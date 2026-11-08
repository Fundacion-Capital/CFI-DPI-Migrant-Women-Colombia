# Exact E.4-to-exhibit specification

These are stable internal IDs, not final manuscript numbering. All statistical
figures/tables must eventually be generated in native Stata from the unchanged
aggregate ledgers; none is rendered or empirically re-estimated here. A conceptual
definition table may be authored from the accepted preparation code.

## Shared source and denominator contract

Source directory: the exact `run` leaf under
`audit-local/intake/package-e-restricted-20261108/e4-restricted-scope-c49b157/`.
The five ledgers are pinned by path/bytes/SHA-256 in INPUTS.json and the private
NUMERICAL_MAP.json. Their source producer is `1 Code/academic/2 Analysis.do`,
`BEGIN E4 BODY` through its closing block, pinned at entry. No original cell is
edited; display rounding never replaces a native token.

The observational unit is a recruited woman, not an independently verified unique
household. Historical manual exclusions and the admitted cohort are unchanged.
Model masks are complete/domain-valid subsets, not further cohort deletions.
Each model uses its own intended and actual estimator N from e4_model_status.csv:

| Model | Outcome | Mask | Exact controls / role |
| --- | --- | --- | --- |
| R0_E4 | Reported any digital remittance retention/use | e4_mask_r0 | Core |
| D0_E4 | Reported domestic digital participation in 60 days | e4_mask_d0 | Core |
| R1_E4 | Remittance retention/use | e4_mask_r1 | Core + grouped occupation + original first-arrival year |
| D1_E4 | Domestic participation | e4_mask_d1 | Core + grouped occupation + original first-arrival year |
| R0C_E4 | Remittance retention/use | e4_mask_common | Core on the shared outcome-observed base |

All logit models include the three candidate fields continuously, age, grouped
education and grouped recorded residence. Education reference: completed secondary;
residence reference: Bogotá. Extensions use employee/worker as occupation reference
and the uncentered original q2_1 year, not tenure. No interactions, weights or
referral/household clustering were added. Working robust VCE is conditional on
independent records, not a correction for the unrecorded recruitment network.
The residual residence category is heterogeneous, not a fourth single city.

## Six finite exhibit slots

| ID / destination | Content and exact source selector | Required uncertainty / qualification |
| --- | --- | --- |
| QT1 / main methods-results table | Five rows from e4_model_status.csv keyed by model; show outcome, core/extension/common role, intended_n, estimator_n and status. Definition panel uses preparation lines 1606–1726, not new statistics. | No invented standard deviation, response rate, exclusive missingness waterfall or raw participant rows. Label the support/sample gates as working-model checks, not scientific validation. |
| QF1 / main results figure | e4_probabilities.csv: R0_E4 and D0_E4, each of the three focals, record=higher_minus_lower: six points in two outcome panels. | estimate/se/ll/ul already in percentage points; zero reference line; native 95% pointwise conditional delta intervals. Fixed focal order, no p-value selection. |
| QT2 / main primary-test table | All six e4_primary_tests.csv slots, joined by model+field to QF1 and model N. Order R_IAT/R_IADT/R_IAFF then D_IAT/D_IADT/D_IAFF, not p-value order. Show p_raw and p_holm. | Coefficient-null Wald tests and fixed-six Holm family; not a second family for fifteen contrasts and not simultaneous figure intervals. No stars. |
| QS1 / supplement comparisons table | All fifteen higher_minus_lower records, ordered R0/D0/R1/D1/R0C then IAT/IADT/IAFF; include each model N and source status. Main six are retained for complete accounting, not a second headline display. | estimate/se/ll/ul in percentage points. Extensions/common-model comparisons are supporting; no new cross-model tests, no claim of exhaustive robustness. |
| QS2 / supplement endpoint table | All thirty lower/higher records from e4_probabilities.csv, model+focal+record unique. | Native probability units, SE and pointwise bounds. Model-standardized predictions, not observed prevalence or within-woman transitions. Do not clip intervals. |
| QS3 / restricted technical model record | Every fit/e4_B coefficient and matching fit/e4_V covariance cell in e4_native_matrices.csv, plus status and support references. Include factor baselines and original coding. | Existing native coefficients and covariances are available; coefficient SE/CI/control p-values and log likelihood/pseudo-R2 were not separately captured as reporting cells. No fabricated columns. A future Stata-only aggregate derivation may produce SE/CI from B/V under its exact contract; not executed here. |

QT1/QF1/QT2 are a proposed compact main-paper set, not an instruction to crowd
the paper with repeated numbers. The supplement retains all authorized results.
All six slots remain restricted candidates pending rendering, disclosure and
author review. QS3 support cells are NOT automatically public appendix material.

## Focal definitions and fixed endpoints

- IAT (`wp07_iat3`): fixed mean of phone access, internet frequency and running-out
  response; not a psychometrically validated access/financial-literacy score.
- IADT (`wp07_iadt2`): reported transfer and confidence items; not demonstrated
  skill, training receipt or the smartphone-only three-item comparison.
- IAFF (`wp07_iaff2`): own-name address-proof and telephone conditions; not account
  ownership, documentation legality or a complete institutional-access measure.
- IAT and IADT endpoints are 0.50 and 0.75; IAFF endpoints are 0.50 and 1.00.
  The increments differ. Do not rank constructs by these magnitudes as if they
  represented a common dose, standardized effect or intervention.
- Remittance outcome uses q6_13 ordinary categories: all-cash versus any reported
  digital retention/use. It is not receipt channel or measured money fraction.
  Domestic outcome is the separate q6_14 60-day participation response, not counts.

## Ready-to-adapt captions

**QF1:** Adjusted probability differences for two reported forms of digital
engagement in the recruited study cohort. Each point compares predictions at
the stated higher and lower candidate value, averaged over that model's unchanged
estimation sample with other covariates at observed values. Bars are native 95%
pointwise conditional delta-method intervals using the independent-record working
robust covariance; they are not Holm-adjusted simultaneous intervals. Differences
are percentage points. The two outcomes and three candidate increments are not
interchangeable; the models do not identify causal effects or population prevalence.

**QT2:** Six primary coefficient-null Wald tests in the two core logit models.
Raw and fixed-six Holm-adjusted p-values use the conditional working covariance.
All slots are shown regardless of their value. These tests are distinct from
the pointwise probability-comparison intervals in QF1. N is model-specific.

**QS1/QS2:** All predeclared fixed-endpoint summaries from the five authorized
working models. Other covariates remain observed and averaging is over each
model's e(sample). Extensions add occupation and original first-arrival year;
R0C uses the core shared base. Neither between-model differences nor differences
between outcomes are formally tested here. Reported endpoint uncertainty remains
pointwise; no results are omitted on significance grounds.

## Display and production acceptance

Plain-English labels; direct units; monochrome-safe symbols and interval bars;
no decorative gradients, significance stars or clipped negative bounds. Keep
construct and model order fixed. Use three probability decimals, two percentage-
point decimals and three p-value decimals (values below .001 shown <.001); keep
the exact native tokens in the machine-readable source map. If rounding obscures
an interval's zero boundary, add explicit direction/zero-crossing wording and a
more precise bound in the note; never round an interval into a different claim.
Reference coefficients are labeled reference, not estimated zero with SE zero.

Future production checks: exact key sets and row counts; all model Ns/statuses;
units/direction/endpoints; native versus displayed cells; all six raw/Holm values;
45 probability rows; no participant inputs or fitted-model restores; no inference
created outside the declared native Stata operation. Stop on altered source hash,
duplicate/unavailable key, invalid status or unapproved output destination. Native
rendering and visual/LaTeX checks are NOT performed in this mapping package.
