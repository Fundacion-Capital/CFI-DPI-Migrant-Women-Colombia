"""Explicit bounded role entry functions; no launcher, scheduler or live CLI.

Each callable can be exercised against the real adapter using an artificial API.
Independent process scheduling and cross-process credentials are NOT established
by executing these functions serially in a test interpreter.
"""
import copy
import hashlib
import hmac
from actors import worker_step,controller_step
from supervisor import Supervisor
from observer import assess_case
from journal_protocol import require,integer,sha,canonical,verify_message,digest


class RoleRuntime:
    def __init__(self,bridge,backend,provider,clock,journal,worker,event,self_ceiling_tick):
        require(getattr(backend,'evidence_domain',None)=='ARTIFICIAL' and getattr(provider,'evidence_domain',None)=='ARTIFICIAL','Unadopted runtime provider')
        require(bridge._native is backend and bridge._clock is clock and bridge._owner=='S','Pinned supervisor/native ownership required')
        binding=bridge.capture_identity(worker)
        require(binding==provider.binding and clock.domain==binding['clock_domain'] and clock.frequency_hz==int(binding['qpc_frequency_hz']),'Provider/clock binding mismatch')
        row=backend._row(worker,'PROCESS')
        require(row['event']==event and row['pipe'] is not None,'Authenticated attached control channel required')
        integer(self_ceiling_tick,True)
        require(self_ceiling_tick<=bridge._scope['cleanup_deadline_tick'],'Worker ceiling exceeds cleanup')
        self.bridge=bridge;self.backend=backend;self.provider=provider;self.clock=clock
        self.journal=journal;self.worker=worker;self.event=event;self.binding=binding
        self.supervisor=Supervisor(binding,bridge,clock,journal)
        self.state=dict(binding=copy.deepcopy(binding),sequence=0,previous_digest='0'*64,phase='READY',terminal=None,
                        self_ceiling_tick=self_ceiling_tick,verify_control=provider.verify_control)
        self.controller=copy.deepcopy(self.state)
        self.controller['self_ceiling_tick']=bridge._scope['control_deadline_tick']
        self.armed=False;self.attempt=None;self.application=None;self.exit=None;self.assessment=None

    def arm(self,deadline_tick):
        require(not self.armed,'No re-arm/retry')
        integer(deadline_tick,True)
        require(deadline_tick<self.state['self_ceiling_tick'],'Stop deadline must precede worker self-ceiling')
        self.bridge._admit('PREARM_WORK_FAULT')
        slot=self.journal.prepare(self.binding,deadline_tick)
        record=self.supervisor.arm(slot,dict(stage='PREARM_WORK_FAULT'))
        self._authority_generation=self.provider.generation
        self.backend.bind_authority(self.worker,self.provider,self._authority_generation)
        self.armed=True
        return record

    def supervisor_once(self,controller_observation=None,request=None):
        require(self.armed,'Supervisor not armed')
        if not self.provider.authority_current(self._authority_generation):
            self.supervisor.quarantine('Local authority revoked')
        record=self.supervisor.step(self.clock.now_tick(),controller_observation,request)
        if record['kind']=='CONTROL_ATTEMPT':self.attempt=copy.deepcopy(record)
        return record

    def flush_attempt(self):
        return self.supervisor.flush_receipt()

    def worker_once(self,work_blocked=True):
        require(self.armed,'Work before authenticated durable prearm is forbidden')
        require(type(work_blocked) is bool,'Bounded artificial work state required')
        now=self.clock.now_tick();receipt=None
        if self.state['phase']=='READY' and now<self.state['self_ceiling_tick'] and self.backend.event_observed(self.event):
            receipt=self.provider.sign_control(dict(binding=self.binding,slot_id=sha(self.binding),event_observed=True,evidence_ref='PENDING'))
        self.state=worker_step(self.state,control_receipt=receipt,work_blocked=work_blocked,now_tick=now)
        if self.state['terminal']=='STOP_APPLIED' and receipt is not None:self.application=copy.deepcopy(receipt)
        return dict(phase=self.state['phase'],terminal=self.state['terminal'],sequence=self.state['sequence'])

    def controller_once(self):
        require(self.armed,'Controller work before prearm forbidden')
        self.controller=controller_step(self.controller,dict(kind='HEARTBEAT'),self.clock.now_tick())
        if self.controller['phase']=='EXITED':
            return dict(phase='EXITED',terminal=self.controller['terminal'],sequence=self.controller['sequence'],observation=None)
        now=self.clock.now_tick()
        observation=self.provider.sign_status(dict(binding=self.binding,alive=self.controller['phase']=='READY',heartbeat_tick=now,
             heartbeat_loss_tick=min(now+self.provider._age,self.bridge._scope['control_deadline_tick']),evidence_ref='PENDING'))
        return dict(phase=self.controller['phase'],terminal=self.controller['terminal'],sequence=self.controller['sequence'],observation=observation)

    def observe_worker_exit(self):
        self.exit=self.bridge.poll_exit(self.worker,self.bridge._scope['cleanup_deadline_tick'])
        return copy.deepcopy(self.exit)

    def accept_observer_evidence(self,evidence,scope):
        require(type(scope) is dict and scope.get('binding')==self.binding and scope.get('evidence_domain')=='ARTIFICIAL','Explicit independent artificial evidence scope required')
        self.assessment=assess_case(self.bridge._case,evidence,scope['expected_resources'],scope)
        return copy.deepcopy(self.assessment)

    def finish(self):
        return dict(disposition='HOLD',evidence_domain='ARTIFICIAL',attempt_observed=self.attempt is not None,
          worker_application_observed=self.application is not None,same_handle_exit_observed=bool(self.exit and self.exit['signaled']),
          independent_assessment=copy.deepcopy(self.assessment),inventory=self.backend.inventory(),
          operational_acceptance=False,scientific_acceptance=False,cases_executed=0)


def role_entry(role,runtime,max_iterations):
    """Bounded nonblocking callable, never an independent-scheduling claim."""
    require(role in ('L','O','S','C','W'),'Fixed role required');integer(max_iterations,True)
    require(max_iterations<=64,'Iteration budget exceeded')
    actions={'L':runtime.finish,'O':runtime.observe_worker_exit,'S':runtime.supervisor_once,
             'C':runtime.controller_once,'W':runtime.worker_once}
    records=[]
    for _ in range(max_iterations):
        record=actions[role]();records.append(record)
        if record.get('phase')=='EXITED' or record.get('kind') in ('CONTROL_ATTEMPT','ALREADY_CONSUMED','QUARANTINED') or role in ('L','O'):
            break
    return dict(disposition='HOLD',evidence_domain='ARTIFICIAL',iterations=len(records),records=records,
                work_callbacks=0,processes_launched=0,operational_acceptance=False)


class FrameChannel:
    """One bounded message-mode pipe operation; no blocking receive or retry."""
    def __init__(self,backend,pipe,provider,issuer,peer,clock,deadline_tick,bridge=None):
        require(getattr(backend,'evidence_domain',None)=='ARTIFICIAL' and getattr(provider,'evidence_domain',None)=='ARTIFICIAL','Artificial provider required')
        require(issuer in ('L','O','S','C','W') and peer in ('L','O','S','C','W') and issuer!=peer,'Distinct fixed roles required')
        require(issuer in provider._keys and peer in provider._keys,'Role keys unavailable')
        require(bridge is not None and bridge._native is backend and bridge._clock is clock and bridge._owner==issuer,'Pinned admitting Bridge required')
        approved=bridge._admit('PREARM_WORK_FAULT')
        require(approved['binding']==provider.binding,'Channel authority binding mismatch')
        require(deadline_tick<=approved['ipc_deadline_tick']<=approved['cleanup_deadline_tick'],'IPC deadline extension forbidden')
        row=backend._row(pipe,'PIPE');require(row['connected'],'Connected channel required')
        owners=[t for t,r in backend._owned.items() if r['kind']=='PROCESS' and not r['closed'] and r['pipe']==pipe and r['binding']==provider.binding]
        require(len(owners)==1 and not row.get('channel_claimed',False),'No unique unclaimed authenticated pipe')
        require(backend._owned[owners[0]]['role']==peer,'Channel role differs from captured endpoint role')
        require(backend.clock is clock and clock.domain==provider.binding['clock_domain'] and clock.frequency_hz==int(provider.binding['qpc_frequency_hz']),'Channel clock mismatch')
        integer(deadline_tick,True)
        self.backend=backend;self.pipe=pipe;self.provider=provider;self.issuer=issuer;self.peer=peer;self.clock=clock;self.bridge=bridge
        self.deadline=deadline_tick;self._last=clock.now_tick();require(self._last<deadline_tick,'Expired channel')
        self._operation=None;self._kind=None;self._sent=0;self._received=0;self._send_digest='0'*64;self._receive_digest='0'*64
        self.quarantined=False;self.application_proven=False
        row['channel_claimed']=True;self._process=owners[0]

    def _now(self):
        now=self.clock.now_tick();integer(now)
        if now<self._last:
            self.quarantined=True;raise ValueError('Channel clock rollback')
        self._last=now;return now

    def _available(self):
        require(not self.quarantined and self._operation is None,'Quarantined/busy channel')
        now=self._now();require(now<self.deadline,'Channel deadline expired')
        approved=self.bridge._admit('PREARM_WORK_FAULT')
        require(self.deadline<=approved['ipc_deadline_tick'] and now<approved['ipc_deadline_tick'],'Expired/extended approved IPC ceiling')
        return now

    def send(self,kind,reason,result,payload_digest):
        now=self._available();digest(payload_digest)
        require(self.issuer not in self.provider._revoked,'Revoked sender')
        body=dict(binding=self.provider.binding,issuer=self.issuer,credential_id='ART_'+self.issuer+'_CREDENTIAL',sequence=str(self._sent+1),
                  previous_digest=self._send_digest,tick=str(now),frequency=str(self.clock.frequency_hz),kind=kind,reason=reason,result=result,payload_digest=payload_digest)
        body['tag']=hmac.new(self.provider._keys[self.issuer],canonical(body),hashlib.sha256).hexdigest()
        wire=canonical(body)
        verify_message(wire,self.provider.binding,self.provider._keys[self.issuer],self._sent,self._send_digest)
        self._sent+=1;self._send_digest=hashlib.sha256(wire).hexdigest()
        try:self._operation=self.backend._start(self.pipe,wire,'WRITE',origin=self._process);self._kind='WRITE'
        except Exception:self.quarantined=True;raise
        return dict(status='PENDING',operation_id=self._operation)

    def receive(self):
        self._available()
        try:self._operation=self.backend._start(self.pipe,b'','READ',origin=self._process);self._kind='READ'
        except Exception:self.quarantined=True;raise
        return dict(status='PENDING',operation_id=self._operation)

    def poll(self):
        if self.quarantined:return dict(status='HOLD',application_proven=False)
        require(self._operation is not None,'No pending channel operation')
        now=self._now()
        if now>=self.deadline:
            self.quarantined=True
            if self.backend._operations[self._operation]['status']=='PENDING':self.backend.cancel(self._operation)
            return dict(status='HOLD',application_proven=False)
        try:result=self.backend.completion(self._operation)
        except Exception:
            self.quarantined=True
            raise
        if result['status']=='PENDING':return dict(status='PENDING',application_proven=False)
        if result['status']!='SUCCESS':self.quarantined=True;return dict(status='HOLD',application_proven=False)
        if self._kind=='WRITE':self._operation=None;return dict(status='WRITE_COMPLETED',application_proven=False)
        try:
            require(self.peer not in self.provider._revoked,'Revoked peer')
            m=verify_message(result['wire'],self.provider.binding,self.provider._keys[self.peer],self._received,self._receive_digest)
            require(m['issuer']==self.peer and m['credential_id']=='ART_'+self.peer+'_CREDENTIAL','Wrong peer credential')
            require(int(m['tick'])<=now and now-int(m['tick'])<=self.provider._age,'Stale/future frame')
            self._received+=1;self._receive_digest=hashlib.sha256(result['wire']).hexdigest();self._operation=None
            return dict(status='VERIFIED_FRAME',message=m,application_proven=False)
        except (ValueError,KeyError,TypeError,AttributeError):
            self.quarantined=True;raise ValueError('Malformed/untrusted native frame') from None

    def drain(self):
        require(self.quarantined and self._operation is not None,'Only quarantined pending I/O can drain')
        return dict(status=self.backend.completion(self._operation)['status'],message_delivered=False,application_proven=False)


def main(argv=None):
    return 2


if __name__=='__main__':
    raise SystemExit(main())
