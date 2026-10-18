"""Inert metadata tests only. No Stage-A imports, process or OS fixtures."""
import copy
import importlib.util
import json
import pathlib
import unittest

ROOT=pathlib.Path(__file__).resolve().parent

class PreflightTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue((ROOT/'check_preflight.py').exists(),'Missing inert documentary checker')
        s=importlib.util.spec_from_file_location('stage_b_checker',ROOT/'check_preflight.py')
        self.m=importlib.util.module_from_spec(s);s.loader.exec_module(self.m)
        self.inputs=[json.loads((ROOT/n).read_text(encoding='utf-8')) for n in ('design.json','gates.json','cases.json','sources.json')]
    def deny(self,change):
        values=copy.deepcopy(self.inputs);change(*values)
        with self.assertRaises(ValueError):self.m.check(*values)
    def test_documentary_pass_always_blocks_execution(self):
        result=self.m.check(*self.inputs)
        self.assertEqual(result['status'],'DOCUMENTARY_PREFLIGHT_PASS_EXECUTION_BLOCKED')
        self.assertFalse(result['operational_eligible']);self.assertEqual(result['cases_executed'],0)
        self.assertEqual(len(result['blocking_gates']),15);self.assertEqual(result['conditional_cases'],['AC21'])
    def test_authority_and_readiness_cannot_be_promoted(self):
        for key in self.inputs[0]['authority']:
            for value in (1,True):self.deny(lambda d,g,c,s,k=key,v=value:d['authority'].update({k:v}))
        self.deny(lambda d,g,c,s:d.update(operational_eligible=True));self.deny(lambda d,g,c,s:d.update(cases_executed=True))
        self.deny(lambda d,g,c,s:d.update(status='READY_TO_RUN'))
    def test_all_runtime_unknowns_remain_null(self):
        for key in self.inputs[1]['runtime']:
            for value in (0,False,'ASSUMED'):self.deny(lambda d,g,c,s,k=key,v=value:g['runtime'].update({k:v}))
        self.deny(lambda d,g,c,s:g['runtime'].pop('execution_budget_ns'))
    def test_all_pending_gate_fields_refuse_fabricated_decisions(self):
        fields={'approved':True,'status':'APPROVED','decision_maker':'OWNER','decision_date':'2026-10-18','rationale':'accepted','evidence_ref':'receipt'}
        for index in range(15):
            for key,value in fields.items():self.deny(lambda d,g,c,s,i=index,k=key,v=value:g['gates'][i].update({k:v}))
    def test_all_cases_remain_unexecuted_without_evidence(self):
        for index in range(6):
            for key,value in {'status':'PASS_WITH_VERIFIED_EVIDENCE','execution_evidence':['fake'],'actual_inventory':{},'execution_authorized':True}.items():
                self.deny(lambda d,g,c,s,i=index,k=key,v=value:c['cases'][i].update({k:v}))
    def test_exact_cases_phase_and_requirements(self):
        self.deny(lambda d,g,c,s:c['cases'].pop())
        for index in range(6):
            for key,value in {'id':'AC17','phase':'A_ARTIFICIAL','requirements':[]}.items():
                if key=='id' and index==0:continue
                self.deny(lambda d,g,c,s,i=index,k=key,v=value:c['cases'][i].update({k:v}))
    def test_launch_caps_are_exact_typed_and_zero_retry(self):
        for key in self.inputs[0]['launch_caps']:
            self.deny(lambda d,g,c,s,k=key:d['launch_caps'].update({k:True}))
            self.deny(lambda d,g,c,s,k=key:d['launch_caps'].update({k:99}))
        for index in range(6):self.deny(lambda d,g,c,s,i=index:c['cases'][i].update(max_new_processes=99))
    def test_profiles_and_prohibitions_cannot_enable_fallback(self):
        self.deny(lambda d,g,c,s:d['profiles'].update(fallback_enabled=True))
        self.deny(lambda d,g,c,s:d['profiles'].update(control='FORCED_TERMINATION'))
        self.deny(lambda d,g,c,s:c['cases'][4].update(conditional_fallback=False))
        for key in self.inputs[0]['prohibited']:self.deny(lambda d,g,c,s,k=key:d['prohibited'].update({k:False}))
    def test_role_topology_cannot_move_supervisor_under_controller(self):
        self.deny(lambda d,g,c,s:d['roles'][2].update(creator='CONTROLLER'))
        self.deny(lambda d,g,c,s:d['roles'][0].update(new_process=True))
        self.deny(lambda d,g,c,s:d['roles'][4].update(max_simultaneous=True))
    def test_exact_future_files_no_path_escape_or_missing_list(self):
        for value in ([],['wp06-stage-b/actors.py']*7,['../escape.py']):self.deny(lambda d,g,c,s,v=value:d.update(future_files=v))
    def test_gate_case_crosswalk_complete_and_conditional(self):
        self.deny(lambda d,g,c,s:g['gates'][12].update(required_for=['AC17']))
        self.deny(lambda d,g,c,s:g['gates'][0].update(required_for=[]))
        self.deny(lambda d,g,c,s:c['cases'][4].update(required_gates=['G01']))
    def test_sources_are_official_documentation_not_host_proof(self):
        for index in range(15):
            for key,value in {'url':'https://learn.microsoft.com.evil.example/doc','host_verified':True,'status':'HOST_VALIDATED'}.items():
                self.deny(lambda d,g,c,s,i=index,k=key,v=value:s['sources'][i].update({k:v}))
        self.deny(lambda d,g,c,s:s['sources'].pop())
    def test_source_pins_exact_schema_not_arbitrary_paths(self):
        self.deny(lambda d,g,c,s:d['source_pins']['stage_a_seal'].update(file='../secret'))
        self.deny(lambda d,g,c,s:d['source_pins']['stage_a_seal'].update(bytes=True))
        self.deny(lambda d,g,c,s:d['source_pins']['stage_a_seal'].update(sha256='unknown'))
    def test_unknown_fields_and_missing_sections_are_rejected(self):
        for index in range(4):
            values=copy.deepcopy(self.inputs);values[index]['unexpected']='ART_CANARY'
            with self.assertRaises(ValueError):self.m.check(*values)
        self.deny(lambda d,g,c,s:g['gates'][0].update(extra='ART_CANARY'))
        self.deny(lambda d,g,c,s:c['cases'][0].update(extra='ART_CANARY'))
        self.deny(lambda d,g,c,s:s['sources'][0].update(extra='ART_CANARY'))
    def test_enforcement_stages_are_ordered_and_cannot_bypass_observations(self):
        stages=self.inputs[1]['enforcement_stages']
        self.assertEqual([s['id'] for s in stages],['PRECREATION','QUIESCENT_BOOTSTRAP','PREARM_WORK_FAULT','CONDITIONAL_FALLBACK','COMPLETION'])
        self.deny(lambda d,g,c,s:g['enforcement_stages'].reverse())
        self.deny(lambda d,g,c,s:g['enforcement_stages'][0]['obligations'].append('G07_OBSERVED'))
        self.deny(lambda d,g,c,s:g['enforcement_stages'][1]['allowed'].append('WORK_DISPATCH'))
        self.deny(lambda d,g,c,s:g['enforcement_stages'][2]['obligations'].remove('G10_ARMED'))
    def test_retained_handles_cannot_claim_numeric_pid_reuse_acceptance(self):
        self.assertEqual(self.inputs[0]['profiles']['pid_reuse'],'RETAINED_HANDLE_REPLACEMENT_ONLY_FULL_AC19_HOLD_PENDING_REVIEWED_SCOPE_RESTRICTION')
        self.deny(lambda d,g,c,s:d['profiles'].update(pid_reuse='RETAINED_HANDLES_ALLOW_NUMERIC_REUSE_PASS'))
    def test_validation_does_not_mutate_inputs(self):
        before=copy.deepcopy(self.inputs);self.m.check(*self.inputs);self.assertEqual(self.inputs,before)

if __name__=='__main__':unittest.main(verbosity=2)
