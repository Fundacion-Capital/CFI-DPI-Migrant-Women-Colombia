// Offline checks of saved artificial artifacts; never launch Stata or read a model.
import fs from 'node:fs/promises';
import path from 'node:path';
import crypto from 'node:crypto';
import assert from 'node:assert/strict';
import { fileURLToPath } from 'node:url';
import { auditDirectory } from '../wp07-e5-presentation-successor/audit_presentation.mjs';

const here = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(here, '../..');
const binding = JSON.parse(await fs.readFile(path.join(here, 'INPUTS.json'), 'utf8'));
const read = p => fs.readFile(path.join(root, p), 'utf8');
const hash = b => crypto.createHash('sha256').update(b).digest('hex');
for (const pin of binding.pins) {
  const b = await fs.readFile(path.join(root, pin.path));
  assert.equal(b.length, pin.bytes, pin.path + ' size');
  assert.equal(hash(b), pin.sha256, pin.path + ' SHA-256');
}

const original = await read(binding.original_outputs + '/QS2_endpoints.tex');
const lastFoot = original.split('\n').find(l => l.endsWith('\\endlastfoot'));
assert(lastFoot, 'Original final footer');
const note = lastFoot.match(/\{\\footnotesize (.*?)\}\\tabularnewline/)[1];
const reserved = String.raw`\hline\multicolumn{7}{p{.94\linewidth}}{\phantom{\parbox[t]{\linewidth}{\footnotesize ` + note +
  String.raw`{\small\strut}}}}\tabularnewline\noalign{\kern0pt}\endfoot`;
const printed = lastFoot.replace('\\endlastfoot', '\\noalign{\\kern0pt}\\endlastfoot');
const repaired = await read(binding.diagnostic_outputs + '/QS2_endpoints.tex');
assert.equal(repaired, original.replace('\\hline\\endfoot', reserved).replace(lastFoot, printed), 'Exactly two footer replacements');

const oldSource = (await read(binding.original_producer)).replaceAll('\r\n', '\n');
const newSource = (await read(binding.held_successor)).replaceAll('\r\n', '\n');
assert.equal(newSource.split('\n')[6], 'exit 198', 'Entry hold stays on line seven');
const reversedSource = newSource.replace('* E.5 v3:', '* E.5 v2:')
  .replace('* QS2 layout repair: saved-artifact rendering checked; native generation untested.', '* Presentation successor only: native parsing and rendering remain untested.')
  .replace('    * Reserve the full notes height so longtable, not the outer page builder, breaks QS2.\n', '')
  .replace(reserved, '\\hline\\endfoot').replace(printed, lastFoot);
assert.equal(reversedSource, oldSource, 'No other scientific, CSV, row-writer or cleanup changes');

const files = (await fs.readdir(path.join(root, binding.original_outputs))).sort();
assert.equal(files.length, 17);
assert.deepEqual((await fs.readdir(path.join(root, binding.diagnostic_outputs))).sort(), files);
let tableRows = 0;
for (const file of files) {
  const a = await fs.readFile(path.join(root, binding.original_outputs, file));
  const b = await fs.readFile(path.join(root, binding.diagnostic_outputs, file));
  if (file !== 'QS2_endpoints.tex') assert(a.equals(b), file + ' exact saved bytes');
  if (file.endsWith('.tex')) {
    const rows = text => text.split('\n').filter(l => /^(R0C?|D0|R1|D1)\s*&/.test(l));
    assert.deepEqual(rows(a.toString()), rows(b.toString()), file + ' all row text/numbers/order');
    tableRows += rows(b.toString()).length;
  }
}
assert.equal(tableRows, 130);
const numericAndStructure = await auditDirectory(path.join(root, binding.diagnostic_outputs));
console.log(JSON.stringify({ result: 'PASS_SOURCE_EXACT_SAVED_ARTIFACT_CHECKS_ONLY', unchanged_files: 16,
  QS2_footer_replacements: 2, unchanged_table_rows: tableRows, numericAndStructure,
  Stata_calls: 0, native_generation_checked: false }));
