# Documentary comparison readiness audit

Base: `16c7f07`. No Stata calls, participant file reads/hashes, fitting,
original changes, staging or push. This is a source and target audit,
not a numerical comparison.

| Check | Result |
| --- | --- |
| Prior packets | Ten source-seal members and three artificial-validation seal members matched; the untouched historical analysis SHA-256 matched its baseline. |
| Block boundary | Six exact disabled sources matched; 57, 43, 2, 15, 31 and 9 source field names matched their respective projections in blocks 01, 02, 04, 05, 06 and 08. Blocks 03 and 07 are not historical comparisons. |
| Archive locators | Three restricted files resolve with recorded sizes. Old37 matches the accepted replay binding. The two downstream identities match the restricted archive manifest and the clustering target catalogue, with prior schema receipts for N=423. Metadata only; no fresh carrier content check. |
| Targets | 56 public artifact size/SHA pins matched: 38 broad descriptive PNGs, six current reference PNGs, and 12 Appendix C/D/F files. All 13 inherited block 08 target/control pins matched; one is the public comparison-rules CSV. |
| Numeric target keys | C1: 15 rows match the actual truncated keys in source order; C2: exact 15 labels on both axes; D1: 67 rows, 14 item keys, no N column; D2: 14 dummy keys and an N column. |
| F5 saved workbook evidence | Four exact sheets with 120, 15, 120 and 24 data rows. Workbook digest matched; this check used the saved sheet catalogue, not a new typed-cell read. |
| Missing provenance | The current Section I output-copy alias is absent. Multiple archive candidates are retained as candidates only. No authenticated standalone historical line 231 target was identified in the reviewed source/coverage and saved handoffs. |

Precision inspection of the public aggregate CSVs found that actual
decimal tokens can be finer than the Stata display format (e.g. up to 16
places in the first C2 record). Do not compare a Results-window rendering
or impose a blanket three-decimal tolerance. Capture the underlying Stata
aggregates and bind conversion and field-specific tolerances in the next
exact execution contract; preserve the original numeric strings.

Two initial static checks stopped on verifier assumptions: the inherited
target list includes the public comparison-rules CSV, and the clustering
catalogue names its path column `source`, not `file`. The corrected,
exact-scope checks passed. No historical file or binding evidence was
changed to make either check pass.
