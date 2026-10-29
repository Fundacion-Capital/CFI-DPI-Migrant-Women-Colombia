from pathlib import Path
import tempfile
import unittest
import mcp_adapter
import native_session
from native_provider import NativeOwner
from test_support import FakeKernel, FakeChannel, binding, scope


class FakeSDK:
    def __init__(self, name):
        self.tools = {}
    def tool(self, name):
        def decorate(function):
            self.tools[name] = function
            return function
        return decorate


class MCPBindingTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='wp06_mcp_fake_')
        self.addCleanup(self.temp.cleanup)
        self.value = binding(Path(self.temp.name) / 'run')
        self.value['manager_source'] = 'C:/Users/jzava/.cursor/extensions/deepecon.stata-mcp-0.5.3-universal/src/session_manager.py'
        self.kernel = FakeKernel()
        self.wire = FakeChannel(self.kernel)
        self.owner = NativeOwner(self.kernel, self.wire, self.value, scope())
        self.manager = native_session.isolated_manager(mcp_adapter.source_manager(self.value),
            self.owner, scope(), self.value)
        self.server, self.close = mcp_adapter.build_server(self.manager, FakeSDK)

    def test_listing_tools_and_session_does_not_create_a_worker(self):
        self.assertEqual(set(self.server.tools), {'stata_run_selection', 'stata_session'})
        self.server.tools['stata_session']('list')
        self.assertFalse(any(e[0] == 'spawn' for e in self.kernel.events if isinstance(e, tuple)))

    def test_two_tool_calls_close_the_exact_run_before_successful_final_return(self):
        call = self.server.tools['stata_run_selection']
        for code in self.value['literal_selections']:
            self.assertEqual(call(code, scope()['session_id'], 10), 'NATIVE_SIMULATION_ONLY')
        self.assertEqual(self.kernel.handles, set())
        with self.assertRaises(ValueError):
            call(self.value['literal_selections'][0], scope()['session_id'], 10)

    def test_wrong_session_request_never_initializes_an_engine(self):
        with self.assertRaises(ValueError):
            self.server.tools['stata_run_selection']('display 1', 'default', 10)
        self.assertFalse(any(e == ('resume', 'worker') for e in self.kernel.events))

    def test_native_policy_uses_the_one_provider_origin(self):
        self.kernel.tick = 5
        manager = native_session.isolated_manager(mcp_adapter.source_manager(self.value),
            self.owner, scope(), self.value)
        self.assertEqual(manager._origin, self.owner.origin)
