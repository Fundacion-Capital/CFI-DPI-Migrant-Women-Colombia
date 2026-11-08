# E.4 scientific-decision and bounded-estimation design
8 November 2026. **Design prepared; owner adoption and all execution remain pending.**

This package converts the accepted D2/D3/D4/D6 policies and completed restricted
E.2/E.3 checks into one reviewable proposal. It does not estimate anything, amend
the canonical Stata scripts, inspect participant records or grant a new load.
Read this memo, then the exact `ESTIMATION_MANIFEST.json` and `FIELD_GROUPINGS.csv`.
Actual unpublished support counts and their source locators remain in the
protected E.4 evidence note, not in this public source package.

## 1. What the evidence now changes
Coverage is not estimability. The protected native category tables identify
singleton adjustment levels in the nominated core and extension designs.
A separate indicator supported by one binary response admits a likelihood-
improving path towards an infinite coefficient: move that indicator's
coefficient towards the observed outcome, leaving every other row unchanged.
Thus the full original categorical nominations cannot have an entirely finite,
unpenalized maximum-likelihood solution on their intended input samples.
This is a mathematical implication of existing aggregate evidence, **not a new
fit, outcome-by-category inspection or assertion that Stata already failed**.

The scientific target remains a within-recruited-cohort conditional association,
not a national or causal effect. Household-remittance eligibility is not proof of
personal receipt/management. The remittance outcome is reported disposition, not
a measured monetary share; the domestic outcome has a 60-day reference period.
IAT partly references financial use, so content overlap with engagement remains
an interpretation limitation. Complete valid model inputs do not establish
random missingness or transportability. No accepted measure is newly declared a
validated latent construct by this design.

Stata documents perfect-predictor omissions and observation removal. Accepting
the resulting fit as if it used the nominated sample would be misleading.
[Stata logit manual, examples 2–3](https://www.stata.com/manuals/rlogit.pdf).

**Recommendation:** adopt the explicit adjustment-only groupings below,
retain all original responses/descriptive categories, and recheck the grouped
design before any fit. These are proposed scientific amendments, not style
fixes, accepted D3 changes, empirical validation or automatically applied repairs.
Grouping eliminates the known singleton categories in the existing marginal
tables; it does **not** establish joint support, full rank or absence of other
separation. A still-unsupported model stops rather than dropping women.

## 2. One consolidated owner review: four decisions
### Decision A — support-aware adjustment and honest uncertainty
Recommended model-only context fields:
- **Education:** below completed secondary (source 1–4); completed secondary (5,
  reference); any reported postsecondary study (6–10, including incomplete).
  Do not call the last category a completed tertiary qualification.
- **Residence:** Bogotá (reference), Cali, Medellín, and **other recorded
  residence responses**, explicitly comprising early Other, later Soacha and
  Meta. The residual is not a city, municipality, rural stratum or cluster.
  Soacha remains individually visible in descriptions; its pooling is a real
  loss of adjustment detail that requires the owner's approval.
- **Occupation, extensions only:** employer/independent; employee/worker
  (reference, unchanged); paid domestic worker; student/pensioner/not currently
  working; unpaid family worker; other. This is a nominal grouping of main-
  occupation responses, not a verified labour-force classification or ranking.

Exact source-code mappings are in FIELD_GROUPINGS.csv. All model input masks
continue to require valid original source responses. No original category,
candidate definition, person or historical exclusion changes.

Recommend `vce(robust)` **only as an explicitly conditional, independent-record
working covariance**, not as a solution for recruitment/referral/household
dependence. Primary numerical p-values, Holm summaries and nominal intervals,
if later computable, must carry that limitation; do not describe a confirmed
population discovery or design-valid 5% error guarantee. Give substantive
priority to association sizes and uncertainty, with no significance stars.
If that conditional analysis is unacceptable, retain descriptive/point-
prediction reporting and keep inferential tests unavailable. No exact network-
robust inference can be certified from the current projection.

No survey/RDS weights, invented grouping identifiers, city/enumerator clustering,
wild bootstrap or resampling is introduced. Grouping residence for adjustment
does not make it an independent sampling cluster. Clustering should follow a
defensible design argument, not a software default or the smallest p-value.
[Stata covariance options](https://www.stata.com/manuals/rlogit.pdf);
[Abadie et al., author manuscript](https://arxiv.org/pdf/1710.02926).

Alternatives needing a different proposal: preserve all nominal levels and
assess Firth/bias-reduced logit; or explicitly simplify the adjustment set.
Penalization can address separation under suitable design conditions but does
not recover recruitment-network information or make uncertainty automatically
robust. It is not installed, selected or a fallback in this manifest.
[Kosmidis and Firth, author manuscript](https://arxiv.org/abs/1812.01938).
Dropping rare women, treating education as an equal-spaced number, or silently
accepting Stata's sample deletions is not recommended.

### Decision B — exact probability summaries, distinct from primary tests
Recommend these fixed contrasts for every admitted model:
| Candidate | Lower to higher | Interpretation |
| --- | --- | --- |
| IAT3 | 0.50 to 0.75 | A quarter-scale comparison of the same provisional three-component summary |
| IADT2 | 0.50 to 0.75 | A quarter-scale comparison of transfer ability/confidence, not the smartphone-only item |
| IAFF2 | 0.50 to 1.00 | One versus both reported administrative conditions; not an invented 0.1 step |

These values lie inside the ranges recorded in E.3. **Exact endpoint counts and
joint support were not established there.** Before each future model fit,
require at least one observation at each chosen endpoint within its intended
mask, and retain endpoint-by-outcome counts as a restricted support diagnostic.
Presence is a minimum gate, not proof of adequate precision or joint positivity.
Never substitute a more favourable contrast if an endpoint is unsupported.
A missing endpoint leaves that contrast unavailable; do not infer a missing
coefficient test solely from that fact.

For each comparison, set only that candidate to each endpoint, leave other
covariates at their observed values, and average predictions over that fitted
model's unchanged sample. Report both probabilities and higher-minus-lower
difference, in percentage points. Use conditional delta-method, pointwise 95%
intervals from the adopted working covariance. No at-means respondent, score
standardization, causal intervention or national weighting is implied.
Simultaneously setting a summary across observed covariate combinations remains
model-based and may rely on extrapolation; marginal endpoints do not establish
joint overlap. [Stata margins](https://www.stata.com/manuals/rmargins.pdf).

The accepted **six overall focal tests** stay coefficient-null Wald tests:
each of IAT3, IADT2 and IAFF2 has its single continuous-slope coefficient equal
to zero in each core model. A finite-difference Wald p-value is not substituted
for that coefficient test. Probability contrasts supply interpretable
magnitudes, not another primary discovery family.
[Stata test](https://www.stata.com/manuals/rtest.pdf).

### Decision C — extension history without invented tenure
Recommend the original first-arrival year `c.q2_1` as one linear calendar term
in each extension, alongside nominal grouped occupation. It describes earlier
versus later first arrival under a linear log-odds specification, not years of
residence, uninterrupted exposure, current migration spell or a causal cohort
effect. No reference-year clock, 2026-minus-arrival tenure, date repair,
normalized IVS or data-selected cohorts are created.

A one-year linear calendar association is a proposed functional form, not a
finding forced by nonmissing coverage. Extensions are supporting analyses, not
new primary discoveries. Keep the two cores usable if an extension is blocked.
An owner who does not want the linear assumption can defer both extensions;
that changes the manifest before execution, not in response to fit results.

### Decision D — finite fit budget, failures and fixed family
Recommend **at most five named fits, one attempt each and no retries**:
| ID | Role | Inputs/sample |
| --- | --- | --- |
| R0_E4 | Core remittance engagement | Own valid core inputs; grouped context |
| D0_E4 | Core domestic participation | Own valid core inputs; grouped context |
| R1_E4 | Supporting remittance extension | R0 inputs plus valid occupation and raw arrival year |
| D1_E4 | Supporting domestic extension | D0 inputs plus valid occupation and raw arrival year |
| R0C_E4 | Common-observation sensitivity | Remittance core on intersection of the two core masks |

These IDs amend, rather than overwrite, the original R0/D0/R1/D1 nominations.
No second domestic common-sample fit is needed: E.3's intersection equals its
domestic mask in size, and is a subset of it by construction, hence the sets
coincide. Groupings preserve missingness; a future exact assertion must confirm
that relation. A failed assertion returns the manifest for review; it does not
authorize an extra fit. This removes a redundant fit, not an outcome model.

The five commands, named postestimation operations, input/source bindings,
masked-sample rules, outputs and stop conditions are in the manifest.
Grouped-context projections have **not** been run on participant data.
The maximum is a ceiling, not an obligation: failed pre-fit gates consume no
fit; actual failures are retained with no replacement. No penalty estimator,
interaction grid, LCA, C2, score substitution or model search is included.

For six fixed primary slots use the accepted Holm procedure. For valid raw
p-values ordered as p(1)...p(k), k <= 6, calculate
`min(1, max over j<=i of ((6-j+1)*p(j)))`. Unavailable slots retain a missing
raw/adjusted p-value and explicit reason; never turn an internal bookkeeping
placeholder into a measured p-value or reduce the family to k. This is the
conservative extension obtained by reserving unrejected slots, not a new test
result. Validity still depends on the underlying tests; multiplicity does not
fix separation or dependence. Report an incomplete family as incomplete.
Pointwise intervals are not simultaneous Holm intervals.
[Goeman and Solari, section 3](https://arxiv.org/html/1211.3313v1).
The original Holm full text was not retrievable; see METHOD_SOURCES.md.

## 3. What must pass before a future estimate is reportable
1. Adopt this exact scientific proposal, including the genuine context grouping
   amendments. Bind a separately authorized native Stata test/execution scope.
2. Rebind the unchanged carrier and preparation hash, exact inherited 98-field
   E.3 raw projection, fresh restricted output leaf and Stata-MCP route. Do not
   run the master/full analysis, reuse consumed E.2/E.3 grants or expand fields.
3. In memory only, apply the accepted preparation and, if adopted, the explicit
   grouped-context mapping. Check original answers/order/cohort continuity and
   no newly missing grouped field on an ordinary source value.
4. Reproduce the four domain-valid masks. Preserve the cohort: masks are
   model-specific inclusion rules, not new global exclusions or repaired values.
   Check expected mask counts privately against E.3; do not hard-code fitted N.
5. Pre-fit check both outcome values, adopted references, grouped factor-by-
   outcome support, exact contrast endpoints, and obvious design dependencies.
   Any nonempty factor level containing only one outcome blocks that model.
   Empty nonreference levels are recorded as absent, not pooled or populated.
   These necessary checks do not rule out multivariable separation.
6. After each authorized fit require intended mask == e(sample), convergence,
   finite coefficients/covariance, positive focal standard errors, full expected
   design rank, and no unexpected omissions or perfect-prediction/sample-drop
   rules. Expected columns count only present factor levels, plus intercept
   and named continuous terms; empty/base levels are not rank failures.
   Numerical convergence alone is insufficient. Preserve all Stata notes.
7. Record unavailable tests/margins separately, restore stored model state
   before each margins operation, and capture named matrices immediately.
   Do not use force/noestimcheck/noesample, participant predictions or a retry.
8. Keep exact source, command receipt, aggregate/model-matrix results and
   failed/partial packets restricted. Inspect log destinations before dispatch;
   ordinary and MCP spill logs are not assumed to be safely located.
   Timeout is not proof of native exit; no hard-kill guarantee is invented.

## 4. Owner checkpoint and next substantive work
**Current adoption status: PENDING. Current authorized loads/fits: 0/0.**
One consolidated acceptance can adopt A–D; it does not itself authorize data
processing, fitting, release, institutional approval or manuscript claims.

Suggested response:
> I approve E.4 decisions A–D, including the explicit model-only context
> groupings, conditional robust-error interpretation, fixed contrasts, linear
> first-arrival-year extensions and five-fit ceiling. Implement and audit the
> separate source candidate; retain all execution and release holds.

After adoption: integrate the exact model-only mappings and five named
specifications into the held canonical source, prepare a finite artificial
native test selection, and seek/run only the separately authorized test and
restricted fit scope. This is substantive statistical implementation, not a
worker/bootstrap milestone. If an owner changes a material choice, issue a
dated successor specification before fitting.

E.5 then supplies verified exhibits and quantitative writing. B/C/D/G.1 continue
the full paper's literature/theory/Colombia context, existing qualitative and
expert evidence, benchmarking and architecture without waiting for LCA.
D1_rights R01–R12, privacy, exact-version coauthor/CFI and release decisions remain
as recorded: documentary acceptance is not institutional or publication
clearance. No qualitative themes, citations, manuscript/Overleaf files or
historical packets are changed here.

