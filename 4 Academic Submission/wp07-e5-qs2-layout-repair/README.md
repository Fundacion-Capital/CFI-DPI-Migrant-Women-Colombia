# E.5 QS2 layout-only repair and saved-artifact verification

10 November 2026. **The scoped layout repair passes saved-artifact verification.
Native generation by the new held v3 producer has not been executed. E.5 is
still incomplete; Appendix C2 remains HOLD.**

The former QS2 continuation-page defect is reproduced in exact copies of the
preserved artificial AT01 output, both alone and in the full five-table wrapper.
The repeated header was already defined. Installed longtable's height-only
footer accounting under-reserved the final notes' trailing depth; the outer page
builder then split the final row/notes after longtable had finished managing
pagination. Adding another header definition would not address that cause.

## Implemented change

`1 Code/academic/3 E4 exhibits v3.do` is a separate, still-disabled successor.
Its line-seven `exit 198` stays intact. Only the QS2 ordinary/final footer strings
change, with a version/provenance note and one explanatory Stata comment:

- Reserve an invisible copy of the final notes at the same paragraph width.
- Match the table's terminal row strut inside that invisible copy.
- End both footer boxes with a zero kern, so longtable accounts for their full
  vertical extent. Measured footer height is 34.4pt and depth zero for both.

No printed wording, visible font size, margin, data-row writer, CSV command,
calculation, model, uncertainty convention or cleanup logic changes. The
original producer, v2, canonical master/preparation/analysis scripts, prior
requests, auditors, fixtures and native outputs are preserved.

The repaired diagnostic output directory is a **separate copy**, not native
output from v3. Sixteen of its seventeen files are byte-identical to the saved
artificial AT01 files; QS2 differs by exactly the two footer replacements. All
130 table data rows preserve exact text, numbers and order. The unchanged
numeric/structure auditor passes all seventeen files.

## Actual verification

| Saved-artifact wrapper | Final pages | QS2 pages / rows per page |
| --- | ---: | --- |
| All five tables, 11pt, one-inch margins | 7 | 4–5 / 29, 1 |
| QS2 alone, same layout | 2 | 1–2 / 29, 1 |
| QS2, five-inch text height | 2 | 1–2 / 15, 15 |
| QS2, 3.5-inch text height | 4 | 1–4 / 9, 10, 10, 1 |

Each wrapper received three standard pdflatex passes, with no shell escape or
dependency/settings changes. Pass-two/pass-three auxiliary files agree. Every
QS2 page has headings and data; every variant contains all thirty endpoint rows
and prints the notes once on its final QS2 page. Root inspected all fifteen final
pages. No final log has a Warning entry, overfull box or LaTeX error. Existing
underfull paragraph diagnostics remain: forty in the full wrapper, ten in each
isolated/stress wrapper. They reflect the preserved narrow paragraph columns;
they are not falsely reported as a wholly clean typesetting log.

The final PDF checker also rejects the preserved missing-header baseline and
the rejected notes-only-page control. The initial checker mistook the PDF's
`ffi` ligature in the following QS3 caption for a missing table boundary; that
false alert and its initial checker are preserved, and its boundary detection
was corrected without weakening QS2 header/row/notes checks.

Independent read-only review verified source reversibility, eight input pins,
all sixteen unchanged files, all 130 rows, exact footer-size parity and final
wrapper/log bindings. It did not independently perform root's visual review.

## Evidence and next substantive task

See AUDIT.md, INPUTS.json, CHECKS.json and VALIDATION.json. The Git-ignored
companion holds every baseline, failed control, source before-image, all three
passes, final rasters and detailed review evidence. Do not stage that companion.
The checks can be repeated offline with `verify_saved_artifacts.mjs` and
`verify_layout.mjs` against the declared private diagnostic PDFs.

**Next: bind the held v3 producer into a fresh artificial-only native validation
contract and exact caller/request paths, then seek the separate execution
authorization.** Retain the existing two-positive/ten-negative case design,
frozen fixtures/numeric auditor, sixty-second soft timeouts, no fits,
participant/model loads or retries, and genuine rendered acceptance. Stop on
the first unexpected result. Never repoint or resume the stopped v2 batch.
This packet contains no fresh executable request or native authorization.

Native v3 parsing/generation, remaining negative/order-invariance cases,
study-ledger rendering, manuscript integration and journal-layout verification
remain unperformed. No universal pagination guarantee is claimed for page
heights too small to hold a header, one data row and the notes. Institutional,
consent, disclosure and release matters remain unresolved as previously stated.
Packages B/C/D/G continue the full academic paper; this repair does not replace
literature, qualitative, institutional or benchmarking work.

This package made zero Stata calls, participant/model loads or fits. It made no
contacts, settings/service changes, Git mutations, publication or cloud sync.
