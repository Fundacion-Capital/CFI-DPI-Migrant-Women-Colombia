# Historical IADT measurement audit

Date: 6 October 2026  
Task: **M4.03.5 / M5.02.3**  
Disposition: **bounded historical measurement/reproduction audit; scientific findings remain open**

## 1. Scope, sources and acceptance boundary

This audit reconstructs the unchanged historical **perceived transactional digital self-efficacy index**, IADT. It checks the five used questionnaire versions, full scoped eligibility/group/item relevance, observed domains, the exact scoring recipe, stored values, numerical/missingness controls, manuscript interpretation and actual downstream source consumers. It does **not** revise a score, estimate a model, regenerate an exhibit, validate a causal claim, change the qualitative contribution or approve public participant data.

The effective entry is clean `main@b447ee5915a7f8ef4f9487253d6ffcdb705c84c5`. During intake the owner committed the six pre-existing historical-preservation documentation changes, advancing the initially observed `f2c99ab` checkout. The entry was refreshed after that owner action; the agent did not commit. The ignored evidence-directory suffix retains the original observation, not the effective entry identity.

The source is Preparation **P1252–1288**, with ten value-defining statements at **P1256–1280**. The preparation and analysis hashes remain respectively `E6A9E542DCFF1067DCDA7A37A19B5CFF542B65B54622F198C240A419DC0ED449` and `714377CA31DE2B6D70DB0994E3C7EF6A38374165D7B1FB7C7ABEB3B3F56549C9`. The selected full legacy manuscript remains LEGACY-A, internally labelled 31 July 2026. Participant inputs, source paths, manuscript extracts, catalogue identities and executable diagnostics remain restricted/ignored; none is a public anonymous derivative.

All participant-data inspection, scoring and statistical read-back used **Stata MCP**, installed Stata 19 IC on Windows with `version 16` language semantics and explicit float generation. Native helpers only read source/OOXML text, manifests and mechanical receipt metadata, and check opaque hashes, sizes, paths, pointers and Git boundaries. Existing Graphify navigation was advisory; its inferred relationships were checked against actual source blocks. The independent critic read source and the definitive receipts separately.

| Evidence | Verified bounded result | What it does not establish |
| --- | --- | --- |
| Instrument | Five used definitions; 20 phone/item-version rows and 75 selected choice rows; these four questions' properties and linked choice meanings agree | Not compiled XML/attachment, device/runtime deployment or whole-instrument certification |
| Actual applicability and domains | 60 question × version × raw/audit/coded checks; 390 code/missing/invalid count rows; zero illegal codes, applicable-item nonresponse or answers outside full scoped relevance | Not ethics, independent-person identity or representative sampling |
| Protected linkage | 23 eligibility/key-aligned source checks, zero differences | Keys remain private; not whole-dataset or timestamp reconstruction |
| Exact selected-state recipe | Ten ordered operations agree with source; all six stored float variables match across 423 retained records: **2,538 cells** | Reproduces historical arithmetic, not construct validity |
| Preserved-state scope | 36 unique catalogue identities/SHA-256 values; 468 separate presence/numeric/schema checks; 17 complete index states, 102 variable-parity records, **43,146 exact cell comparisons** | The other 19 states do not support the complete six-variable replay; versions are not independent samples |
| Stored aliases | 23 checks across nine fixed-alias states and five score-tercile states: **9,729 cells**, zero discrepancies | No LCA or other estimator fitted; declaration alone is not operative model use |
| Synthetic behavior | 729 legal-value/sentinel/missing patterns, 11 nominal boundary probes, seven malformed-code controls and two degenerate-sample controls | Defects are preserved as test outcomes; no observed source contamination is inferred |
| Acceptance | Guarded driver and independent aggregate/specification read-back return zero; independent review and source/privacy checks support the bounded handoff | M0 and all parent scientific, disclosure, ethics, rights and release gates remain pending |

## 2. What the instrument actually asks

All five used spreadsheet definitions are pinned: `2512090157`, `2512091719`, `2512111044`, `2512121811` and `2602120658`. The complete enclosing chain was parsed with opening/closing-group and string-length assertions, not just a question's own relevance. Eligibility is calculated under consent: consent=1, gender response `q1`=1, age at least 18 and household remittance receipt `q5`=1. The Acceso group requires `eligible_flag`=1. Agreement with that calculation does not certify consent/ethics or endorse all historical selection rules.

The control `q3_1` asks whether the woman personally has a mobile phone she uses regularly: 1 smartphone, 2 basic phone, 3 no. The three scored items are required Likert questions inside `/Acceso/c1`, a field-list group with no additional own relevance. Their item-specific applicability differs:

| Item | Exact questionnaire statement | Applicable retained records | Item relevance beyond eligible Acceso |
| --- | --- | ---: | --- |
| `q3_15` → app installation | “Sé descargar e instalar una aplicación en mi teléfono.” | 323 | `${q3_1} = '1'`: smartphone only |
| `q3_16` → sending/receiving money | “Sé usar mi teléfono para enviar o recibir dinero (transferencias, billetera digital, pago móvil).” | 422 | `(${q3_1} = '1' or ${q3_1} = '2')`: smartphone or basic phone |
| `q3_17` → perceived fraud avoidance | “Me siento segura evitando fraudes y mensajes sospechosos en línea (PIN, códigos OTP, enlaces).” | 423 | No own phone-type condition; all eligible records |

All use the same five choices: **1 Nada cierta, 2 Poco cierta, 3 Medianamente cierta, 4 Muy cierta, 5 Totalmente cierta**. Larger codes mean stronger endorsement of a perceived-capability statement. They are not demonstrated task performance, observed fraud prevention, verified transaction success or a direct measure of financial inclusion. `98`/`99` are **not declared choices** in this Likert list, although the preparation contains defensive recoding for them.

The first two versions place the items at Excel rows 45–47; the last three use rows 46–48 after a row insertion. Row movement is not a new item meaning. Actual relevant answers satisfy the declared applicability in all three inspected raw/audit/coded sources. The observed source pattern supports structural skips, not a certified reconstruction of historical mobile-client screen behavior. Current SurveyCTO documentation describes enclosing-group relevance and newer dynamic field-list behavior; it must not be projected backwards onto an unverified historical client. [Official relevance documentation](https://docs.surveycto.com/02-designing-forms/01-core-concepts/08.relevance.html).

## 3. Exact historical scoring and storage

The diagnostic copies these **ten unchanged operations in order**:

```stata
recode q3_15 q3_16 q3_17 (98=.) (99=.)
gen iadt_appinstall = (q3_15 - 1) / 4
gen iadt_sendmoney = (q3_16 - 1) / 4
gen iadt_fraudesafe = (q3_17 - 1) / 4
egen iadt_score = rowmean(iadt_appinstall iadt_sendmoney iadt_fraudesafe)
egen iadt_score_std = std(iadt_score)
gen iadt_cat = .
replace iadt_cat = 1 if iadt_score <= 0.33
replace iadt_cat = 2 if iadt_score > 0.33 & iadt_score <= 0.66
replace iadt_cat = 3 if iadt_score > 0.66
```

Each endorsed Likert level maps to **0, .25, .50, .75, 1**. `rowmean()` equally weights the available nonmissing components, not a fixed denominator of three; if all components are missing, the score is missing. `std()` uses the score's nonmissing construction sample and sample standard deviation. The six stored variables are separately asserted **float**, and the replay retains that precision. The fixed category labels are low, medium and high perceived self-efficacy. Their decimal boundaries are `.33` and `.66`, not empirical terciles and not a newly imposed exact mathematical-third rule. [Stata egen manual](https://www.stata.com/manuals/degen.pdf).

Treating ordered answers as equally spaced values, assigning equal available-component weights and defining fixed cutoffs are substantive measurement assumptions. Exact compatibility is not reliability, dimensionality, measurement-invariance or external criterion validation. No such scientific gate passes here.

## 4. Observed denominators and changing implicit weights

The raw and historical audit contain 490 submitted records; the coded reference has 423 historically retained records. Protected key alignment preserves those distinctions. Across the five versions, every applicable phone/item question has an answer, all answers use their declared codes, and no answer occurs outside the full scoped relevance. These are retained submissions, not a new claim of 423 independently verified distinct women.

| Available components | Count of scored retained records | Actual available-item definition | Implicit weights |
| --- | ---: | --- | --- |
| Three | 323 | App installation + money transfers + perceived fraud avoidance | One-third each |
| Two | 99 | Money transfers + perceived fraud avoidance; installation structurally skipped | One-half each |
| One | 1 | Perceived fraud avoidance only; installation and transfers structurally skipped | Entire weight on this item |
| Zero | 0 | No actual missing composite | Missing-to-high behavior is latent only |

Thus **100/423 (23.64%)** of the historical scores are available-item means with a different content/weight structure. Calling them “item nonresponse,” “refusal,” “incomplete answering” or excluding them as a routine missing-data fix would misdescribe the actual instrument and silently change the sample. The cross-phone-group comparability question remains open. Candidate solutions, such as explicit opportunity/phone strata, a common eligible-item estimand or carefully justified alternative score rules, belong in M7 after the historical audit; none is selected or implemented.

The selected-state mean is **.7829984250**, sample SD **.2073207298**, range **0–1**, with no missing score. Historical fixed categories are **11 low, 61 medium, 351 high** (2.60%, 14.42%, 82.98%). High categories occur in 276/323 three-component and 75/100 partial-component scores. These differences are descriptive, not evidence of a causal phone effect. All six stored values, including sample-dependent standardization, reproduce exactly.

For `q3_16`, the applicable denominator is **422**, not the entire 423-record reference. The lowest two responses total **22/422 (5.21%)**; responses 4/5 total **362/422 (85.78%)**. The legacy prose's 6% is not that exact combined proportion, and its population/skill interpretation is too broad. Whether it arose by summing rounded bars needs the later Figure 11 artifact audit; no historical graphic was replaced here.

## 5. Preserved states, aliases and actual consumers

The catalogue retains the prior 33 identities and adds the three separately preserved historical inputs as unique new IDs 37–39. Identity uniqueness and hash uniqueness are asserted before Stata opens any state. An early diagnostic collision in appended IDs was corrected, the schema/parity outputs regenerated, and only the definitive receipts accepted. No original or prior evidence file changed.

All 17 states with three numeric source items and all six stored IADT variables reproduce the unchanged recipe exactly. The schema distinguishes absent from present-but-nonnumeric variables; none of these scoped present fields is nonnumeric. Nine states contain both fixed-category aliases and five contain the score-tercile alias, each agreeing exactly with its actual source rule. None of the 36 states contains stored `z_iadt`. Reconstructing `std(iadt_score)` on the selected same sample agrees with `iadt_score_std`; this is a construction check, **not recovery of a preserved historical regression `z_iadt` or estimator sample**.

The selected sample's `xtile h_iadt3 = iadt_score, nq(3)` gives **251 / 36 / 136** records, not three equally sized groups. Ties/ceiling concentration and the quantile convention produce uneven membership. Compared with fixed `iadt_cat`, **276/423 assignments differ**. The distinction is not a discovered category defect or authority to replace one classification with the other.

| Consumer | Direct source evidence | Implication, not an estimated effect |
| --- | --- | --- |
| Descriptives and pairwise analysis | A214–241 graphs `q3_16` and mean `iadt_score` by `iat_cat`; later correlation/scatter/category inventories use score/fixed categories | Retain applicable-item, composite-content, score/group and construction-sample denominators; Figures 11–12 bytes/display/generation remain a later exhibit check |
| Raw regression architecture | A1229 `block_B` includes `c.iadt_score`; later raw families and selected interaction models use it | A score/sample revision can change these specifications' inputs; coefficients and claims are unvalidated here |
| Standardized/AME comparability | A1192 creates `z_iadt`; A1234 defines `block_B_z` with it, but four hard-coded counterpart fits omit it: A1275 IURD, A1325–1326 formal-remittance logit/AME, A1377 IUOF, A1429 IETR | These counterparts are **not merely rescaled full raw specifications**. Their fit/plot/margins omissions require explicit model and exhibit reconciliation at M6/M7, not silent insertion now |
| Other standardized families | OQI A1477, IPCS A1529 and IEDF A1576–1577 include `c.z_iadt` | Do not generalize the omission to every standardized model; inclusion alone does not certify an effect |
| Fixed sensitivity/profile aliases | A4408–4417 derives `lca_iadt3` and `lca_iadt2` from the fixed category; B1/B2 and other inventories declare candidates | A declared feature set is not evidence of an actually fitted model using it |
| Score-tercile alias | A7718–7721 creates and labels `h_iadt3`; later distribution/profile inventories list it | Continuous-score/sample changes can change this alias; a fixed-category-only change does not directly do so |
| Preferred/fitted class-defining route | Stable binary M1 A6683–6685, preferred hybrid H1 A8783–8817/A8920–8927, and the actual 12-input k-means/Ward fits A7209–7261 exclude IADT | Do not claim IADT necessarily drove preferred or fitted benchmark classes from an all-index candidate inventory. No fitted class solution or effect was checked here |
| Post-class profiles/centroids | Continuous IADT enters external profile, centroid and wider index summaries | A score change directly changes the profile input. Same-sample post-class separation is descriptive/internal consistency, not independent validation or a causal mechanism |

A later replay must pin each actual input/reload and stage-specific sample. Compatibility across stored IADT variables is not equality of whole datasets, IVS states, regression outputs or LCA solutions; in particular it does not resolve the separate **IVS-05** historical two-component finding.

## 6. Latent and observed numerical/missingness behavior

The diagnostic exhausts **9³=729 synthetic patterns** from each item's five legal values plus the preparation's `98`/`99` sentinels, system missing and extended missing `.a`. This is not 729 legal questionnaire profiles: 125 have all three legal components, 300 have two, 240 have one and 64 have none. Available-component means and float arithmetic match independently declared expectations.

- Every all-missing synthetic profile has a missing score but historical category 3: Stata numeric missing is above a finite cutoff. **No such case is observed in the 423 coded rows or the 17 complete-index states.**
- The 11 nominal cutoff probes preserve system and extended missings and show float-stored `.33` classified medium and float-stored `.66` classified high, while double-stored nominal boundaries satisfy the inclusive lower rule. Unlike the preceding IAT/IVS findings, these are **not attainable exact IADT means** from quarter increments with one/two/three available components. No observed participant-boundary misclassification is established. [Stata numeric storage/precision guidance](https://www.stata.com/manuals/u12.pdf).
- Seven malformed/sentinel controls show that `0`, `6`, `97` and `-1` are not range-guarded and can produce scores outside 0–1. The undeclared fractional code `2.5` gives an apparently in-range score .375, so a range check alone is insufficient; observed historical-state domains are checked against exact choice membership. `98`/`99` alone are recoded missing. **No illegal nonmissing code is observed**; this is future input-validation exposure, not evidence the historical data contain those values.
- Constant complete high answers yield score 1 and category high but missing standardized scores; an all-missing sample also has missing scores/standardization while category becomes high. These two degenerate construction samples are hypothetical, not the observed reference.

The guards, numerical policy and sample-degeneracy rules are future revision candidates. The fixtures deliberately reproduce the historical behavior rather than repairing it.

## 7. Manuscript and scientific finding register

The fresh scoped extraction of LEGACY-A includes the instrument-domain table B00443, IADT descriptive blocks B00504–B00514, regression architecture/interpretation blocks B00638–B00731, and preferred-class/profile blocks B00790/B00792/B00820/B00827. Original narrative and figures remain untouched. Block identifiers are reproducible extraction locators, not certified rendered Word page numbers.

| Finding | Evidence / scientific concern | Later disposition required |
| --- | --- | --- |
| **IADT-01 — observed structural composition/weights** | 323/99/1 scores average three/two/one items because of phone-specific applicability, not applicable-item nonresponse | Define a defensible cross-group construct/estimand and document any sensitivity or scoring revision before implementation; preserve historical scores/sample |
| **IADT-02 — perceived confidence and inference limits** | B00505–06 moves from endorsement to mastery, autonomy and financial inclusion; B00510/B00514 infers skills development/catalysis from cross-sectional means/correlation; later coefficient interpretations imply mediation or protective mechanisms | Use confidence/association language unless independent evidence supports competence, mediation, temporal learning, protection or causal effects; do not treat omitted/non-significant estimates as proof of an indirect pathway |
| **IADT-03 — latent guard/boundary/standardization exposure** | All-missing→high; unguarded illegal codes; degenerate standardization; float nominal probes, but no observed boundary-error case for legal score support | Explicit future safeguards and numerical definition; do not claim current misclassification or silently alter fixed cutoffs |
| **IADT-04 — observed source specification difference** | Four raw-vs-standardized/AME counterparts omit IADT, despite declared standardized control macro | Pin fitted commands, stored outputs, actual samples and display targets in protected M6; record a justified M7 decision, not automatic add-back or an unestimated effect claim |
| **IADT-05 — categories, terciles and validation claims** | 276 differing assignments and uneven tercile groups; post-class IADT summaries are not preferred class-defining input or independent validation | Keep fixed and empirical labels/sample definitions separate; justify ordinal spacing, weights/cutoffs and psychometric claims; audit profile/validation wording and actual fitted paths |

B00506's denominator/rounded proportion also requires the later Figure 11 check. B00510's .52/.83 means and B00514's correlation are located, **not freshly certified numerical exhibits**. B00820's broader-centroid claim cannot by itself establish out-of-sample or independent external validity. The qualitative contribution is neither reinterpreted nor edited by these quantitative findings.

## 8. Execution failures, independent review and source/privacy retention

The only definitive statistical acceptance evidence is **`iadt_driver.log`**, **`iadt_readback.log`** and the final-session run in the ignored `workflow_query_receipts.json`. Both guarded runs return zero and satisfy their explicit completion markers. Aggregate read-back preserves CSV header case, UTF-8 and double precision; float outputs are recast to float for storage-consistent fixture checks. All source/working frames are dropped; only an empty default frame remains.

Rejected/superseded attempts are retained and labelled: an entry assumption superseded by the owner's commit; manually shortened input paths; dollar-expansion in a diagnostic literal; an opening-group assertion accidentally applied to its closing row; CSV header-case assumptions; and duplicate appended catalogue IDs. They are diagnostic/provenance issues corrected before acceptance, not missing project sources, source mutations or accepted scientific findings. Earlier zero-return runs without the final schema/alias checks are not the final evidence.

The final metadata check verifies **768 overlapping original-source byte/size checks** (765 prior-contract checks plus the separately preserved three), **92 retained prior private fingerprints**, all resolving workflow pointers, ignored private outputs, the original 124 primary tasks and 14 milestones, unchanged preparation/analysis/legacy/output bytes, unchanged prior exhibit report, and empty staging. Counts of byte checks are not counts of distinct files or reviewed scientific sources. Private evidence contains specifications, aggregates, synthetic values and source locators, never respondent-level exports, keys or contact values.

The existing `main.tex` stays an academic preparation record in its current editor, with its preamble unchanged. The fresh post-edit native compile attempt fails during initialization with `Unable to find standard directories for platform`; layout is unverified. This does not authorize a replacement PDF/tab, compiler installation or Overleaf synchronization. No original/source was deleted, moved, recoded or overwritten, and no visibility/access control, stage/commit/push, anonymous derivative, public release or external message was performed.

## 9. Granular task acceptance and next workflow

| Child | Bounded evidence supporting completion |
| --- | --- |
| **M4.03.5.a** | Five pinned versions; full enclosing chain, item/phone/eligibility rules, declared codes, requiredness and string/nesting guards |
| **M4.03.5.b** | 60 scoped applicability/domain checks, 390 domain-count rows and 23 protected source comparisons; excluded/structural-missing states retained |
| **M5.02.3.a** | Ten unchanged ordered operations; direction, quarter scaling, available-component weighting, sample standardization and decimal fixed cutoffs explicit |
| **M5.02.3.b** | Six float variables exact for the 423-row reference and all 17 complete catalogue states; no source save or downstream estimator |
| **M5.02.3.c** | 729 patterns, 11 nominal probes, seven malformed controls and two degenerate samples; observed and latent concerns separated |
| **M5.02.3.d** | Manuscript/consumer mapping, four omitted counterpart controls, fixed versus score-tercile distinctions and 23 exact stored-alias checks; no model impact inferred |
| **M5.02.3.e** | Separate critic, definitive aggregate read-back, byte/ignore/pointer/task/gate checks, empty Stata state and scoped handoff/commit proposal |

**Next immediate task: M4.03.6 / M5.02.4 — historical ICDP measurement audit**, covering Preparation P1291–1347 and the four actual source fields `q3_20`–`q3_23`. Use the same bounded instrument/domain/recipe/replay/fixture/consumer/review sequence, with attention to opportunity-dependent skips, stated behavior versus observed performance, 0–100 component mappings followed by 0–1 scaling, and fixed categories versus downstream aliases. Do not fit models or repair production code as part of that next historical audit.

Remaining measures, state-specific downstream/exhibit reconciliation and protected estimator replication must precede M7's explicit retrospective revision decisions. IADT-01–05 are open scientific candidates, not silently implemented corrections. The qualitative and release boundaries and the ITD-first four-journal sequence remain unchanged.
