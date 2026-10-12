# Protected original M1 five-class candidate disposition
Task: **M6.08.26.R1**. Owner checkpoint: `f66d3f424284dbd730cca4996deed265f8d82f4b`.

## Disposition
Retain the original minimal-binary **M1_k5** as a historical **nonconverged candidate**, not an accepted scientific solution. The historical row records return code 0, convergence 0 and reporting-candidate flag 0. The single authorized replay also returned code 0 and convergence 0, with 423 eligible observations and no saved native state. This is a historical **status match only**, not numerical replication.

The seven indicators are IVS, ICDP, IAFF, OQI, IURD, IEDF harm and ICPF binary inputs. The original five-class specification uses seed 6429005, randomid starts with 500 draws and an iteration ceiling of 7000. These are archival facts; no estimator was executed for this disposition.

## What remains unavailable
Historical BIC, AIC, entropy, average maximum posterior, minimum class count/share, small-class flag, log likelihood and degrees of freedom are unavailable, **not zero**. There is no M1_k5 native saved target in the frozen intake, and the replay saved no model state. That absence is scoped to the frozen intake, not an assertion that no such file exists anywhere.

The historical report_candidate=0 is retained literally. The replay flag was **not recomputed**, since no posterior diagnostics were produced. Do not describe it as a freshly evaluated zero. No coefficient/covariance comparison, posterior profile, classification, inference, class-label matching or fit ranking is supported.

## Reporting-screen provenance
Original source lines 7033–7037 screen on convergence, four/five classes, minimum class share of at least 5%, and entropy of at least 0.60. This is not an explicit return-code/missing-value/count/BIC-minimization guard. The separate small-class warning uses count below 20 or share below 5%. Preserve this screen as historical evidence rather than silently repairing it or inferring fresh eligibility.

The separately selected hybrid **H1_k4** final model is distinct from minimal M1_k5 and from its own grid candidate. Neither H1 nor M1_k4 saved states may substitute as five-class numerical targets. This disposition changes no historical preferred model.

## Operational failures and preservation
The original MCP client request timed out after 300 seconds while its owned worker continued the same single fit. It was not retried. After status capture, the original driver failed cleanup with r(3499) at the invalid command `mata clear`. Its original transport event, failed log, consumed driver and adapter remain immutable provenance, **not reusable templates**.

A separate **no-fit** recovery used `clear mata`, restored maxvar to 5000, checked the saved one-row status, cleared the owned state and destroyed the worker. Successful recovery does not make the original script exit zero. The timeout itself is not statistical failure. Preliminary completion requests were not dispatched and remain preserved as superseded evidence. Preserve all earlier failed packets and recovery records unchanged.

## Contract and validation
[Candidate context](lca-m1-k5-candidate-disposition/candidate_context.csv) and the [claim-by-claim reporting contract](lca-m1-k5-candidate-disposition/reporting_contract.csv) distinguish RETAIN, HOLD and EXCLUDE.

This task has **zero Stata dispatches, zero fits, zero predictions and zero respondent-data loads**. Checks consume sealed metadata, text source windows and fingerprints only. The protected validation receipt documents checks actually run; the preceding replay's cumulative 101-group/896-execution acceptance remains historical evidence and is not claimed as rerun here.

Scientific acceptance, numerical replication, release approval and permission for any further fit remain false. Nonconvergence alone establishes neither intrinsic invalidity nor identification failure/global optimality. Production code, raw data, qualitative work and the main manuscript are unchanged. No commit, push, cloud synchronization or publication is authorized.

## Next immediate task
**M6.03.28 / M6.05.28 — protected original M2 two-class candidate adapter and native-capture preflight, without fitting.** The frozen catalogue identifies M2_k2 at source lines 6784–6794, six binary indicators excluding fraud harm, seed 6430002, 200 randomid draws and iteration ceiling 5000; its saved-estimate presence must be verified against convergence and its exact target, not treated as acceptance. No M2 fit is authorized by this contract.
