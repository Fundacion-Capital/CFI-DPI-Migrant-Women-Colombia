# WP06 — isolated live-control integration and acceptance

## Decision and measured scope

**Completed for the isolated artificial-worker domain only.** The combined four-task package implements native ownership/bootstrap, independent control roles, the finite acceptance suite, and review/correction/preservation audit. It does not release a participant execution gate or alter the scientific analysis. Entry HEAD: `365fea7a2ca5bd0518c0f60b6bfa05b1fbb829e4`.

The owner authorized empty/artificial workers only, without participant data, fitting or shared-service changes. All changes are new files in this folder plus a restricted local evidence packet. Old Stage-B ARTIFICIAL-only guards, source/runtime preflight evidence, scientific do-files, manuscript and previous packets are preserved unchanged. No staging, commit, push, cloud synchronization, release or contact is performed.

## Four combined tasks

1. **Ownership/bootstrap — complete.** Suspended creation, job assignment before resume, explicit inherited-handle list, run/role credentials through private pipes, PID plus creation-time checks and source/executable fingerprints. Native jobs are kill-on-close; work waits for the launcher prearm gate.
2. **Live integration — complete within this domain.** Real separate observer, supervisor, controller and artificial worker processes. The supervisor holds the worker handle; the independent observer holds the nested job; the launcher holds the outer job and native exit witnesses. No arbitrary command, participant path or foreign-PID command interface.
3. **Acceptance — complete.** One initial six-case wave and one diagnosed post-fix six-case wave, without in-case retry or replacement. The final wave alone supplies the accepted measurements below. Twelve native case packets total; no third wave.
4. **Review/final audit — complete subject to the matching restricted seal and separate readback receipt.** The initial independent reviewer identified three Important and one Minor finding. Failure reproductions, corrections and final normal/optimized tests are retained; no post-fix independent endorsement is asserted.

## Final measured acceptance

| Artificial profile | Accepted observation | Seconds | Active owned processes after cleanup |
|---|---|---:|---:|
| Cooperative | W applied the stop event; native O/S/C/W exits all 0 | 1.0814683 | 0 |
| Controller exits | C exited 93; S observed that exit and stopped W; other exits 0 | 0.9754668 | 0 |
| Worker ignores stop | S terminated its exact retained W handle; W exit 73; no cooperative application credited | 1.3797015 | 0 |
| Supervisor stalls | Independent O contained the nested job; S/W exits 73 | 8.1090234 | 0 |
| Observer stalls | L contained the outer job; O exit 73; S/C/W exits 0 | 10.1117502 | 0 |
| Wrong worker creation identity | Rejected before any work/prearm; owned group emptied; one retained O exit witness, exit 73 | 5.0304021 | 0 |

All six final cases closed owned handles successfully. The five positive/prearm cases each have four retained launcher exit observations. The negative bootstrap case has only one: it must not be described as four individually witnessed exits. Its additional evidence is the worker identity-rejection record, absence of work/prearm reports and zero owned-group inventory after cleanup.

One QPC envelope is used per case: bootstrap5s, control8s, observer cleanup10s, outer cleanup12s. Measured seconds run from origin through native observations, evidence validation and owned-handle closure; final result-file fsync follows that measurement. These are observed bounds on these runs, not a claim of universal hard real-time Windows behavior or bounded storage latency.

Machine-readable measured results are in [acceptance_results.json](acceptance_results.json) and [CASE_RESULTS.csv](CASE_RESULTS.csv). No PID, role credential or participant information is published there. Source pins bind the final native wave to the tested implementation, inherited ABI/encoding modules and interpreter.

## Review corrections and tests

- **I1: cleanup on every path.** An unconditional ownership `finally` now encloses setup and observation. Closing attempts continue after an individual handle error; closure errors prevent acceptance. Final publication is after successful closure. Pure tests cover accounting, termination, exit-observation, close and publication failures, and late closure.
- **I2: whole-profile evidence.** Acceptance checks exact native exit codes, required reports and permitted faults, native creation identities, reported worker identity, and O/S exits against L's retained-handle observations. Tests reject a controller publication fault, missing request, wrong authenticated identity and inconsistent exits; a complete valid fixture must still pass.
- **I3: bootstrap deadline.** Recheck after report read, after PREARM publication immediately before release, and after observing the gate. Deadline equality is expired. Tests reproduce each late-admission path.
- **M1: bounded reader.** Read at most 8,193 bytes before rejecting reports larger than 8,192, rather than allocate an arbitrary file first.

Final tests: **19 normal pure tests, 19 optimized pure tests and 148 inherited artificial tests passed.** No unit discovery launches workers or loads a Windows DLL. The first inherited rerun failed because this package's runner omitted creating its new artificial SQLite directory; all 30 errors and the failed receipt are preserved. The runner setup was corrected, and all 148 passed in a separately created directory. No inherited code was changed. The initial native wave and review RED failures also remain preserved, not overwritten or selectively replaced.

## Remaining gates and next immediate task

The independently controlled artificial-worker route is now evidenced. **The existing Stata-MCP execution route is not thereby bound to it.** No busy Stata cancellation, recovery policy, deployment credential chain, source-exact empirical adapter or participant load has been validated by these Python workers.

The next practical WP06 task is a **source-exact empty-Stata integration contract and no-execution preflight**: identify how an owned Stata-MCP session could retain an independent enforceable deadline/control/cleanup path without weakening the current recovery/service boundaries; specify the exact empty-session test and allowed command set before seeking execution authority. If that cannot be integrated without service changes, report the limitation and options rather than claim equivalence or run a participant wave.

The accepted D2–D6 scientific decisions remain documentary; P1–P4 verification still requires its exact source/adapter, runtime/control, output and budget gates. Unresolved institutional rights, historical consent corroboration, privacy/remediation and release-review questions remain explicitly unresolved. Public-release requirements are not misrepresented as permission to inspect participants, and this operational package supplies no institutional approval.

## Evidence and preservation

Restricted packet: `audit-local/intake/wp06-live-control-365fea7/`. It retains entry fingerprints, plan and owner scope, initial sources, RED/GREEN tests, both complete native waves, initial independent review, correction disposition, inherited-test failure/recovery and final audit/seal/readback. Live role keys were not persisted; MACs were verified during execution. Later readback verifies sealed bytes and consistency, not a second MAC authentication after keys are discarded.

The preservation audit checks all **24,699 entry files** as opaque bytes, without opening participant containers as records. Its first inventory check rejected the interpreter's already Git-ignored `__pycache__` directory; that audit failure is retained. The corrected check requires exactly eight deliverable files, verifies the ignored cache against its source and includes retained cache bytes in the private seal. Nothing was deleted. Private packet artifacts and ignored runtime caches must not be included in a public commit. The commit title/body are prepared separately; nothing has been committed or published.
