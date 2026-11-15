# Academic Stata track — current source checkpoint
15 November 2026. The descriptive section of `2 Analysis.do` is available as a
separate run on the locked, prepared survey file. It does not call preparation
or run any model. The original Master, preparation and E.4 execution holds
remain in place. The dated checkpoint below describes the earlier held source.

## Run the descriptive section

Start a separate Stata session. Load the approved prepared dataset in memory
and use an existing, empty **restricted** output directory. Substitute your
local paths:

```stata
ssc install blindschemes
use "path/to/restricted/academic_prepared.dta", clear
do "path/to/repository/1 Code/academic/2 Analysis.do" descriptives ///
    "path/to/restricted/new-output-folder" "path/to/repository/1 Code/academic"
```

Install `blindschemes` only once if `plotplain` is not already available. The
held Master checks for it and installs it only if missing. The descriptive
call uses the verbatim version-specific offered-choice list in
`descriptive_options.csv`; do not substitute pooled or historic value labels.

The run writes two main tables, five supplementary tables, the two descriptive
figures and their presentation or submission variants, and aggregate CSVs. Use
the `_artwork.pdf` files and the corresponding `_caption.tex` fragments when
the publisher requires captions outside artwork. Figures with in-image notes
are for independent review or presentations. The detailed option and route
counts stay restricted, including zero bases and small cells.
`item_choices.csv` preserves the original audit columns;
`item_choice_display.csv` distinguishes the ordinary multiple-response parent
base from the all-recorded parent base used for explicit refusal. No prepared
records are changed and no respondent-level file is created. The numerical and
presentation checks are not release clearance.

## 8 November checkpoint (historical)

8 November 2026. E.4 decisions A–D are accepted by the owner and integrated
**in held source only**. At that checkpoint all three scripts began with a hold.
The analysis has an additional stop immediately before the E.4 estimation body.
No execution, participant load, hold removal or release is authorized here.
Appendix C2 remains HOLD.

Start with `4 Academic Submission/wp07-e4-source-integration/README.md`,
its owner acceptance and prepared native-validation plan. The older
`wp07-integrated-stata`, E.1/E.2/E.3 and E.4 design packets remain preserved
evidence at their dated checkpoints, not standing execution authority.

## The three scripts
- **0 Master.do:** the same exact admitted carrier, literal 98-field projection,
  preparation call and restricted prepared-data save. It now passes the output
  argument to analysis. **Do not dispatch this full master for bounded E.4**:
  it includes a dataset save, full descriptive reports and existing correlations,
  none of which is in the next artificial-model validation scope.
- **1 Data preparation.do:** unchanged 93-item version/route/state rules, eleven
  provisional candidates and two distinct binary engagement fields. The approved
  model-only education/residence/occupation groupings are appended explicitly.
  Original values, detailed descriptive categories and historical exclusions
  remain unchanged; no new pooled outcome or LCA input is created.
- **2 Analysis.do:** the earlier item/domain reports are preserved in Git and
  the private audit. The 15 November descriptive entry above replaces them in
  the current source. After a separate stop, the unchanged E.4 body contains the
  five named logit specifications, model-specific masks, support and exact-sample
  checks, finite/rank/omission checks, six primary Wald slots, fixed probability
  comparisons and fixed-six Holm treatment. There is no helper program, external
  dependency, fallback estimator, retry, model search or participant prediction.

## Scientific meaning and limits
Education's model grouping distinguishes below completed secondary, completed
secondary and any postsecondary study (including incomplete). Residence's
residual is explicitly Other/Soacha/Meta responses, not one city or a cluster.
Occupation remains nominal with employee/worker as reference. All detailed
original categories stay available in descriptions.

The calendar extension is raw first-arrival year, not newly derived tenure or
normalized IVS. Working robust covariance is a conditional independent-record
approximation, not a correction for referral/household dependence or a national
sampling design. Completely-determined outcome counts are retained as diagnostics:
they alone do not establish nonfinite MLEs or invalidate an otherwise qualified
fit. Actual sample loss, nonzero perfect-predictor rules, rank/finite/convergence
failures and unexpected omissions remain explicit failure conditions.

The primary family is six coefficient-null tests in the two cores. Unavailable
slots keep missing p-values; the Holm family does not shrink. Probability
comparisons are .50–.75 for IAT3/IADT2 and .50–1 for IAFF2, over each unchanged
model sample, not at means. A missing endpoint affects its contrast, not an
otherwise estimable coefficient test. Pointwise intervals are not simultaneous
or causal intervals. No historical H1/k4 or new academic LCA is adopted.

## Custody and next validation
The preserved carrier identity and inherited membership still govern. Existing
manual/test/nonofficial and coded exclusions are not reapplied or expanded.
KEY, contacts, enumerator identities and free text remain outside the research
projection. Raw values and clocks are not repaired.

Before any authorized run, bind the exact revised source hashes, stage-specific
selection, dedicated empty Stata-MCP session, log/spill destinations and a fresh
restricted output leaf. No shell Stata or Python/R replacement estimates.
A timeout is not proof of native exit; no replacement/retry or custom worker is
introduced. The new validation fixtures are artificial, held and **NOT RUN**.
They do not authorize the five real-data fits or certify current support.

The E.4 body would write only restricted aggregate/native-matrix ledgers and
six hypothesis records; it never saves a participant dataset or exports
individual predictions. The full master has a different output scope.
Exact before-images of this README and the three scripts are preserved privately.
