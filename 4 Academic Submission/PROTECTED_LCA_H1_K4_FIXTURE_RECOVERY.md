# M6.08.41.R4.R1 — preserved-attempt syntax recovery and mathematical-fixture preflight

## Bounded outcome

The separately reserved **synthetic-only** Stata/Mata preflight passed. The preserved original helper reproduced parser return code **3000**; the sibling helper then loaded and completed all eight mathematical fixture groups with body return code **0**. This completes syntax recovery and synthetic fixture preflight only. **Historical R4 diagnostics remain incomplete.** No saved estimates or participant data were loaded, and no fitting occurred.

The original failed R4 packet, its reservation, sources, log, audit, review and seal remain unchanged. The new helper has identical non-whitespace source to the preserved helper: inline block boundaries were expanded onto separate lines without changing the formulas, parameters or tolerances. The original six fixture groups received the same boundary-only correction; two additional synthetic groups exercise the comparison helper and unavailable-spectrum reporting.

## Confirmed parser cause

The original inline loop ended its final expression immediately before a closing brace, without a statement separator. Reproduction in the fresh owned worker returned 3000. With the block contents and closing brace on separate lines, the entire helper compiled and the fixtures passed. This confirms the statement-boundary repair in the executed source rather than relying on the earlier hypothesis. Stata documents newline/semicolon statement separation in its [official Mata syntax manual](https://www.stata.com/manuals/m-2syntax.pdf).

## Mathematical fixtures

| Group | Executed check | Result |
| --- | --- | --- |
| Uniform mixture and identical classes | All 1,458 theoretical response patterns have probability 1/1,458; the logit-coordinate Jacobian has rank 13 at relative threshold 1e-10 and zero weight-contrast columns | PASS |
| Logit-coordinate Jacobian | Interior synthetic fixture has rank 55; centered finite differences check every one of 55 columns using step 1e-5 and maximum absolute error below 1e-8; a reversed-sign derivative is detectably wrong | PASS |
| Probability-coordinate Jacobian | Centered finite differences check all 55 independent probability coordinates, balancing weights/category probabilities; interior rank 55 | PASS |
| Scratch class permutations | All 24 unique class-column permutations preserve the theoretical response-pattern distribution | PASS |
| Covariance/reference and threshold checks | Fixed reference excluded from 55-dimensional free covariance; identity free covariance has rank 55; synthetic negative eigenvalue recovered as -1; diagonal SVD fixture gives ranks 1/2/3 at the stated thresholds | PASS |
| Extreme logits and nonlabel perturbation | Finite probabilities/derivatives and unit mass under logits/cutpoints at +/-1,000; an ordinary coefficient perturbation changes the theoretical distribution | PASS |
| Synthetic comparison schema | 79 distinct comparison metrics; identity comparison has identity best permutation and zero distances; ordinary perturbation has positive distribution distance; input coefficient/covariance matrices unchanged | PASS |
| Unavailable-spectrum schema | 47 distinct state metrics; zero free covariance has rank zero and unavailable condition number; unavailable correlation spectrum remains missing rather than fabricated zero | PASS |

These fixtures validate this helper against explicit synthetic properties; they do not establish global correctness, identification of either historical model, observational equivalence, or scientific acceptance. Rank is coordinate- and threshold-dependent. The 1,458 patterns are theoretically possible combinations of one binary and six three-category indicators, not participant records or fitted observations. Scratch permutations are not applied relabeling of saved models.

## Execution and evidence

One fixture-only MCP selection ran in a separately named owned worker. It first reproduced the old parser failure under capture, cleared the partial Mata functions, loaded the corrected helper and ran the fixtures. Cleanup confirmed empty data/variables and maxvar 5000; the worker was destroyed and pre-existing session identities remained. Shared-default internal state is not certified.

The complete saved log contains all 13 exact outer/group/cleanup markers. The connector's compact output retains five outer gates but omits the individual Mata `printf` group lines. A separately tested evidence reader therefore requires all 13 markers from the complete log and the five actual outer gates from the authenticated MCP response. The original overstrict draft reader remains preserved and is not used for acceptance; the executed producer and its reservation/source pins were not edited after dispatch. No rerun, tolerance relaxation or mathematical change was used to address output compaction.

The [aggregate fixture status](lca-h1-k4-fixture-recovery/fixture_status.csv) contains no participant data or historical model diagnostics. The actual request/events, source bindings, complete log, preservation manifest and runtime pins remain in the ignored local packet. Final closure requires independent review, fresh audit, seal and separate saved-only verification. Selected safe Python suites are not an assertion that all historical producing workflows were rerun.

## Scope and retained holds

Only new recovery artifacts and six aggregate reporting/governance paths are in scope. All previous artifact pointers are retained. No model fitting, saved-estimate loads, predictions, participant loads/exports, applied relabeling/rebasing, historical comparison tolerance changes, production-analysis or manuscript edits, commit/push, cloud/Overleaf synchronization or release occurred. The prior R3 numerical discrepancy remains unexplained; candidate disposition, scientific acceptance, release and overall M6 completion remain withheld.

## Next immediate task

**M6.08.41.R4.R2 — separately reserved protected saved-state H1 four-class diagnostic adapter/preflight and execution contract, without fitting.**

Bind the recovered, fixture-tested helper to a new diagnostic adapter and precision-safe evidence/output contract. Preserve all packets and validate source/native/schema/authority boundaries before a later saved-state diagnostic run. Do not reuse the original failed R4 reservation or advance to R5 candidate disposition. This fixture preflight authorizes neither fitting nor historical diagnostic execution.
