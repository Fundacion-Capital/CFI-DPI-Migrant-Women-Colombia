import assert from 'node:assert/strict';
import fs from 'node:fs/promises';
import test from 'node:test';
import { verifyReceipts } from './verify_receipts.mjs';

const inner = 'E5_ARTIFICIAL_COMPLETE: case=complete expected_rc=0 observed_rc=0 N=0 K=0';
const outer = 'E5_ARTIFICIAL_SELECTION_COMPLETE: AT01 N=0 K=0';
const base = { id: 'AT01', caseName: 'complete', expectedInnerRc: 0, toolIsError: false, expandedResponse: outer, ordinaryLog: inner };
test('split log/response evidence passes without inventing an outer rc', () => {
  assert.deepEqual(verifyReceipts(base), {
    innerEvidence: ['ordinary_log'], outerEvidence: 'expanded_response', nativeOuterRc: null,
    receiptGate: 'PASS_ONLY_NOT_OUTPUT_ACCEPTANCE'
  });
});
for (const [id, caseName, rc] of [
  ['AT03', 'duplicate_probability', 459],
  ['AT04', 'missing_probability', 9],
  ['AT10', 'output_collision', 602]
]) {
  test(`expected inner r(${rc}) and explicit wrapping do not fail a correct outer completion`, () => {
    const actual = `E5_ARTIFICIAL_COMPLETE: case=${caseName} expected_rc=${rc} observed_rc=${rc} N=0 K=0`;
    const wrapped = actual.slice(0, 71) + '\n> ' + actual.slice(71);
    const result = verifyReceipts({ ...base, id, caseName, expectedInnerRc: rc, nativeOuterRc: 0,
      ordinaryLog: `r(${rc});\n${wrapped}`, expandedResponse: `r(${rc});\nE5_ARTIFICIAL_SELECTION_COMPLETE: ${id} N=0 K=0\n` });
    assert.equal(result.nativeOuterRc, 0);
  });
}
test('preserved v2 outer-only response and log fail the actual caller gate', async () => {
  const pins = JSON.parse(await fs.readFile(new URL('../wp07-e5-v3-preflight-hold/INPUTS.json', import.meta.url), 'utf8'));
  const expandedResponse = await fs.readFile(pins.prior_saved_response.path, 'utf8');
  const ordinaryLog = await fs.readFile(pins.prior_ordinary_log.path, 'utf8');
  assert(expandedResponse.split(/\r?\n/).includes(outer));
  assert.throws(() => verifyReceipts({ ...base, expandedResponse, ordinaryLog }), /Actual caller receipt is missing/);
});
for (const [name, changes, reason] of [
  ['caller source echo', { ordinaryLog: `. display as text "${inner}"` }, /missing/],
  ['outer source echo', { expandedResponse: `. display as text "${outer}"` }, /outer receipt/i],
  ['outer only in ordinary log', { ordinaryLog: inner + '\n' + outer, expandedResponse: '' }, /outer receipt/i],
  ['wrong case', { ordinaryLog: inner.replace('complete', 'reordered') }, /Conflicting/],
  ['wrong observed rc', { ordinaryLog: inner.replace('observed_rc=0', 'observed_rc=9') }, /Conflicting/],
  ['nonempty terminal state', { ordinaryLog: inner.replace('N=0', 'N=1') }, /Conflicting/],
  ['duplicate caller receipt', { ordinaryLog: inner + '\n' + inner }, /repeated caller/],
  ['conflicting channels', { expandedResponse: inner.replace('K=0', 'K=1') + '\n' + outer }, /Conflicting/],
  ['duplicate outer receipt', { expandedResponse: outer + '\n' + outer }, /outer receipt/i],
  ['nonterminal outer receipt', { expandedResponse: outer + '\nr(9);' }, /not terminal/],
  ['actual stop', { expandedResponse: 'E5_ARTIFICIAL_STOP: AT01 rc=9\n' + outer }, /stop receipt/i],
  ['unexpected standalone diagnostic', { expandedResponse: 'r(9);\n' + outer }, /Unexpected Stata return/],
  ['outer marker in the already closed ordinary log', { ordinaryLog: inner + '\nE5_ARTIFICIAL_SELECTION_COMPLETE: AT11 N=1 K=2' }, /ordinary log/i],
  ['MCP error', { toolIsError: true }, /MCP must report success/],
  ['unknown MCP status', { toolIsError: undefined }, /MCP must report success/],
  ['nonzero outer rc', { nativeOuterRc: 9 }, /nonzero outer/]
]) {
  test(`reject ${name}`, () => assert.throws(() => verifyReceipts({ ...base, ...changes }), reason));
}
test('reject a standalone diagnostic that disagrees with the expected negative case', () => {
  assert.throws(() => verifyReceipts({ ...base, id: 'AT04', caseName: 'missing_probability', expectedInnerRc: 9,
    ordinaryLog: 'r(459);\nE5_ARTIFICIAL_COMPLETE: case=missing_probability expected_rc=9 observed_rc=9 N=0 K=0',
    expandedResponse: 'E5_ARTIFICIAL_SELECTION_COMPLETE: AT04 N=0 K=0' }), /Unexpected Stata return/);
});
