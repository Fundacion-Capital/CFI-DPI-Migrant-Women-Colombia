"""In-process synthetic lifecycle. No process, pipe, service or engine backend."""
import copy
import hashlib
import json
import re
import threading
from journal import Journal,integer,validate_binding
from protocol import Verifier,RESULTS,encode,sign,_registry

LIVE=('service_changes','live_probes','stata_execution','participant_processing','fits','live_stop_calls','process_kills','release')

class FixtureRegistry:
    """Trusted fixture registrar, not an operating-system identity authority."""
    def __init__(self,binding,credentials):
        self._lock=threading.RLock();self._current=validate_binding(binding);self._credentials=_registry(credentials)
    def replace(self,binding):
        with self._lock:self._current=validate_binding(binding)

class Harness:
    def __init__(self,journal,trusted_fixture_registry,clock):
        if type(journal) is not Journal or type(trusted_fixture_registry) is not FixtureRegistry or not callable(clock):raise ValueError('Exact trusted fixture components required')
        self.journal=journal;self.registry=trusted_fixture_registry;self._clock=clock;self._last=0
        self._state='ART_REGISTERED';self._reason='ART_REGISTERED';self._bound=None
        self._dispatches=0;self._intents=0;self._applied=0;self._delivery=False;self._exit=False;self._cleanup=False
        self._execution_deadline=None;self._cleanup_deadline=None;self._intent=None;self._stop_at=None;self._applied_at=None;self._exit_at=None

    def _quarantine(self,reason):
        if self._state in ('ART_COMPLETE','UNKNOWN_QUARANTINED'):return
        self._state='UNKNOWN_QUARANTINED';self._reason=reason
        if self._bound is not None and not self.journal.blocked:
            try:self.journal.append(self._bound,'QUARANTINED',{'reason':'ART_FIXTURE'})
            except ValueError:pass

    def _fail(self,reason):
        self._quarantine(reason);raise ValueError(reason)

    def _now(self):
        try:now=integer(self._clock())
        except Exception:self._fail('ART_INVALID_CLOCK')
        if now<self._last:self._fail('ART_CLOCK_ROLLBACK')
        self._last=now;return now

    def _guard(self):
        if self._state in ('ART_COMPLETE','UNKNOWN_QUARANTINED'):raise ValueError('Terminal consumed fixture')
        if self._bound is not None:
            if self.registry._current!=self._bound:self._fail('ART_REPLACED_IDENTITY')
            try:status=self.journal.status(self._bound)
            except ValueError:self._fail('ART_JOURNAL_UNKNOWN')
            if self.journal.blocked or status in (None,'QUARANTINED','CLEANUP_OBSERVED'):self._fail('ART_OLD_CONSUMED_LEASE')

    def _record(self,kind):
        try:return self.journal.append(self._bound,kind,{'reason':'ART_FIXTURE'})
        except ValueError:self._fail('ART_JOURNAL_COMMIT_UNKNOWN')

    def reserve(self,binding,execution_ns,cleanup_ns):
        with self.registry._lock:
            self._guard()
            if self._state!='ART_REGISTERED':self._fail('ART_ALREADY_RESERVED')
            try:
                bound=validate_binding(binding);execution=integer(execution_ns,True);cleanup=integer(cleanup_ns,True);now=self._now()
                execution_deadline=integer(now+execution);total=integer(execution_deadline+cleanup)
                if bound!=self.registry._current:raise ValueError('Unregistered synthetic binding')
            except ValueError:self._fail('ART_INVALID_RESERVATION')
            self._bound=bound
            try:receipt=self.journal.reserve(bound)
            except ValueError:self._fail('ART_RESERVATION_UNKNOWN')
            self._start=now;self._cleanup_allowance=cleanup;self._execution_deadline=execution_deadline;self._total=total;self._cleanup_deadline=total
            self._verifier=Verifier(self.registry._credentials,deliver_by=total);self._state='ART_RESERVED'
            return receipt

    def arm(self,binding,clock_domain):
        with self.registry._lock:
            self._guard();now=self._now()
            expected={k:self._bound[k] for k in ('host_id','boot_id','clock_domain')} if self._bound else {}
            expected['translation_delay_ns']=0
            try:matched=validate_binding(binding)==self._bound
            except ValueError:self._fail('ART_MALFORMED_ARM')
            if self._state!='ART_RESERVED' or not matched or type(clock_domain) is not dict or clock_domain!=expected or type(clock_domain.get('translation_delay_ns')) is not int or any(type(clock_domain.get(k)) is not str for k in ('host_id','boot_id','clock_domain')) or now>=self._execution_deadline:self._fail('ART_UNSAFE_ARM')
            self._record('ARM');self._state='ART_ARMED'

    def dispatch(self):
        with self.registry._lock:
            self._guard();now=self._now()
            if self._state!='ART_ARMED' or now>=self._execution_deadline:self._fail('ART_DISPATCH_DENIED')
            self._record('DISPATCH_INTENT');self._record('DISPATCH_OBSERVED')
            self._dispatches+=1;self._state='ART_RUNNING'

    def _stop(self,now):
        deadline=integer(min(self._total,now+self._cleanup_allowance))
        body=dict(kind='ART_STOP_INTENT',binding=dict(self._bound,pid=str(self._bound['pid']),worker_epoch=str(self._bound['worker_epoch'])),
            sequence='1',previous_digest='0'*64,timestamp_ns=str(now),issuer='ART_CONTROL',credential_id='ART_CONTROL_KEY',reason='ART_FIXTURE',
            payload_digest=hashlib.sha256(b'{"action":"ART_STOP_INTENT"}').hexdigest(),result='ART_REQUESTED')
        intent=sign(body,'ART_CONTROL_KEY',self.registry._credentials)
        self._record('STOP_INTENT')
        self._cleanup_deadline=deadline;self._verifier.deadline=deadline;self._stop_at=now;self._intent=intent
        self._intents+=1;self._state='ART_STOP_REQUESTED';return intent

    def cancel(self):
        with self.registry._lock:
            self._guard();now=self._now()
            if self._state=='ART_REGISTERED':self._fail('ART_CANCELLED_BEFORE_RESERVATION')
            if self._state in ('ART_RESERVED','ART_ARMED'):
                self._quarantine('ART_PRESTART_CANCELLED');return None
            if now>=self._cleanup_deadline:
                self._quarantine('ART_CLEANUP_EXPIRED');return None
            if self._state=='ART_STOP_REQUESTED':return None
            if self._state!='ART_RUNNING':self._fail('ART_CANCEL_STATE')
            return self._stop(now)

    def tick(self):
        with self.registry._lock:
            self._guard();now=self._now()
            if self._execution_deadline is None:self._fail('ART_NO_LEASE')
            if now>=self._cleanup_deadline:
                self._quarantine('ART_CLEANUP_EXPIRED');return None
            if now>=self._execution_deadline:
                if self._state in ('ART_RESERVED','ART_ARMED'):
                    self._quarantine('ART_UNSTARTED_EXPIRED');return None
                if self._state=='ART_RUNNING':return self._stop(now)
            return None

    def receive(self,envelope):
        with self.registry._lock:
            self._guard();now=self._now()
            deadline=self._cleanup_deadline if self._stop_at is not None else self._execution_deadline
            if deadline is None or now>=deadline:self._fail('ART_LATE_RECEIPT')
            try:
                if type(envelope) is not bytes or len(envelope)>8192:raise ValueError('Bounded wire bytes')
                preview=json.loads(envelope.decode('ascii'));kind=preview['body']['kind']
                if kind not in RESULTS:raise ValueError('Unknown event kind')
                body=self._verifier.consume(envelope,self._bound,kind,now);at=int(body['timestamp_ns'])
            except (ValueError,TypeError,KeyError,RecursionError,UnicodeError):self._fail('ART_UNVERIFIED_RECEIPT')
            if at<self._start:self._fail('ART_BEFORE_RESERVATION')
            if kind=='ART_STOP_INTENT':
                if self._state!='ART_STOP_REQUESTED' or envelope!=self._intent or self._applied or at!=self._stop_at:self._fail('ART_UNEXPECTED_CONTROL')
                self._record('STOP_APPLIED');self._applied+=1;self._applied_at=now
            elif kind=='ART_STOP_APPLIED':
                if self._state!='ART_STOP_REQUESTED' or not self._applied or self._delivery or at<self._applied_at:self._fail('ART_DELIVERY_ORDER')
                self._record('STOP_APPLIED');self._delivery=True
            elif kind=='ART_EXIT_OBSERVED':
                if self._state not in ('ART_RUNNING','ART_STOP_REQUESTED') or self._exit:self._fail('ART_EXIT_ORDER')
                if self._stop_at is not None and self._delivery and at<self._applied_at:self._fail('ART_EXIT_BEFORE_DELIVERY')
                self._record('EXIT_OBSERVED');self._exit=True;self._exit_at=at
                if self._stop_at is not None and not self._delivery:self._fail('ART_EXIT_CAUSE_UNKNOWN')
                self._state='ART_EXIT_OBSERVED'
            else:
                if self._state!='ART_EXIT_OBSERVED' or not self._exit or at<self._exit_at:self._fail('ART_CLEANUP_ORDER')
                self._record('CLEANUP_OBSERVED');self._cleanup=True;self._state='ART_COMPLETE';self._reason='ART_FIXTURE_COMPLETE_ONLY'

    def snapshot(self):
        with self.registry._lock:
            return dict(origin='ARTIFICIAL_ONLY',state=self._state,reason=self._reason,dispatch_count=self._dispatches,
                stop_intent_count=self._intents,stop_applied_count=self._applied,delivery_confirmed=self._delivery,
                exit_observed=self._exit,cleanup_confirmed=self._cleanup,quarantined=self._state=='UNKNOWN_QUARANTINED',
                execution_deadline=self._execution_deadline,cleanup_deadline=self._cleanup_deadline)

    def public_summary(self,case_id):
        if type(case_id) is not str or not re.fullmatch('AC(0[1-9]|1[0-6])',case_id):raise ValueError('Stage-A case required')
        s=self.snapshot()
        return dict(origin='ARTIFICIAL_ONLY',case_id=case_id,status=s['state'],dispatch_count=s['dispatch_count'],stop_intent_count=s['stop_intent_count'],
            stop_applied_count=s['stop_applied_count'],quarantined=s['quarantined'],live_authorities={key:0 for key in LIVE})

    def authorize(self,action):return False
