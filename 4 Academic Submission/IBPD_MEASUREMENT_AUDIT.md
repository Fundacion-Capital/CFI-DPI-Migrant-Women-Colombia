# Historical IBPD measurement audit

**Checkpoint:** 7 October 2026; **M4.03.17 / M5.02.15**. Entry: clean main at `c1050ebfaecb8f0f642a4a74358705c555894ad6`, one worktree. This is a bounded historical audit, not a revised index, newly fitted model, scientific approval or release authorization.

## 1. Scope and acceptance boundary

The seven established children connect the author-selected **LEGACY-A original full draft (31 July 2026)**, five preserved SurveyCTO definitions, restricted raw/audit/coded sources, Preparation Section 3.10 C, all three authentic scoring recipes, all 36 preserved dataset identities and actual Analysis consumers. **Every respondent and synthetic computation is executed through Stata MCP only.** Native checks independently verify source/form metadata, hashes, CSV structure and workflow boundaries, not participant statistics.

Acceptance requires definitive Stata driver and separate full-precision specification/arithmetic/aggregate numeric-text read-back, independent source/receipt criticism and fresh preservation checks. **M0 remains in progress. All parent scientific, design, method, quality, replication, ethics and release gates remain pending; zero participant fields are approved for public release.** Exact replay is compatibility evidence, not construct validity, proof of a unique historical producing run, fitted-estimate parity or figure verification.

The ignored packet `audit-local/intake/ibpd-c1050eb` contains restricted aggregates, specifications, synthetic controls and provenance. No participant dataset, crosswalk or identifier is exported. Production code, all protected originals, prior sealed audit packets, legacy outputs and qualitative content remain unchanged. No staging, commit, push, deletion, history rewrite, cloud/access/visibility change, form upload or Overleaf synchronization is included.

## 2. Instrument, version meaning and source contracts

The five definitions are **2512090157, 2512091719, 2512111044, 2512121811 and 2602120658**. Independent native OOXML extraction exactly matches Stata's **155 specification and 449 choice rows**, including full group ancestry, consent/eligibility calculation, labels, field types, own relevance, requiredness, constraints, filters and appearance. This metadata scope covers the complete barriers module and relevant eligibility/groups; it is not a whole-questionnaire semantic audit.

All five scored inputs are required in `/Barreras` when `eligible_flag=1`, without additional own relevance. Eligibility combines affirmative consent, woman code 1, age at least 18 and household international-remittance receipt within the preceding 12 months. It does not require personal account ownership, digital use or training. The training-conditioned IEH follow-up is **not** imported into IBPD. Constraints and choice filters are blank, including the additional-barrier multiselect.

| Input | Actual content | Current scoring |
|---|---|---|
| q10_1 | Main reason for not using digital payments more, or at all | Any nonmissing numerical value from 1 through 15 gives 1; other nonmissing values give 0. |
| q10_2 | Other perceived difficulties, multiple selections | Sum dummies 1–12,14,15, then collapse any strictly positive subtotal to 1. Dummies 16 and 98 are not scored. |
| q10_4 | Perceived information about commissions, FX and what to do after a problem | None (1) / very little (2) give 1; some (3) / much (4) give 0. |
| q10_6 | Time and extra cost at nearby cash-out points | Slow/with cost (3), slow/no cost (4), no known nearby point (5) and unknown (98) give 1; rapid/no cost (1) and rapid/with cost (2) give 0. |
| q10_16 | Frequency of seeing or using anti-fraud/safe-payment materials within 12 months | Never (4) and unknown (98) give 1; always (1) / often (2) / rarely (3) give 0. |

**Code 13 is absent from both actual barrier lists in every definition.** Its absence from the subtotal is not an offered substantive barrier being omitted. The current source has fourteen scored option dummies, plus two existing but unscored dummies 16/98; no missing dummy is manufactured.

Version differences are substantive. In the earliest main-barrier list, choices 1–10 are named reasons and **11 means Other (specify)**. Later main lists make 11 language/terms difficulty, add 12/14/15, and offer 16 None and 98 refusal. The earliest additional list has **no option 1**; its 16 means **Other (specify)**, not None. Later additional lists introduce option 1 and change 16 to None. Two early additional labels have spelling errors but identifiable meanings. Main-question appearance changes from earliest `likert` to blank; additional selections retain `randomized(0,1)`.

The current formula counts an earliest Other main reason as a barrier but excludes an earliest Other additional reason. These are verified version-dependent policies, not corrected recodes. Neither early Other response occurs in the retained cohort, so this particular latent policy is not an observed score difference here.

Stata checks **490×267 raw, 490×266 audit and 423×439 coded** sources, unique nonmissing keys, exact versioned legal scalar/token domains, full applicability, sixteen dummy columns and keyed identity. **75 question checks, 213 scalar-domain rows, 150 routing checks, 240 multiselect checks and 84 source/eligibility/keyed comparisons** pass. Invalid nonmissing answers, duplicate/illegal multiselect tokens, applicable nonresponse, answers outside relevance, illegal dummy values, parent/dummy disagreements and shared-input differences are zero in this contract. The 67 non-applicable raw/audit records remain structurally blank rather than treated as retained-item nonresponse.

The preparation source imports the already-wide dummy fields. This audit verifies imported availability, legal domains and exact parent-token/dummy concordance; it does not identify or recertify the unique original export/generation execution.

There are **two None/refusal-plus-other multiselect combinations** and **13 main-None responses accompanied by a scored additional barrier**. The deployed instrument's empty constraints permit them; they are semantic/coherence review cases, not fabricated domain violations or parent/dummy discordance. No response is deleted or reconciled automatically.

## 3. Exact current arithmetic and observed support

All **12 ordered value operations** match the native source and reproduce all **nine stored fields across 423 records:3,807 exact cells**. There are six helper fields, of which **five binary terms** enter the mean; the additional-barrier *count* is not a sixth mean term.

The formula sums the fourteen selected option dummies with default `rowtotal`, collapses positive totals, averages available binary components, stores `IBPD_raw` as float, multiplies that stored value by 100 into float `IBPD`, and applies **low <40; medium 40–<70; high ≥70 with a missing guard**.

Every retained respondent has all five terms; actual weights are **20% per term**, without available-case denominator differences. Main and additional barriers each contribute at most one term, irrespective of reason, count or severity. Additional scored counts range 0–7, but one and seven additional reasons produce the same binary component. The raw mean is not a validated frequency, severity, institutional-performance or directly observed DPI-failure scale.

| Verified summary | Historical value |
|---|---:|
| N; nonmissing components | 423; five for every respondent |
| IBPD mean | 53.9007108701882 |
| Sample SD | 21.9793008129233 |
| Fixed low / medium / high | 63 / 265 / 95 |
| Empirical tercile 1 /2 /3 | 145 / 183 / 95 |
| Fixed versus empirical assignment differences | 82 /423 |
| Exact score 40 / score 70 | 82 /0 |
| Score60 stored at full precision | 60.0000038146972656 |

The six observed score levels have frequencies **21,42,82,183,90,5** for nominal0/20/40/60/80/100. Fixed groups are substantive source thresholds, not empirical thirds. All 82 score 40 cases move from fixed medium to empirical first tercile; ties make the terciles uneven.

Independent frequency-weighted means and sample SDs match all nine exported summaries. Keeping the intermediate float matters: direct double-mean scaling differs in 183 final last-digit scores; raw-versus-scaled standardization differs in 265 values by at most **2^-24**. Neither changes observed fixed categories. This is operation-order characterization, not evidence of substantive robustness.

The exact median is 60.0000038146972656 with 183 ties; a diagnostic local-macro serialization probe produces zero altered strict-above-median assignments. No binary median-based IBPD alias is present or invented.

## 4. All preserved states, authentic recipes and aliases

The unchanged catalogue retains **36 unique identities and SHA-256 values**. **1,548 schema records** separate17 complete source/score states from 19 incomplete states. Complete states have423 unique keys and agree with all 27 protected input fields, verified in 476 key-coverage/input records. Incomplete states are inventoried, not silently completed or called successfully replayed.

The current formula reproduces **153 field comparisons /64,719 cells** across all 17 complete states exactly. Git supplies three distinct native recipes, whose12/20/20 ordered operations and captured-source hashes are independently authenticated. Replaying all three yields **459 field comparisons /194,157 cells**.

Both current `d119b22` and `6376fcf` match all 17 stored states. Their equivalence on these observations does **not** establish a unique original producer. The earlier `d130a4f` policy differs by 87 cells in each complete state:10 main-refusal components,7 cash-out-unknown components,16 materials-unknown components,25 raw scores,25 scaled scores and 4 categories. Across27 affected respondents,25 scores change; two differ only in component availability. No historical state or result is repaired to remove these differences.

All **24 actually present alias comparisons /10,152 cells** agree with their source-local rules: `zcl_IBPD` and `segz_ibpd` standardize the stored scaled score; `lca_ibpd3` copies valid fixed categories; `h_ibpd3` uses empirical score terciles. The source declares `z_ibpd`, but it is absent from these preserved states. No binary IBPD alias is present.

The driver independently recreates participant-level aliases in temporary frames. The separate read-back verifies their safe aggregate parity receipts and schema coverage; it does **not** claim a second participant-level alias reconstruction or re-fit any model.

## 5. Independent controls and their explicit ceiling

The definitive Stata read-back never calls driver scoring programs or reopens respondent sources. It independently specifies mappings, missing-value policies, storage order, formulas, weighted moments, categories and sufficient-statistic multiplicities.

| Control family | Coverage |
|---|---|
| Legal factor grid |18,000 cases: every legal four-scalar tuple in each version × both achievable additional-barrier score classes;2,640 earliest and 3,840 each later version |
| Legal additional-selection powersets |294,907 nonempty unordered subsets:32,767 earliest and 65,535 each later version; all offered dummy patterns executed, with 217 sufficient-statistic rows independently checked by binomial multiplicities |
| Representative raw rectangle |243 cases: four scalar negative/positive/missing dimensions × zero/positive/all-missing scored dummies |
| Complete component arithmetic |243 five-component 0/1/missing combinations; includes component states not normally generated by default subtotal |
| Single-input controls |1,700 item/version cases covering all four scalars and sixteen actual dummies, including unscored16/98, malformed values, fractions and ordinary/extended missing |
| Entirely missing raw inputs |All 27 Stata missing types, including .a–.z |
| Malformed dummy aggregates |Six signed/cancellation/fractional/partial-missing/unscored-only controls |
| Nominal score boundaries |39 arbitrary40/70/float-ULP/epsilon/missing probes |
| Constant sample |Six identical scores; missing standardized values and tied quantile behavior checked |

**The factorization is deliberate and bounded.** It proves the scalar mappings for every legal tuple and both possible additional-barrier binary outcomes, and separately checks all unordered nonempty legal additional subsets. It does not enumerate their roughly547 million combined cross-product rows, choice-order permutations, the full questionnaire or all possible malformed strings. Sufficient-statistic read-back verifies powerset counts rather than pretending every original synthetic powerset row was exported and re-imported. The arithmetic grid has 10 attainable score 40 cases and no score 70 cases; arbitrary70 probes are not evidence that a valid five-binary complete mean reaches70.

**Default-rowtotal latent defect:** entirely missing actual source/dummy inputs become subtotal0, extra-bin0, IBPD0 and low, with one available generated term. They do not become missing/high. Separately, when all five *component terms* are artificially missing, the current final high guard preserves a missing category; older unguarded category logic would classify a missing score high. Those are different experiments. Neither occurs in the retained full-five-component cohort.

All statistical/specification CSV numeric cells are separately imported as numeric values and original CSV text at full precision, including extended missing codes. The two source-only consumer/path catalogues are checked natively and excluded from the statistical numeric/text claim. Definitive driver and read-back logs close normally, actual MCP receipts contain all completion markers, and both sessions finish with only default 0×0.

A diagnostic-only local-code-list collision and an initial24-versus28 alias-count assumption were detected, preserved and corrected; affected complete programs were rerun. The accepted read-back derives alias coverage from the independent schema contract. Superseded source/log/receipt copies are explicitly excluded from acceptance. No production formula was altered.

## 6. Actual analytical and legacy-text consumers

A fresh source statement catalogue traces preparation/descriptions, graph/crosstab/fixed-category displays, Pearson/Spearman correlations, labelled representations, score standardization, LCA/profile registries, outcome comparisons, standardized-direction reversals and appendix export paths.

- Current core regression `block_D` / `zblock_D` prioritizes IEH and excludes IBPD. A legacy predictor-family description is not evidence of IBPD entering a fitted core equation.
- **None of 33 actual explicit GSEM bodies includes IBPD, its helpers or aliases.** The checked bodies contain no unresolved macros. Expanded `fs_B1_exp` / `fs_B2_expauto` declarations include `lca_ibpd3`, but declarations/feature registries are not demonstrated fitted use.
- `benchmark_z_all` declares `zcl_IBPD`; operative Section6.6 k-means and Ward source bodies **exclude `segz_ibpd`**, although it is generated. Presence of the standardized field is not fitted clustering inclusion.
- IBPD is an **actual dependent outcome** in the segment-membership OLS overlay source and an outcome in broader profiling/centroid/contrast tables. No estimate, standard error, fit statistic, segment mean or resulting image is re-certified by this measurement audit.
- Plots reverse its sign so higher displayed values mean fewer barriers; this presentation direction does not change the underlying index's higher-is-more-barriers meaning.
- **IEH and IBPD literally share q10_4,q10_6,q10_16.** The information and cash-out terms are exact complements on current legal nonmissing codes; the materials terms are not exact inverses at rare exposure3. Their association is partly mechanically built in, not independent corroboration.
- These are same-survey, same-cohort profiles. Even when IBPD is outside preferred class formation, profile separation is not independent external criterion validation or proof of causal effects.

All 90 preserved IBPD legacy excerpt records match a fresh extraction from LEGACY-A. Relevant section3.10, regression-family, segmentation-domain, Figures50/51, external-outcome table and regression-overlay passages are located. The wording about users being expelled/prevented, opaque pricing, cash-in bottlenecks, complete absence of institutional guidance and connectivity mediation goes beyond these self-reports and crosstabs. Cash-in is not directly scored; rarely seeing materials is not institutional absence; high cash-out cost without delay is not a positive barrier term. Modal/posterior-weighted profile and overlay results require later exact M6 reconciliation, not reinterpretation of unmatched numbers here.

The qualitative contribution is protected unchanged. Any eventual mixed-evidence claim or excerpting decision remains explicit author/coauthor review.

## 7. Scientific findings: open, not implemented

| ID | Severity | Finding and required later decision |
|---|---|---|
| IBPD-01 | Major | Heterogeneous perception/exposure proxies; main and additional reasons both collapse any barrier to one. Justify construct name, severity/weight interpretation, omitted dimensions and institutional/DPI claims. |
| IBPD-02 | Major latent/version | Earliest main11 Other and additional16 Other receive asymmetric treatment; earliest additional option 1 absent;13 never offered. No observed early-Other effect, but any revised version harmonization must be explicit. |
| IBPD-03 | Major | Main refusal 98 scores 0; additional refusal 98 unscored; cash-out/materials unknown 98 score 1. Two contradictory multiselect and 13 main-None/additional-barrier cases are instrument-permitted. Assess sentinel/coherence policy without automatic deletion/imputation. |
| IBPD-04 | Major latent | Default subtotal fabricates an available zero term when all relevant source inputs are missing. The actual 423 respondents retain five terms, so distinguish latent missingness/default risk from observed nonresponse. |
| IBPD-05 | Major historical | Current/6376 compatibility is observation-bound, not general recipe equivalence; the earlier missing-sentinel policy changes 25 scores and 4 categories per complete state. Two compatible recipes do not identify unique historical production. |
| IBPD-06 | Major representation / minor numeric | Fixed categories versus quantiles differ for 82 assignments; source-local aliases must not be substituted. Float scaling/standardization last digits have zero observed category consequences and do not validate thresholds. |
| IBPD-07 | Major | Literal IEH overlap and same-cohort profiling are not external/causal validation. Actual GSEM/clustering exclusions must override declarations when describing fitted methods. |
| IBPD-08 | Major pending exhibit/claim | Reconcile legacy prevention/mediation/institutional claims and exact figure/table/profile/overlay provenance at M6/M7; no new causal or fitted-result claim and no qualitative rewrite. |

These findings populate the explicit future revision record. The author's agreement to evidence-backed correction does not erase the historical baseline or bypass the method/design decision gate.

## 8. Acceptance, preserved evidence and rendering limitation

The final native/independent closeout verifies all **768 overlapping original manifest byte/size occurrences**, **864 prior-private fingerprints**, earlier reports, all 941 previous artifact pointers, 124 primary task IDs, 14 milestone headings, unchanged qualitative/production sources, no staged files and zero public-approved participant fields. These are occurrences, not 768 unique files. Native source/form checks, actual Stata receipts, independent critic and final fingerprints govern acceptance, not this narrative alone.

The same `main.tex`, editor and preamble are retained. The preparation record is appended in place. The fresh built-in compiler returns `compile-failed`: “Could not prepare the LaTeX preview”, with Windows helper “setup refresh had errors”, before TeX preparation. Compilation and rendered layout remain unverified; the actual receipt is preserved in the ignored packet. No alternative compiler, PDF or tab is used. This environmental rendering failure does not certify the PDF, and does not silently invalidate already verified historical arithmetic.

## 9. Next immediate task and commit draft

**Next: M5.01.1 / M5.07.1 — consolidated historical measurement and overlap crosswalk**, seven defined children in the workplan. Connect all fifteen audited constructs to exact source items/components/aliases, denominator and sentinel regimes, literal overlaps versus routing/common-method dependencies, actual versus declared model consumers, open scientific findings and the remaining protected M6 replication frontier. No new estimator or scientific recode belongs to this consolidation. Remaining sample/design/exhibit and historical replication obligations still precede explicit M7 revisions.

**Proposed commit title**

`Audit historical IBPD measurement, versioned barriers and source consumers`

**Proposed commit description**

- Complete the seven bounded M4.03.17/M5.02.15 children through Stata MCP, independent full-precision read-back, source/form proof, separate criticism and preservation checks.
- Authenticate five instrument versions, sixteen actual additional-barrier dummies and twelve current value operations; reproduce nine fields/3,807 reference cells and 64,719 complete-state cells exactly.
- Reconcile three authentic recipes/194,157 cells and 24 present alias comparisons/10,152 cells without claiming a unique producing run or fitted-model parity.
- Document Other/None version drift, refusal/unknown/coherence policies, latent default-zero behavior, fixed-versus-tercile differences and literal IEH overlap as open scientific findings.
- Bound 18,000 legal factor cases and 294,907 additional-choice subsets separately; validate arithmetic, malformed/missing, float-boundary, constant and all statistical/specification numeric-text controls.
- Preserve all original/prior bytes, 941 earlier pointers, 124 primary IDs, 14 milestones, zero approved public fields and pending gates; retain failed diagnostic attempts only as excluded restricted evidence.
- Update local IBPD audit, measurement register, handoff, workplan, workflow state and same-file LaTeX preparation checkpoint; define the next consolidated crosswalk.
- Leave production code, datasets, models, figures, qualitative content and legacy outputs unchanged; do not stage, commit, push, alter cloud/history/access, release data or synchronize Overleaf.

This is a draft only. The private evidence packet remains ignored and must not be included in a public commit.
