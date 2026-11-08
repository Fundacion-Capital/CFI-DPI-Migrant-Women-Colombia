# E.5 six-slot native Stata exhibit producer

8 November 2026. Source, artificial fixtures and exact no-fit validation contract
implemented and audited. **No Stata execution or rendered exhibit is certified.**

The held [producer](../../1%20Code/academic/3%20E4%20exhibits.do) reads only the five
sealed E.4 aggregate CSVs. It is separate from the unchanged master/preparation/
analysis scripts and does not restore models, fit, run margins/tests, read a DTA,
save participant data, enable C2, install anything or modify global settings.
Line7 remains `exit 198`; the marked body has source-exact private staged copies,
not standing execution authority.

## Six slots, seventeen files

| Slot | Statistical output | Numeric record |
| --- | --- | --- |
| QT1 | Model/sample table and in-table construct/outcome definition panel | Five model rows; own intended/estimator Ns |
| QF1 | Two-panel monochrome PDF/PNG figure, six core comparisons | Six exact difference/SE/CI rows |
| QT2 | All six primary coefficient-null tests, raw and fixed-six Holm p-values | Six tests; no significance filter or new p-value |
| QS1 | All fifteen fixed comparisons, ordered by model then candidate | Native percentage points, zero labels and precise near-zero bound notes |
| QS2 | All thirty model-standardized endpoints | Probability units; unmodified/unclipped native bounds |
| QS3 | Full coefficient table with references and covariance-derived SE/normal CI | 74 B entries including 12 references, 1,154 V cells and 186 restricted support rows |

LaTeX tables use explicit row commands, bounded text columns and standard
`longtable` for the supplement. No journal class, manuscript layout, Overleaf
file or external-link change is made. QS3 computes SE=sqrt(saved V diagonal)
and nonreference coefficient +/- invnormal(.975)*SE in native Stata only; it
creates no new coefficient/control p-values or fit statistics. These normal
intervals, like the probability intervals, are pointwise working summaries,
not the fixed-six Holm family. References have no estimated SE/CI.

## Artificial validation — prepared, not run

The five [fixtures](fixtures/README.md) contain no participant records or study
numeric values. They mirror only ledger schemas/keys/dimensions. CASES.json
defines 12 cases: complete and reversed-order positives; duplicate/missing records,
wrong units/endpoints/status, invalid reference variance, missing covariance,
existing output collision, numeric-key alias and invalid support negatives.
Near-zero and outside-zero/one intervals, differing artificial Ns, reference
columns and a small nonbinary covariance value are built into the positive input.

`VALIDATION_CONTRACT.json` pins source, fixtures, staged bodies and12 exact private
Stata MCP selections. Their fresh input/output directories are empty. Each case
allows one selection, no retry, zero fits and zero participant/model loads, with
a 60-second soft tool timeout. Neither hard cancellation nor current runtime/
provider readiness is proved. The contract grants no execution permission.

Future acceptance requires all 17 outputs in AT01/AT02, the full native-output
audit, identical numeric CSVs/TeX between these order variants, actual PDF/PNG/
LaTeX inspection and all ten expected negative dispositions. Stop the whole
batch on an unexpected error, timeout or mismatch, preserving every attempt.
Any actual restricted E.4 rendering requires a separate exact scope after this
artificial validation; these fixtures never substitute for the sealed ledgers.

## Verification available now

From the repository root:

```text
node "4 Academic Submission/wp07-e5-exhibit-producer/verify_producer.mjs"
```

This is a file-only audit of source boundaries, fixture shape, source hashes,
exact staged bytes, empty destinations, preservation and the output auditor's
artificial in-memory rejection checks. It is NOT a Stata parser, estimator or
research-runtime dependency. It deliberately does not manufacture rendered
tables/figures in another language. Future native artifacts are checked with
`verify_artificial_outputs.mjs <one-artificial-output-directory>`.

`AUDIT.md`, `IMPLEMENTATION_PLAN.md`, the successor register and final
`VALIDATION.json` distinguish checked source from unrun native behavior. The
private companion `../audit-local/intake/package-e-restricted-20261108/e5-producer-f6e4faa/`
retains the two navigation before-images, pre-correction artifacts, review/fix
record, exact staged bodies and 12 disabled requests. All old packets remain.

Next: separately authorize the exact 12 artificial-only Stata MCP selections,
then audit their real native outputs before any study-ledger rendering. C2 HOLD,
unresolved institutional/disclosure limits and B/C/D/G whole-paper work remain.
No scientific/release approval, contact, commit, push or cloud sync occurred.
