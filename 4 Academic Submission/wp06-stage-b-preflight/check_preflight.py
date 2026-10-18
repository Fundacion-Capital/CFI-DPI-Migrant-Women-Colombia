"""Inert pending-template validation, never permission or a Stage-B executor."""
import json
import pathlib
import re
from urllib.parse import urlsplit

CONTRACT='WP06_STAGE_B_DISPOSABLE_V1'
CASES=['AC'+str(i) for i in range(17,23)]
AUTH={'process_launches','live_control','service_changes','live_probes','stata_execution','participant_processing','fits','process_kills','release','stage_b_execution'}
RUNTIME={'windows_build','interpreter_path','interpreter_sha256','launch_attestor_pid','process_inventory','host_id','boot_id','qpc_frequency_hz','clock_domain_proof','acl_evidence','credential_lifecycle_evidence','active_store_path','archive_path','retention_years','execution_budget_ns','cleanup_budget_ns','ipc_budget_ns','heartbeat_interval_ns','heartbeat_loss_budget_ns','worker_self_ceiling_ns','shutdown_budget_ns','scheduling_delay_bound_ns','active_build_digest','process_launch_grant','fault_grant','fallback_profile_revision','termination_grant'}
FUTURE=['wp06-stage-b/'+n for n in ('launch_stage_b.py','observer.py','supervisor.py','actors.py','win32_bridge.py','journal_protocol.py','test_stage_b.py')]
ROLE_NAMES=['LAUNCH_ATTESTOR','OBSERVER','SUPERVISOR','CONTROLLER','WORKER']
CREATORS=['EXTERNAL_OPERATOR','LAUNCH_ATTESTOR','OBSERVER','OBSERVER','SUPERVISOR']
ENFORCEMENT_STAGES=json.loads('''[{"id":"PRECREATION","obligations":["G01_POLICY","G02_POLICY","G03_POLICY","G04_POLICY","G05_POLICY","G06_POLICY","G07_PLAN","G08_POLICY","G09_LIMITS","G10_PLAN","G11_POLICY","G12_POLICY","G15_PLAN"],"allowed":["APPROVE_EXACT_BUILD_SCOPE_LIMITS_AND_EXPECTED_RESOURCE_MANIFEST"],"blocked":["ACTOR_CREATION_WITHOUT_ALL_PRECREATION_DECISIONS"]},{"id":"QUIESCENT_BOOTSTRAP","obligations":["ALL_PRECREATION_DECISIONS_AUTHENTICATED","BOUNDED_BOOTSTRAP_CEILING_AND_LAUNCH_CAPS"],"allowed":["CREATE_ONLY_PREDECLARED_IDLE_ACTORS_AND_PRIVATE_RESOURCES","COLLECT_ACTUAL_IDENTITY_CLOCK_PEER_AND_RESOURCE_EVIDENCE"],"blocked":["WORK_DISPATCH","FAULT_STIMULUS","LIVE_CONTROL","TERMINATION","RETRY_OR_EXTRA_LAUNCH_ON_FAILURE"]},{"id":"PREARM_WORK_FAULT","obligations":["ALL_PRECREATION_DECISIONS_AUTHENTICATED","G04_OBSERVED","G07_OBSERVED","G08_OBSERVED","G09_RUNTIME_BOUND","G10_ARMED","G11_EXACT_FAULT_AUTHORITY","RESERVATION_AND_SINGLE_USE_SLOT_COMMITTED"],"allowed":["ONLY_EXACT_SEPARATELY_AUTHORIZED_CASE_WORK_AND_FAULT"],"blocked":["MISSING_RUNTIME_BINDING","UNBOUNDED_CALIBRATION","IMPLICIT_RETRY"]},{"id":"CONDITIONAL_FALLBACK","obligations":["ALL_PREARM_OBLIGATIONS","G13_PROFILE_REVISION","G14_EXACT_TARGET_TERMINATION_GRANT"],"allowed":["ONLY_AC21_EXACT_OWNED_WORKER_REQUEST_WITHIN_UNCHANGED_CEILING"],"blocked":["DEFAULT_FALLBACK","PID_ONLY_TARGETING","RETRY"]},{"id":"COMPLETION","obligations":["ALL_APPLICABLE_CASE_GATES","WORKER_APPLICATION_OBSERVED","SAME_RETAINED_HANDLE_EXIT","G15_OBSERVED_RESOURCE_CLEANUP","L_OBSERVES_O_EXIT","FULL_CASE_COVERAGE_OR_HOLD"],"allowed":["ASSESS_EVIDENCE_AND_PRESERVE_DISPOSITION"],"blocked":["INFER_EXIT_FROM_REQUEST","RELEASE_OR_SCIENTIFIC_APPROVAL"]}]''')
PROFILES=dict(control='COOPERATIVE_ONLY',fallback_enabled=False,AC21='CONDITIONAL_BLOCKED_PENDING_PROFILE_REVISION_AND_EXACT_GRANT',
    transport='LOCAL_EXPLICIT_ACL_OVERLAPPED_PIPE_AND_PRIVATE_WORKER_EVENT',journal='LOCAL_RESTRICTED_SINGLE_WRITER_DELETE_EXTRA_NO_RETRY',
    clock='PROPOSED_QPC_INTEGER_DOMAIN_REQUIRES_OPERATOR_ADOPTION',boot_binding='LOGICAL_RUN_BOOT_NAMESPACE_RETAINED_OBSERVER_NO_RESUME',
    stop_consumer='SUPERVISOR_WATCHDOG_SINGLE_CONSUMER_PRECOMMITTED_SLOT',pid_reuse='RETAINED_HANDLE_REPLACEMENT_ONLY_FULL_AC19_HOLD_PENDING_REVIEWED_SCOPE_RESTRICTION')
PROHIBITED={'auto_restart','default_or_shared_target','pid_or_name_only_target','shell_or_arbitrary_code','job_assignment_or_kill_on_close','stage_a_public_keys_or_operational_import','uncertain_io_buffer_reuse','wait_handle_close_before_completion','scientific_authority_inheritance'}
GATES=[('EXACT_DESIGN_REVIEW','OWNER'),('FUTURE_BUILD_PIN_SCOPE','OPERATOR'),('HOST_RUNTIME_COMPATIBILITY','OPERATOR'),('TRUSTED_HOST_BOOT_CLOCK','OPERATOR'),
    ('LOCAL_STORAGE_RETENTION','STEWARD'),('PROCESS_LAUNCH_SCOPE','OWNER'),('OWNED_TARGET_INVENTORY','OPERATOR'),('PIPE_ACL_AUTHENTICATION','OPERATOR'),
    ('NUMERIC_BUDGETS_DELAY_BOUNDS','OPERATOR'),('INDEPENDENT_SUPERVISOR_PREARM','ASSESSOR'),('EXACT_FAULT_SCOPE','OWNER'),('INDEPENDENT_ACCEPTANCE_ASSESSOR','OWNER'),
    ('FALLBACK_PROFILE_REVISION','OWNER'),('EXACT_WORKER_TERMINATION_SCOPE','OWNER'),('CLEANUP_DISCLOSURE','STEWARD')]
REQUIREMENTS=[['C07'],['C03','C07','C09'],['C02','C05'],['C04','C06','C08'],['C07','C11'],['C10','C11','C12']]
VARIANTS=['BLOCK_CONTROLLER_AND_WORK_QUEUE_KEEP_INDEPENDENT_PATH','CONTROLLER_SELF_EXIT_OR_HEARTBEAT_SEVER_PREDECLARED_SECOND_CLIENT',
    'TWO_PREDECLARED_WORKERS_NO_PID_CHURN_NO_UNOBSERVED_REUSE_PASS','BOUNDED_TRANSPORT_RECEIPT_FAULTS_NO_RESPONSE_DEPENDENT_CLEANUP',
    'DISABLED_EXACT_OWNED_WORKER_FALLBACK_CONDITIONAL','ALL_OWNED_RESOURCES_AND_OBSERVER_EXIT_ATTESTED']
PINS={'case_catalogue':'4 Academic Submission/wp06-operational-contract/acceptance_plan.json',
    'stage_a_seal':'4 Academic Submission/audit-local/intake/wp06-stage-a-implementation-c870e8b/validation.json',
    'stage_a_closure':'4 Academic Submission/audit-local/intake/wp06-stage-a-implementation-c870e8b-verification/closure.json',
    'profile_checkpoint':'4 Academic Submission/wp06-operator-checkpoint/checkpoint.json'}

def require(condition,message):
    if not condition:raise ValueError(message)

def schema(value,keys):require(type(value) is dict and set(value)==set(keys),'Exact documentary schema required')
def text(value):require(type(value) is str and bool(value.strip()),'Nonempty documentary text required')
def whole(value,expected):require(type(value) is int and value==expected,'Exact integer required')

def check(design,gates,cases,sources):
    schema(design,{'contract_id','kind','phase','status','operational_eligible','cases_executed','authority','source_pins','roles','launch_caps','profiles','prohibited','future_files','runtime_observations_available','source_ids'})
    require(design['contract_id']==CONTRACT and design['kind']=='DESIGN_AND_NO_EXECUTION_PREFLIGHT_ONLY' and design['phase']=='B_DISPOSABLE' and design['status']=='DESIGN_ONLY_NOT_ADOPTED','Design is not adoption')
    require(design['operational_eligible'] is False and design['runtime_observations_available'] is False,'No readiness/host promotion')
    whole(design['cases_executed'],0);schema(design['authority'],AUTH)
    for value in design['authority'].values():whole(value,0)
    schema(design['source_pins'],PINS)
    for key,path in PINS.items():
        pin=design['source_pins'][key];schema(pin,{'file','bytes','sha256'})
        require(pin['file']==path and type(pin['bytes']) is int and pin['bytes']>0 and type(pin['sha256']) is str and re.fullmatch('[0-9A-Fa-f]{64}',pin['sha256']) is not None,'Exact source pin metadata')
    require(type(design['roles']) is list and len(design['roles'])==5,'Exact role list')
    for index,role in enumerate(design['roles']):
        schema(role,{'role','creator','new_process','max_simultaneous'})
        require(role['role']==ROLE_NAMES[index] and role['creator']==CREATORS[index] and role['new_process'] is (index!=0),'Role topology')
        whole(role['max_simultaneous'],0 if index==0 else 1)
    caps={'max_concurrent_new':4,'default_total_new':4,'AC18_total_new':5,'AC19_total_new':5,'retries':0,'unplanned_replacements':0}
    schema(design['launch_caps'],caps)
    for key,value in caps.items():whole(design['launch_caps'][key],value)
    schema(design['profiles'],PROFILES)
    require(design['profiles']==PROFILES and design['profiles']['fallback_enabled'] is False,'Selected profiles remain pending/cooperative-only')
    schema(design['prohibited'],PROHIBITED);require(all(v is True for v in design['prohibited'].values()),'Prohibited actions stay prohibited')
    require(type(design['future_files']) is list and design['future_files']==FUTURE,'Exact future file list')
    ids=['S'+str(i).zfill(2) for i in range(1,16)];require(design['source_ids']==ids,'Complete source references')

    schema(gates,{'contract_id','kind','runtime','gates','enforcement_stages'})
    require(gates['enforcement_stages']==ENFORCEMENT_STAGES,'Exact ordered policy, bootstrap, observation, fallback and completion boundaries')
    require(gates['contract_id']==CONTRACT and gates['kind']=='PENDING_EXTERNAL_GATE_TEMPLATE','Gate contract')
    schema(gates['runtime'],RUNTIME);require(all(v is None for v in gates['runtime'].values()),'Runtime facts unknown; no invented values')
    require(type(gates['gates']) is list and len(gates['gates'])==15,'Exact pending gate list')
    for index,(row,(checkpoint,role)) in enumerate(zip(gates['gates'],GATES)):
        schema(row,{'id','checkpoint','responsible_role','status','approved','decision_maker','decision_date','rationale','evidence_ref','required_for'})
        require(row['id']=='G'+str(index+1).zfill(2) and row['checkpoint']==checkpoint and row['responsible_role']==role,'Gate identity/role')
        require(row['status']=='PENDING_EXTERNAL_INPUT' and row['approved'] is False,'Real decisions not approved here')
        require(all(type(row[k]) is str and row[k]=='' for k in ('decision_maker','decision_date','rationale','evidence_ref')),'Blank real decision fields')
        require(row['required_for']==(['AC21'] if index in (12,13) else CASES),'Gate applicability')

    schema(cases,{'contract_id','kind','cases'})
    require(cases['contract_id']==CONTRACT and cases['kind']=='UNEXECUTED_STAGE_B_CASE_PLANS','Case contract')
    require(type(cases['cases']) is list and len(cases['cases'])==6,'Exactly six case plans')
    for index,row in enumerate(cases['cases']):
        schema(row,{'id','phase','requirements','precondition','stimulus','pass_evidence','failure_disposition','status','execution_evidence','variant','required_gates','max_new_processes','max_concurrent_new','conditional_fallback','actual_inventory','independent_evidence','execution_authorized'})
        require(row['id']==CASES[index] and row['phase']=='B_DISPOSABLE' and row['requirements']==REQUIREMENTS[index] and row['variant']==VARIANTS[index],'Exact catalogue crosswalk')
        require(row['status']=='NOT_EXECUTED' and type(row['execution_evidence']) is list and row['execution_evidence']==[] and row['execution_authorized'] is False and row['actual_inventory'] is None,'No runtime evidence or authority')
        for key in ('precondition','stimulus','pass_evidence','failure_disposition'):text(row[key])
        require(row['required_gates']==[g['id'] for g in gates['gates'] if row['id'] in g['required_for']],'Exact case gate mapping')
        whole(row['max_new_processes'],5 if index in (1,2) else 4);whole(row['max_concurrent_new'],4)
        require(row['conditional_fallback'] is (index==4),'Conditional fallback remains visible')
        expected=['SEPARATE_PROFILE_REVISION','EXACT_WORKER_TERMINATION_GRANT','RETAINED_HANDLE_EXIT','CLEANUP_INVENTORY'] if index==4 else ['CURRENT_BUILD_SCOPE','AUTHENTICATED_ORDERED_OBSERVATIONS','SAME_HANDLE_EXIT','BOUNDED_CLEANUP_INVENTORY']
        require(row['independent_evidence']==expected,'Future evidence obligations')

    schema(sources,{'kind','verified_on','sources'})
    require(sources['kind']=='OFFICIAL_DOCUMENTATION_NOT_HOST_VALIDATION' and sources['verified_on']=='2026-10-18','Documentation boundary')
    require(type(sources['sources']) is list and len(sources['sources'])==15,'Exact source registry')
    for index,row in enumerate(sources['sources']):
        schema(row,{'id','title','url','publisher','status','fact','host_verified'})
        require(row['id']==ids[index] and row['publisher']=='Microsoft' and row['status']=='DOCUMENTATION_VERIFIED' and row['host_verified'] is False,'Source not host proof')
        text(row['title']);text(row['fact']);text(row['url']);url=urlsplit(row['url'])
        require(url.scheme=='https' and url.netloc=='learn.microsoft.com' and url.path.startswith('/en-us/windows/') and not url.query and not url.fragment,'Official primary URL required')
    return dict(status='DOCUMENTARY_PREFLIGHT_PASS_EXECUTION_BLOCKED',operational_eligible=False,cases_executed=0,stage_b_cases=6,
        blocking_gates=[g['id'] for g in gates['gates']],missing_runtime_fields=sorted(RUNTIME),conditional_cases=['AC21'],process_launch_authority=0,live_control_authority=0)

if __name__=='__main__':
    root=pathlib.Path(__file__).resolve().parent
    values=[json.loads((root/name).read_text(encoding='utf-8')) for name in ('design.json','gates.json','cases.json','sources.json')]
    print(json.dumps(check(*values),indent=2))
