"""Exact Stage-B records and pure admission. No host/runtime initialization."""
import copy
import hashlib
import hmac
import json
import re
import os
import pathlib
import sqlite3

MAX_U64=(1<<64)-1
BINDING_FIELDS={'origin','contract_digest','build_digest','host_id','boot_id','observer_epoch','session_id','owner_nonce','worker_epoch','command_id','pid','creation_time_100ns','engine_module_digest','reservation_id','lease_id','scope_id','clock_domain','qpc_frequency_hz'}
DIGEST_FIELDS={'contract_digest','build_digest','engine_module_digest'}
NUMBER_FIELDS={'pid','creation_time_100ns','qpc_frequency_hz'}
ENVELOPE_FIELDS={'binding','issuer','credential_id','sequence','previous_digest','tick','frequency','kind','reason','result','payload_digest','tag'}
KINDS={'C':{'REQUEST','HEARTBEAT','FAULT'},'S':{'REGISTERED','SUPERVISOR_ARMED','CONTROL_ATTEMPT'},'W':{'STOP_APPLIED'},'O':{'VERIFY','CLEANUP'},'L':{'OBSERVER_EXIT'}}
POLICY=('G01_POLICY','G02_POLICY','G03_POLICY','G04_POLICY','G05_POLICY','G06_POLICY','G07_PLAN','G08_POLICY','G09_LIMITS','G10_PLAN','G11_POLICY','G12_POLICY','G15_PLAN')
OBSERVED=('G04_OBSERVED','G07_OBSERVED','G08_OBSERVED','G09_RUNTIME_BOUND','G10_ARMED','RESERVATION_AND_SINGLE_USE_SLOT_COMMITTED')
EXTRA=('G11_EXACT_FAULT_AUTHORITY','G13_PROFILE_REVISION','G14_EXACT_TARGET_TERMINATION_GRANT')
DECISION_FIELDS={'component','decision_id','issuer','scope_digest','build_digest','not_before_tick','expires_tick','observer_epoch','approved','evidence_digest','signature'}
OBSERVATION_FIELDS={'component','binding','envelope_digest','tick','evidence_ref'}

def require(condition,message):
    if not condition:raise ValueError(message)
def exact(value,fields):require(type(value) is dict and set(value)==set(fields),'Exact record schema required')
def integer(value,positive=False):
    require(type(value) is int and (1 if positive else 0)<=value<=MAX_U64,'Unsigned64 integer required')
    return value
def decimal(value,positive=False):
    require(type(value) is str and re.fullmatch(r'0|[1-9][0-9]{0,19}',value) is not None,'Canonical decimal string required')
    return integer(int(value),positive)
def identifier(value):require(type(value) is str and re.fullmatch(r'[A-Za-z0-9_-]{1,128}',value) is not None,'Bounded ASCII identifier required')
def digest(value):require(type(value) is str and re.fullmatch(r'[0-9a-f]{64}',value) is not None,'Lowercase SHA256 required')
def ascii_text(value):require(type(value) is str and 1<=len(value)<=8192 and all(32<=ord(c)<=126 for c in value),'Bounded printable ASCII required')
def canonical(value):return json.dumps(value,sort_keys=True,separators=(',',':'),ensure_ascii=True,allow_nan=False).encode('ascii')
def sha(value):return hashlib.sha256(canonical(value)).hexdigest()
def validate_binding(binding):
    exact(binding,BINDING_FIELDS);require(binding['origin']=='B_DISPOSABLE','Wrong origin')
    for key,value in binding.items():
        if key in DIGEST_FIELDS:digest(value)
        elif key in NUMBER_FIELDS:decimal(value,True)
        else:identifier(value)
    return copy.deepcopy(binding)
def _envelope(message):
    exact(message,ENVELOPE_FIELDS);validate_binding(message['binding'])
    require(message['issuer'] in KINDS and message['kind'] in KINDS[message['issuer']],'Role/kind mismatch')
    identifier(message['credential_id']);decimal(message['sequence'],True);decimal(message['tick']);decimal(message['frequency'],True)
    require(message['frequency']==message['binding']['qpc_frequency_hz'],'Clock frequency mismatch')
    for key in ('previous_digest','payload_digest','tag'):digest(message[key])
    ascii_text(message['reason']);ascii_text(message['result'])
def canonical_message(message):
    _envelope(message);wire=canonical(message);require(len(wire)<=8192,'Frame exceeds bound');return wire
def _unique(pairs):
    result={}
    for key,value in pairs:
        require(key not in result,'Duplicate JSON key');result[key]=value
    return result

class Journal:
    """New artificial stores only. Real storage policy remains unadopted."""
    def __init__(self,path,expected_high_watermark):
        exact(expected_high_watermark,{'sequence','chain_digest','evidence_domain'})
        require(expected_high_watermark==dict(sequence=0,chain_digest='0'*64,evidence_domain='ARTIFICIAL'),'Only fresh artificial stores may initialize')
        root=os.environ.get('WP06_ARTIFICIAL_STORE_ROOT');require(bool(root),'Explicit artificial output root required')
        target=pathlib.Path(path).resolve();require(target.parent==pathlib.Path(root).resolve() and target.suffix=='.sqlite','Outside artificial store scope')
        self.quarantined=False;self.watermark=copy.deepcopy(expected_high_watermark)
        try:
            with target.open('xb'):pass
        except FileExistsError as error:raise ValueError('Existing store cannot be reopened/replaced') from error
        self.connection=sqlite3.connect(str(target),timeout=0,isolation_level=None)
        try:
            require(self.connection.execute('PRAGMA journal_mode=DELETE').fetchone()[0]=='delete','Unexpected journal mode')
            self.connection.execute('PRAGMA synchronous=EXTRA');self.connection.execute('PRAGMA busy_timeout=0')
            self.connection.execute('PRAGMA foreign_keys=ON')
            self.connection.executescript('CREATE TABLE reservations (lease TEXT PRIMARY KEY,slot_id TEXT UNIQUE NOT NULL,binding TEXT NOT NULL,status TEXT NOT NULL,slot TEXT NOT NULL); CREATE TABLE attempts (slot_id TEXT PRIMARY KEY REFERENCES reservations(slot_id),receipt TEXT NOT NULL); CREATE TABLE watermark (sequence INTEGER NOT NULL,digest TEXT NOT NULL); INSERT INTO watermark VALUES (0,"'+('0'*64)+'");')
        except Exception:
            self.quarantined=True;self.connection.close();raise
    def _available(self):require(not self.quarantined,'Store quarantined; no retry')
    def prepare(self,binding,deadline_tick):
        self._available();b=validate_binding(binding);integer(deadline_tick,True)
        slot=dict(binding=b,deadline_tick=deadline_tick,reservation_digest=sha({'binding':b,'deadline':deadline_tick}),slot_id=sha(b),status='ARMED_UNUSED')
        try:
            self.connection.execute('BEGIN IMMEDIATE')
            self.connection.execute('INSERT INTO reservations VALUES (?,?,?,?,?)',(b['lease_id'],slot['slot_id'],canonical(b).decode(),'RESERVED_CONSUMED',canonical(slot).decode()))
            sequence=self.watermark['sequence']+1;chain=sha({'previous':self.watermark['chain_digest'],'slot':slot})
            self.connection.execute('UPDATE watermark SET sequence=?,digest=?',(sequence,chain));self.connection.execute('COMMIT')
            self.watermark=dict(sequence=sequence,chain_digest=chain,evidence_domain='ARTIFICIAL')
        except sqlite3.Error as error:
            self.quarantined=True
            if self.connection.in_transaction:self.connection.execute('ROLLBACK')
            raise ValueError('Prepare failed/uncertain; never dispatch or retry') from error
        return copy.deepcopy(slot)
    def verify_slot(self,slot):
        if self.quarantined:return False
        try:
            row=self.connection.execute('SELECT slot FROM reservations WHERE lease=?',(slot['binding']['lease_id'],)).fetchone()
            return bool(row and json.loads(row[0])==slot)
        except (sqlite3.Error,KeyError,TypeError):return False
    def record_after_attempt(self,receipt):
        self._available()
        try:
            exact(receipt,{'binding','slot_id','attempt_tick','delivery_status','kind','application_proven','evidence_domain'})
            b=validate_binding(receipt['binding']);digest(receipt['slot_id']);integer(receipt['attempt_tick'])
            require(receipt['kind']=='CONTROL_ATTEMPT' and receipt['delivery_status'] in ('ATTEMPTED','UNKNOWN') and receipt['application_proven'] is False and receipt['evidence_domain']=='ARTIFICIAL','Invalid attempt disposition')
            row=self.connection.execute('SELECT binding FROM reservations WHERE slot_id=?',(receipt['slot_id'],)).fetchone()
            require(row is not None and json.loads(row[0])==b and receipt['slot_id']==sha(b),'No exact committed reservation')
            self.connection.execute('INSERT INTO attempts VALUES (?,?)',(receipt['slot_id'],canonical(receipt).decode()))
        except (sqlite3.Error,KeyError,TypeError,ValueError) as error:
            self.quarantined=True;raise ValueError('Postaction persistence unavailable; consumed action is not retried') from error
    def recover(self,observed_high_watermark):
        try:
            row=self.connection.execute('SELECT sequence,digest FROM watermark').fetchone()
            require(not self.quarantined and observed_high_watermark==self.watermark and row==(self.watermark['sequence'],self.watermark['chain_digest']),'Rollback/high-watermark uncertainty')
            # Historical nonterminal leases remain consumed even on a matching watermark.
            self.quarantined=True
        except (ValueError,sqlite3.Error):self.quarantined=True
        return dict(disposition='QUARANTINE',resume=False)
    def close(self):self.connection.close()
def verify_message(wire,expected_binding,role_key,previous_sequence,previous_digest):
    require(type(wire) is bytes and 0<len(wire)<=8192,'Bounded bytes frame required')
    require(type(role_key) is bytes and len(role_key)>=32,'Scoped key required');integer(previous_sequence);digest(previous_digest)
    try:message=json.loads(wire.decode('ascii'),object_pairs_hook=_unique)
    except (UnicodeError,json.JSONDecodeError,RecursionError) as error:raise ValueError('Invalid JSON frame') from error
    require(canonical_message(message)==wire,'Noncanonical frame')
    require(message['binding']==validate_binding(expected_binding),'Binding mismatch')
    require(decimal(message['sequence'],True)==previous_sequence+1 and message['previous_digest']==previous_digest,'Replay/gap/chain mismatch')
    body={key:value for key,value in message.items() if key!='tag'}
    tag=hmac.new(role_key,canonical(body),hashlib.sha256).hexdigest()
    require(hmac.compare_digest(tag,message['tag']),'Authentication failed');return copy.deepcopy(message)
def ns_to_ticks(ns,frequency):
    integer(ns,True);integer(frequency,True);ticks=ns*frequency//1000000000;integer(ticks,True);return ticks
def deadline_state(now_tick,deadline_tick,uncertainty_ticks):
    integer(now_tick);integer(deadline_tick,True);integer(uncertainty_ticks)
    if now_tick>=deadline_tick:return 'EXPIRED'
    return 'AMBIGUOUS' if now_tick+uncertainty_ticks>=deadline_tick else 'BEFORE'
def admit_phase(stage,decisions,observations,expected_scope,verify_decision):
    result=dict(stage=stage,eligible=False,missing=[],evidence_digests=[])
    phases={'PRECREATION','QUIESCENT_BOOTSTRAP','PREARM_WORK_FAULT','CONDITIONAL_FALLBACK','COMPLETION'}
    try:
        require(stage in phases,'Unknown phase');scope=expected_scope
        require(verify_decision is scope['verify_decision'] and callable(verify_decision),'Unpinned decision verifier')
        integer(scope['now_tick']);validate_binding(scope['binding']);digest(scope['scope_digest']);digest(scope['build_digest'])
        require(scope['binding']['build_digest']==scope['build_digest'] and scope['binding']['observer_epoch']==scope['observer_epoch'],'Scope binding mismatch')
        require(scope['evidence_domain']=='ARTIFICIAL','Unadopted runtime provider')
        require(type(decisions) is list and type(observations) is list,'Lists required')
        approved={};seen=set()
        for row in decisions:
            exact(row,DECISION_FIELDS);component=row['component'];require(component in POLICY+EXTRA and component not in seen,'Unknown/duplicate decision');seen.add(component)
            identifier(row['decision_id']);identifier(row['issuer']);digest(row['evidence_digest']);ascii_text(row['signature'])
            require(row['approved'] is True and row['scope_digest']==scope['scope_digest'] and row['build_digest']==scope['build_digest'] and row['observer_epoch']==scope['observer_epoch'],'Wrong decision scope')
            require(decimal(row['not_before_tick'])<=scope['now_tick']<decimal(row['expires_tick'],True),'Decision expired/not yet valid')
            require(verify_decision(copy.deepcopy(row)) is True,'Decision not authenticated');approved[component]=row['evidence_digest']
        observed={}
        for row in observations:
            exact(row,OBSERVATION_FIELDS);component=row['component']
            require(component in OBSERVED+('WORKER_APPLICATION_OBSERVED','SAME_RETAINED_HANDLE_EXIT','G15_OBSERVED_RESOURCE_CLEANUP','L_OBSERVES_O_EXIT','FULL_CASE_COVERAGE_OR_HOLD') and component not in observed,'Unknown/duplicate observation')
            require(row['binding']==scope['binding'],'Observed binding mismatch');digest(row['envelope_digest'])
            require(decimal(row['tick'])<=scope['now_tick'] and scope['verify_observation'](copy.deepcopy(row)) is True,'Observation unverified/future')
            observed[component]=row['envelope_digest']
        required=set(POLICY);needed=set()
        if stage in ('PREARM_WORK_FAULT','CONDITIONAL_FALLBACK','COMPLETION'):required.add('G11_EXACT_FAULT_AUTHORITY');needed.update(OBSERVED)
        if stage=='CONDITIONAL_FALLBACK':required.update(EXTRA[1:])
        if stage=='COMPLETION':needed.update(('WORKER_APPLICATION_OBSERVED','SAME_RETAINED_HANDLE_EXIT','G15_OBSERVED_RESOURCE_CLEANUP','L_OBSERVES_O_EXIT','FULL_CASE_COVERAGE_OR_HOLD'))
        result['missing']=sorted((required-set(approved))|(needed-set(observed)))
        result['eligible']=not result['missing'];result['evidence_digests']=sorted(set(approved.values())|set(observed.values()))
    except (ValueError,KeyError,TypeError,AttributeError,OverflowError):result['missing']=['INVALID_OR_UNTRUSTED_INPUT']
    return result
