import assert from "node:assert/strict";
import { existsSync, mkdtempSync, writeFileSync, rmdirSync, unlinkSync, symlinkSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { test } from "node:test";

import { fingerprint, verify } from "./response-digest.mjs";
import * as verifier from "./response-digest.mjs";

test("uses SHA-256 over exact UTF-8 bytes", () => {
    assert.deepEqual(fingerprint("abc"), {
        bytes: 3,
        sha256: "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
    });
});

test("accepts the original file and rejects altered bytes before receipt parsing", t => {
    const dir = mkdtempSync(join(tmpdir(), "wp07-response-fixture-"));
    const path = join(dir, "synthetic.json");
    const link = join(dir, "linked");
    t.after(() => {
        if (existsSync(link)) rmdirSync(link);
        if (existsSync(path)) unlinkSync(path);
        rmdirSync(dir);
    });
    const text = JSON.stringify({ content: [{ type: "text", text: "línea\r\n> continuación 🧪\n" }], isError: false }, null, 2) + "\n";
    const expected = fingerprint(text);
    writeFileSync(path, text);
    assert.deepEqual(verify(path, expected), expected);
    assert.equal(typeof verifier.readVerified, "function", "verified bytes must be available without a second file read");
    assert.equal(verifier.readVerified(path, expected).toString("utf8"), text);
    for (const changed of [
        text.replace("línea", "líneo"), text.slice(0, -1), text + " ",
        text.replaceAll("\n", "\r\n"), "\uFEFF" + text, '{"content":"<<ccr:placeholder>>"}\n'
    ]) {
        writeFileSync(path, changed);
        assert.throws(() => verify(path, expected), /response digest mismatch/);
        assert.throws(() => verifier.readVerified(path, expected), /response digest mismatch/);
    }
    assert.throws(() => verify(path, { bytes: expected.bytes }), /invalid pre-write fingerprint/);
    assert.throws(() => verify(join(dir, "missing.json"), expected));
    assert.throws(() => verify(dir, expected), /not a regular file/);
    symlinkSync(dir, link, "junction");
    assert.throws(() => verify(link, expected), /not a regular file/);
});
