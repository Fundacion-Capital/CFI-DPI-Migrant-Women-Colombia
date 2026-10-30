"""Source-bound native candidate. This package grants no execution authority."""
import hashlib
import json
import math
import os
import stat
from pathlib import Path
import time

HERE = Path(__file__).resolve().parent
CONTRACT = HERE.parent / 'wp06-empty-stata-contract/contract.json'


def digest(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def validate(binding):
    contract_raw = CONTRACT.read_bytes()
    contract = json.loads(contract_raw)
    if (type(binding) is not dict or binding.get('schema') != 'WP06_NATIVE_EMPTY_V1'
            or binding.get('domain') != 'NATIVE_EMPTY'
            or binding.get('runtime_ready') is not False
            or binding.get('manager_sha256') != '5f9b427ffbd0d01afc51542a47f2652aff02a084c7c08cc73700ad9b8fda2308'
            or binding.get('contract_sha256') != hashlib.sha256(contract_raw).hexdigest()
            or binding.get('literal_selections') != contract['literal_selections']
            or binding.get('bounds') != contract['proposed_bounds']):
        raise ValueError('Native binding is not the source-exact empty contract')
    for name in ('python', 'entry', 'private_root', 'stata_home', 'site_packages', 'source_root'):
        if type(binding.get(name)) is not str or not Path(binding[name]).is_absolute() or '\0' in binding[name]:
            raise ValueError('Explicit absolute native deployment paths required')
    if Path(binding['entry']).name != 'runtime_roles.py':
        raise ValueError('Only the fixed role entry point is allowed')
    if (Path(binding['source_root']).resolve() != HERE
            or Path(binding['entry']).resolve() != HERE / 'runtime_roles.py'):
        raise ValueError('Binding does not identify this exact additive source')
    return binding


def require_execution(binding, grant):
    validate(binding)
    if (binding.get('activation_allowed') is not True or binding.get('activation_holds') != []
            or type(grant) is not dict or grant.get('approved') is not True
            or grant.get('scope') != 'ONE_EMPTY_NATIVE_RUN'
            or grant.get('binding_sha256') != digest(binding)
            or not isinstance(grant.get('approval_reference'), str) or not grant['approval_reference']
            or type(grant.get('expires_utc')) not in (int, float)
            or not math.isfinite(grant['expires_utc']) or time.time() >= grant['expires_utc']):
        raise ValueError('Native activation is held; no matching explicit execution grant')
    return True


def inventory_contract(binding):
    if type(binding.get('python_base_root')) is not str or type(binding.get('manager_source')) is not str:
        raise ValueError('Explicit base interpreter and manager source required')
    source = Path(binding['source_root']).resolve()
    stata = Path(binding['stata_home']).resolve()
    venv = Path(binding['python']).resolve().parents[1]
    roots = [{'path': str(path.resolve()), 'mode': mode} for path, mode in (
        (venv, 'all'), (Path(binding['python_base_root']), 'all'),
        (stata / 'utilities', 'all'), (stata / 'ado/base/py', 'all'),
        (Path(binding['manager_source']).parent, 'importable'), (source, 'importable'),
        (source.parent / 'wp06-live-control', 'importable'),
        (source.parent / 'wp06-stage-b', 'importable'), (stata, 'dll_top'))]
    required = [str(p.resolve()) for p in (Path(binding['python']),
        Path(binding['python_base_root']) / 'python.exe', stata / 'mp-64.dll',
        stata / 'utilities/pystata/config.py', stata / 'utilities/pystata/stata.py',
        Path(binding['manager_source']), source / 'runtime_roles.py', source / 'mcp_adapter.py',
        Path(binding['site_packages']) / 'mcp/server/fastmcp/server.py', CONTRACT,
        source / 'startup_guard.py', source / 'empty_client.py',
        Path(binding['site_packages']) / 'mcp/client/stdio/__init__.py',
        Path(binding['site_packages']) / 'mcp/client/session.py',
        Path(binding['site_packages']) / 'mcp/os/win32/utilities.py',
        Path(binding['site_packages']) / 'win32/win32api.pyd',
        Path(binding['site_packages']) / 'win32/win32job.pyd',
        Path(binding['site_packages']) / 'win32/lib/pywintypes.py',
        Path(binding['site_packages']) / 'pywin32_system32/pywintypes311.dll')]
    return roots, required


def scan_roots(roots):
    result = set()
    def fail(error):
        raise error
    for item in roots:
        root = Path(item['path']).resolve()
        if not root.is_dir() or item['mode'] not in {'all', 'importable', 'dll_top'}:
            raise ValueError('Unknown or missing bounded inventory root')
        for directory, folders, files in os.walk(root, followlinks=False, onerror=fail):
            parent = Path(directory)
            for name in folders + files:
                path = parent / name
                if getattr(path.lstat(), 'st_file_attributes', 0) & stat.FILE_ATTRIBUTE_REPARSE_POINT:
                    raise ValueError('Runtime root contains an unresolved reparse/symlink entry')
            if item['mode'] == 'dll_top':
                folders[:] = []
            for name in files:
                path = parent / name
                suffix = path.suffix.lower()
                if (item['mode'] == 'all' or item['mode'] == 'dll_top' and suffix == '.dll'
                        or item['mode'] == 'importable' and suffix in {'.py', '.pyc', '.pyd', '.dll', '.zip', '.pth'}):
                    result.add(path.resolve())
    return result


def check_catalog(catalog, roots, required):
    if (type(catalog) is not dict or catalog.get('schema') != 'WP06_RUNTIME_FILES_V1'
            or catalog.get('roots') != roots or catalog.get('required') != required
            or type(catalog.get('files')) is not list or not catalog['files']):
        raise ValueError('Runtime inventory schema, roots or required pins are incomplete')
    rows = catalog['files']
    paths = [str(Path(r['path']).resolve()) for r in rows]
    if len(paths) != len(set(paths)) or not set(required).issubset(paths):
        raise ValueError('Duplicate inventory entries or missing critical pins')
    expected = {str(p) for p in scan_roots(roots)} | set(required)
    errors = [] if set(paths) == expected else ['runtime_file_set']
    for row in rows:
        candidate = Path(row['path'])
        if not candidate.is_file() or candidate.stat().st_size != row['bytes']:
            errors.append(row['path'])
            continue
        with candidate.open('rb') as stream:
            if hashlib.file_digest(stream, 'sha256').hexdigest() != row['sha256']:
                errors.append(row['path'])
    return errors


def verify_inventory(path, expected_digest, binding):
    raw = Path(path).read_bytes()
    if hashlib.sha256(raw).hexdigest() != expected_digest:
        raise ValueError('Runtime inventory digest changed')
    catalog = json.loads(raw)
    roots, required = inventory_contract(binding)
    if check_catalog(catalog, roots, required):
        raise ValueError('Bound runtime/source bytes or file set changed')
    return catalog


def identity_paths(binding):
    stata = Path(binding['stata_home'])
    return {'engine': [stata / 'mp-64.dll'],
        'python_image': [Path(binding['python']), Path(binding['python_base_root']) / 'python.exe'],
        'pystata_config': [stata / 'utilities/pystata/config.py'],
        'pystata_stata': [stata / 'utilities/pystata/stata.py']}


def check_identity_spec(binding, catalog):
    rows = {r['path']: r for r in catalog['files']}
    wanted = {name: [rows[str(p.resolve())] for p in paths] for name, paths in identity_paths(binding).items()}
    if binding.get('runtime_identity_files') != wanted:
        raise ValueError('Runtime identity pins differ from the complete source inventory')


def check_runtime_identity(binding, proof):
    wanted = binding.get('runtime_identity_files')
    if (type(wanted) is not dict or set(wanted) != {'engine', 'python_image', 'pystata_config', 'pystata_stata'}
            or type(proof) is not dict or set(proof) != set(wanted)
            or any(proof[name] not in wanted[name] for name in wanted)):
        raise ValueError('Loaded runtime path/disk identity does not match the bound files')


def load_active(path):
    path = Path(path).resolve()
    binding = json.loads(path.read_text(encoding='utf-8'))
    if path != Path(binding['private_root']).resolve() / 'active_binding.json':
        raise ValueError('Active binding must live in its exact reserved run directory')
    grant = json.loads(path.with_name('execution_grant.json').read_text(encoding='utf-8'))
    require_execution(binding, grant)
    catalog = verify_inventory(binding['runtime_inventory'], binding['runtime_inventory_sha256'], binding)
    check_identity_spec(binding, catalog)
    from startup_guard import verify
    verify(binding)
    return binding, grant
