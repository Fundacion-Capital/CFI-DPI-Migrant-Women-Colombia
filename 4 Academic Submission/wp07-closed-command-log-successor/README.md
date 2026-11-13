# WP07 — closed command-log guard successor

13 November 2026 · **Offline only. Not staged, not authorized, not run.**

[Exact requests](RUN_CONTRACT.json) · [Synthetic caller](run_artificial_repository.do) ·
[Prior diagnostic evidence](../wp07-command-log-execution/VALIDATION.json)

## What changed

The one authorized diagnostic returned `(closed)`, query RC 0, blank
`r(status)` and no `r(filename)`. The old guards wrongly required the
literal status `off`. Both new guards query `cmdlog` once, require
both macros to be exactly empty, and emit a receipt only after the
query succeeds and the comparisons pass. A failed query stops the gate
or is returned through the caller's existing error and cleanup path.
An active or suspended log, a blank status with a filename, and an
unrecognized status are not accepted. No command log is opened,
closed, or suspended by the correction. See StataCorp's references on
[logging](https://www.stata.com/manuals/rlog.pdf#page=5),
[error propagation](https://www.stata.com/manuals/pcapture.pdf) and
[visible output inside quiet blocks](https://www.stata.com/manuals/pquietly.pdf).
The closed/no-file combination comes from the saved native diagnostic;
it does not establish the old worker's state.

AQ09 still opens its own artificial **ordinary** log before the
ordinary-log checks, rejects it by count or path, and closes only
its own handle. The new branch receipt identifies the ordinary-log
rejection, so a generic `phase=log rc=459` from another cause cannot
pass AQ09. No command-log query or closed receipt is expected in AQ09.
Fixture, schema, preparation, fault variants, save/reopen assertions,
and all expected case phases, return codes and file inventories are
unchanged apart from the new text marker and these receipt requirements.

## Bound future execution — separate authorization required

- Use the observed repository working directory, with a new ignored
  synthetic root `audit-local/intake/wp07-aq-repo-0207380` under
  `4 Academic Submission` and the thirteen fresh
  `cfi_wp07_r0207_*` sessions. The saved diagnostic inventories
  do not contain those names; recheck live vacancy and capacity before
  staging and before dispatch. Verify the path and expected reparse
  metadata, seven source bytes, empty leaves except for the exact AQ07
  sentinel, and the separate fresh evidence path. Git ignore does
  not provide privacy or a no-sync guarantee.
- Run serially: one text gate, then AQ01–AQ12, each with a 60-second
  soft timeout and no retries. Require the text marker write/read and
  independent byte check before AQ01. Require the positive 423×322
  save/reopen and its native assertions before any negative case.
  The existing three-save/three-reopen ceiling and case file allowlists
  are unchanged.
- Preserve and read back the full response first. For the gate and
  every case except AQ09, require the actual native `(closed)` line
  exactly once, then the exact command-log receipt, then the existing
  ordinary-log/runtime receipt, then the remaining case receipts.
  Echoed source is not evidence. Keep any incidental log path private;
  do not open a command-log path or scan Temp. Missing, duplicate, or
  conflicting receipts, wrong routing, a named spill, capped output,
  unexpected status/artifacts, or a timeout stops the sequence.
- For AQ09 require exactly one actual ordinary-log rejection receipt
  (`reason=count` or `reason=path`), then the expected inner and
  outer receipts, cleanup 0, empty memory and only `unexpected.log`.
  A command-log query, closed or runtime receipt, or a save/reopen
  receipt is disqualifying. Preserve failures and partials; no retry
  or alternate route. Retain all predecessor receipt checks.

## Offline audit

Contract SHA-256: `68523fcd9ac196dfde737ebafda91673b1614c038a3ab2303bd1e66e26616ca6`.
An offline predicate table checked nine states at both guard sites.
The predecessor rejected the observed closed state and accepted
`off` with or without a filename; the successor accepted only the
successful exact blank/no-file combination in that table. The source
comparison allowed only the path/session and marker rebinding,
the two command-log corrections and AQ09 branch receipts. The 13
requests preserve the original order, dependencies, case outcomes and
operation ceilings. The six reused staging sources are byte-identical.
This is a static source and contract audit, not a native test.

The final preservation check covers 17 source/evidence pins in this
contract, all seven original and staged payload pairs from the prior
batch, 33 earlier receipts, and three installed provider source pins.
The prior gate stayed empty and the AQ07 sentinel stayed byte-identical.
All 28 proposed paths, including the separate evidence destination,
are absent, ignored and untracked. No prior packet or scientific code
changed; the two navigation before-states remain at entry commit
`020738067da0eb6b4ba8ed8e3edd40c42ccc7088`.

**Next:** Review and separately authorize only the bound synthetic
sequence. No Stata or provider calls, staging, data loads or fits
occurred. Repository write/save/reopen and restricted custody are
not established. The restricted build, **E.5 and C2 remain held**.
