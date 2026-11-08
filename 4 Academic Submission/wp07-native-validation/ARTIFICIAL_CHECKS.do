/*
Package E artificial-only checks. Authorised 8 November 2026; NOT YET RUN.
Dispatch through Stata MCP only, with an empty, dedicated session.
Arguments: repository and an existing local artificial-output parent.
The fixed child directory must not exist. No participant path is an argument.
*/
version 16
args repository artificial_parent
if "`repository'" == "" | "`artificial_parent'" == "" {
    exit 198
}
if c(k) > 0 | c(N) > 0 {
    exit 4
}
set more off
set varabbrev off
local run "`artificial_parent'/package-e-artificial"
mkdir "`run'"
log using "`run'/artificial.log", text name(e_artificial)

capture noisily {
    * Copy source bodies, not formulas. The only omitted line is each entry hold.
    * macval preserves the source's local macros rather than expanding them here.
    local source_master "0 Master.do"
    local source_prep "1 Data preparation.do"
    local source_analysis "2 Analysis.do"
    foreach stage in master prep analysis {
        tempname src dst
        file open `src' using "`repository'/1 Code/academic/`source_`stage''", read text
        file open `dst' using "`run'/`stage'_body.do", write text
        local line_number = 0
        file read `src' line
        while r(eof) == 0 {
            local ++line_number
            if `line_number' == 7 {
                if `"`macval(line)'"' != "exit 198" {
                    exit 459
                }
            }
            else {
                file write `dst' `"`macval(line)'"' _n
            }
            file read `src' line
        }
        file close `src'
        file close `dst'
        if `line_number' <= 7 {
            exit 459
        }
    }

    * Read-only source selection for the association edge cases below.
    tempname src dst
    file open `src' using "`repository'/1 Code/academic/2 Analysis.do", read text
    file open `dst' using "`run'/association_body.do", write text
    local in_association = 0
    local starts = 0
    local ends = 0
    file read `src' line
    while r(eof) == 0 {
        if strpos(`"`macval(line)'"', "* ASSOCIATION COMPARISON:") == 1 {
            local in_association = 1
            local ++starts
        }
        if strpos(`"`macval(line)'"', "* REGRESSION SPECIFICATIONS") == 1 {
            local in_association = 0
            local ++ends
        }
        if `in_association' {
            file write `dst' `"`macval(line)'"' _n
        }
        file read `src' line
    }
    file close `src'
    file close `dst'
    if `starts' != 1 | `ends' != 1 {
        exit 459
    }

    * Thirty-two invented cases; double prevents rounded ten-digit form versions.
    set obs 32
    gen byte case_id = _n
    local numeric formdef_version eligible_flag consent q1 q5 q3 q3_1 q3_5 q3_6 ///
        q3_7 q3_8 q3_12 q2_1 q2_2 q2_3 q4 q3_15 q3_16 q3_17 q3_20 q3_21 ///
        q3_22 q3_23 q4_5 q4_6 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 q4_26 ///
        q4_27 q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 q6_13 q6_14 ///
        q6_15 q6_6 q6_9 q6_11 q6_16 q6_17 q6_18 q6_20 q6_21 q6_22 q6_23 ///
        q6_24 q7_1 q7_2 q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 q7_11 q7_12 q7_13 ///
        q7_14 q7_15 q9_4 q9_5 q9_6 q9_7 q9_8 q9_9 q9_11 q9_13 q9_16 q9_18 ///
        q9_19 q9_20 q9_1 q9_15 q9_22 q10_4 q10_6 q10_10 q10_11 q10_12 ///
        q10_13 q10_14 q10_16 q10_1
    local strings q4_1 q4_12 q5_13 q9_17 q9_21 q10_2
    foreach field of local numeric {
        gen double `field' = 1
    }
    foreach field of local strings {
        gen str24 `field' = "1"
    }
    replace formdef_version = 2602120658
    replace q2_1 = 2019
    replace q2_2 = 5
    replace q2_3 = 3
    replace q4 = 40
    replace q3_8 = 2
    replace q3_15 = 4
    replace q3_16 = 3
    replace q3_17 = 5
    replace q3_21 = 2
    replace q4_15 = 2
    replace q4_24 = 2
    replace q4_25 = 3
    replace q5_14 = 2
    replace q5_23 = 2
    replace q6_13 = 3
    replace q6_15 = 2
    replace q10_1 = 4
    replace q10_2 = "4"

    * V02: version-specific residence, not a pooled city-4 interpretation.
    replace formdef_version = 2512090157 in 2
    replace q3 = 4 in 2
    replace formdef_version = 2512111044 in 3
    replace q3 = 4 in 3
    replace q3 = 5 in 4
    replace formdef_version = 1111111111 in 5

    * V03: unknown parent, definitely closed blank, and out-of-route observation.
    replace eligible_flag = . in 6
    replace q3_5 = . in 6
    replace eligible_flag = 0 in 7/8
    replace q3_5 = . in 7

    * V04: valid, duplicate, empty and malformed account parents.
    replace q4_12 = "1 2" in 9
    replace q4_12 = "1 1" in 10
    replace q4_12 = "" in 11
    replace q4_12 = "x" in 12

    * V05: basic phone, no phone and unanswered smartphone app item.
    replace q3_1 = 2 in 13
    replace q3_15 = . in 13
    replace q3_1 = 3 in 14
    replace q3_15 = . in 14
    replace q3_16 = . in 14
    replace q3_8 = . in 14
    replace q3_15 = . in 15

    * V06-V07: item-specific sentinels and changing offered barrier options.
    replace q3_7 = 99 in 16
    replace formdef_version = 2512090157 in 17
    replace q10_2 = "1" in 17
    replace q3_21 = 4 in 18
    replace q10_2 = "4 98" in 19
    replace q10_2 = "4" in 20
    replace q3_15 = 1 in 20
    replace q10_2 = "1" in 21
    replace q10_2 = "13" in 22
    replace q9_4 = 98 in 23
    replace q9_5 = 98 in 23

    * V08-V10: incomplete components, omitted definitions and operation uncertainty.
    replace q6_15 = 98 in 24
    replace q6_15 = . in 25
    replace q6_15 = 77 in 26
    replace q6_14 = 0 in 27
    replace q6_15 = . in 27
    replace q3_17 = . in 28
    replace q4_15 = . in 29
    replace q5_14 = . in 30
    replace q3_8 = 99 in 31
    replace q3_5 = 77 in 32
    save "`run'/raw_artificial.dta"
    _datasignature `numeric' `strings'
    local raw_signature `"`r(datasignature)'"'
    if `"`raw_signature'"' == "" {
        exit 459
    }

    * V01: all delivered entry points stop, without changing these artificial rows.
    foreach stage in master prep analysis {
        capture noisily do "`repository'/1 Code/academic/`source_`stage''"
        local hold_rc = _rc
        assert `hold_rc' == 198
    }
    _datasignature `numeric' `strings'
    assert `"`r(datasignature)'"' == `"`raw_signature'"'
    display "V01 held entry points: PASS"

    * The candidate, not a duplicate implementation, constructs the prepared fields.
    include "`run'/prep_body.do"
    assert _N == 32
    assert case_id == _n
    _datasignature `numeric' `strings'
    assert `"`r(datasignature)'"' == `"`raw_signature'"'
    assert wp07_residence == 4 in 2
    assert wp07_residence == 5 in 3
    assert wp07_residence == 6 in 4
    assert missing(wp07_residence) in 5
    assert wp07_state_q3_5 == 6 in 6
    assert wp07_state_q3_5 == 2 in 7
    assert wp07_state_q3_5 == 6 in 8
    assert wp07_account_route == 1 in 9
    assert wp07_state_q4_12 == 6 in 10
    assert wp07_state_q4_12 == 4 in 11
    assert wp07_state_q4_12 == 6 in 12
    assert missing(wp07_account_route) in 10/12
    assert missing(wp07_iuof3) in 10/12
    assert wp07_state_q3_15 == 2 in 13/14
    assert wp07_state_q3_16 == 1 in 13
    assert wp07_state_q3_16 == 2 in 14
    assert missing(wp07_iadt3) in 13/15
    assert missing(wp07_iadt2) in 14
    assert missing(wp07_iat3) in 14
    assert abs(wp07_iadt2 - .75) < 1e-12 in 13
    assert wp07_state_q3_7 == 5 in 16
    assert wp07_state_q10_2 == 6 in 17
    assert wp07_state_q3_21 == 5 in 18
    assert missing(wp07_icdp2) in 18
    assert wp07_state_q10_2 == 6 in 19
    assert wp07_state_q10_1 == 1 in 20
    assert wp07_state_q10_2 == 1 in 20/21
    assert wp07_state_q10_2 == 6 in 22
    * 98 is not offered for q9_4; it is an explicit sentinel for q9_5.
    assert wp07_state_q9_4 == 6 in 23
    assert wp07_state_q9_5 == 5 in 23
    display "V02-V07 classifications: PASS; whole-item unavailable state not claimed"

    * Independent, hand-derived expectations for case 1, not copied calculations.
    assert abs(wp07_ivs_educ - 5/9) < 1e-12 in 1
    assert abs(wp07_iat3 - 5/6) < 1e-12 in 1
    assert abs(wp07_iadt2 - .75) < 1e-12 in 1
    assert abs(wp07_iadt3 - .75) < 1e-12 in 1
    assert abs(wp07_iadt2 - .75) < 1e-12 in 20
    assert abs(wp07_iadt3 - .5) < 1e-12 in 20
    assert abs(wp07_icdp2 - .75) < 1e-12 in 1
    assert wp07_iaff2 == 1 in 1
    assert abs(wp07_iuof3 - 5/12) < 1e-12 in 1
    assert abs(wp07_iuof3_oldmap - 13/30) < 1e-12 in 1
    assert abs(wp07_iuof2_no_frequency - .25) < 1e-12 in 1
    assert abs(wp07_oqi2 - 7/12) < 1e-12 in 1
    assert abs(wp07_oqi2_oldmap - 5/8) < 1e-12 in 1
    foreach score in wp07_ivs_educ wp07_iat3 wp07_iadt2 wp07_iadt3 wp07_icdp2 ///
        wp07_iaff2 wp07_iuof3 wp07_iuof3_oldmap wp07_iuof2_no_frequency ///
        wp07_oqi2 wp07_oqi2_oldmap {
        local storage : type `score'
        assert "`storage'" == "double"
    }
    assert missing(wp07_iadt2) & missing(wp07_iadt3) in 28
    assert missing(wp07_iuof3) & missing(wp07_iuof3_oldmap) in 29
    assert abs(wp07_iuof2_no_frequency - .25) < 1e-12 in 29
    assert missing(wp07_oqi2) & missing(wp07_oqi2_oldmap) in 30
    assert missing(wp07_iat3) in 31/32
    assert wp07_state_q6_15 == 5 & wp07_domestic_ops_bin == 98 in 24
    assert wp07_state_q6_15 == 4 & missing(wp07_domestic_ops_bin) in 25
    assert wp07_state_q6_15 == 6 & missing(wp07_domestic_ops_bin) in 26
    assert wp07_state_q6_15 == 2 & missing(wp07_domestic_ops_bin) in 27
    assert wp07_remit_disposition == 3 & wp07_remit_any_digital == 1 in 1
    assert wp07_domestic_60d == 1 & wp07_domestic_ops_bin == 2 in 1
    display "V08-V10 fixed arithmetic and distinct outcomes: PASS"

    * Reconcile six-state partitions for every one of the 93 prepared items.
    ds wp07_state_*
    local states `r(varlist)'
    local state_count : word count `states'
    assert `state_count' == 93
    foreach statevar of local states {
        local partition_n = 0
        forvalues state = 1/6 {
            quietly count if `statevar' == `state'
            local partition_n = `partition_n' + r(N)
        }
        assert `partition_n' == 32
    }
    save "`run'/prepared_artificial.dta"
    include "`run'/analysis_body.do"
    assert _N == 32
    assert case_id == _n
    _datasignature `numeric' `strings'
    assert `"`r(datasignature)'"' == `"`raw_signature'"'
    display "V11 full reporting and raw continuity: PASS; review denominator log"

    * V11 empty ordinary/recorded bases: stress reporting, not a claimed raw route.
    foreach statevar of local states {
        replace `statevar' = 6
    }
    include "`run'/analysis_body.do"
    display "V11 empty-base reporting: PASS; review unavailable/zero output"

    * V12-V13: same exact association block, with own/common N and constants.
    clear
    input double(wp07_iat3 wp07_iadt2 wp07_iadt3)
    0    0    .5
    .5   .5   .5
    1    1    .5
    .75  .25  .
    end
    include "`run'/association_body.do"
    assert `common_n' == 3
    assert `pair_n' == 3
    assert `common_iat_varies' == 1
    assert `iadt2_varies' == 1 & `iadt3_varies' == 0
    display "V12-V13 common N 3; IAT/IADT2 common correlation must be 1"
    display "V13 IAT/IADT3 and between-definition coefficients must be unavailable"
    replace wp07_iadt3 = wp07_iadt2
    replace wp07_iadt3 = . in 4
    include "`run'/association_body.do"
    assert r(N) == 3
    assert abs(r(rho) - 1) < 1e-12
    replace wp07_iat3 = 1
    include "`run'/association_body.do"
    assert `common_iat_varies' == 0
    assert r(N) == 3
    assert abs(r(rho) - 1) < 1e-12
    replace wp07_iadt2 = . in 2/4
    replace wp07_iadt3 = . in 2/4
    include "`run'/association_body.do"
    assert `common_n' == 1
    replace wp07_iadt2 = . in 1
    replace wp07_iadt3 = . in 1
    include "`run'/association_body.do"
    assert `common_n' == 0
    display "V12-V13 N/variation assertions: PASS; review emitted coefficients"

    * V14: exact preparation body must reject a wrong type and an absent input.
    use "`run'/raw_artificial.dta", clear
    drop q3_1
    gen str1 q3_1 = "1"
    capture noisily do "`run'/prep_body.do"
    local type_rc = _rc
    assert `type_rc' != 0
    confirm new variable wp07_known_form
    drop q3_1
    capture noisily do "`run'/prep_body.do"
    local missing_rc = _rc
    assert `missing_rc' != 0
    confirm new variable wp07_known_form
    capture noisily do "`run'/master_body.do" "" "" ""
    local args_rc = _rc
    assert `args_rc' == 198
    display "V14 type, missing field and missing arguments: PASS"

    * Remaining V14 filesystem/log branches require the distinct control selection.
    * Do not label V14 complete from these three assertions alone.
}
local check_rc = _rc
capture log close e_artificial
local log_rc = _rc
if `check_rc' != 0 {
    exit `check_rc'
}
if `log_rc' != 0 {
    exit `log_rc'
}
clear
* Preserve the artificial data, body copies and complete log, including a failed run.
* No success marker here substitutes for the case-by-case receipt review.
