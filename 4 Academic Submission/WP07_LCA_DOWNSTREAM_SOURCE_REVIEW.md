# WP07 — historical LCA-to-downstream source review and revision
5 November 2026 (Europe/Berlin).
Status: **DISABLED_SOURCE_REVISION; SCIENTIFIC_AND_EXECUTION_HOLDS_RETAINED**.

## 1. Scope and actual changes

The [separate review copy](../1%20Code/wp07-lca-downstream-v1/README.md)
covers every physical source line 1900–19300 of the original analysis:
17,401 source lines spanning the full historical Section III. The two extra
closing lines beyond the older WP03 report-export window preserve its scope;
Section 18 online-appendix copying, including C2, is not executed or revised.

The first executable command is exit 198. One file preserves shared locals,
temporary handles, programs, delimiters and execution order. Nineteen documented
comment-line revisions correct interpretation without changing any executable
scientific command. Stage notes and blank-line cleanup improve navigation.
This is a historical reference revision, not a claim that the large legacy
workflow is already a publication-ready academic pipeline.

[Source fingerprints](wp07-lca-downstream-source-review/source_pins.json)
bind 51 earlier files, including original/preparation/style/previous revisions,
the manuscript, prior WP03 registers and prior regression audit. No participant
dataset, saved model or raw consent record was opened or freshly hashed.
Four additional supporting metadata files are pinned in a separate
[supporting register](wp07-lca-downstream-source-review/supporting_pins.json);
these are current text-source checks, not participant inspections.

## 2. Candidate and downstream scope

The [candidate register](wp07-lca-downstream-source-review/CANDIDATES.csv)
contains M1–M4 and H1–H4, each at k=2–5, plus one distinct preferred-final
H1 four-class fit: **33 literal GSEM fit sites, zero performed**.

The frozen WP03 expansion register separately identifies **88 conditional
downstream operation slots**: 51 primary estimation/clustering operations,
35 ANOVAs and two legacy k-means fallback attempts. The 51 includes the one
preferred-final fit, so adding the 32 grid candidates gives **120 conditional
source-path operation slots**, not 121 and not 120 performed fits.
The candidate and downstream registers have different purposes; neither is an
execution grant, a sufficient optimization search or a new analysis plan.

The [stage register](wp07-lca-downstream-source-review/STAGES.csv) covers 16
contiguous windows. The [read/write map](wp07-lca-downstream-source-review/DATAFLOW.csv)
identifies 325 textual read/write sites, including 128 reads and 197 writes.
Sites inside loops/branches may execute multiple times or not at all; temporary
and macro-generated destinations are not uniquely identified files. No target
content, row data or fitted values were read to construct this map.
The map excludes postfile/log/directory calls and is not a full side-effect
catalogue. A separate [removal-site register](wp07-lca-downstream-source-review/REMOVAL_SITES.csv)
binds 14 historical erase sites; no deletion occurred. The
[alias-lineage register](wp07-lca-downstream-source-review/ALIAS_LINEAGE.csv)
binds 64 declaration/assignment lines for 26 named aliases, retaining stage
context rather than treating repeated variable names as one universal state.

## 3. Indicator lineage and selection

- Historical source indices are diagnosed and recoded into categorical/binary
  aliases before the minimal and hybrid grids. Fixed historical bins and
  distribution-dependent cuts must not be replaced with the accepted academic
  D3 definitions merely because a construct name is the same.
- The preferred final H1 model uses h_ivs3, h_icdp3, h_iaff3, h_iuof3,
  h_oqi3 and h_iurd3 as ordered logits, and h_iedf2 as binary logit.
  It has a seven-indicator complete-case flag.
- Original grids preserve each family-specific sample, class count, explicit
  seed, random-start draws and iteration budget. Failed/nonconverged cases
  remain part of the historical record, not silently dropped.
- Both historical report_candidate flags require convergence, k in 4/5,
  minimum class percentage at least 5 and entropy at least .60.
  This is a reporting screen, not proof that k=4 is optimal or identified.
  Its greater-than-or-equal comparisons have no explicit nonmissing metric
  guards. Because Stata numeric missings sort above finite values, a hypothetical
  converged k=4/5 row with missing size/entropy can pass that expression.
  No claim is made that an actual archived row did so.
  The later H1 four-class choice/refit is hard-coded, not an automatic winner
  produced by those flags.
- Benchmark k-means/Ward clustering uses standardized continuous inputs.
  The legacy k-means fallback branches are preserved but not authorized.
  The inherited assignment merge/order at the benchmark boundary remains
  a distinct input-lineage issue.

StataCorp documents latent classes as model-defined categorical latent
variables, not observed types: [lclass options](https://www.stata.com/manuals/semgsemlclassoptions.pdf)
and [latent-class example](https://www.stata.com/manuals/semexample50g.pdf).
Current documentation does not establish historical runtime parity or validate
these particular indicator families.

## 4. Preferred final fit, aliases and saved-state evidence

The preferred-final source sorts KEY, attempts sortseed 6529004 under capture,
sets seed 6529004 and fits a **separate** H1 four-class model with 600 randomid
draws, explicit start seed 6529004, difficult and 8000 iterations. The enclosing
LCA workflow declares version 16; do not silently substitute the earlier
regression section's version 19 directive.

The previously accepted [saved-state audit](WP03_PREFERRED_FINAL_SAVED_STATE_AUDIT.md)
reported exact 3,199-field reproduction alongside near-boundary item probabilities,
extreme cutpoint uncertainty and severe coordinate scaling. These are inherited
findings, not remeasured here. Exact reproduction, stored convergence and local
rank do not close the academic scientific hold.

The historical reporting permutation is:

| Raw class | Final segment | Posterior source |
|---:|---:|---|
| 1 | 1 | classpost1 |
| 4 | 2 | classpost4 |
| 3 | 3 | classpost3 |
| 2 | 4 | classpost2 |

This mapping describes one historical model state. Numeric class labels can
differ across fits. No relabeling, posterior prediction or reuse was performed.
StataCorp's [prediction manual](https://www.stata.com/manuals/sempredictaftergsem.pdf)
distinguishes class probabilities from posterior probabilities conditional on
observed responses; neither makes modal assignment observed truth.

## 5. Classification edge cases: demonstrated only on artificial vectors

The original raw assignment chooses the first raw class attaining the maximum.
The reconstructed segment assignment chooses the first segment attaining the
maximum **after permutation**. For the artificial raw vector
(.10, .40, .10, .40), the historical raw priority selects class 2 → segment 4,
whereas reordered probabilities select segment 2. The equality assertion can
therefore fail under an exact tie.

Both second-best searches use a strict value-below-maximum rule. For artificial
(.40, .40, .10, .10), this yields .10 rather than the usual second order statistic
.40, producing a .30 rather than zero top-two gap. With four .25 values there is
no strictly lower value and the later nonmissing-second-posterior assertion
cannot be satisfied.

Six pure-Python arithmetic fixtures demonstrate these logical facts and the
missing-metric reporting-screen edge case without
Stata, participants, random draws, estimation or applying a new tie policy.
They do not show that any actual respondent was tied or misclassified.
The source rules and stored assignments remain unchanged.

[The remediation register](wp07-lca-downstream-source-review/REMEDIATION.md)
proposes a bounded future validity/tie-count check and owner choice of a
permutation-consistent policy and second-order-statistic definition. No
respondent exclusion, jitter, tolerance, reassignment or score change is
automatically approved.

## 6. Profiles, overlap and downstream interpretation

[The 11-outcome crosswalk](wp07-lca-downstream-source-review/OUTCOME_DEPENDENCIES.csv)
separates direct class-defining transformations from shared survey items/routes.

- IURD, IUOF, OQI and IEDF enter H1 through transformations. Segment differences
  in them are not independent confirmation.
- formal_remittance comes from q6_4, which is itself a source item in the
  historical IURD score. Its “external” label does not remove construction
  overlap, and receipt channel is not the academic q6_13 retention/use outcome.
- Domestic-use routes shared with IURD affect experience measures. Exposure q7_1
  contributes to IEDF and routes IPCS content. IEH/IBPD share q10_4/q10_6/q10_16.
  Non-direct indicators remain same-survey evidence with possible shared content.
- Posterior-weighted profiles provide descriptive summaries, not corrected
  classification-error standard errors or independent validation. Modal-class
  OLS/ANOVA, pairwise comparisons, multinomial membership regressions and
  outcome logits/OLS remain associational.
- Historical thresholds .60/.80 describe recorded certainty categories, not a
  new inclusion rule. No low-certainty participant was removed.
- Local per-outcome pairwise Holm adjustment is not the accepted D4/D6 family of
  six future primary overall association tests. Its old families, missing-result
  handling and pointwise intervals must be compared separately if later executed.
- Collapsed s15 age/education/occupation/geography controls and reference segment 3
  are historical overlay specifications, not automatic academic controls.
- Actual source lines 4650–4655 define recent_training_12m from q10_10.
  The [older outcome-role metadata](scientific-foundation/downstream_outcome_roles.csv)
  assigns q10_11 to that helper; this is a metadata/code discrepancy,
  not a reason to silently change this source helper. Item definitions and
  version-specific meaning still govern any academic reuse.

No BCH/three-step or one-step uncertainty correction is assumed feasible for
this exact mixed-input GSEM workflow. That method/software decision remains
scientific work, not a style edit.

## 7. Writers, release and unchanged boundaries

The source saves respondent-level assignments/posteriors and final datasets,
including Stata and Excel containers. KEY-based merges, fallback IDs, alternate
input paths and output overwrites are all visible in the disabled historical
copy, not sanctioned as the new public replication route. Aggregate-looking
filenames alone do not establish non-disclosure; response-pattern and rare-cell
tables require payload-specific review.

Repeated figure/table destinations and multi-sheet append/replace commands
remain historical. A pathname is not enough to identify which source variant
produced a current artifact. No plot or table was regenerated, visually
revalidated or replaced.

The accepted D2/D3/D4/D6 account, institutional/privacy limits and conditional
academic LCA route remain unchanged. No qualitative evidence, manuscript,
participant sample, scoring, model or numerical result was altered.
Appendix C2 and the original worker's runtime qualification remain on hold.
The standalone StataCorp diagnostic success is not that worker's qualification.

## 8. Audit and next substantive task

The [audit](wp07-lca-downstream-source-review/AUDIT.md) records file-only tests,
the independent read-only AI-assisted review and any corrections. Complete
physical source coverage is a mechanical preservation check; it is not a claim
that every scientific assumption or native execution branch has been validated.

This advances WP07/WP08 source preparation. It does not close M8/M9 or the
Measurement/Method/Replication/Release gates.

Next: prepare the finite academic replacement/retirement map for the legacy
LCA and downstream blocks. Separate historically retained reference code from
what the academic paper actually needs, specify unresolved indicator/uncertainty
choices, and define the smallest no-fit validation wave. No new LCA family,
class count, fit, participant read or release follows automatically from this pass.
