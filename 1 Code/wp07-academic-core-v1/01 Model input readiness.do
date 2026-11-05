* WP07 model-input readiness -- disabled, restricted aggregate review only.
exit 198

version 16
set varabbrev off

* Exact prepared input in memory. No loading, scoring, filtering or output file.
confirm numeric variable formdef_version eligible_flag wp07_known_form, exact
confirm numeric variable q4 q2_2 q2_3 q2_1 wp07_residence, exact
confirm numeric variable wp07_iat3 wp07_iadt2 wp07_iaff2, exact
confirm numeric variable wp07_remit_disposition, exact
confirm numeric variable wp07_remit_any_digital wp07_domestic_60d, exact

* Verify the declared representation, not its scientific validity.
assert missing(wp07_iat3) | inrange(wp07_iat3, 0, 1)
assert missing(wp07_iadt2) | inrange(wp07_iadt2, 0, 1)
assert missing(wp07_iaff2) | inlist(wp07_iaff2, 0, .5, 1)
assert missing(wp07_remit_disposition) | ///
    inlist(wp07_remit_disposition, 1, 2, 3, 4, 5)
assert missing(wp07_remit_any_digital) | ///
    inlist(wp07_remit_any_digital, 0, 1)
assert missing(wp07_domestic_60d) | inlist(wp07_domestic_60d, 0, 1)
assert missing(wp07_remit_disposition) == missing(wp07_remit_any_digital)
assert wp07_remit_any_digital == (wp07_remit_disposition != 1) ///
    if !missing(wp07_remit_disposition)

* Every admitted row remains present. These are prospective restricted readouts.
count
display as text "Retained prepared rows; not a universal denominator: " r(N)
count if wp07_known_form != 1
display as text "Unknown or missing submitted-version status: " r(N)
count if eligible_flag != 1
display as text "Historical screening disagreement; no new exclusion: " r(N)

* Outcome support remains separate for the two questions and reference periods.
tabulate wp07_remit_disposition, missing
tabulate wp07_remit_any_digital, missing
tabulate wp07_domestic_60d, missing

* These counts are nonmissing-field screens, NOT certified model samples.
* They do not establish route validity, support, independence or estimability.
count if !missing(wp07_remit_any_digital, wp07_iat3, wp07_iadt2, ///
    wp07_iaff2, q4, q2_2, wp07_residence)
display as text "Remittance core nomination, nonmissing inputs only: " r(N)
count if !missing(wp07_domestic_60d, wp07_iat3, wp07_iadt2, ///
    wp07_iaff2, q4, q2_2, wp07_residence)
display as text "Domestic core nomination, nonmissing inputs only: " r(N)
count if !missing(wp07_remit_any_digital, wp07_iat3, wp07_iadt2, ///
    wp07_iaff2, q4, q2_2, wp07_residence, q2_3, q2_1)
display as text "Remittance extension, calendar input not yet resolved: " r(N)
count if !missing(wp07_domestic_60d, wp07_iat3, wp07_iadt2, ///
    wp07_iaff2, q4, q2_2, wp07_residence, q2_3, q2_1)
display as text "Domestic extension, calendar input not yet resolved: " r(N)

* Check raw covariate domains explicitly; never repair or drop an answer here.
count if !missing(q4) & (!inrange(q4, 18, 100) | q4 != floor(q4))
display as text "Age outside the instrument's integer 18-100 domain: " r(N)
count if !missing(q2_2) & ///
    (!inrange(q2_2, 1, 10) | q2_2 != floor(q2_2))
display as text "Education outside the ten offered codes: " r(N)
count if !missing(q2_3) & ///
    (!inrange(q2_3, 1, 9) | q2_3 != floor(q2_3))
display as text "Occupation outside the nine offered codes: " r(N)
count if !missing(q2_1) & ///
    (!inrange(q2_1, 1950, 2026) | q2_1 != floor(q2_1))
display as text "Arrival year outside the retained form's domain: " r(N)

* Code 5 is completed secondary education; code 3 is employee/worker.
* These are overall support counts, not support within an estimated model.
count if q2_2 == 5
display as text "Proposed education reference, full prepared stage: " r(N)
count if wp07_residence == 1
display as text "Proposed Bogota reference, full prepared stage: " r(N)
count if q2_3 == 3
display as text "Proposed occupation reference, full prepared stage: " r(N)

* Preserve Other/Soacha/Meta meanings by version. Small cells remain restricted.
tabulate wp07_residence formdef_version, missing
tabulate q2_2, missing
tabulate q2_3, missing

* Do not derive tenure from the current year or change any historical clock.
count if missing(q2_1)
display as text "Missing first-arrival calendar input: " r(N)

* No VCE, logit, margins, p-values, weights or LCA choices are made here.
* Joint support and covariate-domain review must precede any fit manifest.
