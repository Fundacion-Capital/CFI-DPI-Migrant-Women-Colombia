"""Independent-review regressions; all resources and clocks are artificial."""
import ctypes as c
import hashlib
import json
from pathlib import Path
import tempfile
import time
import unittest
import deployment
import mcp_adapter
import native_session
import preflight
from native_provider import NativeOwner
from test_support import FakeKernel, FakeChannel, binding, scope
from test_abi import FakeABI
from test_adapter import FakeSDK
from win32_owner import Kernel


class NativeReviewTests(unittest.TestCase):
    def setup_owner(self, root, wire_class=FakeChannel):
        value = binding(root)
        value['manager_source'] = 'C:/Users/jzava/.cursor/extensions/deepecon.stata-mcp-0.5.3-universal/src/session_manager.py'
        kernel = FakeKernel()
        wire = wire_class(kernel)
        owner = NativeOwner(kernel, wire, value, scope())
        manager = native_session.isolated_manager(mcp_adapter.source_manager(value), owner, scope(), value)
        return value, kernel, wire, owner, manager

    def test_assignment_failure_terminates_unassigned_suspended_process(self):
        class RealisticWire(FakeChannel):
            def publish(self, role, kind, sequence, payload):
                self.events.append(('publish', role, kind, sequence))
                if kind == 'shutdown':
                    for process, row in self.kernel.processes.items():
                        if row['resumed']:
                            self.kernel.finish(process)
        with tempfile.TemporaryDirectory(prefix='wp06_review_') as directory:
            _, kernel, _, _, manager = self.setup_owner(Path(directory), RealisticWire)
            kernel.fail = 'assign'
            with self.assertRaises(ValueError):
                manager.open()
            self.assertTrue(all(not p['alive'] for p in kernel.processes.values()))
            self.assertEqual(kernel.handles, set())

    def test_pending_close_error_still_attempts_every_handle_and_retains_failed_one(self):
        with tempfile.TemporaryDirectory(prefix='wp06_review_') as directory:
            api = FakeABI()
            original = api.CloseHandle
            failed = []
            def close(handle):
                if handle == 12 and not failed:
                    failed.append(handle)
                    raise OSError('Artificial writer close failure')
                return original(handle)
            api.CloseHandle = close
            kernel = Kernel(binding(Path(directory)), None, api=api)
            process = kernel.spawn_suspended('worker', binding(Path(directory)), {})
            with self.assertRaises(Exception):
                kernel.close(process)
            self.assertIn(502, api.closed)
            self.assertIn(501, api.closed)
            self.assertIn(12, kernel.handles)
            kernel.close_all()
            self.assertEqual(kernel.handles, set())
            self.assertEqual(kernel.pending, {})

    def test_job_configuration_failure_closes_raw_job(self):
        with tempfile.TemporaryDirectory(prefix='wp06_review_') as directory:
            api = FakeABI()
            api.CreateJobObjectW = lambda *args: 901
            def fail(*args):
                raise OSError('Artificial job setup failure')
            api.SetInformationJobObject = fail
            kernel = Kernel(binding(Path(directory)), None, api=api)
            with self.assertRaises(OSError):
                kernel.job()
            self.assertEqual(kernel.handles, set())
            self.assertIn(901, api.closed)

    def test_idle_one_call_is_closed_by_supervisor_without_another_request(self):
        with tempfile.TemporaryDirectory(prefix='wp06_review_') as directory:
            value, kernel, _, _, manager = self.setup_owner(Path(directory))
            server, close = mcp_adapter.build_server(manager, FakeSDK)
            server.tools['stata_run_selection'](value['literal_selections'][0], scope()['session_id'], 10)
            kernel.tick = 110
            for process in kernel.processes:
                kernel.finish(process)
            self.assertTrue(mcp_adapter.lifecycle_step(manager, kernel, close))
            self.assertEqual(kernel.handles, set())
            self.assertTrue(manager._close_started)

    def test_empty_inventory_cannot_pass_static_preflight(self):
        with tempfile.TemporaryDirectory(prefix='wp06_review_') as directory:
            root = Path(directory)
            path = root / 'inventory.json'
            raw = b'{"files":[]}'
            path.write_bytes(raw)
            value = binding(root)
            value.update(runtime_inventory=str(path), runtime_inventory_sha256=hashlib.sha256(raw).hexdigest())
            with self.assertRaises(ValueError):
                preflight.inspect(value)

    def test_catalog_detects_added_importable_file_and_missing_required_pin(self):
        with tempfile.TemporaryDirectory(prefix='wp06_review_') as directory:
            root = Path(directory)
            path = root / 'module.py'
            raw = b'value = 1\n'
            path.write_bytes(raw)
            roots = [{'path': str(root), 'mode': 'importable'}]
            required = [str(path)]
            catalog = dict(schema='WP06_RUNTIME_FILES_V1', roots=roots, required=required,
                files=[dict(path=str(path), bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest())])
            self.assertEqual(deployment.check_catalog(catalog, roots, required), [])
            (root / 'injected.py').write_bytes(b'value = 2\n')
            self.assertTrue(deployment.check_catalog(catalog, roots, required))
            catalog['files'] = []
            with self.assertRaises(ValueError):
                deployment.check_catalog(catalog, roots, required)

    def test_nonfinite_expiry_never_authorizes_native_calls(self):
        value = binding(Path('C:/fixed/private'))
        value.update(activation_allowed=True, activation_holds=[])
        grant = dict(approved=True, scope='ONE_EMPTY_NATIVE_RUN', approval_reference='artificial-test-only',
            binding_sha256=deployment.digest(value), expires_utc=float('nan'))
        with self.assertRaises(ValueError):
            deployment.require_execution(value, grant)
