# WP06 — first protected P1–P4 verification contract

Prepared 26 October 2026 (Europe/Berlin), from clean checkpoint `bd407ffeb500188a5b8d20310c4f4195a189b356`.

**Status: source-bound documentary preparation complete only when its final audit passes; analytical execution remains held.** The owner has accepted the D4/D6 policies and P1–P4 design. That acceptance is not a participant-access grant, an adopted runtime budget, a completed scientific validation or institutional clearance.

## 1. What this package delivers

- [Machine-readable contract](verification_contract.json): one carrier, literal projection, permitted operations, exact output schemas, proposed resource envelope and stop/discrepancy rules.
- [33-check catalogue](verification_checks.csv): every check is `PLANNED_NOT_EXECUTED`; no participant counts or empirical results are supplied.
- [Eight-row binding ledger](binding_status.csv): seven pre-execution conditions and one explicit outside-scope entry. It separates evidence already retained from decisions and checks still needed.
- [Source pins](source_pins.json): documentary/static source identity and the scope of the dictionary intake, not fresh dataset or runtime validation.
- [Audit summary](audit_summary.json): generated only after the scoped tests, source review and preservation checks; technical success does not activate execution.

The accepted [D4/D6 account](../wp06-d4-d6-acceptance/D4_D6_ACCEPTED_ACCOUNT_2026-10-26.md), accepted D3 accounts and D2 policies govern interpretation. Older proposals remain intact. Their unadopted permissions and numerical limits are not silently promoted by this successor.

## 2. Exact source and projection

The sole proposed participant carrier is **TARGET33**, the preserved regular CODED state, historically described as **423 observations and 439 variables**. Its inherited SHA-256 is `95E0929D4AB5F4E0808C07F9EB636C24A0EEB88F676CACE328BB064BADCAD756`; the source commit/blob and restricted archive locator are pinned in the contract. This is not the file whose name says NoPII. The current absolute path, current bytes, schema and access controls have not been verified here.

The unchanged [literal field list](../wp06-academic-specification/field_allowlist.csv) contains **163 fields**: 100 respondent-answer fields, one calculated eligibility helper, six technical/lineage fields and 56 numeric multiselect dummies. Its SHA-256 is `662df36abf8abf4db038afb77eba0c64caa050654ff316015c69f50acb6168c1`. It is an exact proposed projection, not a wildcard and not permission to read those fields now.

`KEY` is for internal submission integrity and order checks only; no value may enter output. Contact fields, narrative answers, coordinates, enumerator identifiers and administrative lists are excluded. The seven permitted dummy families are `q10_2`, `q4_12`, `q4_1`, `q5_13`, `q5_2`, `q9_17` and `q9_21`, with only the 56 explicitly listed child fields. A string-valued numeric-choice parent is not permission to inspect arbitrary free text.

All historical manual test/non-official exclusions and coded restrictions are honored through the exact preserved carrier. No raw-490 replay, fresh SurveyCTO export, name/telephone matching, reinstatement, new exclusion or alternative-source fallback is part of this wave. Submission-key uniqueness is not proof of unique persons or households. The 423-case historical reference is not a response rate or a universal item/model denominator.

## 3. Static-source intake: what is and is not established

The retained extracts provide 756 question/version keys and 2,943 choice/version/code keys. Comparisons initially stopped on 865 differences because some questionnaire CSVs omitted the `choice_filter` column. A diagnosis found **no conflicting values in shared recorded columns**; the only extra column was `choice_filter`. The failed intake, original failed-attempt script and unmerged metadata are retained. Richer independently pinned extracts supply that column only after agreement on all shared values. Absent metadata has not been interpreted as an empty constraint.

The base extracts did not include the five `q3` question definitions. A retained geography extract supplies those definitions and 21 version-specific choices. Thus all 101 projected question/calculation fields have leaf definitions across the five submitted versions. Selected-question choice lists are available. This is a source-availability result, not observed compliance, cross-version measurement equivalence, a fresh schema check or proof of compiled/device deployment.

**Remaining source gap:** the scoped `q3` extract does not retain its enclosing-group relevance. A blank own-relevance cell cannot establish unconditional applicability. The exact parent chain must be validated from a preserved definition before dispatching a full route adapter. It is not guessed from adjacent questions. An unresolved empirical route state must remain unresolved, not zero, a favourable response or a forced structural skip.

## 4. The four bounded operations

| Operation | Permitted later checks | What it must not do |
| --- | --- | --- |
| **P1 — membership and screening support** | Exact authorized source/projection; unchanged cohort/order; internal missing/duplicate-key counts; recorded consent, woman response, age, household-remittance and calculated-helper support | No person deduplication, new eligibility screen, data correction or migration/residence certification that year-only fields cannot support |
| **P2 — versions, routes and response states** | Actual five-version dictionaries; full known own/parent routes; six-state accounting; actual-version options/filters; literal parent/dummy concordance; standalone provider/account/complaint context | No default latest dictionary, blanket sentinel map, zero-fill, relabelling, imposed extra response/resolution gate or assumed missingness mechanism |
| **P3 — preserved time/geography** | Coded clock availability/order and lineage; separate candidate calendar-year coverage; first-arrival limitations; version-correct `q3` meanings and grouping differences | No raw-export clock comparison, inferred offset cause, timestamp normalization, selected new year source, latest-return tenure, Meta pooling or Villavicencio inference |
| **P4 — denominators and input coverage** | Applicable/valid denominators; fixed eight candidate input sets; IADT common applicability; two primary-outcome input sets and conditional main/extension coverage | No new score or outcome binary, normalization, imputation, model matrix, fitted `e(sample)`, estimator, margins, prediction, posterior or class assignment |

The eight coverage sets are IAT3, IVS2 raw inputs, IADT2, IADT3, ICDP2, IAFF2, IUOF3 and OQI2. They use the fixed accepted source items, not replacement aliases. IVS requires separate date-source evidence: raw `q2_1`/`q2_2` completeness is not proof that a normalized IVS candidate can be computed. Likewise, extension raw-input availability is not a completed migration-history regressor. No calendar source or construction bounds are adopted here.

For IADT, transfer ability and fraud-avoidance confidence remain the two-item candidate; app installation is an additional smartphone-only item in the three-item comparison. IUOF uses frequency, merchant payments and saving/retention beyond a week, not cash access/travel time. OQI uses registration ease and offered support, not activation timing. Item-specific N/A, uncertainty, nonuse and refusal rules remain those of the accepted accounts; being in the source dictionary does not make a response scorable.

## 5. Response states, discrepancies and failure

P2 keeps six distinct states: **observed valid; structural skip; unavailable in version; applicable nonresponse; substantive N/A/sentinel; unresolved**. Within the sentinel state, retain item-specific refusal, uncertainty, nonuse and N/A subtypes. Applicable nonresponse means missing/blank after excluding recorded item-specific sentinel states, not a refusal or N/A response. An applicable item with a missing response is not a designed skip. An option that a version never offered is not a negative answer. A response outside its known route is a discrepancy, not silently a valid skip. Contradictions or insufficient context stay unresolved; state counts must reconcile to the relevant carrier/item scope without double counting.

Two different outcomes must remain distinct:

- **Technical/authority failure:** unbound permission, unknown version, missing required dictionary, wrong source/hash/schema, unallowlisted input/output, source/output collision, preservation drift, or unresolved runtime ownership/deadline/stop/cleanup. Stop, preserve the attempt and do not retry or choose another source.
- **Substantive discrepancy within a correctly bound source:** a known-domain violation, missing answer, contradictory route/account response, limited screening support or date/geography inconsistency. Record it with its denominator and interpretation limit; do not repair or exclude a woman.

The earlier proposal's combined “unexpected version/domain” stop wording is not copied indiscriminately: an unknown version prevents interpretation, whereas a known-version invalid response is an intended audit finding. Unsupported and indeterminate findings are legitimate results. Completion does not require every retained respondent to pass every substantive check.

## 6. Restricted output and operational proposal

The contract names seven outputs: four aggregate CSVs, `verification_readout.md`, `execution_receipt.json` and `stata_full.log`, with exact schemas/contents. There are no empirical output placeholders in this preparation folder. A fresh restricted execution destination has **not** been created or reserved.

Uncomputed counts serialize as the literal `NA` in CSV and `null` in JSON, never as zero. An observed/discrepancy zero requires a completed count; an expected zero may be explicitly fixed in advance. Completed checks use the interpretive status supported/unsupported/indeterminate. Checks not performed or technically stopped use `not_executed` or `technical_stop`, with `NA` for uncomputed counts. The execution receipt separately records the completed/not_executed/technical_stop disposition. This does not treat missing evidence as an observed result.

No identifiers, raw numeric-choice strings, individual dates/locations, participant rows/lists, respondent-level auxiliary flags, modified datasets, scores, predictions or classes may be exported or displayed. Transient in-memory masks may support aggregate counts only and must not survive as row-level outputs. All small/version-specific counts remain restricted. No public synopsis follows automatically. Runtime ownership evidence is separate operational metadata, not permission to export participant administrative identifiers.

The **unadopted** proposal is one projected load within P1, four participant selection calls total, at most 45 seconds per selection and 180 seconds of work, plus 30 seconds for cleanup: **210 seconds absolute total**, zero fits and zero retries. Source/access and empty-runtime preflight are separate from this future participant wave. No hidden participant setup load or extra selection can sit outside the envelope. If direct explicit implementation cannot meet it, return a revised proposal before execution; do not silently extend a deadline or split into additional calls.

Current Stata build, session ownership, capacity and independently usable cancellation are unverified. Historical artificial Stage-A/B/bootstrap/deployment tests are evidence about those artificial contracts, not production integration or a proven live stop path. The adapter must be pinned and the runtime/control conditions verified under separate authority. Late or uncertain completion quarantines the packet; it does not unlock a retry. No fitted-model b/V stripe is required for this no-fit task, and no runtime/maxvar/library mutation is silently authorized to rescue it.

The future Stata adapter must follow the [research coding standard](../STATA_RESEARCH_CODING_STANDARD.md): explicit commented scientific commands, essential direct assertions, no unnecessary helper programs, fallback sources or retry machinery. This package creates no Stata do-file or dispatch adapter. Process-control evidence stays outside scientific code.

## 7. Remaining bindings and scope-specific gates

The binding ledger identifies the practical remaining conditions: exact protected-use grant; applicable D1 use conditions; current input/path/access/hash/schema; missing `q3` parent-chain and literal route-adapter binding; destination/retention; owned runtime/independent control; and adopted budgets plus exact adapter/execution grant. Their status is held or partially bound—not a request to repeat the completed D1–D4 interviews.

No dated external ethics decision, institutional/coauthor assent, narrowed-package review or release approval is invented. Conversely, public-release G7, fitted-model stripe checks, final variance selection and LCA enumeration must not be manufactured as prerequisites for this limited internal descriptive wave. Relevant access/use conditions still matter: “no fit” alone does not authorize access.

The four regression targets, six-test primary inference family, variance/dependence problem, LCA scientific hold, historical WP04-CORR01/I3-REPLAY-D01 qualifications, qualitative boundaries and author/CFI publication checkpoints remain unchanged. Neither WP06 nor its parent Measurement/Method/Replication/Release Gates closes here.

## 8. Audit and handoff

The private packet is `audit-local/intake/wp06-p1-p4-contract-bd407ff/`. It retains the entry fingerprints, expected missing-contract RED check, failed and corrected static intake, metadata sources/scripts, artificial-boundary tests, fresh read-only review, rulings, final audit and seal. Separate-process verification is retained in its sibling verification folder. Previous public and private files remain byte-for-byte intact; this successor adds no navigation rewrites.

**Next immediate process:** separately authorize current restricted-input resolution, the missing static parent-chain check and owned empty-runtime/control preflight. That phase must not load or count participants. Only after the exact access/output/retention/budget/adapter conditions are bound should a separate bounded P1–P4 execution grant be considered. The audit summary and final readback determine documentary completion; they are not an activation token.
