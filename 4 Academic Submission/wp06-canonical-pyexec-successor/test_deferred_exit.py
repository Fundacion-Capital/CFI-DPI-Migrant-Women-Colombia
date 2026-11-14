from pathlib import Path
from tempfile import TemporaryDirectory
from types import SimpleNamespace
import unittest
from unittest.mock import Mock, patch

from native_provider import NativeOwner
from private_channel import Channel
from test_support import FakeChannel, FakeKernel, binding, fake_python_ready, scope
from termination_evidence import read_exit_witness, read_parent_bootstrap
from win32_owner import Kernel


class DeferredExitTests(unittest.TestCase):
    def test_clock_failure_still_closes_handles_and_finishes_failed_rollback(self):
        for phase in ('exit', 'closure'):
            with self.subTest(phase=phase):
                kernel = FakeKernel()
                owner = NativeOwner(kernel, FakeChannel(kernel), binding(Path('C:/artificial/run')), scope())
                resource = owner.allocate_suspended(scope())
                owner.assign_job(resource)
                owner.initialize(resource)
                active = kernel.active
                sampled = []
                def count(job):
                    value = active(job)
                    sampled.append(True)
                    return value
                def now():
                    if sampled and (phase == 'exit') == bool(kernel.handles):
                        raise OSError('artificial clock failure')
                    return kernel.tick
                with patch.object(kernel,'now',side_effect=now), patch.object(kernel,'active',side_effect=count):
                    with self.assertRaises(BaseExceptionGroup):
                        owner._rollback()
                self.assertFalse(owner.rollback_result['cleanup_complete'])
                self.assertFalse(kernel.handles)

    def test_provider_does_not_initialize_when_real_bootstrap_publication_fails(self):
        with TemporaryDirectory(prefix='wp06_duplicate_bootstrap_') as tmp:
            root = Path(tmp)
            kernel = FakeKernel()
            records, wire = Channel(kernel), FakeChannel(kernel)
            value = {**binding(root),'run_scope':scope()}
            with patch('private_channel.verify_startup'):
                records.prepare(value,scope(),{'worker':b'w'*32,'watchdog':b'd'*32})
            wire.record_parent = records.record_parent
            owner = NativeOwner(kernel,wire,value,scope())
            resource = owner.allocate_suspended(scope())
            owner.assign_job(resource)
            path = root/'parent.python_bootstrap.json'
            path.write_bytes(b'artificial preexisting')
            with self.assertRaises(FileExistsError):
                owner.initialize(resource)
            self.assertFalse(owner.initialized)
            self.assertFalse(kernel.handles)
            self.assertEqual(path.read_bytes(),b'artificial preexisting')

    def test_denial_reconciles_only_with_complete_timely_rollback(self):
        for case in ('valid', 'late', 'foreign', 'close_failure', 'unclassified'):
            with self.subTest(case=case):
                kernel = FakeKernel()
                wire = FakeChannel(kernel)
                tmp = TemporaryDirectory(prefix='wp06_deferred_exit_')
                self.addCleanup(tmp.cleanup)
                root = Path(tmp.name)
                records = Channel(kernel)
                value = {**binding(root),'run_scope':scope()}
                with patch('private_channel.verify_startup'):
                    records.prepare(value,scope(),{'worker':b'w'*32,'watchdog':b'd'*32})
                wire.record_parent = records.record_parent
                owner = NativeOwner(kernel, wire, value, scope())
                resource = owner.allocate_suspended(scope())
                owner.assign_job(resource)
                owner.initialize(resource)
                watchdog = owner.watchdog
                original_stop = kernel.stop_process
                denial = PermissionError('artificial access denied')
                denial.winerror = 5
                terminate = Mock(side_effect=denial)
                abi = SimpleNamespace(handles=kernel.handles, identity=kernel.identity,
                                      signaled=kernel.signaled, ok=lambda result: result,
                                      api=SimpleNamespace(TerminateProcess=terminate))

                def stop(handle, expected):
                    if handle != watchdog:
                        return original_stop(handle, expected)
                    if case == 'unclassified':
                        raise denial
                    return Kernel.stop_process(abi, handle, expected)

                def pause():
                    kernel.tick = owner.origin + (110 if case == 'late' else 1)*owner.frequency_hz
                    kernel.finish(watchdog)
                    if case == 'foreign':
                        kernel.birth_delta = 1

                if case == 'close_failure':
                    kernel.fail = watchdog
                kernel.finish(owner.worker)
                with patch.object(kernel,'stop_job'), patch.object(kernel,'stop_process',side_effect=stop), patch.object(kernel,'pause',side_effect=pause):
                    if case == 'valid':
                        try:
                            self.assertTrue(owner._rollback()['cleanup_complete'])
                        except BaseExceptionGroup as error:
                            self.fail(str(error))
                    else:
                        with self.assertRaises(BaseExceptionGroup):
                            owner._rollback()
                        self.assertFalse(owner.rollback_result['cleanup_complete'])
                row = owner.termination_observations[-1]
                self.assertEqual(row['result'], 'exit_verified_in_rollback_after_access_denied' if case == 'valid' else 'failed')
                self.assertEqual(row['winerror'], 5)
                self.assertIn('artificial access denied',row['error'])
                self.assertEqual(terminate.call_count, 0 if case == 'unclassified' else 1)
                roles = ['inner','outer','worker','watchdog']
                if case == 'valid':
                    saved = read_exit_witness(root, scope(), roles)
                    self.assertEqual(saved['termination_observations'][-1], row)
                    (root/'parent.closure.json').unlink()
                    with self.assertRaises(FileNotFoundError):
                        read_exit_witness(root, scope(), roles)
                else:
                    with self.assertRaises(ValueError):
                        read_exit_witness(root, scope(), roles)

    def test_real_positive_receipt_is_create_only_and_validated(self):
        with TemporaryDirectory(prefix='wp06_receipt_fake_') as tmp:
            root = Path(tmp)
            wire = Channel(FakeKernel())
            value = {**binding(root), 'run_scope':scope()}
            with patch('private_channel.verify_startup'):
                wire.prepare(value, scope(), {'worker':b'w'*32,'watchdog':b'd'*32})
            proof = fake_python_ready(value)
            try:
                wire.record_parent('python_bootstrap', proof)
            except ValueError as error:
                self.fail(str(error))
            path = root/'parent.python_bootstrap.json'
            saved = path.read_bytes()
            self.assertEqual(read_parent_bootstrap(root,scope(),value),proof)
            with self.assertRaises(ValueError):
                read_parent_bootstrap(root,{**scope(),'run_id':'foreign'},value)
            with self.assertRaises(ValueError):
                wire.record_parent('python_bootstrap', {**proof,'sfi_initialized':False})
            with self.assertRaises(FileExistsError):
                wire.record_parent('python_bootstrap', proof)
            with self.assertRaises(ValueError):
                wire.record_parent('unknown', proof)
            self.assertEqual(path.read_bytes(),saved)
