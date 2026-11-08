/*
NV01 — all approved category mappings and unscored states
E.4 native validation preparation — artificial inputs only, 8 November 2026.
*/
* Preparation only. No Stata execution is authorized by this file.
* Keep this hold; a later authorized MCP selection binds source blocks and output.
exit 198

* BEGIN NV01 PREFIX
version 16
if c(N) > 0 | c(k) > 0 {
    exit 4
}
set obs 37
gen double q2_2 = .
gen double q2_3 = .
gen double wp07_residence = .
gen byte wp07_state_q2_2 = 4
gen byte wp07_state_q2_3 = 4
replace q2_2 = _n if inrange(_n, 1, 10)
replace wp07_state_q2_2 = 1 if inrange(_n, 1, 10)
replace wp07_residence = _n - 10 if inrange(_n, 11, 16)
replace q2_3 = _n - 16 if inrange(_n, 17, 25)
replace wp07_state_q2_3 = 1 if inrange(_n, 17, 25)
* Ordinary-looking values in nonordinary states must remain unscored.
replace q2_2 = 5 if inrange(_n, 26, 30)
replace wp07_state_q2_2 = _n - 24 if inrange(_n, 26, 30)
replace q2_3 = 3 if inrange(_n, 31, 35)
replace wp07_state_q2_3 = _n - 29 if inrange(_n, 31, 35)
replace q2_2 = 2.5 in 36
replace wp07_state_q2_2 = 6 in 36
replace q2_3 = 2.5 in 37
replace wp07_state_q2_3 = 6 in 37
_datasignature q2_2 q2_3 wp07_residence wp07_state_q2_2 wp07_state_q2_3
local nv_signature "`r(datasignature)'"
* END NV01 PREFIX

* Insert the exact canonical E4 GROUPINGS block here in the authorized selection.

* BEGIN NV01 SUFFIX
assert _N == 37
assert e4_education3 == 1 if inrange(_n, 1, 4)
assert e4_education3 == 2 in 5
assert e4_education3 == 3 if inrange(_n, 6, 10)
assert missing(e4_education3) if _n > 10
assert e4_residence4 == _n - 10 if inrange(_n, 11, 13)
assert e4_residence4 == 4 if inrange(_n, 14, 16)
assert missing(e4_residence4) if _n <= 10 | _n > 16
assert e4_occupation6 == 1 if inrange(_n, 17, 18)
assert e4_occupation6 == 3 in 19
assert e4_occupation6 == 4 in 20
assert e4_occupation6 == 5 if inlist(_n, 21, 22, 24)
assert e4_occupation6 == 7 in 23
assert e4_occupation6 == 9 in 25
assert missing(e4_occupation6) if _n < 17 | _n > 25
_datasignature q2_2 q2_3 wp07_residence wp07_state_q2_2 wp07_state_q2_3
assert "`r(datasignature)'" == "`nv_signature'"
display as text "NV01_PASS: 37 artificial rows; 25 source mappings; no fit."
* END NV01 SUFFIX

