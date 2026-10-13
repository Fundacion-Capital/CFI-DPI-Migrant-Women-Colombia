# M6.04.29 / M6.08.28 — bounded original M2 three-class replay

## Scope and outcome

One authorized original-specification M2_k3 fit was executed, followed by a separate saved-state comparison. The disposition is **NATIVE_NUMERICAL_DISCREPANCY**. Reported convergence does not establish exact historical replication or scientific acceptance. In particular, the large covariance-entry difference below remains unresolved and must not be obscured by the small likelihood difference.

There was no retry, alternative model, class relabeling, tolerance adjustment, posterior prediction, participant export or preferred-model change. The historical target and all earlier packets remain preserved.

## Original specification and observed status

The replay uses the original six binary indicators excluding fraud harm, the source sample at lines 6774–6778, original input order, seed 6430003 and estimator at lines 6802–6812: three classes, randomid draws 300, difficult iterate 5000 and nolog. Source, input and saved target are fingerprint bound to the preceding preflight.

Observed fit return code 0, reported convergence 1, N=423, rank 20, 21 slots, e(sample)=423 and complete cases=423. The state was saved before native-capture acceptance; its native carrier contains 469 records. These are observed replay results, not a replacement for the separately preserved historical grid or its posterior summaries.

## Exact original-coordinate comparison

Each STER state first passes an exact native readback against its own carrier, including native values, types, coordinates and labels. The two native carriers are then compared directly, with no numerical tolerance or parameter rearrangement.

| Component | Cells | Exact matches | Differences | Label mismatches | Maximum absolute difference |
|---|---:|---:|---:|---:|---:|
| Coefficients | 21 | 1 | 20 | 0 | 1.566503204926907 |
| Covariance matrix | 441 | 41 | 400 | 0 | 2203564.740426676 |
| Metadata | 7 | 6 | 1 | 0 | 4.38425445282e-6 |
| All | 469 | 48 | 421 | 0 | 2203564.740426676 |

Historical log likelihood: **-1507.920353230341**. Replay log likelihood: **-1507.920357614596**. Their absolute difference is **4.38425445282e-6**.

The approximately 2.20-million covariance-entry difference is a material diagnostic flag. A small likelihood difference does not resolve this or prove label equivalence, identification, conditioning, global optimality or scientific usability. No such explanation is accepted here; saved-state diagnostics are the next task.

The [four-row aggregate summary](lca-m2-k3-replay/comparison_summary.csv) is an unchanged copy of the Stata-generated summary. Native captures, saved states and detailed comparisons remain private. CSV precision is not substituted for native equality.

## Execution, preservation and closure

The single fit was reserved exclusively against a frozen request/source manifest. All Stata work used the Stata MCP tools: one fit selection, one no-fit comparison selection, two owned-worker destructions and before/after inventories. Both paths restored maxvar from 32767 to 5000 and empty owned state. The default session inventory was unchanged.

Current tests enforce one-fit authority, no refits/predictions, coherent comparison disposition and actual review/final-command attestation. Relevant inherited tests and preservation/integration checks must pass. The preceding preflight’s historical failures and Minor issues remain preserved; its unused standalone 217 label is not a current acceptance marker, and its initial ledger entry is not treated as current status.

Independent review, fresh post-review execution/digest binding, exclusive sealing and separate saved-only verification govern technical closure. Extensive historical/datetime-scope suites are preserved evidence, not newly rerun coverage. No production code, original data, qualitative work, manuscript, Git index/history, cloud or Overleaf content is changed. This task provides no further-fit or release authority.

## Next immediate task

**M6.08.28.R1 — protected saved-state M2 three-class numerical-discrepancy and identification diagnostics, without fitting.** Use both preserved states and captures to assess parameterization/possible class-label relationships, theoretical distributions, covariance conditioning, fitted-point rank and stored derivative availability. Preserve the original-coordinate discrepancy; no refit, target replacement, preferred-model change or scientific acceptance is authorized.
