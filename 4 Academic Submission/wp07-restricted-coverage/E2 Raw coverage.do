/*
E.2 restricted raw coverage. Authorised 8 November 2026; no scores or fitting.
Exact source/hash, 102-field projection and protected output DACL are bound outside Stata.
Dispatch only through Stata MCP; never print respondent values.
*/
version 16
args carrier out
if "`carrier'" == "" | "`out'" == "" {
    exit 198
}
if c(k) > 0 | c(N) > 0 {
    exit 4
}
set more off
set varabbrev off
foreach filename in raw_scope.log cohort_version_coverage.csv item_route_state_coverage.csv ///
    clock_geography_checks.csv raw_stage_complete.txt {
    confirm new file "`out'/`filename'"
}
confirm file "`out'/raw_classification.do"
log using "`out'/raw_scope.log", text name(e2_raw)

capture quietly {
    use ///
        formdef_version eligible_flag consent q1 q5 q3 q3_1 q3_5 q3_6 q3_7 q3_8 q3_12 ///
        q2_1 q2_2 q2_3 q4 q3_15 q3_16 q3_17 q3_20 q3_21 q3_22 q3_23 q4_1 ///
        q4_5 q4_6 q4_12 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 q4_26 q4_27 q5_13 ///
        q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 q6_13 q6_14 q6_15 q6_6 ///
        q6_9 q6_11 q6_16 q6_17 q6_18 q6_20 q6_21 q6_22 q6_23 q6_24 q7_1 q7_2 ///
        q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 q7_11 q7_12 q7_13 q7_14 q7_15 q9_4 ///
        q9_5 q9_6 q9_7 q9_8 q9_9 q9_11 q9_13 q9_16 q9_18 q9_19 q9_20 q9_1 ///
        q9_15 q9_17 q9_21 q9_22 q10_4 q10_6 q10_10 q10_11 q10_12 q10_13 q10_14 q10_16 ///
        q10_1 q10_2 SubmissionDate starttime endtime fecha using "`carrier'", clear
    local admitted_n = _N
    if `admitted_n' != 423 {
        exit 459
    }
    confirm numeric variable SubmissionDate starttime endtime fecha, exact
    local raw_fields formdef_version eligible_flag consent q1 q5 q3 q3_1 q3_5 q3_6 q3_7 q3_8 q3_12 q2_1 q2_2 q2_3 q4 q3_15 q3_16 q3_17 q3_20 q3_21 q3_22 q3_23 q4_1 q4_5 q4_6 q4_12 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 q4_26 q4_27 q5_13 q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 q6_13 q6_14 q6_15 q6_6 q6_9 q6_11 q6_16 q6_17 q6_18 q6_20 q6_21 q6_22 q6_23 q6_24 q7_1 q7_2 q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 q7_11 q7_12 q7_13 q7_14 q7_15 q9_4 q9_5 q9_6 q9_7 q9_8 q9_9 q9_11 q9_13 q9_16 q9_18 q9_19 q9_20 q9_1 q9_15 q9_17 q9_21 q9_22 q10_4 q10_6 q10_10 q10_11 q10_12 q10_13 q10_14 q10_16 q10_1 q10_2 SubmissionDate starttime endtime fecha
    _datasignature `raw_fields'
    local raw_signature `"`r(datasignature)'"'
    if `"`raw_signature'"' == "" {
        exit 459
    }
    gen long _e2_row = _n

    * The pinned segment stops before every fixed-component candidate.
    include "`out'/raw_classification.do"
    confirm new variable wp07_iat3
    confirm new variable wp07_residence
    assert _N == `admitted_n'
    assert _e2_row == _n
    _datasignature `raw_fields'
    assert `"`r(datasignature)'"' == `"`raw_signature'"'

    * Historical cohort membership is preserved; screening counts never re-filter it.
    tempname cohort
    file open `cohort' using "`out'/cohort_version_coverage.csv", write text
    file write `cohort' "check_id,form_version,observed_n,admitted_n,status,limitation" _n
    file write `cohort' "admitted,ALL," (`admitted_n') "," (`admitted_n') ",observed,Not a response rate" _n
    foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
        count if formdef_version == `fv'
        file write `cohort' "form,`fv'," (r(N)) "," (`admitted_n') ",observed,Original submitted version" _n
    }
    count if wp07_known_form != 1
    file write `cohort' "unknown_form,ALL," (r(N)) "," (`admitted_n') ",observed,Retained not repaired" _n
    count if consent == 0 | consent == 98
    file write `cohort' "historical_consent_filter_disagreement,ALL," (r(N)) "," (`admitted_n') ",observed,No new exclusion" _n
    count if q1 == 2
    file write `cohort' "historical_gender_filter_disagreement,ALL," (r(N)) "," (`admitted_n') ",observed,Not a positive eligibility certificate" _n
    count if q5 == 0 | q5 == 98
    file write `cohort' "historical_remittance_filter_disagreement,ALL," (r(N)) "," (`admitted_n') ",observed,Household interpretation retained" _n
    count if eligible_flag != 1
    file write `cohort' "eligibility_flag_not_one,ALL," (r(N)) "," (`admitted_n') ",observed,Retained historical cohort" _n
    foreach field in consent q1 q5 eligible_flag {
        count if missing(`field')
        file write `cohort' "missing_`field',ALL," (r(N)) "," (`admitted_n') ",observed,No inferred compliance" _n
    }
    count if wp07_route_q4_13 == 1 & q4_13 == 5
    file write `cohort' "principal_none_on_positive_parent,ALL," (r(N)) "," (`admitted_n') ",semantic_review,No repair or exclusion" _n
    * Principal product may contradict the selected account parent; do not repair it.
    forvalues code = 1/4 {
        count if wp07_state_q4_13 == 1 & wp07_state_q4_12 == 1 & q4_13 == `code' & ///
            strpos(" " + itrim(strtrim(q4_12)) + " ", " `code' ") == 0
        file write `cohort' "principal_absent_from_parent_`code',ALL," (r(N)) "," (`admitted_n') ",semantic_review,No repair or exclusion" _n
    }
    count if inlist(formdef_version,2512091719,2512111044,2512121811,2602120658) & ///
        q10_1 == 16 & wp07_state_q10_2 == 1 & ///
        regexm(itrim(strtrim(q10_2)), "(^| )(1|2|3|4|5|6|7|8|9|10|11|12|14|15)( |$)")
    file write `cohort' "main_none_with_named_additional_barrier,ALL," (r(N)) "," ///
        (`admitted_n') ",semantic_review,No repair or exclusion" _n
    file close `cohort'

    * One ordinary loop applies the same coverage accounting to the 93 source items.
    tempname coverage
    file open `coverage' using "`out'/item_route_state_coverage.csv", write text
    file write `coverage' "field,scope,scope_n,applicable_n,closed_n,unknown_route_n,ordinary_n,structural_n,unavailable_n,nonresponse_n,sentinel_n,unresolved_n,recorded_n" _n
    local items q3_1 q3_5 q3_6 q3_7 q3_8 q3_12 q2_1 q2_2 q2_3 q4 q3 q3_15 q3_16 q3_17 q3_20 q3_21 q3_22 q3_23 q4_1 q4_5 q4_6 q4_12 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 q4_26 q4_27 q5_13 q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 q6_13 q6_14 q6_15 q6_6 q6_9 q6_11 q6_16 q6_17 q6_18 q6_20 q6_21 q6_22 q6_23 q6_24 q7_1 q7_2 q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 q7_11 q7_12 q7_13 q7_14 q7_15 q9_4 q9_5 q9_6 q9_7 q9_8 q9_9 q9_11 q9_13 q9_16 q9_18 q9_19 q9_20 q9_1 q9_15 q9_17 q9_21 q9_22 q10_4 q10_6 q10_10 q10_11 q10_12 q10_13 q10_14 q10_16 q10_1 q10_2
    foreach item of local items {
        foreach scope in ALL 2512090157 2512091719 2512111044 2512121811 2602120658 UNKNOWN {
            local base "1"
            if "`scope'" == "UNKNOWN" {
                local base "wp07_known_form != 1"
            }
            else if "`scope'" != "ALL" {
                local base "formdef_version == `scope'"
            }
            count if `base'
            local scope_n = r(N)
            count if (`base') & wp07_route_`item' == 1
            local applicable_n = r(N)
            count if (`base') & wp07_route_`item' == 0
            local closed_n = r(N)
            count if (`base') & !inlist(wp07_route_`item', 0, 1)
            local unknown_route_n = r(N)
            forvalues state = 1/6 {
                count if (`base') & wp07_state_`item' == `state'
                local n`state' = r(N)
            }
            if `n1' + `n2' + `n3' + `n4' + `n5' + `n6' != `scope_n' {
                exit 459
            }
            local recorded_n = `n1' + `n5'
            file write `coverage' "`item',`scope'," (`scope_n') "," (`applicable_n') "," ///
                (`closed_n') "," (`unknown_route_n') "," (`n1') "," (`n2') "," (`n3') "," ///
                (`n4') "," (`n5') "," (`n6') "," (`recorded_n') _n
        }
    }
    file close `coverage'

    * Preserve every clock; bounds are diagnostics, not a chosen reference calendar.
    tempname clocks
    file open `clocks' using "`out'/clock_geography_checks.csv", write text
    file write `clocks' "check_id,field,scope,observed_n,minimum,maximum,status,limitation" _n
    foreach clock in SubmissionDate starttime endtime fecha {
        local storage : type `clock'
        local clock_format : format `clock'
        summarize `clock', meanonly
        local clock_n = r(N)
        local lo = r(min)
        local hi = r(max)
        if "`clock'" == "fecha" {
            local first = string(`lo', "%tdCCYY-NN-DD")
            local last = string(`hi', "%tdCCYY-NN-DD")
            count if !missing(q2_1, `clock') & q2_1 > year(`clock')
        }
        else {
            local first = string(dofc(`lo'), "%tdCCYY-NN-DD")
            local last = string(dofc(`hi'), "%tdCCYY-NN-DD")
            count if !missing(q2_1, `clock') & q2_1 > year(dofc(`clock'))
        }
        local arrival_after_clock = r(N)
        file write `clocks' "clock_daily_bounds,`clock',ALL," (`clock_n') ",`first',`last',observed,Storage `storage' format `clock_format'; clock unchanged" _n
        file write `clocks' "arrival_after_clock_year,`clock',ALL," (`arrival_after_clock') ",,,indeterminate,No calendar source adopted" _n
    }
    count if !missing(starttime, endtime) & endtime < starttime
    file write `clocks' "end_before_start,starttime_endtime,ALL," (r(N)) ",,,observed,No timestamp repair" _n
    count if !missing(fecha, SubmissionDate) & fecha != dofc(SubmissionDate)
    file write `clocks' "daily_clock_disagreement,fecha_SubmissionDate,ALL," (r(N)) ",,,indeterminate,Historical discrepancy retained" _n
    gen double _e2_clock_gap_hours = (SubmissionDate - endtime) / 3600000 ///
        if !missing(SubmissionDate, endtime)
    summarize _e2_clock_gap_hours, meanonly
    file write `clocks' "submission_minus_end_hours,SubmissionDate_endtime,ALL," (r(N)) "," ///
        %24.17g (r(min)) "," %24.17g (r(max)) ",indeterminate,Export timezone history unavailable" _n
    foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
        forvalues category = 1/5 {
            count if formdef_version == `fv' & q3 == `category'
            file write `clocks' "raw_residence_code_`category',q3,`fv'," (r(N)) ",,,observed,Code4 meaning changes by version; code5 Meta only latest" _n
        }
        count if formdef_version == `fv' & missing(q3)
        file write `clocks' "missing_residence,q3,`fv'," (r(N)) ",,,observed,No inferred city" _n
        if `fv' != 2602120658 {
            count if formdef_version == `fv' & q3 == 5
            file write `clocks' "unoffered_residence_code5,q3,`fv'," (r(N)) ",,,semantic_review,Meta code not offered in this form" _n
        }
        count if formdef_version == `fv' & !missing(q3) & !inlist(q3, 1, 2, 3, 4, 5)
        file write `clocks' "unexpected_residence_code,q3,`fv'," (r(N)) ",,,semantic_review,No repair" _n
    }
    file close `clocks'
    _datasignature `raw_fields'
    assert `"`r(datasignature)'"' == `"`raw_signature'"'
    assert _e2_row == _n
    assert _N == `admitted_n'
}
local run_rc = _rc
capture log close e2_raw
local close_rc = _rc
clear
if `run_rc' != 0 {
    noisily display as error "E.2 stopped; preserve the restricted partial packet. Stata code: " `run_rc'
    exit `run_rc'
}
if `close_rc' != 0 {
    exit `close_rc'
}
tempname completed
file open `completed' using "`out'/raw_stage_complete.txt", write text
file write `completed' "E2_COMPLETE_NO_SCORING_NO_FIT" _n
file close `completed'
noisily display "E.2 completed. Detailed aggregates remain in the restricted packet."
