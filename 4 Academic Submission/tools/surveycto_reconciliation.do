version 16
/* Read-only source reconciliation. Execute only through Stata MCP in a fresh
   named session. No estimators, source saves, raw exports, or scientific recodes.
   Inputs: repository, Dropbox project, OneDrive project, ignored receipt folder.
   Output: schemas and aggregate differences only; no respondent values/keys.
*/
args cfi_repo cfi_db cfi_od cfi_out
if missing("`cfi_repo'") | missing("`cfi_db'") | missing("`cfi_od'") | missing("`cfi_out'") {
    display as error "Supply four absolute scoped paths."
    exit 198
}
if strpos("`cfi_out'", "`cfi_repo'/4 Academic Submission/audit-local/") != 1 | strpos("`cfi_out'", "/../") | strpos("`cfi_out'", "\") {
    display as error "Receipt output must be a normalized ignored audit-local path."
    exit 198
}
confirm file "`cfi_out'/baseline_receipt.json"
frame change default
assert _N == 0 & c(k) == 0
tempfile cfi_counts cfi_fields cfi_diff cfi_links cfi_flow cfi_versions cfi_orders
tempname cfi_cp cfi_fp cfi_dp cfi_lp cfi_sp cfi_op
postfile `cfi_cp' str20 source_id long N K missing_keys byte unique_keys using "`cfi_counts'", replace
postfile `cfi_fp' str20 source_id str32 variable str12 storage_type using "`cfi_fields'", replace
postfile `cfi_dp' str32 comparison str32 variable str12 master_type str12 reference_type long compared strict_differences equivalent_differences invalid_numeric_text using "`cfi_diff'", replace
postfile `cfi_lp' str32 comparison long master_N reference_N matched master_only reference_only shared_variables master_only_variables reference_only_variables using "`cfi_links'", replace
postfile `cfi_sp' str50 check_name long before_N excluded_N retained_N using "`cfi_flow'", replace
postfile `cfi_op' str32 comparison long matched absolute_position_differences relative_order_differences using "`cfi_orders'", replace

capture program drop cfi_source_compare
program define cfi_source_compare, rclass
    syntax, MASTER(name) REFERENCE(name) TAG(string) DIFF(name) LINKS(name)
    frame change `master'
    unab cfi_mv : _all
    local cfi_mn = _N
    frame `reference': unab cfi_rv : _all
    frame `reference': quietly count
    local cfi_rn = r(N)
    local cfi_common : list cfi_mv & cfi_rv
    local cfi_monly : list cfi_mv - cfi_rv
    local cfi_ronly : list cfi_rv - cfi_mv
    local cfi_common_n : word count `cfi_common'
    local cfi_monly_n : word count `cfi_monly'
    local cfi_ronly_n : word count `cfi_ronly'
    quietly frlink 1:1 KEY, frame(`reference') generate(__cfi_link)
    quietly count if !missing(__cfi_link)
    local cfi_match = r(N)
    post `links' ("`tag'") (`cfi_mn') (`cfi_rn') (`cfi_match') (`cfi_mn'-`cfi_match') (`cfi_rn'-`cfi_match') (`cfi_common_n') (`cfi_monly_n') (`cfi_ronly_n')
    local cfi_total_strict = 0
    local cfi_total_equiv = 0
    foreach cfi_v of local cfi_common {
        local cfi_mt : type `cfi_v'
        quietly frget __cfi_ref = `cfi_v', from(__cfi_link)
        local cfi_rt : type __cfi_ref
        local cfi_invalid = 0
        if (substr("`cfi_mt'",1,3)=="str") == (substr("`cfi_rt'",1,3)=="str") {
            quietly count if `cfi_v' != __cfi_ref & !missing(__cfi_link)
            local cfi_strict = r(N)
            local cfi_equiv = r(N)
        }
        else {
            local cfi_strict = `cfi_match'
            if substr("`cfi_mt'",1,3)=="str" {
                local cfi_string "`cfi_v'"
                local cfi_number "__cfi_ref"
            }
            else {
                local cfi_string "__cfi_ref"
                local cfi_number "`cfi_v'"
            }
            /* Empty text matches system missing only; extended missing stays distinct.
               Never coerce arbitrary text to missing or decode category labels silently. */
            quietly count if !missing(__cfi_link) & !((`cfi_string'=="" & `cfi_number'==.) | (!missing(real(`cfi_string')) & real(`cfi_string')==`cfi_number'))
            local cfi_equiv = r(N)
            quietly count if !missing(__cfi_link) & `cfi_string'!="" & missing(real(`cfi_string'))
            local cfi_invalid = r(N)
        }
        post `diff' ("`tag'") ("`cfi_v'") ("`cfi_mt'") ("`cfi_rt'") (`cfi_match') (`cfi_strict') (`cfi_equiv') (`cfi_invalid')
        local cfi_total_strict = `cfi_total_strict' + `cfi_strict'
        local cfi_total_equiv = `cfi_total_equiv' + `cfi_equiv'
        drop __cfi_ref
    }
    drop __cfi_link
    return scalar matched = `cfi_match'
    return scalar strict = `cfi_total_strict'
    return scalar equivalent = `cfi_total_equiv'
end

/* frlink indices refer to a sorted reference, not its original physical rows.
   Capture positions before linking in disposable copies, never from link indices.
   Relative order is meaningful for a subset; absolute positions need not agree. */
capture program drop cfi_order_compare
program define cfi_order_compare, rclass
    syntax, MASTER(name) REFERENCE(name)
    frame copy `master' cfi_order_m
    frame copy `reference' cfi_order_r
    frame cfi_order_m: generate long __cfi_master_pos = _n
    frame cfi_order_r: generate long __cfi_reference_pos = _n
    frame change cfi_order_m
    quietly frlink 1:1 KEY, frame(cfi_order_r) generate(__cfi_order_link)
    quietly frget __cfi_refpos = __cfi_reference_pos, from(__cfi_order_link)
    assert __cfi_master_pos == _n
    quietly count if !missing(__cfi_order_link)
    local cfi_matched = r(N)
    quietly count if !missing(__cfi_order_link) & __cfi_master_pos != __cfi_refpos
    local cfi_absolute = r(N)
    quietly keep if !missing(__cfi_order_link)
    generate long __cfi_relative_master = _n
    sort __cfi_refpos
    quietly count if __cfi_relative_master != _n
    local cfi_relative = r(N)
    frame change default
    frame drop cfi_order_m cfi_order_r
    frame change `master'
    return scalar matched = `cfi_matched'
    return scalar absolute = `cfi_absolute'
    return scalar relative = `cfi_relative'
end

/* Runnable regression check: shuffled keys, true change, numeric/text equivalence,
   invalid text, and an extended missing must not be hidden. Synthetic values only. */
frame create cfi_test_m
frame change cfi_test_m
quietly set obs 3
generate str1 KEY = string(_n)
generate double x = cond(_n==3,.a,_n)
frame copy cfi_test_m cfi_test_r
frame cfi_test_r: gsort -KEY
cfi_source_compare, master(cfi_test_m) reference(cfi_test_r) tag("SELF_ORDER") diff(`cfi_dp') links(`cfi_lp')
assert r(matched)==3 & r(equivalent)==0
frame cfi_test_r: replace x = 99 if KEY=="2"
cfi_source_compare, master(cfi_test_m) reference(cfi_test_r) tag("SELF_CHANGE") diff(`cfi_dp') links(`cfi_lp')
assert r(equivalent)==1
frame cfi_test_r: drop x
frame cfi_test_r: generate str7 x = cond(KEY=="3","",KEY)
cfi_source_compare, master(cfi_test_m) reference(cfi_test_r) tag("SELF_TYPES") diff(`cfi_dp') links(`cfi_lp')
assert r(equivalent)==1
frame cfi_test_r: replace x = "invalid" if KEY=="1"
cfi_source_compare, master(cfi_test_m) reference(cfi_test_r) tag("SELF_TEXT") diff(`cfi_dp') links(`cfi_lp')
assert r(equivalent)==2
frame change default
frame drop cfi_test_m cfi_test_r
display "PASS: key-aligned cell comparison self-check"

/* Synthetic regression check: identical reverse-key files must agree despite
   reordered reference-link indices; a subset differs only in absolute position. */
frame create cfi_order_test_r
frame cfi_order_test_r: quietly set obs 3
frame cfi_order_test_r: generate str1 KEY = string(4-_n)
frame copy cfi_order_test_r cfi_order_test_m
cfi_order_compare, master(cfi_order_test_m) reference(cfi_order_test_r)
assert r(matched)==3 & r(absolute)==0 & r(relative)==0
frame cfi_order_test_m: quietly drop if KEY=="2"
cfi_order_compare, master(cfi_order_test_m) reference(cfi_order_test_r)
assert r(matched)==2 & r(absolute)==1 & r(relative)==0
frame cfi_order_test_m: gsort KEY
cfi_order_compare, master(cfi_order_test_m) reference(cfi_order_test_r)
assert r(matched)==2 & r(relative)==2
frame change default
frame drop cfi_order_test_m cfi_order_test_r
display "PASS: original-position and subset-order self-check"

/* Loading creates temporary frames only. Do not run the historical master here. */
foreach cfi_source in NEW_RAW OLD_RAW AUDIT CODED NO_PII {
    frame create `cfi_source'
    frame change `cfi_source'
    if "`cfi_source'"=="NEW_RAW" {
        quietly import excel using "`cfi_db'/2 Data/1 Raw/CFI DPI Encuesta Cuantitativa_WIDE.xlsx", sheet("data") firstrow clear
    }
    if "`cfi_source'"=="OLD_RAW" {
        quietly import excel using "`cfi_od'/2 Data/1 Raw/CFI DPI Encuesta Cuantitativa_WIDE.xlsx", sheet("data") firstrow clear
    }
    if "`cfi_source'"=="AUDIT" {
        quietly use "`cfi_repo'/2 Output/CFI_DPI Data for audit.dta", clear
    }
    if "`cfi_source'"=="CODED" {
        quietly use "`cfi_db'/2 Data/3 Coded/CFI_DPI Data for analysis.dta", clear
    }
    if "`cfi_source'"=="NO_PII" {
        quietly use "`cfi_db'/2 Data/3 Coded/CFI_DPI Data for analysis_NoPII.dta", clear
    }
    quietly describe
    local cfi_n = r(N)
    local cfi_k = r(k)
    quietly count if missing(KEY)
    local cfi_missing = r(N)
    isid KEY
    post `cfi_cp' ("`cfi_source'") (`cfi_n') (`cfi_k') (`cfi_missing') (1)
    unab cfi_vars : _all
    foreach cfi_v of local cfi_vars {
        local cfi_t : type `cfi_v'
        post `cfi_fp' ("`cfi_source'") ("`cfi_v'") ("`cfi_t'")
    }
}
/* Before any source comparison can sort an original reference frame. */
cfi_order_compare, master(NEW_RAW) reference(AUDIT)
post `cfi_op' ("NEW_AUDIT") (r(matched)) (r(absolute)) (r(relative))
cfi_order_compare, master(OLD_RAW) reference(AUDIT)
post `cfi_op' ("OLD_AUDIT") (r(matched)) (r(absolute)) (r(relative))
cfi_order_compare, master(AUDIT) reference(CODED)
post `cfi_op' ("AUDIT_CODED") (r(matched)) (r(absolute)) (r(relative))
cfi_source_compare, master(NEW_RAW) reference(OLD_RAW) tag("NEW_OLD") diff(`cfi_dp') links(`cfi_lp')
cfi_source_compare, master(NEW_RAW) reference(AUDIT) tag("NEW_AUDIT") diff(`cfi_dp') links(`cfi_lp')
cfi_source_compare, master(NEW_RAW) reference(CODED) tag("NEW_CODED") diff(`cfi_dp') links(`cfi_lp')
cfi_source_compare, master(AUDIT) reference(CODED) tag("AUDIT_CODED") diff(`cfi_dp') links(`cfi_lp')
cfi_source_compare, master(CODED) reference(NO_PII) tag("CODED_NO_PII") diff(`cfi_dp') links(`cfi_lp')

/* Replay exactly the existing four filters (preparation lines 1011, 1014--1016).
   This audits membership, not every later transformation or participant eligibility. */
frame copy NEW_RAW cfi_filter
frame change cfi_filter
local cfi_before = _N
quietly drop if KEY==""
post `cfi_sp' ("EMPTY_KEY") (`cfi_before') (`cfi_before'-_N) (_N)
local cfi_before = _N
quietly drop if consent==0 | consent==98
post `cfi_sp' ("DECLINED_OR_PREFER_NOT_RESPOND_CONSENT") (`cfi_before') (`cfi_before'-_N) (_N)
local cfi_before = _N
quietly drop if q1==2
post `cfi_sp' ("Q1_CODE_2") (`cfi_before') (`cfi_before'-_N) (_N)
local cfi_before = _N
quietly drop if q5==0 | q5==98
post `cfi_sp' ("NO_OR_PREFER_NOT_RESPOND_REMITTANCE") (`cfi_before') (`cfi_before'-_N) (_N)
foreach cfi_v in consent q1 q5 q4 {
    quietly count if missing(`cfi_v')
    post `cfi_sp' ("RETAINED_MISSING_`cfi_v'") (_N) (r(N)) (_N)
}
quietly count if q4<18 & !missing(q4)
post `cfi_sp' ("RETAINED_REPORTED_AGE_BELOW_18") (_N) (r(N)) (_N)
cfi_source_compare, master(cfi_filter) reference(CODED) tag("FILTERED_CODED") diff(`cfi_dp') links(`cfi_lp')
assert r(matched)==423
frame CODED: assert _N==423
frame cfi_filter: assert _N==423

/* Form-version counts only. Do not emit individual submission timestamps. */
frame copy NEW_RAW cfi_version
frame change cfi_version
keep formdef_version
quietly contract formdef_version, freq(submitted_N)
quietly export delimited using "`cfi_out'/stata_form_version_counts.csv", replace quote
frame change default

postclose `cfi_cp'
postclose `cfi_fp'
postclose `cfi_dp'
postclose `cfi_lp'
postclose `cfi_sp'
postclose `cfi_op'
frame create cfi_receipt
frame change cfi_receipt
quietly use "`cfi_counts'", clear
quietly export delimited using "`cfi_out'/stata_source_counts.csv", replace quote
quietly use "`cfi_fields'", clear
quietly export delimited using "`cfi_out'/stata_source_schema.csv", replace quote
quietly use "`cfi_diff'", clear
quietly export delimited using "`cfi_out'/stata_field_differences.csv", replace quote
quietly use "`cfi_links'", clear
quietly export delimited using "`cfi_out'/stata_key_schema_containment.csv", replace quote
quietly use "`cfi_flow'", clear
quietly export delimited using "`cfi_out'/stata_historical_filter_flow.csv", replace quote
quietly use "`cfi_orders'", clear
quietly export delimited using "`cfi_out'/stata_original_order_comparisons.csv", replace quote
frame change default
frame drop NEW_RAW OLD_RAW AUDIT CODED NO_PII cfi_filter cfi_version cfi_receipt
assert _N==0 & c(k)==0
display "PASS: source reconciliation executed; no estimation or source writes; default frame empty"

