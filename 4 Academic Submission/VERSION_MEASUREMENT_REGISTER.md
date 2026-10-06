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

**Next immediate task — M2.04.1 / M6.08.1: historical IAT–IVS exhibit provenance.** Pin the legacy embedded Table 2/Figures 6–10 and existing output candidates, then reconcile exact relationships, caption/content, denominators and source versions with bounded Stata-MCP diagnostics where needed. No replacement exhibit, estimator, production-code correction, geography harmonization or anonymous derivative. The owner agrees in principle with justified later Data Preparation/Analysis corrections; preserve historical and revised tracks and record the M7 decisions first. M0 and full scientific/release gates remain pending.
