# E.4 admission failure: source-supported diagnosis, no retry
8 November 2026. Status: **NV01 failed before fixture construction; whole batch
stopped. No correction or further native selection was executed.**

## What actually ran
One exact sealed request was dispatched once through Stata MCP. Admission
displayed N=0, K=0, Stata19. The next line was `quietly log query all`.
Stata treated `all` as a log name and returned `log all not found`, r(111).
The ordinary case log had not opened, no fixture row had been generated and no
estimator had been reached. The MCP envelope's isError=false was not accepted
as native success. The two printed r(111) lines are not counted as two dispatches.

Actual accounting: 1 dispatched, 0 passed, 1 unexpectedly failed, 9 not dispatched;
0 synthetic fits, 0 participant/model loads or fits, 0 retries. The nine
successors remain sealed and unrun. No source patch or cleanup selection was
used to bypass the stopping rule.

## Root cause and proposed correction
This is a mistake in the operational caller envelope added for execution, not
a finding about the canonical measurement/model code, data or estimability.
The installed official Stata help, `C:/Program Files/Stata19/ado/base/l/log.sthlp`,
specifies `log query [logname | _all]` and gives `log query _all` as its example.
Its SHA-256 is
`48abbc35320ff5095d226701788884fe967f2e80c4663163c62bec096357bbe5`.
The earlier web PDF text rendering omitted the underscore; the exact installed
SMCL source and native error govern this diagnosis, not the rendered preview.

Proposed caller-only edits in a NEW successor, not these preserved requests:
```stata
quietly log query _all
...
log query _all
```
The invalid unqualified command occurs twice in each of the ten request files.
A future successor should change only those20 occurrences, bind a new exact
request manifest and recheck the unchanged nine scientific source blocks.
The valid token is source-supported; successful execution of the corrected
caller and all remaining tests is **not yet demonstrated**. Do not describe the
batch as fixed or validated, or reuse unused slots as renewed authority.

## Preservation and runtime/log limits
Full returned native error text, raw MCP envelope, dispatch intent, outcome,
session inventory and independent receipt are retained privately. The case's
native.log never existed; no model/result CSV was generated.
An external provider capture-log path was observed in the response. Its
post-failure byte hash was unavailable; no evidence recovery/settings change was
attempted and no completeness guarantee for provider-internal logs is claimed.

The final read-only inventory reports the owned session ready and not busy.
N/K were observed only at admission before the nonmutating failed command.
There was no post-failure native memory/log query, cleanup, reset or replacement;
final native log closure is therefore not independently certified.
No participant data were ever authorized or loaded; no public release occurred.

## Next substantive task
Apply the two caller-command corrections only in an additive successor, keep
all current packets, reseal the ten unchanged scientific cases, and obtain a
fresh bounded execution authorization (at most7 synthetic fits, no retries).
No new scientific decisions, worker/bootstrap development, environment repair,
participant access, methodological changes or C2 execution are required by this
logging-command diagnosis. Actual native tests remain pending.

