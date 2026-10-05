# Historical-input contract: pre-estimation checkpoint

Status: bounded source/instrument/order checks completed; **M0 and the M1/M4/M5/M6 scientific gates remain open**. Entry: clean `main@c4be81ad1d5f1ff7be8aa0feffc42fd43e28c63e`, 5 October 2026. This document is a preparation record, not a revised analysis or approval to release data.

The author-selected full manuscript labelled 31 July 2026 remains the foundation. The M0–M13 sequence and all 124 primary task IDs remain unchanged. Qualitative inputs and every historical measure, exclusion, regression, LCA specification and result remain untouched.

## 1. Source roles and permitted use

| Preserved state | Verified role | Boundary |
|---|---|---|
| Refreshed raw export: 490 submissions, 267 columns | Recovers every audit and coded submission key; all 263 shared non-time fields agree with the audit across 128,870 cells | Not interchangeable with historical timestamp values; no silent repinning |
| Historical audit dataset: 490 rows, 266 variables | Preparation saves this state before deriving `fecha` and applying exclusions | Preserve original clocks and original row positions; not a newly anonymized dataset |
| Stored coded datasets: 423 rows, 439 variables | Exactly reproduced membership under the unchanged four sequential restrictions; regular and NoPII-labelled versions agree across all 185,697 cells | Both retain genuine contact information; filename is not disclosure certification |
| Four newly supplied legacy spreadsheet definitions | Match the four previously unmatched submitted form versions | Version labels establish archive coverage, not measurement equivalence or independent deployment certification |

The existing read-only [Stata reconciliation helper](tools/surveycto_reconciliation.do) runs only through Stata MCP, in an isolated named session. It writes aggregate/schema receipts into ignored `audit-local/`; it does not save respondent records, run estimators, invoke the historical master or change source files.

## 2. Corrected original-order evidence

The previous “489 changed positions” conclusion is **superseded**. Its diagnostic compared `frlink` indices with the master row number. Those indices address a sorted reference frame, not the reference file's original physical positions.

The corrected helper captures positions in disposable copies **before** any linking and fetches the captured reference position explicitly. A reverse-key synthetic fixture demonstrates why link indices and original positions differ. Separate full-cohort, subset and shuffled-subset assertions protect the correction.

| Comparison | Matched keys | Original absolute-position differences | Relative-order differences |
|---|---:|---:|---:|
| Refreshed raw vs. preserved audit | 490 | 0 | 0 |
| Earlier 120-row raw vs. preserved audit | 120 | 0 | 0 |
| Audit vs. retained coded sample | 423 | 422 | 0 |

The last comparison is a subset: exclusions change absolute positions, while retained ordering agrees. Fourteen keyed project downloads were also checked against the audit; both full 490-row downloads preserve the original order. One additional similarly named download lacks the required key and is not accepted as a full raw input.

This corrects an audit diagnostic only. It is not evidence that any stochastic estimator has been reproduced.

## 3. Clock contract and unresolved provenance

For all 490 matched submissions, each of `SubmissionDate`, `starttime` and `endtime` in the refreshed raw is approximately **6 hours plus 36 seconds** ahead of the audit. Rounding diagnostic copies to the nearest millisecond does not remove the difference or the observed calendar-day changes: 153 submission dates, 146 start dates and 153 end dates differ. Rounded elapsed start-to-end durations agree.

None of the fourteen keyed downloaded exports recovers the audit timestamps exactly. Some exports have different constant second-level offsets, so a whole-hour timezone adjustment cannot be assumed to explain the complete discrepancy. The generated SurveyCTO Stata import template is an additional provenance document, not proof of execution of the authored Excel preparation script.

The authored preparation directly derives `fecha=dofc(SubmissionDate)` at lines 1007–1008. The current scoped source inspection finds no other explicit authored uses of those three timestamps or `fecha`; macro/transitive dependency review remains required and this statement is not a full dataflow certificate.

SurveyCTO documents that exports express datetimes in the exporting computer's timezone and that export reports record export context and form versions. These are possible mechanisms and relevant recovery sources, **not proof of this project's cause**. [Export format](https://docs.surveycto.com/05-exporting-and-publishing-data/01-overview/09.data-format.html), [export reports](https://docs.surveycto.com/05-exporting-and-publishing-data/01-overview/09b.data-export-reports.html). Stata documents sub-millisecond Excel conversion/display effects; the executed synthetic and actual-data checks distinguish that jitter from the genuine multi-hour difference. [Stata datetime guidance](https://www.stata.com/support/faqs/data-management/excel-datetime-value-behind/).

The owner confirms that the export reports/settings no longer exist. This evidence-recovery request is closed as unavailable, not as a successful reconstruction of the clock. Freeze the preserved audit/coded clocks and bytes as the reference states actually stored by the historical workflow; retain the refreshed raw as a separate recovered source. A future protected replay may validate the preserved intermediate/coded states, but cannot claim exact raw-to-audit timestamp reconstruction. Do not invent a conversion, silently repin an input or relabel a transformed export “original.” Record this limit in M1/M6 and the eventual replication documentation.

## 4. Complete submitted-version spreadsheet coverage

| Recorded form version | Submitted forms | Matching spreadsheet definition |
|---|---:|---|
| 2512090157 | 2 | Recovered and hash-pinned |
| 2512091719 | 2 | Recovered and hash-pinned |
| 2512111044 | 7 | Recovered and hash-pinned |
| 2512121811 | 474 | Recovered and hash-pinned |
| 2602120658 | 5 | Current supplied definition, hash-pinned |

All five `form_id` values match the quantitative project. Two additional definitions, 2602160713 and 2511101752, are not recorded submitted versions and must not be promoted to authority merely by filename, modification date or larger version number.

Seven definitions were inspected across all six workbook sheets (42 sheet imports). Checks include schema, key-aligned field definitions, full-row multiset comparisons and choice-list comparisons preserving duplicate multiplicity. Field-name alignment prevents inserted rows or paired opening/closing group names from being misreported as wholesale question changes. SurveyCTO warns that latest definitions shape exports even when records were collected under earlier versions. [Updating forms](https://docs.surveycto.com/02-designing-forms/01-core-concepts/10.updating.html), [export options](https://docs.surveycto.com/05-exporting-and-publishing-data/02-exporting-data-with-surveycto-desktop/02.export-options.html).

Important differences are now explicitly queued for M4/M5, not automatically corrected:

- The first two used versions have 17 fewer named fields: conditional “other—specify” text fields added later. Treat their absence as version-dependent instrument availability, not automatically respondent nonresponse or a zero.
- Geography option 4 means **Other** in those early versions and **Soacha** later. The retained coded sample contains an affected version/code combination. Preparation line 1019 applies the later city labels globally; the measurement audit must reconcile version-specific meaning before any recoding or interpretation decision.
- Several early choice lists differ beyond geography; the private change ledger records every affected list and duplicate-preserving row counts.
- The contact-number field changes from integer to text. This is instrument/protection provenance, not authority to change scientific outcomes.
- The dominant submitted version and current definition have identical complete survey rows; their choices differ by the later added geography option. This does not make all earlier versions equivalent.
- Existing duplicate `ws` choice codes remain documented and unchanged.

Matching archived spreadsheets does not independently certify historical compiled XML, attachments, device deployment or all fieldwork procedures.

## 5. Input, dependency and RNG boundaries

The three authored Stata files and four manuscript pins remain byte-identical. The master declares version 16 and seed 6427961, configures project directories and vendored PLUS, but its two dispatch lines are commented legacy IFC filenames. It also contains package-install paths; it was not run.

The analysis loads an output coded copy at line 27 and the Dropbox coded copy at lines 1105–1106; the LCA intake uses a preferred coded path with an output fallback. The final H1_k4 block already sorts `KEY`, captures sortseed 6529004, resets seed 6529004, and declares 600 random-start draws and 8,000 iterations. These source settings were inspected, **not changed or executed**.

The isolated probe resolves the actual command paths, ColrSpace library and plotplain scheme with project PLUS. `palettes` and `colrspace` are package/library-family names, so failure to resolve an ado command with those names is not proof the installed functionality is missing. Actual palette commands/library resolve. No package was installed or updated. Stata 19 IC is the current runtime; source `version 16` is not proof of replication under an original Stata 16 executable.

The native helper handles bytes, source-text locators and receipts only. All respondent-cell, form-cell and statistical checks use Stata MCP. The existing private Graphify map is supplementary, code-only navigation, not runtime or exhaustive dependency evidence.

## 6. Checkpoint and next bounded work

| Child / gate | Current disposition |
|---|---|
| M0.06i.2–i.4: key coverage, non-time cells, historical restrictions | CHECK_PASS within stated scope; not sample/measurement approval |
| M0.06i.5: original export-clock authority | Limitation disposition recorded: owner confirms reports/settings unavailable; offset/rounding/duration checks pass, causal reconstruction remains unverified |
| M0.06i.6: original sequence diagnostic | CHECK_PASS after correcting the link-index error; estimator/RNG reproduction pending M6 |
| M0.06i.8: exact submitted-version spreadsheet recovery | ARCHIVE_CHECK_PASS; cross-version semantics explicitly handed to M4/M5 |
| M0.06h: field and transitive analytical dependencies | REVIEW_REQUIRED; source locators and critical routing inspected, not exhaustive semantic certification |
| M0 privacy, ethics, rights; M1 historical baseline; M4/M5/M6 scientific gates | OPEN; no parent milestone declared complete |

The next immediate work is the version-aware measurement/dependency register, starting with geography, structural missingness and every changed early choice list, followed by the protected historical replay contract with the recorded clock limitation. Only then refresh the anonymous-field proposal and obtain its exact implementation authority. Revised estimates remain behind M7.

Private receipts, exact paths, restricted form text and hash manifests remain in ignored `audit-local/intake/input-contract-c4be81a/`. Source retention checks cover 698 entry archive occurrences, seven code/manuscript pins, 20 project downloads, four newly added definitions and 36 selected restricted-source pins (765 overlapping checks, not 765 distinct files). All pinned source bytes are unchanged. Remote checks cover new definition identity/path/size metadata, not remote payload SHA-256.

Existing public Git/history exposure and protected temporary read-back housekeeping remain unresolved. No original data, analysis, qualitative content, sharing control, visibility, Git history or live Overleaf state was changed. Nothing was staged, committed, pushed or released.

