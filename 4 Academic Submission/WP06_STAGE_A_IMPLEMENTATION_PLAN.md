# WP06 isolated Stage-A implementation plan

> For agentic workers: use `superpowers:executing-plans` inline, test-first, followed by one independent final review. This is a plan for review, not an executed implementation.

**Goal:** implement and test the selected control components entirely in artificial fixtures, with no callable live-control backend, while preserving all prior packets.

**Architecture:** three small modules: a private fixture SQLite reservation journal; a restricted, authenticated artificial message protocol; and an in-process harness combining trusted fixture registration, integer clocks, journal transitions and simulated delivery/exit/cleanup. An explicit approval boundary separates this plan from future code. Stages B/C, Windows transport and process integration remain absent.

**Tech stack:** existing Python standard library only (`sqlite3`, `json`, `hashlib`, `hmac`, `threading`, `unittest`, filesystem helpers). No installation, dependency upgrade, server, socket, named pipe, real credential store, process supervisor, engine or participant reader.

**Spec:** the preserved [operational integration contract](WP06_OPERATIONAL_INTEGRATION_CONTRACT.md), [acceptance plan](WP06_OPERATIONAL_ACCEPTANCE_TEST_PLAN.md), [approved profile recommendations](WP06_OPERATOR_IMPLEMENTATION_SELECTION_CHECKPOINT.md), and this user's scoped [design-adoption intake](wp06-stage-a-plan/design_adoption.json). Source technical guidance is inherited from the sealed recommendation packet; no fresh host availability claim is made here.

**Status: PLAN_REVIEW_REQUIRED.** The owner approved O01–O07 designs and artificial development. This exact patch plan did not exist at that approval; it requires review before implementation. No AC case has run. The immutable original choices, 24 checkpoint responses and planning catalogue remain unchanged. Real deployment/institutional adoption remains unresolved.

## 1. Scope and constraints

- All binding values, messages, keys, process identities and evidence are synthetic. Fixture PIDs are labels, never queried or acted on.
- Proposed fixture budgets: start `100`, execution allowance `10`, cleanup allowance `3`, all integer **artificial clock ticks represented as nanoseconds**. They are not real scheduling/resource budgets. Production budgets stay null.
- No real clock reads, sleeps, worker launches, service/source edits, live control, OS process enumeration, key provisioning, ACL inspection, Stata or participant processing.
- No tests outside explicitly named metadata/artificial suites; no discovery that could load research files. All Python runs use `-B` to avoid modifying predecessor caches.
- All scratch databases, rejected messages and fault evidence belong in a new ignored successor packet, outside every predecessor packet. Preserve them, including failures. No cleanup/delete to hide incomplete work.
- A synthetic fixture store inside the ignored packet is an **explicit Stage-A exception**, not approval of a production active store inside Git or synchronized storage. It contains no real secret or participant data. Real storage/retention/access choices remain unverified.
- Canonicalization covers a deliberately narrow, exactly validated ASCII object/string wire schema, not a general RFC 8785 implementation. Integers travel as canonical decimal strings. Reject floats, duplicate keys, unknown fields, Unicode outside the chosen ASCII grammar, excessive size/depth, malformed decimal representations and invalid tags. Any later wider JSON schema requires a separately reviewed canonicalizer and vectors.
- Roles, keys and registrations come from a fixed trusted fixture registry, never from an incoming message or caller's approval boolean. These fixtures do not authenticate humans or Windows principals.
- Counters for live probes, Stata, fitting, participant processing, termination and release stay zero. A test PASS cannot modify those gates.

## 2. Files and caller reach

Create only these future public implementation files under `4 Academic Submission/wp06-stage-a/`:

| File | Responsibility |
|---|---|
| `journal.py` | Unique transactional reservations, forward-only event records, readback/restart quarantine and injected-fault boundaries. |
| `protocol.py` | Exact artificial wire schema, canonical encoding, HMAC verification, role/scope/revocation/sequence and message-chain checks. |
| `harness.py` | Trusted fixture registry and lock, integer-clock lifecycle, journal/protocol integration and simulated event sink. No engine or OS control adapter. |
| `test_stage_a.py` | AC01–AC16 fixtures, assertions on real component effects and negative-side-effect checks; bounded thread teardown. |

Future private successor packet: `audit-local/intake/wp06-stage-a-implementation-<entry-head7>/`. Build pins, fake inputs, journal directories, rejected/fault artifacts, test results, review and seal live there. Capture its exact path and code digests before testing. Do not create it in this preparation packet.

No existing adapter, service, contract, test fixture or predecessor is modified. Existing public callers cannot call the new harness automatically: there is no endpoint, CLI dispatch route, plugin registration or installed-service import. After implementation, the five established governance surfaces may append the new evidence/status; existing entries remain historical.

## 3. Shared interfaces and trust boundaries

**Binding:** exact frozen fields: `origin, contract_digest, build_digest, host_id, boot_id, session_id, owner_nonce, worker_epoch, command_id, pid, creation_time, engine_module_digest, reservation_id, lease_id, scope_id, clock_domain`. Origin must be exactly `ARTIFICIAL_ONLY`. Token-valued identifiers use bounded ASCII `ART_` tokens; digest fields instead use lowercase SHA-256 hexadecimal strings, as specified below. Internal `pid`/`worker_epoch` are exact positive integers (not booleans); no path, code, participant field or arbitrary text is accepted. Trusted fixture registration supplies the binding and freezes a copy. Wire integers are canonical decimal strings, with conversion only after exact validation.

**Journal interface:** `Journal(path, expected_watermark)`; `reserve(binding) -> reservation_receipt`; `append(binding, kind, metadata) -> event_receipt`; `recover() -> quarantined_ids`; `snapshot() -> typed_metadata`. Only fixture paths under the current packet are accepted by the harness. `BEGIN IMMEDIATE`, rollback `DELETE`, `synchronous=EXTRA`, timeout zero and unique indexes on reservation ID and `(host_id, boot_id, session_id, worker_epoch, command_id)`. No retry of a claim. Event history is append-only; closing, failure or recovery never frees a claim. An error or uncertain commit freezes the harness before any dispatch. Coherent backups and high-watermark fixtures are integrity/recovery evidence, not actual power-loss durability.

**Protocol interface:** `encode(record) -> bytes`; `sign(record, credential_id, fixture_registry) -> envelope`; `Verifier(registry).consume(envelope, expected_binding, expected_kind, now) -> frozen_record`. Input is bounded serialized bytes, with duplicate-key detection before constructing a dictionary. Tag length/type checked before constant-time comparison. Verify the entire validated body, role/credential/scope, sequence, previous digest and lease. Revoked, old, unknown or wrong-role keys fail before event application. Each scope/role key is a distinct public synthetic fixture, not a real credential. Verifier keeps replay and terminal expiry/rollback state; caller-supplied evidence labels never constitute proof.

**Harness interface:** `Harness(journal, trusted_fixture_registry, clock)`; `reserve(binding, execution_ns, cleanup_ns)`; `arm(binding, clock_domain)`; `dispatch()`; `cancel()`; `tick()`; `receive(envelope)`; `snapshot()`. All budgets/timestamps are bounded exact integers, excluding bool, floats, NaN/Inf and coercible objects. Retain an immutable total ceiling. No automatic arm, implicit grace or budget extension. Under one registration/application lock, verify current binding and consume one simulated control event at most. Unknown acknowledgment/delivery/outcome stays quarantined. Receipt validation and journal transitions precede exposing a successful returned disposition.

**Exact fixture limits:** identifiers use `ART_[A-Z0-9_]{1,60}`; serialized input is at most 8,192 bytes, nested at most four object levels, with no arrays. Clock values and positive budgets fit `0..9223372036854775807`; validate sums before committing any transition. Wire integers match `0|[1-9][0-9]*` with the same upper bound; numeric binding fields remain positive. Signature/digest encodings are exactly 64 lowercase hexadecimal characters. The outer envelope has only `body` and `tag`; body fields are exactly `kind, binding, sequence, previous_digest, timestamp_ns, issuer, credential_id, reason, payload_digest, result`. Sequence begins at 1 per lease/issuer, with 64 zeroes as the first previous digest; subsequent events require the exact prior canonical-body SHA-256. `ART_CONTROL` may issue only `ART_STOP_INTENT`; `ART_OBSERVER` may issue only `ART_STOP_APPLIED`, `ART_EXIT_OBSERVED`, `ART_CLEANUP_OBSERVED`. Binding and clock domain are checked against trusted registry state, not copied into trust from the body. Reason is always `ART_FIXTURE`. The exact kind/result map is `ART_STOP_INTENT:ART_REQUESTED`, `ART_STOP_APPLIED:ART_APPLIED`, `ART_EXIT_OBSERVED:ART_EXIT`, `ART_CLEANUP_OBSERVED:ART_CLEANUP`. Public summaries have only `origin, case_id, status, assertion_count, dispatch_count, stop_intent_count, stop_applied_count, quarantined, live_authorities`; no body/key/tag/raw-output passthrough. The retained synthetic envelope is the restricted diagnostic original.

**Field-specific wire rules:** `origin` is the literal `ARTIFICIAL_ONLY`; `pid` and `worker_epoch` are positive canonical decimal strings; `contract_digest`, `build_digest`, `engine_module_digest`, `previous_digest` and `payload_digest` are 64 lowercase hexadecimal characters, never `ART_` tokens. All other binding fields are bounded `ART_` tokens. In particular, `creation_time` is an opaque fixture token such as `ART_CREATED_1`, not a measured Windows creation timestamp. The three binding digests are SHA-256 hashes of the literal ASCII fixture strings `ART_CONTRACT_FIXTURE_V1`, `ART_BUILD_FIXTURE_V1`, `ART_ENGINE_FIXTURE_V1`; they are intentionally synthetic, not evidence of the actual installed engine or accepted runtime. Actual future code/contract build pins are separate preservation metadata and may not be substituted into live identity claims.

**Exact canonical bytes:** validate the bounded ASCII-only object/string schema first. Recursively sort object keys by ASCII code-point order; serialize every string with JSON double quotes, without whitespace, UTF-8 BOM or trailing newline. Allowed string values contain only the stated token/decimal/hex/enum characters, so no escaping is needed and ASCII order agrees with the relevant JCS key order. Arrays, JSON numeric literals, booleans, null, control characters, escapes and duplicate keys are rejected in incoming wire bytes. Reject noncanonical serialization rather than silently verifying a different byte representation. HMAC-SHA256 covers exactly these canonical **body** bytes, excluding the outer envelope and its tag. The outer envelope is independently validated and serialized with the same recipe; its tag is the 64-character lowercase hexadecimal HMAC. `payload_digest` is SHA-256 of the canonical ASCII object `{"action":"<kind>"}` with the already validated fixed kind substituted; for stop intent the exact bytes are `{"action":"ART_STOP_INTENT"}`. There is no separately supplied arbitrary payload. `previous_digest` hashes the previous canonical body, not its outer envelope/tag; the first event uses 64 zeroes. This is a restricted fixture schema, not a general RFC 8785 encoder or a production-security claim.

### Valid synthetic body example

The example below uses wire-string integers, synthetic fixture hashes and first-event chain values. For a complete fixture envelope, sign its canonical body with the public synthetic key bytes `ART_CONTROL_KEY_FIXTURE_ONLY`, then place that body and lowercase hexadecimal tag in the exact outer fields `body` and `tag`. This fixture key has no production use or confidentiality claim.

<!-- STAGE_A_WIRE_EXAMPLE -->

```json
{
  "kind": "ART_STOP_INTENT",
  "binding": {
    "origin": "ARTIFICIAL_ONLY",
    "contract_digest": "c2031cdd3bb5e408531618a46ac46102b6b8bf0e7279f475c4d7d80d2ec2960d",
    "build_digest": "46c60158585a283de3a9ea67a081e5c509b39d3e1a85c04e92f3b8315d7faefb",
    "host_id": "ART_HOST_1",
    "boot_id": "ART_BOOT_1",
    "session_id": "ART_SESSION_1",
    "owner_nonce": "ART_OWNER_1",
    "worker_epoch": "1",
    "command_id": "ART_COMMAND_1",
    "pid": "1234",
    "creation_time": "ART_CREATED_1",
    "engine_module_digest": "8dab5dc5f45075ad65bdcc0f56ec14a4f896d55c891a942c49d7061530eb2193",
    "reservation_id": "ART_RESERVATION_1",
    "lease_id": "ART_LEASE_1",
    "scope_id": "ART_SCOPE_A",
    "clock_domain": "ART_CLOCK_1"
  },
  "sequence": "1",
  "previous_digest": "0000000000000000000000000000000000000000000000000000000000000000",
  "timestamp_ns": "105",
  "issuer": "ART_CONTROL",
  "credential_id": "ART_CONTROL_KEY",
  "reason": "ART_FIXTURE",
  "payload_digest": "429186d13df60ea5731ec5bae8e8012b5d85a7bb6812549b19f394ae0da45fc3",
  "result": "ART_REQUESTED"
}
```

No method performs native work. The fake event sink records `ART_DISPATCH`, `ART_STOP_APPLIED`, `ART_EXIT_OBSERVED`, `ART_CLEANUP_OBSERVED` only after their preconditions. It must not call arbitrary callbacks supplied by messages. Independent supervision is a **modeled prerequisite**, not an independently running supervisor. AC17–AC28 remain unexecuted.

## 4. Review focus

1. A lost/uncertain SQLite commit cannot become permission to dispatch or reuse an ID: persisted readback and no-dispatch assertions in AC03–05/14.
2. A correctly signed but stale/wrong-role/revoked message cannot pass ownership/application gates: AC02/06–08 and exact simulated-effect counts.
3. Expiry followed by rollback, extreme integers, booleans and malformed numeric strings cannot reopen either controller or consumer: AC09–11.
4. Missing/reordered/future receipts or an observed exit cannot become confirmed cancellation/cleanup: AC12–13, independent status dimensions.
5. An all-green artificial suite cannot grant live/kill/research authority or disclose synthetic sensitive canaries: AC15–16 and immutable old-gate readback.

## 5. Implementation tasks — all pending

### Task 1 — Transactional fixture journal

Files: `journal.py`, `test_stage_a.py`. Consumes frozen synthetic bindings and explicit current-packet fixture paths. Produces durable unique reservation receipts and forward-only event/recovery metadata for Task 3.

- [ ] Write AC03–05/14 tests first. Two connections/eight callers claim the same reservation and command: one winner, all others denied, no second dispatch. A new reservation cannot reuse the consumed command. Read committed claims through a fresh connection.
- [ ] Inject failures before reserve commit, after reserve/before dispatch, after dispatch intent with missing acknowledgment, and during stop recording. Assert zero resend and preserved uncertainty. Do not label an uncommitted record as durably committed.
- [ ] Restart from old nonterminal records: preserve consumed IDs, quarantine them and fence old leases. Restore an older coherent backup against a separately sealed higher watermark: deny continuation. Preserve both snapshots; do not overwrite a source packet.
- [ ] Corrupt/truncate only a disposable fixture copy; inject write/commit errors through a narrow fixture fault boundary. Preserve original bytes and diagnostic copies and assert zero dispatch. No OS permission or service manipulation.
- [ ] Run RED, retain complete failure output; implement minimal journal; run GREEN. State exact observed commit/recovery guarantees and limits. Thread waits/joins must be bounded with teardown even on assertion failure.

Expected: missing implementation causes the initial tests to fail; finished tests prove the component's observable journal and no-dispatch effects, not only SQLite's documented behavior. No power-loss/process-crash acceptance is claimed.

### Task 2 — Authenticated artificial protocol

Files: `protocol.py`, `test_stage_a.py`. Consumes frozen binding schema and fixed role/scope fixture registry. Produces verified, frozen messages and consumed sequence/chain state for Task 3.

- [ ] Write AC01/06–07/15 tests first: exact schema, missing/extra/mutable identities, default/shared IDs, duplicate JSON keys, oversized/deep input and no hidden type coercion.
- [ ] Pin independently hand-checked ASCII canonical bytes and decimal-string cases, including values above IEEE754's exact-integer range. Use HMAC known-answer vectors separately from encoding tests; do not generate both expected and actual tags with the same code under test.
- [ ] Tamper every binding field, kind/body/digest/issuer/role/credential/sequence/previous digest/tag. Verify actual cryptographic rejection before any effect. A real signature from a revoked/wrong-scope or untrusted credential is still denied. Public fixture keys cannot imply production security.
- [ ] Test replay after consumed delivery, terminal expiry then clock rollback, stale lease and re-registration. Once closed/expired, no smaller timestamp reopens the consumer.
- [ ] Use artificial sensitive canaries only: reject prohibited/unknown input fields; public summaries use an allowlist while restricted originals stay in the new fixture packet. No raw messages, tags/keys, arbitrary command text or canaries in public summaries.
- [ ] Preserve RED then GREEN outputs. Implement only the restricted schema; no general canonicalizer, Windows pipe, DPAPI call, actual principal lookup or real key provisioning.

### Task 3 — Integrated synthetic lifecycle

Files: `harness.py`, `test_stage_a.py`. Consumes Tasks 1–2 interfaces. Produces a staged synthetic event history with separate reservation, dispatch, stop application, exit, cleanup and quarantine dimensions.

- [ ] Write AC02/08–13 tests before implementation. Queue an old intent; replace the fixture worker under the same session. Current binding must be rechecked atomically before effect, including command, generation, boot, PID/creation and lease; no check/action gap.
- [ ] Eight cancel callers plus duplicate delivery yield one stop intent/application maximum. Cancel before dispatch consumes the slot and dispatch count stays zero. Do not infer native break acceptance from a fake event.
- [ ] With fake start `100`, execution `10`, cleanup `3`, natural completion at `109` may be observed; at `110` execution is expired. Early stop at `105` gives cleanup deadline `108`, not `113`; equality expires, duplicate cancellation cannot extend it.
- [ ] Exercise expiry→rollback separately at controller and consumer, integer upper bound, out-of-range values, bool/float/NaN/Inf and invalid strings. No transition/count may advance unless its exact intent is recorded and returned. Reject clock host/boot/domain changes or unknown translation before arm/dispatch.
- [ ] Require exact signed event kind/binding/sequence and ordered timestamps. Reject missing/reversed/future delivery/exit/cleanup, legacy acknowledgment and registry absence as proof. Preserve observed exit separately when cancellation cause or cleanup is unknown.
- [ ] Lost ack, late stop, late numerical/success response and stale worker response stay consumed/quarantined; no second break, retry, replacement dispatch or late-output adoption.
- [ ] RED→GREEN and integrated AC01–AC16 fixture run. Record separate negative rejection-before-effect evidence; do not count a raised exception after a forbidden effect as a passing case.

### Task 4 — Authority fence and final artificial audit

Files: `test_stage_a.py`, new private build/result manifest and report; five additive governance surfaces after results exist. No predecessor implementation edits.

- [ ] AC16: even when all synthetic cases pass, live service/probe, process termination, engine execution, fit, participant and release requests remain denied. No callable implementation of those actions exists.
- [ ] Pin exact files, current-packet paths, artificial fixture manifest and accepted scope **before** fixture execution. Leave all production budgets/paths/retention unknown. A changed build requires a new preservation record, not a silent replacement.
- [ ] Execute AC01–AC16 only after exact-plan approval. Each separate result record has case ID, build/fixture pins, stimulus, observed rejection/effects, assertions/log references and limits. Mark a case PASS only from verified assertions. Failure stays FAIL_PRESERVED; skipped/missing prerequisites stay BLOCKED, not PASS. Original catalogue remains immutable/NOT_EXECUTED.
- [ ] Run new suite normally and with `-O`, plus the 109 named predecessor tests. Capture logs, failure counts and bounded thread cleanup; no broad test discovery or engine/runtime probe.
- [ ] Independent final read-only review; one owner RED→GREEN correction pass for Important/Critical findings, preserve all attempts. Rehash every baseline tracked/private file and old pointer, check only allowed paths changed, seal and separate-process readback.
- [ ] Supply proposed full commit title/body only. No automatic commit, push, Overleaf/Dropbox sync, deployment or move to Stages B/C.

## 6. AC01–AC16 evidence crosswalk

| Case | Owner task | Required observable evidence |
|---|---|---|
| AC01 | 2 | Malformed/unowned binding rejected with reservation/action counts zero. |
| AC02 | 3 | Queued old generation denied under current-registration lock; effect count zero. |
| AC03 | 1 | One committed unique winner; no terminal slot release or command-ID bypass. |
| AC04 | 1,3 | Each injected crash-window fixture preserved; unknown state never resent. |
| AC05 | 1,2 | Restart quarantine and old lease/replay rejection. |
| AC06 | 2 | Actual tag/body/issuer verification fails before effect for tampered input. |
| AC07 | 2 | Revoked/wrong-role/scope/old-lease proofs rejected; no extension or replay. |
| AC08 | 3 | Eight-way cancellation one application maximum; pre-start dispatch zero. |
| AC09 | 3 | Literal 109/110 and early-stop 108 boundaries; no hidden grace/extension. |
| AC10 | 2,3 | Both expiry→rollback gates terminal; invalid/extreme numeric inputs cannot miscount. |
| AC11 | 3 | Unknown delay/boot/domain mismatch blocks arm and dispatch. |
| AC12 | 3 | Missing/reordered/future events never fabricate delivery, exit or cleanup. |
| AC13 | 3 | Lost ack/late events remain quarantined with no retry or adopted output. |
| AC14 | 1 | Fixture corruption/uncertain writes block dispatch; original and diagnostic bytes preserved. |
| AC15 | 2 | Canary/unknown fields excluded from allowlisted public summary, originals retained. |
| AC16 | 4 | Artificial PASS leaves every live/research/change/release gate closed. |

## 7. What approval of this plan would mean

It would authorize Tasks 1–4 **only** with synthetic fixtures and private fixture files, no retries of historical fits and no live integration. It would not approve production budgets, storage paths, named institutional principals, service changes, Windows pipe/key/process operations, AC17–AC28, scientific decisions or participant access. No production deployment instructions or native control mechanism will be added.

The alternative is to revise this plan before writing code. In particular, if the owner wants only a narrower journal-only first slice, Tasks 2–4 must remain explicitly pending rather than being claimed as a full Stage-A implementation.

## 8. Current preparation closeout

This preparation records the user's seven design approvals, pins the original recommendations/catalogue and makes the complete implementation boundary reviewable. It does not execute any task above. Preparation metadata/preservation checks, the named predecessor suite, independent review, seal and separate readback are recorded in `audit-local/intake/wp06-stage-a-plan-3288dd1` and its sibling verification packet. Their success is documentary closure only.
