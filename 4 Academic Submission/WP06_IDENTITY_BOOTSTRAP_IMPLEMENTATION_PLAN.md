# Artificial Identity/Bootstrap Implementation Plan

> **For agentic workers:** use superpowers:executing-plans inline, test-first, with one fresh final source review. Owner approved the contract and explicitly waived further design checkpoints. No commit, cleanup or live execution is included.

**Goal:** implement captured per-actor identities and authenticated bootstrap, then derive one exact worker target and a controlled legacy-worker view without predicted PIDs.
**Architecture:** additive identity validators and a split-capture bootstrap coordinator reuse existing ABI/resource and legacy supervisor primitives. Only injected artificial external API calls are used. All earlier sources and seals remain unchanged.
**Tech stack:** Python standard library, existing Stage-B modules, unittest, artificial ctypes API fixture, fresh artificial SQLite journals.
**Spec:** `WP06_RUN_ACTOR_TARGET_BOOTSTRAP_CONTRACT.md`, approved by the owner on this turn; its historical pending-review label remains preserved, not overwritten.

## Global constraints

No host probes, actor launches, live control, service changes, Stata, participant processing, real credentials, DLL resolvers, installation, Git mutation, cloud synchronization or release. Preserve every old packet and all eleven prior Python sources. Failure consumes its allocation/challenge/adoption allowance and remains fail-stop. New success is ARTIFICIAL_IDENTITY_BOOTSTRAP_ACCEPTED, never operational acceptance. All work remains in 4 Academic Submission.

## Review focus

- Forged but correctly MACed registrations must match local handle capture, not just a claimed PID: T05/T06/T11.
- State changes, revocation and expired clocks between capture and resume/adoption cannot reanimate a run: T07/T08/T13/T14.
- Actor key isolation must survive bootstrap transcript/frame boundaries; valid C MAC cannot impersonate W: T10/T15.
- Controlled legacy adoption must not be callable with a fabricated dictionary or detach the retained W/authority: T17/T19/T21.
- Partial I/O/closure/registration failure retains every resource and cannot reset a challenge/target/slot: T12/T18/T22/T23.

## Task 1 — exact identities, authority and projection

Create `wp06-stage-b/identity_contract.py`; add ContractTests to `test_identity_bootstrap.py`.
Produces `validate_run(record)`, `validate_actor(record)`, `validate_manifest(record)`, `project_target(run,actor,target)`, `Authority(run,credentials,clock)` and a role-limited Endpoint. Records follow the exact spec fields; signing/verifying uses domain-separated canonical HMACs and exact caller-pinned role IDs. Shared revocation survives deepcopy.

- [ ] Write T01/T02/T17 tests first; missing module assertions must fail without an import error.
- [ ] Run the named tests through the private audit runner; retain RED snapshot/results.
- [ ] Implement validators, authority and eighteen-field projection; compare all projected fields with literal hand-checked expectations.
- [ ] Run contract tests GREEN, then retain result and ledger status.

## Task 2 — split native capture and owned quiescent resume

Create `wp06-stage-b/identity_bootstrap.py`; implement `SplitBackend(api,manifest,capabilities,clock)`, `capture(role)` and `resume(role)`. It subclasses the old backend for resource/I/O helpers but never calls its combined create_process. Actual PID/time come from API outputs; narrow handle, thread/full creator handles and failure resources stay registered. No target binding is fabricated before capture.

- [ ] Write dynamic fake API and T03–T08/T11/T22 boundary tests; run RED before source.
- [ ] Implement fixed CreateProcessW flags/handle list, actual capture, unique PID guards and separate quiescent resume.
- [ ] Verify no ResumeThread before registration checks, no allocation replenishment and resource retention after failure.
- [ ] Run this task GREEN and cumulative old suite; retain all snapshots.

## Task 3 — authenticated bootstrap, roster, target and frame chains

Produces `Bootstrap(manifest,authority,backend,external_anchor)`, `capture(role,grant)`, `registration(role)`, `resume(role,proof)`, connection/challenge/write/read/poll operations, `endpoint(role)`, `roster()`, `admit_target(target,admission)`. Native pipe completion supplies the response bytes. Endpoint only receives its own signing key and fixed verification callbacks. Target envelopes bind both actor digests and direction-specific sequence chains.

- [ ] Write T09/T10/T12–T16/T18/T20/T23 first and retain missing-feature RED.
- [ ] Implement exact domain/scope/role/parent/channel checks, one-use challenge and actual I/O-completion intake, persistent quarantine and monotonic local revocation.
- [ ] Verify all four artificial roles have distinct captured identities, all grants lack PIDs and target sealing follows W capture.
- [ ] Run task and cumulative suites GREEN; retain expected failure paths.

## Task 4 — controlled legacy-worker adoption and composition

Produces Bootstrap's sealed worker adoption method and a guarded Bridge subclass. It derives the legacy W row from the real registry, not test-side insertion, and requires separate target-scoped policy/prearm records. Existing Provider, Supervisor, actors and Journal execute unchanged. Bootstrap completion alone cannot create observed G07/G10 or a durable reservation.

- [ ] Write T19/T21 plus no-prearm/no-application/no-exit promotion assertions first and retain RED.
- [ ] Implement one-use adoption, target provider sharing authority revocation and legacy worker-only registration.
- [ ] Run a single artificial stop composition using a fresh synthetic journal and observed fake event; no additional actor is created or retried.
- [ ] Run all T01–T24 and the complete old 81-test suite normally and optimized. Run the old 17-test inert documentary suite in both modes.

## Task 5 — fresh review, single correction pass and preservation seal

- [ ] Request one fresh read-only whole-change review, supplying this plan/spec/ledger and exact source scope.
- [ ] Reproduce each accepted Important/Critical finding RED, fix in one owner pass, run GREEN plus whole suites. Retain all failures; no second review is implied.
- [ ] Publish an implementation report with actual case-to-test coverage and explicit live/scientific limitations. Append only the five governance surfaces and twelve new pointers; reversible state addition only.
- [ ] Verify baseline tracked/private files, eleven old sources, prior seals, all old pointers and service-source fingerprints. Pin actual tested source snapshots.
- [ ] Seal the new packet and verify in a separate interpreter. Provide proposed commit title/body only; preserve all files and the current checkout.

## Self-review and execution

All twelve spec sections map to the five tasks; T01–T24 remain distinct acceptance obligations. The handoff from run authority to actor capture to target-bound compatibility is explicit. Shared interfaces use exact records, no predicted PID and no replacement generation. A fake external Windows API is necessary because live effects are prohibited; no scientific or policy layer is replaced by a mock.

Owner chose continuous inline execution with no more design checkpoints. This plan is executed in that mode; all actual RED/GREEN runs and rulings live in the new private ledger rather than retroactively changing this plan.
