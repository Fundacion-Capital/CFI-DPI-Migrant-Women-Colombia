# Original H1 four-class bounded replay — comparison hold

**M6.04.42 / M6.08.41 is NOT complete.** The authorized single fit finished and its evidence is preserved, but the subsequent no-fit comparison failed an assertion before its first readback-success marker. This document records a blocked checkpoint, not successful native comparison, scientific acceptance or fit authorization.

## Observed execution

The original initial-grid specification was used unchanged: six ordered-logit indicators plus binary-logit `h_iedf2`, four classes, seed6529004,600 random-id draws, `difficult`,8000 iterations, original sample and row order under version16 semantics. Source sample8214–8217, seed8259 and estimator8261–8273 including immediate return-code capture are bound to the preceding sealed preflight. No sorting, recoding, tolerance change, relabeling, retry, prediction or participant export was introduced. This is not the separate final preferred H1 four-class refit.

The single fit recorded:

| Field | Captured status |
|---|---:|
| Return code | 0 |
| Convergence flag | 1 |
| Estimation N / e(sample) count / eligible count | 423 / 423 / 423 |
| Rank / coefficient slots | 55 / 56 |
| Status CSV log likelihood | −2764.56108744326 |

The archived initial-grid metadata reports log likelihood−2764.561090279198. The recorded decimal values differ; **this is not a completed native-target comparison or an established explanation for the failed assertion**. Status serialization, saved-state values and native readback must be diagnosed without fitting before interpreting that difference.

The three-field initial aggregate status and the eight-field full status were durably postclosed before optional state saving and native capture. The fresh saved state,3,199-row aggregate native carrier, CSVs, initial/full DTA status files and fit log remain preserved. The fit log contains exactly one estimator-attempt marker, body0 and successful cleanup.

## Unresolved comparison boundary

The reserved second selection contains **no fitting**. It returned **body9** with `assertion is false` after loading the verification-program definitions and before `H1R_INITIAL_FINAL_STATUS_AND_SAVED_STATE_EXACT_PASS`. It did not reach fresh-state native readback, historical-state readback or comparison-complete markers. The available log does not identify the precise failed field; no cause is assumed here and no check is weakened.

No `native_comparison.dta/.csv` or `comparison_summary.dta/.csv` was produced. Exact-match, mismatch and stripe-mismatch counts therefore remain **unavailable**, not zero. No claim of exact native identity, completed numerical discrepancy classification or scientific validity is permitted.

The [observed-status table](lca-h1-k4-replay-hold/replay_status.csv) explicitly labels the comparison unavailable and the requested task incomplete. It is not a regression/native-comparison summary.

## Preservation, cleanup and audit boundary

The actual roster has six Stata MCP events: initial inventory; single fit; fit-worker destruction; no-fit comparison; comparison-worker destruction; final inventory. Both bodies performed cleanup, restored `maxvar` from32767 to5000 and cleared their frames/data/state. Both owned workers were destroyed and final inventory equals initial inventory. The default session was untouched. No additional Stata execution followed the comparison failure.

Original dispatch-pinned source, requests and manifests remain unchanged. The complete actual request/result envelopes, logs and all pre-existing packets are preserved. The hold audit checks1061 unrelated tracked files,19195 prior private files and four original governance snapshots, plus all current execution artifacts. Current and selected safe preceding tests concern code boundaries and hold preservation; they cannot make the failed comparison pass. Independent review and fresh hold seal/separate verification apply only to the truthful preservation of this blocked checkpoint, not acceptance of M6.04.42 / M6.08.41.

No production analysis, manuscript, Git commit/push, cloud synchronization, preferred-model decision or release is changed. The sole fit authorization has been consumed; it does not permit retry or refit.

## Next immediate task

**M6.08.41.R1 — protected saved-state initial-status/native-capture readback-failure diagnostics, without fitting.**

Use the preserved state and aggregate artifacts to identify exactly which initial/full-status or saved-state predicate failed, including any representation/precision issue only if demonstrated. Preserve the failed packet and original verification rules. Any proposed correction must have its own explicit, source-bound tests and reporting contract; do not rerun the model, silently introduce tolerance, change class labels or infer scientific acceptance.
