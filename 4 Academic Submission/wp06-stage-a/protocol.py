"""Restricted ASCII synthetic proof protocol. No live transport or secret store."""
import hashlib
import hmac
import json
import re
import threading
from types import MappingProxyType
from journal import integer,validate_binding

RESULTS={'ART_STOP_INTENT':'ART_REQUESTED','ART_STOP_APPLIED':'ART_APPLIED','ART_EXIT_OBSERVED':'ART_EXIT','ART_CLEANUP_OBSERVED':'ART_CLEANUP'}
BODY={'kind','binding','sequence','previous_digest','timestamp_ns','issuer','credential_id','reason','payload_digest','result'}
ZERO='0'*64

def _tree(value,depth=0):
    if depth>4:raise ValueError('Wire depth limit')
    if type(value) is str:
        if not re.fullmatch('[A-Za-z0-9_]+',value):raise ValueError('Unescaped ASCII strings only')
    elif type(value) is dict:
        for key,item in value.items():
            if type(key) is not str or not re.fullmatch('[A-Za-z_]+',key):raise ValueError('ASCII object key required')
            _tree(item,depth+1)
    else:raise ValueError('Only objects and strings on wire')

def encode(record):
    _tree(record)
    result=json.dumps(record,sort_keys=True,separators=(',',':'),ensure_ascii=True).encode('ascii')
    if len(result)>8192:raise ValueError('Wire size limit')
    return result

def mac(key,content):return hmac.new(key,content,'sha256').hexdigest()

def _decimal(value,positive=False):
    if type(value) is not str or len(value)>19 or not re.fullmatch('0|[1-9][0-9]*',value):raise ValueError('Canonical decimal string required')
    return integer(int(value),positive)

def _body(record):
    if type(record) is not dict or set(record)!=BODY:raise ValueError('Exact body schema')
    encode(record);validate_binding(record['binding'],wire=True)
    kind=record['kind']
    if kind not in RESULTS or record['result']!=RESULTS[kind] or record['reason']!='ART_FIXTURE':raise ValueError('Fixed kind/result required')
    role='ART_CONTROL' if kind=='ART_STOP_INTENT' else 'ART_OBSERVER'
    if record['issuer']!=role or not re.fullmatch(r'ART_[A-Z0-9_]{1,60}',record['credential_id']):raise ValueError('Fixed issuer/token')
    _decimal(record['sequence'],True);_decimal(record['timestamp_ns'])
    for key in ('previous_digest','payload_digest'):
        if not re.fullmatch('[0-9a-f]{64}',record[key]):raise ValueError('Digest encoding')
    payload=encode({'action':kind})
    if record['payload_digest']!=hashlib.sha256(payload).hexdigest():raise ValueError('Payload digest mismatch')
    return record

def _registry(registry):
    if type(registry) is not dict or not registry:raise ValueError('Trusted fixture key registry required')
    result={}
    for name,entry in registry.items():
        if type(name) is not str or not re.fullmatch(r'ART_[A-Z0-9_]{1,60}',name) or type(entry) is not dict or set(entry)!={'issuer','scope_id','key','revoked'}:raise ValueError('Fixture key schema')
        if entry['issuer'] not in ('ART_CONTROL','ART_OBSERVER') or type(entry['scope_id']) is not str or not re.fullmatch(r'ART_[A-Z0-9_]{1,60}',entry['scope_id']):raise ValueError('Fixture role/scope')
        if type(entry['key']) is not bytes or not entry['key'].startswith(b'ART_') or not 16<=len(entry['key'])<=128 or type(entry['revoked']) is not bool:raise ValueError('Synthetic fixture key only')
        result[name]=dict(entry)
    return result

def sign(record,credential_id,fixture_registry):
    body=_body(record);keys=_registry(fixture_registry)
    if type(credential_id) is not str or credential_id!=body['credential_id'] or credential_id not in keys:raise ValueError('Unknown signing credential')
    return encode({'body':body,'tag':mac(keys[credential_id]['key'],encode(body))})

def _pairs(pairs):
    result={}
    for key,value in pairs:
        if key in result:raise ValueError('Duplicate wire key')
        result[key]=value
    return result

class Verifier:
    """Scoped in-process synthetic verifier, not Windows authentication."""
    def __init__(self,registry,*,deliver_by):
        self._keys=_registry(registry);self.deadline=integer(deliver_by,True)
        self._last=0;self._sequences={};self.closed=False;self._lock=threading.RLock()

    def revoke(self,credential_id):
        with self._lock:
            if credential_id not in self._keys:raise ValueError('Unknown credential')
            self._keys[credential_id]['revoked']=True

    def consume(self,envelope,expected_binding,expected_kind,now):
        with self._lock:
            if self.closed:raise ValueError('Consumer permanently closed')
            try:
                integer(now)
                if now<self._last or now>=self.deadline:raise ValueError('Expired or rolled-back consumer')
                self._last=now
                b=validate_binding(expected_binding);wire_binding=dict(b,pid=str(b['pid']),worker_epoch=str(b['worker_epoch']))
                if type(envelope) is not bytes or len(envelope)>8192 or b'\\' in envelope:raise ValueError('Bounded canonical byte envelope required')
                parsed=json.loads(envelope.decode('ascii'),object_pairs_hook=_pairs)
                if type(parsed) is not dict or set(parsed)!={'body','tag'} or encode(parsed)!=envelope:raise ValueError('Exact canonical envelope')
                body=_body(parsed['body']);tag=parsed['tag']
                if type(tag) is not str or not re.fullmatch('[0-9a-f]{64}',tag):raise ValueError('Fixed-length tag')
                credential=self._keys.get(body['credential_id'])
                if not credential or credential['revoked'] or credential['issuer']!=body['issuer'] or credential['scope_id']!=b['scope_id']:raise ValueError('Untrusted/revoked/wrong-role credential')
                if not hmac.compare_digest(tag,mac(credential['key'],encode(body))):raise ValueError('Invalid authentication tag')
                if body['binding']!=wire_binding or type(expected_kind) is not str or body['kind']!=expected_kind or _decimal(body['timestamp_ns'])>now:raise ValueError('Wrong binding/kind or future observation')
                key=(b['lease_id'],body['issuer']);seq,previous,last_at=self._sequences.get(key,(0,ZERO,0))
                if _decimal(body['sequence'],True)!=seq+1 or body['previous_digest']!=previous or _decimal(body['timestamp_ns'])<last_at:raise ValueError('Replay, reversed observation or broken chain')
                self._sequences[key]=(seq+1,hashlib.sha256(encode(body)).hexdigest(),_decimal(body['timestamp_ns']))
                frozen=dict(body);frozen['binding']=MappingProxyType(dict(body['binding']))
                return MappingProxyType(frozen)
            except (ValueError,TypeError,KeyError,RecursionError,UnicodeError) as error:
                self.closed=True
                raise ValueError('Synthetic proof rejected; gate closed') from error
