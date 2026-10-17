# WP03 — preferred-final saved-state numerical, identification and disposition audit

## Outcome

The historical preferred-final H1 four-class estimate and its exact replay both pass fresh **3,199-field native checks** against their frozen targets. All **63 keyed diagnostic/availability entries per state agree: True**. This is a completed no-fit audit, not academic acceptance of the model. Disposition: **EXACT_NATIVE_REPLAY_WITH_SAVED_STATE_NUMERICAL_AND_IDENTIFICATION_HOLD**. No fit/refit, participant-data load/export, prediction, assignment, permutation search, relabeling, original-state rewrite or downstream execution occurred.

## Saved-state numerical evidence

| Metric | Archived preferred-final | Preserved replay |
| --- | ---: | ---: |
| stored_ll | -2764.561087971138 | -2764.561087971138 |
| stored_gradient_maxabs | 0.0024970050977990341 | 0.0024970050977990341 |
| variance_max | 2987544302760.8911 | 2987544302760.8911 |
| standard_error_max | 1728451.4175298335 | 1728451.4175298335 |
| maximum_variance_coordinate | 34 | 34 |
| free_covariance_condition | 272357145151606.81 | 272357145151606.81 |
| free_correlation_condition | 28.587691008967468 | 28.587691008967468 |
| minimum_class_weight | 0.10029064878623807 | 0.10029064878623807 |
| minimum_item_probability | 9.1580593743162332e-15 | 9.1580593743162332e-15 |
| item_boundary_count_1e8 | 4 | 4 |
| item_boundary_count_1e6 | 5 | 5 |
| item_boundary_count_1e4 | 7 | 7 |
| logit_jacobian_condition | 136685746924419.58 | 136685746924419.58 |
| probability_jacobian_condition | 31.452570706359491 | 31.452570706359491 |
| pattern_mass_error | 4.4408920985006262e-16 | 4.4408920985006262e-16 |
| minimum_pair_profile_separation | 0.72823798631593473 | 0.72823798631593473 |

The largest variance is native slot34, `/h_iuof3:2.C#c.cut1`, whose stored cutpoint is approximately -32.32414209736896. Its standard error is about1.73million. That uncertainty and the severe raw-coordinate scaling are substantive inference warnings, not transcription errors to fix by formatting. Both states retain stored convergence1, N423,56slots and55free coordinates. The maximum stored gradient is a raw stored1x56 quantity; no fresh score or scaled stopping criterion was evaluated. Stored `e(H)` is absent, and its finite/dimension/maximum fields are explicitly unavailable, never zero. No Hessian was fabricated by inverting covariance.

## Coordinate scaling and local identification

Relative numerical ranks count singular values greater than rtol times the largest singular value. Thresholds below are diagnostics only; they never relax the exact historical native-equality rule.

| Matrix/map | 1e-8 | 1e-10 | 1e-12 | 1e-14 |
| --- | ---: | ---: | ---: | ---: |
| Free covariance | 6 | 6 | 8 | 45 |
| Diagonal-correlation coordinates | 55 | 55 | 55 | 55 |
| Logit/cutpoint probability-map Jacobian | 50 | 52 | 53 | 54 |
| Probability-coordinate Jacobian | 55 | 55 | 55 | 55 |

The raw covariance ranks6–45 must **not** be read as only6–45 identified parameters. Correlation and probability coordinates are much better conditioned, with full numerical rank55 at these thresholds. Conversely, full local probability-map rank does **not** certify global uniqueness, stable/regular likelihood inference or participant-classification stability. Computed raw covariance eigenvalues and singular values are algorithmic summaries of a severely ill-scaled matrix, not an observed-information or curvature certificate. See Stata's official [SVD](https://www.stata.com/manuals/m-5svd.pdf) and [rank](https://www.stata.com/manuals/m-5rank.pdf) references.

## Tail-safe probabilities and mathematical preflight

The ordered probabilities follow the [ordered-logit cumulative-cutpoint representation](https://www.stata.com/manuals/rologit.pdf). This packet computes both binary outcomes explicitly and ordered upper tails from the negative cutpoint; middle categories use a stable product/gap expression rather than subtracting CDFs rounded to1. Derivatives use direct logistic density factors, not rounded complements. Complement masses used for boundary distances/counts are sums of other category probabilities. The all-category audit covers **80 coordinates**:8binary probabilities and72ordinal probabilities across four classes; older76-coordinate tables omitted the four binary failures and should not be compared by bare denominator.

The preserved expected-red fixture demonstrates loss of a representable positive40/41 tail under the legacy helper. The new helper passed uniform1458-pattern/rank13, separated55-coordinate logit and probability finite differences, deliberate sign fault, relative positive/negative40/41 tail and derivative checks, narrow cut gaps, underflow1000, zero/indefinite covariance and explicit threshold fixtures. The first green attempt reached most checks but stopped rc3000 at a compact loop's syntax. Its original source/reservation/log remain preserved. A separately reserved multiline-only correction passed every fixture; no old helper or scientific result was rewritten.

The model-implied1458-pattern distribution is generated analytically from saved parameters, without observed records. Its mass error checks arithmetic consistency, **not observed goodness of fit**. The minimum mixing weight is about10.03percent, not a modal class size. No fresh posterior probabilities, entropy, modal counts, class profiles based on observed participants or original reporting-screen eligibility were recomputed. Near-boundary probabilities and high coordinate separation also do not prove robust participant assignments.

## Disposition and reporting contract

Retain the archived preferred-final model and exact replay as preserved historical evidence. Report exact numerical reproduction together with near-boundary/scaling/uncertainty limitations. **Do not present the huge native cutpoint standard errors as validated Wald inference or exact replication as scientific model selection.** The reporting contract separates17 supported, bounded, unavailable, not-recomputed and withheld claims. No analyst correction, class merge, item change, relabeling or alternative solution is adopted here. Scientific/privacy/ethics/release holds remain unchanged.

## Preservation and closure

Entry baseline:1,105 tracked files and19,886 prior-private files. Proposed tracked changes are this report, three aggregate CSVs and five governance documents. All previous2,265 artifact pointers remain. Four no-fit Stata selections cover legacy red, preserved failed green, corrected green and saved-state diagnostics; four owned workers were destroyed, shared default untouched. Independent review, post-review full preservation audit, immutable seal, separate verification and closure receipt govern technical completion. No commit, push, cloud/Overleaf sync, manuscript or qualitative changes.

## Next task

Prepare the combined **preferred-final scientific-adjudication/remediation protocol and downstream execution-gate crosswalk**, without fitting or participant outputs. Specify how future authorized sensitivity/stability and uncertainty work would address these findings, distinguish historical downstream replay from academic scientific adoption, and freeze stage-specific authority before any prediction, participant export, benchmark fit or regression. This audit does not activate those stages or claim publication readiness.
