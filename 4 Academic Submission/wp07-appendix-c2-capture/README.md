# WP07 block 05 — historical Appendix C2 capture contract

Prepared at `2e20c61`. This is a disabled, no-load, no-fit package for **Table C2 only**. It does not authorize a Stata call, file load, projection export, or release.

## Exact source, input and denominator

- Historical producer: [`2 Analysis_CFI DPI Migrant Women Colombia.do`](../../1%20Code/2%20Analysis_CFI%20DPI%20Migrant%20Women%20Colombia.do), lines 19499, 19501–19504 and 19530–19545; SHA-256 `714377ca31de2b6d70db0994e3c7ef6a38374165d7b1fb7c7abeb3b3f56549c9`. The producer takes `r(C)` after unweighted `correlate`, converts the matrix columns to doubles, and exports the CSV. Its `%9.3f` display format is not the precision of the saved CSV.
- Bounded predecessor: [`05 Historical appendix C2 matrix.do`](../../1%20Code/wp07-descriptive-correlation-v1/05%20Historical%20appendix%20C2%20matrix.do), SHA-256 `4e7814e1b4f5a052cca1e45eb2d45cfc86c162cec0337f7bf04e073df24f4938`; [`BLOCKS.json`](../wp07-historical-descriptive-correlation/BLOCKS.json), `blocks.05`.
- Input: the **sealed final-segment carrier**, not the LCA-base carrier. Resolve only `carrier_bindings.final_segments` in the sealed private parent through this packet's restricted binding. The expected size is 1,824,317 bytes and prior schema evidence records 423 rows. Only the locator and size were checked here. A future authorized run must verify the recorded byte hash, admit only the fields below with their native storage and missing values, preserve row order, and leave the source untouched. No joining, filtering, recoding, recomputing, or alternate carrier is permitted.

Exact case-sensitive field list in command and matrix order (only these fields may enter the Stata session):

```text
ivs_score iat_score iadt_score icdp_score iaff_score iuof_score_01 oqi_score_01 iurd_score_01 ietr_score_01 IPCS IEDF IAER ICPF IEH IBPD
```

Use one unweighted Pearson matrix with **one listwise denominator**: only rows nonmissing on all 15 fields contribute, including exclusion for any Stata extended missing value. No pairwise deletion. Save native `r(N)` and compare it to an independent all-fields `count`; both must agree and be between 2 and 423. The 423 is the expected input size, not the complete-case N. The archive reports **no historical complete-case N**, so that denominator cannot be independently matched to the exhibit.

## Native capture and readback

[`05 C2 capture.do`](05%20C2%20capture.do) is stopped by `exit 198` and contains no loader or writer. Once separately activated in a reserved, isolated session, it checks exact numeric field membership, saves native `r(C)` before any further r-class command, validates its dimensions and row/column names, and checks that the in-memory data signature is unchanged before emitting its end marker.

Keep the exact Stata response: one begin record, one N record (carrier N and both complete-case counts), 15 ordered two-axis records, 225 ordered cell records, and one end record: **243 `C2|` records**. Cell payloads are Stata `%16H` values (16 hex digits, big-endian IEEE binary64). Store this unrounded payload, not a screenshot, `matrix list` rendering, triangle alone, or rounded decimal export. Require intact transport, a successful native return/receipt and a separately proven carrier/projection before accepting any comparison. The offline reader does not establish those execution facts.

## Immutable target and comparison

The numeric target is [`Table_C2_Index_Correlation_Matrix.csv`](../../3%20Research%20Paper%20Online%20Appendix/C%20Variable%20Construction/tables/Table_C2_Index_Correlation_Matrix.csv) (4,140 bytes; SHA-256 `94abf6b1bf291f923ad7f03486099cb42dac90dba9f6d1ab5d5abe0f185eefff`). Its Markdown preview is display-only. **Figure C2, Figure F5 and every other block are out of scope.**

[`compare_c2.py`](compare_c2.py) compares the 225 keyed cells, both triangles included. It rejects a changed target fingerprint, incorrect axes, incomplete/duplicate/reordered capture, a native Stata error, inconsistent N, non-finite or out-of-range correlations, an inexact unit diagonal, or a nonsymmetric matrix. The target itself must have the exact two axes, literal `1` on the diagonal, and matching decimal tokens across the diagonal.

For off-diagonal target token `t` with `d` fractional digits, compare the exact rational value represented by the captured binary64 cell to the exact decimal value of `t`. Accept at archived precision only if the absolute difference is at most half the last decimal unit: `5e-16` for 15 digits or `5e-17` for 16 digits, endpoints included. The diagonal requires exact `+1`. Within this bound, distinguish `roundtrip_equal` (same bits as the nearest binary64 value obtained from `t`) from `decimal_compatible` (a different binary64 value within the same bound). Neither recovers or establishes equality to the unavailable historical native matrix. This is the specified comparison rule, not proof of the original CSV exporter's rounding policy.

Report every cell with both axis names, original token, exact captured hex, rational absolute error and bound, and status. Report both N statuses (captured N and unavailable historical N). Any structural failure or out-of-bound cell stops acceptance. Preserve the raw response and discrepancy; no tolerance widening, retries or alternate target under this contract. The reader only parses an aggregate text receipt and the pinned public CSV. It does not run Stata or load data.

## Next gate

First validate the exact emitter through Stata MCP on an isolated, in-memory 423-row artificial fixture with distinct fields, nonidentical missingness patterns (including extended missing), a known common-case N, and failure cases. Verify the native matrix capture, all 243 records end to end, receipt and session ownership, and unchanged input signature. A protected run remains blocked until that gate passes and the exact carrier, restricted destination and single run are separately authorized. Neither the readiness of another block nor an earlier artificial test activates this file.
