# M6.08.27.R1 — protected original M2 two-class saved-state diagnostics

## Scope and outcome

This is a zero-fit, saved-state-only diagnostic of the original M2_k2 historical state and the single protected replay. No raw respondent dataset was opened. Both STER states were checked against their native 217-record captures, including exact values, schema, keys and parameter stripes.

The results strongly support a class-label reversal as the dominant explanation for the original discrepancy, with small residual numerical differences. This is not exact historical replication, a tolerance-based acceptance, scientific endorsement, global-optimality certification or public-release clearance. Original states/captures and the exact 183/217-cell discrepancy are unchanged.

## Diagnostic comparisons

| Quantity | Original coordinates | Diagnostic class swap |
|---|---:|---:|
| Maximum absolute coefficient difference | 3.597559853937978 | 1.77453595374e-7 |
| Maximum absolute covariance-entry difference | 0.2297577852467991 | 3.47626848696e-8 |
| Maximum class-weight difference | 0.4499431862062799 | 1.39895134366e-8 |
| Maximum item-probability difference | 0.7141383337699881 | 1.94229223816e-8 |

The full theoretical distribution over all 64 binary response patterns has maximum absolute difference **1.57395261408e-9** and total variation **9.06043928116e-9**. These are model-implied pattern probabilities, not participant predictions or posterior assignments. Swapping the replay labels leaves its own pattern distribution unchanged to a maximum numerical error of **1.38777878078e-17**.

The first class weight is constrained as the reference. The diagnostic transformation negates the free class-membership intercept, swaps the paired item intercepts, and transforms covariance by A V A'. It does not merely reorder coefficient rows. Both identity and swap comparisons are reported; neither overwrites the historical state.

## Conditioning and fitted-point diagnostics

Both states have N=423, 14 native slots, 13 free coordinates and reported convergence. The fixed reference slot is excluded from conditioning/rank calculations.

- Both 64-by-13 distribution Jacobians have rank 13 at relative singular-value thresholds 1e-8, 1e-10, 1e-12 and 1e-14. Condition numbers are about 11.73.
- Both free covariance matrices have rank 13 at all four thresholds, positive minimum eigenvalues about 0.01379, and condition numbers about 31.12; free correlation condition numbers are about 15.98.
- Minimum class weights are about 0.2750. Item probabilities range from about 0.08461 to 0.87490, with no items within 1e-8 of zero or one.
- Saved gradients exist and are finite: maximum absolute values are 1.73120045368e-5 (replay) and 1.94589150052e-5 (historical).
- Neither state contains the stored H matrix. Hessian diagnostics are unavailable, not zero and not reconstructed.

These findings support full numerical fitted-point rank of the assumed model distribution, modulo labels, at the tested thresholds. They do not prove global identification, absence of other maxima, measurement validity, robustness or substantive interpretability. No fresh scores, Hessian or optimizer were evaluated.

## Validation and preservation

Synthetic Stata fixtures cover the uniform 64-pattern distribution, identical-class rank loss, nondegenerate rank, analytic Jacobian versus central differences, reference-sign reversal, item swaps, covariance cross-term signs, involution, non-label differences, extreme finite values and rank-threshold sensitivity. Initial missing-function RED and two Mata syntax failures are retained; corrected GREEN03 passes.

Boundary and closure tests cover forbidden execution, diagnostic-only disposition, unavailable/invalid values, original reviewer identity and authenticated post-review completion. The full task audit verifies immutable earlier private and unrelated tracked files, actual Stata requests/results, source pins, cleanup and exact six-path public scope. Independent review and final sealing are required before task closure.

Only one task-owned worker was used, restored to empty state/maxvar5000 and destroyed. Default inventory is unchanged. No commit, push, cloud synchronization or public release is part of this task. The aggregate [diagnostics table](lca-m2-k2-diagnostics/diagnostics_summary.csv) contains no participant records. Detailed execution, native captures, failures and proofs stay in ignored private audit storage.

## Next immediate task

**M6.08.27.R2 — protected original M2 two-class candidate-disposition and reporting contract, without fitting.** Decide how to report the original exact discrepancy alongside strong diagnostic label alignment and small residual differences. Preserve all states and prior packets; do not refit, change the preferred model, or infer release authority.
