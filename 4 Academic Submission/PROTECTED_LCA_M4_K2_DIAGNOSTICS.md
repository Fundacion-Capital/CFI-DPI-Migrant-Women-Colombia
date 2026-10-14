# Protected original M4 two-class saved-state diagnostics

## Scope and boundary

**M6.08.35.R1.** Diagnostic examination of the two preserved M4_k2 estimates, without fitting. The original five binaries are IVS, ICDP, IAFF, OQI and IURD (no IEDF/ICPF). There are 12 native coefficient slots, one fixed base coordinate, 11 free coordinates and 32 unconditional binary response patterns.

Both 163-record native carriers were verified exactly against their own immutable saved estimates before calculations. No participant dataset was loaded; there was no fitting, retry, prediction, participant classification/export, fresh score/Hessian evaluation or optimizer. All numerical calculations used Stata/Mata through Stata MCP. The prior unaligned 31-match/132-mismatch comparison remains unchanged.

## Class-parameterization comparison

For a two-class swap, the reference-base coefficient remains fixed at zero, the free class-membership intercept changes sign, and the two item coefficients exchange within each of five indicators. The same linear map A transforms covariance to A V A'. These transformations are transient diagnostics only: neither saved state nor historical class labels were overwritten.

| Diagnostic | Original identity mapping | Diagnostic class swap |
|---|---:|---:|
| Maximum coefficient difference | 3.689517655480867 | 5.77587033757e-08 |
| Maximum covariance difference | 0.3213128108995731 | 1.81056418747e-08 |
| Maximum class-weight difference | 0.4637508396777473 | 5.17168186054e-09 |
| Maximum item-probability difference | 0.7263982881557604 | 7.22265658393e-09 |

The swap substantially reduces the recorded discrepancies, supporting a class-label reversal as the dominant parameterization difference, but it does not eliminate the residuals. **Outcome: RESIDUAL_PARAMETER_DISCREPANCY.** No tolerance was introduced to convert small residuals into exact replication.

Across all 32 unconditional response patterns, the maximum probability difference is 6.97099586389e-10 and total variation is 2.87443565022e-09. Within the replay state alone, applying the swap changes the implied distribution by at most 2.77555756156e-17 (floating-point diagnostic invariance error). These are model-implied probabilities, not participant predictions or observed goodness-of-fit statistics.

## Fitted-point numerical diagnostics

| Quantity | Replay | Historical |
|---|---:|---:|
| N / stored rank / slots | 423 / 11 / 12 | 423 / 11 / 12 |
| Reported convergence | 1 | 1 |
| Log likelihood | -1245.808440340146 | -1245.808440340146 |
| Free covariance condition number | 39.2214516231823 | 39.22145167598775 |
| Free correlation condition number | 19.47290683608412 | 19.47290827347906 |
| Distribution-Jacobian condition number | 12.59656233594404 | 12.59656203846404 |
| Minimum free covariance eigenvalue | 0.0139380902185922 | 0.0139380902553272 |
| Minimum class weight | 0.2681245775752855 | 0.2681245827469673 |
| Minimum item probability | 0.083176046792005 | 0.0831760487418413 |
| Maximum item probability | 0.8732522284182074 | 0.8732522348111007 |
| Item probabilities within 1e-8 of a boundary | 0 | 0 |
| Maximum absolute stored gradient | 6.32384719881e-07 | 8.48155930419e-08 |

The analytic 32-by-11 distribution Jacobian, 11-by-11 free covariance and free correlation matrices each have numerical rank11 at relative singular-value thresholds 1e-8, 1e-10, 1e-12 and 1e-14, in both states. Covariances are symmetric and the fixed-base covariance row/column is zero. These are fitted-point/local numerical facts under the retained model; they do not establish global identification, a unique optimum or substantive validity.

Stored gradients are finite 1-by-12 matrices. Neither state contains a saved H matrix. Hessian diagnostics are therefore unavailable, **not zero**; no Hessian was reconstructed from covariance or reevaluated from respondent data. The complete [99-row aggregate diagnostic table](lca-m4-k2-diagnostics/diagnostics_summary.csv) retains availability flags and blank unavailable values.

## Validation, preservation and limits

Synthetic fixtures run through Stata verify uniform 32-pattern probabilities, symmetric rank5 and generic full rank11, analytic derivatives against finite differences, signed covariance cross-term exchange, inverse swap, genuine perturbation detection, stable extreme logits and relative-rank thresholds. The expected missing-function RED (3499) precedes GREEN. The pinned fixture's inherited log identifier contains the legacy token 64; its dimensions and assertions test five binaries/32 patterns, and the token is not interpreted as a count.

The six authenticated Stata events comprise inventory, RED, GREEN, diagnostics, owned-worker destruction and final inventory. All actual diagnostic bodies clean to empty/maxvar5000 after temporary32767; the session inventory is unchanged. The protected packet is `audit-local/intake/lca-m4-k2-diagnostics-fdf4abe`. Preservation covers 1015 unrelated tracked files, 18079 earlier private files and four tracker snapshots, including all earlier estimates, packets and failed attempts.

Six aggregate/documentation paths are prepared locally, uncommitted. Schema117 retains 1962 prior pointers and adds ten. Authentic review, fresh final execution, exclusive seal and separate saved-only verification remain mandatory for technical closure. All scientific, ethics and release holds and the preferred H1_k4 remain unchanged. This is not exact numerical replication or scientific acceptance; no original production or manuscript material changes.

## Next immediate task

**M6.08.35.R2 — protected original M4 two-class candidate-disposition and reporting contract, without fitting.** Carry forward the raw discrepancy, diagnostic swap residuals and fitted-point limitations into an explicit reporting disposition. No additional fit or participant profiling is authorized.
