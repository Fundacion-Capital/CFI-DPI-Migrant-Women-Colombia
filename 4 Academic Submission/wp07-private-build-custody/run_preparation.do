* WP07 preparation-only caller. Review only; do not use without the separate private-build grant.
version 16
set more off
set varabbrev off

local build "C:/Users/jzava/AppData/Local/CFI-DPI-WP07-Private/preparation-only-20261113-dc48dbc"
local here = lower(subinstr(c(pwd), char(92), "/", .))
local temp = lower(subinstr(c(tmpdir), char(92), "/", .))
if substr("`temp'", -1, 1) == "/" {
    local temp = substr("`temp'", 1, strlen("`temp'") - 1)
}
if "`here'" != lower("`build'") | "`temp'" != lower("`build'/runtime") | _N != 0 | c(k) != 0 {
    exit 459
}
quietly log query _all
local logs = r(numlogs)
local logpath = lower(subinstr("`r(filename1)'", char(92), "/", .))
local prefix = lower("`build'/runtime/stata_run_cfi_wp07_prep_20261113_dc48dbc_")
if !inlist(`logs', 0, 1) | (`logs' == 0 & "`logpath'" != "") {
    exit 459
}
if `logs' == 1 {
    if substr("`logpath'", 1, strlen("`prefix'")) != "`prefix'" | ///
        !regexm(substr("`logpath'", strlen("`prefix'")+1, .), "^[a-z0-9_-]+[.]log$") {
        exit 459
    }
}
quietly cmdlog
if `"`r(status)'"' != "" | `"`r(filename)'"' != "" {
    exit 459
}

* The controller verifies the signed-off intent, ACLs, and exact input hashes before dispatch.
foreach f in intent.json carrier.path.txt approved_metadata.bin preparation.do coverage.do {
    confirm file "`build'/`f'"
}
foreach f in wp07_prepared_candidate.dta native_receipt.json build_receipt.json coverage_reconciliation.json {
    confirm new file "`build'/`f'"
}
foreach f in prepared_item_route_state_coverage.csv candidate_component_coverage.csv ///
    candidate_definition_comparisons.csv outcome_model_input_support.csv {
    confirm new file "`build'/coverage/`f'"
}

* Describe metadata by length and content; never put label or characteristic text in a log.
quietly mata:
string scalar wp07_token(string scalar s)
{
    return(strofreal(strlen(s), "%18.0f") + ":" + s)
}
string scalar wp07_metadata()
{
    real scalar i, j
    real colvector codes
    string scalar s, v
    string colvector names, texts
    s = wp07_token(st_datalabel())
    for (i=0; i<=st_nvar(); i++) {
        v = "_dta"
        if (i>0) {
            v = st_varname(i)
            s = s + wp07_token(v) + wp07_token(st_vartype(i)) + wp07_token(st_varformat(i)) +
                wp07_token(st_varlabel(i)) + wp07_token(st_varvaluelabel(i))
        }
        names = sort(st_dir("char", v, "*"), 1)
        s = s + wp07_token(strofreal(rows(names)))
        for (j=1; j<=rows(names); j++) {
            s = s + wp07_token(names[j]) + wp07_token(st_global(v+"["+names[j]+"]"))
        }
    }
    names = sort(st_vldir()', 1)
    s = s + wp07_token(strofreal(rows(names)))
    for (i=1; i<=rows(names); i++) {
        st_vlload(names[i], codes, texts)
        s = s + wp07_token(names[i]) + wp07_token(strofreal(rows(codes)))
        for (j=1; j<=rows(codes); j++) {
            s = s + wp07_token(strofreal(codes[j], "%21.0g")) + wp07_token(texts[j])
        }
    }
    return(s)
}
real scalar wp07_metadata_approved(string scalar file)
{
    real scalar fh, n
    string scalar approved
    fh = fopen(file, "r")
    fseek(fh, 0, 1)
    n = ftell(fh)
    fseek(fh, 0, -1)
    if (n<=0 | n>1048576) {
        fclose(fh)
        return(0)
    }
    approved = fread(fh, n)
    fclose(fh)
    return(wp07_metadata()==approved)
}
end

local raw formdef_version eligible_flag consent q1 q5 q3 q3_1 q3_5 q3_6 q3_7 q3_8 ///
    q3_12 q2_1 q2_2 q2_3 q4 q3_15 q3_16 q3_17 q3_20 q3_21 q3_22 ///
    q3_23 q4_1 q4_5 q4_6 q4_12 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 ///
    q4_26 q4_27 q5_13 q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 ///
    q6_13 q6_14 q6_15 q6_6 q6_9 q6_11 q6_16 q6_17 q6_18 q6_20 q6_21 ///
    q6_22 q6_23 q6_24 q7_1 q7_2 q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 ///
    q7_11 q7_12 q7_13 q7_14 q7_15 q9_4 q9_5 q9_6 q9_7 q9_8 q9_9 ///
    q9_11 q9_13 q9_16 q9_18 q9_19 q9_20 q9_1 q9_15 q9_17 q9_21 q9_22 ///
    q10_4 q10_6 q10_10 q10_11 q10_12 q10_13 q10_14 q10_16 q10_1 q10_2
local expected formdef_version eligible_flag consent q1 q5 q3 q3_1 q3_5 q3_6 q3_7 q3_8 ///
    q3_12 q2_1 q2_2 q2_3 q4 q3_15 q3_16 q3_17 q3_20 q3_21 q3_22 ///
    q3_23 q4_1 q4_5 q4_6 q4_12 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 ///
    q4_26 q4_27 q5_13 q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 ///
    q6_13 q6_14 q6_15 q6_6 q6_9 q6_11 q6_16 q6_17 q6_18 q6_20 q6_21 ///
    q6_22 q6_23 q6_24 q7_1 q7_2 q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 ///
    q7_11 q7_12 q7_13 q7_14 q7_15 q9_4 q9_5 q9_6 q9_7 q9_8 q9_9 ///
    q9_11 q9_13 q9_16 q9_18 q9_19 q9_20 q9_1 q9_15 q9_17 q9_21 q9_22 ///
    q10_4 q10_6 q10_10 q10_11 q10_12 q10_13 q10_14 q10_16 q10_1 q10_2 wp07_known_form ///
    wp07_state_q3_1 wp07_route_q3_1 wp07_state_q3_5 wp07_route_q3_5 wp07_state_q3_6 wp07_route_q3_6 wp07_state_q3_7 wp07_route_q3_7 wp07_state_q3_8 wp07_route_q3_8 wp07_state_q3_12 ///
    wp07_route_q3_12 wp07_state_q2_1 wp07_route_q2_1 wp07_state_q2_2 wp07_route_q2_2 wp07_state_q2_3 wp07_route_q2_3 wp07_state_q4 wp07_route_q4 wp07_state_q3 wp07_route_q3 ///
    wp07_state_q3_15 wp07_route_q3_15 wp07_state_q3_16 wp07_route_q3_16 wp07_state_q3_17 wp07_route_q3_17 wp07_state_q3_20 wp07_route_q3_20 wp07_state_q3_21 wp07_route_q3_21 wp07_state_q3_22 ///
    wp07_route_q3_22 wp07_state_q3_23 wp07_route_q3_23 wp07_state_q4_1 wp07_route_q4_1 wp07_state_q4_5 wp07_route_q4_5 wp07_state_q4_6 wp07_route_q4_6 wp07_state_q4_12 wp07_route_q4_12 ///
    wp07_state_q4_13 wp07_route_q4_13 wp07_state_q4_15 wp07_route_q4_15 wp07_state_q4_16 wp07_route_q4_16 wp07_state_q4_17 wp07_route_q4_17 wp07_state_q4_24 wp07_route_q4_24 wp07_state_q4_25 ///
    wp07_route_q4_25 wp07_state_q4_26 wp07_route_q4_26 wp07_state_q4_27 wp07_route_q4_27 wp07_state_q5_13 wp07_route_q5_13 wp07_state_q5_14 wp07_route_q5_14 wp07_state_q5_15 wp07_route_q5_15 ///
    wp07_state_q5_16 wp07_route_q5_16 wp07_state_q5_21 wp07_route_q5_21 wp07_state_q5_22 wp07_route_q5_22 wp07_state_q5_23 wp07_route_q5_23 wp07_state_q6_2 wp07_route_q6_2 wp07_state_q6_4 ///
    wp07_route_q6_4 wp07_state_q6_13 wp07_route_q6_13 wp07_state_q6_14 wp07_route_q6_14 wp07_state_q6_15 wp07_route_q6_15 wp07_state_q6_6 wp07_route_q6_6 wp07_state_q6_9 wp07_route_q6_9 ///
    wp07_state_q6_11 wp07_route_q6_11 wp07_state_q6_16 wp07_route_q6_16 wp07_state_q6_17 wp07_route_q6_17 wp07_state_q6_18 wp07_route_q6_18 wp07_state_q6_20 wp07_route_q6_20 wp07_state_q6_21 ///
    wp07_route_q6_21 wp07_state_q6_22 wp07_route_q6_22 wp07_state_q6_23 wp07_route_q6_23 wp07_state_q6_24 wp07_route_q6_24 wp07_state_q7_1 wp07_route_q7_1 wp07_state_q7_2 wp07_route_q7_2 ///
    wp07_state_q7_6 wp07_route_q7_6 wp07_state_q7_7 wp07_route_q7_7 wp07_state_q7_8 wp07_route_q7_8 wp07_state_q7_9 wp07_route_q7_9 wp07_state_q7_10 wp07_route_q7_10 wp07_state_q7_5 ///
    wp07_route_q7_5 wp07_state_q7_11 wp07_route_q7_11 wp07_state_q7_12 wp07_route_q7_12 wp07_state_q7_13 wp07_route_q7_13 wp07_state_q7_14 wp07_route_q7_14 wp07_state_q7_15 wp07_route_q7_15 ///
    wp07_state_q9_4 wp07_route_q9_4 wp07_state_q9_5 wp07_route_q9_5 wp07_state_q9_6 wp07_route_q9_6 wp07_state_q9_7 wp07_route_q9_7 wp07_state_q9_8 wp07_route_q9_8 wp07_state_q9_9 ///
    wp07_route_q9_9 wp07_state_q9_11 wp07_route_q9_11 wp07_state_q9_13 wp07_route_q9_13 wp07_state_q9_16 wp07_route_q9_16 wp07_state_q9_18 wp07_route_q9_18 wp07_state_q9_19 wp07_route_q9_19 ///
    wp07_state_q9_20 wp07_route_q9_20 wp07_state_q9_1 wp07_route_q9_1 wp07_state_q9_15 wp07_route_q9_15 wp07_state_q9_17 wp07_route_q9_17 wp07_state_q9_21 wp07_route_q9_21 wp07_state_q9_22 ///
    wp07_route_q9_22 wp07_state_q10_4 wp07_route_q10_4 wp07_state_q10_6 wp07_route_q10_6 wp07_state_q10_10 wp07_route_q10_10 wp07_state_q10_11 wp07_route_q10_11 wp07_state_q10_12 wp07_route_q10_12 ///
    wp07_state_q10_13 wp07_route_q10_13 wp07_state_q10_14 wp07_route_q10_14 wp07_state_q10_16 wp07_route_q10_16 wp07_state_q10_1 wp07_route_q10_1 wp07_state_q10_2 wp07_route_q10_2 wp07_residence ///
    wp07_account_route wp07_ivs_educ wp07_iat_phone wp07_iat_internet wp07_iat_runout wp07_iat3 wp07_iadt_app wp07_iadt_transfer wp07_iadt_confidence wp07_iadt3 wp07_iadt2 ///
    wp07_icdp_otp wp07_icdp_pin wp07_icdp2 wp07_iaff_address wp07_iaff_phone wp07_iaff2 wp07_iuof_frequency wp07_iuof_merchant wp07_iuof_saving wp07_iuof3 wp07_iuof_frequency_oldmap ///
    wp07_iuof3_oldmap wp07_iuof2_no_frequency wp07_oqi_ease wp07_oqi_support wp07_oqi2 wp07_oqi_ease_oldmap wp07_oqi2_oldmap wp07_remit_disposition wp07_remit_any_digital wp07_domestic_60d wp07_domestic_ops_bin ///
    e4_education3 e4_residence4 e4_occupation6
local bytevars wp07_known_form wp07_state_q3_1 wp07_route_q3_1 wp07_state_q3_5 wp07_route_q3_5 wp07_state_q3_6 wp07_route_q3_6 wp07_state_q3_7 wp07_route_q3_7 wp07_state_q3_8 wp07_route_q3_8 ///
    wp07_state_q3_12 wp07_route_q3_12 wp07_state_q2_1 wp07_route_q2_1 wp07_state_q2_2 wp07_route_q2_2 wp07_state_q2_3 wp07_route_q2_3 wp07_state_q4 wp07_route_q4 wp07_state_q3 ///
    wp07_route_q3 wp07_state_q3_15 wp07_route_q3_15 wp07_state_q3_16 wp07_route_q3_16 wp07_state_q3_17 wp07_route_q3_17 wp07_state_q3_20 wp07_route_q3_20 wp07_state_q3_21 wp07_route_q3_21 ///
    wp07_state_q3_22 wp07_route_q3_22 wp07_state_q3_23 wp07_route_q3_23 wp07_state_q4_1 wp07_route_q4_1 wp07_state_q4_5 wp07_route_q4_5 wp07_state_q4_6 wp07_route_q4_6 wp07_state_q4_12 ///
    wp07_route_q4_12 wp07_state_q4_13 wp07_route_q4_13 wp07_state_q4_15 wp07_route_q4_15 wp07_state_q4_16 wp07_route_q4_16 wp07_state_q4_17 wp07_route_q4_17 wp07_state_q4_24 wp07_route_q4_24 ///
    wp07_state_q4_25 wp07_route_q4_25 wp07_state_q4_26 wp07_route_q4_26 wp07_state_q4_27 wp07_route_q4_27 wp07_state_q5_13 wp07_route_q5_13 wp07_state_q5_14 wp07_route_q5_14 wp07_state_q5_15 ///
    wp07_route_q5_15 wp07_state_q5_16 wp07_route_q5_16 wp07_state_q5_21 wp07_route_q5_21 wp07_state_q5_22 wp07_route_q5_22 wp07_state_q5_23 wp07_route_q5_23 wp07_state_q6_2 wp07_route_q6_2 ///
    wp07_state_q6_4 wp07_route_q6_4 wp07_state_q6_13 wp07_route_q6_13 wp07_state_q6_14 wp07_route_q6_14 wp07_state_q6_15 wp07_route_q6_15 wp07_state_q6_6 wp07_route_q6_6 wp07_state_q6_9 ///
    wp07_route_q6_9 wp07_state_q6_11 wp07_route_q6_11 wp07_state_q6_16 wp07_route_q6_16 wp07_state_q6_17 wp07_route_q6_17 wp07_state_q6_18 wp07_route_q6_18 wp07_state_q6_20 wp07_route_q6_20 ///
    wp07_state_q6_21 wp07_route_q6_21 wp07_state_q6_22 wp07_route_q6_22 wp07_state_q6_23 wp07_route_q6_23 wp07_state_q6_24 wp07_route_q6_24 wp07_state_q7_1 wp07_route_q7_1 wp07_state_q7_2 ///
    wp07_route_q7_2 wp07_state_q7_6 wp07_route_q7_6 wp07_state_q7_7 wp07_route_q7_7 wp07_state_q7_8 wp07_route_q7_8 wp07_state_q7_9 wp07_route_q7_9 wp07_state_q7_10 wp07_route_q7_10 ///
    wp07_state_q7_5 wp07_route_q7_5 wp07_state_q7_11 wp07_route_q7_11 wp07_state_q7_12 wp07_route_q7_12 wp07_state_q7_13 wp07_route_q7_13 wp07_state_q7_14 wp07_route_q7_14 wp07_state_q7_15 ///
    wp07_route_q7_15 wp07_state_q9_4 wp07_route_q9_4 wp07_state_q9_5 wp07_route_q9_5 wp07_state_q9_6 wp07_route_q9_6 wp07_state_q9_7 wp07_route_q9_7 wp07_state_q9_8 wp07_route_q9_8 ///
    wp07_state_q9_9 wp07_route_q9_9 wp07_state_q9_11 wp07_route_q9_11 wp07_state_q9_13 wp07_route_q9_13 wp07_state_q9_16 wp07_route_q9_16 wp07_state_q9_18 wp07_route_q9_18 wp07_state_q9_19 ///
    wp07_route_q9_19 wp07_state_q9_20 wp07_route_q9_20 wp07_state_q9_1 wp07_route_q9_1 wp07_state_q9_15 wp07_route_q9_15 wp07_state_q9_17 wp07_route_q9_17 wp07_state_q9_21 wp07_route_q9_21 ///
    wp07_state_q9_22 wp07_route_q9_22 wp07_state_q10_4 wp07_route_q10_4 wp07_state_q10_6 wp07_route_q10_6 wp07_state_q10_10 wp07_route_q10_10 wp07_state_q10_11 wp07_route_q10_11 wp07_state_q10_12 ///
    wp07_route_q10_12 wp07_state_q10_13 wp07_route_q10_13 wp07_state_q10_14 wp07_route_q10_14 wp07_state_q10_16 wp07_route_q10_16 wp07_state_q10_1 wp07_route_q10_1 wp07_state_q10_2 wp07_route_q10_2 ///
    wp07_residence wp07_account_route wp07_remit_disposition wp07_remit_any_digital wp07_domestic_60d wp07_domestic_ops_bin e4_education3 e4_residence4 e4_occupation6
local doublevars wp07_ivs_educ wp07_iat_phone wp07_iat_internet wp07_iat_runout wp07_iat3 wp07_iadt_app wp07_iadt_transfer wp07_iadt_confidence wp07_iadt3 wp07_iadt2 wp07_icdp_otp ///
    wp07_icdp_pin wp07_icdp2 wp07_iaff_address wp07_iaff_phone wp07_iaff2 wp07_iuof_frequency wp07_iuof_merchant wp07_iuof_saving wp07_iuof3 wp07_iuof_frequency_oldmap wp07_iuof3_oldmap ///
    wp07_iuof2_no_frequency wp07_oqi_ease wp07_oqi_support wp07_oqi2 wp07_oqi_ease_oldmap wp07_oqi2_oldmap
local phase projection
local loads 0
local saves 0
local reopens 0
local owned_readback 0
tempname route readback receipt
local original = c(frame)
capture quietly {
    file open `route' using "`build'/carrier.path.txt", read text
    file read `route' carrier
    local carrier_eof = r(eof)
    file close `route'
    if `carrier_eof' | `"`carrier'"' == "" {
        error 459
    }
    local loads 1
    use `raw' using `"`carrier'"', clear
    assert _N == 423
    order `raw'
    unab received : _all
    if c(k) != 98 | "`received'" != "`raw'" {
        error 459
    }

    local phase preparation
    do "`build'/preparation.do"
    assert _N == 423
    unab received : _all
    if c(k) != 322 | "`received'" != "`expected'" {
        error 459
    }
    foreach type in byte double {
        local fields ``type'vars'
        foreach field of local fields {
            local storage : type `field'
            if "`storage'" != "`type'" {
                error 459
            }
        }
    }

    local phase metadata_before_save
    mata: st_local("approved", strofreal(wp07_metadata_approved(st_local("build")+"/approved_metadata.bin")))
    if "`approved'" != "1" {
        error 459
    }

    local phase save
    local saves 1
    save "`build'/wp07_prepared_candidate.dta"

    local phase readback
    frame create `readback'
    local owned_readback 1
    local reopens 1
    frame `readback': use "`build'/wp07_prepared_candidate.dta", clear
    frame `readback': assert _N == 423
    frame `readback': unab reopened : _all
    if "`reopened'" != "`expected'" {
        error 459
    }
    foreach field of local expected {
        frame `readback': assert `field' == _frval(`original', `field', _n)
    }
    frame `readback': mata: st_local("approved", strofreal(wp07_metadata_approved(st_local("build")+"/approved_metadata.bin")))
    if "`approved'" != "1" {
        error 459
    }

    local phase coverage
    frame `readback': do "`build'/coverage.do" "`build'/coverage"
    local phase complete
}
local run_rc = _rc
local cleanup_rc 0
if `owned_readback' {
    capture frame drop `readback'
    local cleanup_rc = _rc
}
capture clear
if _rc & !`cleanup_rc' {
    local cleanup_rc = _rc
}
quietly file open `receipt' using "`build'/native_receipt.json", write text
quietly file write `receipt' "{" _n ///
    `""phase":"`phase'","' _n ///
    `""rc":"' (`run_rc') "," _n ///
    `""cleanup_rc":"' (`cleanup_rc') "," _n ///
    `""carrier_load_attempts":"' (`loads') "," _n ///
    `""candidate_save_attempts":"' (`saves') "," _n ///
    `""candidate_reopen_attempts":"' (`reopens') "," _n ///
    `""final_n":"' (_N) "," _n ///
    `""final_k":"' (c(k)) _n "}" _n
quietly file close `receipt'
if `run_rc' | `cleanup_rc' | _N != 0 | c(k) != 0 {
    exit 459
}
display "WP07_PRIVATE_PREP_COMPLETE"
