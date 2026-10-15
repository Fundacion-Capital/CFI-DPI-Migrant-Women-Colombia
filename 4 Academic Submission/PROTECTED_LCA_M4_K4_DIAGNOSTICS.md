# M6.08.37.R1 — original M4 four-class saved-state diagnostics

## Result and scope

**RESIDUAL_PARAMETER_DISCREPANCY. Saved-state diagnostics only: zero fits, predictions, participant-input loads or participant exports.** The fresh state remains nonconverged0/rank22; the archived target remains converged1/rank23. This is not exact replication or scientific acceptance. The original607-cell raw comparison (52exact,555different,zero stripe differences), transport timeout, withheld strict converged capture and every prior packet remain unchanged.

The closest of all24 permutations is **2143**, lexicographic index8: fresh columns2,1,4,3 are compared with historical columns1,2,3,4. It is chosen by minimum maximum absolute discrepancy over the combined class-weight/item-probability matrix, with first lexicographic minimum retained. It is not a substantive class naming, a tolerance-based acceptance, or a replacement of original labels. The closest item-probability discrepancy remains .81779660946844279 and class-weight discrepancy .57261063416276992. Thus the observed discrepancy is not explained solely by a class-label permutation.

## Evidence, source and numerical safeguards

Entry owner checkpoint main14ece8ffaf0bc00d400ffcca68b26b8abe66e11e. Preceding replay seal EF62299E6F4D6167D6F047E059BA1FA111E7C8954E7925DEF2DC11FF8FE157EA and its two actual execution proofs were checked. Both native carriers were verified against their own saved estimate exactly across607 records (7metadata,24coefficients,576covariance cells), including full stripes and double-precision values. Own-state readback is transcription integrity, not convergence or cross-state equality.

The five original binary indicators are IVS, ICDP, IAFF, OQI and IURD, in original order. Only saved STER/parameter carriers are loaded, never participant inputs. Existing reviewed four-class analytic math was adapted from six to five items:24native slots,23free coordinates and32theoretical response patterns. All24 class permutations were retained. Probabilities are derived algebraically from stored parameters; these are model-implied theoretical distributions, not posterior respondent assignments, empirical frequencies, a new likelihood evaluation or a refit.

Before either saved model was loaded, a real missing-function fixture RED was observed through Stata MCP, followed by GREEN checks for the32-pattern uniform distribution, identical-class rank5, synthetic nondegenerate rank23, finite-difference verification of all23logit and all23probability-coordinate derivative columns, all24permutations and inverse reference rebases, covariance cross-terms, fixed-base exclusion, indefinite covariance, genuine nonlabel changes, extreme finite logits and relative-rank threshold sensitivity. All fixtures were synthetic and used no research data. The fixed reference intercept is zero by parameterization, not a zero class probability or an equal-share assumption.

## Boundary, derivative and covariance evidence

The table transcribes Stata aggregate strings without recomputing numerical results outside Stata. Unavailable values remain explicitly unavailable, never zero. `standard_error_max` is only the square root of the largest stored variance for conditioning diagnostics, **not a validated standard error or usable inference**.

| Metric | Fresh nonconverged state | Historical target |
|---|---:|---:|
| stored_N | 423 | 423 |
| stored_rank | 22 | 23 |
| stored_converged | 0 | 1 |
| stored_slots | 24 | 24 |
| free_parameters | 23 | 23 |
| stored_ll | -1239.2119213585713 | -1239.8095827772584 |
| stored_gradient_maxabs | 3.2559924634565093e-07 | .0086587757938294749 |
| stored_H_maxabs | unavailable | unavailable |
| minimum_class_weight | .054904887619656367 | .11292668229850217 |
| minimum_item_probability | 1.4348732896336502e-08 | 5.5806849469230563e-08 |
| maximum_item_probability | .99999994098071132 | .99999930129249315 |
| minimum_distance_to_item_boundary | 1.4348732896336502e-08 | 5.5806849469230563e-08 |
| item_boundary_count_1e6 | 4 | 4 |
| variance_min | 0 | .030604554346523694 |
| variance_max | 48628616.966152914 | 12398689.170127485 |
| standard_error_max | 6973.4221847062236 | 3521.1772420779225 |
| maximum_variance_coordinate | 8 | 12 |
| covariance_max_asymmetry | 0 | 0 |
| covariance_eigen_min | 4.3368086899406181e-19 | .012518794081826788 |
| free_covariance_sv_min | 1.0805308253292677e-18 | .012518793901573195 |
| free_covariance_condition | 4.5004377317369606e+25 | 990406046.1105336 |
| free_correlation_condition | unavailable | 522.88421154428761 |
| logit_jacobian_condition | 1051302099.5564386 | 379866982.17216682 |
| probability_jacobian_condition | 281.65368909865992 | 421.73654582492793 |

Both states contain four of20item probabilities within1e-6 of0 or1. The fresh state has a zero stored free-coordinate variance and an extremely ill-conditioned, numerical-rank22 free covariance. Its smallest computed singular/eigenvalue is near numerical zero; the finite condition number must not be interpreted as evidence of a reliably invertible covariance. Fresh free-correlation standardization is unavailable because a free-coordinate variance is zero. The archived covariance also has a large logit-scale condition number, though its variance-normalized correlation condition is522.88421154428761. Both saved covariances are exactly symmetric in the preserved values. The largest native variance is fresh coordinate8 (IVS,4.C) versus archived coordinate12 (ICDP,4.C).

Both states retain a finite stored gradient, but no stored H matrix. Those gradients are read-only saved artifacts, not gradients recomputed at a common objective/normalization or evidence of a valid optimum. In particular the small fresh stored gradient does not override convergence0, prove a stopping criterion, certify KKT conditions or explain why optimization stopped. No unavailable Hessian is reconstructed from the covariance.

## Local mapping and threshold sensitivity

Jacobians map23free coordinates to32theoretical pattern probabilities. In logit coordinates they vary the three nonbaseline class logits and20item logits; in probability coordinates they vary three nonbaseline class weights with the baseline weight offsetting their sum, and20item probabilities. Ranks count singular values greater than the declared relative threshold times the largest singular value. These are **local, scale- and tolerance-dependent** numerical diagnostics, not a proof of global identification, unique classes, stable inference, or statistical equivalence. Full finite-point probability-coordinate rank does not repair the nonconverged state or certify behavior at limiting boundaries.

| State / matrix | Relative1e-8 | Relative1e-10 | Relative1e-12 | Relative1e-14 |
|---|---:|---:|---:|---:|
| replay / free_covariance | 6 | 22 | 22 | 22 |
| replay / logit_jacobian | 19 | 23 | 23 | 23 |
| replay / probability_jacobian | 23 | 23 | 23 | 23 |
| historical / free_covariance | 15 | 23 | 23 | 23 |
| historical / logit_jacobian | 21 | 23 | 23 | 23 |
| historical / probability_jacobian | 23 | 23 | 23 | 23 |

The fresh logit Jacobian loses four directions at relative1e-8 but has23retained columns at the smaller thresholds; the archived logit Jacobian retains21then23. Both probability-coordinate Jacobians retain23at all four thresholds. This is coordinate/threshold sensitivity, not a declaration that the stored optimizer rank should be replaced by a different rank.

## All24 diagnostic label permutations

For each permutation, the fresh class columns are reordered to the indicated historical order for comparison only. The original carriers and unaligned comparison remain immutable. Identity1234 is included; no permutation is silently discarded.

| Fresh-column order | Maximum item-probability difference | Maximum class-weight difference |
|---|---:|---:|
| 1234 | .82934920991936922 | .17505396861300149 |
| 1243 | .82058491612506956 | .57261063416276992 |
| 1324 | .82934920991936922 | .41475375371348167 |
| 1342 | .99999943782167178 | .57261063416276992 |
| 1423 | .99999971738389848 | .41475375371348167 |
| 1432 | .99999971738389848 | .17505396861300149 |
| 2134 | .82934920991936922 | .17505396861300149 |
| 2143 | .81779660946844279 | .57261063416276992 |
| 2314 | .82934920991936922 | .34764373064045212 |
| 2341 | .81779660946844279 | .57261063416276992 |
| 2413 | .99999971738389848 | .34764373064045212 |
| 2431 | .99999971738389848 | .17505396861300149 |
| 3124 | .83404601932086764 | .41475375371348167 |
| 3142 | .99999943782167178 | .57261063416276992 |
| 3214 | .83404601932086764 | .34764373064045212 |
| 3241 | .83404601932086764 | .57261063416276992 |
| 3412 | .99999971738389848 | .34764373064045212 |
| 3421 | .99999971738389848 | .41475375371348167 |
| 4123 | .9999982015989749 | .41475375371348167 |
| 4132 | .99999943782167178 | .17505396861300149 |
| 4213 | .9999982015989749 | .34764373064045212 |
| 4231 | .9999982015989749 | .17505396861300149 |
| 4312 | .99999943782167178 | .34764373064045212 |
| 4321 | .9999982015989749 | .41475375371348167 |

## Permutation-invariant and reference-rebased checks

| Diagnostic | Value |
|---|---:|
| closest_permutation_index | 8 |
| closest_permutation_maxdiff | .81779660946844279 |
| theoretical_pattern_maxdiff | .0078748915077316781 |
| theoretical_pattern_total_variation | .033876661566187169 |
| diagnostic_rebased_logit_maxdiff | 18.086827571093501 |
| diagnostic_rebased_covariance_maxdiff | 48628616.919756666 |

The32-pattern differences are permutation invariant under the model's conditional-independence map. Total variation is one half of the summed absolute theoretical-pattern differences, not an observed-data discrepancy test or a statistical acceptance criterion. The reference-rebased coefficients use an exact linear reference-class transformation; covariance is transformed by congruence using the same matrix. The substantial residual coefficient/covariance differences after that transformation are not erased by profile alignment, a higher nonconverged likelihood or identical native coordinate labels. No tolerance-based equivalence threshold or preferred-model decision is introduced.

## Preservation, audit and closure boundary

Preserve1033 unrelated tracked files and18514 preceding private files, predecessor seal/proofs and exact public entry snapshots. Four mutable tracker references in the preceding seal are checked against their entry snapshots; the preceding seal itself is not edited. No production code, source data, historical target, previous model, manuscript/main.tex, qualitative content or legacy comparison is changed. Public changes are limited to this report, its aggregate CSV, the three governance trackers and workflow state. Schema125 preserves all2038prior pointers and adds ten, total2048. Existing scientific/release gates and preferred-model state remain unchanged.

The no-fit guard checks the pinned reviewed executable graph, including case/prefix variants, exact reserved dependencies, malformed strings, cycles and forbidden fitting/prediction/external dispatch. It is **not a general Stata/Mata sandbox** or a claim about arbitrary hostile programs. Six authentic Stata MCP events bind entry inventory, missing-function RED, GREEN fixtures, saved-state diagnostics, worker destruction and identical final inventory. All three selection bodies restore empty state/maxvar5000 and close their logs.

Technical closure requires selected software tests, fresh independent final review with scope rulings, fresh actual post-review audit, authenticated final execution, sealing, separate saved-only verification and their original execution proofs. A review PASS or technical closure does not grant scientific/exact-replication acceptance or authorize another fit, corrections, model selection, release, commit/push or cloud/Overleaf synchronization. Earlier closed live-event test epochs are not rerun; original sealed evidence remains preserved.

## Next immediate task

**M6.08.37.R2 — protected original M4 four-class candidate-disposition and reporting contract, without fitting.** Carry forward nonconvergence0/rank22, raw555-cell discrepancy, the diagnostic residuals, near-boundary/conditioning evidence and derivative limitations. Do not declare a preferred model, change historical reporting flags, calculate posterior allocations, fit again or replace existing source/manuscript content.
