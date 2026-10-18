"""Explicit artificial authority and QPC providers; no credential or DLL discovery."""
import copy
import ctypes as c
import hashlib
import hmac
from journal_protocol import canonical, validate_binding, digest, exact, require, integer, decimal, identifier, sha
from journal_protocol import DECISION_FIELDS, OBSERVATION_FIELDS


class QpcClock:
    """The caller injects the two ABI functions; this module never resolves them."""
    def __init__(self, counter, frequency, domain, expected_frequency):
        identifier(domain);integer(expected_frequency,True)
        value=c.c_int64()
        require(frequency(c.byref(value))==1 and value.value==expected_frequency,'Unverified QPC frequency')
        self.domain=domain;self.frequency_hz=expected_frequency
        self._counter=counter;self._last=None;self._failed=False

    def now_tick(self):
        require(not self._failed,'Clock quarantined')
        value=c.c_int64()
        try:
            require(self._counter(c.byref(value))==1,'QPC unavailable')
            integer(value.value)
            require(self._last is None or value.value>=self._last,'QPC rollback')
        except Exception:
            self._failed=True
            raise
        self._last=value.value
        return value.value


class Provider:
    """Role-separated artificial MACs, not institutional attestation/nonrepudiation.

    Observation tags occupy the existing evidence_ref field, keeping its schema.
    No keys are read from disk, environment, command line, network or account.
    """
    evidence_domain='ARTIFICIAL'

    def __init__(self,binding,scope_digest,keys,clock,observation_roles,max_age=10,evidence_domain='ARTIFICIAL'):
        require(evidence_domain=='ARTIFICIAL','Runtime trust roots remain unadopted')
        validate_binding(binding);digest(scope_digest);integer(max_age,True)
        require(type(keys) is dict and bool(keys),'Explicit artificial keys required')
        for role,key in keys.items():
            identifier(role);require(type(key) is bytes and len(key)>=32,'Invalid role key')
        require(len(set(keys.values()))==len(keys),'Role keys must differ')
        require(type(observation_roles) is dict,'Explicit observation-role policy required')
        require(all(type(k) is str and v in keys and v!='OWNER' for k,v in observation_roles.items()),'Invalid observation role')
        require(clock.domain==binding['clock_domain'] and clock.frequency_hz==int(binding['qpc_frequency_hz']),'Clock scope mismatch')
        self.binding=copy.deepcopy(binding);self.scope_digest=scope_digest
        self._keys=keys.copy();self._roles=observation_roles.copy();self._clock=clock
        self._age=max_age;self._revoked=set();self.generation=0

    def __deepcopy__(self,memo):
        # A copied verifier must not fork its live local revocation identity.
        memo[id(self)]=self
        return self

    def authority_current(self,generation):
        return type(generation) is int and generation==self.generation and not self._revoked

    def revoke(self,role):
        require(role in self._keys,'Unknown role')
        if role not in self._revoked:self._revoked.add(role);self.generation+=1

    def _tag(self,kind,body,role):
        require(role in self._keys and role not in self._revoked,'Unavailable credential')
        return hmac.new(self._keys[role],canonical(dict(kind=kind,issuer=role,body=body)),hashlib.sha256).hexdigest()

    def _decision(self,row):
        exact(row,DECISION_FIELDS)
        require(row['issuer']=='OWNER' and row['approved'] is True,'Decision issuer/approval mismatch')
        require(row['scope_digest']==self.scope_digest and row['build_digest']==self.binding['build_digest'] and row['observer_epoch']==self.binding['observer_epoch'],'Decision scope mismatch')
        now=self._clock.now_tick()
        require(decimal(row['not_before_tick'])<=now<decimal(row['expires_tick'],True),'Decision expired/not yet valid')
        return {k:v for k,v in row.items() if k!='signature'}

    def sign_decision(self,row):
        row=copy.deepcopy(row);body=self._decision(row)
        row['signature']=self._tag('DECISION',body,'OWNER')
        return row

    def verify_decision(self,row):
        try:
            body=self._decision(row)
            return type(row['signature']) is str and hmac.compare_digest(row['signature'],self._tag('DECISION',body,'OWNER'))
        except (ValueError,KeyError,TypeError,AttributeError,OverflowError):
            return False

    def _observation(self,row,role):
        exact(row,OBSERVATION_FIELDS)
        require(row['binding']==self.binding,'Observation binding mismatch')
        require(type(row['component']) is str and self._roles.get(row['component'])==role,'Observation role mismatch')
        digest(row['envelope_digest']);tick=decimal(row['tick']);now=self._clock.now_tick()
        require(tick<=now and now-tick<=self._age,'Stale/future observation')
        return {k:v for k,v in row.items() if k!='evidence_ref'}

    def sign_observation(self,row,role):
        row=copy.deepcopy(row);body=self._observation(row,role)
        row['evidence_ref']=role+'_'+self._tag('OBSERVATION',body,role)
        return row

    def verify_observation(self,row):
        try:
            if type(row) is dict and 'component' not in row:
                body=self._status(row)
                return type(row['evidence_ref']) is str and hmac.compare_digest(row['evidence_ref'],'C_'+self._tag('CONTROL_STATUS',body,'C'))
            require(type(row) is dict and type(row.get('evidence_ref')) is str,'Malformed observation')
            role,tag=row['evidence_ref'].rsplit('_',1)
            body=self._observation(row,role)
            return hmac.compare_digest(tag,self._tag('OBSERVATION',body,role))
        except (ValueError,KeyError,TypeError,AttributeError,OverflowError):
            return False

    def _status(self,row):
        require(type(row) is dict and row.get('binding')==self.binding,'Controller binding mismatch')
        now=self._clock.now_tick()
        if 'alive' in row:
            exact(row,{'binding','alive','heartbeat_tick','heartbeat_loss_tick','evidence_ref'})
            require(type(row['alive']) is bool,'Exact controller liveness required')
            tick=integer(row['heartbeat_tick']);loss=integer(row['heartbeat_loss_tick'],True)
            require(loss>=tick,'Invalid heartbeat ordering')
        else:
            exact(row,{'binding','kind','tick','evidence_ref'})
            require(row['kind']=='REQUEST','Only exact controller request allowed');tick=integer(row['tick'])
        require(tick<=now and now-tick<=self._age,'Stale/future controller record')
        return {k:v for k,v in row.items() if k!='evidence_ref'}

    def sign_status(self,row):
        row=copy.deepcopy(row);body=self._status(row)
        row['evidence_ref']='C_'+self._tag('CONTROL_STATUS',body,'C')
        return row

    def sign_control(self,row):
        row=copy.deepcopy(row)
        exact(row,{'binding','slot_id','event_observed','evidence_ref'})
        require(row['binding']==self.binding and row['slot_id']==sha(self.binding) and row['event_observed'] is True,'Invalid worker event observation')
        body={k:v for k,v in row.items() if k!='evidence_ref'}
        row['evidence_ref']='W_'+self._tag('WORKER_EVENT',body,'W')
        return row

    def verify_control(self,row):
        try:
            exact(row,{'binding','slot_id','event_observed','evidence_ref'})
            expected=self.sign_control(row)['evidence_ref']
            return type(row['evidence_ref']) is str and hmac.compare_digest(row['evidence_ref'],expected)
        except (ValueError,KeyError,TypeError,AttributeError):return False
