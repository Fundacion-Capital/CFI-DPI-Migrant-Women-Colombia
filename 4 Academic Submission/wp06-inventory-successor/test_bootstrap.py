"""AC-D09–11: guarded role entry with fake kernel, no engine/native imports."""
import copy
import ast
import json
from pathlib import Path
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch
from deployment import digest
import runtime_roles as roles
from test_support import FakeChannel, binding, scope


class BootstrapTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory(prefix='wp06_bootstrap_artificial_')
        self.addCleanup(self.temp.cleanup)
        self.root=Path(self.temp.name)
        self.value=binding(self.root); self.value['run_scope']=scope()
        self.current={'pid':701,'birth':134000000000000001}
        self.packet=dict(scope=scope(),origin=0,frequency=1,binding_sha256=digest(self.value),
            worker_identity=copy.deepcopy(self.current),role='watchdog',key='01'*32,
            identity=copy.deepcopy(self.current),inherited=dict(worker=102,inner_job=103))
        self.tick=59; self.calls=[]
        def identity(handle): self.calls.append('identity'); return self.current
        def now(): self.calls.append('now'); return self.tick
        self.kernel=SimpleNamespace(frequency=1,api=SimpleNamespace(GetCurrentProcess=lambda:-1),identity=identity,
            now=now,read_private_bootstrap=lambda reader:copy.deepcopy(self.packet),own=lambda h:None,
            member=lambda *args:True,close_all=lambda:None)

    def invoke(self,role='watchdog'):
        with patch.object(roles,'load_active',return_value=(self.value,None)), \
                patch.dict(sys.modules,{'win32_owner':SimpleNamespace(Kernel=lambda *args:self.kernel)}), \
                patch.object(roles,'Channel',FakeChannel),patch.object(roles,'watchdog_loop',return_value=None), \
                patch.object(roles,'StataEngine',side_effect=AssertionError('Engine forbidden')):
            roles.main(role,11,self.root/'not-a-real-binding.json')

    def rejection(self,role='watchdog'):
        with self.assertRaises(Exception): self.invoke(role)
        file=self.root/('bootstrap.'+(role if role in {'worker','watchdog'} else 'invalid-role')+'.rejection.json')
        self.assertTrue(file.is_file())
        return json.loads(file.read_text(encoding='utf-8'))

    def test_ac_d09_first_failed_predicate_does_not_evaluate_later_operands(self):
        self.packet['unexpected']='not-to-be-logged'
        row=self.rejection()
        self.assertEqual(row['reason'],'schema')
        self.assertEqual(row['checks']['identity'],'NOT_EVALUATED')
        self.assertEqual(row['checks']['deadline'],'NOT_EVALUATED')
        self.assertEqual(self.calls,[])

    def test_all_guard_rejection_categories_are_distinct(self):
        cases=[('role_match','role','worker'),('binding_digest','binding_sha256','0'*64),
            ('frequency','frequency',2),('identity','identity',{'pid':702,'birth':134000000000000001})]
        for reason,field,value in cases:
            with self.subTest(reason=reason):
                self.packet[field]=value
                row=self.rejection()
                self.assertEqual(row['reason'],reason)
                (self.root/'bootstrap.watchdog.rejection.json').unlink()
                self.setUp_packet()

    def setUp_packet(self):
        self.packet.update(role='watchdog',binding_sha256=digest(self.value),frequency=1,identity=copy.deepcopy(self.current))
        self.calls.clear()

    def test_exact_deadline_retains_actual_sample_without_reset(self):
        self.tick=60
        row=self.rejection()
        self.assertEqual(row['reason'],'deadline')
        self.assertEqual(row['checks']['deadline'],dict(origin=0,frequency=1,deadline=60,tick=60,matched=False))
        self.assertEqual(self.calls.count('now'),1)

    def test_success_before_deadline_does_not_create_rejection(self):
        self.invoke()
        self.assertFalse(list(self.root.glob('bootstrap.*.json')))

    def test_ac_d10_credentials_and_unknown_fields_are_not_written(self):
        secret='PRIVATE_ROLE_CREDENTIAL_NEVER_LOG'
        self.packet['key']=secret; self.packet[secret]=secret
        row=self.rejection()
        self.assertNotIn(secret,json.dumps(row))
        self.assertEqual(row['role'],'watchdog')
        self.assertEqual(len(row['source_disk_sha256']),64)

    def test_diagnostic_write_failure_keeps_both_failures(self):
        self.packet['frequency']=2
        original=Path.open
        def denied(file,*args,**kwargs):
            if file.name.startswith('bootstrap.'): raise OSError('artificial write denied')
            return original(file,*args,**kwargs)
        with patch.object(Path,'open',new=denied):
            with self.assertRaises(ExceptionGroup) as caught: self.invoke()
        self.assertEqual(len(caught.exception.exceptions),2)
        self.assertIsInstance(caught.exception.exceptions[0],ValueError)
        self.assertIsInstance(caught.exception.exceptions[1],OSError)

    def test_existing_rejection_record_is_not_overwritten(self):
        file=self.root/'bootstrap.watchdog.rejection.json'; file.write_bytes(b'preserved artificial record')
        self.packet['frequency']=2
        with self.assertRaises(ExceptionGroup): self.invoke()
        self.assertEqual(file.read_bytes(),b'preserved artificial record')

    def test_untrusted_role_cannot_choose_record_path(self):
        row=self.rejection('../outside')
        self.assertEqual(row['role'],'UNSUPPORTED')
        self.assertEqual(row['reason'],'role_match')
        self.assertNotIn('../outside',json.dumps(row))

    def test_malformed_packet_is_rejected_without_dumping_payload(self):
        self.packet=['secret-payload']
        row=self.rejection()
        self.assertEqual(row['reason'],'schema')
        self.assertNotIn('secret-payload',json.dumps(row))

    def test_ac_d11_large_identity_integer_is_preserved(self):
        self.packet['identity']['birth']=134000000000000003
        row=self.rejection()
        self.assertEqual(row['checks']['identity']['reported']['birth'],134000000000000003)
        self.assertEqual(row['checks']['identity']['observed']['birth'],134000000000000001)

    def test_matching_unknown_role_is_rejected_by_allowlist(self):
        self.packet['role']='unknown-role'
        row=self.rejection('unknown-role')
        self.assertEqual(row['reason'],'role_allowed')
        self.assertEqual(row['checks']['binding_digest'],'NOT_EVALUATED')

    def test_ac_d11_changed_manager_source_pin_rejects_before_dispatch(self):
        import mcp_adapter
        value=copy.deepcopy(self.value)
        value.update(manager_source='C:/Users/jzava/.cursor/extensions/deepecon.stata-mcp-0.5.3-universal/src/session_manager.py',manager_sha256='0'*64)
        with self.assertRaisesRegex(ValueError,'Selection source pin changed'): mcp_adapter.source_manager(value)

    def test_integer_packet_guard_matches_original_accept_reject_boundary(self):
        original=Path(__file__).resolve().parent.parent/'wp06-startup-remediation/runtime_roles.py'
        tree=ast.parse(original.read_text(encoding='utf-8'))
        main=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='main')
        wanted=next(n for n in main.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='wanted' for t in n.targets))
        guard=main.body[main.body.index(wanted)+1]
        code=compile(ast.fix_missing_locations(ast.Module(body=[wanted,guard],type_ignores=[])),str(original)+':guard-only','exec')
        for tick in (0,59,60,61):
            for changed in (False,True):
                packet=copy.deepcopy(self.packet)
                if changed: packet['frequency']=2
                kernel=SimpleNamespace(frequency=1,api=self.kernel.api,identity=lambda h:self.current,now=lambda:tick)
                with tempfile.TemporaryDirectory(prefix='wp06_equivalence_artificial_') as folder:
                    value=copy.deepcopy(self.value); value['private_root']=folder
                    packet['binding_sha256']=digest(value)
                    expected=True
                    try: exec(code,dict(packet=packet,role='watchdog',binding=value,kernel=kernel,digest=digest))
                    except ValueError: expected=False
                    actual=True
                    try: roles.check_bootstrap('watchdog',packet,value,kernel)
                    except ValueError: actual=False
                    with self.subTest(tick=tick,changed=changed): self.assertEqual(actual,expected)

    def test_oversized_diagnostic_fails_closed_without_writing_payload(self):
        self.packet['identity']['birth']=10**4100
        with self.assertRaises(ExceptionGroup) as caught: self.invoke()
        self.assertIsInstance(caught.exception.exceptions[1],ValueError)
        self.assertFalse(list(self.root.glob('bootstrap.*.json')))

    def test_invalid_deadline_operand_is_not_logged_as_raw_text(self):
        self.packet['origin']='PRIVATE_INVALID_ORIGIN'
        row=self.rejection()
        self.assertEqual(row['reason'],'deadline_evaluation')
        self.assertEqual(row['checks']['deadline']['origin'],'INVALID_TYPE')
        self.assertNotIn('PRIVATE_INVALID_ORIGIN',json.dumps(row))


if __name__=='__main__': unittest.main()
