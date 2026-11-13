import { lstatSync, readFileSync, readdirSync, writeFileSync } from "node:fs";
import { resolve } from "node:path";
import { pathToFileURL } from "node:url";
import { fingerprint, readVerified } from "../wp07-aq05-aq12-digest-successor/response-digest.mjs";

const sentinel = "a2c07e6099da3fd2f1d52e722525eca56ec2d487acc6d726e4a4eecb40414d13";
const badOutput = /<<ccr:|compressed.{0,45}(?:hash|retriev)|truncat(?:ed|ion)|output (?:capped|saved)|token limit|spill(?:ed| file)|timed out|timeout exceeded|^\s*Error:/im;

export function runAudit({ response, pin, binding, provider, leaf, audit, seal }) {
    // Parse the same bytes that passed the digest check; never parse tool-rendered output.
    const d = JSON.parse(readVerified(response, pin).toString("utf8"));
    const { id, expected: exp, expected_receipts: want } = binding;
    const env = d.envelope;
    if (d.case !== id || env?.isError !== false || env?.transportException ||
        !Array.isArray(env?.content) || env.content.length !== 1 ||
        env.content[0]?.type !== "text" || typeof env.content[0].text !== "string") {
        throw new Error("untrusted response envelope");
    }
    const raw = env.content[0].text;
    const lines = raw.split(/\r?\n/).map(l => l.trimEnd());
    const errors = [], positions = [];
    const check = (condition, error) => { if (!condition) errors.push(error); };
    const matching = (f) => lines.flatMap((l, i) => f(l) ? [i] : []);
    const starts = (s) => matching(l => l.startsWith(s));
    const need = (line, family = null) => {
        const hits = matching(l => l === line);
        check(hits.length === 1 && (!family || starts(family).length === 1), "missing or conflicting receipt: " + line);
        positions.push(hits[0] ?? -1);
    };
    check(!badOutput.test(raw), "provider output incomplete or failed");
    let ordinary = null, ordinary_rejection = null;
    if (id === "aq09") {
        const hits = starts("WP07_AQ09_ORDINARY_REJECT ");
        const line = lines[hits[0]];
        check(hits.length === 1 && provider.aq09_negative.exactly_one_of.includes(line), "missing or conflicting AQ09 ordinary-log rejection");
        positions.push(hits[0] ?? -1);
        ordinary_rejection = line ?? null;
        check(!lines.some(l => l === "(closed)" || /^\s*\.\s+(?:noisily\s+)?cmdlog\s*$/.test(l)) &&
            !starts("WP07_AQ_CMDLOG_CLOSED ").length && !starts("WP07_AQ_RUNTIME ").length,
            "AQ09 reached command-log or runtime stage");
    } else {
        need("(closed)");
        need(want.command_log, "WP07_AQ_CMDLOG_CLOSED ");
        const hits = starts("WP07_AQ_RUNTIME ");
        check(hits.length === 1, "missing or conflicting runtime receipt");
        positions.push(hits[0] ?? -1);
        if (hits.length === 1) {
            let line = lines[hits[0]], wraps = 0;
            for (let i = hits[0] + 1; i < lines.length && /^> .+$/.test(lines[i]); i++) {
                line += lines[i].slice(2);
                wraps++;
            }
            const match = line.match(new RegExp("^WP07_AQ_RUNTIME case=" + id +
                " version=.+ user=.+ temp=.+ ordinary_logs=\\s*(\\d+) path=(.*)$"));
            const route = new RegExp(provider.ordinary_log_name_rule.replace("<exact case>", id));
            const parent = provider.ordinary_log_parent.toLowerCase() + "/";
            if (!match) errors.push("malformed runtime receipt");
            else {
                const count = Number(match[1]), path = match[2];
                if (count === 0 && path === "") ordinary = { count, wraps, route: "none" };
                else if (count === 1 && path.startsWith(parent) && route.test(path.slice(parent.length))) {
                    ordinary = { count, wraps, route: "matched", path, observed: "not present at readback" };
                    try {
                        const item = lstatSync(path);
                        check(item.isFile() && !item.isSymbolicLink(), "ordinary log is not a regular file");
                        ordinary.observed = "present (metadata only)";
                    } catch (e) {
                        if (e.code !== "ENOENT") {
                            ordinary.observed = "unknown";
                            errors.push("ordinary-log metadata unavailable");
                        }
                    }
                } else errors.push("wrong ordinary-log route");
            }
        }
        check(!starts("WP07_AQ09_ORDINARY_REJECT ").length, "unexpected AQ09 receipt");
    }
    if (want.save_reopen) {
        const [n, k] = want.save_reopen_shape;
        need("WP07_AQ_SAVE case=" + id + " N=" + n + " K=" + k, "WP07_AQ_SAVE ");
        need("WP07_AQ_REOPEN case=" + id + " N=" + n + " K=" + k, "WP07_AQ_REOPEN ");
    } else check(!starts("WP07_AQ_SAVE ").length && !starts("WP07_AQ_REOPEN ").length, "unexpected save/reopen");
    need("WP07_AQ_INNER case=" + id + " phase=" + exp.phase + " rc=" + exp.rc + " cleanup=" + exp.cleanup +
        " N=" + exp.N + " K=" + exp.K, "WP07_AQ_INNER ");
    need("WP07_AQ_OUTER case=" + id + " rc=" + exp.rc + " N=" + exp.N + " K=" + exp.K, "WP07_AQ_OUTER ");
    const codes = lines.flatMap(l => { const m = l.match(/^\s*r\((\d+)\);$/); return m ? [Number(m[1])] : []; });
    check(codes.length > 0 && codes.every(rc => rc === exp.rc), "native return code missing or inconsistent");
    check(positions.every((n, i) => n >= 0 && (!i || n > positions[i - 1])), "receipts out of order");

    const directory = lstatSync(leaf);
    if (!directory.isDirectory() || directory.isSymbolicLink()) throw new Error("invalid case directory");
    const names = readdirSync(leaf).sort();
    const expectedNames = exp.case_files.map(s => s.replace(/ \(.+\)$/, "")).sort();
    check(JSON.stringify(names) === JSON.stringify(expectedNames), "unexpected case files");
    const artifacts = [];
    for (const name of names.filter(n => expectedNames.includes(n))) {
        const path = resolve(leaf, name), item = lstatSync(path);
        if (!item.isFile() || item.isSymbolicLink()) { errors.push("unexpected artifact type"); continue; }
        const p = fingerprint(readFileSync(path));
        check(p.bytes > 0, "empty artifact");
        if (exp.case_files.includes(name + " (sentinel unchanged)")) {
            check(p.sha256 === sentinel, "AQ07 sentinel mismatch");
        }
        artifacts.push({ file: name, ...p });
    }
    const result = { id, accepted: errors.length === 0, digest_verified: true, response: pin, errors,
        response_chars: raw.length, response_lines: lines.length, receipt_positions: positions.map(i => i + 1),
        native_codes: codes, phase: exp.phase, rc: exp.rc, ordinary, ordinary_rejection, artifacts };
    if (audit || seal) {
        const payload = JSON.stringify(result, null, 2) + "\n";
        const expected = fingerprint(payload);
        const sealText = JSON.stringify(expected, null, 2) + "\n";
        writeFileSync(audit, payload, { flag: "wx" });
        writeFileSync(seal, sealText, { flag: "wx" });
        const savedSeal = JSON.parse(readVerified(seal, fingerprint(sealText)).toString("utf8"));
        readVerified(audit, savedSeal);
    }
    return result;
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
    try {
        const [, , path, id, bytes, sha256] = process.argv;
        const c = JSON.parse(readFileSync(path, "utf8"));
        if (!/^aq(?:0[7-9]|1[0-2])$/.test(id)) throw new Error("out-of-scope case");
        const binding = c.cases.find(x => x.id === id);
        if (!binding) throw new Error("case is not bound");
        const stem = resolve(c.reserved_evidence_directory, id);
        const pin = JSON.parse(readFileSync(stem + "-prewrite.json", "utf8"));
        if (pin.bytes !== Number(bytes) || pin.sha256 !== sha256) throw new Error("independent pre-write fingerprint disagrees");
        const result = runAudit({ response: stem + "-response.json", pin, binding, provider: c.provider,
            leaf: resolve(c.synthetic_root, id), audit: stem + "-audit.json", seal: stem + "-audit-seal.json" });
        process.exitCode = result.accepted ? 0 : 1;
    } catch (error) {
        process.stderr.write(error.message + "\n");
        process.exitCode = 1;
    }
}
