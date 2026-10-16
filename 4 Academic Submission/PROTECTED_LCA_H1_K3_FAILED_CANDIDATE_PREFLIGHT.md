# Original H1 three-class failed-candidate intake and adapter preflight

**M6.03.41 / M6.05.41 — without fitting.** This is a protected preflight of the original candidate, not a new estimate, scientific acceptance or release. The historical H1 two-class native match is preserved separately; its target is not borrowed for H1_k3.

## Historical source and availability

The original H1_k3 specification has six ordered-logit indicators—`h_ivs3`, `h_icdp3`, `h_iaff3`, `h_iuof3`, `h_oqi3`, `h_iurd3`—and the binary-logit indicator `h_iedf2`. It uses three classes, seed6529003,400 random-id draws, `difficult`, and an iteration ceiling of6000. Source sample selection is at lines8214–8217; seed8240; estimator8242–8253; return code captured immediately at8254. Original sample, mixed measurement definitions, recodes, row order and estimation options are unchanged. No sorting, weights, relabeling, alternative starts, tolerance or production correction is added.

The [archival status row](lca-h1-k3-preflight/historical_status.csv) is transcribed from the frozen original grid: N_complete423, return code0, convergence0 and report_candidate0, with note “Model estimated but did not converge.” Return code0 is not convergence. Nine unavailable fields—log likelihood, df, AIC, BIC, entropy, average maximum posterior, minimum class count, minimum class percentage and small-class flag—remain blank, never zero-filled. Fresh metrics and reporting eligibility are **NOT_RECOMPUTED**.

The frozen intake catalogue records no saved H1_k3 estimate, and its saved-model metadata and models folder contain no corresponding native state or numerical target. Absence is scoped to this frozen intake; it is not a claim about every historical storage location. No coefficient/covariance target, posterior assignment or convergence evidence is fabricated. Source recording code stores estimates/diagnostics only within its convergence branch; this preflight retains that provenance without running the recording program or its predictions.

## Protected no-fit execution contract

The staged original estimator sits behind an unconditional **exit459 before any data load or estimator**. It remains held. Executed preflight code and its complete dependency graph are pinned and checked for forbidden estimators, predictions, external dispatch and unsupported or dynamic dependencies. This is a purpose-bound reviewed guard, not a general sandbox for arbitrary future code.

Only two new owned Stata workers are permitted, accessed through the Stata MCP connection:

1. The positive preflight loads only KEY, seven source scores and seven hybrid indicators into memory—a15-column projection. A separate in-memory frame loads KEY and the same seven scores from the preserved upstream minimal-input dataset—an8-column projection. Row-by-row keys, scores and original order must agree. The exact source blocks are then used to recreate all six tertile indicators and the IEDF median split. Recreated and stored values, ordinal/binary domains, unchanged order and423 complete cases must agree. No respondent identifiers or individual values are displayed or exported.
2. The controlled negative-cleanup preflight deliberately raises assertion error9 after temporarily increasing capacity. It checks handled-error restoration separately from the normal body0 path. This does not test forced termination, process crashes or transport-timeout recovery.

Both workers must restore `maxvar` to5000 after temporary32767, clear loaded frames/data/estimation state, be destroyed, and leave the final session inventory equal to its initial snapshot. The actual six-event roster, exact requests, returned results and durable logs are authenticated before acceptance. No analysis is run through a shell or alternative statistical engine.

## Nonconvergence-aware capture routes

| Synthetic status fixture | Required disposition |
| --- | --- |
| Nonzero return code, regardless of convergence | `FAILED_NO_CAPTURE` |
| Return code0 and convergence0 | `NONCONVERGED_NO_CAPTURE` |
| Return code0 and missing convergence | `NONCONVERGED_NO_CAPTURE` |
| Return code0 and convergence1 | `NEW_STATE_ONLY_NO_HISTORICAL_TARGET` |

Two additional invalid-status fixtures must be refused. These fixtures route synthetic status inputs only: they do not create estimates, use participant outcomes as fitted states or demonstrate optimizer convergence. Even hypothetical future convergence would create new evidence, not recover a missing historical target. A future replay must capture actual status before optional native capture and may not classify a nonconverged state as accepted numerical replication.

## Audit, preservation and limits

Every prior packet, failed attempt, source file, input and preserved estimate remains unchanged. Public output is limited to this report, the single archival aggregate row and governance/routing updates; no participant records are exported. Completion requires safe unit suites, full in-scope byte preservation, one independent review, fresh post-review validation, authentic exit-zero execution/source/receipt binding, an immutable seal, separate saved-only verification and external closure/readback. A passed preflight is neither fit authority nor public-release approval.

The exact input/recode checks establish fidelity to the preserved inputs only. They do not validate upstream instrument design, measurement suitability, global identification, optimality, inference, robustness or substantive class interpretation. The original reporting screen—including its missing-value behavior—and distinct final H1_k4 preference remain untouched and unvalidated here.

## Next immediate task

**M6.04.41 / M6.08.40 — bounded original H1 three-class failed-candidate replay and historical convergence/status comparison.**

That next task requires separate explicit authorization for one bounded fit and a newly reserved execution/capture contract. It must preserve this packet, the historical blanks and absent-target distinction, capture return code/convergence before optional native capture, and distinguish status agreement from numerical replication. **Current task fits authorized:0; further fit authorized:false.**
