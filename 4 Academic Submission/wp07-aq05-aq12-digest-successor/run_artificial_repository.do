* Artificial-only caller. Never supply a participant file or path.
version 16
set more off
set varabbrev off
args case
if !regexm("`case'", "^aq(0[1-9]|1[0-2])$") {
    error 198
}
local root "C:/Users/jzava/Documents/GitHub/CFI-DPI-Migrant-Women-Colombia/4 Academic Submission/audit-local/intake/wp07-aq-repo-aq05-c1d0148"
local dir "`root'/`case'"
local here = lower(subinstr(c(pwd), char(92), "/", .))
if "`here'" != lower("`dir'") | _N != 0 | c(k) != 0 {
    error 459
}
local phase admission
tempname reopened testlog
local has_reopen 0
local has_testlog 0
local before = c(frame)

capture quietly {
    local phase log
    if "`case'" == "aq09" {
        log using "`dir'/unexpected.log", text name(`testlog')
        local has_testlog 1
    }
    log query _all
    local logs = r(numlogs)
    local firstlog = lower(subinstr("`r(filename1)'", char(92), "/", .))
    if !inlist(`logs', 0, 1) {
        if "`case'" == "aq09" {
            noisily display "WP07_AQ09_ORDINARY_REJECT reason=count"
        }
        error 459
    }
    if `logs' == 1 & !regexm("`firstlog'", ///
        "^c:/users/jzava/appdata/local/temp/stata_run_cfi_wp07_rc1a_`case'_[a-z0-9_-]+[.]log$") {
        if "`case'" == "aq09" {
            noisily display "WP07_AQ09_ORDINARY_REJECT reason=path"
        }
        error 459
    }
    noisily cmdlog
    if `"`r(status)'"' != "" | `"`r(filename)'"' != "" {
        error 459
    }
    noisily display "WP07_AQ_CMDLOG_CLOSED case=`case' rc=0 status_blank=1 filename_absent=1"
    noisily display "WP07_AQ_RUNTIME case=`case' version=" c(stata_version) " user=" c(username) ///
        " temp=" c(tmpdir) " ordinary_logs=" `logs' " path=`firstlog'"

    local phase target
    capture confirm file "`dir'/candidate.dta"
    if _rc == 0 {
        error 459
    }
    confirm new file "`dir'/candidate.dta"

    local phase fixture
    do "`root'/fixture.do" "`case'"
    local phase input_n
    if _N == 0 {
        error 2000
    }
    if _N != 423 | c(k) != 98 {
        error 459
    }

    local phase prep
    local body "preparation.do"
    if inlist("`case'", "aq04", "aq05", "aq12") {
        local body "preparation-`case'.do"
    }
    do "`root'/`body'"
    if "`case'" == "aq10" {
        rename e4_education3 artificial_wrong_name
    }

    local phase schema
    do "`root'/check_schema.do"
    if _N != 423 {
        error 459
    }
    assert wp07_state_q6_15 == 1 in 1
    assert wp07_state_q6_15 == 5 in 2
    assert wp07_state_q6_15 == 4 in 3
    assert wp07_state_q6_15 == 6 in 4
    assert wp07_state_q6_15 == 2 in 5
    assert wp07_domestic_ops_bin == 3 in 1
    assert wp07_domestic_ops_bin == 98 in 2
    assert missing(wp07_domestic_ops_bin) in 3/5
    assert wp07_remit_any_digital == 0 in 1
    assert wp07_remit_any_digital == 1 in 2
    assert wp07_known_form == 0 in 6
    assert wp07_state_q6_14 == 6 in 6
    assert q4_1 == "1 2" in 1
    assert q4_1 == "" in 2
    assert q2_1 == .a in 1
    assert q2_1 == .z in 2

    local phase save
    save "`dir'/candidate.dta"
    noisily display "WP07_AQ_SAVE case=`case' N=" _N " K=" c(k)
    local phase reopen
    frame create `reopened'
    local has_reopen 1
    frame `reopened': use "`dir'/candidate.dta", clear
    frame `reopened': noisily display "WP07_AQ_REOPEN case=`case' N=" _N " K=" c(k)
    if "`case'" == "aq08" {
        frame `reopened': replace q4_1 = "1" in 1
    }
    if "`case'" == "aq11" {
        frame `reopened': label variable q4_1 "Artificial metadata mismatch"
    }

    local phase readback_schema
    unab expected : _all
    frame `reopened': unab actual : _all
    frame `reopened': count
    if r(N) != 423 | "`actual'" != "`expected'" {
        error 459
    }

    local phase readback_metadata
    frame `reopened': local dataset_after : data label
    frame `reopened': local note_after : char q6_14[note1]
    frame `reopened': local zero_after : label (q6_14) 0, strict
    frame `reopened': local one_after : label (q6_14) 1, strict
    if "`dataset_after'" != "Artificial WP07 fixture only" | ///
        "`note_after'" != "Artificial fixture note" | ///
        "`zero_after'" != "No" | "`one_after'" != "Yes" {
        error 459
    }
    foreach v of local expected {
        local phase readback_metadata
        local type_before : type `v'
        local label_before : variable label `v'
        local format_before : format `v'
        local vl_before : value label `v'
        frame `reopened': local type_after : type `v'
        frame `reopened': local label_after : variable label `v'
        frame `reopened': local format_after : format `v'
        frame `reopened': local vl_after : value label `v'
        if "`type_before'" != "`type_after'" | ///
            `"`label_before'"' != `"`label_after'"' | ///
            "`format_before'" != "`format_after'" | "`vl_before'" != "`vl_after'" {
            error 459
        }
        local phase readback_values
        frame `reopened': assert `v' == _frval(`before', `v', _n)
    }
    local phase complete
}

local run_rc = _rc
local cleanup_rc = 0
if `has_reopen' {
    capture frame drop `reopened'
    local cleanup_rc = _rc
}
if `has_testlog' {
    capture log close `testlog'
    if _rc != 0 {
        local cleanup_rc = _rc
    }
}
capture clear
if _rc != 0 {
    local cleanup_rc = _rc
}
display "WP07_AQ_INNER case=`case' phase=`phase' rc=`run_rc' cleanup=`cleanup_rc' N=" _N " K=" c(k)
if `cleanup_rc' != 0 {
    exit `cleanup_rc'
}
exit `run_rc'
