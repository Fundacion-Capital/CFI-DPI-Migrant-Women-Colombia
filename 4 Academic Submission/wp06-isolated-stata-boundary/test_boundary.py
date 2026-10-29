"""Behavior tests: source methods run only with artificial external effects."""
import copy
import importlib
import threading
import unittest
from test_support import ArtificialOwner, manifest, scope

try:
    policy = importlib.import_module('boundary')
except ModuleNotFoundError:
    policy = None


class BoundaryTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(policy, 'Isolated admission implementation is missing')
        self.owner = ArtificialOwner()
        self.base = self.owner.source_class
        self.manager = policy.isolated_manager(self.base, self.owner, scope(), manifest())
        self.router = policy.bind_dispatcher(self.manager)

    def request(self, index=0):
        return dict(selection=manifest()['literal_selections'][index],
            session_id='wp06-empty-artificial', timeout=10)

    def dispatch(self, index=0, **changes):
        request = self.request(index)
        request.update(changes)
        return self.router(request, True)

    def test_owned_creation_precedes_initialization_and_two_source_calls_succeed(self):
        self.manager.open()
        self.assertEqual(self.owner.events[:3], ['allocate', 'assign', 'initialize'])
        self.assertEqual(self.dispatch()['output'], 'ARTIFICIAL_OUTPUT_ONLY')
        self.assertEqual(self.dispatch(1)['status'], 'success')
        result = self.manager.close()
        self.assertTrue(result['accepted'])
        self.assertEqual(result['calls'], 2)
        self.assertEqual(self.owner.closed, {'fake-process', 'fake-job'})

    def test_original_class_is_not_modified(self):
        before = dict(self.base.__dict__)
        self.manager.open()
        self.dispatch()
        self.assertEqual(before, dict(self.base.__dict__))

    def test_missing_or_wrong_manager_never_enters_a_fallback(self):
        for manager in (None, object()):
            with self.assertRaises(ValueError):
                policy.bind_dispatcher(manager)
        self.assertFalse(self.owner.allocated)

    def test_disabled_multisession_consumes_run_before_transport(self):
        self.manager.open()
        with self.assertRaises(ValueError):
            self.router(self.request(), False)
        with self.assertRaises(ValueError):
            self.dispatch()
        self.assertFalse(any(isinstance(e, tuple) and e[0] == 'exchange' for e in self.owner.events))

    def test_default_or_wrong_session_rejected(self):
        self.manager.open()
        with self.assertRaises(ValueError):
            self.dispatch(session_id='default')
        self.assertEqual(self.manager.calls, 0)

    def test_payload_order_and_arbitrary_code_rejected(self):
        self.manager.open()
        with self.assertRaises(ValueError):
            self.dispatch(1)
        self.assertEqual(self.manager.calls, 0)

    def test_extra_path_and_timeout_fields_rejected(self):
        self.manager.open()
        with self.assertRaises(ValueError):
            self.dispatch(working_dir='C:/unapproved')
        self.assertEqual(self.manager.calls, 0)

    def test_third_selection_is_never_sent(self):
        self.manager.open()
        self.dispatch()
        self.dispatch(1)
        with self.assertRaises(ValueError):
            self.dispatch()
        self.assertEqual(self.manager.calls, 2)

    def test_second_open_does_not_allocate_a_replacement(self):
        self.manager.open()
        with self.assertRaises(ValueError):
            self.manager.open()
        self.assertEqual(self.owner.events.count('allocate'), 1)

    def test_creation_failure_still_closes_every_owned_handle(self):
        self.owner.fail = 'assign'
        with self.assertRaises(ValueError):
            self.manager.open()
        self.assertNotIn('initialize', self.owner.events)
        self.assertEqual(self.owner.closed, {'fake-process', 'fake-job'})

    def test_wrong_birth_identity_rejects_before_exchange(self):
        self.manager.open()
        self.owner.birth += 1
        with self.assertRaises(ValueError):
            self.dispatch()
        self.assertEqual(self.manager.calls, 0)

    def test_transport_timeout_consumes_call_without_retry(self):
        self.manager.open()
        self.owner.fail = 'exchange'
        with self.assertRaises(ValueError):
            self.dispatch()
        with self.assertRaises(ValueError):
            self.dispatch()
        self.assertEqual(self.manager.calls, 1)
        self.assertEqual(self.owner.events.count('allocate'), 1)

    def test_recovery_flag_is_a_failure_not_success(self):
        self.manager.open()
        self.owner.result = dict(status='success', output='', error='',
            session_id='wp06-empty-artificial', extra={}, session_recovered=True)
        with self.assertRaises(ValueError):
            self.dispatch()

    def test_late_result_is_rejected_without_second_call(self):
        self.manager.open()
        self.owner.exchange_hook = lambda: setattr(self.owner, 'tick', 90)
        with self.assertRaises(ValueError):
            self.dispatch()
        self.assertEqual(self.manager.calls, 1)

    def test_dispatch_at_deadline_equality_rejected(self):
        self.manager.open()
        self.owner.tick = 80
        with self.assertRaises(ValueError):
            self.dispatch()
        self.assertEqual(self.manager.calls, 0)

    def test_clock_rollback_quarantines(self):
        self.manager.open()
        self.owner.tick = 2
        self.dispatch()
        self.owner.tick = 1
        with self.assertRaises(ValueError):
            self.dispatch(1)

    def test_control_can_progress_during_an_exchange(self):
        self.manager.open()
        def during():
            self.owner.tick = 95
            self.manager.control_tick()
        self.owner.exchange_hook = during
        with self.assertRaises(ValueError):
            self.dispatch()
        self.assertIn('cooperative_stop', self.owner.events)
        self.assertIn('supervisor_containment', self.owner.events)

    def test_control_ceilings_are_once_only_and_include_outer_job(self):
        self.manager.open()
        self.owner.tick = 110
        self.manager.control_tick()
        self.manager.control_tick()
        for action in ('cooperative_stop', 'supervisor_containment', 'observer_containment', 'outer_containment'):
            self.assertEqual(self.owner.events.count(action), 1)

    def test_no_lifecycle_or_file_runner_bypasses(self):
        names = ('start', 'stop', 'create_session', '_create_session_internal',
            '_restart_session_with_same_id', 'restart_default_session', '_recover_session',
            '_check_sessions', 'execute_file', 'get_data', 'stop_execution', '_terminate_worker')
        for name in names:
            with self.subTest(name=name):
                owner = ArtificialOwner()
                manager = policy.isolated_manager(owner.source_class, owner, scope(), manifest())
                manager.open()
                with self.assertRaises(ValueError):
                    getattr(manager, name)('foreign')
                self.assertEqual(owner.events.count('allocate'), 1)
                self.assertFalse(manager.close()['accepted'])

    def test_cleanup_failure_does_not_skip_other_handles_or_pass(self):
        self.manager.open()
        self.dispatch()
        self.dispatch(1)
        self.owner.fail = 'fake-process'
        result = self.manager.close()
        self.assertFalse(result['accepted'])
        self.assertEqual(self.owner.closed, {'fake-process', 'fake-job'})

    def test_missing_exit_evidence_prevents_acceptance(self):
        self.manager.open()
        self.dispatch()
        self.dispatch(1)
        self.owner.exit_observed = False
        self.assertFalse(self.manager.close()['accepted'])

    def test_real_domain_and_runtime_ready_claim_rejected_before_allocation(self):
        self.owner.evidence_domain = 'LIVE'
        with self.assertRaises(ValueError):
            policy.isolated_manager(self.base, self.owner, scope(), manifest())
        self.owner.evidence_domain = 'ARTIFICIAL'
        changed = manifest()
        changed['runtime_ready'] = True
        with self.assertRaises(ValueError):
            policy.isolated_manager(self.base, self.owner, scope(), changed)
        self.assertFalse(self.owner.allocated)

    def test_wrong_source_class_pin_rejected(self):
        self.base.__source_sha256__ = '0' * 64
        with self.assertRaises(ValueError):
            policy.isolated_manager(self.base, self.owner, scope(), manifest())

    def test_installed_normalizer_removes_only_the_terminal_newline(self):
        self.manager.open()
        self.dispatch()
        payload = next(e[1] for e in self.owner.events if isinstance(e, tuple) and e[0] == 'exchange')
        self.assertEqual(payload + '\n', self.request()['selection'])

    def test_unapproved_code_never_reaches_transport(self):
        self.manager.open()
        with self.assertRaises(ValueError):
            self.dispatch(selection='display 1')
        self.assertFalse(any(isinstance(e, tuple) and e[0] == 'exchange' for e in self.owner.events))

    def test_control_remains_available_during_cleanup(self):
        self.manager.open()
        def during_shutdown():
            self.owner.tick = 110
            self.manager.control_tick()
        self.owner.shutdown_hook = during_shutdown
        self.assertFalse(self.manager.close()['accepted'])
        self.assertIn('outer_containment', self.owner.events)

    def test_control_before_allocation_does_not_send_an_unowned_action(self):
        self.owner.tick = 110
        self.manager.control_tick()
        self.assertNotIn('outer_containment', self.owner.events)

    def test_exit_evidence_must_match_retained_identity(self):
        self.manager.open()
        self.dispatch()
        self.dispatch(1)
        self.owner.exit_identity_hook = lambda row: row.update(creation_time=9999)
        self.assertFalse(self.manager.close()['accepted'])

    def test_pending_second_call_cannot_be_accepted_by_cleanup(self):
        self.manager.open()
        self.dispatch()
        closed = []
        self.owner.exchange_hook = lambda: closed.append(self.manager.close())
        with self.assertRaises(ValueError):
            self.dispatch(1)
        self.assertFalse(closed[0]['accepted'])

    def test_concurrent_admission_does_not_duplicate_exchange(self):
        self.manager.open()
        entered, release = threading.Event(), threading.Event()
        outcomes = []
        def blocked_exchange():
            entered.set()
            if not release.wait(1):
                raise ValueError('Artificial test release absent')
        def first():
            try:
                self.dispatch()
                outcomes.append('accepted')
            except ValueError:
                outcomes.append('rejected')
        self.owner.exchange_hook = blocked_exchange
        thread = threading.Thread(target=first)
        thread.start()
        try:
            self.assertTrue(entered.wait(1))
            with self.assertRaises(ValueError):
                self.dispatch()
        finally:
            release.set()
            thread.join(2)
        self.assertFalse(thread.is_alive())
        self.assertEqual(outcomes, ['rejected'])
        self.assertEqual(self.manager.calls, 1)

    def test_exact_nominal_deadline_rejects_even_before_global_control(self):
        self.manager.open()
        self.owner.exchange_hook = lambda: setattr(self.owner, 'tick', 10)
        with self.assertRaises(ValueError):
            self.dispatch()

    def test_missing_session_registry_does_not_autocreate(self):
        self.manager.open()
        self.manager._sessions.clear()
        with self.assertRaises(ValueError):
            self.dispatch()
        self.assertEqual(self.owner.events.count('allocate'), 1)

    def test_control_failure_does_not_skip_other_containment(self):
        self.manager.open()
        self.owner.fail = 'cooperative_stop'
        self.owner.tick = 110
        self.manager.control_tick()
        self.assertIn('outer_containment', self.owner.events)
        self.assertFalse(self.manager.close()['accepted'])

    def test_close_during_allocation_defers_then_cleans_without_initializing(self):
        original = self.owner.allocate_suspended
        receipts = []
        def allocate(value):
            resource = original(value)
            receipts.append(self.manager.close())
            return resource
        self.owner.allocate_suspended = allocate
        with self.assertRaises(ValueError):
            self.manager.open()
        self.assertFalse(receipts[0]['accepted'])
        self.assertNotIn('initialize', self.owner.events)
        self.assertEqual(self.owner.active, 0)
        self.assertEqual(self.owner.closed, {'fake-process', 'fake-job'})

    def test_identity_error_does_not_skip_retained_resource_shutdown(self):
        self.manager.open()
        self.dispatch()
        self.dispatch(1)
        self.owner.birth += 1
        result = self.manager.close()
        self.assertFalse(result['accepted'])
        self.assertIn('shutdown', self.owner.events)
        self.assertEqual(self.owner.active, 0)
        self.assertEqual(self.owner.closed, {'fake-process', 'fake-job'})

    def test_invalid_low_level_command_consumes_run(self):
        self.manager.open()
        with self.assertRaises(ValueError):
            self.manager._execute_command(object(), object(), {}, 10)
        with self.assertRaises(ValueError):
            self.dispatch()
        self.assertFalse(self.manager.close()['accepted'])

    def test_bound_dispatcher_cannot_be_redirected_to_another_valid_manager(self):
        self.manager.open()
        router = policy.bind_dispatcher(self.manager)
        other_owner = ArtificialOwner()
        other_scope = scope()
        other_scope.update(run_id='other-run', worker_epoch='other-epoch', owner_nonce='other-nonce')
        other = policy.isolated_manager(other_owner.source_class, other_owner, other_scope, manifest())
        other.open()
        # The bound router has no candidate-manager parameter to replace its captured instance.
        router(self.request(), True)
        self.assertEqual(self.manager.calls, 1)
        self.assertEqual(other.calls, 0)
        with self.assertRaises(TypeError):
            router(self.request(), True, other)

    def test_returned_capabilities_are_not_mutable_by_provider_alias(self):
        original = self.owner.allocate_suspended
        retained = []
        def allocate(value):
            resource = original(value)
            retained.append(resource)
            return resource
        self.owner.allocate_suspended = allocate
        self.manager.open()
        retained[0]['process_handle'] = 'foreign'
        self.dispatch()
        self.dispatch(1)
        self.assertTrue(self.manager.close()['accepted'])
        self.assertNotIn('foreign', self.owner.closed)
