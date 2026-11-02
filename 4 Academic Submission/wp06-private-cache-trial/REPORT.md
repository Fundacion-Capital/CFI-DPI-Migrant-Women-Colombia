# Single authorized empty-native trial — failed, no retry

The exact authorized request was attempted once on2November2026 (Europe/Berlin), using the prescribed isolated stdio MCP client. The client returned exit code1. **No fixed Stata selection completed, no successful native-empty qualification was established, and the authority is consumed.** No retry, replacement, source repair, deadline extension, participant processing or settings/service change was performed.

## Observed failure

The worker reached `StataEngine.__init__` and failed inside `pystata.config.init('mp', splash=False)`. Its retained stdout first reports `failed to set the specified Python version` and `Unable to find the shared library`, then a traceback ending at installed `pystata/config.py:544`, `import sfi`, with:

```text
ModuleNotFoundError: No module named 'sfi'
```

The installed `ado/base/py/sfi.py` file exists. The source explicitly adds site-packages and Stata utilities at that point. These facts support a **next read-only investigation of Python shared-library and Stata/Python module-path setup**, not a fully established causal mechanism or an applied fix. The two retained private startup profiles are inert source-pinned files; their startup messages are not analytical results.

## Retained native evidence

- Client invocation:1; completed fixed selections:0; retries/replacements:0.
- Scoped client, adapter and watchdog cache proofs retained:3. Worker readiness and its fourth cache proof were not published; four-channel acceptance fails. The private cache prefix remains plain and empty.
- The parent reports rollback with worker exit1, watchdog exit0, zero active owned processes, zero retained owner/kernel handles and `cleanup_complete=true`. The recipe remains `accepted=false` with calls/completed0 and bootstrap/frame deadline failures.
- Saved parent counters place exit observation at60.0045553seconds and closure at60.0067065seconds after the recorded origin. This is exact saved-counter arithmetic, not independent host timing or certification that every end-to-end phase met every deadline.
- No parent runtime-identity witness, worker readiness/result frames or selection logs exist. Missing success evidence is not excused by reported cleanup.

These are source-exact saved native-parent/child observations. They are not independent host-process cleanup verification or independent MAC authentication of retained frames. No live probes or additional control calls were made to obtain a stronger claim.

## Audit and preservation

Prelaunch complete artificial suites passed301/301 normally and optimized. The final post-consumption suites exercise unchanged source controls and the new local/saved-failure checks; preparation-only readiness tests remain historical because the approved root now exists and authority is consumed. Original positive-readiness records, executed helpers, console chunks, all native files and the first success-rejection assessment remain preserved.

Detailed evidence is in ignored `audit-local/intake/wp06-private-cache-trial-c06961f-20261102`; the approved run remains at `audit-local/intake/wp06-empty-private-cache-20261101-0c91ebf12c60`. The actual final artifact audit, seal and readback—not this report—govern custody completion. A complete failed-trial audit must not be read as a successful trial or permission for participant analysis.

Both fresh post-trial suites passed **279/279** in normal and optimized modes, with zero failures, errors, skips or blocked effects and zero new native launches. One independent read-only review identified four Important local audit-guard issues: incomplete finalizer qualification, malformed watchdog identity acceptance, insufficient seal-membership checks and incomplete reconciliation of derived assessment/invocation claims. All four were addressed in one file-only corrective pass. Focused mutation tests passed20/20; failed test attempts and the review-time hold remain retained. The fresh suites include the finalizer and current helper/source membership. These corrections did not alter the executed operators, native packet, approved provider or original failure assessments, and no second independent review is claimed.

## Next bounded task

Source-exact **read-only PyStata/shared-library/`sfi` bootstrap diagnosis and minimal remediation proposal**, without launching, fitting, participant processing or settings/service changes. Any later source correction would require its own disabled source qualification and fresh exact trial authority. This run, grant and request are not reusable. Scientific, institutional and public-release gates remain separate and closed where previously recorded.
