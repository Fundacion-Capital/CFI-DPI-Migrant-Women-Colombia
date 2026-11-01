# Custody readback correction — no native trial

The `wp06-direct-role-trial` admission remains **INVALIDATED_BEFORE_GRANT_RUNTIME_CACHE_DRIFT**. Owner confirmations are recorded; grants, native launches and participant processing remain zero.

The first separate custody readback was retained as failed: it compared absolute observed path strings with 270 relative path strings in an older seal. That representation mismatch did not establish changed bytes. Neither that failed readback nor the original 34-artifact seal was overwritten.

The additive file-only reader anchors relative lookup to the repository and compares the original size/SHA-256 without rewriting the seal's path. Six artificial fixture tests prove unchanged relative/absolute entries pass while missing files and changed bytes/size fail: RED 3 failures, then 6/6 pass in normal and optimized modes. This correction has implementer test-first verification, not a second independent review.

The controlling correction records are in the ignored sibling case `audit-local/intake/wp06-direct-role-trial-readback-r1-826ad1e-20261101`: `corrected_readback.json`, `correction_seal.json` and `correction_readback.json`. Their actual values govern custody completion; these are not runtime-admission or native-acceptance records. The original `wp06-direct-role-trial` README/OUTCOME references are historical and must be read with this correction.

No runtime/catalog/settings/service changes, cache deletion/restoration, grant, run-root preparation or native retry occurred. The existing full suites remain 256 passes plus one genuine runtime-inventory error per mode. This audit-reader correction does not fix or waive that runtime gate.

Commit title: **Record WP06 owner authorization, prelaunch cache rejection and corrected custody readback**.

Commit description: Record the exact owner confirmations, preserve the runtime-cache admission rejection before grant/launch, retain all preliminary/failed evidence and source seals, and document the additive test-first relative-path readback correction. Keep custody success distinct from the unchanged invalidated request, red static preflight and unperformed native trial. No participant, source, settings/service, Git or publication actions were taken.
