# Historical IAT measurement audit

Checked **6 October 2026**, entering clean `main` at `24f23bdc56cced9529aa1fae9f4962c324a71b73`. This delivers **M4.03.3 / M5.02.1 as a bounded historical-reproduction audit**, not an approved correction or a completed Measurement/Replication Gate. The author-selected 31 July full manuscript remains the foundation. Read the [workplan](ACADEMIC_SUBMISSION_WORKPLAN.md), [historical input contract](HISTORICAL_INPUT_CONTRACT.md) and [version register](VERSION_MEASUREMENT_REGISTER.md) together.

## 1. Evidence and execution boundary

All form-cell, respondent, schema and statistical checks used **Stata MCP**, in disposable frames in an isolated session. The three pinned states were the recovered raw workbook (490 × 267), historical audit dataset (490 × 266), and coded dataset (423 × 439). The audit used the five recorded spreadsheet definitions, not either nonused archive version. Native utilities read authored source text and document extracts, checked fingerprints, and maintained documentation only; they did not calculate statistics.

The diagnostic copies the **29 ordered executable scoring statements** from preparation lines **1192–1243**, without changing their behavior. A native source-text comparison and a separate reviewer verified that identity. It does not execute the original preparation pipeline or master. Sources, scores, labels, sample restrictions, models, qualitative material and timestamps were not edited. No participant rows, identities or rare joint profiles are released here. Private specifications, synthetic controls, aggregate receipts, execution log and review are Git-ignored under `audit-local/intake/iat-24f23bd/`.

| Acceptance evidence | Actual result | Limit |
|---|---|---|
| Historical component/score/category replay | All eight stored variables agree exactly in all 423 coded observations: **3,384 cells**, zero value or missingness differences | Historical agreement does not validate the scoring choices |
| Questionnaire specifications | 125 scoped specification rows, including 30 IAT item/version rows; 125 linked choice rows across five versions | Not 125 questions; compiled XML, attachments and historical device deployment are not certified |
| Domain and complete scoped relevance checks | **90 checks**: six items × five versions × raw/audit/coded; zero invalid domains, missing-required answers or answers outside relevance | Applies to these items and their eligibility ancestry, not every field or the validity of consent |
| Source/eligibility checks | **27 checks**, all zero discrepancies | No ethics, sample or distinct-person certification |
| Synthetic controls and independent assertions | **20 fixtures** pass; accepted final driver returns 0 and emits its completion marker; separate receipt assertions pass | Fixtures deliberately reproduce problematic rules; they do not fix them |
| Storage and cleanup | All eight stored variables separately asserted `float`; source/helper frames absent, only empty default frame remains | No estimator or downstream result reproduction |
| Retention and orchestration | **765 overlapping source-byte checks** unchanged; 124 primary task IDs and 14 milestones retained | Not 765 distinct files or a complete remote/archive review |

Incomplete diagnostic runs were rejected. A closing-group capitalization mismatch in the private parser and an eligibility comparison that initially omitted the consent-group scope were corrected **only in the diagnostic**. The complete driver and independent assertions were rerun successfully. The final receipts retain these execution limits and the accepted evidence separately.

## 2. The exact historical construct

IAT is the *Índice de Acceso a Telecomunicaciones*. Five scored components use six questionnaire items. Preparation lines 156–196 document item meanings; lines 1192–1243 implement the recipe.

| Component | Actual item meaning and historical scores | Interpretation to preserve or review |
|---|---|---|
| `tel_score`, `q3_1` | Smartphone 100; basic phone 50; no phone 0 | Device access; not digital proficiency |
| `internet_score`, `q3_5` | Daily 100; several times/week 75; once/week 50; less than once/week 25; never 0 | The active English labels for codes 2/3 say Weekly/Monthly; code 3 is **not monthly** in the five instruments |
| `access_score`, `q3_6` | Home WiFi 100; work/study or family/friend's home 80; phone data, public WiFi or other 40 | **Internet access location**, not payment-plan type; the scoring comments misdescribe the codes |
| `data_stability`, `q3_7` and `q3_8` | First 100 for plan code ≤2 and no runout; then 50 for one runout; finally 0 for several runouts **or no plan** | Ordered replacements matter. No-plan overrides a prior 50. Legal N/A codes do not have a uniform scored treatment |
| `read_score`, `q3_12` | Always able to read short messages without another person's help 100; sometimes 25; never 0 | The 25-point penalty and applicability are historical choices, not validated psychometric weights |

The recipe takes `rowmean` of the available five component values, divides by 100, standardizes the continuous score, then assigns low ≤0.45, medium >0.45 and ≤0.80, high >0.80. Stata's `rowmean` omits missing components and returns missing when all are missing; `std()` uses the current nonmissing sample. These are computational behaviors, not a missing-data or construct-validity justification. [Official Stata `egen` manual](https://www.stata.com/manuals/degen.pdf).

Across all five definitions, the IAT items are required `select_one` fields inside `/Acceso/c0`, with inherited `eligible_flag=1`. `q3_1` and `q3_5` have no additional own relevance; `q3_6` excludes Internet code 5; `q3_7`, `q3_8` and `q3_12` require phone code 1 or 2. The eligibility calculation itself is inside the consent-relevant `/Elegibilidad` group and requires consent, `q1=1`, age ≥18 and `q5=1`. The supplied age item is required and constrained to 18–100. The linked choice lists have no choice filter. This records the spreadsheets and observed checks, not independent confirmation of historical app execution. SurveyCTO documents how enclosing-group relevance scopes its fields. [Official relevance documentation](https://docs.surveycto.com/02-designing-forms/01-core-concepts/08.relevance.html).

## 3. Open findings—not implemented corrections

**IAT-01 — actual float-boundary category misclassification.** All **71 of 423 observations (16.78%)** whose component-based, double-precision nominal-reference score is 0.80 are historically labelled high. The stored float representation is `0.80000001192092896`, above the double literal `0.80000000000000004` used by the ≤0.80 comparison. Under the written inclusive boundary, those nominal scores belong to medium. All observed historical-versus-reference category differences occur at this boundary. This is not a participant-data change: the diagnostic reproduces the historical categories exactly and reports the discrepancy separately. **No categories or outputs have been corrected.** M7 must register any repair, its downstream consumers and historical/revised result comparison before implementation.

**IAT-02 — item meanings versus labels/comments.** The `q3_6` payment-plan comments contradict its access-location question and dictionary. The active `q3_5` English frequency labels misstate codes 2/3, particularly Monthly for once/week. Label/comment problems are distinct from changed scoring values. Any published chart, table or narrative using those labels needs later source-output validation; this audit does not establish which historical exhibit displays them.

**IAT-03 — available-component weighting, N/A and latent missing category.** Of 423 coded observations, **420 have five scored components, two have four and one has three**. The final continuous score is nonmissing in all 423. Each available item therefore has weight 1/5, 1/4 or 1/3 rather than a universally fixed 1/5. Zero relevant required-response failures does not remove this issue: skips and legal N/A combinations can leave components unscored. Ordered stability overrides and partially handled N/A combinations are preserved. The condition `q3_7<=2` also admits invalid nonpositive codes synthetically; none occur in the coded data.

The synthetic controls additionally establish that an all-missing continuous score is assigned category 3 because Stata missing values compare above finite numbers and the final category replacement has no nonmissing guard. **No all-missing IAT or such missing-to-high case occurs in the 423 coded observations.** This is a latent code defect, not an observed cohort error. [Official Stata missing-value comparison guidance](https://www.stata.com/support/faqs/data-management/logical-expressions-and-missing-values/).

The historical standardized score reproduces exactly and has the expected near-zero mean and unit sample SD in this coded population. That is computational parity, not evidence of unidimensionality, justified cutpoints, comparable missingness, reliability, external validity or causality.

## 4. Downstream and legacy-manuscript boundaries

The analysis source distinguishes several IAT representations. `z_iat` is regenerated after the coded-data reload (A1105–1191). Later standardized aliases use their currently loaded populations (A5467–5494 and A7186). `h_iat3` is an empirical-tercile construction (A7713–7716), **not** the fixed `iat_cat` rule. Alternative aliases `lca_iat3`/`lca_iat2` copy or dichotomize the fixed category (A4389–4400), so their consumers require tracing if IAT-01 is repaired. The **preferred seven H1 defining indicators exclude IAT** (A8783–8829). Generating an IAT alias does not prove it enters a fitted model. No claim that coefficients, profiles or class membership do or do not change is justified without the later isolated replay.

The selected legacy extraction describes equal-weight component aggregation and standardized regressors at blocks B00448–450; its IAT discussion and Table 2 occupy B00489–503. The present audit tests the scored construct, not every stated item prevalence, vulnerability-conditioned contrast, displayed figure or table cell. In particular, claims about vulnerability groups, risk ratios and “direct impact” still require their own measurement, denominator, output-parity and inferential review. Do not replace legacy text or exhibits from this receipt alone.

## 5. Granular acceptance and next task

| Child under M4.03.3 / M5.02.1 | Accepted boundary |
|---|---|
| .1 Input and unchanged-source identity | Pinned states/form versions and exact ordered 29-statement recipe |
| .2 Item dictionary and complete ancestry | Five-version specifications, eligibility/consent group, phone/Internet triggers and choice domains |
| .3 Observed relevance and source agreement | 90 domain/relevance and 27 source/eligibility checks |
| .4 Scoring and rule-edge controls | 20 synthetic fixtures, with defects preserved and identified |
| .5 Component, normalized and standardized score parity | Eight variables × 423 observations, exact agreement and float types |
| .6 Category precision and missingness | 71 nominal upper-boundary cases; three partial scores; latent all-missing defect distinguished |
| .7 Source consumers and legacy interpretation | Scoped source/document mapping, not estimator or exhibit parity |
| .8 Independent review and durable acceptance | Separate read-only reviewer, accepted driver/receipt markers, input fingerprints and final boundary checks |

The bounded audit is complete **with findings open**. M0 and the full Baseline, Data, Measurement, Replication, ethics/rights, disclosure and release gates are not passed. Historical export-clock reports/settings remain owner-confirmed unavailable; audit/coded clocks remain unchanged. Zero fields are approved for public data. Existing Git/history exposure and protected temporary-copy housekeeping remain unresolved. No staging, commit, push, restricted-original edit/copy/delete, sharing/visibility change or live Overleaf synchronization is included.

**Next immediate task — M4.03.4 / M5.02.2: historical IVS item, directionality, normalization, missingness and category audit.** Vulnerability conditions the legacy IAT interpretation and Table 2, so establish its construct and stored-value parity next. Use the same pinned inputs and Stata-MCP-only disposable-frame approach, create one runnable diagnostic using existing helpers, preserve every historical value, and report rule or semantic findings separately. Do not recalculate the table, revise indices, fit models or infer causal effects in that bounded task. Approved scientific revisions remain behind M7.
