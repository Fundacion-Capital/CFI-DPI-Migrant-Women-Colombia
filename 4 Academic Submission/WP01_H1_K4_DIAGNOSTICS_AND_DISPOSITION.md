# WP01 — H1 four-class saved-state diagnostics and candidate disposition

## Outcome and scope

**Retain the exact native numerical mismatch, with label-order and coordinate-scaling diagnostics.** The protected read-only audit completes the four WP01 subprocesses when its final review/audit/seal/verification receipts pass. It does not certify exact native replication, scientific acceptance, global identification, inference, the distinct preferred final refit or overall M6 completion.

This is the original **initial-grid `H1_k4`** candidate. It is not `lca_final_hybrid_H1_k4`, whose separate sorting/seeded execution remains pending. Original source: `1 Code/2 Analysis_CFI DPI Migrant Women Colombia.do`; SHA-256 `714377CA31DE2B6D70DB0994E3C7EF6A38374165D7B1FB7C7ABEB3B3F56549C9`; sample8214–8217, seed8259, estimator8261–8272, immediate status8273. Original four-class specification uses six ordinal-logit indicators and binary `h_iedf2`, seed6529004,600 random-id draws,8000 iterations and `difficult`. None was refitted or changed here.

The [203-row full-precision metric table](wp01-h1-k4/diagnostic_metrics.csv), [H1 status sheet](wp01-h1-k4/candidate_context.csv) and [20-statement reporting contract](wp01-h1-k4/reporting_contract.csv) are aggregate reporting artifacts. No participant-level file was loaded/exported, no prediction command ran, no saved state was rewritten and no relabeling was applied.

## WP01.1 — contract and preflight

The entry audit preserved prior tracked/private packets, the failed R4 attempt, successful R4.R1 fixtures and R3 exact targets. The recovered mathematics and exact3199-cell native verifier were reused unchanged. A synthetic203-row Stata transport preflight checked keys/schema and availability encoding before diagnostics. Python negative cases reject missing/duplicate/unknown keys, nonblank unavailable values, decimal/hex disagreement, unsafe data/estimation routes and false success markers.

Later, strict intake correctly rejected the real CSV's truncated decimal representations. The synthetic zero-only transport had not exposed this format limitation. The original DTA/CSV/log and source-bound producer remain preserved. A separately reserved **aggregate-only saved-DTA readback** used explicit17-digit strings, asserted `real(value)==native_value` for every available value, regenerated each hex value and exported `diagnostics_exact.csv`. The strict reader remains unchanged: every decimal now equals its hex-decoded double exactly, and every hex/availability field agrees with the original export. No state was reopened, diagnostic recomputed or historical-comparison tolerance relaxed for this repair.

For old R3 governance files that later accepted tasks intentionally extended, the audit checked the historical sealed bytes against Git checkpoint99682be, all immutable R3 artifacts against R3 and current predecessor governance against the latest seal. No old seal was edited or fingerprint mismatch waived.

## WP01.2 — actual saved-state results

Each of the two allowed `.ster` files passed its unchanged own-state native verifier: **3199 records/stripes each**. Both stored N423, rank55, convergence1 and56 coefficient slots. This validates those stored targets, not historical participant-membership equality. The fixed reference coordinate has zero covariance; geometry below excludes it and uses55 free coordinates.

| Metric | Historical candidate | Preserved replay |
| --- | ---: | ---: |
| Stored log likelihood | -2764.561090279198 | -2764.5610874432596 |
| Stored56-slot gradient maximum absolute entry | 0.0028097279514109246 | 0.0007701013263772403 |
| Stored `e(H)` present | No | No |
| Largest free-coordinate variance | 7.902141043032553e13 | 2.1722171403180137e13 |
| Largest corresponding standard error | 8889398.76652665 | 4660705.032844295 |
| Free covariance condition number | 9.1450164744381e15 | 3.431738407887363e15 |
| Diagonally standardized free correlation condition number | 33.96189519614999 | 28.626102120565307 |
| Smallest computed symmetric covariance eigenvalue | 0.009261907805259153 | 0.010850063567701861 |
| Smallest class-conditional item-probability coordinate | 3.459546308244001e-16 | 1.2593041809953121e-15 |
| Minimum class weight | 0.1002987447303354 | 0.1002928696063799 |

The stored gradients are finite1×56 matrices. They are raw stored gradients, not newly evaluated scores, a scaled convergence test or proof of optimality. Only `e(H)` availability was inspected; it is absent and its dimensions/finite/max fields remain unavailable, not zero. No Hessian was fabricated by inverting covariance, and no fresh likelihood, score or observed-information calculation was performed.

The largest variance is on the IUOF first cutpoint: historical slot33 (`/h_iuof3:1bn.C#c.cut1`) and replay slot36 (`/h_iuof3:4.C#c.cut1`). These are corresponding classes under the closest scratch probability-column permutation below. The smallest eigenvalues shown are computed in an extremely ill-scaled raw matrix; do not turn their numerical signs or the raw singular-value ratios into a curvature or structural-identification certificate.

### Relative-threshold and coordinate comparison

The explicit numerical-rank rule counts singular values greater than `rtol × largest singular value`. The four columns below use relative thresholds1e-8,1e-10,1e-12,1e-14; they do not alter the historical exact-match rule. See Stata's [rank](https://www.stata.com/manuals/m-5rank.pdf) and [SVD](https://www.stata.com/manuals/m-5svd.pdf) documentation for tolerance-dependent numerical rank.

| Matrix/map | Historical ranks | Replay ranks |
| --- | --- | --- |
| Free covariance, original units | 5 / 6 / 7 / 13 | 6 / 6 / 7 / 20 |
| Diagonally standardized free correlation | 55 / 55 / 55 / 55 | 55 / 55 / 55 / 55 |
| Model-implied probability-map Jacobian, original logits/cutpoints | 51 / 52 / 53 / 54 | 51 / 52 / 53 / 54 |
| Same map, independent probability coordinates | 55 / 55 / 55 / 55 | 55 / 55 / 55 / 55 |

The logit-coordinate Jacobian condition numbers are approximately3.9704e15 and1.0021e15; probability-coordinate values are43.3401 and31.4525. Raw covariance numerical rank is therefore strongly scale/threshold-sensitive; it must not be reported as proof that the model has only5–20 structurally identified parameters. Likewise, probability-coordinate rank55 is a local linear-algebra observation at the stored probabilities, not global identification or regular likelihood-based inference, especially near probability boundaries. The ordered-probability map follows the [ordered-logit cumulative-cutpoint representation](https://www.stata.com/manuals/rologit.pdf).

There are4 item-probability coordinates within1e-8 of a boundary in each state; at1e-6 there are5 historical and7 replay; at1e-4 there are7 each. These counts cover76 reported item coordinates: four binary success probabilities plus72 ordinal category probabilities. Binary failure probabilities are implicit complements, not four additional counted coordinates. Class weights are excluded from these boundary counts.

## WP01.3 — what explains the discrepancy, and what does not

The unchanged R3 result remains **118 exact / 3081 different / zero stripe mismatches** among3199 cells. Coefficients are1/56 exact; covariance111/3136 exact; metadata6/7 exact. Maximum direct differences remain b39.97900710667828, V79021410430324.7 and log likelihood2.8359386305965018e-6. No exact-native result is upgraded.

All24 probability-column permutations were examined in scratch matrices. The closest is lexicographic index19, replay columns **(4,1,2,3)** compared with historical columns **(1,2,3,4)**. It is a comparison orientation, not relabeling of either saved estimate.

| Comparison | Maximum absolute difference |
| --- | ---: |
| Identity-order class weights plus conditional item profiles | 0.9999978425036679 |
| Closest-permutation item profiles | 0.0000641008480740668 |
| Closest-permutation class weights | 0.0000429506455406070 |
| Closest-permutation combined profile | 0.0000641008480740668 |

The model-implied distribution across all1458 theoretical response patterns has maximum pointwise difference **1.5124318580601176e-6** and total variation **3.3839314082432546e-5**. This distribution is permutation-invariant and uses no observed respondent records. It is not a respondent fit check, an empirical goodness-of-fit test, posterior assignment comparison, stability study or new acceptance tolerance.

**Supported interpretation:** native coordinate differences are heavily affected by class ordering; after scratch alignment, the probability representations are close but not identical. Both states also have near-boundary item probabilities, large cutpoint variances and severe logit-coordinate scaling, while probability/correlation coordinates are much better conditioned. This is evidence for label-order and weakly scaled logit-coordinate sensitivity, not evidence that a formatting error alone created the native discrepancy.

**Not established:** exact equality after relabeling; identical participant membership; equal optimizer paths or global maxima; an identified causal/measurement model; reliable Wald inference; unique structural identification; the reason the optimizer reached these particular states; or validity of the separate final refit. Establishing any of those needs evidence outside this no-fit package. No new starts, parameter rebasing, covariance relabeling or extra estimation was performed to force an explanation.

## WP01.4 — candidate disposition and reporting contract

Disposition: **RETAIN_NATIVE_MISMATCH_WITH_LABEL_AND_SCALE_DIAGNOSTICS**. Retain the original archived candidate and its replay as separate preserved states. Report the raw mismatch and bounded diagnostics together; do not substitute probability closeness for exact native replication or carry raw cutpoint uncertainty into the academic paper as validated inference.

The archival initial-grid row has convergence1/report_candidate1, with its original likelihood, information criteria, entropy and class summaries. That is historical reporting context, not newly recomputed eligibility or academic acceptance. Fresh information criteria, posterior probabilities, entropy, modal class sizes and reporting-screen status remain **NOT_RECOMPUTED**. The original screen requires convergence1, k4/5, minimum modal class percentage≥5 and entropy≥0.60 and lacks an explicit missing-value guard; no general endorsement or correction of that screen is made here.

H1 k2 retains its prior exact-native-match/reporting-excluded disposition; H1 k3 retains its prior rc/nonconvergence match; H1 k4 now has the bounded discrepancy disposition above; H1 k5 remains pending replay; the separate final preferred H1 k4 remains distinct and pending. This is not full H1-family completion or a new class-count/model choice. The status sheet carries no borrowed fresh posterior/information metrics.

The original failed syntax packet, recovered fixture packet, original truncated CSV, failed strict-reader path and all new precision-readback evidence remain preserved. Three owned no-fit selections—synthetic preflight, saved-state diagnostics and aggregate-only precision readback—form ten authenticated MCP events with shared inventory endpoints. Each worker was cleaned/destroyed; pre-existing session identities remained. Shared-default internal state is not certified. No model or participant file was modified, and no production/manuscript, Git commit/push, cloud/Overleaf, preferred-model or public-release change occurred.

One final independent review, owner rulings, fresh audit, immutable seal and separate saved-only verification govern completion. The selected regression suites are not an exhaustive rerun of all historical producing workflows. All M0–M13 scientific/privacy/release gates remain as previously recorded except this bounded WP01 completion; the negative scientific disposition is a completed audit result, not a hidden unfinished diagnostic.

## Next work package

**WP02 — remaining historical LCA candidate-grid intake, bounded family execution and unified dispositions.**

Begin by reconciling current receipts and a source-exact batch manifest for H1_k5 and H2/H3/H4_k2–k5 (thirteen candidates). A future fit authorization must explicitly name that manifest's models, sources/inputs, seeds, starts, iteration/runtime ceilings, maximum fits and retry rules. No fit authority exists from WP01; no need for a new user turn between routine internal checks once a named batch is authorized. The independent final H1 k4 and benchmarks/downstream operations belong to WP03 and are not included in the thirteen-candidate count. Preserve this complete package and the broader consolidated workplan; do not return to one user request per preflight/readback/report.
