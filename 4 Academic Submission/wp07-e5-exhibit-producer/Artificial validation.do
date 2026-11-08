* Artificial E.5 reporting cases only; no study observations or fitted models.
* Use only the source-exact staged producer and fresh private case directories.
* Run one named case per separately authorized Stata MCP selection, no retries.
* Args: producer-body path, base fixture path, case-input path, output path, case.
* All copied or mutated records are the declared artificial aggregates.
* Source-only candidate: this caller has not been executed in Stata.
exit 198

* BEGIN E5 ARTIFICIAL CALLER
args producer fixture case_input output case
version 16
set varabbrev off
assert _N == 0 & c(k) == 0
assert "`producer'" != "" & "`fixture'" != "" & "`case_input'" != "" & "`output'" != ""
assert inlist("`case'", "complete", "reordered", "duplicate_probability", "missing_probability", "wrong_units", "numeric_alias") | ///
    inlist("`case'", "wrong_endpoint", "invalid_model", "reference_variance", "missing_covariance", "output_collision", "invalid_support")
assert lower("`fixture'") != lower("`case_input'")
assert lower("`case_input'") != lower("`output'")
confirm file "`producer'"

* Copy only the five artificial ledgers; a pre-existing case input is an error.
foreach filename in e4_model_status.csv e4_probabilities.csv e4_primary_tests.csv ///
    e4_native_matrices.csv e4_support.csv {
    confirm new file "`case_input'/`filename'"
    copy "`fixture'/`filename'" "`case_input'/`filename'"
}
if "`case'" == "reordered" {
    foreach filename in e4_model_status.csv e4_probabilities.csv e4_primary_tests.csv ///
        e4_native_matrices.csv e4_support.csv {
        import delimited "`case_input'/`filename'", varnames(1) stringcols(_all) clear
        gen long reverse_order = -_n
        sort reverse_order
        drop reverse_order
        export delimited using "`case_input'/`filename'", replace
    }
}
if inlist("`case'", "duplicate_probability", "missing_probability", "wrong_units", "wrong_endpoint") {
    import delimited "`case_input'/e4_probabilities.csv", varnames(1) stringcols(_all) clear
    if "`case'" == "duplicate_probability" {
        expand 2 in 1
    }
    if "`case'" == "missing_probability" {
        drop if model == "R0_E4" & focal == "wp07_iat3" & record == "higher"
    }
    if "`case'" == "wrong_units" {
        replace units = "probability" if model == "R0_E4" & focal == "wp07_iat3" & record == "higher_minus_lower"
    }
    if "`case'" == "wrong_endpoint" {
        replace endpoint = "1" if model == "R0_E4" & focal == "wp07_iat3" & record == "higher"
    }
    export delimited using "`case_input'/e4_probabilities.csv", replace
}
if "`case'" == "invalid_model" {
    import delimited "`case_input'/e4_model_status.csv", varnames(1) stringcols(_all) clear
    replace status = "POSTFIT_REVIEW_BLOCKED" in 1
    export delimited using "`case_input'/e4_model_status.csv", replace
}
if inlist("`case'", "reference_variance", "missing_covariance", "numeric_alias") {
    import delimited "`case_input'/e4_native_matrices.csv", varnames(1) stringcols(_all) clear
    if "`case'" == "reference_variance" {
        replace value = ".04" if operation == "fit" & matrix == "e4_V" & row == column & strpos(column_name, "b.") > 0
    }
    if "`case'" == "missing_covariance" {
        drop if model == "R0_E4" & operation == "fit" & matrix == "e4_V" & row == "1" & column == "1"
    }
    if "`case'" == "numeric_alias" {
        replace column = "01" if model == "R0_E4" & operation == "fit" & matrix == "e4_V" & row == "1" & column == "2"
        replace row = "01" if model == "R0_E4" & operation == "fit" & matrix == "e4_V" & column == "01"
    }
    export delimited using "`case_input'/e4_native_matrices.csv", replace
}
if "`case'" == "invalid_support" {
    import delimited "`case_input'/e4_support.csv", varnames(1) stringcols(_all) clear
    replace minimum = "" if model == "R0_E4" & check == "continuous" & field == "wp07_iat3"
    export delimited using "`case_input'/e4_support.csv", replace
}
if "`case'" == "output_collision" {
    tempname sentinel
    confirm new file "`output'/QT1_models.tex"
    file open `sentinel' using "`output'/QT1_models.tex", write text
    file write `sentinel' "ARTIFICIAL_SENTINEL_DO_NOT_OVERWRITE" _n
    file close `sentinel'
}
clear
assert _N == 0 & c(k) == 0
local expected_rc = 9
if inlist("`case'", "complete", "reordered") {
    local expected_rc = 0
}
if inlist("`case'", "duplicate_probability", "numeric_alias") {
    local expected_rc = 459
}
if "`case'" == "output_collision" {
    local expected_rc = 602
}
capture noisily do "`producer'" "`case_input'" "`output'"
local observed_rc = _rc
assert `observed_rc' == `expected_rc'
assert _N == 0 & c(k) == 0

* Failures must occur before output; an existing sentinel must survive unchanged.
foreach filename in QT1_models.tex QT1_models.csv QF1_core.pdf QF1_core.png ///
    QF1_core.csv QT2_primary.tex QT2_primary.csv QS1_comparisons.tex ///
    QS1_comparisons.csv QS2_endpoints.tex QS2_endpoints.csv ///
    QS3_coefficients.tex QS3_coefficients.csv QS3_covariance.csv ///
    QS3_support.csv CAPTIONS.txt e5_complete.csv {
    if `expected_rc' == 0 {
        confirm file "`output'/`filename'"
    }
    else if "`case'" == "output_collision" & "`filename'" == "QT1_models.tex" {
        tempname retained
        file open `retained' using "`output'/QT1_models.tex", read text
        file read `retained' sentinel_line
        file close `retained'
        assert "`sentinel_line'" == "ARTIFICIAL_SENTINEL_DO_NOT_OVERWRITE"
    }
    else {
        confirm new file "`output'/`filename'"
    }
}
display as text "E5_ARTIFICIAL_COMPLETE: case=`case' expected_rc=`expected_rc' observed_rc=`observed_rc' N=0 K=0"
* END E5 ARTIFICIAL CALLER
