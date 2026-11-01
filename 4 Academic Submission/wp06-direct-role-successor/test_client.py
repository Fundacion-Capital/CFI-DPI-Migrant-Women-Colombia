"""Exercise exact client requests against an artificial session, never an SDK process."""
import asyncio
import builtins
import importlib
import json
from pathlib import Path
import time
from types import SimpleNamespace
import unittest
from unittest.mock import patch
from deployment import digest
from test_startup import StartupFixture
import startup_guard

try:
    client = importlib.import_module('empty_client')
except ModuleNotFoundError:
    client = None


class Session:
    def __init__(self, binding):
        self.binding, self.calls, self.selections = binding, [], []
        self.initialized = False
        self.fail = None
    async def initialize(self):
        self.initialized = True
    async def call_tool(self, name, arguments, **kwargs):
        self.calls.append((name, arguments))
        if name == 'stata_session':
            count = len(self.selections)
            state = dict(session_id=self.binding['run_scope']['session_id'], opened=count>0, closed=count==2)
            if self.fail == 'foreign': state['session_id'] = 'foreign'
            if self.fail == 'not_closed' and count==2: state['closed'] = False
            text = str(state)
        else:
            self.selections.append(arguments)
            count = len(self.selections)
            if self.fail == 'error':
                return SimpleNamespace(isError=True, content=[])
            marker = 'WP06_EMPTY_BEGIN' if count==1 else 'WP06_EMPTY_END'
            if self.fail == 'marker': marker = 'WRONG_MARKER'
            dimensions = 'N=1 K=3' if self.fail=='nonempty' else 'N=0 K=0'
            text = marker + '\n' + dimensions + '\n'
        block = SimpleNamespace(type='image' if self.fail=='image' else 'text', text=text)
        return SimpleNamespace(isError=False, content=[block])


class ClientTests(StartupFixture):
    def setUp(self):
        self.assertIsNotNone(client, 'Exact isolated client implementation missing')
        super().setUp()
        self.value.update(activation_allowed=True, activation_holds=[])
        self.value['manager_source'] = 'C:/Users/jzava/.cursor/extensions/deepecon.stata-mcp-0.5.3-universal/src/session_manager.py'
        startup_guard.reserve(self.value)
        self.grant = dict(approved=True, scope='ONE_EMPTY_NATIVE_RUN', binding_sha256=digest(self.value),
            approval_reference='ARTIFICIAL_TEST_ONLY', expires_utc=time.time()+1000)
        self.session = Session(self.value)

    def run_exchange(self):
        return asyncio.run(client.exchange(self.value, self.grant, self.session))

    def test_contract_uses_only_exact_stdio_command_cwd_and_bounded_environment(self):
        contract = client.contract(self.value)
        self.assertEqual(contract['command'], self.value['python'])
        self.assertEqual(contract['args'][:5], ['-I','-S','-B','-X','utf8'])
        self.assertEqual(contract['args'][-1], str(self.root / 'active_binding.json'))
        self.assertEqual(contract['cwd'], str(self.root))
        self.assertNotIn('url', contract)
        self.assertEqual(contract['env']['PATH'], str(self.win / 'System32')+';'+str(self.win))

    def test_sdk_bootstrap_is_explicit_and_restores_process_state(self):
        import os
        import sys
        site = self.base / 'site'
        for name in ('win32/lib','pywin32_system32'):
            (site / name).mkdir(parents=True)
        self.value['site_packages'] = str(site)
        self.grant['binding_sha256'] = digest(self.value)
        before = list(sys.path)
        calls = []
        class Handle:
            def __enter__(handle): return handle
            def __exit__(handle,*args): calls.append('closed')
        def add(path):
            calls.append(path)
            return Handle()
        with patch.object(os,'add_dll_directory',add):
            with startup_guard.sdk_environment(self.value,self.grant):
                self.assertEqual(sys.path[:3],[str(site),str(site/'win32'),str(site/'win32/lib')])
        self.assertEqual(sys.path,before)
        self.assertEqual(calls,[str(site/'pywin32_system32'),'closed'])

    def test_sdk_bootstrap_denies_before_searchpath_or_dll_changes(self):
        import os
        import sys
        self.value['activation_allowed'] = False
        before = list(sys.path)
        calls = []
        def forbidden(*args):
            calls.append(args)
            raise RuntimeError('A real DLL operation is forbidden in this test')
        with patch.object(os,'add_dll_directory',forbidden):
            with self.assertRaises(ValueError):
                with startup_guard.sdk_environment(self.value,self.grant): pass
        self.assertEqual(calls,[])
        self.assertEqual(sys.path,before)

    def test_exact_two_selections_and_closed_session_are_required(self):
        result = self.run_exchange()
        self.assertTrue(self.session.initialized)
        self.assertEqual([name for name,args in self.session.calls],
            ['stata_session','stata_run_selection','stata_run_selection','stata_session'])
        self.assertEqual([r['selection'] for r in self.session.selections], self.value['literal_selections'])
        self.assertEqual([r['timeout'] for r in self.session.selections], [10,10])
        self.assertTrue(result['recipe_completed'])

    def test_client_routes_through_actual_isolated_adapter_and_owned_policy(self):
        import mcp_adapter
        import native_session
        from native_provider import NativeOwner
        from test_adapter import FakeSDK
        from test_support import FakeKernel, FakeChannel, scope
        class MetadataChannel(FakeChannel):
            def wait(wire, role, kind, sequence, deadline):
                result = super().wait(role, kind, sequence, deadline)
                if kind == 'result':
                    marker = 'WP06_EMPTY_BEGIN' if sequence==1 else 'WP06_EMPTY_END'
                    result['output'] = marker + '\nN=0 K=0\n'
                return result
        kernel = FakeKernel()
        owner = NativeOwner(kernel, MetadataChannel(kernel), self.value, scope())
        manager = native_session.isolated_manager(mcp_adapter.source_manager(self.value), owner, scope(), self.value)
        server, close = mcp_adapter.build_server(manager, FakeSDK)
        class AdapterSession:
            async def initialize(session): pass
            async def call_tool(session, name, arguments, **kwargs):
                text = server.tools[name](**arguments)
                return SimpleNamespace(isError=False, content=[SimpleNamespace(type='text', text=text)])
        try:
            result = asyncio.run(client.exchange(self.value, self.grant, AdapterSession()))
            self.assertTrue(result['recipe_completed'])
            self.assertEqual(manager._phase, 'CLOSED')
            self.assertEqual(kernel.handles, set())
            self.assertEqual(sum(event==('spawn','worker') for event in kernel.events), 1)
        finally:
            close()

    def test_no_authority_prevents_even_session_initialization(self):
        self.value['activation_allowed'] = False
        with self.assertRaises(ValueError): self.run_exchange()
        self.assertFalse(self.session.initialized)
        self.assertEqual(self.session.calls, [])

    def test_tool_error_stops_without_retry_or_second_selection(self):
        self.session.fail = 'error'
        with self.assertRaises(ValueError): self.run_exchange()
        self.assertEqual(len(self.session.selections), 1)

    def test_foreign_session_rejected_before_selection(self):
        self.session.fail = 'foreign'
        with self.assertRaises(ValueError): self.run_exchange()
        self.assertEqual(self.session.selections, [])

    def test_nonempty_result_is_not_cleared_or_accepted(self):
        self.session.fail = 'nonempty'
        with self.assertRaises(ValueError): self.run_exchange()
        self.assertEqual(len(self.session.selections), 1)

    def test_unclean_final_state_cannot_pass(self):
        self.session.fail = 'not_closed'
        with self.assertRaises(ValueError): self.run_exchange()

    def test_wrong_marker_stops_before_the_second_selection(self):
        self.session.fail = 'marker'
        with self.assertRaises(ValueError): self.run_exchange()
        self.assertEqual(len(self.session.selections), 1)

    def test_nontext_payload_is_rejected(self):
        self.session.fail = 'image'
        with self.assertRaises(ValueError): self.run_exchange()
        self.assertEqual(self.session.selections, [])

    def test_foreign_source_folder_cannot_be_a_client_target(self):
        self.value['source_root'] = str(self.base / 'foreign')
        with self.assertRaises(ValueError): client.contract(self.value)

    def test_client_reservation_is_single_use_and_preserved(self):
        client.reserve_client(self.value, self.grant)
        with self.assertRaises(FileExistsError): client.reserve_client(self.value, self.grant)
        self.assertTrue((self.root / 'CLIENT_RESERVED').is_file())

    def test_disabled_main_denies_before_any_sdk_import(self):
        self.value['activation_allowed'] = False
        for name, value in (('active_binding.json',self.value),('execution_grant.json',self.grant)):
            (self.root / name).write_text(json.dumps(value),encoding='utf-8')
        imports = []
        original = builtins.__import__
        def guarded(name,*args,**kwargs):
            if name=='mcp' or name.startswith('mcp.'):
                imports.append(name)
                raise RuntimeError('A real SDK import is forbidden in this test')
            return original(name,*args,**kwargs)
        with patch.object(builtins,'__import__',guarded):
            with self.assertRaises(ValueError): client.main(self.root / 'active_binding.json')
        self.assertEqual(imports, [])
        self.assertFalse((self.root / 'CLIENT_RESERVED').exists())
