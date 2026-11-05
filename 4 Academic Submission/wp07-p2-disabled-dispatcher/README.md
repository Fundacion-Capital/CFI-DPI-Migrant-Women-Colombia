# WP07 disabled P2 reader/dispatcher successor

This is an additive artificial-only implementation of the accepted requalification
package. It is not connected to the master Stata file, Stata MCP, a worker,
Overleaf, a service or a live provider. There is no activation argument or native
callback. Existing sources, fixtures and all previous packets remain unchanged.
C2 is HOLD; native results remain NOT_RUN.

## What is implemented

successor.py reuses the exact pinned pure reader and artificial receipt generator.
It verifies the accepted binding document and helper hashes before use. prepare
accepts only the named aggregate or cases track. It reads each named code source
with its expected size limit, verifies the saved fingerprint, computes only the
accepted hold-removal transform in memory, and verifies the prospective payload.
No unheld Stata source is written. This offline transform is not permission to
send the resulting bytes to Stata.

Prepared code buffers and step inventories are immutable. FixedFileFixture
passes compact single-use references to those same checked buffers; it does not
reopen code files during dispatch. References bind a synthetic channel nonce,
track, sequence, stage, byte count and payload digest. They contain no source
text or arbitrary path. Invalid, replayed and cross-channel references close
the fake channel. This nonce is not a real worker identity or authentication
credential; Python objects in this process are not a security sandbox.

## Separate routes

- dispatch_aggregate validates the P1/P2/P3/P4 synthetic receipt sequence using
  the preserved parser and full output validation. P2 has 4129 rows, not 4139;
  its nine columns and 500 state groups remain unchanged. There are 33 check
  dispositions. The original deadline/cancel/cleanup behaviour is simulated
  only with the preserved fake clock. The single reported load is explicitly
  simulated; actual participant loads and Stata calls are zero.
- dispatch_cases reads five supplied A1-A5 fake records; it never creates facts
  from expected values. The accepted contract checks all 62 literal facts,
  source/payload identities, N=0/K=0/fresh-runtime metadata and exact terminal
  phases. Five distinct synthetic context labels keep case slots separate.
  These are not observations of five real workers. No aggregate timing options
  or budget can be assigned to this route.

Both routes accept only this exact artificial fixture class, reject reuse and
stop on a bad record with no retry. Held entry records remain HELD_NOT_TESTED.
The expected A5 exit 9 is accepted only at its range assertion, not at an empty
memory guard. All case outcomes are metadata consistency only, never native
success, and later cases remain not_executed after a stop.

## Logs, capacity and remaining limits

Selection references are capped at 8192 bytes. The much larger code buffers
remain in memory; the corrected P2 prospective buffer is 952843 bytes. Trace
entries contain only synthetic scope, track, stage, context, digest and size.
No selection/worker log, source buffer or receipt is written to a runtime path.
No output root is provisioned. Test/audit records are documentary files here.

The prior 45/180/30/210-second values remain an unadopted participant proposal,
used only to test the aggregate fake clock. No deadline is extended and no real
case budget is selected. Native source admission, empty-state observation,
worker ownership, real log extraction, independent provenance, cancellation,
exit/cleanup and exact future access/output/retention remain unqualified.

M01-M06 in the prior migration map are addressed as disabled offline mechanisms:
loader pins, updated digest/receipt admission, same-buffer transport and separate
case readout. That does not apply those changes to the old runtime. M07's actual
operational and access decisions remain open. No shared integration was installed.

## Named verification only

Use the pinned CPython 3.11.15 with -I -B and test_successor.py. This executes only
Python source/metadata and in-memory artificial receipts. Run the four named
predecessor source checkers recorded in the audit as well. Do not use repository
test discovery, native tests, legacy load_plan or any participant carrier.

source_pins.json binds the previous 176-file preservation manifest plus the 12
accepted requalification files, totaling 188 preserved sources/documents.
The plan, development test receipts, independent review and final validation
record what was checked. No dataset, historical result or scientific decision
is changed or validated by this implementation.
