# Academic redevelopment and submission workplan

Project: Digital public infrastructure and migrant women's financial inclusion in Colombia  
Plan date: 5 October 2026, Europe/Berlin  
Status: implementation in progress; bounded source reconciliation and selected-version preservation verified with explicit limits; historical estimator replication, revised estimation and scientific milestone gates remain pending
Submission sequence agreed by the author: Information Technology for Development → Development Policy Review → International Migration → Migration and Development

## 1. Purpose and operating decisions

The objective is a defensible academic article, a genuinely reproducible quantitative supplement, and an auditable research record built from the original full manuscript and the entire relevant project archive. The objective is not another cosmetic shortening of the CFI report, nor a promise of acceptance at a particular journal.

The full legacy manuscript is the starting inventory of the research, not unquestionable evidence that its claims, measurements, or statistical specifications are correct. Every quantitative and literature-related claim must be tested against its underlying sources. Previously submitted, approved, presented, or typeset CFI outputs remain historical records. Their institutional approval does not constrain the new academic analysis.

The following decisions govern the work:

1. Start from the full-length legacy drafts. Do not treat the condensed CFI manuscripts or Canva version as the scientific master.
2. Preserve the original manuscripts, historical code, CFI outputs, and existing public appendix package. Corrections and new analyses receive separate academic versions and explicit provenance.
3. Fully audit the literature, institutional/contextual sources, quantitative data lineage, variable construction, descriptive analysis, correlations, regressions, and latent class analysis (LCA), including downstream profiling.
4. Quantitative methods, models, measurements, and results MAY change when the audit establishes a justified reason. The earlier instruction to leave them unchanged does not govern this academic redevelopment.
5. The qualitative component remains unchanged. Do not recode interviews, alter themes, replace quotations, change expert assessments, relabel qualitative groups, or unilaterally rewrite the coauthor's substantive material.
6. Read the existing qualitative findings only to establish the integration boundary and identify consistency issues. Any shortening, reordering, or rephrasing of that material for a journal article requires author/coauthor review rather than a silent edit.
7. Execute all Stata analytical work through the Stata MCP connection. Do not run Stata through a shell or substitute R/Python estimations. Ordinary file inspection, document processing, and provenance checks are not statistical re-estimation.
8. Research comprehensively; write for one audience at a time. Maintain one scientific core and an ITD-first article, with documented adaptations for the remaining three journals.
9. No journal submissions, editor outreach, additional suite installation, public pushes, cloud-folder restructuring, or Zotero/NotebookLM library mutations are authorized by this planning deliverable.
10. A scientific gate may pass with clearly bounded descriptive inference. Passing does not convert observational associations into causal effects.

This plan uses the empirical-research workflow's evidence, method, drafting, and handoff gates. It adapts them to an already completed study: the analysis history is retrospective, not newly preregistered. It does not initialize a speculative collection of empty stage folders or claim that a template is evidence of completed research.

## 2. Verified starting snapshot and remaining access limitations

These are the original planning access/orientation observations, not a completed project audit. The current checkpoint is [00_meta/workflow_state.json](00_meta/workflow_state.json), with the latest evidence and open items in [README.md](README.md). Do not mistake an older snapshot below for current status.

| Resource | Verified on 5 October 2026 | What has NOT yet been verified |
|---|---|---|
| GitHub and local repository | Local branch main; clean working tree before creating this plan; 723 tracked files; local and remote HEAD agree at ca9440acab0d2917e945da7c4d7e615d079e1d0c | Every file's scientific content, full history, actual end-to-end execution, public-release eligibility of all historical artifacts |
| Dropbox | Project namespace and working-paper folder can be listed through the connector; full draft files are locally readable in the synced project archive | File-by-file completeness, inaccessible/cloud-only items elsewhere in the archive, suitability for redistribution; write permission is not inferred from read access |
| OneDrive | Existing CFI-DPI project directory is readable; corresponding full-draft copies match Dropbox copies by SHA-256 | Whether other folders contain additional unique versions, authoritative originals, or missing historical inputs |
| Zotero | Live MCP connection now works; My Library is libraryID 1; the named collection is collectionId 26, under Fundacion Capital | Complete descendant-collection coverage, authoritative bibliographic classification, accessibility and close reading of every attachment |
| Zotero catalogue | A bounded collection listing returned 39 items with limited=false; 38 have a listed PDF attachment | A listed attachment is not proof that its full text is readable; no completed 39-item literature audit is claimed |
| Zotero full-text test | A paper-text passage was retrieved from an explicitly selected attachment in this collection | One successful test is not full-library coverage |
| NotebookLM | Connector health reports authenticated=false; the supplied notebook URL redirects to Google sign-in in a temporary browser session | Notebook contents, source inventory, notebook-specific permission, and any grounded response from this project |
| Stata | MCP execution is the required analysis route | Live analytical session state, installed version/edition, usable packages, and execution reproducibility; no analysis was run during planning |

The Zotero item types currently stored are 27 journalArticle, 5 report, 3 newspaperArticle, 2 webpage, 1 dataset, and 1 bookSection. These are catalogue labels, not a peer-review or source-quality assessment. Some labels may need correction; metadata edits would be proposed separately before modifying the live library.

The original NotebookLM limitation was session-specific. The author's later instruction supersedes the reauthentication route: use the supplied public notebook link only, without account authentication. The correct notebook subsequently became readable in the existing browser session with 38 listed sources. Source inventory access is not full-text verification; reconcile it with Zotero at M3.

### Archive roots

- Git: [CFI-DPI-Migrant-Women-Colombia](C:/Users/jzava/Documents/GitHub/CFI-DPI-Migrant-Women-Colombia).
- Dropbox: [DPI Inclusion Migrant Women Colombia](<C:/Users/jzava/Dropbox (Personal)/Research & Consulting/1 Research/DPI Inclusion Migrant Women Colombia>).
- OneDrive: [CFI-DPI](<C:/Users/jzava/OneDrive - fundacioncapital.org/1 Projects/CFI-DPI>).
- NotebookLM: [author-supplied project notebook](https://notebook.google.com/notebook/93a7f63a-ef2b-4c7b-ab8d-d0cfae228189).

Scope archive searches to these project roots. Do not expand into unrelated PC backups, other research projects, or the currently active NotebookLM notebook merely because a tool makes them visible.

### Full-manuscript candidates

Both files below occur in Dropbox and OneDrive. Each corresponding pair is byte-identical across the two synced locations, but the two drafts differ from each other.

| Candidate in the working-paper folder | Size | SHA-256 | Interpretation |
|---|---:|---|---|
| Cardozo & Zavala - 2026 - Digital bridges for financial inclusion, DPI in migrant women empowerment in Colombia.docx | 7,090,947 bytes | 99919BBE239C5CE319B986B6B18C534DB02D6E3CB5469FF55EDFC1294CAFC76F | Unlabelled full legacy draft; likely baseline candidate, not yet selected |
| Cardozo & Zavala - 2026 - Digital bridges for financial inclusion, DPI in migrant women empowerment in Colombia - Copia.docx | 6,784,660 bytes | BC80253C91CB3EE18619CA264352961B02248D4F3C2FD64DC6F4A785A2AC06AA | Different full-length companion draft; must be compared before selecting or merging |

The copies have approximately 82,580 and 83,050 whitespace-delimited words in document XML, respectively, including material outside the main body. Those are orientation counts, not journal-compliant word counts. Word's cached page properties are inconsistent, so the exact rendered page total has not been certified. Do not select the baseline using a “300 pages” description, filename, cloud-upload date, or cached page count alone.

The author subsequently selected LEGACY-A, the original full draft internally labelled 31 July 2026, by its hash above. Its main body, references and all 38 table-cell arrays match the companion; three appendix images unique to A are retained. This resolves manuscript selection, not the wider computational Baseline Gate. The companion remains preserved; independent disposition/visual review and code/data/output reconciliation remain open in M1.

## 3. Publication architecture and the four-journal strategy

### One research record, one primary submission, three adaptations

Maintain three layers:

1. **Scientific evidence record:** complete source inventory, audit findings, literature matrix, data/code lineage, historical-versus-revised results, and limitations. This is not constrained by an article's word limit.
2. **Article plus technical supplement:** a coherent argument with enough methods and results to evaluate the contribution, backed by full diagnostics and reproducible supporting analyses.
3. **Journal adaptation:** only the framing, abstract, permitted length, exhibit allocation, reference style, anonymity, declarations, and submission packaging change by outlet. Results and limitations cannot change simply to make a different audience more receptive.

The original manuscript's breadth is valuable for recovering work and understanding the project. It does not mean every paragraph or every bibliographic entry belongs in the article. All relevant sources must be assessed; main-text citations are selected for their evidentiary and argumentative role, with additional relevant material retained in the supplement/research record.

Do not force an artificial common format across all four journals. In particular, the smallest word budget in the fallback sequence must not determine how much of the project is audited. Conversely, the earlier internal 15,000-word/50-page target cannot be assumed to satisfy a journal's rules.

### Current official guidance and planning consequences

| Journal in the agreed sequence | Verified guidance | Planning consequence |
|---|---|---|
| Information Technology for Development | Research articles may use qualitative, quantitative, or computational evidence and must make a substantial independent ICT4D contribution. Its current AIS policies do not state a research-article word ceiling; the 6,000-word ceiling on that page is for practitioner papers. Initial submissions have flexible formatting. | ITD is the primary audience. Build an ICT4D contribution rather than a long descriptive country report. Confirm the research-article length, current submission route, supplements, fees, and license before freezing a submission-facing word budget. Do not treat an absent ceiling as permission for an unlimited article. |
| Development Policy Review | Up to 8,000 words, including appendices, footnotes, and graphics but excluding abstract and references. A structured abstract of up to 300 words is required. The journal asks for a focused question, pertinent literature, concise methods, and integrated policy-relevant findings rather than a full research report. | Preserve an accessible policy translation of the same results. Technical material must be appropriately allocated; do not assume an online appendix is excluded from the count without journal confirmation. |
| International Migration | Author guidance states a maximum of 8,000 words including abstract, policy implications, and references, with 2–3 tables/graphs if needed. It prioritizes relevance to migration policy. | The adaptation needs a migration-policy argument and a smaller main-text exhibit/reference budget, not just an ITD manuscript with a new cover letter. |
| Migration and Development | Original articles fall within a 5,000–7,000-word range including references, with a 150–200-word abstract, 4–6 keywords, APA style, and double-anonymized review. Supporting materials are permitted. | Create a focused migration-development adaptation only if needed, drawing on the same scientific core and approved qualitative material. Its shorter format does not imply a reduced audit. |

Official sources: [ITD policies](https://aisel.aisnet.org/itd/policies.html), [DPR author guidelines](https://onlinelibrary.wiley.com/page/journal/14677679/homepage/forauthors.html), [International Migration author guidelines](https://onlinelibrary.wiley.com/page/journal/14682435/homepage/forauthors.html), [Migration and Development submission guidelines](https://journals.sagepub.com/author-instructions/mad).

Every rule will be refreshed before actual submission. Where a publisher transition, ambiguous supplement rule, fee, open-access license, embargo, institutional agreement, or deadline cannot be verified, record “unverified,” not an estimate presented as fact. Do not infer a current review-time forecast from a journal's historical statistics.

The sequence remains the author's agreed default. If the audit reveals an eligibility barrier or a materially different contribution, bring the evidence back for an explicit decision; do not silently substitute another outlet. Submit to only one journal at a time, and never submit automatically when an internal gate passes.

## 4. What “exhaustive” means and how it will be measured

Exhaustiveness must be demonstrable rather than a phrase in a progress update.

### Coverage obligations

- Inventory every tracked repository file at the pinned commit, and every item discovered within the project archive and explicitly scoped literature resources.
- Fully read all unique project-authored scientific text in the agreed scope, especially both full manuscript candidates, protocols, instrument versions, codebooks, analytical notes, and quantitative technical documentation.
- Trace every active project analysis command and its called dependencies. Record third-party package provenance and versions; inspect modifications and scientifically consequential implementation paths rather than claim that every unchanged vendor help file was academically reviewed.
- Register every table, figure, graph, equation, index, model family, sample definition, and substantive numerical claim in the full legacy manuscript.
- Index all stored analytical outputs, map their producing code and input version where recoverable, and identify duplicates/orphans. Visually inspect unique substantive figures and check all retained table contents and labels.
- Reproduce every quantitative result retained in the new article or supplement. Also account for all legacy result families, including null findings and results later superseded.
- Assess every item in the scoped Zotero collection and descendants, distinguishing metadata availability, attachment availability, searchable body text, full-text review, and claim verification.
- Verify every citation retained in the submission-facing text against the appropriate primary source, including institutional facts and methodological claims.

Hash-identical duplicates can be covered by one content review plus explicit duplicate verification. An unavailable PDF cannot be counted as reviewed. An archived spreadsheet cannot be called unnecessary merely because a newer graph exists.

### Coverage and findings records

Use a compact set of records, introduced as needed rather than a large empty scaffold:

| Record | Essential fields |
|---|---|
| Source/file manifest | Source ID, path/URL, archive/library scope, version/commit/hash, file role, readable status, duplicate group, reviewer coverage, restriction/publication status |
| Claim and exhibit ledger | Claim ID, legacy section/page, exact claim or number, source/page or result ID, data sample, generating code, exhibit, permitted inference, new-text destination, disposition |
| Audit and decision register | Finding ID, evidence locator, severity, issue, consequence, proposed remedy, owner decision when needed, old/new result impact, resolution evidence |
| Milestone status/handoff | Current milestone, accepted inputs, completed outputs, gate status, unresolved gaps, worktree/Stata state, next smallest task, protected boundaries |

Statuses distinguish NOT STARTED, IN PROGRESS, VERIFIED, GAP/BLOCKED, NOT APPLICABLE with rationale, and SUPERSEDED with a successor. File existence alone does not count as verification.

Severity:

- **Critical:** could invalidate a main conclusion, make the result irreproducible, expose protected data, misstate consent/ethics, or misrepresent the design.
- **Major:** materially affects measurement, inference, literature positioning, class interpretation, or an important quantitative/qualitative integration claim.
- **Minor:** presentation or localized clarity issue without a scientific consequence.

Critical and major findings affecting the retained argument cannot remain unresolved at submission readiness. A limitation may be accepted by narrowing a claim and explaining it, not by deleting the finding from the register.

## 5. Milestone map and dependencies

| Milestone | Main deliverable | Depends on | Gate |
|---|---|---|---|
| M0 | Access, authority, privacy, and publication-history intake | This plan | Scope and access boundary known |
| M1 | Canonical legacy baseline, full source map, project chronology | M0 | Baseline Gate |
| M2 | Full-manuscript claim, exhibit, and analysis inventory | M1 | No unaccounted substantive legacy component |
| M3 | Complete scoped literature/context matrix and contribution assessment | M0–M2; Zotero access | Literature Evidence Gate |
| M4 | Data lineage, sampling, consent, sample-flow and missingness audit | M1–M2 | Data Gate |
| M5 | Variable/index and LCA-indicator measurement audit | M2, M4 | Measurement Gate |
| M6 | Isolated exact historical replication and result reconciliation | M4–M5; MCP/environment preflight | Replication Gate |
| M7 | Retrospective history plus justified academic revision analysis plan | M3–M6 | Method/Revision Gate |
| M8 | Revised descriptive/correlation and regression evidence | M7 | Statistical Evidence Gate |
| M9 | Revised LCA diagnostics, profiles, and downstream analysis | M7; relevant M8 outputs | LCA Evidence Gate |
| M10 | Claim-safe quantitative/qualitative and institutional integration map | M3, M8–M9; approved qualitative material | Integration Gate |
| M11 | ITD-first article, supplement, bibliography, and exhibit package | M10 | Draft Quality Gate |
| M12 | Independent reproduction, numerical audit, document/layout validation | M11 | Reproducibility and Integrity Gate |
| M13 | Adversarial review, author decisions, journal-specific submission packet | M12 | Submission-Readiness Gate, not submission authorization |

M3 and M4 can progress in parallel after the baseline is established. Measurement and source-positioning issues can be identified during historical replication, but revised estimates must not be run before the revision plan is recorded. M8 and M9 may have independent diagnostic tasks; they must not compete for a shared Stata session or artifact path.

### Granular execution and completion discipline

The fourteen milestones remain the governing sequence. Each of the 124 work items below now has a stable identifier, including separate M8D descriptive/correlation and M8R regression items. Identifiers are not completion claims. A work item inherits its milestone's inputs, deliverable and exit gate; tasks without a current evidence-backed disposition remain pending.

Before executing any work item, split it into source-specific child checks until each check answers one evidence question. Record: parent/task ID, pinned inputs, permitted action, method/tool, actual output, acceptance test, result, residual limitation and next approval/dependency. Never mark a parent complete while a required child is unresolved. Preserve historical receipts and distinguish `PLAN_COMPLETE`, `CHECK_PASS`, `CHECK_FAIL`, `REVIEW_REQUIRED` and `OWNER_APPROVAL_PENDING`; none is interchangeable with public-release approval. Future variable/model-specific children are instantiated after M2/M4 inventory rather than guessed in advance.

M0 is **not complete**. Read-only M1/M2 intake overlaps with M0, but no Baseline, Data, Measurement, Replication or revision gate has passed. The previous source-refresh/preservation workflow entered a clean tree at `main@fb031129013e2b042a95eed066fbd5c0dad086a3`. The owner confirmed restricted Dropbox membership/inherited access and approved 35 preservation copies. The current historical-input contract entered clean `main@c4be81ad1d5f1ff7be8aa0feffc42fd43e28c63e`, corrects the order diagnostic and recovers all used spreadsheets with explicit limits. Historical samples, measurements, regressions, LCA and substantive results remain unchanged.

| Child of M0.06 | Single check or action | Current disposition / acceptance test |
|---|---|---|
| M0.06a | Refresh Git identity and editing boundary | CHECK_PASS: main and entry commit recorded; no pre-existing edits overwritten. Repeat at every workflow. |
| M0.06b | Hash actual local restricted-source candidates | CHECK_PASS at current entry: 698 archive occurrences (383 Dropbox/315 OneDrive) retain pinned bytes; four subsequently owner-added forms pinned separately. Earlier 664-entry and 35-copy receipts remain dated historical evidence. Readability/hash retention is not confidentiality or remote payload verification. |
| M0.06c | Match selected sensitive Git versions to protected copies | CHECK_PASS for all 33 selected targets; two older input versions are also preserved. All 35 source/destination SHA-256 and sizes agree. Not account-wide/all-historical-blob completeness. |
| M0.06d | Check scoped listings and access evidence | OWNER_CONFIRMED restricted members/inherited parent access; ten scoped owned-link lists and the new archive list have no owned links, pagination complete. Independent membership/inheritance enumeration unavailable. No sharing controls changed. |
| M0.06e | Pin the metadata-query source catalogue | CHECK_PASS: 36 sources, comprising 33 sensitive target versions and three actual Dropbox input files. Not all historical blobs or remote copies. |
| M0.06f | Inventory fields using Stata MCP | Prior CHECK_PASS snapshot: 8,964 field occurrences/679 names across 36 selected sources. Fresh source reconciliation checks all shared fields for five datasets. Refresh disclosure metadata for the recovered raw cohort before an anonymous-field approval; snapshot counts are not current certification. |
| M0.06g | Assign a proposed release treatment to every inventoried field | SCOPED_PROPOSAL_REFRESH: 38 existing rows receive version/dependency notes in the prior 679-name snapshot. Prior risk treatments remain proposals; zero public fields approved and full joint disclosure review pending. |
| M0.06h | Locate existing Stata code references for each field | SCOPED_REVIEW_DELIVERED: geography, all 13 early changed lists and 17 later text fields mapped; 455 current locators and separate review supplement prior 5,654 lexical candidates. Full remaining construct/macro/runtime dependencies are not certified. |
| M0.06i | Reconcile input versions before certifying replication baseline | BOUNDED_CHECKS_DELIVERED: cohort/non-time cells and exact 423-key restrictions pass; original-order discrepancy corrected and all five used spreadsheets recovered. Clock reports/settings are owner-confirmed unavailable; preserve original audit/coded states. Version-dependent meaning and semantic dependencies remain M4/M5 review issues; no parent scientific gate passes. |
| M0.06j | Specify disclosure and scientific-parity tests | PLAN_COMPLETE; bounded raw/audit/coded cell and exclusion replay now pass. Joint disclosure, full construct/index parity and clean estimator replication remain pending. |
| M0.06k | Verify originals unchanged and private receipts excluded from Git | CHECK_PASS only after fresh source/code hashes, ignore/staging checks and MCP frame cleanup; record evidence in the local validation receipt. |
| M0.06l | Review this bounded proposal and its unresolved risks | Proposal review only; no anonymity certificate, scientific gate or publication approval. Keep known gaps explicit in the handoff. |
| M0.06m | Obtain exact preservation and cleanup authority | OWNER_APPROVED creation and copying of the exact 35 versions; implemented. No original deletion, Git cleanup/history rewrite, commit, push or Overleaf synchronization included. Separate anonymous-field and cleanup authority remains pending. |
| M0.06n | Preserve approved restricted originals and verify restoration | SELECTED_COPY_CHECK_PASS: 35 SHA-256/size matches, 35 remote paths/sizes, 35 Stata dimension/readability passes. Remote payload checksum unavailable. Protected temporary read-back copies remain after policy-blocked cleanup; owner housekeeping required. All originals retained. |
| M0.06o | Implement the approved anonymous derivative and isolated export routing | PENDING separate workflow: Stata MCP only; private crosswalk; exact variable allowlist; no unrestricted whole-record export; no scientific changes. |
| M0.06p | Validate disclosure, scientific parity and historical-exposure remediation | PENDING: adversarial linkage review, exact retained-cell/sample/index parity, protected historical replication and separately approved Git/history treatment. Stop if privacy and exact reproduction conflict. |
| M0.06q | Obtain explicit public-release/Overleaf synchronization approval | OWNER_APPROVAL_PENDING after all required checks. A safe local artifact is not automatically authorized for publication. |

The earlier source catalogue, field proposal and test protocol remain preserved in ignored `audit-local/intake/release-spec-9137985/`. Current source reconciliation, 35-version preservation and housekeeping limits are recorded in ignored `audit-local/intake/source-refresh-fb03112/`. The next dependency is the historical clock/order/form input contract, followed by a refreshed semantic/disclosure proposal; the approved copies do not require approval again. Safe authority, ethics, rights and literature work may continue while release is held; revised estimation may not bypass M7.

#### Current source-refresh/preservation child evidence

These children refine M0.06i/n; they do not replace or renumber the 124 primary work items. A successful bounded check does not pass the parent historical-baseline gate.

| Child | Exact check and evidence | Disposition / remaining dependency |
|---|---|---|
| M0.06i.1 | Downloads/archive hashes and source pins | CHECK_PASS: raw and form pairs match; historical code/manuscript pins unchanged. |
| M0.06i.2 | Five dataset key/schema checks | CHECK_PASS: unique nonmissing keys; all 490 audit and 423 coded keys contained in refreshed raw. |
| M0.06i.3 | Every shared field, key-aligned | CHECK_PASS for non-time cells; three timestamp fields differ. No automatic conversion or recoding. |
| M0.06i.4 | Exact historical sequential exclusions in temporary frames | CHECK_PASS: 490 → 486 → 478 → 423; final keys equal stored coded keys. Not a sample/construct gate. |
| M0.06i.5 | Clock offsets and calendar-day dependency | LIMITATION_RECORDED: +6 hours plus 36 seconds survives nearest-ms rounding; 153/146/153 day changes remain, rounded durations agree. Owner confirms export reports/settings no longer exist. Freeze stored audit/coded clocks; no inferred conversion or exact raw-to-audit reconstruction claim. |
| M0.06i.6 | Raw row order | CHECK_PASS_CORRECTED: all 490 raw/audit original positions agree; all 423 coded keys preserve relative sequence. Withdraw earlier 489 claim based on sorted link indices. Corrected helper passes reversed-key/full/subset/shuffled-subset tests; estimator/RNG replay pending M6. |
| M0.06i.7 | Six definition sheets and exact duplicate-preserving choices | CHECK_PASS: survey/help unchanged; 771 old choices retained plus one new departamento option. Existing ws duplicate retained; semantic relevance requires M5 review. |
| M0.06i.8 | Submitted form versions against archived definition labels | ARCHIVE_CHECK_PASS: exact labels for all five used spreadsheets, four owner-supplied legacy definitions hashed and read through Stata MCP. All six sheets of seven definitions compared. Early geography coding, 17 later-added text fields and changed choices require M4/M5 review; no recodes or independent deployment certificate. |
| M0.06n.1 | Owner-approved normalized 35-path allowlist and destination preflight | CHECK_PASS: explicit authority; no target overwritten and every source retained. |
| M0.06n.2 | Copy byte identity and sizes | CHECK_PASS: 35/35, 20,505,205 bytes. Restricted originals, no anonymous dataset created. |
| M0.06n.3 | Original/archive and code/manuscript byte retention | CHECK_PASS: 664 entry occurrences and seven code/manuscript pins unchanged; five new local counterparts reconciled separately. |
| M0.06n.4 | Complete remote archive listing and sharing evidence | CHECK_PASS for 35 paths/sizes, no owned archive link; remote SHA-256/member enumeration unavailable, not claimed. |
| M0.06n.5 | Restorable preserved files through Stata MCP | CHECK_PASS: 35/35 expected dimensions. Short hash-identical private copies bypassed Windows Excel path length; source frames empty. |
| M0.06n.6 | Dispose of temporary verification duplicates | OWNER_ACTION_REQUIRED: removal blocked before execution. Exact protected temporary folder is recorded privately; all 35 duplicates remain, originals untouched. |

### Current historical-input contract: one-question child checks

Current workflow entry is clean `main@c4be81ad1d5f1ff7be8aa0feffc42fd43e28c63e`; the earlier `fb03112` preservation checkpoint above is retained as historical evidence. [Historical-input contract](HISTORICAL_INPUT_CONTRACT.md) defines the bounded acceptance criteria. All 124 primary items and M0–M13 gates remain unchanged. The following dispositions supplement—not replace—the M0.06 parent checks.

| Child | One evidence question and actual method | Acceptance / current disposition |
|---|---|---|
| M0.06i.5.1 | Is the full raw/audit clock delta real after nearest-ms comparison? Stata MCP, unique-key alignment for all three fields. | CHECK_PASS: approximately +6h00m36s in 490 matched records; no adjustment performed. |
| M0.06i.5.2 | Do precision effects alone explain changed dates? Synthetic midnight fixture and rounded actual-data comparison. | CHECK_PASS: genuine day changes remain 153/146/153; rounding is not a clock reconstruction. |
| M0.06i.5.3 | Is elapsed interview duration changed by the constant clock shift? Compare rounded start/end differences. | CHECK_PASS: rounded durations agree; sub-ms numerical jitter retained in private receipt. |
| M0.06i.5.4 | Does another locally available keyed export recover audit clocks? Stata MCP compares fourteen downloads. | CHECK_PASS for search/comparison; no exact temporal match. File dates do not establish collection/export authority. |
| M0.06i.5.5 | Are original export reports/settings recoverable? Direct owner answer. | OWNER_CONFIRMED_UNAVAILABLE. Recovery request closed; limitation recorded. Keep preserved audit/coded clocks and disclose raw-to-audit gap at M1/M6. |
| M0.06i.6.1 | Was the old position diagnostic measuring original order? Inspect prior selection and reproduce sorted-link-index failure synthetically. | CHECK_PASS_CORRECTION: earlier 489 claim withdrawn; reference link index was not original position. |
| M0.06i.6.2 | Do full/subset sequences agree when captured before linking? Corrected helper in disposable copies. | CHECK_PASS: NEW_AUDIT 490/0/0, OLD_AUDIT 120/0/0, AUDIT_CODED 423/422/0 (matched/absolute/relative). |
| M0.06i.6.3 | Does the corrected logic reject a genuinely reordered subset? Executable synthetic assertions in existing helper. | CHECK_PASS: identical reversed files and ordered subset accepted; shuffled subset detected. |
| M0.06i.6.4 | Are critical seed/sort/input routing declarations located without running estimators? Source blocks plus isolated dependency path probe. | CHECK_PASS bounded routing/probe; current Stata 19 IC is not original runtime replication. M6 execution remains pending. |
| M0.06i.8.1 | Are the four added files present, hash-stable and remotely listed? Native hashes and connector identity/path/size metadata. | CHECK_PASS: all four exact files; remote payload SHA-256/device deployment not claimed. |
| M0.06i.8.2 | Does every recorded submitted version have a matching form_id/version? Stata MCP settings and source counts. | CHECK_PASS: five used labels matched; two additional archived labels are nonused. |
| M0.06i.8.3 | Were all supplied workbook sheets inspected? Stata MCP schemas and full-row duplicate-preserving comparisons. | CHECK_PASS: seven definitions × six sheets, 42 imports; original survey/choice/specification content unchanged. |
| M0.06i.8.4 | Are question changes separated from row insertion/closing-group duplicates? Stable-name fields plus full-sheet multisets. | CHECK_PASS: 17 later-added text definitions identified; named comparisons and all choice-list multiplicities recorded. |
| M0.06i.8.5 | Are any version differences consequential for retained analytical coding? Version/code scope check, no recoding. | SCOPED_REGISTER_DELIVERED: geography, structural text availability and all changed early lists have dependency dispositions. Domain checks pass; semantic/score/sample consequences remain M4/M5 review, not approved recoding. |
| M0.06k.1 | Do every pinned source and the authored files retain bytes? Existing metadata/hash helpers only. | CHECK_PASS: 765 overlapping checks—698 archive occurrences, seven source pins, 20 downloads, four new forms, 36 selected sources. Not 765 distinct files. |
| M0.06k.2 | Are private artifacts ignored, source frames empty and Git untouched outside scoped edits? Git/ignore/state-pointer checks and final Stata receipts. | Prior workflow passed with 61 pointers; repeat in the current private measurement validation receipt. No scientific or restricted-source mutation is authorized. Native TeX platform initialization failure leaves compilation/layout unverified. |

### Version-aware measurement/dependency checkpoint — 5 October 2026

The [version-aware register](VERSION_MEASUREMENT_REGISTER.md) delivers the six previously queued scoped components without altering any historical analytical value or specification. All primary task IDs and parent gates remain unchanged. The following children separate checked diagnostics, source interpretation, proposals and unfinished scientific decisions.

| Child ID | One acceptance question | Current disposition / evidence |
|---|---|---|
| M0.06h.1 | Are geography states and reloads distinguished? | SCOPED_REVIEW_DELIVERED: stored q3, regression recode, prof_city and s15_city2 are separate nodes; 56 core-control consumers located. Actual replay branches and results remain M6 checks. |
| M0.06h.2 | Does every changed early choice list have a selecting-question/dependency disposition? | CHECK_PASS scoped mapping: 13 lists, 12 linked questions, one unreferenced q100; 46 exact differing dictionary rows with multiplicity preserved. Meaning decisions are not approved. |
| M0.06h.3 | Are metadata-only fields distinguished from value/model use and pass-through? | SCOPED_REVIEW_DELIVERED: 17 text fields have 34 explicit unguarded preparation metadata uses, no explicit scoring/model use, and separate storage/signature/export risks. |
| M0.06h.4 | Are parent multiselects, option dummies and generated wildcards traced? | SCOPED_REVIEW_DELIVERED: IAT/IPCS/ICPF/IBPD and enabler/provider dependencies mapped. Full dummy/relevance/score parity remains pending. |
| M0.06h.5 | Has a separate reviewer checked the source interpretation? | REVIEW_DELIVERED and coordinator cross-check: actual authored paths/hashes and scoped source spans; no claim of full runtime dataflow or fresh analysis. |
| M4.01.1 | Are all five used definitions linked to the raw/coded version domains? | CHECK_PASS: 121 scoped specification rows, 509 choice rows; raw/coded dimensions and unique keys rechecked through Stata MCP. |
| M4.03.1 | Are the 17 unavailable fields kept separate from nonresponse? | CHECK_PASS bounded: 170 field/version/source rows; every first-two-version field is undefined and empty. No new zero or refusal classification. |
| M4.03.2 | Does later text occur only within its own declared trigger? | CHECK_PASS own-trigger only; complete enclosing-group relevance, option exclusivity and all missingness reasons remain REVIEW_REQUIRED. |
| M5.01.1 | Are all observed answers within their recorded-version domains? | CHECK_PASS: 120 linked-question/version/source domains; eight synthetic token fixtures, independent receipt assertions and final completion marker pass. Not semantic equivalence. |
| M5.01.2 | Are changes in option meaning treated separately from spelling? | REVIEW_REGISTER_DELIVERED: Other→Soacha/None, added choices and corrected labels separated. No scientific harmonization or effect-size conclusion. |
| M0.06g.1 | Is the anonymous-field proposal updated without assuming approval? | SCOPED_PROPOSAL_REFRESH: 38 existing rows annotated in prior 679-name snapshot, current raw/coded type metadata added where available. Zero public fields approved; no derivative or full new disclosure inventory. |
| M6.01.1 | Is a protected replay contract specified before estimators run? | PLAN_COMPLETE: immutable historical states, clocks, input branches, isolated outputs, Stata MCP/runtime/RNG and stage-specific sample/result checks declared. Adapter execution and Replication Gate pending. |
| M0.06k.3 | Do diagnostics and local artifacts pass a fresh final boundary check? | BOUNDED_CHECK_PASS: guarded driver and independent receipts pass; only empty default frame remains. All 765 source-byte checks, 78 pointers, 124 primary IDs, 14 milestones, ignored private files, six-file public diff and empty staging pass. No parent scientific/release gate passes. TeX layout remains unverified after platform-initialization failure. |
| M4.03.3 / M5.02.1 | Does historical IAT scoring agree with its items, relevance and stored values? | BOUNDED_AUDIT_DELIVERED 6 October: 29 identical ordered statements; 3,384 exact component/score/category cells; 90 domain/full-relevance, 27 source and 20 fixture checks pass. IAT-01/02/03 remain open: 71 nominal 0.80 category cases, item-label meanings and partial/N/A rules. Eight acceptance children in [IAT_MEASUREMENT_AUDIT.md](IAT_MEASUREMENT_AUDIT.md). No scientific code edit or estimator. |
| M4.03.4 / M5.02.2 | Does historical IVS agree with its items, directionality, missingness, scaling and stored values? | BOUNDED_AUDIT_DELIVERED 6 October: 26 unchanged operational statements; 3,384 exact float cells; 45 scoped domain/full-relevance, 21 source, 20 fixture and four returned-state/constant-range checks pass. IVS-01/02/03 remain scientific findings; IVS-04 rejects stale extrema on the inspected runtime. Eight children in [IVS_MEASUREMENT_AUDIT.md](IVS_MEASUREMENT_AUDIT.md). No scientific correction or estimator. |
| M2.04.1 / M6.08.1 | Do the legacy IAT–IVS exhibits, captions, denominators and interpretations trace to the intended historical outputs? | NEXT IMMEDIATE TASK: pin embedded Table 2/Figures 6–10 and candidate existing outputs, map exact relationships and source rules, and record evidenced discrepancies. No replacement exhibit, estimator or production-code correction. |

Latest bounded delivery, **6 October 2026**: the [historical IVS audit](IVS_MEASUREMENT_AUDIT.md) reproduces the stored recipe and documents observed precision and open construct/missingness findings. Separate source review and independent MCP receipt assertions support bounded acceptance; the earlier IAT evidence, original-byte pins and primary IDs are retained. This is not a parent Measurement or Replication Gate pass.

Next bounded workflow: **historical IAT–IVS exhibit-provenance audit** (M2.04.1 / M6.08.1), with these acceptance children:

1. **M2.04.1.a** — Pin the exact LEGACY-A embedded Table 2 and Figures 6–10, captions, relationships and candidate existing output files; keep restricted extracts ignored.
2. **M2.04.1.b** — Establish image identity and actual content, not just filename/caption identity. Do not guess a missing figure's meaning from neighboring text.
3. **M6.08.1.a** — Map each existing exhibit to source statements, selected data state, category definition, sample and denominator; disclose missing output/version provenance.
4. **M6.08.1.b** — Use bounded Stata-MCP aggregate diagnostics where necessary to compare displayed values with the known historical recipe. Do not fit models, overwrite an output or silently choose the preferred number.
5. **M6.08.1.c** — Distinguish stale artifact/version, caption-placement, numerical-precision and unsupported-interpretation issues; record minimal correction candidates and expected consumers, without implementing scientific changes.
6. **M6.08.1.d** — Require a separate review, source retention, empty-session/ignore/staging checks and explicit known-gap disposition before accepting this bounded child.

The owner expressed agreement in principle with justified Data Preparation/Analysis corrections on 6 October. This supports the later revision track; it does not certify unfinished historical gates or unknown substantive choices. Continue the remaining measure audits and protected historical replication, then record and implement the explicit M7 revision decisions with historical/revised comparisons. No production correction, estimator, geography harmonization or anonymous dataset is part of this immediate exhibit audit. A completed child does not complete M0, M4, M5 or M6; qualitative substance and separate Git/cloud/release authorities remain protected.


### M0 — Scope, access, authority, privacy, and prior dissemination

**Work**

1. **M0.01** — Record the instruction change: quantitative redevelopment is allowed; qualitative content is protected; CFI approvals are historical, not scientific constraints.
2. **M0.02** — Refresh repository branch, commit, status, worktrees, and remote evidence before any editing. Do not overwrite pre-existing changes.
3. **M0.03** — Confirm Dropbox/OneDrive project scope and identify local placeholders or connector gaps. Record that read access is not authority to restructure or publish.
4. **M0.04** — Resolve Zotero collection descendants and explicit IDs; keep all calls scoped. Build an attachment-access receipt without changing the collection.
5. **M0.05** — Use only the author-supplied public NotebookLM link, without account authentication. Reconcile its source list with Zotero and verify retained claims against original sources. Never query an unrelated active notebook as a fallback.
6. **M0.06** — Verify permanent restricted Dropbox storage for originals/PII and the ignored local audit boundary; prepare an owner-reviewable public field specification. Public Git may receive safe code, aggregate evidence, non-sensitive provenance and an owner-approved anonymous replication derivative only after disclosure and reproducibility checks. Do not change GitHub visibility, transfer data, clean history or publish without the appropriate separate authority. Execute the child checks above.
7. **M0.07** — Inventory existing public reports, Canva outputs, preprints, repository manuscripts, policy briefs, technical supplements, permissions, funding conditions, and author agreements. Distinguish “sent privately to CFI” from “publicly published.”
8. **M0.08** — Identify author-owned choices to obtain at later gates: canonical draft, major analytical changes, qualitative integration approval, corresponding author, affiliations, open-access mandate/budget, and final publication authority.

**Deliverable:** intake and access register, publication-history/rights summary, and known-gap list.

**Completion:** resource scopes and restrictions are explicit; credentials are never recorded; missing access has a concrete recovery route. NotebookLM absence can remain a bounded open item while accessible-source work continues, but no NotebookLM-complete claim is permitted.

### M1 — Canonical manuscript, project-wide inventory, and chronology

**Work**

1. **M1.01** — Compare the two full drafts section-by-section, including tables, embedded images, footnotes/endnotes, bibliography fields, tracked changes, comments, text boxes, and appendices.
2. **M1.02** — Check whether each draft's media and tables actually display and whether apparently repeated headings reflect duplicates, annexes, or distinct versions.
3. **M1.03** — Give every unique substantive difference a disposition: baseline, companion addition, later correction, duplicate, or unresolved author choice. Do not merge uncritically.
4. **M1.04** — Reconcile archive contents across admin, literature, data, code, output, deliverables/presentations, and working-paper folders. Hash duplicates and identify unique files before deciding any priority.
5. **M1.05** — Build the code/data/output dependency map from actual paths and calls. In the current Git master, the two commented analysis calls use older IFC filenames; establish the real historical execution route rather than assume the master presently invokes the CFI preparation and analysis files.
6. **M1.06** — Inspect Git history, relevant diffs, archived logs, versioned data and instruments, manuscript revisions, and feedback documents. Date substantive events from evidence. Distinguish code creation dates, fieldwork dates, file modification dates, and Dropbox upload dates.
7. **M1.07** — Establish which code/data snapshot generated each manuscript result. Where unrecoverable, state the uncertainty.
8. **M1.08** — Freeze originals by hashes and references; do not relocate or rename live Dropbox/OneDrive files.

**Deliverable:** author-confirmable baseline recommendation, source manifest, dependency map, and evidence-based project chronology.

**Completion / Baseline Gate:** every discovered version is classified; the chosen manuscript and computational snapshots are identified; unique content in the companion is accounted for; no “latest means authoritative” inference remains.

### M2 — Complete manuscript decomposition and claim inventory

**Work**

1. **M2.01** — Read the canonical full draft completely, using stable section/paragraph identifiers and a rendered page map when available.
2. **M2.02** — Identify the research questions, contribution claims, theoretical mechanisms, institutional chronology, quantitative stages, existing qualitative findings, policy discussion, and regional comparison.
3. **M2.03** — Enumerate every quantitative outcome, index, explanatory variable, control family, sample restriction, regression, interaction, correlation, class solution, and post-LCA comparison.
4. **M2.04** — Register every table/figure and number, including values appearing only in captions, narrative, or appendices.
5. **M2.05** — Separate claims about what was actually conducted from proposed work, aspirations, or unimplemented methods.
6. **M2.06** — Map each legacy element to article, supplement, research record, duplicate, unsupported/needs verification, or author-owned qualitative material. Assigning a destination does not authorize deleting it.
7. **M2.07** — Crosswalk CFI comments and subsequent revisions as useful diagnostic history. No historical reviewer suggestion substitutes for a new scientific assessment.

**Deliverable:** complete claim/exhibit ledger and a “legacy element → evidence → new destination” map.

**Completion:** every substantive manuscript component has a status and destination; no important stage disappears because it was absent from a condensed version.

### M3 — Literature, institutional context, and contribution audit

**Work**

1. **M3.01** — Enumerate all items in the named Zotero collection and descendants with pagination and coverage receipts. Reconcile them against both full drafts, Dropbox/OneDrive references, and the NotebookLM source list once accessible.
2. **M3.02** — Verify metadata, source type, DOI/URL, authors, year, journal/publisher, publication status, duplicates, and any correction/retraction. Propose library corrections separately; do not mutate Zotero during an audit.
3. **M3.03** — Fully read accessible project literature. Record inaccessible or image-only texts separately and obtain legal primary-source alternatives where needed. An abstract or AI summary does not count as full-text review.
4. **M3.04** — Build a critical evidence matrix: question, theory, country/population, data, sampling, design, measure, effect or association, uncertainty, limitations, contrary evidence, and relevance to this paper.
5. **M3.05** — Cover the original conceptual territory: DPI versus provider applications; digital financial inclusion versus account ownership; usage quality and welfare; gender, agency, and household relations; migration/legal identity/KYC; remittances; skills, trust, privacy, fraud and redress; and institutional interoperability. Refine themes from the actual source corpus rather than presume all are equally central.
6. **M3.06** — Identify the closest competing work and perform bounded updated searches through official journal/publisher pages, scholarly discovery services, and forward/backward citations. Record dates, query families, inclusion criteria, and stopping rationale.
7. **M3.07** — Use NotebookLM for bounded discovery and cross-source interrogation once access is verified. Cache grounded responses with their source references, and check all substantive passages against the original sources before citing them.
8. **M3.08** — Build a separate institutional-source matrix for Colombian laws, implementation dates, regulators, payment infrastructure, migration/documentation rules, inclusion statistics, and benchmarking sources. Verify against primary official sources and distinguish fieldwork-era conditions from later developments.
9. **M3.09** — Separate enabling institutional conditions from impacts measured by this study. Later payment-system changes cannot become exposure or causal mechanisms in an earlier cross-sectional survey by narrative implication.
10. **M3.10** — Produce a contribution assessment that names what this study adds, what it does not establish, and the closest literature it changes or qualifies. Do not mistake an underdocumented population, a long report, or an LCA typology by itself for a theoretical contribution.

**Deliverable:** scoped corpus/coverage receipt, critical literature matrix, institutional chronology, verified bibliography, and a contribution memo shared by methods and writing.

**Completion / Literature Evidence Gate:** all scoped items assessed; central claims source-verified; inaccessible items explicit; contemporary/contextual facts temporally aligned; closest literature and competing explanations included. The article need not cite every catalogue item, but omissions have an evidentiary rationale rather than an arbitrary citation quota.

### M4 — Quantitative data lineage, sampling, and sample audit

**Work**

1. **M4.01** — Trace fielded survey instruments, form/export versions, raw deliveries, participant keys, cleaning inputs, merge paths, and final analytical datasets.
2. **M4.02** — Audit duplicated/replaced records, consent and eligibility, timing, geography, language, recruitment channels, interview mode, and substantive-response rules. Keep identifiers and record-level crosswalks restricted.
3. **M4.03** — Compare instrument skip logic to missing values. Distinguish structural non-applicability, refusals, “don't know,” accidental missingness, and data-entry errors.
4. **M4.04** — Reconstruct sample flow and model-specific denominators. Explain every change between raw, eligible, cleaned, complete-case, regression, and LCA samples.
5. **M4.05** — Determine the actual sampling design. Do not label referral recruitment as respondent-driven probability sampling or apply survey/RDS weights unless recruitment and available design information support it.
6. **M4.06** — Evaluate coverage, selection, nonresponse, digital/phone access, geographic concentration, recruitment-network dependence, and external-validity limits.
7. **M4.07** — Assess missingness by variable and subgroup. Choose transparent model-specific handling; consider imputation only if substantively and statistically justified, with sensitivity evidence.
8. **M4.08** — Confirm unit-of-analysis, independence assumptions, weight definitions, household/site/network identifiers where available, and appropriate inference units.
9. **M4.09** — Validate disclosure, consent, data rights, and access arrangements. Missing ethics documentation remains a factual gap; do not invent an approval number or retrospectively describe an exemption as granted.

**Deliverable:** data provenance and restricted crosswalk, public-safe sample-flow/missingness report, codebook, and sampling/inference boundary.

**Completion / Data Gate:** stable inputs and keys; every exclusion/denominator explained; design and representativeness accurately described; no unresolved data-integrity issue drives a retained central claim.

### M5 — Measurement and index construction

**Work**

1. **M5.01** — Build a field-item → coded variable → component → index → model/LCA indicator map.
2. **M5.02** — Check labels, ranges, coding direction, reversals, category collapses, special missing codes, transforms, weights, denominators, normalization sample, and constant/degenerate variables.
3. **M5.03** — Trace any use of returned Stata statistics and shared helper state. Establish whether normalization or other transformations use the intended statistics, not values overwritten by an intervening command.
4. **M5.04** — Reconstruct formulas directly from the code and compare them with manuscript/appendix descriptions and the questionnaire.
5. **M5.05** — Assess construct validity: what the measure actually captures, what it omits, and whether the name overclaims capability, vulnerability, empowerment, or DPI exposure.
6. **M5.06** — Distinguish formative composites from reflective scales. Reliability/factor methods are conditional tools, not automatic requirements for every index.
7. **M5.07** — Examine predictor/outcome and index-component overlap. Identify mechanical correlations, circular regressions, and post-LCA comparisons that reuse the class-defining information.
8. **M5.08** — Inspect binary/category recoding for LCA, sparse categories, thresholds, sample restrictions, and whether indicators represent a coherent construct space.
9. **M5.09** — Propose alternatives only for documented threats: preserve historical measures, justify any revision, and plan comparison before examining the revised finding.

**Deliverable:** measurement audit, item/index dictionary, overlap matrix, and recommended changes with consequences.

**Completion / Measurement Gate:** every retained measure is reproducible and interpretable; discrepancies are resolved or explicitly limit the claim; any revised measure has a rationale independent of whether it makes coefficients significant.

### M6 — Exact historical replication, before academic revision

**Work**

1. **M6.01** — Inspect Stata MCP session state before execution. Preserve any unrelated loaded work and establish one executor.
2. **M6.02** — Record Stata version/edition, dependencies and ado resolution, input hashes, seeds, stochastic settings, and the true preparation/analysis entry points.
3. **M6.03** — Run into an isolated private scratch/output location, not the legacy output tree or public appendix folder. Preflight every path and writing side effect.
4. **M6.04** — Reproduce the archived preparation and all four quantitative stages: descriptive statistics, correlations, regressions/interactions, and LCA/profiling.
5. **M6.05** — If an execution defect prevents replication, preserve the original, record the minimal operational repair separately, and assess whether it is statistically inert. A substantive correction belongs in the revision track.
6. **M6.06** — Compare sample membership and model-specific N, variable values, descriptive denominators, coefficients, standard errors, confidence intervals, fit measures, class probabilities, posterior diagnostics, and displayed rounding.
7. **M6.07** — Align LCA solutions allowing for arbitrary class-label permutation. Distinguish numerical tolerance, optimizer variation, different local maxima, and substantive changes.
8. **M6.08** — Reconcile code-generated values with manuscript tables, narrative, graphics, and appendix manifests. Inspect missing/empty tables, stale figures, uncited results, and mixed-version outputs.
9. **M6.09** — If a tool times out, inspect durable logs/markers before rerunning. A client timeout is neither proof of failure nor permission to launch duplicate estimation.

**Deliverable:** historical replication report, environment receipt, result/exhibit crosswalk, and discrepancy register.

**Completion / Replication Gate:** each legacy result family is reproduced, explained as a documented numerical/version difference, or marked unrecoverable with evidence. A substantive unreproduced result cannot be carried into the new article simply because it appeared in the approved report.

### M7 — Academic revision plan and method gate

**Work**

1. **M7.01** — Disclose what results have already been seen and the known analysis/search history. This is a retrospective audit of an existing study, not a preregistered new experiment.
2. **M7.02** — Separate exact reproduction, deterministic error correction, justified methodological revision, and genuinely new exploratory analysis.
3. **M7.03** — Specify research questions, target quantities, outcome hierarchy, populations/samples, measurements, control sets, inference, missingness, multiplicity families, interaction interpretation, and LCA selection/validation criteria.
4. **M7.04** — Create a threat-driven diagnostic/robustness matrix. Each proposed test must have a scientific purpose and a decision consequence.
5. **M7.05** — Determine permissible claim strength. If the survey cannot identify causal effects, retain association/descriptive claims; do not manufacture an instrument, panel, natural experiment, or “mechanism test” from inadequate data.
6. **M7.06** — Record the proposed revision before estimating it. Timestamping now can constrain new work, but cannot make already observed hypotheses confirmatory.
7. **M7.07** — Take material choices to the author: changed index definition, substantially changed sample or primary question, new main estimator, changed LCA feature set/class-selection rule, or removal of a central legacy claim.
8. **M7.08** — Use ordinary scientific diagnostics and documented bug fixes without demanding approval for every harmless operation. Escalate choices that change the study's substantive meaning.

**Deliverable:** retrospective analysis history, revision/design register, inference plan, approved material decisions, and a method-gate report.

**Completion / Method Gate:** revisions are justified and bounded; claim strength matches the data; no unresolved critical measurement/design issue is hidden by a larger battery of regressions.

### M8 — Descriptive, correlation, and regression evidence

**Descriptive/correlation work**

- **M8D.01** — Rebuild complete distributions, sample characteristics, denominators, and substantively important subgroup comparisons.
- **M8D.02** — Check binary/proportional data, extreme values, ceiling/floor effects, multiple-response questions, and meaningful units.
- **M8D.03** — Distinguish raw correlations from associations mechanically induced by shared items; report uncertainty appropriately.
- **M8D.04** — Choose correlation methods and missingness conventions based on the actual measures. Do not present an indiscriminate significance heatmap as proof of a mechanism.

**Regression work**

- **M8R.01** — Audit every historical model family and decide which answers the academic research questions.
- **M8R.02** — Check outcome-model compatibility, functional form, collinearity, influential observations, overfitting/limited information, missingness, and support for comparisons.
- **M8R.03** — Justify controls using temporal and conceptual roles; flag mediators, colliders, and contemporaneous proxies rather than treating “more controls” as universally better.
- **M8R.04** — Assess heteroskedasticity/dependence and suitable uncertainty estimates. Do not mechanically cluster at a level with very few independent groups without addressing the resulting inference limits.
- **M8R.05** — Define multiplicity families from the scientific questions and report both raw and appropriate adjusted evidence where justified.
- **M8R.06** — Present meaningful effect sizes/associations and intervals, not only significance stars. Interpret imprecise/null estimates honestly.
- **M8R.07** — Evaluate interactions using coherent predicted quantities/marginal effects, common support, uncertainty, and clear scales; do not infer subgroup differences from different significance levels alone.
- **M8R.08** — Run only the recorded, threat-relevant sensitivity analyses. Preserve every specification tried and its status, including unfavorable results.

**Deliverable:** reproducible revised descriptive/correlation/regression tables and figures, diagnostics, inference report, and historical-versus-academic result comparison.

**Completion / Statistical Evidence Gate:** every retained result is traceable and interpretable; sample and inference conventions are explicit; the narrative is not selected according to the most attractive estimate.

### M9 — LCA, uncertainty, and downstream profiling

**Work**

1. **M9.01** — First distinguish the historical solution from any proposed academic revision. Do not assume four classes or existing segment names must survive.
2. **M9.02** — Audit indicators, coding, estimation sample, missingness treatment, identifiability, convergence, parameter estimates, boundary behavior, and sparse response patterns.
3. **M9.03** — Assess sensitivity to starts/seeds and competing local optima. Record the best solutions and comparable likelihoods; a single successful run is not stability evidence.
4. **M9.04** — Compare feasible class counts using fit, parsimony, classification uncertainty, substantive interpretability, minimum information/class size, and reproducibility. Do not choose a count solely to fit a pre-existing narrative.
5. **M9.05** — Examine conditional/local-independence assumptions and indicator overlap. Diagnose sensitivity to justified feature/threshold alternatives.
6. **M9.06** — Report posterior probabilities, assignment uncertainty, class sizes, profiles and their uncertainty as appropriate. Class labels are interpretive summaries, not discovered natural identities.
7. **M9.07** — Audit downstream multinomial associations, distal-outcome comparisons, and validation claims. Classifying participants and treating that classification as error-free may distort inference.
8. **M9.08** — Consider an appropriate uncertainty-aware downstream method only where feasible and justified in Stata. Do not automatically introduce a complex method or install packages merely because it is available elsewhere.
9. **M9.09** — Distinguish internal characterization using class-defining items from validation with information not used to create the classes. Avoid circular “validation.”
10. **M9.10** — Preserve the coauthor's qualitative grouping/interpretation. If it does not map neatly onto statistically estimated classes, state the different analytical purposes rather than force equivalence or relabel qualitative groups.

**Deliverable:** LCA selection/convergence/stability and classification report, complete profiles, downstream analysis, limitations, and historical-versus-revised comparison.

**Completion / LCA Evidence Gate:** the retained solution has documented diagnostic support; uncertainty and sensitivity are visible; any unsupported typology or validation claim is narrowed or removed.

### M10 — Integration without changing the qualitative component

**Work**

1. **M10.01** — Read the approved migrant and expert qualitative material as existing evidence, preserving source, wording, interpretation, and attribution.
2. **M10.02** — Map each academic quantitative finding to relevant literature and existing qualitative evidence: convergence, complementarity, divergence, or no direct comparison.
3. **M10.03** — Keep units and analytical purposes distinct. Interviews can contextualize an association; they do not automatically causally validate it.
4. **M10.04** — Check whether updated quantitative results affect joint conclusions or policy recommendations. Flag conflicts for author/coauthor resolution; do not alter qualitative findings to make the paper appear coherent.
5. **M10.05** — Validate institutional/contextual sources and dates without recoding expert interviews or changing coauthor-owned regional assessments.
6. **M10.06** — Clearly identify what Colombian evidence can suggest elsewhere and what regional benchmarking can and cannot establish.
7. **M10.07** — Build a claim-safe discussion and policy mapping: observation → interpretation → qualified implication → implementation uncertainty.

**Deliverable:** integration matrix, protected qualitative-content map, divergence/issues list, and evidence-bounded discussion outline.

**Completion / Integration Gate:** all mixed-evidence claims have support and a proper inference boundary; qualitative changes are absent unless separately approved; unresolved material conflicts are not silently edited away.

### M11 — Article, supplement, bibliography, and exhibits

**Work**

1. **M11.01** — Draft from the audited evidence ledger and full legacy content map, not from the condensed CFI manuscript.
2. **M11.02** — Build a sharp opening with research questions, actual methods, main findings, contribution, and limitations. Restore essential Colombia context that earlier condensation lost.
3. **M11.03** — Create a critical, connected literature argument, not a catalogue of everything read. Bring relevant scholarship into results interpretation and discussion as well as the literature section.
4. **M11.04** — Describe all four quantitative stages clearly and provide enough sample, measurement, regression, and LCA information to judge the study.
5. **M11.05** — Use the approved qualitative component within its protected boundary. Obtain coauthor approval for any journal-length excerpting/reformatting that changes its presentation.
6. **M11.06** — Allocate full instruments, variable/index architecture, sample diagnostics, model specifications, complete regression output, LCA diagnostics, class profiles, and justified sensitivity work to a navigable technical supplement.
7. **M11.07** — Keep legacy CFI public appendices separate from academic versions. Every revised exhibit identifies its input/code/version and superseded historical counterpart.
8. **M11.08** — Generate all statistical results, graphs, methodological diagnostics, and analytical tables from the Stata pipeline. Manually authored conceptual diagrams and variable-description tables are acceptable when source-mapped and checked; do not manually type statistical estimates into them.
9. **M11.09** — Embed actual tables/figures in Word, not empty placeholders or external file links. Provide editable tables and appropriate high-resolution/vector figures, clear units, denominators, notes, and source attribution.
10. **M11.10** — Verify every retained in-text citation and bibliographic entry, with APA consistency where required. Keep institutional/news/legal sources identifiable by type and date; retain legacy bibliographies in the research record rather than silently overwrite history.
11. **M11.11** — Record AI-assisted research, analysis, drafting, translation, editing, and document assembly for accurate journal-specific disclosure. Human authors remain responsible; tools are not authors.

**Deliverable:** audited scientific master, ITD-first Word article, technical supplement, complete bibliography, exhibit index, and journal adaptation checklist.

**Completion / Draft Quality Gate:** the article is coherent and substantively adequate, the supplement supplies essential technical evidence, every major legacy component has a documented disposition, and no quantitative number is orphaned from its result source. Attractive formatting cannot compensate for an unresolved method gate.

### M12 — Independent reproduction and document integrity

**Work**

1. **M12.01** — Re-run the academic pipeline in a clean, isolated environment/output directory through the actual supported Stata entry point. Preserve legacy files; do not delete the historical output tree to simulate a clean run.
2. **M12.02** — Compare inputs, sample definitions, results, exported tables/figures, and final displayed numbers within declared tolerances.
3. **M12.03** — Audit every numerical claim, model label, confidence interval, class share, caption, and denominator against the final frozen results.
4. **M12.04** — Check all citations bidirectionally, including author/year consistency, publication versions, page-located support, institutional dates, and unresolved references.
5. **M12.05** — Render and visually inspect Word/PDF deliverables for missing or cropped graphics, empty tables, unreadable tables, bad page breaks, incorrect captions, font/style inconsistency, and unresolved fields.
6. **M12.06** — Apply actual journal heading and appendix requirements. Do not import the long report's table-of-contents behavior into a journal article by default.
7. **M12.07** — Verify blind review: author identifiers in filenames, properties, tracked changes/comments, headers, funding details, Git links, supplementary metadata, and self-references. Public replication links can reveal identity; determine the journal-compliant review route without compromising provenance.
8. **M12.08** — Inspect public-safe package contents for participant-level data, disclosure-prone logs, hidden spreadsheet sheets, IDs, audio, consent forms, protected literature PDFs, and credentials.

**Deliverable:** reproducibility receipt, final claim/citation/numeric audit, layout report, privacy/blinding report, and frozen artifact manifest.

**Completion / Integrity Gate:** the actual reader-facing files, not only the source text, are verified; no retained major numeric/source discrepancy or public disclosure issue remains. “Can run locally” and “may be published publicly” remain separate conclusions.

### M13 — Adversarial review and submission readiness

**Work**

1. **M13.01** — Perform distinct substantive, measurement/inference, LCA, and mixed-evidence reviews. Seek genuine author or independent methodological review where available; an AI simulation is not external peer review.
2. **M13.02** — Stress-test contribution against the closest literature and ask what skeptical ITD reviewers could reject: DPI construct ambiguity, selection, measurement overlap, causal overclaiming, under-validated classes, or an insufficiently general argument.
3. **M13.03** — Resolve review findings with evidence. Limit unsupported claims instead of repeatedly searching specifications for a favorable answer.
4. **M13.04** — Refresh ITD rules and verify outstanding word/supplement, fees, open-access, license, prior-publication, data, ethics, AI-disclosure, and anonymity requirements.
5. **M13.05** — Confirm authorship/order, affiliations, funding/CFI relationship, contributions, conflicts, ethics/consent, permitted quotation/reproduction, and restricted data availability with the authors.
6. **M13.06** — Assemble main manuscript, separate title page, abstract/keywords, cover letter, declarations, technical supplement, figures/tables, and replication access instructions as actually required.
7. **M13.07** — Prepare a fallback adaptation memo for DPR, International Migration, and Migration and Development. Do not create three diverging scientific manuscripts before the first submission is settled.
8. **M13.08** — Obtain explicit author approval of the final scientific version and separate explicit authority for submission/public release.

**Deliverable:** review reports, response/decision log, final ITD packet, submission-readiness checklist, and fallback adaptation memo.

**Completion:** packet is ready for author-controlled submission, with no outstanding critical/major issue affecting its argument or compliance. This status does NOT authorize clicking Submit, emailing an editor, posting a preprint, or pushing an academic release.


## 6. Quantitative change control

Each substantive revision records:

1. Finding and exact evidence.
2. Historical behavior/result and the version that produced it.
3. Why the proposed correction or alternative addresses a specific problem.
4. Any material author decision.
5. The dated analysis plan and implementation.
6. Revised result, comparison with the legacy result, and effects on downstream tables/claims/LCA.
7. Sensitivity, residual limitations, and whether the finding is exploratory.

Keep distinct tracks: historical replication; operational execution repair; substantive error correction; methodological improvement; new exploratory work. Never edit archived estimates to agree with new prose or conceal a result that changed unfavorably.

Null or contradictory findings are not failed analyses. More computation does not create a probability sample, temporal ordering, an experimental counterfactual, or independent validation data. No new data collection is assumed by this plan.

The existing online appendix README explicitly describes a legacy package with unchanged indices, models, and estimates. Leave that historical contract intact. Academic outputs need a clearly separate version and provenance; linking the two is appropriate only after public-release review and authorization.

## 7. Workspace, chats, and execution ownership

### Recommended arrangement

Use this chat as the coordinating record. Add two bounded workstream chats when execution begins and only with explicit user authorization:

- **Literature and context:** Zotero/NotebookLM corpus, primary-source verification, literature matrix, institutional chronology, contribution assessment. Own source notes, not the master manuscript or Stata.
- **Quantitative audit and replication:** data/measurement/code audit, sole Stata MCP execution, historical and academic result records, analytical exhibits.

A final publication/independent-review chat can be useful after the evidence gates pass. It should review a frozen packet; it should not autonomously rerun analysis or rewrite protected qualitative material.

One chat is technically feasible, but a long, entirely linear conversation is not inherently more rigorous. Literature and data auditing can progress independently; estimation and manuscript integration have real dependencies. Conversely, multiple chats do not isolate files, cloud sync, credentials, or a shared Stata session.

### Ownership rules

- Coordinator owns the agreed plan, decisions, gate status, evidence integration, and final manuscript.
- One quantitative executor owns the Stata session and output paths.
- Literature work owns source evidence and citation suggestions; it does not overwrite the manuscript.
- Review tasks are read-only until findings are accepted and assigned.
- Do not have two writers editing the same artifact, staging/committing shared changes, or executing Stata concurrently.
- No chat creation, delegation, task messaging, or new worktree is performed as part of this planning deliverable.

### Durable continuation

At every milestone boundary, store a compact handoff with commit/input hashes, accepted outputs, gate evidence, unresolved findings, protected qualitative content, current Stata/output state, and next smallest action. A new chat resumes from these records and fresh checks, not a claim that it remembers a previous conversation.

Prefer the existing empirical-workflow templates/checkers when their fields fit the actual study. Instantiate them when execution reaches the relevant stage, not as evidence-free placeholders. Use a small number of authoritative ledgers rather than competing dashboards maintained differently in several chats.

## 8. Skills and research tools

Use relevant tools at the point of need, not every installed suite.

| Work | Route |
|---|---|
| Overall intake, method/quality gates, continuation | auto-empirical-research-skills and its Paper-WorkFlow orchestration resources, adapted to the retrospective study and Stata requirement |
| Literature synthesis and source verification | literature-review; Zotero MCP with explicit library/collection/attachment scope; primary journal/official sources; validate-bib for bibliographic checks |
| Project NotebookLM evidence | notebooklm, only after notebook-specific access is verified; grounded responses remain pointers to primary sources |
| Dropbox archive discovery | find-dropbox-content and read-only listing/metadata; local archive reading where appropriate |
| Quantitative methods/execution | stata and the applicable empirical audit/inference references; all Stata execution through the MCP connection |
| Document and PDF inspection/assembly | documents and pdf when drafting/format validation is actually undertaken; preserve embedded contents and inspect rendered files |
| Adversarial academic review | applicable empirical/referee resources and econ-review where suitable; distinguish AI review from an external human review |
| Journal adaptations | official author instructions first; the existing cross-journal rt-venue-reframe, rt-desk-reject-risk, and rt-submission-readiness resources can support checks after their instructions are read |

The installed Awesome Journal Skills companion was checked during planning. Its venue index and exact-name pack search did not provide exact suites for ITD, DPR, International Migration, or Migration and Development. Do not invent skill names or substitute an Information Systems Research or World Development pack as if it were an ITD pack. Use verified official rules and the cross-journal resources; any future installation requires a separate user request.

A methodological suite cannot mandate an irrelevant estimator. No DiD, IV, RDD, machine-learning, structural, or mediation analysis is added solely because a skill offers it. Scientific need, available data, and identification support decide the method.

## 9. Work cadence, progress, and escalation

Report completed evidence and gates, not “percentage of the project” without a stable denominator.

At each milestone report:

- Items in scope, reviewed/validated, excluded with rationale, and inaccessible.
- What was checked and what the checks establish.
- Critical/major/minor findings and their consequences.
- Decisions needed from the author, separated from routine work.
- Scientific gate status and any claim restrictions.
- The next smallest task and updated completion outlook.

Plan the first execution block as M0–M2: finalize access boundaries, compare the two full drafts, reconcile the project archives, and produce the complete claim/analysis inventory. It should not jump straight to a new condensed manuscript.

The next block develops M3 in parallel with M4–M6, while keeping a single Stata writer. M7 is the explicit transition from understanding/reproducing the study to changing it. M8–M10 produce the revised scientific evidence; M11–M13 convert it into a verified submission packet.

A calendar forecast should be issued after M1–M2 establish the unique-file, literature, claim, exhibit, and analysis counts and the first replication pass reveals runtime/data issues. Account credits do not resolve missing access, ethics documentation, scientific identification, or coauthor approval. Do not promise that exhaustive work can finish in a few days before these denominators are known.

Escalate rather than improvise when:

- No defensible canonical data/manuscript version can be established.
- Consent, legal access, authorship, rights, or publication eligibility is unresolved.
- A proposed revision materially changes the scientific question or contradicts protected qualitative material.
- Available data cannot support a retained main claim.
- A repeated methodological failure would lead to unbounded specification search.
- A gate remains unsatisfied after bounded repair attempts: deliver the evidence and gap for author decision, never mark it passed.

## 10. Final definition of done

The academic preparation is complete only when:

1. All agreed project sources and unique manuscript components have documented coverage or an explicit, accepted access gap.
2. The original full draft and quantitative history remain recoverable.
3. The literature/context assessment is comprehensive within its declared scope, and every retained citation/claim is source-verified.
4. The data, sampling, measurement, inference, regression, and LCA evidence support the exact claims made.
5. Historical-versus-academic changes are transparent, with no selective disappearance of inconvenient results.
6. The qualitative component has not been substantively modified without separate author/coauthor approval.
7. Statistical exhibits are reproducible through the Stata MCP-supported pipeline and match the reader-facing Word/PDF files.
8. The technical supplement contains the full evidence needed to evaluate the quantitative work without bloating or replacing the article.
9. Public and restricted materials are separated, and the final packet satisfies the verified primary journal's requirements.
10. Authors have reviewed and approved the scientific packet; any actual submission or public release still requires explicit authorization.

The next action is the evidence-based baseline and inventory phase, not manuscript rewriting or searching for more favorable regressions.
