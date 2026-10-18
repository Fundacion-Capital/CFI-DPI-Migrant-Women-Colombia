"""Independent structural/evidence assessment. Artificial results never pass ACs."""
import copy
from journal_protocol import validate_binding,require,integer,exact,sha,deadline_state,identifier,digest

RESOURCE_FIELDS={'resource_id','kind','owner_role','generation','binding_digest','operation_id','rights','state','deadline_tick','disposition'}
DIMENSIONS=('reservation','control_attempt','worker_application','original_exit','cleanup','integrity')
ROLES={'reservation':'S','control_attempt':'S','worker_application':'W','original_exit':'O','cleanup':'L','integrity':'L'}
def _inventory(rows):
    require(type(rows) is list and bool(rows),'Nonempty inventory required');out={}
    for row in rows:
        exact(row,RESOURCE_FIELDS);identifier(row['resource_id']);identifier(row['generation']);digest(row['binding_digest']);integer(row['deadline_tick'],True)
        require(row['kind'] in ('PROCESS','PIPE','EVENT','OVERLAPPED','BUFFER','QUEUE','KEY','FILE','HANDLE') and row['owner_role'] in ('L','O','S','C','W'),'Invalid resource kind/role')
        if row['operation_id'] is not None:identifier(row['operation_id'])
        require(type(row['rights']) is list and bool(row['rights']) and all(type(r) is str and r in ('QUERY','SYNCHRONIZE','TERMINATE','READ','WRITE','SIGNAL','WAIT') for r in row['rights']) and len(set(row['rights']))==len(row['rights']),'Invalid rights')
        require(row['state'] in ('LIVE','EXITED','CLOSED','PENDING','UNKNOWN') and row['disposition'] in ('EXPECTED','OWNED','CLOSED','HOLD'),'Invalid lifecycle domain')
        if row['kind']=='PROCESS':require(row['operation_id'] is None and set(row['rights'])<= {'QUERY','SYNCHRONIZE'},'Invalid process resource')
        if row['kind'] in ('OVERLAPPED','BUFFER'):require(row['operation_id'] is not None,'Missing operation identity')
        require(row['resource_id'] not in out,'Duplicate resource');out[row['resource_id']]=row
    require({'O','S','C','W'}<={r['owner_role'] for r in rows if r['kind']=='PROCESS'},'Full actor inventory missing')
    return out
def preexit_inventory_digest(observed_resources):
    rows=copy.deepcopy(observed_resources)
    for row in rows:
        if row['kind']=='PROCESS' and row['owner_role']=='O':row.update(state='PENDING_L_EXIT',disposition='PENDING_L')
    return sha(rows)
def assess_cleanup(expected_resources,observed_resources,observer_exit):
    result=dict(disposition='HOLD',evidence_domain='ARTIFICIAL_STRUCTURAL_ONLY',blockers=[],termination_authorized=False)
    try:
        expected=_inventory(expected_resources);observed=_inventory(observed_resources)
        require(set(expected)==set(observed),'Incomplete/unexpected resource inventory')
        for token,row in expected.items():
            actual=observed[token];stable=RESOURCE_FIELDS-{'state','disposition'}
            require(all(actual[k]==row[k] for k in stable),'Resource identity/rights/generation mismatch')
            require(actual['state']=='CLOSED' and actual['disposition']=='CLOSED','Pending/unknown cleanup')
        exact(observer_exit,{'issuer','resource_id','binding_digest','same_handle','signaled','observed_tick','evidence_ref','evidence_domain','signature','final_inventory'})
        target=expected.get(observer_exit['resource_id']);require(target is not None and target['owner_role']=='O' and target['kind']=='PROCESS','Wrong observer target')
        require(observer_exit['issuer']=='L' and observer_exit['binding_digest']==target['binding_digest'] and observer_exit['same_handle'] is True and observer_exit['signaled'] is True,'Observer cannot self-prove exit')
        integer(observer_exit['observed_tick']);require(observer_exit['observed_tick']+1<target['deadline_tick'] and observer_exit['evidence_domain']=='ARTIFICIAL','Unverified/late real observation')
        inventory=observer_exit['final_inventory'];exact(inventory,{'issuer','tick','inventory_digest','observed_digest','evidence_ref','signature'})
        integer(inventory['tick']);require(inventory['issuer']=='O' and inventory['inventory_digest']==sha(expected_resources) and inventory['observed_digest']==preexit_inventory_digest(observed_resources),'Final inventory mismatch')
        require(inventory['tick']+1<observer_exit['observed_tick'],'Final inventory must precede observed O exit')
        result['disposition']='ARTIFICIAL_STRUCTURAL_COMPLETE'
    except (ValueError,TypeError,KeyError):result['blockers']=['INCOMPLETE_OR_UNVERIFIED_CLEANUP']
    return result
def assess_case(case_id,evidence,expected_resources,scope):
    dimensions={key:False for key in DIMENSIONS};blockers=[];digests=[];ticks={}
    result=dict(case_id=case_id,evidence_domain='ARTIFICIAL',dimensions=dimensions,disposition='HOLD',blockers=blockers,evidence_digests=digests,scientific_acceptance=False)
    try:
        require(case_id in {'AC'+str(i) for i in range(17,23)},'Unknown case');require(scope['evidence_domain']=='ARTIFICIAL','Runtime verifier not adopted')
        b=validate_binding(scope['binding']);integer(scope['now_tick']);integer(scope['evidence_deadline_tick'],True);integer(scope['cleanup_deadline_tick'],True)
        require(expected_resources==scope['expected_resources'] and sha(expected_resources)==scope['inventory_digest'],'Unpinned/swapped inventory')
        _inventory(expected_resources)
        for role in ('O','S','C','W'):
            cap=2 if (case_id=='AC18' and role=='C') or (case_id=='AC19' and role=='W') else 1
            require(sum(r['kind']=='PROCESS' and r['owner_role']==role for r in expected_resources)<=cap,'Unapproved actor generations')
        require(type(evidence) is list and callable(scope['verify_evidence']),'Pinned evidence verification required');seen=set()
        for row in evidence:
            exact(row,{'dimension','issuer','binding','tick','evidence_domain','value','signature'});dim=row['dimension']
            require(dim in DIMENSIONS and dim not in seen,'Duplicate/unknown evidence dimension');seen.add(dim)
            require(row['evidence_domain']=='ARTIFICIAL' and row['binding']==b and row['issuer']==ROLES[dim] and scope['verify_evidence'](copy.deepcopy(row)) is True,'Unverified/wrong-scope evidence')
            integer(row['tick']);limit=scope['cleanup_deadline_tick'] if dim=='cleanup' else scope['evidence_deadline_tick']
            require(row['tick']<=scope['now_tick'] and deadline_state(row['tick'],limit,1)=='BEFORE','Late/ambiguous/future evidence')
            value=row['value'];require(type(value) is dict,'Evidence value required');slot=sha(b)
            if dim=='reservation':dimensions[dim]=value.get('committed') is True and value.get('slot_id')==slot
            elif dim=='control_attempt':dimensions[dim]=value.get('kind')=='CONTROL_ATTEMPT' and value.get('delivery_status')=='ATTEMPTED' and value.get('slot_id')==slot
            elif dim=='worker_application':dimensions[dim]=value.get('kind')=='STOP_APPLIED' and value.get('event_observed') is True and value.get('slot_id')==slot
            elif dim=='original_exit':dimensions[dim]=value.get('same_handle') is True and value.get('signaled') is True and any(r['resource_id']==value.get('resource_id') and r['kind']=='PROCESS' and r['owner_role']=='W' and r['binding_digest']==sha(b) for r in expected_resources)
            elif dim=='cleanup':
                exit_record=value.get('observer_exit');require(type(exit_record) is dict,'Independent L record required')
                inventory=exit_record.get('final_inventory');require(type(inventory) is dict,'Independent O inventory required')
                require(scope['verify_l_observation'](copy.deepcopy(exit_record)) is True and scope['verify_inventory'](copy.deepcopy(inventory)) is True,'Independent L/O authentication failed')
                require(exit_record['observed_tick']+1<row['tick']<=scope['now_tick'] and inventory['tick']<=scope['now_tick'],'Nested future/ambiguous exit')
                dimensions[dim]=assess_cleanup(expected_resources,value.get('observed_resources'),exit_record)['disposition']=='ARTIFICIAL_STRUCTURAL_COMPLETE'
            else:dimensions[dim]=value.get('chain_valid') is True and value.get('source_pins_match') is True
            ticks[dim]=row['tick'];digests.append(sha(row))
        if all(key in ticks for key in DIMENSIONS):
            require(all(ticks[a]+1<ticks[z] for a,z in zip(DIMENSIONS,DIMENSIONS[1:])),'One-tick/ambiguous causal order')
            cleanup=next(row for row in evidence if row['dimension']=='cleanup')['value']['observer_exit']
            require(ticks['original_exit']+1<cleanup['final_inventory']['tick'] and cleanup['observed_tick']+1<ticks['cleanup'],'Cleanup chronology unproven')
        if not all(dimensions.values()):blockers.append('MISSING_OR_UNPROVEN_DIMENSIONS')
        if case_id=='AC19':blockers.append('PID_REUSE_UNAVAILABLE_RETAINED_HANDLE_FULL_AC19_HOLD')
        if case_id=='AC21':blockers.append('FALLBACK_PROFILE_AND_TARGET_ADJUDICATION_REQUIRED')
        if not blockers:result['disposition']='ARTIFICIAL_MODEL_PASS'
    except (ValueError,KeyError,TypeError,AttributeError):blockers.append('INVALID_OR_UNTRUSTED_EVIDENCE')
    return result
