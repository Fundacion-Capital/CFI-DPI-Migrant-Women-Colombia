# WP06 — Independent cancellation/control-path investigation and proposal

18 October 2026. Baseline: `ef49585b4d85f1923f836e39f7c376b0c42a987c`.

## Decision and authority

The bounded investigation and inert proposal are complete subject to the packet's final review, preservation seal and separate readback. **No live cancellation mechanism has been implemented or validated.** No fitting, participant processing, service/source/configuration changes, direct operating-system termination, live stop-route calls, retries or external approvals are authorized by this packet. The existing execution gate remains closed. This is operational evidence and design, not scientific acceptance, a new execution contract, or permission to resume a consumed slot.

The recommended next development target is an independently scheduled, strictly owned controller that can request the installed worker's existing event-based stop, with a separately authorized process-handle fallback only if later demonstrated necessary and safe. Do not repeat the previous sleep probe or launch another model to discover whether cancellation works.

## Evidence and limits

The installed source location was discovered through an owned, empty Stata MCP session using module-location metadata only. Three installed Python source files were inspected as text/AST, never imported or started as a server. Exact source and function digests and symbol/line boundaries are recorded in [the source register](wp06-control-proposal/source_boundary_register.json). The extension directory's version label does not establish correspondence to an unmodified upstream release. Source bytes on disk are not an attestation of the currently loaded server bytecode.

All computational fixtures are artificial standard-library events, threads and coroutines; no persistent listener or child process is created. [Artificial evidence](wp06-control-proposal/artificial_evidence.json) is deliberately separate from source facts. The owned metadata worker was checked empty and destroyed normally through MCP; the pre-existing default session was not used or destroyed. No live stop endpoint was invoked.

### Source-exact findings

| Evidence | Verified installed-source behavior | Consequence for the proposal |
|---|---|---|
| S01 | The selection endpoint already awaits `asyncio.to_thread(session_manager.execute, ...)`. | Do not propose adding this existing offload as the fix. It does not prove an independent client control request can reach the service. |
| S02, S07, S12 | The MCP session tool forwards to the generic REST tool handler; its destroy branch calls synchronous `destroy_session`. Shutdown/join and termination occur outside the manager lock; the lock protects lookup/state and later removal. | Direct synchronous destroy can block the async handler despite releasing the lock. A future narrowly scoped patch should examine async offload, not repair an alleged lock-held join that these bytes do not contain. Destroy is not an independent deadline-control primitive. |
| S03 | Matching-result waiting uses wall-clock time and adds five seconds to the requested timeout. | A requested one-second wait is not a one-second engine deadline. Future budgets must use monotonic absolute deadlines and explicitly distinguish result, engine and cleanup ceilings. |
| S04–S06 | Timeout handling can recover the worker, including restart under the same session ID, before returning a timeout result. | Session ID is not worker identity. Epoch/PID/creation binding must survive and detect replacement. A timeout consumes the reservation; a replacement is not permission to continue. |
| S08–S09 | An existing stop mechanism sets a worker event. A separate REST stop route offloads the manager call with a two-second await; the current MCP session actions expose list/destroy, not stop. The route can return `stop_requested` even when its `stop_sent` flag is false. | The legacy response does not prove signal delivery or engine termination. A timeout of the await does not prove the background thread stopped; a late signal remains possible. Investigate a strictly bound adapter with independent delivery/completion evidence and quarantine ambiguous outcomes. Optional/default targeting is not an acceptable owner contract. |
| S10–S11 | A worker monitor checks the event and issues a native break while busy. A guard avoids repeated native breaks; the source warns repeated breaks can crash. | Request once per exact execution; never retry native break blindly. Effects during a particular native optimizer/GIL state remain untested. Pre-start clearing and late/duplicate events need race tests. |

These mechanisms are consistent with the previously observed delayed timeout/cleanup. This packet does **not** establish a complete causal timing decomposition, identify every upstream tool-scheduling bottleneck, or prove the native optimizer interruptible. In particular, making an async endpoint responsive is different from stopping its work. [Python's thread-offload documentation](https://docs.python.org/3.11/library/asyncio-task.html#asyncio.to_thread) supports the former distinction, not a guarantee of native cancellation.

### Artificial results and what they do not prove

1. Synchronous artificial work on the event loop prevents the queued control coroutine from running until work returns.
2. Thread-offloaded artificial work lets the control coroutine run while work remains unfinished. Fixture teardown then releases and joins that work. This is **not** a canceled-thread or canceled-Stata test.
3. An artificial cooperative worker honors a separate event and reports an artificial stopped outcome. This is not native Stata interrupt evidence.
4. An inert ownership-envelope validator accepts the exact artificial binding and rejects missing/stale/mismatched bindings, including a default-session substitution. It sends no signal. AST tests distinguish comments from actual awaited dispatch.

All fixture waits and teardown are bounded. The fixture suite documents pattern-level causality; it cannot validate the live transport, worker native code, supervisor independence, process exit or operating-system ownership.

## Proposed control contract — not deployed

### Independence and ownership

Arm the controller before dispatch, outside the chat request scheduler, server event loop, engine worker/GIL and work-command queue. A separate thread alone is not sufficient evidence of independence. The controller must receive control metadata only, not arbitrary Stata commands or participant paths. Its reservation binds `session_id`, an unguessable owner nonce, worker epoch, command ID, PID, process creation time, engine-module digest and reservation ID. Reject default/shared/unknown workers and absent or changed fields before any stop request.

The existing event-stop route must not be exposed unchanged as a broadly callable kill switch: require the full binding, one-shot command scope and authenticated local ownership. Snapshot identity immediately before action and reject replacement/recycled processes. An automatic same-ID recovery changes the binding; quarantine both uncertain execution and late results instead of adopting a new worker. No automatic restart, resumption, fitting retry or reservation reuse is permitted.

### Minimal state and deadline model

`PREPARED → RESERVED → RUNNING_BOUND → STOP_REQUESTED → EXIT_CONFIRMED`

Any missing identity, ambiguous state, deadline breach, failed acknowledgment or unverified termination leads to `UNKNOWN_QUARANTINED`. Both exit and quarantine are terminal/consumed. A response or registry disappearance alone cannot establish engine exit. Keep the engine outcome, request acknowledgment, exit evidence and cleanup outcome as separate fields.

Use a monotonic absolute execution deadline plus an explicit, separately bounded cleanup allowance. The controller must remain able to act while the result request, manager lock or tool bridge is stalled. Capture request/acknowledgment/exit times and exact ownership metadata; never turn a timeout, late successful response, or newly ready replacement into a successful completed fit. Numerical reporting remains barred until the existing scientific and input-authority gates independently permit it.

### Stop escalation and safe failure

First request the existing event-based cooperative stop once, for the exact owned execution. Never promote the current route's `stop_requested` response into a verified-delivery receipt. Independently establish exact-bound delivery and completion; late delivery after an await timeout must not reach a replacement/new execution. If either is uncertain, quarantine rather than send another native break. If an eventual hard-stop fallback is approved, use an already validated owned process handle or Windows Job Object membership, never a process-name match or a PID alone. This packet contains no callable operating-system termination implementation.

Forced termination can leave synchronization/IPC state unsafe; [Python documents these process-termination hazards](https://docs.python.org/3.11/library/multiprocessing.html#multiprocessing.Process.terminate). A future fallback must quarantine queues, partial outputs and the consumed slot, not reconnect/retry. [Windows Job Objects](https://learn.microsoft.com/en-us/windows/win32/procthread/job-objects) are a candidate ownership mechanism, not a validated solution here: nested-job behavior, privileges, handle inheritance and close behavior require isolated testing first.

Required future failure fixtures: cancel-before-start, duplicate/late/stale cancel, worker epoch replacement, PID reuse, blocked transport/lock, controller death, lost acknowledgment, late work result, partial receipt, bounded teardown and fallback-denied conditions. Preserve all attempts and their separate terminal outcomes. A missing control receipt must remain unavailable, not zero or success.

## Proposed staged acceptance and release gates

| Stage | Exact next evidence | Authority still needed |
|---|---|---|
| 1 — isolated patch preparation | Minimal adapter/control design in an isolated development location; source/interface review; no installed-service edits. | Explicit scope for preparing the adapter; no deployment permission implied. |
| 2 — artificial verification | Ownership/race/deadline fixtures; demonstrate independent request scheduling and fail-closed state transitions without any engine/data. | Artificial development/testing scope only. |
| 3 — empty-engine cooperative check | Separately reserved empty Stata session, no estimates or participant data, one safe stop test through the proposed bound interface. | New explicit authorization for this live control test; installed-service changes separately approved if necessary. |
| 4 — independent fallback | Owned disposable process tests, handle/creation binding, supervisor survival and verified exit/cleanup; no research fit. | Explicit fallback/operator authorization; no broad kill permission. |
| 5 — operational adoption | Operator-reviewed installation/change record and fresh sealed exact execution contract. | All real author/institutional/scientific/input decisions plus fit-specific authorization. |

The 24 real checkpoint responses remain pending; artificial examples cannot fill them. Previous candidate dispositions, recipes, numerical discrepancies and scientific limitations are unchanged. The future continuity-validation packet remains absent. No benchmark, qualitative component, manuscript, model specification or empirical dataset is changed by this investigation.

## Preservation, audit and handoff

The private packet is `audit-local/intake/wp06-control-investigation-ef49585`; its sibling `-verification/closure.json` records separate-process readback. Entry preservation covers 1,145 tracked files, 20,032 prior private files and all pre-existing workflow pointers. Only this report, the four proposal-folder files and additive updates to the five governance surfaces belong to the public change scope. The sealed private audit/review records are authoritative for final observed counts and pass/fail status; a written proposal alone is not a passing audit.

The source register contains filenames/symbols/digests rather than installed-source copies or sensitive paths. Proposal JSON grants zero fits, participant processing, process kills, service changes and real approvals. All failed attempts and prior packets remain preserved. Nothing is committed, pushed, synchronized, released or sent externally by this workflow.

**Next immediate task:** prepare and test the smallest isolated bound-control adapter against artificial ownership/race/deadline fixtures, after confirming that development scope. Do not deploy it, invoke the live stop route, run a native interruption probe or fit a model under the present authorization.
