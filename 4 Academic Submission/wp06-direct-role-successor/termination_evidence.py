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
