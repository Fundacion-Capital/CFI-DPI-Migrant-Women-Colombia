# Bounded original M2 two-class replay and native-target comparison
Task: **M6.04.28 / M6.08.27**. Owner checkpoint `fd0a37d511b5e96d40b94d0dac7dbea54faf0a96`.

## Outcome: native numerical discrepancy
The one authorized M2_k2 fit returned code0 and converged1, with N423, rank13,14 parameter slots and423 estimation-sample observations. Its log likelihood was -1528.176325447269 versus the saved target's -1528.176325447272.

Direct Stata native comparison found **34 exact matches and183 differing cells out of217**, with **zero stripe mismatches**. The maximum absolute coefficient difference was3.597559853937978; covariance difference0.2297577852467991; metadata difference3.18323145621e-12. [Complete aggregate comparison](lca-m2-k2-replay/comparison_summary.csv).

| Component | Cells | Exact matches | Differing cells |
|---|---:|---:|---:|
| Metadata |7|6|1|
| Coefficients |14|1|13|
| Covariance |196|27|169|
| Total |217|34|183|

This is **not exact historical numerical replication**. The near-equal likelihood does not establish equivalent solutions, class-label equivalence, global optimality or identification. No class-label realignment, tolerance change, refit or target substitution was attempted. Scientific acceptance remains held.

## Source fidelity and scope
The fit retained original M2 six-indicator complete-case sample lines6774–6778 and estimator lines6784–6794: IVS,ICDP,IAFF,OQI,IURD,ICPF, excluding fraud harm. Seed6430002, two classes,200 randomid draws,5000-iteration ceiling, saved input carrier and original row order were unchanged. No additional sort, posterior prediction, participant export or model-selection operation occurred.

The preflight's held adapter, all failed attempts and original reviewerFAIL/verified correction remain sealed and unchanged. A new stage-bound driver and owned worker were used. The fit reservation was consumed once; existing-file refusal protects against replay of the consumed driver. Its native state and status were saved privately before comparison.

## Native comparison and runtime
A separate saved-only Stata MCP selection verified fresh STER versus fresh native capture and historical STER versus frozen historical native target, each exactly across217 records/types/coordinates/stripes. It then compared fresh and historical native DTA values in their original parameterization. CSV is readable transcription; no rounded-CSV equality or tolerance is claimed.

Research fits1; refits0; predictions0; participant exports0. Both stages restored maxvar5000, cleared owned state and completed. Only the two task-owned workers were destroyed; full default inventory matched before/after. No additional model or retry is authorized.

## Validation and holds
Preservation checks protect944 unrelated tracked files and16227 earlier private artifacts. Public integration is six aggregate/documentation paths; source manuscript, production analysis, qualitative material, input datasets and preferred historical hybrid model remain unchanged. Workflow state88 retains all1669 prior pointers and adds ten, for1679.

Technical closure requires actual tests, independent review, fresh post-review exit-zero execution attesting receipt/source digests, exclusive seal and separate saved-only proof. Passing those gates completes this bounded replay/comparison task, **not** scientific acceptance, exact replication, release approval or permission to fit again. Historical extensive suite acceptance remains preserved, not presented as rerun.

## Next immediate task
**M6.08.27.R1 — protected saved-state M2 two-class numerical-discrepancy and class-parameterization diagnostics, without fitting.** Determine what the native discrepancy supports using preserved states only. A possible label-parameterization explanation is a hypothesis to test, not a conclusion of this replay. Preserve all packets; no refit, preferred-model change or release.
