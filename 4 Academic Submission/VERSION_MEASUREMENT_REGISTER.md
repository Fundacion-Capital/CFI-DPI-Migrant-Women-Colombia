# Version-aware measurement and dependency register

Checked 5 October 2026 against `main` at `ce69fd96c959c9cf9a0391801eb22986692d121e`. This is a **bounded pre-estimation audit**, not a scientific revision, completed measurement gate, or anonymous-data release. The author-selected 31 July full manuscript remains the academic foundation. The M0–M13 sequence and all 124 primary task IDs remain unchanged.

This register completes the next scoped review specified in [HISTORICAL_INPUT_CONTRACT.md](HISTORICAL_INPUT_CONTRACT.md): geography, the 17 later-added text fields, every changed early choice list, their source-level analytical dependencies, a protected replay contract, and an updated **proposal** for disclosure handling. All originals, historical code, sample restrictions, indices, regressions, LCA specifications and results, and qualitative material remain unchanged.

## 1. Evidence and acceptance boundary

All form-content, respondent-cell, schema and diagnostic execution used Stata MCP in an isolated named session. No estimator, legacy master, package installation or external form upload was run. Native helpers handled hashes, authored source-text locators and proposal metadata only.

| Evidence actually checked | Result | What it does not establish |
|---|---|---|
| Five used spreadsheet definitions, pinned raw and coded states | Each used version has a matched definition; source dimensions are 490 × 267 and 423 × 439 | Historical compiled XML, device deployment, consent/eligibility validity, or complete scientific baseline |
| Scoped questionnaire and choice dictionaries | 121 question-specification rows and 509 supplied choice rows; 46 exact differing dictionary-row records across four historical versions versus the current used definition | 46 different questions or respondent changes; semantic equivalence of changed options |
| Coded-answer domains | All 120 field/version/source checks pass: 12 linked questions × five versions × two sources, with no out-of-version answer tokens | Full relevance, selection-count constraints, mutually exclusive answers, measurement validity or scientific parity |
| Later-added text availability | 170 field/version/source checks pass; every one of the 17 fields is undefined in the first two used versions and empty there | Respondent refusal or nonresponse in versions that never offered the field |
| Defined text fields' own triggers | Observed text never occurs outside its own declared parent/option trigger in these checks | Full enclosing-group relevance or all reasons for a missing text answer |
| Diagnostic controls | Eight synthetic token fixtures pass, including empty, single, multiple, repeated-valid, invalid and boundary-confusable codes; receipt assertions and completion markers pass | A statistical model has been reproduced |
| Authored source review | 455 executable-statement/metadata locators supplement a separate read-only review of geography and the text fields | Exhaustive semantic interpretation of every unrelated analysis line or actual runtime branches |
| Anonymous-field proposal refresh | 38 existing proposal rows receive scoped dependency notes; all 679 snapshot rows remain explicitly unapproved | A fresh full-source disclosure inventory, approved public allowlist, anonymous derivative or release permission |

The 121 specification rows also contain the already-existing `q2_3_otro` text field as a control and the contact-field specification. They are not 121 newly added fields. The 706 raw/coded schema occurrences are 267 + 439, not 706 unique variables or the earlier 36-source disclosure inventory.

Private instruments, exact response counts, paths, schemas, checks and review receipts remain ignored in `audit-local/intake/measurement-ce69fd9/`. No respondent names, contact values, keys, narrative answers or joint rare-cell distributions are published in this register. Earlier all-source privacy evidence remains a dated snapshot, not silently recertified.

The diagnostic was **not accepted on file existence or a tool success flag**. A wrong input filename, an interrupted multiline block, a failed expression-parser test and a current-frame cleanup error were resolved and the final driver was rerun from an empty session. The final run and independent receipt assertions provide the acceptance evidence; incomplete runs are retained as such in the private execution receipt.

## 2. Geography: different meanings and different analytical states

The first two used definitions, `2512090157` and `2512091719`, encode `departamento` choice 4 as **Other**. The later three encode 4 as **Soacha**. Choice 5, **Meta**, appears in the current used definition `2602120658` but not the four earlier used definitions. Codes 1–3 retain their corresponding city choices.

Preparation applies a later universal label to `q3`. That does not retrospectively identify an early “Other” response as Soacha. The restricted prior checks establish that the ambiguity is relevant to retained data; its rare version/geography count is deliberately not published. No record has been inferred, reclassified or excluded.

Evidence aliases below refer to the actual authored files:

- **P:** [1 Data Preparation_CFI DPI Migrant Women Colombia.do](<../1 Code/1 Data Preparation_CFI DPI Migrant Women Colombia.do>), SHA-256 `E6A9E542DCFF1067DCDA7A37A19B5CFF542B65B54622F198C240A419DC0ED449`.
- **A:** [2 Analysis_CFI DPI Migrant Women Colombia.do](<../1 Code/2 Analysis_CFI DPI Migrant Women Colombia.do>), SHA-256 `714377CA31DE2B6D70DB0994E3C7EF6A38374165D7B1FB7C7ABEB3B3F56549C9`.
- **M:** [0 Master Code_CFI DPI Migrant Women Colombia.do](<../1 Code/0 Master Code_CFI DPI Migrant Women Colombia.do>), SHA-256 `D2EC519440281BFD0316EC9CD7DE1BDF64AFADFF5E7959E43A774F33323C7B39`.

| State / consumer | Exact source evidence | Meaning and unresolved issue |
|---|---|---|
| Stored `q3` and labels | P 75–78; 1019–1020 | Original numeric response is retained, but preparation labels 4 Soacha and 5 Meta without conditioning on form version. Preserve original codes and version; do not certify a harmonized residence measure. |
| Early residence and IVS-by-city graphics | A 27; 53–72; 144–154 | Load the output-directory coded copy before the regression recode. `q3` stratifies the IVS chart; it is not an IVS score component. |
| Core regression-stage `q3` | A 1105–1112; 1226 | Reload the Dropbox coded input, then change 5 to 1 in memory. The `demo_controls` macro includes `i.q3` and has 56 source consumers in OLS/logit/interaction/binary models. This is not the same geography definition as untouched coded data. |
| Preferred LCA | A 1941–1955; 8765; 8783–8795; 8816–8829 | Reloading breaks automatic inheritance of the earlier regression recode. The preferred H1 four-class model uses `h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2`, not `q3`. No direct residence-to-class-indicator edge was found; sample/input identity and downstream interpretation still matter. |
| External class profiles: `prof_city` | A 11966–11971; 12062–12077; 12428–12589 | Reload final segments and clone/encode `q3`. Class profiles, association tests and posterior-weighted distributions use this state. Stored labels are not independent validation of the early response's meaning. |
| Overlay geography: `s15_city2` | A 16065–16070; 16190–16227; 16274–16285; 16618–16706 | Map original 1/4 to one group and 2/3/5 to the other. Geography enters a complete-control sample gate, segment-membership multinomial logit, formal-remittance logit and ten continuous-index models. Code 5 is not grouped as in the core regression recode. |
| Appendix demographic frequencies | A 19499; 19556–19575; 19612–19617 | Use reloaded final-segments geography and nonmissing-category denominators; do not assume the regression-stage definition. |

**Disposition GEO-01 — REVIEW_REQUIRED:** retain the historical behaviors as separate state nodes. A later decision must specify the meaning of early Other, the rationale for Meta→Bogotá in core regressions, and the overlay comparison. No geolocation inference or scientifically revised recoding is authorized by this register. Exact regression/LCA consequences require the later protected replay, not a claim inferred from source text alone.

## 3. The 17 later-added text fields

All 17 are absent from the first two used definitions and present in `2512111044`, `2512121811` and `2602120658`. A blank in the earlier versions is **structural unavailability**, not an offered-but-unanswered question and never automatically a scored zero.

The source review finds exactly two explicit preparation uses of each: an unguarded variable label and an unguarded note. No explicit value-scoring, regression, exclusion or LCA-indicator use occurs in M/P/A. Their **presence is nevertheless required by those metadata commands**. Whole-dataset saves, signatures and exports can also retain or use their contents. “Not explicitly scored” therefore does not mean “safe to release” or “safe to drop before preparation.”

| Text field | Own parent / selected code | P label / note lines |
|---|---|---:|
| `q3_6_otro` | `q3_6` / 6 | 172 / 173 |
| `q4_1_otro` | `q4_1` / 8 | 260 / 261 |
| `q4_3_otro` | `q4_3` / 5 | 278 / 279 |
| `q4_11_otro` | `q4_11` / 6 | 301 / 302 |
| `q4_23_otro` | `q4_23` / 9 | 343 / 344 |
| `q5_1_otro` | `q5_1` / 5 | 382 / 383 |
| `q5_2_otro` | `q5_2` / 5 | 397 / 398 |
| `q5_10_otro` | `q5_10` / 7 | 440 / 441 |
| `q5_12_otro` | `q5_12` / 7 | 453 / 454 |
| `q5_13_otro` | `q5_13` / 7 | 469 / 470 |
| `q6_4_otro` | `q6_4` / 5 | 547 / 548 |
| `q6_5_otro` | `q6_5` / 5 | 555 / 556 |
| `q6_10_otro` | `q6_10` / 5 | 578 / 579 |
| `q6_12_otro` | `q6_12` / 7 | 598 / 599 |
| `q6_25_otro` | `q6_25` / 6 | 666 / 667 |
| `q6_26_otro` | `q6_26` / 5 | 674 / 675 |
| `q7_21_otro` | `q7_21` / 6 | 777 / 778 |

The diagnostic checks the field's **own** `selected(parent, option)` expression, not the complete enclosing-group eligibility chain. SurveyCTO documents that relevance applies to both fields and groups, so the full chain is a separate required check. [Official relevance documentation](https://docs.surveycto.com/02-designing-forms/01-core-concepts/08.relevance.html).

**Disposition TEXT-01 — BOUNDED_CHECK_PASS / FULL_SKIP_REVIEW_PENDING:** version availability and own-trigger consistency are checked; classify other blanks only after tracing parent/group relevance, refusal/don't-know conventions and observed response states. Keep free text restricted. The older `q2_3_otro` control is present in all five definitions and must not be described as a later addition.

## 4. All 13 changed early choice lists

Changes below compare the historical used definitions with current used `2602120658`. “First” means `2512090157`; “first two” includes `2512091719`. Third/fourth used definitions otherwise match these scoped current choice rows, apart from the later addition of Meta. Dictionary comparison preserves full rows and multiplicity; it does not renumber codes.

| List → linked field | Verified change | Source dependency / review consequence |
|---|---|---|
| `departamento` → `q3` | First two: 4 Other becomes Soacha; current adds 5 Meta | GEO-01 above: labels, descriptives, indirect regression controls, external profiles, overlays and Appendix D |
| `acceso` → `q3_6` | First two: code 6 Other becomes Other (specify), with different surrounding whitespace in one definition | P 1207–1211 → `access_score` → `iat_score` at P 1231–1234 → regression `block_B` and index profiles/alternative LCA uses. Numeric treatment is unchanged, but the question is access location; comments referring to a payment plan/recarga need construct review, not silent correction. |
| `q37` → `q5_11` | First two: code 6 Other (specify) is removed | P 443–446; metadata and whole-dataset retention. No explicit scoring consumer found; P 1509's “used in tabulations” is a comment, not proof an executed table exists. |
| `q82` → `q7_10` | First: code 7 Other (specify) is removed | P 1827–1840 → `e1_valora_prevencion` → IPCS → outcome regressions and profiles/alternative constructs. This is not a preferred H1 indicator. |
| `q84` → `q7_12` | First: code 7 Other (specify) is removed | P 727–730; metadata/pass-through, no explicit score consumer found. Do not relabel an old Other as a named complaint channel. |
| `q88` → `q7_16` | First: code 6 Other (specify) becomes None of the above | P 747–750; later universal labels alter meaning even though no explicit index formula uses this field. |
| `q93` → `q7_21` | First: code 4 “Tato y empatía” becomes “Tacto y empatía” | P 772–778; a spelling/label correction, not an observed outcome or numerical correction. Its later text companion is separately protected. |
| `q100` → no selecting field | First: code 7 Other becomes None of the above | No `select_one`/`select_multiple` question references this list in any of the five scoped definitions. Treat as an unreferenced dictionary list, not as `q9_5` or an analytical variable. No model impact inferred. |
| `q110` → `q9_17` | First: code 5 Other becomes None of the above | P 844–849; dummy family `q9_17_1/2/3` → `sum_consecuencias` → `f2_sin_consecuencias` → ICPF at P 2040–2057. Code 5 is not in that sum; meaning, option availability and missingness still need review. The sum also includes the option labelled “No pasaría nada”: an existing construct question, not a newly implemented correction. |
| `q114` → `q10_1` | First: code 11 Other becomes Language/terms; adds 12, 14, 15, 16 and 98 | P 2162–2164 → `g2_barrera_principal` → IBPD; A 933–970 relabels and graphs barriers using later meanings. Do not apply later labels universally or treat earlier unavailable options as negative answers. |
| `q115` → `q10_2` | First: adds code 1 No own phone; code 16 Other becomes None; spelling corrected for document and distance options | P 2166–2172 sums dummy options → `g2_barreras_extra_bin` → IBPD. The parent multiselect string and dummy columns are distinct dependencies; domain membership alone does not validate their concordance or missing/zero behavior. |
| `q116` → `q10_3` | First two: code 10 Other becomes None of the above | P 2084–2093 creates seven `enabler_*` flags; A 988 onward collapses the generated wildcard for the top-five chart; A 19622–19623 includes all ten option dummies in the appendix. `q10_3` is not a component of the IEH score at P 2115–2149. |
| `q125` → `q10_14` | First two: code 6 Other (specify) becomes Other entity | P 2101–2102 creates formal/informal accompaniment-provider flags. These are not components of the IEH score. Later labels still need faithful interpretation. |

**Disposition CHOICE-01 — DOMAIN_CHECK_PASS / MEANING_REVIEW_REQUIRED:** observed answers fit their version-specific domains. No assertion of equivalent measurement, comparable option opportunity, corrected labels, unchanged estimates or absence of scientific consequences follows from that pass.

The contact field `q11_3` is **integer in the first three used definitions and text in the last two**. This is a contact/protection issue, never an analytical outcome or reason to publish a telephone field. Both contact fields remain restricted irrespective of storage type.

SurveyCTO explains that updated exports can reflect later form definitions, including changed option labels. That is a reason to retain version-specific meaning, not proof of the cause of any individual recorded value or this project's clock discrepancy. [Official form-update documentation](https://docs.surveycto.com/02-designing-forms/01-core-concepts/10.updating.html).

## 5. Dependency and disclosure proposal: no anonymous data created

The review separates **metadata prerequisite**, **substantive computation**, **whole-dataset pass-through**, **dataset signature/storage**, **derived dummy**, **macro consumer**, **reload boundary**, and **export**. They are not interchangeable “used/unused” flags.

| Field family | Current proposal | Scientific/privacy boundary |
|---|---|---|
| Names, telephones, staff/account/device information | Restricted originals only; remove from any separately approved public derivative | No removal performed. A NoPII filename is not certification. |
| The 17 text companions and existing narrative fields | Keep restricted; candidate omission only after exact export-routing and dependency approval | Drop-after-preparation and drop-before-preparation are different operations; unguarded labels/notes make early stripping non-equivalent. |
| Versioned categorical parents and option dummies | Preserve exact historical values privately; public candidacy remains subject to joint review | No harmonization, coarsening, new zero, recoding, exclusion or renumbering. Verify parent/dummy concordance and complete analytic parity first. |
| Residence, age and other quasi-identifiers | Joint linkage/disclosure hold | A valid answer domain is not anonymity. Small combinations and previously exposed records remain relevant. |
| Source keys, sort identity and posterior vectors | Restricted source identities/crosswalk; replay order and fingerprint review required | Rekeying/reordering may affect stochastic reproducibility. Do not export original keys or assume a new ID prevents linkage. |
| Derived geography, scores, class and policy annotations | Recompute or retain only under a later approved field contract | Distinguish direct class indicators from external profiles and exploratory downstream regressions. |

Source-visible participant saves/exports at A 9123–9126, 9711–9716 and 19124–19137 have no explicit variable allowlist. `order` changes column order; it does **not** remove columns. These statements require later isolated export routing, not a claim that the present public package is safe. Existing Git/history exposure remains unresolved; the owner's keep-public decision is respected.

The private refreshed proposal retains the earlier 679-name snapshot and adds scoped notes to 38 existing rows, current raw/coded storage metadata where available, and explicit NOT_APPROVED status. It does not silently certify the other rows or change the original proposal. **Zero fields are approved for public release.**

## 6. Protected historical replay contract

This contract is specified, **not executed or cleared for a scientific gate**. Existing [historical input, order and clock findings](HISTORICAL_INPUT_CONTRACT.md) remain binding.

| Preflight / checkpoint | Required behavior before M6 execution |
|---|---|
| Immutable inputs | Pin original authored M/P/A, all necessary intermediate/coded states, chosen legacy manuscript, packages and historical outputs. Keep respondent-level work restricted and all sources untouched. |
| Raw-to-audit clock limit | Preserve historical audit/coded timestamps. Owner confirms original export reports/settings no longer exist. No invented +6h36s conversion, silent repinning, or claim of exact raw-to-audit reconstruction. A replay starting at an intermediate must disclose that starting point. |
| Execution adapter | Inspect inactive legacy master dispatch and package-install paths first. Use the minimum reviewed adapter/disposable code copies needed to route every save, graph, model and export to isolated ignored storage. Never run the unchanged master against its original output directories. |
| File reloads | Reconcile the early output-coded copy, the later Dropbox-coded input, LCA preferred/fallback inputs and subsequent intermediate reloads. Hash the actual selected branches; the current session's contents do not certify these identities. |
| Environment and RNG | Stata MCP only; declare runtime/edition, version directives, actual vendored command/library/scheme resolution, wrapper seed injection, initial order and stage-specific RNG state. Master seed 6427961 and preferred H1 seed/sortseed 6529004 are source facts, not reproduced estimates. |
| Stage-specific samples | Test historical exclusions separately from positive eligibility/consent/completion assumptions; record each descriptive, correlation, regression, LCA and overlay denominator and failed assertions. Do not relabel exclusions as attrition. |
| Version meaning | Preserve source codes and differing geography states. A historical replay reproduces a behavior; it does not endorse that behavior or become an academic correction. |
| Scientific reconciliation | Compare every retained result family with pinned historical outputs, declared tolerances, estimator diagnostics and warnings. New coefficients or class solutions stay private and unaccepted until the scientific checks pass. |
| Output and disclosure | No unrestricted participant export, original overwrite, public data, Git cleanup, commit/push or Overleaf synchronization. Anonymous-data implementation/release needs its exact separate approved contract. |

## 7. Completion decision and next smallest task

**Completed and re-audited in this workflow:** the scoped version-aware register, real-data domain and structural-availability checks, geography/text separate source review, transitive dependency distinctions, protected replay specification, and scoped disclosure-proposal refresh. Final evidence records 765 unchanged source-byte checks, all 78 resolving artifact pointers, all 124 primary IDs and 14 milestones retained, ignored private receipts, six scoped public-file changes, an empty staging area and an empty named Stata session. String-length guards prevent silent diagnostic truncation; the guarded driver and independent receipt assertions both pass. The private validation accepts this bounded scope, not any parent scientific or release gate. The existing main.tex remains in place, but compilation/layout is unverified because native compiler initialization fails with `Unable to find standard directories for platform`.

**Not completed:** M0; Baseline, Data, Measurement or Replication Gates; full group-relevance and option-dummy concordance; every index formula and missingness behavior; exact historical estimator replay; retrospective scientific revision decisions; ethics/rights; anonymous data; remediation of existing Git/history exposure; source-temporary-copy housekeeping; public release or live Overleaf synchronization.

**Follow-up delivered 6 October 2026 — M4.03.3 / M5.02.1:** the [historical IAT audit](IAT_MEASUREMENT_AUDIT.md) verifies its complete scoped eligibility/group/item relevance, six-item domains, five scored components, normalization, standardization and stored categories. All 29 ordered scoring statements match the source; all 3,384 stored cells reproduce exactly. The 90 relevance/domain, 27 source and 20 fixture checks pass. This new IAT-specific evidence does not retrospectively expand the older text-field own-trigger checks into a global relevance pass.

**Scientific findings remain open:** 71 nominal 0.80 values are historically high because of float storage despite the inclusive medium boundary; active item labels/comments disagree with the instruments; three scores use fewer than five components. Ordered N/A behavior and a latent, not observed, all-missing-to-high rule remain unchanged. No index, label, category, model or result was corrected. The preferred H1 defining indicators exclude IAT; other aliases and empirical terciles must remain distinct. The prior completion metrics above identify that earlier workflow, not the current artifact count.

**Follow-up delivered 6 October 2026 — M4.03.4 / M5.02.2:** the [historical IVS audit](IVS_MEASUREMENT_AUDIT.md) now verifies its three items, five-version definitions/choices, enclosing eligibility/group relevance, tenure, normalization, components, score, standardization and categories. All 26 ordered operational statements match the unchanged source; all eight float variables reproduce exactly across 423 rows (3,384 cells). The 45 domain/full-relevance, 21 source, 20 fixture and four returned-state/constant-range controls pass. All actual scores use three components. Fifteen IVS item/version rows and 95 choice rows agree across five definitions; this does not certify every index or device deployment.

**Open IVS findings:** one nominal 0.33 value is medium and three nominal 0.66 values are high by floating comparison. Main occupation is not proof of formality/stability; vulnerability ordering/weights/cutoffs need rationale. Legal arrival year 2026, constant tenure and all-missing-to-high handling are latent edge cases, not failures observed in the 423 coded rows. The initial stale-return concern is rejected for the inspected `_gmax` implementation: it refreshes extrema internally and the stored normalization reproduces. The preferred `h_ivs3` is a continuous-score empirical tercile, not fixed `ivs_cat`; category-only versus score/sample changes have distinct consumers. No model impact or legacy exhibit parity is certified, and no correction was implemented.

**Follow-up delivered 6 October 2026 — M2.04.1 / M6.08.1:** the [IAT–IVS exhibit audit](IAT_IVS_EXHIBIT_AUDIT.md) pins exact Table 2 cells and five inline figure relationships. All five images match earlier Git PNG blobs exactly, not current PNG bytes; all six current output/appendix copy pairs are identical. Word age/city images are correctly captioned despite reversed source-file numbering. Stata MCP confirms six Table 2 count differences across all 14 inspected indexed states, an internal 47.96% versus 47.92% arithmetic error, 22/27 legacy age/city cell differences and numerical compatibility for Figures 9–10. All 43 current displayed cells agree. Figure 6 has old positive bars below the selected score minimum; exact old bins/data are not recovered.

**Open EXH-01–06:** old IVS generating data/runtime/logs are unverified; promised table means are absent; the old low-IVS IAT mean/sevenfold contrast is not supported by the selected state; frequency labels, union/literacy/outage denominators and causal/construct wording need explicit later revision. No replacement table/graph, production correction, estimator, geography harmonization or anonymous derivative was made. The report/receipts distinguish byte identity and numerical compatibility from scientific validation and full Word rendering.

**Final audit adds an actionable provenance dependency:** six older coded Git blobs at the old-image presence commits have no identical-byte match in the pinned archive/catalogue; three use the historical analysis-input filename. Their object IDs, hashes, sizes, load statements and exact restricted-copy proposal are private. No new dataset copy/opening occurred, and no claim that historical generating data no longer exist is justified.

**Subsequent M6.08.1.e follow-up, 6 October 2026 — exact owner-authorized preservation implemented:** three historical analysis-input versions were copied into the restricted archive, with SHA-256/size and MCP readability checked; all 35 prior files remain unchanged, 38 total. Source IDs/destinations stay private. All three 423-row states reproduce the nine legacy table counts and 43 Figure 7–10 displayed cells, including .83/.73 mean compatibility; Figure 6 shape is consistent, not fully regenerated. This supersedes only the older unopened-input and unmatched-stored-state disposition.

**IVS-05 — observed old component omission:** migration-tenure normalization is missing in all 423 old rows, and stored IVS exactly averages education and occupation alone. In the current reference all three components are complete. The three old states agree across 26 protected key-aligned fields. Only normalization, IVS score (422), standardized score (423) and fixed category (117) differ against current data; selected IAT/item/group fields agree. All 29 IAT and 26 IVS value operations match the current source (9 March tenure-category label language differs). Installed-runtime tenure calculation does not reproduce the old missing component. This establishes a stored/declared-behavior discrepancy, **not its original runtime cause**. Keep old two-component and later three-component consumers separate in protected replay; no estimator impact is certified.

**EXH-01/02 refined:** old stored values and narrative means/contrast are now traceable, while unique generating file/runtime/logs, table arithmetic/missing means/naming, exact histogram rendering and scientific validity remain unresolved. EXH-03–06 remain open. The [exhibit follow-up](IAT_IVS_EXHIBIT_AUDIT.md#6-authorized-historical-input-follow-up--m6081e) and private validation document exact copies, accepted/read-back diagnostics, review and source/privacy boundaries. All scientific gates remain pending.

**Follow-up delivered 6 October 2026 — M4.03.5 / M5.02.3:** the [historical IADT audit](IADT_MEASUREMENT_AUDIT.md) now verifies all five used definitions, complete scoped consent/eligibility/group/item ancestry, phone-specific relevance, Likert domains, ten ordered scoring operations, float storage and available-item weights. All 60 applicability/domain and 23 protected source checks pass. Six stored variables reproduce exactly across 423 retained records (2,538 cells). No applicable-item nonresponse or illegal code occurs. Structural phone skips explain 323 three-, 99 two- and one one-component mean; the 100 shorter composites are not nonresponse.

Across 36 unique catalogue identities/hashes, 468 presence/numeric checks distinguish 17 complete-index states from 19 incomplete-schema states. All 102 replay records/43,146 cells and 23 available fixed/tercile-alias records/9,729 cells match exactly; 17 independently read-back score/coverage summaries confirm zero missing score/illegal item cells and the same component counts and fixed categories (11/61/351). No stored `z_iadt` is recovered. The fixed-category versus score-tercile assignments differ for 276/423 records, and quantile groups are uneven (251/36/136), not interchangeable labels.

**IADT-01–05 remain open:** changing structural component content/weights, perceived-confidence versus objective-skill/causal interpretation, latent missing/range/standardization edges, four standardized/AME specification omissions relative to full raw models, and distinct fixed/quantile/profile validation rules. The 729 synthetic patterns, 11 boundary probes, seven malformed-code controls and two degenerate samples reproduce historical behavior; nominal .33/.66 boundaries are not attainable exact legal IADT means, so no observed IADT boundary misclassification is demonstrated. Source inventories do not prove fitted IADT-sensitive classes; preferred H1 and actual hard-coded benchmark inputs omit IADT. Numerical Figure 11–12 and model consequences remain their own later audits. No source value, label, score, category, estimator, qualitative material or public derivative changed.

Definitive guarded MCP driver/read-back, separate critic and final metadata closeout support the seven bounded children, retaining 768 overlapping source-byte checks, 92 prior private fingerprints, all current pointers, original primary tasks/milestones, pending scientific gates, ignored evidence and empty staging/default session. Earlier diagnostic path/literal/group/case/identity issues are retained but excluded from acceptance. The agent made no commit/push or cloud/access change; the owner's prior six-file documentation commit during intake was separately verified. This does not retrospectively expand the older scoped checks into global construct, consent, deployment or estimator certification.

**Next task at the IADT checkpoint — M4.03.6 / M5.02.4 historical ICDP audit**, with seven instrument/domain/recipe/replay/fixture/consumer/review children in the workplan. Continue remaining measures, downstream state/exhibit reconciliation and protected historical replay before M7 decisions. No production correction, broader history copy, participant export, anonymous data, Git mutation or Overleaf synchronization is included.

**Follow-up delivered 6 October 2026 — M4.03.6 / M5.02.4:** [historical ICDP audit](ICDP_MEASUREMENT_AUDIT.md) verifies five used definitions, full scoped ancestry, four item domains, 24 ordered scoring operations and seven float-storage variables. The 125 questionnaire/155 choice rows, 90 domain/relevance checks, 540 code-count rows and 27 protected source comparisons pass. Illegal answers, applicable-item nonresponse and answers outside relevance are zero. OTP/PIN applicability is 422; QR/fraud applicability is 423. **422 four-component and one two-component score** are structurally opportunity-dependent means, not a reason for automatic imputation or exclusion.

Seven reference variables reproduce exactly across 423 records (**2,961 cells**). A 36-identity/SHA catalogue yields 612 schema checks, 17 complete-index replays, 119 variable records/**50,337 cells**, 17 checked score/coverage summaries and 23 exact alias records/**9,729 cells**. Other 19 states are not complete replays. Aliases comprise nine fixed ordinal `lca_icdp3`, eight fixed binary `lca2_icdp_high`, five `h_icdp3` quantile and one `segz_icdp` standardization; no stored `z_icdp` or `lca_icdp2` is recovered. Same-sample standardized arithmetic does not recover historical fitted samples.

Fixed counts are **30/106/287**, mean .8169326241, SD .2025430814 and range 0–1. Fixed versus score-quantile assignments differ **314/423**. The 17 observed score levels, cutoffs .8125/.9375 and groups 162/182/79 are independently read back; the upper quantile is **score 1 only**. Actual binary M1 uses the fixed-high alias; actual preferred H1 uses score-quantile `h_icdp3`; hard-coded twelve-input k-means/Ward uses `segz_icdp`. All seven inspected standardized regression counterparts retain ICDP; the prior four IADT omissions are not ICDP omissions. Category-only versus score-redesign dependencies are distinct, not demonstrated fitted consequences. Continuous-index separation in H1 profiles is internal description, not independent criterion validation.

**ICDP-01–05 remain open:** measured self-reports/hypothetical behavior versus task-performance language; normative component rankings/weights/cutoffs; opportunity-dependent composition; latent guards/precision; and actual representation/validation roles. The 4,032 synthetic combinations, 11 nominal probes, seven malformed controls and two degenerate samples pass. Two-stage float storage differs from direct score in 576 artificial three-component configurations, none observed here; observed score/category precision differences are zero. Exact legal means cannot equal .45/.80, so nominal probes do not establish actual boundary errors. Missing-to-high/unmapped omission are latent, not observed illegal answers or missing scores.

Definitive MCP driver and separate specification/aggregate read-back, independent criticism and native final receipts govern bounded acceptance. **768 overlapping original source-byte checks and 131 prior private fingerprints**, original task/milestone IDs, pending scientific/release gates, ignored evidence and zero public-field approvals remain protected. Prior IAT/IVS exhibit and IADT reports are unchanged. No participant-level export, production/index/category correction, estimator, qualitative change, source preservation copy/deletion, Git mutation or cloud/Overleaf write occurs.

**Next immediate task — M4.03.7 / M5.02.5 historical IAFF audit**, seven instrument/domain/recipe/replay/fixture/consumer/review children in the workplan. Remaining measure and exhibit audits plus protected historical replication precede explicit M7 decisions and tested historical/revised comparisons. Defining the next child is not executing it or passing a parent gate.

**Follow-up delivered 6 October 2026 — M4.03.7 / M5.02.5:** [IAFF audit](IAFF_MEASUREMENT_AUDIT.md) accepts seven bounded historical children. Five definitions preserve optional unconstrained document multiselect, required positive-only account multiselect and full /Identidad eligibility ancestry. 115 specification/145 choice rows,60 item checks,450 code-count rows,900 token/dummy checks and51 protected-source comparisons pass. No applicable-item missingness, illegal nonmissing values, duplicate tokens or parent/dummy disagreement; one none/refusal-plus-other combination remains semantic ambiguity.

IAFF account component is100 in all423; all scores have four components. Mean0.689420803782506, SD0.223379011310685, range0.25–1; fixed31/290/102 versus empirical169/152/102 differs138 at0.5. Nineteen logical source operations and seven float fields reproduce2,961 cells. Thirty-six identities/828 schema checks identify17 complete states/50,337 exact cells;23 available aliases reproduce9,729 cells. High membership coincides here, not a general fixed/quantile identity. No estimator or historical image is recertified.

The20,736 scored-input grid,1,024 document masks,11 nominal probes,eight malformed and two degenerate controls expose default-zero concealment, unmapped scalar omission and precision/SD edges. Fully missing source inputs yield0/low because document/account remain numeric0; missing-score-high is only an impossible full-recipe score-only probe. Nominal0.8 is unattainable; observed score/category precision differences are zero. Five address refusals and seven unknown phone responses score0.

IAFF-01–05 remain open: reported possessions versus actual acceptance/use; positive-only/constant account content; optional/exclusivity/refusal ambiguity; defaults/guards/precision; and operative representation/internal-validation/exhibit claims. Figure16 priority assignment differs ownership prevalence; Figure20 uses fixed IAFF despite tercile language. Internal class profiles cannot independently validate manifest content. No invented no-account response, new score, participant derivative, source edit, qualitative change or fitted inference.

Definitive MCP driver and separate read-back, independent source/receipt/report criticism and native closeout retain768 source-byte checks and167 prior private fingerprints,124 primary tasks/fourteen milestones, resolving pointers, zero approved public fields and pending scientific/release gates. No source copy/deletion, Git/cloud/access mutation or Overleaf synchronization. Same-file compile result and proposed commit title/body accompany the handoff.

**Next immediate task — M4.03.8 / M5.02.6 historical IUOF audit**, seven explicit children in the workplan. Remaining measures/exhibits and protected historical replication precede explicit M7 decisions; no parent milestone or IUOF task is completed by this checkpoint.

## 6. Historical IUOF follow-up — M4.03.8 / M5.02.6

[IUOF_MEASUREMENT_AUDIT.md](IUOF_MEASUREMENT_AUDIT.md) accepts seven bounded children. All five used forms retain seven optional account-dependent items and consent/eligibility/Identidad ancestry;140 specification/215 choice rows,120 item/relevance,645 code-count,180 routing and60 protected-source checks. q4_15's60-day stem/90-day non-use choice is stable inconsistency. Principal no-account34 and unselected-product21 use legal choices and agree across sources; reconciliation is semantic, not an automatic correction. All items relevant423;408 seven-/15 six-component means. NA99 counts6/3/10/9/13 score0; six account-sharing refusals score100.

All38 ordered operations/11 float fields reproduce4,653 reference cells exactly. Catalogue36identities/828schema/17complete states checks79,101 cells:71,910 non-category cells exact;789 original-category differences retained across five states. State37 matches raw40/70;32/33/38/39 match historical mixed raw/normalized predicate. Current code already contains d119b22's corrected normalized middle condition. Source association and recipe compatibility do not prove exact producing execution or fitted effects. All24 available actual aliases reproduce10,152 cells; z_iuof absent, not invented.

Reference mean0.7378391282320305/SD0.1871952035771307, fixed61/167/195, empirical143/142/138 differs139. Quantile upper group begins observed score≈.85, not fixed≥.8. Raw versus normalized standardized fields differ270 by at most2.384185791015625e-7; observed86 ordered/direct normalization differences yield0category changes. Exact0.5/0.8 occur1/8 times and follow actual medium/high definitions. The108,000 domain/missing grid,112 dependency guards,35 one-field invalid/six all-unmapped controls,11 nominal probes andtwo constant samples pass independent read-back. All-missing→high latent; no observed missing aggregate. Diagnostic export/string-key repairs do not change production.

IUOF-01–07 record construct mixture, recall/account/nonresponse semantics, N/A/refusal policy, precision/guards, three historical category regimes, fixed/quantile/specification distinctions and internal/causal overclaims. Figure20 fixed categories≠terciles; raw fullD includesIADT but standardized plot omits it. ActualM1 excludesIUOF; preferredH1 uses empirical h_iuof3; continuous clustering uses segz_iuof. No historical image, coefficient, probability or causal claim is newly certified.

Independent criticism, definitive MCP driver/read-back and native closeout preserve768 original byte checks/206prior fingerprints,earlier reports,124primary IDs/fourteen milestones,zero public-field approvals andpending gates. Existing main.tex/preamble/editor retained; fresh native compile receipt governs unverified layout. No participant derivative/export, production/model/qualitative change, source copy/delete, Git/cloud/access orOverleaf mutation.

**Next immediate: M4.03.9 / M5.02.7 — historical OQI audit**, seven granular instrument/domain/recipe/state/fixture/consumer/review children in the workplan. Remaining measures/exhibits and protected historical replication precede explicit M7 revisions; this checkpoint does not complete parent milestones.

**Follow-up delivered 6 October 2026 — M4.03.9 / M5.02.7: historical OQI audit.** [Full report](OQI_MEASUREMENT_AUDIT.md) records seven bounded children and OQI-01–07 open. Five forms retain full eligibility/SistemasdePagos/account/rail ancestry, requiredness and blank scoped constraints/filters. 245 specification/702 choice rows include the early-two-version q5_11 Other6 exception. 195 scalar/528 domain/570 routing/360 multiselect/126 source rows pass; zero applicable scalar nonresponse/illegal tokens/dummy differences. Principal No-account34/unselected-product21 remain semantic issues.

All50 operations/14 float fields reproduce5,922 reference cells. All423 totals nonmissing:325 nine-/98 eight-component means; omissions are valid mixed terms/privacy pairs, not absent answers. KYC excludes Other/Unknown:18 unknown-only/three Other-only profiles get100. Raw mean74.754235436730355/SD18.263080574372243; normalized mean0.747542352893392/SD0.1826308060221092. Raw45/85 fixed groups39/241/143 versus empirical141/142/140 differ105. One/three observed cutoffs classify correctly.

Catalogue36 identities/2,268 schema rows yields16 complete states/672 protected41-field/key checks.94,752 derived cells checked:87,984 OQI-only exact;660 QR differences in32/33/38/39 match older receive-only `q5_4==1` QR recipe. Two authentic source records differ from current only at that positive QR operation. Producer execution or fitted consequences are not proven. All50 present aliases/21,150 cells match actual roles. Current QR has179 domain disagreements (170missing/ninefalse positives,including85 Both unclassified), but is outside OQI mean. Analysis any_qr_use/lca_di_qr_use mappings are independently correct.

Reduced support/missing grid345,600 contains34,560 complete legal point supports, not every raw response. KYC/joint/QR/routing/missing/scalar/malformed/boundary/constant controls pass separate read-back. Full-source missing yields KYC100/score100/high; artificial component-only missing yields missing/high. Neither observed. Observed two-stage/direct normalization88 and raw/normalized std318/max2.384185791015625e-7 produce0 category precision errors. Explicit-double/scientific and nine-bit CSV roundtrips pass; no production repair.

OQI-01–07 cover mixed service/registration/transaction construct and causal claims; joint omission/weights/cutoffs; KYC unknown/Other/default/requested-versus-accepted requirements; routing/refusal/help; QR defect/history; precision/missing/constant guards; and operative representations/internal-validation/model/exhibit roles. Own standardized OQI includesIADT; M1 fixed-high binary,preferredH1 score quantiles. No fitted result/image/qualitative claim recertified.

Final independent/MCP/native chain requires768 original-byte checks/253prior fingerprints,previous reports,124primary IDs/fourteen milestones,all pointers,zero public-field approvals andpending gates; same main.tex/editor/preamble. The fresh built-in compiler fails during platform initialization (`Unable to find standard directories for platform`); compilation and rendered layout remain unverified. No production/data/model/source-copy/delete/Git/cloud/access/Overleaf or participant-export action. Next M4.03.10/M5.02.8: seven-child historical IURD audit; parent milestones and scientific/release gates remain pending.

## 8. Historical IURD follow-up — M4.03.10 / M5.02.8
**7 October2026.** [IURD audit](IURD_MEASUREMENT_AUDIT.md) accepts seven bounded historical children only. Full five-version ancestry/233spec/615choices and120question/319domain/300route/54source checks retain requiredness, optional q6_14 and recent-Yes-only operations. No account or q6 principal-manager gate is invented; q6 applicable426raw/audit versus423coded is source-specific. No illegal code, out-of-route answer or required applicable nonresponse is observed.

Twenty-six current operations/eight fields/3,384 exact reference cells;349five/51four/21three/2two-term means. Frequency99=27omitted, q6_14No45/refusal6/blank4 and55structural ops skips, opsunknown7 omitted. Legalcode4 does not exist, binary retention2–5=100 is not actual spending/share, Otherchannel5 cannot automatically be informal/cash. IURD-01–04 retain construct/recall, unknown/structural weighting and point-policy questions without automatic corrections.

Fixed30/55 groups45/129/249 versus tercile145/144/134 differs215; observed exactcutoffs2/4 correct. Rawmean58.656028334976085/SD22.37719953636819, normalizedmean0.5865602800820736/SD0.22377199473831747. Ordered/direct13 and raw/normalized std300differences/max1.78813934326171875e-7;0observed category precision effects. Undefined constant-SD and full-source-missing/high are latent controls, not observed contamination.

Thirty-six identities/1,368schema rows/17complete states;306inputchecks exact. Fifteen current states exact;37 matches four-term/graded40–70 and unknown-response defaults including historicalrawstd,38 four-term/graded45–85. Current56,682cell comparisons retain2,518differences; compatible sharedcells57,105exact. Six native source recipes/732variantfield rows/309,636cross-recipe cells,77available aliases/32,571exact cells. Byte-compressed components/categories are inventoried, not assumedfloat. No original producer/unique execution/model consequence proven. IURD-05 retains all historical regimes.

5,040rawrectangle cases contain900explicitlylegal routed cases;810arithmetic/omission/phantom4 points are not wholly legal support.80one-item/24dependency/nine score-only ULP/threefullmissing/twoconstant-sample controls and independent specification/aggregate/numerical/extendedmissing/string read-back pass. Each fractional diagnostic field explicitlydouble; weighted mean/sampleSD checked. Source-specific q6 applicability and primitive CSV column/type assumptions corrected only in ignored diagnostics. IURD-06 retains precision/domain/missing/degenerate guards.

Actual fixed/binaryM1, quantilepreferredH1 and standardizedcontinuous clustering consumers remain distinct. Same-source channel/recent-use profiling is not independent externalvalidation. Standardized IURD omitsIADT while rawfullD includesit; helperOther policies differ. LEGACY-A maximum-channel-weight/spending-share/informal-cash/causal narratives require review; original numerical images and estimator effects remain unverified. IURD-07 retains these explicit decisions. Protected qualitative content unchanged.

Definitive MCP driver/read-back/empty-session and independent/native closeout retain768original-byte checks/310priorfingerprints,earlier reports,124primary IDs/14milestones,all pointers,zero publicfieldapprovals/pendinggates. Same main.tex/preamble/editor; fresh native preview fails with Windows sandbox setup-refresh errors, layoutunverified. No alternative PDF/compiler/tab, public participant derivative/export, sourcecopy/delete, production/sample/model/output/qualitative repair, Git/cloud/access/Overleaf mutation. Full proposed commit only.

Next: **M4.03.11 / M5.02.9 historical IETR audit**, seven explicit children in workplan. Remaining measures/exhibits and protected historical replication precede explicit M7 decisions.

## 9. Historical IETR follow-up — M4.03.11 / M5.02.9

**7 October2026.** The [IETR audit](IETR_MEASUREMENT_AUDIT.md) accepts seven historical children only. Five definitions/233specification/615choices match separate native reads;15 contextual questions/225question/480route/66source checks show no illegal/out-of-relevance/required-applicable missing responses. Optional recent-use blanks4 and55structural child skips are separate from unknown/refusal/N/A.

All56 value operations plus2drops match58 interleaved source statements;12fields/5,076referencecells exact. Nine outer terms contain two nested means:249complete versus174incomplete profiles,55non-Yes recent users with≤3terms. Fee/FX temporary names reversed, q6_9FX N/A99→100 whereas q6_18no-fee4→0; q6_18literally90days, q6_11paper confirmation positive/no timing/no legal6, q6_21unpredictable6omitted. No response or scoring policy corrected.

Fixed45/85 categories13/318/92 versus142/142/139terciles differ176; oneexact45/85 eachcorrect. Rawmean/SD71.8860930495/15.2534909417; normalized0.7188609262/0.1525349114.117ordered/direct and347raw/normalized std differences(max2.384185791015625e-7),zeroobserved categoryprecisioneffects. Current missing/high and older seven-term falsezero/low controls are distinct, no observed missing total.

36identities/1,476schema/17complete states/374key-inputchecks;85,446 current sharedcells retain1,813differences. Four positive-no-confirm states32/33/38/39each83, oldseven-term37=1,481;12currentstates exact. Five native recipes/948variantfields/401,004cells;85,869source-compatible sharedcells exact including historicalrawstd.33available aliases/13,959exactcells. Original/unique producing execution, fitted consequences andexhibits notproven.

Separate specification/aggregate/weightedmeanSD/numeric/extendedmissing/stringread-back accepts113single-item,121/120rawrectangles,40/42legal pairprojections,20legal scored-inputbundles,1,399,680component-arithmetic,9score-only boundary,3current/15historical missing,5historical best/twoconstantsamples. Actual failed expectations/CSVcolumn/stringlength diagnostics repairedonly ignoredfiles, definitive rerunspass; bothMCPsessions default0×0.

| Open finding | Explicit later boundary |
|---|---|
| IETR-01 | Mixed international/domestic/latest/general/global/60–90day referents and paper confirmation; not audited timely digital performance, persistence or causal mechanisms. |
| IETR-02 | Reversed fee/FX documentation and asymmetric no-fee/N/A polarity need explicit scientific policy; not an automatic recode. |
| IETR-03 | Nested available-case weight/content differences and legal one-term100/nonuser profiles require target estimand/routing/missing/sensitivity decisions, no imputation/exclusion. |
| IETR-04 | Preserve older no-confirm/default/overwrite/seven-/nine-term regimes and audit downstream actual source/reloads/fits before choosing academic recipe. |
| IETR-05 | Legal variable6 and unknown/refusal/N/A treatment, normative ordinalpoints and60/90day wording need justification; cannot recover actual timing/cost or corrected responses. |
| IETR-06 | Domain/finite/missinghigh/constantSD/float guards latent; zero category precision change does not validate construct or fitted robustness. |
| IETR-07 | Fixed/quantile/continuous roles differ; standardizedIETR omitsIADT; h_ietr3notpreferredH1,all33explicitGSEMexcludeIETR, actualclusteringincludesit. Shared-route same-sample profiles not independent validation; inference/exhibits remainpending. |

Definitive MCP/closedlogs/independent/native closeout retain768original-byte manifestrecords/378priorfingerprints/earlierreports/124primarytasks/14milestones/allpointers/zeroapprovedpublicfields/pendinggates. Same main.tex/preamble/editor; fresh nativecompile fails before TeX preparation with Windows sandbox helper setup-refresh errors, so compilation/layout remainunverified. Actual receipts retained. No alternativePDF/compiler/tab, production/model/sample/exhibit/qualitative orparticipant derivative, sourcecopy/delete, Git/cloud/access/Overleaf change. Full proposed commit only.

Next **M4.03.12 / M5.02.10 historical IPCS audit**, seven bounded children. Remaining measurement/exhibit audits andprotected historicalreplication precede explicitM7 scientificcorrections; all parentgates remainpending.
