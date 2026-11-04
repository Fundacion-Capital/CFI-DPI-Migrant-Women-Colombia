# WP07 block 05 — artificial Stata MCP validation

**Passed on 4 November 2026 in Stata 19.** This validates the sealed Appendix Table C2 emitter and receipt transport on invented data, not historical coefficients or the historical complete-case N. The emitter on disk is unchanged and still disabled.

| Check | Observed result |
| --- | --- |
| Scope and isolation | Fresh non-default MCP worker; empty on entry. The executable selection omitted only the dormant `exit 198` line from the sealed emitter, with line endings normalized. All 423 artificial rows were generated in memory; Stata opened no data files. |
| Listwise N | Exactly 15 numeric variables; ordinary and extended missings exclude seven distinct rows, including an overlap. Native `r(N)` and the independent all-fields count both returned **416**. The first pair had 420 usable rows, so this fixture distinguishes listwise from pairwise deletion. |
| Matrix and transport | All **243** records arrived in order: 1 begin, 1 N, 15 axes, 225 binary64 cells, 1 end. The unchanged offline reader accepted the receipt. Stata checked all 225 native values against an independent formula for the balanced nested indicators, checked that all 210 off-diagonals differed from their three-decimal rounding, and confirmed the input signature was unchanged. Two extra native hex witnesses matched the corresponding transported cells bit for bit. |
| Expected failures | The dormant guard stopped with `r(198)`; a 16th field stopped with `r(459)`; an abbreviated lookalike in place of the exact required name stopped with `r(111)`. No failed selection emitted a receipt. |
| Custody and cleanup | All exact selections and raw responses retained in the ignored local audit packet. The named worker was cleared, confirmed empty, destroyed and absent on readback. The default session record was unchanged; no preexisting worker was used or destroyed. Original source, target and predecessor packets were verified unchanged. |

On complete rows, unsigned indicator `j` is one for `j` of every 16 positions. For indices `i,j`, let `lo=min(i,j)` and `hi=max(i,j)`. The analytic reference used in Stata was `(-1)^(i+j) * sqrt(lo*(16-hi)/(hi*(16-lo)))`, including 1 on the diagonal. The synthetic matrix was deliberately not compared to the historical CSV.

The artificial validation passed. A protected comparison still requires separate authorization for the exact carrier, restricted output destination and one bounded run; it cannot verify the archived complete-case N because the archive does not report it. No participant file was inspected. No fitting, Git staging, commit, push or release occurred.
