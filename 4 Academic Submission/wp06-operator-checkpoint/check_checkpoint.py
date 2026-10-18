"""Documentary recommendation checker; never adopts a choice or verifies a host."""
import json
import pathlib
from urllib.parse import urlsplit

AUTH=('service_changes','live_probes','stata_execution','participant_processing','fits','live_stop_calls','process_kills','release')
HOSTS={'www.sqlite.org':'SQLite','sqlite.org':'SQLite','learn.microsoft.com':'Microsoft','docs.python.org':'Python','www.rfc-editor.org':'RFC Editor'}

def need(ok,message):
    if not ok:raise ValueError(message)

def obj(value,keys):need(type(value) is dict and all(type(x) is str for x in value) and set(value)==set(keys),'Exact documentary object required')

def text(value):need(type(value) is str and bool(value.strip()),'Nonempty text required')

def texts(value):
    need(type(value) is list and len(value)>0,'Nonempty list required')
    for x in value:text(x)
    need(len(value)==len(set(value)),'Duplicate list item')

def check(checkpoint,registry):
    obj(checkpoint,('kind','source_contract','prepared_on','operational_ready','real_decisions_recorded','planned_cases_executed','authorities',
        'host_compatibility','real_execution_budget_ns','real_cleanup_budget_ns','active_store_path','archive_path','retention_years','recommendations'))
    for key,want in (('kind','EVIDENCE_BACKED_RECOMMENDATIONS_ONLY'),('source_contract','WP06_OPERATIONAL_INTEGRATION_V1'),
        ('prepared_on','2026-10-18'),('host_compatibility','NOT_ASSESSED_NO_LIVE_PROBE')):
        need(type(checkpoint[key]) is str and checkpoint[key]==want,'No promotion beyond documented recommendation scope')
    need(checkpoint['operational_ready'] is False,'Operational readiness is false')
    for key in ('real_decisions_recorded','planned_cases_executed'):
        need(type(checkpoint[key]) is int and checkpoint[key]==0,'No real decision or case execution')
    obj(checkpoint['authorities'],AUTH)
    need(all(type(v) is int and v==0 for v in checkpoint['authorities'].values()),'All authority remains integer zero')
    for key in ('real_execution_budget_ns','real_cleanup_budget_ns','active_store_path','archive_path','retention_years'):
        need(checkpoint[key] is None,'Unmeasured/unapproved value must remain null')
    obj(registry,('verified_on','scope','sources'));text(registry['scope'])
    need(type(registry['verified_on']) is str and registry['verified_on']==checkpoint['prepared_on'],'Source date mismatch')
    need(type(registry['sources']) is list,'Source list required');source_ids=[]
    for source in registry['sources']:
        obj(source,('id','publisher','url','status','claim'))
        for value in source.values():text(value)
        parsed=urlsplit(source['url'])
        need(parsed.scheme=='https' and parsed.netloc in HOSTS and not parsed.username and not parsed.password,'Official primary URL required')
        need(source['publisher']==HOSTS[parsed.netloc] and source['status']=='DOCUMENTATION_VERIFIED','Documentation facts, not host verification')
        source_ids.append(source['id'])
    need(len(source_ids)==16 and set(source_ids)=={'S%02d'%i for i in range(1,17)},'Exact source register required')
    need(type(checkpoint['recommendations']) is list,'Recommendation list required');ids=[];all_req=set();all_cases=set()
    for row in checkpoint['recommendations']:
        obj(row,('id','role','checkpoint','profile','basis','recommendation','rationale','alternatives','sources','requirements','cases','limits','decision'))
        for key in ('id','role','checkpoint','profile','basis','recommendation','rationale'):text(row[key])
        need(row['id'] in ['O%02d'%i for i in range(1,8)],'Unknown selection ID');ids.append(row['id'])
        role='project_owner_and_institution' if row['id']=='O07' else ('project_owner_and_runtime_operator' if row['id']=='O06' else 'runtime_operator')
        need(row['role']==role and row['checkpoint']==('D1_rights' if row['id']=='O07' else 'D5_operational'),'Role/checkpoint mismatch')
        need(row['basis']=='DESIGN_RECOMMENDATION_NOT_OPERATOR_ADOPTION','Recommendation is not adoption')
        for key in ('alternatives','sources','requirements','cases','limits'):texts(row[key])
        need(set(row['sources'])<=set(source_ids),'Unknown source reference')
        need(set(row['requirements'])<={'C%02d'%i for i in range(1,13)},'Unknown contract requirement')
        need(set(row['cases'])<={'AC%02d'%i for i in range(1,29)},'Unknown acceptance case')
        all_req.update(row['requirements']);all_cases.update(row['cases'])
        decision=row['decision'];obj(decision,('status','approved','selected_value','decision_maker','decision_date','rationale','evidence_ref'))
        need(type(decision['status']) is str and decision['status']=='PENDING_EXTERNAL_DECISION' and decision['approved'] is False,'No real approval recorded')
        need(all(type(decision[k]) is str and decision[k]=='' for k in ('selected_value','decision_maker','decision_date','rationale','evidence_ref')),'Do not fabricate decision fields')
    need(len(ids)==7 and set(ids)=={'O%02d'%i for i in range(1,8)},'Seven unique selections required')
    need(all_req=={'C%02d'%i for i in range(1,13)} and all_cases=={'AC%02d'%i for i in range(1,29)},'Incomplete contract/case crosswalk')
    return dict(status='SEVEN_DOCUMENTED_RECOMMENDATIONS_NOT_ADOPTED',recommendations=7,verified_documentation_sources=16,
        operational_eligible=False,real_decisions_recorded=0,planned_cases_executed=0,fit_authority=0,live_probe_authority=0)

if __name__=='__main__':
    root=pathlib.Path(__file__).resolve().parent
    print(json.dumps(check(json.loads((root/'checkpoint.json').read_text(encoding='utf-8')),json.loads((root/'sources.json').read_text(encoding='utf-8'))),indent=2))
