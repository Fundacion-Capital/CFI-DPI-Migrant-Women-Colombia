# WP07 exhibit handoff — source and layout only

No result is populated. The tables and figure notes below are presentation
specifications, not evidence of sample counts, coefficients, or release
clearance. Internal exhibit IDs are stable; paper numbering can follow
the eventual manuscript.

## What goes in the main paper

| Exhibit | Reader's question | Source and fixed display |
| --- | --- | --- |
| T1 | Whom does the survey describe? | `cohort.csv`: one admitted total, then the form-version partition. Screening flags are a separate restricted diagnostic, not exclusions. Add only disclosure-reviewed geography from the established source. |
| T2 / F1 | How do respondents report handling remittances and using domestic digital payments? | `engagement.csv`: remittance codes 1–5 in instrument order; separate domestic No/Yes panel. Use the valid binary collapse in the table only, alongside valid N and unscored states. No waterfall, shared denominator, or connecting arrows. |
| QT1 / T3 | Which respondents and adjustment terms enter the working models? | Five model-status records, in fixed R0, D0, R1, D1, R0C order; intended N and estimator N side by side; show the separate descriptive outcome N in T2. |
| QF1 / F2 and QT2 | What are the model-standardized contrasts and their uncertainty? | Six core contrasts in two outcome panels, fixed IAT, IADT, IAFF order, labelled endpoints and pointwise intervals. Keep raw and Holm-adjusted coefficient-null tests in QT2. Do not order by magnitude or significance. E.5 remains held. |

**F1 caption.** Panel A shows the reported general disposition of remittance
proceeds among respondents who selected one of the five substantive
answers. Panel B shows whether respondents report making or receiving a
domestic digital payment or transfer in the previous 60 days, among valid
yes/no answers. Each panel prints its own denominator. Refusals and
unscored answers are not coded as nonuse. Percentages are shares of
respondents answering each item, not shares of money. The panels do not
follow the same transfer.

**F2 caption.** Points are higher-minus-lower differences in average fitted
probability, in percentage points, evaluated within the estimation sample
of the corresponding outcome model. The fitted values use the observed
other covariates in that sample. The comparison is 0.50 to 0.75 for access
and for reported transfer/online-safety confidence, and 0.50 to 1.00 for the two
onboarding conditions. Bars show pointwise 95% delta intervals, not
simultaneous intervals. These are conditional associations, not causal
effects, population estimates, or comparable unit changes across scores.
Use a zero reference line and direct labels; make the panels readable
in grayscale. If an endpoint or contrast is unavailable, keep its slot
and state why rather than leaving an unexplained blank or plotting zero.

## Supplemental exhibits and machine-readable checks

The held [Stata emitter](Descriptive%20exhibits.do) reads an existing
prepared frame only. Its four proposed CSVs are restricted artifacts,
never a public release by default. Future execution must use an
approved fresh destination; a partial file after failure is not accepted.
The three descriptive files are the default. AS1 requires the literal
`as1` argument under a separately reviewed scope. The pooled S5 choice
labels were checked across all five submitted versions; the existing
version-specific reporting and audit remain available separately.

| File | Key and fixed rows (excluding header) | Acceptance before interpretation |
| --- | --- | --- |
| `cohort.csv` | `section,category`; 11 rows | Five named versions plus UNKNOWN sum to admitted N; the four screening diagnostic states independently sum to the same admitted N. Never sum across sections. |
| `engagement.csv` | `panel,basis,code`; 19 rows | Remittance categories and its binary collapse use the same valid N; all-cash equals binary No and categories 2–5 sum to Yes. Domestic yes/no uses its own valid N. For each outcome, states 2–6 plus valid N reconcile to the admitted cohort. For q6_14, state 5 is offered refusal; for q6_13, no sentinel was offered. |
| `remittance_context.csv` | `item,basis,code`; 32 rows | S5: 4 receipt-frequency choices and 5 latest-channel choices use their separate recorded-answer bases; both six-state partitions use admitted N. Operation bins 1–5 use valid bins only. All six operation states among affirmative domestic users reconcile to the affirmative-user base. Code 99 remains the combined nonapplicable/not remembered response; code 98 for operation count is uncertainty, not a bin. |
| `associations.csv` | `basis,left,right`; 5 rows | Optional AS1, never C2: two own-pair bases and three common-base comparisons. Preserve the complete-case N, blank coefficient and distinct status for insufficient N or constant fields. No p-values, direction of causality, or validation claim. |

Labels are the recorded choices, not numeric interpretations. In the
remittance panel label code 2 “Withdrew less than half in cash” and code
4 “Kept more than half digitally”; do not sort the categories on a
monotonic cash-share axis. For operation count, preserve the survey's
phrasing, including shared endpoints at 10 and 20. Do not resolve endpoint
membership after the fact or use bin midpoints. Use a separate symbol/text
for undefined percentages when valid N is zero, not a bar at zero. A
genuine offered zero with a positive base is distinct from missing,
unoffered, or disclosure-suppressed.

S1–S4 and S6–S9 retain the [93-item register](../wp07-integrated-closure/ITEM_EXHIBIT_MAP.csv)
and version-specific option, route, and measurement rules. S10–S11
retain the exact model provenance, grouped support, omitted levels,
estimator/intent N and test records. The five E.4 ledgers and six E.5
slots stay governed by the [existing specification](../wp07-e5-restricted-exhibit-map/EXHIBIT_SPEC.md);
this package does not create a second renderer or change any model.

Before disclosure, review the complete package together. Version
partitions, response states, their totals, and companion exhibits can
allow a suppressed value to be recovered by subtraction. Hold the
whole affected display until direct and complementary disclosure have
been reviewed. Do not invent a threshold or mark the candidate cleared.
