# WP07 — AQ04 readback audit and remaining-case binding

13 November 2026 · **Offline only. No Stata or provider session calls.**
[Original stop and accepted checks](../wp07-closed-command-log-execution/VALIDATION.json) ·
[Eight exact requests](RUN_CONTRACT.json) ·
[Digest verifier](response-digest.mjs)

## What can be recovered

The preserved stop says the full-response readback comparison failed.
This is a failure of the live evidence gate, not evidence that Stata or
the preparation code failed. The sealed AQ04 JSON is 2,650 bytes and
its raw text is 2,285 characters on 96 lines. The saved receipt
review reports 2,279 characters because it joined three Stata display
continuations, removing two continuation-prefix characters each.
This explains those two *saved* lengths, not the original equality
failure. The raw JSON and normalized audit are distinct artifacts.
The raw text has no compression, capping, or spill marker. That is
not proof of what reached the original comparison boundary.

The saved response contains the closed/no-file command-log receipt,
the allowed ordinary-log path after reassembling its three display
continuations, the expected inner `phase=prep rc=9 cleanup=0 N=0 K=0`,
the native `r(9)`, and the matching outer receipt. The AQ04 directory
was and remains empty. No independently recorded pre-write digest
or both original comparison operands exist. The specific cause
(e.g. presentation-layer transformation or some other representation
difference) is unproved; do not assign it to any proxy or normalizer.
**AQ04 remains stopped and unaccepted.** Gate and AQ01–AQ03 retain
their exact accepted status, seals and artifacts. None is rebound.

## Digest gate — qualified offline

Freeze the *entire received response envelope*, including error state
and metadata, as one JSON record plus exactly one final LF. Compute the
UTF-8 byte length and SHA-256 of that serialization **before** writing
the response. Keep the expected fingerprint separately. Write the same
serialization to a new evidence path. Verify the saved file's raw bytes
locally against the pre-write fingerprint; return only a digest and
length, not rendered JSON. Never substitute a digest computed from the
saved file for the pre-write expectation. Parse the same verified
byte buffer, not a second read; preserve the raw response before joining display
continuations for receipt checks. An equal digest proves byte
preservation from the delivered envelope, not provider completeness or
case success. Error, missing fingerprint, mismatch, spill, capping,
unexpected receipt, or file/inventory drift stops dispatch.

The built-in Node SHA-256 implementation is only for this offline
evidence step; it adds no Stata or replication dependency. The tests
passed on the known SHA-256 vector and the original-file round trip;
they rejected same-length content changes, missing final LF, extra
whitespace, CRLF conversion, BOM, replacement with a compression
placeholder, invalid/missing fingerprints and non-file paths. A
Windows junction was rejected; a file-symlink fixture could not be
created under current privileges, and no permissions were changed.
The separate synthetic Unicode/CRLF/escape fixture passed the actual
orchestration → Node REPL pre-write fingerprint → saved file → local
CLI comparison. Its pre-write seal was 276 bytes,
`a60481acc8dadfee3a7df62df288a7afcc8421847fcd44778278abf03c6c8fed`. No live-response equivalence is claimed for
AQ04 from these offline checks.

## Fresh binding for review

Only **AQ05–AQ12** are bound, serially in original order, 60-second
soft timeout per request, no retries. Fresh session names and unused
synthetic/evidence paths are separate from the stopped batch. The
caller is identical except for root/session rebinding; no scientific
code or expected case result changed. Reuse the six sealed
non-caller payloads and copy the byte-identical AQ07 sentinel.
Before any separately authorized execution, verify the predecessor
acceptance and artifact seals, the unchanged AQ04 stop, exact
staging and metadata, and live session name vacancy/capacity. The
fresh root is synthetic-only; verify each case output allowlist.

Use the existing closed/no-file and ordinary-log checks. AQ09
still requires its own ordinary-log rejection receipt and cleanup,
with no command-log or save/reopen receipt. AQ08/AQ11 preserve their
rejected artificial artifacts; the ceiling is two synthetic saves and
two reopens, no model or participant work. The eight-case grant would
not reauthorize AQ04. To claim complete qualification later, resolve
AQ04 separately rather than treating its saved transcript as a pass.
Until then, neither the previous nor the proposed grant permits a
participant build. **E.5 and Appendix C2 remain held.**

Contract SHA-256: `6cfdaab533462dccafa74e8c680e028bb92efefa44ee7b2f6c935b5d718090db`. Nothing was staged in the proposed
execution roots. The already-uncommitted execution packet and both
navigation before-images are preserved. Final read-only verification
matched 55 earlier receipts, 24 source/evidence pins, two fixture pins,
all preserved artifact fingerprints and both stopped staging roots.
All 21 proposed paths were unused and Git-ignored. The eight session
names were absent from the saved closing inventory; no live availability
is claimed.
