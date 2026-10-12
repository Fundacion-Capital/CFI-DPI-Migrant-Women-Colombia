# Protected original M1 four-class saved-state diagnostics

Task **M6.08.25.R1**. Entry owner main `157a740a904dc5214042981fed11eaed19b62294`.
This diagnostic-only task preserves the historical and replay states and the
original-coordinate mismatch from M6.04.26 / M6.08.25. **No model was fitted.**
No respondent dataset, posterior allocation or prediction was used; no target,
coefficient, covariance, class label or comparison tolerance was changed.

## Main findings and limits

The states show substantial class-label reordering. Diagnostic mapping **3412**
means current classes (3,4,1,2) correspond to historical classes (1,2,3,4).
Their theoretical binary-pattern distributions are close but not identical.
Proper reference-logit and covariance rebasing leaves material discrepancies,
so **label switching alone does not reconcile the historical native target**.

Both states have near-boundary item probabilities and very large saved logit
variances. Covariance and logit-Jacobian conditioning are much poorer than the
corresponding correlation and probability-coordinate diagnostics. This is
consistent with a coordinate-scaling difficulty near a boundary; it does not
establish the causal origin of the mismatch, intrinsic non-identification, a
global optimum, an appropriate class count or reliable finite-sample inference.
Historical numerical reproduction and scientific/release acceptance remain held.

## Exact saved-state evidence

The unchanged strict verifier checked **1,063 native cells per state**, including
metadata, all 32 coefficient slots, every covariance entry and their stripes:
**2,126 unique state cells**. Both retain N=423, stored rank=31 and convergence=1.
The constrained reference-class intercept is excluded from the 31-coordinate
free covariance and Jacobians. Stored convergence and rank are not identification
or stationarity certificates.

All 24 permutations were enumerated lexicographically, from 1234 to 4321; 3412
is index 17. This is explanatory alignment only, not target relabeling or relaxed
numerical acceptance. For each saved state, the 128 theoretical probabilities
are the seven-item product-Bernoulli mixture implied by its saved coefficients,
not individual fitted predictions or an empirical respondent distribution.

| Comparison diagnostic | Value |
|---|---:|
| Current saved log likelihood | −1702.8257921443133 |
| Historical saved log likelihood | −1702.8257907204677 |
| Unaligned maximum item-probability difference | 0.87920664285776395 |
| Unaligned maximum class-weight difference | 0.38792646429233302 |
| Closest-aligned maximum item-probability difference | 0.00016343865605254054 |
| Closest-aligned maximum class-weight difference | 0.000041460465402320956 |
| Maximum difference across 128 theoretical pattern probabilities | 0.0000059110399900069027 |
| Theoretical-pattern total variation | 0.000032609333516313219 |
| Maximum diagnostically rebased logit difference | 2.9195166668115871 |
| Maximum diagnostically rebased covariance difference | 11,654,039.678389438 |

The diagnostic linear map A subtracts the newly selected reference-class logit
from the other class logits and permutes item logits. Covariance is transformed
as A V A′. Synthetic checks cover every permutation, probability invariance,
reference constraints and covariance rank. No aligned STER or historical target
is saved or substituted.

## Boundaries, conditioning and local numerical rank

| Saved-state diagnostic | Current | Historical |
|---|---:|---:|
| Free covariance condition number | 1,375,549,735.6440954 | 217,294,781.18296129 |
| Free correlation condition number | 92.285545759192814 | 95.23091606525972 |
| Smallest free covariance eigenvalue | 0.0089531062630890876 | 0.01099093429532336 |
| Largest free covariance eigenvalue | 12,315,445.346019618 | 2,388,272.6612219037 |
| Largest saved logit standard error | 3,509.3368812069889 | 1,545.4037210824326 |
| Logit-coordinate 128×31 Jacobian condition number | 69,802,817.807752475 | 35,964,127.039651066 |
| Probability-coordinate 128×31 Jacobian condition number | 114.63012833112445 | 77.525559145151959 |
| Smallest class weight | 0.11281095090782754 | 0.11278170707013713 |
| Minimum distance to an item-probability boundary | 0.000000036100077672958505 | 0.000000044372987506591244 |
| Maximum absolute stored gradient component | 0.0016957705958825895 | 0.0021829195989818556 |

The declared numerical rank rule counts singular values greater than a relative
cutoff times the largest singular value. At cutoffs 10⁻⁸/10⁻¹⁰/10⁻¹²/10⁻¹⁴,
the free covariance ranks are **18/31/31/31 current** and **28/31/31/31 historical**.
Both free correlations and both Jacobians retain rank 31 at all four cutoffs.
The covariance cutoff sensitivity is a numerical scaling warning—not a claim of
exact algebraic rank deficiency. Free covariance matrices are exactly symmetric
and have positive computed minimum eigenvalues at the saved numerical precision.

Each state has four item probabilities within 10⁻⁶ of a boundary, also four within
10⁻⁴, and none within 10⁻⁸. Class weights are not near zero. The maximum saved
variance occurs at original native coordinate 5 current and 23 historical.
Theoretical probability mass errors are approximately 2.22×10⁻¹⁶ and 1.11×10⁻¹⁶.

For the model family, the generic identification result for mixtures of Bernoulli
products requires p≥2⌈log₂r⌉+1: seven items exceed the sufficient five-item bound
for four classes. A 2/2/3 partition also satisfies the grouped rank bound,
4+4+4≥2×4+2. **Generic identification up to permutation is not identification at
every saved point**, a numerical optimum or an inference certificate. This
distinction follows [Allman, Matias and Rhodes (2009)](https://arxiv.org/pdf/0809.5032).

## Saved optimizer evidence and unavailable information

Both states contain 32 finite saved gradient entries. Their raw maximum norms
are reported without an arbitrary acceptance cutoff or a stationarity claim.
Neither contains a saved Hessian. Availability is determined by actual
`e(matrices)` membership, not by a successful matrix assignment that can return
a missing placeholder; a synthetic absence fixture verifies that distinction.
No fresh scores, likelihood evaluations or Hessians against participant data
were computed. An inverse-Hessian consistency check is therefore unavailable.
The official [gsem manual](https://www.stata.com/manuals/semgsem.pdf) documents
stored results, while the [Mata SVD manual](https://www.stata.com/manuals/m-5svd.pdf)
supports the singular-value diagnostics.

## Operational validation and preservation

Four actual Stata selections are retained and authenticated: the intended
missing-function RED, one failed mathematical GREEN (r(3000), Mata one-line
function syntax), the successful corrected GREEN, and the successful two-state
diagnostics. There are **13 unique successful mathematical fixtures**, including
both finite-difference Jacobians, all 24 permutations, covariance rebasing,
non-label changes, extreme logits, rank thresholds and absent-matrix availability.
Partial or repeated attempts are not extra unique successes. Two Python adoption
failures and an initially misquoted prepared RED request are also retained;
the actual executed request and results are authenticated separately.

The owned worker cleared data, estimates, matrices and Mata, kept maxvar=5000,
closed its log and was destroyed. Default-session inventory and activity records
are unchanged. No package installation, persistent runtime change, model fit,
respondent export, production correction, Git action or cloud action occurred.

Preservation checks retain 768 original byte bindings, 14,786 inherited private
bindings and 163 latest public snapshots. The original replay seal remains
`4E2F8388A230C26C592E695EFC8860FD476A16BEB586A956EE10399DD6E2385D`.
Its eight public representations are archived under the established exact
Git/EOL bridge; earlier successful/failed packets, original reviews and proofs
remain untouched. Partial archive recovery accepts existing bytes only when
they match their original sealed size/hash.

Only eight public paths are added/updated: this report, two aggregate CSVs,
README, workplan, measurement register, workflow state and the existing main.tex.
Schema 82 retains all 1,613 prior artifact pointers and adds ten, giving 1,623;
124 primary task identities and 14 milestone headings are preserved. Technical
closure requires cumulative checks, one independent review, actual post-review
final execution, same-source built-in compilation, an exclusive seal and a
separate saved-only proof. These gates do not authorize scientific acceptance
or public release. Compilation is distinct from visual PDF inspection.

Aggregate tables: [state diagnostics](lca-m1-k4-saved-diagnostics/state_diagnostics.csv)
(112 rows) and [comparison diagnostics](lca-m1-k4-saved-diagnostics/comparison_diagnostics.csv)
(54 rows). `available=0` with a blank value means unavailable; an available
Boolean value of zero means validated absence, including the saved Hessian.

## Next immediate task

**Proposed M6.08.25.R2 — protected original M1 four-class candidate-disposition
and reporting contract, without fitting.** Consolidate original reporting and
selection criteria, the native-coordinate mismatch and these diagnostic limits
into an explicit retained/held/excluded decision record. Do not automatically
modify specifications, labels, thresholds or accepted historical findings.
Further fitting, scientific correction, publication and Git/cloud actions remain
separate authorizations.

## References

Allman, E. S., Matias, C., & Rhodes, J. A. (2009). Identifiability of parameters
in latent structure models with many observed variables. *The Annals of
Statistics, 37*(6A), 3099–3132. https://doi.org/10.1214/09-AOS689

StataCorp. (n.d.). *gsem — Generalized structural equation model estimation*.
https://www.stata.com/manuals/semgsem.pdf

StataCorp. (n.d.). *svd() — Singular value decomposition*.
https://www.stata.com/manuals/m-5svd.pdf
