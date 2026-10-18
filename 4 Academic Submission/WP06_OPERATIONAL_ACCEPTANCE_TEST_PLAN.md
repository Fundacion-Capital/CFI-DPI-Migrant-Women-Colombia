# WP06 — Operational acceptance-test plan

18 October 2026 · Contract `WP06_OPERATIONAL_INTEGRATION_V1` · **All 28 cases below are planned, NOT_EXECUTED.**

## 1. Purpose and current permission

This plan operationalizes the 12 requirements of the [integration contract](WP06_OPERATIONAL_INTEGRATION_CONTRACT.md). It is not a runbook permission, deployment instruction or report that an operational test passed. The [case catalogue](wp06-operational-contract/acceptance_plan.json) contains each ID's exact phase, requirements, preconditions, stimulus, pass evidence, failure disposition, unexecuted status and empty execution-evidence list.

Today only documentary/schema validation and named pre-existing artificial/metadata tests run. Existing 32 isolated adapter tests provide partial design evidence for ownership, clock and terminal-state rules; they do not implement durable recovery, authentication, actual process identity or independent supervision, and do not satisfy these integrated cases. Passing the documentary checker is not an AC case result.

## 2. Stages and authorization gates

| Stage | Target and prerequisite | New authority required | Current status |
|---|---|---|---|
| A: AC01–AC16 | Selected integration components in artificial fixtures, no engine/service/participant input | Explicit new artificial implementation/testing scope after O01–O07 selection as applicable | NOT_EXECUTED |
| B: AC17–AC22 | Owned disposable **non-Stata** processes with approved handles/transport and preserved inventory | Exact disposable-process scope; additional owned-termination grant for AC21 or a destructive fault injection | NOT_EXECUTED |
| C: AC23–AC28 | Fresh, empty, owned engine and accepted control build | Explicit empty-engine probe scope and operator integration adoption; separate service/config change or termination approval if needed | NOT_EXECUTED |
| Research fitting/data/release | No cases in this plan | Entirely separate scientific/input/institutional/fit/release contract | OUT_OF_SCOPE |

No future stage inherits permission from the earlier one. Case labels are scope identifiers, not redeemable credentials. Refusal or inability to select/prove a component is a HOLD, never an assumed pass. All applicable A cases must pass independent review before B; all applicable A/B cases and exact empty-engine scope must be accepted before C. A build, protocol, credential or ownership change invalidates affected prior acceptance: re-evaluate case dependencies under a new exact manifest, without rerunning anything automatically.

## 3. Per-case execution envelope — future only

Before an authorized case, the operator must seal: case/contract/build digests, exact disposable or empty target inventory, permitted fault/control actions, registration provenance, journal and proof mechanism, supervisor/lease identity, host/boot/clock domain, numeric execution/cleanup limits, retry 0, restricted evidence locations, expected outcome and authorized decision-maker. A missing value blocks reservation; never invent a permissive default. No research-data path, model command or arbitrary code may be inserted into this plan.

Each case must preserve entry/current/exit identity, durable reservation and arm records, injected fault boundaries, authentication-verifier outcome, ordered receipts, independent supervisor observations, exact process/engine outcome and cleanup inventory. Use artificial canaries rather than participant content. Negative cases pass only when rejection is observed **before the prohibited side effect**; an exception after dispatch is a failure. Where the expected outcome is quarantine, record it as an observed safe rejection—not as confirmed engine termination.

Case status is one of NOT_EXECUTED, PASS_WITH_VERIFIED_EVIDENCE, FAIL_PRESERVED or BLOCKED_MISSING_PREREQUISITE in a **future separate result packet**. The planning catalogue is immutable and remains NOT_EXECUTED. Actual result evaluators, proof verification and authorization validation are not implemented by the current documentary checker. No bool supplied by a caller or nonempty evidence path is enough to confer a future PASS.

## 4. Acceptance catalogue

Full details are in the JSON catalogue; these summaries preserve each required behavior and its evidence burden.

| Case | Stage / requirements | Required behavior and proof |
|---|---|---|
| AC01 | A / C01,C02 | Exact ownership schema; reject missing/extra/mutable/default/shared identities before any reservation or action. |
| AC02 | A / C02,C05 | Replace a queued worker under the same session; atomic current-generation check must deny the old intent. |
| AC03 | A / C03 | Concurrent duplicate reservation/command claims yield one durable winner; terminal claims never release. |
| AC04 | A / C03,C09 | Inject each reserve/dispatch crash window; no precommit dispatch or uncertain resend, all committed attempts remain consumed. |
| AC05 | A / C03,C09 | Restart a controller and attempt reuse; fence old lease/generation and prevent automatic adoption or resume. |
| AC06 | A / C04,C08 | Tamper proof/body/issuer/sequence; actual authentication must fail, not merely inspect a signature field. |
| AC07 | A / C04,C09 | Replay/revoke/wrong-scope messages; no delivery or lease extension from stale credentials. |
| AC08 | A / C05 | Eight cancel callers, duplicate delivery and pre-start cancellation; at most one applied break and zero pre-start dispatch. |
| AC09 | A / C06 | Exact deadline boundaries, early stop and duplicates; no implicit grace or cleanup extension. |
| AC10 | A / C06,C09 | Independent consumer expiry→rollback and nonfinite/extreme numbers; neither gate reopens or miscounts an intent. |
| AC11 | A / C06,C07 | Boot/domain changes or unknown delay; incomparable clocks cannot arm an unsafe lease. |
| AC12 | A / C08 | Missing/reversed/future events, legacy ack and registry absence; no false delivery/exit/cleanup confirmation. |
| AC13 | A / C05,C08,C09 | Lost ack, late stop and late success; retain quarantine without a second break or late-output adoption. |
| AC14 | A / C03,C10 | Corrupt/truncate/write-fail journal; block dispatch and preserve original plus diagnostic copy. |
| AC15 | A / C10 | Artificial sensitive canaries and unknown fields; reject/redact public payload and retain restricted originals. |
| AC16 | A / C11,C12 | All synthetic results green but no live/kill/fit/change grant; every unapproved action remains denied. |
| AC17 | B / C07 | Block dispatcher/client/worker queue; independently scheduled supervisor still acts within the approved deadline. |
| AC18 | B / C03,C07,C09 | Lose disposable controller/heartbeat and restart client; independently detect loss, consume old attempt, do not resume. |
| AC19 | B / C02,C05 | Recycle PID or same-session worker; handle/creation/boot/generation fences deny stale targeting. |
| AC20 | B / C04,C06,C08 | Break/reorder transport and receipts; no false outcome and no unbounded response-dependent cleanup. |
| AC21 | B / C07,C11 | Separately authorized fallback against one owned disposable handle; deny name/default/shared/recycled targets and independently prove exit. |
| AC22 | B / C10,C11,C12 | Inventory every disposable and supervisor after success/failure; no unintended process/config changes or hidden leftovers. |
| AC23 | C / C01,C02,C12 | Fresh exact empty-engine registration/build; no observations, variables, estimates, default targeting or participant paths. |
| AC24 | C / C04,C05,C08 | One separately authorized safe non-fitting cooperative probe; verified applied stop, engine outcome and cleanup separately, retry 0. |
| AC25 | C / C06,C07,C09 | Authorized timeout/lost-ack fault; independent control survives, uncertainty remains consumed/quarantined. |
| AC26 | C / C02,C08,C09,C11 | Final original-process identity/exit versus ready replacement or registry removal; no attribution to replacement. |
| AC27 | C / C10,C11 | Owned-resource cleanup and restricted receipt disclosure audit; unknown cleanup blocks adoption. |
| AC28 | C / C01,C12 | Operator adoption cannot activate research fitting/data/release; independent gates stay closed. |

AC21 and destructive variants of other cases require exact additional termination/fault authority even if B was generally approved. A fallback-absent design must explicitly mark the fallback unavailable and adopt a narrower scope; it may not silently omit AC21 yet claim fallback acceptance. Any formally inapplicable case requires an independently reviewed scope restriction in the future result packet, not deletion or renumbering of the catalogue.

## 5. Stop rules, recovery and final acceptance

Stop the case and preserve the failure on unknown ownership, journal integrity/commit ambiguity, lost independent supervision, unverified authentication, clock/domain failure, repeated break, unexpected worker, participant-data exposure, unapproved change or missing exit/cleanup evidence. Do not extend the budget, retry the command, apply a second native break, recreate a worker or remove evidence. A permitted cleanup action remains narrowly bound to its explicit target/scope; uncertain cleanup is reported, not forcibly hidden.

An independent assessor must compare the exact manifest to implementation/build, inspect the fault evidence and verify authentication/identity rather than rely on operator prose. Acceptance records list every applicable/inapplicable case, evidence verification, residual limitations and adoption scope. Mixed results cannot be summarized as all-pass. Backend or worker recovery must not reset the consumed reservation store. Rollback of code is not rollback of attempted work.

An accepted empty-engine control system is still **not evidence that a particular estimator/optimizer will be interruptible**. No fit or participant-processing case is authorized here. That later question requires its own bounded scientific/execution decision, with no reuse of consumed historical slots.

## 6. Current package validation and next step

The documentary checker rejects missing/duplicate/unknown requirements and cases, phase downgrades, invented approvals, inserted execution evidence and nonzero authorities. It checks the crosswalk, not the implementation of the 28 behaviors or the semantic truth of every sentence. Named predecessor tests and new checker tests are separately identified in the private closure; their count is never reported as 28 operational tests executed.

Entry preservation, one fresh read-only review, any tested corrections, final seal and separate readback are recorded in `audit-local/intake/wp06-operational-contract-f3e3e16` and its sibling verification folder. No prior packet or adapter is modified. The next step is operator selection O01–O07 and an exact isolated implementation plan; no live run follows from finishing this preparation.
