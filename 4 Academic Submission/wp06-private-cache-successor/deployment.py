"""Source-bound native candidate. This package grants no execution authority."""
import hashlib
import json
import math
import os
import stat
import re
import sys
import copy
from pathlib import Path
import time

HERE = Path(__file__).resolve().parent
CONTRACT = HERE.parent / 'wp06-empty-stata-contract/contract.json'
CACHE_POLICY = dict(schema='WP06_PRIVATE_CACHE_PREFIX_V1', directory='pycache', cache_tag='cpython-311', source_backed_only=True)


def digest(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def validate(binding):
    contract_raw = CONTRACT.read_bytes()
    contract = json.loads(contract_raw)
    if (type(binding) is not dict or binding.get('schema') != 'WP06_NATIVE_EMPTY_PRIVATE_CACHE_V2'
            or binding.get('cache_policy') != CACHE_POLICY
            or type(binding.get('cache_policy', {}).get('source_backed_only')) is not bool
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
    root = Path(binding['private_root'])
    if (type(binding.get('stdio')) is not dict or type(binding.get('client')) is not dict
            or binding['stdio'].get('command') != binding['python']
            or binding['client'].get('entry') != str(HERE / 'empty_client.py')
            or binding.get('stdio', {}).get('args') != cache_flags(binding) + [str(HERE / 'mcp_adapter.py'), str(root / 'active_binding.json')]
            or binding.get('client', {}).get('command') != client_command(binding)):
        raise ValueError('All interpreter commands must use this exact private cache prefix')
    return binding


def cache_flags(binding):
    return ['-I','-S','-B','-X','utf8','-X','pycache_prefix=' + str(Path(binding['private_root']) / 'pycache')]


def client_command(binding):
    return [binding['python']] + cache_flags(binding) + [str(HERE / 'empty_client.py'),
        str(Path(binding['private_root']) / 'active_binding.json')]


def check_cache_proof(binding, proof):
    wanted = dict(pycache_prefix=str(Path(binding['private_root']) / 'pycache'),
        dont_write_bytecode=True, cache_tag='cpython-311', isolated=True, no_site=True)
    if (type(proof) is not dict or set(proof) != set(wanted) or proof != wanted
            or any(type(proof[key]) is not type(value) for key,value in wanted.items())):
        raise ValueError('Actual interpreter cache controls differ from the exact private policy')
    return proof


def cache_proof(binding):
    proof = dict(pycache_prefix=sys.pycache_prefix, dont_write_bytecode=sys.dont_write_bytecode,
        cache_tag=sys.implementation.cache_tag, isolated=sys.flags.isolated == 1, no_site=sys.flags.no_site == 1)
    return check_cache_proof(binding, proof)


def assign_run(binding, scope):
    validate(binding)
    fields = {'run_id','session_id','worker_epoch','owner_nonce','clock_domain'}
    if (binding.get('activation_allowed') is not False or binding.get('client', {}).get('enabled') is not False
            or binding.get('stdio', {}).get('enabled') is not False or binding.get('run_scope') is not None
            or Path(binding['private_root']).name != 'UNASSIGNED'
            or type(scope) is not dict or set(scope) != fields
            or any(type(v) is not str or not v or len(v)>128 for v in scope.values())
            or not re.fullmatch(r'[A-Za-z0-9][A-Za-z0-9_-]{0,95}', scope['run_id'])):
        raise ValueError('Only a disabled unassigned source may receive a complete safe scope')
    root = Path(binding['private_root']).parent / scope['run_id']
    if root != root.resolve() or root.exists():
        raise ValueError('Assigned run must be canonical, absent and never replaced')
    result = copy.deepcopy(binding)
    result.update(private_root=str(root),run_scope=copy.deepcopy(scope))
    result['stdio']['args'] = cache_flags(result) + [str(HERE / 'mcp_adapter.py'), str(root / 'active_binding.json')]
    result['client']['command'] = client_command(result)
    validate(result)
    return result


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
        Path(binding['site_packages']) / 'pywin32_system32/pywintypes311.dll',
        source / 'termination_evidence.py', source / 'CLIENT_CONTRACT.json')]
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


def strict_inputs(scanned):
    strict, caches = set(scanned), set()
    for path in scanned:
        match = re.fullmatch(r'(.+)\.cpython-311(?:\.opt-[12])?\.pyc', path.name)
        source = path.parent.parent / (match.group(1) + '.py') if match else None
        if path.parent.name == '__pycache__' and source in scanned:
            caches.add(path)
    return strict - caches, caches


def check_catalog(catalog, roots, required):
    if (type(catalog) is not dict or catalog.get('schema') != 'WP06_RUNTIME_FILES_V2'
            or catalog.get('cache_policy') != CACHE_POLICY
            or type(catalog.get('cache_policy', {}).get('source_backed_only')) is not bool
            or catalog.get('roots') != roots or catalog.get('required') != required
            or type(catalog.get('files')) is not list or not catalog['files']):
        raise ValueError('Runtime inventory schema, roots or required pins are incomplete')
    rows = catalog['files']
    strict, _ = strict_inputs(scan_roots(roots))
    scanned = {str(p) for p in strict}
    # Freshly scanned canonical members need no second resolution; aliases still resolve fully.
    paths = [r['path'] if r['path'] in scanned else str(Path(r['path']).resolve()) for r in rows]
    if len(paths) != len(set(paths)) or not set(required).issubset(paths):
        raise ValueError('Duplicate inventory entries or missing critical pins')
    expected = scanned | set(required)
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


