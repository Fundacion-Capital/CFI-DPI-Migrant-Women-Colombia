* Disabled capture for the historical Appendix C2 matrix only.
* Input must be the separately admitted 15-field, 423-row projection in memory.
exit 198

local indices "ivs_score iat_score iadt_score icdp_score iaff_score iuof_score_01 oqi_score_01 iurd_score_01 ietr_score_01 IPCS IEDF IAER ICPF IEH IBPD"
confirm numeric variable `indices', exact
if c(N) != 423 | c(k) != 15 {
    error 459
}
quietly datasignature
local before "`r(datasignature)'"

* Same unweighted, listwise command as the historical appendix.
tempname corr
quietly correlate `indices'
local complete_n = r(N)
matrix `corr' = r(C)

* Independently count the rows with all 15 recorded scores.
quietly count if !missing(ivs_score, iat_score, iadt_score, icdp_score, iaff_score, ///
    iuof_score_01, oqi_score_01, iurd_score_01, ietr_score_01, IPCS, IEDF, IAER, ICPF, IEH, IBPD)
local check_n = r(N)
assert `complete_n' == `check_n' & inrange(`complete_n', 2, 423)
local row_axis : rownames `corr'
local col_axis : colnames `corr'
assert rowsof(`corr') == 15 & colsof(`corr') == 15
assert "`row_axis'" == "`indices'" & "`col_axis'" == "`indices'"

* Each short receipt line contains one exact, big-endian binary64 cell.
display "C2|BEGIN|WP07_C2_V1"
display "C2|N|423|" `complete_n' "|" `check_n'
forvalues i = 1/15 {
    local row_name : word `i' of `row_axis'
    local col_name : word `i' of `col_axis'
    display "C2|AXIS|" `i' "|`row_name'|`col_name'"
}
forvalues i = 1/15 {
    forvalues j = 1/15 {
        display "C2|CELL|" `i' "|" `j' "|" %16H `corr'[`i',`j']
    }
}
quietly datasignature
assert "`before'" == "`r(datasignature)'"
display "C2|END|225"
