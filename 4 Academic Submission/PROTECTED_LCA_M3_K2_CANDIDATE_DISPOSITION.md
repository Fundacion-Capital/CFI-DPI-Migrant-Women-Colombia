# Protected original M3 two-class candidate disposition and reporting contract

## Scope and authority

M6.08.31.R2 is a reporting-only disposition of the preserved original M3_k2 candidate, its bounded replay and its saved-state diagnostics. It authorizes no Stata call, fit, prediction, participant-data load/export, estimator change, relabelled target replacement, new information criterion, scientific acceptance or public release. The entry checkpoint is main at 3731dd8a6bc52b57b257936a70d52bc227e61abf. The historical hybrid H1_k4 preference remains unchanged and is not revalidated here.

The protected packet is audit-local/intake/lca-m3-k2-disposition-3731dd8. Sources are the sealed replay lca-m3-k2-replay-a674e5a and diagnostics lca-m3-k2-diagnostics-01a4d55, the original analysis code and the preserved native catalogue/grid. The original code hash remains 714377CA31DE2B6D70DB0994E3C7EF6A38374165D7B1FB7C7ABEB3B3F56549C9. No participant identifiers are reproduced in this report or its two aggregate CSVs.

The initial preservation check failed because the older replay seal included four public trackers legitimately advanced by R1. Their historical bytes were verified against R1's sealed entry snapshots; all other replay fingerprints and the complete R1 seal were checked at their proper checkpoints. Neither prior seal nor historical artifact was modified. Failed preparation, quoting and closure-test attempts remain in the authenticated current-task journal and preservation receipts.

## Candidate ruling

**RETAIN_HISTORICAL_CANDIDATE_EXACT_REPLICATION_HELD_WITH_APPROXIMATE_LABEL_ALIGNMENT.**

Retain M3_k2 as an archived, converged two-class candidate, with a successful original-specification replay and diagnostic evidence of reversed class labels. Do not describe it as exact numerical replication, the selected final model, scientifically accepted, globally identified/optimal, or approved for substantive profiling.

M3 has six binary indicators: IVS, ICDP, IAFF, OQI, IURD and IEDF harm; ICPF trust is excluded. The original sample/seed/estimator/recording window is lines 6860–6884: seed 6431002, two classes, random-id starts with 200 draws, difficult optimization and 5,000 maximum iterations. The original command and immediate return-code capture remain unchanged.

| Preserved evidence | Historical state | Bounded replay / diagnostics |
|---|---:|---:|
| Complete sample | 423 | 423 |
| Stored convergence | 1 | 1 |
| Stored rank / coefficient slots | 13 / 14 | 13 / 14 |
| Log likelihood | -1488.797376384362 | -1488.797376384342 |
| Original native comparison | Reference target | 217 cells: 34 exact, 183 differing; zero stripe differences |
| Stored Hessian | UNAVAILABLE | UNAVAILABLE |

The likelihood difference is approximately 2.00088834390e-11. This does not negate the original coefficient/covariance mismatch. The reference targets remain unaligned and immutable.

## What diagnostic alignment does and does not establish

The first class-membership intercept is fixed to zero as the reference. The other class-membership intercept determines the mixture weights; neither class probability is fixed by that normalization. The diagnostic class swap negates that free intercept, swaps each item-parameter pair and transforms covariance as A V A'. It is not an estimator rerun or a replacement of either stored state.

| Maximum absolute difference | Original identity comparison | Diagnostic class swap |
|---|---:|---:|
| Coefficients | 3.198886639349912 | 8.32628772818e-07 |
| Covariance entries | 0.2671839283778329 | 1.61287026956e-07 |
| Mixture weights | 0.473375903066362 | 6.74150777424e-08 |
| Item probabilities | 0.6616117074268765 | 1.04582039473e-07 |

The archived all-64-pattern probability comparison has maximum difference 9.86018253504e-09 and total variation 5.27467808283e-08. Own-state swap invariance has maximum error 2.77555756156e-17. These are transcribed R1 diagnostics, not new calculations or acceptance tolerances. The R1 outcome remains RESIDUAL_PARAMETER_DISCREPANCY.

Both fitted-point distribution Jacobians, free covariance and free correlation matrices have numerical rank 13 at relative thresholds 1e-8, 1e-10, 1e-12 and 1e-14. This is local numerical evidence at the saved fitted points under the assumed model, not proof of global identification, global optimality, measurement validity or substantive class interpretation. Saved gradient maxima are 0.0000171245044705 (replay) and 0.0000327816162046 (historical). Both saved Hessians are absent: UNAVAILABLE must never be reported as zero, evaluated, reconstructed or well-conditioned.

## Archival grid context and reporting limits

[candidate_context.csv](lca-m3-k2-candidate-disposition/candidate_context.csv) preserves five original grid rows: M3_k2, M3_k3, M3_k4, M3_k5 and initial-grid H1_k4. All original field strings and blanks are retained, with explicit archival-only context labels. These are not fresh fits or a newly accepted ranking.

| Archival M3 candidate | Converged | Original reporting flag | AIC | BIC | Minimum class count |
|---|---:|---:|---:|---:|---:|
| M3_k2 | 1 | 0 | 3003.594752768724 | 3056.210591096326 | 103 |
| M3_k3 | 1 | 0 | 2937.110571881602 | 3018.058015462528 | 71 |
| M3_k4 | 1 | 1 | 2936.734501678432 | 3046.013550512681 | 65 |
| M3_k5 | 0 | 0 | unavailable | unavailable | unavailable |

The M3_k5 grid has rc=0 but convergence=0 and blank likelihood, information-criterion, entropy, posterior and class-size fields. Successful command return is not convergence; missing failed-candidate values are not zero. No new evaluation of that failed candidate occurs here.

Original lines 7033–7037 screen on convergence=1, k in {4,5}, minimum class percentage at least 5, and entropy at least 0.60. This mechanically excludes both two- and three-class candidates, regardless of their archived BIC. It is not a BIC-minimization or universal scientific-validity rule. The original screen lacks explicit missing-value guards: Stata numeric missing values compare above finite thresholds. That caveat is retained, not repaired or used to change flags here.

M3_k3 has the lowest archived BIC within these preserved M3 rows, but remains outside that original four-/five-class screen. This is a description of the archived grid, not a current selection recommendation. The initial H1_k4 grid row is distinct from the separately selected final preferred H1_k4 refit in source lines 8804–8832. Do not compare absolute M3 and H1 AIC/BIC as if the six-binary and seven-mixed feature/likelihood structures were identical.

Replay information criteria, entropy, posterior maximums, class sizes and report_candidate are NOT_RECOMPUTED. Historical grid quantities must not be presented as fresh replay outputs.

## Claim-by-claim contract

[reporting_contract.csv](lca-m3-k2-candidate-disposition/reporting_contract.csv) carries 18 explicit rules: nine RETAIN, two HOLD and seven EXCLUDE. They separate archived facts, successful bounded execution, diagnostic alignment, exact identity and scientific acceptance. No omitted rule, missing-as-zero substitution, fresh-selection claim or future-fit authority is permitted.

Validation requires unchanged source/target/private preservation fingerprints; exact source windows; public/private CSV agreement; schema 105 with ten additive artifact pointers; seven-path-only public scope; observed contract and closure negative tests; actual independent final review; a fresh post-review exit-zero check bound to its command, receipt and source hashes; an exclusive seal; and a separate saved-only verification. Completion means this disposition/reporting workflow passed those checks, not scientific replication or release acceptance.

## Next immediate task

**M6.03.33 / M6.05.33 — protected original M3 three-class candidate adapter and native-capture preflight, without fitting.**

The preserved source window is lines 6886–6902: seed 6431003, three classes, 300 random-id draws, difficult optimization, iterate(5000), immediate return-code capture and M3_k3 recording. Its original catalogue records N=423, 21 coefficient slots, rank=20, convergence=1 and 469 native target records. The original stored target hash is 71CEBAB20F774B602DC7FD6E86AD93ACFC1490C280C8AC164F48AEF5441ABEBB; native CSV hash is ED95EBAFDAC44D3297C26F630856DEC57BD9FC8EE4EB130815287529571282A2.

This is a source-bound handoff only. M3_k3 requires its own adapter, runtime and native-target validation; M3_k2 conclusions, class labels, convergence or acceptance must not transfer to it. Fits allowed by the handoff: zero.
