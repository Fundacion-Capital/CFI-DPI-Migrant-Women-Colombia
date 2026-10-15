# Original M4 three-class saved-state diagnostics

## Result and boundary

M6.08.36.R1 completed saved-state numerical-discrepancy and identification/class-parameterization diagnostics without fitting. Classification: **RESIDUAL_PARAMETER_DISCREPANCY**. A class-label swap explains much of the apparent profile difference, but does not eliminate the numerical differences. This diagnostic result is not exact replication, scientific acceptance, proof of stable/global identification, model selection, authorization to relabel historical outputs or permission to publish protected materials.

The original M6.04.37 / M6.08.36 unaligned comparison remains unchanged: 349 native records, 42 exact matches, 307 differences, no stripe mismatch, maximum coefficient difference 13.97702347509373 and maximum covariance difference 390640.5812158377. No matching tolerance has been introduced.

## Scope and source fidelity

Only the preserved historical M4_k3.ster and the sealed single-replay fit_state.ster, plus their own native carriers, were read. Each carrier matched its own saved state exactly across all 349 metadata/coefficient/covariance records. Both states retain N423, convergence1, rank17 and 18 native slots: one fixed reference-class coordinate, two free class-membership intercepts and 15 item logits for five binary indicators (IVS, ICDP, IAFF, OQI and IURD). The original source, row order, measurement, estimator specification, starts, seeds, results and earlier packets were not modified.

All numerical calculations were made through Stata MCP and Mata. The 32 theoretical binary response patterns enumerate the model's mathematical support, not observed respondent records, empirical likelihood evaluations or participant-level predictions. There was no fit, retry, optimization, respondent-data load, posterior classification or respondent export. Stored model estimates were read, not overwritten.

## Class parameterization and probability-space comparison

All six permutations were evaluated. The permutation maps replay columns into historical column order. The closest is **132**: retain replay class1 and exchange classes2/3. Selection minimizes the largest absolute difference across class weights and item-response probabilities, with deterministic lexicographic tie handling. It is a diagnostic alignment, not a class-profile relabelling or an acceptance threshold.

| Replay-column order | Maximum item-probability difference | Maximum class-weight difference |
|---|---:|---:|
|123|.85256311617414393|.064240649754866402|
|132|.00011502622828807318|.0001260383803388665|
|213|.85245554446419369|.43408581054379669|
|231|.78507926123858396|.43408909539040808|
|312|.65931645310613529|.36997119916926918|
|321|.85256311617414393|.43408909539040808|

The theoretical response-pattern distributions differ: maximum absolute probability difference **.000012485941726952943** and total variation **.00004045863845537304**. After diagnostic reference-class rebasing of logits and the full signed covariance transformation A V A', maximum coefficient difference remains **.2037092127247444** and maximum covariance difference remains **63975.437705974211**. Neither is zero. These transformed diagnostics never replace the original unaligned comparison.

## Boundary behavior and numerical identification diagnostics

| Diagnostic | Historical saved state | Replay saved state |
|---|---:|---:|
|Minimum class weight|.16730634892293059|.1671835953892031|
|Minimum item probability|.076420718944063062|.076420376544144519|
|Maximum item probability|.99999523076078889|.99999610973038922|
|Nearest item-boundary distance|4.7692392111109427e-06|3.8902696107845358e-06|
|Item probabilities within 1e-4 of a boundary|1|1|
|Item probabilities within 1e-6 / 1e-8|0 / 0|0 / 0|
|Largest coefficient variance|326665.26601178787|390640.70371776208|
|Largest standard error, logit scale|571.54638133032381|625.01256284794954|
|Free covariance condition number|22013516.855643351|26320124.040844213|
|Free correlation condition number|246.44326622337385|255.60665564260557|
|Logit-map Jacobian condition number|3568434.1999992975|4374484.3073601723|
|Probability-map Jacobian condition number|118.53221837607605|118.51206625366954|
|Stored gradient maximum absolute entry|.001561489766605903|.0094785085740060199|

The largest variances are at historical native coordinate15 and replay coordinate14: OQI class3 and class2 respectively in the preserved stripes, consistent with the diagnostic 132 swap. The near-boundary item probabilities and much poorer logit-scale than probability-scale conditioning are consistent with substantial logit/covariance sensitivity despite close fitted response-pattern probabilities. This is a saved-state numerical interpretation, not a proven exclusive explanation of the discrepancy or an invitation to change estimation settings.

For both saved states, the 17-column analytic logit-map and probability-map Jacobians, free covariance and standardized free-correlation matrix each have numerical rank17 at relative singular-value cutoffs 1e-8, 1e-10, 1e-12 and 1e-14. The covariance matrices are exactly symmetric in storage, their fixed reference rows/columns are zero, and the free-block minimum eigenvalues are positive (.014839303921024222 historical; .014841902114564562 replay). These are local, scale- and tolerance-dependent saved-state diagnostics; they neither prove global identification nor establish that inference is stable or that either solution is globally optimal. The fixed reference coordinate is excluded from free-block rank calculations.

Both saved states contain a finite 1-by-18 stored gradient. Neither contains a stored H matrix. Hessian-derived diagnostics therefore remain explicitly **unavailable**, never zero-filled, inferred from covariance inversion or recomputed by likelihood evaluation. The stored gradients are reported without imposing a new convergence tolerance or asserting optimality. The preserved likelihoods remain distinct: historical -1241.3004908011901; replay -1241.3004913276156.

## Validation and preservation contract

The adapted three-class analytic routines were tested for five indicators, 18 slots, 17 free coordinates and all 32 theoretical patterns. The genuine pre-implementation missing-function test returned3499; the implemented fixtures passed logit- and probability-coordinate finite differences, all six probability-preserving reference changes, signed covariance cross-terms and inverse transformations, a rank-deficient identical-class case, an indefinite covariance case, extreme logits and rank-threshold sensitivity. Full rank at the generic fixture is not a claim about all possible data-generating parameters.

Exactly six actual Stata MCP events were reserved and authenticated: initial inventory, missing-math RED, mathematical GREEN, saved-state diagnostics, worker destruction and final inventory. All three selections used the reserved worker. The diagnostic body restored empty state and maxvar5000 after temporarily allowing32767; the original session inventory was unchanged. The dependency guard checks pinned reviewed source graphs and rejects unreserved/dynamic/indirect dispatch and optimizer calls. It is deliberately not a general Stata/Mata sandbox.

Entry preservation covers **1024 other tracked files and 18289 earlier private artifacts**, including earlier seals and execution proofs. Four changing public tracker files retain byte-identical entry snapshots for verification of the predecessor seal; the original seal is never rewritten. Only six public governance/aggregate paths change. The public CSV is an exact transcription of the Stata-produced aggregate summary, including availability flags. All original 2000 workflow pointers remain, with ten new diagnostic pointers and schema121.

Technical closure additionally requires the owner audit, one authenticated fresh read-only final review, a fresh post-review test run bound to its actual exit-zero command, an immutable fingerprint seal, separate saved-only verification and external authentic execution proofs. Completion does not confer protected-data release authority.

## Next immediate task

**M6.08.36.R2 — protected original M4 three-class candidate-disposition and reporting contract, without fitting.** Retain the historical reporting flag and all raw comparisons; state the diagnostic 132 alignment and residual differences, unavailable Hessian and identification/inference limitations without adopting a new preferred model. Further fitting, posterior classification, profile export or publication requires its own explicit scope and authority.
