# Protected original M1 four-class historical replay

M6.04.26 / M6.08.25. Owner checkpoint: 61d009369e256be618d95af6086b4df2cbc9edfd.

## Audited outcome

Exactly one original M1_k4 estimator attempt completed with estimator and comparison-body return codes zero. This is a completed bounded replay and comparison, **not successful full native numerical reproduction**. Of 1,063 native cells, 70 match exactly and 71 are within the frozen absolute/relative tolerance. Scientific acceptance, class selection, identification and release remain held.

| Native component | Cells | Exact | Within frozen tolerance | Maximum absolute difference |
|---|---:|---:|---:|---:|
| Metadata | 7 | 6 | 7 | 0.00000142384556057 |
| Coefficients | 32 | 1 | 1 | 18.60617636102022 |
| Covariance | 1,024 | 63 | 63 | 12,315,445.2555341 |

The observed likelihood is -1702.825792144313; the frozen original likelihood is -1702.825790720468. The observed N is 423, stored rank 31, convergence flag 1 and coefficient slots 32. Close likelihood and a stored convergence flag do not establish parameter/covariance reproduction, identification or equivalence under class relabeling. No relabeling or tolerance change was applied.

## Scientific and execution contract

The seven original binary indicators, complete-case rule and original input order were retained. The source specification is four classes, seed 6429004, startvalues(randomid, draws(500)), difficult iterate(7000), nolog. The protected replay uses only KEY and those seven indicators internally; no participant data or posterior classifications were exported. Production analysis and qualitative sources are unchanged. Original M1_k4 targets were used, not H1_k4 grid, independent final or M1_k3 targets.

The current and historical STER files were separately read back and all 1,063 native values, dimensions, coordinates and equation/parameter stripes verified in Stata. Every comparison row carries original and current values, exact equality and the original rule abs(current-target)<=1e-8+1e-8*abs(target); metadata other than likelihood requires exact equality. Raw matrices and cell-level comparisons remain private. Public exhibits contain aggregate information only.

Stata's in-memory arithmetic remains authoritative. CSV re-parsing showed last-bit differences for some subtractions; the transcript reader checks carrier identity, finite deltas, match flags and aggregate consistency without requiring independently re-parsed CSV subtraction to be bit-identical. The scientific matching tolerance and Stata outputs were not changed.

## Preserved cleanup failure and no-fit recovery

The estimator, capture, both STER/native readbacks and comparison completed before cleanup failed at r(3499). The implementer used mata clear rather than the existing validated clear mata command. The dispatched driver, actual tool result and pre-recovery log remain unchanged and preserved. This failure was not a failed optimization and was not hidden as ordinary successful cleanup.

A separate source-bound no-fit recovery used clear mata, restored maxvar from 32767 to 5000 and verified an empty owned worker. It loaded no participants or stored models and performed no estimation. The owned worker was then destroyed. The complete before/after default-session inventory and activity match. Exactly one fit call and one no-fit recovery selection, plus three lifecycle events, are authenticated in the task journal. The single-fit authority is exhausted; no refit is authorized.

## Preservation and technical acceptance

The committed schema80 preflight was adopted through an exact Git/EOL bridge and its sealed private evidence. Entry checked 768 original fingerprints, 14,545 inherited private fingerprints and 160 public snapshots. Earlier successful/failed packets, the original independent reviews, their corrections and separate proofs remain preserved.

Aggregate [outcome](lca-m1-k4-replay/outcome.csv) and [native comparison](lca-m1-k4-replay/native_comparison.csv) accompany this report. Ten schema81 orchestration pointers and an audit note are appended without replacing legacy manuscript content or changing the original milestone/task identities.

Final technical closure requires the cumulative suite, one independent critic, review-ruling adoption, authenticated fresh post-review execution and two separate saved-only proofs. The authoritative acceptance is audit-local/intake/lca-m1-k4-replay-61d0093/validation.json, not this narrative by itself. Technical closure does not turn the numerical mismatch into replication or authorize public release, staging, commit, push or cloud synchronization.

## Next immediate task

M6.08.25.R1 — protected saved-state numerical-discrepancy and identification diagnostics, without fitting. Investigate the coefficient/covariance mismatch and possible label/near-boundary issues using only preserved states. Do not relabel the original acceptance comparison, change targets/tolerances, refit or select a preferred candidate. Keep all M1_k3 holds open. The original M1 five-class candidate remains a later separately gated intake/preflight, not part of this authorization.
