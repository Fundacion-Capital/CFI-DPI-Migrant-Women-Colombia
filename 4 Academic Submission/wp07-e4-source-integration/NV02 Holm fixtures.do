/*
NV02 — fixed-six Holm, including unavailable tests
E.4 native validation preparation — artificial inputs only, 8 November 2026.
*/
* Preparation only. No Stata execution is authorized by this file.
* Keep this hold; a later authorized MCP selection binds source blocks and output.
exit 198

* BEGIN NV02 PREFIX
version 16
if c(N) > 0 | c(k) > 0 {
    exit 4
}
* The later selection binds nv_case=1,...,5 and one fresh e4_output directory.
if !inrange(`nv_case', 1, 5) {
    exit 198
}
confirm new file "`e4_output'/e4_primary_tests.csv"
tempname primary
frame create `primary' str8 slot str8 model str32 field double p_raw str40 status
if `nv_case' == 1 {
    matrix NV_raw = (.001, .01, .02, .04, .2, .81234567890123457)
    matrix NV_expected = (.006, .05, .08, .12, .4, .81234567890123457)
}
if `nv_case' == 2 {
    matrix NV_raw = (.001, .01, ., .04, .2, .8)
    matrix NV_expected = (.006, .05, ., .16, .6, 1)
}
if `nv_case' == 3 {
    matrix NV_raw = (.01, .01, .01, .5, .9, 1)
    matrix NV_expected = (.06, .06, .06, 1, 1, 1)
}
if `nv_case' == 4 {
    matrix NV_raw = J(1, 6, .)
    matrix NV_expected = J(1, 6, .)
}
if `nv_case' == 5 {
    matrix NV_raw = (0, ., 1, ., ., .)
    matrix NV_expected = (0, ., 1, ., ., .)
}
local slots "R_IAT R_IADT R_IAFF D_IAT D_IADT D_IAFF"
local column = 0
foreach slot of local slots {
    local column = `column' + 1
    frame post `primary' ("`slot'") ("FIXTURE") ("artificial_p") ///
        (NV_raw[1,`column']) ("ARTIFICIAL")
}
* END NV02 PREFIX

* Insert the exact canonical E4 HOLM block here in the authorized selection.

* BEGIN NV02 SUFFIX
local column = 0
foreach slot of local slots {
    local column = `column' + 1
    if missing(NV_expected[1,`column']) {
        frame `primary': assert missing(p_raw) & missing(p_holm) if slot == "`slot'"
    }
    else {
        frame `primary': assert abs(p_raw - NV_raw[1,`column']) < 1e-12 if slot == "`slot'"
        frame `primary': assert abs(p_holm - NV_expected[1,`column']) < 1e-12 if slot == "`slot'"
    }
}
frame `primary': assert _N == 6
* Read the emitted CSV as doubles; in-memory assertions alone cannot test precision.
tempname nv_readback
frame create `nv_readback'
frame `nv_readback': import delimited using "`e4_output'/e4_primary_tests.csv", ///
    varnames(1) numericcols(4 6 7) asdouble clear
frame `nv_readback': assert _N == 6
local column = 0
foreach slot of local slots {
    local column = `column' + 1
    frame `nv_readback': assert p_raw == NV_raw[1,`column'] if slot == "`slot'"
    if missing(NV_expected[1,`column']) {
        frame `nv_readback': assert missing(p_holm) if slot == "`slot'"
    }
    else {
        frame `nv_readback': assert abs(p_holm - NV_expected[1,`column']) < 1e-12 if slot == "`slot'"
    }
}
frame drop `nv_readback'
frame drop `primary'
display as text "NV02_PASS: fixed-six artificial case `nv_case'; no fit."
* END NV02 SUFFIX

