import assert from "node:assert/strict";
import { readdirSync } from "node:fs";
import { test } from "node:test";
import { runInNewContext } from "node:vm";
import { assertStageNames } from "./stage-check.mjs";

const actual = readdirSync(new URL(".", import.meta.url)).filter(name =>
    name === "stage-check.mjs" || name === "stage-check.test.mjs");
const foreign = (names) => runInNewContext(JSON.stringify(names));
const correct = ["stage-check.test.mjs", "stage-check.mjs"];

test("accepts the exact filenames across JavaScript contexts, regardless of order", () => {
    assert.notEqual(Object.getPrototypeOf(actual), Object.getPrototypeOf(foreign(correct)));
    assert.doesNotThrow(() => assertStageNames(actual, foreign(correct)));
    assert.doesNotThrow(() => assertStageNames(foreign(correct), actual));
    assert.doesNotThrow(() => assertStageNames(foreign([]), []));
});

test("rejects missing and extra entries without accepting equal counts", () => {
    for (const names of [
        ["stage-check.mjs"],
        [...correct, "unexpected.dta"],
        ["stage-check.mjs", "unexpected.dta"],
        ["stage-check.mjs", "stage-check.mjs"],
        ["STAGE-CHECK.MJS", "stage-check.test.mjs"],
    ]) assert.throws(() => assertStageNames(foreign(names), actual));
});
