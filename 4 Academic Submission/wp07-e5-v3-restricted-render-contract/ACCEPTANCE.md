# Restricted E.5 acceptance — apply only after the separate grant

All row counts below are structural expectations from the sealed schemas
and qualified producer, not a claim that the current ledger bytes were
inspected. Use a local CSV reader and typed comparisons on the actual
five authorized ledgers. Never use the artificial model Ns, estimates,
ordering fixtures or fixed adverse-value examples as production targets.
Do not emit cell values in terminal, chat, or Git logs. Preserve a private
key-by-key reconciliation and machine-readable failure disposition.

| Output and expected data rows | Exact reconciliation |
| --- | --- |
| QT1 models, 5 | The exact five accepted model IDs in order R0, D0, R1, D1, R0C. Model labels and roles as specified; intended and estimator N equal the source fields, not cohort N. Check fit/attempt/convergence/rank/sample status from the source ledger, not reconstructed estimates. |
| QF1 core, 6 | Only R0_E4/D0_E4 `higher_minus_lower` rows; each model's IAT, IADT and IAFF in that order. Compare N, estimate, SE and both interval bounds to the exact model/focal/record source. Percentage points, not fractions. |
| QT2 primary, 6 | R_IAT/R_IADT/R_IAFF then D_IAT/D_IADT/D_IAFF. Exact slot/model/field/status and p_raw/p_holm values; join model N. Derive rank independently by sorting ascending (p_raw, slot), including ties, as the E.4 source does. Compare stored rank and the cumulative maximum of (7-rank)×p_raw capped at 1. This checks an existing adjustment; no new test or p-value. |
| QS1 comparisons, 15 | All five models by all three focal fields, `higher_minus_lower` only, model/focal order as above; match exact status, N, units, increments, estimate, SE, bounds and zero relation. QF1 is the exact six-row projection, not a separate significance family. |
| QS2 endpoints, 30 | All five models by all three focal fields and both endpoints in lower/higher order. Fixed lower .50; high .75 for IAT/IADT and 1.00 for IAFF. Match estimate/SE/bounds, model N, availability and probability units. Values outside [0,1] in **bounds** are not clipped; predicted estimates remain in [0,1]. |
| QS3 coefficients, 74 | Match every `fit/e4_B` cell by model/column index and term identity, and its `fit/e4_V` diagonal by both labels. Confirm 12 reference constraints with zero b/v and absent SE/bounds. Other rows have v>0, SE=√v and bounds b±1.959963984540054×SE. These are reporting arithmetic only. No fabricated fit diagnostics or new tests. |
| QS3 covariance, 1,154 | Match every `fit/e4_V` cell by model/row/column and both labels, with three 12×12 and two 19×19 grids. Verify square key coverage, matching symmetry and native value; do not “fix” or zero any cell. |
| QS3 support, 186 | Exact model/check/field/level/outcome key coverage, preserving structural missing levels/outcomes and min/max. Match n and values to E.4; counts must be whole and within model-specific N. |
| e5_complete, 6 | Exact order and status `COMPLETE` for QT1/5, QF1/6, QT2/6, QS1/15, QS2/30 and QS3/74. This marker never replaces independent comparison. |

Before comparisons, enforce five source row×column shapes: model status
5×12, probabilities 45×10, primary tests 6×7, matrices 2262×8 and support
186×8. Require exact schemas per source/read statements, unique keys,
all required cells present and finite, no blank-to-zero conversion.
Output schemas follow the producer's exact named export columns. Treat
empty and Stata numeric missing as missing only in permitted fields;
never equate them with zero. Compare IDs, labels, order, counts, statuses,
reference flags and null placement exactly. Retain original input bytes.
For full-precision numeric pass-through compare parsed finite doubles
exactly or within 4×binary64 epsilon×max(abs(source),abs(output)), no
absolute floor; separately require exact sign and exact zero when applicable.
For independently computed QS3 SE/bounds and Holm arithmetic allow
`1e-12 × max(1, abs(source), abs(expected))` on finite numbers, still
requiring exact missing/reference/status rules. For display, independently
apply the producer's declared decimal rendering to the already accepted
underlying numbers. Do not round first to decide whether an interval includes
zero: use the actual bounds (`ll <= 0 && ul >= 0`).

Check the 17 names exactly as bound: nine CSVs, five TeX fragments,
QF1 PDF/PNG and CAPTIONS.txt. No other entries, subdirectories, links or
empty files in the exhibit directory. Check every displayed QT1/QT2 and
QS1–QS3 row against its accepted CSV. Verify probability/pp/p-value decimal
rules, the `<.001` convention, near-zero bound notes, no stars/clipping,
reference labels and all six captions/limitations. Check QF1 PDF and PNG:
two panels, six points, endpoints and intervals correspond to the six
actual rows, visible zero reference, shared axes and labeled units, adequate
spacing and no clipping. Do not require byte-equal graph formats.

Copy the pinned wrapper byte-for-byte to the bound private diagnostic
directory after authorization. Compile with installed pdfLaTeX, no shell
escape, at most three passes, saving each pass's log and auxiliary file.
Require stable final auxiliary state, zero final compile warnings/errors/
overfull boxes, and no visible clipped rows or missing glyphs. Record
underfull and rasterizer notices. Run the pinned saved QS2 layout checker:
30 data rows in the correct order, repeated header and data on every QS2
page, one note on the final data page. Inspect every page, QS3 continuation,
and both QF1 formats. Do not require the empirical wrapper to have the
artificial case's exact page count. Review captions for the two distinct
outcomes, pointwise uncertainty, conditional working VCE, no extrapolation
or inferred effects. Report no acceptance unless the entire gate passes.
