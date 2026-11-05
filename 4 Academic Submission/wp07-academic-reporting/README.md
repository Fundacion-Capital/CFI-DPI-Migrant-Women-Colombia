# WP07 academic item/domain reporting layer

5 November 2026. Separate disabled implementation; no participant processing.

The two Stata files are under `1 Code/wp07-academic-reporting-v1`. They are
explicit item/candidate blocks, not an abstract reporting framework or a new
dispatcher. Both stop at their first command, `exit 198`.

## Implemented coverage

| Artifact | Scope |
|---|---|
| ITEMS.csv | All 15 domains; 93 unique items; denominator, role and limit for every item |
| CODEBOOK.csv | 2,287 offered option/version rows; 465 item/version contracts including numeric context |
| CANDIDATES.csv | 11 existing provisional preparation fields with fixed components and own-N rules |
| SOURCE_RULE_DIFFERENCES.json | Three intentional non-inheritances for substantive barrier option 4; P2 unchanged |
| STATUS.json | No execution, participant processing, scoring, fitting, adoption or release; Appendix C2 HOLD |
| source_pins.json | 131 existing code/document/instrument-metadata fingerprints |
| verify_reporting.py | Named metadata-only checks; no Stata import, launch or participant reads |
| AUDIT.md / REVIEW.md / VALIDATION.json | Actual audit/review evidence, limits and artifact fingerprints |
| COMMIT_MESSAGE.txt | Proposed commit title and description, not a performed Git action |

The older historical, style-only, preparation, descriptive/correlation, regression
and LCA files remain intact. This is an additive reporting implementation, not
an adopted analytical result, rewritten methodology or a revised LCA family.

## Denominators and response states

The item file carries forward the P2 source's version-local route/domain order,
grouping only identical complete version recipes. It retains six states:
ordinary valid, structural skip, unavailable in version, applicable nonresponse,
item-specific sentinel and unresolved. All admitted rows remain in the coverage
denominator. State 5 is not invalidity; pending/N/A/refusal/uncertainty retain
their item-specific meanings. A conflicting state is not a new sample exclusion.

Scalar category shares include recorded offered sentinels explicitly, with
ordinary/sentinel/applicable N alongside them. Multiselect shares use valid
ordinary parent responses, with item-specific sentinels separately counted among
recorded parents: uncertainty for q5_13 and refusal where actually offered.
Offered options, including zero-count ones, remain version-specific;
nonoffered choices have no denominator or invented zero. Empty bases leave
percentages undefined. No multiselect combination string or open text is shown.
Separate restricted semantic-review counts surface a principal account absent
from selected products, no account after positive account selection, and later
main-None/additional-named barrier combinations. They change no answer, reporting
flag, candidate or row. Ordinary validity here is code/route validity, not proof
that all cross-item contradictions have been resolved.

Prepared candidate summaries use their own nonmissing N; fixed-component coverage
and any disagreement are visible. Common-observation comparisons do not replace
those own-N reports. No available-item reweighting, new cutoffs, optional binary,
candidate formula, normalized IVS or replacement IURD/IEDF aggregate is added.
Prepared engagement binaries retain their own nonmissing denominators; operation
bins use affirmative domestic users, with uncertainty and nonresponse separate.
The q6_13 personal wording remains an interpretation/applicability limitation
within the preserved household-remittance-eligible cohort. No personal-recipient
restriction is added, and disposition is not treated as a measured money share.

The item and candidate files deliberately have different input stages. The
candidate file is not a raw TARGET33 selection. Neither input is loaded here.
No existing P1–P4 permission or worker qualification extends automatically to
these reports, and prospective outputs are restricted, not public-ready tables.

## Source discrepancy and preserved limits

The retained choices and accepted IBPD account establish that q10_1/q10_2
option 4 is “No sé cómo usarlos”, not uncertainty. The new layer therefore does
not inherit P2's option-4 sentinel and combination rules. This corrects the new
source draft only; the original P2 must be separately corrected and requalified
before participant dispatch. No observed count or affected-record claim is made.

The residence q3 codebook comes from the accepted D2 version record: early Other
versus later Soacha, and Meta only in the latest form. Construct questionnaire
extracts lack q3, so this is not represented as a fresh original-form readback.
Partial choice extracts are merged only when their nonempty dictionaries agree;
an empty extract is missing coverage, not evidence that choices did not exist.

The existing Graphify map was traversed read-only for D3/preparation/denominator
dependencies, then current source files were checked directly. Its older source
locations are navigation, not fresh approval or evidence that a current file
was ingested. No graph rebuild, feedback write or corpus expansion occurred.

## Verification boundary

Only the named isolated Python metadata verifier may be run under this task's
authority. It checks source text/metadata, not Stata semantics or participant
results. Do not run repository-wide discovery, Stata, PyStata, native workers,
P1–P4 or C2. The preserved packets and institutional/release conditions remain
unchanged. Methodological/results decisions remain with the owner.

Official references checked for the proposed reporting commands:
[one-way tabulation](https://www.stata.com/manuals/rtabulateoneway.pdf) and
[tabstat](https://www.stata.com/manuals/rtabstat.pdf), plus the
[programming-if versus row-qualifier distinction](https://www.stata.com/support/faqs/programming/if-command-versus-if-qualifier/).
These describe reporting
options, not empirical validity or proof that this draft runs in the owned worker.
