# M6.03.29 / M6.05.29 — protected original M2 three-class preflight

## Scope

This is preparation and saved-state capture validation, **not a model fit or historical numerical replay**. The adapter is held at return code 459 before data loading or estimation. This task authorizes no research fitting, predictions, posterior assignment, participant export, preferred-model change, scientific acceptance or release.

## Original contract

| Contract field | Pinned value |
|---|---|
| Historical model | M2_k3, six-binary LCA excluding fraud harm |
| Indicators | IVS, ICDP, IAFF, OQI, IURD, ICPF binary inputs |
| Sample source | Lines 6774–6778, original input row order |
| Seed source | Line 6800: 6430003 |
| Estimator source | Lines 6802–6812 |
| Classes / random starts / iteration limit | 3 / 300 / 5000 |
| Historical N / rank / native slots | 423 / 20 / 21 |
| Native records | 469: 7 metadata, 21 coefficients, 441 covariance cells |
| Saved convergence | 1; archival, not a fresh result |

The input, original source, STER target, native carrier and sidecar are fingerprint pinned. The Stata eligibility check reads only KEY and the six binary indicators, verifies unique/nonmissing keys and valid binary inputs, and obtains 423 eligible rows without sorting or exporting participant data. The sample predicate and estimator settings are unchanged.

The [aggregate metadata table](lca-m2-k3-preflight/native_target_metadata.csv) labels convergence and dimensions as historical. Python performs metadata/provenance checks and transcription only; Stata reads native statistical carriers.

## Adapter and native-capture validation

The held adapter preserves the original specification and original row order, propagates any future estimator return code, and contains a stage-bound native-capture callback. No future fit is authorized by removing its hold; a separately authorized replay must use its own frozen packet and exclusive destinations.

The adapted sealed capture helper requires gsem, N=423, rank 20, finite negative log likelihood, saved convergence=1, a 21-slot vector and 21-by-21 covariance matrix with matching three-class labels. Native schema checks enforce 469 records, exact coordinate sets, unique keys, double values/indices and string-label types.

Observed Stata preflight:
- Held adapter exit 459 with empty state, before any input loading or estimator execution.
- Capture of the historical state and exact readback of both archival and newly captured native carriers: all 469 records/values/labels agree with the saved matrices.
- Six invalid e-state rejections: wrong command, nonconvergence, wrong N, missing likelihood, wrong rank and wrong dimensions.
- Eight native-carrier rejections: foreign coordinate, duplicate key, missing value, wrong label, wrong kind, fractional index, changed value and missing record.
- Existing output collision rejected 602 and destination escape rejected 198; no rejected capture or escaped output left behind.

The CSV sidecar is supporting output, not a substitute for native-DTA numerical equality. The original historical target and prior two-class states/dispositions remain untouched.

## Runtime, provenance and completion gates

All Stata work used the Stata MCP tools in one task-owned worker. Normal preflight returned 0. A deliberately injected assertion returned 9, with cleanup verified before exit; the MCP error text is retained as the expected negative test, not concealed by its false isError flag.

Both paths restore maxvar from 32767 to 5000 and empty dataset/program/Mata state. The owned worker was destroyed; before/after default-session inventories match. Source/request fingerprints and authenticated actual events bind both selections to their recorded outputs.

Fresh focused and relevant inherited tests, preservation checks, independent review, post-review execution attestation, exclusive seal and separate saved-only verification govern closure. Extensive historical and dated scope-sensitive suites remain preserved evidence, not newly rerun coverage.

No manuscript/production file, original data, scientific target, preferred H1 model, Git index/history or cloud content is changed. Private captures, requests, logs, failures and proofs remain in ignored audit storage. This preflight does not resolve identification, global optimality, future convergence or replication differences.

## Next immediate task

**M6.04.29 / M6.08.28 — the first bounded original M2 three-class historical replay and native-target comparison.** Requires separate authorization for a single fit. Preserve all prior packets, enforce the pinned source/input/seed/runtime contract, capture native results, and report exact original-coordinate agreement or discrepancy without relabeling, refitting or changing targets. No fitting authority is granted here.
