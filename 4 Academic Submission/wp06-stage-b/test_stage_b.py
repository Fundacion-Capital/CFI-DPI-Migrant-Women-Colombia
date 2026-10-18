"""Explicit artificial-only tests; no actors, native libraries or host probes."""
import copy
import hashlib
import hmac
import importlib
import json
import pathlib
import os
import sqlite3
import unittest

HERE=pathlib.Path(__file__).resolve().parent
A='a'*64;B='b'*64;KEY=b'fixture-role-key-not-a-runtime-credential-0001'
def store_path(name):return pathlib.Path(os.environ['WP06_ARTIFICIAL_STORE_ROOT'])/(hashlib.sha256(name.encode('ascii')).hexdigest()[:16]+'.sqlite')
def binding():
    return dict(origin='B_DISPOSABLE',contract_digest=A,build_digest=B,host_id='ART_HOST',boot_id='ART_BOOT',observer_epoch='ART_EPOCH',session_id='ART_SESSION',owner_nonce='ART_OWNER',worker_epoch='ART_W1',command_id='ART_CMD1',pid='101',creation_time_100ns='1001',engine_module_digest=A,reservation_id='ART_R1',lease_id='ART_L1',scope_id='ART_SCOPE',clock_domain='ART_QPC',qpc_frequency_hz='1000000000')
def wire(b=None,**changes):
    m=dict(binding=b or binding(),issuer='W',credential_id='ART_WKEY',sequence='1',previous_digest='0'*64,tick='20',frequency='1000000000',kind='STOP_APPLIED',reason='REQUEST',result='APPLIED',payload_digest=A)
    m.update(changes);body=json.dumps(m,sort_keys=True,separators=(',',':'),ensure_ascii=True).encode('ascii')
    m['tag']=hmac.new(KEY,body,hashlib.sha256).hexdigest()
    return json.dumps(m,sort_keys=True,separators=(',',':'),ensure_ascii=True).encode('ascii')
def fixture_verify(d):return d['signature']=='ART_ONLY'
def fixture_observe(o):return o.get('evidence_ref')=='ART_VERIFIED'
def scope():
    return dict(evidence_domain='ARTIFICIAL',scope_digest=A,build_digest=B,observer_epoch='ART_EPOCH',now_tick=10,binding=binding(),verify_decision=fixture_verify,verify_observation=fixture_observe,actor_specs={r:launch_spec() for r in ('O','S','C','W')},bootstrap_deadline_tick=30,ipc_deadline_tick=60,control_deadline_tick=60,cleanup_deadline_tick=80,fallback_profile_digest=A)
POLICY=['G01_POLICY','G02_POLICY','G03_POLICY','G04_POLICY','G05_POLICY','G06_POLICY','G07_PLAN','G08_POLICY','G09_LIMITS','G10_PLAN','G11_POLICY','G12_POLICY','G15_PLAN']
def decisions(components=None):
    return [dict(component=c,decision_id='ART_D'+str(i),issuer='ART_OWNER',scope_digest=A,build_digest=B,not_before_tick='0',expires_tick='100',observer_epoch='ART_EPOCH',approved=True,evidence_digest=A,signature='ART_ONLY') for i,c in enumerate(components or POLICY)]
def observations():
    return [dict(component=c,binding=binding(),envelope_digest=A,tick='9',evidence_ref='ART_VERIFIED') for c in ['G04_OBSERVED','G07_OBSERVED','G08_OBSERVED','G09_RUNTIME_BOUND','G10_ARMED','RESERVATION_AND_SINGLE_USE_SLOT_COMMITTED']]
class ContractTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue((HERE/'journal_protocol.py').exists(),'Missing contract implementation')
        self.p=importlib.import_module('journal_protocol')
    def test_binding_rejects_missing_extra_bool_or_wrong_generation(self):
        self.assertEqual(self.p.validate_binding(binding()),binding())
        for key in binding():
            bad=binding();bad.pop(key)
            with self.assertRaises(ValueError):self.p.validate_binding(bad)
        for patch in ({'extra':'x'},{'pid':True},{'pid':'01'},{'build_digest':'A'*64}):
            bad=binding();bad.update(patch)
            with self.assertRaises(ValueError):self.p.validate_binding(bad)
        old=binding();old['worker_epoch']='ART_OLD'
        with self.assertRaises(ValueError):self.p.verify_message(wire(old),binding(),KEY,0,'0'*64)
    def test_envelope_rejects_tamper_role_replay_gap_and_oversize(self):
        good=wire();self.assertEqual(self.p.verify_message(good,binding(),KEY,0,'0'*64)['kind'],'STOP_APPLIED')
        for bad,previous in [(good.replace(b'APPLIED',b'FAILED',1),0),(wire(issuer='C'),0),(good,1),(wire(sequence='2'),0),(b'x'*8193,0),(b'{"x":1,"x":2}',0)]:
            with self.assertRaises(ValueError):self.p.verify_message(bad,binding(),KEY,previous,'0'*64)
        m=json.loads(wire());m['reason']='R'*(8192-len(good)+len(m['reason']));body={k:v for k,v in m.items() if k!='tag'}
        m['tag']=hmac.new(KEY,json.dumps(body,sort_keys=True,separators=(',',':')).encode(),hashlib.sha256).hexdigest()
        boundary=json.dumps(m,sort_keys=True,separators=(',',':')).encode();self.assertEqual(len(boundary),8192)
        self.assertEqual(self.p.verify_message(boundary,binding(),KEY,0,'0'*64)['result'],'APPLIED')
    def test_policy_does_not_satisfy_observed_prearm(self):
        self.assertTrue(self.p.admit_phase('QUIESCENT_BOOTSTRAP',decisions(),[],scope(),fixture_verify)['eligible'])
        self.assertFalse(self.p.admit_phase('PREARM_WORK_FAULT',decisions(),[],scope(),fixture_verify)['eligible'])
        self.assertTrue(self.p.admit_phase('PREARM_WORK_FAULT',decisions(POLICY+['G11_EXACT_FAULT_AUTHORITY']),observations(),scope(),fixture_verify)['eligible'])
    def test_decision_requires_pinned_verifier_scope_epoch_and_expiry(self):
        for patch in ({'approved':True,'signature':'FORGED'},{'build_digest':A},{'scope_digest':B},{'observer_epoch':'OLD'},{'expires_tick':'10'}):
            ds=decisions();ds[0].update(patch)
            self.assertFalse(self.p.admit_phase('PRECREATION',ds,[],scope(),fixture_verify)['eligible'])
        self.assertFalse(self.p.admit_phase('PRECREATION',decisions(),[],scope(),lambda _:True)['eligible'])
    def test_tick_floor_equality_and_one_tick_ambiguity(self):
        self.assertEqual(self.p.ns_to_ticks(3,1000000000),3)
        for ns,f in [(1,1),(True,1000000000),(2**64,1000000000)]:
            with self.assertRaises(ValueError):self.p.ns_to_ticks(ns,f)
        self.assertEqual(self.p.deadline_state(10,10,0),'EXPIRED')
        self.assertEqual(self.p.deadline_state(9,10,1),'AMBIGUOUS')
        self.assertEqual(self.p.deadline_state(8,10,1),'BEFORE')

class JournalTests(unittest.TestCase):
    def setUp(self):
        self.p=importlib.import_module('journal_protocol');self.assertTrue(hasattr(self.p,'Journal'),'Missing journal implementation')
        self.path=store_path(self._testMethodName)
        self.j=self.p.Journal(str(self.path),dict(sequence=0,chain_digest='0'*64,evidence_domain='ARTIFICIAL'))
    def tearDown(self):
        if hasattr(self,'j'):self.j.close()
    def test_prepare_commits_binding_before_arm(self):
        slot=self.j.prepare(binding(),50)
        with sqlite3.connect('file:'+self.path.as_posix()+'?mode=ro',uri=True) as reader:
            row=reader.execute('SELECT binding,status FROM reservations').fetchone()
        self.assertEqual(json.loads(row[0]),binding());self.assertEqual(row[1],'RESERVED_CONSUMED')
        self.assertEqual(slot['status'],'ARMED_UNUSED');self.assertTrue(self.j.verify_slot(slot))
        slot['deadline_tick']=999;self.assertFalse(self.j.verify_slot(slot))
    def test_duplicate_or_uncertain_prepare_never_reopens(self):
        self.j.prepare(binding(),50)
        with self.assertRaises(ValueError):self.j.prepare(binding(),50)
        self.assertTrue(self.j.quarantined)
        with self.assertRaises(ValueError):self.j.prepare(binding(),60)
    def test_stale_high_watermark_recovery_blocks_dispatch(self):
        self.j.prepare(binding(),50)
        self.assertEqual(self.j.recover(dict(sequence=0,chain_digest='0'*64,evidence_domain='ARTIFICIAL'))['disposition'],'QUARANTINE')
        fresh=binding();fresh['lease_id']='NEW'
        with self.assertRaises(ValueError):self.j.prepare(fresh,50)
    def test_postattempt_persistence_failure_cannot_resignal(self):
        self.j.prepare(binding(),50);self.j.connection.close()
        with self.assertRaises(ValueError):self.j.record_after_attempt(dict(binding=binding(),slot_id='x',attempt_tick=40,delivery_status='UNKNOWN'))
        self.assertTrue(self.j.quarantined)
        with self.assertRaises(ValueError):self.j.prepare(binding(),50)
    def test_readers_observe_complete_committed_records(self):
        self.j.prepare(binding(),50)
        with sqlite3.connect('file:'+self.path.as_posix()+'?mode=ro',uri=True) as reader:
            self.assertEqual(reader.execute('SELECT count(*) FROM reservations WHERE slot IS NOT NULL AND binding IS NOT NULL').fetchone()[0],1)
        with self.assertRaises(ValueError):self.p.Journal(str(self.path),dict(sequence=0,chain_digest='0'*64,evidence_domain='ARTIFICIAL'))

class Clock:
    frequency_hz=1000000000;domain='ART_QPC'
    def __init__(self,tick=10):self.tick=tick
    def now_tick(self):return self.tick
class NativeModel:
    evidence_domain='ARTIFICIAL'
    def __init__(self):self.actions=[];self.io_status='PENDING';self.exited=False;self.fail_create=False
    def create_process(self,role,spec):
        self.actions.append(('create',role,copy.deepcopy(spec)))
        if self.fail_create:raise ValueError('ART_CREATE_FAILURE')
        return dict(token='ART_'+role+str(len(self.actions)),binding=copy.deepcopy(spec['binding']),rights=['QUERY','SYNCHRONIZE'],creator_handles_closed=True,primary_thread_closed=True,creation_captured=True)
    def signal(self,token):self.actions.append(('signal',token));return 'ATTEMPTED'
    def exit_status(self,token):return dict(signaled=self.exited,exit_code=0 if self.exited else None)
    def start_io(self,token,wire):self.actions.append(('io',token,wire));return 'ART_IO1'
    def cancel(self,op):self.actions.append(('cancel',op));return 'CANCEL_REQUESTED'
    def completion(self,op):return dict(status=self.io_status,wire=b'ART')
    def close(self,token):self.actions.append(('close',token))
    def terminate(self,token):self.actions.append(('terminate',token));return 'REQUESTED'
    def termination_handle(self,token,binding):
        self.actions.append(('grant_terminate',token));return dict(token='ART_TERM_'+token,binding=copy.deepcopy(binding),rights=['TERMINATE'])
def bridge_fixture(case='AC17',role='S'):
    w=importlib.import_module('win32_bridge');n=NativeModel();c=Clock()
    ds=decisions(POLICY+['G11_EXACT_FAULT_AUTHORITY'])
    return w.Bridge(native=n,expected_scope=scope(),decisions=ds,observations=observations(),clock=c,owner_role=role,case_id=case),n,c
def launch_spec(b=None):
    return dict(binding=b or binding(),application='C:/ART_ONLY/python.exe',environment={'SYSTEMROOT':'C:/ART_ONLY'},inherited_handles=['ART_PRIVATE_BOOTSTRAP'],remote_clients=False,overlapped=True,acl_evidence=A,bootstrap_deadline_tick=30)
class BridgeTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue((HERE/'win32_bridge.py').exists(),'Missing bridge implementation');self.w=importlib.import_module('win32_bridge')
    def test_import_and_missing_admission_make_no_native_call(self):
        n=NativeModel();b=self.w.Bridge(native=n)
        with self.assertRaises(ValueError):b.bootstrap('W',launch_spec())
        self.assertEqual(n.actions,[])
        with self.assertRaises(ValueError):self.w.Bridge().bootstrap('W',launch_spec())
    def test_bootstrap_uses_exact_executable_environment_and_handle_allowlist(self):
        b,n,c=bridge_fixture();r=b.bootstrap('W',launch_spec());self.assertEqual(r['rights'],['QUERY','SYNCHRONIZE'])
        self.assertEqual(n.actions[0][2]['inherited_handles'],['ART_PRIVATE_BOOTSTRAP'])
        for patch in ({'application':'python'},{'environment':{'SECRET':'no'}},{'remote_clients':True},{'overlapped':False},{'inherited_handles':['DEFAULT']}):
            other,model,_=bridge_fixture();bad=launch_spec();bad.update(patch)
            with self.assertRaises(ValueError):other.bootstrap('W',bad)
            self.assertEqual(model.actions,[])
    def test_owned_token_checks_all_binding_fields_before_signal(self):
        b,n,c=bridge_fixture();token=b.bootstrap('W',launch_spec())['token']
        b.arm_cooperative(token,binding(),50)
        for key in binding():
            bad=binding();bad[key]='STALE'
            with self.assertRaises(ValueError):b.signal_cooperative(token,bad)
        self.assertFalse(any(a[0]=='signal' for a in n.actions))
        r=b.signal_cooperative(token,binding());self.assertEqual(r['delivery_status'],'ATTEMPTED')
        with self.assertRaises(ValueError):b.signal_cooperative(token,binding())
        self.assertEqual(sum(a[0]=='signal' for a in n.actions),1)
    def test_cancel_request_retains_buffer_until_observed_completion(self):
        b,n,c=bridge_fixture();token=b.bootstrap('W',launch_spec())['token']
        result=b.write_frame(token,b'ART',40);self.assertEqual(result['status'],'PENDING')
        b.cancel_io(result['operation_id'])
        with self.assertRaises(ValueError):b.close_completed(token)
        self.assertEqual(b.pending_count,1)
        n.io_status='CANCELLED'
        with self.assertRaises(ValueError):b.close_completed(token)
        n.exited=True;b.poll_exit(token,60)
        self.assertEqual(b.close_completed(token)['disposition'],'CLOSED');self.assertEqual(b.pending_count,0)
    def test_fallback_requires_both_grants_and_same_handle_exit(self):
        b,n,c=bridge_fixture('AC21');token=b.bootstrap('W',launch_spec())['token']
        grant=fallback_grant()
        with self.assertRaises(ValueError):b.terminate_exact(token,grant)
        self.assertFalse(any(a[0]=='terminate' for a in n.actions))
        b.refresh_authority(fallback_decisions(grant),observations())
        with self.assertRaises(ValueError):b.terminate_exact(token,grant)
        b.arm_cooperative(token,binding(),50);b.signal_cooperative(token,binding())
        b.record_cooperative_outcome(token,dict(binding=binding(),slot_id=applied_event()['slot_id'],status='UNKNOWN',tick=10,evidence_ref='ART_VERIFIED'))
        self.assertEqual(b.terminate_exact(token,grant)['delivery_status'],'REQUESTED')
        self.assertFalse(b.poll_exit(token,80)['signaled'])
        with self.assertRaises(ValueError):b.terminate_exact(token,grant)
        n.exited=True;self.assertTrue(b.poll_exit(token,80)['same_handle'])

def supervisor_fixture(name):
    p=importlib.import_module('journal_protocol');s=importlib.import_module('supervisor')
    b,n,c=bridge_fixture();token=b.bootstrap('W',launch_spec())['token']
    j=p.Journal(str(store_path(name)),dict(sequence=0,chain_digest='0'*64,evidence_domain='ARTIFICIAL'))
    sup=s.Supervisor(binding(),b,c,j);return sup,b,n,c,j,token
def controller_observation(alive=True):
    return dict(binding=binding(),alive=alive,heartbeat_tick=10,heartbeat_loss_tick=40,evidence_ref='ART_VERIFIED')
class SupervisorTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue((HERE/'supervisor.py').exists(),'Missing supervisor implementation')
        self.s,self.b,self.n,self.c,self.j,self.token=supervisor_fixture(self._testMethodName)
    def tearDown(self):
        if hasattr(self,'j'):self.j.close()
    def arm(self):
        self.slot=self.j.prepare(binding(),50)
        return self.s.arm(self.slot,dict(stage='PREARM_WORK_FAULT',eligible=True))
    def test_dispatch_denied_until_committed_prearm(self):
        self.assertFalse(self.s.dispatch_allowed)
        fake=dict(binding=binding(),deadline_tick=50,reservation_digest=A,slot_id=A,status='ARMED_UNUSED')
        with self.assertRaises(ValueError):self.s.arm(fake,dict(stage='PREARM_WORK_FAULT',eligible=True))
        self.arm();self.assertTrue(self.s.dispatch_allowed)
    def test_due_stop_survives_blocked_controller_queue_and_journal(self):
        self.arm();self.j.connection.close();self.c.tick=50
        result=self.s.step(50,controller_observation(),None)
        self.assertEqual(result['kind'],'CONTROL_ATTEMPT');self.assertEqual(sum(a[0]=='signal' for a in self.n.actions),1)
        self.assertEqual(result['slot_id'],self.slot['slot_id']);self.assertFalse(result['application_proven'])
    def test_deadline_and_controller_loss_consume_once(self):
        self.arm();self.c.tick=50
        first=self.s.step(50,controller_observation(False),None);second=self.s.step(50,controller_observation(False),None)
        self.assertEqual(first['kind'],'CONTROL_ATTEMPT');self.assertEqual(second['kind'],'ALREADY_CONSUMED')
        self.assertEqual(sum(a[0]=='signal' for a in self.n.actions),1)
    def test_supervisor_loss_never_causes_resend(self):
        self.arm();self.s.quarantine('SUPERVISOR_LOST');self.c.tick=50
        self.assertEqual(self.s.step(50,controller_observation(),None)['kind'],'QUARANTINED')
        self.assertFalse(any(a[0]=='signal' for a in self.n.actions))
    def test_postaction_unknown_stays_consumed_and_holds_evidence(self):
        self.arm();self.c.tick=50;self.s.step(50,controller_observation(),None);self.j.connection.close()
        self.assertEqual(self.s.flush_receipt()['disposition'],'HOLD')
        self.assertEqual(self.s.step(50,controller_observation(),None)['kind'],'ALREADY_CONSUMED')
        self.assertEqual(sum(a[0]=='signal' for a in self.n.actions),1)

def actor_state(b=None):
    return dict(binding=b or binding(),sequence=0,previous_digest='0'*64,phase='READY',terminal=None,self_ceiling_tick=70,verify_control=fixture_observe)
def applied_event(b=None):
    return dict(binding=b or binding(),slot_id=hashlib.sha256(json.dumps(b or binding(),sort_keys=True,separators=(',',':')).encode()).hexdigest(),event_observed=True,evidence_ref='ART_VERIFIED')
def next_binding():
    b=binding();b.update(worker_epoch='ART_W2',command_id='ART_CMD2',pid='102',creation_time_100ns='1002',reservation_id='ART_R2',lease_id='ART_L2');return b
class ActorTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue((HERE/'actors.py').exists(),'Missing actor implementation');self.a=importlib.import_module('actors')
    def test_blocked_work_does_not_block_receiver_transition(self):
        state=actor_state();result=self.a.worker_step(state,applied_event(),True,20)
        self.assertEqual(result['terminal'],'STOP_APPLIED');self.assertIsNone(state['terminal'])
    def test_stop_applied_requires_current_exact_event_and_lease(self):
        for change in ({'event_observed':False},{'evidence_ref':'UNVERIFIED'},{'binding':next_binding()},{'slot_id':A}):
            event=applied_event();event.update(change)
            with self.assertRaises(ValueError):self.a.worker_step(actor_state(),event,True,20)
    def test_self_ceiling_exit_does_not_claim_supervisor_application(self):
        result=self.a.worker_step(actor_state(),None,True,70)
        self.assertEqual(result['terminal'],'SELF_CEILING');self.assertNotEqual(result['terminal'],'STOP_APPLIED')
    def test_second_controller_is_fresh_not_resumed(self):
        exited=self.a.controller_step(actor_state(),dict(kind='SELF_EXIT'),20)
        fresh=self.a.controller_step(exited,dict(kind='REPLACE',new_binding=next_binding(),genesis_digest=B),21)
        self.assertEqual(fresh['sequence'],0);self.assertEqual(fresh['phase'],'READY');self.assertEqual(fresh['binding']['lease_id'],'ART_L2')
        with self.assertRaises(ValueError):self.a.controller_step(actor_state(),dict(kind='REPLACE',new_binding=next_binding(),genesis_digest=B),21)
    def test_worker_replacement_preserves_old_generation_and_rejects_stale_records(self):
        old=actor_state();new=actor_state(next_binding())
        with self.assertRaises(ValueError):self.a.worker_step(new,applied_event(old['binding']),True,20)
        self.assertEqual(old['binding']['lease_id'],'ART_L1');self.assertEqual(new['binding']['lease_id'],'ART_L2')

def resources():
    digest=hashlib.sha256(json.dumps(binding(),sort_keys=True,separators=(',',':')).encode()).hexdigest()
    return [dict(resource_id='ART_'+role,kind='PROCESS',owner_role=role,generation='ART_GEN',binding_digest=digest,operation_id=None,rights=['QUERY','SYNCHRONIZE'],state='LIVE',deadline_tick=80,disposition='EXPECTED') for role in ('W','O','S','C')]
def closed_resources():
    result=resources()
    for row in result:row.update(state='CLOSED',disposition='CLOSED')
    return result
def observer_exit():
    before=closed_resources();before[1].update(state='PENDING_L_EXIT',disposition='PENDING_L')
    inventory=dict(issuer='O',tick=30,inventory_digest=hashlib.sha256(json.dumps(resources(),sort_keys=True,separators=(',',':')).encode()).hexdigest(),observed_digest=hashlib.sha256(json.dumps(before,sort_keys=True,separators=(',',':')).encode()).hexdigest(),evidence_ref='ART_VERIFIED',signature='ART_ONLY')
    return dict(issuer='L',resource_id='ART_O',binding_digest=resources()[1]['binding_digest'],same_handle=True,signaled=True,observed_tick=36,evidence_ref='ART_VERIFIED',evidence_domain='ARTIFICIAL',signature='ART_ONLY',final_inventory=inventory)
def verify_l_record(row):return row.get('issuer')=='L' and row.get('signature')=='ART_ONLY' and row.get('evidence_ref')=='ART_VERIFIED'
def verify_inventory(row):return row.get('issuer')=='O' and row.get('signature')=='ART_ONLY' and row.get('evidence_ref')=='ART_VERIFIED'
def assessment_scope():
    result=scope();result.update(now_tick=70,evidence_deadline_tick=60,cleanup_deadline_tick=80,verify_evidence=fixture_verify,expected_resources=resources(),inventory_digest=hashlib.sha256(json.dumps(resources(),sort_keys=True,separators=(',',':')).encode()).hexdigest(),verify_l_observation=verify_l_record,verify_inventory=verify_inventory);return result
def case_evidence():
    values=[('reservation','S',dict(committed=True,slot_id=applied_event()['slot_id'])),('control_attempt','S',dict(kind='CONTROL_ATTEMPT',delivery_status='ATTEMPTED',slot_id=applied_event()['slot_id'])),('worker_application','W',dict(kind='STOP_APPLIED',event_observed=True,slot_id=applied_event()['slot_id'])),('original_exit','O',dict(same_handle=True,signaled=True,resource_id='ART_W')),('cleanup','L',dict(observed_resources=closed_resources(),observer_exit=observer_exit())),('integrity','L',dict(chain_valid=True,source_pins_match=True))]
    return [dict(dimension=dimension,issuer=issuer,binding=binding(),tick=(10,14,18,22,40,44)[i],evidence_domain='ARTIFICIAL',value=value,signature='ART_ONLY') for i,(dimension,issuer,value) in enumerate(values)]
class ObserverTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue((HERE/'observer.py').exists(),'Missing observer implementation');self.o=importlib.import_module('observer')
    def assess(self,ev):return self.o.assess_case('AC17',ev,resources(),assessment_scope())
    def test_signal_ack_or_natural_exit_cannot_prove_application(self):
        result=self.assess([e for e in case_evidence() if e['dimension']!='worker_application'])
        self.assertFalse(result['dimensions']['worker_application']);self.assertEqual(result['disposition'],'HOLD')
        good=self.assess(case_evidence());self.assertEqual(good['disposition'],'ARTIFICIAL_MODEL_PASS');self.assertFalse(good['scientific_acceptance'])
    def test_wrong_handle_or_replacement_exit_cannot_close_original(self):
        ev=case_evidence();ev[3]['value']['resource_id']='ART_REPLACEMENT'
        self.assertFalse(self.assess(ev)['dimensions']['original_exit'])
        ev=case_evidence();ev[3]['binding']=next_binding();self.assertEqual(self.assess(ev)['disposition'],'HOLD')
    def test_pending_io_or_missing_resource_stays_hold_without_kill(self):
        observed=closed_resources();observed[0]['state']='PENDING'
        self.assertEqual(self.o.assess_cleanup(resources(),observed,observer_exit())['disposition'],'HOLD')
        self.assertEqual(self.o.assess_cleanup(resources(),closed_resources()[:1],observer_exit())['disposition'],'HOLD')
    def test_observer_cannot_self_attest_final_exit(self):
        receipt=observer_exit();receipt['issuer']='O'
        self.assertEqual(self.o.assess_cleanup(resources(),closed_resources(),receipt)['disposition'],'HOLD')
        self.assertEqual(self.o.assess_cleanup(resources(),closed_resources(),None)['disposition'],'HOLD')
    def test_late_ambiguous_or_artificial_evidence_cannot_pass_real_case(self):
        for patch in ({'tick':59},{'signature':'FORGED'},{'evidence_domain':'REAL'}):
            ev=case_evidence();ev[2].update(patch);self.assertEqual(self.assess(ev)['disposition'],'HOLD')
        self.assertNotEqual(self.assess(case_evidence())['disposition'],'PASS_WITH_VERIFIED_EVIDENCE')

def launch_plan_fixture(case='AC17',with_observations=True):
    module=importlib.import_module('launch_stage_b');sc=scope();sc['actor_specs']={r:launch_spec() for r in ('O','S','C','W')}
    ds=decisions(POLICY+['G11_EXACT_FAULT_AUTHORITY']);plan=module.plan_launch(case,ds,sc,fixture_verify)
    w=importlib.import_module('win32_bridge');n=NativeModel();c=Clock()
    b=w.Bridge(native=n,expected_scope=sc,decisions=ds,observations=observations() if with_observations else [],clock=c,owner_role='L',case_id=case)
    return module,plan,b,n,c
class LaunchTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue((HERE/'launch_stage_b.py').exists(),'Missing launcher implementation');self.l=importlib.import_module('launch_stage_b')
    def test_default_entry_denies_before_any_native_call(self):
        self.assertEqual(self.l.main([]),2);self.assertEqual(self.l.main(['--run']),2)
        plan=self.l.plan_launch('AC17',[],scope(),fixture_verify);self.assertFalse(plan['eligible'])
    def test_quiescent_bootstrap_cannot_dispatch_fault_or_control(self):
        m,p,b,n,c=launch_plan_fixture(with_observations=False)
        result=m.run_authorized_case(p,b,c)
        self.assertEqual([a[1] for a in n.actions],['O','S','C','W']);self.assertFalse(result['work_dispatched'])
        self.assertFalse(any(a[0] in ('signal','terminate') for a in n.actions));self.assertEqual(result['status'],'ARTIFICIAL_BOOTSTRAP_ONLY')
    def test_bootstrap_failure_consumes_allowance_without_replacement_or_kill(self):
        m,p,b,n,c=launch_plan_fixture();n.fail_create=True
        first=m.run_authorized_case(p,b,c);second=m.run_authorized_case(p,b,c)
        self.assertEqual(first['status'],'HOLD_PRESERVED');self.assertEqual(second['status'],'HOLD_PRESERVED')
        self.assertEqual(len(n.actions),1);self.assertEqual(n.actions[0][0],'create')
    def test_total_and_concurrent_caps_and_no_resume_enforced(self):
        m,p,b,n,c=launch_plan_fixture();result=m.run_authorized_case(p,b,c)
        self.assertEqual(len(result['created']),4)
        again=m.run_authorized_case(p,b,c);self.assertEqual(again['status'],'HOLD_PRESERVED');self.assertEqual(len(n.actions),4)
        with self.assertRaises(ValueError):b.bootstrap('O',launch_spec())
    def test_untrusted_provider_or_changed_build_revokes_admission(self):
        m,p,b,n,c=launch_plan_fixture();p['build_digest']=A
        self.assertEqual(m.run_authorized_case(p,b,c)['status'],'HOLD_PRESERVED');self.assertEqual(n.actions,[])
        m,p,b,n,c=launch_plan_fixture();n.evidence_domain='REAL'
        self.assertEqual(m.run_authorized_case(p,b,c)['status'],'HOLD_PRESERVED');self.assertEqual(n.actions,[])

class IntegrationTests(unittest.TestCase):
    def history(self,name):
        sup,b,n,c,j,token=supervisor_fixture(name)
        self.addCleanup(j.close);slot=j.prepare(binding(),50);sup.arm(slot,dict(stage='PREARM_WORK_FAULT'))
        c.tick=40;attempt=sup.step(40,controller_observation(False),None)
        actors=importlib.import_module('actors');worker=actors.worker_step(actor_state(),applied_event(),True,42)
        n.exited=worker['phase']=='EXITED';c.tick=44;exit_receipt=b.poll_exit(token,60)
        ev=case_evidence();ev[0]['tick']=15;ev[0]['value']['committed']=j.verify_slot(slot)
        ev[1]['tick']=40;ev[1]['value'].update(kind=attempt['kind'],delivery_status=attempt['delivery_status'],slot_id=attempt['slot_id'])
        ev[2]['tick']=42;ev[2]['value']['kind']=worker['terminal'];ev[3]['tick']=44
        ev[3]['value'].update(same_handle=exit_receipt['same_handle'],signaled=exit_receipt['signaled'])
        ev[4]['value']['observer_exit']['final_inventory']['tick']=48;ev[4]['value']['observer_exit']['observed_tick']=52
        ev[4]['tick']=56;ev[5]['tick']=58
        return sup,b,n,c,j,ev
    def test_ac17_ac18_independence_and_fresh_client_model(self):
        sup,b,n,c,j,ev=self.history(self._testMethodName)
        observer=importlib.import_module('observer');self.assertEqual(observer.assess_case('AC17',ev,resources(),assessment_scope())['disposition'],'ARTIFICIAL_MODEL_PASS')
        actors=importlib.import_module('actors');old=actors.controller_step(actor_state(),dict(kind='SELF_EXIT'),20)
        new=actors.controller_step(old,dict(kind='REPLACE',new_binding=next_binding(),genesis_digest=B),21)
        self.assertEqual(new['sequence'],0);self.assertEqual(sum(a[0]=='signal' for a in n.actions),1)
    def test_ac19_retained_handle_variant_forces_full_case_hold(self):
        sup,b,n,c,j,ev=self.history(self._testMethodName)
        observer=importlib.import_module('observer');result=observer.assess_case('AC19',ev,resources(),assessment_scope())
        self.assertEqual(result['disposition'],'HOLD');self.assertIn('PID_REUSE_UNAVAILABLE_RETAINED_HANDLE_FULL_AC19_HOLD',result['blockers'])
        with self.assertRaises(ValueError):importlib.import_module('actors').worker_step(actor_state(next_binding()),applied_event(),True,43)
    def test_ac20_transport_uncertainty_never_duplicates_control(self):
        sup,b,n,c,j,ev=self.history(self._testMethodName)
        self.assertFalse(sup.dispatch_allowed)
        self.assertEqual(sup.step(44,controller_observation(False),None)['kind'],'ALREADY_CONSUMED')
        ev[2]['signature']='LOST_OR_FORGED'
        self.assertEqual(importlib.import_module('observer').assess_case('AC20',ev,resources(),assessment_scope())['disposition'],'HOLD')
        self.assertEqual(sum(a[0]=='signal' for a in n.actions),1)
    def test_ac21_disabled_and_exact_grant_branch_remains_conditional(self):
        b,n,c=bridge_fixture('AC21');token=b.bootstrap('W',launch_spec())['token']
        with self.assertRaises(ValueError):b.terminate_exact(token,dict(binding=binding()))
        self.assertEqual(sum(a[0]=='terminate' for a in n.actions),0)
        self.assertEqual(importlib.import_module('observer').assess_case('AC21',case_evidence(),resources(),assessment_scope())['disposition'],'HOLD')
    def test_ac22_full_inventory_and_launcher_exit_evidence_required(self):
        sup,b,n,c,j,ev=self.history(self._testMethodName)
        observer=importlib.import_module('observer');self.assertEqual(observer.assess_case('AC22',ev,resources(),assessment_scope())['disposition'],'ARTIFICIAL_MODEL_PASS')
        ev[4]['value']['observer_exit']['issuer']='O'
        result=observer.assess_case('AC22',ev,resources(),assessment_scope());self.assertEqual(result['disposition'],'HOLD');self.assertFalse(result['scientific_acceptance'])

def fallback_grant():return dict(binding=binding(),slot_id=hashlib.sha256(json.dumps(dict(binding=binding(),purpose='FALLBACK'),sort_keys=True,separators=(',',':')).encode()).hexdigest(),profile_revision=A,scope_digest=A,expires_tick='80',cleanup_deadline_tick=80,signature='ART_ONLY')
def fallback_decisions(grant):
    rows=decisions(POLICY+['G11_EXACT_FAULT_AUTHORITY','G13_PROFILE_REVISION','G14_EXACT_TARGET_TERMINATION_GRANT'])
    rows[-1]['evidence_digest']=hashlib.sha256(json.dumps({k:v for k,v in grant.items() if k!='signature'},sort_keys=True,separators=(',',':')).encode()).hexdigest();return rows
class CorrectionTests(unittest.TestCase):
    def test_i1_due_deadline_ignores_unavailable_controller_and_verifiers(self):
        for index,observation in enumerate((None,{},dict(alive='bad'))):
            sup,b,n,c,j,token=supervisor_fixture(self._testMethodName+str(index));self.addCleanup(j.close)
            slot=j.prepare(binding(),50);sup.arm(slot,dict(stage='PREARM_WORK_FAULT'))
            def unavailable(*args):raise AssertionError('Verifier reached on due path')
            b._scope['verify_decision']=unavailable;b._scope['verify_observation']=unavailable;c.tick=50
            result=sup.step(50,observation,dict(kind='INVALID'))
            self.assertEqual(result['delivery_status'],'ATTEMPTED');self.assertEqual(sum(a[0]=='signal' for a in n.actions),1)
        sup,b,n,c,j,token=supervisor_fixture(self._testMethodName+'expired');self.addCleanup(j.close)
        sup.arm(j.prepare(binding(),50),dict(stage='PREARM_WORK_FAULT'));c.tick=100
        self.assertEqual(sup.step(100,None,None)['delivery_status'],'UNKNOWN');self.assertFalse(any(a[0]=='signal' for a in n.actions))
    def test_i2_live_and_retained_process_handles_cannot_close_early(self):
        b,n,c=bridge_fixture('AC19');token=b.bootstrap('W',launch_spec())['token']
        op=b.write_frame(token,b'ART',40)['operation_id'];b.cancel_io(op);n.io_status='CANCELLED'
        with self.assertRaises(ValueError):b.close_completed(token)
        self.assertFalse(any(a[0]=='close' for a in n.actions))
        n.exited=True;b.poll_exit(token,60)
        with self.assertRaises(ValueError):b.close_completed(token)
        self.assertIn('CANCELLED',[r['status'] for r in b.io_outcomes])
    def test_i3_one_tick_and_future_nested_cleanup_never_pass(self):
        o=importlib.import_module('observer');ev=case_evidence()
        for i in range(4):ev[i]['tick']=20+i
        self.assertEqual(o.assess_case('AC17',ev,resources(),assessment_scope())['disposition'],'HOLD')
        ev=case_evidence();ev[4]['value']['observer_exit']['observed_tick']=79
        self.assertEqual(o.assess_case('AC17',ev,resources(),assessment_scope())['disposition'],'HOLD')
    def test_i4_pinned_inventory_process_types_and_independent_l_proof(self):
        o=importlib.import_module('observer');sc=assessment_scope();ev=case_evidence()
        self.assertEqual(o.assess_case('AC22',ev,resources()[:1],sc)['disposition'],'HOLD')
        for field,value in [('kind','PIPE'),('rights',True),('binding_digest','bad'),('deadline_tick',True),('generation','')]:
            rs=resources();rs[0][field]=value;bad=copy.deepcopy(sc);bad['expected_resources']=rs
            self.assertEqual(o.assess_case('AC22',ev,rs,bad)['disposition'],'HOLD')
        ev=case_evidence();ev[4]['value']['observer_exit']['evidence_ref']='FORGED'
        self.assertEqual(o.assess_case('AC22',ev,resources(),sc)['disposition'],'HOLD')
    def test_i5_exact_specs_deadlines_clock_and_actor_ceilings(self):
        for patch in ({'application':'C:/OTHER/python.exe'},{'environment':{'SYSTEMROOT':'C:/OTHER'}},{'acl_evidence':B},{'bootstrap_deadline_tick':999}):
            b,n,c=bridge_fixture();sp=launch_spec();sp.update(patch)
            with self.assertRaises(ValueError):b.bootstrap('W',sp)
            self.assertEqual(n.actions,[])
        b,n,c=bridge_fixture();token=b.bootstrap('W',launch_spec())['token']
        with self.assertRaises(ValueError):b.write_frame(token,b'ART',999)
        with self.assertRaises(ValueError):b.poll_exit(token,999)
        c.tick=9
        with self.assertRaises(ValueError):b.capture_identity(token)
        c.tick=10
        with self.assertRaises(ValueError):b.capture_identity(token)
        actors=importlib.import_module('actors')
        self.assertEqual(actors.worker_step(actor_state(),applied_event(),True,70)['terminal'],'SELF_CEILING')
        self.assertEqual(actors.controller_step(actor_state(),dict(kind='WORK'),70)['terminal'],'SELF_CEILING')
    def test_i6_fallback_requires_cooperative_uncertainty_and_owner(self):
        b,n,c=bridge_fixture('AC21');token=b.bootstrap('W',launch_spec())['token']
        grant=fallback_grant();b.refresh_authority(fallback_decisions(grant),observations())
        with self.assertRaises(ValueError):b.terminate_exact(token,grant)
        self.assertFalse(any(a[0] in ('terminate','grant_terminate') for a in n.actions))
        b.arm_cooperative(token,binding(),50);b.signal_cooperative(token,binding())
        outcome=dict(binding=binding(),slot_id=applied_event()['slot_id'],status='UNKNOWN',tick=9,evidence_ref='ART_VERIFIED')
        with self.assertRaises(ValueError):b.record_cooperative_outcome(token,outcome)
        outcome['tick']=10;b.record_cooperative_outcome(token,outcome);b._owner='O'
        with self.assertRaises(ValueError):b.terminate_exact(token,grant)
        b._owner='S';bad=copy.deepcopy(grant);bad['slot_id']=A
        with self.assertRaises(ValueError):b.terminate_exact(token,bad)
        self.assertFalse(any(a[0] in ('terminate','grant_terminate') for a in n.actions))
    def test_i7_unreserved_or_malformed_receipts_never_record(self):
        p=importlib.import_module('journal_protocol')
        for index,patch in enumerate(({'slot_id':A},{'binding':next_binding()},{'attempt_tick':True},{'delivery_status':'OK'},{'extra':1},{'kind':None})):
            path=store_path(self._testMethodName+str(index))
            j=p.Journal(str(path),dict(sequence=0,chain_digest='0'*64,evidence_domain='ARTIFICIAL'));self.addCleanup(j.close);slot=j.prepare(binding(),50)
            receipt=dict(binding=binding(),slot_id=slot['slot_id'],attempt_tick=40,delivery_status='ATTEMPTED',kind='CONTROL_ATTEMPT',application_proven=False,evidence_domain='ARTIFICIAL');receipt.update(patch)
            with self.assertRaises(ValueError):j.record_after_attempt(receipt)
            self.assertEqual(j.connection.execute('SELECT count(*) FROM attempts').fetchone()[0],0)

if __name__=='__main__':unittest.main(verbosity=2)
