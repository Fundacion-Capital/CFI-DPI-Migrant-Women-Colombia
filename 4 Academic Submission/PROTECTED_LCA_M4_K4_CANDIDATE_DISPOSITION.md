# Original M4 four-class candidate disposition and reporting contract

## Disposition

**M6.08.37.R2 — retain the archival eligible candidate; keep the nonconverged fresh replay diagnostic-only; hold exact replication and scientific use.**

The archived M4_k4 candidate retains its original convergence flag **1** and historical `report_candidate = 1`. The original-specification replay retains convergence **0** and stored rank **22**. These are distinct records: historical reporting eligibility cannot be transferred to the fresh nonconverged state. Fresh reporting is excluded by the observed failure of the original convergence condition; this is not a newly calculated reporting flag or a claim that the model family is intrinsically invalid.

This is a metadata-transcription and reporting-contract task: **zero Stata calls, fits, retries, new numerical diagnostics, predictions, respondent-data loads or exports**. All numerical values below come from the sealed replay, saved catalogue or R1 diagnostics, not calculations in another language. The [24-statement reporting contract](lca-m4-k4-candidate-disposition/reporting_contract.csv) distinguishes **RETAIN**, **HOLD** and **EXCLUDE**. RETAIN means preserve a recorded fact, not accept the candidate scientifically.

## Historical specification and preserved replay

The M4 family uses five binary indicators, in original order: **IVS, ICDP, IAFF, OQI and IURD**. IEDF and ICPF do not enter this family. The original complete-case sample definition at source lines 6947–6951 and four-class block at 6989–7004 remain unchanged: seed 6432004, 500 random-id starts, `difficult`, and 7,000 iterations.

| Recorded status | Archived target | Original-specification replay |
|---|---:|---:|
| Complete-case / saved N | 423 | 423 |
| Command return code | 0 | 0 |
| Convergence | 1 | **0** |
| Stored rank | 23 | **22** |
| Native slots / free coordinates | 24 / 23 | 24 / 23 |
| Reporting flag | 1, archival | **NOT_RECOMPUTED** |
| Information criteria | Archival only | **NOT_RECOMPUTED** |
| Entropy, posterior summaries and class sizes | Archival only | **NOT_RECOMPUTED** |

A command return code of zero is not convergence. Exactly one fit belongs to the preceding authorized replay; none belongs to this task. Its original 300-second transport timeout remains a timeout, not transport success. Durable completion evidence and subsequent diagnostic readback did not change that transport outcome or promote the withheld strict converged carrier.

The original unaligned native comparison remains **607 cells: 52 exact matches, 555 differences and zero stripe mismatches**. The coefficient and covariance maximum absolute differences remain **18.28239156688288** and **48628614.7565937**. No transformed comparison replaces these values. Both carriers were verified against their own saved estimates across 607 records in earlier authenticated workflows; those checks establish faithful readback, not cross-state equality, convergence or a new readback in this reporting-only task.

## Diagnostic residuals and permissible interpretation

R1 checked all 24 class permutations. The closest diagnostic fresh-column order is **2143** in historical order: fresh classes 2, 1, 4, 3 are compared with historical classes 1, 2, 3, 4. The criterion minimizes the maximum discrepancy across the combined class-weight/item-probability matrix; the first lexicographic tied minimum is retained. It is not a substantive naming rule, a recoding of saved states, or an acceptance tolerance.

| Preserved R1 diagnostic | Value |
|---|---:|
| Closest-order maximum item-probability difference | .81779660946844279 |
| Closest-order maximum class-weight difference | .57261063416276992 |
| Reference-rebased logit maximum residual | 18.086827571093501 |
| Reference-rebased covariance maximum residual | 48628616.919756666 |
| Maximum probability difference across 32 theoretical patterns | .0078748915077316781 |
| Total variation across 32 theoretical patterns | .033876661566187169 |

**The discrepancy is not explained solely by class-label permutation.** These residuals remain diagnostic evidence, not a declaration of statistical equivalence or a new tolerance-based approximation. Theoretical response-pattern probabilities describe the mathematical model support, not empirical frequencies, respondent posterior assignments, or a newly evaluated likelihood.

The first class-membership intercept is fixed to zero as the reference. All four class weights depend on the three free membership intercepts; this normalization does not fix a class probability to zero, one quarter or any other constant. The 24 native slots therefore contain 23 free coordinates. R1's permutation/reference/covariance fixtures remain previous evidence; this task neither reruns them nor expands their claims.

## Nonconvergence, conditioning and identification restrictions

The fresh state has a **zero stored free-coordinate variance**, covariance condition number **4.5004377317369606e+25**, and numerical covariance ranks **6, 22, 22, 22** at relative singular-value thresholds 1e-8, 1e-10, 1e-12 and 1e-14. Its smallest computed covariance singular value is 1.0805308253292677e-18. That tiny positive value and finite computed condition number do **not** establish a reliably invertible covariance. Fresh variance-normalized free-correlation diagnostics are **UNAVAILABLE** because a free-coordinate variance is zero.

The historical target also needs qualification: covariance condition **990406046.1105336**, ranks **15, 23, 23, 23** at the same thresholds, and standardized free-correlation condition **522.88421154428761**. The historical convergence flag remains intact, but it is not newly validated scientific inference.

Both states have four of 20 item probabilities within 1e-6 of zero or one. Minimum class weights are .054904887619656367 fresh and .11292668229850217 historical. Boundary/logit scaling and covariance conditioning remain warnings, not proof of structural nonidentification or intrinsic invalidity.

| Local numerical Jacobian rank | Relative 1e-8 | Relative 1e-10 | Relative 1e-12 | Relative 1e-14 |
|---|---:|---:|---:|---:|
| Fresh, logit coordinates | 19 | 23 | 23 | 23 |
| Historical, logit coordinates | 21 | 23 | 23 | 23 |
| Fresh, probability coordinates | 23 | 23 | 23 | 23 |
| Historical, probability coordinates | 23 | 23 | 23 | 23 |

These are local, coordinate- and threshold-dependent diagnostics under the five-binary model. Full finite-point probability-coordinate rank does not establish global identification, unique classes, stable inference or repaired convergence. Do not replace the stored optimizer rank with a Jacobian rank or interpret the nonconverged covariance as usable standard errors. The reported square roots of maximum stored variances are conditioning diagnostics only.

Both saved gradients are finite 1-by-24 matrices: maximum absolute entries **3.2559924634565093e-07** fresh and **.0086587757938294749** historical. Stored H is **UNAVAILABLE** in both states. The small fresh saved gradient does not override convergence 0, certify KKT conditions or a valid optimum, or explain the optimizer's stopping reason. No common-objective gradient was evaluated and no Hessian was reconstructed by covariance inversion.

The complete [164-row R1 diagnostic table](lca-m4-k4-diagnostics/diagnostics_summary.csv) remains unchanged and is retained verbatim in the protected reporting contract. This includes every permutation, threshold and explicit unavailable value, not just the selected values above.

## Original reporting screen and archival context

The unchanged source at lines 7033–7037 defines the historical reporting screen as:

```stata
converged == 1 & inlist(k, 4, 5) & min_class_pct >= 5 & entropy >= 0.60
```

This is displayed source documentation, not code executed here. Historical M4_k4 satisfies that recorded screen: convergence 1, four classes, minimum class count **42**, minimum class share **9.929078014184398**, and entropy **.6683475877114229**. Its average maximum posterior is **.7699185951380648**, with `small_class_flag = 0`. These are archival diagnostics, not fresh predictions. Neither `small_class_flag` nor a separate minimum-count threshold is an additional condition in the displayed expression.

| Original grid candidate | Archived convergence | Archived reporting flag | Minimum class count | Archival AIC | Archival BIC |
|---|---:|---:|---:|---:|---:|
| M4_k2 | 1 | 0 | 111 | 2513.616880680292 | 2558.137974649801 |
| M4_k3 | 1 | 0 | 104 | 2516.60098160238 | 2585.406308646167 |
| M4_k4 | 1 | 1 | 42 | 2525.619165554516 | 2618.70872567258 |
| M4_k5 | 0 | 0 | unavailable | unavailable | unavailable |

The [five-row context table](lca-m4-k4-candidate-disposition/candidate_context.csv) retains all original M4-family rows and the initial H1_k4 grid row, with explicit archival status and context-scope fields. The screen is not BIC minimization, a universal validity rule, a fresh ranking or permission to report the nonconverged replay.

Stata numeric missing values sort above finite values. The original size/entropy inequalities lack explicit nonmissing guards. Preserve that caveat without repairing the historical code here; M4_k4's relevant archived values are populated, so the caveat does not erase its actual flag 1. M4_k5 retains rc 0, convergence 0, reporting flag 0 and blank likelihood, degrees of freedom, criteria, entropy, posterior and class-size fields. Blanks remain unavailable, never zero or ranking values.

## Separate preferred-model provenance

The included H1_k4 context row is **INITIAL_H1_GRID_NOT_FINAL_PREFERRED_REFIT**. The separate original final preferred block at lines 8804–8832 uses seven mixed indicators, stable KEY ordering, seed 6529004, four classes and 600 starts / 8,000 iterations. It remains pinned and unchanged, not rerun, newly selected or validated here.

M4 and H1 use different outcome/feature structures. Their absolute AIC/BIC values must not be treated as a common cross-feature model ranking. Archival grid eligibility, information criteria and final preferred-refit provenance remain separate evidence. This task does not change the historical preferred model.

## Protection, implementation and completion gates

The protected packet is `audit-local/intake/lca-m4-k4-disposition-4ce20a3`. It retains authenticated owner authority, both predecessor seals and actual external execution proofs, original source windows, separate preferred-model provenance, immutable catalogue/target pins, all 164 R1 rows, five archival context rows and 24 reporting statements. Every earlier packet, failure, saved estimate, original source and data artifact remains untouched.

The no-dispatch check rejects every Stata tool call, including inventory calls. The preceding R1 dependency guard remains purpose-bound to its pinned reviewed executable graph, not a general hostile-program Stata/Mata sandbox; this node makes no new runtime-safety claim.

Exactly seven public documentation/aggregate paths are updated locally. Schema 126 preserves all 2,048 prior workflow pointers and adds ten. Technical closure requires selected software suites, preservation checks, one independent final review, fresh actual post-review validation, authenticated execution binding, sealing, separate saved-only verification and external proof checks. No scientific/exact acceptance, usable inference, release authority, production-code change, manuscript edit, staging, commit, push or cloud synchronization is included.

## Next immediate task

**M6.03.39 / M6.05.39 — protected original M4 five-class failed-candidate source/runtime/reporting intake and nonconvergence-aware adapter preflight, without fitting.**

The original source pins seed **6432005** at line 7006, estimator lines **7008–7018**, and recording lines **7019–7021**: five classes, five binary indicators, 500 random-id starts, `difficult`, and 7,000 iterations. The original complete-case definition is unchanged. The archived row has N 423, rc 0, convergence 0, reporting flag 0 and unavailable fit/posterior metrics. The frozen intake has no original M4_k5 saved estimate or native target, so the next task must not invent a target or treat absent metrics as zero.

This handoff grants **zero fits**. The next node must establish its own reviewed source/dependency graph, runtime and nonconvergence-aware capture contract. No fit, retry, posterior allocation, preferred-model change or publication authority transfers from this disposition.
