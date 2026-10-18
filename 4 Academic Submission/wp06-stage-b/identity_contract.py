"""Exact V2 artificial identities and role-scoped authority. No host discovery."""
import copy
import hashlib
import hmac
import json
from pathlib import PureWindowsPath
from journal_protocol import exact,require,integer,decimal,identifier,digest,canonical,sha,validate_binding,_unique
from journal_protocol import KINDS

RUN=set('origin contract_digest build_digest host_id boot_id observer_epoch session_id owner_nonce scope_id clock_domain qpc_frequency_hz run_id'.split())
ACTOR=set('run_digest role actor_epoch generation parent_role parent_actor_digest pid creation_time_100ns image_pin_digest credential_id'.split())
TARGET=set('run_digest worker_actor_digest worker_epoch command_id reservation_id lease_id'.split())
INTENT=set('run_digest role parent_role actor_epoch generation application command_line image_pin_digest environment credential_id bootstrap_capability_digest'.split())
BUDGETS=set('bootstrap_deadline_tick ipc_deadline_tick control_deadline_tick cleanup_deadline_tick'.split())
PARENTS={'O':'L','S':'O','C':'O','W':'S'}
ROLES=('L','O','S','C','W')
PROTOCOL='WP06_BOOTSTRAP_V2_ARTIFICIAL'
DOMAINS={'EXTERNAL_ANCHOR','RUN_LAUNCH','REGISTRATION','BOOT_RESPONSE','TARGET_ADMISSION','TARGET_FRAME'}

def validate_run(row):
    exact(row,RUN);require(row['origin']=='B_DISPOSABLE','Wrong run origin')
    for k,v in row.items():
        if k.endswith('_digest'):digest(v)
        elif k=='qpc_frequency_hz':decimal(v,True)
        else:identifier(v)
    return copy.deepcopy(row)

def validate_actor(row):
    exact(row,ACTOR);require(row['role'] in ROLES,'Unknown actor role')
    for k,v in row.items():
        if k.endswith('_digest'):digest(v)
        elif k in ('pid','creation_time_100ns','generation'):decimal(v,True)
        else:identifier(v)
    require(row['generation']=='1','Replacement generation not admitted')
    require(row['parent_role']==('EXTERNAL_OPERATOR' if row['role']=='L' else PARENTS[row['role']]),'Actor parent mismatch')
    return copy.deepcopy(row)

def validate_manifest(row):
    exact(row,{'run_context','external_launcher','actor_intents','budgets'})
    run=validate_run(row['run_context']);rd=sha(run)
    exact(row['external_launcher'],{'identity','anchor_proof'})
    launcher=validate_actor(row['external_launcher']['identity'])
    require(launcher['role']=='L' and launcher['run_digest']==rd,'External launcher mismatch')
    exact(row['external_launcher']['anchor_proof'],set('run_digest actor_digest external_anchor_digest issuer credential_id issued_tick expires_tick signature'.split()))
    exact(row['actor_intents'],set(PARENTS));creds=[launcher['credential_id']]
    for role,intent in row['actor_intents'].items():
        exact(intent,INTENT)
        require(intent['run_digest']==rd and intent['role']==role and intent['parent_role']==PARENTS[role] and intent['generation']=='1','Intent scope/topology mismatch')
        identifier(intent['actor_epoch']);identifier(intent['credential_id']);creds.append(intent['credential_id'])
        digest(intent['image_pin_digest']);digest(intent['bootstrap_capability_digest'])
        app=intent['application'];cmd=intent['command_line'];env=intent['environment']
        require(type(app) is str and PureWindowsPath(app).is_absolute() and app.lower().endswith('.exe') and '\0' not in app,'Fixed absolute application required')
        require(type(cmd) is str and cmd.startswith('"'+app+'" ') and '\0' not in cmd and len(cmd.encode('utf-16-le'))<=65532,'Fixed bounded command required')
        require(type(env) is dict and set(env)=={'SYSTEMROOT'} and type(env['SYSTEMROOT']) is str and bool(env['SYSTEMROOT']) and '\0' not in env['SYSTEMROOT'],'Minimal environment required')
    require(len(set(creds))==5,'Actor credentials must differ')
    exact(row['budgets'],BUDGETS)
    for value in row['budgets'].values():integer(value,True)
    b=row['budgets'];require(b['bootstrap_deadline_tick']<min(b['ipc_deadline_tick'],b['control_deadline_tick']) and max(b['ipc_deadline_tick'],b['control_deadline_tick'])<=b['cleanup_deadline_tick'],'Invalid phase ceilings')
    return copy.deepcopy(row)

def project_target(run,actor,target,supplied=None):
    validate_run(run);validate_actor(actor);exact(target,TARGET)
    for k,v in target.items():
        if k.endswith('_digest'):digest(v)
        else:identifier(v)
    require(actor['role']=='W' and actor['run_digest']==target['run_digest']==sha(run) and target['worker_actor_digest']==sha(actor),'Target does not reference captured W')
    result={k:v for k,v in run.items() if k!='run_id'}
    result.update(pid=actor['pid'],creation_time_100ns=actor['creation_time_100ns'],engine_module_digest=actor['image_pin_digest'])
    result.update({k:target[k] for k in ('worker_epoch','command_id','reservation_id','lease_id')})
    validate_binding(result)
    if supplied is not None:require(supplied==result,'Conflicting target projection')
    return copy.deepcopy(result)

def decode_wire(wire):
    require(type(wire) is bytes and 0<len(wire)<=8192,'Bounded ASCII frame required')
    try:
        row=json.loads(wire.decode('ascii'),object_pairs_hook=_unique)
        require(type(row) is dict and canonical(row)==wire,'Noncanonical frame')
        return row
    except (ValueError,TypeError,UnicodeError,RecursionError):raise ValueError('Malformed canonical frame') from None

def mac(key,domain,body):
    require(domain in DOMAINS,'Unknown authentication domain')
    return hmac.new(key,canonical(dict(domain=domain,body=body)),hashlib.sha256).hexdigest()

class Authority:
    evidence_domain='ARTIFICIAL'
    def __init__(self,run,credentials,clock):
        self.run=validate_run(run);exact(credentials,set(ROLES)|{'OWNER'})
        for role,row in credentials.items():
            exact(row,{'credential_id','key'});identifier(row['credential_id'])
            require(type(row['key']) is bytes and len(row['key'])>=32,'Explicit artificial role key required')
        require(len({r['key'] for r in credentials.values()})==6 and len({r['credential_id'] for r in credentials.values()})==6,'Role credentials must differ')
        self._credentials=copy.deepcopy(credentials);self.clock=clock;self._last=None;self._failed=False;self._revoked=set();self.generation=0
        self.now()
    def __deepcopy__(self,memo):memo[id(self)]=self;return self
    def now(self):
        require(not self._failed,'Authority/clock quarantined')
        try:
            require(self.clock.domain==self.run['clock_domain'] and type(self.clock.frequency_hz) is int and self.clock.frequency_hz==int(self.run['qpc_frequency_hz']),'Clock domain/frequency mismatch')
            now=integer(self.clock.now_tick());require(self._last is None or now>=self._last,'Clock rollback')
        except Exception:self._failed=True;raise
        self._last=now;return now
    def authority_current(self,generation):return not self._failed and not self._revoked and type(generation) is int and generation==self.generation
    def revoke(self,role):
        require(role in self._credentials,'Unknown role')
        if role not in self._revoked:self._revoked.add(role);self.generation+=1
    def credential_id(self,role):return self._credentials[role]['credential_id']
    def sign(self,domain,body,role):
        require(self.authority_current(self.generation) and role in self._credentials,'Revoked/unknown signer')
        require(type(body) is dict and 'signature' not in body and body.get('issuer')==role and body.get('credential_id')==self.credential_id(role),'Pinned signer required')
        return dict(copy.deepcopy(body),signature=mac(self._credentials[role]['key'],domain,body))
    def verify(self,domain,row,role):
        try:
            require(type(row) is dict and self.authority_current(self.generation) and role in self._credentials,'Revoked/unknown verifier')
            require(row['issuer']==role and row['credential_id']==self.credential_id(role) and type(row['signature']) is str,'Signer mismatch')
            body={k:v for k,v in row.items() if k!='signature'}
            return hmac.compare_digest(row['signature'],mac(self._credentials[role]['key'],domain,body))
        except (ValueError,TypeError,KeyError):return False
    def verify_tag(self,domain,row,role):
        try:
            require(self.authority_current(self.generation) and row['credential_id']==self.credential_id(role) and type(row['tag']) is str,'Credential unavailable')
            return hmac.compare_digest(row['tag'],mac(self._credentials[role]['key'],domain,{k:v for k,v in row.items() if k!='tag'}))
        except (ValueError,TypeError,KeyError):return False

class Endpoint:
    """Own-role signing only; pinned verification callback exposes no peer key."""
    def __init__(self,actor,key,clock,verify_challenge):
        self.actor=validate_actor(actor);self._key=key;self.clock=clock;self._verify_challenge=verify_challenge;self._used=False
    def respond(self,wire):
        require(not self._used,'Endpoint challenge already consumed');self._used=True;challenge=decode_wire(wire)
        require(self._verify_challenge(challenge) is True,'Unverified scoped challenge')
        body=dict(protocol=PROTOCOL,run_digest=self.actor['run_digest'],actor_digest=sha(self.actor),challenge_digest=sha(challenge),
                  credential_id=self.actor['credential_id'],sequence='1',previous_digest='0'*64,tick=self.clock.now_tick(),frequency=str(self.clock.frequency_hz),payload_digest=sha({'ready':'BOOTSTRAP_ONLY'}))
        body['tag']=mac(self._key,'BOOT_RESPONSE',body);wire=canonical(body)
        require(len(wire)<=8192,'Oversized response');return wire


class ActorFrames:
    """One target-bound direction; own signing key and pinned authority callback."""
    def __init__(self,sender,recipient,target_digest,run,key,guard):
        self.sender=copy.deepcopy(sender);self.recipient=copy.deepcopy(recipient);self.target_digest=target_digest
        self.run=copy.deepcopy(run);self._key=key;self._guard=guard;self._sequence=0;self._previous='0'*64
    def encode(self,kind,payload_digest):
        now=self._guard();digest(payload_digest)
        require(type(kind) is str and kind in KINDS[self.sender['role']],'Wrong actor message kind')
        body=dict(protocol='WP06_TARGET_V2_ARTIFICIAL',run_digest=sha(self.run),target_digest=self.target_digest,sender_actor_digest=sha(self.sender),
          recipient_actor_digest=sha(self.recipient),credential_id=self.sender['credential_id'],sequence=str(self._sequence+1),previous_digest=self._previous,
          tick=now,frequency=self.run['qpc_frequency_hz'],kind=kind,payload_digest=payload_digest)
        body['tag']=mac(self._key,'TARGET_FRAME',body);wire=canonical(body);require(len(wire)<=8192,'Oversized actor frame')
        self._sequence+=1;self._previous=sha(body);return wire
