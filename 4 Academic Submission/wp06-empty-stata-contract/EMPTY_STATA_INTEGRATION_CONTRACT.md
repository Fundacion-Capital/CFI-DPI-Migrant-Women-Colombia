# WP06 — source-exact empty-Stata integration contract

29 October 2026 · Documentary and static-source assessment only

## Conclusion

**The contract and static compatibility assessment are complete; no existing live route is accepted. Execution remains held.** The currently installed Stata-MCP sources can create and recover workers under the same logical session ID. Their cooperative stop and ordinary cleanup machinery do not establish the independently owned, no-replacement, cumulative-deadline contract required here. The earlier live-control package demonstrated those controls for fixed artificial Python workers, not for Stata.

This package continues the interrupted `audit-local/intake/wp06-empty-stata-ac67a7e/` plan without changing it. Entry HEAD is `f912000bfe31a3c19d02a338b3c3da9cc339f996`: the intervening commit adds the Graphify navigation guide. The current instruction authorizes this contract and **no-execution preflight**, not deployment, Stata calls, process launches, cancellation probes, participant inspection, analysis changes or release.

Deliverables:

- [Machine-readable contract](contract.json): literal proposed selections, identity requirements, design ceilings and closed execution flags.
- [Source evidence](source_evidence.json): five exact source-file fingerprints, AST-derived callable signatures and eighteen line-bound evidence anchors.
- [Finite acceptance plan](ACCEPTANCE_PLAN.csv): E01–E16, separating static checks from later execution evidence.
- [Final static audit](audit_summary.json): populated only after entry preservation and documentary checks pass. Its status is not a runtime acceptance result.

Restricted evidence is retained separately in `audit-local/intake/wp06-empty-stata-contract-f912000-20261029/`. Neither that packet nor prior packets should be included in a public documentation commit.

## 1. Source identity and current configuration

The installed extension directory is `deepecon.stata-mcp-0.5.3-universal/src`. The three reviewed files remain byte-identical to the earlier protected-source intake:

| Installed source | Bytes | SHA-256 |
| --- | ---: | --- |
| `stata_mcp_server.py` | 270,346 | `6aa984b08a6657254804e690c77fb877a2d8e62c3b809caa14fe533d30402092` |
| `session_manager.py` | 46,935 | `5f9b427ffbd0d01afc51542a47f2652aff02a084c7c08cc73700ad9b8fda2308` |
| `stata_worker.py` | 52,352 | `0b5c27bdc3d2cb2b12327a2da43118cee8b124c753caf65d82af3d3c5cea088f` |

These are **on-disk source identities**, not proof of a running server's imported module version, worker epoch, loaded engine, license, capacity or responsiveness. No process inventory, service request or runtime import was performed here. Transitive imports, Python interpreter/engine binaries, startup profiles and dependencies still need their own exact manifest before any future runtime implementation can be accepted.

The current Codex configuration is again **12,442 bytes**, SHA-256 `4b00bef781965e1dc9ac94cd7a584fa8b7bd799518f51bc458d51bd4e8793d5a`, matching the original pre-Graphify pin. This is a new observation, not an agent repair or an explanation of the intervening change. The Graphify audit observed a different 12,439-byte file; its failed broad-preservation receipts remain failed and untouched. The owner's inability to recall a settings change remains part of that historical record. No configuration restore, edit, inferred approval or historical rebaseline occurred. Current equality does not bind a live runtime or reopen execution.

## 2. Compatibility crosswalk

Anchor IDs below resolve to exact source file, line interval and segment hash in `source_evidence.json`. Interpretations are static documentary judgments, not dynamic test results.

| Requirement | Actual source evidence | Assessment |
| --- | --- | --- |
| Fresh, explicitly owned session | S01, S04: session creation uses `multiprocessing.Process`; absent session IDs can be created on demand; omitted IDs resolve to the default | A unique name is insufficient. No ownership-before-initialization or physical-epoch admission capability is exposed by this route. |
| No recovery, replacement or retries | S03, S04, S06, S07: dead/error/stale workers can recover; restart recreates the same ID and permits two creation attempts | **Contradicted as-is.** Refusing a returned recovery flag afterward cannot prevent an already-created replacement. |
| Independent stop and deadline | S05, S10, S13: shared manager event, worker monitor and `StataSO_SetBreak()`; stop-sent acknowledgement | Cooperative signalling, not independent observation of application, native exit or containment. |
| One cumulative monotonic envelope | S06: result waiting uses `time.time()` and requested timeout plus five seconds; timeout recovery can add lifecycle work | Nominal call timeout is not the proposed absolute deadline. Recovery and teardown cannot be left outside the budget. |
| Cleanup owned physical worker only | S02: graceful wait, termination and registry removal through the same manager | Useful functionality, but not the independent retained-handle exit and owned-descendant evidence required here. |
| Literal payload boundary | S08, S09, S11: PyStata initialization, seed operations, log wrapping and working-directory handling precede/surround selection execution | Empty payload does not mean no infrastructure commands or filesystem effects. All must be separately bounded and accounted for. |
| Safe output and startup scope | S08, S09: worker/debug logs, temporary directory, selection log and graph directory defaults | Current output locations are not an accepted private per-run retention contract. Startup/dependency behavior is not fully audited here. |
| Existing artificial ownership harness | S15–S18: native jobs/handles and clocks exist, but launcher permits its fixed `live_roles.py` entry point; W waits for an event | Strong prior evidence in its own domain. Substituting Stata is neither supported nor an equivalent tested route. |
| Exposed integration interface | S11, S12, S14: selection parameters and list/destroy session actions; S11 also includes the alternate direct-execution branch at server lines 3151–3161 | No advertised worker-epoch, no-replacement or independent-role capability. If multi-session mode is disabled or the manager is absent, the current server can execute directly without the supplied session binding and with graph autodetection. Future admission must reject **before** that branch. Hidden HTTP routes are not an authorization or a substitute. |

**Route comparison.** (a) Reusing the current shared service unchanged fails this contract. (b) Replacing the artificial worker with a Stata command or direct PyStata call also fails and would bypass the project's Stata-MCP requirement. (c) A **separately owned, source-bound isolated Stata-MCP deployment** is the recommended candidate for subsequent implementation. It is not implemented, selected for live use or authorized by this package. No shared-service modifications are proposed for execution here.

The source-to-control gap is specific: retain native ownership before Stata initialization; require multi-session mode and the exact bound manager, rejecting before any single-session fallback; reject rather than recover every dead/error/timeout/stale/missing-session path after the single permitted initial creation; bind each command and stop capability to one physical epoch; isolate startup/output paths; and keep independent containment functional if the MCP request thread or manager stalls. A result validator alone cannot supply these controls. Existing artificial role code must not have its fixed-domain guards weakened to make the test appear to work.

## 3. Exact proposed empty-only fixture

These **two proposed selections** are also stored verbatim in `contract.json`. They were not sent to Stata, compiled as a do-file or dynamically syntax-tested. Native syntax, output and wrapper compatibility remain future evidence requirements. They intentionally contain no `clear`: unexpected data must cause failure, not erasure.

Selection 1:

```stata
* Verify a newly owned session; do not clear unexpected data.
display "WP06_EMPTY_BEGIN"
display "N=" c(N) " K=" c(k)
if (c(N) != 0 | c(k) != 0) {
    error 459
}
display "STATA=" c(stata_version)
display "FLAVOR=" c(flavor)
display "BUILD=" c(born_date)
display "MAXVAR=" c(maxvar)
```

Selection 2, in the same physical worker:

```stata
* Confirm that the same owned session remains empty.
display "WP06_EMPTY_END"
display "N=" c(N) " K=" c(k)
if (c(N) != 0 | c(k) != 0) {
    error 459
}
```

**Observation limit:** `c(N)` and `c(k)` describe the active frame only. They do not inventory other frames or stored objects and cannot certify whole-session absence of participant information. The separately audited startup/dependency boundary must exclude hidden loads, populated other frames and stored participant objects before admission. If that cannot be established, the route fails preflight; this fixture is not broadened into participant or object inspection.

Only these exact application payloads are proposed. No dataset/header inspection, `use`, import/export, save, data viewer, record listing, model, estimation, score, relabeling, graph, package installation, help execution, sleep or stress loop is included. No arbitrary macro expansion, user-supplied path or general file runner is permitted. The approved scientific sample and manual exclusions are untouched.

**Infrastructure is a separate boundary.** The installed worker initializes PyStata, sets seeds and wraps commands in named log operations; the server can prepend a working-directory change. Those operations cannot be represented as part of the two empty payloads or ignored. A future implementation must enumerate its complete startup/dependency/command behavior and bind private output destinations. Paths, inherited environment, working directory, seeds, temporary files, engine-generated files, logs and server history require explicit review. The current shared/default paths are not approved by this document.

## 4. Proposed lifecycle and finite ceilings

All ceilings are **unadopted design values**, not measured Stata performance or universal Windows real-time guarantees. They deliberately do not copy the earlier artificial harness's 5/8/10/12-second startup envelope.

- One newly owned non-default session and one physical worker epoch; at most two selection calls, nominal timeout 10 seconds each; zero retries and zero replacement workers.
- One native monotonic clock origin before the first owned launch. Startup/ownership/bootstrap must complete strictly before 60 seconds. No dispatch at or after 80 seconds; every dispatch must leave at least its 10-second nominal allowance before the 90-second control ceiling.
- Cooperative stop by 90 seconds if still needed; independently owned supervisor containment by 95 seconds, observer containment by 100 and outer containment by 110. All required native exit, closure and evidence checks must finish before 120 seconds. Equality with an admission/acceptance deadline fails. Eventual completion does not erase an overrun.
- Failure aborts the whole run. No fallback route, default-session substitution, recovery, repeated fixture, enlarged budget or edited source is allowed in that packet. A missing worker is an error, not a reason to create another one.

The future identity tuple comprises run ID, explicit session ID, worker epoch, PID **and creation time**, retained process handle, owned job, exact source manifest, observed loaded module path and corresponding disk hash, and clock domain. A session ID or PID alone cannot prove identity. A loaded path plus disk hash is still not a memory-image attestation.

No literal endpoint, launcher or usable run credential is supplied. A later task must fix the complete isolated deployment, transport schema and credential/ownership handoff before authorizing a launch. The proposed authority is not a standing permission to call the shared service or its hidden stop endpoint.

## 5. Acceptance and reporting rules

E01–E09 are the implementation/static gate; E10–E15 require separately authorized empty execution. E16 limits interpretation. The current assessment resolves the documentary/source question while leaving implementation and runtime evidence open.

Future empty success requires both selections to report zero rows/variables, one unchanged physical epoch, no retries/recovery, exact payload/order and reviewed wrapper behavior, all deadlines satisfied, native exit witnesses, zero active owned descendants, successful handle closure and complete private output accounting. Every attempt, including aborted and failed ones, must remain separately preserved.

A stop request, `stop_sent`, registry disappearance, missing PID, tool return or successful short command is not sufficient cleanup or busy-cancellation evidence. A matching source hash does not prove a loaded module. **Even a later successful empty-session test would not prove interruption of busy Stata, participant-operation safety, P1–P4 readiness or scientific validity.** Any such claim would require its own bounded evidence and authority.

## 6. Audit, preservation and practical next task

The new packet retains the current entry inventory, prior-seal comparisons, static source extracts, missing-contract RED receipt, positive/negative documentary checks, independent technical review and final preservation/seal/readback. Opaque hashing does not parse participant containers. No participant values, names, telephone numbers, keys, individual dates or locations were inspected or exported.

Independent review identified three Important gaps: file-set additions checking, the exact single-session fallback, and the active-frame limitation. All were corrected. A fourth status-label inconsistency was also corrected as an audit-integrity issue. Ten added artificial regression tests went through retained RED/GREEN runs; the final suite contains **23 documentary tests**. The reviewer did not perform a post-correction review or the final multi-gigabyte preservation rehash; those corrections are supported by the retained tests and the integrator's final audit, not a claimed second endorsement.

The original interrupted packet and the qualified Graphify packet remain unchanged. The earlier failed Graphify preservation/assembly receipts retain their original failed status. Current source/configuration equality is not used to reinterpret their historical claims. The only intended Git-visible additions are these five documentary files; commit title and description are prepared privately, not executed.

**Next immediate task:** implement and artificial-test the minimal isolated Stata-MCP ownership/admission/no-replacement boundary, with the exact transitive-source, startup/output and deployment manifest. This would be a separately scoped implementation task: no shared-service edits, Stata launch or participant processing. A subsequent fresh no-execution check must pass before requesting authority for the one-session/two-selection empty fixture. Do not resume the held participant verification merely because this documentary package is complete.

The D2–D6 scientific decisions, institutional rights/consent corroboration, historical privacy/remediation findings, coauthor/CFI checkpoints and public-release conditions remain exactly as previously recorded. This operational document resolves none of them and assumes no further approval.
