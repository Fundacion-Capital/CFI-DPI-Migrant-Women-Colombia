"""Documentary metadata tests only; no operational acceptance case is executed."""
import copy
import importlib.util
import json
import pathlib
import unittest

ROOT=pathlib.Path(__file__).resolve().parent

class PackageTests(unittest.TestCase):
    def setUp(self):
        path=ROOT/'check_package.py'
        self.assertTrue(path.exists(),'Expected RED: documentary checker not implemented')
        spec=importlib.util.spec_from_file_location('documentary_check',path)
        self.m=importlib.util.module_from_spec(spec);spec.loader.exec_module(self.m)
        self.c=json.loads((ROOT/'contract.json').read_text());self.p=json.loads((ROOT/'acceptance_plan.json').read_text())
    def reject(self,c=None,p=None):
        with self.assertRaises(ValueError):self.m.check(self.c if c is None else c,self.p if p is None else p)
    def test_valid_documentary_package_stays_operationally_blocked(self):
        got=self.m.check(self.c,self.p)
        self.assertFalse(got['operational_eligible']);self.assertEqual(got['planned_cases'],28);self.assertEqual(got['planned_cases_executed'],0)
    def test_each_nonzero_or_boolean_authority_rejected(self):
        for key in self.c['authorities']:
            for value in (1,True,False):
                c=copy.deepcopy(self.c);c['authorities'][key]=value
                with self.subTest(key=key,value=value):self.reject(c=c)
    def test_real_approval_or_readiness_promotion_rejected(self):
        for patch in ({'real_approvals':1},{'operational_ready':True},{'kind':'OPERATIONAL_READY'},{'current_phase':'LIVE'}):
            with self.subTest(patch=patch):self.reject(c=dict(self.c,**patch))
    def test_missing_requirement_and_duplicate_id_rejected(self):
        c=copy.deepcopy(self.c);c['requirements'].pop();self.reject(c=c)
        c=copy.deepcopy(self.c);c['requirements'][1]['id']='C01';self.reject(c=c)
    def test_unmapped_or_unknown_requirement_rejected(self):
        p=copy.deepcopy(self.p)
        for row in p['cases']:row['requirements']=[x for x in row['requirements'] if x!='C12']
        self.reject(p=p);p=copy.deepcopy(self.p);p['cases'][0]['requirements'].append('UNKNOWN');self.reject(p=p)
    def test_missing_duplicate_or_renumbered_case_rejected(self):
        for mode in ('missing','duplicate','renumber'):
            p=copy.deepcopy(self.p)
            if mode=='missing':p['cases'].pop()
            elif mode=='duplicate':p['cases'][1]['id']='AC01'
            else:p['cases'][0]['id']='AC99'
            with self.subTest(mode=mode):self.reject(p=p)
    def test_case_status_or_inserted_execution_evidence_rejected(self):
        p=copy.deepcopy(self.p);p['cases'][0]['status']='PASS';self.reject(p=p)
        p=copy.deepcopy(self.p);p['cases'][0]['execution_evidence']=['ART://all-green'];self.reject(p=p)
    def test_authentication_and_supervisor_choices_cannot_be_fabricated(self):
        for field,value in (('status','APPROVED'),('selected_value','ART_selected'),('evidence_ref','ART://fake')):
            c=copy.deepcopy(self.c);c['open_choices'][0][field]=value
            with self.subTest(field=field):self.reject(c=c)
    def test_phase_downgrade_and_authority_rewrite_rejected(self):
        p=copy.deepcopy(self.p);p['cases'][23]['phase']='A_ARTIFICIAL';self.reject(p=p)
        c=copy.deepcopy(self.c);c['phase_authorizations']['C_EMPTY_ENGINE']=['new_artificial_implementation_scope'];self.reject(c=c)
    def test_unknown_or_injected_executor_fields_rejected(self):
        self.reject(c=dict(self.c,executor='LIVE'))
        p=copy.deepcopy(self.p);p['cases'][0]['command']='run_engine';self.reject(p=p)
    def test_missing_action_specific_authority_scopes_rejected(self):
        c=copy.deepcopy(self.c);c.pop('conditional_authorizations',None);self.reject(c=c)
        c=copy.deepcopy(self.c);c['conditional_authorizations']['any_process_termination']='new_disposable_process_scope';self.reject(c=c)
    def test_empty_substantive_case_fields_rejected(self):
        for key in ('precondition','stimulus','pass_evidence','failure_disposition'):
            p=copy.deepcopy(self.p);p['cases'][0][key]=' '
            with self.subTest(key=key):self.reject(p=p)
    def test_unknown_binding_or_missing_receipt_fields_rejected(self):
        c=copy.deepcopy(self.c);c['binding_fields'].remove('worker_epoch');self.reject(c=c)
        c=copy.deepcopy(self.c);c['receipt_fields'].append('raw_stdout');self.reject(c=c)
    def test_inputs_are_not_mutated_or_authorized_by_checker(self):
        before=copy.deepcopy((self.c,self.p));self.m.check(self.c,self.p)
        self.assertEqual((self.c,self.p),before)

if __name__=='__main__':unittest.main(verbosity=2)
