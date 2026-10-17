"""Metadata-only fail-closed guard. Never dispatches Stata, loads data or grants a fit."""
import re

def safety_status(*,timed_out,registry_absent,owned_completion):
    assert all(type(x)==bool for x in [timed_out,registry_absent,owned_completion])
    if timed_out:state='QUARANTINED_CONSUMED_TIMEOUT' if owned_completion else 'QUARANTINED_ENGINE_STATE_UNKNOWN'
    else:state='ARTIFICIAL_COMPLETION_RECORDED' if owned_completion else 'WAITING_UNVERIFIED'
    return dict(state=state,registry_absent=registry_absent,engine_stop_proven=False,
      owned_command_completion_recorded=owned_completion,advance_allowed=False,retry_allowed=False)

def runtime_identity(value):
    assert set(value)=={'candidate_hash','worker_metadata','loaded_module_path','owned_pid'}
    return dict(loaded_image_attested=False,reason='Candidate hash and generic worker metadata are not a loaded-module attestation',
      candidate_hash=value['candidate_hash'],worker_metadata=value['worker_metadata'])

def module_attestation(pid,before,after):
    assert type(pid)==int and pid>0 and before==after
    assert set(before)=={'process_id','creation_time','loaded_module_path','sha256'}
    assert before['process_id']==pid and before['creation_time']
    assert before['loaded_module_path'].replace('\\','/').lower()=='c:/program files/stata19/mp-64.dll'
    assert re.fullmatch('[0-9A-F]{64}',before['sha256'])
    return dict(loaded_module_attested=True,scope='OBSERVED_OWNED_ARTIFICIAL_WORKER_ONLY',
      module_path=before['loaded_module_path'],disk_sha256=before['sha256'],in_memory_digest=False,future_worker_rebind_required=True)

def process_stop_proof(before,after,confirm):
    assert set(before)==set(after)==set(confirm)=={'process_id','creation_time','present'}
    assert before['present'] is True and before['creation_time'] and type(before['process_id'])==int and before['process_id']>0
    assert after['process_id']==confirm['process_id']==before['process_id']
    assert after['present'] is False and confirm['present'] is False
    assert after['creation_time']==confirm['creation_time']==''
    return True
