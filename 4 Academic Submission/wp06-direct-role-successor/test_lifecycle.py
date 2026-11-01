"""AC-D01–08: real policy/provider/wrapper, artificial retained capabilities only."""
import copy
from pathlib import Path
import threading
import unittest
from unittest.mock import patch
import mcp_adapter
import native_session
from native_provider import NativeOwner
from test_adapter import FakeSDK
from test_support import FakeKernel, FakeChannel, binding, scope


class StrictKernel(FakeKernel):
    def identity(self, handle):
        if handle not in self.handles:
            raise ValueError('Disposed identity capability')
        return super().identity(handle)

    def signaled(self, handle):
        if handle not in self.handles:
            raise ValueError('Disposed wait capability')
        return super().signaled(handle)

    def active(self, handle):
        if handle not in self.handles:
            raise ValueError('Disposed job capability')
        return super().active(handle)


class LifecycleTests(unittest.TestCase):
    def setup_run(self):
        value = binding(Path('C:/artificial/not-created'))
        value['manager_source'] = 'C:/Users/jzava/.cursor/extensions/deepecon.stata-mcp-0.5.3-universal/src/session_manager.py'
        kernel = StrictKernel()
        wire = FakeChannel(kernel)
        owner = NativeOwner(kernel, wire, value, scope())
        manager = native_session.isolated_manager(mcp_adapter.source_manager(value), owner, scope(), value)
        server, close = mcp_adapter.build_server(manager, FakeSDK)
        return value, kernel, wire, owner, manager, server, close

    def test_ac_d01_normal_recipe_reuses_terminal_result(self):
        value, kernel, _, _, manager, server, close = self.setup_run()
        for code in value['literal_selections']:
            server.tools['stata_run_selection'](code, scope()['session_id'], 10)
        before = list(kernel.events)
        self.assertTrue(close()['accepted'])
        self.assertEqual(manager.close(), close())
        self.assertEqual(kernel.events, before)

    def test_ac_d02_bootstrap_error_survives_finalizer(self):
        value, kernel, wire, _, _, server, close = self.setup_run()
        wire.fail = 'timeout'
        with self.assertRaisesRegex(ValueError, 'Owned bootstrap failed'):
            server.tools['stata_run_selection'](value['literal_selections'][0], scope()['session_id'], 10)
        before = list(kernel.events)
        try: result = close()
        except ValueError as error: result = error
        self.assertIsInstance(result, dict)
        self.assertFalse(result['accepted'])
        self.assertTrue(result['cleanup_complete'])
        self.assertEqual((result['calls'], result['completed']), (0, 0))
        self.assertEqual(close(), result)
        self.assertEqual(kernel.events, before)

    def test_ac_d03_expired_bootstrap_never_allocates(self):
        value, kernel, _, _, _, server, close = self.setup_run()
        kernel.tick = 60
        with self.assertRaisesRegex(ValueError, 'Owned bootstrap failed'):
            server.tools['stata_run_selection'](value['literal_selections'][0], scope()['session_id'], 10)
        self.assertFalse(close()['accepted'])
        self.assertFalse(any(isinstance(e, tuple) and e[0]=='spawn' for e in kernel.events))

    def test_ac_d04_late_allocation_cannot_cache_pending_as_terminal(self):
        value, kernel, _, owner, manager, server, close = self.setup_run()
        entered, release = threading.Event(), threading.Event()
        original = owner.allocate_suspended
        def delayed(value):
            resource = original(value)
            entered.set()
            if not release.wait(2): raise RuntimeError('Artificial release missing')
            return resource
        caught = []
        def opening():
            try: server.tools['stata_run_selection'](value['literal_selections'][0], scope()['session_id'], 10)
            except BaseException as error: caught.append(error)
        with patch.object(owner, 'allocate_suspended', side_effect=delayed):
            thread = threading.Thread(target=opening)
            thread.start()
            try:
                self.assertTrue(entered.wait(2))
                self.assertTrue(close()['cleanup_pending'])
            finally:
                release.set(); thread.join(2)
        self.assertFalse(thread.is_alive())
        self.assertEqual(len(caught), 1)
        self.assertFalse(close().get('cleanup_pending', False))
        self.assertFalse(close()['accepted'])
        self.assertEqual(kernel.handles, set())
        self.assertEqual(sum(e==('spawn','worker') for e in kernel.events), 1)

    def test_ac_d05_concurrent_finalizers_do_not_repeat_effects(self):
        _, kernel, _, owner, manager, _, close = self.setup_run()
        manager.open()
        entered, release = threading.Event(), threading.Event()
        original = owner.shutdown
        def delayed(resource):
            entered.set()
            if not release.wait(2): raise RuntimeError('Artificial release missing')
            original(resource)
        results = []
        with patch.object(owner, 'shutdown', side_effect=delayed) as shutdown:
            thread = threading.Thread(target=lambda: results.append(manager.close()))
            thread.start()
            try:
                self.assertTrue(entered.wait(2))
                self.assertTrue(close()['cleanup_pending'])
            finally:
                release.set(); thread.join(2)
            self.assertEqual(shutdown.call_count, 1)
        self.assertFalse(thread.is_alive())
        self.assertEqual(close(), results[0])
        self.assertFalse(close()['accepted'])
        self.assertEqual(kernel.handles, set())

    def test_ac_d06_rollback_observation_precedes_capability_disposal(self):
        _, kernel, wire, owner, _, _, _ = self.setup_run()
        resource = owner.allocate_suspended(scope()); owner.assign_job(resource)
        wire.fail = 'timeout'
        with self.assertRaises(TimeoutError): owner.initialize(resource)
        result = owner.rollback_result
        self.assertTrue(result['exit_observed'])
        self.assertEqual(result['active_owned'], 0)
        self.assertTrue(result['cleanup_complete'])
        self.assertEqual(kernel.handles, set())
        before = list(kernel.events)
        owner._rollback()
        self.assertEqual(kernel.events, before)

    def test_ac_d07_interrupted_cleanup_is_terminal_failure_not_retry(self):
        _, kernel, _, owner, manager, _, close = self.setup_run()
        manager.open()
        with patch.object(owner, 'shutdown', side_effect=KeyboardInterrupt('artificial interruption')):
            result = manager.close()
        self.assertFalse(result['accepted'])
        self.assertFalse(result['cleanup_complete'])
        self.assertTrue(any('KeyboardInterrupt' in failure for failure in result['failures']))
        before = list(kernel.events)
        self.assertEqual(close(), result)
        self.assertEqual(kernel.events, before)

    def test_ac_d08_terminal_dictionary_cannot_be_modified_by_reader(self):
        value, _, _, _, manager, server, close = self.setup_run()
        for code in value['literal_selections']:
            server.tools['stata_run_selection'](code, scope()['session_id'], 10)
        result = close()
        result['accepted'] = False; result['failures'].append('reader mutation')
        self.assertTrue(manager.close()['accepted'])
        self.assertNotIn('reader mutation', close()['failures'])

    def test_initialization_in_flight_cannot_be_declared_closed(self):
        value, kernel, wire, _, _, server, close = self.setup_run()
        entered, release = threading.Event(), threading.Event()
        original = wire.wait
        def delayed(*args):
            if args[:2]==('watchdog','ready'):
                entered.set()
                if not release.wait(2): raise RuntimeError('Artificial release missing')
            return original(*args)
        caught = []
        def opening():
            try: server.tools['stata_run_selection'](value['literal_selections'][0], scope()['session_id'], 10)
            except BaseException as error: caught.append(error)
        with patch.object(wire,'wait',side_effect=delayed):
            thread=threading.Thread(target=opening); thread.start()
            try:
                self.assertTrue(entered.wait(2))
                self.assertTrue(close().get('cleanup_pending',False))
            finally:
                release.set(); thread.join(2)
        self.assertFalse(thread.is_alive())
        self.assertEqual(len(caught),1)
        self.assertFalse(close()['accepted'])
        self.assertEqual(kernel.handles,set())

    def test_interrupted_allocation_clears_pending_without_retry(self):
        value, kernel, _, owner, _, server, close = self.setup_run()
        with patch.object(owner,'allocate_suspended',side_effect=KeyboardInterrupt('artificial allocation interrupted')):
            with self.assertRaises(BaseException):
                server.tools['stata_run_selection'](value['literal_selections'][0],scope()['session_id'],10)
        self.assertFalse(close().get('cleanup_pending',False))
        self.assertFalse(close()['accepted'])
        self.assertFalse(any(isinstance(e,tuple) and e[0]=='spawn' for e in kernel.events))

    def test_nonzero_failed_child_can_be_contained_without_recipe_acceptance(self):
        value, kernel, wire, _, _, server, close = self.setup_run()
        wire.fail='timeout'
        with patch.object(kernel,'exit_code',return_value=1):
            with self.assertRaises(ValueError):
                server.tools['stata_run_selection'](value['literal_selections'][0],scope()['session_id'],10)
        self.assertTrue(close()['cleanup_complete'])
        self.assertFalse(close()['accepted'])

    def test_failed_exit_record_cannot_report_complete_rollback(self):
        value, kernel, wire, _, _, server, close = self.setup_run()
        wire.fail='timeout'; original=wire.record_parent
        def record(kind,payload):
            if kind=='exit': raise OSError('artificial exit record denied')
            original(kind,payload)
        with patch.object(wire,'record_parent',side_effect=record):
            with self.assertRaises(ValueError):
                server.tools['stata_run_selection'](value['literal_selections'][0],scope()['session_id'],10)
        result=close()
        self.assertFalse(result['cleanup_complete'])
        self.assertFalse(result['accepted'])
        self.assertTrue(any('Artificial response timeout' in value for value in result['failures']))
        self.assertEqual(kernel.handles,set())

    def test_terminal_record_write_failure_is_not_cached_success(self):
        value, kernel, wire, _, _, server, close = self.setup_run()
        original=wire.record_parent
        def record(kind,payload):
            if kind=='cleanup': raise OSError('artificial terminal record denied')
            original(kind,payload)
        with patch.object(wire,'record_parent',side_effect=record) as writes:
            server.tools['stata_run_selection'](value['literal_selections'][0],scope()['session_id'],10)
            with self.assertRaises(ValueError):
                server.tools['stata_run_selection'](value['literal_selections'][1],scope()['session_id'],10)
            count=writes.call_count
            self.assertFalse(close()['accepted'])
            self.assertFalse(close()['cleanup_complete'])
            self.assertEqual(writes.call_count,count)
        self.assertEqual(kernel.handles,set())

    def test_control_cannot_use_capabilities_after_rollback(self):
        _, kernel, wire, owner, _, _, _ = self.setup_run()
        resource=owner.allocate_suspended(scope()); owner.assign_job(resource); wire.fail='timeout'
        with self.assertRaises(TimeoutError): owner.initialize(resource)
        before=list(kernel.events)
        with self.assertRaises(ValueError): owner.control(resource,'cooperative_stop')
        self.assertEqual(kernel.events,before)

    def test_observe_cannot_query_disposed_identity_after_rollback(self):
        _, kernel, wire, owner, _, _, _ = self.setup_run()
        resource=owner.allocate_suspended(scope()); owner.assign_job(resource); wire.fail='timeout'
        with self.assertRaises(TimeoutError): owner.initialize(resource)
        with patch.object(kernel,'identity',wraps=kernel.identity) as query:
            with self.assertRaises(ValueError): owner.observe(resource)
            self.assertEqual(query.call_count,0)

    def test_supervisor_deadline_during_cleanup_remains_failed_without_replacement(self):
        _, kernel, _, owner, manager, _, close = self.setup_run()
        manager.open(); original=owner.shutdown
        def deadline(resource):
            kernel.tick=120
            self.assertTrue(mcp_adapter.lifecycle_step(manager,kernel,close))
            original(resource)
        with patch.object(owner,'shutdown',side_effect=deadline) as shutdown:
            result=manager.close()
            self.assertEqual(shutdown.call_count,1)
        self.assertFalse(result['accepted'])
        self.assertFalse(result['cleanup_complete'])
        self.assertEqual(close(),result)
        self.assertEqual(kernel.handles,set())
        closed=[e[1] for e in kernel.events if isinstance(e,tuple) and e[0]=='close']
        self.assertEqual(len(closed),len(set(closed)))
        self.assertEqual(sum(e==('spawn','worker') for e in kernel.events),1)

    def test_failed_capability_close_is_retained_without_automatic_retry(self):
        value, kernel, wire, owner, _, server, close = self.setup_run()
        wire.fail='timeout'; original=kernel.close
        def partial(handle):
            if handle==owner.inner: raise OSError('artificial capability close denied')
            original(handle)
        with patch.object(kernel,'close',side_effect=partial):
            with self.assertRaises(ValueError):
                server.tools['stata_run_selection'](value['literal_selections'][0],scope()['session_id'],10)
        self.assertFalse(close()['cleanup_complete'])
        self.assertFalse(close()['accepted'])
        self.assertEqual(kernel.handles,{owner.inner})
        before=list(kernel.events)
        self.assertFalse(close()['accepted'])
        self.assertEqual(kernel.events,before)


if __name__=='__main__': unittest.main()
