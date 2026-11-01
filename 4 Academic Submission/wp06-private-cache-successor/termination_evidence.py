"""Strict new-version exit receipts. No legacy fallback or native acceptance claim."""
import json
from pathlib import Path
from private_channel import LIMIT,unique

def read_exit_witness(run_root,expected_scope,required_roles):
    scope_fields={'run_id','session_id','worker_epoch','owner_nonce','clock_domain'}
    if (type(expected_scope) is not dict or set(expected_scope)!=scope_fields
            or any(type(value) is not str or not value for value in expected_scope.values())):
        raise ValueError('Explicit complete expected run scope required')
    roles={'inner','outer','worker','watchdog'}
    if (type(required_roles) is not list or any(type(role) is not str or role not in roles for role in required_roles)
            or len(required_roles)!=len(set(required_roles))):
        raise ValueError('Explicit unique expected termination roles required')
    with (Path(run_root)/'parent.exit.json').open('rb') as stream:
        raw=stream.read(LIMIT+1)
    if len(raw)>LIMIT:
        raise ValueError('Oversized parent exit witness')
    record=json.loads(raw,object_pairs_hook=unique)
    if (type(record) is not dict or set(record)!={'kind','scope','payload','provenance'}
            or record['kind']!='exit' or record['scope']!=expected_scope
            or type(record['payload']) is not dict or type(record['provenance']) is not str):
        raise ValueError('Foreign or malformed parent exit witness')
    payload=record['payload']
    if 'observation_failed' in payload:
        raise ValueError('Failed exit observation is not successful termination evidence')
    rows=payload.get('termination_observations')
    if type(rows) is not list or len(rows)>4:
        raise ValueError('New-version termination observations are required')
    seen=set()
    for row in rows:
        if type(row) is not dict or type(row.get('role')) is not str or row['role'] not in roles or row['role'] in seen:
            raise ValueError('Foreign or repeated termination role')
        role=row['role']
        operation='TerminateJobObject' if role in {'inner','outer'} else 'TerminateProcess'
        allowed=[dict(role=role,operation=operation,result='termination_requested')]
        if operation=='TerminateProcess':
            allowed += [dict(role=role,operation=operation,result='already_exited'),
                dict(role=role,operation=operation,result='exit_observed_after_access_denied',winerror=5)]
        if row not in allowed or ('winerror' in row and type(row['winerror']) is not int):
            raise ValueError('Failed or malformed termination receipt')
        seen.add(role)
    if seen!=set(required_roles):
        raise ValueError('Termination receipt coverage differs from the expected stages')
    # Scope equality and syntax are not authentication, cleanup acceptance or runtime qualification.
    return payload

def read_cache_witnesses(run_root, expected_scope, binding):
    """Scope/type readback only: retained MAC keys are unavailable for independent authentication."""
    import re
    from deployment import validate, check_cache_proof
    from startup_guard import verify_cache, verify_receipt, _plain
    validate(binding)
    fields = {'run_id','session_id','worker_epoch','owner_nonce','clock_domain'}
    root = Path(run_root)
    if (type(expected_scope) is not dict or set(expected_scope) != fields
            or any(type(v) is not str or not v for v in expected_scope.values())
            or binding.get('run_scope') != expected_scope
            or root != Path(binding['private_root']) or root != root.resolve()):
        raise ValueError('Exact complete binding and expected cache-witness scope required')
    verify_cache(binding)
    verify_receipt(binding)
    def read(name):
        path = root / name
        _plain(path)
        with path.open('rb') as stream:
            raw = stream.read(LIMIT+1)
        if len(raw)>LIMIT:
            raise ValueError('Oversized cache witness')
        row = json.loads(raw,object_pairs_hook=unique)
        if type(row) is not dict or row.get('scope') != expected_scope:
            raise ValueError('Foreign or malformed cache witness')
        return row
    client = read('client_receipt.json')
    parent = read('parent.cache.json')
    if (set(parent) != {'scope','kind','payload','provenance'} or parent['kind'] != 'cache'
            or type(parent['provenance']) is not str):
        raise ValueError('Malformed parent cache witness')
    result = dict(client=check_cache_proof(binding,client.get('cache_control')),
        adapter=check_cache_proof(binding,parent['payload']))
    for role in ('worker','watchdog'):
        row = read(role+'.ready.0.json')
        payload = row.get('payload')
        if (set(row) != {'scope','role','kind','sequence','payload','tag'} or row['role'] != role
                or row['kind'] != 'ready' or type(row['sequence']) is not int or row['sequence'] != 0
                or type(row['tag']) is not str or not re.fullmatch(r'[0-9a-f]{64}',row['tag'])
                or type(payload) is not dict or payload.get('ready') is not True
                or set(payload) != ({'ready','cache_control','runtime_identity'} if role=='worker' else {'ready','cache_control'})):
            raise ValueError('Malformed role cache witness')
        result[role] = check_cache_proof(binding,payload['cache_control'])
    return result


