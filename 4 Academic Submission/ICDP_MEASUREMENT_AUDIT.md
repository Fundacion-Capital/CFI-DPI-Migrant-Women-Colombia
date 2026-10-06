# Historical ICDP measurement audit

Date: 6 October 2026  
Task: **M4.03.6 / M5.02.4**  
Disposition: **bounded historical measurement/reproduction audit; scientific findings remain open**

## 1. Scope, sources and acceptance boundary

This checkpoint audits the unchanged historical practical digital competence index, **ICDP**: instrument wording and full scoped relevance, observed answer domains, scoring order and storage precision, stored-state replay, synthetic edge controls, legacy interpretation and operative downstream consumers. Exact arithmetic reproduction is not construct validation, causal identification, historical estimator recovery or publication approval.

Entry was clean **`main@8eb3405ea4b0a4efcd263c77a228e44018d1b349`**, the owner's committed IADT checkpoint. Source is Preparation **P1291–1347**, with **24 value-defining operations P1297–1339**. Preparation and Analysis retain SHA-256 `E6A9E542DCFF1067DCDA7A37A19B5CFF542B65B54622F198C240A419DC0ED449` and `714377CA31DE2B6D70DB0994E3C7EF6A38374165D7B1FB7C7ABEB3B3F56549C9`. The author-selected full legacy draft, LEGACY-A, remains the manuscript foundation; condensed CFI deliverables do not restrict later justified academic revision.

All participant-data inspection, computation and aggregate read-back used **Stata MCP**, installed Stata 19 IC on Windows under `version 16`. Native helpers only inspected source/OOXML, metadata, pointers, Git state and hashes. Restricted paths, protected keys, catalogue identities and unpublished manuscript extracts stay in ignored `audit-local/`; no participant-level product is exported or approved for Git.

| Acceptance component | Verified bounded evidence | Limit |
| --- | --- | --- |
| Instrument | Five used definitions; 125 questionnaire and 155 choice rows; complete scoped consent/eligibility/group/item ancestry | No certification of archived XML, attachments or historical mobile-client deployment |
| Domains and routing | 90 source/version/question checks and 540 code/missing/invalid count rows; zero illegal values, applicable-item nonresponse or answers outside scoped relevance | Not whole-instrument validation, distinct-person verification or population representativeness |
| Protected linkage | 27 key-aligned source/eligibility checks, zero differences | No key or participant-value export; not full timestamp reconstruction |
| Reference replay | 24 exact ordered operations; seven stored float variables across 423 retained records: **2,961 exact cells** | Historical arithmetic, not scientific endorsement |
| Preserved states | 36 unique identities/SHA-256 values; 612 schema checks; 17 complete index states and 119 variable comparisons: **50,337 exact cells** | Other 19 states are not claimed complete index replays; stored versions are not independent samples |
| Stored aliases | 23 comparisons: nine fixed ordinal, eight fixed binary, five score-quantile and one standardized alias: **9,729 exact cells** | No class fit, assignment or regression effect has been regenerated |
| Controls | 4,032 legal/sentinel/missing combinations, 11 nominal boundary probes, seven malformed controls and two degenerate samples | Artificial controls, not 4,032 legal questionnaires or observed participant defects |
| Final acceptance | Definitive MCP driver and separate aggregate/specification read-back; independent criticism and native byte/pointer/privacy/task/gate checks | Parent scientific and release gates remain pending; same-editor compile outcome is disclosed below |

## 2. What the instrument measures

All five used versions are covered: **2512090157, 2512091719, 2512111044, 2512121811 and 2602120658**. The opening/closing-group chain was checked, including string lengths and nesting, rather than reading only each item's own condition. Consent must equal 1; calculated eligibility requires consent, female gender response, age at least 18 and respondent/household remittance receipt from abroad in the preceding twelve months. The Acceso module requires `eligible_flag=1`. Remittance receipt is **not** itself a migrant-status question, and formula reproduction does not endorse the full sample definition or certify consent/ethics.

The items are required when applicable and sit in `/Acceso/c2`, whose own relevance and appearance are empty. This is not the IADT field-list group. The first three item appearances are empty; the fraud item records literal `randomized(0,1)`. That spreadsheet fact does not certify historical device implementation. `q3_1` distinguishes regularly used smartphone/basic phone/no personal phone; `q3_5` records Internet-use frequency. Both are required under the eligible access module.

| Item | Actual Spanish wording | Response domain and historical component points | Full scoped item applicability |
| --- | --- | --- | --- |
| `q3_20` → QR | “En los últimos 3 meses, ¿escaneó un código QR para pagar o para que le paguen?” | 1 paying =75; 2 receiving =75; 3 both =100; 4 no =0 | Smartphone **or** Internet frequency other than Never; 423 applicable retained records |
| `q3_21` → OTP | “Si recibe un SMS con un código de verificación (OTP), ¿puede leerlo y usarlo sin ayuda?” | 1 always =100; 2 sometimes =50; 3 never =25; 4 does not know what an OTP is =0 | Smartphone **or** basic phone; 422 applicable retained records |
| `q3_22` → PIN | “¿Sabe crear o cambiar el PIN de su aplicación bancaria o billetera digital?” | 1 yes =100; 2 no =0; 3 does not use financial apps =0 | Smartphone **or** basic phone; 422 applicable retained records |
| `q3_23` → suspicious message | “Si recibe por WhatsApp o SMS un mensaje sospechoso que solicita dinero, claves o códigos, ¿qué haría primero?” | 1 do not click/reply and verify through another channel =75; 2 block/report =100; 3 request more information =25; 4 click/share if urgent =0; 5 does not know =0 | Smartphone **or** Internet frequency other than Never; 423 applicable retained records |

The mixture is reported recent QR use, reported unassisted OTP ability, reported PIN knowledge and hypothetical fraud-response intention. No observed task test is administered by these four questions. Opportunity/adoption, self-reported capability and intended safety behavior must remain distinct in the academic interpretation. The component rankings, equal available-component weights and fixed cutoffs are historical measurement assumptions, not externally calibrated competence thresholds.

Full scoped routing agrees with all three inspected sources. No retained record reports Never Internet use, so the QR/fraud routing condition applies to all 423; phone opportunity explains the shorter OTP/PIN coverage. Undeclared codes 98/99 are not choices here. Current [SurveyCTO relevance documentation](https://docs.surveycto.com/02-designing-forms/01-core-concepts/08.relevance.html) explains group inheritance; it does not retrospectively certify the deployment runtime.

## 3. Exact historical scoring and precision

The diagnostic reproduces these **24 unchanged operations in order**, stripping source comments only when comparing executable statements:

```stata
gen icdp_qr = .
replace icdp_qr = 100 if q3_20 == 3
replace icdp_qr = 75 if inlist(q3_20,1,2)
replace icdp_qr = 0 if q3_20 == 4
gen icdp_sms = .
replace icdp_sms = 100 if q3_21 == 1
replace icdp_sms = 50 if q3_21 == 2
replace icdp_sms = 25 if q3_21 == 3
replace icdp_sms = 0 if q3_21 == 4
gen icdp_pin = .
replace icdp_pin = 100 if q3_22 == 1
replace icdp_pin = 0 if inlist(q3_22,2,3)
gen icdp_fraud = .
replace icdp_fraud = 100 if q3_23 == 2
replace icdp_fraud = 75 if q3_23 == 1
replace icdp_fraud = 25 if q3_23 == 3
replace icdp_fraud = 0 if inlist(q3_23,4,5)
egen icdp_score = rowmean(icdp_qr icdp_sms icdp_pin icdp_fraud)
replace icdp_score = icdp_score / 100
egen icdp_score_std = std(icdp_score)
gen icdp_cat = .
replace icdp_cat = 1 if icdp_score <= 0.45
replace icdp_cat = 2 if icdp_score > 0.45 & icdp_score <= 0.80
replace icdp_cat = 3 if icdp_score > 0.80
```

All seven derived variables are separately verified **float**. The available-component mean is stored on the 0–100 scale before replacement divides by 100, producing **two float-storage rounding steps**. Exact historical replay preserves both. A direct normalized mean is not assumed bit-identical in arbitrary incomplete-score fixtures. Standardization uses the nonmissing construction sample and sample SD. [Stata egen manual](https://www.stata.com/manuals/degen.pdf).

Unlike IADT, this section does not explicitly recode 98/99. Unmapped item answers leave their components missing. Because Stata numeric missings compare above ordinary numbers, the unguarded final `>0.80` assignment sends an all-missing composite to high. This is a **latent** defect in the inspected ICDP states, not an observed missing score or incorrect high assignment.

## 4. Observed composition and score support

Historical raw/audit sources contain 490 submitted records; the coded reference retains 423 under existing filters. This audit neither redefines exclusions nor asserts that those are 423 independently verified distinct women. Protected linkage and version-aware domain checks distinguish these states without releasing identifiers.

**422 scores average all four components at one-quarter weight each; one averages QR and fraud only at one-half each.** OTP/PIN missingness follows phone-specific relevance, not applicable-item nonresponse. There are no observed zero-, one- or three-component ICDP scores. This is a different denominator pattern from IADT's 100 shorter composites; they must not be conflated. No zero substitution, imputation, deletion or complete-case restriction is implemented.

All 423 scores are nonmissing and lie in 0–1. Mean is **.8169326241**, sample SD **.2025430814**. Fixed categories contain **30 low, 106 medium and 287 high** records. The observed support consists of 17 values, **0, 1/16, …, 1**. Both explicit observed precision checks return zero: historical two-step storage versus direct score, and float-category versus double conceptual category. The IAT/IVS observed boundary findings therefore cannot be copied onto ICDP.

All 17 complete preserved states reproduce the seven variables exactly and have the same checked score coverage, range, mean, composition and fixed counts. The 36-state catalogue also separates missing-schema states from full replay states. Twenty-three available aliases reproduce exactly: nine `lca_icdp3`, eight `lca2_icdp_high`, five `h_icdp3` and one `segz_icdp`. No stored `z_icdp` or `lca_icdp2` is recovered. Same-sample standardization checks do not establish historical estimator samples or independently recover model fits.

## 5. Fixed categories, empirical groups and operative consumers

The historical hybrid source uses **built-in `xtile h_icdp3 = icdp_score, nq(3)`**, not the fixed cutoffs. The current installed built-in command is version 3.1.9, dated 17 November 2017; runtime evidence is recorded, not projected onto the original run. The definitive score-support export is generated inside the full audit driver and independently reimported/asserted. [Stata quantile manual](https://www.stata.com/manuals/dpctile.pdf).

| Fixed ICDP category | Empirical score group | Records |
| --- | --- | ---: |
| Low | 1 | 30 |
| Medium | 1 | 106 |
| High | 1 | 26 |
| High | 2 | 182 |
| High | 3 | 79 |

**314 of 423 assignments differ.** Ties yield **162/182/79**, not equally sized thirds. Cutoffs are .8125 and .9375; observed group supports are 0–.8125, .875–.9375 and **1 only**. Thus the hybrid's upper category is the maximum-score ceiling (79 records), not the fixed high category (287), a balanced upper third or independently demonstrated mastery.

| Operative source role | Verified source locators | Interpretation boundary |
| --- | --- | --- |
| Descriptive/conditional exhibits | A249–309, A523–541, A719–750 | QR/fixed categories/score means and outcome profiles; the education graph has a source restriction. Figure values, full captions and rendering remain separate exhibit audits. |
| Raw and standardized regressions | A1193, A1229–1234 and actual A1245–1590 counterparts | ICDP and `z_icdp` appear in all seven inspected core adjusted counterparts; demographic-only Model A excludes indices by design. The four IADT omissions are not ICDP omissions. No fit or AME is reproduced. |
| Interaction/direct-item work | A1710–1881; ICDP/OQI A1767–1794 | Continuous scores and percentile contrasts are not fixed high/low categories; causal moderation is not certified. |
| Fixed ordinal/binary LCA | A4425–4429, A6251–6255, operative binary M1 A6683–6766 | `lca_icdp3` copies fixed categories; `lca2_icdp_high` is fixed high versus low/medium and actually enters M1. |
| Preferred hybrid H1 | A7723–7726, A8214–8293, operative H1 A8783–8829 | Score-quantile `h_icdp3` is an actual ordinal manifest input, not merely a declared candidate. |
| Actual k-means/Ward benchmarks | A7181–7264 | Twelve-input hard-coded fits include sample-standardized `segz_icdp`, unlike their exclusion of IADT. |
| Post-class characterization | A9582–9612, A10157–10175, A10281–10296, A10962–11019 and later profiles | Original continuous ICDP underlies H1's ordinal indicator; class separation on it is internal description, not independent external validation. |

A **category-only** revision directly concerns fixed descriptive/binary consumers, but does not directly alter H1's score-quantile or clustering's continuous inputs. A **score/weight/composition** redesign could affect all of them. These are source-dependency distinctions, **not evidence that any coefficient, fitted class, probability or respondent assignment has changed**. Historical fit/output/sample reconciliation at M6 and explicit retrospective scientific decisions at M7 remain necessary.

## 6. Controls and open scientific findings

The item-specific legal/missing/sentinel grid is **8×8×7×9=4,032** synthetic combinations: 240 four-component, 992 three-component, 1,520 two-component, 1,024 one-component and 256 all-unmapped/missing. Independently written expected maps and nested float expectations reproduce the source. There are **576 synthetic two-storage-rounding versus direct-score differences**, all in three-component configurations not observed in the retained reference; observed two-/four-component scores show zero differences. These are not participant discrepancies.

Eleven nominal boundary/missing probes distinguish a stored .80 float moving above the nominal double cutoff from legal attainable scores. Exact legal mapped means cannot equal .45 or .80, so these probes do not demonstrate observed ICDP category errors. Seven all-malformed controls (0, 6, 97, −1, 2.5, 98 and 99) leave all components missing and reproduce missing-to-high behavior; one invalid component with valid others is silently omitted and reweights the remaining mean. Constant/all-missing sample controls reproduce undefined standardization. None justifies inventing contaminated actual records or silently repairing production.

| Finding | Status and required later decision |
| --- | --- |
| **ICDP-01 — measured construct versus performance** | Open: reported use/ability/knowledge and hypothetical response are not observed functional performance. LEGACY-A B00516, B00677, B00691 and B00721 overstate hands-on/observable performance; tighten quantitative interpretation in the revision track, not the protected qualitative evidence. |
| **ICDP-02 — normative scoring and thresholds** | Open: single-purpose QR=75/both=100, never OTP=25, verify-other-channel=75/block-report=100, available-item equality and .45/.80 cutoffs lack independent criterion validation established by this audit. Retrospective construct/scoring decisions require explicit rationale and historical/revised comparisons, not an automatic replacement scale. |
| **ICDP-03 — opportunity-dependent composition** | Open: 422 four-component and one structurally two-component composite change content/weights. Applicable-item nonresponse is zero; no automatic imputation/exclusion or claim that all records were asked identical items. |
| **ICDP-04 — latent guards and precision** | Open: missing-to-high, unmapped-value omission and degenerate standardization require robust future guards. Two-stage precision matters for exact replay; no observed ICDP float-score/category error or illegal actual answer is demonstrated. |
| **ICDP-05 — actual representation and validation roles** | Open: fixed 30/106/287 differs from quantile 162/182/79, with upper group exactly score=1. M1/H1/clustering use different operative representations. LEGACY-A B00815–B00818 high-class language needs this distinction; B00820 continuous-index “validation” is not independent of H1's defining ICDP information. Fit/profile/exhibit consequences remain unestimated. |

Other legacy age/education means, outcome gradients, AMEs, significance and class-specific probabilities are **located, not numerically recertified here**. Rounded sample mean .82 is compatible with this replay; that does not validate an entire centroid table, performance claim or causal interpretation. No coauthor interview, quotation, theme, expert rating or qualitative conclusion is changed.

## 7. Granular completion and retained holds

The seven bounded children are instrument/ancestry **M4.03.6.a**, domain/source **M4.03.6.b**, recipe/precision **M5.02.4.a**, stored-state replay **M5.02.4.b**, fixtures **M5.02.4.c**, legacy/operative-consumer interpretation **M5.02.4.d**, and independent criticism/receipt/retention handoff **M5.02.4.e**. Their acceptance does not complete M0, M4, M5 or M6.

The definitive MCP driver/read-back receipts distinguish the final successful runs from superseded diagnostic appearance/format assumptions. Form files were never corrected to fit the diagnostics. Fresh session checks verify only the default **0×0** frame remains. The separate critic's final verdict and native `icdp_validation.json`/`source_retention_closeout.json` are the bounded acceptance evidence, not this narrative alone. Retention checks cover **768 overlapping original source-byte checks and 131 prior private fingerprints**; these are not distinct-file or all-cloud completeness counts. Prior IAT/IVS exhibit and IADT public reports remain unchanged; all 124 primary task IDs, fourteen milestones, pending gates and zero public-field approvals are retained.

The existing `main.tex` preparation record is updated in place without changing its preamble or replacing the open document. The **fresh same-editor compile attempt failed during native initialization** with `Unable to find standard directories for platform`. The source and current editor are preserved; no replacement PDF/tab or compiler installation was created. Source/measurement checks do not certify PDF layout, and the typesetting limitation remains open.

No source/data save, preservation copy, production correction, model estimation, exhibit replacement, anonymous derivative, qualitative alteration, deletion, staging, commit, push, Dropbox/OneDrive write, visibility/access change, external message or Overleaf synchronization is included. Restricted originals remain protected; the current public Git/history exposure and separate anonymous-package/disclosure/ethics/rights/release work remain unresolved.

**Next immediate task: M4.03.7 / M5.02.5 — historical IAFF measurement audit**, seven instrument/domain/recipe/replay/fixture/consumer/review children in the [workplan](ACADEMIC_SUBMISSION_WORKPLAN.md). Remaining measure audits, source-specific exhibit reconciliation and protected historical replication precede documented M7 revision decisions. No IAFF audit or repair is claimed by this checkpoint.
