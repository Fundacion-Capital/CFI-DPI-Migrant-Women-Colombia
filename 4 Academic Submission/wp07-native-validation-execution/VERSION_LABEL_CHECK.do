/* Artificial reporting-only verification of exact form-version labels. */
version 16
args repository artificial_run
if "`repository'" == "" | "`artificial_run'" == "" {
    exit 198
}
if c(k) > 0 | c(N) > 0 {
    exit 4
}
confirm new file "`artificial_run'/version_label_check.log"
confirm new file "`artificial_run'/analysis_exact_version_labels.do"
log using "`artificial_run'/version_label_check.log", text name(e_version)
capture noisily {
    tempname src dst
    file open `src' using "`repository'/1 Code/academic/2 Analysis.do", read text
    file open `dst' using "`artificial_run'/analysis_exact_version_labels.do", write text
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
    use "`artificial_run'/prepared_artificial.dta", clear
    assert _N == 32
    assert case_id == _n
    include "`artificial_run'/analysis_exact_version_labels.do"
    assert _N == 32
    assert case_id == _n
}
local check_rc = _rc
capture log close e_version
local log_rc = _rc
if `check_rc' != 0 {
    exit `check_rc'
}
if `log_rc' != 0 {
    exit `log_rc'
}
clear
