# Historical IURD measurement audit
M4.03.10 / M5.02.8 — 7 October 2026

## Acceptance boundary

This is a bounded historical source, instrument, domain, replay, control and consumer audit. It is **not validation or approval of the IURD construct**, a new score, a re-estimation exercise or a scientific/public-release gate. Seven children are accepted only with the definitive Stata MCP receipts, normally closed logs, independent review and native preservation closeout retained in the ignored evidence folder. Entry was clean `main@da6c98800c95505c6ac0fb4647eefad9c26f0a01`.

Production code/data, the legacy manuscript, historical outputs, earlier audits and protected qualitative findings remain unchanged. No participant-level derivative/export, estimator, source copy/delete, Git stage/commit/push, access/visibility change, cloud mutation or Overleaf synchronization is included. Public files contain audit explanations and aggregate diagnostics, not restricted paths, source contact details, protected keys or individual responses.

## 1. Sources and five-version measurement contract

Source: Preparation Section 3.7 block B, lines 1627–1676; actual consumers are in Analysis, not inferred from the manuscript or graph. All numerical respondent-level and synthetic work was executed through Stata MCP. Existing source/hash/OOXML helpers were reused only for provenance, structural checks and metadata. The existing Graphify graph was reused for navigation, not execution proof.

The preserved forms are 2512090157, 2512091719, 2512111044, 2512121811 and 2602120658. Stata extracts **233 specification and 615 choice rows**, with balanced full group ancestry, settings versions, requiredness, constraints, filters and appearance. Independent native OOXML inspection corroborates the targeted metadata, five scored choice lists and enclosing relevance. Scoped lists, relevance and requiredness are stable. q6_13 has a wording variant (`se mantiene` versus `mantiene`); no scored-choice/domain change follows from that wording.

The Remesas group requires `eligible_flag=1`. The flag uses consent/q1/adult age/q5, **not the principal-receiver/manager answer q6**, and no account-ownership requirement is added. The q6 role question itself is under consent/Elegibilidad with q5 relevance: applicable to 426 raw/audit records and 423 retained records. This is distinct from the 423-record remittance-group scope. No answer or eligibility state is invented.

| Source item | Actual instrument meaning and route | Historical current scoring |
|---|---|---|
| q6_2 | International remittance receipts over the last 12 months: 1 monthly or more, 2 every 2–3 months, 3 one–two times/year, 99 not applicable/do not remember; required for eligible group. No choice 4. | 1→100; 2→75; 3→25; **undeclared 4→0**; legal 99 remains missing. |
| q6_13 | In general, remittance money retained/used digitally versus withdrawn as cash; required. 1 all cash; 2 less than half withdrawn as cash; 3 half/half; 4 more than half digital; 5 all digital. | 1→0; **2–5→100**, a binary any-digital-retention term, not a proportion or amount spent. |
| q6_14 | Domestic digital payments or remittances in the past 60 days, with apps/transfers/wallets/QR; optional yes/no/refusal (1/0/98). | Yes→100; No→0; refusal/blank remain missing. |
| q6_15 | Binned total digital send/receive operations in the same 60 days; required **only if q6_14=1**. Codes 1–5: <5, 5–10, 10–20, 20–50, >50; 98 do not know/remember. | 1–5→20/40/60/80/100; unknown98 and routed skips remain missing. Ordinal points are not exact transaction counts. |
| q6_4 | Channel for the most recent remittance: bank1, wallet/app2, counter cash3, traveler4, Other5; required. | Bank/wallet→100; cash/traveler/**Other**→0. Other is not intrinsically cash/informal. |

The two above-half-digital descriptions in q6_13 codes2/4 do not establish a strict five-level empirical share scale. Restoring the old 25/50/75/100 gradient is **not an automatically justified correction**. q6_15 ranges have textual shared endpoints; no exact count or continuous-volume scale can be recovered. The “if not remembered, enter0” text appears in the appearance metadata, not a legal choice or constraint. It does not authorize creating a response code0. q6_5 is required only for bank/wallet receipt; q6_10 describes disposition of the latest remittance and does not have the same referent as general q6_13 retention.

## 2. Protected-source domains, routes and linkage

Fresh dimensions: raw workbook **490×267**, audit DTA **490×266**, retained coded reference **423×439**. Protected KEY uniqueness, coverage, eligibility reconstruction and equality of 17 scoped source fields are checked without exposing keys or free text.

**120 question-check, 319 code-count, 300 routing and 54 source-check rows** pass separate read-back. Illegal nonmissing scoped codes, answers outside relevance and required applicable scalar nonresponse are zero. q6_14 has four applicable optional blanks; refusals and unknowns are legal responses, not illegal values or invented nonresponse.

Retained response facts:

- q6_2: 108 monthly+, 154 every2–3 months, 134 one–two/year, **27 legal99**, zero code4. Frequency contributes to396 scores and is never actually zero.
- q6_14: **368 Yes, 45 No, six refusal98, four blank**.
- q6_15: 91/144/85/33/8 in bins1–5, seven legalunknown98, **55 structural skips** following No/refusal/blank. Zero missing applicable answer among the368 Yes records.
- q6_4 Other5: **21**, all with nonblank protected descriptions. Those descriptions were compared privately; none is quoted/exported here.
- Latest cash/traveler receipt with some general digital retention occurs45 times; latest digital receipt with all-cash retention124 times; No recent domestic digital use with some general digital retention11 times; refusal with some retention twice. Different latest/general/international/domestic recall frames prevent declaring these combinations impossible or “cleaning” them automatically.

The source joint aggregate and preserved-state input checks do not change any answer. There is no selected multiselect parent/dummy in the actual IURD mean: it uses five select-one fields. q6_12 use-purpose dummies are not silently substituted into this recipe.

## 3. Exact current recipe, composition and precision

The source's **26 ordered value operations** reproduce eight retained fields exactly: five components, raw mean, normalized mean and category. All **3,384 reference cells** agree, including missingness. Defaults are ordinary missing; generated current reference fields use float storage. Historical compressed byte component/category storage is inventoried separately and does not imply numerical disagreement.

Mean order is frequency, recent-use, operations, digital retention, receipt channel. `rowmean` averages available components; raw float is divided by100 and stored as normalized float. Fixed categories use raw **<30 / [30,55) / ≥55**, with no upper missing guard. There is **no current production iurd_score_std** in this block. Analysis standardizes the normalized score for actual consumers; the historical raw-score standardization survives in one older retained state and is audited as that source-specific field.

| Available components | Records | Implicit weight of each included component |
|---|---:|---:|
| Five | 349 | 20% |
| Four | 51 | 25% |
| Three | 21 | 33⅓% |
| Two | 2 | 50% |

All423 scores are nonmissing; **74 have incomplete composition**. Missing patterns are privately preserved as five-character strings, with leading zeroes retained. These omitted components arise from legal99/98, optional nonresponse and routed operations. They are not all the same missing state, and technical parity does not justify imputation, exclusion or scoring unknowns as zero.

Raw mean/SD: **58.656028334976085 / 22.37719953636819**. Normalized mean/SD: **0.5865602800820736 / 0.22377199473831747**. Individually double-typed postfile summaries and scientific CSV formatting preserve these moments; separate weighted aggregate mean and sample-SD calculations verify them without opening respondent inputs.

Fixed groups are **45/129/249**. Empirical normalized-score terciles are **145/144/134**, with **215 different assignments**. Ties are preserved; “tercile” does not mean equal counts or fixed low/medium/high substantive intensity. Exact raw30 and55 occur two/four times and classify as middle/high correctly.

Ordered raw-float-then-normalize versus double-direct normalization differs in13 retained records. Raw-versus-normalized float standardization differs in300, by at most **1.78813934326171875e-7**. Observed category precision differences are zero. No importance for coefficients, class probabilities or substantive conclusions is inferred from this numerical check.

## 4. Historical-state and authentic-source reconciliation

The unchanged catalogue contains **36 unique state-ID/SHA identities**. Schema inventory has1,368 rows, including absent fields, actual numeric/storage types and optional historical standardization. **17 complete source/core-score bundles** support protected-key/input replay: 306 input rows with zero unmatched keys/input differences. Incomplete schemas are not forced into replay.

Across current available fields, **56,682 cells** are compared. Fifteen eight-field states match the current recipe exactly. Two older states retain **2,518 current-versus-stored differences**:

| Retained state | Compatible native recipe | Consequential distinction |
|---|---|---|
| 37 | a0778ad / 192d311, independently matched native source; eight shared fields including historical raw-score std | Four terms; graded digital retention; 40/70 cuts. Frequency99→0, recent refusal98→0 and operationunknown98→20. No receipt-channel component. |
| 38 | 6376fcf and the preserved3a655f37 source snapshot; seven shared fields | Four terms; graded retention; 45/85 cuts. Legalunknown/refusal omissions, no channel term. |
| Other15 complete states | 80e5687/current; eight shared fields | Five terms; binary retention; 30/55 cuts. |

Current-vs-stored differences are1,228 in37 and1,290 in38, not erased. Source-specific compatibility accounts for **57,105 exact shared field cells** using one canonical matching recipe per state. All **six inspected native Git recipes** are independently checked against captured source and diagnostic program operations: 80e5687/6376fcf/3b10048/a0778ad/192d311/95179b3 have26/26/26/27/27/26 operations. The full cross-recipe test has **732 field-check rows /309,636 cells**; nonmatching counter-recipes are retained, not filtered into universal parity.

All **77 available actual-alias checks /32,571 cells** agree with their own source representation. Standardized, fixed, binary, quantile and direct item/channel helpers are not interchangeable. Absent z_iurd/recent_digital_use state fields are absence evidence, not invented stored products.

These findings establish **stored-state/source-recipe compatibility**, not the original generating execution, unique historical run, estimator replay or rendered-image identity. The two source commits compatible with37 do not identify one unique producer.

## 5. Controls and independent numerical/read-back checks

- **5,040 raw-domain/missing rectangle cases**, with a separately identified **900 legal routed raw-questionnaire cases**. Legal routing handles recent Yes, No, refusal and optional blank, and applicable operationsunknown98.
- **810 arithmetic point/omission cases**. This deliberately includes undeclared frequencycode4's zero point and invalid routed combinations: it is not wholly legal questionnaire support. Ninety-nine ordered/direct normalization differences and zero category differences are verified.
- **80 one-field controls** cover every legal item code, unmapped99/98, plausible malformed/out-of-domain values and ordinary/.a/.z missing. Unmapped components can be dropped while the score stays high; no response is repaired.
- **24 legal routed-dependency cases** separate Yes+known/unknown operations, No+structural skip, refusal and optional blank, with/without frequency99 and cash/digital retention.
- **Nine score-only ULP/missing controls** demonstrate float rounding near30/55 and missing-as-high. These are not claimed attainable questionnaire perturbations. Separate legal routed cases show both exact boundaries are attainable.
- **Three fully missing source cases** produce missing raw/normalized scores but category3 because Stata missing sorts above finite55. This is latent and absent from the423-record reference.
- **Two constant endpoint samples** produce undefined raw/normalized standardization. Low sample6.25 and high100 remain self-consistent; production guards are not added.

Independent read-back opens only specification/aggregate/synthetic CSVs, verifies legal lists/complete scoped ancestry, key-free domain totals, requiredness, routed composition, weighted means/sample SD, categories, native recipe compatibility, alias counts, float order, extended missing values and numerical/string CSV round-trips. Driver/read-back completion markers occur in actual MCP responses and normally closed logs, not just source text. Failed adapter/preflight runs remain labelled and excluded from accepted runs; their protected Stata frames were cleared.

Local diagnostic repairs addressed snapshot field-name parsing, regex escaping, dynamic-condition syntax, optional-variable list-drop behavior, individually double-typed summaries, source-specific q6 relevance, duplicate routing labels and CSV import/storage expectations. These are **audit machinery changes only**. They do not alter scientific scoring or participant content.

## 6. Legacy claims and actual downstream consumers

The independent critic corroborates LEGACY-A locators against native OOXML, and static source locators retain first/last lines and executable statements separately from execution evidence.

- **LEGACY-A B00568** calls channel the maximum conceptual weight and describes a proportion spent digitally. Current terms are equally weighted within each available-case mean; q6_13 measures retention/use, not actual spending share.
- **B00569–B00570** interpret associations as causal spillovers or reasons for cash-out. This audit adds no causal identification.
- **B00632/B00682** loosely treat cash counter receipt as informal. A regulated cash-out channel may be formal; channel mode alone is not a regulatory-status test.
- **B00853** calls formal-channel separation external validation. The formal-channel helper shares q6_4 with class-defining IURD. Separately, the actual recent-use profiling helper shares q6_14; that source-based overlap is not attributed to B00853. Exclusion of either helper from the class manifest does not make it an independent holdout.
- Descriptive Analysis610–632,833–856,890–913 and correlation score lists consume current fixed/raw/normalized variants. Their source route is established; original image numerical/render parity remains pending.
- IURD regression1250–1268 and coefficient plot, interactions1610–1681/1710–1712/1804–1806 use continuous scores/standardized scores. The corresponding raw full-control block includes IADT, while the standardized IURD equation omits it. This discrepancy is recorded, not refitted.
- formal_remittance at1134–1141/4595–4600 maps bank/wallet1 and cash/traveler0, **Other missing**. The IURD channel term and direct sensitivity lca_di_formal_remit5359–5364 map Other to0. Profile remit_channel_profile preserves five channels; four-category profile combines traveler/Other. Do not conflate these policies.
- lca_iurd3 copies valid fixed categories4477–4481; lca2_iurd_high6269–6273 collapses fixed high versus rest and enters binary M1. **Preferred H1** uses h_iurd3 from empirical score tertiles7743–7746 and ordinal manifest specification8725–8832. A category-only correction does not directly change H1 input; a score/denominator correction may, without a quantified model effect here.
- Continuous clustering uses normalized-score standardization zcl_iurd_score_01/segz_iurd and actual k-means/Ward routes. Class-defining separation is internal description, not external validation.
- Appendix table-copy19426–19427 routes the IURD regression product into the appendix; source destination does not certify coefficient/caption/denominator/image parity.

No regression, cluster or LCA is fitted or approved. Original qualitative themes, interviews and expert/regional findings are untouched.

## 7. Explicit scientific findings retained for M7

| Finding | Required later decision, not an automatic correction |
|---|---|
| IURD-01 — construct/referent | Distinguish international remittance receipt, general retention, latest channel and domestic60-day digital payments. Narrow claims on intensity, exact share/volume, inclusion, formality, corridor and causality. |
| IURD-02 — legalfrequency99 and phantom4 | Specify policy for combined not-applicable/do-not-remember response; an undeclaredzero rule does not justify zero-scoring99. Preserve historicaldefault regimes. |
| IURD-03 — available-case composition | Decide applicability, optional blanks, refusals, unknownoperations and implicit weights/denominators; do not silently fill structural skips or restrict the sample. |
| IURD-04 — coarse share/channel/bins | Evaluate binary retention and semantically overlapping old gradients, Other channel, ordinal-volume mapping and cross-question recall. Keep helper-specific Other policies explicit. |
| IURD-05 — historical version regimes | Preserve current five-term/binary30–55 and old four-term/graded40–70 and45–85 results separately. Record unknown-response default policies and retrospective revision provenance. |
| IURD-06 — precision/missing/degenerate guards | Decide scientifically justified finite-score/domain/range/constant-SD guards. Separate latent ULP/full-missing controls from observed contamination and fitted consequences. |
| IURD-07 — operative representation/claims | Reconcile fixed/binary/quantile/continuous routes, IADT control mismatch, same-source profile “validation,” causal narratives and original exhibit denominators/rendering before publication. |

## 8. Closeout and limitations

Seven accepted children: M4.03.10.a/.b and M5.02.8.a–.e. The definitive native closeout preserves **768 overlapping original-byte comparisons, 310 prior private fingerprints**, prior reports,124 primary tasks/fourteen milestones, all artifact pointers, zero public-field approvals and all pending parent gates. This does not complete M0, M4, M5, M6, the full empirical/method/design/quality/replication gates, or the sensitive-data release hold.

The existing main.tex preparation record is edited in place with the exact preamble/editor retained. **Fresh native preview fails before TeX preparation with Windows sandbox helper setup-refresh errors** (`helper_unknown_error: setup refresh had errors`). Compilation/rendered layout remains unverified. This is fresh evidence, not the previous OQI platform-directory error. No alternative compiler, PDF, document or tab is created.

The next immediate task is **M4.03.11 / M5.02.9 — historical IETR measurement audit**, starting Preparation Section3.7 block C and its own complete recipe/questionnaire/consumer contract. Remaining measures/exhibits and protected M6 historical replication precede explicit M7 revisions. Full proposed commit title/body accompanies the handoff; no Git action is executed.

