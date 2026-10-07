# Historical IETR measurement audit

M4.03.11 / M5.02.9 — 7 October 2026

## Acceptance boundary

This checkpoint accepts seven bounded historical source, instrument, domain, replay, control, consumer and preservation children. It does **not** validate or approve IETR as a construct, choose a new scoring policy, re-estimate a model, certify an original exhibit or pass a parent scientific/public-release gate. Acceptance requires the definitive Stata MCP responses, normally closed logs, separate read-back, independent critic and fresh native closeout in the ignored evidence directory. Entry was clean `main@0452e40f27802fe0da6e2e0ff447d8f3a44eadea`.

Production code/data, preserved sources, LEGACY-A, earlier audits, historical outputs and protected qualitative findings remain unchanged. No participant-level derivative/export, source copy/delete, stage/commit/push, cloud/access/visibility change or Overleaf synchronization is included. Public reporting contains safe aggregate diagnostics and source interpretation, not keys, contact information, free text or restricted absolute source paths. Actual privacy/release approval remains pending.

## 1. Instrument and source contract

Current source: Preparation Section 3.7 block C, P1680–1783. Analysis consumer specifications are checked against the actual commands, not just variable inventories, diagram nodes or prose. All respondent-level, statistical and synthetic computations use **Stata MCP only**. Existing source/hash/OOXML and preservation helpers are reused for structural/provenance checks; Graphify is navigation only.

The five preserved instrument versions are **2512090157, 2512091719, 2512111044, 2512121811 and 2602120658**. Stata retains **233 specification and 615 choice rows**, including balanced full group ancestry, settings versions, requiredness, constraints, filters and appearance. A separate native XLSX read checks every scoped exported specification/choice row against the pinned definitions exactly. Scoped item/choice semantics and ancestry are stable across these five versions; physical row changes are not semantic changes. This does not verify historical server/export settings or prove any unique producing execution.

The `Remesas` group opens when `eligible_flag=1`: consent, woman, age at least18 and household overseas-remittance receipt in the last12months. Principal receiver/manager q6 is **not** in that calculation; q6 itself is under consent/Elegibilidad with q5 relevance. No account-ownership or digital-rail requirement is added to the group. q6_4 describes the latest receipt channel; q6_5 requires bank/wallet receipt. Neither gates the three scored latest-remittance items.

The optional q6_14 asks about **domestic digital payments/remittances in the last60days**; Yes1, No0, refusal98 and blank are distinct. q6_16/17/18/20/21/22/23/24 are required when q6_14=1. The remittance items q6_6/9/11 remain scoreable without recent domestic digital activity.

| Final component | Instrument meaning | Current source mapping |
|---|---|---|
| `ietr_time` | q6_6: latest international remittance arrival-to-usability time; codes1–5 increase delay;98 unknown. | 1/2/3/4/5→100/80/60/30/0;98 omitted. |
| `ietr_cost` | q6_9: latest international FX clarity, with99 not applicable. q6_18: upfront fee visibility for latest domestic digital operation;4 no fee applied,98 unknown. | q6_9:1 or99→100,2→50,3/4→0. q6_18:1→100,2→50,3/4→0. Inner available-case mean. |
| `ietr_confirm` | q6_11: confirmation by SMS, app, **paper** or email (1–4), none5, unknown98. q6_20: domestic digital confirmation immediate1/later2/none3/unknown98. | q6_11:1≤code<5→100,5 or undeclared6→0. q6_20:1→100,2→50,3→0. Inner available-case mean. |
| `ietr_problem` | q6_16: resolved same day1, resolved late2, unresolved3, no problem4, unknown98. | 1→75,2→25,3→0,4→100;98 omitted. |
| `ietr_limits` | q6_17: limits prevented completion of a digital operation (1–3), never4, unknown98. | 1–3→0,4→100;98 omitted. Not absence of all provider limits. |
| `ietr_speed` | q6_21: general perceived digital speed;1–5 increasing delay,6 variable/unpredictable. | 1/2/3/4/5→100/80/60/30/0; **legal6 omitted**. |
| `ietr_surcharge` | q6_22: merchant QR/transfer charge comparison: extra1, same-as-cash2, discount3, unknown98, not applicable/nonuse99. | 1→0,2/3→100;98/99 omitted. Not all transaction fees. |
| `ietr_clarity` | q6_23: general provider information clarity about limits, hours, fees and crediting. | 1→100,2→50,3/4→0. |
| `ietr_eval` | q6_24: global digital-service experience over60days, very bad1 through very good5. | 1/2/3/4/5→0/25/50/75/100. |

Two source labels/comments reverse fee and FX: temporary `ietr_cost_fee` actually uses q6_9 **FX** clarity, whereas `ietr_cost_fx` actually uses q6_18 **fee** visibility. The genuine domestic FX question q6_19 is not scored. q6_9 code99 means not applicable, **not no fee**; it gets100. q6_18 code4 means no fee applied and gets0. These are real semantic/polarity issues, not permission for automatic recoding.

q6_18 literally refers to **90days**, despite the60day gate and q6_16/q6_24 wording. q6_11 tests confirmation receipt/modality, not timely confirmation; paper receives the same100 as a digital notification. Code6 does not exist in any of the five q6_11 choice lists. Current relational scoring also admits undeclared fractional values in1≤code<5; synthetic malformed-value tests demonstrate this without asserting observed illegal codes.

## 2. Protected sources, domains and routing

Fresh dimensions are raw workbook **490×267**, audit DTA **490×266**, retained coded reference **423×439**. Protected key uniqueness/coverage, eligibility and equality of **21 scoped source fields** are checked in memory. No keys or free-text participant fields are exported.

There are **15 contextual scalar questions**, not16: q6, q6_4, q6_5, q6_6, q6_9, q6_11, q6_14, q6_16, q6_17, q6_18, q6_20, q6_21, q6_22, q6_23 and q6_24. The separate read-back accepts **225 question, 480 routing and 66 protected-source check rows**, plus source-specific legal-code counts. Illegal nonmissing codes, answers outside relevance and required applicable nonresponse are zero in this scope. q6_14 has four applicable optional blanks.

Source-specific applicable counts remain explicit: q6=426 raw/audit versus423 retained; latest receipt channel and scored remittance items=423; provider q6_5=246; recent domestic digital branch=368. The branch is not the denominator of every IETR input or every score.

Retained legal responses include:

- q6_6 unknown98:11; q6_9 not applicable99:29.
- q6_11 none5:26, unknown98:9, undeclared6:0.
- q6_14 Yes368, No45, refusal6, blank4; **55 structural domestic-child skips**.
- q6_18 no fee4:22 and unknown98:10; q6_20 unknown98:7.
- q6_21 variable/unpredictable6:3; q6_16 unknown98:8; q6_17 unknown98:14.
- q6_22 unknown98:89 and not applicable/nonuse99:21.

Unknown, refusal, not applicable, structural nonrelevance and ordinary missing remain separate. None is automatically imputed, dropped, renamed “invalid” or treated as evidence of respondent error. There is no scored multiselect/dummy in this recipe.

## 3. Exact current replay, weights and representations

**56 value operations and two temporary-drop statements, all58 in exact source order**, reproduce **12 stored fields ×423=5,076 cells** exactly, including missingness. The twelve fields are nine final terms, raw `ietr_score`, normalized `ietr_score_01` and fixed `ietr_cat`. Four temporary inner terms are dropped. Current defaults and generated numeric storage are float; historical byte/double storage is separately inventoried.

The ordered outer mean is time, cost, confirmation, problem, limits, speed, surcharge, clarity and evaluation. It averages **available final terms**, then divides the stored raw float by100 and stores normalized float. This is **not an equal eleven-item average**.

Let n be the number of available outer terms, and k the number of available inputs within an inner term. An observed singleton contributes1/n; a contributing cost or confirmation input contributes1/(n×k). At full completeness, each singleton has1/9 and each nested input1/18 weight. When one nested input is absent, its partner receives that whole term's weight; when an outer term is absent, all remaining terms' weights increase. No missing components are assigned zero by the current available-case mean.

| Available final terms | Retained records |
|---|---:|
| 1 | 5 |
| 2 | 4 |
| 3 | 46 |
| 4 | 0 |
| 5 | 1 |
| 6 | 3 |
| 7 | 12 |
| 8 | 103 |
| 9 | 249 |

All423 totals are nonmissing, but **174 are incomplete nine-term profiles**. All55 non-Yes recent domestic-use cases have at most three available outer terms. Cost uses two inputs in358 and one in65; confirmation uses two in360, one in55 and none in8. Thus a nonuser's score is not the same content/weight profile as a fully observed recent user's score. Legal scored-input controls include a nonuser with remittance time/confirmation unknown and FX not applicable: its single available term gives100/high. This is a legal scoring consequence, not proof that the person enjoyed uniformly excellent digital transactions.

Observed raw mean/SD are approximately **71.8860930495 /15.2534909417**; normalized mean/SD **0.7188609262 /0.1525349114**. Separate frequency-weighted aggregate reconstruction checks both means and sample SD within explicit numerical tolerances; full-precision source/round-trip diagnostics remain private.

Fixed raw categories are **<45 /[45,85) /≥85**: **13/318/92** records. Empirical terciles are **142/142/139**, with **176 different assignments**. One exact45 and one exact85 score classify correctly. Fixed-quality thresholds, empirical quantiles, continuous values and standardized aliases are different representations, not interchangeable labels.

Observed ordered raw-float-then-normalized versus direct double-mean normalization differs in **117** records. Raw-score versus normalized-score float standardization differs in **347**, maximum **2.384185791015625e-7**. Observed category precision disagreements are zero. Exact source-specific aliases still match their own recipes; no fitted consequence or robustness claim follows.

The current category's `>=85` predicate lacks a nonmissing guard. Full-source-missing controls produce missing current score/normalization but **high category** because of Stata numeric-missing ordering. This is latent: no reference total is missing. Undefined standardization in constant samples is separately demonstrated. Neither guard has been installed in production.

## 4. Preserved-state and authentic historical recipe reconciliation

The unchanged catalogue contains **36 unique data identities**. **1,476 schema rows** cover actual present/absent/numeric/storage states; **17 complete retained states** are replayed, with **374 protected key/input checks** and no source-input differences. Incomplete states remain inventoried, not artificially completed or assigned invented fields.

The current recipe compares **202 available fields /85,446 cells** and retains **1,813 exact discrepancies**. They are not suppressed:

| State grouping | Current-versus-stored result | Exact native-source-compatible recipe |
|---|---|---|
| 2–11,35,36 (12 states) | All12 shared fields exact. | d119b22 current nine-term, no-confirm5→0,45/85. |
| 32,33,38,39 (four states) | Each83 differences: confirmation26, raw26, normalized26, category5. | a00115e nine-term, legal no-confirm5→100,45/85. All12 shared fields exact. |
| 37 (one state) | 1,481 current differences across eight changed fields; surcharge/clarity absent. | ad2205e seven-term joint/default policy,40/70; **11 shared fields including historical raw-score standardization** exact. |

Five distinct source recipes are captured from **28 native Preparation source versions** and independently checked against read-only Git content and the actual diagnostic programs. Value/drop order is exact:

| Native source | Value operations /drops | Policy distinction |
|---|---:|---|
| d119b22 |56/2| Current nine-term, no-confirm5→0,45/85. |
| a00115e |56/2| Nine-term, no-confirm5→100,45/85. |
| b03b54d |56/2| Same positive no-confirm rule,40/70 categories. |
| ad2205e |42/0| Seven-term joint cost/confirmation, unknown/missing default behavior, raw standardization,40/70. |
| d130a4f |41/0| Earlier seven-term, different joint cost/problem rules, raw standardization,40/70. |

All **85 state×recipe comparisons**, **948 field comparisons /401,004 cross-recipe cells** are retained. Matching native recipes yield **203 shared fields /85,869 exact cells**, including the older raw standardized field. Compatibility does not establish the unique producing commit, original execution, settings, estimator or exhibit.

Historical policies cannot be flattened into the current one. In ad2205e, the best-cost100 replacement is overwritten by75 and a25 rule by a later0 rule; d130a4f overwrites best-cost100 with60. Both use unguarded relational comparisons that include numeric missing, producing available zero components and score0/low from entirely absent source inputs. Three later nine-term recipes instead produce missing/high from full absence. Older problem/confirmation mappings also differ. These are audited source consequences, not corrections or proposed point policies.

**33 available alias checks /13,959 cells** match each stored state's own source-compatible representation: lca_ietr3 nine states, lca_ietr2 nine, zcl_ietr_score_01 nine, h_ietr3 five and segz_ietr one. Absent z_ietr or other fields are not invented. Fixed three-/two-category aliases, empirical terciles and normalized standardization are checked separately; old raw-score standardization is not silently equated to a normalized-float alias.

## 5. Bounded controls and independent read-back

Definitive driver and separate read-back run through Stata MCP. Controls distinguish legal questionnaire support, partial projections, arithmetic support and malformed/source-absent behavior:

| Control | Cases | What is established |
|---|---:|---|
| Single-item controls |113| Literal legal, unknown/N/A, undeclared, fractional and ordinary/.a/.z missing mappings; current phantom6 and1.5 behavior included. |
| Cost/confirmation raw rectangles |121/120| Inner means and missingness over deliberately broader raw domains; **not wholly legal routed support**. |
| Legal routed cost/confirmation pair projections |40/42| Relevant left/right input domains and recent-use child skips; not complete questionnaire records. |
| Legal routed scored-IETR bundles |20| All scored inputs/gate coherent, best/worst, attainable45/85, unknown/nonuse and nested omissions. Not every survey question. |
| Nine-component arithmetic rectangle |1,399,680| Exhaustive finite component/missing support and outer arithmetic. **Not all legally co-attainable survey responses**. |
| Score-only boundary controls |9| 45±2^-18,85±2^-17 and ordinary/.a/.z missing storage/category behavior; not claimed legal-response perturbations. |
| Current full-source absence |3| Missing total/high category; no observed contamination claim. |
| Five historical recipes ×full-source absence |15| Different later missing/high and older false-zero/low policies. |
| Five historical best bundles |5| Older cost overwrite versus current100, preserving actual source order. |
| Constant legal endpoint samples |Two samples, two records each| Both raw and normalized standardizations undefined; endpoints0 and100. |

The arithmetic rectangle has **221,846 ordered/direct normalization differences**, zero category precision disagreements and one all-component-missing high-category case. These are numerical/component controls, not participant counts or proof that every component combination is attainable.

Independent read-back checks full specification/code/ancestry, source-specific applicability, legal-code counts, nested denominators/weights, weighted moments, current/historical field identity, source compatibility, source-specific aliases, legal/malformed/missing fixtures, precise scientific-notation and string round-trips. Its expectations are not copied from the replay's output values.

The read-back initially rejected incorrect audit assumptions:15 scoped scalar questions rather than16; four older confirmation-rule states rather than one; and actual CSV column locations for string-preserved missing codes. It also caught a **diagnostic** string field too short for full-precision synthetic boundary notation. Only ignored audit expectations, string-column imports and that audit string storage were corrected; all affected definitive runs were rerun. Failed/superseded receipts are retained separately and **excluded from acceptance**. Production calculations remain unchanged.

Definitive driver/read-back logs close normally, actual MCP responses contain required completion markers, and fresh probes show both task sessions have only the default0×0 frame. No protected participant dataset remains in those task frames.

## 6. Actual consumers and LEGACY-A interpretation

Analysis lines are source locators, not fit/output receipts:

- A587–606 describes normalized IETR; A1187–1236 standardizes normalized scores. A1404/1410/1416/1422 uses normalized IETR as OLS outcome. The raw full ModelD's block includesIADT; **A1429's standardized coefficient model omits z_IADT**, so it is not merely the same model rescaled. A1773–1794 uses IETR as the ICDP×OQI interaction outcome. Coefficients, standard errors, samples, significance, margins and plotted content are not recertified here.
- A4488–4499 creates fixed lca_ietr3/lca_ietr2; expanded inventories/families/completeness diagnostics contain candidates, not proof of their fitted inclusion. All **33 explicit GSEM command bodies** inspected contain no IETR manifest term. Preferred final H1 A8816–8829 uses seven other indicators.
- A7749 generates h_ietr3 by empirical xtile, and the hybrid distribution export retains it. It is **absent from preferred H1/final H1_k4** and is not the fixed-category alias.
- The full standardized benchmark inventory includes zcl_ietr_score_01; the reduced set excludes it. Actual k-means4/k-means5, fallback calls and Ward A7185–7264 include **segz_ietr**. Declaration and operative command membership are kept distinct.
- Continuous IETR is used in same-sample post-assignment centroids/profiles, segment outcome tests and adjusted overlays, including A13916–13922,14103/14156–14160,16531–16583. “External mechanism/outcome” means external to the preferred class input set, **not an external dataset, independent criterion validation or causal mechanism estimate**.

IETR's scored item set is not literally identical to current IURD or OQI inputs. However its domestic components share q6_14 routing with an IURD scored term, and related same-respondent clarity/failure/confirmation perceptions occur across composites. Routing/composition and conceptual/common-method dependence remain interpretation risks, not demonstrated model effects or permission to rewrite protected qualitative findings.

LEGACY-A B00573–577 overstates timely/digital confirmation and active-user scope, then infers specific poor-rate/delay/limit and cash-reversion mechanisms from a composite. A low available-case mean alone does not identify every component's state or a causal consequence. B00702–703's persistence, temporal ordering and institutional-design mechanism language exceeds a cross-sectional association. B00770–773's non-significant interaction does not establish equivalence, absence of moderation or institutional dominance. B00709's IADT interpretation must not conflate its omission from the standardized plot with a fitted-and-absorbed coefficient. B00850/853's external-validation language describes same-sample profiling, not independent measurement validation.

Legacy Figure26, Figure38, Figure46 and segment tables need later source/run/exhibit reconciliation; current source figure IDs differ (coefficient43, interaction51). Figure titles/numbers, recipe compatibility and static source text do not establish original visual/numerical parity.

## 7. Open scientific/implementation decisions

| Finding | Evidence/issue | Required later decision; no repair now |
|---|---|---|
| IETR-01 | Mixed latest international/domestic/general/global,60/90day referents; paper confirmation; unmeasured timeliness/persistence/causal mechanisms. | Define target construct/population and defensible manuscript claims; distinguish theory/formative index from observed service performance. |
| IETR-02 | Fee/FX temporary names/comments reversed; FX N/A99 rewarded100 versus no-fee4 scored0. | Correct semantic documentation and explicitly justify or revise polarity/N/A policy after scientific review. No automatically chosen recode. |
| IETR-03 | Nested available-case weights;174 incomplete profiles; nonusers may have only1–3 terms, including legal singleton100. | Specify estimand/content equivalence, routing/missing policy and warranted sensitivity; no imputation/exclusion or score redesign. |
| IETR-04 | Current no-confirm5→0 versus four stored positive-no-confirm states; older seven-term defaults/overwrites. | Preserve historical regimes and audit actual downstream reload/fits/exhibits before selecting an academic recipe. No universal historical parity claim. |
| IETR-05 | Legal unpredictable6 omitted; unknown/refusal/N/A handled asymmetrically; arbitrary ordinal points and60/90day inconsistency. | Justify substantive unknown/nonuse/ordinal policy and recall limits; do not invent continuous timing, fee levels or corrected responses. |
| IETR-06 | Missing-high/undeclared interval/finite-domain/constant-SD guards;117 normalization/347 standardization differences, zero observed category precision changes. | Separate technical guards from scoring changes and actual fitted impact; exact replay is not psychometric or inferential validation. |
| IETR-07 | Fixed/quantile/continuous roles differ; standardized model omitsIADT; within-sample profiles and shared routes not independent validation; legacy mechanism/exhibit claims unresolved. | Protected M6 fit/sample/output reconciliation and explicit M7 scientific/claim decisions. No LCA, clustering, regression or qualitative change here. |

All seven remain open. Owner agreement in principle with justified future corrections does not specify a scientifically justified new score or authorize an unbounded analytical rewrite.

## 8. Closeout, retained evidence and next task

The ignored packet retains the driver/read-back/native checker, five-form metadata, source operations and native recipe inventory/proof, source/domain/routing checks, component/denominator/nested-weight aggregates,36-state schemas and variant/alias comparisons, synthetic controls, failed/superseded receipts, accepted actual MCP responses, independent critique, compiler diagnostics, source-retention receipts and fingerprinted validation. The native entry/closeout chain verifies **768 overlapping original-byte records**, **378 prior-private fingerprints**, earlier public reports, **124 unchanged primary tasks /14 milestones**, resolving artifact pointers, zero public-field approvals and pending scientific gates. These are manifest-record counts, not768 unique files.

The same saved main.tex/editor/preamble is retained. Fresh post-edit built-in compilation fails before TeX preparation: `windows sandbox: helper_unknown_error: setup refresh had errors`. The actual attempts are retained; source preservation does not certify compilation or rendered layout. No source compilation error is reported, but a rendered check is unavailable. No alternate compiler, PDF or tab is used.

**Next immediate task: M4.03.12 / M5.02.10 — historical IPCS measurement audit.** Begin Preparation Section3.8.1 and its own q7_2/q7_6/q7_7/q7_8/q7_9/q7_10 inputs, fraud/recourse ancestry and six binary terms. Do not inherit IETR's component supports, nested denominators, domains, missing policies or thresholds. Seven granular children are in the workplan. Remaining measurement/exhibit audits and protected historical M6 replication precede explicit M7 corrections. M0 remains in progress; all parent scientific/design/method/empirical/quality/replication/release gates remain pending.

