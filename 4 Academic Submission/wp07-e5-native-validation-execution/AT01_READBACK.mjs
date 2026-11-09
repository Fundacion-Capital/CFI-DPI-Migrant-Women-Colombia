// Read-only audit of already-generated artificial files; no Stata invocation.
import fs from 'node:fs/promises';
import path from 'node:path';
import crypto from 'node:crypto';
import {parseCsv,auditRows,auditTex} from '../wp07-e5-exhibit-producer/verify_artificial_outputs.mjs';
const root=process.cwd();
const source='4 Academic Submission/wp07-e5-exhibit-producer';
const contract=JSON.parse(await fs.readFile(path.join(root,source,'VALIDATION_CONTRACT.json'),'utf8'));
const request=contract.prepared_requests[0];
const sources={};
for(const name of contract.inputs) sources[name]=parseCsv(await fs.readFile(path.join(root,source,'fixtures',name),'utf8'));
const files=[];
for(const name of contract.output_files){
  const bytes=await fs.readFile(path.join(root,request.output_dir,name));
  const row={file:name,bytes:bytes.length,sha256:crypto.createHash('sha256').update(bytes).digest('hex')};
  try{
    if(name.endsWith('.csv'))auditRows(name,parseCsv(bytes.toString('utf8')),sources);
    if(name.endsWith('.tex'))auditTex(name,bytes.toString('utf8'),sources);
    if(name.endsWith('.pdf')&&bytes.subarray(0,5).toString()!=='%PDF-')throw Error('PDF signature');
    if(name.endsWith('.png')&&bytes.subarray(0,8).toString('hex')!=='89504e470d0a1a0a')throw Error('PNG signature');
    row.status='PASS_FILE_CHECKS_NOT_VISUAL_APPROVAL';
  }catch(error){row.status='FAIL';row.error=String(error);row.stack=error.stack;}
  files.push(row);
}
const actualModels=parseCsv(await fs.readFile(path.join(root,request.output_dir,'QT1_models.csv'),'utf8'));
const keyChecks=actualModels.map(r=>{const expected=sources['e4_model_status.csv'].find(s=>s.model===r.model);return{model:r.model,intended_n_exact:Number(r.intended_n)===Number(expected.intended_n),estimator_n_exact:Number(r.estimator_n)===Number(expected.estimator_n),status_exact:r.status===expected.status};});
const inputCopies=[];
for(const name of contract.inputs){const a=await fs.readFile(path.join(root,source,'fixtures',name)),b=await fs.readFile(path.join(root,request.input_dir,name));inputCopies.push({file:name,exact:a.equals(b)});}
console.log(JSON.stringify({files,QT1_keyed_values:keyChecks,QT1_actual_order:actualModels.map(r=>r.model),inputCopies,Stata_calls_by_this_script:0,source_or_output_mutations:0},null,2));
