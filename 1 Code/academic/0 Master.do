/*
CFI DPI — academic quantitative analysis
Authors: Jorge E. Zavala and Angélica Cardozo Cadavid
Integrated source: 7 November 2026; held E.4 integration: 8 November 2026. Stata 16 syntax.
*/
* Source-review candidate only. No execution is authorized by this code revision.
exit 198

version 16
set more off
set varabbrev off

* Supply the repository, restricted archive root and a fresh restricted output folder.
* The archive root is the preserved '2 Data/4 Restricted replication archive'.
* No directory is created, no old file overwritten and no alternative carrier tried.
args repository restricted_archive restricted_output
if "`repository'" == "" | "`restricted_archive'" == "" | "`restricted_output'" == "" {
    exit 198
}
confirm file "`repository'/1 Code/academic/1 Data preparation.do"
confirm file "`repository'/1 Code/academic/2 Analysis.do"

* Exact historical admitted carrier, not a new SurveyCTO export or a NoPII clone.
* Expected SHA-256: 95e0929d4ab5f4e0808c07f9eb636c24a0eeb88f676cace328bb064badcad756
* Bind that identity and the output folder in the separately authorized execution manifest.
local carrier ///
    "`restricted_archive'/7132afe058718e790305f51e78a215b383d22009/2 Output/CFI_DPI Data for analysis.dta"
confirm file "`carrier'"

* Preserve an existing in-memory dataset by requiring empty memory before loading.
if c(k) > 0 | c(N) > 0 {
    exit 4
}
confirm new file "`restricted_output'/academic_review.log"
confirm new file "`restricted_output'/academic_prepared.dta"
log using "`restricted_output'/academic_review.log", text name(academic_review)

* Fixed research-field projection. No KEY, names, contacts, enumerator IDs or free text.
* The cohort is inherited intact; manual/test and coded exclusions are not re-applied.
* Close only this named restricted log even when a callee or save stops with an error.
capture noisily {
    use formdef_version eligible_flag consent q1 q5 q3 q3_1 q3_5 q3_6 q3_7 q3_8 q3_12 q2_1 q2_2 q2_3 q4 q3_15 ///
        q3_16 q3_17 q3_20 q3_21 q3_22 q3_23 q4_1 q4_5 q4_6 q4_12 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 q4_26 q4_27 ///
        q5_13 q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 q6_13 q6_14 q6_15 q6_6 q6_9 q6_11 q6_16 q6_17 q6_18 ///
        q6_20 q6_21 q6_22 q6_23 q6_24 q7_1 q7_2 q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 q7_11 q7_12 q7_13 q7_14 q7_15 ///
        q9_4 q9_5 q9_6 q9_7 q9_8 q9_9 q9_11 q9_13 q9_16 q9_18 q9_19 q9_20 q9_1 q9_15 q9_17 q9_21 q9_22 q10_4 ///
        q10_6 q10_10 q10_11 q10_12 q10_13 q10_14 q10_16 q10_1 q10_2 using "`carrier'", clear
    if _N != 423 {
        exit 459
    }
    
    * One preparation stage and one analysis stage; neither calls a historical script.
    do "`repository'/1 Code/academic/1 Data preparation.do"
    save "`restricted_output'/academic_prepared.dta"
    * E.4 is approved in source only; the analysis retains a separate pre-fit stop.
    * Its bounded native validation/estimation must not dispatch this full master.
    do "`repository'/1 Code/academic/2 Analysis.do" "`restricted_output'"
}
local run_rc = _rc
capture log close academic_review
local close_rc = _rc
if `run_rc' != 0 {
    exit `run_rc'
}
if `close_rc' != 0 {
    exit `close_rc'
}


* The prepared dataset, log and all small-cell output remain restricted.
* This source pass does not make the academic pipeline numerically accepted.

