/*
NV03–NV06 — bounded artificial model and failure-path checks
E.4 native validation preparation — artificial inputs only, 8 November 2026.
*/
* Preparation only. No Stata execution is authorized by this file.
* Keep this hold; a later authorized MCP selection binds source blocks and output.
exit 198

* BEGIN NV_MODEL PREFIX
version 16
if c(N) > 0 | c(k) > 0 {
    exit 4
}
* Later selection binds nv_case to SUPPORTED/BLOCKED/RANK/SEPARATION.
if !inlist("`nv_case'", "SUPPORTED", "BLOCKED", "RANK", "SEPARATION") {
    exit 198
}
* Complete factorial covariates with four balanced binary responses per cell.
* This is generated arithmetic, not a study file or a participant-data copy.
set obs 55296
gen long nv_cell = floor((_n - 1)/4)
gen byte nv_rep = mod(_n - 1, 4)
gen double wp07_iat3 = .25 + mod(nv_cell, 4)/4
gen double wp07_iadt2 = .25 + mod(floor(nv_cell/4), 4)/4
gen double wp07_iaff2 = mod(floor(nv_cell/16), 3)/2
gen double q4 = 25 + 20*mod(floor(nv_cell/48), 2)
gen double q2_1 = 2005 + 10*mod(floor(nv_cell/96), 2)
gen byte nv_education = mod(floor(nv_cell/192), 3)
gen byte q2_2 = 1
replace q2_2 = 5 if nv_education == 1
replace q2_2 = 6 if nv_education == 2
gen byte wp07_residence = 1 + mod(floor(nv_cell/576), 4)
replace wp07_residence = 5 if wp07_residence == 4
gen byte nv_occupation = mod(floor(nv_cell/2304), 6)
gen byte q2_3 = 1
replace q2_3 = 3 if nv_occupation == 1
replace q2_3 = 4 if nv_occupation == 2
replace q2_3 = 5 if nv_occupation == 3
replace q2_3 = 7 if nv_occupation == 4
replace q2_3 = 9 if nv_occupation == 5
gen byte wp07_state_q2_2 = 1
gen byte wp07_state_q2_3 = 1
gen byte wp07_remit_any_digital = mod(nv_rep, 2)
gen byte wp07_domestic_60d = inlist(nv_rep, 1, 2)
* The domestic/common masks omit one focal endpoint without invalidating the slope.
replace wp07_domestic_60d = . if wp07_iat3 == .5
if "`nv_case'" == "BLOCKED" {
    replace q4 = 40
}
if inlist("`nv_case'", "RANK", "SEPARATION") {
    * Only R0 can reach a fit: the other four fail their no-fit input gates.
    replace wp07_domestic_60d = .
    replace q2_1 = .
}
if "`nv_case'" == "RANK" {
    replace q4 = 20 + 40*wp07_iat3
}
if "`nv_case'" == "SEPARATION" {
    replace wp07_remit_any_digital = (wp07_iat3 >= .75)
}
* END NV_MODEL PREFIX

* Insert exact canonical E4 GROUPINGS, then E4 BODY, in the authorized selection.

* BEGIN NV_MODEL SUFFIX
assert _N == 55296
assert e4_row_order == _n
tempname nv_status nv_tests nv_probabilities
frame create `nv_status'
frame `nv_status': import delimited using "`e4_output'/e4_model_status.csv", ///
    varnames(1) numericcols(2/11) asdouble clear
frame `nv_status': assert _N == 5
frame `nv_status': isid model
if "`nv_case'" == "SUPPORTED" {
    frame `nv_status': assert attempted == 1 & fit_rc == 0
    frame `nv_status': assert status == "ACCEPTED_WORKING_MODEL"
    frame `nv_status': assert converged == 1 & rank == expected_rank & sample_mismatch == 0
    frame `nv_status': assert intended_n == 55296 if inlist(model, "R0_E4", "R1_E4")
    frame `nv_status': assert intended_n == 41472 if inlist(model, "D0_E4", "D1_E4", "R0C_E4")
    frame `nv_status': assert estimator_n == intended_n
    frame `nv_status': assert expected_rank == 16 if inlist(model, "R1_E4", "D1_E4")
    frame `nv_status': assert expected_rank == 10 if inlist(model, "R0_E4", "D0_E4", "R0C_E4")
}
if "`nv_case'" == "BLOCKED" {
    frame `nv_status': assert attempted == 0
    frame `nv_status': assert status == "PREFIT_SUPPORT_BLOCKED"
}
if inlist("`nv_case'", "RANK", "SEPARATION") {
    frame `nv_status': assert attempted == (model == "R0_E4")
    frame `nv_status': assert status != "ACCEPTED_WORKING_MODEL"
    frame `nv_status': assert status == "PREFIT_SUPPORT_BLOCKED" if model != "R0_E4"
}
frame create `nv_tests'
frame `nv_tests': import delimited using "`e4_output'/e4_primary_tests.csv", ///
    varnames(1) numericcols(4 6 7) asdouble clear
frame `nv_tests': assert _N == 6
frame `nv_tests': isid slot
if "`nv_case'" == "SUPPORTED" {
    frame `nv_tests': assert abs(p_raw - 1) < 1e-8
    frame `nv_tests': assert abs(p_holm - 1) < 1e-8
}
else {
    frame `nv_tests': assert missing(p_raw) & missing(p_holm)
}
frame create `nv_probabilities'
frame `nv_probabilities': import delimited using "`e4_output'/e4_probabilities.csv", ///
    varnames(1) numericcols(4/8) asdouble clear
frame `nv_probabilities': assert _N == 45
if "`nv_case'" == "SUPPORTED" {
    frame `nv_probabilities': count if status == "ENDPOINT_UNAVAILABLE"
    assert r(N) == 9
    frame `nv_probabilities': assert status == "ENDPOINT_UNAVAILABLE" if ///
        focal == "wp07_iat3" & inlist(model, "D0_E4", "D1_E4", "R0C_E4")
    frame `nv_probabilities': assert abs(estimate - .5) < 1e-8 if ///
        status == "AVAILABLE_POINTWISE_WORKING_VCE" & record != "higher_minus_lower"
    frame `nv_probabilities': assert abs(estimate) < 1e-8 if ///
        status == "AVAILABLE_POINTWISE_WORKING_VCE" & record == "higher_minus_lower"
    frame `nv_probabilities': count if status == "AVAILABLE_POINTWISE_WORKING_VCE"
    assert r(N) == 36
}
else {
    frame `nv_probabilities': assert missing(estimate) & missing(se) & missing(ll) & missing(ul)
}
if "`nv_case'" == "SUPPORTED" {
    * Retained matrices describe the last model/operation; compare their CSV cells exactly.
    tempname nv_matrices
    frame create `nv_matrices'
    frame `nv_matrices': import delimited using "`e4_output'/e4_native_matrices.csv", ///
        varnames(1) numericcols(4 5 8) asdouble clear
    frame `nv_matrices': count if model == "R0C_E4" & operation == "fit" & matrix == "e4_V"
    assert r(N) == rowsof(e4_V)*colsof(e4_V)
    frame `nv_matrices': assert value == e4_V[row,column] if ///
        model == "R0C_E4" & operation == "fit" & matrix == "e4_V"
    frame drop `nv_matrices'
}
frame drop `nv_status'
frame drop `nv_tests'
frame drop `nv_probabilities'
display as text "NV_MODEL_PASS: artificial `nv_case'; no study data."
* END NV_MODEL SUFFIX

