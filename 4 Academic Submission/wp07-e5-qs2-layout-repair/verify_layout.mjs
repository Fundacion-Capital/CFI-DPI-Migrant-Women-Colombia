// Saved-artifact check only: read PDF text; never invoke Stata or change a PDF.
import { execFileSync } from 'node:child_process';
import assert from 'node:assert/strict';

assert(process.argv[2], 'Supply the private diagnostic PDF');
const text = execFileSync('pdftotext.exe', ['-layout', process.argv[2], '-'], { encoding: 'utf8' });
const pages = text.split('\f').filter(p => p.trim());
const start = pages.findIndex(p => p.includes('Model-standardized endpoint probabilities'));
assert(start >= 0, 'QS2 caption missing');
// PDF text maps the 'ffi' ligature inconsistently; the unambiguous prefix suffices.
const nextTable = pages.findIndex((p, i) => i > start && /Native\s+logit\s+/.test(p));
const end = nextTable < 0 ? pages.length : nextTable;
const selected = pages.slice(start, end);
const rowModels = [];
const header = /Model\s+Candidate\s+Endpoint\s+N\s+Probability\s+SE\s+95%\s+interval/;
for (const [offset, page] of selected.entries()) {
  const rows = [...page.matchAll(/^(R0C?|D0|R1|D1)\s+/gm)].map(m => m[1]);
  assert(rows.length > 0, 'QS2 page ' + (start + offset + 1) + ' has no data rows');
  assert(header.test(page), 'QS2 page ' + (start + offset + 1) + ' lacks repeated column headings');
  rowModels.push(...rows);
}
assert.deepEqual(rowModels, [
  'R0','R0','R0','R0','R0','R0',
  'D0','D0','D0','D0','D0','D0',
  'R1','R1','R1','R1','R1','R1',
  'D1','D1','D1','D1','D1','D1',
  'R0C','R0C','R0C','R0C','R0C','R0C'
], 'All thirty endpoint rows in model order');
const notes = /Probability\s+units,\s+not\s+percentages\s+or\s+observed\s+prevalence/g;
assert.equal([...selected.join('\n').matchAll(notes)].length, 1, 'Final notes printed once');
assert(/Probability\s+units,\s+not\s+percentages\s+or\s+observed\s+prevalence/.test(selected.at(-1)), 'Notes on final QS2 page');
console.log(JSON.stringify({ result: 'PASS_SAVED_QS2_RENDERED_TEXT_NOT_NATIVE_VALIDATION', document_pages: pages.length, QS2_pages: selected.map((_, i) => start + i + 1), rows: rowModels.length, headings_on_every_QS2_page: true, notes_once: true, Stata_calls: 0, visual_review_still_required: true }));
