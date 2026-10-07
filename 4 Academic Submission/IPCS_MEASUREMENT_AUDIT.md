# Historical IPCS measurement audit

**M4.03.12 / M5.02.10 — 7 October 2026.** Bounded historical measurement/reproducibility checkpoint. Entry: clean `main` at `bd46bba69e2eb7149c32bd35453b13ebcaa973c0`. The historical recipe is reproduced; IPCS is **not** thereby scientifically validated, approved for revised estimation, or cleared for public participant-data release.

## 1. Acceptance boundary and evidence

This audit follows the seven granular children in the [academic workplan](ACADEMIC_SUBMISSION_WORKPLAN.md). All respondent-level checks, aggregate statistics and synthetic arithmetic use Stata MCP. The separate read-back opens aggregate/specification CSVs, not respondent sources. Native checks cover instrument/Word metadata, exact Git operations, byte preservation, CSV structure, pointers and privacy boundaries.

The restricted original workbook remains 490×267, the Git historical audit state 490×266, and the protected coded reference 423×439. The protected 423 keys and all 25 relevant source fields match the raw/audit sources exactly; 78 keyed source checks pass. No respondent identifier or row is exported. All diagnostic products remain in ignored `audit-local/intake/ipcs-bd46bba`.

The accepted evidence consists of the definitive driver, independent read-back, their normally closed logs, actual MCP responses, actual final empty-session probes, native five-form/source proof, source-retention closeout and independent critic. Superseded debug/probe runs are not acceptance evidence. Diagnostic-only repairs included explicit string import for blank specification columns, exact integer form-version serialization, and the correct measured maximum float difference. Independent review additionally required both score fields to be missing explicitly, all 36 recipe-labelled missing controls to be exported/read back, and exact tied-quantile group counts to be asserted. The definitive driver/read-back were rerun after those repairs. Production code, datasets, categories, samples, estimators, qualitative work and historical exhibits are untouched.

## 2. Five-version instrument and routing contract

Versions **2512090157, 2512091719, 2512111044, 2512121811 and 2602120658** are separately pinned. Stata reads and native workbook metadata agree exactly on **193 specification rows and 482 choice rows**. All 19 audited security/exposure/recourse fields are **select-one**, not multiselect parents or dummy bundles. Scalar–multiselect concordance is consequently not an IPCS requirement; no fictitious dummy test is claimed.

The scored fields and their wording, types, requiredness and ancestry are identical across the five definitions. The security group is enabled by `eligible_flag=1`, with actual consent, woman/sex, age≥18 and household remittance receipt in the last 12 months (`q5`) retained; `q5` is not location or migration status. There is no additional account-ownership or digital-use gate. The 19 fields are required when relevant, with no field constraint, choice filter or appearance restriction.

| Scored response | Current binary policy | What the question actually supports |
|---|---|---|
| `q7_2` → `e1_reaccion_segura` | Codes 1/2/3 → 1; 4/5 → 0 | Reported reaction to suspicious contact, asked only when `q7_1` is 1 or 2. “Other” code 5 is not intrinsically proof of unsafe action. |
| `q7_6` → `e1_autenticacion` | 1/2 → 1; 3/98 → 0 | Reported authentication practice; the two favorable response levels are pooled and unknown is treated as zero. |
| `q7_7` → `e1_habitos_claves` | 1/2 → 1; 3/4 → 0 | A combined question about password changes **and** account/transaction review, not two independently observed behaviors. |
| `q7_8` → `e1_educacion` | 1 → 1; 2/3/98 → 0 | Receipt/clarity of anti-fraud education, not demonstrated assimilation or tested competence. |
| `q7_9` → `e1_seguridad_percibida` | 1/2 → 1; 3/4 → 0 | Perceived safety, not an objective protective practice or verified absence of harm. |
| `q7_10` → `e1_valora_prevencion` | 1–5 → 1; 6/7 → 0 | Preferred useful prevention measure, not adoption. Fast customer service (6) is scored zero. Other (7) is legal **only in 2512090157**. |

The preference-list change is real instrument drift: code 7 is declared in the earliest form and removed in the other four. It is neither a universally legal option nor a phantom code in the earliest form. The current recipe still contains its zero mapping.

The broader recourse context is read to establish actual downstream dependencies, not to certify IEDF or IAER. `q7_12` requires `q7_11=1`; `q7_13/14/15/17/18` require a problem and `q7_12!=6`; `q7_16` is the no-complaint branch. Mixed current/general, last-event and 12-month referents must not be flattened into one “daily behavior” recall window.

Across raw/audit/coded, **285 question/version checks, 700 domain-frequency rows and 450 routing-check rows** pass. These domain/routing checks retain all 490 raw/audit rows and all 423 coded rows; only the keyed replay comparison uses the protected 423-key reference. All observed nonmissing codes are legal for their own form version; there are zero answers outside relevance and zero required-applicable omissions. Security-module relevance is 423 in each source; reaction relevance 238; problem follow-up 108; complaint follow-up 104; no-complaint follow-up 4. These are distinct applicability states, not imputable nonresponse.

## 3. Exact historical arithmetic and reference replay

Preparation Section 3.8.1, lines 1798–1843, contains **24 value operations**. The six binary components are generated in order, then:

```stata
egen IPCS_raw = rowmean(e1_reaccion_segura e1_autenticacion e1_habitos_claves e1_educacion e1_seguridad_percibida e1_valora_prevencion)
gen IPCS = IPCS_raw * 100
gen IPCS_cat = .
replace IPCS_cat = 1 if IPCS < 45
replace IPCS_cat = 2 if IPCS >= 45 & IPCS < 85
replace IPCS_cat = 3 if IPCS >= 85
```

The historical storage path is a float available-case mean on 0–1, **then** float multiplication by 100. It is not an initial 0–100 mean, a double direct calculation, or a nested IETR-style composite. There is no explicit legal-domain, finite-score, wholly-missing or constant-standard-deviation guard.

All **nine stored fields ×423 rows =3,807 cells** reproduce exactly, including missing values. Reaction has 238 nonmissing and 185 structurally missing values; the other five components have 423 nonmissing values. Consequently:

- **238 women** average six components, with each available term weighted 1/6.
- **185 women** average five components, with each available term weighted 1/5.
- There is no observed wholly missing score, applicable-item omission or category precision disagreement.

The reference score has mean **77.9117418835**, SD **22.5920281869**, and range 0–100; its 0–1 intermediate has mean **0.779117419682**, SD **0.225920285500**. Fixed low/medium/high counts are **48/220/155**.

A separate `xtile ..., nq(3)` yields only **two nonempty groups: 152/271**, owing to ties; it is not three equal-sized groups and has no observed third group. Fixed and empirical-quantile assignments differ for **259 women**. Legal five-/six-term binary scores cannot attain exactly 45 or 85; with these denominators the fixed “high” category requires every available component to equal one. This mathematical property is not substantive validation of “high prevention.”

The ordered float calculation differs from direct double-mean-then-scaling for **154 scores**. Raw versus scaled standardization differs in the last stored digits for **209 values**, maximum absolute difference **1.4901161193847656×10⁻⁷**; observed fixed categories do not change. Production aliases must follow their actual historical scale rather than an assumed numerically identical rescaling.

## 4. Thirty-six preserved identities and authentic recipes

All **36 unique state identities** remain preserved. The audit checks **1,440 schema rows** and distinguishes **17 complete, comparable states** from 19 that lack the required complete input contract. No missing state or absent alias is manufactured.

For the 17 complete states, all 26 key/input checks per state pass (**442 rows**). The nine shared stored IPCS fields yield **153 comparisons /64,719 cells**. There are **142 current-recipe differences**, all in `IPCS_cat` in state 37; all other compared component and score cells match.

Four authentic **textual** recipes are recovered and independently compared with Git and their diagnostic programs:

| Recipe | Component sentinel/Other policy | Fixed thresholds | Reconciliation |
|---|---|---|---|
| `d119b22` | Current completed zero mappings | 45/85 | Exact in the 16 non-37 complete states. |
| `b03b54d` | Same current component policy | 40/70 | Exact in state 37. |
| `3b10048` | Semantically equivalent to `b03b54d`; syntax differs | 40/70 | Also exact in state 37. |
| `95179b3` | Action 5, authentication 98, education 98 and early Other 7 remain missing | 40/70 | Older authentic policy; not asserted to be the producer of a preserved complete state. |

Each recipe has 24 value operations. Four textual versions do **not** mean four substantively distinct measurement regimes. Cross-recipe checks cover **612 field comparisons /258,876 cells**. Matching an authentic recipe establishes source compatibility, not a proven original run, original environment, downstream reload, estimator sample or reported coefficient/class result.

All **24 available alias fields /10,152 cells** match their declared historical construction: standardized `segz_ipcs` and `zcl_IPCS`, fixed `lca_ipcs3`, and quantile `h_ipcs3`, where preserved. `z_ipcs` is an actual generated regression consumer but not a preserved field in this catalogue. Fixed, empirical-quantile and continuous-standardized representations are not interchangeable.

## 5. Independent bounded controls and read-back

The definitive driver and separate CSV/specification/synthetic read-back pass:

| Control family | Exhaustively checked within the stated boundary |
|---|---|
| Single-item legal and malformed probes | 82 cases, including system/extended missing, negative/zero/fractional and undeclared finite codes. |
| Six-item raw-code/missing rectangle | 30,000 combinations; this is not wholly legal questionnaire data. |
| Five-version legal exposure-routed support | 103,168 legal combinations: 23,296 in the earliest form and 19,968 in each other form, with version-specific Other legality and exact five-/six-term routing. |
| Binary/missing arithmetic masks | 729 combinations; distinct from legitimate questionnaire profiles. |
| Score-only threshold/ULP probes | 12 cases around 45/85, extended missing, out-of-range values and float rounding; not falsely described as attainable questionnaire scores. |
| Wholly missing across four recipes | 36 probes; missing score is classified high by every unguarded recipe. |
| Four authentic recipes ×four legal sentinel/Other contrasts | 16 cases; the oldest omitted term raises the available-case score to 100 versus current 83.3333282471, with historical threshold effects kept separate. |
| Constant endpoint samples | Four best and four worst synthetic cases; standardization is undefined in each constant sample. |

Full-precision numeric and string read-back retains form identifiers, missing masks, extended missing values and score-only input text. Weighted aggregate-support reconstruction independently verifies the observed means, SDs, category counts, denominator structure and precision claims. Both task sessions finish with only **default 0×0**. No synthetic or respondent dataset persists in the repository; two Stata-managed temporary saves concern synthetic controls only.

The missing-to-high and undeclared-domain/constant-SD exposures are real code properties, **not observed empirical errors** in these 423 scores. Guarding them later requires explicit revision, tests and historical/revised comparison; it must not silently change this audited baseline.

## 6. Actual consumers, manuscript and exhibit boundaries

The source/LEGACY-A close-read covers descriptive distributions, correlation inventories, regression specifications, alternative profiling inventories, actual GSEM calls, clustering, same-sample profiles and appendix copies.

- Actual nested raw IPCS regressions and the standardized full model include IADT. The standardized model and plot **retain** it; the IETR standardized-model omission must not be copied into this finding.
- `lca_ipcs3` and `h_ipcs3` are generated/registered candidates. All **33 explicit actual GSEM bodies**, including preferred H1, exclude IPCS; no unresolved macro in those bodies supplies it. Declared candidate inventories are not fitted inclusion.
- Actual k-means and Ward benchmarks include continuous `segz_ipcs`. Class/profile reporting uses IPCS as a same-sample outcome. These uses are distinct from the preferred H1 manifest.
- Although IPCS is outside preferred H1, reaction applicability depends on `q7_1`, a source of IEDF/`h_iedf2` used by H1. This shared-route dependence remains a measurement/interpretation issue; exclusion of IPCS from H1 does not establish independent criterion validation.
- The source block associated with **Figure 27**, Analysis lines 653–676, defines `exposed_fraud` from **`q7_5` account blocking/limitations**, not **`q7_1` suspicious contacts**. Against the latter construct, the reference has 129 blocking-positive versus 238 contact-positive observations and **159 indicator disagreements**. This is a verified transitive exhibit-definition mismatch, not a recalculated or corrected published figure.
- Appendix Table F3→Table E6 copy locators identify IPCS regression outputs, not fresh validation of file contents, fitted coefficients, inference or image layout.

LEGACY-A B00580/B00716/B00720–725 describes defensive agency, daily safe habits, education assimilation, tactical competence, protective capacity, causal/policy mechanisms and null-result implications more strongly than these mixed self-reports justify. Regression results, coefficient ranking/significance, city narratives and absence-of-significance claims are **not recertified here**. Historical OLS association is not an identified causal, temporal or mediation effect. No qualitative text or historical figure/table is altered.

## 7. Explicit scientific/revision decisions left open

| Finding | Required later decision; no production correction made |
|---|---|
| **IPCS-01 — Construct and referents** | Justify a composite mixing reported reactions/authentication/habits, education, perceived safety and preferences; distinguish intention/perception/receipt from demonstrated skill, assimilation and protective efficacy. Retain item-specific recall windows. |
| **IPCS-02 — Exposure-conditioned content** | Address five-/six-term composition, implicit weights and the IEDF/H1 shared route. Specify the estimand and any sensitivity strategy without coding nonexposure as unsafe action, imputing structural skips or treating them as nonresponse. |
| **IPCS-03 — Normative ordinal/sentinel scoring** | Justify pooled favorable frequencies, unclear/no/unknown education zeros, unknown authentication zeros, Other-action zero and fast-service preference zero. Unknown and Other are not automatically demonstrated unsafe conduct. Keep the oldest omission policy as history. |
| **IPCS-04 — History and representations** | Reconcile state 37 and downstream use before revision; distinguish 40/70 from 45/85 and fixed from tied quantile/continuous representations. No original producer, unchanged fit or robustness is inferred from source compatibility. |
| **IPCS-05 — Defensive/precision contract** | Register legal-domain/finite/missing/constant-SD guards and explicit storage/order. The reproduced missing-high exposure and last-digit differences do not establish an observed category defect or authorize replacing the baseline. |
| **IPCS-06 — Actual models and internal profiles** | Retain IADT in the actual IPCS standardized specification; separate candidate manifests, actual GSEM exclusion, actual continuous clustering and same-sample profiles. Audit actual samples/estimators/inference and avoid causal/null-equivalence interpretations. |
| **IPCS-07 — Instrument/exhibit/narrative reconciliation** | Preserve early-only Other 7, correct Figure 27's claimed exposure construct or source only through explicit later review, and reconcile legacy “daily skills/defensive agency” wording and appendix artifacts with what was measured. No exhibit output or qualitative result is certified or changed now. |

## 8. Retention, orchestration and release holds

Fresh closeout requires all **768 original-source manifest records**, **448 prior-private fingerprints**, all prior public measurement reports, **124 primary task IDs**, **14 milestones**, every artifact pointer, pending-gate status and the original TeX preamble to remain intact. Manifest-record counts include overlapping source records and must not be described as unique files.

The only public edits are this audit, README, workplan, version/measurement register, workflow state and the existing preparation checkpoint in `main.tex`. The post-edit native compiler receipt is recorded separately: **Windows helper setup-refresh failure leaves compilation and PDF layout unverified**. No alternate compiler/PDF, new editor tab, or Overleaf synchronization is used. Compiler failure is not a statistical-replay failure; source integrity is not proof of successful layout.

M0 remains in progress. Empirical audit, design lock, method, quality, replication and release gates remain pending; all public participant fields remain **NOT_APPROVED**. The original time-zone/export-history limitation remains preserved. No source deletion, participant derivative, revised estimator, cloud copy/access change, Git stage/commit/push or submission occurs.

## 9. Next immediate task and commit draft

**Next: M4.03.13 / M5.02.11 — historical IEDF measurement audit**, beginning Preparation Section 3.8.2. Its seven granular instrument/domain/recipe/state/control/consumer/closeout children are specified in the workplan; they are not executed or passed by this IPCS checkpoint.

**Proposed commit title**

```text
audit: reconcile historical IPCS measurement and consumer lineage
```

**Proposed commit description**

```text
Complete the bounded M4.03.12/M5.02.10 historical IPCS checkpoint.

- Pin five instrument versions and verify security/exposure/recourse typing,
  relevance, legal domains, early-only Other 7 and protected keyed inputs.
- Reproduce all 24 value operations and nine fields across 423 reference rows;
  distinguish structural five-/six-term means and fixed/quantile representations.
- Reconcile 36 preserved identities and four authentic textual recipes;
  retain state-37 category differences and verify available historical aliases.
- Validate legal-routed, raw/arithmetic, sentinel, malformed, missing, boundary,
  float-order and constant-sample controls through Stata MCP and independent
  full-precision aggregate/specification CSV read-back.
- Record actual IPCS regressions, GSEM exclusion, continuous clustering,
  shared-route profile limits, Figure-27 source mismatch and IPCS-01--07.
- Preserve restricted originals, prior evidence, task IDs, pending gates and
  TeX preamble; record native compiler limitation and define the IEDF audit.

No production code, data, categories, samples, estimates, qualitative results
or historical exhibits changed. No participant export, cloud/Overleaf action,
stage, commit, push or release was performed.
```
