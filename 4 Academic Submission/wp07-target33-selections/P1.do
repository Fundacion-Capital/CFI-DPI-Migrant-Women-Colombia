* TARGET33 P1: exact projection and screening support -- held source; no execution authority.
* The protected dispatcher must validate the pinned contract before invoking this selection.
* Source digest and access are checked outside Stata; never substitute another file.
quietly use KEY SubmissionDate consent eligible_flag endtime fecha formdef_version q1 q10_1 q10_10 ///
    q10_11 q10_12 q10_13 q10_14 q10_16 q10_2 q10_2_1 q10_2_10 q10_2_11 q10_2_12 ///
    q10_2_14 q10_2_15 q10_2_16 q10_2_2 q10_2_3 q10_2_4 q10_2_5 q10_2_6 q10_2_7 q10_2_8 ///
    q10_2_9 q10_2_98 q10_4 q10_6 q2_1 q2_2 q2_3 q3 q3_1 q3_12 ///
    q3_15 q3_16 q3_17 q3_20 q3_21 q3_22 q3_23 q3_5 q3_6 q3_7 ///
    q3_8 q4 q4_1 q4_12 q4_12_1 q4_12_2 q4_12_3 q4_12_4 q4_13 q4_15 ///
    q4_16 q4_17 q4_1_1 q4_1_2 q4_1_3 q4_1_4 q4_1_5 q4_1_6 q4_1_7 q4_1_8 ///
    q4_1_9 q4_1_98 q4_24 q4_25 q4_26 q4_27 q4_5 q4_6 q5 q5_13 ///
    q5_13_1 q5_13_2 q5_13_3 q5_13_4 q5_13_5 q5_13_6 q5_13_7 q5_13_98 q5_14 q5_15 ///
    q5_16 q5_2 q5_21 q5_22 q5_23 q5_2_1 q5_2_2 q5_2_3 q5_2_4 q5_2_5 ///
    q5_2_6 q5_2_98 q5_5 q5_7 q5_9 q6_11 q6_13 q6_14 q6_15 q6_16 ///
    q6_17 q6_18 q6_2 q6_20 q6_21 q6_22 q6_23 q6_24 q6_4 q6_6 ///
    q6_9 q7_1 q7_10 q7_11 q7_12 q7_13 q7_14 q7_15 q7_2 q7_5 ///
    q7_6 q7_7 q7_8 q7_9 q9_1 q9_11 q9_13 q9_15 q9_16 q9_17 ///
    q9_17_1 q9_17_2 q9_17_3 q9_17_4 q9_17_5 q9_17_98 q9_18 q9_19 q9_20 q9_21 ///
    q9_21_1 q9_21_2 q9_21_3 q9_21_4 q9_21_5 q9_22 q9_4 q9_5 q9_6 q9_7 ///
    q9_8 q9_9 starttime using "$wp07_target33_carrier", clear
assert _N == 423
assert inlist(formdef_version,2512090157,2512091719,2512111044,2512121811,2602120658)
confirm string variable KEY
local storage : type KEY
assert "`storage'" == "str41"
confirm numeric variable SubmissionDate
local storage : type SubmissionDate
assert "`storage'" == "double"
confirm numeric variable consent
local storage : type consent
assert "`storage'" == "byte"
confirm numeric variable eligible_flag
local storage : type eligible_flag
assert "`storage'" == "byte"
confirm numeric variable endtime
local storage : type endtime
assert "`storage'" == "double"
confirm numeric variable fecha
local storage : type fecha
assert "`storage'" == "float"
confirm numeric variable formdef_version
local storage : type formdef_version
assert "`storage'" == "double"
confirm numeric variable q1
local storage : type q1
assert "`storage'" == "byte"
confirm numeric variable q10_1
local storage : type q10_1
assert "`storage'" == "byte"
confirm numeric variable q10_10
local storage : type q10_10
assert "`storage'" == "byte"
confirm numeric variable q10_11
local storage : type q10_11
assert "`storage'" == "byte"
confirm numeric variable q10_12
local storage : type q10_12
assert "`storage'" == "byte"
confirm numeric variable q10_13
local storage : type q10_13
assert "`storage'" == "byte"
confirm numeric variable q10_14
local storage : type q10_14
assert "`storage'" == "byte"
confirm numeric variable q10_16
local storage : type q10_16
assert "`storage'" == "byte"
confirm string variable q10_2
local storage : type q10_2
assert "`storage'" == "str15"
confirm numeric variable q10_2_1
local storage : type q10_2_1
assert "`storage'" == "byte"
confirm numeric variable q10_2_10
local storage : type q10_2_10
assert "`storage'" == "byte"
confirm numeric variable q10_2_11
local storage : type q10_2_11
assert "`storage'" == "byte"
confirm numeric variable q10_2_12
local storage : type q10_2_12
assert "`storage'" == "byte"
confirm numeric variable q10_2_14
local storage : type q10_2_14
assert "`storage'" == "byte"
confirm numeric variable q10_2_15
local storage : type q10_2_15
assert "`storage'" == "byte"
confirm numeric variable q10_2_16
local storage : type q10_2_16
assert "`storage'" == "byte"
confirm numeric variable q10_2_2
local storage : type q10_2_2
assert "`storage'" == "byte"
confirm numeric variable q10_2_3
local storage : type q10_2_3
assert "`storage'" == "byte"
confirm numeric variable q10_2_4
local storage : type q10_2_4
assert "`storage'" == "byte"
confirm numeric variable q10_2_5
local storage : type q10_2_5
assert "`storage'" == "byte"
confirm numeric variable q10_2_6
local storage : type q10_2_6
assert "`storage'" == "byte"
confirm numeric variable q10_2_7
local storage : type q10_2_7
assert "`storage'" == "byte"
confirm numeric variable q10_2_8
local storage : type q10_2_8
assert "`storage'" == "byte"
confirm numeric variable q10_2_9
local storage : type q10_2_9
assert "`storage'" == "byte"
confirm numeric variable q10_2_98
local storage : type q10_2_98
assert "`storage'" == "byte"
confirm numeric variable q10_4
local storage : type q10_4
assert "`storage'" == "byte"
confirm numeric variable q10_6
local storage : type q10_6
assert "`storage'" == "byte"
confirm numeric variable q2_1
local storage : type q2_1
assert "`storage'" == "int"
confirm numeric variable q2_2
local storage : type q2_2
assert "`storage'" == "byte"
confirm numeric variable q2_3
local storage : type q2_3
assert "`storage'" == "byte"
confirm numeric variable q3
local storage : type q3
assert "`storage'" == "byte"
confirm numeric variable q3_1
local storage : type q3_1
assert "`storage'" == "byte"
confirm numeric variable q3_12
local storage : type q3_12
assert "`storage'" == "byte"
confirm numeric variable q3_15
local storage : type q3_15
assert "`storage'" == "byte"
confirm numeric variable q3_16
local storage : type q3_16
assert "`storage'" == "byte"
confirm numeric variable q3_17
local storage : type q3_17
assert "`storage'" == "byte"
confirm numeric variable q3_20
local storage : type q3_20
assert "`storage'" == "byte"
confirm numeric variable q3_21
local storage : type q3_21
assert "`storage'" == "byte"
confirm numeric variable q3_22
local storage : type q3_22
assert "`storage'" == "byte"
confirm numeric variable q3_23
local storage : type q3_23
assert "`storage'" == "byte"
confirm numeric variable q3_5
local storage : type q3_5
assert "`storage'" == "byte"
confirm numeric variable q3_6
local storage : type q3_6
assert "`storage'" == "byte"
confirm numeric variable q3_7
local storage : type q3_7
assert "`storage'" == "byte"
confirm numeric variable q3_8
local storage : type q3_8
assert "`storage'" == "byte"
confirm numeric variable q4
local storage : type q4
assert "`storage'" == "byte"
confirm string variable q4_1
local storage : type q4_1
assert "`storage'" == "str7"
confirm string variable q4_12
local storage : type q4_12
assert "`storage'" == "str5"
confirm numeric variable q4_12_1
local storage : type q4_12_1
assert "`storage'" == "byte"
confirm numeric variable q4_12_2
local storage : type q4_12_2
assert "`storage'" == "byte"
confirm numeric variable q4_12_3
local storage : type q4_12_3
assert "`storage'" == "byte"
confirm numeric variable q4_12_4
local storage : type q4_12_4
assert "`storage'" == "byte"
confirm numeric variable q4_13
local storage : type q4_13
assert "`storage'" == "byte"
confirm numeric variable q4_15
local storage : type q4_15
assert "`storage'" == "byte"
confirm numeric variable q4_16
local storage : type q4_16
assert "`storage'" == "byte"
confirm numeric variable q4_17
local storage : type q4_17
assert "`storage'" == "byte"
confirm numeric variable q4_1_1
local storage : type q4_1_1
assert "`storage'" == "byte"
confirm numeric variable q4_1_2
local storage : type q4_1_2
assert "`storage'" == "byte"
confirm numeric variable q4_1_3
local storage : type q4_1_3
assert "`storage'" == "byte"
confirm numeric variable q4_1_4
local storage : type q4_1_4
assert "`storage'" == "byte"
confirm numeric variable q4_1_5
local storage : type q4_1_5
assert "`storage'" == "byte"
confirm numeric variable q4_1_6
local storage : type q4_1_6
assert "`storage'" == "byte"
confirm numeric variable q4_1_7
local storage : type q4_1_7
assert "`storage'" == "byte"
confirm numeric variable q4_1_8
local storage : type q4_1_8
assert "`storage'" == "byte"
confirm numeric variable q4_1_9
local storage : type q4_1_9
assert "`storage'" == "byte"
confirm numeric variable q4_1_98
local storage : type q4_1_98
assert "`storage'" == "byte"
confirm numeric variable q4_24
local storage : type q4_24
assert "`storage'" == "byte"
confirm numeric variable q4_25
local storage : type q4_25
assert "`storage'" == "byte"
confirm numeric variable q4_26
local storage : type q4_26
assert "`storage'" == "byte"
confirm numeric variable q4_27
local storage : type q4_27
assert "`storage'" == "byte"
confirm numeric variable q4_5
local storage : type q4_5
assert "`storage'" == "byte"
confirm numeric variable q4_6
local storage : type q4_6
assert "`storage'" == "byte"
confirm numeric variable q5
local storage : type q5
assert "`storage'" == "byte"
confirm string variable q5_13
local storage : type q5_13
assert "`storage'" == "str13"
confirm numeric variable q5_13_1
local storage : type q5_13_1
assert "`storage'" == "byte"
confirm numeric variable q5_13_2
local storage : type q5_13_2
assert "`storage'" == "byte"
confirm numeric variable q5_13_3
local storage : type q5_13_3
assert "`storage'" == "byte"
confirm numeric variable q5_13_4
local storage : type q5_13_4
assert "`storage'" == "byte"
confirm numeric variable q5_13_5
local storage : type q5_13_5
assert "`storage'" == "byte"
confirm numeric variable q5_13_6
local storage : type q5_13_6
assert "`storage'" == "byte"
confirm numeric variable q5_13_7
local storage : type q5_13_7
assert "`storage'" == "byte"
confirm numeric variable q5_13_98
local storage : type q5_13_98
assert "`storage'" == "byte"
confirm numeric variable q5_14
local storage : type q5_14
assert "`storage'" == "byte"
confirm numeric variable q5_15
local storage : type q5_15
assert "`storage'" == "byte"
confirm numeric variable q5_16
local storage : type q5_16
assert "`storage'" == "byte"
confirm string variable q5_2
local storage : type q5_2
assert "`storage'" == "str7"
confirm numeric variable q5_21
local storage : type q5_21
assert "`storage'" == "byte"
confirm numeric variable q5_22
local storage : type q5_22
assert "`storage'" == "byte"
confirm numeric variable q5_23
local storage : type q5_23
assert "`storage'" == "byte"
confirm numeric variable q5_2_1
local storage : type q5_2_1
assert "`storage'" == "byte"
confirm numeric variable q5_2_2
local storage : type q5_2_2
assert "`storage'" == "byte"
confirm numeric variable q5_2_3
local storage : type q5_2_3
assert "`storage'" == "byte"
confirm numeric variable q5_2_4
local storage : type q5_2_4
assert "`storage'" == "byte"
confirm numeric variable q5_2_5
local storage : type q5_2_5
assert "`storage'" == "byte"
confirm numeric variable q5_2_6
local storage : type q5_2_6
assert "`storage'" == "byte"
confirm numeric variable q5_2_98
local storage : type q5_2_98
assert "`storage'" == "byte"
confirm numeric variable q5_5
local storage : type q5_5
assert "`storage'" == "byte"
confirm numeric variable q5_7
local storage : type q5_7
assert "`storage'" == "byte"
confirm numeric variable q5_9
local storage : type q5_9
assert "`storage'" == "byte"
confirm numeric variable q6_11
local storage : type q6_11
assert "`storage'" == "byte"
confirm numeric variable q6_13
local storage : type q6_13
assert "`storage'" == "byte"
confirm numeric variable q6_14
local storage : type q6_14
assert "`storage'" == "byte"
confirm numeric variable q6_15
local storage : type q6_15
assert "`storage'" == "byte"
confirm numeric variable q6_16
local storage : type q6_16
assert "`storage'" == "byte"
confirm numeric variable q6_17
local storage : type q6_17
assert "`storage'" == "byte"
confirm numeric variable q6_18
local storage : type q6_18
assert "`storage'" == "byte"
confirm numeric variable q6_2
local storage : type q6_2
assert "`storage'" == "byte"
confirm numeric variable q6_20
local storage : type q6_20
assert "`storage'" == "byte"
confirm numeric variable q6_21
local storage : type q6_21
assert "`storage'" == "byte"
confirm numeric variable q6_22
local storage : type q6_22
assert "`storage'" == "byte"
confirm numeric variable q6_23
local storage : type q6_23
assert "`storage'" == "byte"
confirm numeric variable q6_24
local storage : type q6_24
assert "`storage'" == "byte"
confirm numeric variable q6_4
local storage : type q6_4
assert "`storage'" == "byte"
confirm numeric variable q6_6
local storage : type q6_6
assert "`storage'" == "byte"
confirm numeric variable q6_9
local storage : type q6_9
assert "`storage'" == "byte"
confirm numeric variable q7_1
local storage : type q7_1
assert "`storage'" == "byte"
confirm numeric variable q7_10
local storage : type q7_10
assert "`storage'" == "byte"
confirm numeric variable q7_11
local storage : type q7_11
assert "`storage'" == "byte"
confirm numeric variable q7_12
local storage : type q7_12
assert "`storage'" == "byte"
confirm numeric variable q7_13
local storage : type q7_13
assert "`storage'" == "byte"
confirm numeric variable q7_14
local storage : type q7_14
assert "`storage'" == "byte"
confirm numeric variable q7_15
local storage : type q7_15
assert "`storage'" == "byte"
confirm numeric variable q7_2
local storage : type q7_2
assert "`storage'" == "byte"
confirm numeric variable q7_5
local storage : type q7_5
assert "`storage'" == "byte"
confirm numeric variable q7_6
local storage : type q7_6
assert "`storage'" == "byte"
confirm numeric variable q7_7
local storage : type q7_7
assert "`storage'" == "byte"
confirm numeric variable q7_8
local storage : type q7_8
assert "`storage'" == "byte"
confirm numeric variable q7_9
local storage : type q7_9
assert "`storage'" == "byte"
confirm numeric variable q9_1
local storage : type q9_1
assert "`storage'" == "byte"
confirm numeric variable q9_11
local storage : type q9_11
assert "`storage'" == "byte"
confirm numeric variable q9_13
local storage : type q9_13
assert "`storage'" == "byte"
confirm numeric variable q9_15
local storage : type q9_15
assert "`storage'" == "byte"
confirm numeric variable q9_16
local storage : type q9_16
assert "`storage'" == "byte"
confirm string variable q9_17
local storage : type q9_17
assert "`storage'" == "str7"
confirm numeric variable q9_17_1
local storage : type q9_17_1
assert "`storage'" == "byte"
confirm numeric variable q9_17_2
local storage : type q9_17_2
assert "`storage'" == "byte"
confirm numeric variable q9_17_3
local storage : type q9_17_3
assert "`storage'" == "byte"
confirm numeric variable q9_17_4
local storage : type q9_17_4
assert "`storage'" == "byte"
confirm numeric variable q9_17_5
local storage : type q9_17_5
assert "`storage'" == "byte"
confirm numeric variable q9_17_98
local storage : type q9_17_98
assert "`storage'" == "byte"
confirm numeric variable q9_18
local storage : type q9_18
assert "`storage'" == "byte"
confirm numeric variable q9_19
local storage : type q9_19
assert "`storage'" == "byte"
confirm numeric variable q9_20
local storage : type q9_20
assert "`storage'" == "byte"
confirm string variable q9_21
local storage : type q9_21
assert "`storage'" == "str5"
confirm numeric variable q9_21_1
local storage : type q9_21_1
assert "`storage'" == "byte"
confirm numeric variable q9_21_2
local storage : type q9_21_2
assert "`storage'" == "byte"
confirm numeric variable q9_21_3
local storage : type q9_21_3
assert "`storage'" == "byte"
confirm numeric variable q9_21_4
local storage : type q9_21_4
assert "`storage'" == "byte"
confirm numeric variable q9_21_5
local storage : type q9_21_5
assert "`storage'" == "byte"
confirm numeric variable q9_22
local storage : type q9_22
assert "`storage'" == "byte"
confirm numeric variable q9_4
local storage : type q9_4
assert "`storage'" == "byte"
confirm numeric variable q9_5
local storage : type q9_5
assert "`storage'" == "byte"
confirm numeric variable q9_6
local storage : type q9_6
assert "`storage'" == "byte"
confirm numeric variable q9_7
local storage : type q9_7
assert "`storage'" == "byte"
confirm numeric variable q9_8
local storage : type q9_8
assert "`storage'" == "byte"
confirm numeric variable q9_9
local storage : type q9_9
assert "`storage'" == "byte"
confirm numeric variable starttime
local storage : type starttime
assert "`storage'" == "double"
quietly datasignature
global wp07_target33_signature "`r(datasignature)'"
global wp07_target33_step 1
tempname out
file open `out' using "$wp07_target33_out/carrier_and_membership_checks.csv", write text
file write `out' "check_id,expected_n,observed_n,discrepancy_n,status,limitation" _n
file write `out' "P1.01,NA,NA,NA,indeterminate,Opaque admission hash is in the restricted execution receipt" _n
quietly count if 1
file write `out' "P1.02,423," (r(N)) ",0,supported,Historical coded cohort only" _n
quietly preserve
tempvar duplicate
quietly duplicates tag KEY, generate(`duplicate')
quietly count if missing(KEY) | `duplicate' > 0
file write `out' "P1.03,0,NA," (r(N)) ",indeterminate,Missing or duplicate submission keys not duplicate persons" _n
quietly restore
file write `out' "P1.04,NA,NA,NA,indeterminate,Projection checked; exit signature comparison is P4.07" _n
quietly count if consent == 1
local yes = r(N)
file write `out' "P1.05,NA," (`yes') "," (_N-`yes') "," (cond(`yes'==_N,"supported","unsupported")) ",Recorded consent support only" _n
quietly count if q1 == 1
local yes = r(N)
file write `out' "P1.06,NA," (`yes') "," (_N-`yes') "," (cond(`yes'==_N,"supported","unsupported")) ",Positive woman response not exclusion by complement" _n
quietly count if inrange(q4,18,100) & q4 == floor(q4)
local yes = r(N)
file write `out' "P1.07,NA," (`yes') "," (_N-`yes') "," (cond(`yes'==_N,"supported","unsupported")) ",Recorded age domain" _n
quietly count if q5 == 1
local yes = r(N)
file write `out' "P1.08,NA," (`yes') "," (_N-`yes') "," (cond(`yes'==_N,"supported","unsupported")) ",Respondent or household receipt in preceding 12 months" _n
quietly count if !missing(eligible_flag,consent,q1,q4,q5) & eligible_flag != (consent==1 & q1==1 & q4>=18 & q5==1)
file write `out' "P1.09,0,NA," (r(N)) ",indeterminate,Comparable stored helper only; missing or unverified screen states not certified" _n
file close `out'
