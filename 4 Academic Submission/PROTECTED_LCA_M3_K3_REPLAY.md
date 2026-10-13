# Protected original M3 three-class historical replay and native-target comparison

## Scope and authority

M6.04.33 / M6.08.32 executes the owner's explicitly authorized single bounded original M3_k3 fit and an independently bounded no-fit native comparison. Checkpoint: main450e60cc57ebd32d7ff08fe4937cafb7d9d4b99e. Protected packet: audit-local/intake/lca-m3-k3-replay-450e60c.

**Outcome: NATIVE_NUMERICAL_DISCREPANCY.** The fit completed with rc0/convergence1 and correct sample/dimensions. Both saved-state carriers match their own STER exactly, but the fresh replay does not match the original historical numerical target exactly. This is execution/comparison completion, not scientific acceptance, global identification/optimality, final model selection or exact historical replication.

Original analysis code, input, target STER/native carriers, all predecessor packets and the historical H1_k4 preference remain unchanged. The prior M3_k2 findings and M3_k3 preflight recovery are preserved, not rewritten or transferred as acceptance.

## Original specification and fit result

The replay is source-bound to sample lines6860–6864, seed6431003 at6886 and estimator/immediate return-code lines6888–6899. It uses six binary indicators: IVS, ICDP, IAFF, OQI, IURD and IEDF harm; ICPF trust is excluded. Three latent classes, 300 random-id draws, difficult optimization and iterate(5000) were retained exactly. No additional sort, sample restriction, recoding, estimator option change or class relabelling was introduced.

Only KEY and those six binaries were loaded, in the original deterministic input order. N423 eligibility and e(sample) count423 were checked without displaying identifiers or exporting participant rows. Stata MCP was the sole numerical backend. The corrected sealed preflight capture/verifier were copied with namespace/destination changes only; an added pre-dispatch binding guard rejects a mismatched helper name before fitting.

| Stored quantity | Original historical target | Fresh bounded replay |
|---|---:|---:|
| N | 423 | 423 |
| Converged | 1 | 1 |
| Rank | 20 | 20 |
| Coefficient slots | 21 | 21 |
| Log likelihood | -1448.555285940801 | -1448.555285566061 |

The source hash remains 714377CA31DE2B6D70DB0994E3C7EF6A38374165D7B1FB7C7ABEB3B3F56549C9. The input hash remains FFF60ABFD7129DCB8C6A04ABBBD5F4545E8601FEA00FE995D3DC8D95F169F420. Original M3_k3 target hash: 71CEBAB20F774B602DC7FD6E86AD93ACFC1490C280C8AC164F48AEF5441ABEBB; original native CSV hash: ED95EBAFDAC44D3297C26F630856DEC57BD9FC8EE4EB130815287529571282A2.

The immediate estimator return code, fit status and new STER were saved before native-capture acceptance. Exactly one fit was reserved and dispatched; there was no second fit, retry, changed start scheme or tolerance-based acceptance.

## Exact native comparison

Both 469-record carriers were verified separately against their own saved estimates: seven metadata entries, 21 coefficients and 441 covariance entries. Verifiers enforce storage types, finite numeric coordinates/values, coordinate uniqueness/completeness and model-specific equation/parameter stripes.

The comparison joins the original labelled coordinates directly. Exact equality is tested on the native double values and stripes; absolute differences are reported descriptively, with no acceptance tolerance, class permutation or rewriting of either state.

| Component | Cells | Exact matches | Differences | Stripe differences | Maximum absolute difference |
|---|---:|---:|---:|---:|---:|
| All | 469 | 48 | 421 | 0 | 4930885.670333427 |
| Covariance V | 441 | 41 | 400 | 0 | 4930885.670333427 |
| Coefficients b | 21 | 1 | 20 | 0 | 18.68252962384962 |
| Metadata | 7 | 6 | 1 | 0 | 3.74739556719e-07 |

[comparison_summary.csv](lca-m3-k3-replay/comparison_summary.csv) transcribes those Stata-produced aggregate rows exactly. The full native comparison and fresh STER/native capture remain in the protected packet, not in the public summary.

A nearly equal likelihood is not evidence of identical parameters, identical covariance, adequate identification or stable substantive profiles. The current task does not attribute the discrepancy to labels, boundary behavior, a local optimum, software version or another mechanism. Those explanations require separately authorized saved-state diagnostics. Fresh information criteria, posterior metrics, class assignments, entropy and Hessian/identification diagnostics were not computed here.

## Runtime, preservation and validation

The complete authenticated current-task roster consists of six Stata MCP events: initial inventory, single fit, owned fit-worker destruction, separate no-fit comparison, owned comparison-worker destruction and final inventory. There were two selections and one fit. Both workers used temporary maxvar32767, restored maxvar5000 and an empty dataset, and were destroyed. The pre-existing session was untouched and the inventory remained identical.

There were zero refits, predictions, participant exports or model replacements. An exclusive reservation prevents reuse of this fit slot. The same request and source hashes bind pre-dispatch tests, dispatched calls, status, saved estimates, native carriers and comparison. An early reservation attempt while preparation receipts were incomplete was rejected before fitting; its software failure record is retained.

Validation requires predecessor seal/proof authentication; unchanged unrelated tracked/private fingerprints; exact source/contract/helper binding; complete six-event roster without unreserved late calls; typed native readback; aggregate consistency/public transcription; six-public-path scope; schema107 with ten additive pointers; current and selected predecessor tests; an authenticated independent final review; fresh post-review completed exit-zero execution bound to receipt/source hashes; an exclusive seal; and a separate authenticated saved-only verification.

These gates complete operational replay and discrepancy reporting. They do not erase the 421 differences or authorize scientific use/release. No production analysis, manuscript, qualitative component, literature, figures, Git publication, cloud or Overleaf content was changed.

## Next immediate task

**M6.08.32.R1 — protected saved-state original M3 three-class numerical-discrepancy and identification diagnostics, without fitting.**

Preserve the original labelled comparison and both states. Assess the observed parameter/covariance discrepancy using saved-state-only, source-bound diagnostics; any label-aligned diagnostic comparison must remain separate from original exact comparison. No refit, new optimization, additional sample/measurement change, original-target replacement, tolerance widening, model selection or scientific acceptance is authorized by this handoff.
