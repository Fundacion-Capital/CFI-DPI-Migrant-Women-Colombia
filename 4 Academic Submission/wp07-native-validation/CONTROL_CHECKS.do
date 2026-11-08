/*
Package E V14 artificial filesystem/control checks. NOT YET RUN.
Run only after the first selection passes and its body copies are verified.
Arguments: repository and the exact artificial run directory created there.
No participant path is accepted or substituted for the artificial archive.
*/
version 16
args repository artificial_run
if "`repository'" == "" | "`artificial_run'" == "" {
    exit 198
}
if c(k) > 0 | c(N) > 0 {
    exit 4
}
confirm file "`artificial_run'/raw_artificial.dta"
confirm file "`artificial_run'/master_body.do"
local control "`artificial_run'/controls"
mkdir "`control'"
log using "`control'/control.log", text name(e_control)

capture noisily {
    * The master's exact relative filename, under a NEW artificial archive only.
    local archive32 "`control'/archive32"
    local archive423 "`control'/archive423"
    foreach archive in archive32 archive423 {
        mkdir "``archive''"
        mkdir "``archive''/7132afe058718e790305f51e78a215b383d22009"
        mkdir "``archive''/7132afe058718e790305f51e78a215b383d22009/2 Output"
    }
    use "`artificial_run'/raw_artificial.dta", clear
    save "`archive32'/7132afe058718e790305f51e78a215b383d22009/2 Output/CFI_DPI Data for analysis.dta"
    set obs 423
    save "`archive423'/7132afe058718e790305f51e78a215b383d22009/2 Output/CFI_DPI Data for analysis.dta"
    clear
    mkdir "`control'/memory"
    mkdir "`control'/wrong_n"
    mkdir "`control'/held_callee"
    mkdir "`control'/existing_prepared"

    capture noisily do "`artificial_run'/master_body.do" ///
        "`repository'" "`control'/archive_missing" "`control'/memory"
    local path_rc = _rc
    if `path_rc' != 601 | c(N) != 0 | c(k) != 0 {
        exit 459
    }

    * Nonempty memory must survive unchanged, including observations with no variables.
    set obs 1
    gen byte guard = 73
    capture noisily do "`artificial_run'/master_body.do" ///
        "`repository'" "`archive423'" "`control'/memory"
    local memory_rc = _rc
    if `memory_rc' != 4 | c(N) != 1 | c(k) != 1 {
        exit 459
    }
    assert guard == 73
    clear
    set obs 1
    capture noisily do "`artificial_run'/master_body.do" ///
        "`repository'" "`archive423'" "`control'/memory"
    local emptyvars_rc = _rc
    if `emptyvars_rc' != 4 | c(N) != 1 | c(k) != 0 {
        exit 459
    }
    clear
    confirm new file "`control'/memory/academic_review.log"

    * Wrong row count fails after its synthetic load; named log must close.
    capture noisily do "`artificial_run'/master_body.do" ///
        "`repository'" "`archive32'" "`control'/wrong_n"
    local n_rc = _rc
    if `n_rc' != 459 | c(N) != 32 {
        exit 459
    }
    confirm file "`control'/wrong_n/academic_review.log"
    capture log close academic_review
    local wrong_n_log_rc = _rc
    if `wrong_n_log_rc' == 0 {
        exit 459
    }
    confirm new file "`control'/wrong_n/academic_prepared.dta"
    clear

    * The REAL held preparation callee stops after the synthetic 423-row load.
    capture noisily do "`artificial_run'/master_body.do" ///
        "`repository'" "`archive423'" "`control'/held_callee"
    local callee_rc = _rc
    if `callee_rc' != 198 | c(N) != 423 {
        exit 459
    }
    confirm file "`control'/held_callee/academic_review.log"
    capture log close academic_review
    local callee_log_rc = _rc
    if `callee_log_rc' == 0 {
        exit 459
    }
    confirm new file "`control'/held_callee/academic_prepared.dta"
    clear

    * A pre-existing log stops before another data load or overwrite.
    capture noisily do "`artificial_run'/master_body.do" ///
        "`repository'" "`archive423'" "`control'/held_callee"
    local existing_log_rc = _rc
    if `existing_log_rc' != 602 | c(N) != 0 | c(k) != 0 {
        exit 459
    }

    * A pre-existing prepared file also stops before loading; retain its exact text.
    tempname marker
    file open `marker' using "`control'/existing_prepared/academic_prepared.dta", write text
    file write `marker' "PRESERVE_ARTIFICIAL_MARKER" _n
    file close `marker'
    capture noisily do "`artificial_run'/master_body.do" ///
        "`repository'" "`archive423'" "`control'/existing_prepared"
    local existing_data_rc = _rc
    if `existing_data_rc' != 602 | c(N) != 0 | c(k) != 0 {
        exit 459
    }
    file open `marker' using "`control'/existing_prepared/academic_prepared.dta", read text
    file read `marker' marker_text
    file close `marker'
    if "`marker_text'" != "PRESERVE_ARTIFICIAL_MARKER" {
        exit 459
    }
    confirm new file "`control'/existing_prepared/academic_review.log"

    * The caller's own e_control log must still be open at this final close.
    display "V14 memory, N, held callee, pre-existing outputs: PASS"
    * An actual disk-full/permission failure DURING save remains outside this fixture.
}
local check_rc = _rc
capture log close e_control
local log_rc = _rc
if `check_rc' != 0 {
    exit `check_rc'
}
if `log_rc' != 0 {
    exit `log_rc'
}
clear
