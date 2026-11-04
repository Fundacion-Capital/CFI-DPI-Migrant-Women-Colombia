# Historical denominator and comparison rules

All fields below retain their **stored historical values**. No general
recode of 98/99, unknown categories, blank dummies, extended missing
values or group bins is permitted.

| Block/target | Denominator and acceptance rule |
| --- | --- |
| 08, Table 2 counts | Complete `ivs_cat`/ `iat_cat` pairs; percentages within IVS rows. Compare nine counts, margins and rounded percentages. Keep the legacy 47.96% versus source-count 47.92% discrepancy as a preserved exception, not an acceptance threshold change. |
| 08, Table 2 means | Valid `iat_score` within each recorded IVS category, independently of the two-category table. Compare to the retained textual means, record exact equality and differences, and carry the prior diagnostic bound `1e-8 + 1e-6 × abs(target)` without widening. |
| 08, Figure 6 | Nonmissing legacy IVS score; compare 20 declared half-open 0.05 bins with 1 included in the last bin and outside-range/missing separately. These are audit bins, not recovered renderer defaults. Legacy embedded Figure 6 is the percent variant. |
| 08, Word Figures 7 and 8 | Figure 7 conditions on age category (source file fig8); Figure 8 on historical residence (source fig7). Use joint nonmissing cases and compare within-group counts and printed shares. |
| 08, Figures 9 and 10 | Device type conditional on internet-frequency group; data interruption counts valid-coded values including explicit 99/N/A, excluding Stata missing. Preserve legacy printed labels and known differences from the newer images. |
| 02, C1 | Each score's own nonmissing N; mean, sample SD, min, p25, median, p75 and max. Bind 15 rows by source order and verified truncated index key, not guessed full strings. |
| 02, D1 | Each item's numeric nonmissing N; reconcile the exact category counts and their total per item. Numeric sentinels survive unless already coded missing. N is reconstructed from the archived complete category rows, not an independent count column. |
| 02, D2 | Per dummy: count equal to 1 over its nonmissing count. Preserve overlapping selections and any encoded zeros. Do not claim this is question applicability. At N=0 there is no share. |
| 05, C2 | One complete-case N across the fixed 15 scores. Compare matrix labels/order and all numeric cells. Record the fresh N; no archived target N is asserted from the CSV. |
| 06, F5 Pearson | Pairwise nonmissing N for each of 120 oriented pairs across 15 scores plus `formal_remittance`. Require N>2 and support before interpreting rho. Compare rho, absolute rho, threshold .50, and declared theory flags separately. |
| 06, F5 matrix and heatmap | Listwise across the 15 scores **without** `formal_remittance`. Compare workbook matrix cells, not heatmap pixels; report the common N without assuming it was recorded in the workbook. |
| 06, F5 Cramér's V and flagged sheet | Pairwise nonmissing N for 120 oriented pairs across 15 categories plus `formal_remittance`. Compare observed rows/columns, chi-square, p and V only where defined. A degenerate dimension does not yield V=0. Compare threshold .30 and theory flags; union the flagged keys with association type. Preserve the difference between original error capture and the draft's explicit degenerate-table guard. |
| 04, line 231 | Pair-complete historical `iat_score` and `iadt_score`, Pearson r and its original significance output; report N separately. Target not found; do not substitute a matrix cell or figure. |

## Block 01: held figure-level qualification

The pins cover each archived image; the prospective numerical bases below
are **not** claims that a plot's hidden numerators, denominators or original
producer are recovered. Use the original command and exact rendering or
numeric evidence when making a future displayed-value claim.

| Source figure numbers | Prospective numeric target |
| --- | --- |
| 1–5 | Individually observed age, residence, historical calendar gap, education and occupation. Compare distribution counts where recoverable; density and bins require the exact original parameters. |
| 11–15 | Transfer and QR category counts; IADT mean by IAT category; ICDP within age category; ICDP mean and original CI by education excluding code 1. Do not substitute 12 for 04. |
| 16 | Last selected account product wins in source order; each exclusive count divided by fixed 423, not by holders or nonmissing dummies. |
| 17–20 | IAFF within historical tenure category; IAFF mean and original CI by education excluding code 1; IUOF nonmissing distribution; IUOF within `iaff_cat`, not newly computed terciles. |
| 21–24 | Rail dummy-specific nonmissing means ×100; OQI grouped by IAFF and ICDP; receipt-channel counts over literal `q6_4 != .`. That predicate is not the D1 nonmissing convention. |
| 25–30 | Nonmissing IETR; IURD within OQI; safety within historical fraud-exposure flag (outside codes 1–3 is not verified unexposed); IEDF grouped by OQI and ICDP; satisfaction excludes literal system missing and 98, not all extended missing. |
| 31–34 | Nonmissing IAER and group-wise valid outcomes for legacy means/SEs; divide stored scales by 100 where the source plots them. Preserve the historical interval construction separately from mean/SE checks. |
| 35–37 | Legacy ranked barrier, enabling-support and training-topic counts divided by 423. Figure 35 omits missing and 98 before ranking. Figure 36 aliases do not consistently describe questionnaire options. Do not infer a missing tie rule or adopt its labels. |
| 38–39 | Both-field group counts for IBPD by IVS and by IAT; verify the original graph percentages separately. |
