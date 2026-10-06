# Historical IAFF measurement audit

Date: 6 October 2026  
Task: **M4.03.7 / M5.02.5**  
Disposition: **bounded historical measurement/reproduction audit; scientific findings remain open**

## 1. Scope and acceptance boundary

This checkpoint audits the unchanged historical Formal Financial Access Index, IAFF: five-version instrument meaning and ancestry, multiselect parents/exported dummies, scalar domains, protected source agreement, exact component arithmetic and storage, preserved states and aliases, bounded synthetic controls, legacy claims and operative consumers. It is not construct validation, regulatory certification, estimator recovery, figure-file recertification, full-project completion or release approval.

Entry was clean `main@a9604d311bd5f89ecb8ed8873485ce7b85ea87c1`, the owner's committed ICDP checkpoint. Preparation **P1351–1409** contains **19 logical value-defining operations P1356–1401**; the two multiselect OR replacements span several physical lines. The existing statement parser joins continuations and removes comments for ordered identity checks. Preparation and Analysis retain SHA-256 `E6A9E542DCFF1067DCDA7A37A19B5CFF542B65B54622F198C240A419DC0ED449` and `714377CA31DE2B6D70DB0994E3C7EF6A38374165D7B1FB7C7ABEB3B3F56549C9`. LEGACY-A remains the author-selected full historical foundation, not the authoritative future academic analysis.

All participant-data computation, specifications and aggregate read-back use **Stata MCP** in an isolated diagnostic session. Native helpers inspect source/OOXML, hashes, file identity, pointers, CSV structure and Git boundaries only. Evidence stays in ignored `audit-local/intake/iaff-a9604d3/`; no participant dataset, key, name, telephone or response-level export is created.

| Check | Verified bounded evidence | Boundary |
| --- | --- | --- |
| Instrument | Five used definitions; 115 questionnaire/ancestry rows and 145 choice rows; IAFF wording, options, requiredness, own/group relevance and constraints stable | Not a server/mobile deployment or whole-instrument certification |
| Domains/routing | 60 source/version/item checks; 450 code/missing/invalid aggregate rows; all four items applicable/answered in 423 retained records | Not population representativeness or verified financial eligibility |
| Multiselects | 900 checks covering all ten document and four account dummies, token domains, duplicate tokens, parent agreement and blank-parent conventions | One semantic none/refusal-plus-other combination is not a parser/dummy discrepancy |
| Source linkage | 51 eligibility and protected key-aligned comparisons; zero differences | Keys remain private; timestamps and distinct-person identity are not newly certified |
| Reference recipe | 19 unchanged operations; seven float variables, 423 records, **2,961 exact cells** | Exact arithmetic does not endorse construct/weights/cutoffs |
| Stored states | 36 distinct identities/SHA-256 values; 828 field-schema checks; 17 complete states, 119 comparisons, **50,337 exact cells** | Other 19 states are not complete IAFF replays; files are not independent samples |
| Aliases | 23 available fixed ordinal/binary, score-quantile and standardized comparisons, **9,729 exact cells** | No class assignment, model fit or effect is re-estimated |
| Controls | 20,736 scored-flag/scalar patterns; 1,024 full document masks; 11 nominal boundaries; eight malformed controls; two degenerate samples | Many patterns are deliberately outside permitted completed questionnaires |
| Acceptance | Definitive guarded MCP driver and separate read-back; independent criticism; byte/fingerprint/pointer/task/privacy closeout | Parent scientific and release gates remain pending |

## 2. What the five instruments actually ask

Used versions **2512090157, 2512091719, 2512111044, 2512121811 and 2602120658** have the same IAFF item/choice semantics and routing in the inspected definitions. Full nesting and metadata lengths are checked before extracting rows. All four items are in **/Identidad**, inheriting `eligible_flag=1`, with no additional item-own relevance. Eligibility is computed from consent, female gender response, age at least 18 and preceding-twelve-month household remittance receipt; remittance eligibility is not itself a migrant-status measure. Requiredness and applicability are separate properties.

| Item | Meaning and response support | Historical points |
| --- | --- | --- |
| `q4_1` | Optional multiselect: Colombian citizenship ID (1), foreigner's card (2), PPT (3), valid passport (4), expired passport (5), Venezuelan ID (6), birth certificate (7), other (8), none (9), prefers not to say (98) | Any exact1 among dummies1–4 gives100; otherwise0, including blank/unmapped dummies |
| `q4_5` | Required scalar: reports address proof accepted by financial entities; yes(1), no(2), in process(3), prefers not to say(4) | 100 / 0 / 50 / 0; undeclared/missing inputs stay missing |
| `q4_6` | Required scalar: usual phone line registered in respondent's own name; yes(1), no(2), no own line(3), does not know/recall(4) | 100 / 0 / 0 / 0; undeclared/missing inputs stay missing |
| `q4_12` | Required multiselect with **only four positive options**: bank(1), digital wallet(2), cooperative/solidarity finance(3), fintech/EMI(4) | Any exact1 gives100; otherwise0 |

Neither multiselect declares an exclusivity constraint. The document field's optionality is not an instruction to interpret its missing response as absence. None/refusal combinations with other document choices must be recorded as semantic ambiguity rather than automatically recoded as invalid, resolved into a legal status, or erased. All three data sources contain the same single ambiguous combination, with no duplicate token, undeclared token, illegal nonmissing dummy or parent/dummy disagreement.

There is **no explicit no-account option** in `q4_12`, although it is required throughout the five definitions. Every retained record has at least one positive account selection, so `iaff_account=100` for **all 423**. This documents positive-only instrument support and constant observed score content; it does not establish that every eligible migrant woman in Colombia has an account, nor distinguish reported ownership from actual provider onboarding or active use. Selection, reporting and instrument limitations remain separate potential explanations.

The imported raw workbook already contains the dummies. Preparation labels and scores them; it does not independently regenerate them from multiselect parents. The audit therefore tests parent/dummy agreement directly. All four items have no applicable-item nonresponse or answers outside scoped relevance in the inspected 490 raw/audit and 423 coded records. This bounded result does not certify all survey fields or truthful reporting. Group relevance is supported by [official SurveyCTO documentation](https://docs.surveycto.com/02-designing-forms/01-core-concepts/08.relevance.html).

## 3. Exact historical recipe and precision

The diagnostic reproduces these **19 operations in order**, without repair:

```stata
gen iaff_doc = 0
replace iaff_doc = 100 if q4_1_1 == 1 | q4_1_2 == 1 | q4_1_3 == 1 | q4_1_4 == 1
gen iaff_address = .
replace iaff_address = 100 if q4_5 == 1
replace iaff_address = 50 if q4_5 == 3
replace iaff_address = 0 if q4_5 == 2 | q4_5 == 4
gen iaff_phone = .
replace iaff_phone = 100 if q4_6 == 1
replace iaff_phone = 0 if q4_6 == 3
replace iaff_phone = 0 if inlist(q4_6,2,4)
gen iaff_account = 0
replace iaff_account = 100 if q4_12_1 == 1 | q4_12_2 == 1 | q4_12_3 == 1 | q4_12_4 == 1
egen iaff_score = rowmean(iaff_doc iaff_address iaff_phone iaff_account)
replace iaff_score = iaff_score / 100
egen iaff_score_std = std(iaff_score)
gen iaff_cat = .
replace iaff_cat = 1 if iaff_score < 0.5
replace iaff_cat = 2 if iaff_score >= 0.5 & iaff_score <= 0.8
replace iaff_cat = 3 if iaff_score > 0.8
```

Document and account components are initialized at zero, whereas address and phone begin missing. Their default-zero behavior is not equivalent to distinguishing verified negative answers from missing, refusal, structurally absent or malformed input. Five address refusals and seven unknown/not-recalled phone-registration answers are explicitly scored zero in the reference.

All seven stored fields are float. The row mean is first stored on the 0–100 scale, then divided by100 and stored again. Exact replay preserves both rounding steps. Standardization uses the construction sample and sample SD; a direct double normalized mean is not assumed bit-identical. Available-component means and standardization are described in the [Stata egen manual](https://www.stata.com/manuals/degen.pdf).

With two permanently numeric default-zero components, this recipe always has at least two available components: fully missing inputs produce **score0 / low category**, not a missing score and high category. The all-missing-score-to-high comparison remains possible only in artificial score-only probes or external corruption; it is **unattainable from this unchanged full recipe**. Unmapped address/phone inputs can still reduce the denominator, while default-zero dummies conceal missingness. No such incomplete composition is observed in the current reference.

## 4. Reference and preserved-state results

All **423** scores contain four components. The mean is **0.689420803782506**, sample SD **0.223379011310685**, range **0.25–1**. Component means are document **87.7068557919622**, address **33.2151300236407**, phone **54.8463356973995**, account **100** (SD0). Thus observed IAFF variation comes entirely from document/address/phone content. Constant account100 contributes an additive quarter and compresses those three components into the observed 0.25–1 range; it is not empirical variation in account holding.

Seven observed levels are **0.25, 0.375, 0.5, 0.625, 0.75, 0.875 and1**. Fixed low/medium/high counts are **31 / 290 / 102**; empirical score groups are **169 / 152 / 102**. All **138** assignment differences occur at score0.5: fixed medium, empirical low. High membership coincides in this inspected sample, but fixed cutoffs and empirical grouping are not interchangeable definitions or universally identical aliases. The 99 score1 cases are not the whole high group; another three score0.875 cases belong to it.

All 17 complete preserved states match every derived value and missingness indicator exactly. The available aliases are nine `lca_iaff3`, eight `lca2_iaff_high`, five `h_iaff3` and one `segz_iaff`; all agree with their own fixed/quantile/standardization recipes. `z_iaff` and `lca_iaff2` are absent in the inspected catalogue, not silently reconstructed as stored artifacts. The raw ten inputs, seven derived fields and six candidate aliases account for 23 schema fields per state. A separately computed same-sample `z_iaff` agrees exactly with `iaff_score_std`; this does not certify a later estimator's estimation sample or model coefficients.

## 5. Controls: reachable, latent and impossible

The scored-input grid enumerates 16 masks for four scored document options, 16 account masks and nine states for each scalar: codes1–4,0,98,99, ordinary missing and extended missing. It checks exact independently calculated component values, available-component counts, two-stage float storage and categories in **20,736 patterns**. **3,840** patterns satisfy actual scalar support and the required positive account-selection rule. This is a bounded recipe grid, not an enumeration of all legal respondent histories.

A separate **1,024-mask** test enumerates all ten document options and proves that only the first four influence the historical score. Excluded document choices, no-document and refusal options do not individually earn points; combining them with a qualifying document still triggers the unchanged OR. The test does not supply missing legal rules or impose an undeclared exclusivity constraint.

There are 4,096 four-, 10,240 three- and 6,400 two-component patterns in the larger diagnostic grid. Two-stage storage differs from direct normalization in **7,815** artificial patterns, all outside the permitted fully answered pattern subset. Observed reference rounding and category differences are **zero**. Eleven nominal probes show0.5 is medium in double/float, while nominal0.8 stores just above the double cutoff in float and becomes high. But **exact0.8 is unattainable from all legal component levels under this recipe**, including its possible incomplete denominators; the probe does not establish an actual source-category error.

Eight malformed controls show invalid/blank/non-1 flags default to zero; a valid positive flag can still raise the OR-based component to100. Two constant-sample tests (all-high and all-missing inputs) yield missing standardized scores as expected because the SD is zero. These are guard-design findings for future explicit revision, not observed illegal values, automatic imputation instructions or permission to alter historical categories.

## 6. Legacy claims, ownership exhibits and operative consumers

Static statements are traced to their actual consumers, not inferred from candidate lists or graph similarity edges. No model is executed.

| Consumer | Verified source route | Interpretation boundary |
| --- | --- | --- |
| Correlation/descriptive architecture | IAFF belongs to continuous-index descriptive/correlation inputs; Figures17/18 use fixed categories/continuous means | Source location does not establish original generating runtime, stored image parity or inference |
| Core regressions | `iaff_score` enters nested block_C and relevant raw equations; `z_iaff` enters IURD, formal-remittance, IUOF, IETR and OQI standardized equations; IPCS/IEDF omit IAFF in both forms; IAER/ICPF also consume it | Prior IADT counterpart omissions are not new IAFF mismatches; no effect, p-value or causal claim recertified |
| Interactions/robustness | Actual residence-by-IAFF interaction, other interactions and nonlinear/robustness specifications consume continuous IAFF | No fitted consequence inferred from a construct limitation |
| Fixed LCA | `lca_iaff3=iaff_cat`; `lca2_iaff_high` marks category3; actual M1 gsem uses this binary indicator | Fixed high102 is not proof of a validated access threshold |
| Hybrid preferred LCA | `h_iaff3` is score-based `xtile`, actually used in H1 and its final four-class refit | Sample-specific upper-group agreement does not make the three-level definitions equal; no fit/assignment rerun |
| k-means/Ward benchmark | Hard-coded twelve-input operations use `segz_iaff=std(iaff_score)` | Candidate architecture alone is insufficient; actual commands establish participation |
| Final profiles | IAFF continuous scores and high-access summaries enter final class/segment descriptions and weighted profiles | In-sample manifest-input separation is internal description, not independent external construct validation |

**Figure16 ownership language requires revision.** Analysis A322–326 overwrites `product` in the order bank → wallet → cooperative → fintech. Its mutually exclusive priority-coded counts are not separate ownership prevalences. Fresh reference-only aggregate replay gives bank **203 owners versus71 priority assignments**, wallet **337 versus328**, cooperative **22 versus22**, fintech **2 versus2**. These are source-coding diagnostics, not a certified rerendering or checksum match to the legacy image. LEGACY-A B00529 reads priority shares as ordinary ownership and draws unsupported low-KYC-effectiveness conclusions; that claim needs explicit later correction.

**Figure20 is not a tercile cross-tabulation.** Although A404 creates an IAFF score tercile, the actual A436–455 graph consumes **`iaff_cat`**. LEGACY-A B00544 calls it terciles. Its source variable must be described correctly; exact image-level percentages and provenance remain for the exhibit audit. Figure22 also uses fixed categories. Legacy figure numbering, exported filenames and the IAFF interaction's displayed predicted probabilities are locators, not newly recovered fitted artifacts.

LEGACY-A B00528/548/555/710 also overextend reported possessions and cross-sectional co-patterning into operational, causal or system-effectiveness claims. IAFF's four questions do not observe activity intensity, financial welfare, account functionality, verified legal KYC acceptance or provider-specific eligibility. Keep descriptive access conditions, operational use, onboarding quality and causal interpretation distinct; qualitative content is unchanged.

## 7. Open findings and future decisions

| Finding | Evidence | Required later decision; no correction in this checkpoint |
| --- | --- | --- |
| IAFF-01 | Four questions measure reported possessions/conditions, not verified legal acceptance, onboarding success, active use or inclusion welfare | Define defensible construct wording, review narrative overclaims and any overlapping outcome/predictor content |
| IAFF-02 | Required positive-only account menu; account100 constant423, observed score floor0.25 | Record measurement support/selection limits; consider justified score redesign or sensitivity only through explicit M7 decisions, never invent negative answers |
| IAFF-03 | Optional unconstrained document multiselect; one semantic combination; address refusal and unknown phone registration scored0 | Decide transparent missing/refusal/ambiguity policies with historical/revised comparisons; do not mutate preserved responses |
| IAFF-04 | Default zeros hide invalid/missing dummies; unmapped scalars change denominator; float/constant-SD edge behavior | Add and test justified guards later; no observed source boundary error or missing-to-high case under this recipe |
| IAFF-05 | Fixed/quantile differ138; Figure16 priority versus ownership and Figure20 fixed-versus-tercile narrative; operative manifest/profile dependencies | Reconcile exhibits and interpretations, explicitly propagate approved revisions; internal profile coherence is not external validation |

ICDP-01–05, IADT-01–05, IVS-05 and the existing risk/exhibit register remain open. No parent milestone, design/method/quality gate, anonymous-data permission or public-release gate passes here.

## 8. Verification, retention and handoff

The definitive driver and separate aggregate/specification read-back emit accepted completion markers. Earlier read-only probes used incorrect metadata column names; superseded read-back attempts exposed a Stata string-inlist length limit, a mistaken across-version denominator assumption and a CSV column-order assumption. The diagnostic checks were corrected and run freshly from an empty session. They are retained/disclosed as rejected evidence, not silently counted as passes. No production formula or data value changed.

Independent criticism additionally separated core markers in durable logs from wrapper markers displayed after log close, added the receipt's explicit claims contract, and exposed truncated diagnostic denominator labels. Diagnostic storage was widened from str32 to str60 and each full precision-check key is explicitly required to occur once before its zero assertion. The complete driver and read-back were freshly rerun; no production operation, data value or statistic changed.

Independent source/specification/consumer and final receipt/public-report review, plus native closeout, govern acceptance. Final retention checks preserve **768 overlapping original source-byte comparisons and167 prior private fingerprints**, prior IAT–IVS/IADT/ICDP reports, all124 primary task IDs/fourteen milestones, resolving pointers, unchanged main-document preamble, ignored evidence, zero approved public fields, pending scientific/release gates and empty staging. The Stata session ends with default-only0×0. No participant-level export, estimator, scientific revision, qualitative alteration, source copy/deletion, Git stage/commit/push, cloud write/visibility change or Overleaf synchronization is included.

The existing `main.tex` preparation record is updated in place with unchanged preamble and the same editor. The fresh built-in compile attempt fails during initialization with `Unable to find standard directories for platform`; source/editor are preserved and PDF layout remains unverified. No replacement document/PDF/tab or compiler installation is created. The proposed full commit title and body accompany the handoff and are not executed.

**Next immediate task: M4.03.8 / M5.02.6 — historical IUOF measurement audit**, seven granular children in the workplan. Complete remaining measure/exhibit audits and protected historical replication before explicit M7 retrospective scientific revisions.
