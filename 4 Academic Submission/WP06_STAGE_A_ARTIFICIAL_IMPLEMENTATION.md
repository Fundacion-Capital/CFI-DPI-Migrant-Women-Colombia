# WP06 — isolated Stage-A artificial implementation

18 October 2026. Scope: the exact [approved Stage-A plan](WP06_STAGE_A_IMPLEMENTATION_PLAN.md), Tasks1–4 and AC01–AC16. The owner's approval is preserved in the restricted successor packet. This report records **artificial implementation evidence only**, not an operating-system control system, real journal durability, independent supervision, engine interruption, research validity or permission to advance.

## Implemented components

- [Journal](wp06-stage-a/journal.py): exact artificial binding validation; current-packet-only SQLite fixtures; explicit DELETE/EXTRA transactions; unique reservation/command claims; forward hash-chained events; restart quarantine; trusted high-watermark rollback rejection; exact schema/constraint checks; corruption diagnostics. Uncertain writes preserve a sibling hold marker that blocks fresh and already-open instances. No automatic reconciliation clears that hold. Duplicate-claim contention is denied without erasing the winner's record.
- [Protocol](wp06-stage-a/protocol.py): bounded canonical ASCII object/string schema, duplicate/unknown-field rejection, exact decimal and digest representations, real HMAC verification using public synthetic keys, role/scope/revocation checks, per-issuer/lease sequence and digest chains, immutable verified records, terminal expiry/rollback and nondecreasing observation timestamps. This is the restricted approved fixture schema, **not a general RFC8785 encoder or production identity system**.
- [Harness](wp06-stage-a/harness.py): trusted in-process fixture registry; current-identity/application lock; journal-before-simulated-effect transitions; integer fake clocks; explicit arm prerequisite; one simulated stop application maximum; separate application, observer acknowledgment, exit, cleanup and quarantine dimensions; no authority elevation. Independent supervision remains a modeled prerequisite, not a separately scheduled component.
- [Tests](wp06-stage-a/test_stage_a.py): exact file/clock/build admission, literal encoding/HMAC vectors, synthetic SQLite and message fault cases, bounded eight-thread claim/cancel fixtures, per-test assertion outcomes, fixture artifact hashes and lifecycle snapshots. No unrestricted repository test discovery.

No network endpoint, Windows pipe, DPAPI operation, service modification, real process registrar/handle, OS process launch/termination, Stata interface or participant reader was added. The code is intentionally bound to the current private fixture packet. After sealing, it refuses further fixture writes; a later authorized successor must preserve a new exact build/contract rather than remove the seal or reuse this packet.

## Artificial evidence and case scope

The normal/optimized run manifests pin the exact four implementation/test files, approved plan and owner authorization **before** fixtures start. Fake time is100 with execution allowance10 and cleanup allowance3, not a real production timeout. Runtime budgets, institutional storage locations, retention and real principal adoption remain unselected.

The final owner build contains **39 new tests passing normally and optimized**, plus **109 passing named predecessor tests**. Sixteen separate artificial case records map the tests, assertions and preserved run receipts to AC01–AC16. The restricted `acceptance_results.json` pins the corrected final build; the final preservation closure remains a separate requirement. Initial candidates/failures remain preserved rather than overwritten.

| Cases | What the synthetic fixtures exercise |
|---|---|
| AC01–02 | Exact ownership schema, trusted fixture registration, malformed arm rejection and stale queued identity replacement. |
| AC03–05 | Unique durable claim observations, consumed command retention, before/after-commit uncertainty, restart/lease quarantine and older-backup fences. |
| AC06–07 | Actual tag validation, tampering, role/scope/revocation/replay, canonical input and proof-chain checks. |
| AC08 | Eight cancellation callers, duplicate delivery denial and zero pre-start dispatch. |
| AC09–11 | Literal109/110 execution boundary, early-stop108 cleanup boundary, no grace/extension, both rollback gates, invalid/extreme integer and clock-domain rejection. |
| AC12–13 | Signed ordered receipt chain; missing/reversed/future/legacy evidence rejection; separately retained exit under unknown cancellation cause; lost-ack/late-result quarantine with no resend. |
| AC14 | Corrupt/truncated/altered-schema fixture rejection; preserved diagnostic copies and persistent uncertainty holds; dispatch blocked on write failure. |
| AC15–16 | Synthetic canaries retained only in restricted originals; allowlisted summaries; successful synthetic completion leaves all live/research/change/release actions denied. |

Original catalogue statuses and all earlier pending institutional/operator responses remain immutable. Stage-A results are a separate successor; AC17–AC28 remain unexecuted. Passing an exception test counts only when the assertions also establish rejection before the forbidden simulated effect. Expected quarantine is not an observed OS process stop.

## Preserved development and limitations

All missing-component RED attempts, first Windows path-length failure, owner gap regressions and subsequent GREEN attempts are retained under `audit-local/intake/wp06-stage-a-implementation-c870e8b/runs`. Owner gap checks exposed and corrected reversed signed timestamps, malformed-arm reopening, unguarded readable schema alteration, incomplete manifest checks and uncertainty bypass through another journal instance. Old candidate results are superseded, never silently presented as the current build. Initial development attempts retain source hashes/logs; later candidate/final runs additionally retain exact source copies. No unavailable early source snapshot is fabricated.

SQLite file readback/backup/rollback fixtures are not power-loss or process-crash durability tests; the hold sidecar is observed fixture persistence, not an independently durable production protocol. Host ACLs, secure key storage, real loaded-module identity, cooperative/native interruption, supervisor survival, transport delay and scheduling guarantees are untested. In-process callers controlling Python internals are outside this fixture trust boundary. Public fixture keys are intentionally not confidential or suitable for production.

The preparation predecessor's deferred exact-file-list/clock validation weakness is addressed in the new build admission tests, without changing its sealed helper. The predecessor's pre-closeout wording chronology remains preserved.

## Final closeout and next boundary

The single independent reviewer passed the earlier38-test candidate independently and rehashed306fixture artifacts, then identified one Important lifecycle defect: cancellation before reservation raised TypeError without closing the controller. Owner reproduced it in final_fix_red and corrected it in the single allowed pass. The final39-test normal/optimized runs verify typed terminal rejection with zero claims/dispatches and no subsequent work. No Critical or Minor finding remained from that review; the corrected build was not independently re-reviewed. This report's final status is artificial-only; operational adoption stays false.

Owner audit, one independent final review and any single correction pass, all normal/optimized final results, preservation seal and separate-process readback belong to the current packet and sibling verification folder. Closure is pending until their immutable receipts exist; a report sentence or candidate PASS is not a substitute.

After bounded Stage-A closure, the next work is an exact Stage-B disposable **non-Stata** process/transport/supervisor design and authorization preflight—not automatic execution. Any process launch, native control, termination, service change or empty-engine stage requires its own explicit scope. No fitting, participant access, scientific adoption, publication or release authority follows.
