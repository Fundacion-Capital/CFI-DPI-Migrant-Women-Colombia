# WP06 bootstrap and cleanup diagnostic outcome

30 October 2026. **The saved-state/artificial diagnostic work is implemented, with a qualified artifact-only integrity outcome—not a full preservation pass, provider repair or native-runtime acceptance.** The full audit remains failed on two semantic-tool cache files; the separate qualification and seal/readback govern only this packet's integrity. The earlier one-run authorization remains consumed; no new launch or grant was made.

## Findings

**1. A cleanup-lifecycle defect is reproduced in the exact source with artificial effects.** On failed bootstrap, `OwnedBoundary.open()` calls its own `close()`, consuming the manager's cleanup reservation. The outer `build_server()` wrapper has not received or cached that result. When server finalization invokes the wrapper, it calls `manager.close()` again; the manager rejects the consumed reservation. The wrapper sets its own closed flag before that call, so another wrapper invocation subsequently returns its still-empty result (`None`). These are distinct lifecycle states, not evidence that native cleanup succeeded.

The new fixture exercises the actual isolated tool adapter, source-extracted installed manager method, owned manager and native provider with the existing fake kernel/channel. It reproduces both the failed-bootstrap path and a preallocation-expiry path. No second worker or native effect is performed. The successful two-selection artificial path still returns a cached wrapper result without repeated cleanup. This demonstrates a concrete source-level result-ownership defect consistent with the saved server-finally exception; it does not reconstruct every actual native cleanup operation.

**2. The original watchdog bootstrap rejection remains underdetermined.** Its single error message covers packet schema, role agreement/allowlist, binding digest, QPC frequency, current-process creation identity and the absolute deadline. The failed trial retains neither the private bootstrap packet nor the child's evaluated operands. The parent ownership witness cannot substitute for the child's frequency, own identity or guard tick. No particular predicate is established as the primary cause.

**3. No static producer/consumer format defect was established.** An artificial fixture passes actual `NativeOwner.initialize()` output through the actual `Kernel.bootstrap()` serializer and `read_private_bootstrap()` reader using a fake Windows ABI, then through the exact guard AST. Both roles supply the expected nine fields. Large artificial creation-time integers above the JavaScript exact-integer range survive the Python JSON path. This rules out neither real native identity mismatch nor runtime timing; it is a controlled compatibility result, not an inspection of the unretained real payload.

**4. Deadline expiry cannot be excluded from filesystem timestamps.** The shared monotonic origin is captured during owner construction, before manager/SDK setup and allocation. The child guard rejects at or after origin plus 60 seconds. A short interval from the ownership file to watchdog error output does not show that the full original budget remained. An artificial delayed-allocation case illustrates this distinction. It is a possibility, not a diagnosis or a reason to extend/reset the deadline.

## Evidence reconciliation

| Boundary | Actual saved evidence | Source/artificial result | Limit |
| --- | --- | --- | --- |
| Ownership | Native worker identity and true inner/outer job membership | Parent constructs a common scope, origin, frequency, binding hash and worker identity | No retained actual watchdog own-identity packet or child comparison |
| Pipe producer/reader | No bootstrap payload retained | Actual serializer/reader and guard agree on artificial packets | Fake ABI is not native pipe/handle attestation |
| Bootstrap guard | Watchdog raises the generic rejecting-guard error | Each schema, role, digest, frequency, identity and deadline mismatch rejects in artificial cases | Actual first failed predicate remains unknown |
| Worker readiness | Eleven readiness/runtime/command/result/selection/exit/closure witnesses absent; worker stdout empty | Source waits for watchdog readiness before resuming worker and entering the engine | No completed Stata selection or initialization acceptance |
| Cleanup | Consumed-reservation exception in server finalization; no exit/closure witness | Manager/wrapper result-ownership gap reproduced | No live current-process, exit, zero-descendant or handle-closure assurance |

Exact source hashes, symbol locations, failed-run inventory and test logs are retained in the ignored private diagnostic packet. No identifiers, bootstrap credentials or participant data are included in this documentary folder.

## Verification and retained failures

The final artificial receipts cover **127 tests per mode: 113 existing tests plus 14 diagnostic tests**, with zero failures/errors/skips in normal and optimized modes. The guard-extractor test was first observed failing against an explicit stub, then passing against the actual source guard. The cleanup fixtures characterize an **unfixed** defect; their green status is not a repair claim.

The first full-suite attempt is preserved: nine existing async-client tests failed because the diagnostic runner blocked `socket.socket`, which Windows asyncio needs for its internal wakeup pipe. The source provider was not changed. A separate runner version allows that standard-library internal mechanism while blocking real SDK/Stata imports, DLL resolution, subprocess creation and the explicit connection helper. Its guard is not claimed to intercept every possible Windows network API. All nine failures and their original receipt/log remain alongside the later green receipts. There was no native-trial retry.

The no-execution preflight checks thirteen exact source definitions, twenty-six Python 3.11 grammar/source pins, artificial receipts, unchanged failed-run files and disabled source metadata. It does **not** validate a repaired provider: none was created or applied.

The full preservation audit compared **27,343 project files and 11,734 external/runtime files**. All ten prior seals, the twelve-file failed run, settings, external inputs and Git HEAD/index matched, but the project's `.serena/cache/python/document_symbols.pkl` and `raw_document_symbols.pkl` changed. Semantic source inspection during this task updated these persistent tool caches. These are attributable tool side effects, not owner-approved baseline changes. The original `audit_final.json` remains `passed=false`; neither cache was restored/deleted, the baseline was not changed and no owner adoption is assumed.

A separate exact-two-cache qualification retains both before/observed fingerprints, the original failed audit and the explicit status `ARTIFACT_ONLY_SERENA_CACHE_DRIFT_UNADOPTED`, with `full_preservation_contract_passed=false` and `owner_cache_adoption=false`. It rejects an additional difference, unrelated audit error, prior-seal/settings drift or an execution/authority change. Its seven tests passed normally and under optimization after an observed failing test. Fresh narrow source, failed-run, previous-seal, settings and file-set checks precede its artifact seal. The separate readback checks the qualified artifact set only. This qualification cannot make the broader failed audit pass or confer scientific/native acceptance.

## Disposition and next task

Read [the targeted remediation proposal](REMEDIATION_PROPOSAL.md) and its exact artificial acceptance cases. The next useful combined task is to implement an **additive disabled successor** containing the cleanup-result correction, failure-path evidence capture and first-failed-operand bootstrap instrumentation, then run its full artificial regression/race/error suite and preservation audit. That is a source change requiring separate authorization; this proposal does not apply it.

No native relaunch is currently justified by a guessed timing or identity fix. Any eventual trial requires a new reviewed source identity, fresh unused run/root, exact bounded authority and separate native exit/closure evidence. The failed root, grant and reservations cannot be reused. Participant, fitting, institutional, coauthor and release decisions remain unchanged. Historical global-settings exceptions remain unresolved; an unchanged settings fingerprint is not retrospective adoption.
