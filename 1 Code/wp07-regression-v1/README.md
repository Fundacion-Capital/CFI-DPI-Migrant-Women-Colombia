# WP07 — disabled historical regression revision v1

Prepared 5 November 2026. This is a **source-review and writing pass**, not an
executed analysis or an adopted academic specification. Every do-file's first
executable command is `exit 198`. Existing masters do not call these files.

| Draft | Preserved historical source lines | Scope |
|---|---|---|
| 01 Historical regression setup.do | 1112–1236 | Historical geography pooling, eight binary helpers, fifteen standardizations, labels and original graph/directory setup |
| 02 Historical main regressions.do | 1248–1693 | Nine families × five fits, raw tables and nine coefficient/AME figures |
| 03 Historical interactions.do | 1705–1826 | Four interaction fits, original percentiles, grids and four figures |
| 04 Historical supplementary regressions.do | 1839–1895 | Seven binary logits in the original supplementary-table order |

Source: `1 Code/2 Analysis_CFI DPI Migrant Women Colombia.do`, SHA-256
`714377ca31de2b6d70db0994e3c7ef6a38374165d7b1fb7c7abeb3b3f56549c9`.
The original regression section declares **version 19**, despite the older
file header referring to Stata 16. These drafts retain the actual section
directive; no version migration was performed.

## What changed

- Expand `reg` to `regress` and write the actual predictor lists at every
  equation instead of hiding them behind global control blocks.
- Use short explanatory comments, explicit schema checks and readable
  continuations. No helper program, loop, fallback input or automatic retry.
- Repeat the three graph-colour locals in the two files that use them.
  Their values no longer depend on locals created by a different do-file.
- Remove redundant outer grouping braces and now-unused control globals.
  This changes the review-copy interface, not the preserved equations.
- Add an unconditional stop. No active master or execution adapter is supplied.

The [model register](../../4%20Academic%20Submission/wp07-regression-source-review/MODEL_REGISTER.csv)
records all 56 source equations, required model fields, source lines, stored
results, table columns, figure references and margins commands.
The [review report](../../4%20Academic%20Submission/WP07_REGRESSION_SOURCE_REVIEW.md)
separates historical choices from the accepted D2/D3/D4/D6 academic direction.

## Deliberately preserved, not endorsed

No outcome, response mapping, missing-value condition, score, standardization,
predictor order, covariance option, factor reference syntax, margin grid,
table cell, label, star rule, estimate name or figure setting was repaired.
The historical code-5-to-code-1 residence pooling remains in setup.
Several raw and standardized equations differ in predictors. The formal
remittance fifth fit supplies posted AMEs, not another odds-ratio table.
The interaction percentiles precede fitting and therefore are not fitted-sample
quantiles. I4 uses fixed values even though its setup computes percentiles.

These are **historical** labels and output semantics. They are not new claims
that old composites are validated constructs, that a receipt channel is the
academic remittance-use outcome, or that robust VCE solves referral dependence.

## Future input and output boundary

No data file is loaded by these drafts. A separately authorized caller would
have to verify the exact historical coded carrier and its projection, then
the literal setup and the named model-specific fields. Do not substitute
TARGET33, the final segmented carrier, a current output copy, or academic
prepared fields simply because names overlap. Input identity and permission
are not established by these source files.

`output_dir` is intentionally not assigned here. Historical table/graph writer
commands remain in the disabled bodies for audit; future execution must bind
a **new restricted scratch root**, including directory creation, TXT sidecars,
temporary files, package preference writes and estimate bookkeeping. Never
point them at the existing online appendix. Do not remove these stops to run
a full 56-fit batch: there is no such execution authority.

No analytical dataset is saved, but the historical setup would modify fields
in memory and the historical output writers would write files if a future
caller activated them. The stops are accidental-execution guards, not an OS
sandbox or proof of anonymization.

## Static verification only

The file-only audit checks full command order after literal macro expansion,
all numerical formulas and output commands, the 56-fit/5-margins inventory,
the 47 table-column writes and 13 graph exports, required-field coverage,
disabled preambles, 22 preserved source/navigation files and 35 archived
aggregate targets. It does **not** parse Stata, fit anything, compute N,
verify actual coefficients, inspect participant records or render figures.

Appendix C2 and protected runtime execution remain on hold.
