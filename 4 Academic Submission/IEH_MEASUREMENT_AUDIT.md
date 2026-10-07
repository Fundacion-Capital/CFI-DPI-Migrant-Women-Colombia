# Historical IEH measurement audit

**Checkpoint:** 7 October 2026; **M4.03.16 / M5.02.14**. Entry: clean main, commit `c639bdac60fa649edb379a429a24a9dfa4443503`, one worktree. This is a bounded historical audit, not a revised measurement, newly fitted analysis, scientific approval or public-release authorization.

## 1. Scope and acceptance boundary

The seven child tasks connect the author-selected **LEGACY-A original full draft (31 July 2026)**, five deployed SurveyCTO definitions, restricted historical raw/audit/coded sources, Preparation Section 3.10 B, three authentic historical recipes, all 36 preserved dataset identities and actual analysis consumers. **All respondent and synthetic statistics use Stata MCP only.** Native checks independently verify source/form metadata, source bytes, CSV structure and workflow boundaries, not respondent statistics.

Completion requires the definitive driver, separate independent specification/arithmetic/full-precision numeric-text read-back, independent critic and preservation checks. **M0 remains in progress; all parent scientific, design, method, quality, replication, ethics and release gates remain pending. Zero participant fields are approved for public release.** Exact replay establishes compatibility of inspected historical fields, not construct validity, a unique original producing execution, successful fitting or model/exhibit parity.

The ignored local packet is `audit-local/intake/ieh-c639bda`. It holds restricted aggregate/specification diagnostics, synthetic controls and source locators—not exported participant records. Production code, protected originals, prior packets, qualitative contributions, legacy results and exhibits remain unchanged. No staging, commit, push, history rewrite, cloud/access/visibility action, external form upload or Overleaf synchronization is included.

## 2. Five-definition instrument and protected input audit

The preserved deployed versions are **2512090157, 2512091719, 2512111044, 2512121811 and 2602120658**. Native OOXML extraction independently matches **155 specification rows and 449 choice rows** extracted through Stata, including group ancestry, consent/eligibility calculation, field types, own relevance, requiredness, constraints and choice filters.

| Scored input | Actual meaning and legal codes | Current positive rule |
|---|---|---|
| q10_4 | Reported amount of information: none1, very little2, some3, much4 | 3/4. “Some” is not independently demonstrated sufficiency or literacy. |
| q10_6 | Cash-out: rapid/no extra cost1, rapid/with cost2, slow/with cost3, slow/no cost4, no nearby option5, unknown/does not recall98 | 1/2. This prioritizes speed/availability, not uniformly low cost or absence of friction. |
| q10_10 | Recalled training: within last12months1, more than12months ago2 within the question's three-year window, never3, unknown98 | 1/2. Recalled exposure is not measured effectiveness. |
| q10_12 | Perceived willingness after most recent training: much less1, somewhat less2, **no change3**, somewhat more4, **much more5** | **3/4; code5 receives0.** This contradicts the “positive change” interpretation. |
| q10_13 | Individual accompaniment in last12months: yes1, no0, prefers not to answer98 | 1; refusal98 receives0, not an observed absence of support. |
| q10_16 | Educational materials exposure in last12months: always1, often2, rarely3, never4, unknown98 | 1/2; unknown98 receives0. Exposure is not demonstrated comprehension or assimilation. |

All six are required select-one questions in `/Barreras` when `eligible_flag=1`. The actual eligibility combines affirmative consent, woman code1, age≥18 and household international-remittance receipt in the preceding12months; it does **not** impose own-account or digital-use eligibility. Scalar constraints and choice filters are blank. The other five scored inputs have no additional own relevance.

**q10_12 and the unscored q10_11 provider follow-up apply only when q10_10=1/2.** They apply to186 coded respondents;237 others are structural skips, not item nonresponse. The unscored q10_14 provider follow-up applies only after q10_13=1, to146 respondents. Neither provider field is added to IEH.

All six scored questions/choice labels are stable across the five definitions. Unscored version drift is explicitly retained: q116/code10 means Other (specify) in the first two definitions and None of the above in the later three; q125/code6 changes Other (specify) to Other entity. Full scoped choices are therefore **not all version-stable**.

Stata checks **490×267 raw, 490×266 audit and 423×439 coded** sources; unique nonmissing keys; actual versioned legal domains; eligibility and own routes; and keyed shared inputs. **120 question checks,329 domain rows,120 routing checks and45 keyed source checks** show no illegal nonmissing answers, missing applicable responses, responses outside relevance or shared-input differences in the inspected contract. These checks do not certify uninspected questionnaire fields.

## 3. Exact current recipe and reference support

All **12 ordered value operations** match native Preparation lines2118–2151 and the authentic d119b22 recipe. They produce **six binary components, IEH_raw, IEH and IEH_cat: nine fields**. Every nonmissing input not in the positive set receives0; genuine ordinary/extended numeric missing remains missing.

The available-component `rowmean` is stored as float `IEH_raw`, then multiplied by100 into float `IEH`. Fixed categories are **<40, [40,70), ≥70**, with an explicit **`!missing(IEH)` high-category guard**. The current source therefore leaves a wholly missing score/category missing. Do not import ICPF's current unguarded-high finding into IEH; the two older IEH recipes do have unguarded high rules.

All **3,807 reference cells (423×9)** reproduce exactly. The historical normalized mean is **47.1788816249117**, SD **24.3736770823019**, range0–100, with no wholly missing reference score.

| Reference property | Count |
|---|---:|
| Six available components |186|
| Five available components, q10_12 structurally absent |237|
| Positive information / cash-out / training components |138 /354 /186|
| Positive perceived-change component among186 applicable |92|
| Positive accompaniment / materials components |146 /204|
| Fixed low /medium /high |131 /230 /62|
| Empirical quantile low /middle /upper |199 /103 /121|
| Fixed versus empirical assignment disagreements |127|
| Exact stored score40 /score70 |68 /0|

Conditional weighting differs: each observed term weighs1/6 for trained respondents and1/5 for others. Training exposure also determines whether the change term exists. This is a measurement/estimand decision, not authority to impute an unasked change response as zero.

The current change term awards1 to **14 “no change”** and78 “somewhat more” responses, but0 to **56 “much more”** responses. The first group is not positive change; the latter is the strongest stated increase. These are component-level mapping discrepancies, not a quantified effect on fitted coefficients, class assignments or final paper conclusions.

Cash-out code2 (rapid with cost) occurs177 times and code4 (slow without cost)23 times. Cash-out unknown98 occurs7 times, training unknown98 27, accompaniment refusal98 12 and materials unknown98 16. Current zero policies must not be described as verified absence or objective adverse conditions.

## 4. Authentic recipes, all retained states and actual aliases

The source inventory examines **28 historical Preparation versions**, identifying three distinct ordered recipes. Captured-source SHA-256 hashes identify decoded/newline-normalized captured text, not literal Git blob bytes; native Git object/source retrieval independently verifies authenticity and exact operation order.

| Recipe | Operations | Meaningful differences |
|---|---:|---|
| d119b22 |12|Current all-nonmissing-other-code zero policy and guarded high category.|
| 6376fcf |24|Explicit positive/negative sets; cash-out98 and change5 remain missing; training1/2 positive; other named unknown/refusal codes zero; unguarded high.|
| d130a4f |24|Training1 positive,2 zero,3/98 omitted; cash-out98/change5/accompaniment98/materials98 omitted; unguarded high.|

All **36 preserved identities** remain, including noncontiguous IDs and incomplete source/score/alias contracts. **1,188 schema rows** cover33 candidate fields per state; absent fields are not generated. **17 complete states/255 keyed checks** match the423-row reference input contract.

Current nine-field comparisons cover **153 state×field comparisons/64,719 cells**. Sixteen complete states match exactly. Older state37 retains **196 discrepancies**:7 cash-out components,56 change components,60 raw scores,60 normalized scores and13 categories. These are preserved, not repaired. The historical source comparison covers **459 fields/194,157 cells** and51 state×recipe summaries; sixteen states match d119b22, state37 matches6376fcf. The earliest authentic recipe does not exactly match a complete retained state. This is compatibility, **not a unique original code-run certificate**.

Nine alias names are inventoried, with **59 actually present state×alias fields/24,957 cells** matching their source-local rules:

- `z_ieh`, `segz_ieh` and `zcl_IEH` standardize the stored normalized IEH.
- `lca_ieh3` copies valid fixed IEH_cat; `lca2_ieh_adequate` maps fixed medium/high to1 and low to0.
- `h_ieh3` uses empirical `xtile IEH,nq(3)`, not fixed categories.
- `any_training_3y`, `recent_training_12m` and `individual_support` use direct profile rules; training unknown98 and accompaniment refusal98 remain missing, unlike their IEH component zero policies.

**There is no actual current IEH median-binary recipe.** A clearly hypothetical serialization probe finds exact/local median50,56 ties and0 differences; it is not an authentic alias or model specification. Fixed, binary, quantile and continuous representations remain distinct.

## 5. Independent legal, arithmetic and precision controls

Separate Stata read-back opens only diagnostic aggregates, form metadata and synthetic controls, not respondent sources; it does not call driver recipes. It independently reconstructs current/historical synthetic formulas, available denominators, legal version routes, weighted reference mean/SD and categories, and separately verifies the reported state-alias contract aggregates. It does not independently recreate participant-level alias fields: that comparison is performed by the driver against source-local recipes, with an independent native source review. Every numeric cell in the statistical/specification CSV exports is checked against original CSV text at full precision. Source-only consumer locators and protected-state path catalogues are separately checked natively, not treated as statistical exports.

| Control family | Cases |
|---|---:|
| Complete six-scored-input legal Cartesian grid under the training-change route |21,600:4,320 per definition|
| Representative positive/negative/missing six-raw-input rectangle |729|
| Exhaustive six-component0/1/missing arithmetic grid |729|
| Five-version, six-item legal/malformed/sentinel/system/extended-missing probes |510|
| All-source system/extended-missing profiles |27|
| Arbitrary score-only40/70 epsilon/ULP/missing controls |39|
| Constant40 sample |Six rows, one aggregate summary|

The legal grid covers all offered codes of **six scored fields**, not the whole questionnaire, provider choices or unscored multiselect Cartesian combinations. Raw rectangles and malformed probes are arithmetic/domain controls, not assertions that every synthetic profile obeys the survey routes. Structural skips remain distinct from unknown/refusal code98 and numeric missing ./.a–.z.

Available-component arithmetic can attain40 (two positives among five terms) but cannot attain70 with at most six binary terms. Complete six-term means attain neither40 nor70. Arbitrary score-boundary controls are separate from attainable-score evidence. All27 wholly missing profiles preserve current missing raw/score/category; older unguarded recipes classify the missing score high. Constant standardization is missing; finite/range/constant-SD protections remain later decisions.

Float order is required for exact replay: direct versus ordered scaling differs in167 reference scores, raw versus scaled standardization in291, maximum standardized difference **2^-23 =1.1920928955078125e-7**, with **zero observed precision-induced category changes**. This is not evidence that scientific/model robustness is established.

Diagnostic failures were repaired only in ignored audit code: undeclared route post-handle, caller-local export-path scope, literal quote escaping, an overbroad provider-choice stability assertion and an overlength scalar name. The rerun frame-collision receipt is also retained. Version-dependent unscored choice labels were corrected in assertions, **not in source forms/data**. Superseded sources/logs/receipts where captured remain excluded from acceptance. The definitive full driver and independent read-back pass all standalone markers, close their logs normally and each leave **only default0×0**.

## 6. Actual consumers, shared inputs and LEGACY-A interpretation

Native locators and a prefix-aware scan inspect **33 actual explicit GSEM bodies with no unresolved indicator macros: none includes an IEH-family input**. IEH categorical/core feature declarations do not imply fitted M1–M4/H1–H4/final-H1 inclusion. In particular h_ieh3 is not a final-H1 class-defining input.

Actual source uses IEH for descriptive/correlation inventories, raw and standardized regressions as outcome or predictor, interaction/model comparisons, class/segment profiles and outcome overlays. Raw/full-standardized IEH comparisons have other specification differences and are not certified as unit-only re-expressions. `segz_ieh` genuinely enters the k-means/Ward continuous-score input bodies. Appendix C includes IEH and direct training/accompaniment summaries. These are actual source roles, not successful historical fitted-result or exhibit-value proof.

IEH and the separate IBPD score **literally share q10_4, q10_6 and q10_16**. The training/accompaniment direct profile aliases also share IEH source items but differ in unknown/refusal policy and denominator. Their correlations/profiles cannot be called independent external validation. “External outcome” means external to the final class-defining feature set, not external sample, independent measurement or identified causal effect.

Adjacent Section3.10 A has a separate actionable **enabler source-label mismatch**. q116 codes2/3/5/6/7 mean trusted accompaniment, lower/clearer fees, biometrics/PIN, nearby agents and QR merchant acceptance. The enabler helpers instead label them lower fees, better FX, more merchants, help opening an account and better internet. “Better exchange rate” is not an actual offered q116 option. Codes8/9 and Other/none10 are not in those seven helpers. This is not an IEH score input and does not, by itself, certify the rendered figure's values.

Unscored provider groups are researcher classifications, not verified institutional regulation/formality; Other provider is not automatically informal, nor community promoter verified formal. Displaying the first six q10_17 topics does not enumerate its Other7 choice.

The independent LEGACY-A extraction verifies all238 scoped block texts. Open reconciliation points include:

- B00605's “transparent information”/“frictionless cash-out” exceed the subjective-information and speed/cost items.
- B00609/Figure33 caption B00610's lower-fee/better-FX interpretation requires an exhibit-specific source-label reconciliation.
- B00645 and regression interpretation of an enabling environment do not establish institution-level or causal support/program effects.
- B00799/B00820/B00853 profiling and external-validation language describes same-survey/sample evidence, not independent validation.
- B00863/B00868 direct training/accompaniment profiles have distinct windows and sentinel denominators; B00824/B00826/B00827/B00865/B00878 numerical claims await model/exhibit parity.

No historical coefficient, standard error, p-value, graph, cluster/class allocation or causal program effect is certified or newly estimated here. No qualitative quotation, substantive migrant/coauthor finding or expert assessment is changed.

## 7. Open scientific/revision findings

| Finding | Explicit later decision—not implemented |
|---|---|
| **IEH-01** | Justify a construct mixing recalled training, individual support, reported information, material exposure and conditional perceived willingness, with different windows/referents; do not equate it with demonstrated knowledge, institutional quality or program effectiveness. |
| **IEH-02** | Resolve q10_12's verified positive-change mapping conflict: no-change3 positive, greatest-increase5 zero/current or omitted/old. Preserve history and evaluate revised consequences separately, rather than silently altering scores/results. |
| **IEH-03** | Define the estimand and weighting of training-dependent five-/six-term denominators. Keep237 structural skips distinct from omissions and unknown training; no unasked-change imputation. |
| **IEH-04** | Justify “some” information, speed/cost ordering, recalled training pooling and item-specific unknown/refusal zero policies. Direct profile aliases and older recipes use different sentinel denominators. |
| **IEH-05** | Preserve three authentic recipes, state37's196 discrepancies, fixed/quantile/continuous distinctions and normative40/70 thresholds; compatibility is not original execution or model robustness. |
| **IEH-06** | Current high guard is correct for missing, but older high guards, legal-domain/range/finite/constant-SD protection and available-case edge policies remain open. Small precision differences do not validate the construct or fitted consequences. |
| **IEH-07** | Correctly distinguish zero actual IEH GSEM inputs from declarations, actual continuous clustering, outcome overlays, shared IBPD items and same-input profile aliases; do not claim external/causal validation. |
| **IEH-08** | Resolve adjacent enabler2/3/5/6/7 label defects, versioned Other/none/provider wording, grouping claims and LEGACY-A transparency/friction/FX/validation language in exact protected exhibit and explicit M7 revisions. Qualitative content remains protected. |

## 8. Preservation, workflow and rendering

Fresh acceptance retains **768 overlapping original-byte manifest records**, **786 prior-private fingerprints**, previous public audit reports and all previous862 artifact pointers, **124 primary task IDs and14 milestones**, unchanged pending gates and zero public-approved participant fields. Counts are manifest/fingerprint records, not768 unique original files. The exact public scope is this report plus README, workplan, measurement register, workflow state and the existing main.tex.

The established academic workflow is reused without fabricating its missing formal Stage2 proposal prerequisite or passing a parent gate. Local restricted form extraction plus native OOXML avoids unauthorized third-party form upload; source/Git/form metadata checks do not replace Stata statistical checks.

The existing main.tex is updated in place with its preamble/editor preserved. **Fresh built-in compilation fails before TeX preparation because of the Windows helper setup-refresh failure; compilation and PDF layout remain unverified.** No alternative compiler/PDF/tab or live Overleaf change is used. This rendering limitation is separate from bounded measurement validation.

The final actual receipts, independent review and fingerprint/pointer closeout—not failed probes or wrapper-only success—form the acceptance basis. No scientific correction is introduced in production.

## 9. Next immediate task and commit draft

**Next: M4.03.17 / M5.02.15 — historical IBPD measurement audit**, beginning Preparation Section3.10 C, lines2159–2200. Seven granular children cover main/additional barriers, the actual scored dummy selection, information/cash-out/material inputs, version codes/routes, rowtotal/available-case policies, authentic recipes/aliases/consumers, independent controls, exact legacy reconciliation and preservation. The shared IEH items are a documented dependence, not an already accepted IBPD audit.

Remaining measurements/exhibits and protected historical M6 replication precede explicit M7 scientific corrections. A bounded audit child never passes its parent.

**Proposed commit title**

`audit: complete bounded historical IEH measurement review`

**Proposed commit description**

- Complete M4.03.16.a/b and M5.02.14.a-e against five deployed definitions, actual routes and LEGACY-A; retain reported information, speed/cost, training, conditional willingness, accompaniment and material-exposure meanings.
- Record exact12-operation/nine-field/3,807-cell replay; preserve q10_12's no-change/greatest-increase conflict,237 structural skips, five-/six-term weights and unknown/refusal policies as open scientific findings.
- Reconcile36 identities,17 complete states,196 preserved state37 discrepancies, three authentic recipes,194,157 variant cells and24,957 actually present alias cells without claiming original execution or fitted-result parity.
- Record independent Stata-only21,600 legal version-routed controls,729 raw/729 arithmetic cases,510 single-item,27 missing,39 boundary and constant controls; full-precision specification/weighted/numeric-text read-back and closed empty sessions.
- Distinguish zero IEH inputs in33 actual GSEM bodies from declarations, actual continuous clustering and same-survey outcome/profile overlays; retain IEH–IBPD shared inputs and adjacent enabler source-label defects.
- Preserve768 original records,786 prior-private fingerprints, prior evidence/pointers,124 primary tasks,14 milestones, privacy and pending gates; update the same local TeX preparation record and document the fresh compiler limitation.
- Define seven bounded IBPD children as the next task; make no production/model/sample/qualitative/exhibit changes, participant exports, Git/cloud/history/access/Overleaf action or public-release approval.

Draft only; no commit has been made.

