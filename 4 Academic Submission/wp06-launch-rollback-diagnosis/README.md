# WP06: launch-identity mismatch and access-denied rollback

31 October 2026 · Source/saved-state diagnosis and **unapplied** artificial-fixture proposal.

## Outcome and limits

The current role-launch design has a concrete identity mismatch mechanism. The selected venv `python.exe` is a **uv trampoline**, not the base Python image. The parent retains the process returned by `CreateProcessW` and bootstraps that identity; the trampoline starts another Python process, whose role code compares its own identity with the supplied one. These are different processes by design. Static executable markers, its embedded base-interpreter path, the venv configuration and the uv 0.11.28 source support this diagnosis.

The preserved watchdog rejection reports distinct launcher/role identities, consistent with that mechanism. However, no retained process-image/parent-child trace proves the exact historical child chain. This is a strongly supported source diagnosis, not a new live reproduction or loaded-image attestation.

The access-denied rollback is **not uniquely attributed**. The saved parent witnesses retain `WinError 5`, both retained-process exits, zero active owned processes and zero remaining handles, but do not identify the failing API, role or phase. Microsoft documents that `TerminateProcess` can return access denied after termination; the job-first then process-stop code permits that race. This is a plausible explanation, not proof that the historical denial was benign. The failed native trial and failed final audit remain failed.

## Proposed remedy—not deployed

1. Use the already-bound **base Python executable only for the worker/watchdog roles**, in both the application argument and command line. Require that path in the bound image inventory. Keep the SDK/stdio client's venv executable and inventory root unchanged. No PATH search, alternate executable, child discovery or identity relabeling.
2. Keep the exact PID/birth, binding-digest, role and deadline guards. Keep inherited capability lists, hidden suspended creation, bootstrap-before-resume order and all existing absolute deadlines.
3. Add a role-local retained-process stop method. If the process has already exited, do not call termination. After a denied call, only error 5 plus an immediate fresh same-identity and signaled-handle check can produce a proposed `exit_observed_after_access_denied` receipt. Preserve the denial code. A live target, identity change, other error or failed observation stays fatal. No retry or grace-period extension.
4. Record job/process operation, role and outcome in the parent rollback witness, and process receipts in the normal exit witness for the uninitialized-shutdown caller. Preserve the original denial code and verification-failure notes even if a fresh identity/wait check fails. Validate exact process receipt shapes and integer error codes. A denied job operation stays fatal; it cannot inherit the process-race exception. Evidence-write, final-exit, active-process and handle-closure failures continue to block cleanup.

The new receipt rule is a **proposed policy**, not an adopted acceptance rule and not permission to reinterpret earlier packets. The `operation` field labels the requested stop stage; an `already_exited` process receipt means no `TerminateProcess` call was made. The patch is an inspection artifact for a future disabled successor, not a drop-in authorized deployment.

See [UNAPPLIED_REMEDIATION.patch](UNAPPLIED_REMEDIATION.patch), [ACCEPTANCE_AND_REACH.md](ACCEPTANCE_AND_REACH.md) and [SOURCES.md](SOURCES.md).

## Evidence and validation

The private diagnostic case is `audit-local/intake/wp06-launch-rollback-diagnosis-c1d9d8e-20261031`. It contains exact-integer saved-state readback, executable/configuration fingerprints, RED attempts (including an initial corrected artificial startup-reservation fixture), earlier proposal versions, independent-review findings/resolutions and normal/optimized source-pinned final test receipts. Earlier receipts remain preserved, not represented as current-source validation. No participant records were inspected.

The proposed code is evaluated in memory against fake Win32 functions, not installed. Its integration fixture composes the proposed process-stop method with the proposed owner rollback and an artificial asynchronous job/termination race. Tests cover genuine live denials, job denials, changed identities, foreign handles, missing/malformed receipts, evidence-write failure, active-process and handle-closure failures, and the original absolute rollback ceiling. The unchanged provider's existing 169-test artificial suite is also rerun. Final audited totals and custody results are recorded in `AUDIT_SUMMARY.md`.

The existing Graphify map was consulted read-only using `bootstrap identity launch native`. The bounded query displayed 11 of 166 matches; it is a locator, not exhaustive coverage or evidence of current runtime behavior. No graph rebuild, reflection/save-back or participant-file ingestion was performed.

## Settings and unchanged gates

This is **not** settings adoption or a fresh readiness window. The historical settings-continuity failure remains intact. At diagnostic entry the settings fingerprint also differed from the preserved trial's last observation, and subsequent observations changed again. No writer is identified or inferred, no settings are changed by this work, and no runtime acceptance is inferred from a settings observation. Final observations are documentary only; offline fixtures do not depend on a settings-stability window.

Native readiness, activation, participant processing and scientific-result adoption remain unestablished. No selected venv executable, MCP/SDK client, native worker/watchdog or Stata was launched. Ordinary Python was used for static audit and artificial tests, with native/SDK/process-effect guards. No participant processing, fitting, service/settings change, repository commit/push or Overleaf synchronization was performed for this diagnosis.

## Next substantive step

Review/adopt the **proposal**, then, only with appropriate authority, implement one additive **disabled successor** with its updated catalog, receipt readers, fake fixtures and offline acceptance checks. Keep prior packets immutable. No native trial follows automatically; a future trial still requires fresh source/settings/readiness checks and explicit bounded authorization. This diagnostic task does not resolve the separate institutional or academic-analysis gates.
