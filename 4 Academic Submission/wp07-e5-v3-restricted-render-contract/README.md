# E.5 restricted aggregate render implementation plan

> For the later authorized run: use the executing-plans workflow for the
> exact Stata MCP selection and the offline verification steps below. This
> checkpoint supplies no authorization to read, hash, copy, or render ledger
> contents.

**Goal:** Produce and verify one private candidate bundle of the six E.5
exhibits from the five previously sealed E.4 aggregate CSV ledgers, without
refitting or recreating predictions, margins, or tests.

**Architecture:** The [machine-readable binding](RENDER_CONTRACT.json) pins
the production E.4 ledger records from two existing seals, the already
qualified v3 producer body, and the exact quiet MCP request. The native call
reads only those five inputs in place. Separate offline readback verifies
the actual produced files before any promotion.

**Tech stack:** Native Stata through `stata_run_selection`; local CSV,
SHA-256, and PDF/LaTeX checks; no new packages or worker configuration.

**Spec:** [E.5 exhibit specification](../wp07-e5-restricted-exhibit-map/EXHIBIT_SPEC.md),
[frozen E.4 run](../wp07-e4-restricted-execution/VALIDATION.json), and
[12-case artificial qualification](../wp07-e5-v3-negative-native-validation/VALIDATION.json).

## Global constraints

- **Preparation only.** The five hashes and sizes are recorded seal metadata,
  not measurements of the current ledger bytes. No ledger contents were
  opened, rehashed, copied or previewed. No Stata call, session inventory,
  wrapper compile or new exhibit occurred.
- Future scope is at most one exact selection, 60-second soft timeout, no
  retry, no replacement worker or alternate execution route. Zero participant
  or saved-model loads, fits, margins, new tests, alternative samples, added
  inputs or data exports beyond the 17 bound aggregate/reporting files.
- No mutation of inputs, canonical sources, older packets, manuscript,
  institutional records, settings, or public surfaces. C2 stays **HOLD**.
  Technical acceptance does not adopt or release any exhibit.

## Review focus

1. A synthetic ledger or stale file with the correct basename must fail the
   five exact path/byte/hash checks; never substitute a copy from a trial.
2. Git ignore does not make a directory private. The proposed output parent
   currently has additional allow ACEs, including a sandbox group and
   unresolved SIDs; inherited permissions alone are not acceptable.
3. A success flag or echoed receipt is insufficient. Require the actual
   anchored outer line and matching on-disk receipt, followed by independent
   content and visual verification. A quiet log may be empty.
4. A complete 17-file inventory can still contain incorrect columns or values.
   Derive all numeric expectations from the five actual ledgers only after
   authorization; synthetic counts and values are not acceptance targets.
5. No automatic disclosure or release from a correct bundle. Partial files,
   unexpected output or a failed gate are preserved privately, never repaired
   in place or silently retried.

### Task 1 — future authorization and admission

- [ ] Obtain a fresh exact grant for this binding, including the five ledger
  byte rechecks/readback, local private rendering/audit, and the quiet route's
  residual provider-log limitations. The prior artificial grant is exhausted.
- [ ] Verify the binding and both preceding seals. Check that the exact run
  root is unused; create only its bound directories under the approved
  local owner-controlled location. Verify effective ACLs and path identity
  at the actual input files and new directories **before** reading contents:
  owner, SYSTEM, and Administrators only unless an exact additional authorized
  principal is explicitly recorded. Reject unexpected allow entries,
  links/junctions, synced/shared locations, or an unknown worker identity.
  Do not widen source ACLs or change existing packets/settings. If this
  needs a new permissions decision, stop. Verify Git ignore independently.
- [ ] With authority, check the five exact paths, regular-file identities,
  byte lengths and SHA-256 values. Recheck immediately before dispatch.
  Hash mismatch, missing file or different path is a stop, not a request
  to re-create data. Keep data and model files outside the read set.
- [ ] Verify session absence and capacity with the manager's read-only list
  under the new grant. No probe selection or destruction. Verify the
  sealed request content matches the exact caller, producer and fresh
  destination. The fresh grant must explicitly cover the proposed local
  provider Temp route and its residual capture uncertainty. Verify its
  parent path and access boundary without searching for logs. Before
  import, the caller rejects command logging, more than one open log,
  or an open log outside the exact Temp/session filename rule. This is
  a path gate, not certification of hidden middleware capture. Do not
  proceed if the available route is incompatible with the approved boundary.

### Task 2 — future exact native render and evidence

- [ ] Record dispatch intent, exact request hash and timestamp privately.
  Dispatch the sealed request once, with the bound session and timeout.
  The caller uses the qualified body unchanged. The body derives only the
  already specified coefficient SEs and normal bounds from sealed B/V cells.
- [ ] Preserve the raw MCP result and ordinary log privately before acceptance.
  The quiet transport may still log command/path metadata or native output;
  provider/debug locations and lifecycle were not certified. This contract
  does **not** authorize an out-of-bound spill read. If a capped preview,
  named middleware spill, unexpected output containing study values, timeout,
  unfamiliar log channel, or transport error is observed, stop and preserve
  the available evidence without widening the read scope. Do not infer hard
  cancellation or process exit.
- [ ] Require tool success, a single actual terminal
  `E5_RESTRICTED_COMPLETE: rc=0 N=0 K=0`, no actual stop/error result, and
  no contradictory outer return if the tool supplies one. Retain null for
  an unreported separate numeric return. The inner producer is quiet:
  require the exact six-slot `e5_complete.csv` and the 17-file inventory
  instead of inventing a printed inner line. Any mismatch stops the package.

### Task 3 — future independent acceptance and custody

- [ ] Apply [the pinned acceptance rules](ACCEPTANCE.md) to all CSV cells,
  rendered table rows, both figure formats, captions, receipt and exact
  output inventory. The existing artificial numeric auditor is not the
  production oracle. Record detailed checks privately and only gate
  status in the public workplan. Compile solely the bound private diagnostic,
  not the paper.
- [ ] Recheck five ledger hashes, canonical/source pins, archived packets,
  produced artifacts, private ACLs and Git ignore. Seal receipt, raw
  evidence, inventories, and results even on failure; record no retries.
  Retain restricted candidates for separate exact-version disclosure,
  author/institutional and publication decisions.

See [VALIDATION.json](VALIDATION.json) for the preparation-only evidence.
No grant, access certification, or empirical acceptance is claimed here.
