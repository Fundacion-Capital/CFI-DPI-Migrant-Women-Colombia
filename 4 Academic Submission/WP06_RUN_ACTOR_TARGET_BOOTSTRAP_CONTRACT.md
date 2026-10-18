# WP06 — run, actor and target identity; authenticated bootstrap successor

Status: **AWAITING_SPEC_REVIEW**. Product implementation: **NOT_IMPLEMENTED**. Integration cases below are prospective and have not been executed.

Owner checkpoint: `0e26b57bb0b0e7327c3f7beb1e263328e916015d`. This contract follows the audited residual native-provider package. It neither replaces an old seal nor changes the scientific or operational status of the project.

## 1. Purpose, authority and acceptance boundary

The owner requests an artificial-only contract, implementation and integration tests separating run, actor and target identities and authenticating bootstrap. Preserve every packet. No host probes, actor launches, live control, service changes, Stata or participant processing are permitted. Test interpreters, hashing approved source/evidence files and ordinary read-only Git bookkeeping are evidence tooling, not actor launches.

The architectural brainstorming skill requires the written specification to be reviewed before implementation planning or product changes. The preceding user request approves the proposed identity-separation scope; it is not represented as approval of this previously nonexistent written specification. This version therefore supplies an auditable contract for that review and does not claim the requested implementation is finished.

Success for the eventual artificial implementation means four distinct captured O/S/C/W process identities, a separately anchored external L identity, authenticated parent/child and peer-role associations, a single worker-target seal derived from W, no identity predictions, and fail-stop rejection of corrupted or stale transitions. It does not mean real Windows compatibility, independent scheduling, institutional authentication, completed operational cases or permission to estimate anything.

## 2. Source findings and design choice

The current `launch_stage_b.plan_launch` requires each of O/S/C/W's complete bindings to equal the target binding. `Bridge.bootstrap` requires the captured binding to equal that specification. `WindowsBackend._identity` obtains the process PID and creation time and compares them with the expected binding before resumption. Four distinct live processes cannot all have the same process identity.

Current `WindowsBackend.create_process` also captures, narrows and resumes within one method. It cannot simply be renamed into a two-phase capture/admit operation: its resume point must be separated from the later target admission. Existing `Provider` requires a full target binding at construction. Existing `FrameChannel` supports an S-owned channel whose retained endpoint is W, not arbitrary cross-role bootstrap. These are concrete migration surfaces, not just terminology changes.

Three approaches were considered:

| Approach | Consequence | Disposition |
|---|---|---|
| Predict actor PIDs or reuse the target binding for all roles | Retains the circular identity assumption and cannot establish distinct process ownership | Reject |
| Relax existing binding comparisons or rewrite old schemas in place | Makes historical checks and seals ambiguous; can confuse run authority with target authority | Reject |
| Add a versioned pre-target launch/actor bootstrap, then derive a target-bound compatibility view | Resolves unknown identities at capture while retaining exact checks and historical evidence | Recommend |

All eleven existing Stage-B Python sources, earlier public reports, manifests and packets remain byte-identical under this successor design. New modules may reuse existing validators, ABI types and safe resource-lifetime helpers, but must not invoke the old combined creation/resume operation to simulate a split capture. Tests must exercise actual successor code against injected artificial external API functions, not bypass its checks with fabricated registry rows.

## 3. Exact identity schemas and canonical representation

Use the existing exact-dictionary, bounded ASCII, lowercase SHA-256 and unsigned-64 validators. Positive PID, creation-time, frequency and generation values use canonical positive decimal strings; ticks use exact unsigned-64 integers, never booleans or floating-point values. No placeholders such as PID 0, null process identities, wildcard roles or inferred values are admissible.

`RunContext` has exactly these fields:

```
origin, contract_digest, build_digest, host_id, boot_id, observer_epoch,
session_id, owner_nonce, scope_id, clock_domain, qpc_frequency_hz, run_id
```

`origin` remains `B_DISPOSABLE`. `run_id` is a bounded fresh identifier. The run digest is SHA-256 of the canonical record. It contains no actor PID, worker epoch, command, reservation or lease. Host/boot/clock values in this task are expressly artificial fixture values, not actual observations. `contract_digest` pins the approved successor revision, not an assumed historical-contract equivalence.

`ActorIdentity` has exactly:

```
run_digest, role, actor_epoch, generation, parent_role, parent_actor_digest,
pid, creation_time_100ns, image_pin_digest, credential_id
```

Its digest is computed over this record; there is no self-referential digest field. `image_pin_digest` is the approved executable/artifact pin, not a claim that a loaded module has been measured. Actual image attestation remains an external gate. `role` is one of L/O/S/C/W. The externally anchored L has parent role `EXTERNAL_OPERATOR` and an approved external-anchor digest; children have the exact parent topology below. An actor credential identifier is public metadata, not a key.

`TargetContext` has exactly:

```
run_digest, worker_actor_digest, worker_epoch, command_id,
reservation_id, lease_id
```

Its worker reference must resolve to the currently admitted W identity in the same run. It is sealed once per run. Reservation/lease identifiers do not themselves prove durable reservation or prearm. A failed run is never resumed. Initial integration covers one generation per role; AC18/AC19 replacement protocols are not silently introduced by this contract.

The existing eighteen-field worker binding is a deterministic compatibility projection, not an alternative identity source: copy its eleven run fields from RunContext; copy PID and creation time from the referenced W; copy `engine_module_digest` from W's approved image pin; copy the four epoch/command/reservation/lease fields from TargetContext. Reject any supplied duplicate value that differs. The extra run_id is bound by the enclosing run/target/scope digests, not inserted into the unchanged eighteen-field schema.

## 4. Manifest, budgets and pre-target authority

A successor manifest fixes exactly O/S/C/W, their parent roles, applications, image pins, fixed command lines, minimal environments, generation=1, credential identifiers, bootstrap capability identifiers, count limits and immutable budgets. It excludes predicted PID/creation-time values. Numeric OS handles are owned provider resources, not reusable global symbolic credentials. A pinned capability registry resolves the explicitly allowed inherited-handle list before creation; no unlisted inheritable handle or ambient/default endpoint is accepted.

`RunManifest` has exactly `run_context`, `external_launcher`, `actor_intents` and `budgets`. `actor_intents` is an exact O/S/C/W dictionary. `external_launcher` has exactly `identity` (the L ActorIdentity) and `anchor_proof`. The proof has exactly run_digest, actor_digest, external_anchor_digest, issuer, credential_id, issued_tick, expires_tick and signature, verified with the pinned artificial OWNER authority against the externally supplied expected anchor, never an endpoint's chosen trust root. Each role intent has exactly:

```
run_digest, role, parent_role, actor_epoch, generation, application,
command_line, image_pin_digest, environment, credential_id,
bootstrap_capability_digest
```

The environment is the existing minimal SYSTEMROOT-only policy. Commands are fixed by manifest; no shell, arbitrary source string, secret or runtime credential belongs in command arguments or environment. Pure path/schema validation is allowed; no real executable or host discovery is implied.

Budgets have exactly `bootstrap_deadline_tick`, `ipc_deadline_tick`, `control_deadline_tick`, `cleanup_deadline_tick`. Require now < bootstrap < min(ipc, control), ipc <= cleanup and control <= cleanup; reject overflow, deadline equality at use, extensions and clock-domain/frequency changes. Substep deadlines may shorten but never lengthen those ceilings. No calibration is attempted.

Pre-target `RunLaunchGrant` has exactly:

```
run_digest, manifest_digest, intent_digest, issuer, credential_id,
allowance, not_before_tick, expires_tick, signature
```

Only the explicitly pinned artificial OWNER signer may issue it, allowance must be 1, and expiry must not exceed the bootstrap ceiling. No target binding is required or invented here. Grant signing is domain-separated from actor registration, bootstrap, target admission and legacy control messages. A grant is consumed before its single creation attempt; failure does not restore it. No automatic retry, extra launch, fallback or termination is permitted.

These artificial run grants are not translations into approved real institutional G01–G15 decisions. They authorize only the exact synthetic state transitions in the fixture environment.

## 5. Ownership, capture, registration and resumption

Topology remains L→O, O→S, O→C, S→W. External L is supplied as an authenticated synthetic anchor before child allocation and does not count as an additional created actor. O/S/C/W must have distinct concurrent PIDs and distinct captured PID/creation-time tuples. A different handle number cannot stand in for a different process identity.

For each child, its creator:

1. Checks run grant, intent, artifact pin, actual fixed argument/environment encoding, parent identity, budget and exact private resource ownership.
2. Consumes the one permitted creation slot and invokes the injected artificial CreateProcessW boundary with suspension and explicit handle-list policy.
3. Captures PID and creation time from the returned retained process handle. Values come from API outputs, not the manifest, a signed packet's self-description or a test-side expected-PID map.
4. Narrows the retained process handle and records creator/thread/private-channel/event ownership. It does not reopen by PID or create an ungranted termination capability.
5. Produces an ActorIdentity and creator registration proof, then resumes only into the fixed quiescent bootstrap role if capture, registration authorization and deadlines remain valid.

`RegistrationProof` has exactly actor_digest, parent_actor_digest, intent_digest, capture_evidence_digest, bootstrap_capability_digest, issuer, credential_id, issued_tick, expires_tick and signature. It must be authenticated by the pinned creator credential and checked against locally retained capture evidence; signing a fabricated PID is not proof of capture. Parent, role, intent and channel bindings are checked together. The creator records the digest once; a second registration, altered capture or stale credential quarantines the run.

Capture is not target admission. Bootstrap-only resumption is not work dispatch. A primary-thread or creator-handle close failure, failed resume, expired grant, duplicate identity or uncertain capture retains explicit resources and produces a fail-stop disposition, not successful cleanup. The original lease/slot is never silently replenished.

## 6. Authenticated bootstrap and credential isolation

Use a versioned bootstrap protocol distinct from legacy worker-control envelopes. The bootstrap challenge body has exactly:

```
protocol, run_digest, manifest_digest, actor_digest, parent_actor_digest,
intent_digest, capability_digest, challenge_id, issued_tick, expires_tick
```

`protocol` is `WP06_BOOTSTRAP_V2_ARTIFICIAL`. The actor response body has exactly protocol, run_digest, actor_digest, challenge_digest, credential_id, sequence, previous_digest, tick, frequency, payload_digest and tag. Initial bootstrap sequence is canonical string `1` and previous digest is the agreed zero genesis. Response MAC binds all fields except tag and includes a distinct response domain prefix. Challenge/response records must be canonical, exact-schema and at most 8,192 ASCII bytes.

The challenge is single-use, bound to the captured actor, parent, run, launch intent and capability. Check the local retained handle and the kernel pipe-peer PID before accepting a response. Verify the expected captured role as well as the role-specific MAC; valid possession of another role's key cannot override the transport identity. The endpoint cannot nominate its own role, key, verifier or recipient. PID-only equality without the retained same-process identity is insufficient.

An artificial fixture provisioner explicitly supplies each actor endpoint only that role's key and fixed peer-verification material. All five actor credential identifiers and keys are distinct from one another and from OWNER; they are scoped to this run and actor identity. Actor endpoints must not receive OWNER or unrelated role signing keys. The coordinator fixture may hold its artificial verification/signing key inventory; that convenience is not a production secret boundary. No key material is serialized into grants, responses, transcripts, logs, argv, environment or journals. No account authentication or real secret retrieval occurs.

Consume a successful challenge exactly once. Invalid authenticated state, stale or malformed frames, ambiguous transport, wrong role/parent, unknown or revoked credential, replay or sequence mismatch quarantine the endpoint/run with preserved records. Do not rebuild a channel object to reset replay state on the same pipe. A failed or uncertain channel permits bounded completion observation/drain only, not another launch, challenge reset or work dispatch.

## 7. Roster and worker-target seal

After all four actor registrations and bootstrap responses are authenticated, O constructs a canonical `Roster` with exactly run_digest, manifest_digest, budget_digest, actors, registrations and transcripts. `actors` is an exact L/O/S/C/W dictionary of ActorIdentity records; `registrations` and `transcripts` are exact O/S/C/W dictionaries of accepted proof and transcript digests. The roster binds manifest, run and unchanged budgets. Missing, extra, duplicated or substituted roles cannot pass. L is an external anchor, not a self-generated O assertion.

W's actual captured identity supplies the TargetContext reference. An explicit artificial OWNER target-admission record signs run_digest, roster_digest, target_digest, manifest_digest, budget_digest, issued_tick, expires_tick, issuer, credential_id and signature. Domain-separate it from RunLaunchGrant. The signer may not fill in unknown captures or change the worker reference after admission.

The compatibility scope digest is computed from run_digest, roster_digest, target_digest and budget_digest. A signed target record is therefore not transferable to another run, actor roster, target, budget or build. All copied/shared verifier views retain one monotonic local revocation identity, as in the corrected Provider. Revocation invalidates prearmed capability generations without waiting for signature, transport or journal callbacks on the due-action path. No cross-process concurrency or atomic native revocation guarantee follows from this local artificial mechanism.

On success, the strongest new disposition is `ARTIFICIAL_IDENTITY_BOOTSTRAP_ACCEPTED`. It is still quiescent, with work_dispatched=false, cases_executed=0, operational_acceptance=false and scientific_acceptance=false. Target admission cannot be used as observed G07/G10, durable slot commitment or independent cleanup evidence.

## 8. Legacy compatibility and downstream gates

Only a validated sealed roster/target may construct a worker-only compatibility view for the existing eighteen-field Binding, Provider, Supervisor, actors and fresh artificial Journal. Its W process row must derive from the real successor registry/capture record, not a fixture insertion. A production successor method must validate this adoption; tests may not bypass it by setting private old Bridge dictionaries.

Legacy L/O multi-role launch functions are not reused to create successor actors. Legacy control remains bound to the exact projected W; its peer actor identity remains separately pinned by the successor channel. The real C/S/O identities never become copies of W's PID merely to satisfy the old launcher.

Before any artificial work/fault/control composition, obtain separate target-scoped phase authority, authenticated observed prearm inputs and the existing committed single-use slot. The new bootstrap acceptance cannot fabricate these. Preserve one attempt, no resend, self ceilings, signal/application/exit distinctions and bounded completion drain. A bootstrap permit is not an applied-control receipt.

Post-target successor envelopes have distinct exact fields: protocol, run_digest, target_digest, sender_actor_digest, recipient_actor_digest, credential_id, sequence, previous_digest, tick, frequency, kind, payload_digest and tag. Their protocol is `WP06_TARGET_V2_ARTIFICIAL` and role/kind allowances remain the existing fixed L/O/S/C/W allowances, not an arbitrary new message language. Pin both actor endpoints to retained identities and direction-specific chain state. Domain-separate these envelopes from pre-target bootstrap and old control frames. Verify before projecting to a legacy target-bound interface; never re-sign an unverified message to make it acceptable.

No replacement generation is implemented by implication. AC18/AC19 full workflows remain held pending source-exact replacement contracts; AC19 numeric reuse remains unavailable with retained originals. AC21 remains disabled without separately adopted target/profile grants. All real AC17–AC22 statuses, runtime facts and external gates remain unchanged.

## 9. Failure, cleanup and preservation invariants

An actor allocation, challenge, registration, target seal or control slot is never replenished after uncertainty. Failed state cannot return to eligible by editing a nonce, clock, provider or verifier. A new authorized run requires new run/owner/actor/channel credentials and preserved evidence; this task does not automatically create one.

Keep every uncertain process/thread/channel/event/OVERLAPPED/buffer resource in the owned inventory. Pending I/O events cannot close before completion. Cancellation is not completion; successful I/O is not application; a close failure is persistent uncertainty, not success on the next read. Retain the corrected native adapter invariants. Do not use job-wide cleanup, default processes, names or PID reopening.

Bootstrap inventory/receipt generation is not independent O/L cleanup certification. No real actor is terminated, no service is changed, no protected store is opened, no participant record is processed or exported. No Git commit, push, cloud sync, Overleaf update or release is authorized here. Existing failures, baseline files, original sources, seals and pointer values remain preserved; a successor receipt states only the bounded stage actually completed.

## 10. Implementation surfaces and compatibility obligations

Prospective additive modules under `wp06-stage-b/`:

- `identity_contract.py`: exact schemas, canonical digests, target projection, phase permits and immutable admission capabilities.
- `identity_bootstrap.py`: split capture/registration/quiescent-resume coordination, fixed parent topology, role-isolated artificial bootstrap provider, authenticated channels, roster/target seal and controlled compatibility adoption. Reuse fixed-width ABI structures/resource rules without calling the old auto-resume function.
- `test_identity_bootstrap.py`: dynamic-identity fake API at the external boundary and real successor-contract/integration tests. Do not change the prior FakeAPI or eleven original sources.

The final implementation plan must settle concrete class/function signatures, dependency order, exact fixtures and test commands after this written specification is approved. These filenames describe the migration boundary, not pre-approved product code or an executed plan. No new package, plugin, runtime installation or real credential integration is necessary.

All existing 81 tests and both modes of the 17-test inert preflight remain regression obligations, not asserted fresh results in this documentary packet. Runtime facts stay null/pending. Source snapshots, every failed run, review disposition and separate readback must accompany later implementation acceptance. Capability/adoption validation governs public entrypoints in a trusted Python embedding; it does not claim a sandbox against malicious callers mutating private attributes or injecting hostile API functions.

## 11. Prospective acceptance matrix

Every case below is **NOT_EXECUTED** in this design stage. Later tests must distinguish source behavior from artificial API outputs and preserve their source-bound results.

- T01: Exact RunContext rejects target/PID fields, booleans, noncanonical numbers, unknown origins and altered digests.
- T02: Actor and target exact schemas reject missing/extra fields and self-referential or unresolved identity references.
- T03: PID-free launch intents accept distinct dynamic fake API capture values without predicting them.
- T04: Four captured O/S/C/W identities and the external L anchor remain distinct under the required parent topology.
- T05: Duplicated concurrent PID, duplicate handle object, wrong creation time and changed capture evidence fail closed.
- T06: Wrong parent role/digest, cross-run registration or changed manifest/application/environment/handle capabilities cannot allocate or resume.
- T07: Grant allowance is consumed before the API attempt; partial failures cannot create an extra actor or retry.
- T08: Capture and registration precede quiescent resume; target admission and work are unavailable during capture.
- T09: Canonical exact-size bootstrap boundary accepts the maximum permitted frame and rejects oversized, duplicate-key and malformed messages.
- T10: Wrong role/key, recipient, actor, parent, run, challenge or capability rejects a response even when another role MAC is valid.
- T11: Pipe-peer kernel PID and retained identity must agree with the captured endpoint role; no PID-only or MAC-only substitution.
- T12: Replayed challenge, duplicate registration, sequence gap, changed genesis or reconstructed same-pipe channel cannot reset admission.
- T13: Stale/future packets, expiry equality, clock rollback, frequency change and shortened/extended budget mismatches retain HOLD.
- T14: Revocation shared across copied verifiers blocks registration, target seal and cached capabilities without a blocking due-path verifier.
- T15: Actor endpoints receive only the allowed role keys; transcripts, logs, argv, environment and journals contain no keys.
- T16: Incomplete/extra/duplicated roster, forged external L anchor and substituted W cannot yield a target seal.
- T17: Target projection matches all eighteen legacy fields and rejects every conflicting supplied value.
- T18: Cross-run/roster/target/build/budget reuse of a valid signed target record fails.
- T19: Only controlled successor adoption creates a legacy worker compatibility view; arbitrary dictionary/fixture registry insertion is rejected.
- T20: Authenticated bootstrap acceptance alone cannot satisfy observed prearm, committed reservation, applied stop, exit or cleanup gates.
- T21: Separate synthetic target authority plus existing durable prearm supports one bounded artificial worker/supervisor composition; no extra launch or resend follows failure.
- T22: Pending/cancelled/failed I/O, close uncertainty and partial bootstrap failure preserve every owned resource and failed packet; later polling cannot promote uncertainty.
- T23: Default entries, unconfigured providers, live domains, additional roles and replacement/termination requests remain denied; no native resolver or real effect is invoked.
- T24: Full old regression suites, normal/optimized successor suites, exact source pinning, all old packet/pointer hashes and separate final readback govern bounded acceptance; no scientific/operational/release state is promoted.

## 12. Audit, review checkpoint and commit proposal

This specification has been checked against the actual old launch, Bridge, native identity/creation, Provider, role and channel interfaces. The design removes the circular requirement to know a future PID at launch authorization without discarding exact postcapture identity checks. It distinguishes declared image pins from actual module measurement and bootstrap acceptance from observed prearm/control/cleanup.

Documentary evidence lives in `audit-local/intake/wp06-identity-bootstrap-design-0e26b57`. Its entry preserves the previous native-provider seal/closure, baseline tracked files, previous private packets and service-source fingerprints. Its validation/closure receipts assess document completeness and preservation only, not any of T01–T24 or product correctness. No schema/state/pointer update declares the full task complete.

Review checkpoint: approve or revise this written contract before implementation planning and product changes. The immediate remaining work is the requested implementation and integration tests, not a live operation. No claim is made that those have run.

Proposed documentation-only commit title:

```
Define artificial run/actor/target identity and authenticated-bootstrap contract
```

Proposed description: document exact successor identities, PID-free launch authority, captured actor registration, authenticated bootstrap, roster/target sealing, controlled legacy-worker adoption, fail-stop resource rules and twenty-four prospective acceptance cases. Preserve all prior code, packets, runtime gates and scientific state. Record written-spec review as pending; do not imply product implementation, executed integration tests, live authorization or release.
