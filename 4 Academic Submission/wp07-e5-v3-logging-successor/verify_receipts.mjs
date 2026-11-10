// Check saved evidence only. Never dispatch Stata or infer an unreported rc.
import assert from 'node:assert/strict';

function resultLines(text) {
  const lines = [];
  for (const line of text.split(/\r?\n/)) {
    if (line.startsWith('> ') && lines.at(-1)?.startsWith('E5_ARTIFICIAL_')) {
      lines[lines.length - 1] += line.slice(2);
    } else {
      lines.push(line);
    }
  }
  return lines.map(line => line.trimEnd()).filter(line => line.trim());
}

export function verifyReceipts({ id, caseName, expectedInnerRc, toolIsError, nativeOuterRc = null, expandedResponse, ordinaryLog }) {
  assert.equal(toolIsError, false, 'MCP must report success');
  assert(nativeOuterRc === null || nativeOuterRc === 0, 'Observed nonzero outer return');
  const response = resultLines(expandedResponse);
  const log = resultLines(ordinaryLog);
  const inner = `E5_ARTIFICIAL_COMPLETE: case=${caseName} expected_rc=${expectedInnerRc} observed_rc=${expectedInnerRc} N=0 K=0`;
  const outer = `E5_ARTIFICIAL_SELECTION_COMPLETE: ${id} N=0 K=0`;
  assert(![...response, ...log].some(line => line.startsWith('E5_ARTIFICIAL_STOP:')), 'Actual stop receipt');
  const innerEvidence = [];
  for (const [channel, lines] of [['expanded_response', response], ['ordinary_log', log]]) {
    const emitted = lines.filter(line => line.startsWith('E5_ARTIFICIAL_COMPLETE:'));
    assert(emitted.length <= 1 && emitted.every(line => line === inner), 'Conflicting or repeated caller receipt');
    if (emitted.length) innerEvidence.push(channel);
  }
  assert(innerEvidence.length, 'Actual caller receipt is missing');
  assert.deepEqual(response.filter(line => line.startsWith('E5_ARTIFICIAL_SELECTION_COMPLETE:')), [outer], 'Missing, repeated or wrong outer receipt');
  assert.equal(response.at(-1), outer, 'Outer receipt is not terminal');
  assert(!log.some(line => line.startsWith('E5_ARTIFICIAL_SELECTION_COMPLETE:')), 'Outer receipt in the already closed ordinary log');
  for (const line of [...response, ...log]) {
    const diagnostic = line.match(/^\s*r\((\d+)\);?$/);
    if (diagnostic) assert(expectedInnerRc !== 0 && Number(diagnostic[1]) === expectedInnerRc, 'Unexpected Stata return diagnostic');
  }
  return { innerEvidence, outerEvidence: 'expanded_response', nativeOuterRc, receiptGate: 'PASS_ONLY_NOT_OUTPUT_ACCEPTANCE' };
}
