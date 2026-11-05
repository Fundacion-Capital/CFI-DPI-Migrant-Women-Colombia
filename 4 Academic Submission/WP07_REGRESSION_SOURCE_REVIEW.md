# WP07 — historical regression source review and revision
5 November 2026 (Europe/Berlin). Status: **DISABLED_SOURCE_REVISION; EMPIRICAL_VALIDATION_HELD**.

## Scope and deliverables

The next unreviewed layer after the descriptive/correlation pass was Section II
of the historical analysis. This pass supplies four separate, disabled
researcher-readable do-files in [the regression revision folder](../1%20Code/wp07-regression-v1/README.md).
It preserves the original scripts, the style-only copy, approved preparation
draft, descriptive/correlation versions, manuscript, Graphify graph, all
existing packets and Appendix C2 capture source.

The scope includes **56 historical fit specifications**, not 56 performed fits:

- 45 main fits: nine outcome families, four table models and one
  standardized/AME fit per family.
- Four interaction fits, their four predictive-margin calls and plots.
- Seven supplementary item-level logits.
- One additional main-model AME call: five margins calls altogether.
- 47 preserved table-column writes to 11 table paths and 13 graph exports.

See the [56-row register](wp07-regression-source-review/MODEL_REGISTER.csv),
[22 entry fingerprints](wp07-regression-source-review/source_pins.json)
and [35 aggregate artifact fingerprints](wp07-regression-source-review/target_pins.json).
These are static source/exhibit bindings, not fresh participant-input bindings
or native numerical replication targets.

## Source and exhibit mapping

| Source family | Archived online table | Source figure file(s) |
|---|---|---|
| IURD | E1 | fig40 |
| Formal remittance receipt channel | E2 | fig41 AMEs |
| IUOF | E3 | fig42 |
| IETR | E4 | fig43 |
| OQI | E5 | fig44 |
| IPCS | E6 | fig45 |
| IEDF | E7 | fig46 |
| IAER | E8 | fig47 |
| ICPF | E9 | fig48 |
| I1–I4 interactions | E10, columns 1–4 | fig49–fig52 |
| Supplementary logits | E11, columns 1–7 | None in this source block |

Original `Table_F1…F4` path names map to online E1–E9, not Appendix F's
unrelated LCA diagnostic tables. The register supplies exact target filenames,
original table names, source lines, equations and display-column names.
Table headers were checked against all 11 archived TXT tables. Their Markdown
previews are secondary, and the PNGs are image references, not full-precision
coefficient or margin targets. Historical manuscript Figures 35–43 use a
different numbering system from source PNGs 40–48, as already established
by the protected core45 intake; that older distinction is not overwritten.

## Audit findings retained in the revision

1. **Raw versus standardized specifications differ.** IURD, formal remittance,
   IUOF and IETR raw B–D specifications include IADT; their fifth standardized
   specifications do not. These are not merely the same full model in different
   units. Preserve both; an academic specification change needs its own rationale
   and later model-specific comparison.
2. **Geography is historically pooled.** Setup replaces q3 code 5 with 1.
   The academic version-aware residence rule does not permit adopting this
   automatically. Code meanings differ across form versions; never infer that
   the pooled numeric code has one universal locality meaning.
3. **Denominators are model-specific.** Source has no explicit common-sample
   restriction or weights. Prefit completeness is not e(sample); logit support,
   omitted terms and perfect prediction must be checked in an authorized fit.
   The earlier core45 intake reported 423 for OLS table columns and 402 for
   formal-remittance columns; those are inherited exhibit facts, not new Ns.
4. **Standardization occurs before fitting.** Fifteen std() aliases use each
   source variable's observed carrier values, not a shared complete-case sample
   or the eventual equation-specific sample. No restandardization was applied.
5. **Formal receipt is not digital retention/use.** Historical formal_remittance
   uses q6_4 codes 1/2 versus 3/4 and leaves other codes unscored. The accepted
   academic remittance outcome is q6_13, not a renamed q6_4 helper.
6. **OR, AME and adjusted predictions must stay separate.** Raw logit tables
   request eform. The fifth formal fit calls margins with post and stores
   form_ame. Its posted probability derivatives cannot be compared directly
   to odds ratios or raw logit coefficients.
7. **Interaction grids are historical choices.** I1–I3 derive percentiles before
   fitting. I4 computes IEDF percentiles but uses fixed IEDF=0(10)100 and
   ICPF=25/50/75. Margins support is not verified by source inspection.
   The four marginsplots use noci; preserving that is not an academic decision
   to suppress uncertainty.
8. **Helpers and thresholds are not re-adopted.** The original eight binary
   helpers, refusal/uncertainty exclusions, fee/information collapses and
   IAER>=85 threshold are unchanged for historical fidelity. D3's separate,
   ordered or nominal domains are not replaced with these historical binaries.
9. **Dependence remains unresolved.** Historical vce(robust) is retained, not
   presented as a solution to unrecorded leader/referral/household dependence.
   No new clusters, RDS weights, network links, imputation or category pooling.
10. **Writer side effects remain part of future review.** Existing outreg2
    behavior includes TXT sidecars and outreg2.pref; the earlier protected intake
    explicitly documented this. New disabled copies do not sandbox those writes.
    Exact scratch destinations and package versions must be bound before use.

## D2 / D3 / D4 / D6 crosswalk

- **D2:** manual exclusions and the cohort remain untouched. Historical source
  inputs remain distinct from TARGET33 and academic prepared fields. No current
  participant carrier was opened, read or rehashed in this pass.
- **D3:** no scoring, recoding, direction or missingness policy is newly adopted.
  Old scoring and helper mappings appear only inside disabled historical bodies.
  Naming an old index does not validate its construct.
- **D4:** accepted conditional academic nominations use q6_13 retention/use and
  q6_14 domestic participation with IAT3/IADT2/IAFF2 and nominated context.
  None of these 56 old fits becomes one of the new nominated models by default.
  Exact contrasts, support and dependence treatment remain to be resolved.
- **D6:** preserve the retrospective history, failures and unavailable targets.
  The accepted six-test Holm family for the future two main academic models is
  not applied retrospectively to this 56-fit historical catalogue. No significance
  selection, automatic sensitivity batch or LCA model selection is introduced.

The [accepted D4/D6 account](wp06-d4-d6-acceptance/D4_D6_ACCEPTED_ACCOUNT_2026-10-26.md)
is the successor owner policy; the older proposed specification JSON is retained
as a historical preparation document, not silently updated or treated as current.

## Verification boundary and technical references

The audit is a **file-based source comparison**, not a Stata parser or numerical
test. It joins the source's known continuation syntax, expands the four literal
control macros, normalizes the reg abbreviation/whitespace and compares every
preserved executable body command in order, including transformations, labels,
estimation, margins, storage and output options. New preambles are checked
separately. No allowed difference includes changing a numerical formula,
sample condition, reference syntax, estimator, grid or output option.

Official documentation checked for the command semantics:
[regress](https://www.stata.com/manuals/rregress.pdf),
[logit](https://www.stata.com/manuals/rlogit.pdf),
[margins](https://www.stata.com/manuals/rmargins.pdf) and
[local scope across included/do files](https://www.stata.com/manuals/pinclude.pdf).
Current manuals do not establish historical runtime parity. Their guidance is
not authority to add new estimators, automatic clusters or tests.

The Graphify query used existing vocabulary regression/logit/models/controls/stata.
It located the historical regression architecture/version and downstream overlays.
The query was truncated at its stated budget and is navigation only; primary
do-file ranges, not graph coverage, govern this pass. No graph rebuild or
corpus-wide completeness claim is made.

## Remaining work and next substantive pass

The no-execution revision can proceed independently to the historical
**LCA-to-downstream boundary**: trace indicator inputs, candidate-selection
logic, preferred-final aliases, class assignment and classification uncertainty,
then revise the downstream descriptive and regression reporting code in separate
disabled files. Do not amend qualitative findings or infer an academic LCA choice.

Academic model implementation still needs the no-fit coverage evidence and
explicit resolution of scientific choices. StataCorp's standalone success does
not qualify the original worker. Appendix C2 remains on hold until the separate
runtime question and exact operation authorization are resolved. No new test,
fit, participant access, output replacement or release is authorized here.

Audit details and review disposition will be recorded in
[the local audit summary](wp07-regression-source-review/AUDIT.md).
No commit, push, Overleaf sync, email, manuscript edit or source-data change
is part of this pass.
