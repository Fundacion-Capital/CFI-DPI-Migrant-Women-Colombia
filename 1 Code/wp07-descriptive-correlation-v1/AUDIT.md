# Static audit — descriptive and correlation rewrite

Baseline: Git `326cee3`, with the prior academic-analysis draft already
untracked at entry. This pass adds one separate directory. It does not
replace a manuscript, preparation script, output, or earlier packet.

| Check | Result |
| --- | --- |
| Historical and prior draft bytes | 11 pinned files matched: three originals, three style-only copies, two preparation draft files and three first analysis draft files. |
| Section I figure inventory | All 44 export filenames matched the 44 Appendix D PNG names. This is a filename and custody check, not a comparison of rendered figures. |
| Selected historical exhibits | All 56 manifest entries matched size and SHA-256, covering the 44 PNGs, C/F heatmap pair, and table artifacts and previews for C1, C2, D1, D2 and F5. |
| Appendix field order | All 15 C2/F5 matrix headers matched the three new score lists in order. D1 and D2 matched all 14 item names each in exhibit order. |
| F5 long tables | Each ordered variable pair appears exactly once in the respective set of 120 oriented pair keys. Workbook rows are sorted by effect magnitude after calculation; the new Results stream is in source-loop order. The first sequence-order check failed for this documented reason; the corrected key-set check passed. The initial matrix text check also required whitespace normalization across `///` boundaries. |
| Academic preparation binding | All 16 referenced `wp07_*` names were found as definitions in the approved preparation draft. `eligible_flag` remains an inherited input, not a newly derived field. |
| Scope | Eight do-files start with `exit 198` and pass static command and brace checks. There is no file input, output, score rewrite, Stata fit, dependency installation or runtime activation. |

The historical Table 2/Figures 6–10 numerical receipt remains the previous
old-state replay; this audit does not repeat it. The revised scripts do
not yet have Stata parser evidence or a numerical-equivalence result.
No participant file was inspected or loaded, and no Stata calls were made.

Future artificial checks should distinguish three properties: (1) pairwise
overlap is larger than common support when candidates have different
coverage; (2) a constant pair and a one-category table have undefined
association, not zero; (3) a missing operation bin and an uncertainty
response can both be present among affirmative users without becoming the
lowest bin. Use an artificial copy, not edits to the sealed drafts, when
execution is separately authorized.
