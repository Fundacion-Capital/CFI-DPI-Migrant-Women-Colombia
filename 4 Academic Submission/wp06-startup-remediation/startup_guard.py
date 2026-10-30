"""Fixed startup inputs and create-only reservation. No engine or process operations."""
import hashlib
from contextlib import contextmanager
import json
import os
from pathlib import Path
import stat
import sys
from deployment import validate, digest, require_execution, verify_inventory, check_identity_spec

PROFILE = b'* WP06 empty-runtime startup: no commands, data or external sources.\n'
PROFILE_NAMES = ('sysprofile.do', 'profile.do')


def spec(windows_root):
    root = Path(windows_root)
    if not root.is_absolute():
        raise ValueError('Explicit absolute Windows root required')
    row = dict(bytes=len(PROFILE), sha256=hashlib.sha256(PROFILE).hexdigest())
    return dict(schema='WP06_FIXED_STARTUP_V1', windows_root=str(root.resolve()),
        profiles={name: dict(row) for name in PROFILE_NAMES}, directories=['home','temp'])


def _plain(path, directory=False):
    value = path.lstat()
    kind = stat.S_ISDIR(value.st_mode) if directory else stat.S_ISREG(value.st_mode)
    if not kind or getattr(value, 'st_file_attributes', 0) & 0x400:
        raise ValueError('Startup path is not a plain owned file/directory')


def check_spec(binding):
    validate(binding)
    value = binding.get('startup_contract')
    if type(value) is not dict or value != spec(value.get('windows_root', '')):
        raise ValueError('Startup contract differs from the fixed inert inputs')
    root = Path(value['windows_root'])
    _plain(root, True)
    _plain(root / 'System32', True)


def installation_clear(binding):
    home = Path(binding['stata_home'])
    _plain(home, True)
    for name in PROFILE_NAMES:
        try:
            (home / name).lstat()
        except FileNotFoundError:
            continue
        raise ValueError('An installation-directory profile precedes the private profiles')


def environment(binding):
    check_spec(binding)
    root = Path(binding['private_root'])
    windows = Path(binding['startup_contract']['windows_root'])
    return dict(SYSTEMROOT=str(windows), PATH=str(windows / 'System32') + ';' + str(windows),
        USERPROFILE=str(root / 'home'), TEMP=str(root / 'temp'), TMP=str(root / 'temp'), STATATMP=str(root / 'temp'))


def _receipt(binding):
    scope = binding.get('run_scope')
    required = {'run_id','session_id','worker_epoch','owner_nonce','clock_domain'}
    if (type(scope) is not dict or set(scope) != required
            or any(type(v) is not str or not v for v in scope.values())
            or Path(binding['private_root']).name == 'UNASSIGNED'):
        raise ValueError('A concrete exact run scope is required')
    return dict(schema='WP06_FRESH_STARTUP_RECEIPT_V1', binding_sha256=digest(binding),
        scope=scope, creation_mode='exclusive_new_root', startup_contract=binding['startup_contract'])


def reserve(binding):
    check_spec(binding)
    installation_clear(binding)
    receipt = _receipt(binding)
    root = Path(binding['private_root'])
    if root != root.resolve():
        raise ValueError('Run root has an unresolved alias or reparse ancestor')
    root.mkdir()  # Never reuse, empty, delete or replace a previous attempt.
    (root / 'home').mkdir()
    (root / 'temp').mkdir()
    for name in PROFILE_NAMES:
        with (root / name).open('xb') as stream:
            stream.write(PROFILE)
    with (root / 'startup_receipt.json').open('x', encoding='utf-8') as stream:
        json.dump(receipt, stream, sort_keys=True)
    verify(binding)


def verify(binding):
    check_spec(binding)
    installation_clear(binding)
    root = Path(binding['private_root'])
    if root != root.resolve():
        raise ValueError('Run root has an unresolved alias or reparse ancestor')
    for folder in (root, root / 'home', root / 'temp'):
        _plain(folder, True)
    allowed = set(PROFILE_NAMES) | {'home','temp','startup_receipt.json','active_binding.json',
        'execution_grant.json','CLIENT_RESERVED','LAUNCH_RESERVED','client.stderr.log','client_receipt.json',
        'worker.stdout.log','watchdog.stdout.log','selection.1.log','selection.2.log'}
    allowed.update('parent.' + name + '.json' for name in ('ownership','runtime','exit','closure'))
    allowed.update(f'{role}.{kind}.{n}.{suffix}' for role in ('worker','watchdog')
        for kind in ('ready','command','result','shutdown','exit') for n in (0,1,2) for suffix in ('json','pending'))
    if any(path.name not in allowed for path in root.iterdir()):
        raise ValueError('Unaccounted run-root input is held without reading its contents')
    if list((root / 'home').iterdir()):
        raise ValueError('Private home is not empty; unexpected startup preferences are held')
    # Every caller is pre-initialization; later engine scratch is not rechecked here.
    if list((root / 'temp').iterdir()):
        raise ValueError('Private temp is not empty; unexpected startup inputs are held')
    for name in PROFILE_NAMES:
        path = root / name
        _plain(path)
        if path.read_bytes() != PROFILE:
            raise ValueError('Private startup profile differs from the fixed inert bytes')
    path = root / 'startup_receipt.json'
    _plain(path)
    with path.open('rb') as stream:
        raw = stream.read(8193)
    if len(raw) > 8192 or json.loads(raw) != _receipt(binding):
        raise ValueError('Startup reservation is foreign, changed or oversized')


def prepare_authorized(binding, grant):
    require_execution(binding, grant)  # Before file creation, SDK imports or native operations.
    catalog = verify_inventory(binding['runtime_inventory'], binding['runtime_inventory_sha256'], binding)
    check_identity_spec(binding, catalog)
    reserve(binding)
    root = Path(binding['private_root'])
    for name, value in (('active_binding.json', binding), ('execution_grant.json', grant)):
        with (root / name).open('x', encoding='utf-8') as stream:
            json.dump(value, stream, sort_keys=True)
    return root / 'active_binding.json'


@contextmanager
def sdk_environment(binding, grant):
    require_execution(binding, grant)
    site = Path(binding['site_packages'])
    paths = [str(site), str(site / 'win32'), str(site / 'win32/lib')]
    for path in [Path(p) for p in paths] + [site / 'pywin32_system32']:
        _plain(path, True)
    previous = list(sys.path)
    try:
        sys.path[:] = paths + [path for path in previous if path not in paths]
        # Explicit, scoped equivalent of the required pywin32 paths; never execute a .pth file.
        with os.add_dll_directory(str(site / 'pywin32_system32')):
            yield
    finally:
        sys.path[:] = previous


if __name__ == '__main__':
    import sys
    if len(sys.argv) != 2:
        raise SystemExit('An exact separately authorized preparation request is required')
    request = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
    print(prepare_authorized(request['binding'], request['grant']))
