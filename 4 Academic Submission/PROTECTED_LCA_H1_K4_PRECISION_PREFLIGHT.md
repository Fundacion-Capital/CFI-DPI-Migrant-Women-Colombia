# Original H1 four-class precision-safe comparison preflight

## M6.08.41.R2 — scope and observed preflight

This packet prepares a **new, no-fit comparison adapter** for the already preserved original H1 four-class fit. It does not fit, refit, predict, load respondent data, cross-compare fresh and historical native values, or alter any previous packet. The parent M6.04.42 / M6.08.41 comparison remains incomplete.

The preceding R1 diagnosis remains unchanged: default numeric local serialization placed the preserved status log likelihood one adjacent double below its saved-state value. The original status is retained as evidence; it is not silently corrected. The new writer posts matrix expressions directly into a separate double-precision status artifact and verifies exact equality against the saved matrix. No tolerance is introduced.

One reserved Stata MCP preflight completed body0 and demonstrated:

| Gate | Observed result |
|---|---|
| Real comparison entrypoint without execution authority | Held at rc459 before saved-state payload or comparison output |
| Matrix-sourced status write and readback | Exact equality for all eight status fields, all double storage |
| Deliberate one-step log-likelihood corruption | Rejected |
| Deliberate wrong estimation N | Rejected |
| Deliberate wrong coefficient-slot count | Rejected |
| Deliberate float storage | Rejected |
| Deliberate duplicate status row | Rejected |
| Fresh native carrier against its own saved state | All 3199 metadata/coefficient/covariance records and stripes pass |
| Historical native carrier against its own saved state | All 3199 records and stripes pass |

The five faults existed only in temporary, preserved/restored diagnostic memory, never in originals or the new saved valid status. Their rejection is not a scientific robustness exercise. Both native verifications are **self-readbacks**, not a fresh-versus-historical comparison.

The owned worker restored empty data/frames/state and maxvar5000 and was destroyed; final inventory matched initial inventory. Zero fits, refits, predictions, participant loads/exports or historical cross-comparisons occurred.

## Prepared comparison and reporting contract

The held adapter keeps the original initial-status check and explicitly validates the diagnosed legacy status hexadecimal values. It then writes and verifies a **new canonical status** from saved-state matrices. It does not pass off the rounded legacy status as an exact readback. Fresh and historical native carriers must each pass the unchanged verifier before any future exact merge/comparison.

Future runtime artifacts are directed to a **new sibling execution packet**, not inside this sealed preflight. A separately reserved execution authority is required; the authority filename alone is not a scientific or release approval. No authority file or runtime comparison packet has been created in R2.

The prepared detail output carries exact hexadecimal historical, replay, signed-difference and absolute-difference fields, the native keys and both stripe sets. Summary output carries exact maximum-difference hex and per-kind/all counts. The tested reporting contract requires the complete 3199-key universe (7 metadata, 56 coefficients, 3136 covariance cells), rejects missing/duplicate keys, malformed/nonfinite values, inconsistent differences/stripes/flags and incorrect summaries. It permits truthful numerical or stripe discrepancies; it must never turn unavailable comparison counts into zero mismatches or claim scientific acceptance. Synthetic full-shape reporting fixtures are software tests, not empirical findings.

The historical comparison payload remains unexecuted and is not yet certified end-to-end on real comparison outputs. The fresh-versus-historical likelihood difference is unresolved; the one-step serialization repair does not explain it.

See [aggregate preflight status](lca-h1-k4-precision-preflight/preflight_status.csv). Private source/request pins, logs, original-file preservation fingerprints, valid test status and actual execution envelopes remain local and ignored. Final technical closure is governed by the independent review, fresh final audit, seal and separate saved-only verification. No production analysis, manuscript, Git commit/push, cloud synchronization, preferred-model decision or release is changed.

## Next immediate task

**M6.08.41.R3 — separately reserved precision-safe saved-state historical comparison and exact native-target reporting, without fitting.**

Prepare the new execution packet and source-bound authority/reservation; then run the held no-fit adapter once, authenticate both own-state readbacks and exact detail/summary outputs, and report the observed historical match/discrepancy without relabeling, tolerance or fitting. Preserve this preflight and all prior packets. Completion of R2 does not complete the parent comparison or authorize any fit.
