# Bounded QS2 repair audit

Scope: source-only held QS2 layout successor and saved artificial artifacts.
Entry: e9d7aae4d2b24b81bfd522afc4fc040b93580ea5; clean worktree/index.
No Stata execution or participant/model-file interpretation is included.

## Diagnosis before source repair

The exact preserved QS2 fragment already contains first/repeated headings and
proper longtable terminators. Both the full and isolated three-pass baseline
reproduce the missing final-page header. Installed longtable v4.27 (2026-01-28)
reserves footer height and tests terminal body/footer height without their
trailing depths. It is not claimed to be the later version on the CTAN mirror.

The original trace records one terminal output call (penalty -30000), no normal
intermediate longtable break, page goal 650.03001pt and page total 635.14392pt.
The ordinary footer is 0.4pt high/depth zero; the last footer is 8.79996pt high
with 25.60004pt depth. The final note therefore escapes the expected reservation
and the outer page builder splits the returned material without a repeated head.

Preserved controls show why a superficial fix is insufficient:

1. Printing the full notes on ordinary pages did not normalize their depth.
2. A top-parbox phantom alone likewise left depth unaccounted for.
3. A bottom-aligned final note still did not repair the terminal split.
4. Adding a final rule restored a header but created a notes-only page: rejected.
5. Normalizing both footer depths with a zero kern, with an invisible ordinary
   note reservation, restored genuine longtable pagination.
6. Inner paragraph width was corrected to the containing cell's linewidth.
7. The final invisible grouped small strut matches the printed p-cell's terminal
   row strut. Final independent measurements give height 34.4pt/depth zero for
   both footer boxes. No body kern, package patch, new package, magic row break,
   forced numeric rounding, font-size reduction or margin change is used.

The visible printed note remains exact. The invisible strut's size command is
grouped so it cannot change the note paragraph's baseline spacing. Source code
and the new artifact reproduce exactly the same two footer strings; the new
artifact is labelled a transformed diagnostic copy, never a new native result.

## Tests that actually ran

- Real baseline PDF consumer check fails for the missing QS2 continuation head.
- Final-rule control fails for a notes-only continuation, even though headed.
- Four final wrappers pass after exactly three standard pdflatex passes each.
  They produce 7/2/2/4 pages; all fifteen final pages were visually inspected.
- PDF text checks require headings AND data on every QS2 page, thirty model-row
  IDs in order, notes exactly once and specifically on the final QS2 page.
  Exact candidate/endpoint/numeric row identity comes from the separate
  source-row equality test, not from model-ID matching alone.
- The small saved-artifact verifier reverses the declared v3-only changes and
  obtains v2 exactly after newline normalization; line-seven exit198 survives.
  It verifies eight byte/size/SHA-256 pins, all sixteen unchanged output files,
  exactly two QS2 TeX footer replacements and all130 table rows byte-for-byte.
- The unchanged seventeen-file numeric/longtable auditor passes. Nine CSV files,
  their Ns, six primary raw/Holm pairs, fifteen comparisons, thirty endpoints,
  74 coefficients (twelve references), 1,154 covariance cells and186 support
  records are preserved; this is synthetic-artifact checking, not study results.
- Independent review repeats the source/pin/file/row assertions read-only and
  checks all four wrappers, final/pass3 PDF equality, auxiliary convergence and
  footer metrics. Root, not the independent reviewer, performed visual checks.

The new PDF checker initially included QS3 in the QS2 span because pdftotext
encoded the caption's ffi ligature as a control character. That false alert is
retained alongside its checker before-image. Matching the unambiguous Native
logit prefix fixes only the table-boundary detector. The original missing-head
and notes-only regressions still fail with the corrected detector.

All controls, hypotheses and compile passes remain in the private companion.
No claim is made that the first hypothesis or any rejected control passed.

## Custody and acceptance boundaries

At entry601 unique predecessor fingerprints matched. Final closure treats599
as immutable and two navigation files as authorized updates with exact private
before-images. The new source is additive; historical source/output packets,
frozen auditors and stopped requests remain unchanged. Only the E.5 row in a
new forty-one-task register changes; other task statuses remain exact.

The public validation receipt seals new public files (except itself), allowed
navigation updates and private evidence. Hashes demonstrate byte custody, not
rights, institutional approval, disclosure safety, scientific validity or sync.

Accepted scope: layout-only source repair and saved-artifact LaTeX verification.
Not accepted/claimed: native v3 generation, twelve-case native batch, full E.5,
study-ledger rendering, journal-specific layout, full manuscript, or release.
The unchanged QF1 PDF/PNG are byte-preserved, not newly visually revalidated.
Existing underfull paragraphs remain as documented; no overfull boxes or final
warnings occurred. C2 stays HOLD. No settings/service/library changes, contacts,
Stata launches, participant/model loads, fits, commits, pushes or cloud sync.

Next is fresh v3 caller/request binding and separately authorized artificial
native validation, not resumption of a consumed grant. No new infrastructure
or Python/worker/bootstrap development is needed for this research milestone.
