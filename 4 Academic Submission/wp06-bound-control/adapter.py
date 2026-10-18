"""Isolated artificial-only control kernel. Emits intents; has no live transport."""
import math
import threading

FIELDS=('origin','session_id','owner_nonce','worker_epoch','command_id','pid','creation_time','engine_module_digest','reservation_id')
TERMINAL=('EXIT_CONFIRMED','UNKNOWN_QUARANTINED')

def number(value):
    if type(value) not in (int,float):
        raise ValueError('Finite numeric value required')
    try:converted=float(value)
    except (ValueError,OverflowError):raise ValueError('Finite numeric value required') from None
    if not math.isfinite(converted):raise ValueError('Finite numeric value required')
    return converted

def identity(value):
    if type(value) is not dict or set(value)!=set(FIELDS) or type(value['origin']) is not str or value['origin']!='ARTIFICIAL_ONLY':
        raise ValueError('Exact artificial binding required')
    for key in FIELDS[1:]:
        item=value[key]
        if key in ('worker_epoch','pid'):
            if type(item) is not int or item<=0:raise ValueError('Positive artificial integer required')
        elif type(item) is not str or not item.startswith('ART_') or len(item)<=4:
            raise ValueError('Artificial identity tokens required; no default/live identities')
    return tuple(value[k] for k in FIELDS)

class ReservationBook:
    """Consumed for this in-memory book's lifetime; not a durable live ledger."""
    def __init__(self):
        self._lock=threading.Lock();self._reservations=set();self._commands=set()
    def _claim(self,bound):
        values=dict(zip(FIELDS,bound));reservation=values['reservation_id']
        command=(values['session_id'],values['worker_epoch'],values['command_id'])
        with self._lock:
            if reservation in self._reservations or command in self._commands:
                raise ValueError('Reservation or command already consumed')
            self._reservations.add(reservation);self._commands.add(command)

class DeliveryGate:
    """Freeze a trusted artificial intent; consume under the channel's identity lock."""
    @staticmethod
    def _intent(value):
        if type(value) is not dict or set(value)!= {'binding','issued_at','deliver_by'}:
            raise ValueError('Exact artificial intent required')
        bound=identity(value['binding']);issued=number(value['issued_at']);deadline=number(value['deliver_by'])
        if deadline<=issued:raise ValueError('Empty delivery interval')
        return bound,issued,deadline
    def __init__(self,intent):
        self._expected=self._intent(intent);self._last=self._expected[1]
        self._used=False;self._closed=False;self._lock=threading.Lock()
    def consume(self,intent,current,now):
        with self._lock:
            if self._closed:raise ValueError('Delivery gate quarantined')
            try:
                parsed=self._intent(intent);at=number(now)
                if at<self._last or parsed!=self._expected or identity(current)!=parsed[0] or not parsed[1]<=at<parsed[2]:
                    raise ValueError('Rollback, altered, unowned or expired delivery')
                self._last=at
            except ValueError:
                self._closed=True
                raise
            if self._used:return None
            self._used=True
            return dict(kind='ART_DELIVERY_AUTHORIZED',binding=dict(zip(FIELDS,parsed[0])),observed_at=at)

class BoundControl:
    def __init__(self,binding,*,clock,reservations,execution_budget,cleanup_budget):
        self._bound=identity(binding)
        execution=number(execution_budget);self._cleanup_budget=number(cleanup_budget)
        if execution<=0 or self._cleanup_budget<=0 or not callable(clock) or type(reservations) is not ReservationBook:
            raise ValueError('Explicit positive budgets, clock and artificial reservation book required')
        self._clock=clock;self._last=number(clock())
        self._execution_deadline=number(self._last+execution)
        self._cleanup_deadline=number(self._execution_deadline+self._cleanup_budget)
        self._lock=threading.RLock();self._state='RESERVED';self._reason='RESERVED_ARTIFICIAL'
        self._stop_at=None;self._delivery_at=None;self._started_at=None;self._stop_intents=0
        reservations._claim(self._bound)

    def _reject(self,reason):
        if self._state not in TERMINAL:self._state='UNKNOWN_QUARANTINED';self._reason=reason
        raise ValueError(reason)

    def _now(self):
        try:now=number(self._clock())
        except Exception:self._reject('INVALID_CLOCK')
        if now<self._last:self._reject('CLOCK_ROLLBACK')
        self._last=now
        return now

    def _match(self,current):
        try:bound=identity(current)
        except ValueError:self._reject('INVALID_CURRENT_IDENTITY')
        if bound!=self._bound:self._reject('OWNERSHIP_CHANGED')

    def _quarantine(self,reason):
        if self._state not in TERMINAL:self._state='UNKNOWN_QUARANTINED';self._reason=reason

    def _stop(self,now):
        deadline=number(min(self._cleanup_deadline,now+self._cleanup_budget))
        self._state='STOP_REQUESTED';self._reason='ARTIFICIAL_STOP_INTENT'
        self._stop_at=now;self._stop_intents+=1
        self._cleanup_deadline=deadline
        return dict(binding=dict(zip(FIELDS,self._bound)),issued_at=now,deliver_by=self._cleanup_deadline)

    def start(self,current):
        with self._lock:
            now=self._now();self._match(current)
            if self._state!='RESERVED':self._reject('CANNOT_RESTART_CONSUMED_SLOT')
            if now>=self._execution_deadline:self._reject('EXPIRED_BEFORE_START')
            self._state='RUNNING_BOUND';self._started_at=now;self._reason='ARTIFICIAL_RUNNING'

    def cancel(self,current):
        with self._lock:
            now=self._now();self._match(current)
            if self._state in TERMINAL:return None
            if now>=self._cleanup_deadline:self._quarantine('CLEANUP_DEADLINE');return None
            if self._state=='STOP_REQUESTED':return None
            if self._state=='RESERVED':self._quarantine('CANCELLED_BEFORE_START');return None
            if now>=self._cleanup_deadline:self._quarantine('CLEANUP_DEADLINE');return None
            return self._stop(now)

    def tick(self,current):
        with self._lock:
            now=self._now();self._match(current)
            if self._state in TERMINAL:return None
            if now>=self._cleanup_deadline:self._quarantine('CLEANUP_DEADLINE');return None
            if now>=self._execution_deadline:
                if self._state=='RESERVED':self._quarantine('EXPIRED_BEFORE_START');return None
                if self._state=='RUNNING_BOUND':return self._stop(now)
            return None

    def _receipt(self,receipt,kind,now,earliest):
        if type(receipt) is not dict or set(receipt)!= {'kind','binding','observed_at'}:
            self._reject('INVALID_RECEIPT_SCHEMA')
        self._match(receipt['binding'])
        try:at=number(receipt['observed_at'])
        except ValueError:self._reject('INVALID_RECEIPT_TIME')
        if type(receipt['kind']) is not str or receipt['kind']!=kind or not earliest<=at<=now:self._reject('UNVERIFIED_OR_UNORDERED_RECEIPT')
        return at

    def delivery(self,receipt,*,current):
        with self._lock:
            now=self._now();self._match(current)
            if self._state!='STOP_REQUESTED' or now>=self._cleanup_deadline:self._reject('LATE_OR_UNREQUESTED_DELIVERY')
            at=self._receipt(receipt,'ART_EVENT_SET',now,self._stop_at)
            if self._delivery_at is not None:
                if at!=self._delivery_at:self._reject('CONFLICTING_DELIVERY')
                return
            self._delivery_at=at

    def complete(self,exit_receipt,cleanup_receipt,*,current):
        with self._lock:
            now=self._now();self._match(current)
            if self._state not in ('RUNNING_BOUND','STOP_REQUESTED'):self._reject('TERMINAL_OR_UNSTARTED_COMPLETION')
            deadline=self._execution_deadline if self._state=='RUNNING_BOUND' else self._cleanup_deadline
            if now>=deadline:self._reject('LATE_COMPLETION')
            if self._state=='STOP_REQUESTED' and self._delivery_at is None:self._reject('DELIVERY_UNAVAILABLE')
            earliest=self._delivery_at if self._delivery_at is not None else self._started_at
            exited=self._receipt(exit_receipt,'ART_EXIT_CONFIRMED',now,earliest)
            self._receipt(cleanup_receipt,'ART_CLEANUP_COMPLETE',now,exited)
            self._state='EXIT_CONFIRMED';self._reason='ARTIFICIAL_EXIT_AND_CLEANUP_ONLY'

    def controller_lost(self):
        with self._lock:self._quarantine('CONTROLLER_LOST')

    def snapshot(self):
        with self._lock:
            return dict(origin='ARTIFICIAL_ONLY',binding=dict(zip(FIELDS,self._bound)),state=self._state,reason=self._reason,
                consumed=True,stop_intents=self._stop_intents,delivery_confirmed=self._delivery_at is not None,
                execution_deadline=self._execution_deadline,cleanup_deadline=self._cleanup_deadline,
                fits=0,participant_processing=0,service_changes=0,live_stop_calls=0,process_kills=0)
