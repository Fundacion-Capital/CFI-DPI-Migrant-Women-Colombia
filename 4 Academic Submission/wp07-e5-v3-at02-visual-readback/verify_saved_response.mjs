import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { lstat, open, realpath, writeFile } from 'node:fs/promises';
import { basename, isAbsolute, resolve } from 'node:path';
import { verifyReceipts } from '../wp07-e5-v3-logging-successor/verify_receipts.mjs';

const newlines = value => value.replaceAll('\r\n', '\n');
const pathKey = value => process.platform === 'win32' ? value.replaceAll('\\', '/').toLowerCase() : value;

// Offline only. The caller must first save the raw response and ordinary log.
export async function verifySavedResponse({ raw, ordinaryLog, binding, spillDir, savedSpill, start, end, nativeOuterRc = null }) {
  assert.equal(raw.isError, false, 'MCP must report success');
  assert(raw.content?.length === 1 && raw.content[0].type === 'text', 'Unexpected MCP response shape');
  const inline = raw.content[0].text;
  let expandedResponse = inline;
  let spill = null;
  if (/^Output exceeded token limit|^Full output saved to:|^\.\.\. \[truncated\]/m.test(inline)) {
    const text = newlines(inline);
    const paths = [...text.matchAll(/^Full output saved to: (.+)$/gm)];
    const preview = text.match(/\n--- Preview ---\n([\s\S]+)\n\.\.\. \[truncated\]\s*$/)?.[1];
    assert(/^Output exceeded token limit \(\d+ tokens > \d+ max\)\./.test(text)
      && paths.length === 1 && preview?.trim(), 'Unrecognized full-output handoff');
    const named = paths[0][1];
    const directory = resolve(spillDir);
    const file = resolve(directory, basename(named));
    assert(isAbsolute(named) && pathKey(named) === pathKey(file)
      && /^stata_output_\d{8}_\d{6}\.log$/.test(basename(file)), 'Spill outside the bound directory or naming rule');
    const before = await lstat(file);
    assert(before.isFile() && !before.isSymbolicLink()
      && pathKey(await realpath(file)) === pathKey(file), 'Spill is not a bound regular file');
    assert(Number.isFinite(start) && Number.isFinite(end) && end >= start
      && before.mtimeMs >= start - 1000 && before.mtimeMs <= end + 1000, 'Spill outside dispatch time window');
    const handle = await open(file, 'r');
    const matches = stat => stat.isFile() && stat.dev === before.dev && stat.ino === before.ino
      && stat.mtimeMs === before.mtimeMs && stat.size === before.size;
    let bytes;
    try {
      assert(matches(await handle.stat()), 'Spill changed before readback');
      bytes = await handle.readFile();
      assert(matches(await handle.stat()) && bytes.length === before.size, 'Spill changed during readback');
    } finally {
      await handle.close();
    }
    expandedResponse = bytes.toString('utf8');
    assert(newlines(expandedResponse).startsWith(preview), 'Spill does not match the delivered preview prefix');
    await writeFile(savedSpill, bytes, { flag: 'wx' });
    spill = { path: named, preserved_path: savedSpill, bytes: bytes.length,
      sha256: createHash('sha256').update(bytes).digest('hex'), mtime_ms: before.mtimeMs };
  }
  const receipt = verifyReceipts({ id: binding.id, caseName: binding.case,
    expectedInnerRc: binding.expected_inner_producer_rc, toolIsError: raw.isError,
    nativeOuterRc, expandedResponse, ordinaryLog });
  return { source: spill ? 'named_full_output' : 'inline', spill, receipt };
}
