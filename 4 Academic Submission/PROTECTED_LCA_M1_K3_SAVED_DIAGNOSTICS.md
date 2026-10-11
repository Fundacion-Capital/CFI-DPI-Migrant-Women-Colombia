# Protected M1 three-class saved-state discrepancy and identification diagnostics

Task: **M6.08.24.R3**. Entry: owner `main` at `0421ff55884ecf1841cedcf69078a57de2568e60`. This is an additive, diagnostic-only audit of the two immutable saved states from M6.04.25.R2 / M6.08.24.R2. It does not replace that replay's numerical-mismatch conclusion.

## Scope and scientific disposition

No research model was fitted. No respondent dataset was loaded, no posterior membership or respondent prediction was produced, and no historical coefficient, covariance, class label, tolerance, likelihood, or target was changed. The original seven-binary, three-class specification, sample of 423, seed 6429003, 300 random starts and 5,000 iterations remain historical facts, not newly executed estimation settings. All calculations used saved STER/native carriers or synthetic mathematical fixtures through Stata MCP.

The current and historical saved states exhibit substantial class-label reordering and close—but not identical—theoretical mixture distributions. After diagnostic label alignment and proper baseline-logit/covariance rebasing, material coefficient and covariance discrepancies remain. **Historical numerical replication is still incomplete.** Conditioning diagnostics suggest a near-boundary logit-coordinate issue, but do not establish its causal origin, intrinsic non-identification, a global likelihood maximum, an appropriate class count, or reliable finite-sample inference.

## Exact evidence and mathematical checks

The current and historical carriers were independently checked against their STER metadata, coefficient/covariance stripes, double-precision values and fixed reference constraint: **607 native cells per state, 1,214 total**. The extension repeats that saved-only check; those repetitions are not additional unique cells. Both states retain N=423, stored rank=23 and convergence=1. Stored convergence and `e(rank)` alone are not identification or optimizer certificates.

Six permutations were enumerated in the fixed order `123,132,213,231,312,321`. The closest mapping is **312: current classes (3,1,2) correspond to historical classes (1,2,3)**. This is an explanatory calculation only. It does not relabel a target or relax the existing exact-coordinate comparison.

| Diagnostic | Result |
|---|---:|
| Current saved log likelihood | −1709.192280707085 |
| Historical saved log likelihood | −1709.1922858612702 |
| Unaligned maximum item-probability difference | 0.84409929258877092 |
| Unaligned maximum class-weight difference | 0.36588342343663177 |
| Closest-aligned maximum item-probability difference | 0.000029731584127223876 |
| Closest-aligned maximum class-weight difference | 0.000036205988689419488 |
| Maximum difference across 128 theoretical binary-pattern probabilities | 0.0000082043571653644953 |
| Theoretical-pattern total variation | 0.000035792950591322704 |
| Maximum logit difference after diagnostic rebasing | 1.253300837115491 |
| Maximum covariance-entry difference after diagnostic rebasing | 388561.91106820927 |

For seven binary items, the 128-pattern distribution is the product-Bernoulli mixture implied by the saved coefficients. It is not a distribution computed from individual predictions or posterior allocations. For the closest permutation, a linear parameter map rebases the class logits and permutes the item logits; covariance is transformed as A V A′. Synthetic checks verify both probability invariance under this map and preservation of the fixed-reference covariance constraint. The nonzero rebased discrepancies show why label switching alone is not an exact reconciliation.

## Conditioning, boundaries and local numerical rank

| Saved-state diagnostic | Current | Historical |
|---|---:|---:|
| Free 23-coordinate covariance condition number | 43,324,950.227826767 | 14,978,558.266936874 |
| Free correlation condition number | 24.758121660014144 | 30.1475247069503 |
| Smallest free covariance eigenvalue | 0.012538785331457919 | 0.010326784233493806 |
| Largest free covariance eigenvalue | 543,242.25031091855 | 154,680.33925758681 |
| Largest saved logit standard error | 737.04969323988951 | 393.29421459869707 |
| Logit-coordinate 128×23 Jacobian condition number | 4,430,122.806379335 | 1,432,638.0311195345 |
| Probability-coordinate 128×23 Jacobian condition number | 10.626122211709358 | 11.63071097725005 |
| Smallest class weight | 0.16068139777133289 | 0.16064519178264347 |
| Largest item probability | 0.99999976736426166 | 0.99999918533732668 |
| Minimum distance to an item-probability boundary | 0.00000023263573833975926 | 0.00000081466267332075404 |
| Maximum absolute stored gradient component | 0.0023878170539264974 | 0.0045917756728197003 |

The first of 24 native coordinates is the constrained reference-class intercept. Its zero covariance is expected, so it is excluded from the free 23-coordinate covariance and correlation calculations. Both free covariance matrices are exactly symmetric, positive definite at the saved numerical precision, and full rank at each declared relative singular-value cutoff: 10⁻⁸, 10⁻¹⁰, 10⁻¹² and 10⁻¹⁴. Both analytic Jacobians also retain rank 23 at all four cutoffs. The probability-coordinate Jacobian is much better conditioned than the logit-coordinate Jacobian. This is evidence about coordinate scaling near a boundary—not a proof of inferential adequacy or absence of practical estimation difficulty.

Neither state has an item probability within 10⁻⁸ of 0 or 1; each has one within 10⁻⁶ and one within 10⁻⁴. The largest saved variance occurs at original native coordinate 17 in the current state and 18 in the historical state. Class weights themselves are not near zero. Theoretical pattern mass sums to one within 1.11×10⁻¹⁶ in both states.

The generic identification result for finite mixtures of product distributions also matters: splitting seven binary indicators into groups of 2/2/3 satisfies the three-class rank bound, 3+3+3≥2×3+2. This supports **generic identification up to class permutation**, not identification at every fitted point, a global optimum, or valid inference for these particular saved estimates. The saved-state numerical checks and the generic theorem therefore answer different questions. See [Allman, Matias and Rhodes (2009)](https://arxiv.org/pdf/0809.5032).

## Stored-gradient evidence and unavailable Hessian

The saved results contain 24 finite gradient components in each state. Their raw maximum norms are reported, without calling them a stationarity certificate. No fresh score or Hessian was computed against participant data.

An initial diagnostic availability flag was misleading: `capture matrix H=e(H)` returned successfully while creating a 1×1 missing matrix even though `e(H)` was absent. The failed extension and two subsequent metadata-inspection errors are preserved. The corrected extension checks actual `e(matrices)` membership and finite gradient entries; **a saved Hessian is unavailable in both states**. Stata's documented [gsem stored results](https://www.stata.com/manuals/semgsem.pdf) list `e(gradient)` but do not promise `e(H)`.

The original raw diagnostic tables remain unchanged in the private packet. A separately named derivative corrects only the two Hessian-availability flags from 1 to 0. The public state table uses that derivative, plus validated extension metrics. This is a diagnostic metadata correction, not a change to either fitted model or to a historical target. No inverse-Hessian consistency conclusion is possible here.

## Validation and preservation contract

Nine actual Stata selections are journal-bound: the intended missing-function RED, three mathematical GREEN attempts, the main saved-state diagnostics, the failed first extension, two failed metadata inspections, and the successful corrected extension. The first two GREEN attempts failed with r(3000) and r(3200); their source/request/receipt/log versions remain preserved. The intended RED captured r(3499). The failed extension captured r(9); metadata inspections returned r(109) and r(111). Transport success is not treated as computational success: the complete closed Stata logs govern acceptance.

There are **16 unique successful mathematical fixtures**, including finite-difference Jacobian checks, covariance/constraint checks, permutation invariance and genuine absent-matrix availability handling. Repeated or partially completed fixture runs are not counted as additional successes. The worker clears its owned data, estimates, matrices and Mata state, keeps maxvar=5000, closes logs and is destroyed. The default session's inventory and activity records are unchanged.

Preservation checks retain **768 original byte bindings, 13,786 inherited private bindings and 151 latest public snapshots**, together with the full prior chain. The R2 seal remains `9DD376D71E24196D0075BAD638473BF7B557789C062164DF1F82E6703D2E172E`; its eight public representations are archived byte-exactly using the established Git/EOL contract. The first partial archive attempt is also preserved. Previous failed fits, failed diagnostics, original review verdicts and proof packets are not removed or rewritten.

Only eight public paths are updated/added: this report, two aggregate CSVs, README, workplan, measurement register, workflow state and the existing main.tex. Workflow schema 78 retains all 1,573 prior pointers and adds ten, giving 1,583. The 124 primary task IDs, 14 milestone headings and manuscript preamble remain unchanged. Technical closure additionally requires the source-bound cumulative suite, one independent review with preserved original verdict/dispositions, authenticated post-review final execution, same-source built-in compilation, an exclusive seal and separate saved-only verification. These receipts are protected audit evidence, not a public release approval.

Aggregate tables: [state diagnostics](lca-m1-k3-saved-diagnostics/state_diagnostics.csv) (108 rows) and [comparison diagnostics](lca-m1-k3-saved-diagnostics/comparison_diagnostics.csv) (18 rows). `available=0` means the diagnostic itself is unavailable; an available Boolean value of 0 means a validated absence, including the corrected saved-Hessian flags.

## Next immediate task

**Proposed M6.08.24.R4 — protected historical M1 three-class candidate-disposition and reporting contract, without fitting.** Consolidate the original candidate-selection/reporting criteria, the R2 exact-coordinate mismatch and the R3 diagnostic limitations into an explicit retained/held/excluded reporting decision record before preparing another candidate. Do not change labels, thresholds, scientific specifications or accepted historical results automatically. Any fit, scientific correction, publication, Git action or cloud synchronization remains a separate authorization.

## References

Allman, E. S., Matias, C., & Rhodes, J. A. (2009). Identifiability of parameters in latent structure models with many observed variables. *The Annals of Statistics, 37*(6A), 3099–3132. https://doi.org/10.1214/09-AOS689

StataCorp. (n.d.). *gsem — Generalized structural equation model estimation*. [Official manual](https://www.stata.com/manuals/semgsem.pdf).

StataCorp. (n.d.). *svd() — Singular value decomposition*. [Official Mata manual](https://www.stata.com/manuals/m-5svd.pdf).

StataCorp. (n.d.). *rank() — Rank of matrix*. [Official Mata manual](https://www.stata.com/manuals/m-5rank.pdf).
