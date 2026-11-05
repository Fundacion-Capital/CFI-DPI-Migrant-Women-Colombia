# Academic item/domain reporting: source-only audit

5 November 2026. Task closure is limited to disabled source implementation.

## Implemented scope

Two separate Stata drafts are added under `1 Code/wp07-academic-reporting-v1`:

1. Item/domain reports: 15 domains, 93 unique original items, 465 item/version
   contracts and a 2,287-row offered-option codebook. Shared items are reported
   once and cross-referenced. Numeric age/year context does not create tenure.
2. Prepared-field reports: 11 provisional summaries/components already declared
   in the preserved preparation draft, three common-observation comparisons,
   and the separately prepared engagement outcomes and operation bins.

Both start with unconditional `exit 198`; neither is called by a master.
They contain no input loader, output file path, participant-row export, fit,
prediction, score construction or legacy-alias fallback. The item file creates
and drops only its own reporting-state flags. The candidate file changes no
variable. No Stata, PyStata/SFI, native worker or participant file was invoked.

## Source and denominator audit

- Accepted D2/D3/D4/D6 policies govern meanings and conditional roles. Historical
  source recipes and prior technical passes do not override them.
- The exact 163-field TARGET33 allowlist remains unchanged. Original-item reads
  are within it; this does not extend its processing permission. Prepared-field
  reporting has a different, future separately verified input stage.
- Each version-local route/state sequence is compared to P2 source. Only the
  three documented substantive-barrier rules are intentionally not inherited.
  Every replace has a row-level version qualifier. Unknown versions remain
  unresolved, not discarded or processed by the first row's version.
- Six-state coverage uses the full admitted denominator. Each scalar category
  uses its recorded applicable answer N, explicitly including offered sentinels.
  Ordinary-valid, sentinel and applicable N are separately visible.
- Each multiselect option uses its version-specific ordinary-valid parent N;
  an offered sentinel is separately reported over recorded parents. q5_13's
  98 means uncertainty; other offered refusals retain their own meaning.
  No full combination string, open text or identifier is printed.
- Offered zero counts are visible. Unoffered options have no invented zeros.
  Empty denominators leave percentages undefined. No available-item reweighting,
  common-case restriction across all domains or new cohort exclusion is added.
- Separate non-mutating semantic-review counts surface no account after positive
  selection, principal products absent from selected accounts, and later-form
  main-None/additional-named barrier combinations. Ordinary code/route validity
  is not semantic clearance. These counts change no mask, score, answer or row.
- Candidate own-N, complete-component N and discrepancies remain distinct.
  The education component is not an IVS composite. The three common-observation
  comparisons do not replace each candidate's broader own-N report.
- Household-remittance eligibility is preserved despite q6_13's personal wording.
  No monetary shares, reconstructed operation counts, date-source resolution,
  normalized IVS, replacement IURD/IEDF aggregate or LCA recipe is supplied.

## Inherited source discrepancy

Retained instrument choices and accepted IBPD definitions establish that option
4 in q10_1/q10_2 is “No sé cómo usarlos”. P2 incorrectly classifies it as
uncertainty and treats some q10_2 combinations containing it as unresolved.
The new draft omits exactly three such rules; P2 and its prior packets remain
unchanged. SOURCE_RULE_DIFFERENCES.json identifies them. A separately scoped
additive P2 correction and requalification is required before future use.
No actual affected-participant count has been inspected or inferred.

The codebook draws on agreeing nonempty construct questionnaire/choice extracts.
Empty extracts were treated as missing metadata, not as absent choices. q3's
version-specific geography meanings use the accepted D2 record because the
construct extracts do not include that field. That distinction is explicit.

## Verification history and review

The missing-files test was observed failing before implementation. Additional
negative controls were observed failing before their fixes: mutation outside
reporting flags/new-score commands, programming if on participant fields,
missing cross-item semantic checks, and q5_13 uncertainty mislabeled as refusal.
The false-positive check for Spanish “nombre” inside questionnaire comments was
narrowed to active code; the source question wording was not altered.

An independent reviewer identified three material source-level issues, all
addressed in the new files:

1. Programming-if wrappers were inappropriate for row-wise version selection.
   Every state replace now has its own row qualifier. The verifier compares
   exact version-local sequences across all 465 contracts and rejects the
   programming-if mistake.
2. Cross-item semantic-review coverage was incomplete. Principal-account and
   main-None/additional-barrier diagnostics were added without response repairs,
   new masks or cohort exclusions.
3. q5_13's uncertainty was mislabeled as refusal. The output and denominator
   descriptions are now item-specific. Unreachable 98 branches were removed
   from multiselect items where that option is not offered.

The final named verifier has 15 static source/metadata checks. These are not
Stata execution tests and do not establish native syntax, command semantics,
empirical denominators or scientific validity. The predecessor map's nine
file-only checks were also rerun. REVIEW.md records the independent closeout;
VALIDATION.json records final exits, limits and new-artifact fingerprints.

Metadata exploration included a PowerShell parse error, a partial-dictionary
conflict check, truncated large-JSON reads and two rejected patch contexts.
They were corrected without participant reads or changes to existing sources.
No failed native attempt or data processing occurred. Original packets were
not overwritten, replaced, cleaned up or deleted.

## Custody and authority

All 131 pinned existing code/document/instrument-metadata files match their
recorded sizes and SHA-256 fingerprints. This includes the prior map and all
existing research do-files. This is not a fresh hash audit of every restricted
participant/model packet; those payloads were not opened. Git HEAD remains
19e797156c3e539fb7520559e1e43acd87c1ad50, with no tracked/staged edits.
Only the two new package directories are added.

No execution, participant processing, scoring, fitting, relabeling, scientific
adoption, institutional clearance, coauthor approval or release is inferred.
No settings/services, contacts, Git commit/push or cloud/Overleaf synchronization.
Appendix C2 remains HOLD. The owner's methodological/results decisions remain
with the owner; existing institutional and publication checkpoints stay open.

## Next substantive step

Reconcile the inherited P2 barrier rules in a separately preserved disabled
successor, and prepare the exact artificial-validation cases for the reporting
files. Source-only work can continue while the worker issue is unresolved.
Any Stata run or participant processing still requires its own qualified route
and exact authorization; no such action is included in this closure.
