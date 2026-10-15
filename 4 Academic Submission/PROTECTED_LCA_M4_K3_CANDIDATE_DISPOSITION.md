# Protected original M4 three-class candidate disposition and reporting contract

## Disposition

**M6.08.36.R2: RETAIN_HISTORICAL_CANDIDATE_EXACT_REPLICATION_HELD_WITH_APPROXIMATE_LABEL_ALIGNMENT.**

Retain M4_k3 as an original converged five-binary historical candidate, while holding exact numerical replication and scientific use unaccepted. Its historical reporting flag remains0; this disposition neither changes eligibility nor selects a preferred model. The separately preferred final H1_k4 refit remains unchanged and is not newly validated here.

This is a metadata-transcription and reporting-contract workflow: **zero Stata calls, fits, retries, new numerical diagnostics, predictions, respondent-data loads or exports**. Numerical evidence is transcribed from the sealed replay and R1 diagnostics, not recomputed in another language. The [22-statement reporting contract](lca-m4-k3-candidate-disposition/reporting_contract.csv) distinguishes **RETAIN**, **HOLD** and **EXCLUDE**; RETAIN means retain the recorded historical fact, not scientific acceptance.

## Historical candidate and original replay

The M4 family uses five binary indicators: IVS, ICDP, IAFF, OQI and IURD. Neither IEDF nor ICPF enters this family. Source eligibility lines6947–6951 and the original three-class block at6972–6987 remain unchanged: seed6432003,300 random-id starts, difficult and5000 iterations. Historical complete-case N423, command rc0 and convergence1 are retained. The sole authorized original-specification replay also recorded N423, convergence1, rank17 and18 native coefficient slots, with no refit or posterior predictions.

The original unaligned native comparison remains **349 records:42 exact matches,307 differences and zero stripe mismatches**. Its coefficient maximum difference13.97702347509373 and covariance maximum difference390640.5812158377 are not replaced by transformed diagnostics. Both saved-state carriers passed exact349-record verification against their respective saved estimates in the preserved replay/R1 workflows; that is earlier authenticated evidence, not a new native readback performed here.

## Diagnostic alignment, residuals and reporting limits

The closest diagnostic replay-column order is **132** in historical class order: retain replay class1 and exchange classes2/3. All six permutations were compared. The reference-intercept transformation and full signed covariance mapping were evaluated in R1, without overwriting either saved state or the original native comparison.

| Preserved R1 diagnostic | Value |
|---|---:|
|Closest-order item-probability maximum difference|.00011502622828807318|
|Closest-order class-weight maximum difference|.0001260383803388665|
|Rebased coefficient maximum residual|.2037092127247444|
|Rebased covariance maximum residual|63975.437705974211|
|Maximum probability difference across32 theoretical response patterns|.000012485941726952943|
|Total variation across32 theoretical patterns|.00004045863845537304|

These residuals are nonzero. Theoretical pattern probabilities describe the mathematical model support, not respondent predictions, empirical pattern counts or a new likelihood evaluation. Close probability distributions do not establish identical logits, covariance matrices, inferential stability or exact numerical replication. No tolerance or approximate-acceptance rule is introduced.

The first class-membership intercept is fixed to zero as the reference. All three class weights depend on the two free membership intercepts; this normalization does not fix any class probability to zero, one third or another constant. The18 native slots contain17 free coordinates.

Both saved distribution Jacobians, free covariance and standardized free-correlation matrices have numerical rank17 at relative singular-value thresholds1e-8,1e-10,1e-12 and1e-14. These are conditional local numerical facts under the assumed model, not proof of structural/global identification, global optimality or stable statistical inference. All-six permutation/reference/covariance invariance was tested in controlled fixtures; invariance of the actual fitted replay distribution was asserted for the closest ordering only. Fixture coverage must not be restated as all-six actual-state invariance checks.

Each state has one item probability within1e-4 of a boundary and none within1e-6 or1e-8. Minimum class weights are.16730634892293059 historical and.1671835953892031 replay. Maximum coefficient variances are326665.26601178787 and390640.70371776208, with maximum standard errors571.54638133032381 and625.01256284794954. Free covariance condition numbers are22013516.855643351 and26320124.040844213. Logit-map Jacobian conditioning is3568434.1999992975 and4374484.3073601723, versus118.53221837607605 and118.51206625366954 in probability coordinates. Thus local full rank coexists with boundary-sensitive logit behavior and large uncertainty; neither is silently interpreted as a finding of nonidentification or as harmless rounding.

Both states retain finite1-by-18 stored gradients, with maximum absolute entries.001561489766605903 historical and.0094785085740060199 replay. Stored H is **UNAVAILABLE** in both states. It is not zero-filled, reconstructed by covariance inversion or evaluated anew. The distinct recorded likelihoods remain historical-1241.3004908011901 and replay-1241.3004913276156. No new convergence threshold is imposed and optimality is not certified.

## Original reporting screen and archival context

The unmodified source at lines7033–7037 defines the historical flag as:

```stata
converged == 1 & inlist(k, 4, 5) & min_class_pct >= 5 & entropy >= 0.60
```

This displayed source expression is documentary only and is not executed here. M4_k3 has archival entropy.6456793752977756, minimum class count104 and minimum class percentage24.58628841607565, but k3 is outside the permitted k4/k5 set. Its reporting flag0 therefore must not be described as nonconvergence, tiny-class failure, universal scientific invalidity or a new rejection based on BIC.

| Original M4 grid candidate | Archived convergence | Archived reporting flag | Archived minimum class count | Archived AIC | Archived BIC |
|---|---:|---:|---:|---:|---:|
|M4_k2|1|0|111|2513.616880680292|2558.137974649801|
|M4_k3|1|0|104|2516.60098160238|2585.406308646167|
|M4_k4|1|1|42|2525.619165554516|2618.70872567258|
|M4_k5|0|0|unavailable|unavailable|unavailable|

The [five-row candidate context](lca-m4-k3-candidate-disposition/candidate_context.csv) preserves the complete archival M4-family rows plus the initial H1_k4 grid row, with explicit evidence-status and context-scope fields. These are **ARCHIVAL_GRID_ONLY_NOT_FRESH_FIT_OR_ACCEPTANCE** values. Replay information criteria, reporting flag, entropy, posterior summaries and class sizes remain **NOT_RECOMPUTED**. Historical diagnostics are not fresh replay outputs, and context is not a new ranking.

M4_k5 retains archived rc0/convergence0 and blank likelihood, df, information criteria, entropy, posterior, class-size and small-class-flag fields. A zero return code is not convergence; blank failed-candidate fields are not zero. Stata numeric missing values sort above finite numbers, so the original size/entropy inequalities alone are not explicit nonmissing checks. Preserve that screen caveat without repairing the historical code in this reporting-only node.

## Separate preferred-model provenance

The H1_k4 row is explicitly **INITIAL_H1_GRID_NOT_FINAL_PREFERRED_REFIT**. The original final preferred H1_k4 block at8804–8832 is pinned separately: seven mixed indicators, stable KEY ordering, seed6529004, four classes and600 starts/8000 iterations. That block is not run, recomputed, selected anew or validated here.

M4 and H1 have different outcome/feature structures. Do not use their absolute AIC/BIC values as a common cross-feature ranking. The historical reporting screen, archival information criteria and separately chosen H1_k4 provenance are distinct pieces of evidence, not interchangeable model-selection rules.

## Protected implementation and completion gates

The restricted packet is `audit-local/intake/lca-m4-k3-disposition-6829388`. It preserves authenticated owner authority, both predecessor seals and their actual external execution proofs, original source windows, separate preferred-model provenance, immutable saved catalogue/target pins, full134-row R1 diagnostic evidence, five context rows and22 reporting statements. All original source, data, estimates, numerical differences, earlier packets and failed attempts remain untouched.

Entry protection covers **1026 other tracked files and18348 earlier private artifacts**, plus exact entry snapshots of the four changing public trackers. The previous replay seal's tracker references are verified against the matching R1 entry snapshots; neither earlier seal is rewritten. The current no-dispatch guard rejects every Stata tool call, including inventory calls. No executable adapter is dispatched in this task.

The R1 dependency guard is already hardened for its pinned reviewed diagnostic grammar. It is not a general Stata/Mata sandbox, and this node makes no claim of fresh guard execution or safety for arbitrary future programs. The next adapter must establish its own reviewed source/dependency graph and runtime preflight.

Only seven public-facing documentation/aggregate paths are prepared locally. Schema122 preserves all2010 prior workflow pointers and adds ten. Owner verification, one fresh independent final review, a genuine post-review final audit bound to its actual exit-zero execution and source fingerprints, an exclusive seal, separate saved-only verification and external execution proofs govern technical closure. Passing these gates does not grant scientific acceptance, model selection or protected-data release authority. No staging, commit, push, cloud synchronization or manuscript modification is included.

## Next immediate task

**M6.03.38 / M6.05.38 — protected original M4 four-class candidate adapter and native-capture preflight, without fitting.**

This handoff pins seed6432004 at6989, the original estimator at6991–7001 and lca_record at7002–7004: four classes,500 random-id starts, difficult and7000 iterations. The archived M4_k4 target metadata is N423,24 native slots, rank23,607 native records and saved convergence1. Its saved target and model31 native carrier are fingerprinted as immutable inputs. These are source/catalogue facts, not a completed new adapter, fresh own-state readback, replay, acceptance or fit approval.

The next task must preserve this contract, every earlier packet and the historical reporting restriction. No fitting or further analytical/publication authority transfers from this disposition.
