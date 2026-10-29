"""No-execution validation. Reads pinned files and parses Python; resolves no DLL or service."""
import ast
import hashlib
import json
from pathlib import Path
from deployment import validate, verify_inventory, check_identity_spec

HERE = Path(__file__).resolve().parent


def inspect(binding):
    validate(binding)
    if binding.get('activation_allowed') is not False or not binding.get('activation_holds'):
        raise ValueError('This preparation artifact must remain disabled')
    catalog = verify_inventory(binding['runtime_inventory'], binding['runtime_inventory_sha256'], binding)
    check_identity_spec(binding, catalog)
    errors = []
    scripts = sorted(HERE.glob('*.py'))
    for path in scripts:
        ast.parse(path.read_text(encoding='utf-8'), filename=str(path), feature_version=(3, 11))
    return dict(passed=not errors, status='PASS_STATIC_PREPARATION_ONLY' if not errors else 'FAIL',
        bound_files=len(catalog['files']), syntax_checked=len(scripts), syntax_target='Python 3.11 grammar only',
        differences=errors, activation_allowed=False, activation_holds=binding['activation_holds'],
        native_calls=0, worker_launches=0, stata_calls=0, participant_processing=False,
        loaded_runtime_verified=False, mcp_interoperability_executed=False)
