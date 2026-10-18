"""Real bounded contract and preserved Bootstrap; only external API/witness facts are artificial."""
import copy
import importlib
import importlib.util
import json
import unittest
import test_identity_bootstrap as old
from journal_protocol import sha,canonical

class DeploymentTests(unittest.TestCase):
    make_boot=old.BootstrapTests.make_boot
    grant=old.BootstrapTests.grant
    captured=old.BootstrapTests.captured
    complete_role=old.BootstrapTests.complete_role
    complete=old.BootstrapTests.complete
    target=old.BootstrapTests.target
    admission=old.BootstrapTests.admission
    admitted=old.BootstrapTests.admitted
    def setUp(self):
        self.assertIsNotNone(importlib.util.find_spec('deployment_contract'),'Missing artificial deployment contract')
        self.d=importlib.import_module('deployment_contract')
        old.BootstrapTests.setUp(self);self.admitted();self.worker_binding=self.boot.binding();self.witnesses={'O':set(),'L':set()}
        self.verifiers={role:(lambda record,r=role:sha(record) in self.witnesses[r]) for role in ('O','L')}
        self.contract=self.d.DeploymentContract(self.boot,old.A,self.verifiers)
    def endpoints(self):
        return {r:self.contract.consume(r,self.contract.ticket(r,20)) for r in ('L','O','S','C','W')}
    def inventory(self,roles):
        return {r:dict(actor_digest=sha(self.boot.actor(r)),resources_closed=True,pending_io=0,uncertainty=False) for r in roles}
    def payload(self,kind,accepted):
        return {
          'CONTROL_ATTEMPT':lambda:dict(slot_digest=sha(self.worker_binding),delivery_status='ATTEMPTED'),
          'WORKER_APPLICATION':lambda:dict(attempt_digest=sha(accepted[-1]),terminal='STOP_APPLIED'),
          'APPLIED_OBSERVATION':lambda:dict(worker_evidence_digest=sha(accepted[-1]),applied=True),
          'EXIT_OBSERVATION':lambda:dict(application_observation_digest=sha(accepted[-1]),signaled=True,exit_code=0),
          'CLEANUP_OBSERVATION':lambda:dict(exit_evidence_digest=sha(accepted[-1]),inventory=self.inventory(('S','C','W'))),
          'FINAL_INVENTORY':lambda:dict(cleanup_evidence_digest=sha(accepted[-1]),inventory=self.inventory(('O','S','C','W')))
        }[kind]()
    def chain(self,stop=6,transform=None):
        endpoints=self.endpoints();accepted=[];result=None
        for index,(role,kind) in enumerate((('S','CONTROL_ATTEMPT'),('W','WORKER_APPLICATION'),('O','APPLIED_OBSERVATION'),('O','EXIT_OBSERVATION'),('O','CLEANUP_OBSERVATION'),('L','FINAL_INVENTORY'))):
            if index>=stop:break
            payload=self.payload(kind,accepted)
            if transform:transform(kind,payload)
            row=endpoints[role].encode(kind,payload)
            if role in self.witnesses:self.witnesses[role].add(sha(row))
            result=self.contract.accept(row);accepted.append(row)
        return result,accepted,endpoints
    def test_complete_chain_preserves_no_effect_and_unadopted_status(self):
        before=list(self.api.calls);result,rows,endpoints=self.chain()
        self.assertEqual(result['status'],'ARTIFICIAL_EVIDENCE_CHAIN_ACCEPTED');self.assertEqual(result['accepted_stages'],6)
        self.assertFalse(result['operational_acceptance']);self.assertFalse(result['scientific_acceptance']);self.assertFalse(result['release'])
        self.assertEqual(result['host_actions'],0);self.assertEqual(before,self.api.calls)
    def test_incomplete_bootstrap_cannot_construct_deployment(self):
        self.make_boot();self.assertRaises(ValueError,self.d.DeploymentContract,self.boot,old.A,self.verifiers)
    def test_changed_deployment_effect_or_scope_fails_closed(self):
        for change in ('effects','scope_digest','actors','extra'):
            self.setUp();row=self.contract.request()
            if change=='effects':row['effects']['launch']=True
            elif change=='scope_digest':row['scope_digest']=old.B
            elif change=='actors':row['actors']['W']=row['actors']['S']
            else:row['key']='NO_SECRET_ALLOWED'
            self.assertRaises(ValueError,self.contract.validate_request,row)
            self.assertRaises(ValueError,self.contract.request)
    def test_handoff_has_own_key_only_and_metadata_has_no_key_material(self):
        endpoints=self.endpoints();request=self.contract.request();self.assertEqual(request['transport'],'IN_MEMORY_ONLY')
        for role,endpoint in endpoints.items():
            self.assertEqual([v for v in vars(endpoint).values() if isinstance(v,bytes)],[old.credentials()[role]['key']])
        for c in old.credentials().values():self.assertNotIn(c['key'],canonical(request))
        self.assertNotIn('OWNER',request['actors'])
    def test_ticket_cannot_be_reissued_or_consumed_twice(self):
        ticket=self.contract.ticket('W',20);self.contract.consume('W',ticket)
        self.assertRaises(ValueError,self.contract.consume,'W',ticket)
        self.assertRaises(ValueError,self.contract.ticket,'W',20)
    def test_ticket_wrong_role_and_correctly_signed_substitute_fail(self):
        for mutate in ('ROLE','EXPIRY'):
            self.setUp();ticket=self.contract.ticket('W',20)
            if mutate=='ROLE':ticket['role']='S'
            else:ticket['expires_tick']=19;ticket['tag']=self.d.tag(old.credentials()['OWNER']['key'],'HANDOFF',{k:v for k,v in ticket.items() if k!='tag'})
            self.assertRaises(ValueError,self.contract.consume,'W',ticket)
    def test_ticket_expiry_equality_does_not_revive(self):
        ticket=self.contract.ticket('W',20);self.clock.tick=20
        self.assertRaises(ValueError,self.contract.consume,'W',ticket)
        self.clock.tick=10;self.assertRaises(ValueError,self.contract.consume,'W',ticket)
    def test_ticket_extension_and_boolean_expiry_rejected(self):
        for expiry in (True,31,10):
            self.setUp();self.assertRaises(ValueError,self.contract.ticket,'W',expiry)
    def test_revocation_reaches_endpoint_and_acceptance(self):
        endpoint=self.endpoints()['S'];row=endpoint.encode('CONTROL_ATTEMPT',self.payload('CONTROL_ATTEMPT',[]))
        self.auth.revoke('OWNER');self.assertRaises(ValueError,self.contract.accept,row)
        self.assertRaises(ValueError,endpoint.encode,'CONTROL_ATTEMPT',self.payload('CONTROL_ATTEMPT',[]))
    def test_clock_rollback_quarantines_contract(self):
        self.contract.request();self.clock.tick=9;self.assertRaises(ValueError,self.contract.request)
        self.clock.tick=10;self.assertRaises(ValueError,self.contract.request)
    def test_clock_frequency_change_rejected(self):
        self.clock.frequency_hz=1;self.assertRaises(ValueError,self.contract.request)
    def test_evidence_cross_run_reuse_with_same_fixture_keys_rejected(self):
        row=self.endpoints()['S'].encode('CONTROL_ATTEMPT',self.payload('CONTROL_ATTEMPT',[]))
        run=old.run_context();run['run_id']='ART_OTHER_DEPLOYMENT';self.make_boot(run);self.admitted()
        second=self.d.DeploymentContract(self.boot,old.A,self.verifiers)
        self.assertRaises(ValueError,second.accept,row)
    def test_valid_wrong_role_mac_cannot_replace_supervisor(self):
        row=self.endpoints()['S'].encode('CONTROL_ATTEMPT',self.payload('CONTROL_ATTEMPT',[]))
        row['role']='C';row['actor_digest']=sha(self.boot.actor('C'));row['credential_id']='ART_KEY_C'
        row['tag']=self.d.tag(old.credentials()['C']['key'],'EVIDENCE',{k:v for k,v in row.items() if k!='tag'})
        self.assertRaises(ValueError,self.contract.accept,row)
    def test_worker_receipt_cannot_skip_control_attempt(self):
        row=self.endpoints()['W'].encode('WORKER_APPLICATION',dict(attempt_digest=old.A,terminal='STOP_APPLIED'))
        self.assertRaises(ValueError,self.contract.accept,row)
    def test_unknown_delivery_never_advances_to_application(self):
        row=self.endpoints()['S'].encode('CONTROL_ATTEMPT',dict(slot_digest=sha(self.boot.binding()),delivery_status='UNKNOWN'))
        self.assertRaises(ValueError,self.contract.accept,row)
    def test_bad_signature_or_role_chain_rejected(self):
        for field,value in (('tag','0'*64),('sequence',2),('previous_digest',old.A),('tick',11)):
            self.setUp();row=self.endpoints()['S'].encode('CONTROL_ATTEMPT',self.payload('CONTROL_ATTEMPT',[]));row[field]=value
            if field!='tag':row['tag']=self.d.tag(old.credentials()['S']['key'],'EVIDENCE',{k:v for k,v in row.items() if k!='tag'})
            self.assertRaises(ValueError,self.contract.accept,row)
    def test_mac_without_independent_witness_cannot_credit_observation(self):
        result,accepted,endpoints=self.chain(2);self.assertEqual(result['status'],'ARTIFICIAL_EVIDENCE_PREFIX_ACCEPTED')
        row=endpoints['O'].encode('APPLIED_OBSERVATION',self.payload('APPLIED_OBSERVATION',accepted))
        self.assertRaises(ValueError,self.contract.accept,row)
    def test_witness_exception_and_truthy_nonboolean_fail_closed(self):
        for behavior in ('RAISE','TRUTHY'):
            self.setUp()
            def bad(row):
                if behavior=='RAISE':raise RuntimeError('artificial witness unavailable')
                return 1
            self.contract=self.d.DeploymentContract(self.boot,old.A,{'O':bad,'L':self.verifiers['L']})
            self.assertRaises(ValueError,self.chain,3)
    def test_same_witness_callable_cannot_fill_both_independent_seats(self):
        same=lambda row:True
        self.assertRaises(ValueError,self.d.DeploymentContract,self.boot,old.A,{'O':same,'L':same})
    def test_exit_code_boolean_and_inventory_uncertainty_fail(self):
        for bad_kind in ('EXIT_OBSERVATION','CLEANUP_OBSERVATION'):
            self.setUp()
            def mutate(kind,payload):
                if kind==bad_kind:
                    if kind=='EXIT_OBSERVATION':payload['exit_code']=True
                    else:payload['inventory']['W']['uncertainty']=True
            self.assertRaises(ValueError,self.chain,6,mutate)
    def test_final_observer_cannot_replace_external_launcher_inventory(self):
        result,accepted,endpoints=self.chain(5)
        self.assertEqual(result['accepted_stages'],5)
        self.assertRaises(ValueError,endpoints['O'].encode,'FINAL_INVENTORY',self.payload('FINAL_INVENTORY',accepted))
    def test_control_and_cleanup_expiry_equalities_block_records(self):
        for tick,stop in ((60,0),(80,2)):
            self.setUp()
            if stop:
                result,accepted,endpoints=self.chain(stop);role,kind='O','APPLIED_OBSERVATION'
            else:endpoints=self.endpoints();accepted=[];role,kind='S','CONTROL_ATTEMPT'
            self.clock.tick=tick;self.assertRaises(ValueError,endpoints[role].encode,kind,self.payload(kind,accepted))
    def test_inventory_requires_every_exact_role_and_prior_record(self):
        for bad in ('MISSING','EXTRA','PRIOR'):
            self.setUp()
            def mutate(kind,payload):
                if kind=='FINAL_INVENTORY':
                    if bad=='MISSING':payload['inventory'].pop('O')
                    elif bad=='EXTRA':payload['inventory']['L']=payload['inventory']['O']
                    else:payload['cleanup_evidence_digest']=old.A
            self.assertRaises(ValueError,self.chain,6,mutate)
    def test_root_metadata_drift_and_quarantine_block_handoff(self):
        for failure in ('TARGET','QUARANTINE'):
            self.setUp();ticket=self.contract.ticket('W',20)
            if failure=='TARGET':self.boot._target['lease_id']='MUTATED'
            else:self.boot._abort('ARTIFICIAL_TEST',ValueError())
            self.assertRaises(ValueError,self.contract.consume,'W',ticket)

    def test_review_final_witness_revocation_blocks_commit(self):
        def final(row):self.auth.revoke('OWNER');return True
        self.contract=self.d.DeploymentContract(self.boot,old.A,{'O':self.verifiers['O'],'L':final})
        self.assertRaises(ValueError,self.chain)
        self.assertTrue(self.contract.failed);self.assertEqual(len(self.contract._accepted),5)

    def test_review_final_witness_cleanup_expiry_blocks_commit(self):
        def final(row):self.clock.tick=80;return True
        self.contract=self.d.DeploymentContract(self.boot,old.A,{'O':self.verifiers['O'],'L':final})
        self.assertRaises(ValueError,self.chain)
        self.assertTrue(self.contract.failed);self.assertEqual(len(self.contract._accepted),5)

    def test_review_caught_nested_failure_cannot_be_accepted_outside(self):
        def final(row):
            try:self.contract.accept({})
            except ValueError:pass
            return True
        self.contract=self.d.DeploymentContract(self.boot,old.A,{'O':self.verifiers['O'],'L':final})
        self.assertRaises(ValueError,self.chain)
        self.assertTrue(self.contract.failed);self.assertEqual(len(self.contract._accepted),5)

    def test_review_reentrant_same_record_cannot_consume_two_stages(self):
        entered=[]
        def observer(row):
            if not entered:
                entered.append(True)
                try:self.contract.accept(row)
                except ValueError:pass
            return True
        self.contract=self.d.DeploymentContract(self.boot,old.A,{'O':observer,'L':self.verifiers['L']})
        self.assertRaises(ValueError,self.chain,3)
        self.assertEqual(len(self.contract._accepted),2);self.assertTrue(self.contract.failed)

    def test_review_endpoint_construction_error_is_local_not_intake(self):
        endpoint=self.endpoints()['S']
        self.assertRaises(ValueError,endpoint.encode,'FINAL_INVENTORY',{})
        self.assertRaises(ValueError,endpoint.encode,'CONTROL_ATTEMPT',{'blob':'X'*9000})
        row=endpoint.encode('CONTROL_ATTEMPT',self.payload('CONTROL_ATTEMPT',[]))
        self.assertEqual(row['sequence'],1)
        self.assertEqual(self.contract.accept(row)['accepted_stages'],1)

    def test_review_direct_oversized_and_signed_malformed_payload_rejected(self):
        for payload in ({'blob':'X'*9000},{'slot_digest':old.A,'delivery_status':'ATTEMPTED'}):
            self.setUp();self.endpoints()
            row=dict(protocol='WP06_EVIDENCE_V1_ARTIFICIAL',deployment_digest=self.contract.deployment_digest,role='S',actor_digest=sha(self.boot.actor('S')),
                credential_id='ART_KEY_S',kind='CONTROL_ATTEMPT',sequence=1,previous_digest='0'*64,tick=10,payload=payload)
            row['tag']=self.d.tag(old.credentials()['S']['key'],'EVIDENCE',row)
            self.assertRaises(ValueError,self.contract.accept,row);self.assertTrue(self.contract.failed)

    def test_review_construction_does_not_add_native_api_calls(self):
        before=list(self.api.calls)
        contract=self.d.DeploymentContract(self.boot,old.A,self.verifiers);contract.validate_request(contract.request())
        self.assertEqual(before,self.api.calls)
