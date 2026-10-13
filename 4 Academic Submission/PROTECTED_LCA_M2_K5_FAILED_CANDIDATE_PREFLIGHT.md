# Original M2 five-class failed-candidate preflight

M6.03.31 / M6.05.31. Protected intake and operational preflight **without fitting**.
This is not a new statistical result, exact historical replication, scientific
acceptance, or release approval.

## Original source, status, and unavailable target

The original M2_k5 specification uses six binary indicators, excluding fraud harm:
IVS, ICDP, IAFF, OQI, IURD, and ICPF. It retains the original complete-case block
(production lines6774–6778), seed6430005 (line6836), five latent classes,
500 randomid draws, difficult optimization and iterate(7000) (lines6838–6849,
including the original return-code capture). Input order is unchanged; no new
sorting, recoding, threshold correction, or estimator change is introduced.

The archived fit-grid row records rc0, converged0, report_candidate0,
N_complete423, six indicators and “Model estimated but did not converge.”
Return-code success is not convergence. Log likelihood, degrees of freedom,
AIC, BIC, entropy, average maximum posterior, minimum class size/share and
small-class flag are unavailable. The [historical status table](lca-m2-k5-preflight/historical_status.csv)
preserves those nine fields as blanks, not zeros. Fresh metrics are
NOT_RECOMPUTED. N_complete423 is an input eligibility count, not a saved fit's
N, rank, parameter count or posterior classification.

The original recorder saves model estimates only inside its converged==1 branch.
The frozen original intake catalogue, saved-state metadata and preserved models
folder contain no M2_k5 saved estimate/native target. This absence is scoped to
that intake, not every archive or external location. M2_k4, M1_k5, and H1_k4
must not be substituted as numerical targets. Historical H1_k4 preference is
unchanged, not revalidated. No cross-feature information-criterion ranking is made.

## Held adapter and nonconvergence-aware status contract

The adapter stops unconditionally at rc459 **before loading input or estimating**.
Its unreachable tail preserves the source-exact original M2_k5 estimator and seed.
Removing that guard is not authorized. A future rc!=0 means FAILED_NO_CAPTURE;
rc0 with convergence0 or missing convergence means NONCONVERGED_NO_CAPTURE;
a hypothetical converged state means NEW_STATE_ONLY_NO_HISTORICAL_TARGET.
These are status fixtures, not simulated e(b)/e(V) states or fresh model results.
Any future converged state would need a separate capture/reporting contract and
would not recover the absent historical target or establish preferred-model status.

## Observed no-fit operational checks

Two owned Stata MCP selections were used. The first projected only KEY plus
the six indicators from the preserved input, checked unique/nonmissing keys,
binary coding and423 complete cases, then cleared respondent data before testing
the held adapter and four status fixtures. No identifiers were displayed/exported.
The second deliberately failed with body rc9 after raising maxvar to32767.
Both normal and expected-error paths restored maxvar5000 and empty data/e-state;
both owned workers were destroyed. Default-session inventory matched before/after.
No estimator, prediction, classification or native numerical comparison was run.

Preparation initially rejected an extra trailing blank line in the held file and
stopped before dispatch. That failed attempt is retained; the exact-source guard
was not relaxed. The saved runtime reader also initially rejected the expected
rc9 because the connector reports nominal isError:false even for Stata errors.
A failing regression preceded the correction: acceptance now requires actual
Stata error/body/cleanup markers rather than treating MCP metadata as success.
Neither correction redispatched a Stata request or authorized fitting.

An additional source regression then caught an adapter-added duplicate return-code
assignment in the unreachable tail. The consumed stage_held.do is preserved
unchanged; stage_held_corrected.do removes only that duplicate and is the prepared
adapter for any later separately authorized workflow. Original source already
includes its single return-code capture. No corrected adapter redispatch or fit
occurred. The earlier owner audit remains preserved, not overwritten as final QA.

## Validation and completion boundary

Private originals, failures and prior packets remain preserved. Six-path public
integration is aggregate-only and append-only where applicable; production code,
main.tex, qualitative content, Git index and cloud remain untouched. Schema99
retains prior artifact pointers and adds this preflight's ten pointers.

Technical completion requires authentic independent review adoption, a fresh
post-review software run and actual-execution binding, immutable seal, separate
saved-only verification/proofs and final preservation readback. A test pass or
this prose alone does not establish completion. Scientific/exact-replication,
privacy/release and any further-fit authority remain held. This preflight does
not conclude intrinsic invalidity, global nonidentification or inevitable future
nonconvergence. It does not certify cleanup after forced termination/disk failure.

## Next immediate task

M6.04.31 / M6.08.30 — bounded original M2 five-class failed-candidate replay and
historical convergence/status comparison, **only after separate explicit
single-fit authorization**. There is no original native numerical target in the
frozen intake. Preserve the original specification, capacity restoration and
failure evidence; do not invent unavailable metrics or substitute another model.
No next-task execution or fit authorization is granted here.
