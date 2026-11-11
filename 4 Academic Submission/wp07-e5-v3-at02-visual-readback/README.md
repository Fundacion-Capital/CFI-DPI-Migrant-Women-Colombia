# E.5 v3: AT02 saved-artifact acceptance and remaining-case binding

11 November 2026. **AT02 passed saved-artifact review.** Both positive cases
now have accepted artificial evidence, but the original two-dispatch batch
remains stopped. AT03–AT12 are bound, not authorized or dispatched.

## Saved-artifact acceptance

- The stopped-batch seal and its predecessor chain matched before review.
  Both frozen offline auditors passed on both 17-file outputs; all nine CSV
  and five TeX pairs matched after line-ending normalization.
- A byte-identical copy of the pinned AT02 wrapper was compiled privately
  with pdfLaTeX, no shell escape, in three passes. Passes 2 and 3 had
  identical auxiliary hashes. The final log had zero warning, error or
  overfull entries and 40 underfull diagnostics. Original wrapper and
  artifacts were unchanged.
- All seven pages were inspected. QT1/QT2 fit on pages 1/2; QS1 on page 3
  showed the comparison and exact-bound note; QS2 on pages 4–5 retained all
  30 rows, repeated column headings and one note at the end of the last
  data page. QS3 on pages 6–7 repeated headings and kept the notes legible.
  The single-row QS2 continuation met the diagnostic gate; it is not a
  final manuscript layout decision.
- Both QF1 formats were inspected. The PDF rasterizer reported unavailable
  Symbol/ArialUnicode display fonts; no missing glyphs or clipped labels
  were visible. AT01 and AT02 native QF1 PNG hashes matched; their PDF
  rasters and table-page rasters 2–7 matched. Page 1 has a different
  diagnostic title. No PDF-byte-equality requirement was added.

## Readback-first gate

The [new offline checker](verify_saved_response.mjs) was tested against the
actual preserved AT01 inline reply and the exact named AT02 spill. AT02's
41,515-byte readback matched the archived SHA-256. It carries the actual
terminal outer line, without inventing a separate numeric outer return code.
The prior preview stop and both original evidence channels remain intact.
Nine new tests and the 22 frozen receipt tests passed. Independent review
identified a file-identity check that needed to run before the first read;
the check now runs before and after reading, and the final tests and
archived readback were rerun.

The [binding](AT03_AT12_BINDING.json) fixes each request's byte hash,
source and fixture pins, expected inner/outer receipts, output inventory
and private evidence paths. The ten request envelopes change only the
session ID to a fresh **proposed** owned session; selection text, working
directory, timeout and unused case paths match the sealed predecessor.
No live admission or capacity was queried.

After a fresh exact grant, verify the pins, unused paths, and absent proposed
session before dispatch. Save the raw MCP response and the ordinary log
before checking receipts. If the tool reports a cap, use only the exact
reported regular spill inside the bound directory; validate the call window,
file identity and preview prefix and retain the exact bytes to the unused
case evidence path. Pass the saved `raw` object, ordinary-log text, binding,
bound directory and path, and dispatch start/end in epoch milliseconds to
`verifySavedResponse`. Supply the actual outer code if independently
reported; otherwise retain null. A malformed, missing or mismatched spill
stops the batch. Do not reconstruct or substitute a terminal receipt.
The checker never dispatches, opens a Stata session, or verifies an output
inventory on its own.

Then verify the expected inner nonzero return, genuine terminal outer
completion and N=0/K=0; check the output directory before the next case.
AT10 must retain exactly the sentinel at `QT1_models.tex`; all other
negative-case output directories must be empty. One attempt per case,
60-second soft timeout, stop on first unexpected result, no retries,
no redispatch of AT01 or AT02. Unused capacity in the stopped grant is
not continuation authority.

See the [case register](CASE_STATUS.csv), [active task register](TASK_REGISTER.csv)
and [audit seal](VALIDATION.json). No new Stata calls, fits, participant/model
loads, study-ledger rendering, or submission work. **Appendix C2: HOLD.**
