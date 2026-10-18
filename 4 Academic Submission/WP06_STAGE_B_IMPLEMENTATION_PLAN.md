# Isolated Stage-B Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans for the native implementation approach after the owner reviews this plan and separately authorizes implementation. Subagent-driven execution is an alternative only if explicitly selected. Checkboxes describe future work, not completed implementation.

**Goal:** Build a deny-by-default, isolated disposable-actor implementation of the sealed Stage-B design, without inheriting permission to launch or control any actor.

**Architecture:** Preserve `L → O → {S → W, C}`. Implement contract/journal rules first, a narrow lazy Windows bridge second, and supervisor, fixture actors, observer and launcher around those interfaces. Prove pure behavior with artificial dependencies before requesting any host/bootstrap authorization; mock evidence never passes a real AC case.

**Tech Stack:** Python standard library; explicit `ctypes` Windows calls only behind a separately activated bridge; `sqlite3` for the future restricted single-writer journal; `unittest` for named, artificial-only selections. No installation or runtime/interpreter version is assumed approved.

**Spec:** [sealed Stage-B design](WP06_STAGE_B_DESIGN_AND_NOEXEC_PREFLIGHT.md), [pending staged gates](wp06-stage-b-preflight/gates.json), [original six case plans](wp06-stage-b-preflight/cases.json). Machine-readable task, source-pin and coverage companion: [plan.json](wp06-stage-b-plan/plan.json).

18 October 2026. Baseline commit: `1a2f05242890c9f9abf8d4c2970600a0c9e38b35`. **Current task is documentary planning only. No file in the future runtime directory is created now.** Implementation, operational adoption, host probes, launch, fault, control, fallback, Stata, participant processing and release remain unauthorized. This plan does not revise an O01–O07 profile or grant a gate.

## Global constraints and isolation

- Future editable allowlist: exactly the seven files below under `4 Academic Submission/wp06-stage-b/`; no change to sealed Stage-A/B inputs, old packets, services, scientific/qualitative code, data, manuscript, Overleaf or external configuration. A future implementation report/governance handoff needs its own explicit additive artifact scope.
- Maximum four concurrent new actors O/S/C/W; four total by default; five total for predeclared sequential C2 in AC18 or W2 in AC19; no overlapping generations, retries, automatic restart or unplanned replacements. L is an existing separately approved launcher, not a service.
- Cooperative-only. No job assignment, kill-on-close, tree/name/PID-only targeting, shared/default session, shell command, arbitrary code/data or Stata engine. AC21 is disabled without separate profile and exact-W termination grants.
- Source-exact binding has all 18 design fields. Unknown host/build/clock/ACL/storage/retention/budgets/grants remain null; tests use explicitly artificial values, never recorded as actual observations.
- Maximum frame is 8192 bytes; IDs bounded opaque ASCII; digests 64 lowercase hex; PID/time/count values canonical unsigned decimal strings. Enforce type/range, reject booleans as integers, unknown fields, duplicates and noncanonical encodings.
- Adopted numeric ceilings must precede bootstrap; clock is proposed integer QPC, not approved today. `ticks = ns * frequency // 1_000_000_000`; reject zero/overflow. Equality expires. External observations within one tick cannot prove ordering; no float, retry, grace or ceiling extension.
- Separate reservation, attempted control, W application, same-handle exit, cleanup, evidence integrity and scientific validity. No fixture/model PASS is an AC17–AC22 PASS. No existing results are overwritten.
- Any test command in this plan is **future, artificial-only and subject to implementation approval**, not a command executed while writing this plan. Never run broad discovery that could load historical runtime tests. No commit command is included: prepare commit title/body per task; stage/commit/push only on explicit authorization.

### Frozen file responsibilities and import direction

| Future file | Responsibility; imports allowed |
|---|---|
| `journal_protocol.py` | Canonical records, authenticated envelopes, phase admission, journal/high-watermark rules; standard library only. No Stage-A operational imports. |
| `win32_bridge.py` | Lazy, explicitly activated Windows boundary and owned handle/I/O lifetimes; may import protocol, never launcher/actors. Import must not load a DLL or create a resource. |
| `supervisor.py` | Single-consumer stop slot, prearm, independent deadline/loss path; protocol + bridge. |
| `actors.py` | Fixed C/W role state and cooperative receiver, separate from blocked work queue; protocol + bridge. |
| `observer.py` | Independent evidence, ordered observations and complete resource/exit assessment; protocol + bridge. |
| `launch_stage_b.py` | Deny-by-default orchestration/L attestation; imports these modules without invoking role loops. |
| `test_stage_b.py` | Named artificial test classes, side-effect-denying dependencies and hand-derived fixtures; never auto-runs live cases. |

No new general framework, plugin, daemon, CLI with arbitrary arguments or configuration layer is planned. All seven remain absent until separately authorized implementation.

## Shared interface/record contract

All functions below are future signatures; no implementation is embedded here. `dict` means an exact validated record, not an arbitrary input bag. Unknown/missing fields fail before side effects. Validation raises `ValueError`; unavailable evidence returns BLOCKED/HOLD, never fabricated success. Test dependencies live in `test_stage_b.py` only. The injected clock supplies `now_tick() -> int`, `frequency_hz: int` and `domain: str`; real providers remain gated. Tick/counter values are unsigned64; identifiers are 1–128 ASCII characters from `[A-Za-z0-9_-]`; sequence 1 follows the separately sealed genesis digest/previous sequence 0. Reject embedded NUL, leading-zero decimal representations except zero itself, and unknown record variants. These are proposed implementation validation choices, not host observations or adopted runtime values.

`journal_protocol.py` owns:

- `validate_binding(binding: dict) -> dict`: exact fields `origin, contract_digest, build_digest, host_id, boot_id, observer_epoch, session_id, owner_nonce, worker_epoch, command_id, pid, creation_time_100ns, engine_module_digest, reservation_id, lease_id, scope_id, clock_domain, qpc_frequency_hz`; `origin=B_DISPOSABLE`.
- `canonical_message(message: dict) -> bytes` and `verify_message(wire: bytes, expected_binding: dict, role_key: bytes, previous_sequence: int, previous_digest: str) -> dict`. Envelope fields: `binding, issuer, credential_id, sequence, previous_digest, tick, frequency, kind, reason, result, payload_digest, tag`; ASCII canonical sorted compact JSON, HMAC-SHA256 over all fields except `tag`, constant-time comparison. No duplicate JSON keys, extra fields, replay/gap, wrong role-kind or chain accepted. Kind allowlists: C REQUEST/HEARTBEAT/FAULT; S REGISTERED/SUPERVISOR_ARMED/CONTROL_ATTEMPT; W STOP_APPLIED; O VERIFY/CLEANUP; L OBSERVER_EXIT. Shared keys are authentication, not nonrepudiation.
- `admit_phase(stage: str, decisions: list[dict], observations: list[dict], expected_scope: dict, verify_decision) -> dict`. Decision fields: `component, decision_id, issuer, scope_digest, build_digest, not_before_tick, expires_tick, observer_epoch, approved, evidence_digest, signature`; observation fields: `component, binding, envelope_digest, tick, evidence_ref`. The pinned out-of-band decision-verifier callable is the trusted build dependency, never supplied through a message or CLI. It must authenticate issuer/role/scope/build/epoch/expiry/evidence, not trust `approved=True`. Actual trust roots/providers remain external gates; a fixture verifier cannot activate a real bridge. Return `stage, eligible, missing, evidence_digests`; this is stage-specific, never scientific eligibility.
- `Journal(path: str, expected_high_watermark: dict)` with `prepare(binding: dict, deadline_tick: int) -> dict`, `record_after_attempt(receipt: dict) -> None`, `recover(observed_high_watermark: dict) -> dict`. `prepare` transactionally commits reservation/lease/target/deadline/one-use slot before arm. Return slot fields `binding, deadline_tick, reservation_digest, slot_id, status=ARMED_UNUSED`. Prepare/recover error is no-dispatch, consumed/quarantined, no retry. Later storage persistence cannot gate a due stop.
- `ns_to_ticks(ns: int, frequency: int) -> int` and `deadline_state(now_tick: int, deadline_tick: int, uncertainty_ticks: int) -> str`: checked unsigned64 range; return BEFORE/EXPIRED/AMBIGUOUS, never round a late observation into BEFORE.

`win32_bridge.py` owns `Bridge` with methods `bootstrap(role: str, approved_spec: dict) -> dict`, `capture_identity(token: str) -> dict`, `signal_cooperative(token: str, binding: dict) -> dict`, `poll_exit(token: str, deadline_tick: int) -> dict`, `read_frame(token: str, deadline_tick: int) -> bytes`, `write_frame(token: str, wire: bytes, deadline_tick: int) -> dict`, `cancel_io(operation_id: str) -> dict`, `close_completed(token: str) -> dict`, `terminate_exact(token: str, grant: dict) -> dict`. Tokens resolve only in its private owned-handle table, never from a PID/name. Resource records have `resource_id, kind, owner_role, generation, binding_digest, operation_id, rights, state, deadline_tick, disposition`; pending buffers/OVERLAPPED/waits remain retained until observed completion. Signal receipt has `binding, slot_id, attempt_tick, delivery_status`; it is not STOP_APPLIED. Exit receipt has `binding, observed_tick, same_handle, signaled, exit_code`; not an observation until the same owned handle signals. Separate granted terminate handles never enter O's table.

No raw Win32 error is converted to success. Unsupported host/capability, absent attestation, unknown completion, expired authority or discontinuous clock blocks advancement; record the actual bounded failure. Bridge activation is explicit and requires trusted phase admission plus approved runtime providers. Every side-effect boundary independently revalidates current authenticated authority against the pinned scope/build/epoch and remaining budget; neither a caller-constructed plan dictionary nor an `eligible=True` field is a capability. An import, caller Boolean or passing synthetic receipt cannot activate it.

## Review focus — five failure classes with assigned tests

1. Precreation/postcreation gate circularity or forged self-approval: B01 admission and B07 bootstrap/work barrier tests.
2. Journal/I/O/response blockage starving the watchdog: B02 prepare ordering and B04 lock-free postarm decision tests.
3. Stale process/generation targeting and impossible PID-reuse claims: B03 owned handles and B08 AC19 HOLD test.
4. Pending I/O/buffer lifetime, uncertain delivery and unapproved cleanup kill: B03 completion states and B06 cleanup accounting.
5. Timing-order ambiguity, observer loss or artificial evidence promoted to acceptance: B01 integer bounds, B06 cause/exit separation and B08 evidence-domain tests.

## Implementation tasks — all unchecked, dependency-ordered

Each task uses the six steps listed. The named tests/assertions are defined here independently of implementation. Future RED and GREEN runs must be preserved in distinct private receipts. For each run, explicitly select `test_stage_b.py` and the named class; never bare discovery. Run from the future runtime directory with `python -B -m unittest test_stage_b.<Class> -v`, then repeat the completed artificial suite with `python -B -O -m unittest test_stage_b -v`. These commands require a reviewed interpreter and implementation authorization; none is run for this planning task.

### B01 — Exact contracts, authenticated admission and integer time

**Files:** Create `journal_protocol.py`, `test_stage_b.py` (ContractTests). Consumes immutable design/gates; produces the shared functions above. No native dependency or runtime provider invocation.

**Five tests/assertions:**

- `test_binding_rejects_missing_extra_bool_or_wrong_generation`: every missing/extra binding field, boolean PID and expected-generation mismatch rejected.
- `test_envelope_rejects_tamper_role_replay_gap_and_oversize`: one-bit mutation, wrong role, duplicate/gapped sequence, duplicate JSON keys and 8193-byte wire rejected; valid hand-derived 8192-boundary fixture parsed only if its complete encoding fits.
- `test_policy_does_not_satisfy_observed_prearm`: approved policy decisions may admit the exact idle bootstrap but never work without G04/G07/G08/G09/G10 observations and G11 fault authority.
- `test_decision_requires_pinned_verifier_scope_epoch_and_expiry`: raw approval Boolean, substituted verifier, wrong build/scope/epoch or `now==expires` deny without a bridge call.
- `test_tick_floor_equality_and_one_tick_ambiguity`: 3ns at 1GHz gives 3 ticks; sub-tick/overflow rejected; local equality EXPIRED; external one-tick uncertainty AMBIGUOUS.

- [ ] Write ContractTests with literal valid/invalid artificial records and side-effect-denying boundary.
- [ ] Preserve the named-class RED receipt showing missing contract behavior, not a test typo.
- [ ] Implement the exact protocol/admission/time signatures; reject before any side effect.
- [ ] Preserve named-class GREEN and cumulative normal/optimized artificial-suite receipts.
- [ ] Audit exact fields, role-kind matrix, canonicalization, trust dependency and phase mapping against source pins.
- [ ] Prepare commit title/body `feat(wp06): add isolated Stage-B contract and admission rules`; do not commit without authority.

### B02 — Reservation journal, replay quarantine and postarm independence

**Files:** Modify `journal_protocol.py`, `test_stage_b.py` (JournalTests). Depends B01. Produces Journal/ARMED_UNUSED slot; consumer B04. Future tests may use a newly authorized artificial temporary SQLite store only, never a restricted historical store; close/retain the test packet under its own approved policy.

**Five tests/assertions:** `test_prepare_commits_binding_before_arm` (no slot before durable commit); `test_duplicate_or_uncertain_prepare_never_reopens` (consumed/quarantined, no retry); `test_stale_high_watermark_recovery_blocks_dispatch` (rollback rejected); `test_postattempt_persistence_failure_cannot_resignal` (record failure leaves one consumed action); `test_readers_observe_complete_committed_records` (no partial reservation eligible).

- [ ] Write JournalTests around the new exact schema and a hand-derived high-watermark fixture.
- [ ] Preserve RED showing each reservation/recovery behavior absent or incorrect.
- [ ] Implement Journal with one writer, explicit transactions, DELETE/EXTRA settings and no busy retry; return immutable slot before dispatch.
- [ ] Preserve GREEN plus cumulative normal/optimized suite, never opening old stores.
- [ ] Audit prepare/commit/prearm/action/postaction ordering and recovery refusal; a passing fixture is not durability or concurrent-host proof.
- [ ] Prepare commit title/body `feat(wp06): bind Stage-B reservations and quarantine replay uncertainty`; no Git action by default.

### B03 — Narrow Windows boundary, handle identity and I/O lifetimes

**Files:** Create `win32_bridge.py`; modify `test_stage_b.py` (BridgeTests). Depends B01. Produces Bridge and exact owned tokens/resource records above. Tests use an artificial native-call boundary; no DLL, handle, pipe, event or process is opened during artificial validation.

**Five tests/assertions:** `test_import_and_missing_admission_make_no_native_call`; `test_bootstrap_uses_exact_executable_environment_and_handle_allowlist` (no PATH/shell/incidental inheritance; close/narrow broad creator rights before arm); `test_owned_token_checks_all_binding_fields_before_signal` (stale PID/creation/generation cannot select another handle); `test_cancel_request_retains_buffer_until_observed_completion` (late success/cancel/failure distinct, pending close refused); `test_fallback_requires_both_grants_and_same_handle_exit` (request never exit proof, no alternate target/retry).

- [ ] Write BridgeTests with explicit fail-on-native-call and finite artificial completion sequences.
- [ ] Preserve RED for missing lazy activation/ownership/completion enforcement.
- [ ] Implement typed ctypes declarations behind activation; initialize nothing at import. Use explicit CreateProcess application/minimal environment, enumerated handles, local restricted overlapped pipes, peer-to-owned-handle checks and private W event.
- [ ] Preserve GREEN plus cumulative normal/optimized artificial suite. Do not claim ABI, installed-host compatibility or ACL adequacy.
- [ ] Audit source documentation pins, rights narrowing, same-handle proof, no close-during-wait, no pending-buffer reuse and forbidden Job Object/default targeting.
- [ ] Prepare commit title/body `feat(wp06): isolate owned Windows handles and bounded I/O`; no launch or commit authority inherited.

### B04 — Supervisor prearm and single-consumer stop path

**Files:** Create `supervisor.py`; modify `test_stage_b.py` (SupervisorTests). Depends B01–B03. Interface: `Supervisor(binding: dict, bridge: Bridge, clock, journal: Journal)`; `arm(slot: dict, admission: dict) -> dict`; `step(now_tick: int, controller_observation: dict, request: dict | None) -> dict`. Produces SUPERVISOR_ARMED, at most one CONTROL_ATTEMPT and explicit persistence uncertainty.

**Five tests/assertions:** `test_dispatch_denied_until_committed_prearm`; `test_due_stop_survives_blocked_controller_queue_and_journal` (precommitted memory slot, no postarm journal/response lock needed); `test_deadline_and_controller_loss_consume_once` (competing triggers one attempted signal); `test_supervisor_loss_never_causes_resend`; `test_postaction_unknown_stays_consumed_and_holds_evidence`.

- [ ] Write SupervisorTests with deterministic clock and blocked artificial dependencies, not sleeping threads.
- [ ] Preserve RED for missing arm barrier/independent consumption behavior.
- [ ] Implement registration, immutable slot and sole watchdog consumer. Mark consumed in the owner state before one signal; postaction journal work runs off the critical path. No await on C, pipe response, database append or work lock before a due action.
- [ ] Preserve GREEN plus cumulative normal/optimized suite; scheduler independence remains untested until a separately authorized process stage.
- [ ] Audit every competing trigger, unknown response, restart and consumed-slot path against no-retry rules.
- [ ] Prepare commit title/body `feat(wp06): enforce independent single-use supervisor control`; no runtime grant implied.

### B05 — Fixed artificial actor state and independent cooperative receiver

**Files:** Create `actors.py`; modify `test_stage_b.py` (ActorTests). Depends B01/B03/B04. Interfaces: `controller_step(state: dict, stimulus: dict, now_tick: int) -> dict`; `worker_step(state: dict, control_receipt: dict | None, work_blocked: bool, now_tick: int) -> dict`. Future explicitly entered role loops use these transitions; import starts no loop. States carry binding, sequence, previous digest, phase and terminal disposition only; no data/model/shell payload.

**Five tests/assertions:** `test_blocked_work_does_not_block_receiver_transition`; `test_stop_applied_requires_current_exact_event_and_lease`; `test_self_ceiling_exit_does_not_claim_supervisor_application`; `test_second_controller_is_fresh_not_resumed`; `test_worker_replacement_preserves_old_generation_and_rejects_stale_records`.

- [ ] Write ActorTests with finite input histories and independent expected state changes.
- [ ] Preserve RED for missing receiver/state isolation and generation checks.
- [ ] Implement only fixed role stimuli and separate cooperative receiver/work dispatch. No arbitrary task function, new child, executable path or participant payload accepted.
- [ ] Preserve GREEN plus cumulative normal/optimized suite without threads, actors or handles.
- [ ] Audit receiver/blocked-work separation, self-ceiling attribution and replacement caps; live independent reception remains unverified.
- [ ] Prepare commit title/body `feat(wp06): add fixed disposable actor state transitions`; no actor execution authority.

### B06 — Independent evidence, causal attribution and cleanup closure

**Files:** Create `observer.py`; modify `test_stage_b.py` (ObserverTests). Depends B01/B03/B04/B05. Interfaces: `assess_case(case_id: str, evidence: list[dict], expected_resources: list[dict], scope: dict) -> dict`; `assess_cleanup(expected_resources: list[dict], observed_resources: list[dict], observer_exit: dict | None) -> dict`. Result fields: `case_id, evidence_domain, dimensions, disposition, blockers, evidence_digests`; dimensions name reservation/control_attempt/worker_application/original_exit/cleanup/integrity separately. Scientific acceptance always false.

**Five tests/assertions:** `test_signal_ack_or_natural_exit_cannot_prove_application`; `test_wrong_handle_or_replacement_exit_cannot_close_original`; `test_pending_io_or_missing_resource_stays_hold_without_kill`; `test_observer_cannot_self_attest_final_exit`; `test_late_ambiguous_or_artificial_evidence_cannot_pass_real_case`.

- [ ] Write ObserverTests with authentic-looking but deliberately mismatched/partial artificial histories.
- [ ] Preserve RED for missing dimension, same-handle, evidence-domain and inventory enforcement.
- [ ] Implement independent verification and causal accounting; require L's authenticated same-O-handle exit evidence for final cleanup. Do not infer global host immutability from owned-resource closure.
- [ ] Preserve GREEN plus cumulative normal/optimized artificial suite.
- [ ] Audit every missing/unknown/late observation and all resources; none permits fallback, relabeling or scientific promotion.
- [ ] Prepare commit title/body `feat(wp06): separate Stage-B application exit and cleanup evidence`; no acceptance claim from fixtures.

### B07 — Deny-by-default launcher and staged orchestration

**Files:** Create `launch_stage_b.py`; modify `test_stage_b.py` (LaunchTests). Depends B01–B06. Interfaces: `plan_launch(case_id: str, decisions: list[dict], expected_scope: dict, verify_decision) -> dict`; `run_authorized_case(plan: dict, bridge: Bridge, clock) -> dict`; `main(argv: list[str]) -> int`. Default/no-argument entry returns a blocked report before bridge activation; unknown argument/fixture-to-runtime substitution denied. No CLI switch can manufacture grants or select arbitrary code/data.

**Five tests/assertions:** `test_default_entry_denies_before_any_native_call`; `test_quiescent_bootstrap_cannot_dispatch_fault_or_control`; `test_bootstrap_failure_consumes_allowance_without_replacement_or_kill`; `test_total_and_concurrent_caps_and_no_resume_enforced`; `test_untrusted_provider_or_changed_build_revokes_admission`.

- [ ] Write LaunchTests with a strict artificial bridge recording actions and failing on forbidden phases.
- [ ] Preserve RED for absent entry denial/phase and allowance enforcement.
- [ ] Implement only the exact ownership topology, phase boundaries and allowed fixed role entrypoints. Actual bootstrap/work still requires authenticated decisions plus observed evidence; no raw caller Boolean is authority.
- [ ] Preserve GREEN plus cumulative normal/optimized artificial suite; no script/default discovery may launch a process.
- [ ] Audit L versus O exit responsibilities, partial-bootstrap inventory and no-retry caps. Host setup/calibration stays a separate approved operation.
- [ ] Prepare commit title/body `feat(wp06): gate Stage-B orchestration by phase and exact scope`; no stage/commit/push automatically.

### B08 — Cross-component artificial histories, case adapters and final implementation audit

**Files:** Modify `test_stage_b.py` (IntegrationTests); touch the six implementation modules only to correct defects demonstrated by new RED cases. Depends B01–B07. Consumes all interfaces, produces artificial test receipts only; no real-case result packet or adopted runtime profile.

**Five tests/assertions:** `test_ac17_ac18_independence_and_fresh_client_model`; `test_ac19_retained_handle_variant_forces_full_case_hold`; `test_ac20_transport_uncertainty_never_duplicates_control`; `test_ac21_disabled_and_exact_grant_branch_remains_conditional`; `test_ac22_full_inventory_and_launcher_exit_evidence_required`. Each drives the real implemented decision/state/verification code through a strict artificial external boundary; merely testing that a fake returns its programmed result is insufficient.

- [ ] Write the five cross-component histories, including adversarial evidence-domain and identity substitutions; retain all original case catalogue/status fields unchanged.
- [ ] Preserve RED where a real decision/state/verification defect exists; if behavior already passes, record coverage as characterization rather than inventing a failed run.
- [ ] Implement only demonstrated corrections; AC19 never reports actual numeric PID reuse under retained handles. AC21 fixture permission is never a live termination grant.
- [ ] Preserve the full named artificial suite normally/optimized, test totals, failures and rejected mutations. Do not run broad historical discovery or any AC17–AC22 process test.
- [ ] Conduct code/spec/interface/security-boundary self-review; then one explicitly scoped independent code review if authorized by the selected execution skill. Preserve findings and one correction pass. Hash all previous packets, seal the new implementation packet and verify separately; no acceptance from a review message alone.
- [ ] Prepare full final commit title/body `feat(wp06): complete isolated Stage-B artificial implementation`; stop for owner review before any host probe, bootstrap, launch, fault or control.

## Complete design-to-task crosswalk

| ID | Design obligation | Owning tasks |
|---|---|---|
| D01 | Isolation, zero inherited research/service authority | B01, B07, B08 |
| D02 | L/O/S/C/W topology and launcher-observed O exit | B03, B06, B07 |
| D03 | Four concurrent actors; total four/five; no retry/resume | B05, B07 |
| D04 | Exact executable/environment/handle inheritance | B03, B07 |
| D05 | Broad creator-right narrowing and exact retained identity | B03, B06 |
| D06 | All 18 binding fields, generation and observer-bound boot continuity | B01, B03, B05 |
| D07 | Reservation/slot committed before work | B02, B04 |
| D08 | Single independent consumer; no C/I/O/journal/work-lock dependency | B04, B05, B08 |
| D09 | Separate attempted delivery, W application, exit and cleanup | B04, B06, B08 |
| D10 | Local single-writer journal, high-watermark/recovery quarantine | B02 |
| D11 | Restricted local pipes, peer ownership, fresh scoped credentials | B01, B03 |
| D12 | Canonical authenticated chains, frame bound and role-kind allowlists | B01, B03 |
| D13 | OVERLAPPED/buffer/wait lifetime through observed completion | B03, B06 |
| D14 | Integer QPC, strict deadlines, ambiguity and no grace | B01, B04, B06 |
| D15 | AC17–AC22 case coverage and evidence-domain distinction | B08 |
| D16 | AC19 replacement-only; numeric-reuse limitation/HOLD | B05, B08 |
| D17 | AC21 conditional profile/target grant, no request-as-exit shortcut | B03, B06, B08 |
| D18 | Phased policy/bootstrap/observed/conditional/completion admission | B01, B07 |
| D19 | Immutable failures/pointers, final review/seal/separate readback | B08 |

## Completion criteria and next permission boundary

**This planning task:** source pins verified; eight tasks/40 prospective tests/19 design obligations/six case mappings defined; interface/dependency/phase consistency self-reviewed; prior packets and state preserved; new plan sealed and separately read back. It does not implement any task above. The fresh 17-test parent metadata suite may be rerun because it is inert; those results test the existing documentary boundary, not these future 40 tests or runtime behavior.

**Future isolated implementation:** all eight tasks, artificial tests and scoped review/seal complete, with import/default entry proved side-effect-free. Even that outcome leaves host compatibility, trusted providers, numeric calibration, effective ACL/key/storage proof, actual supervision and all real AC17–AC22 cases unverified. No runtime default/provider or trust root may be guessed to obtain GREEN.

**Remaining owner/operator decisions:** review this plan and select/confirm native execution (recommended for tightly shared interfaces and lower coordination overhead), or explicitly choose delegated execution; separately authorize artificial-only implementation/testing and its write scope; adopt actual trusted decision/provider/build profile; grant bounded host/calibration/bootstrap scope only afterward. AC19 narrower-scope adjudication and optional AC21 grants stay explicit. A request to implement does not itself approve a numerical budget, actor launch or fallback.

Plan review is the next checkpoint. No further planning loop is needed unless the owner changes scope or the implementation exposes a genuine design contradiction; identify that exact contradiction before proposing a successor packet.
