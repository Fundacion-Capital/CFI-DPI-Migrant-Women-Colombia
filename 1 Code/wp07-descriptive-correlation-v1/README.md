# WP07 — descriptive and correlation source pass

Eight independent, disabled do-files rewrite the numerical reporting blocks.
Each starts with `exit 198`; none loads data, fits a model, saves a file, or
regenerates an exhibit. A future caller must verify the exact already-loaded
carrier and relevant fields before any execution. Do not concatenate these
blocks against a single convenient dataset. The older master, preparation,
analysis, style-only copies and first academic draft remain unchanged.

## Source and denominator crosswalk

Historical line numbers refer to the preserved analysis do-file. The
appendix manifests and workbook preview headers were used as documentary
evidence, not as participant data or proof of numerical reproduction.

| Draft | Historical target / required input | Fields and denominator |
| --- | --- | --- |
| 01 Main descriptives | Section I (27–1087); initial output-copy descriptive carrier. Figures 1–5 and 11–39 by source file number, including five companion variants across all 39 numbers. | Age, residence, tenure, education and occupation use their own observed fields. Stacks are audited with both-field counts and group row percentages, not presumed identical to every graph option. Grouped means show outcome N by group; CI rendering remains separate. See specific exceptions below. |
| 08 Table 2 and Figures 6–10 | Analysis 125–210 and the [accepted old-state replay](../../4%20Academic%20Submission/PROTECTED_DESCRIPTIVE_REPLAY.md). Use its nine-field old-state projection, not a newer copy. | Table 2 uses IVS/IAT category row percentages and separate IAT means by IVS. Figure 6 uses declared 0.05 count bins. Word Figure 7 is age (source fig8), Word Figure 8 is residence (source fig7), Figure 9 conditions device type on internet frequency, and Figure 10 includes explicit 99/N/A but excludes missing. |
| 02 Appendix descriptives | Section 18.3 (19499–19646); final-segment carrier. | C1 uses variable-specific N for 15 scores. D1 uses each item's observed nonmissing N, including retained numeric sentinels. D2 uses each dummy's nonmissing N and its count of ones; it is not Figure 16's exclusive priority count or verified question applicability. |
| 04 Historical pair | Section I line 231; initial descriptive carrier. | `iat_score` and `iadt_score`, pair-complete Pearson correlation, with historical significance display and newly visible N. No modern score substitutions. |
| 05 Appendix C2 | Section 18.3 (19530–19544); final-segment carrier. | One complete-case N across the exact 15-score list, in exhibit column order. Legacy CSV omits N. |
| 06 F5 associations | Section III.3 (3302, 3348–3418, 3875–4190); historical cluster-base carrier. | F5 Pearson and Cramer's V long sheets use each pair's nonmissing N and include `formal_remittance`. The continuous matrix excludes it and uses one listwise N across 15 scores. The original threshold flags (.50 absolute Pearson, .30 V) and theory pairs stay distinct; the flag columns identify the consolidated sheet's rows. |
| 03 Academic descriptives | Approved preparation v1, not any historical exhibit carrier. | Known-version and recorded eligibility gate coverage; version-aware residence; valid remittance and domestic participation; conditional operation bins; candidate score summaries with per-field N. |
| 07 Academic comparison | Same prepared academic input; not an historical replay or a model nomination. | IAT3 with IADT2 and separately with IADT3. Report each pair's own N and then the common N for an apples-to-apples comparison. No p-values. |

**Table C2 is not Figure C2.** The latter is the LCA-base heatmap
from the F5 matrix path, also copied to Appendix F. Its two archived
copies match each other by SHA-256; that fact does not make the
segmented-carrier Appendix C2 table their numeric source. Stata documents
the pairwise versus listwise distinction in its
[correlation manual](https://www.stata.com/manuals/rcorrelate.pdf).

## Historical exceptions that affect interpretation

- **Figures 6–10/Table 2:** keep the earlier old-state verification and the
  printed Table 2 percentage discrepancy separate. The draft checks counts
  and source means; it does not correct the preserved exhibit, recover
  historical rendering settings, or rename age and residence files.
  Historical preparation uses `q4 >= 60` without a nonmissing guard at
  line 1040. Stata missing values can satisfy this condition; whether any
  rows actually did is not established here. The historical audit uses the
  stored `age_cat` and does not recode it.
- **Figures 15 and 18:** omit education code 1 as in the graph source.
  Figures 15, 18, 22 and 23 originally plotted `ci mean` intervals; the
  new block reports group N, mean and SE, not adopted interval estimates.
  Figures 28–29 and 31–34 display legacy aggregates on a 0–1 scale; the
  audit reports stored values where indicated and does not change the scores.
- **Figure 16 versus D2:** the original Figure 16 assigned each row to
  the last selected product in source order, then divided by fixed 423.
  D2 allows simultaneous product selections and has item-specific denominators.
- **Figures 21, 24, 27, 30:** Figure 21 uses item-specific dummy means;
  Figure 24 counts recorded receipt channels, not retention or use.
  Figure 27 initialized all non-1–3 cases, including missing or unclassified
  `q7_5`, as the reference group. Do not describe it as verified unexposed.
  Figure 30's historical condition excludes system missing and 98; it is
  not proof of a validated complaint route.
- **Figures 35–37:** divide selected-option counts by fixed 423 in the
  historical figures. Do not substitute the respondents who answered the
  question. Figure 36 additionally has a **source-label mismatch**:
  preparation lines 2087–2093 derive the legacy `enabler_*` aliases from
  `q10_3_1` through `q10_3_7` in order, but preparation's option labels at
  917–923 disagree with several aliases. For example `q10_3_2` is
  accompaniment by someone trusted, not “Lower fees”; `q10_3_3` is
  lower/clearer fees, not “Better exchange rate”; and `q10_3_7` is merchant
  QR acceptance, not “Better internet.” Preserve the historical counts and
  art; do not reuse those aliases as academic labels or infer a tie rule.
- **C1/D1/D2:** the C1 export uses an eight-character index field in its
  historical postfile, too short for several full variable names. Use the
  full source names for comparison. D1's omitted denominator can be printed
  directly from each field; D2's nonmissing-dummy denominator does not
  establish eligibility to answer the multiselect.
- **F5:** require the exhibited field list rather than silently screening
  away absent fields. For sparse/constant inputs, retain pair N and report
  undefined coefficients rather than assigning zero. The rewritten
  categorical block does not force a chi-square test on one observed row
  or column. It does not recreate legacy flag prose, sorting, or Excel
  output; those are downstream display work.

## Academic field handoff and limits

The accepted preparation draft constructs `wp07_residence` from version
and `q3` without merging Other, Soacha and Meta. It does not resolve the
historical clock or the IVS composite; `wp07_ivs_educ` is one component
only. The accepted IAT3, IADT2/3, ICDP2, IAFF2, IUOF variants and OQI
variants are read as distinct candidates; none replaces the corresponding
historical score in C1/C2/F5. No new pooled score is created for the other
domains.

`wp07_remit_disposition` is `q6_13` codes 1–5 under the recorded gate,
not a monetary share or the latest `q6_4` receipt channel. The optional
binary field is not substituted for the categorical output.
`wp07_domestic_60d` is `q6_14` 0/1; `wp07_domestic_ops_bin` is `q6_15`
only among affirmative users. Report the full admitted N, the eligible-known
gate count, item-valid N and the unscored count; for operations separately
show affirmative users, valid bins, uncertainty 98 and unscored users.
The bin wording is <5, 5–10, 10–20, 20–50 and >50, not a reconstructed
number of operations. A zero-frequency category is not a missing response.
The draft cannot partition unscored responses into the six D2 response
states; that requires version- and route-specific evidence not supplied by
these derived fields.

## Verification boundary

This pass checks source, target names, ordering, input separation and
preservation. See the [static audit](AUDIT.md). No Stata parser or runtime
was exercised. It does not compare
observed coefficients, regenerate chart bins or pixels, or close
`WP04-CORR01`. Appendix F diagnostic tables other than F5, post-LCA
outcome exhibits, model results and release review are outside this pass.

For a separately authorized artificial Stata check, use cases with
different missing fields so pairwise and listwise Ns differ, a constant
pair, an all-missing outcome, zero-frequency declared codes, and an
operations 98 under an affirmative parent. Check that an operation value
under a nonaffirmative parent fails rather than entering the denominator.
Only after those checks and exact carrier authorization should a future
pass compare against historical numeric targets or adopt an academic table.
