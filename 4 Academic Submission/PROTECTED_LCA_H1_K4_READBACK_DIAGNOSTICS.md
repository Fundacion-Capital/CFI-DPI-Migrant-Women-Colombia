# H1 four-class saved-state readback diagnostics

## M6.08.41.R1 — no-fit diagnostic findings

The previous comparison assertion is explained by **default numeric local-macro serialization of the log likelihood**, not by a failed native-carrier self-readback. This is a bounded technical diagnosis. The original replay/native-target comparison, M6.04.42 / M6.08.41, remains incomplete; historical numerical equivalence and scientific acceptance are not established.

The diagnostic loaded only the preserved fresh estimation state and aggregate initial/full-status/native files. No respondent data were loaded. It reproduced the original compound assertions unchanged: initial status rc0, full status rc9. All four initial predicates passed. Eight of nine full-status predicates passed; only `ll == M[1,3]` failed.

| Representation | Exact Stata hexadecimal value |
|---|---|
| Saved estimation-state log likelihood | `-1.5991f46da75feX+00b` |
| Preserved full-status log likelihood | `-1.5991f46da75ffX+00b` |
| Reconstructed original default local assignment | `-1.5991f46da75ffX+00b` |
| Explicit `%24.17g` local and direct scalar | `-1.5991f46da75feX+00b` |

The status value is exactly one adjacent representable double toward negative infinity from the saved-state value: status minus saved = **−4.547473508864641 × 10⁻¹³**. Both values appear as −2764.56108744326 in the exported decimal CSV. Therefore decimal-display equality is not binary equality. The separately retained hexadecimal evidence identifies the difference without introducing a tolerance.

The root is the original `local ll=e(ll)` followed by posting the expanded numeric text. Repeating that assignment from the unchanged saved state exactly reproduces the preserved status value. An explicitly formatted full-precision local and a direct scalar reproduce the saved-state value exactly. The original full-status variables are stored as doubles, so this is not a float-storage explanation. No preserved file was corrected or overwritten.

## Native-capture and operational checks

The unchanged verifier successfully checked all **3,199** fresh native records against the same saved state: seven metadata cells, 56 coefficients and 3,136 variance/covariance cells, with exact numeric and stripe checks. This establishes fresh-carrier self-consistency, **not** fresh-versus-historical equivalence.

One no-fit Stata MCP selection completed body0 and restored empty data/frames/state and `maxvar=5000`; its owned worker was destroyed. The final default-session inventory matched the initial inventory. Zero fits, refits, predictions, participant loads/exports, relabelings or tolerance changes were performed.

All previous packets, failed attempts and original assertions remain preserved. The first Python intake failed because it compared rounded decimal CSV fields; that failed reader remains dispatch-pinned and unaccepted for real evidence intake. A separate tested reader interprets the retained canonical hexadecimal fields, rejects altered predicates/constants, and authenticates the actual MCP execution. The earlier guard preflight omission and failed tests are retained rather than erased.

See the [aggregate diagnostic summary](lca-h1-k4-readback-diagnostics/readback_summary.csv). Final technical closure requires the private fresh audit, independent review, seal and separate saved-only verification. Private native states, diagnostic DTA files and event logs remain excluded from public Git material. No manuscript, production analysis, Git commit/push, cloud synchronization, model preference or release decision is changed.

## Next immediate task

**M6.08.41.R2 — protected precision-safe saved-state comparison adapter and reporting-contract preflight, without fitting.**

Prepare a separate no-fit comparison packet using the preserved fresh fit. Preserve the original status record as evidence of serialization loss; any canonical status readback must be a new artifact sourced directly from saved-state scalars/matrices and checked exactly. Do not silently repair the old status, introduce tolerance, reuse the failed success pipeline, or declare historical numerical equivalence. Validate the new comparison adapter and its reporting boundary before any separately authorized comparison execution. No fit authority exists.
