# M6.08.33.R4 — renewed M3 four-class saved-state diagnostics

Scope: diagnostics of the preserved historical and renewed replay saved estimates only. No fitting, retries, optimization, participant-data loading, predictions, manuscript changes, source-analysis changes or historical-target replacement. The task is diagnostic closure, not candidate acceptance or exact-replication closure.

## Sources and mathematical checks

Protected packet: `audit-local/intake/lca-m3-k4-diagnostics-r4-81abc86/`. Replay source: R2 execution packet `lca-m3-k4-renewal-r2-0bf4c8a/fit_state.ster`, accepted in R3. Historical source: preserved `M3_k4.ster`. Both saved estimates reproduce their own 819-cell native carriers exactly, including coefficient/covariance stripes and metadata.

M3 contains six binary indicators (IVS, ICDP, IAFF, OQI, IURD and IEDF recodings), four classes, 28 native coefficient slots, **27 free coordinates**, and 64 theoretical response patterns. The fixed reference-class intercept and its zero covariance row/column explain the extra native slot; they are not evidence of underidentification.

Reused four-class routines were adapted to six items. Twelve observed Stata fixtures cover uniform/identical components, a nondegenerate full-rank synthetic model, finite-difference checks of all 27 logit and probability-coordinate derivatives, all 24 permutations, reference-class logit rebasing, covariance transformation, constraint exclusion, indefinite covariance, non-label perturbations, extreme finite logits and rank-threshold sensitivity. Missing-routine RED and passing GREEN are retained.

Three inherited fixture log labels still say “31”; their executed assertions and loops explicitly test 27 coordinates. The logs and executed source are retained unchanged. The owner verifier’s initial label mismatch failed closed; a metadata-only correction binds the literal retained labels and has an observed RED/GREEN regression test. This does not change mathematical results or authorize another Stata execution.

## Class parameterization and residual discrepancies

All 24 class permutations were evaluated using the maximum absolute difference across transformed class weights and item probabilities. The closest permutation is **2341**: replay classes 2, 3, 4, 1 correspond diagnostically to historical classes 1, 2, 3, 4. This is an in-memory witness only; saved class labels and target artifacts remain unchanged.

| Saved-state comparison | Diagnostic result |
|---|---:|
| Identity-order maximum item-probability difference | 0.9060375478 |
| Identity-order maximum class-weight difference | 0.2771401702 |
| Closest-permutation maximum item-probability difference | 0.00005913031523 |
| Closest-permutation maximum class-weight difference | 0.00002112435962 |
| Maximum difference across 64 theoretical pattern probabilities | 0.000004623148617 |
| Total variation of the two theoretical pattern distributions | 0.00001183467512 |
| Diagnostic rebased maximum logit difference | 1.168238743 |
| Diagnostic rebased maximum covariance difference | 2,673,255.549 |

The pattern distributions are model-implied probabilities, not observed frequencies or participant predictions. Total variation is half the sum of absolute differences. Relabelling removes most of the probability-scale discrepancy, but does **not** produce exact equality of parameters, covariance matrices or model-implied probabilities. Small differences are descriptive findings, not a new equivalence tolerance.

The R3 native comparison remains authoritative: 62 of 819 cells matched exactly, 757 differed, and no stripes differed; maximum coefficient difference 19.36519651 and maximum covariance difference 5,650,608.092. The saved log-likelihoods remain −1441.3672510711383 (replay) and −1441.3672508392165 (historical). Near-equal likelihoods do not establish exact replication or scientific acceptance.

## Identification and conditioning evidence

Relative spectral rank thresholds are 1e−8, 1e−10, 1e−12 and 1e−14, applied to the largest singular value. They are diagnostic sensitivity checks, not changed native-match rules.

| Diagnostic | Replay | Historical |
|---|---:|---:|
| Stored N / convergence / rank | 423 / 1 / 27 | 423 / 1 / 27 |
| Free covariance condition number | 353,027,727.2 | 347,298,155.0 |
| Free covariance ranks at the four thresholds | 22 / 27 / 27 / 27 | 20 / 27 / 27 / 27 |
| Standardized free-covariance condition number | 269.4001 | 212.6231 |
| Logit Jacobian condition number | 157,179,130.0 | 68,141,589.0 |
| Logit Jacobian ranks at the four thresholds | 26 / 27 / 27 / 27 | 27 / 27 / 27 / 27 |
| Probability-coordinate Jacobian condition number | 109.0333 | 101.0894 |
| Probability-coordinate Jacobian ranks | 27 at all thresholds | 27 at all thresholds |
| Minimum distance of an item probability to 0 or 1 | 2.18933911e−8 | 3.233966128e−8 |
| Item probabilities within 1e−6 of a boundary | 5 of 24 | 5 of 24 |
| Largest logit-coordinate standard error | 1,981.7957 | 2,377.1008 |
| Maximum absolute stored gradient coordinate | 0.002243559857 | 0.0001172260426 |

Both covariance matrices are exactly symmetric with positive free-coordinate eigenvalues in the saved-state calculation; their minimum eigenvalues are 0.01112523 (replay) and 0.01627019 (historical). Large condition numbers and threshold sensitivity show poor scaling/conditioning, not a proof of exact rank deficiency. The substantially better probability-coordinate Jacobian conditioning is consistent with near-boundary probabilities making the logit representation unstable.

The local probability-map Jacobian has numerical rank 27 in both states at all tested thresholds. This supports local numerical separation in that coordinate system; it does **not** prove global identification, uniqueness, a global likelihood maximum, robust inferential validity, or acceptable profile interpretation. No Hessian was stored in either saved estimate. Presence was checked by membership in `e(matrices)`; no missing placeholder or inverse-covariance surrogate was treated as a Hessian. Stored gradients were finite, 1×28; maxima are descriptive and are not a reconstructed optimizer stopping test.

## Preservation, validation and limitations

All tracked files and all prior private intake files are fingerprinted at entry and checked again at closure. Historical, interrupted, recovery, renewal and replay packets are retained. A setup filename mistake and its failed command are retained; only the new packet manifest was corrected to the existing historical `model28_targets.csv` companion.

Execution uses only Stata MCP: baseline inventory, missing-routine RED, passing synthetic GREEN, saved-state diagnostics, owned-worker destruction and final inventory. The worker restored maxvar 5000 and empty state before destruction; the default session inventory is unchanged. Python is limited to metadata, hashes, receipt parsing and trust-boundary tests. Independent review and post-review verification are required for the private seal.

The workflow registry remains schema 110; broader M6 replication and candidate acceptance are not closed by this task. H1_k4 preference, historical comparison, publication/release holds and all source analytical decisions remain unchanged. No Git commit, push or cloud synchronization is performed.

## Next immediate task

**M6.08.33.R5 — protected renewed original M3 four-class candidate-disposition and reporting contract, without fitting.** Carry forward the preserved native mismatch, permutation witness, near-boundary/conditioning findings, stored-derivative limitations and the original interrupted-packet limitation. Do not declare numerical equivalence or authorize another fit.

## Proposed commit

Title: `audit: diagnose renewed M3 four-class saved-state discrepancy`

Description:

- Record exact own-state native readbacks and all-24 diagnostic class-permutation checks.
- Document residual parameter/covariance differences, near-boundary item probabilities and coordinate-sensitive conditioning.
- Distinguish local numerical Jacobian rank from global identification and report unavailable saved Hessians.
- Preserve prior packets, failed setup evidence and immutable historical comparison; retain all replication/release gates.
- Add this public diagnostic report only; keep private estimates, logs, receipts and validation artifacts out of Git.
