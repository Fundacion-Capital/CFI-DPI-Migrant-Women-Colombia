"""Fixed pure fixture transitions, not process entrypoints or general dispatch."""
import copy
from journal_protocol import validate_binding,integer,require,exact,digest,sha

FIELDS={'binding','sequence','previous_digest','phase','terminal','self_ceiling_tick','verify_control'}
def _state(state,now_tick):
    exact(state,FIELDS);validate_binding(state['binding']);integer(state['sequence']);digest(state['previous_digest']);integer(now_tick);integer(state['self_ceiling_tick'],True)
    require(state['phase'] in ('READY','EXITED') and state['terminal'] in (None,'SELF_EXIT','SELF_CEILING','STOP_APPLIED'),'Unknown state')
    require(callable(state['verify_control']),'Pinned receiver verification required');return copy.deepcopy(state)
def controller_step(state,stimulus,now_tick):
    out=_state(state,now_tick);require(type(stimulus) is dict,'Fixed stimulus required');kind=stimulus.get('kind')
    if out['phase']=='READY' and now_tick>=out['self_ceiling_tick']:
        out.update(phase='EXITED',terminal='SELF_CEILING');return out
    if kind=='REPLACE':
        exact(stimulus,{'kind','new_binding','genesis_digest'});require(out['phase']=='EXITED','No overlapping/restarted generation')
        new=validate_binding(stimulus['new_binding']);old=out['binding'];digest(stimulus['genesis_digest'])
        changed={'worker_epoch','command_id','pid','creation_time_100ns','reservation_id','lease_id'}
        require(all(new[k]!=old[k] for k in changed) and all(new[k]==old[k] for k in set(new)-changed),'Fresh scoped identity required; retained PID cannot recycle')
        out.update(binding=new,sequence=0,previous_digest=stimulus['genesis_digest'],phase='READY',terminal=None);return out
    exact(stimulus,{'kind'});require(kind in ('SELF_EXIT','HEARTBEAT','WORK','CANCEL') and out['phase']=='READY','Unknown/terminal controller stimulus')
    if kind=='SELF_EXIT':out.update(phase='EXITED',terminal='SELF_EXIT')
    else:out['sequence']=integer(out['sequence']+1,True)
    return out
def worker_step(state,control_receipt,work_blocked,now_tick):
    out=_state(state,now_tick);require(type(work_blocked) is bool,'Exact queue state required')
    if out['phase']=='EXITED':return out
    if now_tick>=out['self_ceiling_tick']:
        out.update(phase='EXITED',terminal='SELF_CEILING');return out
    if control_receipt is not None:
        exact(control_receipt,{'binding','slot_id','event_observed','evidence_ref'})
        require(control_receipt['binding']==out['binding'] and control_receipt['slot_id']==sha(out['binding']),'Stale event/lease')
        require(control_receipt['event_observed'] is True and out['verify_control'](copy.deepcopy(control_receipt)) is True,'Event observation not verified')
        out.update(phase='EXITED',terminal='STOP_APPLIED');out['sequence']=integer(out['sequence']+1,True);return out
    if now_tick>=out['self_ceiling_tick']:out.update(phase='EXITED',terminal='SELF_CEILING')
    elif not work_blocked:out['sequence']=integer(out['sequence']+1,True)
    return out
