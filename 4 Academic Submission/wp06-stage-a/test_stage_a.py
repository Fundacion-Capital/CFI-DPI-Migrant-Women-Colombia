"""Approved AC01–AC16 synthetic fixtures only; no discovery or live backend."""
import argparse
import copy
import hashlib
import importlib
import json
import pathlib
import sqlite3
import sys
import threading
import unittest
import uuid
from contextlib import closing

FOLDER=pathlib.Path(__file__).resolve().parent
ROOT=FOLDER.parent/'audit-local/intake/wp06-stage-a-implementation-c870e8b'
parser=argparse.ArgumentParser();parser.add_argument('--packet',required=True);parser.add_argument('selectors',nargs='*')
args=parser.parse_args();PACKET=pathlib.Path(args.packet).resolve()
if ROOT.resolve() not in PACKET.parents or (ROOT/'validation.json').exists():raise ValueError('Unsealed current run packet required')
manifest=json.loads((PACKET/'build_manifest.json').read_text(encoding='utf-8'))
def validate_manifest(value,packet):
    names=['journal.py','protocol.py','harness.py','test_stage_a.py']
    if value['run_root']!=str(packet) or value['expected_files']!=names or value['clock']!={'kind':'SYNTHETIC_INTEGER_NANOSECOND_TICKS_NOT_HOST_CLOCK','start':100,'execution_allowance':10,'cleanup_allowance':3}:raise ValueError('Exact approved files/fixture')
    if any(type(value['clock'][k]) is not int for k in ('start','execution_allowance','cleanup_allowance')):raise ValueError('Clock types')
    present=[n for n in names if (FOLDER/n).exists()]
    if value['missing']!=[n for n in names if n not in present] or [pin['file'] for pin in value['files']]!=[(FOLDER/n).relative_to(FOLDER.parents[1]).as_posix() for n in present]:raise ValueError('Exact source inventory')
    if value['scope']!='ARTIFICIAL_ONLY' or value['production_budgets'] is not None or type(value['retry']) is not int or value['retry']!=0:raise ValueError('Scope')
    for pin in value['files']:
        content=(FOLDER.parents[1]/pin['file']).read_bytes()
        if len(content)!=pin['bytes'] or hashlib.sha256(content).hexdigest().upper()!=pin['sha256']:raise ValueError('Build changed before tests')
validate_manifest(manifest,PACKET)

ZERO='0'*64
def binding(**changes):
    b=dict(origin='ARTIFICIAL_ONLY',contract_digest=hashlib.sha256(b'ART_CONTRACT_FIXTURE_V1').hexdigest(),
        build_digest=hashlib.sha256(b'ART_BUILD_FIXTURE_V1').hexdigest(),host_id='ART_HOST_1',boot_id='ART_BOOT_1',session_id='ART_SESSION_1',
        owner_nonce='ART_OWNER_1',worker_epoch=1,command_id='ART_COMMAND_1',pid=1234,creation_time='ART_CREATED_1',
        engine_module_digest=hashlib.sha256(b'ART_ENGINE_FIXTURE_V1').hexdigest(),reservation_id='ART_RESERVATION_1',lease_id='ART_LEASE_1',scope_id='ART_SCOPE_A',clock_domain='ART_CLOCK_1')
    b.update(changes);return b

class Base(unittest.TestCase):
    def setUp(self):
        self.checks=0;self.evidence=[];self.harnesses=[];self.folder=PACKET/'f'/uuid.uuid4().hex[:8]
        self.folder.mkdir(parents=True,exist_ok=False)
    def tearDown(self):
        artifacts=[]
        for path in sorted(self.folder.rglob('*')):
            if path.is_file():
                content=path.read_bytes();artifacts.append(dict(file=path.relative_to(FOLDER.parents[1]).as_posix(),bytes=len(content),sha256=hashlib.sha256(content).hexdigest().upper()))
        self.evidence.append(dict(fixture_root=self.folder.relative_to(PACKET).as_posix(),artifacts=artifacts,harness_states=[h.snapshot() for h in self.harnesses]))
    def assertEqual(self,*a,**k):self.checks+=1;return super().assertEqual(*a,**k)
    def assertTrue(self,*a,**k):self.checks+=1;return super().assertTrue(*a,**k)
    def assertFalse(self,*a,**k):self.checks+=1;return super().assertFalse(*a,**k)
    def assertRaises(self,*a,**k):self.checks+=1;return super().assertRaises(*a,**k)
    def need(self,name):
        self.assertTrue((FOLDER/(name+'.py')).exists(),'Missing approved implementation '+name)
        return importlib.import_module(name)
    def journal(self,name='journal.sqlite',mark=(0,ZERO)):
        return self.need('journal').Journal(self.folder/name,mark)
    def reject(self,call,*a,**k):
        with self.assertRaises(ValueError):call(*a,**k)
    def proof(self,kind='ART_STOP_INTENT',b=None,seq=1,prev=ZERO,at=105,credential=None):
        b=copy.deepcopy(b or binding());b['pid']=str(b['pid']);b['worker_epoch']=str(b['worker_epoch'])
        role='ART_CONTROL' if kind=='ART_STOP_INTENT' else 'ART_OBSERVER'
        return dict(kind=kind,binding=b,sequence=str(seq),previous_digest=prev,timestamp_ns=str(at),issuer=role,
            credential_id=credential or ('ART_CONTROL_KEY' if role=='ART_CONTROL' else 'ART_OBSERVER_KEY'),reason='ART_FIXTURE',
            payload_digest=hashlib.sha256(('{"action":"'+kind+'"}').encode('ascii')).hexdigest(),
            result={'ART_STOP_INTENT':'ART_REQUESTED','ART_STOP_APPLIED':'ART_APPLIED','ART_EXIT_OBSERVED':'ART_EXIT','ART_CLEANUP_OBSERVED':'ART_CLEANUP'}[kind])
    def keys(self):
        return {'ART_CONTROL_KEY':dict(issuer='ART_CONTROL',scope_id='ART_SCOPE_A',key=b'ART_CONTROL_KEY_FIXTURE_ONLY',revoked=False),
            'ART_OBSERVER_KEY':dict(issuer='ART_OBSERVER',scope_id='ART_SCOPE_A',key=b'ART_OBSERVER_KEY_FIXTURE_ONLY',revoked=False)}

class JournalTests(Base):
    def test_AC03_unique_concurrent_claim(self):
        j=self.journal();gate=threading.Barrier(8,timeout=3);out=[]
        def claim():
            try:gate.wait();self.need('journal').Journal(j.path,(0,ZERO)).reserve(binding());out.append('WIN')
            except (ValueError,threading.BrokenBarrierError):out.append('DENIED')
        threads=[threading.Thread(target=claim) for _ in range(8)]
        try:
            for t in threads:t.start()
        finally:
            for t in threads:t.join(4)
        self.assertFalse(any(t.is_alive() for t in threads));self.assertEqual(out.count('WIN'),1)
        self.assertEqual(len(out),8);self.assertEqual(j.snapshot()['claims'],1)
        self.evidence.append(j.snapshot())
    def test_AC03_terminal_command_not_released(self):
        j=self.journal();j.reserve(binding());j.append(binding(),'CLEANUP_OBSERVED',{'reason':'ART_FIXTURE'})
        self.reject(j.reserve,binding(reservation_id='ART_RESERVATION_2'));self.assertEqual(j.snapshot()['claims'],1)
    def test_AC04_before_commit_never_dispatchable(self):
        j=self.journal();j.fixture_fault='BEFORE_COMMIT';self.reject(j.reserve,binding())
        self.assertTrue(j.blocked);self.assertEqual(j.snapshot()['claims'],0);self.assertEqual(j.snapshot()['dispatches'],0)
        self.reject(j.reserve,binding())
    def test_AC04_after_commit_unknown_consumed(self):
        j=self.journal();j.fixture_fault='AFTER_COMMIT';self.reject(j.reserve,binding())
        self.assertTrue(j.blocked);self.assertEqual(j.snapshot()['claims'],1);self.assertEqual(j.snapshot()['dispatches'],0)
        try:
            second=self.need('journal').Journal(j.path,(0,ZERO))
        except ValueError:second=None
        if second is not None:self.reject(second.reserve,binding())
        self.evidence.append(j.snapshot())
    def test_AC04_unknown_before_commit_blocks_fresh_instance(self):
        j=self.journal();j.fixture_fault='BEFORE_COMMIT';self.reject(j.reserve,binding())
        self.reject(self.need('journal').Journal,j.path,(0,ZERO));self.assertEqual(j.snapshot()['dispatches'],0)
    def test_AC14_write_uncertainty_fences_existing_other_instance(self):
        j=self.journal();j.reserve(binding());other=self.need('journal').Journal(j.path,j.snapshot()['watermark'])
        j.fixture_fault='BEFORE_WRITE';self.reject(j.append,binding(),'ARM',{'reason':'ART_FIXTURE'})
        self.reject(other.append,binding(),'DISPATCH_OBSERVED',{'reason':'ART_FIXTURE'})
        self.assertEqual(other.snapshot()['dispatches'],0)
    def test_AC04_AC05_restart_quarantines_without_resend(self):
        j=self.journal();j.reserve(binding());j.append(binding(),'DISPATCH_INTENT',{'reason':'ART_FIXTURE'})
        mark=j.snapshot()['watermark'];fresh=self.need('journal').Journal(j.path,mark)
        self.assertEqual(fresh.recover(),['ART_RESERVATION_1']);self.assertEqual(fresh.status(binding()),'QUARANTINED')
        self.reject(fresh.reserve,binding());self.assertEqual(fresh.snapshot()['dispatches'],0)
    def test_AC05_old_backup_below_watermark_blocks(self):
        j=self.journal();j.reserve(binding());backup=self.folder/'old.sqlite'
        with closing(sqlite3.connect(j.path)) as source,closing(sqlite3.connect(backup)) as dest:source.backup(dest)
        j.append(binding(),'ARM',{'reason':'ART_FIXTURE'});mark=j.snapshot()['watermark']
        self.reject(self.need('journal').Journal,backup,mark);self.assertTrue(backup.exists())
    def test_AC14_corrupt_truncate_copy_preserves_original(self):
        j=self.journal();j.reserve(binding());original=j.path.read_bytes()
        for name,content in [('corrupt.sqlite',b'ART_CORRUPT'),('truncated.sqlite',original[:31])]:
            path=self.folder/name;path.write_bytes(content);self.reject(self.need('journal').Journal,path,(0,ZERO))
            self.assertEqual(path.read_bytes(),content)
        self.assertEqual(j.path.read_bytes(),original);self.assertTrue(len(list(self.folder.glob('*.diagnostic')))==2)
    def test_AC14_write_failure_preserves_diagnostic(self):
        j=self.journal();j.reserve(binding());j.fixture_fault='BEFORE_WRITE';before=j.path.read_bytes()
        self.reject(j.append,binding(),'DISPATCH_INTENT',{'reason':'ART_FIXTURE'})
        self.assertEqual(j.path.read_bytes(),before);self.assertEqual(j.snapshot()['dispatches'],0)
        self.assertTrue(j.blocked);self.assertTrue(bool(list(self.folder.glob('*.diagnostic'))))
    def test_AC14_readable_but_changed_schema_is_rejected(self):
        j=self.journal();j.reserve(binding());mark=j.snapshot()['watermark'];con=sqlite3.connect(j.path)
        try:con.execute('CREATE TRIGGER unexpected AFTER INSERT ON events BEGIN SELECT 1; END;');con.commit()
        finally:con.close()
        self.reject(self.need('journal').Journal,j.path,mark)

class ProtocolTests(Base):
    def test_AC01_binding_schema_before_reserve(self):
        j=self.journal();b=binding()
        invalid=[{},dict(b,unknown='ART_CANARY'),dict(b,origin='LIVE'),dict(b,pid=True),dict(b,session_id='default'),dict(b,owner_nonce=['ART_MUTABLE'])]
        for bad in invalid:self.reject(j.reserve,bad)
        self.assertEqual(j.snapshot()['claims'],0);self.assertEqual(j.snapshot()['dispatches'],0)
    def test_AC06_known_byte_and_hmac_vectors(self):
        p=self.need('protocol')
        self.assertEqual(p.encode({'z':{'b':'1'},'a':'ART_A'}),b'{"a":"ART_A","z":{"b":"1"}}')
        self.assertEqual(p.mac(bytes([11])*20,b'Hi There'),'b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7')
        body=self.proof(b=binding(pid=9007199254740993));keys=self.keys();wire=p.sign(body,'ART_CONTROL_KEY',keys)
        result=p.Verifier(keys,deliver_by=113).consume(wire,binding(pid=9007199254740993),'ART_STOP_INTENT',105)
        self.assertEqual(result['binding']['pid'],'9007199254740993')
        with self.assertRaises(TypeError):result['binding']['pid']='2'
    def test_AC06_tamper_every_binding_field_and_tag(self):
        p=self.need('protocol');body=self.proof();keys=self.keys();wire=p.sign(body,'ART_CONTROL_KEY',keys)
        for key,value in body['binding'].items():
            envelope=json.loads(wire);envelope['body']['binding'][key]=('2' if key in ('pid','worker_epoch') else ('1'*64 if key.endswith('digest') else 'ART_REPLACED'))
            self.reject(p.Verifier(keys,deliver_by=113).consume,p.encode(envelope),binding(),'ART_STOP_INTENT',105)
        for key in ('kind','issuer','credential_id','sequence','previous_digest','timestamp_ns','reason','payload_digest','result'):
            envelope=json.loads(wire);envelope['body'][key]='ART_TAMPER'
            self.reject(p.Verifier(keys,deliver_by=113).consume,p.encode(envelope),binding(),'ART_STOP_INTENT',105)
        envelope=json.loads(wire);envelope['tag']='0'*64
        self.reject(p.Verifier(keys,deliver_by=113).consume,p.encode(envelope),binding(),'ART_STOP_INTENT',105)
    def test_AC06_noncanonical_duplicates_types_size_depth(self):
        p=self.need('protocol');keys=self.keys();wire=p.sign(self.proof(),'ART_CONTROL_KEY',keys)
        invalid=[wire+b' ',b'{"body":{},"body":{},"tag":"'+b'0'*64+b'"}',b'{"x":1}',b'{"x":true}',b'{"x":null}',b'{"x":[]}',b'{"x":"\\u0041"}',b'x'*8193,b'{"x":'*20+b'"x"'+b'}'*20]
        for item in invalid:self.reject(p.Verifier(keys,deliver_by=113).consume,item,binding(),'ART_STOP_INTENT',105)
        for value in ('01','-1','1.0','9223372036854775808',True,1.0):
            body=self.proof();body['timestamp_ns']=value;self.reject(p.sign,body,'ART_CONTROL_KEY',keys)
    def test_AC07_replay_and_revocation(self):
        p=self.need('protocol');keys=self.keys();wire=p.sign(self.proof(),'ART_CONTROL_KEY',keys)
        v=p.Verifier(keys,deliver_by=113);v.consume(wire,binding(),'ART_STOP_INTENT',105);self.reject(v.consume,wire,binding(),'ART_STOP_INTENT',105)
        v=p.Verifier(keys,deliver_by=113);v.revoke('ART_CONTROL_KEY');self.reject(v.consume,wire,binding(),'ART_STOP_INTENT',105)
    def test_AC12_authenticated_timestamp_reversal_is_rejected(self):
        p=self.need('protocol');keys=self.keys();first=self.proof('ART_STOP_APPLIED',at=106)
        v=p.Verifier(keys,deliver_by=113);v.consume(p.sign(first,'ART_OBSERVER_KEY',keys),binding(),'ART_STOP_APPLIED',106)
        next_body=self.proof('ART_EXIT_OBSERVED',seq=2,prev=hashlib.sha256(p.encode(first)).hexdigest(),at=105)
        self.reject(v.consume,p.sign(next_body,'ART_OBSERVER_KEY',keys),binding(),'ART_EXIT_OBSERVED',106)
    def test_AC07_wrong_role_scope_lease_or_key(self):
        p=self.need('protocol');keys=self.keys()
        for body in (self.proof(credential='ART_OBSERVER_KEY'),self.proof(b=binding(scope_id='ART_SCOPE_B')),self.proof(b=binding(lease_id='ART_OLD_LEASE'))):
            wire=p.sign(body,body['credential_id'],keys);self.reject(p.Verifier(keys,deliver_by=113).consume,wire,binding(),'ART_STOP_INTENT',105)
        hostile=copy.deepcopy(keys);hostile['ART_CONTROL_KEY']['key']=b'ART_WRONG_KEY_FIXTURE_ONLY'
        wire=p.sign(self.proof(),'ART_CONTROL_KEY',hostile);self.reject(p.Verifier(keys,deliver_by=113).consume,wire,binding(),'ART_STOP_INTENT',105)
    def test_AC10_consumer_expiry_then_rollback_never_reopens(self):
        p=self.need('protocol');keys=self.keys();wire=p.sign(self.proof(),'ART_CONTROL_KEY',keys);v=p.Verifier(keys,deliver_by=108)
        self.reject(v.consume,wire,binding(),'ART_STOP_INTENT',108);self.reject(v.consume,wire,binding(),'ART_STOP_INTENT',105)
        self.assertTrue(v.closed)
    def test_AC15_unknown_and_canary_not_public(self):
        p=self.need('protocol');body=self.proof();body['participant_name']='ART_SENSITIVE_CANARY'
        self.reject(p.sign,body,'ART_CONTROL_KEY',self.keys());self.reject(p.encode,{'z':'ART_SENSITIVE_CANARY','x':object()})
        (self.folder/'rejected_canary.json').write_text(json.dumps(body),encoding='utf-8')
        self.assertTrue((self.folder/'rejected_canary.json').exists())

class HarnessTests(Base):
    def make(self):
        m=self.need('harness');self.now=[100];self.registry=m.FixtureRegistry(binding(),self.keys())
        self.h=m.Harness(self.journal('h'+uuid.uuid4().hex[:4]+'.sqlite'),self.registry,lambda:self.now[0]);self.harnesses.append(self.h);return self.h
    def domain(self):return dict(host_id='ART_HOST_1',boot_id='ART_BOOT_1',clock_domain='ART_CLOCK_1',translation_delay_ns=0)
    def running(self):
        h=self.make();h.reserve(binding(),10,3);h.arm(binding(),self.domain());h.dispatch();return h
    def observation(self,kind,seq=1,prev=ZERO,at=None):
        p=self.need('protocol');body=self.proof(kind,seq=seq,prev=prev,at=self.now[0] if at is None else at)
        return p.sign(body,body['credential_id'],self.keys()),hashlib.sha256(p.encode(body)).hexdigest()
    def test_AC01_unregistered_binding_before_claim(self):
        h=self.make();self.reject(h.reserve,binding(owner_nonce='ART_OTHER_OWNER'),10,3)
        self.assertEqual(h.journal.snapshot()['claims'],0);self.assertEqual(h.snapshot()['dispatch_count'],0)
    def test_AC02_every_replaced_identity_denies_old_control(self):
        for field in ('host_id','boot_id','session_id','owner_nonce','worker_epoch','command_id','pid','creation_time','engine_module_digest','reservation_id','lease_id','scope_id','clock_domain','contract_digest','build_digest'):
            h=self.running();self.now[0]=105;intent=h.cancel();changed=binding()
            changed[field]=2 if field in ('pid','worker_epoch') else ('1'*64 if field.endswith('digest') else 'ART_CHANGED')
            self.registry.replace(changed);self.reject(h.receive,intent)
            self.assertEqual(h.snapshot()['stop_applied_count'],0);self.assertTrue(h.snapshot()['quarantined'])
    def test_AC04_dispatch_and_stop_commit_failure_no_effect(self):
        h=self.make();h.reserve(binding(),10,3);h.arm(binding(),self.domain());h.journal.fixture_fault='AFTER_COMMIT'
        self.reject(h.dispatch);self.assertEqual(h.snapshot()['dispatch_count'],0);self.assertTrue(h.snapshot()['quarantined'])
        h=self.running();self.now[0]=105;h.journal.fixture_fault='AFTER_COMMIT';self.reject(h.cancel)
        self.assertEqual(h.snapshot()['stop_intent_count'],0);self.assertEqual(h.snapshot()['stop_applied_count'],0)
    def test_AC05_restart_fences_old_active_controller(self):
        h=self.running();self.now[0]=105;intent=h.cancel();h.journal.recover();self.reject(h.receive,intent)
        self.assertEqual(h.snapshot()['stop_applied_count'],0)
    def test_AC08_eight_cancel_callers_one_application(self):
        h=self.running();self.now[0]=105;gate=threading.Barrier(8,timeout=3);intents=[];errors=[]
        def cancel():
            try:gate.wait();intents.append(h.cancel())
            except Exception as e:errors.append(type(e).__name__)
        threads=[threading.Thread(target=cancel) for _ in range(8)]
        try:
            for t in threads:t.start()
        finally:
            for t in threads:t.join(4)
        self.assertFalse(any(t.is_alive() for t in threads));self.assertEqual(errors,[])
        real=[x for x in intents if x is not None];self.assertEqual(len(real),1);h.receive(real[0]);self.reject(h.receive,real[0])
        self.assertEqual(h.snapshot()['stop_intent_count'],1);self.assertEqual(h.snapshot()['stop_applied_count'],1)
        self.evidence.append(h.snapshot())
    def test_AC08_prestart_cancel_never_dispatches(self):
        h=self.make();h.reserve(binding(),10,3);self.assertEqual(h.cancel(),None);self.reject(h.dispatch)
        self.assertEqual(h.snapshot()['dispatch_count'],0);self.assertTrue(h.snapshot()['quarantined'])
    def test_AC08_cancel_before_reservation_terminal_no_claim(self):
        h=self.make();self.reject(h.cancel);self.assertTrue(h.snapshot()['quarantined'])
        self.assertEqual(h.journal.snapshot()['claims'],0);self.assertEqual(h.snapshot()['dispatch_count'],0)
        self.reject(h.reserve,binding(),10,3);self.reject(h.dispatch)
        self.assertEqual(h.journal.snapshot()['claims'],0);self.assertEqual(h.snapshot()['dispatch_count'],0)
    def test_AC09_early_stop_deadline_equal_expires_no_extension(self):
        h=self.running();self.now[0]=105;intent=h.cancel();self.assertEqual(h.snapshot()['cleanup_deadline'],108)
        self.now[0]=106;self.assertEqual(h.cancel(),None);self.assertEqual(h.snapshot()['cleanup_deadline'],108)
        self.now[0]=108;self.reject(h.receive,intent);self.assertEqual(h.snapshot()['stop_applied_count'],0)
    def test_AC09_natural_109_complete_110_rejected(self):
        h=self.running();self.now[0]=109;exit_wire,digest=self.observation('ART_EXIT_OBSERVED');h.receive(exit_wire)
        cleanup,_=self.observation('ART_CLEANUP_OBSERVED',2,digest);h.receive(cleanup)
        self.assertEqual(h.snapshot()['state'],'ART_COMPLETE');self.assertFalse(h.snapshot()['delivery_confirmed'])
        h=self.running();self.now[0]=110;exit_wire,_=self.observation('ART_EXIT_OBSERVED');self.reject(h.receive,exit_wire)
        self.assertTrue(h.snapshot()['quarantined']);self.assertFalse(h.snapshot()['cleanup_confirmed'])
    def test_AC10_invalid_numeric_and_controller_rollback(self):
        for bad in (True,1.0,float('nan'),float('inf'),0,-1,9223372036854775808):
            h=self.make();self.reject(h.reserve,binding(),bad,3);self.assertEqual(h.journal.snapshot()['claims'],0)
        h=self.make();self.now[0]=9223372036854775800;self.reject(h.reserve,binding(),10,3);self.assertEqual(h.journal.snapshot()['claims'],0)
        h=self.running();self.now[0]=113;h.tick();self.now[0]=105;self.reject(h.cancel)
        self.assertEqual(h.snapshot()['stop_intent_count'],0);self.assertTrue(h.snapshot()['quarantined'])
        h=self.running();self.now[0]=float('nan');self.reject(h.tick);self.assertEqual(h.snapshot()['stop_intent_count'],0)
    def test_AC11_incomparable_clock_or_unknown_delay_blocks_arm(self):
        for field,value in [('host_id','ART_HOST_2'),('boot_id','ART_BOOT_2'),('clock_domain','ART_CLOCK_2'),('translation_delay_ns',None),('translation_delay_ns',True),('translation_delay_ns',1)]:
            h=self.make();h.reserve(binding(),10,3);domain=self.domain();domain[field]=value;self.reject(h.arm,binding(),domain)
            self.assertEqual(h.snapshot()['dispatch_count'],0);self.assertTrue(h.snapshot()['quarantined'])
    def test_AC01_malformed_arm_is_terminal(self):
        h=self.make();h.reserve(binding(),10,3);self.reject(h.arm,{},self.domain())
        self.assertTrue(h.snapshot()['quarantined']);self.reject(h.arm,binding(),self.domain());self.assertEqual(h.snapshot()['dispatch_count'],0)
    def test_AC12_signed_ordered_cancel_exit_cleanup(self):
        h=self.running();self.now[0]=105;intent=h.cancel();h.receive(intent)
        applied,previous=self.observation('ART_STOP_APPLIED');h.receive(applied)
        self.now[0]=106;exited,previous2=self.observation('ART_EXIT_OBSERVED',2,previous);h.receive(exited)
        cleanup,_=self.observation('ART_CLEANUP_OBSERVED',3,previous2);h.receive(cleanup)
        self.assertEqual(h.snapshot()['state'],'ART_COMPLETE');self.assertTrue(h.snapshot()['delivery_confirmed']);self.assertTrue(h.snapshot()['cleanup_confirmed'])
        self.evidence.append(h.snapshot())
    def test_AC12_future_reversed_missing_proof_not_confirmation(self):
        h=self.running();self.now[0]=105;future,_=self.observation('ART_EXIT_OBSERVED',at=106);self.reject(h.receive,future)
        self.assertFalse(h.snapshot()['exit_observed']);self.assertFalse(h.snapshot()['cleanup_confirmed'])
        h=self.running();self.now[0]=105;cleanup,_=self.observation('ART_CLEANUP_OBSERVED');self.reject(h.receive,cleanup)
        self.assertFalse(h.snapshot()['cleanup_confirmed'])
        h=self.running();self.now[0]=105;h.cancel();exited,_=self.observation('ART_EXIT_OBSERVED');self.reject(h.receive,exited)
        self.assertTrue(h.snapshot()['exit_observed']);self.assertFalse(h.snapshot()['delivery_confirmed']);self.assertTrue(h.snapshot()['quarantined'])
        h=self.running();self.reject(h.receive,b'{"kind":"ART_LEGACY_ACK","registry_absent":"yes"}')
        self.assertFalse(h.snapshot()['exit_observed'])
    def test_AC13_lost_ack_late_stop_success_stay_consumed(self):
        h=self.running();self.now[0]=105;intent=h.cancel();self.now[0]=108;h.tick();self.reject(h.receive,intent)
        exited,_=self.observation('ART_EXIT_OBSERVED');self.reject(h.receive,exited);self.assertEqual(h.snapshot()['stop_applied_count'],0)
        self.assertEqual(h.snapshot()['stop_intent_count'],1);self.reject(h.dispatch);self.assertEqual(h.snapshot()['dispatch_count'],1)
        self.assertFalse(h.snapshot()['cleanup_confirmed']);self.assertTrue(h.snapshot()['quarantined'])
    def test_AC14_failed_journal_blocks_dispatch(self):
        h=self.make();h.reserve(binding(),10,3);h.arm(binding(),self.domain());h.journal.fixture_fault='BEFORE_WRITE'
        self.reject(h.dispatch);self.assertEqual(h.snapshot()['dispatch_count'],0);self.assertTrue(h.snapshot()['quarantined'])
    def test_AC15_public_allowlist_excludes_canary_and_raw_proof(self):
        h=self.running();canary={'participant_name':'ART_SENSITIVE_CANARY','stdout':'ART_RAW_CANARY'}
        (self.folder/'restricted_canary.json').write_text(json.dumps(canary),encoding='utf-8')
        self.reject(h.receive,self.need('protocol').encode(canary));public=h.public_summary('AC15')
        self.assertFalse('CANARY' in json.dumps(public));self.assertFalse('binding' in public);self.assertFalse('tag' in public)
        allowed={'origin','case_id','status','assertion_count','dispatch_count','stop_intent_count','stop_applied_count','quarantined','live_authorities'}
        self.assertTrue(set(public)<=allowed);self.assertEqual(sum(public['live_authorities'].values()),0)
    def test_AC16_all_artificial_success_never_grants_authority(self):
        h=self.running();self.now[0]=109;exited,digest=self.observation('ART_EXIT_OBSERVED');h.receive(exited)
        cleanup,_=self.observation('ART_CLEANUP_OBSERVED',2,digest);h.receive(cleanup)
        self.assertEqual(h.snapshot()['state'],'ART_COMPLETE')
        for action in ('service_changes','live_probes','stata_execution','participant_processing','fits','live_stop_calls','process_kills','release','unknown'):
            self.assertFalse(h.authorize(action))
        self.assertEqual(sum(h.public_summary('AC16')['live_authorities'].values()),0);self.evidence.append(h.public_summary('AC16'))
    def test_AC16_exact_build_manifest_and_fixture_clock(self):
        self.assertTrue(callable(globals().get('validate_manifest')),'Missing exact manifest validation')
        for replacement in ([],['journal.py']*4,['wrong.py','protocol.py','harness.py','test_stage_a.py']):
            changed=copy.deepcopy(manifest);changed['expected_files']=replacement;self.reject(validate_manifest,changed,PACKET)
        for field in ('kind','start','execution_allowance','cleanup_allowance'):
            changed=copy.deepcopy(manifest);changed['clock'].pop(field);self.reject(validate_manifest,changed,PACKET)
        changed=copy.deepcopy(manifest);changed['clock']['start']=101;self.reject(validate_manifest,changed,PACKET)

class EvidenceResult(unittest.TextTestResult):
    def __init__(self,*a,**k):super().__init__(*a,**k);self.records=[]
    def addSuccess(self,test):
        super().addSuccess(test);self.records.append(dict(test=test.id(),status='PASS',assertions=test.checks,evidence=test.evidence))
    def addFailure(self,test,err):
        super().addFailure(test,err);self.records.append(dict(test=test.id(),status='FAIL_PRESERVED',assertions=test.checks,evidence=test.evidence))
    def addError(self,test,err):
        super().addError(test,err);self.records.append(dict(test=test.id(),status='FAIL_PRESERVED',assertions=getattr(test,'checks',0),evidence=getattr(test,'evidence',[])))

if __name__=='__main__':
    suite=unittest.defaultTestLoader.loadTestsFromNames(args.selectors,module=sys.modules[__name__]) if args.selectors else unittest.defaultTestLoader.loadTestsFromModule(sys.modules[__name__])
    result=unittest.TextTestRunner(verbosity=2,resultclass=EvidenceResult).run(suite)
    with (PACKET/'unittest_results.json').open('x',encoding='utf-8') as out:
        json.dump(dict(tests=result.testsRun,failures=len(result.failures),errors=len(result.errors),records=result.records),out,indent=2)
    sys.exit(0 if result.wasSuccessful() else 1)
