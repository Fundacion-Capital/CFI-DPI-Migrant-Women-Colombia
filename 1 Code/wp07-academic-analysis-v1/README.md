# Academic Stata source revision: master and first descriptive block

These are **disabled drafts**, not changes to the historical analysis. Each
starts with `exit 198`. This first analysis block consumes two fields from
the existing [preparation draft](../wp07-academic-preparation-v1/README.md),
once that draft and its input have been separately verified and adopted.
It does not open the raw workbook or run historical stages. There are no
new dependencies, exports, scoring formulas, sample rules or fits.

## Source findings and decisions

Line numbers below refer to the untouched historical do-files at the audit
baseline. The existing Graphify index helped locate the script families;
the findings were checked against the do-file source.

| Historical source | What the source does | Revision disposition |
| --- | --- | --- |
| Master 39–49, 53–75 | Machine-specific username branches set globals; no unsupported-user branch. Both child calls are commented out and point to stale filenames. The package section can install code, including an unconditional scheme install. | Draft master replaces machine branches with two explicit arguments, requires the exact input and child file, loads only the two named fields, and calls the real descriptive filename. It neither installs packages nor runs the old stages. This is an operational correction, not a style-only edit. |
| Preparation 30, 992, 1011–1016, 2221–2223 | Imports the historical workbook; writes an audit carrier before the manual and coded exclusions; writes consecutive analysis and `NoPII` saves without intervening redaction. | Preserve exclusions and existing files. Treat both old coded saves as restricted; the filename is not a disclosure check. The separate approved preparation draft is the academic starting point, not either historical export by default. |
| Analysis 27, 1105–1118, 1946–1963 | Starts descriptives from the output copy; switches to the coded carrier for regressions and applies a blanket `q3` 5-to-1 recode there; LCA intake attempts one of two locations. | No alternate source and no blanket recode in the draft. Do not infer carrier equality or apply the academic geography definition retroactively. Verify sample/route provenance before regression or revised inference. |
| Analysis 5152, 6158, 6694 onward | A later feature-set step rewrites the earlier LCA-ready filename. Candidate fitting and saved outputs depend on stage order. | Preserve both historical states and candidate dispositions. A later modular rewrite must identify which stage consumes which state before changing file names, scopes or RNG order. |
| Analysis 8724, 8765–8775, 9770 onward | Preferred-final LCA loads a dedicated hybrid carrier and can create an observation-order key if the original key is missing. Subsequent profiling reads the saved segmented carrier. | No row-number substitution in a revised workflow. Verify stable-key provenance before any approved merge; do not reuse the old preferred class or promote a new one by syntax cleanup. |
| Analysis 16868 and 19499 onward | Report exports and appendix code use downstream segmented and index inputs; these are not interchangeable with the primary outcome variables. | Compare against named historical exhibits and disclosure-review each intended derivative. No exports or manuscript edits in this pass. |

## What the first descriptive block reports

- Remittance disposition (`q6_13`): the five accepted response categories
  when observed. No assumption about amount, actual channel, or percentage
  retained. The optional binary comparison is not substituted for this table.
- Domestic digital participation (`q6_14`): the accepted binary outcome for
  the preceding 60 days. Missing stays unscored, never recoded to no.
- Each outcome has a coverage table with the full admitted sample as
  denominator, followed by the valid count and a valid-answer distribution
  when there are valid answers. This is not a decomposition into the six
  D2 response states; that information must come from route verification.
  A Stata one-way table reports observed categories; the final exhibit will
  need explicit treatment of categories with zero observations.

## Verification and next source pass

The checks in this pass are static: verify the historical and prior draft
bytes, the declared input names, both execution stops, the single master
route, and the absence of writes, recodes or fits in the new draft. No Stata
parse, empirical result, or output-equivalence claim is made.

For a later authorized synthetic Stata check, use six rows with remittance
codes `1 2 3 4 5 .` and domestic codes `1 0 1 . . 0`: expect valid denominators
5 and 4 respectively, and two yes / two no for domestic participation.
Also check an all-missing outcome, an invalid nonmissing code, and a missing
input file. Do not remove the stops from these sealed copies for a test.

The next code pass is preparation-to-descriptive/correlation alignment. The
historical analysis has four distinct correlation paths; none should be
treated as interchangeable:

| Historical location | Source-level denominator |
| --- | --- |
| Line 231, IAT versus IADT | `pwcorr` for the two scores in the descriptive carrier. |
| Lines 3890–3913, clustering diagnostic long table | Counts available observations separately for each pair and runs `correlate` for that pair only when its count exceeds two. |
| Lines 3974–3980, continuous matrix | One `correlate` over the available variable list, using one complete-case sample. The workbook name contains “pairwise,” but the matrix sheet is not the pair-specific table. |
| Lines 19499 and 19530–19544, Appendix C matrix | One `correlate` over the appendix list, after loading the segmented carrier. The CSV export writes the coefficient matrix, not its complete-case N. |

Trace each displayed historical exhibit to its actual carrier, variable list,
and missingness convention before rewriting its reporting code. Record both
the actual N and the denominator rule in future outputs. The
[`WP04-CORR01` provenance gap](../../4%20Academic%20Submission/WP04_SCIENTIFIC_FOUNDATION_SYNTHESIS.md)
remains open; the source inventory is not an observed-data comparison.
Then draft model-specific input checks before specifying regression
contrasts, and review LCA and downstream reporting separately. D4/D6 model
nominations, covariance choices, candidate selection and release are not
resolved by this source pass.

Technical references: Stata's [programming if](https://www.stata.com/manuals/pif.pdf),
[argument verification](https://www.stata.com/manuals/pconfirm.pdf),
[correlation and missing-value conventions](https://www.stata.com/manuals/rcorrelate.pdf), and
[local macro scope across do-files](https://www.stata.com/manuals/pinclude.pdf).
