import assert from 'node:assert/strict';
import { mkdtemp, readdir, readFile, rmdir, unlink, utimes, writeFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import test from 'node:test';
import { verifySavedResponse } from './verify_saved_response.mjs';

const binding = { id: 'AT03', case: 'duplicate_probability', expected_inner_producer_rc: 459 };
const prefix = 'Artificial output begins.\n';
const inner = 'E5_ARTIFICIAL_COMPLETE: case=duplicate_probability expected_rc=459 observed_rc=459 N=0 K=0';
const outer = 'E5_ARTIFICIAL_SELECTION_COMPLETE: AT03 N=0 K=0';
const complete = prefix + 'r(459);\n' + inner + '\n' + outer + '\n';
const response = text => ({ isError: false, content: [{ type: 'text', text }] });
const preview = path => 'Output exceeded token limit (10155 tokens > 10000 max).\nFull output saved to: ' +
  path + '\n\n--- Preview ---\n' + prefix + '... [truncated]';

async function fixture(t, output = complete) {
  const spillDir = await mkdtemp(join(tmpdir(), 'e5-readback-'));
  t.after(async () => {
    for (const name of await readdir(spillDir)) await unlink(join(spillDir, name));
    await rmdir(spillDir);
  });
  const path = join(spillDir, 'stata_output_20261111_010019.log');
  const savedSpill = join(spillDir, 'preserved.log');
  const start = Date.now() - 1000;
  if (output !== null) await writeFile(path, output);
  return { path, args: { binding, raw: response(preview(path)), ordinaryLog: inner,
    spillDir, savedSpill, start, end: Date.now() + 1000 } };
}

test('the named spill is preserved byte-for-byte before receipt verification', async t => {
  const { args } = await fixture(t, complete.replaceAll('\n', '\r\n'));
  const result = await verifySavedResponse(args);
  assert.equal(result.receipt.receiptGate, 'PASS_ONLY_NOT_OUTPUT_ACCEPTANCE');
  assert.equal(result.receipt.nativeOuterRc, null);
  assert.equal(await readFile(args.savedSpill, 'utf8'), complete.replaceAll('\n', '\r\n'));
});

test('complete inline output keeps the original gate and creates no spill copy', async t => {
  const { args } = await fixture(t, null);
  const result = await verifySavedResponse({ ...args, raw: response(complete) });
  assert.equal(result.source, 'inline');
  await assert.rejects(readFile(args.savedSpill), { code: 'ENOENT' });
});

test('missing, mismatched or out-of-scope spill stops the case', async t => {
  const missing = await fixture(t, null);
  await assert.rejects(verifySavedResponse(missing.args), { code: 'ENOENT' });
  const mismatch = await fixture(t, complete.replace('Artificial', 'Different'));
  await assert.rejects(verifySavedResponse(mismatch.args), /prefix/i);
  const wrongDir = await fixture(t);
  await assert.rejects(verifySavedResponse({ ...wrongDir.args, spillDir: tmpdir() }), /directory/i);
});

test('a truncated preview without the exact handoff is rejected', async t => {
  const { args } = await fixture(t);
  await assert.rejects(verifySavedResponse({ ...args, raw: response(complete + '... [truncated]') }), /handoff/i);
});

test('an existing evidence copy is never overwritten', async t => {
  const { args } = await fixture(t);
  await writeFile(args.savedSpill, 'keep this');
  await assert.rejects(verifySavedResponse(args), { code: 'EEXIST' });
  assert.equal(await readFile(args.savedSpill, 'utf8'), 'keep this');
});

test('a stale spill is rejected before copying', async t => {
  const { path, args } = await fixture(t);
  await utimes(path, new Date(args.start - 60_000), new Date(args.start - 60_000));
  await assert.rejects(verifySavedResponse(args), /time window/i);
  await assert.rejects(readFile(args.savedSpill), { code: 'ENOENT' });
});

test('the copy survives a later receipt failure', async t => {
  const wrongCase = complete.replace('AT03 N=0 K=0', 'AT04 N=0 K=0');
  const { args } = await fixture(t, wrongCase);
  await assert.rejects(verifySavedResponse(args), /outer receipt/i);
  assert.equal(await readFile(args.savedSpill, 'utf8'), wrongCase);
});

test('failed or unknown MCP status cannot read back a spill', async t => {
  const { args } = await fixture(t);
  for (const isError of [true, undefined]) {
    await assert.rejects(verifySavedResponse({ ...args, raw: { ...args.raw, isError } }), /must report success/);
  }
  await assert.rejects(readFile(args.savedSpill), { code: 'ENOENT' });
});

test('a separately observed nonzero outer return stops acceptance', async t => {
  const { args } = await fixture(t);
  await assert.rejects(verifySavedResponse({ ...args, nativeOuterRc: 459 }), /Observed nonzero outer return/);
  assert.equal(await readFile(args.savedSpill, 'utf8'), complete);
});
