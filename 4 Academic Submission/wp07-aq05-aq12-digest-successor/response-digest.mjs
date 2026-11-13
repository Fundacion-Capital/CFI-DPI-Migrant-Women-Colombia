import { createHash } from "node:crypto";
import { lstatSync, readFileSync } from "node:fs";
import { pathToFileURL } from "node:url";

export function fingerprint(input) {
    if (typeof input !== "string" && !Buffer.isBuffer(input)) {
        throw new TypeError("response must be text or bytes");
    }
    const bytes = Buffer.isBuffer(input) ? input : Buffer.from(input, "utf8");
    return { bytes: bytes.length, sha256: createHash("sha256").update(bytes).digest("hex") };
}

export function readVerified(path, expected) {
    if (!Number.isSafeInteger(expected?.bytes) || expected.bytes <= 0 ||
        !/^[a-f0-9]{64}$/.test(expected?.sha256 ?? "")) {
        throw new Error("invalid pre-write fingerprint");
    }
    const entry = lstatSync(path);
    if (!entry.isFile() || entry.isSymbolicLink()) throw new Error("not a regular file");
    const saved = readFileSync(path);
    const actual = fingerprint(saved);
    if (actual.bytes !== expected.bytes || actual.sha256 !== expected.sha256) {
        throw new Error("response digest mismatch");
    }
    return saved;
}

export function verify(path, expected) {
    readVerified(path, expected);
    return expected;
}

if (typeof process !== "undefined" && process.argv[1] &&
    import.meta.url === pathToFileURL(process.argv[1]).href) {
    const [, , file, bytes, sha256] = process.argv;
    try {
        process.stdout.write(JSON.stringify(verify(file, { bytes: Number(bytes), sha256 })) + "\n");
    } catch (error) {
        process.stderr.write(error.message + "\n");
        process.exitCode = 1;
    }
}
