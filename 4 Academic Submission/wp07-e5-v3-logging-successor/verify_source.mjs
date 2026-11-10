// Offline boundary and artificial-fixture audit only; native Stata tests remain unrun.
import fs from 'node:fs/promises';
import path from 'node:path';
import assert from 'node:assert/strict';
import crypto from 'node:crypto';
import { parseCsv, auditRows, auditTex } from '../wp07-e5-presentation-successor/audit_presentation.mjs';
const root = process.cwd();
const folder = '4 Academic Submission/wp07-e5-v3-logging-successor';
const read = p => fs.readFile(path.join(root, p), 'utf8');
const producerPath = '1 Code/academic/3 E4 exhibits v3.do';
assert(await fs.stat(path.join(root, producerPath)).then(() => true, () => false), 'Six-slot native Stata producer not implemented');
const producer = await read(producerPath);
assert.equal(producer.split(/\r?\n/)[6], 'exit 198');
assert(producer.includes('* BEGIN E5 PRODUCER') && producer.includes('* END E5 PRODUCER'));
assert(!producer.includes('\\\\'), 'Unsafe doubled backslash in Stata LaTeX string');
assert(producer.includes('%25.16e'), '17-significant-digit audit formatting not implemented');
const commands = producer.split(/\r?\n/).filter(x => x.trim() && !x.trimStart().startsWith('*')).join('\n');
assert(!/^\s*(?:logit|logistic|regress|gsem|sem|margins|predict|test|lincom|use|save|shell|python|rsource|ssc|net|program)\b/im.test(commands), 'Forbidden estimator, model/participant operation or helper');
assert(!/estimates\s+(?:use|restore|store)/im.test(commands), 'Stored model operation');
const logicalCommands = commands.replace(/\/\/\/\r?\n/g, ' ');
assert(!/^\s*(?:export delimited|file open|graph export).*\breplace\b/im.test(logicalCommands), 'Overwriting export');
const contract = JSON.parse(await read(folder + '/VALIDATION_CONTRACT.json'));
const fingerprint = async p => { const bytes=await fs.readFile(path.join(root,p));return{path:p,bytes:bytes.length,sha256:crypto.createHash('sha256').update(bytes).digest('hex')}; };
for(const pin of [contract.producer,contract.caller,...contract.fixture_pins,...contract.staged_bodies]) assert.deepEqual(await fingerprint(pin.path),pin,'Stale source/fixture binding');
assert.deepEqual(await fingerprint(contract.native_output_auditor_pin.path),contract.native_output_auditor_pin);
const extract=(text,markers)=>text.slice(text.indexOf(markers[0])+markers[0].length,text.indexOf(markers[1])).replace(/^\r?\n/,'');
assert.equal(await read(contract.staged_bodies[0].path),extract(producer,contract.producer_markers));
assert.equal(await read(contract.staged_bodies[1].path),extract(await read(contract.caller.path),contract.caller_markers));
assert.equal(contract.execution_authorized, false);
assert.equal(contract.fits, 0);
assert.equal(contract.participant_or_model_loads, 0);
assert.equal(contract.C2, 'HOLD');
assert.equal(contract.current_execution_authority,0);
assert.equal(contract.retries,0);
assert.equal(contract.timeout_seconds_per_selection,60);
assert.deepEqual(await fingerprint(contract.pdf_layout_auditor_pin.path),contract.pdf_layout_auditor_pin);
assert.deepEqual(await fingerprint(contract.auditor_metadata_dependency.path),contract.auditor_metadata_dependency);
assert.deepEqual(await fingerprint(contract.case_definition_pin.path),contract.case_definition_pin);
assert.deepEqual(await fingerprint(contract.source_preflight_pin.path),contract.source_preflight_pin);
assert.equal(contract.output_files.length, 17);
assert.equal(new Set(contract.output_files).size, 17);
for (const name of contract.output_files) assert(producer.includes(name), 'Missing declared output ' + name);
assert.deepEqual(await fingerprint(contract.native_numeric_auditor_pin.path),contract.native_numeric_auditor_pin);
const source = {};
for (const name of contract.inputs) source[name] = parseCsv(await read(contract.fixture_directory+'/'+name));
assert.deepEqual(contract.inputs.map(name=>source[name].length),[5,45,6,2262,186]);
assert.deepEqual(source['e4_model_status.csv'].map(x=>Number(x.estimator_n)),[120,108,108,96,108]);
assert.equal(source['e4_probabilities.csv'][2].ll,'-.004');
assert(source['e4_probabilities.csv'].some(x=>x.ll==='-.02'));
assert(source['e4_probabilities.csv'].some(x=>x.ul==='1.02'));
const fakeCov=source['e4_native_matrices.csv'].filter(x=>x.matrix==='e4_V'&&x.operation==='fit');
assert.equal(fakeCov.length,1154);
assert.equal(Number(fakeCov.find(x=>x.model==='R0_E4'&&x.row==='1'&&x.column==='2').value),1.2345678901234567e-5);
const modelRows=source['e4_model_status.csv'].map((x,i)=>({...x,role:i===4?'Common-observation core':i>1?'Extension':'Core'}));
auditRows('QT1_models.csv',modelRows,source);
const wrongN=structuredClone(modelRows);wrongN[0].estimator_n='423';
assert.throws(()=>auditRows('QT1_models.csv',wrongN,source));
const coreRows=source['e4_probabilities.csv'].filter(x=>['R0_E4','D0_E4'].includes(x.model)&&x.record==='higher_minus_lower').map(x=>({...x,estimator_n:x.model==='R0_E4'?'120':'108',zero_relation:Number(x.ll)>0?'Above zero':Number(x.ul)<0?'Below zero':'Includes zero'}));
auditRows('QF1_core.csv',coreRows,source);
const primaryRows=source['e4_primary_tests.csv'].toSorted((a,b)=>['R0_E4','D0_E4'].indexOf(a.model)-['R0_E4','D0_E4'].indexOf(b.model)||['wp07_iat3','wp07_iadt2','wp07_iaff2'].indexOf(a.field)-['wp07_iat3','wp07_iadt2','wp07_iaff2'].indexOf(b.field)).map(x=>({...x,estimator_n:x.model==='R0_E4'?'120':'108'}));
auditRows('QT2_primary.csv',primaryRows,source);
const wrongHolm=structuredClone(primaryRows);wrongHolm[0].p_holm='0';
assert.throws(()=>auditRows('QT2_primary.csv',wrongHolm,source));
const clipped=structuredClone(coreRows);clipped[0].ll='0';
assert.throws(()=>auditRows('QF1_core.csv',clipped,source));
const wrongZero=structuredClone(coreRows);wrongZero[0].zero_relation='Above zero';
assert.throws(()=>auditRows('QF1_core.csv',wrongZero,source));
const missing=structuredClone(coreRows);missing.pop();
assert.throws(()=>auditRows('QF1_core.csv',missing,source));
const fakeTex='R0 & A & Core & Accepted working &120 &120 \\tabularnewline\nD0 & B & Core & Accepted working &108 &108 \\tabularnewline\nR1 & A & Extension & Accepted working &108 &108 \\tabularnewline\nD1 & B & Extension & Accepted working &96 &96 \\tabularnewline\nR0C & A & Common-observation core & Accepted working &108 &108 \\tabularnewline';
auditTex('QT1_models.tex',fakeTex,source);
assert.throws(()=>auditTex('QT1_models.tex',fakeTex.replace('\\tabularnewline','\\'),source));
assert.throws(()=>auditTex('QT1_models.tex',fakeTex.replace('&120 &120','&120 &423'),source));
const cases=JSON.parse(await read(contract.cases));
assert.equal(cases.cases.length,12);
assert.equal(cases.native_status,'NOT_RUN');
assert.equal(contract.prepared_requests.length,12);
assert.deepEqual(contract.prepared_requests.map(r=>[r.id,r.case,r.expected_inner_producer_rc]),cases.cases.map(r=>[r.id,r.case,r.expected_rc]));
const priorContract=JSON.parse(await read('4 Academic Submission/wp07-e5-v3-native-validation-preparation/VALIDATION_CONTRACT.json'));
const entry=JSON.parse(await read(folder+'/INPUTS.json'));
for (const pin of [entry.predecessor_contract, entry.hold_receipt, contract.receipt_auditor, contract.receipt_tests]) {
  assert.deepEqual(await fingerprint(pin.path), pin);
}
assert.deepEqual(contract.staged_bodies, priorContract.staged_bodies, 'Preserved exact bodies');
for (const key of ['producer','caller','fixture_pins','cases','inputs','output_files','output_rows','native_numeric_auditor_pin','native_output_auditor_pin','pdf_layout_auditor_pin']) {
  assert.deepEqual(contract[key], priorContract[key], 'Changed science/output binding: ' + key);
}
const unused = async p => {
  await assert.rejects(fs.lstat(path.join(root,p)), { code: 'ENOENT' });
};
assert.deepEqual(contract.future_native_table_wrappers.map(w=>w.case), ['AT01','AT02']);
for (const w of contract.future_native_table_wrappers) {
  const old = priorContract.future_native_table_wrappers.find(x=>x.case===w.case);
  assert.equal(w.path, entry.preservation_beforeimages+'/latex-audit/'+w.case+'/tables.tex');
  assert.equal(w.future_pdf, w.path.replace(/tex$/,'pdf'));
  assert.equal(w.future_log, w.path.replace(/tex$/,'log'));
  const oldOut = priorContract.prepared_requests.find(r=>r.id===w.case).output_dir;
  const newOut = contract.prepared_requests.find(r=>r.id===w.case).output_dir;
  assert.equal(await read(w.path),(await read(old.path)).replaceAll(oldOut,newOut));
  assert.deepEqual(await fingerprint(w.path),w.pin);
  assert.deepEqual(await fs.readdir(path.dirname(path.join(root,w.path))),['tables.tex']);
  await unused(w.future_pdf); await unused(w.future_log);
}
const dirs = new Set();
for (const request of contract.prepared_requests) {
  const oldRequest = priorContract.prepared_requests.find(r=>r.id===request.id);
  const oldCase = oldRequest.path.slice(0,-'/selection.do'.length);
  const newCase = entry.preservation_beforeimages+'/trial/'+request.id;
  for(const key of ['path','input_dir','output_dir','log']) {
    assert.equal(request[key],oldRequest[key].replace(oldCase,newCase),'Fresh '+key+' binding');
  }
  const oldText = await read(oldRequest.path);
  const selection = await read(request.path);
  assert.equal(oldText.split('\ncapture quietly do ').length,2);
  assert.equal(selection,oldText.replaceAll(oldCase,newCase).replace('\ncapture quietly do ','\ncapture noisily do '),'Only fresh case paths and outer logging word may change');
  assert.equal(selection.split('\ncapture noisily do ').length,2);
  assert(!selection.includes('capture quietly do'));
  assert.equal(request.mcp_request.path,newCase+'/mcp_request.json');
  assert.deepEqual(await fingerprint(request.mcp_request.path),request.mcp_request);
  const payload = JSON.parse(await read(request.mcp_request.path));
  assert.deepEqual(payload,{selection,session_id:'cfi_e5_v3_log_65309c5',timeout:60,working_dir:root.split(path.sep).join('/')},'Exact MCP envelope');
  assert.equal(request.session_id,payload.session_id);
  assert.equal(request.expected_inner_producer_rc,oldRequest.expected_inner_producer_rc);
  assert.equal(request.expected_outer_selection_rc,0);
  const actual = await fingerprint(request.path);
  assert.equal(actual.bytes,request.bytes);assert.equal(actual.sha256,request.sha256);
  assert.equal(request.timeout,60);assert.equal(request.status,'PREPARED_NOT_AUTHORIZED_NOT_DISPATCHED');
  for(const relative of [request.input_dir,request.output_dir]) {
    const absolute=path.resolve(root,relative);
    const real=await fs.realpath(absolute);
    assert.equal(real.toLowerCase(),absolute.toLowerCase(),'Aliased case path');
    assert(!dirs.has(real.toLowerCase()),'Repeated case path');
    dirs.add(real.toLowerCase());
    assert.deepEqual(await fs.readdir(absolute),[],'Case directory is not empty');
  }
  await unused(request.log);
}
assert.equal(dirs.size,24);
assert.deepEqual(await fingerprint(entry.entry_snapshot.path),entry.entry_snapshot);
const closure=new Map(JSON.parse(await read(entry.entry_snapshot.path)).map(pin=>[pin.path,pin]));
assert.equal(closure.size,entry.entry_fingerprints_checked);
for(const pin of closure.values()){const target=entry.planned_mutable_files.includes(pin.path)?entry.preservation_beforeimages+'/'+path.basename(pin.path):pin.path;const actual=await fingerprint(target);assert.equal(actual.bytes,pin.bytes,pin.path);assert.equal(actual.sha256,pin.sha256,pin.path);}
const pointer=JSON.parse(await read('4 Academic Submission/00_meta/current_workplan.json'));
assert.equal(pointer.latest_source_handoff,folder+'/README.md');
assert.equal(pointer.appendix_c2,'HOLD');assert.equal(pointer.fits_newly_authorized,0);
assert.equal(pointer.participant_loads_newly_authorized,false);assert.equal(pointer.release_authorized,false);
assert.equal(pointer.artificial_native_tests_authorized,false);
assert.equal(pointer.e5_current_authorized_selections_remaining,0);
const priorRows=(await read('4 Academic Submission/wp07-e5-v3-preflight-hold/TASK_REGISTER.csv')).trimEnd().split(/\r?\n/);
const nextRows=(await read(folder+'/TASK_REGISTER.csv')).trimEnd().split(/\r?\n/);
assert.equal(nextRows.length,42);
assert.deepEqual(priorRows.filter((row,i)=>row!==nextRows[i]).map(row=>row.split(',')[0]),['"E.5"']);
assert.deepEqual(await fingerprint(contract.execution_checklist.path),contract.execution_checklist);
console.log(JSON.stringify({ result: 'PASS_LOGGING_ONLY_SOURCE_AND_UNUSED_PATHS_NOT_NATIVE_VALIDATION', outputs:17, cases_prepared:12, auditor_negative_controls:7, predecessor_pins:closure.size,source_and_fixture_pins:9,exact_staged_bodies:2,native_calls:0,fits:0,participant_or_model_loads:0 }));
