"""Validate this documentary package only; cannot authenticate or authorize runtime work."""
import json
import pathlib

CID='WP06_OPERATIONAL_INTEGRATION_V1'
AUTH=('service_changes','live_probes','stata_execution','participant_processing','fits','live_stop_calls','process_kills','release')
BINDING=('contract_digest','build_digest','host_id','boot_id','session_id','owner_nonce','worker_epoch','command_id','pid','creation_time','engine_module_digest','reservation_id','lease_id','scope_id')
RECEIPTS=('receipt_id','message_type','sequence','previous_digest','binding','clock_domain','monotonic_time','utc_audit_time','issuer_principal','credential_id','authentication_proof_ref','payload_digest','status_code')
PHASES={'A_ARTIFICIAL':['new_artificial_implementation_scope'],'B_DISPOSABLE':['new_disposable_process_scope'],
        'C_EMPTY_ENGINE':['new_empty_engine_scope','operator_integration_adoption']}
CONDITIONAL={'any_service_or_configuration_write':'new_exact_service_change_scope','any_process_termination':'new_exact_owned_termination_scope',
        'any_engine_execution':'new_empty_engine_scope','any_fit_or_participant_processing':'OUT_OF_SCOPE_REQUIRES_SEPARATE_RESEARCH_CONTRACT'}

def need(condition,message):
    if not condition:raise ValueError(message)

def obj(value,keys):
    need(type(value) is dict and all(type(k) is str for k in value) and set(value)==set(keys),'Exact documentary object required')

def text(value):need(type(value) is str and bool(value.strip()),'Nonempty text required')

def strings(value,expected):
    need(type(value) is list and all(type(x) is str and bool(x.strip()) for x in value),'String list required')
    need(len(value)==len(set(value)) and set(value)==set(expected),'Missing, duplicate or unexpected field')

def check(contract,plan):
    obj(contract,('contract_id','version','kind','current_phase','operational_ready','real_approvals','authorities','binding_fields',
        'receipt_fields','required_receipts','phase_authorizations','conditional_authorizations','requirements','open_choices'))
    for key,want in (('contract_id',CID),('kind','DOCUMENTARY_ONLY'),('current_phase','DOCUMENTARY_PREPARATION')):
        need(type(contract[key]) is str and contract[key]==want,'Not a documentary contract')
    need(type(contract['version']) is int and contract['version']==1,'Version mismatch')
    need(contract['operational_ready'] is False,'No operational readiness in this package')
    need(type(contract['real_approvals']) is int and contract['real_approvals']==0,'No real approvals in this package')
    obj(contract['authorities'],AUTH)
    need(all(type(x) is int and x==0 for x in contract['authorities'].values()),'All authority must remain integer zero')
    strings(contract['binding_fields'],BINDING);strings(contract['receipt_fields'],RECEIPTS)
    strings(contract['required_receipts'],('REGISTERED','RESERVED_DURABLE','SUPERVISOR_ARMED','STOP_APPLIED_IF_REQUESTED','ENGINE_EXIT_OBSERVED','CLEANUP_OBSERVED'))
    obj(contract['phase_authorizations'],PHASES)
    for phase,auth in PHASES.items():strings(contract['phase_authorizations'][phase],auth)
    obj(contract['conditional_authorizations'],CONDITIONAL)
    need(all(type(contract['conditional_authorizations'][k]) is str and contract['conditional_authorizations'][k]==v for k,v in CONDITIONAL.items()),'Action-specific scope cannot be weakened')
    requirements=contract['requirements'];need(type(requirements) is list,'Requirements list required')
    ids=[]
    for row in requirements:
        obj(row,('id','obligation','required_evidence','implementation_status'))
        for field in row:text(row[field])
        ids.append(row['id'])
        expected='ARTIFICIAL_PARTIAL' if row['id'] in ('C05','C06','C08','C09') else 'NOT_IMPLEMENTED'
        need(row['implementation_status']==expected,'Do not promote implementation status')
    strings(ids,['C%02d'%i for i in range(1,13)])
    choices=contract['open_choices'];need(type(choices) is list,'Open choices list required');choice_ids=[]
    for row in choices:
        obj(row,('id','subject','role','checkpoint','status','selected_value','evidence_ref'))
        for field in row:need(type(row[field]) is str,'Choice fields must be strings')
        text(row['subject']);choice_ids.append(row['id'])
        need(row['role'] in ('runtime_operator','project_owner_and_runtime_operator','project_owner_and_institution'),'Unknown choice role')
        need(row['checkpoint']==('D1_rights' if row['id']=='O07' else 'D5_operational'),'Checkpoint mismatch')
        need(row['status']=='PENDING_OPERATOR_DECISION' and row['selected_value']==row['evidence_ref']=='','Do not fabricate a choice or approval')
    strings(choice_ids,['O%02d'%i for i in range(1,8)])
    obj(plan,('contract_id','kind','cases'))
    need(type(plan['contract_id']) is str and plan['contract_id']==CID,'Contract cross-reference mismatch')
    need(type(plan['kind']) is str and plan['kind']=='PLANNED_ACCEPTANCE_ONLY','Planned cases only')
    need(type(plan['cases']) is list,'Cases list required');case_ids=[];coverage=set()
    for row in plan['cases']:
        obj(row,('id','phase','requirements','precondition','stimulus','pass_evidence','failure_disposition','status','execution_evidence'))
        for field in ('id','phase','precondition','stimulus','pass_evidence','failure_disposition','status'):text(row[field])
        need(row['id'] in ['AC%02d'%i for i in range(1,29)],'Unknown acceptance ID')
        index=int(row['id'][2:]);phase='A_ARTIFICIAL' if index<=16 else ('B_DISPOSABLE' if index<=22 else 'C_EMPTY_ENGINE')
        need(row['phase']==phase,'Phase cannot be downgraded')
        need(type(row['requirements']) is list and len(row['requirements'])>0,'Requirement coverage required')
        need(all(type(x) is str and x in ids for x in row['requirements']),'Unknown requirement')
        need(len(row['requirements'])==len(set(row['requirements'])),'Duplicate requirement mapping')
        coverage.update(row['requirements']);case_ids.append(row['id'])
        need(row['status']=='NOT_EXECUTED' and type(row['execution_evidence']) is list and not row['execution_evidence'],'No planned case was executed here')
    strings(case_ids,['AC%02d'%i for i in range(1,29)]);need(coverage==set(ids),'Uncovered integration requirement')
    return dict(status='DOCUMENTARY_VALIDATION_ONLY',documentary_validated=True,operational_eligible=False,
        planned_cases=28,planned_cases_executed=0,open_choices=7,real_approvals=0,fit_authority=0,live_probe_authority=0)

if __name__=='__main__':
    root=pathlib.Path(__file__).resolve().parent
    print(json.dumps(check(json.loads((root/'contract.json').read_text(encoding='utf-8')),json.loads((root/'acceptance_plan.json').read_text(encoding='utf-8'))),indent=2))
