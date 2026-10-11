# M6.08.24.R4 — historical M1 three-class candidate disposition and reporting contract

## Decision and scope

**Retain the historical M1_k3 candidate and its audit evidence. Hold its fresh
scientific acceptance and exact-replication claim. Exclude unsupported reporting
claims, not the underlying model or preserved files.** This is a source-bound
reporting decision, not a new class-count selection, corrected estimator or fit.

The original M1_k3 was a converged seven-binary three-class grid candidate. It was
not admitted by the original report-candidate screen because that screen explicitly
allowed only four or five classes. It was also not the separately coded preferred
final hybrid model. Neither exclusion from that historical screen nor the later
native-target mismatch proves that M1_k3 was scientifically invalid or unidentified.

R4 uses only frozen Stata source/catalog, historical aggregate grid evidence, and
the sealed R2/R3 audit packets. It dispatches no Stata calls, fits no model, loads no
participant dataset and creates no respondent predictions. Python is used only
for evidence transcription, hashing and reporting-contract tests, not statistical
reanalysis. Targets, class labels, original tolerances and analytical code remain
unchanged. Git, Dropbox and Overleaf changes are not authorized by this closure.

Deliverables: [candidate context and disposition](lca-m1-k3-candidate-disposition/candidate_disposition.csv)
and [22 reporting-claim dispositions](lca-m1-k3-candidate-disposition/reporting_contract.csv).
The CSVs are aggregate audit tables, not freshly estimated outputs or native targets.
Their historical numeric cells retain the source strings without recalculation.

## Original screening rules — what the code actually did

The frozen original source, physical lines 7033–7037, defines:

```stata
gen byte report_candidate = ///
    converged == 1 & ///
    inlist(k, 4, 5) & ///
    min_class_pct >= 5 & ///
    entropy >= 0.60
```

The hybrid-grid block repeats this screen at lines 8576–8580. It is an eligibility
flag, not an automatic preferred-model selection, significance test or argmin-BIC
routine. The audited screen does not explicitly require minimum modal count 20,
return code zero, small_class_flag zero, an average maximum posterior threshold,
or a nonmissing guard. No new threshold is substituted in R4.

Separately, the lca_record helper flags a small modal class when **modal_n < 20 OR
modal_pct < 5** (lines 6578–6589). Its minimum class share is derived from modal
assignment counts, not the estimated mixture weight. Its note distinguishes
successful posterior handling, small classes and unavailable posterior diagnostics;
the saved estimate alone does not prove that posterior capture succeeded.

There is a historical missing-value caveat: Stata numeric missing values exceed
finite values, so the two greater-than-or-equal comparisons do not by themselves
exclude missing diagnostics. This does not demonstrate a misflagged M1_k3 row:
that row has populated diagnostics and k=3 already fails the explicit class-count
gate. It does mean the source must not be described as explicitly missing-value-safe.
R4 records this limitation without modifying the historical rule. Any eventual
production correction requires its own scientific/code approval and test boundary.
See the [official Stata missing-value explanation](https://www.stata.com/support/faqs/data-management/logical-expressions-and-missing-values/).

## Historical candidate evidence and identity

The original minimal-grid workbook evidence records M1_k3 as converged=1,
report_candidate=0, rc=0, note=OK, seven indicators and 423 complete cases. Its
historical values are BIC 3557.474131840605, AIC 3464.38457172254, entropy
.7315966383173476, average maximum posterior .8842495026213982, minimum modal
class count 71, minimum modal share 16.78486997635934%, and small_class_flag=0.
The grid log-likelihood string is -1709.19228586127 with df=23; original native
precision is retained in the protected target packet and is not replaced by this
workbook display. These are historical values, not new calculations.

The six-row context table transcribes the M1 two-, three-, four- and five-class
grid rows, the H1 four-class grid row, and a separately identified independent
final model. It does not certify fresh replication of those other candidates.
M1_k4 has report_candidate=1. M1_k5 has rc=0 but converged=0 and unavailable
fit diagnostics: return code alone is not scientific acceptance. Empty cells in
the independent-final context row mean that this row is not a transcribed grid
result, not that its statistics are zero or that its saved state is absent.

The independently estimated preferred final model is explicitly coded as
**lca_final_hybrid_H1_k4**, with four classes, six ordered-logit indicators
(h_ivs3, h_icdp3, h_iaff3, h_iuof3, h_oqi3, h_iurd3), one binary-logit indicator
(h_iedf2), seed 6529004, 600 random starts and iterate(8000). Its source block is
8816–8832; selected_model=1 is explicitly exported at line 8952. This is not
M1_k3 and is not interchangeable with the H1_k4 grid state: the preserved native
targets differ despite the shared nominal seed. R4 neither validates nor changes
the preference originally encoded for this separate final model.

The original final block encodes a preference; the audited screen/final blocks
do not establish that it was a global BIC optimum. Information criteria cannot
be pooled indiscriminately across different response vectors or likelihood events
merely because N or the number of indicators agree. The minimal binary and hybrid
mixed/ordered recodings are different observed response events. R4 makes no new
pooled ranking or class-count choice. This comparability safeguard follows the
[official Stata information-criteria note](https://www.stata.com/manuals/ricnote.pdf).

## Retained, held and excluded reporting lanes

| Lane | Decision | Permissible interpretation |
|---|---|---|
| Historical archive/methods/audit | RETAIN | Attribute saved historical grid values and original source criteria accurately; retain all prior states and failed packets. |
| Fresh exact replication/profile/inference | HOLD | Do not describe M1_k3 as exactly replicated or freshly validated; original native mismatch and scientific review remain open. |
| Unsupported stronger claims | EXCLUDE | Exclude false promotion or invalidity claims, not the preserved model. Every excluded claim has a specific reason/evidence entry. |

The [capacity-bound replay](PROTECTED_LCA_M1_K3_CAPACITY_REPLAY.md) completed the
single original fit and matched sample size, rank and convergence, but not the
frozen exact coefficient/covariance targets. The [saved-state diagnostics](PROTECTED_LCA_M1_K3_SAVED_DIAGNOSTICS.md)
explain label ordering and near-boundary logit sensitivity without resolving that
acceptance failure. Their probability/permutation distances are diagnostic evidence,
not replacement targets or permission to relabel the comparison.

The R3 analytic 128-pattern calculations concern theoretical distributions, not
respondent memberships. Generic identifiability and numerical full-rank checks
do not prove fitted-point identification, global optimality or inferential adequacy.
The corrected diagnostic derivative records no available stored Hessian; finite
saved gradient components are not a stationarity certificate. R4 retains these
limitations and the raw/failed evidence rather than manufacturing a stronger verdict.

The machine-readable claim contract contains five RETAIN, two HOLD and fifteen
EXCLUDE entries. These distinguish historical role, screen eligibility, operational
execution, numerical replication and fresh scientific/reporting acceptance. A held
fresh result does not prohibit accurately qualified discussion of the historical
methodology or audit. Any promotion requires separate source-bound scientific review;
neither this reporting contract nor a passing test suite supplies that authority.

## Preservation and acceptance boundary

The owner checkpoint is main at 42b7c766282c5e1929a7a2e064a518663e25bd64.
Its exact eight-path adoption of R3 is authenticated through the established
Git/EOL bridge; all eight pre-update sealed public representations are archived.
R4 preserves **768 original bindings, 14,058 inherited private bindings and 154
latest public snapshots**, including previous seals, proof packets, original reviews,
failed fits and failed diagnostic attempts. The R3 seal remains
C6F38C656509687A1FF3EA1A831CFF01AAC1B17B01A803B05ED0D2E34A806EF9.

Four R4 implementation/runner failures are retained privately: source leading
whitespace needed semantic normalization, and catalog fields needed their actual
random_draws/iterations names; a milestone check needed the exact established
heading expression rather than matching subsequent task headings; the first cumulative
runner repeated 28 dated R3 tests (730 executions, all groups passing) because its
group-name match was wrong, so that receipt was not accepted for closure. A routing
RED/GREEN check and corrected fresh run govern acceptance. None changed the original source, data, catalog,
scientific settings or targets. Intended missing-implementation RED tests and actual
GREEN results are journal-bound, rather than inferred from final file existence.

Exactly eight public paths are in scope: this report, the two aggregate tables,
README, workplan, measurement register, workflow state and existing main.tex.
Workflow schema 79 retains all 1,583 prior pointers and adds ten, giving 1,593;
124 original primary task IDs, 14 milestone headings and the manuscript preamble
are preserved. The existing main.tex is compiled through the built-in compiler.

Closure requires the same-source 95-group cumulative suite, 674 inherited repeated
tests plus 28 current tests (702 executions), sole independent original-scope review
and individual dispositions, an actual post-review/post-adoption final execution,
exclusive typed seal and two separate verification proofs. The dated R3 receipt is
authenticated as historical evidence, not passed off as a fresh R4 run. A completion
marker or technical seal is not numerical replication, privacy or release approval.

## Next immediate task

**Proposed M6.03.26 / M6.05.26 — protected original M1 four-class candidate adapter
and native-capture preflight, without fitting.** Preserve the exact original
M1_k4 specification: seed **6429004**, **500** random starts, **iterate(7000)**
(not the three-class iterate(5000)). Resolve source/runtime/target bindings before
any fit. The original source/catalog, not a generalized earlier intake summary,
governs these settings. R4 supplies no fit, correction, Git or cloud authorization.
