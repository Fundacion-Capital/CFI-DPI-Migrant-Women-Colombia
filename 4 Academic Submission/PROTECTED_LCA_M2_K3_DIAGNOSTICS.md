# Protected original M2 three-class saved-state diagnostics

Task: **M6.08.28.R1**. Scope: saved-state diagnostics only; zero fits, predictions, optimizer calls or participant exports. Both original STERs/native469 carriers and every preceding packet remain unchanged. These diagnostics do not replace the original exact comparison.

## Aggregate findings

All six class permutations were examined in declared lexicographic order (123,132,213,231,312,321). The closest diagnostic alignment is **123, the original ordering**. The maximum item-probability difference is 0.000012318352401119448; maximum class-weight difference is 0.000008742464634448055. The other permutations have much larger item-probability differences (approximately 0.670–0.809).

Across the complete theoretical distribution of all 64 binary response patterns, maximum probability difference is 0.0000031097817678044093 and total variation is 0.0000096064432955298438. These are probabilities calculated from the saved model parameters under the original conditional-independence mixture; not empirical frequencies or respondent classifications. Closeness is descriptive, not a tolerance-based equivalence decision.

Diagnostic reference-class rebasing and covariance congruence retain a maximum coefficient difference of 1.5665032049269065 and covariance difference of 2203564.7404266763, because the closest alignment is the identity. The original native469 comparison remains 48 exact matches, 421 numerical differences and zero label/stripe mismatches. A simple class-label permutation does not remove the discrepancy.

| Diagnostic | Replay | Historical |
|---|---:|---:|
| Saved N / reported rank / parameter slots | 423 / 20 / 21 | 423 / 20 / 21 |
| Largest parameter variance | 580977.54360863089 | 2784542.2840353074 |
| Largest standard error, original logit coordinates | 762.21882921417716 | 1668.6947845652624 |
| Free covariance condition number | 52567263.461312003 | 251953954.31875482 |
| Free correlation condition number | 21.324482521662752 | 21.323164359799705 |
| Logit-coordinate distribution Jacobian condition | 9010941.4781307913 | 30033736.914966203 |
| Probability-coordinate distribution Jacobian condition | 23.070808583140195 | 23.069628184862037 |
| Maximum absolute saved logit | 15.044945006481758 | 16.611448211408664 |
| Minimum distance of an item probability to 0 or 1 | 0.00000029245784549658538 | 0.000000061057592759539148 |
| Item probabilities within 0.000001 of a boundary | 2 | 3 |
| Maximum absolute stored gradient component | 0.0042504536563706327 | 0.0024330688361436648 |

The fixed reference-class coefficient and its covariance row/column are zero and are excluded from the 20-coordinate rank/conditioning checks. In both states, the largest variance occurs at original native coordinate **17: lca2_iurd_high:2.C**. Both free covariance matrices are symmetric and have positive computed minimum eigenvalues (approximately 0.01105); positive eigenvalues are not an identification certificate.

Both logit- and probability-coordinate Jacobians have numerical rank 20 at each relative singular-value threshold **1e-8, 1e-10, 1e-12 and 1e-14**. The historical free covariance rank is 16 at 1e-8 and 20 at the other thresholds; the replay free covariance rank is 20 at all four. Threshold-dependent numerical rank must not be conflated with structural parameter count or formal identification.

The contrast between probability-coordinate and logit/covariance conditioning is consistent with strong boundary-related coordinate scaling. The six-permutation check provides no class-relabeling explanation. These observations do not prove the complete cause of the covariance discrepancy, formal/global identification, accurate stationarity, a global optimum, or scientific usability.

## Saved derivative availability and limitations

Both saved states contain a finite 1-by-21 stored gradient. Neither lists a stored **e(H)** Hessian. Unavailable Hessian diagnostics are explicitly missing, not zero. Stored gradients were read, not reevaluated; their magnitudes are not an optimizer-accuracy acceptance rule. No likelihood, score or Hessian evaluation and no information-matrix inversion were performed. The original likelihood difference remains approximately 0.000004384254453; a close likelihood alone does not establish equivalent estimates or defensible inference.

## Validation and preservation

The model-specific synthetic suite checks uniform 64-pattern probabilities, identical-class rank6, a nondegenerate rank20 case, both analytic Jacobians against central finite differences, all six permutations, reference-logit rebasing, covariance cross-term sign changes and inverse congruence, fixed-base exclusion, indefinite covariance, non-label perturbations, extreme finite logits and threshold sensitivity. It first exposed a stub syntax error and a remaining four-class component dimension; these attempts and source versions are retained. The corrected RED reached the intended assertion and the final GREEN passed all fixtures.

Both saved STERs were verified exactly against their own native469 captures before diagnostics. Aggregate CSV output comes directly from Stata/Mata via the Stata MCP. The protected workflow retains authenticated requests/results, immutable input/source fingerprints, selected current/inherited software-test receipts, independent review, final execution binding, seal and separate saved-only verification. Completion requires these closure gates; this report alone is not a completion receipt.

Only the task-owned worker was destroyed; maxvar5000 and the unchanged default session inventory were checked. All preceding files, failures and original comparison remain preserved. No manuscript, qualitative analysis, production code, model-selection preference, Git commit/push, cloud synchronization or release action is included.

## Reporting boundary

Status: **saved-state diagnostics with unresolved native parameter/covariance discrepancy and boundary/conditioning concerns**. Exact historical replication, scientific candidate acceptance and public-release authority remain held. Full-rank numerical Jacobians at these saved points do not establish global identification or inferential reliability. No new fit is authorized.

## Next immediate task

**M6.08.28.R2 — protected original M2 three-class candidate-disposition and reporting contract, without fitting.** Translate the preserved replay and diagnostic evidence into explicit reporting eligibility, caveats and unresolved requirements, without altering saved states, original targets or model preference.
