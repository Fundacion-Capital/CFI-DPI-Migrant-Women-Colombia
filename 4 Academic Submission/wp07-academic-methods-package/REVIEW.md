# Independent read-only review

5 November 2026. Reviewer: separate wp07_four_part_methods_review agent.
Base HEAD: 4bbaa04092190f1694b7448e005e09aa04250f86.

The reviewer inspected the new specification, readiness/methods/exhibit/claim
documents, comparison/test registers and the two short Stata sources against
accepted D2/D3/D4/D6 and relevant retained metadata. No edits, participant/model/
consent payloads, Stata/MCP/native/Python/test/fixture/compiler execution or Git
mutations were performed. Source and CSV inspection only.

## Finding resolved during the same review

One Important issue, no Critical issues: C04 and C07 in the new code crosswalk
incorrectly inherited a numeric-only description for upstream TARGET33/preparation
and raw item reporting. The actual preparation route uses string q4_12; retained
P1 explicitly confirms it as string. Item reporting also uses string multiselect
parents such as q4_1, q5_13 and q9_17. Those are source-contract facts, not observed
participant values.

The main agent corrected the new crosswalk to SOURCE_EXACT_MIXED_TYPE, documented
the old inaccurate comment in IMPLEMENTATION_GAPS and the specification, and left
original code/data untouched. The reviewer independently read back the correction
and found the issue resolved. The genuinely numeric fourteen-field prepared
readiness view remains separate; no type conversion was introduced.

## Reviewed conclusions

- Fifteen domains, six response states, fixed components and own/common-N
  distinctions remain represented without a new global complete-case cohort.
- The two outcomes, four conditional nominations, nominated reference labels,
  unresolved support/covariance/contrast choices and single six-test Holm family
  match the accepted account. The nineteen comparisons are not nineteen tests.
- Population/manual exclusions, nonprobability recruitment, mixed mode and later
  R03 consent correction are retained without assumed institutional clearance.
- No H1/k4 default, new LCA family or error-free modal assignment is adopted.
- Both new do-files start with exit 198. Fourteen numeric inputs and two literal
  calls are explicit; no row edits, loading, scoring, estimator, hidden VCE,
  loop/helper framework or fallback is present in the new code bodies.
- Methods/exhibit text is appropriately prospective and source-grounded. Citation
  notes disclose their limited primary-source checks rather than a full review.

Verdict: no remaining Critical/Important findings in the reviewed bodies;
acceptable as OFFLINE_SOURCE_ONLY consolidation and drafting, subject to parent
closeout/custody checks. No actionable Minor was raised; editorial draft labels
are intentionally retained, not an assertion of final journal-ready prose.

## Explicit limits

The reviewer did not independently inspect LEGACY-A itself, participant quotes,
legacy hash custody, all historical scripts, the wider literature corpus, web
sources, or the subsequently added final preservation/closeout files. The parent
performed targeted legacy XML/hash inspection and final metadata readback.
Neither review establishes statistical validity, usable model samples, runtime
qualification, institutional/coauthor approval or publication readiness.
