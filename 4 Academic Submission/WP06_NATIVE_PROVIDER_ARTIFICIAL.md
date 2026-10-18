# WP06 — residual native adapter/provider implementation, artificial only

18 October 2026. Owner checkpoint: `852c23686b292b9d133d9d500dad9fa05e63e6fa`.

## Acceptance boundary

This successor adds executable adapter/provider source, tested through an injected artificial Windows API function table. It does not load DLLs, inspect the host, launch actors, control real processes, modify services, execute Stata, load/export participant records or adopt operational credentials. Ordinary test interpreters and read-only Git bookkeeping are evidence tooling, not actor launches.

The previous seven Stage-B modules and every prior packet remain unchanged. The previous report's residual statuses remain historical, not silently rewritten. The default new entry returns refusal; the old entry still refuses execution. No real AC17–AC22 case is executed or passed. All runtime facts and external gates retain their previous values.

## Implemented source and callers

| Surface | New source | Concrete artificial verification |
|---|---|---|
| N01 authority/time | [providers.py](wp06-stage-b/providers.py) | Role-separated MAC decisions and observations, binding/scope/build/epoch/freshness checks, explicit revocation, worker-event records; injected QueryPerformanceCounter/Frequency calls, mismatch/error/rollback quarantine. No key discovery or account access. |
| N02 process/identity | [native_backend.py](wp06-stage-b/native_backend.py) | Fixed-width Windows structures and unbound ABI declarations; mutable UTF-16 command, explicit application/minimal environment, STARTUPINFOEX handle allowlist, suspended creation, captured PID/creation time, narrowed QUERY/SYNCHRONIZE handle, creator/thread closure and failure quarantine. Separate pregranted TERMINATE handle captured before narrowing, never PID reopening. |
| N03 transport/control | Same backend | Protected account-specific ACL construction; local, first-instance, overlapped message-mode pipe; unnamed events; kernel pipe-peer PID check against retained process identity; pending buffers/OVERLAPPED/event lifetime; read/write/connect completion, cancellation request versus observed completion; same-handle exit and owned resource inventory. |
| N04 composition | [native_runtime.py](wp06-stage-b/native_runtime.py) | Callable bounded L/O/S/C/W role iterations; explicit existing Bridge/Supervisor/actors/Journal composition for a prebound worker; durable prearm before work, one attempted stop, worker event observation versus application versus actual handle exit; authenticated native frame transport with role credential, sequence/hash chain, tamper/replay/expiry/rollback checks and no retry. |
| N05 tests | [test_native_backend.py](wp06-stage-b/test_native_backend.py) | Only the external API boundary is artificial: the actual new ABI adapter/provider and existing policy/actor/journal code run. API output pointers, flags, rights, failures, resource retention, pipe identity, pending cancellation, role admission, application/exit separation and channel ownership are asserted. |

No new dependency, service source, configuration, installer, runtime fact, scientific code or manuscript change is required. Injection is trusted artificial configuration, not a security sandbox: an arbitrary malicious injected callable is not made safe by its `ARTIFICIAL` label.

## Source completion is not native deployment

The following remain explicitly **unadopted or incomplete**, not passed by substitutes:

1. **Four-process identity/bootstrap integration.** The sealed historical `plan_launch` requires all four actor specifications to share the target's full binding. The new backend validates a captured process's own PID/creation time before resuming it. Those contracts cannot truthfully describe four distinct native processes. Tests compose one explicitly prebound artificial worker, not an actual four-process launch. A successor source-exact design must separate run/target binding from each actor's captured native identity and explain when identities are signed/admitted. No old manifest is silently weakened and no PID is invented from the real host.
2. **Cross-process role provisioning and scheduling.** Role functions and pipe/MAC implementations exist, but no real role executable, inherited bootstrap descriptor exchange, authenticated per-role key distribution, independent watchdog/receiver scheduling, real boot-continuity provider or measured latency envelope is installed or verified. Serial artificial role calls are not proof of independence.
3. **Operational authority and store.** Supplied synthetic keys and explicit in-memory revocation are not institutional trust roots, a nonrepudiation system, secure key storage or automatic cross-process revocation. The existing Journal still only creates fresh artificial stores; no restricted active/archive store, independent high-watermark authority, crash/power-loss or cross-process contention verification is adopted.
4. **Independent final evidence and cleanup.** Backend inventory exposes actual adapter ownership facts; it is not signed O/L evidence. `finish()` retains HOLD and cannot self-promote attempted delivery, worker state, a frame or numeric exit into complete AC acceptance. O/L role separation and the full authenticated final resource inventory still require real integration and separately authorized evidence.
5. **AC19/AC21.** AC19 numeric reuse remains unavailable while original process identity is retained. AC21 termination is conditional on separately adopted exact target/profile grants; a synthetic capability test is not permission to terminate. Real cases remain NOT_EXECUTED.

Accordingly, this is bounded residual source implementation and artificial validation, **not full native backend/provider deployment or full live executor completion**. No operational, scientific, institutional, publication or release acceptance follows.

## Documentation basis

ABI/flag/lifetime choices were checked against official Microsoft documentation, not host probes: [CreateProcessW](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createprocessw), [UpdateProcThreadAttribute](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-updateprocthreadattribute), [DuplicateHandle](https://learn.microsoft.com/en-us/windows/win32/api/handleapi/nf-handleapi-duplicatehandle), [CreateNamedPipeW](https://learn.microsoft.com/en-us/windows/win32/api/namedpipeapi/nf-namedpipeapi-createnamedpipew), [GetOverlappedResult](https://learn.microsoft.com/en-us/windows/win32/api/ioapiset/nf-ioapiset-getoverlappedresult), [pending-I/O cancellation](https://learn.microsoft.com/en-us/windows/win32/fileio/canceling-pending-i-o-operations) and [security descriptor strings](https://learn.microsoft.com/en-us/windows/win32/secauthz/security-descriptor-string-format). This verifies documentary API requirements, not actual DLL signatures or host compatibility.

## Evidence and next boundary

### Review and correction

One fresh read-only review found six Important issues and one Minor issue, with no Critical issue established inside the artificial-only boundary. The owner re-graded the Minor application-evidence erasure as Important. Eight regression tests reproduced all seven findings before correction. A single owner pass corrected pending-event ownership, sticky closure uncertainty, shared local revocation and cached-action invalidation, controller status/request schemas, captured endpoint role binding, approved IPC ceilings and monotonic application evidence. Two additional characterization tests cover channel-level uncertainty and positive/stale/future request records. The original eight-test RED run, intermediate missing-S-key fixture error and every source snapshot remain preserved. No second independent review was performed or implied.

The final suite is **81 distinct tests: 47 unchanged historical regressions and 34 new adapter/provider/composition tests**; normal and optimized final runs must each pass against byte-identical current source snapshots. The inert documentary preflight separately passes 17 tests in each mode. Actual receipts and the seal govern these counts, not this narrative. Local revocation uses shared authenticator identity and a cached generation check; concurrent cross-process propagation or atomic native revocation is still not established. The inherited fail-closed malformed issuer/kind exception-type Minor remains in the unchanged original protocol; the new receiving channel normalizes malformed-frame rejection.

Private packet: `audit-local/intake/wp06-native-provider-852c236`. It preserves owner authority, original hashes, every failing and passing source snapshot/test run/store, ledger rulings, one fresh review, any single owner correction pass, final seal and separate-process readback. Completion counts are governed by actual final receipts, not the intermediate 71-test run. No old failed packet or test store is replaced, reopened or deleted.

Next: resolve the four-process run/actor/target identity and authenticated bootstrap contract at source/design level using artificial fixtures only, unless the owner separately authorizes a different boundary. Do not jump to a host probe, process launch, live control, service change or statistical fit.
