import assert from "node:assert/strict";
import { mkdirSync, mkdtempSync, readFileSync, writeFileSync, unlinkSync, rmdirSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { test } from "node:test";
import { fingerprint } from "../wp07-aq05-aq12-digest-successor/response-digest.mjs";

const cli = fileURLToPath(new URL("./closure-audit.mjs", import.meta.url));
const contract = JSON.parse(readFileSync(new URL("./CLOSURE_CONTRACT.json", import.meta.url), "utf8"));
const history = {
    aq04: "wp07-closed-command-log-execution",
    aq06: "wp07-aq05-aq12-digest-execution",
};

for (const binding of contract.cases) {
    const { id, expected: { rc } } = binding;
    test(id + " saved synthetic response: digest, receipts, and exclusive decision", t => {
        const manifest = JSON.parse(readFileSync(new URL("../" + history[id] + "/VALIDATION.json", import.meta.url)));
        const record = manifest.evidence_pins.find(p => p.file === id + "-response.json");
        const original = readFileSync(join(manifest.private_evidence, record.file));
        // AQ04's historical saved-file fingerprint is an offline test input, not a recovered pre-write fingerprint.
        const pin = fingerprint(original);
        assert.deepEqual(pin, { bytes: record.bytes, sha256: record.sha256 });
        const dir = mkdtempSync(join(tmpdir(), "wp07-closure-test-"));
        const leaf = join(dir, id);
        const [spec, response, prewrite, audit, seal] = [
            "contract.json", record.file, id + "-prewrite.json", id + "-audit.json", id + "-audit-seal.json",
        ].map(n => join(dir, n));
        t.after(() => {
            for (const p of [spec, response, prewrite, audit, seal]) {
                try { unlinkSync(p); } catch (e) { if (e.code !== "ENOENT") throw e; }
            }
            rmdirSync(leaf);
            rmdirSync(dir);
        });
        mkdirSync(leaf);
        // Use the original provider naming rule only for this saved response.
        const prior = JSON.parse(readFileSync(manifest.contract.path));
        writeFileSync(spec, JSON.stringify({
            cases: [binding], synthetic_root: dir, reserved_evidence_directory: dir, provider: prior.provider,
        }));
        writeFileSync(prewrite, JSON.stringify(pin));
        writeFileSync(response, Buffer.concat([original, Buffer.from(" ")]));
        const run = (caseId = id, hash = pin.sha256) =>
            spawnSync(process.execPath, [cli, spec, caseId, String(pin.bytes), hash], { encoding: "utf8" });
        assert.match(run("aq07").stderr, /out-of-scope/);
        assert.match(run(id, "0".repeat(64)).stderr, /pre-write fingerprint disagrees/);
        assert.match(run().stderr, /response digest mismatch/);
        assert.throws(() => readFileSync(audit), /ENOENT/);
        writeFileSync(response, original);
        const accepted = run();
        assert.equal(accepted.status, 0, accepted.stderr);
        const result = JSON.parse(readFileSync(audit, "utf8"));
        assert.equal(result.accepted, true, result.errors.join("; "));
        assert.equal(result.rc, rc);
        assert.deepEqual(result.artifacts, []);
        assert.deepEqual(JSON.parse(readFileSync(seal, "utf8")), fingerprint(readFileSync(audit)));
        assert.match(run().stderr, /EEXIST/);
    });
}
