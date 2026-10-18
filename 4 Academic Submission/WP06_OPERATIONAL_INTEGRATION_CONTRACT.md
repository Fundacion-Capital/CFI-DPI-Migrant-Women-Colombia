# WP06 — Bounded operational integration contract

18 October 2026 · `WP06_OPERATIONAL_INTEGRATION_V1` · Baseline `f3e3e1685b4462cd133f213fe74a5d2eb829ff96`.

## 1. Status, scope and authority — C01/C12

This is a **normative integration contract for a future implementation**, not a running integration, approval, executable deployment manifest or fit contract. The companion [acceptance plan](WP06_OPERATIONAL_ACCEPTANCE_TEST_PLAN.md) defines tests that have **not been executed**. The [machine-readable contract](wp06-operational-contract/contract.json) and [case catalogue](wp06-operational-contract/acceptance_plan.json) make that distinction explicit.

Current permission is documentary preparation and named artificial/metadata validation only. Service changes, live probes, Stata execution, participant processing, live stops, process termination, fitting and release all remain zero. No new principal decision or approval is supplied. The existing 24 responses remain pending in [the preserved checkpoint template](wp06-remediation/response_template.json). D5 operational evidence and D1 rights/privacy evidence are relevant prerequisites, not approvals inferred from their presence in a template.

The [isolated adapter](WP06_ISOLATED_BOUND_CONTROL_ADAPTER.md) remains unchanged. Its in-memory book, caller-scheduled checks, artificial receipt labels and test-thread independence are **not** the durable journal, trusted registrar, authentication system, independent process supervisor or operating-system proof specified below. Neither this package nor an all-green test suite can authorize a model fit. Scientific, institutional, input, manuscript and release decisions remain separate.

## 2. Components and trust boundary — C02/C04/C07

The proposed integration has five distinct responsibilities, even if an approved implementation later combines some code:

| Component | Required responsibility | Must not substitute for it |
|---|---|---|
| Trusted registrar | Bind the exact owned worker, current generation, installed build and process handle to one scope | Session string, caller-supplied PID or old module/path receipt |
| Durable reservation journal | Commit consumed attempt/command identity before work dispatch; fence every restart | An in-memory set or successful API response |
| Independent supervisor | Arm before work, own the deadline and survive blocked client/worker request paths | A coroutine on the same blocked request loop, or a caller invoking `tick` |
| Bound control consumer | Authenticate and atomically recheck the current worker/command before one stop application | Default targeting, stale queued events or a second unbound native break |
| Evidence verifier/operator | Verify ordered authenticated events and independently observed exit/cleanup | A signature field, `stop_requested`, ready replacement or registry absence |

Authentication must establish an authorized principal, scope and non-replayed message—not merely a nonempty token. Provisioning, verification, expiry and revocation are part of the selected implementation. No keys, secrets, transport or signing scheme are created here. The supervisor's independence must be demonstrated against blocked dispatch/control responses, not assumed from a separate thread name. Loss of the client/controller must be detected without its voluntary `controller_lost` call.

## 3. Frozen registration and interface envelope — C02/C05

A registration is scoped to one approved build and host boot. Its exact binding consists of:

`contract_digest, build_digest, host_id, boot_id, session_id, owner_nonce, worker_epoch, command_id, pid, creation_time, engine_module_digest, reservation_id, lease_id, scope_id`.

The registrar must obtain process identity through a trusted owned-handle/registry path and fresh observations. Default, shared, unknown and unowned workers are prohibited. The owner nonce must be provisioned through that trusted registration; the artificial `ART_` convention is not authentication. The consumer must recheck generation, command and process identity at application time, under the relevant registration/ownership lock, without a gap in which replacement can become the target. A same-session restart is a new worker, never continuity of the old attempt.

The build record must distinguish approved installed/source digests, actual fresh worker/module observations and any unavailable loaded-code attestation. A directory/version label or disk hash alone is not proof of already-loaded bytecode. Unavailable required provenance blocks adoption; it is not filled from a historical worker's receipt.

The logical interfaces are records—not executable routes—in this contract:

| Record | Required effect in a future implementation |
|---|---|
| REGISTERED | Trusted binding and scope established; no work yet |
| RESERVED_DURABLE | Reservation/command claimed by a committed transaction |
| SUPERVISOR_ARMED | Independent owner/lease/deadline confirmed before dispatch |
| DISPATCH_INTENT / DISPATCH_OBSERVED | Distinguish committed intent from confirmed receipt/application |
| STOP_INTENT / STOP_APPLIED | Distinguish requested control from exact-bound application |
| ENGINE_EXIT_OBSERVED | Independently establish the same process/command's outcome |
| CLEANUP_OBSERVED | Account separately for owned processes, queues, partial artifacts and supervisor |
| UNKNOWN_QUARANTINED | Preserve unresolved/failed attempts; no resend, restart, relabel or late-result adoption |

There is no public port, callable URL, Stata command, participant-data destination or installation instruction in these records. Future Stata probe dispatch must use the approved MCP execution path under separate authorization; an independent control transport itself requires explicit operator adoption, not an ad-hoc unauthenticated bypass.

## 4. Durable reservation and crash contract — C03/C09

The selected store must atomically enforce uniqueness for reservation ID and host/boot/session/generation/command, with an append-only or equivalently auditable forward history. A committed reserve precedes both supervisor arm and work dispatch. A successful reply without durable commit is insufficient. The implementation must specify its durability guarantees, corruption checks, concurrency behavior and recovery procedure before adoption.

Crash windows have distinct dispositions:

| Window | Required recovery |
|---|---|
| Before confirmed reserve commit | Never dispatch; unresolved commit must be reconciled, not guessed absent |
| After reserve, before dispatch | Slot remains consumed, even if work apparently never started |
| Dispatch sent, response lost | Execution unknown; do not resend or create a replacement attempt automatically |
| Stop recorded, delivery unknown | Intent record is not evidence of an applied break; no duplicate break |
| Controller/journal restart | Fence old leases and quarantine every old nonterminal/uncertain attempt |
| Truncated/corrupt/missing journal | Block dispatch and preserve both original and diagnostic copy |

Retries are zero. Idempotent readback may return the existing disposition, but it must not reapply a command. New IDs cannot silently bypass a consumed command. A subsequently authorized attempt requires a new explicit reservation/contract; it does not rewrite the old one. Recovery and rollback of a future software installation must retain the consumed journal, not restore a backup that reopens slots.

## 5. Deadline and clock contract — C06/C07

Arm an absolute execution deadline before dispatch. Cleanup ends at the earlier of the approved total ceiling and stop time plus its separately approved allowance. Equality expires. No implicit five-second grace, fresh budget on late receipt, duplicate-cancel extension or unbounded shutdown wait is allowed.

Each monotonic timestamp must name its host/boot/clock domain. Never subtract timestamps from incomparable domains or treat UTC as an execution clock. The operator must establish a common domain or a conservatively bounded translation/transport scheme before arming. Unknown delay, reboot/domain change, rollback, nonfinite values and unsafe arithmetic block or quarantine the attempt. Extreme finite inputs must not commit a transition/count without its corresponding returned/recorded intent.

The controller and consumer each retain terminal expiry/rollback state. Once expired or quarantined, a later smaller clock reading cannot reopen either gate. The independent supervisor must still enforce the deadline if the request loop, worker queue, client or response channel is blocked. Exact production budgets and delay bounds are deliberately unselected in this document; artificial values such as 100/110/113 are tests, not resource allocation.

## 6. Control and evidence contract — C04/C05/C08

Authenticated canonical records cover the entire binding, event kind, sequence, previous-event digest, clock domain/time, issuer, credential identifier, payload digest and result. The common receipt fields are enumerated in the JSON contract. Authentication proof references are not accepted merely because a field exists; the selected verifier must actually validate provenance, content and revocation against the registered principal. Public material must never contain a secret credential.

The consumer checks a frozen, authenticated intent and current registration atomically immediately before action. At most one native break may be applied per command. A rejected, expired, malformed or replaced-worker gate cannot be reopened by replay or a new timestamp. Pre-start cancellation consumes the slot without dispatch. Applied control is a distinct observation from request acknowledgment. An await timing out is not evidence that its background operation ended; delayed delivery must be fenced from both expired and replacement commands.

For natural completion, require registration/reserve/arm plus exact-command exit and cleanup evidence. For a cancellation path, additionally require independently verified STOP_APPLIED before claiming a confirmed stopped outcome. Missing delivery proof may coexist with an observed process exit, but the cancellation cause remains unknown: preserve the exit observation without upgrading the whole attempt to confirmed cancellation. A late numerical or successful response cannot change a consumed/quarantined disposition.

Status, engine outcome, delivery, exact-process exit, cleanup, journal integrity and scientific validity are separate dimensions. `STOP_INTENT_RECORDED`, `STOP_APPLIED`, `ENGINE_EXIT_OBSERVED`, `CLEANUP_CONFIRMED` and `UNKNOWN_QUARANTINED` must not be collapsed into one success boolean. Evidence from a replacement worker is never attributed to the original.

## 7. Cleanup, fallback and preservation — C09/C11

Use cooperative control once first. An owned-process fallback requires its own exact-target grant and acceptance evidence; approval for an empty-engine probe or software adoption does not imply termination permission. No process-name search, numeric PID alone, default session, shared worker, broad process tree or automatic restart may be targeted. If the chosen owned-handle/containment mechanism cannot be proved safe, fallback stays unavailable.

Bound cleanup independently; account for the original worker, supervisor, control channel, locks/queues and partial output locations. Registry absence or a newly ready worker is not original-process exit. Forced termination can make IPC/state uncertain; quarantine those resources rather than reconnect/reuse them. Unknown exit or cleanup remains explicit and blocks adoption. Preserve original packets, failed attempts, raw operational receipts and reason-coded diagnostics in restricted storage; do not delete to make the inventory look clean.

## 8. Metadata and disclosure — C10

Permit only typed control metadata: version/digests, binding IDs, roles/credential IDs (not credentials), event sequence, clock domain and numeric times, reason/status codes, non-identifying counts and restricted evidence references. Exclude arbitrary Stata code, participant identifiers or records, dataset paths, raw stdout/stderr, raw commands, credentials and model outputs from public control receipts. Unknown fields are rejected rather than copied through. Public summaries require a redacted allowlist; original sensitive operational evidence, if later produced, stays restricted.

The current package contains no participant content. Future privacy tests use artificial canaries only. No Dropbox access, copied raw data, manuscript edits or empirical processing is needed for this contract.

## 9. Open implementation selections and adoption — C12

Seven operator/institutional selections remain open in the JSON contract: **O01 durability store; O02 authenticated transport/proof lifecycle; O03 supervisor/owned fallback; O04 registration/build and change procedure; O05 numeric budgets/clock bounds; O06 acceptance scope/principals; O07 restricted evidence/retention policy.** No technology, principal response or evidence reference is silently filled. These choices are completion prerequisites for a future operational implementation, not missing content disguised as a functioning system.

Resolve them against D5 operational and D1 rights/privacy checkpoints with decision-maker, date, scope, evidence and affected build. This package does not amend the 24 pending responses or claim their missing fields are now complete. Separate service/configuration change approval is required for any proposed installation; separate disposable/empty-engine/termination scopes are required for corresponding probes. The exact intended build, target inventory, budgets, no-retry rule and preservation destinations must be sealed before a future run.

The next immediate task is the **operator implementation-selection checkpoint**: record these seven selections or explicitly defer them, then prepare the corresponding isolated implementation patch plan. No live probe, engine execution or model fit follows automatically. Operational adoption can cover only the accepted control build and scope; later research fitting/data access requires its own gates and explicit authorization.

## 10. Validation and preservation boundary

[The documentary checker](wp06-operational-contract/check_package.py) validates schema, requirement coverage, case staging, pending choices and zero authority. It does not authenticate operational evidence, inspect a running service, validate prose semantics or execute acceptance cases. Its output must remain `DOCUMENTARY_VALIDATION_ONLY` with operational eligibility false. Its own unit tests are different from the 28 planned acceptance cases.

The private successor is `audit-local/intake/wp06-operational-contract-f3e3e16`; final audit/review/seal and separate sibling readback provide the closure evidence. Prior adapter code, tests, contracts and packets stay immutable. Changes are limited to these two documents, the four new package artifacts and five additive governance surfaces. A passing preparation audit is neither operational acceptance nor scientific approval.
