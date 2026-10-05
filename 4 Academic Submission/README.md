# Academic redevelopment workspace

This is the academic redevelopment of the full legacy research manuscript, not a republication of the condensed CFI deliverables. The governing milestones and scientific boundaries are in [ACADEMIC_SUBMISSION_WORKPLAN.md](ACADEMIC_SUBMISSION_WORKPLAN.md). This workspace was initialized against repository commit `151b0e8db2e34cc9e05c2f0e6f19afb5e080a5d6` on 5 October 2026. No historical analysis or manuscript was changed during intake.

## Entry routing

The project enters as **retrospective redevelopment of completed research**. Existing estimates and draft interpretations have already been seen. Neither this audit nor a later revision register is a prospective preregistration. Describe historical, exploratory, and genuinely future validation work separately.

The agreed submission sequence is **Information Technology for Development → Development Policy Review → International Migration → Migration and Development**. Work on one scientifically defensible core, primarily addressing the first outlet's audience; adapt later rather than treating four venues' different rules as one universal format. Current venue instructions, fees, open-access obligations, rights, and required disclosures must be rechecked at the relevant submission gate. Exact installed skill suites for these four outlets have not been verified; do not substitute another journal's requirements.

The user authorizes literature and quantitative reassessment, including justified improvements after the historical baseline is reproduced. Earlier CFI approval does not bind the new academic analysis. The qualitative contribution is protected: read and locate it for integration, but do not recode interviews, alter quotations, relabel themes, revise expert ratings, or rewrite its substantive conclusions without author/coauthor review.

## Stage passport

| Milestone | Current state | Evidence and exit condition |
| --- | --- | --- |
| M0 — authority, access, privacy | In progress; access probes and manuscript choice completed | Git and local archives readable; Zotero collection and public NotebookLM accessible; Overleaf linked to the correct repository. Rights, ethics, privacy, and prior-publication status still require resolution. |
| M1 — historical baseline and provenance | In progress; byte inventory and bounded draft comparison completed | Latest recheck: 1,386 file occurrences hashed, including 724 Git-tracked files at the intake commit, 347 local Dropbox files, and 315 OneDrive files. Both full legacy drafts are preserved; A is author-selected. Inventory and comparison are not scientific validation. |
| M2 — manuscript, claims, exhibits, workflow | In progress; extracted-text/structural reading and complete Stata source close-read completed | 605 crosswalk entries account for the selected manuscript's body blocks and exhibits. The 19,648-line analysis source is covered by two report-scoped close-read receipts; this is static coverage, not validated estimates. Numerical, citation, visual, source-output and replication checks remain separate gates. |
| M3–M6 — literature, sample, measurement, exact replication | Pending | Begin the relevant activities only with traceable inputs and the previous gates resolved. Do not replace historical outputs or silently change estimators. |
| M7–M10 — revision register, quantitative reassessment, protected integration | Pending | Approve a retrospective revision register after baseline audit; report revised and historical estimates distinctly. |
| M11–M13 — manuscript, reproducibility, readiness | Pending | Prepare and independently validate the article and supplement. Readiness is not submission or publication authorization. |

The machine-readable checkpoint is [00_meta/workflow_state.json](00_meta/workflow_state.json). The intake parser has one runnable self-check in [tools/intake_audit.py](tools/intake_audit.py). It is a document/provenance utility, **not an alternative statistical backend**.

## Source authority and scope

**The author selected LEGACY-A, the original full draft labelled 31 July 2026, as the academic foundation on 5 October 2026.** Its hash identifies the selected document independently of filename, cached Word statistics, or internal date. This manuscript selection is not a validation of its claims or an analytical specification lock. Both originals remain preserved:

| Source ID | Internal version label | SHA-256 |
| --- | --- | --- |
| LEGACY-A | 31 July 2026 | `99919BBE239C5CE319B986B6B18C534DB02D6E3CB5469FF55EDFC1294CAFC76F` |
| LEGACY-B | 4 August 2026; filename includes `Copia` | `BC80253C91CB3EE18619CA264352961B02248D4F3C2FD64DC6F4A785A2AC06AA` |

Each draft has an identical-hash counterpart in the two local archives. Their visible-text comparison identifies 50 change groups and differences in embedded media and document parts. The main body, references, and all 38 table-cell arrays match; three unique appendix images retained in A are absent from B. Complete the independent review of the disposition report and rendered exhibits before certifying the full historical baseline. Cached Word page/word counts are not reliable measurements of the rendered manuscript.

The local Dropbox inventory is not identical to the fresh cloud listing: five cloud-listed files are absent at the same local Dropbox paths but appear in the OneDrive inventory; eight local-only files are an Office lock file and seven desktop configuration files. Cloud byte equality for the five files has not been established. No Dropbox download, synchronization, deletion, or archive modification was performed. OneDrive coverage is a filesystem inventory, not a remote tenant-wide completeness certificate.

The first local pass hashed 1,383 occurrences; a later recheck observed three additional OneDrive cloud-placeholder paths. Normal read-only hash access succeeded for all three, retrieving their existing bytes into the local OneDrive cache without editing cloud content or synchronization controls. The latest manifest therefore records **1,386 hashed occurrences, 860 distinct file hashes, and no unreadable/placeholder rows**. The two added report copies are byte-identical; the presentation is distinct. All 132 distinct Word documents remain structurally extracted. Their presence does not prove public dissemination or reuse rights.

The Zotero access scope is library `1`, collection `26`, **CFI DPI Migrant Women Colombia**: 39 catalogue items, 38 with PDF attachments listed. Metadata and abstracts are not a full-text literature review. Use the [public NotebookLM notebook](https://notebook.google.com/notebook/93a7f63a-ef2b-4c7b-ab8d-d0cfae228189) only. It exposes the correct project notebook with 38 sources in the existing Chrome session. Do not attempt NotebookLM account authentication, use another project's active notebook, or treat generated answers as primary evidence. Reconcile the two source catalogues and verify claims against the underlying publications.

CFI's [official project description](https://www.centerforfinancialinclusion.org/research/global-dpi-insights-community/) establishes that the project has been publicly described. Its proposed research scope is not proof of the final achieved sample, completed analyses, or publication of the full report. Definitive dissemination history, reuse rights, and author disclosure still need confirmation.

## Pipeline status and execution contract

All statistical Stata execution must use the **Stata MCP tools**, including later historical replication and any revised estimation. Do not run Stata through the terminal or substitute Python/R estimates. The non-estimation probe reported **Stata 19 IC on Windows**. The active default adopath did not locate `coefplot`, but the historical master sets a vendored PLUS directory; package readiness therefore remains unverified, not failed. The MCP selection wrapper automatically injects a seed; exact replication must explicitly control and record seeds, package resolution, input hashes, edition-dependent capabilities, and the execution path.

No analytical estimator was executed and no historical analytical output was overwritten during intake. Initial environment and metadata probes did not load data. Later privacy checks used temporary frames in an isolated Stata MCP session to inspect current datasets, Excel worksheets and selected historical versions, displaying schema information and aggregate counts only. No actual identifier values were displayed or saved in receipts; temporary frames were dropped. The local proposal records 13 current contact-bearing files, 18 posterior files whose keys all link to the contact-bearing final dataset, and two historical-only contact-bearing paths. The author confirmed that the contact details are genuine. These checks are not sample/measurement validation or historical replication. Static code findings are questions to resolve, not evidence of a changed effect. Preserve original code, inputs, outputs, logs and RNG/environment provenance before execution; keep historical replication separate from new revisions.

Initial open questions requiring evidence:

| ID | Question | Required next evidence |
| --- | --- | --- |
| AUTH-01 | Canonical manuscript selected: LEGACY-A. Is the historical package fully reconciled? | Author choice recorded; finish independent disposition and visual review, then reconcile code, data, and output versions. |
| AUTH-02 | What has actually been disseminated and what can be reused? | Author publication/distribution chronology, CFI agreement/permissions, and journal disclosure assessment. |
| ETHICS-01 | Which consent/ethics records apply to this specific study? | Verify study-specific documents; do not reuse an archived other-project approval or infer approval from a filename. |
| SCOPE-01 | Does every research claim describe work actually conducted? | Reconcile proposed future/panel/merchant methods with the completed cross-sectional study and data. |
| NUM-01 | Are payment-awareness/use figures comparable across manuscript sections? | Trace variables, coding, denominators, sample restrictions, versions, and underlying outputs; do not choose a preferred number by appearance. |
| EXHIBIT-01 | Does every caption correspond to the intended embedded graphic? | Map figure references, media relationships, numerical sources, and rendered displays. |
| REPL-01 | Can the historical workflow run from a clean, declared environment? | Verify master routing, input/output paths, vendored dependencies, seeds, and historical results through Stata MCP. |
| PRIV-01 | Confirmed: the selected historical dataset labelled `NoPII` retains populated name and telephone fields. | Preserve restricted originals; correct the storage/release boundary only after explicit implementation approval. The filename is demonstrably not a disclosure guarantee for the inspected version. |
| PRIV-02 | Confirmed sensitive-data release hold; exact current/historical proposal prepared locally. | Author confirmation and proposal-only authorization are recorded. Review the ignored 33-path proposal, verify restricted preservation outside Git, and obtain separate authority before removal, history rewriting, commits/pushes, cloud synchronization or external contact. |
| LIT-01 | Do every retained citation and date have a verified source? | Full-text literature matrix, chronology check, bibliographic corrections, and Zotero/NotebookLM source reconciliation. |

No substantive finding is accepted simply because it appeared in a submitted legacy document. Equally, no finding is rejected merely because an intake scan flags a question. The method, integrity, ethics, numerical, and replication gates remain pending.

**Public-release and synchronization work is on hold while PRIV-01/PRIV-02 remain unresolved.** On 5 October 2026 the author superseded the earlier make-private decision: keep GitHub public and do not change repository visibility. The intended architecture is permanent restricted storage of original/PII data in Dropbox and an owner-approved, disclosure-reviewed anonymized derivative for the public reproducibility package. This decision does not remove sensitive files already in Git or its history, certify anonymization, or authorize destructive cleanup. The proposal and exact target/hash manifest are inside ignored `audit-local/intake/`; do not publish them. No repository visibility change, removal, redaction, history rewrite, commit, push, cloud mutation or external message has been performed by this work. Safe local evidence review may continue.

## Privacy and release boundary

`audit-local/` is deliberately Git-ignored. It contains absolute source paths, source manifests, unpublished manuscript extracts, potentially restricted interview/instrument text, connector receipts, difference reviews, and navigation artifacts. Do not stage, commit, upload, or copy those contents to Overleaf. The full archive inventory includes out-of-project archival material; presence in a folder does not establish analytical relevance or permission.

GitHub may receive reviewed academic sources, safe aggregate exhibits, approved bibliographic metadata, reproducibility documentation, and the approved anonymized replication dataset once disclosure and reproducibility checks pass. Direct identifiers, linkable/pseudonymized records that remain identifiable, consent records, audio, identifiable logs, restricted transcripts, and unlicensed third-party full text must not enter the public package. Removing names and telephone fields alone does not establish anonymity: review stable linking keys, free text, detailed locations/timestamps, rare combinations and linkage to previously exposed data. Keep any identifier crosswalk restricted. Overleaf should receive only the reviewed manuscript sources, bibliography and safe exhibits; restricted raw data belong in the owner-designated Dropbox archive, not Git or Overleaf. That archive's complete preservation and access controls have not yet been verified. An ignore rule or a new anonymized file does not remove earlier tracked sensitive versions. A public-safe file is still not approved for release until the owner authorizes it.

## Workflow handoff and proposed commit

After every completed workflow, provide a proposed commit title and full description covering the purpose, actual changes and affected files, validation performed, and any unresolved limits. Clearly distinguish completed work from the next planned workflow. Preparing the message does not authorize staging, committing, pushing, history rewriting or cloud synchronization; those remain separate owner decisions. Do not include identifiers, restricted extracts or the private operational target manifest in a commit message.

## Overleaf handoff

The user-created [Overleaf project](https://www.overleaf.com/project/6ac365fc911d6a7c7f8003e3) is linked to `Fundacion-Capital/CFI-DPI-Migrant-Women-Colombia`. Its verified intake settings are **main document: None; compiler: pdfLaTeX; TeX Live: 2026; autocompile: off**. Its GitHub dialog reported no new commits since the last merge at the time of inspection. No compiler setting or synchronization control was changed.

[main.tex](main.tex) is a locally prepared, clearly labelled academic preparation record, **not a finished journal article or a validated replacement for the legacy paper**. Local compilation and opening in the Codex editor do not synchronize Overleaf. After explicit owner authorization to commit/push and synchronize, review the exact public-safe diff, synchronize through the linked project's controls, select `4 Academic Submission/main.tex` as the main document, and verify the compiler log and rendered PDF in Overleaf. Do not click either synchronization direction blindly: reconcile remote edits first.

## Latest handoff

Immediate next workflow: verify and pin the complete restricted Dropbox baseline, then prepare an owner-reviewable field-level public-release specification showing which fields are retained, removed, replaced or require disclosure review, together with their use in the existing analysis. No data transfer, removal or anonymization is implied by this planning step. After the specification and exact implementation scope are approved, use Stata MCP to create/test the derivative and separate restricted/public export routing, preserving historical samples, indices, model specifications and results during this privacy workflow. Handle already tracked sensitive files and historical exposure through separately authorized remediation; changing visibility is not part of the plan. Then continue scientific source/claim and exhibit reconciliation, study-specific ethics/rights review, full-text literature review and exact historical replication. LEGACY-A is author-selected; the full extracted manuscript and all 19,648 analysis-source lines have reading receipts, but the wider historical analytical package and estimates are not certified. Finding identifiers in the two close-read reports are report-scoped: use CR1/CR2 prefixes when citing overlapping P2-* labels. The current TeX record and metadata deliberately do not assert numerical validation, scientific completeness, journal compliance or submission readiness.

The built-in standalone compiler was rechecked after this policy update and again returned `Unable to find standard directories for platform`. This is an unresolved platform-level compilation failure, not evidence of a TeX syntax error. The source is preserved and queued for the built-in editor; PDF compilation and the live Overleaf main-document handoff remain unverified. No compiler was installed and no live settings were changed.

Research navigation is supplementary: Graphify does not natively detect these Stata `.do` sources as code, so a local navigation extract uses byte-identical text copies of the three authored Stata files only. It is not a lossless audit of all archives and cannot replace reading or execution.

No additional suite or plugin was installed; no commit, push, cloud synchronization, email, submission, or publication was performed. Continuing in this chat is sufficient because the persistent files carry the handoff; narrowly scoped delegated reviews may be used where the research orchestration skill calls for them.
