# WP06 isolated live-control integration

This is a **LIVE_ARTIFICIAL** Windows test harness for fixed disposable Python roles, not a participant runner, Stata launcher or shared-service patch. Old Stage-B ARTIFICIAL-only guards and all earlier sources/packets remain unchanged. The implementation reuses their Win32 ABI structures/signatures and canonical encoding without mislabelling a real API as an artificial provider.

## Actual integration

`live_windows.py` provides native job/process/event/pipe operations. `live_roles.py` runs real separate L/O/S/C/W roles: L retains the outer job/observer handle; O independently observes and contains S/C/W in a nested job; S retains its own newly created W process handle; C requests a stop; W only waits. Child creation is suspended, job assignment precedes resume, inheritance is restricted to an explicit bootstrap/event/process-handle list, and each role checks its creation identity and source/clock scope before work.

Private inherited bootstrap pipes carry fresh run-scoped role keys; keys are not written to receipts or passed in command-line arguments. MAC-tagged records are atomically published, create-only and bounded. Process identities include creation time, not just PID. Event capabilities are narrowed; W directly verifies that its sync-only stop handle cannot signal itself. Sources and the explicit Python executable are hash-pinned. These are integrity checks between trusted local roles, not a hostile-same-user sandbox, memory-image attestation or nonrepudiation against trusted parents.

All deadlines use one native QPC frequency/domain per case: bootstrap5s, control8s, observer cleanup10s and outer cleanup12s. A cooperative signal, worker application, forced exit and independently observed process exit are separate facts. A supervisor stall is contained by O's job; an observer stall is contained by L's outer job. Closing owning job handles contains descendants if that owner exits. No arbitrary command, participant input or foreign-PID CLI is accepted. Windows is not claimed to provide universal hard real-time behavior; acceptance requires the measured case to finish within its declared envelope.

The native design follows Microsoft's [job-object](https://learn.microsoft.com/en-us/windows/win32/procthread/job-objects), [explicit handle-inheritance](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-updateprocthreadattribute) and [QPC](https://learn.microsoft.com/en-us/windows/win32/sysinfo/acquiring-high-resolution-time-stamps) documentation. No breakaway or shared-service alteration is used.

## Finite acceptance cases

1. Cooperative stop: W records event application and exits normally.
2. Controller exits: S observes controller exit and stops W without relying on C's heartbeat.
3. Worker ignores stop: S terminates only its exact retained W process handle; no cooperative application is credited.
4. Supervisor stalls: O contains its job and independently observes exits.
5. Observer stalls: L contains the outer job and observes its retained role handles signal.
6. Wrong worker birth identity: bootstrap rejects before prearm/work; the owned job is cleaned without a replacement.

Unit tests default to **no launches**. The explicit live suite requires the current private owner scope and a fresh packet. No automatic retry/replacement occurs inside a case. Every initial/failed/corrected attempt is preserved. Both the initial and post-fix six-case waves are retained; the complete post-fix wave alone governs final acceptance. All six final cases were accepted, with zero active owned processes observed after cleanup and successful owned-handle closure. No third native wave was run.

The [acceptance report](LIVE_CONTROL_ACCEPTANCE.md) records the initial independent review, reproduced failures, corrections, exact final measurements, 19 normal/19 optimized pure tests and 148 inherited artificial tests. Native exits, authenticated identities, required reports and allowed faults must all agree; a signalled event alone cannot pass a case. All bootstrap admissions recheck the strict deadline after read/publication and after gate observation.

## Limits and handoff

This validates only the isolated artificial-worker domain. It does **not** bind an already-running Stata-MCP worker to this launcher, disable MCP recovery, prove busy Stata interruption, pass the old full deployment/credential protocol, clear cloud membership/rights conditions, or authorize any P1–P4 participant wave. No Stata executable, respondent dataset, model, score, shared-service configuration or original scientific do-file is touched. Any subsequent empty-Stata integration needs its own exact authority and launch/recovery contract.

The private packet is `audit-local/intake/wp06-live-control-365fea7/`. It contains the plan/authority, entry fingerprints, RED/GREEN tests, complete native case packets, fresh review and final seal/readback. Public numerical claims must be tied to the actual retained source version and results, not merely successful unit tests. Commit/push/release are not performed by the harness.
