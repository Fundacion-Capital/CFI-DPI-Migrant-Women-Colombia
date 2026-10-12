# Protected original M1 four-class candidate disposition and reporting contract

Task **M6.08.25.R2**. Entry owner main `2c9b96bc435646e66e40084ca85a165c3fac79a4`.
This is a reporting-only contract, not a new fit, class-count decision, scientific
correction or public-release approval. **No Stata command, respondent-data load,
prediction or fresh statistical calculation is performed in this task.**

## Disposition

| Evidence or proposed use | Disposition | Reason |
|---|---|---|
| Original M1_k4 grid row, convergence, report eligibility and historical diagnostics | RETAIN | Authentic historical evidence; do not erase or rewrite it. |
| Original bounded replay and saved-state diagnostic packets | RETAIN | Completed technical workflows with an unresolved native mismatch. |
| Fresh exact historical numerical reproduction | HOLD | Only 71 of 1,063 native cells met unchanged tolerance; no target substitution. |
| Fresh validated profiles, memberships, uncertainty and inference | HOLD | These uses have not been validated by the saved-state/reporting-only tasks. |
| Unsupported promotion, invalidity or selection claims | EXCLUDE | Neither eligibility nor diagnostic similarity warrants those claims. |

**M1_k4 remains archived and historically report-eligible, but is not promoted to
fresh scientifically accepted results. It is not deleted or declared invalid.**
The independently coded preferred final model is **hybrid H1_k4**, not this
seven-binary minimal M1_k4. That final identity remains a historical source fact,
not new approval of the hybrid model. Even the hybrid grid H1_k4 and separately
estimated final H1_k4 have different immutable native targets; neither is a
replacement for M1_k4. Same class count or nominal seed does not establish identity.

## Original reporting criteria and grid evidence

The frozen original source, lines 7033–7037, constructs `report_candidate` from:

1. `converged == 1`;
2. `k` equal to 4 or 5;
3. minimum **modal-assignment** class percentage at least 5;
4. entropy at least 0.60.

It does not implement a BIC argmin, a return-code check, an explicit nonmissing
guard or a minimum-class-count condition in that flag. The separate small-class
warning at lines 6588–6589 uses **count <20 OR percentage <5**. A modal assignment
share is not an estimated mixture prior weight. The four-class saved minimum
mixture weight of about 0.1128 and the historical minimum modal share of 7.092%
are different quantities and must not be substituted for each other.

| Original M1_k4 grid field | Preserved historical value |
|---|---:|
| Classes / binary indicators / complete cases | 4 / 7 / 423 |
| Stored convergence / return code / report_candidate | 1 / 0 / 1 |
| Log likelihood | −1702.825790720468 |
| Parameter degrees of freedom | 31 |
| AIC | 3467.651581440936 |
| BIC | 3593.12011899137 |
| Entropy | 0.7227392647628159 |
| Average maximum posterior probability | 0.8484467478015976 |
| Minimum modal-class count | 30 |
| Minimum modal-class percentage | 7.092198581560284 |
| Small-class warning / note | 0 / OK |
| Historical seed / random draws / maximum iterations | 6429004 / 500 / 7000 |

These values are transcribed from the frozen grid and source, not recalculated.
They describe historical classification/fit diagnostics, not freshly validated
respondent classifications. The same-family M1_k3 historical BIC is
3557.474131840605, below M1_k4's BIC, while its report_candidate flag is zero
because k=3 is outside the screen. Thus the historical flag is demonstrably not
the same thing as choosing the lowest same-family BIC. This observation does not
make a new class-count recommendation.

The original screen lacks an explicit nonmissing guard. Stata numeric missing
values sort above finite numbers, so inequalities alone are not missing-safe.
The M1_k4 row's relevant diagnostics are actually populated; the caveat does not
justify changing that observed historical flag. The source is preserved, and
any future correction must be separately scoped. See the official
[Stata missing-values FAQ](https://www.stata.com/support/faqs/data-management/logical-expressions-and-missing-values/).

Information criteria require comparable likelihood events, not just the same
number of participants. Recoded feature families change the response events;
their pooled BIC values must not be presented as a validated global selection
rule. The original independent H1_k4 final specification is explicitly coded,
not selected by an audited automatic pooled BIC argmin. See Stata's
[IC note](https://www.stata.com/manuals/ricnote.pdf) and
[estat ic manual](https://www.stata.com/manuals/restatic.pdf).

## Replay and diagnostic evidence that governs the hold

The [bounded replay](PROTECTED_LCA_M1_K4_REPLAY.md) performed one authorized fit.
It retained 70 exact and 71 within-tolerance cells out of 1,063; coefficient and
covariance reproduction failed. Sample, stored rank and convergence agreement
did not establish complete native reproduction. Its cleanup error and separate
no-fit recovery remain preserved, not rewritten into an uninterrupted success.

The [saved-state diagnostic task](PROTECTED_LCA_M1_K4_SAVED_DIAGNOSTICS.md)
strictly read 2,126 native state cells and validated the four-class math without
fitting. Diagnostic mapping 3412 brings the distributions close, but proper
reference-logit/covariance rebasing leaves a maximum logit difference of
2.9195166668115871 and covariance-entry difference of 11,654,039.678389438.
Pattern total variation is about 0.0000326093335. These remain diagnostic
quantities, not changed comparison tolerances or relabeled acceptance targets.

Near-boundary item probabilities, large saved logit variances and numerical
conditioning require caution, not a declaration of intrinsic non-identification.
Generic identification and finite-precision ranks do not certify either saved
point, global optimality, stationarity or reliable inference. Neither state has
a saved Hessian; finite saved gradients do not fill that gap. No respondent
membership, posterior allocation, profile prevalence or inferential conclusion
is newly validated here.

## Permitted reporting language

“The original seven-binary M1 four-class candidate met the historical reporting
screen and remains preserved as grid evidence. Its bounded replay did not
reproduce the full native coefficient/covariance target. Saved-state diagnostics
show class reordering and close implied distributions, but material rebased
differences and numerical-sensitivity concerns remain. Fresh scientific
acceptance is held pending separately scoped decisions and validation.”

Do not describe this as an accepted preferred model, exact replication, proof of
invalidity/non-identification, a global optimum, or validated individual profiles.
The machine-readable contract enumerates **22 claim dispositions: five RETAIN,
two HOLD and fifteen EXCLUDE**. [Reporting claims](lca-m1-k4-candidate-disposition/reporting_contract.csv)
and [candidate context](lca-m1-k4-candidate-disposition/candidate_disposition.csv)
preserve six rows: M1_k2/k3/k4/k5, hybrid grid H1_k4 and a separate final identity.
Blank final/grid diagnostics mean unavailable—not zero.

## Preservation and validation contract

The protected packet retains 768 original byte bindings, 15,029 inherited
private bindings and 166 latest public snapshots. The preceding diagnostic seal
remains `6B33293332204F151DB5E2EF64E4972C8D6289CA775EF64FF9A1B837A20920D9`.
Historical sources, targets, original reviews, failed attempts and proof packets
remain unchanged. Only aggregate reporting and additive orchestration are public.

Eight public paths are changed/added. Schema83 retains all 1,623 prior artifact
pointers and adds ten, giving 1,633; 124 original task identities and 14 milestone
headings remain intact. Existing main.tex retains its entire legacy prefix and
is compiled in the same editor. Technical completion additionally requires
test-first and cumulative checks, one independent critic, actual post-review
final execution, exclusive sealing and a separate saved-only proof. Compilation
is not visual PDF QA, and technical closure is not release approval.

## Next immediate task

**Proposed M6.03.27 / M6.05.27 — protected original M1 five-class failed-candidate
source/runtime/reporting intake and nonconvergence-aware adapter preflight,
without fitting.** The frozen catalogue records seed6429005, draws500,
iterate7000 and **no saved historical M1_k5 estimate**. Its grid row has rc=0,
converged=0 and unavailable fit diagnostics. A future preflight must preserve
that nonconvergence and absence; it must not invent a native target or promise
an exact-target comparison. This proposal does not authorize another fit.

## References

StataCorp. (n.d.). *Logical expressions and missing values*.
https://www.stata.com/support/faqs/data-management/logical-expressions-and-missing-values/

StataCorp. (n.d.). *IC note — Calculating and interpreting information criteria*.
https://www.stata.com/manuals/ricnote.pdf

StataCorp. (n.d.). *estat ic — Display information criteria*.
https://www.stata.com/manuals/restatic.pdf
