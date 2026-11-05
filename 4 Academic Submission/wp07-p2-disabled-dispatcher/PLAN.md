# Disabled P2 successor implementation plan

> Implement inline with test-first checks and one independent read-only review.

**Goal:** Implement the audited reader/dispatcher and fixed-file transport
successor as an artificial-only, disabled package.

**Architecture:** Reuse the pinned pure legacy reader and artificial receipt
generator. Bind only the exact sources in the accepted BINDINGS.json. Prepare
immutable byte buffers once, pass compact single-use references to those same
buffers, and keep the four aggregate stages separate from five artificial cases.
No native provider or live activation interface is added.

**Tech stack:** Python 3.11.15 standard library; no new dependency.
**Spec:** ../wp07-p2-reader-requalification/README.md, BINDINGS.json and
MIGRATION_MAP.csv, accepted for this next implementation by the owner's request.

## Constraints and scope

- Add files only in this directory; preserve all existing tracked files and packets.
- No Stata/worker execution, participant/model loads, scoring, fitting, settings,
  services, contacts, commit, push, synchronization or unheld Stata file writes.
- C2 HOLD; native NOT_RUN; no scientific or release adoption.
- Existing 45/180/30/210-second limits are artificial aggregate simulation values
  only, not adopted participant limits or an artificial-case execution budget.
- Fixed-file means source bytes are checked once and retained in memory. The
  descriptor carries identity/size/sequence, not source text or an arbitrary path.
- No general callbacks or live transport accepted. Fake case records are supplied
  by tests, never manufactured from expected facts by the dispatcher.

## Review focus

1. A modified source or forged prepared buffer must fail before fake selection.
2. An invalid/replayed/cross-track descriptor must close its fake channel.
3. Corrected receipts must pass the real parser; old/stale receipts must fail.
4. A held entry or wrong-location negative failure must not count as a case pass.
5. Empty/fresh case metadata is consistency only, not native provenance or cleanup.

## Tasks and interfaces

### 1. Exact loader and same-buffer transport

Create successor.py and test_successor.py. Interfaces: prepare(track) returns a
frozen Prepared object; FixedFileFixture(prepared, ...) consumes only that object;
reserve()/select(reference, deadline) pass a compact single-use reference.

- [x] Write source-admission, payload, reference, handoff and mutation tests.
- [x] Run the named checker and observe the missing implementation fail.
- [x] Implement pinned imports, immutable buffers and the artificial-only transport.
- [x] Rerun and require the loader/transport tests to pass.

### 2. Aggregate dispatcher and independent case reader

Interfaces: dispatch_aggregate(prepared, fixture) validates P1-P4 artificial
receipts; dispatch_cases(prepared, fixture) validates A1-A5 supplied metadata.
Both reject a different transport class, track, order, payload or second use.

- [x] Add success, malformed receipt, deadline, cleanup, case-hold, range-location
  and stop-without-retry tests before implementing those interfaces.
- [x] Implement only these offline routes using the preserved validators.
- [x] Require all tests to pass; trace/log records contain metadata only in memory.

Task 1: initial missing-implementation test failed as intended; four initial
checks passed after implementation. Task 2: missing routes and transferable
references failed first, then passed with source-bound routes and channel nonce.
Two further negative controls exposed replaced-inner-transport admission and
silently ignored case timing options; both were corrected at admission. The
22-check run passed, including preservation and no-reopen buffer handoff.

### 3. Custody and final audit

- [x] Verify 188 existing source/documentation fingerprints (previous 176 plus
  the 12 requalification package files), then run named predecessor checks.
- [x] Obtain a read-only review, fix substantiated issues, and rerun fresh checks.
- [x] Add README, audit/status/validation receipts and full proposed commit text.
- [x] Confirm no tracked/index changes and no provisioned outputs or activation.

Task 3: independent review raised three Important findings; all were accepted
and fixed with RED-to-GREEN regressions. The parent final suite contains 28 new
and 53 predecessor checks; final counts/custody are recorded in VALIDATION.json.
No second reviewer approval or native qualification is claimed. All deliberately
excluded review behaviours remain the explicit operational limits in REVIEW.md.

## Execution rulings

- Ruling: keep additive files in the owner's current checkout, not a new worktree
  or branch. No existing file is edited and no Git mutation is authorized here.
- Ruling: use only named offline test suites, not repository-wide discovery that
  could cross the explicit native/participant boundary.
- Ruling: preserve this ledger and failed test receipts; do not use automation
  helpers that commit files or remove workflow records.
