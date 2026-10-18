# WP06 — Isolated bound-control adapter and artificial validation

18 October 2026. Baseline `65859db36d43815bd255409c6c9bc90fcadd814d`. This implements only the artificial adapter stage of the [independent-control proposal](WP06_INDEPENDENT_CONTROL_PATH_INVESTIGATION.md). The live execution gate remains closed.

## Deliverable and safety boundary

[The adapter](wp06-bound-control/adapter.py) is a small, standard-library, thread-safe control kernel. It accepts only exact `ARTIFICIAL_ONLY` identities with explicitly artificial tokens, records consumed reservations, validates state transitions and emits stop **intents**. It has no endpoint, signal callback, service import, Stata interface, process launcher or process-killing function. No dependency or service is installed or changed. Merely importing it starts no thread, worker or listener.

[The tests](wp06-bound-control/test_adapter.py) supply artificial clocks and an artificial event channel. The real adapter—not a mocked adapter—processes them. Channel consumption checks ownership under its own lock immediately before setting a test event; queued old-worker intents and duplicate delivery are denied. PID/creation/module fields here are synthetic values, not operating-system attestations. Artificial labels and receipts are not cryptographic authentication or real approval.

The adapter's `DeliveryGate` freezes the trusted artificial intent and rechecks it at consumption; altered deadlines, premature/expired/nonfinite times and changed ownership cannot authorize delivery. The test channel holds its registry lock across that check and event setting. Gate authorization is explicitly distinct from the channel's subsequent artificial event-delivery observation. Trusted registration and authenticated live receipts are not implemented.

A failed or expired consumption permanently quarantines that gate, so a later clock rollback cannot reopen it. Origin and receipt-kind labels require exact strings, preventing custom equality objects from entering the supposedly immutable artificial binding or proof schema. Stop-deadline arithmetic is bounded before the transition and intent count are committed, including extreme finite input values.

The implementation is not a production watchdog. `tick` must be scheduled by a caller; an owned artificial supervisory thread demonstrates that this can happen while another artificial thread is blocked. This does not establish independence from a real server process, native GIL state, host failure or tool transport. `controller_lost` records an artificial loss observation; it does not detect process death.

## Implemented contract

The complete binding contains origin, session, owner nonce, worker generation, command, PID, creation token, module token and reservation. Inputs reject absent/extra fields, non-artificial/default identities, invalid integer types and invalid budgets. Bindings and snapshots are defensively copied. Runtime validation uses explicit exceptions and remains enabled under optimized Python.

An in-memory reservation book consumes both the reservation ID and the session/generation/command key. It never releases them, including after pre-start cancellation or failure. This prevents reuse within that book, including from a second adapter instance. A fresh process/book is not durable authority: cross-process/restart-safe reservations remain unimplemented and cannot support a live fit contract.

`RESERVED → RUNNING_BOUND → STOP_REQUESTED → EXIT_CONFIRMED` is the ordinary cancellation path. Natural artificial completion can go directly from `RUNNING_BOUND` to `EXIT_CONFIRMED`. Unavailable/changed ownership, lost controller, malformed proof, clock rollback or unconfirmed deadline expiry leads to `UNKNOWN_QUARANTINED`. Terminal slots cannot restart or adopt a late result. No state confers fit or release authority.

Execution uses an absolute monotonic-domain deadline armed at reservation, not a fresh budget at start. Equality expires. Stop cleanup is separately bounded: it ends at the earlier of the total execution-plus-cleanup ceiling and stop-intent time plus cleanup allowance. This avoids granting the unused execution budget as extra cleanup time after an early cancellation. Duplicate cancellation emits no second intent and cannot extend the deadline.

An event-delivery receipt is separate from exit and cleanup receipts. Legacy `stop_requested` responses are rejected. Cancellation completion requires ordered exact-bound artificial delivery, exit and cleanup observations; natural completion still requires exit and cleanup. Missing, future, reversed, stale or malformed observations cannot confirm exit. A deadline or ambiguous event never becomes proof of native termination.

## Artificial validation

The named suite exercises ownership-field mutation, schema/type rejection, reservation and command reuse, immutable copies, pre-start cancellation, duplicate cancellation, exact deadlines, clock rollback/nonfinite/overflow values, stale worker replacement before queued delivery, legacy acknowledgment rejection, lost acknowledgment, late success, ordered exit/cleanup, controller loss and terminal-state protection.

Two real-thread fixtures cover an eight-way cancellation race (one intent only) and an artificial controller reaching blocked work without releasing that work. All fixture waits/joins are bounded and owned threads are joined. The blocked-work test explicitly shows that successful control delivery is not work termination; unconfirmed work reaches quarantine at the cleanup deadline.

[Five replayable artificial scenario records](wp06-bound-control/artificial_evidence.json) show natural exit, confirmed artificial cancellation exit, deadline without exit, replacement before delivery and pre-start cancellation. All records are artificial. The [machine-readable contract](wp06-bound-control/contract.json) keeps every live permission at zero.

Initial tests were run before implementation. Boundary review found and reproduced two additional defects: duplicate cancel returned before enforcing cleanup expiry, and an oversized integer receipt leaked a numeric overflow rather than failing closed. Both were corrected through failing-then-passing tests; initial code and failed outputs remain preserved. The authoritative final test count and review disposition are in the sealed private successor packet, not inferred from this prose.

Independent review then reproduced expired-gate reopening after clock rollback and an extreme finite arithmetic transition inconsistency; both were corrected in one tested pass. An origin exact-type gap was also treated as a contract defect and corrected, together with its receipt-kind counterpart. The original reviewed implementation and all failing probes are preserved. This is not an independent re-review of the corrected code; final owner tests and preservation readback provide the correction evidence.

## Preservation and closure

The successor is `audit-local/intake/wp06-bound-control-65859db`, with separate readback in its sibling `-verification` folder. Entry preservation verified the parent seal and covers 1,150 tracked files, 20,063 prior private files, all previous pointers and the three unchanged installed-source files. Only this report, the four new adapter-folder artifacts and five additive governance surfaces are in the public change scope. Earlier packets—including earlier source-fact corrections—remain untouched.

Completion requires named artificial/metadata suites, a fresh independent read-only review, a full post-review preservation audit, final seal and separate-process readback. It establishes an isolated implementation and artificial behavior only. No Stata/MCP execution, participant processing, live stop call, native break, process kill, service/source/config change, commit, push, synchronization or release occurs. All 24 real decision checkpoints remain pending; the future continuity-validation packet stays absent.

## Next gate

Review the isolated implementation and decide the exact scope for a future operational control test. Before any live integration, require a separately authorized implementation/installation plan, reliable consumption-time worker/command ownership checks, authenticated delivery/exit evidence, durable consumed reservations and a genuinely independent supervisor. No live probe or model fit follows automatically from this artificial package.
