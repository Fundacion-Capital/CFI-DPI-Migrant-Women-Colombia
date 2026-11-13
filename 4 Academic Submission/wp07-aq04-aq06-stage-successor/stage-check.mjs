import assert from "node:assert/strict";

// Compare filename strings, not the prototypes of the arrays returned by different contexts.
export function assertStageNames(actual, expected) {
    assert.equal(JSON.stringify([...actual].sort()), JSON.stringify([...expected].sort()),
        "Staged directory entries differ from the sealed allowlist");
}
