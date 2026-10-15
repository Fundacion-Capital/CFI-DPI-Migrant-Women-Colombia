# Original M4 five-class failed-candidate intake and no-fit preflight

## Status and scope

**M6.03.39 / M6.05.39 — original failed-candidate intake, held adapter and nonconvergence-aware preflight, without fitting.**

The archived M4_k5 row records command return code **0**, convergence **0**, reporting flag **0**, five binary indicators and complete-case **N = 423**. Likelihood, degrees of freedom, information criteria, entropy, posterior summaries and class-size diagnostics remain **unavailable**, not zero. The archived note is “Model estimated but did not converge.” A zero command return code is not convergence.

The frozen original intake contains no M4_k5 saved estimate or native numerical carrier. This absence is scoped to that intake, not a claim about every possible archive. No target is fabricated or borrowed from M4_k4, another family, or a future fit. Exact historical native coefficient/covariance comparison is therefore **unavailable** for this candidate.

This task performs **zero fits, retries, predictions, posterior allocations, participant exports, production-code corrections or manuscript changes**. The Stata execution is limited to two owned, bounded no-fit workers. The sole respondent-level read is a restricted six-column projection—KEY plus five binary indicators—for eligibility checks; identifier values are never displayed or exported.

## Original source and historical reporting

The five M4 indicators are **IVS, ICDP, IAFF, OQI and IURD**, in their original order. Neither IEDF nor ICPF enters this family. The original analysis and frozen source copy have matching fingerprints; the original minimal-binary input is also fingerprinted.

| Source element | Preserved specification |
|---|---|
| Complete-case sample | Lines 6947–6951 |
| Seed | 6432005, line 7006 |
| Estimator and immediate return-code capture | Lines 7008–7018 |
| Candidate recording | Lines 7019–7021 |
| Classes / indicators | Five / five binary indicators |
| Starting values | `randomid`, 500 draws |
| Optimizer settings | `difficult`, 7,000 iterations |
| Input ordering | Original row order; no additional sort |

The [archival status table](lca-m4-k5-preflight/historical_status.csv) reproduces the original row and its blank failed-candidate fields. These are historical status facts, not new model estimates. Fresh convergence, likelihood, information criteria, entropy, posterior diagnostics, reporting flag and class sizes are **NOT_RECOMPUTED**.

The original reporting expression at lines 7033–7037 requires recorded convergence 1, four or five classes, minimum class percentage at least 5, and entropy at least .60. M4_k5's recorded nonconvergence remains decisive; the original flag is not changed. Stata numeric missing values sort above finite values, and the original inequalities lack explicit nonmissing guards. Preserve that caveat without repairing the historical source or treating blank metrics as passing values. This is not a new BIC ranking or a scientific rejection of the whole model family.

## Held adapter and capture restrictions

The protected `stage_held.do` exits with **459 before its input-loading, sample, seed or estimator payload**. The original estimator is retained as unreachable source evidence, not executed. Removing the hold or changing the source contract is rejected by the software checks and would require a separately reviewed replay packet and explicit fit authority.

The status contract distinguishes:

| Command status / convergence | Permitted classification |
|---|---|
| Nonzero command return code | `FAILED_NO_CAPTURE` |
| Return code zero, convergence zero or missing | `NONCONVERGED_NO_CAPTURE` |
| Return code zero, convergence one | `NEW_STATE_ONLY_NO_HISTORICAL_TARGET` |
| Negative return code or invalid convergence value | Refuse the malformed status |

Even a future converged state would be **new evidence**, not recovery of a nonexistent original saved target. No native/posterior capture or scientific acceptance is authorized by these classifications. The held adapter is not a ready-to-run fit/capture workflow; the next replay must define its own bounded execution and nonconvergence-aware evidence capture.

The no-fit executable dependency graph is pinned before dispatch. It reuses the latest reviewed guard, refusing unapproved dependencies, dynamic/unparsed calls, indirect evaluation, cycles, changed files and fitting/prediction/external commands. The held-file exception requires its exact fingerprint, source contract and initial exit. This is a purpose-bound check of the reviewed graph, **not a general hostile-program Stata/Mata sandbox**.

## Actual no-fit runtime checks

The first owned Stata worker checks the six-column projection, 423 rows, unique/nonmissing KEY, unchanged row order, binary indicator values and complete-case eligibility. It clears the data before calling the held adapter and confirms that no estimation state exists afterward. Synthetic status cases check command failure, nonconvergence, missing convergence and hypothetical convergence, plus two malformed-status refusals. These are fixtures, not fits or respondent predictions.

The second owned worker deliberately raises assertion error **9** after temporarily increasing capacity. Its purpose is to prove handled-error cleanup, not to produce a successful analytical result. The actual error remains recorded as expected negative evidence; it is not recoded as ordinary success.

Both workers use temporary `maxvar = 32767`, clear data and estimation state, restore `maxvar = 5000`, and report cleanup markers. Both are destroyed. The six-event roster is fixed: initial inventory, positive selection, controlled-negative selection, two worker destructions, final inventory. Initial and final inventories match exactly; unrelated sessions are not changed.

The runtime is Stata/MP 19 on Windows with `version 16` source semantics. Restoration was tested for normal completion and a handled assertion failure—not forced process termination, a crash, optimizer behavior or future fit duration. The timeout and two-worker request arguments are retained exactly in the protected packet.

## Preservation and validation gates

The protected packet is `audit-local/intake/lca-m4-k5-adapter-59d389c`. It retains original owner authority, preceding disposition seal and authenticated execution proofs, source/input/catalogue/grid pins, original tracker snapshots, exact requests, source pins, logs, actual tool responses, status table, failure records and runtime acceptance evidence.

Every prior packet, original saved estimate, data file, source file and failed attempt is preserved. Only six public report/status/governance paths are changed. Schema 127 preserves all 2,058 preceding workflow pointers and adds ten, for 2,068 total. The preferred historical H1_k4 refit and its provenance remain unchanged and are not scientifically validated here.

Technical completion requires the software suites, exact actual-event authentication, preservation and public-scope checks, one independent final review, fresh post-review audit, authenticated execution binding, sealing, separate saved-only verification and external proof checks. Preflight completion is not fit approval, exact replication, scientific acceptance, publication or data-release authority. No staging, commit, push, deletion or cloud synchronization is included.

## Next immediate task

**M6.04.39 / M6.08.38 — bounded original M4 five-class failed-candidate replay and historical convergence/status comparison.**

This next task requires **separate explicit authorization for one bounded fit**, with no retry implied. Preserve the original source, seed, sample ordering and archived failure/blanks. Capture fresh status separately from archival status; never present any fresh coefficients as an original native target. A new converged state must remain new evidence requiring its own diagnostics and reporting decision. This preflight grants no fitting authority.
