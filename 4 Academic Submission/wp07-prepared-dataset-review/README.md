# WP07 — E.5 access preflight and held dataset-build review

12 November 2026 · Source baseline `8cb6e7b893be95832404cfcd72d0d84599da0d01`.
E.5 render **held**. New preparation and analysis checks are **source-only**.
No ledger contents were opened, copied or hashed; no participant/model load,
Stata call, fit, permissions change, render, release or C2 activity occurred.

## E.5 access preflight

Read-only file and directory metadata for the exact [render contract](../wp07-e5-v3-restricted-render-contract/RENDER_CONTRACT.json).
All five named inputs are regular files, and their lengths match the recorded
seal: model status 415 B, probabilities 7,978 B, primary tests 584 B, native
matrices 206,609 B, support 7,871 B. Each file and the input directory list
only the owner, SYSTEM and BUILTIN Administrators on the observed DACL,
with inherited FullControl. Git ignores the five input paths and all four
reserved output directories. These are metadata findings, not byte-identity,
runtime effective-access, sync, or disclosure clearance.

| Surface | Observed | What must be resolved before use |
| --- | --- | --- |
| Input path custody | Ledger leaves are not reparse points. Their shared `Documents/GitHub` ancestor has Cloud Files tag `0x9000A01A`. | Establish whether these exact paths are in a sync scope and whether that custody is authorized; the tag alone is not proof of upload. If local-only custody cannot be established, stop and separately authorize any controlled relocation/rebinding. Confirm the actual native identity has traverse/read rights; do not grant broad read rights. |
| Reserved E.5 root `e5-v3-restricted-render-cec8bb3` | Root absent. Parent has inheritable Modify/Synchronize for `CodexSandboxUsers` and two unresolved SIDs, in addition to owner/SYSTEM/Administrators. The same Cloud Files ancestor applies. | Separately authorize provisioning a fresh non-synced private leaf with protected ACLs for root, exhibits, evidence and diagnostic. Keep existing parent ACLs unchanged. Verify only owner/SYSTEM/Administrators or a separately identified, approved minimum-rights writer; ensure native create/write and verifier readback, then verify inherited access on outputs. If the exact bound path cannot meet this condition, prepare a successor binding. |
| Provider log parent `C:/Users/jzava/AppData/Local/Temp` | No reparse point on this chain. DACL is protected from inheritance, but explicitly grants inheritable Modify/Synchronize to `CodexSandboxUsers` and one unresolved SID in addition to owner/SYSTEM/Administrators. The future session log was not created, opened or inspected. | Do not approve this route from directory metadata. Establish the exact execution identity, effective private log custody and capture/retention boundary, or rebind to a supported private route. No broad Temp ACL changes. A matching log filename or empty log would not rule out provider/middleware capture. |

Microsoft identifies this tag as [Cloud Files filter metadata](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-fscc/c8e77b37-3909-4fe6-a4ea-2b9d423b1ee4).
No sync account, remote copy, token or membership was inferred. The shell
principal matches the recorded owner; this is not an observation of the
Stata MCP worker identity. Unknown principals remain unapproved.

After the access findings are resolved, obtain a **fresh exact grant** for
five aggregate-ledger byte checks and one no-fit quiet render, restricted
readback and diagnostic verification. Keep the previously qualified producer,
17-output list, and no-retry rule. Stop on any path/ACL mismatch, hash drift,
unexpected provider route or incomplete output. No access decision for this
branch authorizes a participant dataset build, and vice versa.

## Actual Stata source review

[The exact two-file patch](held-source.patch) is against the held canonical
files. Revised full `.do` copies are materialized locally in the ignored
`audit-local/intake/package-e-restricted-20261112/wp07-prepared-dataset-review-8cb6e7b`
packet. The canonical master, preparation, analysis and E.5 producer
match their prior source pins. Earlier packets were left in place without
reopening restricted artifacts. Do not apply the patch
to the canonical files or remove holds as part of this checkpoint.

| Stage | Verified statically | Still needed |
| --- | --- | --- |
| Master → preparation | Exact same 98 projected names (92 numeric, six string). Preparation now requires a nonempty input, checks admitted N and a signature over all projected fields, and verifies a temporary row ordinal before dropping it. No new file operation, row filter, sort, raw write, imputation or sample rule. | Bind and validate the preparation-only caller. The existing held full master is not the route for this build: it proceeds to analysis after the save. |
| Form and measurement rules | 93 matching item/route/state names across five versions and 15 domains. Construction block is unchanged byte-for-byte, including 11 measurement candidates, E.4 groupings, and the two distinct digital engagement outcomes. The early/later additional-barrier option lists intentionally differ: code 1 is unavailable in the first form, and code 16 changes meaning. | Native assertions and checks of the final saved candidate; no inference of empirical coverage or measurement validity from matching source. |
| Analysis descriptions | All 93 item-report blocks unchanged. Added nonempty-input check and a guard that a recorded domestic operation bin must match the source answer and have an affirmative parent. Ordinary bins, uncertainty, applicable nonresponse and unresolved observations must together equal the affirmative-user base. No reporting denominator, bin, sentinel or percentage formula changed. | Artificial tests of the added guards; then compare each displayed denominator to its route/state and verify whole-cohort versus applicable/recorded/common-case distinctions. |
| Associations and E.4 | Input screens, pair/common-case associations, five approved commands, working robust VCE, fixed contrasts, fixed-six Holm and pre-fit stop unchanged. | Tie each reported claim to its exact approved native evidence. Existing E.4 ran the predecessor in memory; do not silently rebase those ledgers to the new saved candidate or infer a fit grant. |
| LCA, historical appendices and release | No segmentation or old estimator reactivated. C2 untouched. | LCA requires its own scientific disposition; exact-version institutional and disclosure gates remain separate. |

Source checks rejected the baseline for the two missing guard locations,
then passed on the successor. The baseline E.4 source checker passed;
the patch applies cleanly in check-only mode. The projected field set,
all construction logic, descriptive item-report block, model body and
all entry/fit stops were independently compared with the baseline.
No Stata parse, dataset signature, assert behavior or numerical output
was tested natively. This is not a final line-by-line empirical audit.
See [source fingerprints and verification status](VALIDATION.json).

## Next quantitative package — one preparation-only build contract

1. Bind the exact admitted carrier, unchanged 98-field projection, inherited
   manual exclusions, held successor source, and a fresh non-synced private
   destination with explicit access and retention. Reserve one native
   preparation-only selection. If saved-file readback is in scope, name it
   explicitly and count it separately from the carrier load. No master run
   that falls through to analysis, models, C2, or E.5 ledger access.
2. Prepare and, only under a distinct artificial-only grant, validate the
   changed guards: normal mixed-type projection; empty input; changed
   value or distinguishable row order; row-count drift; all four affirmative
   bin states; a missing/invalid bin or broken parent; and a zero
   affirmative base. Check intended failure without modifying research data.
3. Under a new exact participant-load and private-save grant, use Stata MCP
   to build only the restricted candidate. Require the inherited 423 rows,
   the exact raw and derived schema (source expectation: 98 raw + 224
   retained derived fields), unchanged projected values and row order,
   no new exclusions or identifying fields, and reconciled aggregate
   version/route/state and model-input coverage against the relevant E.3/E.4
   selectors. Check file metadata/labels/characteristics for disclosure
   without emitting records. Seal the candidate, schema, source lineage,
   Stata environment and receipts after successful readback; preserve failed
   attempts separately. Keep the temporary ordinal check independent of the
   [Stata data signature](https://www.stata.com/manuals/p_datasignature.pdf);
   neither signature nor post-save comparison substitutes for the ordinal
   while preparation is in memory.
4. Audit analysis in order: version-aware descriptions and their denominators;
   prespecified pair/common-case associations; fixed model masks, support,
   uncertainty and tests; exhibit-to-ledger parity and manuscript claims.
   Reuse accepted E.4 evidence only where lineage is established. Do not refit,
   choose a model by significance, or force revised outputs to match legacy.
   In parallel, carry the full legacy literature/Colombia context, coauthor's
   existing qualitative findings, expert/institutional analysis and regional
   benchmark into the manuscript without changing their evidentiary scope.

No steps beyond source and metadata review are granted by this handoff.
Nothing here clears institutional approval, repository exposure concerns,
coauthor/CFI review, an academic submission or public replication release.
