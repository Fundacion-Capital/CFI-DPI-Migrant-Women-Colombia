# E.4 artificial native validation — stopped admission attempt
8 November 2026. **Validation did not complete. NV01 failed before its fixture;
the other nine selections were not dispatched.** The no-retry/first-failure
stop rule was enforced. No synthetic fit or participant processing occurred.

## Actual execution
| Item | Observed |
| --- | --- |
| Authorized named selections / synthetic-fit ceiling | 10 / 7 |
| Dispatched / passed / unexpectedly failed | 1 / 0 / 1 |
| Not dispatched | 9 |
| Synthetic fits / participant loads or fits | 0 / 0 |
| Retries / extra native test or probe selections | 0 / 0 |
| C2 | HOLD |

Stata MCP was callable in the existing verification context. The newly owned
session admitted with N=0, K=0, Stata19. The next caller-envelope command,
`quietly log query all`, failed with `log all not found`, r(111). No
`native.log`, fixture rows, model/result CSVs or success/cleanup markers were
created. isError=false in the MCP envelope was not treated as a test pass.
The duplicate printed return code does not mean two dispatches.

This is a caller-command syntax mistake, not evidence about the canonical
preparation, five model equations, data, measurement or statistical validity.
ROOT_CAUSE.md records the exact installed-help evidence for reserved `_all`
and the two proposed wrapper-command corrections. They are not applied or
natively tested in this task.

## Preserved evidence
AUTHORIZATION.json records the user's exact grant. RUN_CONTRACT.json and its
identical private manifest remain the pre-dispatch source/output binding.
CASE_STATUS.csv gives every named slot, including all nine unrun slots.
The ten exact request files, dispatch intent, complete expanded native error,
MCP envelope, outcome, final read-only session inventory and independent
execution receipt stay in the protected Git-ignored leaf:
`4 Academic Submission/audit-local/intake/package-e-restricted-20261108/e4-native-validation-20261108`.
No failed or partial packet is overwritten/deleted. All earlier packets and
canonical/source entry holds remain unchanged. The current pointer is updated
to the failed-attempt checkpoint, not artificial acceptance or actual estimation.

## Runtime and logging limits
The owned session is reported ready/nonbusy in the final read-only inventory.
Empty N/K was observed at admission immediately before the nonmutating failed
query; final memory/log closure was not independently probed. No cleanup/reset/
worker replacement was requested. Existing unrelated sessions were untouched.

An external provider capture path was actually observed in the returned text;
its post-failure digest was unavailable. Working-directory binding does not
prove provider capture/debug/spill logs are confined to the case leaf. The
installed extension's logging/recovery behavior was inspected read-only, but
its exact identity/current host settings were not independently bound to the
callable endpoint. No cancellation/no-provider-reset guarantee is claimed.
No timeout/recovery was observed in this attempt. All payload content was
source code and artificial fixture instructions, not participant records.

## Next substantive task
Make only the caller-envelope correction `log query all` → `log query _all`
in an additive successor, preserving this attempt, reseal all ten otherwise
unchanged scientific cases, and obtain renewed bounded execution authority.
No new model/measurement choice, backend infrastructure, environment repair,
participant access or C2 execution follows from this logging diagnosis.
Unused slots are not renewed permission and have not been silently resumed.

Actual grouped study support, native model/postestimation/precision behavior,
inference adequacy and all empirical/institutional/release gates remain
unverified. B/C/D/G.1 whole-paper source work remains available in parallel.
No commit, push, contact, live Overleaf sync or release was performed.

