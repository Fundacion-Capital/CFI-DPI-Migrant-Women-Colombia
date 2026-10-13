# M6.08.27.R2 — protected original M2 two-class candidate disposition

## Disposition

**Retain the historical M2_k2 candidate and its bounded replay as archival/diagnostic evidence. Hold exact historical replication and scientific acceptance.** The large original-coordinate discrepancy is predominantly explained by reversed class labels, with small residual numerical differences after diagnostic rebasing. Do not replace the exact comparison with aligned values or an acceptance tolerance.

This reporting task makes zero Stata calls, fits, predictions or respondent-data loads. It transcribes sealed evidence and original source rules; it does not recalculate scientific statistics or change production analysis.

## Historical candidate and reporting screen

M2_k2 uses six binary indicators, excluding fraud harm: IVS, ICDP, IAFF, OQI, IURD and ICPF. The historical grid records N_complete=423, two classes, convergence1, rc0 and report_candidate0.

| Historical M2_k2 grid metric | Archival value |
|---|---:|
| Log likelihood | -1528.176325447272 |
| Degrees of freedom | 13 |
| AIC | 3082.352650894544 |
| BIC | 3134.968489222145 |
| Entropy | .6781665694940076 |
| Mean maximum posterior | .9123491380689608 |
| Minimum assigned class size | 113 |
| Minimum assigned class percentage | 26.71394799054373 |
| Small-class flag | 0 |

Every number above is archival. Replay posterior summaries and report_candidate are **NOT_RECOMPUTED**; this report must not present them as newly verified participant-level outputs.

The original screen at source lines 7033–7037 requires convergence, four or five classes, minimum class percentage of at least 5, and entropy of at least .60. It mechanically excludes two classes even though M2_k2 converged and meets the displayed size/entropy thresholds. It is not a minimum-BIC selection rule or proof of intrinsic invalidity. The screen has no explicit missing-value guard for its size/entropy comparisons; Stata missing values sort above finite numbers. This historical caveat is retained, not repaired here. The small-class warning is a separate diagnostic.

The [candidate context table](lca-m2-k2-candidate-disposition/candidate_context.csv) preserves the M2_k2/k3/k4 and initial H1_k4 grid rows. M2_k3/k4 have not been newly replayed in this task. The H1 row is its initial grid result, not the separate final preferred refit. Absolute BIC/AIC comparisons across M2 and H1 must not be used for ranking their different feature/likelihood structures.

## Replay and diagnostic reporting

The single original-specification replay reported return code 0 and convergence, N=423, rank 13 and 14 slots. Its exact native comparison remains 217 cells: 34 exact matches, 183 differences and zero stripe mismatches. Original targets, native states, source, input order and failures remain unchanged.

| Diagnostic maximum difference | Identity coordinates | Correct class swap |
|---|---:|---:|
| Coefficients | 3.597559853937978 | 1.77453595374e-7 |
| Covariance entries | .2297577852467991 | 3.47626848696e-8 |
| Class weights | .4499431862062799 | 1.39895134366e-8 |
| Item probabilities | .7141383337699881 | 1.94229223816e-8 |

The model-implied distribution across 64 binary patterns differs by at most 1.57395261408e-9, with total variation 9.06043928116e-9. These are saved-state theoretical distributions, not participant predictions. No diagnostic tolerance is converted into a replication acceptance rule.

**The first class-membership intercept is fixed to zero as the reference.** Both mixture weights remain functions of the free membership intercept. This explicitly corrects the Minor wording issue in the sealed R1 report, which referred to a constrained “weight.” The R1 report/seal remains preserved. Correct rebasing negates the free intercept, swaps item-intercept pairs and transforms covariance by A V A'.

Both saved distribution Jacobians and free covariance matrices have numerical rank 13 at relative thresholds 1e-8, 1e-10, 1e-12 and 1e-14. Stored gradients are finite. The stored H matrix is **UNAVAILABLE** in both states, not zero; no fresh Hessian/scores or optimization are accepted here. These facts support numerical fitted-point diagnostics, not global identification, optimality, measurement validity, robustness or substantive class acceptance.

## Reporting contract and limits

The [reporting contract](lca-m2-k2-candidate-disposition/reporting_contract.csv) separates 16 RETAIN/HOLD/EXCLUDE claims. Keep archival fit and posterior diagnostics; retain the exact mismatch and approximate label alignment; hold exact identity/scientific use; exclude fresh-flag substitution, missing-as-zero, cross-feature fit ranking, preferred-model replacement and new execution/release authority.

The separately selected historical hybrid H1_k4 model remains unchanged. Its final preferred estimation source is preserved at lines 8804–8832. Neither M2_k2 nor the initial H1 grid row substitutes for that final model.

Verification is bounded to source transcription, current contract/closure tests, relevant inherited checks, preservation, authenticated zero-call history and seven public integration paths. Extensive historical suites are retained, not claimed rerun. Independent review, fresh post-review execution, sealing and separate proof are mandatory for closure. Private native states/logs/evidence stay outside Git; no commit, push, cloud/Overleaf change or manuscript modification is part of this task.

## Next immediate task

**M6.03.29 / M6.05.29 — protected original M2 three-class candidate adapter and native-capture preflight, without fitting.** Source seed 6430003, three classes, randomid draws 300, iterate 5000, same six indicators/sample. Frozen target metadata: N=423, 21 slots, rank 20, 469 native records, saved convergence 1. Preflight must validate these contracts and preserve all failures; it does not authorize a fit or transfer the M2_k2 diagnostic disposition to M2_k3.
