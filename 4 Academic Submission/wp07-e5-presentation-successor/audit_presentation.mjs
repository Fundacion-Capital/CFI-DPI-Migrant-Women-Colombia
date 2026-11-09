// Read artificial output files only; never launch Stata or generate estimates.
import fs from 'node:fs/promises';
import path from 'node:path';
import assert from 'node:assert/strict';
import { pathToFileURL } from 'node:url';
import { auditDirectory as auditNumericDirectory } from '../wp07-e5-exhibit-producer/verify_artificial_outputs.mjs';
export { parseCsv, auditRows, auditTex } from '../wp07-e5-exhibit-producer/verify_artificial_outputs.mjs';

export function auditLongtable(text, label, columns) {
  for (const command of ['\\endfirsthead', '\\endhead', '\\endfoot', '\\endlastfoot']) {
    assert.equal(text.split(command).length - 1, 1, label + ': one ' + command);
  }
  assert.equal(text.split('\\caption{').length - 1, 1, label + ': one caption');
  assert.equal(text.split('\\label{' + label + '}').length - 1, 1, label + ': one label');
  const first = text.indexOf('\\endfirsthead');
  const head = text.indexOf('\\endhead');
  const foot = text.indexOf('\\endfoot');
  const last = text.indexOf('\\endlastfoot');
  assert(text.indexOf('\\label{' + label + '}') < first, label + ': label belongs to first head');
  assert(first < head && head < foot && foot < last, label + ': header/footer order');
  const repeated = text.slice(first, head);
  assert(repeated.includes('Model & '), label + ': repeated column headings');
  assert(!repeated.includes('\\caption') && !repeated.includes('\\label'), label + ': no repeated caption/label');
  const notes = text.slice(foot, last);
  assert(notes.includes('\\multicolumn{' + columns + '}'), label + ': notes span the table');
  assert(notes.includes('\\footnotesize'), label + ': notes inside last footer');
  const tableEnd = text.indexOf('\\end{longtable}');
  assert(tableEnd > last, label + ': table ends after its last footer');
  assert(!text.slice(tableEnd).includes('\\footnotesize'), label + ': no detached notes');
}

export async function auditDirectory(directory) {
  const result = await auditNumericDirectory(directory);
  for (const [file, label, columns] of [
    ['QS1_comparisons.tex', 'tab:qs1-comparisons', 7],
    ['QS2_endpoints.tex', 'tab:qs2-endpoints', 7],
    ['QS3_coefficients.tex', 'tab:qs3-coefficients', 6]
  ]) auditLongtable(await fs.readFile(path.join(directory, file), 'utf8'), label, columns);
  return { ...result, result: 'PASS_ARTIFICIAL_FILE_AND_LONGTABLE_STRUCTURE_CHECKS', visual_layout_checked: false };
}

function selfTest() {
  const valid = String.raw`\begin{longtable}{lr}
\caption{Example}\label{tab:fixture}\tabularnewline
Model & Value \tabularnewline\endfirsthead
Model & Value \tabularnewline\endhead
\hline\endfoot
\multicolumn{2}{p{.9\linewidth}}{\footnotesize Notes.}\tabularnewline\endlastfoot
R0 & 1 \tabularnewline
\end{longtable}`;
  auditLongtable(valid, 'tab:fixture', 2);
  const precisionNote = valid.replace('R0 & 1', String.raw`\multicolumn{2}{p{.9\linewidth}}{\footnotesize Precise lower bound -0.004.}\tabularnewline` + '\nR0 & 1');
  auditLongtable(precisionNote, 'tab:fixture', 2);
  assert.throws(() => auditLongtable(valid.replace('\\endfirsthead', ''), 'tab:fixture', 2));
  assert.throws(() => auditLongtable(valid.replace('Model & Value', '\\caption{Repeated}Model & Value'), 'tab:fixture', 2));
  assert.throws(() => auditLongtable(valid.replace('\\endhead', '\\label{tab:fixture}\\endhead'), 'tab:fixture', 2));
  assert.throws(() => auditLongtable(valid.replace('\\endfirsthead', '\\endlastfoot').replace('\\endlastfoot\nR0', '\\endfirsthead\nR0'), 'tab:fixture', 2));
  assert.throws(() => auditLongtable(valid.replace('\\multicolumn{2}', '\\multicolumn{1}'), 'tab:fixture', 2));
  assert.throws(() => auditLongtable(valid + '\\footnotesize Detached notes.', 'tab:fixture', 2));
  assert.throws(() => auditLongtable(valid.replace('\\end{longtable}', ''), 'tab:fixture', 2));
  return { result: 'PASS_OUTPUT_AUDITOR_UNIT_CASES_ONLY', valid_cases: 2, rejected_mutations: 7, Stata_calls: 0 };
}

if (process.argv[1] && import.meta.url === pathToFileURL(path.resolve(process.argv[1])).href) {
  if (process.argv[2] === '--self-test') console.log(JSON.stringify(selfTest()));
  else {
    assert(process.argv[2], 'Supply future artificial output directory or --self-test');
    const directories = process.argv.slice(2).map(p => path.resolve(p));
    assert(directories.length <= 2, 'At most the two positive case directories');
    const results = [];
    for (const directory of directories) results.push(await auditDirectory(directory));
    if (directories.length === 2) {
      const contract = JSON.parse(await fs.readFile('4 Academic Submission/wp07-e5-presentation-successor/VALIDATION_CONTRACT.json', 'utf8'));
      for (const file of contract.output_files.filter(f => f.endsWith('.csv') || f.endsWith('.tex'))) {
        const a = (await fs.readFile(path.join(directories[0], file), 'utf8')).replaceAll('\r\n', '\n');
        const b = (await fs.readFile(path.join(directories[1], file), 'utf8')).replaceAll('\r\n', '\n');
        assert.equal(a, b, 'AT01/AT02 order invariance: ' + file);
      }
    }
    console.log(JSON.stringify({ results, order_invariance_checked: directories.length === 2 }));
  }
}
