# WP06 — isolated Stage-B artificial implementation

18 October 2026. Source plan: [B01–B08 implementation plan](WP06_STAGE_B_IMPLEMENTATION_PLAN.md). Baseline `c46e53b6d57646bebcd59393271c9342b2585ca1`.

## Scope and acceptance boundary

The owner approved native implementation with artificial-only tests, not host probes, process launches, live control, service changes, Stata or participant processing. Seven isolated files implement exact protocol/admission/time rules, fresh artificial journal behavior, owned-resource policy, deterministic supervisor/actor transitions, evidence/cleanup assessment and bounded artificial bootstrap orchestration.

**No operational provider is adopted.** The bridge accepts only an explicitly injected artificial native boundary; its Windows signatures are unbound declarations, not a DLL loader or working native backend. The default entry refuses execution. `run_authorized_case` ends at ARTIFICIAL_BOOTSTRAP_ONLY and cannot promote policy approval into actual prearm/work proof. This is not a deployed process executor, supervisor scheduler, production journal or completed AC17–AC22 trial.

## Implemented surfaces

| Task | Source | Artificial behavior covered |
|---|---|---|
| B01 | [journal_protocol.py](wp06-stage-b/journal_protocol.py) | Exact 18-field binding; canonical HMAC envelopes; sequence/chain/role/frame checks; phased pinned-verifier admission; unsigned integer time/deadline rules. |
| B02 | Same module | New per-run SQLite stores only; committed consumed reservations; immutable slot readback; no reopen/retry; high-watermark/recovery quarantine; postaction persistence uncertainty. |
| B03 | [win32_bridge.py](wp06-stage-b/win32_bridge.py) | Deny-by-default artificial boundary; owned tokens/full binding; fixed executable/environment/handle policy; pending buffers until observed completion; separate cancellation/termination/exit states. |
| B04 | [supervisor.py](wp06-stage-b/supervisor.py) | Durable prearm; one consumed stop slot; deterministic deadline/loss decisions; no journal or controller-response wait on the attempted-action path; deferred persistence. |
| B05 | [actors.py](wp06-stage-b/actors.py) | Fixed state transitions; verified current event/lease; blocked-work receiver independence as a model; fresh generation; self-ceiling not supervisor application. |
| B06 | [observer.py](wp06-stage-b/observer.py) | Separate reservation/attempt/application/exit/cleanup/integrity; authenticated artificial evidence; same target; timing and resource checks; independent L observation requirement. |
| B07 | [launch_stage_b.py](wp06-stage-b/launch_stage_b.py) | Default refusal; exact manifest and topology; shared artificial launch caps; failed bootstrap consumed without retry/kill; no work dispatch from idle bootstrap. |
| B08 | [test_stage_b.py](wp06-stage-b/test_stage_b.py) | Cross-component artificial histories, forged/stale/partial evidence refusals, explicit AC19/AC21 HOLD and AC22 cleanup-model checks. |

## Evidence and limitations

The first seven tasks each have preserved expected missing-implementation RED receipts followed by cumulative normal and optimized GREEN receipts. The five B08 composition tests already passed against B01–B07 and are honestly recorded as characterization, not fabricated RED. Initial complete suite: 40/40 normal and 40/40 optimized. Final review/correction tests and final counts are governed by the private receipts, not this initial count.

SQLite stores contain synthetic records only and remain in this task's Git-ignored evidence packet. No old store is reopened. These tests are not cross-process contention, crash/power-loss durability, scheduling or host storage-policy proof. The model native boundary, fixture keys, clocks, PIDs and attestations are not actual observations or adopted credentials. Same-SID/shared-key authentication is not nonrepudiation.

All real AC17–AC22 cases remain NOT_EXECUTED. AC19 remains replacement/stale-record coverage only; retaining a process handle makes numeric reuse unavailable and full-case acceptance remains HOLD. AC21 remains disabled without separately adopted profile/target grants; artificial branch tests cannot grant termination. All 15 external gates remain pending and all 27 runtime facts null in the immutable preparation package.

## Preservation and review

Private packet: `audit-local/intake/wp06-stage-b-implementation-c46e53b`. It retains approval, entry hashes, every source snapshot/test run/store, rulings, independent review, any single correction pass, final seal and separate readback. No packet is deleted. The approved plan and previous seal/source files remain unchanged. Five governance surfaces append the successor; no earlier pointer/status is relabeled.

One independent source review found 0 Critical, 7 Important and 1 Minor issues. The initial 40-test suite did not cover the seven model defects; the reviewer did not rerun tests or independently enumerate the archive. The single owner correction pass reproduced all seven in a valid RED run, corrected them and passed **47/47 normal and 47/47 optimized**. No second independent review is claimed. The existing inert preparation suite also passed freshly17/17 in both modes; the static boundary scan confirms all40planned test names among47actual methods, not native runtime safety.

The corrections cover due-action independence with bounded local authority expiry/revocation, same-handle exit before closure and AC19 retention, conservative causal/nested timing, complete pinned resource inventory and independent O/L proof, exact specs/phase budgets/clock continuity/actor ceilings, preceding cooperative uncertainty and separate S-owned fallback handle, and exact reservation-bound recorded receipts. O's signed pre-exit inventory leaves O pending L; L independently observes O exit and records later closure/integrity. No future L observation is embedded in a pre-exit O statement.

Initial wrong passing fixtures, failed/missing-helper RED candidate, valid seven-failure RED, Windows-path-length fixture failure, corrected sources and final results remain preserved separately. Only the new artificial fixture basename was shortened; no host setting changed. Minor M1 remains deferred: malformed issuer/kind containers can raise TypeError rather than ValueError, but fail closed. That exception contract must be normalized before future live parser adoption.

Read `review.json`/`review_record.md` for findings, exclusions and owner correction disposition. Final preservation is accepted only through the actual validation seal and sibling closure receipt. No scientific validity, runtime safety, publication readiness, institutional approval or release follows from an artificial test, review message or preservation receipt.

## Residual implementation/provider crosswalk — not completed by this task

| Surface | What remains unavailable/unimplemented | Gate before any real use |
|---|---|---|
| B01 real authority | Institutional trust roots, scoped key provisioning/revocation and actual attestation verification | Adopt exact trusted providers/build and G01–G04/G08 evidence; fixture callbacks are not real authentication. |
| B02 real store | Restricted active/archive locations, real recovery/high-watermark authority, deployment and crash/contention durability evidence | G05/G09/G15; no original/restricted store opened by this build. |
| B03 Windows backend | Functional native process/pipe/event/handle adapter and installed ABI verification; current declarations are unbound | Separately scoped backend implementation/review and G02/G03/G07/G08; no DLL or API probe now. |
| B04/B05 process operation | Real independent watchdog/receiver scheduling, native role loops, actual clock/boot continuity and latency limits | G03/G04/G09/G10 and separate bounded host authority. Pure transitions do not establish scheduling. |
| B06 actual evidence | Real complete owned-resource inventory, independent signed observations and observed cleanup | G07/G08/G12/G15. ARTIFICIAL model/structural outcomes are not real AC acceptance. |
| B07 full executor | Real bootstrap-to-work/fault process executor; current function ends at artificial idle bootstrap | Exact runtime providers and phased launch/work/fault grants; no automatic advancement from this packet. |
| AC19/AC21 | Numeric-reuse scope adjudication/retention release; optional real fallback profile and exact-target authority | AC19 remains full-case HOLD with conservative retention; AC21 real branch disabled, G13/G14 separate. |

**Accepted scope is bounded artificial policy/state implementation, not unqualified completion of all native bridge/executor functionality originally envisioned.** The injected ARTIFICIAL provider is trusted test configuration, not a sandbox proving arbitrary injected code harmless. Operational gate decisions, all27runtime facts and all real AC statuses are unchanged.

## Next boundary

After bounded artificial acceptance, review the exact residual provider/backend and institutional-gate crosswalk. Do not jump to host probes, calibration, idle bootstrap, live actor/control tests, fallback or Stata. Real provider adoption, Windows implementation verification and any bounded host operation need separately defined authority and actual evidence. No unimplemented native behavior is silently covered by these fixtures.
