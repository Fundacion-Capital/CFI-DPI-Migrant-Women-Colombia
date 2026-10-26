"""Pure failure-path reproductions: fake only the native OS boundary, no launches."""
import ctypes
import tempfile
from pathlib import Path
import unittest
from unittest.mock import patch

import live_roles as roles
from live_windows import Native

class FakeNative:
    def __init__(self, mode='normal'):
        self.frequency = 1000; self.tick = 0; self.mode = mode; self.closed = False; self.released = False
        self.ids = {i: {'pid': i, 'birth': i*10} for i in range(1, 6)}
        self.codes = {2: 0, 3: 0, 4: 71 if mode in {'controller_publication_failure','unexpected_exit'} else 0, 5: 0}
        self.api = type('API', (), {'GetCurrentProcess': staticmethod(lambda: 1), 'Sleep': lambda _, ms: self.advance(1000)})()
    def advance(self, ticks): self.tick += ticks
    def now(self): self.tick += 1; return self.tick
    def identity(self, handle): return self.ids[handle]
    def job(self): return 90
    def event(self): return 91
    def duplicate(self, handle, access): return 92
    def close(self, handle): pass
    def close_all(self):
        self.closed = True
        if self.mode == 'close_failure': raise OSError('close failed')
        if self.mode == 'late_closure': self.tick = 13000
    def wait(self, handle, deadline): return True
    def open_identity(self, identity, job): return identity['pid']
    def signal(self, handle): self.released = True
    def active(self, job):
        if self.mode == 'accounting_failure': raise OSError('accounting failure')
        return 1 if self.mode == 'termination_failure' else 0
    def stop_job(self, job):
        if self.mode == 'termination_failure': raise OSError('termination failure')
    def exit_code(self, handle):
        if self.mode == 'exit_observation_failure': raise OSError('exit observation failed')
        return self.codes[handle]
    def spawn(self, role, packet, script, job, capabilities):
        def emit(who, kind, payload):
            body = dict(domain=roles.DOMAIN, run=packet['run'], case=packet['case'], role=who,
                kind=kind, identity=self.ids['LOSCW'.index(who)+1], tick=1, payload=payload)
            if self.mode == 'wrong_identity' and (who,kind)==('W','STOP_APPLIED'):
                body['identity'] = dict(body['identity'], birth=999)
            roles.publish(Path(packet['packet'])/f'{who}_{kind}.json', roles.encode(body, bytes.fromhex(packet['keys'][who])))
        emit('O','READY',{'S':self.ids[3],'C':self.ids[4],'W':self.ids[5]})
        for who in 'OSCW': emit(who,'WORK_STARTED',{})
        emit('C','BOOT',{})
        emit('W','BOOT',{'stop_modify_denied':True})
        emit('S','READY',{'worker':self.ids[5]})
        emit('S','CONTROL_ATTEMPT',{'trigger':0,'worker':self.ids[5]})
        emit('S','FINAL',{'worker':self.ids[5],'forced':False,'exit_code':0})
        emit('W','STOP_APPLIED',{'event_observed':True})
        if self.mode == 'controller_publication_failure':
            emit('C','FAULT',{'reason':'publication failed','type':'OSError'})
        elif self.mode != 'missing_request': emit('C','STOP_REQUEST',{'event_signaled':True})
        emit('O','FINAL',{'S':0,'C':99 if self.mode == 'wrong_exit_report' else self.codes[4],
            'W':0,'supervisor_deadline_containment':False,'active_processes':0})
        return 2, self.ids[2]

class FailurePaths(unittest.TestCase):
    def run_fake(self, native, publish=None):
        with tempfile.TemporaryDirectory() as directory, patch.object(roles, 'PRIVATE', Path(directory)), patch.object(roles, 'Native', lambda: native):
            if publish is None: return roles.run_case(Path(directory)/'case', 'cooperative')
            with patch.object(roles, 'publish', publish): return roles.run_case(Path(directory)/'case', 'cooperative')

    def test_controller_publication_failure_cannot_pass_cooperative_profile(self):
        self.assertFalse(self.run_fake(FakeNative('controller_publication_failure'))['accepted'])

    def test_exact_profile_accepts_complete_native_and_report_evidence(self):
        self.assertTrue(self.run_fake(FakeNative())['accepted'])

    def test_wrong_authenticated_identity_missing_request_or_exit_mismatch_rejects(self):
        for mode in ['wrong_identity','missing_request','unexpected_exit','wrong_exit_report']:
            with self.subTest(mode=mode):
                self.assertFalse(self.run_fake(FakeNative(mode))['accepted'])

    def test_accounting_or_termination_failure_still_closes_owned_resources(self):
        for mode in ['accounting_failure','termination_failure','exit_observation_failure']:
            with self.subTest(mode=mode):
                native = FakeNative(mode)
                try: self.run_fake(native)
                except OSError: pass
                self.assertTrue(native.closed)

    def test_close_failure_does_not_return_acceptance(self):
        native = FakeNative('close_failure')
        with self.assertRaises(OSError): self.run_fake(native)
        self.assertTrue(native.closed)

    def test_closure_crossing_outer_deadline_cannot_pass(self):
        result = self.run_fake(FakeNative('late_closure'))
        self.assertTrue(result['owned_handles_closed'])
        self.assertFalse(result['accepted'])

    def test_final_publication_failure_still_closes_owned_resources(self):
        native = FakeNative()
        original = roles.publish
        def broken(path, wire):
            if path.name == 'case_result.json': raise OSError('final publication failed')
            return original(path, wire)
        with self.assertRaises(OSError): self.run_fake(native, broken)
        self.assertTrue(native.closed)

    def test_prearm_publication_crossing_deadline_cannot_release_gate(self):
        native = FakeNative()
        original = roles.publish
        def delayed(path, wire):
            original(path, wire)
            if path.name == 'L_PREARM.json': native.tick = 5000
        result = self.run_fake(native, delayed)
        self.assertFalse(native.released)
        self.assertFalse(result['accepted'])

    def test_await_report_rechecks_clock_after_read(self):
        ctx = object.__new__(roles.Context)
        clock = iter([9,10])
        ctx.n = type('Clock', (), {'now': lambda _: next(clock)})()
        ctx.b = {'bootstrap':10}
        ctx.read = lambda role,kind: {'report':'arrived late'}
        with self.assertRaises(ValueError): ctx.await_report('O','READY')

    def test_observed_gate_at_bootstrap_equality_does_not_admit_work(self):
        ctx = object.__new__(roles.Context)
        ctx.n = type('Clock', (), {'now':lambda _:10,'wait':lambda *args:True})()
        ctx.b = {'bootstrap':10,'control':20,'caps':{'gate':1}}
        written=[];ctx.write=lambda *args:written.append(args)
        with self.assertRaises(ValueError): ctx.gate()
        self.assertEqual(written,[])

    def test_close_all_attempts_remaining_handles_after_one_error(self):
        native = object.__new__(Native)
        native.handles={1,2};attempts=[]
        def close(handle):
            attempts.append(handle)
            if handle==1: raise OSError('close failed')
        native.close=close
        with self.assertRaises(Exception): native.close_all()
        self.assertEqual(set(attempts),{1,2})

    def test_report_reader_limits_the_read_before_decoding(self):
        ctx = object.__new__(roles.Context)
        with tempfile.TemporaryDirectory() as directory:
            ctx.path = Path(directory); ctx.keys = {'W': b'fixture'}
            target = ctx.path/'W_BOOT.json'
            with target.open('wb') as stream: stream.write(b' ' * 20000)
            original = Path.open
            sizes=[]
            class Reader:
                def __enter__(self): self.stream=original(target,'rb'); return self
                def __exit__(self,*args): self.stream.close()
                def read(self,size): sizes.append(size); return self.stream.read(size)
            with patch.object(Path,'open',lambda *args,**kwargs:Reader()):
                with self.assertRaisesRegex(ValueError,'FRAME_TOO_LARGE'):ctx.read('W','BOOT')
            self.assertEqual(sizes,[8193])

if __name__=='__main__':unittest.main()
