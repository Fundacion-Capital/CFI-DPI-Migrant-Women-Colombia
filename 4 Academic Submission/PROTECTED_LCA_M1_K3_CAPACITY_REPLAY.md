# Capacity-bound original M1 three-class historical replay

M6.04.25.R2 / M6.08.24.R2 executed the single newly authorized original fit. **Historical numerical replication is NOT COMPLETE.** Technical audit closure requires the full saved-only suite, sole original-scope-bound independent review and dispositions, exclusive seal and separate verification. No further fit is authorized.

## Original specification and observed fit

One Stata MCP estimator invocation retained the historical seven intercept-only binary logit equations, original sample/order, seed6429003,classes3,300 random-start draws,difficult/iterate5000/nolog. The worker started at maxvar5000 and temporarily used32767. All423 complete projected cases and current e(sample) were validated. Fit rc0/body rc0; current N423,rank23,converged1,log likelihood -1709.192280707085. A private current STER and607-cell native capture were saved. Strict native-double storage/coordinate/stripe/value readbacks passed against both the current STER and the unchanged historical STER/carrier. No posterior prediction, margins, class assignment, extra model, refit or scientific correction was performed.

## Frozen numerical comparison: mismatch, not reproduction

Comparison used exact native coordinates and stripes, no class relabelling, and the original rule abs(current-target)<=1e-8+1e-8*abs(target); metadata other than likelihood requires exact equality. The Stata-produced [aggregate comparison](lca-m1-k3-capacity-replay/native_comparison.csv) contains:

| Component | Cells | Exact | Within tolerance | Maximum absolute difference |
|---|---:|---:|---:|---:|
| Metadata | 7 | 6 | 7 | 0.00000515418514624 |
| Coefficients | 24 | 1 | 1 | 15.05751731753021 |
| Covariance | 576 | 47 | 47 | 543242.2170437777 |

The historical likelihood is -1709.19228586127. Similar likelihood does not establish parameter or covariance equality, class-label equivalence, estimator stability or identification. No cause is inferred or remedied in this bounded replay. The native artifacts and full607-cell comparison remain private; only aggregate audit output is public.

## Cleanup failure and bounded recovery

The original wrapper cleared data/e-state/estimates/Stata matrices/programs, then failed restoring maxvar with r4: Mata had not been cleared. The exact pre-recovery log snapshot, original driver and actual failed-return receipt are retained. R1's successful no-fit cleanup did not exercise gsem-created Mata objects; its preserved evidence is not rewritten to claim otherwise.

One separately bound no-fit selection in the same owned worker cleared Mata and restored maxvar5000. It loaded neither participant data nor stored models and fitted nothing. Both the full recovery log and actual receipt confirm restoration; the worker was destroyed, and full recorded default-session inventory/activity is unchanged. This is recovered restoration, not an initial cleanup PASS. The [official Stata discussion](https://www.stata.com/statalist/archive/2009-10/msg01243.html) distinguishes clearing data from clearing Mata objects.

## Preservation and acceptance boundary

Preserve the original r900 failed packet, its seal/review/proofs, the complete R1 capacity packet/seal/proofs and221 frozen R1 review bindings. Owner Git/EOL adoption archives R1's eight exact sealed public representations before additive status changes. Current protection includes768 originals,13544 inherited private bindings,148 public snapshots,124 primary task IDs,14 milestones and the existing LaTeX preamble. Schema77 retains1563 prior pointers and adds ten. All tooling and cleanup failures remain retained.

Technical closure is conditional on the fresh full suite, original independent-review rulings and exclusive seal/separate saved-only verification. Neither a successful estimator return nor audit closure is successful historical replication, model selection, scientific validity, privacy/consent/anonymization or release approval. The runtime header/flavor discrepancy and I3-REPLAY-D01 remain held. Private evidence stays Git-excluded; no Git/cloud/Dropbox/Overleaf synchronization occurs.

## Next immediate task

**Proposed M6.08.24.R3 — protected saved-state numerical-discrepancy and identification diagnostics, without fitting.** Preserve all attempts and assess the discrepancy from the existing stored artifacts before considering any later scientific correction or separately authorized fit. This task grants no renewed fit authority, relabelling, tolerance widening or public release.
