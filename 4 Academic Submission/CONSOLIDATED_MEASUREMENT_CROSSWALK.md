# Consolidated historical measurement and overlap crosswalk

**7 October 2026 — M5.01.1 / M5.07.1: all seven children accepted within the bounded historical-characterization contract.** This checkpoint consolidates the fifteen accepted historical measurement audits. It characterizes what the historical sources actually construct and consume; it does not endorse those measurements or reproduce fitted analyses. Independent review, actual definitive receipts and the final preservation seal govern this acceptance. All parent scientific, sample/design, method, quality, replication, ethics, privacy and release gates remain pending.

Entry is clean `main@111ed931196e22b769acfc2584dc16a56c315e85`. The previous fifteen reports and their sealed evidence are read-only. The author-selected LEGACY-A and its qualitative contribution remain unchanged. This task does not revise the academic manuscript, scientific scoring, production Stata scripts, data, regressions, LCA, figures, qualitative themes or quotations.

## 1. Evidence, coverage and limits

The public source-metadata tables in [measurement-crosswalk](measurement-crosswalk/) cover all fifteen constructs: IAT, IVS, IADT, ICDP, IAFF, IUOF, OQI, IURD, IETR, IPCS, IEDF, IAER, ICPF, IEH and IBPD. The protected packet is `audit-local/intake/measurement-crosswalk-111ed93/`; it remains ignored and is not a public replication dataset.

| Evidence | What is established | What is not established |
|---|---|---|
| Fifteen report/seal pins; 36 retained dataset identities | Previous acceptance scope and original bytes remain identifiable | A unique original producing run or every historical runtime |
| 89 current scored outer components; exact ordered ancestry | Source items, component mappings, nested terms, scale and available-case weighting | Construct validity, criterion validity or a justified scientific redesign |
| Five form-version routes from accepted instrument metadata | Item-specific requiredness, own and inherited gates, version and route references | New independent form-cell replay, complete device deployment or whole-questionnaire certification |
| 105 unordered index pairs | Literal scored overlap versus scored-to-routing, shared routing and common-method dependencies | Empirical correlations, causal effects or fitted conditional local independence |
| 99 analysis-representation candidates | Presence scope, source-local type and earlier parity evidence are distinguished | Every declared alias exists, or every retained alias is recreated twice |
| 33 explicit GSEM bodies; five explicit cluster commands; 45 core regression specifications | Actual explicit source inputs and core outcome/predictor roles | Successful execution, identical fitted samples, coefficients, starts, class selection or historical estimates |
| 2,124 full-source consumer locators | Additional declarations, construction and profile/exhibit uses remain traceable in the protected catalogue | Automatic expansion of every loop/program or proof that every source branch ran |

The current preparation source remains SHA-256 `E6A9E542DCFF1067DCDA7A37A19B5CFF542B65B54622F198C240A419DC0ED449`; Analysis remains `714377CA31DE2B6D70DB0994E3C7EF6A38374165D7B1FB7C7ABEB3B3F56549C9`. Native metadata utilities reuse the established statement parser, CSV and hashing helpers. All numerical, tabular analytical, legal-code polarity and weight checks use **Stata MCP**, never another statistical backend.

## 2. How to read the crosswalk

| Table | Role |
|---|---|
| [measurement_manifest.csv](measurement-crosswalk/measurement_manifest.csv) | Fifteen report/seal hashes, accepted packet IDs, current roots, score/category names, scored item sets and route sets |
| [components.csv](measurement-crosswalk/components.csv) | Every current outer term, exact source operations/lines, raw leaves, questionnaire parent, inner-term count and conditional weight rule |
| [current_source_operations.csv](measurement-crosswalk/current_source_operations.csv) | Native ordered current operations, including the IADT recode and IETR temporary drops; no formula repair |
| [recipe_operations.csv](measurement-crosswalk/recipe_operations.csv) | Authenticated ordered historical textual recipes where captured; current-authored fallback is explicitly labelled, never called original execution |
| [instrument_routes.csv](measurement-crosswalk/instrument_routes.csv) | Per-item/component/form own and inherited applicability, requiredness and route-input lineage |
| [measurement_contracts.csv](measurement-crosswalk/measurement_contracts.csv) | Current reference denominator distributions, polarity, scale, cut rules, sentinel/missing defaults and historical regime limits |
| [overlap_pairs.csv](measurement-crosswalk/overlap_pairs.csv) | All 105 pairs, including direction of scored-to-routing links and zero independent-validation claims |
| [representations.csv](measurement-crosswalk/representations.csv) | Actual candidate aliases, presence counts, source-local type, parity-record scope and declared-but-absent distinctions; no state-level respondent values |
| [consumer_summary.csv](measurement-crosswalk/consumer_summary.csv) | Inclusion counts across explicit GSEM/cluster commands and preferred final H1; these are command counts, not independent fitted analyses |
| [core_consumer_summary.csv](measurement-crosswalk/core_consumer_summary.csv) | Source-level outcome/predictor counts across the 45 core specifications |
| [core_model_specifications.csv](measurement-crosswalk/core_model_specifications.csv) | Every core equation and preceding literal-global expansion, with native source line and model ID |
| [open_findings.csv](measurement-crosswalk/open_findings.csv) | All 103 inherited blocking-issue entries, verbatim and still open, including measurement, exhibit, provenance, governance and privacy holds |

Hashes certify pinned evidence identity, not scientific acceptability. The canonical scientific findings remain in the unchanged individual audit reports; the consolidated tables provide an additional navigation and comparison layer, not replacement findings.

## 3. Sample, applicability and weighting contract

The retained analysis cohort is 423 survey submissions. The recovered raw/audit cohort contains 490 submissions. Earlier row/key and selection checks are inherited, not repeated or promoted here. Eligibility combines consent, woman respondent, adult age and a household international-remittance criterion. It does **not** by itself prove international-migrant status, personal account ownership, personal receipt or active payment use. Model-specific listwise exclusions, fit-specific N and dependence/sampling assumptions remain M4/M6 obligations. A common eligible survey cohort is not proof that every model used the same rows.

Four distinct states must remain separate: an item not available in a form version; a structural skip due to relevance; a genuinely missing applicable response; and a legal sentinel/response deliberately mapped to zero, positive points or omission. A generated nonmissing component does not necessarily establish a substantive response: default OR/rowtotal logic can create zeros or positive reverse-coded terms.

The common `rowmean` arithmetic uses **1/n of the available outer terms**, not a universal full-construct weight. Current examples are IAT 420 five-/2 four-/1 three-term scores; IADT 323 three-/99 two-/1 one-term; ICDP 422 four-/1 two-term; OQI 325 nine-/98 eight-term; IURD 349 five-/51 four-/21 three-/2 two-term; IPCS 238 six-/185 five-term; and IEH 186 six-/237 five-term. IEDF has 29 two-/290 three-/8 five-/96 six-term scores. These are accepted historical reference aggregates, not newly computed respondent statistics.

IETR is particularly consequential: nine outer terms contain two nested two-input means. A complete singleton question has weight 1/9; each question within a complete cost or confirmation pair has weight 1/18. If k inner terms and n outer terms are available, a nested question's conditional arithmetic weight is **1/(n×k)**. The eleven contributing questions therefore are not eleven equally weighted items. Current IETR has 249 complete nine-term and 174 partial profiles; the per-n distribution is retained in the contract table. No new available-case policy is chosen.

IAFF, IAER, ICPF and IBPD have complete generated outer terms for all 423 current respondents, but completeness alone does not remove construct/default/sentinel concerns. IAFF's account term is constant positive; ICPF's routed mitigation term frequently defaults positive; IBPD's default extra-barrier subtotal can fabricate an available zero under completely absent raw inputs.

## 4. Scoring, polarity, defaults and historical versions

The original mappings, storage order and scale are preserved. A raw 0–100 mean, its float 0–1 normalization, an analysis z-score, a fixed ordinal category, a fixed binary recode, empirical quantiles and a source-local median binary are **different representations**. Source-local aliases cannot be substituted on the strength of similar names. Quantile ties can leave fewer populated groups and non-equal group sizes; sample-specific SD/min-max transforms are cohort-dependent.

The contract table retains every construct's index-specific endpoints. They are not one generic low/middle/high rule: for example IAT/ICDP use inclusive .45/.80 middle boundaries; IAFF uses .50/.80 with an inclusive upper middle endpoint; IUOF uses .50/.80 with .80 already high; IURD uses raw30/55; IEDF uses45/80; and IEH/IBPD guard the high category against missing while many earlier scales do not. Latent completely missing scores often become high under unguarded Stata comparisons; IBPD's actual all-raw-missing default instead yields zero/low, and ICPF/OQI defaults can yield100/high. Component-only missing probes and completely absent raw-input probes are different experiments.

Observed precision/category effects remain distinct from latent probes: IAT has 71 nominal .80 high assignments and IVS has four observed boundary discrepancies. Source-local `h_iedf2` includes 147 exact-median ties because of serialized-median precision, whereas ICPF's median80 strict split has no demonstrated serialization error and IAER's median100 binary is constant zero due to its ceiling. None is repaired here.

Each report's substantive limitations remain active: IADT measures perceived capability, not demonstrated skill; ICDP combines reported use/ability/knowledge with a hypothetical scenario; IAFF conditions are not verified legal onboarding acceptance; IUOF mixes windows and sentinel rules; OQI blends onboarding, operational and perception terms; IURD and IETR mix transaction referents; IPCS/IEDF mix exposure, response, perception and recourse; IAER/ICPF pool autonomy/norms/intention/hypothetical protection; and IEH/IBPD use heterogeneous enabler/barrier proxies. Refusal98, unknown98, N/A99, Other and None do not receive uniform or automatically defensible treatment.

Version preservation is essential:

- **IVS-05:** old retained states37/38/39 have all-missing tenure components and two-term stored means despite the same authored scoring operations. The current three-term replay and old exhibit compatibility both stand. The original generating cause and downstream model/class consequences remain unverified. The inspected installed `egen max` route refreshes extrema; a blanket stale-return explanation is not accepted.
- **IUOF:** preserve old raw40/70 categories and mixed raw/normalized middle logic separately from current normalized .50/.80 logic.
- **IURD/IETR:** retain older four-/seven-term, graded/default/overwrite and cutpoint regimes separately from current five-/nine-term formulas. Dropped intermediates remain scored ancestors, not extra outer terms.
- **IPCS/IEDF/IAER/ICPF/IEH/IBPD:** preserve authentic older cuts, five-/ten-/eleven-/three-term regimes, missing guards and sentinel differences. Compatible current/older recipes do not identify a unique producing run.
- **OQI:** `qr_usage` is adjacent but outside its mean. Preparation has an erroneous `q5_5==3` branch instead of `q5_4==3`, an undeclared zero branch and omission of the substantive Both option; the Analysis QR helper is separately defined. This is not an OQI-score correction. KYC and IETR temporary drops and IVS `max_years` remain explicit protected helper records.

The eight later construct packets provide ordered native historical textual recipes; earlier current-only rows and separate IUOF/OQI policy pins are labelled with their actual evidentiary scope. Additional IAT/IVS historical source snapshots are authenticated against Git and retained privately. This consolidation neither reruns nor rewrites the sealed measurement packets.

## 5. Overlap and dependency findings

All 105 unordered pairs are classified by exact questionnaire-item ancestry, not by a correlation threshold. The Stata reconstruction independently derives the sets from item edges and compares every pair and direction.

| Relationship | Pairs / items | Consequence |
|---|---|---|
| Literal scored overlap: one pair | IEH–IBPD: q10_4, q10_6, q10_16 | Some association is mechanically built into the two scores; independent corroboration cannot be claimed |
| Scored-to-routing: seven pairs | IAT→IADT q3_1; IAT→ICDP q3_1/q3_5; IAFF→IUOF and IAFF→OQI q4_12; IURD→IETR q6_14; IEDF→IPCS q7_1; IAER→ICPF q9_20 | One construct contains an answer that governs another's available content; this is not literal duplicate scoring of that answer |
| Common-route only: two pairs | IADT–ICDP q3_1; IUOF–OQI q4_12 | Related applicability populations even without a repeated scored item |
| Common-method only in this item map: 95 pairs | No scored-item/routing intersection identified | Not proof of statistical independence, no confounding, or external validation |

Within-construct route self-dependence is also retained in the manifest: examples are IAT's own access route, IURD's recent-use route, IEDF's problem/recourse route and IEH's training route. The pair classification does not remove these dependencies.

IEH information and cash-out terms are exact complements of IBPD's corresponding terms on current legal nonmissing codes. Materials terms are **not** exact complements: rare exposure3 produces zero in both. Stata validates all 15 legal item/code support rows, not a whole-questionnaire Cartesian. The three shared outer terms account for **50% of a six-term trained IEH score**, **60% of a five-term untrained IEH score**, and **60% of the five-term IBPD score**. These are conditional arithmetic shares, not an estimated correlation, regression contribution, variance decomposition, exact whole-index inverse or duplicated independent evidence.

Routing dependence may affect composition, range and comparability even where a pair has no literal scored overlap. Shared questionnaire/cohort exposure may also create common-method association. Diagnosing fitted local dependence, bad-control/collider risks, sample-specific covariance and sensitivity requires explicit later M6/M7/M8/M9 work; this task does not manufacture such results.

## 6. Actual consumers versus declarations

Preferred final H1 actually uses **h_ivs3, h_icdp3, h_iaff3, h_iuof3, h_oqi3, h_iurd3, h_iedf2**. None of its seven constructs literally shares a scored questionnaire item with another in this map, but routing/common-method dependence still exists; this is not a conditional-independence certificate. IAT/IADT exclusion is not evidence of no substantive relevance, and variables omitted from class formation do not thereby become independent validation outcomes.

Across all 33 explicit GSEM bodies, IVS/ICDP/IAFF/OQI/IURD each occur33 times, IUOF13, IEDF21 and ICPF16; IAT/IADT/IETR/IPCS/IAER/IEH/IBPD occur zero times. ICPF uses fixed-high binary in eight M1/M2 specifications and empirical quantiles in eight H2/H3 specifications; no actual `h_icpf2` fitted input is certified. Declarations such as expanded feature registries do not override the actual bodies.

Operative k-means/Ward source uses twelve standardized measures: IVS, ICDP, IAFF, IUOF, OQI, IURD, IETR, IEDF, IPCS, IAER, ICPF and IEH. It excludes IAT, IADT and IBPD, even where their standardized fields or full-family declarations exist. The five source commands include alternative k-means starts/fallbacks and Ward, not five independent successful analyses.

The 45 explicit core specifications are traced through literal-global expansion and a 675 construct/model role grid. IURD, IUOF, IETR, OQI, IPCS, IEDF, IAER and ICPF each have five outcome specifications; formal remittance adds five item-level-helper specifications. IVS/IAT/IADT/ICDP/IAFF/IEH/IBPD are not outcomes in this restricted core family, although other analysis sections may use them. IURD appears as a predictor in eight IAER/ICPF specifications; ICPF appears in three IAER specifications. The source does **not** establish IAER as an ICPF core predictor. Consequently IAER's q9_20 routing of the ICPF predictor can create composition dependence in an IAER-outcome analysis; this is not literal same-item scoring or a fitted endogeneity test.

Four standardized core counterparts omit IADT relative to the full raw counterpart: IURD, formal remittance, IUOF and IETR. OQI, IPCS and IEDF retain it. IAER/ICPF have their own narrower control families; they are not additional omissions of the same full-block comparison. Whether the differences were intended and their fitted sample/coefficient/AME effects remain unverified.

Source-local aliases may be transient: `z_iat`, `z_ivs` and `z_iadt` are declared/created in analysis but absent from the scoped retained-state headers. IAT/IVS analysis-alias presence is newly checked by **36-state header-only Stata inspection**, not respondent-alias value replay. Other parity records are inherited from the bounded prior packets. A presence count is not a value-parity count; neither is fit validation.

Outcome/centroid/profile/overlay/exhibit locators remain traceable. IBPD is an actual segment-membership OLS outcome and broader profile/contrast outcome, despite LCA/clustering exclusions. IEH overlaps it directly; IURD/profile helpers reuse channel/recent-use answers; IPCS/IEDF share exposure routing. Posterior weighting, modal assignment, segment comparisons and held-out measures from the same survey are not independent external criterion validation. Exact legacy numbers, class labels, weights, uncertainty and rendered exhibits remain for M6.

## 7. Open findings and remaining gates

All 103 inherited blocking-issue entries are retained verbatim, not automatically closed or relabelled as new independent discoveries. The individual construct finding IDs remain authoritative. This crosswalk supplies the measurement/overlap map requested by M5.01/M5.07, but not the full Measurement Gate.

Remaining obligations include full sample/eligibility/migrant-status/geography/design interpretation; cross-version response semantics; principled construct/weights/cut/sentinel policies; stored versus authored/runtime provenance; model-specific samples and inference; actual estimator/seed/start/posterior/class/output replication; missing/empty or misassigned figures/tables; literature/citation and quantitative causal/validation claims; ethics, rights, disclosure and prior-publication authority; public-data minimization/anonymization and the existing sensitive Git/history exposure. No participant field has been approved for public release, and leaving repository visibility unchanged does not resolve the earlier privacy findings.

Before any scientific revision, M7 must distinguish statistically inert operational repairs from measurement/sample/control/LCA changes. Material choices need their own rationale, known-results disclosure, comparison targets and author decision. In-principle support for justified corrections does not approve an unspecified new construct or estimator, and cannot become prospective preregistration.

## 8. Verification and bounded acceptance

Current source ancestry has a real-source RED→GREEN characterization guard and ordered native-source authentication. Stata reconstructs all105 pair sets and distinguishes the nested/conditional weights, legal item polarity, 570 GSEM/cluster grid rows, 675 core-model roles and analysis-alias scope. A separate Stata session independently reimports numerical cells both as numbers and original text, checks full precision, derives core roles from expanded equations and verifies hand-specified expected pair/consumer/mapping contracts. Header-only alias inspection loads no respondent answers. Definitive logs close normally and the three sessions finish with default0×0.

Detected diagnostic-only defects were corrected and complete affected checks repeated: CSV header inference, a metadata name longer than Stata's32-character limit, a temporary-helper catalogue over-inclusion, and an incorrect checker assumption that IURD/ICPF were never core predictors. The independent critic caught direct-item binaries incorrectly labelled ordinal and the nonexistent `form_D_z` expected ID; final checks use the actual `form_ame` and explicitly prove all fourteen comparison IDs exist. The unscored IVS tenure-band recode is retained in the complete26-operation chain. All417 current native operation/line records now match. Failed/superseded driver/core receipts and sources remain restricted and excluded; older successful driver/read-back receipts are superseded by the complete corrected driver04/read-back03. No defect in these utilities is represented as a production/scientific repair.

The independent critic passes with no unresolved blocking crosswalk defect; the final native closeout and separate read-only seal verification retain **768 original byte/size occurrences**, **938 prior-private fingerprints**, all **1,016 earlier artifact pointers**, unchanged fifteen reports/seals, all124 primary task IDs, fourteen milestone headings, unchanged qualitative/production sources, no staged files, metadata-only public additions and zero approved participant fields. These are manifest occurrences and fingerprints, not 768 distinct files or a new full-history/privacy certificate. Formal Paper-WorkFlow Stage2 entry remains blocked by absent `01_proposal/proposal.md`; this authorized retrospective child is preparation evidence only.

The same `main.tex`, editor and preamble are retained and a current preparation checkpoint is appended in place. Fresh built-in compilation returns `compile-failed`: “Could not prepare the LaTeX preview”, with Windows helper “setup refresh had errors” before TeX preparation. Compilation and rendered layout remain unverified; no substitute compiler/PDF/tab or live Overleaf sync is used. Bounded source/arithmetic acceptance is distinct from visual acceptance and every pending parent gate.

## 9. Next immediate task

**M6.01.2 / M6.02.1 — operational preflight of the protected historical replication contract.** This implements the already documented M6.01.1 plan rather than pretending it is a new completed contract. Seven next children are defined in the workplan: isolated executor/environment; actual master/reload/dependency path; version-aware stage input contracts; safe side-effect/output allowlist; frozen historical comparison targets; unresolved-authority/failure disposition; and independent preflight review/commit draft. No estimator execution, package installation, production repair, overwrite, public derivative or M7 scientific change belongs to that next preflight.

## 10. Proposed commit title and description

**Title:** `Consolidate historical measurement, overlap and actual consumer crosswalk`

**Description:**

- Complete the seven bounded M5.01.1/M5.07.1 children across all fifteen accepted measurement audits; preserve report/seal and retained-state provenance.
- Trace89 current outer components, ordered current/historical operations, five-version routes, conditional/nested denominators, sentinel/default policies, polarity, scale and source-local representations.
- Reconcile105 pair relationships: one literal IEH–IBPD partial-inverse overlap, seven scored-to-routing dependencies, two shared-route-only pairs and95 common-method-only pairs; do not claim empirical independence or causal validation.
- Distinguish33 actual GSEM bodies, five operative cluster commands and45 core equations from declarations; verify570 manifest-input and675 core-role rows and the four IADT counterpart differences.
- Add metadata-only crosswalk tables and retain all103 inherited blocking findings; header-check IAT/IVS analysis-alias presence without participant-value export/replay.
- Validate through Stata MCP, separate full-precision/numeric-text/source-role read-back, independent criticism, native original/prior-byte and pointer/ID/gate preservation; preserve excluded diagnostic attempts privately.
- Update local preparation handoff, register, workplan, workflow state and same-file LaTeX checkpoint; retain current compiler diagnostics and any rendering limitation.
- Define the next protected replication operational preflight without promoting any parent gate or changing production data/code/results, qualitative content, Git staging/history/cloud/access, Overleaf or public-release authority.

This is a draft only. No files are staged, committed or pushed; the ignored evidence packet must not be included in a public commit.
