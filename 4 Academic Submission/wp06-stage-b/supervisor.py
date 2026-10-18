"""Sole-consumer deterministic supervisor; no thread, timer or actor starts here."""
import copy
from journal_protocol import validate_binding,require,integer,exact,sha

class Supervisor:
    def __init__(self,binding,bridge,clock,journal):
        self._binding=validate_binding(binding);self._bridge=bridge;self._clock=clock;self._journal=journal
        self._slot=None;self._token=None;self._consumed=False;self._quarantined=False;self._receipt=None
    @property
    def dispatch_allowed(self):return self._slot is not None and not self._consumed and not self._quarantined
    def arm(self,slot,admission):
        require(self._slot is None and not self._quarantined,'Already armed/quarantined')
        require(type(admission) is dict and admission.get('stage')=='PREARM_WORK_FAULT','Wrong phase')
        self._bridge._admit('PREARM_WORK_FAULT')
        require(slot.get('binding')==self._binding and self._journal.verify_slot(slot),'No matching durable precommit')
        require(slot['status']=='ARMED_UNUSED' and slot['slot_id']==sha(self._binding) and self._clock.now_tick()<slot['deadline_tick'],'Invalid/expired slot')
        self._token=self._bridge.worker_token(self._binding)
        self._bridge.arm_cooperative(self._token,self._binding,slot['deadline_tick']);self._slot=copy.deepcopy(slot)
        return dict(kind='SUPERVISOR_ARMED',binding=copy.deepcopy(self._binding),slot_id=slot['slot_id'])
    def quarantine(self,reason):
        require(type(reason) is str and bool(reason),'Reason required');self._quarantined=True
    def step(self,now_tick,controller_observation,request):
        integer(now_tick);require(now_tick==self._clock.now_tick(),'Untrusted/discontinuous clock')
        if self._consumed:return dict(kind='ALREADY_CONSUMED',retry=False)
        if self._quarantined:return dict(kind='QUARANTINED',retry=False)
        require(self._slot is not None,'Supervisor not armed')
        due=now_tick>=self._slot['deadline_tick']
        if not due:
            try:
                observation=controller_observation
                require(self._bridge.verify_control_observation(observation),'Unverified controller observation')
                exact(observation,{'binding','alive','heartbeat_tick','heartbeat_loss_tick','evidence_ref'})
                require(type(observation['alive']) is bool,'Unknown liveness');integer(observation['heartbeat_tick']);integer(observation['heartbeat_loss_tick'],True)
                require(observation['heartbeat_tick']<=now_tick and observation['heartbeat_loss_tick']>=observation['heartbeat_tick'],'Invalid heartbeat ordering')
                due=not observation['alive'] or now_tick>=observation['heartbeat_loss_tick']
                if not due and request is not None:due=self._bridge.verify_control_observation(request) and request.get('kind')=='REQUEST'
            except (ValueError,KeyError,TypeError):due=False
        if not due:return dict(kind='WAITING',dispatch_allowed=True)
        self._consumed=True
        try:receipt=self._bridge.signal_cooperative(self._token,self._binding)
        except Exception:receipt=dict(binding=copy.deepcopy(self._binding),slot_id=self._slot['slot_id'],attempt_tick=now_tick,delivery_status='UNKNOWN')
        self._receipt=dict(**receipt,kind='CONTROL_ATTEMPT',application_proven=False,evidence_domain='ARTIFICIAL')
        # Persistence is explicitly off the deadline path; no response/journal wait here.
        return copy.deepcopy(self._receipt)
    def flush_receipt(self):
        require(self._consumed and self._receipt is not None,'No consumed attempt')
        try:self._journal.record_after_attempt(self._receipt);return dict(disposition='RECORDED',retry=False)
        except ValueError:return dict(disposition='HOLD',retry=False)
