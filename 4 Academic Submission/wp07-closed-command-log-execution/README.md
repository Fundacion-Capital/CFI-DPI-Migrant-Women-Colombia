# WP07 — corrected guard batch stopped at AQ04 readback

13 November 2026 · [Sealed request set](../wp07-closed-command-log-successor/RUN_CONTRACT.json) · [Validation and evidence pins](VALIDATION.json)

**Five selections dispatched; four accepted; no retries.** The text gate
and AQ01–AQ03 met their exact checks. AQ04 was dispatched once and the
batch stopped at its full-response equality check. AQ05–AQ12 were not
dispatched; the remaining authority under this stopped grant is zero.

| Case | Disposition | Evidence |
| --- | --- | --- |
| Text gate | Accepted | Actual closed/no-file and runtime receipts, native write/read/EOF, and independently verified 35-byte marker. |
| AQ01 | Accepted | 423 × 322 native save and reopen in separate frames, successful in-caller comparison and cleanup, exact outer receipt, one sealed artificial dataset. |
| AQ02 | Accepted expected rejection | `input_n`, RC 2000, cleanup 0, empty memory and no output. |
| AQ03 | Accepted expected rejection | `input_n`, RC 459, cleanup 0, empty memory and no output. |
| AQ04 | Stopped; not accepted | Live readback equality check did not pass. Later inspection of the saved response found the expected `prep` RC 9, cleanup 0, empty memory and no output, but did not establish equality to the original live comparison operand. |
| AQ05–AQ12 | Not dispatched | Includes AQ09. The only file in an undispatched leaf is the unchanged, pre-staged AQ07 sentinel. |

The full available responses were persisted. The initial text-gate
reader treated the first display line as the full log path. Before
dispatching AQ01, a separate audit joined the exact one-line Stata
continuation and verified the bound filename; both audit records were
kept. No retry or output modification was needed. The four accepted
cases each showed a closed command log and an allowed ordinary log.
The validated ordinary-log paths were absent at metadata readback.
This does not establish absence of unreported provider capture.

AQ04's saved response contains all the expected native receipts in
order and no named spill or capping marker. The raw MCP response was
written before the comparison; the live comparison operands were not
preserved independently, so the exact reason the check failed is
unproven. Do not call it a Stata or data-preparation failure, infer a
specific proxy cause, or treat the later saved review as permission to
advance. No data other than the synthetic AQ01 candidate were saved
or reopened; no participant/model data, fits, settings changes or
service actions occurred.

The postflight reverified 33 prior receipts, 17 source/evidence pins,
all seven old payload pairs and seven new staged sources, plus three
installed provider pins. The old gate remained empty. The new marker,
synthetic AQ01 DTA and pre-staged AQ07 sentinel are the only files
inside the new case leaves. The manager reported all five dispatched
sessions ready and nonbusy, no remaining named case sessions, and
concurrent unrelated inventory changes; this is not process-exit
proof. Twenty-two new evidence files are sealed; raw receipts and
incidental paths remain in the ignored evidence packet.

**Next:** Diagnose the AQ04 equality failure from saved evidence and
qualify a stable, source-exact response verifier offline. It should
compare an independent pre-write digest of the full response against
the saved response without passing both through another rendered
tool-output boundary. Preserve the existing successes and this stop.
Any remaining synthetic cases require an exact new binding and grant.
The synthetic write/save/reopen result does not clear participant
custody. The restricted build, **E.5 and Appendix C2 remain held**.
