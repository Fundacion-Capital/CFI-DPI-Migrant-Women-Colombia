"""Replay the unchanged policy behavior suite against a distinct native-domain source port."""
import ast
import importlib.util
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
OLD = HERE.parent / 'wp06-isolated-stata-boundary'
spec = importlib.util.spec_from_file_location('wp06_prior_test_support', OLD / 'test_support.py')
support = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = support
spec.loader.exec_module(support)
tree = ast.parse((OLD / 'test_boundary.py').read_text(encoding='utf-8'))
for node in ast.walk(tree):
    if isinstance(node, ast.ImportFrom) and node.module == 'test_support':
        node.module = 'wp06_prior_test_support'
    if isinstance(node, ast.Constant) and node.value == 'boundary':
        node.value = 'native_session'
namespace = {'__name__': 'wp06_native_policy_behavior_replay'}
exec(compile(ast.fix_missing_locations(tree), str(OLD / 'test_boundary.py') + ':native-domain-replay', 'exec'), namespace)
original_manifest = support.manifest


def native_manifest():
    value = original_manifest()
    value.update(schema='WP06_NATIVE_EMPTY_V1', domain='NATIVE_EMPTY', runtime_ready=False,
        activation_allowed=False, activation_holds=['NO_EXECUTION_AUTHORITY'],
        python='C:/fixed/python.exe', entry=str(HERE / 'runtime_roles.py'),
        private_root='C:/fixed/private', stata_home='C:/fixed/Stata19',
        site_packages='C:/fixed/site-packages', source_root=str(HERE))
    return value


class NativeFixtureOwner(support.ArtificialOwner):
    evidence_domain = 'NATIVE_EMPTY'
    evidence_scope = 'FAKE_WIN32'
    origin = 0


namespace['manifest'] = native_manifest
namespace['ArtificialOwner'] = NativeFixtureOwner
NativePolicyTests = type('NativePolicyTests', (namespace['BoundaryTests'],), {'__module__': __name__})
