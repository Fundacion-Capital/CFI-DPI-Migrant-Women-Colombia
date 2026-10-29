import importlib
from pathlib import Path
import tempfile
import unittest
from test_support import FakeKernel, FakeChannel, binding, scope

try:
    roles = importlib.import_module('runtime_roles')
    adapter = importlib.import_module('mcp_adapter')
except ModuleNotFoundError:
    roles = adapter = None


class FakeEngine:
    def __init__(self):
        self.calls = []
    def run(self, code, sequence):
        self.calls.append((code, sequence))
        return 'EMPTY_METADATA_SIMULATION'


class RoleTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(roles, 'Fixed runtime roles missing')
        self.kernel = FakeKernel()
        self.wire = FakeChannel(self.kernel)
        self.engine = FakeEngine()
        self.binding = binding(Path('C:/fixed/private'))
        self.wire.prepare(self.binding, scope(), {})

    def test_worker_consumes_exactly_two_fixed_commands(self):
        requests = [dict(code=code.removesuffix('\n'), timeout=10, execution_id='native-test-' + str(i))
            for i, code in enumerate(self.binding['literal_selections'], 1)]
        self.wire.read = lambda role, kind, sequence: requests[sequence - 1] if kind == 'command' else None
        roles.worker_loop(self.engine, self.kernel, self.wire, self.binding, scope(), 0)
        self.assertEqual(len(self.engine.calls), 2)
        self.assertEqual([r[1] for r in self.engine.calls], [1, 2])

    def test_worker_rejects_arbitrary_or_replayed_payload_before_engine(self):
        self.wire.read = lambda role, kind, sequence: dict(code='use private.dta', timeout=10, execution_id='x') if kind == 'command' else None
        with self.assertRaises(ValueError):
            roles.worker_loop(self.engine, self.kernel, self.wire, self.binding, scope(), 0)
        self.assertEqual(self.engine.calls, [])

    def test_watchdog_contains_worker_even_without_parent_request_progress(self):
        inner = self.kernel.job()
        worker = self.kernel.spawn_suspended('worker', self.binding, {})
        self.kernel.assign(inner, worker)
        stop = self.kernel.event()
        ready = self.kernel.event()
        self.kernel.signal(ready)
        packet = dict(origin=0, frequency=1, inherited=dict(inner_job=inner, worker=worker,
            stop_event=stop, ready_event=ready), worker_identity=self.kernel.identity(worker))
        roles.watchdog_loop(self.kernel, self.wire, packet)
        self.assertTrue(self.kernel.signaled(worker))
        self.assertLessEqual(self.kernel.tick, 100)


class AdapterTests(unittest.TestCase):
    def test_disabled_descriptor_rejects_before_runtime_or_sdk_start(self):
        self.assertIsNotNone(adapter, 'MCP adapter missing')
        with tempfile.TemporaryDirectory(prefix='wp06_disabled_') as directory:
            import json
            root = Path(directory)
            value = binding(root)
            (root / 'active_binding.json').write_text(json.dumps(value), encoding='utf-8')
            (root / 'execution_grant.json').write_text('{}', encoding='utf-8')
            with self.assertRaises(ValueError):
                adapter.main(root / 'active_binding.json')
