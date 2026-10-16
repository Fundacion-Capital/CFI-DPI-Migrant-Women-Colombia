# M6.08.41.R4 — protected H1 four-class diagnostic attempt

## Status: incomplete; failed attempt preserved

The single reserved no-fit execution failed with Mata parser return code **3000** while defining `h1r4_jac()` in the new mathematics helper. This occurred before the synthetic mathematical fixtures, either saved-state readback, and any diagnostic calculation. There are **no diagnostic results** from this attempt. Do not interpret the Python contract tests or the successful cleanup as mathematical validation or completion of R4.

The failure location is an inline loop body ending in `...*T[2+3*(j-1)+z,k]}`. Missing statement termination before the closing brace is the immediate parser-recovery hypothesis; it has not been runtime-verified. The whole helper and fixture syntax require a separate preflight, not blind substitution and reuse of this reservation.

## Implemented but not runtime-validated

The preserved draft adapter covers the H1 mixed-input specification: one binary item and six three-category ordinal items; 56 stored coefficient slots, including the fixed class-reference coordinate. Its planned diagnostics exclude that reference coordinate when examining the 55-dimensional free covariance matrix; record stored gradient/Hessian availability rather than inventing unavailable evidence; and examine singular values, eigenvalues, boundary saturation and local probability-map derivatives.

The mathematical fixtures are designed to test both analytic Jacobians against finite differences, identical-class degeneracy, an interior full-rank example, threshold sensitivity, extreme logits and all 24 scratch probability-column permutations. None completed in this attempt. Enumerating the 1,458 theoretically possible response patterns would not be a participant prediction or an observed-data fit. Scratch permutation distances would not apply relabeling to either saved estimate or establish observational equivalence. Any numerical-rank outcome would be threshold- and coordinate-dependent, not a global-identification proof.

The ordered-category probability map follows the ordered-logit cumulative-cutpoint representation in the [official Stata ordered-logit manual](https://www.stata.com/manuals/rologit.pdf), with the ordinal/logit family documented in the [gsem family/link manual](https://www.stata.com/manuals/semgsemfamily-and-linkoptions.pdf). These references support the intended formulas, not the unexecuted implementation. Singular-value diagnostics are described in the [official Mata SVD manual](https://www.stata.com/manuals/m-5svd.pdf).

## Preservation and execution boundary

The source-bound attempt used only the Stata MCP selection interface and its separately named owned worker. The body returned 3000; cleanup explicitly passed empty data/variables and `maxvar=5000`; the owned worker was destroyed. Before/after inventory retains the same pre-existing session identities. The shared default session's internal state is not certified; its last-activity metadata changed, so full inventory-object equality is not claimed.

All previous tracked sources and private packets remain protected by the entry SHA-256/size manifest. The original failed adapter, reservation, source pins and log remain untouched. No output dataset or 203-row metric CSV was created. No fits, retries, saved-state readbacks, participant loads/exports, predictions, stored-state relabeling/rebasing, tolerance changes, production-analysis edits, manuscript edits, Git actions or cloud synchronization occurred.

The previous R3 exact comparison remains unchanged: 118 of 3,199 cells matched, 3,081 differed, and no stripes differed. This attempt provides no new evidence about why the covariance and coefficient discrepancies exist. Scientific acceptance, candidate disposition, release approval and overall M6 completion remain withheld. The new failure audit and independent review certify preservation and truthful reporting of the failed attempt only.

Public [attempt status](lca-h1-k4-diagnostic-attempt/attempt_status.csv) is aggregate-only. Source, log, request evidence and preservation manifests remain in the ignored protected packet. Completion of its failure-preservation workflow must not be confused with completion of the requested diagnostic workflow.

## Next immediate task

**M6.08.41.R4.R1 — preserved-attempt syntax recovery and mathematical-fixture preflight, without fitting.**

Keep this entire attempt immutable; prepare a sibling recovery packet, repair and preflight the Mata parser boundary, and validate the mathematical fixtures before any saved-state diagnostics. Any subsequent execution needs a new source-bound reservation. No fitting or automatic retry is authorized by the exhausted R4 reservation. R5 candidate disposition must wait for successful diagnostics.
