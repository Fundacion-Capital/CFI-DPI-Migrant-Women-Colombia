# Disabled academic item/domain reporting v1

Both do-files begin with unconditional `exit 198`. Leave that hold in place.
No master calls these files; nothing in this package selects or loads a carrier.
No Stata execution has been performed for this task.

- **01 Item and domain reports.do:** 15 explicit domain sections, 93 unique raw
  source items and five actual form versions. It creates only temporary response
  flags, counts all six D2 states and reports offered categories/options using
  declared denominators. It drops only its own flags after each item. No new
  score, optional binary, cohort exclusion, row export or statistical test.
- **02 Prepared candidate reports.do:** consumes 11 named provisional fields
  and their declared components from the preserved preparation draft. Reports
  own nonmissing/component coverage, three common-observation comparisons and
  the separately prepared engagement outcomes. It creates no missing field or
  replacement aggregate. IVS date source, calendar gap and normalization stay held.

The item file consumes only named fields within the unchanged TARGET33 allowlist,
already in memory under a future separately authorized exact contract. The
candidate file requires the separately verified preparation output already in
memory. They have different input stages; neither file runs preparation or the
other file. The new code has not been added to any historical or academic master.

## Reading the reports

Scalar category percentages use recorded applicable answers, including explicit
sentinels; ordinary-valid, sentinel and applicable N are also printed. They are
not percentages of the entire sample or population estimates. Numeric age/year
context uses its own ordinary-valid N, without reconstructing tenure.

Multiselect option percentages use ordinary-valid parent responses within the
actual version; item-specific sentinels use all recorded parents separately
(uncertainty for q5_13, refusal where offered). Nonoffered options
are not assigned zero. Malformed/conflicting combinations remain unresolved,
not repaired or excluded from the admitted cohort. Full parent strings and free
text are never printed. Shared items are cross-referenced rather than duplicated
as independent evidence. All prospective counts, including small cells, remain
restricted and require separate disclosure review before publication.

Use the [item register](../../4%20Academic%20Submission/wp07-academic-reporting/ITEMS.csv)
and [version-specific codebook](../../4%20Academic%20Submission/wp07-academic-reporting/CODEBOOK.csv)
to interpret numeric codes. Legacy value labels are not authoritative here.

## Important source discrepancy

The inherited P2 source classifies barrier option 4 (“No sé cómo usarlos”) as
uncertainty in q10_1/q10_2, and holds some q10_2 combinations containing it.
The accepted IBPD account and retained choices establish that this is substantive
lack of know-how. The new disabled layer omits those three inherited rules.
P2 and every original remain unchanged. P2 needs separately scoped correction
and requalification before future participant use; its prior static pass is not
proof of this classification's substantive correctness.

See the [implementation/audit package](../../4%20Academic%20Submission/wp07-academic-reporting/README.md).
Appendix C2 remains on hold. Static checks do not establish native parsing,
empirical validity, institutional approval or release clearance.
