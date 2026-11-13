# WP07 analysis and exhibit audit — source-only

This review uses the current held `1 Code/academic/2 Analysis.do` (4,372
lines), the accepted D2/D3 and D4/D6 decisions, and the later E.4 decisions.
The entry and pre-estimation stops stay intact. No tables, coefficients,
prediction matrices or respondent records were opened or generated.
[Item-to-exhibit register](ITEM_EXHIBIT_MAP.csv) maps all 93 retained items
in 15 domains to their actual Stata line and denominator contract. A mapped
field is not an accepted numerical exhibit.

## Descriptive and association review

| Destination | Stata source and denominator | Deliverable and gate |
| --- | --- | --- |
| T1 sample accounting | 12–24; 3733–3815. Count the admitted cohort once. Known form versions plus unknown reconcile to 423. Screening disagreements are checks on the retained rows, not sequential exclusions. | Cohort, geography and version accounting. Use the frozen E.2 cohort records and accepted recruitment account; do not publish rare form cells without disclosure review. Neither the code nor the raw-to-admitted counts yield a response rate. |
| T2 / F1 observed outcomes | 1430–1499; 3682–3706; 3742–3766. q6_13 valid categories are the disposition denominator; all-cash vs categories 2–5 uses that same base. q6_14 has its own yes/no base. | Two-panel observed figure and a table of counts/bases. Reconcile the binary collapse to the five categories and label unscored responses separately. No common sample inferred from separate bases; no individual transition, money share or rail use inferred. |
| S1 / S2 dictionary and route/state | 26–3398 and the versioned codebook. Route partitions (open/closed/unknown) and six response states are different accounting systems; recorded = ordinary + sentinel. | Dictionary and restricted accounting keyed by field and form scope. Keep ALL and UNKNOWN separate; do not add ALL to version totals. |
| S3 / S4 components and definitions | 3400–3680; 17 components, 11 candidates, seven definition records in three common-base groups. | Own-N summaries and same-case comparisons. IADT3 has a distinct applicability rule; IUOF/OQI historical spacings are sensitivities, not automatically promoted. No universal composite or comparison across unequal own bases as though matched. |
| S5 channel and frequency context | 1360–1535; 3707–3729. q6_4 is latest receipt channel; q6_2 is categorical context; q6_15 is conditional on an affirmative q6_14, with bins 1–5 normalized only on valid bins and 98 displayed separately. | Keep categories and question-specific bases. The current operation summary lists uncertainty, nonresponse and unresolved but does not explicitly reconcile structural/unavailable states to the affirmative-user base. A held proposal below closes the accounting without reassigning rows. |
| S6–S9 routed experiences | Item register and exact version/option labels. Scalar categorical shares use recorded state 1+5; numeric summaries use ordinary-valid inputs; multiple-response shares use ordinary-valid parents and only offered options. | Include cost/clarity, access, safety, complaint/recourse, agency/support and barriers where relevant. Preserve refusal, uncertainty, route closure and unoffered responses; distinguish an offered zero from an undefined percentage. Do not divide option counts by the full sample. |
| AS1 optional three-field association | 3818–3868: IAT3 with each IADT candidate on pair-complete bases; both pairs and IADT2/IADT3 on the common three-field base. | Supplement only if useful. Report exact N, omit coefficients for inadequate N/constant inputs, preserve the distinction between pair/common. Three fields only if later authorized. Not measurement validation and not historical C2. |

The nominally nonmissing screens at 3768–3782 and full-stage support
counts at 3796–3803 are **not model N or factor support**. Retain them for
diagnostics, but prohibit their use in QT1. Also preserve that the q6_18
fee-visibility item uses its own wording and route (the held script quotes
90 days); do not harmonize it to the q6_14 60-day recall by proximity.
The four E.3 preparation references have metadata-matched lengths.
Historical sets reuse basenames, and one earlier manifest also has a
same-digest alias. Bind each reference using its basename, length and
recorded digest together in the exact pinned manifest, then use its full
path. Never select the latest file.

### Proposed Stata improvement for review

[The held reporting patch](operation-denominator.patch) adds explicit
state 2/3 counts and reconciliation to the affirmative-user operation
summary. It retains the original valid-bin percentage denominator and
the uncertainty, nonresponse and unresolved labels. It does not reassign
responses, change the cohort, touch the model block or release C2. If an
unexpected state/bin combination prevents reconciliation, do not silently
repair it; investigate the coverage under a later no-fit grant. The
patch is checked against the canonical file, not applied or run.

## Model and result lineage

The masked E.4 body begins at 3879; masks at 3898–3921 and literal fits at
4062–4085 map to the [frozen design](../wp07-estimation-design/ESTIMATION_MANIFEST.json).
R0 and D0 use distinct outcome-valid masks, the three focal candidates,
age, grouped education and version-aware grouped residence. R1 and D1 add
nominal occupation and raw first-arrival calendar year; the latter is
not current tenure. R0C repeats the remittance core on the intersection.
The saved design requires common-mask equality with D0, so there is no
sixth fit. Preserve exact integer/domain restrictions and grouped reference
presence; a missingness count alone is not enough to establish support.

| Exhibit | Exact use of historical E.4 native records | Acceptance limit |
| --- | --- | --- |
| QT1 / T3 | Five status records with intended and estimator N, status and definitions. | Keep exclusions from the admitted cohort distinct from model masks. Check grouped reference and endpoint support, rank, omissions and convergence; never equate prior programmed success with scientific adoption. |
| QF1 / F2 | Six fixed higher-minus-lower model-standardized probability differences, 3 per core outcome. IAT/IADT: 0.50 to 0.75; IAFF: 0.50 to 1.00. | Different increments, conditional pointwise delta intervals. Not a causal intervention, common dose or observed prevalence. Endpoints in marginal support do not establish joint overlap. |
| QT2 | Six named coefficient-null Wald tests, raw and fixed-six Holm values. | Do not reorder headline slots by significance, reduce the family because a slot is unavailable, or describe figure intervals as simultaneous. |
| QS1 / QS2 | Fifteen contrast records and thirty endpoint records across the five models. | Outcome/support and reference sets explicit. No clipped intervals, p-value fishing or new hypothesis family. |
| QS3 / S10–S11 | Native B/V and grouped support/status records; separate model sample and decision provenance. | No fabricated coefficient columns or release of small cells. E.5 remains held; no source rows inspected. |

The existing [E.4 execution receipt](../wp07-e4-restricted-execution/README.md)
records five converged working models, not coefficients on a future
persisted candidate. Before reuse, show exact lineage on carrier,
preparation body, projected values and row order, all outcome/focal/control
representations, model masks, grouped support and command/settings. Equal
model Ns alone cannot establish this. If an input difference matters,
document it and seek narrowly scoped fit authority; no refit for
significance or historical parity. Robust covariance here is conditional
on an independent-record working model, not a correction for unknown
household/referral dependence or a population survey design. Keep the old
45-model grids, default latent profiles and historical C2 off the
article's critical path. Preserve them; scientific and disclosure
decisions about any later use remain separate.

## Exhibit text ready for author review

**Table 1. Cohort and availability.** The unit is one retained survey
record. Report the 423-record cohort alongside separate known-version,
unknown-version and item-valid counts. A survey-record count does not
establish the number of distinct households or a response rate.

**Figure 1. Two measures of reported digital use.** Panel A shows the
distribution of the five remittance-disposition categories among valid
responses. Panel B shows reported domestic digital payment or transfer in
the previous 60 days among valid yes/no responses. Label the two Ns on
the figure and report unscored states in the source table. The panels
do not follow the same money from receipt to domestic use.

**Figure 2. Conditional associations with reported digital use.** Each
row shows the higher-minus-lower difference in model-standardized
probability for one prespecified focal measure, in percentage points.
Show the endpoints, model and estimation N. Bars are pointwise
intervals, not simultaneous or design-based intervals. Put raw and
Holm-adjusted tests in the companion table. Do not order by significance.

For each candidate exhibit, the later render review must link the
caption to the exact source result, freeze the row or panel order, reconcile
counts to its stated base, and check labels, rounding and disclosure on
the final rendering. These are specifications and caption drafts, not
new numerical exhibits or authorization to run the held E.5 emitter.
