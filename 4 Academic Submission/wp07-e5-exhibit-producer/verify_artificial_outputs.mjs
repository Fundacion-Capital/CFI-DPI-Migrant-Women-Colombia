// Audit future native artificial outputs; never generate tables or estimates here.
import fs from 'node:fs/promises';
import path from 'node:path';
import assert from 'node:assert/strict';
import { pathToFileURL } from 'node:url';
const root = process.cwd();
const folder = '4 Academic Submission/wp07-e5-exhibit-producer';
// Fixed fixture/report fields contain no embedded commas or newlines; reject any wider shape.
export function parseCsv(text) {
  const lines = text.trimEnd().split(/\r?\n/);
  const fields = line => line.split(',').map(x => x.startsWith('"') && x.endsWith('"') ? x.slice(1, -1).replaceAll('""', '"') : x.trim());
  const header = fields(lines.shift());
  return lines.map(line => {
    const values = fields(line);
    assert.equal(values.length, header.length, 'Unexpected CSV width');
    return Object.fromEntries(header.map((k, i) => [k, values[i]]));
  });
}
const number = x => x === '' || /^\.[a-z]?$/.test(x) ? null : Number(x);
function equalCell(actual, expected, message) {
  if (expected === '' || /^\.[a-z]?$/.test(expected)) assert.equal(number(actual), null, message);
  else if (Number.isFinite(Number(expected))) assert.equal(number(actual), Number(expected), message);
  else assert.equal(actual, expected, message);
}
export function auditRows(name, rows, sources) {
  const models = ['R0_E4', 'D0_E4', 'R1_E4', 'D1_E4', 'R0C_E4'];
  const focals = ['wp07_iat3', 'wp07_iadt2', 'wp07_iaff2'];
  const modelN = { R0_E4:120, D0_E4:108, R1_E4:108, D1_E4:96, R0C_E4:108 };
  const probabilities = sources['e4_probabilities.csv'];
  const counts = { 'QT1_models.csv':5, 'QF1_core.csv':6, 'QT2_primary.csv':6, 'QS1_comparisons.csv':15, 'QS2_endpoints.csv':30, 'QS3_coefficients.csv':74, 'QS3_covariance.csv':1154, 'QS3_support.csv':186, 'e5_complete.csv':6 };
  assert.equal(rows.length, counts[name], name + ' complete rows');
  const keys = rows.map(r => name === 'e5_complete.csv' ? r.slot : [r.model, r.focal || r.field || '', r.record || r.column || '', r.row || '', r.check || '', r.level || '', r.outcome || ''].join('|'));
  assert.equal(new Set(keys).size, rows.length, name + ' unique keys');
  if (name === 'QT1_models.csv') {
    assert.deepEqual(rows.map(r => r.model), models);
    for (const r of rows) {
      assert.equal(Number(r.intended_n), modelN[r.model]);
      assert.equal(Number(r.estimator_n), modelN[r.model]);
      assert.equal(r.status, 'ACCEPTED_WORKING_MODEL');
    }
    assert.equal(rows[4].role, 'Common-observation core');
  }
  if (['QF1_core.csv', 'QS1_comparisons.csv', 'QS2_endpoints.csv'].includes(name)) {
    const selected = probabilities.filter(r => name === 'QS2_endpoints.csv' ? r.record !== 'higher_minus_lower' : r.record === 'higher_minus_lower' && (name !== 'QF1_core.csv' || ['R0_E4','D0_E4'].includes(r.model)));
    selected.sort((a,b) => models.indexOf(a.model)-models.indexOf(b.model) || focals.indexOf(a.focal)-focals.indexOf(b.focal) || ['lower','higher'].indexOf(a.record)-['lower','higher'].indexOf(b.record));
    rows.forEach((r,i) => {
      const expected = selected[i];
      for (const field of ['model','focal','estimate','se','ll','ul']) equalCell(r[field], expected[field], name + ':' + field);
      assert.equal(Number(r.estimator_n), modelN[r.model]);
      if (name === 'QS2_endpoints.csv') for (const field of ['record','endpoint','units']) equalCell(r[field], expected[field], name + ':' + field);
      else assert.equal(r.zero_relation, Number(expected.ll) > 0 ? 'Above zero' : Number(expected.ul) < 0 ? 'Below zero' : 'Includes zero');
    });
  }
  if (name === 'QT2_primary.csv') {
    const expected = sources['e4_primary_tests.csv'].toSorted((a,b) => models.indexOf(a.model)-models.indexOf(b.model) || focals.indexOf(a.field)-focals.indexOf(b.field));
    rows.forEach((r,i) => {
      for (const field of ['slot','model','field','p_raw','p_holm','status']) equalCell(r[field], expected[i][field], name + ':' + field);
      assert.equal(Number(r.estimator_n), modelN[r.model]);
    });
  }
  if (name === 'QS3_coefficients.csv') {
    const b = sources['e4_native_matrices.csv'].filter(r => r.operation === 'fit' && r.matrix === 'e4_B').toSorted((a,b) => models.indexOf(a.model)-models.indexOf(b.model) || Number(a.column)-Number(b.column));
    rows.forEach((r,i) => {
      const expected = b[i];
      for (const field of ['model','column','column_name']) equalCell(r[field], expected[field], name + ':' + field);
      equalCell(r.coefficient, expected.value, 'Native coefficient');
      assert.equal(Number(r.estimator_n), modelN[r.model]);
      const reference = /\d+b\./.test(expected.column_name);
      assert.equal(Number(r.reference), reference ? 1 : 0);
      equalCell(r.variance, reference ? '0' : '.04', 'Artificial covariance diagonal');
      if (reference) for (const field of ['se','ll','ul']) assert.equal(number(r[field]), null, 'Reference has no estimated interval');
      else {
        assert.equal(Number(r.se), .2);
        // Hand-checked artificial half-width, not a newly computed study interval.
        assert(Math.abs(Number(r.ll) - (Number(expected.value) - .3919927969080108)) < 1e-12);
        assert(Math.abs(Number(r.ul) - (Number(expected.value) + .3919927969080108)) < 1e-12);
      }
    });
    assert.equal(rows.filter(r => Number(r.reference) === 1).length, 12);
  }
  if (name === 'QS3_covariance.csv') {
    const expected = sources['e4_native_matrices.csv'].filter(r => r.operation === 'fit' && r.matrix === 'e4_V').toSorted((a,b) => models.indexOf(a.model)-models.indexOf(b.model) || Number(a.row)-Number(b.row) || Number(a.column)-Number(b.column));
    rows.forEach((r,i) => { for (const field of ['model','row','column','row_name','column_name','value']) equalCell(r[field], expected[i][field], name + ':' + field); });
    assert.equal(Number(rows.find(r => r.model === 'R0_E4' && Number(r.row) === 1 && Number(r.column) === 2).value), 1.2345678901234567e-5);
  }
  if (name === 'QS3_support.csv') {
    const key = r => [r.model,r.check,r.field,number(r.level),number(r.outcome)].join('|');
    const expected = new Map(sources['e4_support.csv'].map(r => [key(r),r]));
    for (const r of rows) for (const field of ['model','check','field','level','outcome','n','minimum','maximum']) equalCell(r[field], expected.get(key(r))?.[field] ?? 'ABSENT', name + ':' + field);
  }
  if (name === 'e5_complete.csv') {
    assert.deepEqual(rows.map(r => [r.slot,Number(r.rows),r.status]), [['QT1',5,'COMPLETE'],['QF1',6,'COMPLETE'],['QT2',6,'COMPLETE'],['QS1',15,'COMPLETE'],['QS2',30,'COMPLETE'],['QS3',74,'COMPLETE']]);
  }
}
export function auditTex(name, text, sources) {
  const modelOrder = ['R0_E4','D0_E4','R1_E4','D1_E4','R0C_E4'];
  const focalOrder = ['wp07_iat3','wp07_iadt2','wp07_iaff2'];
  const lines = text.split(/\r?\n/).filter(line => /^(R0C?|D0|R1|D1) & /.test(line));
  const counts = { 'QT1_models.tex':5,'QT2_primary.tex':6,'QS1_comparisons.tex':15,'QS2_endpoints.tex':30,'QS3_coefficients.tex':74 };
  assert.equal(lines.length,counts[name],name+' actual data rows');
  assert(lines.every(line=>line.endsWith('\\tabularnewline')),name+' intact data row commands');
  const cells = lines.map(line=>line.replace(/\s*\\tabularnewline$/,'').split('&').map(x=>x.trim()));
  const displayNumber = (actual, expected, digits) => assert(Number(actual) === Number(Number(expected).toFixed(digits)),name+' displayed cell');
  if (name === 'QT1_models.tex') cells.forEach((r,i)=>{
    assert.equal(r[0],modelOrder[i].replace('_E4',''));
    assert.equal(Number(r[4]),[120,108,108,96,108][i]);
    assert.equal(Number(r[5]),[120,108,108,96,108][i]);
  });
  if (name === 'QT2_primary.tex') {
    const expected=sources['e4_primary_tests.csv'].toSorted((a,b)=>modelOrder.indexOf(a.model)-modelOrder.indexOf(b.model)||focalOrder.indexOf(a.field)-focalOrder.indexOf(b.field));
    cells.forEach((r,i)=>{
      assert.equal(r[0],expected[i].model.replace('_E4',''));
      assert.equal(r[3],Number(expected[i].p_raw)<.001?'$<.001$':Number(expected[i].p_raw).toFixed(3));
      assert.equal(r[4],Number(expected[i].p_holm)<.001?'$<.001$':Number(expected[i].p_holm).toFixed(3));
    });
  }
  if (['QS1_comparisons.tex','QS2_endpoints.tex'].includes(name)) {
    const differences=name==='QS1_comparisons.tex';
    const expected=sources['e4_probabilities.csv'].filter(r=>differences?r.record==='higher_minus_lower':r.record!=='higher_minus_lower').toSorted((a,b)=>modelOrder.indexOf(a.model)-modelOrder.indexOf(b.model)||focalOrder.indexOf(a.focal)-focalOrder.indexOf(b.focal)||['lower','higher'].indexOf(a.record)-['lower','higher'].indexOf(b.record));
    cells.forEach((r,i)=>{
      const e=expected[i], digits=differences?2:3;
      assert.equal(r[0],e.model.replace('_E4',''));
      displayNumber(r[differences?3:4],e.estimate,digits);
      displayNumber(r[differences?4:5],e.se,digits);
      const bounds=r[differences?5:6].replace(/[\[\]]/g,'').split(',');
      displayNumber(bounds[0],e.ll,digits);displayNumber(bounds[1],e.ul,digits);
      if (differences) assert.equal(r[6],Number(e.ll)>0?'Above zero':Number(e.ul)<0?'Below zero':'Includes zero');
      else displayNumber(r[2],e.endpoint,2);
    });
  }
  if(name==='QS3_coefficients.tex') {
    const expected=sources['e4_native_matrices.csv'].filter(r=>r.operation==='fit'&&r.matrix==='e4_B').toSorted((a,b)=>modelOrder.indexOf(a.model)-modelOrder.indexOf(b.model)||Number(a.column)-Number(b.column));
    cells.forEach((r,i)=>{
      const e=expected[i];assert.equal(r[0],e.model.replace('_E4',''));
      if(/\d+b\./.test(e.column_name))assert.deepEqual(r.slice(3),['Reference','--','--']);
      else {displayNumber(r[3],e.value,3);displayNumber(r[4],.2,3);const bounds=r[5].replace(/[\[\]]/g,'').split(',');displayNumber(bounds[0],Number(e.value)-.3919927969080108,3);displayNumber(bounds[1],Number(e.value)+.3919927969080108,3);}
    });
  }
}
export async function auditDirectory(directory) {
  const contract = JSON.parse(await fs.readFile(path.join(root,folder,'VALIDATION_CONTRACT.json'),'utf8'));
  const sources = {};
  for (const name of contract.inputs) sources[name] = parseCsv(await fs.readFile(path.join(root,folder,'fixtures',name),'utf8'));
  for (const name of contract.output_files) {
    const bytes = await fs.readFile(path.join(directory,name));
    assert(bytes.length > 0, name + ' empty');
    if (name.endsWith('.csv')) auditRows(name,parseCsv(bytes.toString('utf8')),sources);
    if (name.endsWith('.pdf')) assert(bytes.subarray(0,5).equals(Buffer.from('%PDF-')));
    if (name.endsWith('.png')) assert.equal(bytes.subarray(0,8).toString('hex'),'89504e470d0a1a0a');
    if (name.endsWith('.tex')) {
      const text = bytes.toString('utf8');
      assert(text.includes('\\tabularnewline'), name + ' lost row terminators');
      assert(!/^.*\\\s*$/m.test(text), name + ' lone backslash row ending');
      auditTex(name,text,sources);
      if (name === 'QT1_models.tex') for (const word of ['IAT','IADT','IAFF','Remittance','Domestic','Common-observation core']) assert(text.includes(word));
      if (name === 'QT2_primary.tex') assert(text.includes('$<.001$'));
      if (name === 'QS1_comparisons.tex') { assert(text.includes('precise lower bound')); const precise=text.match(/precise lower bound\s+([^\s]+) percentage points/); assert(precise && Number(precise[1])===-.004, 'Precise near-zero lower bound omitted'); }
      if (name === 'QS3_coefficients.tex') assert.equal((text.match(/Reference & -- & --/g)||[]).length,12);
    }
  }
  return { result:'PASS_NATIVE_ARTIFICIAL_OUTPUTS_ONLY',files:17,visual_layout_checked:false };
}
if (process.argv[1] && import.meta.url === pathToFileURL(path.resolve(process.argv[1])).href) {
  assert(process.argv[2], 'Supply one future native artificial output directory; no native output exists yet');
  const first=path.resolve(process.argv[2]);
  const results=[await auditDirectory(first)];
  if(process.argv[3]) {
    const second=path.resolve(process.argv[3]);results.push(await auditDirectory(second));
    const contract=JSON.parse(await fs.readFile(path.join(root,folder,'VALIDATION_CONTRACT.json'),'utf8'));
    for(const name of contract.output_files.filter(x=>x.endsWith('.csv')||x.endsWith('.tex'))) {
      const a=(await fs.readFile(path.join(first,name),'utf8')).replaceAll('\r\n','\n');
      const b=(await fs.readFile(path.join(second,name),'utf8')).replaceAll('\r\n','\n');
      assert.equal(a,b,'AT01/AT02 order invariance: '+name);
    }
  }
  console.log(JSON.stringify({results,order_invariance_checked:results.length===2}));
}
