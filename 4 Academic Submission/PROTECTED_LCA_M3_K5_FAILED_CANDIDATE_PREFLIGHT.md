# M6.03.35 / M6.05.35 — original M3 five-class failed-candidate intake and preflight

## Scope and decision

This is protected preparation **without fitting**. Original M3_k5 is retained as an archived failed/nonconverged candidate, not as an accepted fitted model or a recoverable native coefficient target. The held adapter exits459 before input loading or estimation; separate explicit authority and a new bounded replay packet are required for any future fit.

The [historical status table](lca-m3-k5-preflight/historical_status.csv) transcribes the original archived row. It retains rc=0, converged=0, report_candidate=0, N_complete=423 and the note “Model estimated but did not converge.” Return-code success is not convergence.

Likelihood, df, AIC, BIC, entropy, posterior summaries, class-size fields and size flags remain blank. They are unavailable—not zero or newly calculated. Fresh replay metrics are **NOT_RECOMPUTED**. No M3_k5 saved estimate or native target exists in the frozen original intake catalogue; that absence is not a claim about every possible external archive.

## Immutable source/input contract

Original source sample lines6860–6864 and estimator lines6924–6935 are preserved exactly. Source seed6431005 binds five classes,500 random starts and7000 maximum iterations. Six binary indicators are IVS, ICDP, IAFF, OQI, IURD and IEDF recodings; the source excludes trust climate. The source and minimal-binary input retain their established SHA-256 fingerprints.

Only KEY and the six named indicators are projected into a private owned worker. KEY is used for uniqueness checks, not printed or exported. There is no extra sort, recoding, sample substitution, full-script invocation, posterior prediction, native-target fabrication or scientific model comparison. The input row order is checked before/after the uniqueness check.

Temporary capacity is32767, with restoration to5000. The no-fit eligibility body verifies423 observations, unique/nonmissing KEY, complete binary indicators and the exact original sample flags.

## Nonconvergence-aware policy

| Status supplied to the controlled policy fixture | Disposition |
|---|---|
| Nonzero return code | FAILED_NO_CAPTURE |
| rc0, convergence0 | NONCONVERGED_NO_CAPTURE |
| rc0, missing convergence | NONCONVERGED_NO_CAPTURE; missing is not rewritten as0 |
| rc0, convergence1 | NEW_STATE_ONLY_NO_HISTORICAL_TARGET |
| Invalid negative return code or invalid convergence flag | Refuse the malformed status |

These are controlled status fixtures, not estimates. A hypothetical future converged state would be **new evidence**, not an exact recovery of a nonexistent historical target or automatic scientific acceptance. No fitted-state capture, criterion/posterior reconstruction or historical-target substitution is authorized by this preflight.

The original reporting screen and missing-value-ordering caveat remain unchanged. The M3 four-class native discrepancy/diagnostic disposition, original interrupted packet and separate preferred H1_k4 refit remain preserved and unresolved where previously held.

## Operational proof

Exactly two no-fit Stata MCP selections were executed in separate owned workers:

1. Eligibility/source/held-adapter/status preflight:423 complete records; held adapter459 before loading; four status branches and two malformed-status refusals; handled body return0.
2. Controlled assert-failure cleanup: handled body return9; the real r(9) evidence is retained even though the MCP provider labels the call nominally successful.

Both paths restore empty data/estimation state and maxvar5000 before exiting. Both owned workers are destroyed, and baseline/final session inventories agree. The complete six-event roster, exact requests, actual results, source pins and completed log markers govern validation. There are **zero fits, predictions or participant exports**, and one restricted eligibility projection.

Preparation syntax/EOF mistakes, a metadata-code-generation failure and a runtime namespace collision were caught and retained. The corrected closure imports its own runtime by absolute path; observed RED/GREEN tests cover that binding. Consumed Stata/runtime source pins remain unchanged, with no Stata retries or additional selections.

## Preservation and acceptance boundary

Protected packet: `audit-local/intake/lca-m3-k5-adapter-7aa29fb/`. Prior R5 seal and actual closure proofs, all unrelated tracked/prior-private fingerprints, exact original tracker copies and failed attempts are retained. Current and directly relevant inherited tests, independent review, post-review checks, authenticated exit-zero/source/receipt binding, exclusive sealing and saved-only readback govern completion.

Public scope is six paths: this report, one archival status CSV and additive README/workplan/measurement-register/workflow-state updates. Registry schema112 adds ten routing pointers without clearing older holds. No original analytical/data-preparation code, manuscript, qualitative/literature content, Git commit/push, cloud/Overleaf synchronization or publication release changes occur.

This preflight certifies source/eligibility/status/refusal and handled cleanup only. It does not certify convergence, optimizer behavior, process-termination cleanup, numerical identity, identification, model selection, profile validity or scientific use.

## Next immediate task

**M6.04.35 / M6.08.34 — bounded original M3 five-class failed-candidate replay and historical convergence/status comparison.**

That task requires separate explicit single-fit authority and a fresh execution packet. Preserve the archived rc0/convergence0 status, unavailable fields and absent native target; compare execution/convergence status truthfully rather than manufacture an exact native numerical target. No further fit is authorized here.

## Proposed commit

Title: `audit: preflight original M3 five-class failed candidate`

Description:

- Bind the original M3_k5 source, six-indicator input and archived nonconvergence/status blanks.
- Preserve the absent historical native target and held-before-load fitting refusal.
- Record two no-fit MCP checks, status/malformed-status fixtures and0/9 cleanup with32767/5000 capacity restoration.
- Preserve all earlier packets, failed preparation attempts, four-class holds and separate H1 preferred refit.
- Add archival status/report and additive routing only; keep private inputs, code packets, logs and receipts out of Git.
