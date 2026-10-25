# WP06–D2: sample, version, missingness and time/geography decision package

Prepared 25 October 2026 (Europe/Berlin), baseline main@0bbd387604ff23be61c45aa649839bb46aa90913.

**Status: documentary decision package prepared for author review. No academic sample or scientific revision is adopted.** No participant records, analytical code contents or saved estimates were opened; no new empirical calculation, Stata execution, fitting, filtering, recoding or manuscript edit occurred. Earlier data, code, exclusions, packets, formal decisions and institutional holds remain unchanged.

## 1. Outcome and four subprocesses

This package implements the next D2 preparation step, not a new institutional interview and not a repeat of every historical replay. It supplies: (1) a reconciled sample-policy foundation; (2) actual-version and missingness/denominator decisions; (3) time/geography alternatives and consequences; and (4) a concise owner review and proposed later protected-verification scope. The [23-row decision matrix](wp06-d2-decision-package/decision_matrix.json), [five-version register](wp06-d2-decision-package/version_scope.json), [six author-review bundles](wp06-d2-decision-package/author_review.json), [unapproved verification scope](wp06-d2-decision-package/proposed_validation_scope.json) and [16-source manifest](wp06-d2-decision-package/evidence_manifest.json) are complementary, not independent approvals.

All empirical numbers below are inherited from named receipts/reports, not recalculated from participant data. Source IDs S01–S16 resolve through the manifest. A source hash identifies the bytes reviewed, not scientific validity, complete source coverage or legal authority.

### Precedence and corrections preserved

Accepted D1_population account S01/S02 controls the implemented recruitment description and the explicit instruction to honor manual exclusions. It does not make every retained respondent positively eligible by proof. Actual form definitions, as characterized in retained metadata S08, govern designed wording/routes; historical source/replay reports govern what historical code did. Narrative intentions cannot silently replace calculations.

S01 retains an earlier account mentioning quantitative paper/audio consent. The later accepted R03 account S04 corrects it: **quantitative consent was recorded only in SurveyCTO; signed paper forms concern qualitative work, not quantitative surveys**. Both originals stay untouched; this package uses the correction, not the superseded wording. R12 S03 preserves oral institutional conclusions, unknown narrowed-package coverage and the pending formal response. No institutional issue is closed here.

## 2. Sample-policy foundation

### Historical exclusions are preserved, not reopened

The historical analytical reference remains423 records. Keep all existing manual test/non-official exclusions and coded restrictions. Do not reinstate excluded observations, reconstruct new exclusion lists from guesses, or silently replace the historical sample.

S07 records the sequential flow490→490→486→478→423, excluding0 empty keys,4 specified consent values,8 gender-code2 values and55 specified remittance values. This is not a response rate, longitudinal attrition, or proof that all67 were tests. It does not locate every manual exclusion relative to every export. Respecting this limitation is not a reason to reverse the owner's exclusions.

Historical membership and proposed academic eligibility are two separate objects. The package recommends a future **discrepancy/support ledger**, not an automatic drop rule. If a retained record cannot be shown to satisfy an intended condition, label that uncertainty and return a scientific choice to the owner. Do not edit historical records or reintroduce excluded records in the name of positive screening.

### Proposed academic description, not a newly verified sample

The accepted population description is adult women with international migration experience, including Colombian return migrants, recruited in urban/periurban study communities, with approximately3months in Colombia after arrival/return. Prior Fundación Capital participation, own-phone ownership and literacy were not requirements. Do not introduce a five-year arrival cutoff, foreign-nationality-only restriction or rural coverage.

The implemented recruitment was leader-enumerator contacts and respondent referrals, with no retained referral network. It is nonprobability snowball/chain referral, not formal RDS with design weights. Instructed respondent diversity is not verified quota attainment or proportional population representation. The observational unit is the woman; absence of household links prevents certifying distinct households or their independence. No weights, cluster corrections or other remedies are adopted by this documentary package.

The five retained form definitions' eligibility calculation uses affirmative consent, gender Woman, age>=18 and receipt of remittances by the respondent OR someone in the household in the previous12months (S08). The age entry is constrained18–100. Nationality, arrival year, post-return residence and principal remittance management are not all positively established by that calculation.

Planning wording on expected future receipts or sending-only differs from the programmed household-receipt condition. The ineligibility note's principal-recipient description also differs. Recommend describing the actual designed household screen while retaining the documentary differences; do not import planning alternatives as grounds for new inclusion or retrospective exclusion.

Administrative cross-enumerator/city names-and-phone matching and the validated-data handoff are author-confirmed (S01/S02), not independently reconstructed. Submission-key coverage and order checks in S05 do not independently prove unique persons. This package performs neither matching nor participant inspection.

## 3. Actual-version interpretation

S05/S12 record five submitted versions:2512090157(2submitted/1retained),2512091719(2/1),2512111044(7/7),2512121811(474/409),2602120658(5/5). These tiny version counts are inherited planning metadata, not evidence of version effects or approved public cells.

Use actual submitted version as the future interpretation key. The newer unused definitions2602160713 and2511101752 must not replace it merely because they look latest. Archive coverage of five spreadsheets does not certify historical compiled XML, device deployment, semantic equivalence or individual compliance.

The version register records two material classes of difference:

- Seventeen later-added other-specify text fields were undefined in the first two versions. Their absence is instrument unavailability, not respondent refusal, nonresponse or zero.
- Thirteen choice lists changed. Geography4 is Other in the first two versions and Soacha later; Meta5 is offered only in2602120658. Other/None changes also affect q7_16, q9_17, q10_1/q10_2/q10_3 and related helpers. q100 has no selecting field in any of the five scoped forms and must not be presented as q9_5 or an affected analytical item.

The complete13-list and17-field crosswalk is in version_scope.json, including spelling-only/pass-through changes and the distinction between scored fields and adjacent helpers. It is not a signed transformation recipe. A legal answer token does not establish correct semantics, routing, selection-count constraints or parent/dummy concordance.

## 4. Missingness and denominator decisions

Recommend the following conceptual states before any approved numerical mapping:

| State | Meaning | What not to do |
|---|---|---|
| Valid observed answer | Defined, applicable substantive response | Do not confuse None with nonresponse. |
| Structural skip | A defined field not asked under its route | Do not force into generic missing or zero without the construct policy. |
| Unavailable in version | Field/option did not exist in that form | Do not infer respondent refusal or absence of the trait. |
| Applicable nonresponse | Asked/applicable but unanswered or not substantively answered | Do not assume random missingness. |
| Substantive N/A or sentinel | Meaning defined by that item's version/options | Do not globally map98/99 or make all N/A adverse/favorable. |
| Unresolved | Evidence cannot distinguish those states | Keep uncertainty rather than invent a response. |

For multiselect questions, offered-but-unselected, absent option, skipped parent and unanswered parent are different. A generated dummy0 does not by itself distinguish them.

Every exhibit needs its own declared denominator: exported records; retained historical cohort; applicable respondents; valid answers; available score components; or actual estimation sample. N423 is not a universal denominator. A fitted model's sample is not certified by prefit complete-case arithmetic; estimator exclusions and perfect prediction may matter.

For available-term means, complete generated scores do not establish complete raw-item coverage. Weights change as available components change; nested IETR means have another denominator level. No minimum-item threshold, imputation, complete-case restriction, weighting or category rule is selected here. D3 owns scientific score decisions. MCAR/MAR is not established from observed patterns or these documents.

### Consequences across all fifteen constructs

The following routing/absence concerns come from S10, not new calculations:

| Construct | D2 issue passed to D3 |
|---|---|
| IAT | Phone/Internet relevance, available terms and later score/category guard effects. |
| IVS | First-arrival year,2026 reference, tenure edges, cohort extrema and historical two/three-term regimes. |
| IADT | Phone-gated terms versus universal safety item; one/two/three-term comparability. |
| ICDP | Routed phone items and mixed reported/hypothetical content. |
| IAFF | OR/default coding, refusal/unknown and constant account term: generated completeness is not universal access. |
| IUOF | Account routing, true N/A versus nonresponse/refusal and60/90day wording. |
| OQI | KYC rowtotal/defaults and domestic routes; adjacent QR helper is not the OQI score. |
| IURD | Channel/helper versus graded index, routes/sentinels and multiple historical recipes. |
| IETR | Nested conditional weights, fee/FX polarity, routes and period. |
| IPCS | Contact-gated reactions and perception/preference/unknown distinctions. |
| IEDF | Versioned complaint routes, harms/recourse, contributor counts and median ties. |
| IAER | Sensitive refusal, norms/intention and ceiling behavior; complete terms do not establish construct validity. |
| ICPF | Restriction/trust direction, earliest Other versus None, routed positive defaults. |
| IEH | Training-route denominator and polarity; adjacent enabler helpers not identical to scored terms. |
| IBPD | Parent/dummy availability, refusal/unknown/default-zero and shared items with IEH. |

This coverage does not resolve fifteen measurement decisions. No score is recomputed, no scientific inference is adopted and no case is removed.

## 5. Time and geography

### Clocks and fieldwork chronology

S05 preserves an approximately6hour36second refreshed-raw versus audit timestamp discrepancy, with some calendar-day differences. Elapsed durations and relative-order checks do not identify its cause. Historical export reports/settings are unavailable. Preserve audit/coded clocks and refreshed raw separately; no timezone correction, repinning or use of the computer's current date.

S01 reports recorded interview dates9December2025–17February2026 from earlier aggregate checks; this is not an independently verified administrative closure date. EarlyDecember interviews are confirmed as real fieldwork. The provenance/date field matters because clocks can shift days; do not present all stored timestamp representations as identical.

### Tenure and reference-year alternatives

The historical IVS recipe in S11 uses2026 minus q2_1(year first living in Colombia) only when year<2026, then inverse min–max scaling on the construction cohort.2026answers can therefore yield missing tenure; a constant range can create an undefined denominator. Those edge cases are not a finding that the observed historical cohort had those failures.

Three potential academic definitions require different evidence: retain a fixed study reference year; use interview-year minus first-arrival year; or measure tenure since most recent arrival/return. None is an automatic improvement. Calendar-year differences are not elapsed months; the first-arrival item may not identify post-return tenure. Do not impose an exact3month rule from year alone, substitute2025 globally, update to the current year or infer missing durations.

**Recommendation:** preserve the historical definition as continuity only and defer a new tenure recipe to D3_IVS, with its substantive meaning, year-only precision and output impacts stated. A later sample change requires an explicit normalization/standardization reference and zero-range policy; it can invalidate the provisional H1 continuity recipes. No new extrema, standard deviations or cutoffs are calculated here.

### Residence interpretation versus analytical grouping

The accepted account does not identify the municipality within Meta. Do not substitute Villavicencio. S06 distinguishes unmodified coded q3, core-regression5to1 pooling, class-profile residence, overlay1/4versus2/3/5 groups and appendix frequencies. These are not interchangeable definitions of city.

Recommend faithful version-aware, unpooled descriptive geography as the starting point, subject to actual interpretation/disclosure review. Sparse Meta cells alone do not justify relabelling it Bogotá. A coarser inferential grouping could later be justified, but must be an explicit contextual/scientific decision with a denominator and sensitivity plan—not a style edit or silent global recode. No particular grouping or geography regression is approved now. Preserve urban/periurban and nonrepresentative scope in claims.

## 6. Owner review and later validation

The owner need not repeat the R01–R12 interview. Review six bundles in author_review.json: population/remittances, version semantics, missingness/denominators, time/tenure, geography and the later validation scope. Each choice remains null; the one historical-exclusion preservation instruction is carried forward, not reopened. Any selected academic policy needs its own dated acceptance and limitation record.

proposed_validation_scope.json describes four future protected checks: membership/eligibility support; version/route states; time/geography lineage; and analysis denominator accounting. It has no carrier path/hash, field grant or output allowlist yet. It is NOT an executable adapter or permission to load data. Institutional/right-use conditions, exact projections, preservation, output confidentiality and separate owner authority are prerequisites. Names/phones, free text, participant exports, estimation, new scores, filtering and transformations are excluded.

The next scientific step after owner D2 review is D3 construct adjudication, supported by WP05 literature/Colombia-context work. No operational probe or new artificial runtime component is needed merely to prepare those choices. Future statistical work uses Stata/Mata through Stata MCP only.

## 7. Coding-style instruction added during this package

The owner expressly required readable, explicit, human-reviewable Stata, extensive purposeful comments and no AI-style overengineering. For a style-only revision, analytical outputs must remain exactly unchanged. This request does not authorize edits during D2. [The project coding standard](STATA_RESEARCH_CODING_STANDARD.md) separates those instructions, official guidance reviewed, actual replication-code reading and remaining source-coverage limitations.

Use relevant tools/skills at full appropriate capability, not every tool indiscriminately. No installation, participant access, fit, wider licence permission or release authority is inferred. No remembered practice or external example overrides a protected scientific recipe.

## 8. Audit and honest completion

The final [review and audit](wp06-d2-decision-package/review_and_audit.json) records metadata checks, negative controls, a separate read-only reviewer, owner dispositions, source hashes, final artifact identity and preservation scans. The separate review is not institutional or methodological approval. No claim of exact final sample validity, anonymous data, completed literature corpus review or whole-project gate closure follows.

This package may be complete as **decision preparation** while D2 scientific adoption, D1_rights and participant/fit/release gates remain held. No old dossier, readiness count, manuscript or workflow state is silently promoted. Existing governance snapshots remain dated history; use this successor and accepted R12 for current documentary interpretation.
