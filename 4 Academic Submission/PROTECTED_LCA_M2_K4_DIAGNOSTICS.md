# M6.08.29.R1 — original M2 four-class saved-state diagnostics

**Saved-state diagnostics only: zero fits, predictions, participant input loads or participant exports.** The fresh nonconverged state is not scientifically accepted. The original exact comparison (819cells:60exact/759different/0stripe) remains unchanged.

## Evidence and protected scope

Entry main2a5e9dc397aaf8134bb5b3779e308b0376e253a5. The preceding replay seal2FDCBEF5471EC483EA8CD7878B58F85743B34F1CF2C4140AF77E45D1BF23FC09 and both actual execution proofs were verified. All prior packets, transport timeout, strict comparison601 and38-file failed packet are preserved.

Only the frozen original M2_k4 STER/native target and fresh saved STER/diagnostic native carrier are read. Each state passes strict own-carrier readback of819cells, full coefficient/covariance stripes and dimensions:28native slots including one fixed baseline,27free coordinates. The fresh state explicitly requires N423/converged0/rank23; the archived target requires N423/converged1/rank27. No input microdata, optimizer, score reevaluation or new classification is used.

## Label parameterization versus remaining discrepancy

All24permutations were examined using the maximum absolute difference across class weights and six-item probabilities. The closest lexicographic permutation is index6: **1432**, meaning replay columns1,4,3,2 are compared with historical columns1,2,3,4. This is a diagnostic alignment, not a replacement labeling or tolerance-based acceptance.

| Diagnostic | Result |
|---|---:|
| Identity item-probability maximum difference |0.69714100536513646|
| Closest1432 item-probability maximum difference |0.000047911852267934485|
| Closest1432 class-weight maximum difference |0.00001920513908290622|
| Maximum difference across64 theoretical pattern probabilities |0.0000021331685917946874|
| Total variation over64 theoretical patterns |0.000011130145273297241|
| Reference-rebased logit maximum difference |4.6416257365679314|
| Congruence-rebased covariance maximum difference |35605745.85268259|

Class weights are model-implied mixing weights, not respondent assignments or empirical class sizes. Pattern probabilities describe the complete theoretical six-binary-indicator response space, not new sample frequencies. Rebasing uses an explicit baseline-logit transformation A and full covariance congruence A V A', including cross terms; permutations do not refit either model.

The probability profiles and theoretical distributions are very close after1432 alignment, but not exactly equal. Parameter and covariance disagreement remains. Label switching explains much of the unaligned profile difference; it does not repair nonconvergence, establish equivalent inference or erase the original native discrepancy.

## Boundary and covariance evidence

| Diagnostic | Fresh nonconverged state | Historical target |
|---|---:|---:|
| Stored convergence / rank |0 /23|1 /27|
| Minimum item distance from0 or1 |1.3060672543474539e-9|1.3545590815677855e-7|
| Item probabilities within1e-6 of a boundary |6 of24|5 of24|
| Minimum free-coordinate variance |0|0.024786224225003178|
| Maximum free-coordinate variance |36230642.447778471|1203477.569808882|
| Square root of maximum stored variance |6019.1895175163299|1097.0312528861164|
| Largest-variance original native coordinate |18:OQI,2.C|22:IURD,2.C|
| Free covariance smallest singular value |0|0.010441368075500716|
| Free covariance condition number |Unavailable: zero smallest singular value|115260525.35696834|

The covariance matrices are exactly symmetric in saved evidence. The fresh minimum symmetrized eigenvalue is-1.3286420897790505e-19: numerical near-zero evidence, not a substantive proof of a materially negative eigenvalue. Its free covariance is singular, and free-correlation standardization is unavailable because a free-coordinate variance is zero. The historical normalized-correlation condition number is127.95832832173016.

Square roots of stored variances are reported as conditioning diagnostics, **not validated standard errors or usable inference**. Both states include near-boundary item probabilities; the fresh state is closer to a boundary and has more severe logit-scale/covariance instability.

## Local mapping checks and relative-threshold sensitivity

Ranks use singular values exceeding the declared relative threshold times the largest singular value. Both Jacobians map27free coordinates to64theoretical pattern probabilities; the probability-coordinate Jacobian varies the three nonbaseline class weights with the baseline weight adjusted to maintain unit mass.

| Matrix |1e-8|1e-10|1e-12|1e-14|
|---|---:|---:|---:|---:|
| Fresh free covariance |9|23|23|23|
| Historical free covariance |26|27|27|27|
| Fresh logit-coordinate Jacobian |23|27|27|27|
| Historical logit-coordinate Jacobian |27|27|27|27|
| Fresh probability-coordinate Jacobian |27|27|27|27|
| Historical probability-coordinate Jacobian |27|27|27|27|

The logit-coordinate condition numbers are1272808067.5142305(fresh) and24225628.527376547(historical); probability-coordinate values are96.63082144783705 and96.628424560818488. Thus finite-point probability-coordinate local mapping checks show full27-column numerical rank, while the fresh logit map is strongly affected by near-boundary scaling and the stored covariance remains rank-deficient. These checks do **not** prove global identification, uniqueness of the likelihood optimum, or reliable inference for the nonconverged fit. Stored e(rank) and a threshold-dependent Jacobian rank are different diagnostics and must not be conflated.

## Stored derivatives and limitations

Both saved states retain a finite1x28gradient. Maximum absolute stored gradient entries are1.1502088065398935e-6(fresh) and0.0011511308097530313(historical). Neither stores a Hessian. A smaller stored gradient does not override the fresh convergence0 flag or establish the original convergence criterion: iteration/criterion context and a stored Hessian are unavailable here. No covariance inverse is substituted for a missing Hessian; no optimizer or observational likelihood is rerun.

Fresh posterior probabilities, empirical class counts, entropy and reporting-screen flags are **NOT_RECOMPUTED**. The archived target remains an archived candidate, not automatically revalidated evidence. Original H1_k4 preference and all scientific/exact-replication/release holds are unchanged.

## Mathematical and operational verification

A deliberately broken64-pattern map failed its actual Stata assertion3498 and restored maxvar5000; that attempt is retained. The corrected mathematics passed synthetic uniform/identical-class/nondegenerate27-rank fixtures, finite differences for both27-coordinate Jacobians, all24permutations, baseline rebasing, inverse and covariance cross-term checks, constraint exclusion, indefinite covariance, nonlabel changes, extreme finite logits and declared-threshold sensitivity.

Actual diagnostic readback passed for both819cell carriers. Capacity restored from32767 to5000; only the owned worker was destroyed, with default-session inventory unchanged. Six authenticated Stata events comprise three no-fit selections, two inventory calls and one owned-worker destruction.

Entry preservation covers964 unrelated tracked files and16770 previous private files. Only six public paths change: this report, [164-row aggregate diagnostic receipt](lca-m2-k4-diagnostics/diagnostics_summary.csv), three additive milestone documents and schema97 workflow state with10additional pointers. The software guards, independent final review with decline adoption, fresh actual post-review execution binding, immutable seal, independent saved-only verification/proofs and final readback are required before completion. No manuscript, production code, Git commit/push, cloud synchronization or release is included.

## Next immediate task

**M6.08.29.R2 — protected original M2 four-class candidate-disposition and reporting contract, without fitting.** Separate archival reporting eligibility from the nonconverged fresh state, carry forward label/conditioning/Hessian caveats, and define explicitly what may be described as historical evidence versus diagnostic-only replay. No retry or new fit is authorized.
