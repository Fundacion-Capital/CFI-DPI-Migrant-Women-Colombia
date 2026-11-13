import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import { runAudit } from "../wp07-aq07-aq12-local-audit/local-audit.mjs";

try {
    const [, , contractPath, id, bytes, sha256] = process.argv;
    if (id !== "aq04" && id !== "aq06") throw new Error("out-of-scope case");
    const c = JSON.parse(readFileSync(contractPath, "utf8"));
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
