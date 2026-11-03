"""Artificial-only TARGET33 controller. No live transport or carrier access."""
from collections import defaultdict
import csv
from dataclasses import dataclass
import hashlib
import io
import json
from pathlib import Path
import re

STATES=('observed_valid','structural_skip','unavailable_in_version','applicable_nonresponse','sentinel','unresolved')
COUNT=object()
STATUS=object()
REFERENCE_N=423
PER_STEP=45
WORK=180
CLEANUP=30
TOTAL=210
STEPS=('P1','P2','P3','P4')
SOURCE_DIGESTS=(
    'dfa977ccf641624a97a010af17b1944f362291faaaa10775ea86ce597e302992',
    'dbfb0593dcf4ccb09f3b9cbe57b49ddb8ec4c1d6fc73dee476668ffad60b9a63',
    '7e8761029a09b5dd9f775225268182a8e5a13b68da4d4cfe88d0212aa1a64454',
    'e8683c83e2e8e98acbd50ddcff68f91f66213b13e83d21c07bd735baf5624829',
)
LOG_PREFIX='ARTIFICIAL_ONLY:'


def need(ok,label):
    if not ok:
        raise ValueError(label)


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def load(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))


def sealed(academic,folder,anchor):
    seal=folder/'seal.json'
    need(digest(seal.read_bytes())==anchor,'seal_changed')
    record=load(seal)
    if 'files' in record:
        members=[(Path(row['path']),row['sha256'],row['bytes']) for row in record['files']]
    else:
        members=[(academic.parent/path,sha,None) for path,sha in record.items()]
    for path,wanted,size in members:
        need(path.suffix.lower() not in {'.dta','.xlsx','.xls'},'non_documentary_seal_member')
        raw=path.read_bytes()
        need(digest(raw)==wanted and (size is None or size==len(raw)),'member_changed')
    need(load(folder/'readback.json')['passed'] is True,'readback_failed')
    return len(members)


@dataclass(frozen=True)
class Output:
    name: str
    header: tuple
    rows: tuple


@dataclass(frozen=True)
class Step:
    id: str
    body: bytes
    sha256: str
    outputs: tuple


@dataclass(frozen=True)
class Plan:
    steps: tuple
    output_root: Path
    versions: tuple
    checks: tuple
    custody: tuple
    live_enabled: bool=False


def templates(body,versions):
    """Read only the known file-write grammar in the sealed source."""
    result={}
    active=None
    for line in body.decode().splitlines():
        line=line.strip()
        if line.startswith("file open"):
            m=re.fullmatch(r'''file open `out' using "\$wp07_target33_out/([a-z0-9_.]+)", write text''',line)
            need(m and active is None and m[1] not in result,'output_open_contract')
            active=m[1]
            result[active]=[]
        elif line=="file close `out'":
            need(active is not None,'unexpected_close')
            active=None
        elif line.startswith("file write"):
            need(active is not None,'write_without_open')
            s=line.removeprefix("file write `out' ")
            s=re.sub(r'\(cond\([^)]*\)\)',' @STATUS@ ',s)
            s=re.sub(r'\((?:r\(N\)|`(?:checked|applicable|yes)'+"'"+r'|_N-`yes'+ "'"+r')\)',' @COUNT@ ',s)
            tokens=re.findall(r'"[^"]*"|@STATUS@|@COUNT@|_n',s)
            need(''.join(tokens)==re.sub(r'\s+(?=(?:[^"]*"[^"]*")*[^"]*$)','',s),'unapproved_write_expression')
            text=''.join(t[1:-1] if t.startswith('"') else t if t.startswith('@') else '\n' for t in tokens)
            if "`fv'" in text:
                result[active].extend(text.replace("`fv'",v).replace("`meaning'",state)
                    .replace('@STATUS@','indeterminate' if state=='unresolved' else 'supported')
                    for v in versions for state in STATES)
            else:
                result[active].append(text)
    need(active is None,'output_not_closed')
    outputs=[]
    for name,lines in result.items():
        if name.endswith('.csv'):
            split=[tuple(row) for row in csv.reader(io.StringIO(''.join(lines)))]
            need(split and all(len(row)==len(split[0]) for row in split),'wrong_csv_width')
            rows=tuple(tuple(COUNT if v=='@COUNT@' else STATUS if v=='@STATUS@' else v for v in row) for row in split[1:])
            outputs.append(Output(name,split[0],rows))
        else:
            outputs.append(Output(name,(),(''.join(lines),)))
    return tuple(outputs)


def load_plan(academic):
    intake=academic/'audit-local/intake'
    pre=intake/'wp07-target33-preflight-3c51c36'
    source=intake/'wp07-target33-selections-3c51c36'
    custody=(sealed(academic,pre,'5abab6c465f42623ca2fb51a72c83b86cc9031d0047b040a6756de48475e1b99'),
             sealed(academic,source,'c6f180167ea0c7b46544c1bea7d04156d40a7a8865bd2900504f8321ff89bf98'))
    contract_file=academic/'wp06-nofit-verification-preflight/verification_contract.json'
    need(digest(contract_file.read_bytes())=='07ed5f67c367aa2fe80e129abe3ec8b062b372625c36efb787070653da6bffaa','contract_changed')
    contract=load(contract_file)
    versions=tuple(contract['version_reference']['versions'])
    catalogue=contract_file.with_name('verification_checks.csv')
    need(digest(catalogue.read_bytes())==load(pre/'adapter_static.json')['checks']['sha256'],'catalogue_changed')
    with catalogue.open(encoding='utf-8-sig',newline='') as f:
        checks=tuple((r['check_id'],r['operation']) for r in csv.DictReader(f))
    need(len(checks)==33 and len(dict(checks))==33,'check_catalogue')
    need(contract['budget_proposal']==dict(adopted=False,participant_loads=1,participant_selection_calls=4,
         max_seconds_per_selection=PER_STEP,max_work_seconds=WORK,cleanup_seconds=CLEANUP,max_total_seconds=TOTAL,
         retries=0,max_fits=0),'budget_contract')
    binding=load(pre/'binding.json')
    root=Path(binding['output_candidate']['root'])
    need(root.parent==intake.resolve() and root==root.resolve() and not root.exists(),'output_root_not_absent')
    steps=[]
    expected={o['name']:tuple(o.get('columns',())) for o in contract['outputs']['files']}
    for step,wanted in zip(STEPS,SOURCE_DIGESTS):
        filename=step+'.do'
        raw=(academic/'wp07-target33-selections'/filename).read_bytes()
        sha=load(source/'audit_final.json')['sources'][filename]['sha256']
        need(digest(raw)==sha==wanted,'source_changed')
        outputs=templates(raw,versions)
        need(all(expected[o.name]==o.header for o in outputs),'output_schema')
        steps.append(Step(step,raw,sha,outputs))
    need(sum(s.body.count(b'quietly use ') for s in steps)==1,'load_contract')
    return Plan(tuple(steps),root,versions,checks,custody)


def count(value):
    need(re.fullmatch(r'0|[1-9][0-9]{0,2}',value) and int(value)<=REFERENCE_N,'count_type_or_bound')
    return int(value)


def check_outputs(step,outputs,versions):
    need(type(outputs) is dict and set(outputs)=={o.name for o in step.outputs},'output_membership')
    for spec in step.outputs:
        raw=outputs[spec.name]
        need(type(raw) is str and len(raw)<=2_000_000,'output_size_or_type')
        if not spec.header:
            need(raw==spec.rows[0],'readout_template')
            continue
        csv_rows=list(csv.reader(io.StringIO(raw),strict=True))
        need(csv_rows and tuple(csv_rows[0])==spec.header and len(csv_rows)==len(spec.rows)+1,'csv_shape')
        for actual,wanted in zip(csv_rows[1:],spec.rows):
            need(len(actual)==len(wanted),'csv_columns')
            for value,rule in zip(actual,wanted):
                if rule is COUNT:
                    count(value)
                elif rule is STATUS:
                    need(value in {'supported','unsupported'},'status_domain')
                else:
                    need(value==rule,'unapproved_output_value')
        data=list(csv.DictReader(io.StringIO(raw),strict=True))
        if step.id=='P1':
            for row in data:
                if row['check_id'] in {'P1.05','P1.06','P1.07','P1.08'}:
                    yes,other=count(row['observed_n']),count(row['discrepancy_n'])
                    need(yes+other==REFERENCE_N and row['status']==('supported' if other==0 else 'unsupported'),'screening_total')
            need(data[1]['observed_n']==str(REFERENCE_N),'cohort_total')
        if step.id=='P2':
            population={row['form_version']:count(row['observed_n']) for row in data if row['check_id']=='P2.01'}
            need(set(population)==set(versions) and sum(population.values())==REFERENCE_N,'version_total')
            groups=defaultdict(int)
            for row in data:
                if row['check_id']=='P2.03':
                    v=row['form_version']
                    need(count(row['checked_n'])==population[v],'state_denominator')
                    groups[(row['field'],v)]+=count(row['observed_n'])
            need(len(groups)==500 and all(n==population[v] for (_,v),n in groups.items()),'six_state_total')
        if step.id=='P4':
            for row in data:
                if row['applicable_n']!='NA':
                    need(count(row['complete_input_n'])<=count(row['valid_n'])<=count(row['applicable_n']),
                         'coverage_order')


class ArtificialTransport:
    """Deterministic fixture only. Stores no rows, paths, credentials or handles."""
    def __init__(self,plan,durations=(1,1,1,1),fault=None,cleanup_duration=1,cleanup_ok=True,cancel_ok=True):
        need(len(durations)==4 and all(type(x) is int and x>=0 for x in (*durations,cleanup_duration))
             and type(cleanup_ok) is bool and type(cancel_ok) is bool,'artificial_clock_contract')
        self.plan=plan
        self.durations=durations
        self.fault=fault
        self.cleanup_duration=cleanup_duration
        self.cleanup_ok=cleanup_ok
        self.cancel_ok=cancel_ok
        self.tick=0
        self.calls=[]
        self.cancel_calls=self.cleanup_calls=0
        self.used=False

    def select(self,step,deadline):
        self.calls.append(step.id)
        self.tick+=self.durations[len(self.calls)-1]
        outputs={}
        for spec in step.outputs:
            if not spec.header:
                outputs[spec.name]=spec.rows[0]
                continue
            text=io.StringIO()
            writer=csv.writer(text,lineterminator='\n')
            writer.writerow(spec.header)
            for expected in spec.rows:
                row=[]
                for i,rule in enumerate(expected):
                    val=rule
                    if rule is COUNT:
                        val='0'
                        if expected[0]=='P1.02' or (expected[0] in {'P1.05','P1.06','P1.07','P1.08'} and i==2):
                            val=str(REFERENCE_N)
                        if expected[0] in {'P2.01','P2.03'} and expected[2]==self.plan.versions[0]:
                            if expected[0]=='P2.01' or i==5 or expected[3]=='applicable_nonresponse':
                                val=str(REFERENCE_N)
                    elif rule is STATUS:
                        val='supported'
                    row.append(val)
                writer.writerow(row)
            outputs[spec.name]=text.getvalue()
        result=dict(scope='ARTIFICIAL_ONLY',step=step.id,sha256=step.sha256,ok=True,
                    simulated_loads=int(step.id=='P1'),outputs=outputs,log=LOG_PREFIX+step.id)
        if step.id=='P2':
            name=next(iter(outputs))
            if self.fault=='missing_row':
                outputs[name]=outputs[name].rsplit('\n',2)[0]+'\n'
            elif self.fault=='raw_value':
                outputs[name]=outputs[name].replace('formdef_version,','raw_response,',1)
            elif self.fault=='foreign_scope':
                result['scope']='FOREIGN'
            elif self.fault=='wrong_digest':
                result['sha256']='0'*64
            elif self.fault=='nonaggregate_log':
                result['log']='ARTIFICIAL RAW VALUE'
            elif self.fault=='extra_output':
                outputs['extra.csv']='synthetic forbidden'
            elif self.fault=='count_not_reconciled':
                outputs[name]=outputs[name].replace(',423,423,NA,supported',',423,422,NA,supported',1)
        return result

    def cancel(self):
        self.cancel_calls+=1
        return self.cancel_ok

    def cleanup(self,deadline):
        self.cleanup_calls+=1
        self.tick+=self.cleanup_duration
        return self.cleanup_ok


def dispatch(plan,transport):
    need(type(transport) is ArtificialTransport and transport.plan is plan and not transport.used,'artificial_single_use_only')
    need(plan.live_enabled is False and not plan.output_root.exists()
         and tuple(s.id for s in plan.steps)==STEPS
         and tuple(s.sha256 for s in plan.steps)==SOURCE_DIGESTS
         and all(digest(s.body)==s.sha256 and templates(s.body,plan.versions)==s.outputs for s in plan.steps),
         'offline_admission')
    transport.used=True
    origin=transport.tick
    dispositions={key:'not_executed' for key,_ in plan.checks}
    loads=0
    errors=[]
    canceled=True
    for step in plan.steps:
        deadline=min(transport.tick+PER_STEP,origin+WORK)
        try:
            need(transport.tick<deadline,'work_deadline')
            started=transport.tick
            result=transport.select(step,deadline)
            need(type(transport.tick) is int and started<=transport.tick<deadline,'step_deadline')
            need(set(result)=={'scope','step','sha256','ok','simulated_loads','outputs','log'}
                 and result['scope']=='ARTIFICIAL_ONLY' and result['step']==step.id
                 and result['sha256']==step.sha256 and result['ok'] is True
                 and type(result['simulated_loads']) is int and result['simulated_loads']==int(step.id=='P1')
                 and result['log']==LOG_PREFIX+step.id,'receipt_contract')
            loads+=result['simulated_loads']
            check_outputs(step,result['outputs'],plan.versions)
        except (ValueError,TypeError,KeyError,csv.Error) as error:
            errors.append(str(error))
            for key,stage in plan.checks:
                if stage==step.id:
                    dispositions[key]='technical_stop'
            canceled=transport.cancel() is True
            break
        for key,stage in plan.checks:
            if stage==step.id:
                dispositions[key]='artificial_complete'
    started=transport.tick
    deadline=min(started+CLEANUP,origin+TOTAL)
    cleaned=transport.cleanup(deadline) is True and started<=transport.tick<deadline
    status='QUARANTINED' if not (cleaned and canceled) else 'TECHNICAL_STOP' if errors else 'ARTIFICIAL_PASS'
    return dict(status=status,check_dispositions=dispositions,simulated_loads=loads,actual_loads=0,
                actual_stata_calls=0,cleanup_verified=cleaned,artificial_cancel_verified=canceled,
                errors=errors,retries=0,live_ready=False)
