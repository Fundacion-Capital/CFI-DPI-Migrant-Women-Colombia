* Prepared-field reporting coverage cases -- artificial-only draft, not run.
* No source or participant file is loaded. Do not remove the hold under this task.
exit 198

version 16
assert _N == 0
* Literal reporting-only numbers, not constructed scores or a test of scoring formulas.
* Row4 deliberately has an IAT summary without components to exercise the diagnostic.
input byte case_id
1
2
3
4
end

gen double wp07_ivs_educ = .
replace wp07_ivs_educ = 1 if case_id == 1
replace wp07_ivs_educ = 0 if case_id == 2

gen double wp07_iat3 = .
replace wp07_iat3 = 1 if case_id == 1
replace wp07_iat3 = 0 if case_id == 2

gen double wp07_iat_phone = .
replace wp07_iat_phone = 1 if case_id == 1
replace wp07_iat_phone = 0 if case_id == 2

gen double wp07_iat_internet = .
replace wp07_iat_internet = 1 if case_id == 1
replace wp07_iat_internet = 0 if case_id == 2

gen double wp07_iat_runout = .
replace wp07_iat_runout = 1 if case_id == 1
replace wp07_iat_runout = 0 if case_id == 2

gen double wp07_iadt2 = .
replace wp07_iadt2 = 1 if case_id == 1
replace wp07_iadt2 = 0 if case_id == 2

gen double wp07_iadt_transfer = .
replace wp07_iadt_transfer = 1 if case_id == 1
replace wp07_iadt_transfer = 0 if case_id == 2

gen double wp07_iadt_confidence = .
replace wp07_iadt_confidence = 1 if case_id == 1
replace wp07_iadt_confidence = 0 if case_id == 2

gen double wp07_iadt3 = .
replace wp07_iadt3 = 1 if case_id == 1
replace wp07_iadt3 = 0 if case_id == 2

gen double wp07_iadt_app = .
replace wp07_iadt_app = 1 if case_id == 1
replace wp07_iadt_app = 0 if case_id == 2

gen double wp07_icdp2 = .
replace wp07_icdp2 = 1 if case_id == 1
replace wp07_icdp2 = 0 if case_id == 2

gen double wp07_icdp_otp = .
replace wp07_icdp_otp = 1 if case_id == 1
replace wp07_icdp_otp = 0 if case_id == 2

gen double wp07_icdp_pin = .
replace wp07_icdp_pin = 1 if case_id == 1
replace wp07_icdp_pin = 0 if case_id == 2

gen double wp07_iaff2 = .
replace wp07_iaff2 = 1 if case_id == 1
replace wp07_iaff2 = 0 if case_id == 2

gen double wp07_iaff_address = .
replace wp07_iaff_address = 1 if case_id == 1
replace wp07_iaff_address = 0 if case_id == 2

gen double wp07_iaff_phone = .
replace wp07_iaff_phone = 1 if case_id == 1
replace wp07_iaff_phone = 0 if case_id == 2

gen double wp07_iuof3 = .
replace wp07_iuof3 = 1 if case_id == 1
replace wp07_iuof3 = 0 if case_id == 2

gen double wp07_iuof_frequency = .
replace wp07_iuof_frequency = 1 if case_id == 1
replace wp07_iuof_frequency = 0 if case_id == 2

gen double wp07_iuof_merchant = .
replace wp07_iuof_merchant = 1 if case_id == 1
replace wp07_iuof_merchant = 0 if case_id == 2

gen double wp07_iuof_saving = .
replace wp07_iuof_saving = 1 if case_id == 1
replace wp07_iuof_saving = 0 if case_id == 2

gen double wp07_iuof3_oldmap = .
replace wp07_iuof3_oldmap = 1 if case_id == 1
replace wp07_iuof3_oldmap = 0 if case_id == 2

gen double wp07_iuof_frequency_oldmap = .
replace wp07_iuof_frequency_oldmap = 1 if case_id == 1
replace wp07_iuof_frequency_oldmap = 0 if case_id == 2

gen double wp07_iuof2_no_frequency = .
replace wp07_iuof2_no_frequency = 1 if case_id == 1
replace wp07_iuof2_no_frequency = 0 if case_id == 2

gen double wp07_oqi2 = .
replace wp07_oqi2 = 1 if case_id == 1
replace wp07_oqi2 = 0 if case_id == 2

gen double wp07_oqi_ease = .
replace wp07_oqi_ease = 1 if case_id == 1
replace wp07_oqi_ease = 0 if case_id == 2

gen double wp07_oqi_support = .
replace wp07_oqi_support = 1 if case_id == 1
replace wp07_oqi_support = 0 if case_id == 2

gen double wp07_oqi2_oldmap = .
replace wp07_oqi2_oldmap = 1 if case_id == 1
replace wp07_oqi2_oldmap = 0 if case_id == 2

gen double wp07_oqi_ease_oldmap = .
replace wp07_oqi_ease_oldmap = 1 if case_id == 1
replace wp07_oqi_ease_oldmap = 0 if case_id == 2
replace wp07_ivs_educ = 0.4444444444444444 if case_id == 3
replace wp07_iadt_transfer = 0.5 if case_id == 3
replace wp07_iadt_confidence = 0.5 if case_id == 3
replace wp07_iadt2 = 0.5 if case_id == 3
replace wp07_iuof_merchant = 0.5 if case_id == 3
replace wp07_iuof_saving = 0.5 if case_id == 3
replace wp07_iuof2_no_frequency = 0.5 if case_id == 3
replace wp07_oqi_ease = 0.3333333333333333 if case_id == 3
replace wp07_oqi_support = 1 if case_id == 3
replace wp07_oqi2 = 0.6666666666666666 if case_id == 3
replace wp07_iat3 = 1 if case_id == 4

gen double wp07_remit_disposition = .
replace wp07_remit_disposition = 1 if case_id == 1
replace wp07_remit_disposition = 5 if case_id == 2
replace wp07_remit_disposition = 2 if case_id == 3

gen double wp07_remit_any_digital = .
replace wp07_remit_any_digital = 0 if case_id == 1
replace wp07_remit_any_digital = 1 if case_id == 2
replace wp07_remit_any_digital = 1 if case_id == 3

gen double wp07_domestic_60d = .
replace wp07_domestic_60d = 0 if case_id == 1
replace wp07_domestic_60d = 1 if case_id == 2
replace wp07_domestic_60d = 1 if case_id == 3
replace wp07_domestic_60d = 1 if case_id == 4

gen double wp07_domestic_ops_bin = .
replace wp07_domestic_ops_bin = 2 if case_id == 2
replace wp07_domestic_ops_bin = 98 if case_id == 3

* BEGIN FULL_PREPARED_REPORT
version 16
set varabbrev off
* No loader, alternate carrier, cohort restriction, scoring, fit or file export.
* Require exact names. A missing preparation field stops the block; no legacy alias is used.
* These provisional summaries are not validated psychometrics or adopted LCA inputs.
count
local admitted_n = r(N)
display as text "Admitted rows retained: " as result `admitted_n'
* IVS calendar gap, date source and fixed L/U bounds remain unimplemented and held.
* No IURD, IETR, IPCS, IEDF, IAER, ICPF, IEH or IBPD aggregate is substituted.

* CANDIDATE wp07_ivs_educ
* Education component only; not normalized IVS or continuous tenure
confirm numeric variable wp07_ivs_educ, exact
assert missing(wp07_ivs_educ) | inrange(wp07_ivs_educ, 0, 1)
quietly count if !missing(wp07_ivs_educ)
local summary_n = r(N)
display as text "Education component nonmissing N / admitted (not an IVS composite): " as result `summary_n' " / " `admitted_n'
if `summary_n' > 0 {
    tabstat wp07_ivs_educ, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iat3
* Fixed three-item candidate; financial-use content overlap remains
confirm numeric variable wp07_iat3 wp07_iat_phone wp07_iat_internet wp07_iat_runout, exact
assert missing(wp07_iat3) | inrange(wp07_iat3, 0, 1)
assert missing(wp07_iat_phone) | inrange(wp07_iat_phone, 0, 1)
assert missing(wp07_iat_internet) | inrange(wp07_iat_internet, 0, 1)
assert missing(wp07_iat_runout) | inrange(wp07_iat_runout, 0, 1)
quietly count if !missing(wp07_iat_phone, wp07_iat_internet, wp07_iat_runout)
local component_n = r(N)
quietly count if !missing(wp07_iat3)
local summary_n = r(N)
display as text "wp07_iat3 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iat3) & !missing(wp07_iat_phone, wp07_iat_internet, wp07_iat_runout)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iat3) & missing(wp07_iat_phone, wp07_iat_internet, wp07_iat_runout)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iat3, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iadt2
* Two fixed components; phone applicability remains
confirm numeric variable wp07_iadt2 wp07_iadt_transfer wp07_iadt_confidence, exact
assert missing(wp07_iadt2) | inrange(wp07_iadt2, 0, 1)
assert missing(wp07_iadt_transfer) | inrange(wp07_iadt_transfer, 0, 1)
assert missing(wp07_iadt_confidence) | inrange(wp07_iadt_confidence, 0, 1)
quietly count if !missing(wp07_iadt_transfer, wp07_iadt_confidence)
local component_n = r(N)
quietly count if !missing(wp07_iadt2)
local summary_n = r(N)
display as text "wp07_iadt2 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iadt2) & !missing(wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iadt2) & missing(wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iadt2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iadt3
* Smartphone-only app component; compare on common observations separately
confirm numeric variable wp07_iadt3 wp07_iadt_app wp07_iadt_transfer wp07_iadt_confidence, exact
assert missing(wp07_iadt3) | inrange(wp07_iadt3, 0, 1)
assert missing(wp07_iadt_app) | inrange(wp07_iadt_app, 0, 1)
assert missing(wp07_iadt_transfer) | inrange(wp07_iadt_transfer, 0, 1)
assert missing(wp07_iadt_confidence) | inrange(wp07_iadt_confidence, 0, 1)
quietly count if !missing(wp07_iadt_app, wp07_iadt_transfer, wp07_iadt_confidence)
local component_n = r(N)
quietly count if !missing(wp07_iadt3)
local summary_n = r(N)
display as text "wp07_iadt3 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iadt3) & !missing(wp07_iadt_app, wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iadt3) & missing(wp07_iadt_app, wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iadt3, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_icdp2
* Both valid applicable OTP/PIN components; unfamiliarity/nonuse not zero
confirm numeric variable wp07_icdp2 wp07_icdp_otp wp07_icdp_pin, exact
assert missing(wp07_icdp2) | inrange(wp07_icdp2, 0, 1)
assert missing(wp07_icdp_otp) | inrange(wp07_icdp_otp, 0, 1)
assert missing(wp07_icdp_pin) | inrange(wp07_icdp_pin, 0, 1)
quietly count if !missing(wp07_icdp_otp, wp07_icdp_pin)
local component_n = r(N)
quietly count if !missing(wp07_icdp2)
local summary_n = r(N)
display as text "wp07_icdp2 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_icdp2) & !missing(wp07_icdp_otp, wp07_icdp_pin)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_icdp2) & missing(wp07_icdp_otp, wp07_icdp_pin)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_icdp2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iaff2
* Two specific administrative conditions, not comprehensive formal inclusion
confirm numeric variable wp07_iaff2 wp07_iaff_address wp07_iaff_phone, exact
assert missing(wp07_iaff2) | inrange(wp07_iaff2, 0, 1)
assert missing(wp07_iaff_address) | inrange(wp07_iaff_address, 0, 1)
assert missing(wp07_iaff_phone) | inrange(wp07_iaff_phone, 0, 1)
quietly count if !missing(wp07_iaff_address, wp07_iaff_phone)
local component_n = r(N)
quietly count if !missing(wp07_iaff2)
local summary_n = r(N)
display as text "wp07_iaff2 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iaff2) & !missing(wp07_iaff_address, wp07_iaff_phone)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iaff2) & missing(wp07_iaff_address, wp07_iaff_phone)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iaff2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iuof3
* Accepted 1/.75/.5/.25/0 frequency map with fixed components
confirm numeric variable wp07_iuof3 wp07_iuof_frequency wp07_iuof_merchant wp07_iuof_saving, exact
assert missing(wp07_iuof3) | inrange(wp07_iuof3, 0, 1)
assert missing(wp07_iuof_frequency) | inrange(wp07_iuof_frequency, 0, 1)
assert missing(wp07_iuof_merchant) | inrange(wp07_iuof_merchant, 0, 1)
assert missing(wp07_iuof_saving) | inrange(wp07_iuof_saving, 0, 1)
quietly count if !missing(wp07_iuof_frequency, wp07_iuof_merchant, wp07_iuof_saving)
local component_n = r(N)
quietly count if !missing(wp07_iuof3)
local summary_n = r(N)
display as text "wp07_iuof3 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iuof3) & !missing(wp07_iuof_frequency, wp07_iuof_merchant, wp07_iuof_saving)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iuof3) & missing(wp07_iuof_frequency, wp07_iuof_merchant, wp07_iuof_saving)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iuof3, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iuof3_oldmap
* Declared historical frequency-spacing sensitivity, not automatic replacement
confirm numeric variable wp07_iuof3_oldmap wp07_iuof_frequency_oldmap wp07_iuof_merchant wp07_iuof_saving, exact
assert missing(wp07_iuof3_oldmap) | inrange(wp07_iuof3_oldmap, 0, 1)
assert missing(wp07_iuof_frequency_oldmap) | inrange(wp07_iuof_frequency_oldmap, 0, 1)
assert missing(wp07_iuof_merchant) | inrange(wp07_iuof_merchant, 0, 1)
assert missing(wp07_iuof_saving) | inrange(wp07_iuof_saving, 0, 1)
quietly count if !missing(wp07_iuof_frequency_oldmap, wp07_iuof_merchant, wp07_iuof_saving)
local component_n = r(N)
quietly count if !missing(wp07_iuof3_oldmap)
local summary_n = r(N)
display as text "wp07_iuof3_oldmap complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iuof3_oldmap) & !missing(wp07_iuof_frequency_oldmap, wp07_iuof_merchant, wp07_iuof_saving)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iuof3_oldmap) & missing(wp07_iuof_frequency_oldmap, wp07_iuof_merchant, wp07_iuof_saving)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iuof3_oldmap, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iuof2_no_frequency
* Frequency-omission definition, not available-item fallback
confirm numeric variable wp07_iuof2_no_frequency wp07_iuof_merchant wp07_iuof_saving, exact
assert missing(wp07_iuof2_no_frequency) | inrange(wp07_iuof2_no_frequency, 0, 1)
assert missing(wp07_iuof_merchant) | inrange(wp07_iuof_merchant, 0, 1)
assert missing(wp07_iuof_saving) | inrange(wp07_iuof_saving, 0, 1)
quietly count if !missing(wp07_iuof_merchant, wp07_iuof_saving)
local component_n = r(N)
quietly count if !missing(wp07_iuof2_no_frequency)
local summary_n = r(N)
display as text "wp07_iuof2_no_frequency complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iuof2_no_frequency) & !missing(wp07_iuof_merchant, wp07_iuof_saving)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iuof2_no_frequency) & missing(wp07_iuof_merchant, wp07_iuof_saving)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iuof2_no_frequency, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_oqi2
* Registration ease and offered initial support; activation separate
confirm numeric variable wp07_oqi2 wp07_oqi_ease wp07_oqi_support, exact
assert missing(wp07_oqi2) | inrange(wp07_oqi2, 0, 1)
assert missing(wp07_oqi_ease) | inrange(wp07_oqi_ease, 0, 1)
assert missing(wp07_oqi_support) | inrange(wp07_oqi_support, 0, 1)
quietly count if !missing(wp07_oqi_ease, wp07_oqi_support)
local component_n = r(N)
quietly count if !missing(wp07_oqi2)
local summary_n = r(N)
display as text "wp07_oqi2 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_oqi2) & !missing(wp07_oqi_ease, wp07_oqi_support)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_oqi2) & missing(wp07_oqi_ease, wp07_oqi_support)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_oqi2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_oqi2_oldmap
* Declared historical ease-spacing sensitivity
confirm numeric variable wp07_oqi2_oldmap wp07_oqi_ease_oldmap wp07_oqi_support, exact
assert missing(wp07_oqi2_oldmap) | inrange(wp07_oqi2_oldmap, 0, 1)
assert missing(wp07_oqi_ease_oldmap) | inrange(wp07_oqi_ease_oldmap, 0, 1)
assert missing(wp07_oqi_support) | inrange(wp07_oqi_support, 0, 1)
quietly count if !missing(wp07_oqi_ease_oldmap, wp07_oqi_support)
local component_n = r(N)
quietly count if !missing(wp07_oqi2_oldmap)
local summary_n = r(N)
display as text "wp07_oqi2_oldmap complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_oqi2_oldmap) & !missing(wp07_oqi_ease_oldmap, wp07_oqi_support)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_oqi2_oldmap) & missing(wp07_oqi_ease_oldmap, wp07_oqi_support)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_oqi2_oldmap, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* COMMON_SAMPLE IADT_TWO_VS_THREE: Definition and applicability comparison, not simple rescaling
quietly count if !missing(wp07_iadt2, wp07_iadt3)
local common_n = r(N)
display as text "IADT_TWO_VS_THREE common nonmissing N / admitted: " as result `common_n' " / " `admitted_n'
if `common_n' > 0 {
    tabstat wp07_iadt2 wp07_iadt3 if !missing(wp07_iadt2, wp07_iadt3), ///
        statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}

* COMMON_SAMPLE IUOF_FREQUENCY_DEFINITIONS: Compare all three on their common observations; retain broader own-N reports above
quietly count if !missing(wp07_iuof3, wp07_iuof3_oldmap, wp07_iuof2_no_frequency)
local common_n = r(N)
display as text "IUOF_FREQUENCY_DEFINITIONS common nonmissing N / admitted: " as result `common_n' " / " `admitted_n'
if `common_n' > 0 {
    tabstat wp07_iuof3 wp07_iuof3_oldmap wp07_iuof2_no_frequency if !missing(wp07_iuof3, wp07_iuof3_oldmap, wp07_iuof2_no_frequency), ///
        statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}

* COMMON_SAMPLE OQI_EASE_SPACING: Declared ease-spacing definitions on the same nonmissing observations
quietly count if !missing(wp07_oqi2, wp07_oqi2_oldmap)
local common_n = r(N)
display as text "OQI_EASE_SPACING common nonmissing N / admitted: " as result `common_n' " / " `admitted_n'
if `common_n' > 0 {
    tabstat wp07_oqi2 wp07_oqi2_oldmap if !missing(wp07_oqi2, wp07_oqi2_oldmap), ///
        statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}

* The two accepted primary binary contrasts retain separate valid-answer denominators.
confirm numeric variable wp07_remit_disposition wp07_remit_any_digital wp07_domestic_60d wp07_domestic_ops_bin, exact
assert missing(wp07_remit_disposition) | inlist(wp07_remit_disposition, 1, 2, 3, 4, 5)
assert missing(wp07_remit_any_digital) | inlist(wp07_remit_any_digital, 0, 1)
assert missing(wp07_domestic_60d) | inlist(wp07_domestic_60d, 0, 1)
assert missing(wp07_domestic_ops_bin) | inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5, 98)
* Prepared-field reports consume their own nonmissing values, without claiming route validation.
quietly count if !missing(wp07_remit_disposition)
local remit_n = r(N)
quietly count if !missing(wp07_remit_any_digital)
local remit_binary_n = r(N)
quietly count if !missing(wp07_domestic_60d)
local domestic_n = r(N)
display as text "Remittance categories / binary / domestic binary / admitted: " as result `remit_n' " / " `remit_binary_n' " / " `domestic_n' " / " `admitted_n'
if `remit_n' > 0 {
    tabulate wp07_remit_disposition, nolabel
}
if `remit_binary_n' > 0 {
    tabulate wp07_remit_any_digital, nolabel
}
if `domestic_n' > 0 {
    tabulate wp07_domestic_60d, nolabel
}
* Bin uncertainty is a valid recorded category, but not a substantive operation bin.
quietly count if wp07_domestic_60d == 1
local users_n = r(N)
quietly count if wp07_domestic_60d == 1 & inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5)
local bins_n = r(N)
quietly count if wp07_domestic_60d == 1 & wp07_domestic_ops_bin == 98
local unknown_bins_n = r(N)
quietly count if wp07_domestic_60d == 1 & missing(wp07_domestic_ops_bin)
local missing_bins_n = r(N)
display as text "Affirmative users / valid bins / uncertainty / nonresponse: " as result `users_n' " / " `bins_n' " / " `unknown_bins_n' " / " `missing_bins_n'
forvalues category = 1/5 {
    quietly count if wp07_domestic_60d == 1 & wp07_domestic_ops_bin == `category'
    local category_n = r(N)
    display as text "Operation bin " `category' " N: " as result `category_n'
    if `bins_n' > 0 {
        display as text "Percent valid operation bins: " as result 100 * `category_n' / `bins_n'
    }
}
* No change to scores, labels, rows, historical outputs or Appendix C2.
* END FULL_PREPARED_REPORT
assert _N == 4
assert `summary_n' == 2
assert `common_n' == 2
assert `remit_n' == 3
assert `remit_binary_n' == 3
assert `domestic_n' == 4
assert `users_n' == 3
assert `bins_n' == 1
assert `unknown_bins_n' == 1
assert `missing_bins_n' == 1
* Remove only the four artificial rows, retaining variables for the empty-data case.
drop if case_id > 0
assert _N == 0
* BEGIN EMPTY_PREPARED_REPORT
version 16
set varabbrev off
* No loader, alternate carrier, cohort restriction, scoring, fit or file export.
* Require exact names. A missing preparation field stops the block; no legacy alias is used.
* These provisional summaries are not validated psychometrics or adopted LCA inputs.
count
local admitted_n = r(N)
display as text "Admitted rows retained: " as result `admitted_n'
* IVS calendar gap, date source and fixed L/U bounds remain unimplemented and held.
* No IURD, IETR, IPCS, IEDF, IAER, ICPF, IEH or IBPD aggregate is substituted.

* CANDIDATE wp07_ivs_educ
* Education component only; not normalized IVS or continuous tenure
confirm numeric variable wp07_ivs_educ, exact
assert missing(wp07_ivs_educ) | inrange(wp07_ivs_educ, 0, 1)
quietly count if !missing(wp07_ivs_educ)
local summary_n = r(N)
display as text "Education component nonmissing N / admitted (not an IVS composite): " as result `summary_n' " / " `admitted_n'
if `summary_n' > 0 {
    tabstat wp07_ivs_educ, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iat3
* Fixed three-item candidate; financial-use content overlap remains
confirm numeric variable wp07_iat3 wp07_iat_phone wp07_iat_internet wp07_iat_runout, exact
assert missing(wp07_iat3) | inrange(wp07_iat3, 0, 1)
assert missing(wp07_iat_phone) | inrange(wp07_iat_phone, 0, 1)
assert missing(wp07_iat_internet) | inrange(wp07_iat_internet, 0, 1)
assert missing(wp07_iat_runout) | inrange(wp07_iat_runout, 0, 1)
quietly count if !missing(wp07_iat_phone, wp07_iat_internet, wp07_iat_runout)
local component_n = r(N)
quietly count if !missing(wp07_iat3)
local summary_n = r(N)
display as text "wp07_iat3 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iat3) & !missing(wp07_iat_phone, wp07_iat_internet, wp07_iat_runout)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iat3) & missing(wp07_iat_phone, wp07_iat_internet, wp07_iat_runout)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iat3, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iadt2
* Two fixed components; phone applicability remains
confirm numeric variable wp07_iadt2 wp07_iadt_transfer wp07_iadt_confidence, exact
assert missing(wp07_iadt2) | inrange(wp07_iadt2, 0, 1)
assert missing(wp07_iadt_transfer) | inrange(wp07_iadt_transfer, 0, 1)
assert missing(wp07_iadt_confidence) | inrange(wp07_iadt_confidence, 0, 1)
quietly count if !missing(wp07_iadt_transfer, wp07_iadt_confidence)
local component_n = r(N)
quietly count if !missing(wp07_iadt2)
local summary_n = r(N)
display as text "wp07_iadt2 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iadt2) & !missing(wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iadt2) & missing(wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iadt2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iadt3
* Smartphone-only app component; compare on common observations separately
confirm numeric variable wp07_iadt3 wp07_iadt_app wp07_iadt_transfer wp07_iadt_confidence, exact
assert missing(wp07_iadt3) | inrange(wp07_iadt3, 0, 1)
assert missing(wp07_iadt_app) | inrange(wp07_iadt_app, 0, 1)
assert missing(wp07_iadt_transfer) | inrange(wp07_iadt_transfer, 0, 1)
assert missing(wp07_iadt_confidence) | inrange(wp07_iadt_confidence, 0, 1)
quietly count if !missing(wp07_iadt_app, wp07_iadt_transfer, wp07_iadt_confidence)
local component_n = r(N)
quietly count if !missing(wp07_iadt3)
local summary_n = r(N)
display as text "wp07_iadt3 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iadt3) & !missing(wp07_iadt_app, wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iadt3) & missing(wp07_iadt_app, wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iadt3, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_icdp2
* Both valid applicable OTP/PIN components; unfamiliarity/nonuse not zero
confirm numeric variable wp07_icdp2 wp07_icdp_otp wp07_icdp_pin, exact
assert missing(wp07_icdp2) | inrange(wp07_icdp2, 0, 1)
assert missing(wp07_icdp_otp) | inrange(wp07_icdp_otp, 0, 1)
assert missing(wp07_icdp_pin) | inrange(wp07_icdp_pin, 0, 1)
quietly count if !missing(wp07_icdp_otp, wp07_icdp_pin)
local component_n = r(N)
quietly count if !missing(wp07_icdp2)
local summary_n = r(N)
display as text "wp07_icdp2 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_icdp2) & !missing(wp07_icdp_otp, wp07_icdp_pin)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_icdp2) & missing(wp07_icdp_otp, wp07_icdp_pin)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_icdp2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iaff2
* Two specific administrative conditions, not comprehensive formal inclusion
confirm numeric variable wp07_iaff2 wp07_iaff_address wp07_iaff_phone, exact
assert missing(wp07_iaff2) | inrange(wp07_iaff2, 0, 1)
assert missing(wp07_iaff_address) | inrange(wp07_iaff_address, 0, 1)
assert missing(wp07_iaff_phone) | inrange(wp07_iaff_phone, 0, 1)
quietly count if !missing(wp07_iaff_address, wp07_iaff_phone)
local component_n = r(N)
quietly count if !missing(wp07_iaff2)
local summary_n = r(N)
display as text "wp07_iaff2 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iaff2) & !missing(wp07_iaff_address, wp07_iaff_phone)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iaff2) & missing(wp07_iaff_address, wp07_iaff_phone)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iaff2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iuof3
* Accepted 1/.75/.5/.25/0 frequency map with fixed components
confirm numeric variable wp07_iuof3 wp07_iuof_frequency wp07_iuof_merchant wp07_iuof_saving, exact
assert missing(wp07_iuof3) | inrange(wp07_iuof3, 0, 1)
assert missing(wp07_iuof_frequency) | inrange(wp07_iuof_frequency, 0, 1)
assert missing(wp07_iuof_merchant) | inrange(wp07_iuof_merchant, 0, 1)
assert missing(wp07_iuof_saving) | inrange(wp07_iuof_saving, 0, 1)
quietly count if !missing(wp07_iuof_frequency, wp07_iuof_merchant, wp07_iuof_saving)
local component_n = r(N)
quietly count if !missing(wp07_iuof3)
local summary_n = r(N)
display as text "wp07_iuof3 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iuof3) & !missing(wp07_iuof_frequency, wp07_iuof_merchant, wp07_iuof_saving)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iuof3) & missing(wp07_iuof_frequency, wp07_iuof_merchant, wp07_iuof_saving)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iuof3, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iuof3_oldmap
* Declared historical frequency-spacing sensitivity, not automatic replacement
confirm numeric variable wp07_iuof3_oldmap wp07_iuof_frequency_oldmap wp07_iuof_merchant wp07_iuof_saving, exact
assert missing(wp07_iuof3_oldmap) | inrange(wp07_iuof3_oldmap, 0, 1)
assert missing(wp07_iuof_frequency_oldmap) | inrange(wp07_iuof_frequency_oldmap, 0, 1)
assert missing(wp07_iuof_merchant) | inrange(wp07_iuof_merchant, 0, 1)
assert missing(wp07_iuof_saving) | inrange(wp07_iuof_saving, 0, 1)
quietly count if !missing(wp07_iuof_frequency_oldmap, wp07_iuof_merchant, wp07_iuof_saving)
local component_n = r(N)
quietly count if !missing(wp07_iuof3_oldmap)
local summary_n = r(N)
display as text "wp07_iuof3_oldmap complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iuof3_oldmap) & !missing(wp07_iuof_frequency_oldmap, wp07_iuof_merchant, wp07_iuof_saving)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iuof3_oldmap) & missing(wp07_iuof_frequency_oldmap, wp07_iuof_merchant, wp07_iuof_saving)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iuof3_oldmap, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iuof2_no_frequency
* Frequency-omission definition, not available-item fallback
confirm numeric variable wp07_iuof2_no_frequency wp07_iuof_merchant wp07_iuof_saving, exact
assert missing(wp07_iuof2_no_frequency) | inrange(wp07_iuof2_no_frequency, 0, 1)
assert missing(wp07_iuof_merchant) | inrange(wp07_iuof_merchant, 0, 1)
assert missing(wp07_iuof_saving) | inrange(wp07_iuof_saving, 0, 1)
quietly count if !missing(wp07_iuof_merchant, wp07_iuof_saving)
local component_n = r(N)
quietly count if !missing(wp07_iuof2_no_frequency)
local summary_n = r(N)
display as text "wp07_iuof2_no_frequency complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iuof2_no_frequency) & !missing(wp07_iuof_merchant, wp07_iuof_saving)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iuof2_no_frequency) & missing(wp07_iuof_merchant, wp07_iuof_saving)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iuof2_no_frequency, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_oqi2
* Registration ease and offered initial support; activation separate
confirm numeric variable wp07_oqi2 wp07_oqi_ease wp07_oqi_support, exact
assert missing(wp07_oqi2) | inrange(wp07_oqi2, 0, 1)
assert missing(wp07_oqi_ease) | inrange(wp07_oqi_ease, 0, 1)
assert missing(wp07_oqi_support) | inrange(wp07_oqi_support, 0, 1)
quietly count if !missing(wp07_oqi_ease, wp07_oqi_support)
local component_n = r(N)
quietly count if !missing(wp07_oqi2)
local summary_n = r(N)
display as text "wp07_oqi2 complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_oqi2) & !missing(wp07_oqi_ease, wp07_oqi_support)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_oqi2) & missing(wp07_oqi_ease, wp07_oqi_support)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_oqi2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_oqi2_oldmap
* Declared historical ease-spacing sensitivity
confirm numeric variable wp07_oqi2_oldmap wp07_oqi_ease_oldmap wp07_oqi_support, exact
assert missing(wp07_oqi2_oldmap) | inrange(wp07_oqi2_oldmap, 0, 1)
assert missing(wp07_oqi_ease_oldmap) | inrange(wp07_oqi_ease_oldmap, 0, 1)
assert missing(wp07_oqi_support) | inrange(wp07_oqi_support, 0, 1)
quietly count if !missing(wp07_oqi_ease_oldmap, wp07_oqi_support)
local component_n = r(N)
quietly count if !missing(wp07_oqi2_oldmap)
local summary_n = r(N)
display as text "wp07_oqi2_oldmap complete components / nonmissing summary / admitted: " as result `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_oqi2_oldmap) & !missing(wp07_oqi_ease_oldmap, wp07_oqi_support)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_oqi2_oldmap) & missing(wp07_oqi_ease_oldmap, wp07_oqi_support)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_oqi2_oldmap, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* COMMON_SAMPLE IADT_TWO_VS_THREE: Definition and applicability comparison, not simple rescaling
quietly count if !missing(wp07_iadt2, wp07_iadt3)
local common_n = r(N)
display as text "IADT_TWO_VS_THREE common nonmissing N / admitted: " as result `common_n' " / " `admitted_n'
if `common_n' > 0 {
    tabstat wp07_iadt2 wp07_iadt3 if !missing(wp07_iadt2, wp07_iadt3), ///
        statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}

* COMMON_SAMPLE IUOF_FREQUENCY_DEFINITIONS: Compare all three on their common observations; retain broader own-N reports above
quietly count if !missing(wp07_iuof3, wp07_iuof3_oldmap, wp07_iuof2_no_frequency)
local common_n = r(N)
display as text "IUOF_FREQUENCY_DEFINITIONS common nonmissing N / admitted: " as result `common_n' " / " `admitted_n'
if `common_n' > 0 {
    tabstat wp07_iuof3 wp07_iuof3_oldmap wp07_iuof2_no_frequency if !missing(wp07_iuof3, wp07_iuof3_oldmap, wp07_iuof2_no_frequency), ///
        statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}

* COMMON_SAMPLE OQI_EASE_SPACING: Declared ease-spacing definitions on the same nonmissing observations
quietly count if !missing(wp07_oqi2, wp07_oqi2_oldmap)
local common_n = r(N)
display as text "OQI_EASE_SPACING common nonmissing N / admitted: " as result `common_n' " / " `admitted_n'
if `common_n' > 0 {
    tabstat wp07_oqi2 wp07_oqi2_oldmap if !missing(wp07_oqi2, wp07_oqi2_oldmap), ///
        statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}

* The two accepted primary binary contrasts retain separate valid-answer denominators.
confirm numeric variable wp07_remit_disposition wp07_remit_any_digital wp07_domestic_60d wp07_domestic_ops_bin, exact
assert missing(wp07_remit_disposition) | inlist(wp07_remit_disposition, 1, 2, 3, 4, 5)
assert missing(wp07_remit_any_digital) | inlist(wp07_remit_any_digital, 0, 1)
assert missing(wp07_domestic_60d) | inlist(wp07_domestic_60d, 0, 1)
assert missing(wp07_domestic_ops_bin) | inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5, 98)
* Prepared-field reports consume their own nonmissing values, without claiming route validation.
quietly count if !missing(wp07_remit_disposition)
local remit_n = r(N)
quietly count if !missing(wp07_remit_any_digital)
local remit_binary_n = r(N)
quietly count if !missing(wp07_domestic_60d)
local domestic_n = r(N)
display as text "Remittance categories / binary / domestic binary / admitted: " as result `remit_n' " / " `remit_binary_n' " / " `domestic_n' " / " `admitted_n'
if `remit_n' > 0 {
    tabulate wp07_remit_disposition, nolabel
}
if `remit_binary_n' > 0 {
    tabulate wp07_remit_any_digital, nolabel
}
if `domestic_n' > 0 {
    tabulate wp07_domestic_60d, nolabel
}
* Bin uncertainty is a valid recorded category, but not a substantive operation bin.
quietly count if wp07_domestic_60d == 1
local users_n = r(N)
quietly count if wp07_domestic_60d == 1 & inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5)
local bins_n = r(N)
quietly count if wp07_domestic_60d == 1 & wp07_domestic_ops_bin == 98
local unknown_bins_n = r(N)
quietly count if wp07_domestic_60d == 1 & missing(wp07_domestic_ops_bin)
local missing_bins_n = r(N)
display as text "Affirmative users / valid bins / uncertainty / nonresponse: " as result `users_n' " / " `bins_n' " / " `unknown_bins_n' " / " `missing_bins_n'
forvalues category = 1/5 {
    quietly count if wp07_domestic_60d == 1 & wp07_domestic_ops_bin == `category'
    local category_n = r(N)
    display as text "Operation bin " `category' " N: " as result `category_n'
    if `bins_n' > 0 {
        display as text "Percent valid operation bins: " as result 100 * `category_n' / `bins_n'
    }
}
* No change to scores, labels, rows, historical outputs or Appendix C2.
* END EMPTY_PREPARED_REPORT
assert _N == 0
assert `summary_n' == 0
assert `common_n' == 0
assert `domestic_n' == 0
assert `users_n' == 0
assert `bins_n' == 0
