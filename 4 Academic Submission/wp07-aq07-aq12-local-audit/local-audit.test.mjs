import assert from "node:assert/strict";
import { mkdirSync, mkdtempSync, readFileSync, writeFileSync, unlinkSync, rmdirSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { test } from "node:test";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { fingerprint } from "../wp07-aq05-aq12-digest-successor/response-digest.mjs";

import { runAudit } from "./local-audit.mjs";
const route = "^stata_run_fixture_<exact case>_[a-z0-9_-]+[.]log$";
const provider = {
    ordinary_log_parent: "C:/synthetic/Temp", ordinary_log_name_rule: route,
    aq09_negative: { exactly_one_of: ["WP07_AQ09_ORDINARY_REJECT reason=count", "WP07_AQ09_ORDINARY_REJECT reason=path"] }
};
const binding = { id: "aq07", expected: { phase: "target", rc: 459, cleanup: 0, N: 0, K: 0, case_files: [] },
    expected_receipts: { command_log: "WP07_AQ_CMDLOG_CLOSED case=aq07 rc=0 status_blank=1 filename_absent=1", save_reopen: false, runtime: true } };
const closed = "(closed)\n" + binding.expected_receipts.command_log;
const runtime = "WP07_AQ_RUNTIME case=aq07 version=19 user=fixture temp=C:/synthetic/Temp/ ordinary_logs=1 path=c:/synthetic/temp/stata_run_fixture_\n> aq07_token.log";
const inner = "WP07_AQ_INNER case=aq07 phase=target rc=459 cleanup=0 N=0 K=0";
const outer = "WP07_AQ_OUTER case=aq07 rc=459 N=0 K=0";
const valid = [closed, runtime, inner, "r(459);", outer].join("\n");

test("local evidence survives an irrelevant warning in displayed output and cannot be overwritten", t => {
    const dir = mkdtempSync(join(tmpdir(), "wp07-local-audit-"));
    const [response, audit, seal, leaf] = ["response.json", "audit.json", "audit-seal.json", "."].map(n => join(dir, n));
    t.after(() => { for (const p of [response, audit, seal]) try { unlinkSync(p); } catch (e) { if (e.code !== "ENOENT") throw e; } rmdirSync(dir); });
    const payload = JSON.stringify({ case: "aq07", envelope: { content: [{ type: "text", text: valid }], isError: false } });
    writeFileSync(response, payload);
    const input = { response, pin: fingerprint(payload), binding: { ...binding, expected: { ...binding.expected, case_files: ["response.json"] } }, provider, leaf, audit, seal };
    const result = runAudit(input);
    const displayed = "Warning: artificial banner\n" + JSON.stringify(result);
    assert.throws(() => JSON.parse(displayed), SyntaxError);
    assert.equal(result.accepted, true);
    assert.equal(JSON.parse(readFileSync(audit, "utf8")).accepted, true);
    assert.deepEqual(JSON.parse(readFileSync(seal, "utf8")), fingerprint(readFileSync(audit)));
    assert.throws(() => runAudit(input), /EEXIST/);
});

test("receipt review fails closed after verifying the input digest", t => {
    const dir = mkdtempSync(join(tmpdir(), "wp07-receipt-fixture-"));
    const response = join(dir, "response.json");
    t.after(() => { unlinkSync(response); rmdirSync(dir); });
    const encode = (text, id = "aq07") => JSON.stringify({ case: id, envelope: { content: [{ type: "text", text }], isError: false } });
    const check = (text, b = binding, accepted = false) => {
        const payload = encode(text, b.id);
        writeFileSync(response, payload);
        const spec = { ...b, expected: { ...b.expected, case_files: ["response.json"] } };
        const result = runAudit({ response, pin: fingerprint(payload), binding: spec, provider, leaf: dir });
        assert.equal(result.digest_verified, true);
        assert.equal(result.accepted, accepted, result.errors?.join("; "));
    };
    check(valid, binding, true);
    check(valid.replace(inner, ". display " + inner));
    check(valid + "\n" + outer);
    check(valid.replace(inner + "\nr(459);\n" + outer, outer + "\nr(459);\n" + inner));
    check(valid.replace("r(459);", "r(9);"));
    check(valid.replace("aq07_token.log", "another_case.log"));
    check("<<ccr:fixture,placeholder>>\n" + valid);
    check(valid.replace("(closed)", "(open)"));
    const aq09 = { id: "aq09", expected: { ...binding.expected, phase: "log" }, expected_receipts: { runtime: false, save_reopen: false } };
    const nine = ["WP07_AQ09_ORDINARY_REJECT reason=count", inner.replace("case=aq07 phase=target", "case=aq09 phase=log"), "r(459);", outer.replace("case=aq07", "case=aq09")].join("\n");
    check(nine, aq09, true);
    check(nine.replace(/^.*\n/, ""), aq09);
    check("(closed)\n" + nine, aq09);
    check(nine.replace("reason=count", "reason=path"), aq09, true);
    check(nine + "\nWP07_AQ_SAVE case=aq09 N=423 K=322", aq09);
    const aq08 = { id: "aq08", expected: { ...binding.expected, phase: "readback_values", rc: 9 },
        expected_receipts: { ...binding.expected_receipts, command_log: binding.expected_receipts.command_log.replace("aq07", "aq08"), save_reopen: true, save_reopen_shape: [423, 322] } };
    const save = "WP07_AQ_SAVE case=aq08 N=423 K=322";
    const reopen = "WP07_AQ_REOPEN case=aq08 N=423 K=322";
    const eight = [closed.replace("case=aq07", "case=aq08"), runtime.replaceAll("aq07", "aq08"), save, reopen,
        inner.replace("case=aq07 phase=target rc=459", "case=aq08 phase=readback_values rc=9"),
        "r(9);", outer.replace("case=aq07 rc=459", "case=aq08 rc=9")].join("\n");
    check(eight, aq08, true);
    check(eight.replace(reopen, reopen.replace("K=322", "K=321")), aq08);
    check(eight.replace(save + "\n" + reopen, reopen + "\n" + save), aq08);
    const payload = encode(valid);
    writeFileSync(response, payload + " ");
    assert.throws(() => runAudit({ response, pin: fingerprint(payload), binding, provider, leaf: dir }), /response digest mismatch/);
});

test("CLI gates on independent digest and local decision, not its display", t => {
    const dir = mkdtempSync(join(tmpdir(), "wp07-local-cli-"));
    const leaf = join(dir, "aq07");
    const contract = join(dir, "contract.json");
    const response = join(dir, "aq07-response.json");
    const prewrite = join(dir, "aq07-prewrite.json");
    const audit = join(dir, "aq07-audit.json");
    const seal = join(dir, "aq07-audit-seal.json");
    t.after(() => { for (const p of [contract, response, prewrite, audit, seal]) try { unlinkSync(p); } catch (e) { if (e.code !== "ENOENT") throw e; } rmdirSync(leaf); rmdirSync(dir); });
    mkdirSync(leaf);
    writeFileSync(contract, JSON.stringify({ cases: [binding], synthetic_root: dir, reserved_evidence_directory: dir, provider }));
    const payload = JSON.stringify({ case: "aq07", envelope: { content: [{ type: "text", text: valid }], isError: false } });
    const pin = fingerprint(payload);
    writeFileSync(response, payload);
    writeFileSync(prewrite, JSON.stringify(pin));
    const cli = fileURLToPath(new URL("./local-audit.mjs", import.meta.url));
    const run = (hash) => spawnSync(process.execPath, [cli, contract, "aq07", String(pin.bytes), hash], { encoding: "utf8" });
    assert.equal(run("0".repeat(64)).status, 1);
    assert.throws(() => readFileSync(audit), /ENOENT/);
    assert.equal(run(pin.sha256).status, 0);
    assert.equal(JSON.parse(readFileSync(audit, "utf8")).accepted, true);
    assert.deepEqual(JSON.parse(readFileSync(seal, "utf8")), fingerprint(readFileSync(audit)));
    assert.equal(run(pin.sha256).status, 1);
});
