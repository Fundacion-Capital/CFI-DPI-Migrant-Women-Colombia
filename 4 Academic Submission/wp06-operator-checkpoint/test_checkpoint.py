"""Selection-record metadata only; no operator response is accepted or acted on."""
import copy
import importlib.util
import json
import pathlib
import unittest

ROOT=pathlib.Path(__file__).resolve().parent

class CheckpointTests(unittest.TestCase):
    def setUp(self):
        path=ROOT/'check_checkpoint.py';self.assertTrue(path.exists(),'Expected RED: checkpoint checker missing')
        spec=importlib.util.spec_from_file_location('operator_check',path);self.m=importlib.util.module_from_spec(spec);spec.loader.exec_module(self.m)
        self.c=json.loads((ROOT/'checkpoint.json').read_text());self.s=json.loads((ROOT/'sources.json').read_text())
    def reject(self,c=None,s=None):
        with self.assertRaises(ValueError):self.m.check(self.c if c is None else c,self.s if s is None else s)
    def test_seven_recommendations_do_not_record_adoption(self):
        result=self.m.check(self.c,self.s)
        self.assertEqual(result['recommendations'],7);self.assertEqual(result['real_decisions_recorded'],0)
        self.assertFalse(result['operational_eligible'])
    def test_each_authority_and_execution_promotion_rejected(self):
        for key in self.c['authorities']:
            c=copy.deepcopy(self.c);c['authorities'][key]=1
            with self.subTest(key=key):self.reject(c=c)
        for key in ('real_decisions_recorded','planned_cases_executed'):
            c=copy.deepcopy(self.c);c[key]=1;self.reject(c=c)
    def test_each_real_decision_field_cannot_be_fabricated(self):
        for i in range(7):
            for field,value in [('approved',True),('status','APPROVED'),('selected_value','REC_PROFILE'),('decision_maker','ART_operator'),('decision_date','2026-10-18'),('rationale','ART_test'),('evidence_ref','ART://pass')]:
                c=copy.deepcopy(self.c);c['recommendations'][i]['decision'][field]=value
                with self.subTest(i=i,field=field):self.reject(c=c)
    def test_unmeasured_budgets_paths_and_retention_remain_unknown(self):
        for key,value in [('real_execution_budget_ns',0),('real_cleanup_budget_ns',1000),('active_store_path','C:/ART'),('archive_path','ART_archive'),('retention_years',5)]:
            c=copy.deepcopy(self.c);c[key]=value
            with self.subTest(key=key):self.reject(c=c)
    def test_missing_duplicate_or_unknown_recommendation_rejected(self):
        c=copy.deepcopy(self.c);c['recommendations'].pop();self.reject(c=c)
        c=copy.deepcopy(self.c);c['recommendations'][1]['id']='O01';self.reject(c=c)
        c=copy.deepcopy(self.c);c['recommendations'][1]['id']='O99';self.reject(c=c)
    def test_wrong_role_or_checkpoint_rejected(self):
        c=copy.deepcopy(self.c);c['recommendations'][6]['role']='runtime_operator';self.reject(c=c)
        c=copy.deepcopy(self.c);c['recommendations'][0]['checkpoint']='D1_rights';self.reject(c=c)
    def test_unknown_unverified_and_nonprimary_source_rejected(self):
        c=copy.deepcopy(self.c);c['recommendations'][0]['sources'].append('UNKNOWN');self.reject(c=c)
        s=copy.deepcopy(self.s);s['sources'][0]['status']='HOST_VERIFIED';self.reject(s=s)
        s=copy.deepcopy(self.s);s['sources'][0]['url']='https://example.org/claim';self.reject(s=s)
    def test_missing_duplicate_or_empty_source_fact_rejected(self):
        s=copy.deepcopy(self.s);s['sources'].pop();self.reject(s=s)
        s=copy.deepcopy(self.s);s['sources'][1]['id']='S01';self.reject(s=s)
        s=copy.deepcopy(self.s);s['sources'][0]['claim']=' ';self.reject(s=s)
    def test_case_or_requirement_mapping_cannot_escape_contract(self):
        c=copy.deepcopy(self.c);c['recommendations'][0]['cases'].append('AC99');self.reject(c=c)
        c=copy.deepcopy(self.c);c['recommendations'][0]['requirements'].append('C99');self.reject(c=c)
    def test_recommendation_basis_cannot_be_promoted_to_fact(self):
        c=copy.deepcopy(self.c);c['recommendations'][0]['basis']='OPERATOR_ADOPTED';self.reject(c=c)
        self.reject(c=dict(self.c,host_compatibility='VALIDATED'))
    def test_empty_tradeoff_or_limit_rejected(self):
        c=copy.deepcopy(self.c);c['recommendations'][0]['alternatives']=[];self.reject(c=c)
        c=copy.deepcopy(self.c);c['recommendations'][0]['limits']=[];self.reject(c=c)
    def test_injected_executor_and_input_mutation_rejected(self):
        self.reject(c=dict(self.c,executor='LIVE'))
        before=copy.deepcopy((self.c,self.s));self.m.check(self.c,self.s);self.assertEqual((self.c,self.s),before)

if __name__=='__main__':unittest.main(verbosity=2)
