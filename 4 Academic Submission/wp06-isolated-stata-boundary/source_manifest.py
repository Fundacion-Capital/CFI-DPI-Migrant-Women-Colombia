"""Static provenance only; never import the inspected extension or Stata."""
import ast
import hashlib
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
CONTRACT = HERE.parent / 'wp06-empty-stata-contract/contract.json'
MANAGER_SHA = '5f9b427ffbd0d01afc51542a47f2652aff02a084c7c08cc73700ad9b8fda2308'


def validate(manifest):
    raw = CONTRACT.read_bytes()
    contract = json.loads(raw)
    if (type(manifest) is not dict or manifest.get('schema') != 'WP06_ISOLATED_STATA_MANIFEST_V1'
            or manifest.get('domain') != 'ARTIFICIAL' or manifest.get('runtime_ready') is not False
            or manifest.get('manager_sha256') != MANAGER_SHA
            or manifest.get('contract_sha256') != hashlib.sha256(raw).hexdigest()
            or manifest.get('literal_selections') != contract['literal_selections']
            or manifest.get('bounds') != contract['proposed_bounds']
            or manifest.get('startup_review') != 'UNBOUND'
            or manifest.get('deployment') != 'NOT_DEPLOYED'):
        raise ValueError('Manifest is not the pinned artificial-only contract')
    return manifest


def pin(path):
    raw = path.read_bytes()
    return dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest())


def verify_sources(rows, root):
    root = root.resolve()
    expected = set()
    differences = []
    for row in rows:
        path = (root / row['file']).resolve()
        if not path.is_relative_to(root / 'src') or path.suffix != '.py' or path in expected:
            raise ValueError('Source path escapes root or duplicates an entry')
        expected.add(path)
        if not path.is_file() or pin(path) != {'bytes': row['bytes'], 'sha256': row['sha256']}:
            differences.append(row['file'])
    actual = {p.resolve() for p in (root / 'src').rglob('*.py')}
    differences.extend(str(p.relative_to(root)) for p in actual - expected)
    return differences


def verify_complete(manifest, extension):
    validate(manifest)
    # Deterministic rebuild checks every declared pin, import row and exact source-key set.
    return [] if manifest == build(extension) else ['complete_manifest_mismatch']


def build(extension):
    """Pin every extension-local Python source and enumerate imports without resolution."""
    contract = json.loads(CONTRACT.read_text(encoding='utf-8'))
    files = sorted((extension / 'src').rglob('*.py'))
    modules = {p.relative_to(extension / 'src').with_suffix('').as_posix().replace('/', '.') for p in files}
    rows = []
    for path in files:
        tree = ast.parse(path.read_text(encoding='utf-8-sig'))
        imports = []
        for node in ast.walk(tree):
            names = [a.name for a in node.names] if isinstance(node, ast.Import) else (
                [node.module or ''] if isinstance(node, ast.ImportFrom) else [])
            for name in names:
                root = name.split('.')[0]
                category = 'extension_local' if root in modules else (
                    'stdlib_name_only' if root in sys.stdlib_module_names else 'external_unbound')
                imports.append(dict(module=name, line=node.lineno, classification=category,
                    relative_level=getattr(node, 'level', 0)))
        dynamic = [dict(line=n.lineno, expression=ast.unparse(n.func)) for n in ast.walk(tree)
            if isinstance(n, ast.Call) and ast.unparse(n.func) in {'__import__', 'importlib.import_module'}]
        rows.append(dict(file=path.relative_to(extension).as_posix(), **pin(path), imports=imports,
            dynamic_import_sites=dynamic))
    result = dict(schema='WP06_ISOLATED_STATA_MANIFEST_V1', domain='ARTIFICIAL', runtime_ready=False,
        manager_sha256=MANAGER_SHA, contract_sha256=pin(CONTRACT)['sha256'],
        literal_selections=contract['literal_selections'], bounds=contract['proposed_bounds'],
        startup_review='UNBOUND', deployment='NOT_DEPLOYED', extension_source_files=rows,
        extension_package=pin(extension / 'package.json'),
        artificial_test_interpreter=pin(Path(sys.executable)),
        implementation_sources={p.name: pin(p) for p in sorted(HERE.glob('*.py'))},
        proposed_deployment=dict(dispatcher_factory='boundary.bind_dispatcher(manager)',
            manager_factory='boundary.isolated_manager',
            parameters=['selection', 'session_id', 'timeout'],
            endpoint=None, credentials=None, shared_service_changes=False,
            actual_native_provider=None, live_launch_entrypoint=None),
        startup=dict(required=['owned suspended allocation', 'job assignment before initialization',
            'explicit nondefault session and epoch', 'audit engine/PyStata/profile dependencies',
            'exclude hidden data loads and populated other frames', 'record all seed/log wrappers'],
            actual_verified=False),
        outputs=dict(required=['new restricted per-run evidence directory', 'exclusive create-only receipts',
            'private worker/debug/selection logs', 'isolated cwd/temp/graph/history paths',
            'retention and final inventory'], actual_paths_bound=False),
        runtime_unbound=['actual server/worker epoch', 'actual worker interpreter and environment',
            'third-party package versions and transitive code', 'Stata engine/PyStata and startup profiles',
            'native owned creation/control/cleanup provider', 'endpoint credentials and private output paths'],
        closure_limit='All extension-local Python bytes are pinned; import declarations include conditional imports. Dynamic imports and external/stdlib transitive runtime code are not resolved or certified.')
    validate(result)
    return result
