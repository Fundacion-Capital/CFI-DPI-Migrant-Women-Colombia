# WP07 — command-log guard diagnosis

13 November 2026 · **Saved evidence only. One diagnostic bound for review; not authorized or run.**

[Stopped execution](../wp07-synthetic-repository-execution/VALIDATION.json) ·
[Exact diagnostic](PROBE_CONTRACT.json) ·
[StataCorp logging reference, pp. 2 and 5](https://www.stata.com/manuals/rlog.pdf#page=5)

## What stopped and why

The complete response reaches gate selection lines 15–18:
`quietly cmdlog`, then `if "`r(status)'" != "off"`, then the
executed `exit 459`. The three `r(459)` lines are propagation
of one failure, not three requests. The empty-memory/effective-directory
and ordinary-log checks did not take their error branches. The gate's
runtime receipt (line 19), target check (line 20) and first file open
(line 22) were never reached. The gate leaf is empty. This was not the
earlier AQ01 file-not-found failure, a failed file write, a save/reopen
failure or a defect in scientific preparation. All 12 cases remain
undispatched; the old grant cannot be reused.

The immediate cause is an exact-string guard rejecting the value it
read; the saved response never reveals that value or the command-log
filename. StataCorp distinguishes ordinary logs (`log query _all`)
from command logs (bare `cmdlog`). The manual documents
`r(status)` as `on` or `off`, with `r(filename)` for the file,
and distinguishes suspending logging from closing its file. It does not
specify the returned macros when **no** command-log file is open.
An empty or other unexpected value could reject a no-file state;
a real active command log could also explain the rejection. Conversely,
the current check would accept `off` without noticing a filename
for a suspended log. Neither equate an empty status with no open log
nor use `off` alone as evidence of no command-log file.

The [repository caller](../wp07-synthetic-repository-successor/run_artificial_repository.do#L22)
duplicates the predicate at lines 37–40 under `phase=log`, before the
runtime receipt, target checks and fixture. An ordinary case encountering
the same status would fail there even if the outer text gate were fixed.
The preserved AppData caller contains the same check and never reached
it in its prior `r(601)` attempt. AQ09 deliberately opens an unexpected
**ordinary** log and is expected to stop before `cmdlog`; its expected
`phase=log rc=459` alone would not diagnose this problem. Keep the
ordinary-log guard, exact synthetic-log disposition and AQ09 evidence
requirements separate from the command-log check.

Read-only inspection of the three pinned installed provider sources
agreed with the existing visibility record: the selection worker wraps
execution in a named ordinary text log and may fall back to captured
stdout. No command-log operation was found in those files. This is
evidence about the installed source, not proof of the exact loaded
provider, worker startup behavior, command-log state or hidden capture.
The existing Graphify index had no source-exact evidence for this guard;
the sealed request, response and caller govern this diagnosis.

## One proposed discriminator — review only

The exact request is in `PROBE_CONTRACT.json` (SHA-256
`9f7239b63bf794f232235e5f12d48659b6c29d7db032fee618ea7d1cfcbfd6eb`).
It uses the same repository-root `working_dir`, the same preserved empty
gate leaf as the effective directory, version 16, and one fresh
session name `cfi_wp07_cmdlog_fe31674`. It checks empty memory and
the permitted ordinary-log route, then invokes **one bare native
`cmdlog`** with output visible. It reports the query return code, exact
blank/on/off flags, and whether the filename macro is populated, followed
by an empty-memory receipt. It does not run either caller, create data,
open a project file, test writing, or change a log or settings. The
existing provider may create its normal synthetic capture log. A native
query may report a filename; preserve the full response privately,
without opening the file or repeating its path in the summary.

Only after fresh exact authority: verify the pins and unchanged gate leaf,
confirm session vacancy and capacity in a fresh metadata-only inventory,
and reserve the exact ignored evidence path. The name is absent in both
saved inventories, not proven vacant now. One selection, 60-second soft
timeout, no retry. Save and inspect the entire returned response before
reading actual receipts; require exactly one of each in order and compare
the native message to the status and filename flags. Preserve the
post-inventory and confirm the old leaf remains empty. Do not continue
on capped output, a named spill, unexpected ordinary log, inconsistent
receipts, wrong cwd, nonempty memory, or a failed query.

| Coherent observation in the fresh worker | What it supports |
| --- | --- |
| Native output explicitly says no command log is open; filename absent, query succeeds; status blank | Reproduces a no-open-log state that the old exact-string guard would reject. Review a narrow, evidence-backed correction to **both** guards; it does not retroactively identify the old worker's status. |
| Native no-open-log message, no filename, query succeeds; status exactly `off` | Old predicate would pass in this worker. Historical rejection not reproduced; no correction or retry implied. |
| Native open/active state with filename; exact `on` | Guard correctly rejects an active command log on this route; hold. |
| Native open/suspended state with filename; exact `off` | Reveals a false-pass possibility in the predicate if the requirement is no open command-log file. Hold; do not close or suspend someone else's log. |
| Query error, missing/inconsistent output, or any other combination | Unresolved. Preserve evidence and stop; do not widen the accepted state or dispatch the batch. |

The offline audit matched 25 saved receipts across the stopped gate,
AQ01 and visibility-probe packets, 13 predecessor source pins, all seven
original and staged payload pairs, and three installed provider source pins.
The old root still contains seven staged source files and thirteen leaves;
only AQ07 is populated, with its unchanged artificial sentinel. The new
contract is sealed, the diagnostic evidence destination is absent and
ignored, and the only existing files changed were the two navigation files.

No native or provider calls, no data loads, no settings or permission
changes, and no authority carried forward. Scientific code and earlier
packets were left unchanged. Both navigation before-states are recoverable
at entry commit `fe3167466f3a6676f34ba9cb042be52b7aa5033f`. The restricted
build, **E.5 and Appendix C2 remain held**.
