"""Actual V2 implementation; only its external Windows API boundary is artificial."""
import copy
import ctypes as c
import hashlib
import importlib
import json
import unittest
from test_stage_b import binding as old_binding,A,B,store_path,POLICY
from journal_protocol import sha,canonical
from test_native_backend import FakeAPI

class IdentityAPI(FakeAPI):
    def __init__(self):
        super().__init__();self.created_roles={};self.pipe_peers={};self.io_status=0;self.fail_role=None
    def CreateProcessW(self,app,cmd,ps,ts,inherit,flags,env,cwd,start,info):
        role=bytes(cmd).decode('utf-16-le').rstrip('\0').rsplit('-',1)[-1]
        self.calls.append(('CREATE_V2',role,inherit,flags))
        if self.fail=='create' or role==self.fail_role:return 0
        process,thread=self.handle(),self.handle()
        pid=700+len(self.created_roles)*17;created=2000+pid
        self.info[process]=(pid,created);self.created_roles[role]=pid
        info._obj.hProcess=process;info._obj.hThread=thread;info._obj.dwProcessId=pid
        return 1
    def CreateNamedPipeW(self,name,*args):
        handle=super().CreateNamedPipeW(name,*args)
        role=bytes(name).decode('utf-16-le').rstrip('\0').rsplit('_',1)[-1]
        self.pipe_peers[handle]=self.created_roles[role]
        return handle
    def GetNamedPipeClientProcessId(self,h,out):out._obj.value=self.pipe_peers[h];return 1

class Clock:
    domain='ART_QPC';frequency_hz=1000000000
    def __init__(self):self.tick=10
    def now_tick(self):return self.tick

def run_context():
    return dict(origin='B_DISPOSABLE',contract_digest=A,build_digest=B,host_id='ART_HOST',boot_id='ART_BOOT',observer_epoch='ART_EPOCH',
                session_id='ART_SESSION',owner_nonce='ART_OWNER',scope_id='ART_SCOPE',clock_domain='ART_QPC',qpc_frequency_hz='1000000000',run_id='ART_V2_RUN')

def credentials():
    return {role:dict(credential_id='ART_KEY_'+role,key=bytes([i])*32) for i,role in enumerate(('OWNER','L','O','S','C','W'),65)}

def signed(authority,domain,body,role='OWNER'):
    return authority.sign(domain,dict(body,issuer=role,credential_id='ART_KEY_'+role),role)

def fixture(m,run=None):
    clock=Clock();run=run_context() if run is None else run;auth=m.Authority(run,credentials(),clock)
    caps={r:dict(run_digest=sha(run),role=r,handle=41+i) for i,r in enumerate(('O','S','C','W'))}
    launcher=dict(run_digest=sha(run),role='L',actor_epoch='ART_L_EPOCH',generation='1',parent_role='EXTERNAL_OPERATOR',parent_actor_digest=A,
                  pid='600',creation_time_100ns='1600',image_pin_digest=A,credential_id='ART_KEY_L')
    anchor=signed(auth,'EXTERNAL_ANCHOR',dict(run_digest=sha(run),actor_digest=sha(launcher),external_anchor_digest=A,issued_tick=10,expires_tick=30))
    intents={r:dict(run_digest=sha(run),role=r,parent_role={'O':'L','S':'O','C':'O','W':'S'}[r],actor_epoch='ART_'+r+'_EPOCH',generation='1',
         application='C:/ART_ONLY/python.exe',command_line='"C:/ART_ONLY/python.exe" fixed-'+r,image_pin_digest=A,environment={'SYSTEMROOT':'C:/ART_ONLY'},
         credential_id='ART_KEY_'+r,bootstrap_capability_digest=sha(caps[r])) for r in ('O','S','C','W')}
    manifest=dict(run_context=run,external_launcher=dict(identity=launcher,anchor_proof=anchor),actor_intents=intents,
                  budgets=dict(bootstrap_deadline_tick=30,ipc_deadline_tick=60,control_deadline_tick=60,cleanup_deadline_tick=80))
    return clock,auth,manifest,caps


class ContractTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(importlib.util.find_spec('identity_contract'),'Missing approved V2 identity contract')
        self.m=importlib.import_module('identity_contract')
    def test_t01_exact_run_no_pid_bool_or_noncanonical_frequency(self):
        self.assertEqual(self.m.validate_run(run_context())['run_id'],'ART_V2_RUN')
        for change in ({'pid':'1'},{'qpc_frequency_hz':True},{'qpc_frequency_hz':'01'},{'origin':'LIVE'},{'build_digest':'x'*64}):
            bad=run_context();bad.update(change);self.assertRaises(ValueError,self.m.validate_run,bad)
    def test_t02_exact_actor_manifest_and_target_schemas(self):
        clock,auth,manifest,caps=fixture(self.m)
        self.assertEqual(self.m.validate_manifest(manifest)['actor_intents']['W']['parent_role'],'S')
        for mutate in (lambda x:x['actor_intents']['W'].update(pid='999'),lambda x:x['budgets'].update(ipc_deadline_tick=True),
                       lambda x:x['actor_intents']['C'].update(parent_role='L'),lambda x:x['actor_intents']['W'].update(generation='2')):
            bad=copy.deepcopy(manifest);mutate(bad);self.assertRaises(ValueError,self.m.validate_manifest,bad)
    def test_t17_projection_all_eighteen_fields_and_conflicts(self):
        run=run_context();actor=dict(run_digest=sha(run),role='W',actor_epoch='ART_W_EPOCH',generation='1',parent_role='S',parent_actor_digest=B,
             pid='901',creation_time_100ns='1901',image_pin_digest=A,credential_id='ART_KEY_W')
        target=dict(run_digest=sha(run),worker_actor_digest=sha(actor),worker_epoch='ART_W2',command_id='ART_CMD2',reservation_id='ART_R2',lease_id='ART_L2')
        expected=dict(old_binding(),pid='901',creation_time_100ns='1901',worker_epoch='ART_W2',command_id='ART_CMD2',reservation_id='ART_R2',lease_id='ART_L2')
        self.assertEqual(self.m.project_target(run,actor,target),expected)
        for field in expected:
            bad=copy.deepcopy(expected);bad[field]='WRONG';self.assertRaises(ValueError,self.m.project_target,run,actor,target,bad)
        wrong=copy.deepcopy(target);wrong['worker_actor_digest']=A
        self.assertRaises(ValueError,self.m.project_target,run,actor,wrong)


class CaptureTests(unittest.TestCase):
    def setUp(self):
        self.m=importlib.import_module('identity_contract')
        self.assertIsNotNone(importlib.util.find_spec('identity_bootstrap'),'Missing split-capture identity backend')
        self.b=importlib.import_module('identity_bootstrap')
        self.clock,self.auth,self.manifest,self.caps=fixture(self.m);self.api=IdentityAPI()
        self.backend=self.b.SplitBackend(self.api,self.manifest,self.caps,self.clock)
    def test_t03_dynamic_capture_without_predicted_pid(self):
        captured=self.backend.capture('O')
        self.assertEqual(captured['identity']['pid'],'700');self.assertEqual(captured['identity']['creation_time_100ns'],'2700')
        self.assertNotIn('pid',self.manifest['actor_intents']['O'])
        self.assertFalse(any(x[0]=='RESUME' for x in self.api.calls))


    def test_t04_distinct_actor_capture_and_parent_topology(self):
        actors=[]
        for role in ('O','S','C','W'):
            actors.append(self.backend.capture(role)['identity']);self.backend.resume(role)
        self.assertEqual([a['pid'] for a in actors],['700','717','734','751'])
        self.assertEqual(actors[1]['parent_actor_digest'],sha(actors[0]))
        self.assertEqual(actors[3]['parent_actor_digest'],sha(actors[1]))
    def test_t05_duplicate_pid_and_handle_identity_rejected(self):
        self.backend.capture('O');self.backend.resume('O')
        original=self.api.GetProcessId
        self.api.GetProcessId=lambda h:700
        self.assertRaises(ValueError,self.backend.capture,'S')
        self.assertTrue(self.backend.failed);self.assertTrue(self.backend.inventory()['resources'])
    def test_t06_capability_alias_and_unavailable_parent_rejected(self):
        self.assertRaises(ValueError,self.backend.capture,'W')
        bad=copy.deepcopy(self.caps);bad['W']['handle']=bad['O']['handle']
        self.assertRaises(ValueError,self.b.SplitBackend,self.api,self.manifest,bad,self.clock)
    def test_t07_partial_failure_consumes_capture_slot(self):
        self.api.fail='duplicate'
        self.assertRaises(ValueError,self.backend.capture,'O')
        before=sum(x[0]=='CREATE_V2' for x in self.api.calls)
        self.assertRaises(ValueError,self.backend.capture,'O')
        self.assertEqual(sum(x[0]=='CREATE_V2' for x in self.api.calls),before)
        self.assertTrue(self.backend.inventory()['resources'])
    def test_t08_capture_resume_order_and_expiry(self):
        self.backend.capture('O');self.clock.tick=30
        self.assertRaises(ValueError,self.backend.resume,'O')
        self.assertFalse(any(x[0]=='RESUME' for x in self.api.calls))


class BootstrapTests(unittest.TestCase):
    def setUp(self):
        self.m=importlib.import_module('identity_contract');self.b=importlib.import_module('identity_bootstrap')
        self.assertTrue(hasattr(self.b,'Bootstrap'),'Missing authenticated V2 bootstrap coordinator')
        self.make_boot()
    def make_boot(self,run=None):
        self.clock,self.auth,self.manifest,self.caps=fixture(self.m,run);self.api=IdentityAPI()
        self.backend=self.b.SplitBackend(self.api,self.manifest,self.caps,self.clock)
        self.boot=self.b.Bootstrap(self.manifest,self.auth,self.backend,A)
    def grant(self,role):
        return signed(self.auth,'RUN_LAUNCH',dict(run_digest=sha(self.manifest['run_context']),manifest_digest=sha(self.manifest),intent_digest=sha(self.manifest['actor_intents'][role]),allowance=1,not_before_tick=0,expires_tick=30))
    def captured(self,role):
        self.boot.capture(role,self.grant(role));proof=self.boot.registration(role);self.boot.resume(role,proof)
        self.boot.connect(role,['S-1-5-21-1-2-3-1001']);self.boot.poll_connect(role)
    def complete_role(self,role):
        self.captured(role);wire=self.boot.challenge(role);endpoint=self.boot.endpoint(role)
        self.boot.write_challenge(role);self.assertEqual(self.boot.poll_challenge(role)['status'],'CHALLENGE_DELIVERED')
        self.api.io_wire=endpoint.respond(wire);self.boot.read_response(role)
        self.assertEqual(self.boot.poll_response(role)['status'],'ACTOR_BOOTSTRAP_ACCEPTED')
        return endpoint,wire
    def complete(self):
        for role in ('O','S','C','W'):self.complete_role(role)
    def target(self):
        return dict(run_digest=sha(self.manifest['run_context']),worker_actor_digest=sha(self.boot.actor('W')),worker_epoch='ART_W2',command_id='ART_CMD2',reservation_id='ART_R2',lease_id='ART_L2')
    def admission(self,target,**changes):
        body=dict(run_digest=sha(self.manifest['run_context']),roster_digest=sha(self.boot.roster()),target_digest=sha(target),manifest_digest=sha(self.manifest),
                  budget_digest=sha(self.manifest['budgets']),issued_tick=10,expires_tick=30)
        body.update(changes);return signed(self.auth,'TARGET_ADMISSION',body)
    def admitted(self):
        self.complete();target=self.target();return self.boot.admit_target(target,self.admission(target))
    def test_t09_canonical_frame_limits_and_malformed_response(self):
        wire=canonical({'p':'x'*8184});self.assertEqual(len(wire),8192)
        self.assertEqual(len(self.m.decode_wire(wire)['p']),8184)
        for bad in (wire+b' ',b'{"a":1,"a":2}',b'{ "a":1}',b'NaN'):
            self.assertRaises(ValueError,self.m.decode_wire,bad)
        self.captured('O');self.boot.challenge('O');self.boot.write_challenge('O');self.boot.poll_challenge('O')
        self.api.io_wire=b'{"a":1,"a":2}';self.boot.read_response('O')
        self.assertRaises(ValueError,self.boot.poll_response,'O');self.assertTrue(self.boot.failed)
    def test_t10_wrong_parent_or_correctly_signed_wrong_scope_rejected(self):
        self.boot.capture('O',self.grant('O'));proof=self.boot.registration('O');proof['parent_actor_digest']=B
        proof=signed(self.auth,'REGISTRATION',{k:v for k,v in proof.items() if k not in ('signature','issuer','credential_id')},'L')
        self.assertRaises(ValueError,self.boot.resume,'O',proof)
        self.assertFalse(any(x[0]=='RESUME' for x in self.api.calls))
    def test_t11_pipe_peer_must_match_retained_captured_actor(self):
        self.captured('O');pipe=self.boot.channel('O')['pipe'];self.api.pipe_peers[self.backend._row(pipe)['handle']]=9999
        self.assertRaises(ValueError,self.boot.challenge,'O');self.assertTrue(self.boot.failed)
    def test_t12_one_challenge_and_no_channel_reconstruction(self):
        endpoint,wire=self.complete_role('O')
        self.assertRaises(ValueError,endpoint.respond,wire)
        self.assertRaises(ValueError,self.boot.challenge,'O');self.assertTrue(self.boot.failed)
    def test_t13_expired_and_rolled_back_clock_never_reanimates(self):
        self.boot.capture('O',self.grant('O'));proof=self.boot.registration('O');self.clock.tick=30
        self.assertRaises(ValueError,self.boot.resume,'O',proof)
        self.clock.tick=10;self.assertRaises(ValueError,self.boot.resume,'O',proof)
    def test_t14_shared_revocation_blocks_captured_resume(self):
        self.boot.capture('O',self.grant('O'));proof=self.boot.registration('O');view=copy.deepcopy(self.auth)
        view.revoke('L');self.assertIs(view,self.auth)
        self.assertRaises(ValueError,self.boot.resume,'O',proof)
        self.assertFalse(any(x[0]=='RESUME' for x in self.api.calls))
    def test_t15_endpoint_owns_one_key_and_transcript_has_no_keys(self):
        endpoint,wire=self.complete_role('O')
        self.assertEqual([v for v in vars(endpoint).values() if isinstance(v,bytes)],[credentials()['O']['key']])
        transcript=canonical(self.boot.transcript('O'))
        for credential in credentials().values():self.assertNotIn(credential['key'],transcript)
    def test_t16_incomplete_roster_and_forged_anchor_rejected(self):
        self.complete_role('O');self.assertRaises(ValueError,self.boot.roster)
        self.make_boot();bad=copy.deepcopy(self.manifest);bad['external_launcher']['anchor_proof']['external_anchor_digest']=B
        self.assertRaises(ValueError,self.b.Bootstrap,bad,self.auth,self.backend,A)
    def test_t18_signed_roster_substitution_cannot_admit_target(self):
        self.complete();target=self.target();packet=self.admission(target,roster_digest=A)
        self.assertRaises(ValueError,self.boot.admit_target,target,packet)
        self.assertTrue(self.boot.failed)
    def test_t20_bootstrap_success_does_not_credit_prearm_or_work(self):
        result=self.admitted()
        self.assertEqual(result['status'],'ARTIFICIAL_IDENTITY_BOOTSTRAP_ACCEPTED')
        self.assertFalse(result['work_dispatched']);self.assertEqual(result['cases_executed'],0)
        self.assertFalse(result['operational_acceptance']);self.assertFalse(result['scientific_acceptance'])
        self.assertEqual(self.boot.binding()['pid'],'751');self.assertEqual(self.boot.actor('O')['pid'],'700')
    def test_t22_pending_io_failure_preserves_owned_resources(self):
        self.captured('O');self.boot.challenge('O');self.boot.write_challenge('O');self.api.io_status=996
        self.assertEqual(self.boot.poll_challenge('O')['status'],'PENDING')
        before=self.backend.inventory();self.clock.tick=30
        self.assertRaises(ValueError,self.boot.poll_challenge,'O')
        after=self.backend.inventory();self.assertEqual(after['pending'],before['pending'])
        self.assertEqual(len(after['resources']),len(before['resources']))
    def test_t23_default_live_and_replacement_paths_refused(self):
        self.assertEqual(self.b.main([]),2);self.assertEqual(self.b.main(['--live']),2)
        self.assertRaises(ValueError,self.boot.capture,'X',self.grant('O'))

    def test_review_r1_short_grant_expiry_equal_blocks_resume_permanently(self):
        grant=self.grant('O');grant['expires_tick']=20
        grant=signed(self.auth,'RUN_LAUNCH',{k:v for k,v in grant.items() if k not in ('signature','issuer','credential_id')})
        self.boot.capture('O',grant);proof=self.boot.registration('O');before=self.backend.inventory()
        self.clock.tick=20;self.assertRaises(ValueError,self.boot.resume,'O',proof)
        self.clock.tick=10;self.assertRaises(ValueError,self.boot.resume,'O',proof)
        self.assertFalse(any(x[0]=='RESUME' for x in self.api.calls))
        self.assertEqual(before,self.backend.inventory());self.assertTrue(self.boot.failed)

    def test_review_r4_maximum_run_identifier_completes_without_late_pipe_failure(self):
        run=run_context();run['run_id']='R'*128;self.make_boot(run)
        self.admitted();self.assertFalse(self.boot.failed)

    def test_review_r5_failed_io_drains_without_delivery_or_revival(self):
        self.captured('O');self.boot.challenge('O');self.boot.write_challenge('O');self.api.io_status=996
        self.clock.tick=30;self.assertRaises(ValueError,self.boot.poll_challenge,'O')
        self.assertEqual(self.boot.drain('O')['status'],'PENDING')
        self.api.io_status=0;result=self.boot.drain('O')
        self.assertEqual(result['status'],'SUCCESS');self.assertFalse(result['delivery_accepted'])
        self.assertEqual(self.boot._phases['O'],'WRITING_CHALLENGE');self.assertTrue(self.boot.failed)
        self.assertRaises(ValueError,self.boot.poll_challenge,'O')
        self.clock.tick=80;before=list(self.api.calls);self.assertRaises(ValueError,self.boot.drain,'O')
        self.assertEqual(before,self.api.calls)

    def test_review_failed_io_cancelled_drain_never_accepts_delivery(self):
        self.captured('O');self.boot.challenge('O');self.boot.write_challenge('O');self.api.io_status=996
        self.clock.tick=30;self.assertRaises(ValueError,self.boot.poll_challenge,'O')
        self.api.io_status=995;result=self.boot.drain('O')
        self.assertEqual(result['status'],'CANCELLED');self.assertFalse(result['delivery_accepted'])
        self.assertTrue(self.boot.failed);self.assertEqual(self.boot._phases['O'],'WRITING_CHALLENGE')

    def test_review_partial_write_and_completion_close_uncertainty_quarantine(self):
        for failure in ('PARTIAL_WRITE','CLOSE_UNCERTAIN'):
            self.make_boot();self.captured('O');self.boot.challenge('O');self.boot.write_challenge('O')
            if failure=='PARTIAL_WRITE':
                original=self.api.GetOverlappedResult
                def partial(h,overlap,count,wait):
                    result=original(h,overlap,count,wait);count._obj.value=1;return result
                self.api.GetOverlappedResult=partial
            else:self.api.fail='close'
            self.assertRaises(ValueError,self.boot.poll_challenge,'O');self.assertTrue(self.boot.failed)
            self.assertNotEqual(self.boot._phases['O'],'CHALLENGE_DELIVERED')
            inventory=self.backend.inventory();self.assertTrue(inventory['resources'])
            if failure=='CLOSE_UNCERTAIN':self.assertTrue(any(r['quarantined'] for r in inventory['resources']))


class CompatibilityTests(unittest.TestCase):
    setUp=BootstrapTests.setUp
    make_boot=BootstrapTests.make_boot
    grant=BootstrapTests.grant
    captured=BootstrapTests.captured
    complete_role=BootstrapTests.complete_role
    complete=BootstrapTests.complete
    target=BootstrapTests.target
    admission=BootstrapTests.admission
    admitted=BootstrapTests.admitted
    def setup_target(self):
        self.admitted();self.assertTrue(hasattr(self.boot,'adopt_worker'),'Missing controlled legacy worker adoption')
        provider=self.boot.legacy_provider()
        from test_stage_b import decisions,observations
        ds=[]
        for row in decisions(POLICY+['G11_EXACT_FAULT_AUTHORITY']):
            row.update(scope_digest=self.boot.scope_digest,issuer='OWNER')
            ds.append(provider.sign_decision(row))
        obs=[]
        for row in observations():
            row['binding']=self.boot.binding();obs.append(provider.sign_observation(row,'O'))
        return provider,ds,obs
    def test_t19_adoption_rejects_dictionary_and_consumes_once(self):
        provider,ds,obs=self.setup_target()
        self.assertRaises(ValueError,self.b.BoundWorkerBridge,{})
        bridge=self.boot.adopt_worker(ds,obs)
        self.assertEqual(bridge.capture_identity(bridge.worker_token(self.boot.binding()))['pid'],'751')
        self.assertRaises(ValueError,bridge.bootstrap,'W',{})
        self.assertRaises(ValueError,self.boot.adopt_worker,ds,obs)
    def test_t21_separate_prearm_and_one_bounded_legacy_stop(self):
        provider,ds,obs=self.setup_target();bridge=self.boot.adopt_worker(ds,obs)
        from journal_protocol import Journal
        from native_runtime import RoleRuntime
        journal=Journal(str(store_path(self._testMethodName)),dict(sequence=0,chain_digest='0'*64,evidence_domain='ARTIFICIAL'))
        self.addCleanup(journal.close);token=bridge.worker_token(self.boot.binding());event=self.boot.channel('W')['event']
        runtime=RoleRuntime(bridge,self.backend,provider,self.clock,journal,token,event,70)
        self.assertRaises(ValueError,runtime.worker_once,True)
        runtime.arm(40);before=sum(x[0]=='CREATE_V2' for x in self.api.calls);self.clock.tick=40
        self.assertEqual(runtime.supervisor_once()['kind'],'CONTROL_ATTEMPT')
        self.assertEqual(runtime.supervisor_once()['kind'],'ALREADY_CONSUMED')
        self.assertEqual(sum(x[0]=='SET' for x in self.api.calls),1)
        self.assertEqual(sum(x[0]=='CREATE_V2' for x in self.api.calls),before)
        self.api.event_signaled=True;self.assertEqual(runtime.worker_once(True)['terminal'],'STOP_APPLIED')
        self.assertFalse(runtime.observe_worker_exit()['signaled']);self.assertEqual(runtime.finish()['disposition'],'HOLD')
        self.assertEqual(runtime.flush_attempt()['disposition'],'RECORDED')
    def test_t24_target_revocation_reaches_legacy_cached_authority(self):
        provider,ds,obs=self.setup_target();bridge=self.boot.adopt_worker(ds,obs)
        from journal_protocol import Journal
        from native_runtime import RoleRuntime
        journal=Journal(str(store_path(self._testMethodName)),dict(sequence=0,chain_digest='0'*64,evidence_domain='ARTIFICIAL'));self.addCleanup(journal.close)
        runtime=RoleRuntime(bridge,self.backend,provider,self.clock,journal,bridge.worker_token(self.boot.binding()),self.boot.channel('W')['event'],70)
        runtime.arm(40);self.auth.revoke('OWNER');self.clock.tick=40
        self.assertEqual(runtime.supervisor_once()['kind'],'QUARANTINED');self.assertFalse(any(x[0]=='SET' for x in self.api.calls))

    def test_review_r2_direct_supervisor_revocation_and_quarantine_block_signal(self):
        from journal_protocol import Journal
        from supervisor import Supervisor
        for failure in ('REVOKED','QUARANTINED'):
            self.make_boot();provider,ds,obs=self.setup_target();bridge=self.boot.adopt_worker(ds,obs)
            journal=Journal(str(store_path(self._testMethodName+'_'+failure)),dict(sequence=0,chain_digest='0'*64,evidence_domain='ARTIFICIAL'))
            self.addCleanup(journal.close);binding=self.boot.binding()
            slot=journal.prepare(binding,40)
            supervisor=Supervisor(binding,bridge,self.clock,journal)
            supervisor.arm(slot,dict(stage='PREARM_WORK_FAULT'))
            if failure=='REVOKED':self.auth.revoke('OWNER')
            else:self.boot._abort('ARTIFICIAL_QUARANTINE',ValueError())
            self.clock.tick=40;result=supervisor.step(40,None,None)
            self.assertEqual(result['delivery_status'],'UNKNOWN');self.assertFalse(any(x[0]=='SET' for x in self.api.calls))
            self.assertEqual(supervisor.step(40,None,None)['kind'],'ALREADY_CONSUMED')

    def test_review_r3_legacy_records_bind_full_v2_scope_with_same_role_keys(self):
        first,ds,obs=self.setup_target();binding=self.boot.binding()
        status=first.sign_status(dict(binding=binding,kind='REQUEST',tick=10,evidence_ref='PENDING'))
        event=first.sign_control(dict(binding=binding,slot_id=sha(binding),event_observed=True,evidence_ref='PENDING'))
        self.assertTrue(first.verify_observation(obs[0]));self.assertTrue(first.verify_observation(status));self.assertTrue(first.verify_control(event))
        run=run_context();run['run_id']='SECOND_RUN';self.make_boot(run);second,ds2,obs2=self.setup_target()
        self.assertEqual(first.binding,second.binding);self.assertNotEqual(first.scope_digest,second.scope_digest)
        self.assertFalse(second.verify_observation(obs[0]));self.assertFalse(second.verify_observation(status));self.assertFalse(second.verify_control(event))
        self.assertTrue(second.verify_observation(obs2[0]))


class TargetFrameTests(unittest.TestCase):
    setUp=BootstrapTests.setUp
    make_boot=BootstrapTests.make_boot
    grant=BootstrapTests.grant
    captured=BootstrapTests.captured
    complete_role=BootstrapTests.complete_role
    complete=BootstrapTests.complete
    target=BootstrapTests.target
    admission=BootstrapTests.admission
    admitted=BootstrapTests.admitted
    def target_pair(self):
        self.admitted();self.assertTrue(hasattr(self.boot,'target_endpoint'),'Missing target-bound actor frame path')
        return self.boot.target_endpoint('W','S')
    def deliver(self,wire):
        self.api.io_wire=wire;self.boot.read_target('W','S');return self.boot.poll_target('W','S')
    def test_target_frame_native_intake_pins_both_actor_identities(self):
        endpoint=self.target_pair();wire=endpoint.encode('STOP_APPLIED',A)
        self.clock.tick=40
        result=self.deliver(wire)
        self.assertEqual(result['message']['sender_actor_digest'],sha(self.boot.actor('W')))
        self.assertEqual(result['message']['recipient_actor_digest'],sha(self.boot.actor('S')))
        self.assertFalse(result['application_proven'])
    def test_target_frame_replay_fails(self):
        endpoint=self.target_pair();wire=endpoint.encode('STOP_APPLIED',A);self.deliver(wire)
        self.assertRaises(ValueError,self.deliver,wire)
        self.assertTrue(self.boot.failed)
    def test_target_frame_correctly_signed_wrong_recipient_fails(self):
        endpoint=self.target_pair();row=json.loads(endpoint.encode('STOP_APPLIED',A))
        row['recipient_actor_digest']=sha(self.boot.actor('O'))
        row['tag']=self.m.mac(credentials()['W']['key'],'TARGET_FRAME',{k:v for k,v in row.items() if k!='tag'})
        self.assertRaises(ValueError,self.deliver,canonical(row))
        self.assertTrue(self.boot.failed)

    def test_review_target_frame_valid_c_mac_cannot_impersonate_w(self):
        endpoint=self.target_pair();row=json.loads(endpoint.encode('STOP_APPLIED',A))
        row['credential_id']=credentials()['C']['credential_id']
        row['tag']=self.m.mac(credentials()['C']['key'],'TARGET_FRAME',{k:v for k,v in row.items() if k!='tag'})
        self.assertRaises(ValueError,self.deliver,canonical(row));self.assertTrue(self.boot.failed)

    def test_review_target_ipc_expiry_equality_blocks_native_read(self):
        endpoint=self.target_pair();wire=endpoint.encode('STOP_APPLIED',A);self.clock.tick=60
        before=list(self.api.calls);self.assertRaises(ValueError,self.deliver,wire)
        self.assertEqual(before,self.api.calls);self.assertTrue(self.boot.failed)
