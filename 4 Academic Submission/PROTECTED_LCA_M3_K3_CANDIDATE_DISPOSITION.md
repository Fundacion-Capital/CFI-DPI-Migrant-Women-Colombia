# Protected original M3 three-class candidate disposition and reporting contract

## Scope and authority

M6.08.32.R2 is a reporting-only disposition of the preserved original M3_k3 candidate, its one bounded replay and its saved-state diagnostics. It authorizes no Stata call (including inventory), fit, prediction, participant-data load/export, statistical recomputation, estimator change, target substitution, tolerance widening, scientific acceptance or public release. The entry checkpoint is main at 0818b0959b9f4fa2a83a9a76c657046fc541594b. The historical hybrid H1_k4 preference remains unchanged and is not revalidated here.

The protected packet is audit-local/intake/lca-m3-k3-disposition-0818b09. Sources are the sealed replay lca-m3-k3-replay-450e60c, diagnostics lca-m3-k3-diagnostics-63cd833, original analysis code and preserved native catalogue/grid. The original analysis code hash is 714377CA31DE2B6D70DB0994E3C7EF6A38374165D7B1FB7C7ABEB3B3F56549C9. Only aggregate quantities are reproduced.

The replay seal includes four public trackers later advanced by R1; their original bytes are checked against R1's sealed entry-public snapshots. Other replay artifacts and the complete R1 seal are checked directly. Neither historical seal is rewritten. Current entry preservation covers 991 unrelated tracked paths and 17,429 prior private files.

## Candidate ruling

**RETAIN_HISTORICAL_CANDIDATE_EXACT_REPLICATION_HELD_WITH_APPROXIMATE_LABEL_ALIGNMENT.**

Retain M3_k3 as an archived, converged three-class candidate with a successful bounded original-specification replay and separate evidence of approximate class alignment. Keep exact numerical replication and scientific acceptance on hold. Do not call this candidate the selected final model, globally identified/optimal, scientifically validated, robust, or approved for substantive profiling.

M3 uses six binary indicators: IVS, ICDP, IAFF, OQI, IURD and IEDF harm. ICPF trust climate is excluded from class definition. The original complete-case window is lines6860–6866 and candidate window6886–6902: seed6431003, three classes, random-id starts with300 draws, difficult optimization and5,000 maximum iterations. The original command and immediate return-code capture are unchanged.

| Preserved evidence | Historical state | Bounded replay |
|---|---:|---:|
| Sample size | 423 | 423 |
| Stored convergence | 1 | 1 |
| Stored rank / coefficient slots | 20 / 21 | 20 / 21 |
| Saved-state log likelihood (R1 readback) | -1448.5552859408006 | -1448.555285566061 |
| Native comparison | Original reference target | 469 cells:48 exact,421 differing; zero stripe mismatches |
| Saved Hessian | UNAVAILABLE | UNAVAILABLE |

The historical catalogue/grid stores likelihood -1448.555285940801; R1's saved-state readback preserves finer displayed precision. These source strings are retained, not silently standardized. Both native469 carriers exactly match their own saved states. Own-state capture integrity is not a cross-state equality finding.

The original coefficient maximum difference is18.68252962384962 and covariance maximum difference4930885.670333427. These remain immutable historical comparison results. Close likelihoods do not negate them.

## Diagnostic class alignment and residual discrepancy

The first class-membership intercept is fixed to zero as the reference. The two free membership intercepts determine all three weights; no class probability is fixed by that normalization.

R1 compared all six class orders. The closest order is **replay classes3–2–1 in historical order**. The diagnostic transformation permutes item logits, subtracts the new reference membership intercept from the other two, and transforms covariance as A V A'. It changes neither stored state nor original targets.

| R1 diagnostic comparison | Maximum absolute difference |
|---|---:|
| Identity-labelled item probabilities | .83416286518843041 |
| Identity-labelled class weights | .2027926274982588 |
| Closest-order item probabilities | .000044056196158770433 |
| Closest-order class weights | .000051910276754163487 |
| Closest-order reference-rebased logits | .46646684679054573 |
| Closest-order reference-rebased covariance entries | 756542.84691238357 |
| Probabilities across64 theoretical binary response patterns | 7.9165267481973167e-06 |
| Pattern-distribution total variation | .000027453296239728992 |

All values are transcribed from sealed R1 outputs, not new calculations or acceptance thresholds. The R1 outcome remains **RESIDUAL_PARAMETER_DISCREPANCY**. Close aligned pattern distributions do not erase residual logit/covariance differences, validate standard errors, or establish substantive class interpretation.

All six reference-intercept and covariance transformations passed controlled fixtures. The actual fitted replay's distribution-preservation assertion covers the closest ordering only. Fixture coverage must not be presented as an actual-state invariance assertion for every permutation.

## Identification, boundaries and numerical uncertainty

Both saved distribution Jacobians have numerical rank20 at relative thresholds1e-8,1e-10,1e-12 and1e-14. This is fitted-point, coordinate- and threshold-qualified local evidence under the assumed model. It is not proof of global identification, global optimality, measurement validity or a suitable number of classes.

| Preserved R1 diagnostic | Historical | Replay |
|---|---:|---:|
| Logit Jacobian condition number | 42699619.976932265 | 56526625.526555926 |
| Probability Jacobian condition number | 25.015785293471637 | 19.157993249216208 |
| Free covariance condition number | 503458921.54509938 | 454637017.57772231 |
| Free correlation condition number | 33.07055928294551 | 42.610502305342969 |
| Largest logit standard error | 2043.1208780525792 | 2220.5597873614493 |
| Smallest class weight | .14891481466168346 | .14891106975287055 |
| Smallest item probability | 1.8825331951129363e-07 | 1.1807520163166196e-07 |
| Largest item probability | .99999997418092645 | .99999997814660224 |
| Stored gradient maximum absolute value | .0013212870795298766 | .0028861182066405636 |

Free covariance numerical rank is14 at relative1e-8 but20 at the three tighter thresholds in both states. Free correlation rank is20 at all four. This scale/threshold sensitivity is not an invariant rank14 finding or a universal singularity verdict.

Each state has zero item probabilities within1e-8 of a boundary and three within1e-6 and1e-4. Boundary proximity and large logit uncertainty are retained warnings. Class weights near0.149 are not vanishing classes. The markedly better probability-coordinate conditioning does not justify discarding the logit/covariance warnings.

Both stored gradients are finite1x21. Both saved H matrices are absent; H maxima remain unavailable/blank. No fresh scores, derivative evaluation or Hessian reconstruction occurred. UNAVAILABLE must not become zero or evidence of good conditioning.

## Archival grid and original reporting screen

[candidate_context.csv](lca-m3-k3-candidate-disposition/candidate_context.csv) preserves the five original rows M3_k2, M3_k3, M3_k4, M3_k5 and initial-grid H1_k4, including every original string and blank. Added context labels explicitly mark archival evidence rather than fresh fitting or acceptance.

| Archival M3 candidate | Converged | Original reporting flag | AIC | BIC | Minimum class count |
|---|---:|---:|---:|---:|---:|
| M3_k2 | 1 | 0 | 3003.594752768724 | 3056.210591096326 | 103 |
| M3_k3 | 1 | 0 | 2937.110571881602 | 3018.058015462528 | 71 |
| M3_k4 | 1 | 1 | 2936.734501678432 | 3046.013550512681 | 65 |
| M3_k5 | 0 | 0 | unavailable | unavailable | unavailable |

Original lines7033–7037 require convergence1, k in{4,5}, minimum class percentage>=5 and entropy>=0.60. This mechanically excludes the two- and three-class candidates, regardless of archived BIC. It is not BIC minimization or a universal scientific-validity rule. The original screen lacks explicit missing-value guards; Stata numeric missing values compare above finite thresholds. That caveat remains documented and unrepaired.

M3_k3 has the lowest archived BIC among these M3 rows, while M3_k4 has the lowest archived AIC. These are descriptions of the preserved grid, not new rankings or a recommendation to change the selected model. M3_k3's archived entropy .7134238790011558, average maximum posterior .869981223597818, minimum class count71 and minimum class percentage16.78486997635934 are not fresh replay outputs.

M3_k5 has rc0 but convergence0 and blank likelihood, information-criterion, entropy, posterior and class-size fields. Command success is not convergence; blanks are not zero. No fresh evaluation of that candidate occurs here.

Initial-grid H1_k4 is distinct from the separately selected final preferred H1_k4 refit in source lines8804–8832. Do not rank six-binary M3 against seven-mixed H1 by absolute AIC/BIC as though the feature/likelihood structures were identical. The final historical H1 preference remains unchanged.

Replay information criteria, entropy, posterior maximums, class sizes and report_candidate are **NOT_RECOMPUTED**.

## Claim-by-claim reporting contract and validation

[reporting_contract.csv](lca-m3-k3-candidate-disposition/reporting_contract.csv) contains21 rules:12 RETAIN,2 HOLD and7 EXCLUDE. They distinguish archival facts, bounded execution, diagnostic alignment, numerical identity, conditional identification and scientific acceptance. Omitted rules, weakened boundary/rank/invariance qualifications and future-fit transfers are rejected by tests.

Validation requires source/target/private preservation, exact source windows, private/public table agreement, zero post-authority Stata calls, seven-path public scope, schema109/ten additive pointers, observed negative tests, one actual independent review, fresh post-review checks bound to actual completed exit-zero execution and source/receipt hashes, an exclusive seal and separate saved-only verification.

Technical reporting closure is not statistical, scientific, class-selection or release acceptance. No manuscript, production analysis, qualitative, literature, Git, cloud or Overleaf action is included.

## Next immediate task

**M6.03.34 / M6.05.34 — protected original M3 four-class candidate adapter and native-capture preflight, without fitting.**

The original source window is lines6904–6920: seed6431004, four classes,500 random-id draws, difficult optimization, iterate(7000), immediate return-code capture and M3_k4 recording. Its catalogue records N423,28 coefficient slots, rank27, convergence1 and819 native target records.

The original target hash is9157A5BB1491672A2767859EFE272D8CEE46913EB5C2DC1D3F086B1EEAA2790B; native CSV hash3881C7D6B2C5B7AB821182BE04792F4D7ECBDB45A5A44E2859698D850FEB560D. The preserved target and capture are pinned during this reporting intake, not newly decoded.

This handoff authorizes zero fits. M3_k4 needs its own adapter, runtime and native-capture validation. Neither M3_k3 alignment nor its convergence, warnings, disposition or scientific status transfers to the four-class candidate.

