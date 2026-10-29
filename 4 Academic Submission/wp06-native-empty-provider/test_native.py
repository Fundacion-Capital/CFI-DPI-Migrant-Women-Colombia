"""Concrete provider decisions with simulated kernel/channel effects."""
import importlib
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
from test_support import FakeKernel, FakeChannel, binding, scope

try:
    provider = importlib.import_module('native_provider')
    deployment = importlib.import_module('deployment')
    windows = importlib.import_module('win32_owner')
    channel = importlib.import_module('private_channel')
except ModuleNotFoundError:
    provider = deployment = windows = channel = None


class ProviderTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(provider, 'Native provider implementation missing')
        self.temp = tempfile.TemporaryDirectory(prefix='wp06_native_fake_')
        self.addCleanup(self.temp.cleanup)
        self.kernel = FakeKernel()
        self.wire = FakeChannel(self.kernel)
        self.binding = binding(Path(self.temp.name) / 'reserved')
        self.owner = provider.NativeOwner(self.kernel, self.wire, self.binding, scope())

    def opened(self):
        resource = self.owner.allocate_suspended(scope())
        self.owner.assign_job(resource)
        self.owner.initialize(resource)
        return resource

    def test_worker_owned_before_any_resume_and_watcher_starts_first(self):
        resource = self.opened()
        self.assertTrue(self.owner.observe(resource)['assigned'])
        resumes = [e for e in self.kernel.events if isinstance(e, tuple) and e[0] == 'resume']
        self.assertEqual(resumes, [('resume', 'watchdog'), ('resume', 'worker')])
        first_resume = self.kernel.events.index(resumes[0])
        self.assertEqual(sum(e[0] == 'assign' for e in self.kernel.events[:first_resume] if isinstance(e, tuple)), 3)

    def test_second_allocation_never_spawns_another_worker(self):
        self.opened()
        with self.assertRaises(ValueError):
            self.owner.allocate_suspended(scope())
        self.assertEqual(self.kernel.events.count(('spawn', 'worker')), 1)

    def test_partial_creation_rolls_back_all_returned_handles(self):
        self.kernel.fail = 'worker'
        with self.assertRaises(ValueError):
            self.owner.allocate_suspended(scope())
        self.assertEqual(self.kernel.handles, set())

    def test_watcher_creation_failure_stops_owned_worker(self):
        resource = self.owner.allocate_suspended(scope())
        self.owner.assign_job(resource)
        self.kernel.fail = 'watchdog'
        with self.assertRaises(ValueError):
            self.owner.initialize(resource)
        self.assertTrue(self.kernel.signaled(resource['process_handle']))

    def test_identity_drift_cannot_target_a_different_process(self):
        resource = self.opened()
        before = self.owner.observe(resource)
        self.kernel.birth_delta = 1
        after = self.owner.observe(resource)
        self.assertNotEqual(before['creation_time'], after['creation_time'])

    def test_exchange_allows_only_bound_literals_and_sequence(self):
        resource = self.opened()
        with self.assertRaises(ValueError):
            self.owner.exchange(resource, dict(code='display 1', timeout=10, execution_id='x'), 10)
        self.assertFalse(any(e[:3] == ('publish', 'worker', 'command') for e in self.wire.events))

    def test_timeout_signals_and_contains_without_retry(self):
        resource = self.opened()
        self.wire.fail = 'timeout'
        with self.assertRaises(TimeoutError):
            self.owner.exchange(resource, dict(code=self.binding['literal_selections'][0].removesuffix('\n'),
                timeout=10, execution_id='native-test-1'), 10)
        self.assertIn('signal_stop', self.kernel.events)
        self.assertTrue(self.kernel.signaled(resource['process_handle']))
        self.assertEqual(self.kernel.events.count(('spawn', 'worker')), 1)

    def test_shutdown_waits_for_worker_and_watchdog_and_closes_every_handle(self):
        resource = self.opened()
        self.owner.shutdown(resource)
        evidence = self.owner.observe_exit(resource)
        self.assertTrue(evidence['exit_observed'])
        self.assertEqual(evidence['active_owned'], 0)
        self.owner.close_handle(resource['process_handle'])
        self.owner.close_handle(resource['job'])
        self.assertEqual(self.kernel.handles, set())

    def test_real_kernel_constructor_rejects_before_dll_resolution(self):
        with patch('ctypes.WinDLL', side_effect=AssertionError('Native DLL resolution forbidden')) as dll:
            with self.assertRaises(ValueError):
                windows.Kernel(self.binding, None)
            dll.assert_not_called()

    def test_activation_descriptor_remains_disabled(self):
        with self.assertRaises(ValueError):
            deployment.require_execution(self.binding, None)


class ChannelTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(channel, 'Private channel implementation missing')
        self.temp = tempfile.TemporaryDirectory(prefix='wp06_channel_fake_')
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.clock = FakeKernel()
        self.wire = channel.Channel(self.clock)
        self.wire.prepare(binding(self.root), scope(), {'worker': b'w' * 32, 'watchdog': b'o' * 32})

    def test_frame_roundtrip_is_bound_and_create_only(self):
        self.wire.publish('worker', 'ready', 0, {'ready': True})
        self.assertEqual(self.wire.read('worker', 'ready', 0), {'ready': True})
        with self.assertRaises((FileExistsError, ValueError)):
            self.wire.publish('worker', 'ready', 0, {'ready': True})

    def test_other_run_and_tampered_frame_rejected(self):
        self.wire.publish('worker', 'ready', 0, {'ready': True})
        path = self.root / 'worker.ready.0.json'
        raw = path.read_bytes().replace(b'true', b'false')
        path.write_bytes(raw)
        with self.assertRaises(ValueError):
            self.wire.read('worker', 'ready', 0)

    def test_path_and_frame_size_rejected(self):
        with self.assertRaises(ValueError):
            self.wire.publish('../foreign', 'ready', 0, {})
        with self.assertRaises(ValueError):
            self.wire.publish('worker', 'result', 1, {'output': 'a' * 20000})

    def test_wait_respects_absolute_deadline(self):
        with self.assertRaises(TimeoutError):
            self.wire.wait('worker', 'ready', 0, 3)
        self.assertEqual(self.clock.tick, 3)
