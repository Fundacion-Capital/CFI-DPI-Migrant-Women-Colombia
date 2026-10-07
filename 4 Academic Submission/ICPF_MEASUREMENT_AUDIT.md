# Historical ICPF measurement audit

**Checkpoint:** 7 October 2026; **M4.03.15 / M5.02.13**. Entry: main, commit `1a1db958ee6fefb4740315c37c4321c84ce4fa4c`, one worktree, clean entry. This is a bounded historical measurement audit, not a revised index, newly fitted result, scientific approval, or public-release authorization.

## 1. Scope and acceptance boundary

The audit connects the author-selected **LEGACY-A original full draft (31 July 2026)**, five deployed SurveyCTO definitions, historical raw/audit/coded inputs, the current Preparation Section 3.9.2, three authentic preparation recipes, all 36 preserved dataset identities, and the actual analysis consumers. Respondent and synthetic statistics were executed through **Stata MCP only**. Native checks independently validate source text, form metadata, hashes, CSV structure and checkpoint boundaries; they do not compute respondent statistics.

Seven child tasks are accepted only with the definitive Stata run, separate aggregate/specification read-back, independent source review and final preservation checks. **M0 remains in progress; all parent scientific/design/method/quality/replication/release gates remain pending.** Zero participant fields are approved for public release. Exact replay establishes historical reproducibility of the inspected fields, not construct validity, original producing execution or fitted-result robustness.

The ignored local packet is `audit-local/intake/icpf-1a1db95`. It contains safe aggregate/specification diagnostics and source locators, not exported participant records. Protected originals, prior audit packets, code, results, qualitative contributions and legacy exhibits remain unchanged. No staging, commit, push, history rewrite, cloud access/copy/delete, Overleaf synchronization, or production correction is included.

## 2. Instrument meaning, version routes and source identity

Five deployed versions are retained: **2512090157, 2512091719, 2512111044, 2512121811 and 2602120658**. The independent native OOXML comparison matches the Stata extraction of **180 questionnaire metadata rows and 285 choice rows**, including full group ancestry, eligibility calculations, constraints, requiredness and own relevance.

| Scored input | What respondents were actually asked | Current component |
|---|---|---|
| q9_1 | Confidence that the main account/payment provider keeps money safe; agreement scale1–5 | Agreement4/5 →1;1/2/3 →0. This is perceived trust, not verified safeguarding. |
| q9_15 | Whether household members consider women's digital payment use appropriate; agreement1–5 | Agreement4/5 →1;1/2/3 →0. Neutral3 is pooled with disagreement. |
| q9_22 | Perceived community view that women should decide about household remittances | Majority1 →1;half2/few3/almost-none4/unknown98 →0. Perceived community norms are not observed household autonomy. |
| q9_17_1, _2, _3 | Hypothetical consequences of refusing to share PIN/OTP/telephone for remittance management | No selected code1/2/3 →1;any positive sum →0. **Code1 means “Nada (no pasaría nada)”**, while2/3 mean discussion/anger and restricted access to money. |
| q9_21_1, _2, _3 | Changes that would make digital payments safer and avoid household conflicts | No selected code1/2/3 →1;any positive sum →0. These are requests for privacy, own credentials/biometrics and family education, not observed coping actions. |

All scalar scored items and q9_17 are required within `/Confianza` when `eligible_flag=1`. The actual eligibility requires consent, being a woman, age≥18 and household international-remittance receipt in the past12months. It does **not** require owning an account or using digital payments.

The required q9_21 follow-up is shown only when **q9_20=1**, reporting avoidance of digital payments/apps because of feared household conflict. Thus **48 coded respondents have applicable q9_21 answers and 375 have structural skips**. These skips are not item nonresponse. No legal q9_21/code98 is invented.

q9_17 permits code4 (mobility/communication restriction), code5 and refusal98. In the earliest version, code5 means **Other (specify)**; in later versions it means **None of the above**. Code1 “nothing would happen” remains unchanged in all five versions. q9_21 also permits coercion support4 and Other5. Neither multiselect has a mutual-exclusivity constraint: legal code combinations must not be silently recoded as impossible.

Stata checks the actual source dimensions **490×267 raw, 490×266 audit and 423×439 coded**, unique nonmissing keys, legal version-specific domains, consent/eligibility ancestry, applicable/nonapplicable responses and actual dummy membership. The definitive safe exports contain **90 question checks, 147 domain rows, 390 routing/dummy checks and 57 keyed source checks**. There are no illegal answers, applicable missing responses, answers outside relevance, applicable dummy-membership disagreements or keyed source-input differences in the inspected contract. Nonapplicable q9_21 dummies remain missing in raw/audit/coded sources.

## 3. Exact current recipe and observed reference support

All **23 ordered current scoring operations** independently match the native source at Preparation lines2018–2064 and the authentic d119b22 recipe. Five binary components are averaged using available-component `egen rowmean`, stored as float `ICPF_raw`, then multiplied by100 into float `ICPF`. Fixed categories use **<40, [40,70), ≥70**, without a missing guard on the final high predicate. Ten fields are generated: five components, two rowtotals, raw/normalized scores and category.

The two rowtotals do **not** use Stata's `missing` option. An all-missing triad therefore sums to0 and receives a positive component. The current full-source-all-missing synthetic profile consequently has **two available positive components and ICPF=100/high**. Earlier three-component recipes instead have a missing aggregate score that the unguarded final predicate classifies high. Both are latent issues, not missing reference scores.

Every one of **423 reference respondents has all five generated components**. All **4,230 stored cells match exactly**, including float storage order and category. The historical reference mean is **66.5248239215102**, SD **17.9778353920279**, range20–100. These are properties of the current historical recipe, not a scientifically approved revised construct.

| Exact stored score | Reference count | Fixed category |
|---|---:|---|
| 20 |18|Low|
| 40 |55|Medium|
| 60.000003814697265625 |136|Medium|
| 80 |199|High|
| 100 |15|High|

Fixed counts are **18/191/214**. Empirical score-quantile groups are **209/199/15**, not equal-sized thirds, and differ from fixed categories for **390/423 assignments**. The high fixed group is not interchangeable with the upper quantile or median binary.

Independent reference support verifies the consequential mappings:

- **359 respondents** select “nothing would happen”; selecting code1 contributes to the adverse consequence sum, regardless of other selected codes.
- **Two respondents** select mobility/communication restriction4 without any of the three scored consequence codes, leaving the “no consequences” component positive.
- **Ten respondents** select refusal98 without a scored consequence code, also leaving that component positive.
- **Two respondents** select coercion-support mitigation4 without scored mitigation1/2/3, leaving “no mitigations” positive.
- All **375 structurally skipped follow-ups** receive a positive mitigation component; two of48 applicable respondents also receive it.

These are confirmed instrument–recipe inconsistencies or explicit policy concerns. They do not establish actual abuse, false respondent answers or any fitted-effect consequence.

## 4. Historical recipes, retained states and actual aliases

The source inventory reviews **28 preparation versions** and identifies **three distinct ordered recipes**. Captured-source-text SHA-256 values hash decoded/newline-normalized captured text, not literal Git blob bytes; Git object identities separately establish the authentic source location.

| Recipe | Operations/components | Historical policy |
|---|---|---|
| d119b22 |23operations/five components|Current three scalar components plus two rowtotal-derived components; fixed40/70.|
| b03b54d |15operations/three components|Trust, household norms and community only; neutral3 and community2/98 scored0; fixed40/70.|
| 95179b3 |15operations/three components|Neutral3 omitted in trust/norms; community2/98 omitted,3/4 scored0; fixed40/70.|

All **36 distinct preserved identities** are retained, including incomplete contracts; absent fields and noncontiguous IDs are not fabricated. **1,332 schema rows** cover37 candidate fields across36 states. **17 states** have the complete retained source/score contract; **323 keyed checks** establish their matching423 reference source rows/fields.

The current recipe is compared against **166 shared fields/70,218 cells**. Sixteen complete states match it exactly. State37's older three-component representation retains **408 raw-score, 408 normalized-score and89 category discrepancies**, **905 cells total**. Those discrepancies are preserved, not overwritten.

Across all three recipes, **370 shared-field comparisons/156,510 cells** and **51 state×recipe summaries** establish exact native compatibility for16 states with d119b22 and state37 with b03b54d. The earliest recipe is authentic but does not exactly reproduce a complete retained state. Shared-field compatibility cannot prove which code run originally generated a file, a unique producing execution, or downstream reload/estimator/exhibit parity.

Eight aliases are inventoried, including absent ones. **46 actually present state×alias fields/19,458 cells** match the source-local rules exactly:

- Standardized continuous `z_icpf`, `segz_icpf` and `zcl_ICPF`: only actual fields are tested.
- Fixed ordinal `lca_icpf3`; fixed-high `lca_icpf2` and `lca2_icpf_high`.
- Score-quantile `h_icpf3`, which is not fixed ICPF_cat.
- Median binary `h_icpf2`, using the actual source's serialized local median.

The reference exact and serialized median both equal **80**. There are **199 exact median ties**, **15 strict-above-median positives** and **zero serialization discrepancies**, including all five stored h_icpf2 states. The IEDF median-local discrepancy must not be imported into ICPF. Neither the fixed-high214 nor empirical-upper15 is a universal alternative recipe.

## 5. Independent controls and numeric/text read-back

The bounded synthetic design is explicit, not a claim to enumerate the entire original questionnaire or every legal multiselect Cartesian combination.

| Control family | Verified cases |
|---|---:|
| Every legal code of each of three scored scalars across five versions |75|
| Scalar legal/malformed/system/extended-missing controls |102|
| Six scored dummies, zero/positive/negative/fractional/system/extended missing |54|
| Representative complete binary profiles,32per version |160|
| Representative nine-input positive/negative/missing rectangle |19,683|
| Exhaustive five-component0/1/missing arithmetic patterns |243|
| Score-only float/40/70/extended-missing/out-of-range probes |12|
| All-source-missing cases across three recipes |27|
| Historical neutral/community/skip/consequence/preference/Other policy contrasts |42|
| Constant100 and constant0 samples |Four rows each|

Legal positive “no scored selection” multiselect profiles use real offered **code4**, not an invented none code; this explicitly exposes their semantic problem. Refusal/Other codes remain version-specific and are tested as policy contrasts, not silently interpreted as no conflict. The dummy controls show that missing triads become positive, positive malformed values can be penalized, and negative sums can omit a component. No domain/range guard is added to production.

Separate Stata read-back reopens **only aggregate/specification exports**, not participant sources, and does not call a driver recipe. It independently checks field/choice/routes, membership implications, weighted mean/SD, five-component arithmetic, factorized multiplicities, aliases, fixed/quantile comparisons, policy contrasts, extended missing values and every numeric CSV cell against its original text representation. It reconstructs the nine-input rectangle using **8 no-selected and19 positive-selected triad patterns** and three scalar positive/negative/missing choices.

Float storage order is consequential for exact replay but not a demonstrated category error here: direct versus ordered scaling differs in **136 scores**, raw versus scaled standardization in **353**, maximum standardized difference **2^-22 = 2.384185791015625e-7**, with **zero observed category precision differences**. Complete five-component means attain40 but not70; no legal ≤5-component arithmetic mean attains70. Arbitrary score-only boundary probes are not attainable legal-score evidence.

The audit's own first aggregate export used abbreviated display formatting, and its first independent run rejected shortened synthetic form-version identifiers. The root cause was localized to diagnostic export formatting; explicit full-precision numeric fields and integer form-version formatting were added only to ignored diagnostics. The final explicit Other/none parent-token expansion also exposed a diagnostic post-expression replacement error; the exact post-handle target was corrected. Original failed/superseded sources, receipts/logs and diagnostic-only cleanup are retained and excluded from acceptance. The final full driver and independent read-back both pass all standalone completion markers, normally close their logs and leave **only default0×0** in each task session.

## 6. Actual analysis consumers and LEGACY-A claims

Consumer locators identify actual native commands, not proof that historical fitted outputs or images reproduce. The analysis uses ICPF as a mean-by-IURD description (source Figure34), Pearson/correlation inventory member, raw and standardized OLS outcome, IAER predictor, IEDF×ICPF interaction predictor for IURD, high-autonomy logit predictor, standardized continuous clustering input and profile/segment outcome. Full raw and standardized ICPF models have corresponding IVS/IURD/IAFF/IEDF/IEH and demographic predictor blocks; neither has IADT. Source Figure48 is the standardized ICPF coefficient plot.

An independent prefix-aware scan inspects **all33 actual explicit GSEM bodies with no unresolved indicator macros**. **Eight M1/M2 bodies include lca2_icpf_high; eight H2/H3 include h_icpf3.** Other bodies, including the final preferred **H1**, exclude ICPF. **h_icpf2 appears in none of those GSEM bodies.** Candidate/core inventories do not establish fitted inclusion. Actual k-means/Ward score lists do include standardized continuous ICPF.

There is **no literal scored-input overlap** between IAER's scored scalar inputs and the five ICPF components. However, **q9_20 is IAER's avoidance item and ICPF's q9_21 route trigger**, creating explicit source-induced conditioning; common-module/common-method dependence remains relevant. ICPF's trust/norm scalar components are also mixed with conditional hypothetical/preference items. Same-input clustering and subsequent ICPF profiles are internal characterization, not independent external construct validation.

LEGACY-A block references and claims remain preserved for later quantitative interpretation and exact model/exhibit reconciliation:

- B00595 describes experienced negative consequences and being forced to use mitigation strategies. The questionnaire instead elicits hypothetical consequences and desired safety changes, while the current mapping penalizes “nothing would happen.”
- B00600 calls a descriptive group relationship robust/significant and infers a supportive ecosystem is necessary for intensive use. No significance test or necessary/causal relationship is established by this audit.
- B00743/B00753 interpret adjusted coefficient attenuation as mediation/explanation; cross-sectional attenuation is not by itself identified mediation.
- B00749/B00751 suggest formal access creates trust or null coefficients identify what shapes trust. Association and non-significance do not establish those causal or absence-of-effect conclusions.
- Manuscript Figure31 versus source Figure34, Figure43 versus source Figure48, and native .doc output versus appendix .txt paths are provenance locators. They do **not** prove missing figures, wrong image placement or successful original generation.

No legacy coefficient, p-value, standard error, plotted point, cluster allocation or class probability is certified or newly estimated. No substantive qualitative conclusion, quotation or expert assessment is changed.

## 7. Open scientific/revision findings

| Finding | Explicit later decision — not implemented |
|---|---|
| **ICPF-01** | Mixed provider confidence, household approval, perceived community norms, hypothetical consequences and requested safeguards require a defensible construct/estimand; they are not observed safety, harm or demonstrated protection. |
| **ICPF-02** | Correct the instrument–recipe polarity mismatch: code1 “nothing would happen” is penalized, while code4 mobility/communication restriction is excluded. Refusal98 and version-dependent Other/none5 need explicit policy. Preserve historical scores and evaluate revised consequences separately. |
| **ICPF-03** | Conditional q9_21 safeguards1/2/3 are penalized, coercion-support4/Other5 omitted, and375 structural skips awardedpositive. Define eligibility/denominator/conditioning and preference semantics before selecting any scientific correction; do not impute structural skips as answers. |
| **ICPF-04** | Available-component equal weights, pooling neutral/unknown, historical three-/five-term versions, normative40/70 thresholds and fixed/quantile/median/continuous representations need justification and sensitivity analysis. Native state compatibility is not original execution. |
| **ICPF-05** | Current all-source-missing100/high and older missing/high, malformed rowtotals, unguarded finite/range/category/constant-SD edges need explicit revised-code tests. Tiny precision differences and zero observed category impact do not certify statistical robustness. |
| **ICPF-06** | Actual M1/M2 fixed-high, H2/H3 quantile, preferredH1 exclusion and continuous clustering must be represented correctly. q9_20 source-induced conditioning and internal profile validation do not constitute literal scored overlap or external validation. |
| **ICPF-07** | Reconcile legacy harm/forced mitigation/significance/necessary ecosystem/mediation/null-effect/provider claims and actual figure/table/model artifacts in protected M6 and explicit M7. Do not rewrite qualitative findings or silently replace historical exhibits. |

## 8. Preservation, workflow and rendering closeout

Acceptance is bounded by fresh checks of **768 overlapping original-byte manifest records**, **688 prior-private fingerprints**, all prior public audit reports, all previous763 artifact pointers, **124 primary task IDs and14 milestones**, unchanged preamble/source/editor, clean staging and the exact six-file public scope. New pointers are appended without replacing prior evidence. Original-byte records overlap; this is not a claim of768 unique files.

The existing workflow contract and academic research skills route this retrospective audit without promoting formal Stage2: its entry helper fails because `01_proposal/proposal.md` does not exist. That formal prerequisite is recorded, not manufactured. Existing Graphify navigation is queried with the actual ICPF/trust/norms/climate terms only; no rebuild/reflection modifies earlier sealed evidence. Restricted form extraction uses local Stata plus an independent native metadata check, not an external form-upload tool. Stata execution remains the single statistical writer.

The same saved `main.tex` is updated in place, retaining its existing preamble and editor. A fresh built-in compilation attempt fails **before TeX preparation** because of the Windows helper setup-refresh failure. Compilation and PDF layout therefore remain **unverified**; no alternative compiler, replacement PDF or new tab is used. This external rendering limitation is separate from the successful bounded measurement checks.

The definitive actual tool receipts, closed logs, independent critic and final validation seal—not the bootstrap extraction or superseded attempts—are the basis of completion. All parent gates remain pending. No proposed correction has yet been introduced into the production preparation or analysis code.

## 9. Next immediate task and commit draft

**Next: M4.03.16 / M5.02.14 — historical IEH measurement audit**, beginning Preparation Section3.10 blockB (lines2114–2155). Seven granular children in the workplan cover the six information/cash-out/training/perceived-change/accompaniment/material-exposure terms, actual routes, historical recipes, alias/consumer roles, independent controls and preservation. Adjacent Section3.10 descriptive/program helpers are traced only where they are genuine dependencies; IBPD remains the subsequent separate construct audit. The IEH high predicate visibly has a missing guard; do not import ICPF's unguarded-high finding.

Remaining measurement/exhibit audits and protected historical M6 replication precede explicit M7 scientific revisions. Completing an audit child does not pass its parent.

**Proposed commit title**

`audit: complete bounded historical ICPF measurement review`

**Proposed commit description**

- Document M4.03.15.a/b and M5.02.13.a-e against five deployed definitions and LEGACY-A; preserve trust/norms/hypothetical-consequence/conditional-safeguard meanings, ancestry, version-specific Other/none and refusal policies.
- Record exact23-operation/ten-field/4,230-cell reference replay; retain code1 polarity, unscored restriction/refusal/support choices and375 structurally skipped-positive mitigation cases as open scientific findings.
- Reconcile36 identities,17 complete states,905 retained current-recipe discrepancies, three authentic recipes,156,510 variant cells and19,458 actually present alias cells without claiming original execution or fitted-result parity.
- Record independent Stata-only legal/malformed/routed/raw/arithmetic/ULP/extended-missing/constant and full-precision numeric/text read-back, repaired diagnostic-only version serialization, exact median80 and actual GSEM/clustering roles.
- Preserve768 original records,688 prior-private fingerprints, prior evidence/pointers,124 primary tasks,14 milestones, privacy and pending parent gates; update the same local TeX preparation record and record the native compiler limitation.
- Define seven bounded IEH children as the next immediate task; make no production/model/sample/qualitative/exhibit changes, participant exports, Git/cloud/history/Overleaf actions or public-release approval.

This is a draft only; no commit has been made.
