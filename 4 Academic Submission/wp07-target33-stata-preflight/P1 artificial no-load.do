* TARGET33 P1: exact projection and screening support -- held source; no execution authority.
* The protected dispatcher must validate the pinned contract before invoking this selection.
* Source digest and access are checked outside Stata; never substitute another file.
* Artificial memory only. The historical load is replaced, not redirected.
assert _N == 0
quietly set obs 423
quietly generate str41 KEY = ""
quietly generate double SubmissionDate = .
quietly generate byte consent = .
quietly generate byte eligible_flag = .
quietly generate double endtime = .
quietly generate float fecha = .
quietly generate double formdef_version = .
quietly generate byte q1 = .
quietly generate byte q10_1 = .
quietly generate byte q10_10 = .
quietly generate byte q10_11 = .
quietly generate byte q10_12 = .
quietly generate byte q10_13 = .
quietly generate byte q10_14 = .
quietly generate byte q10_16 = .
quietly generate str15 q10_2 = ""
quietly generate byte q10_2_1 = .
quietly generate byte q10_2_10 = .
quietly generate byte q10_2_11 = .
quietly generate byte q10_2_12 = .
quietly generate byte q10_2_14 = .
quietly generate byte q10_2_15 = .
quietly generate byte q10_2_16 = .
quietly generate byte q10_2_2 = .
quietly generate byte q10_2_3 = .
quietly generate byte q10_2_4 = .
quietly generate byte q10_2_5 = .
quietly generate byte q10_2_6 = .
quietly generate byte q10_2_7 = .
quietly generate byte q10_2_8 = .
quietly generate byte q10_2_9 = .
quietly generate byte q10_2_98 = .
quietly generate byte q10_4 = .
quietly generate byte q10_6 = .
quietly generate int q2_1 = .
quietly generate byte q2_2 = .
quietly generate byte q2_3 = .
quietly generate byte q3 = .
quietly generate byte q3_1 = .
quietly generate byte q3_12 = .
quietly generate byte q3_15 = .
quietly generate byte q3_16 = .
quietly generate byte q3_17 = .
quietly generate byte q3_20 = .
quietly generate byte q3_21 = .
quietly generate byte q3_22 = .
quietly generate byte q3_23 = .
quietly generate byte q3_5 = .
quietly generate byte q3_6 = .
quietly generate byte q3_7 = .
quietly generate byte q3_8 = .
quietly generate byte q4 = .
quietly generate str7 q4_1 = ""
quietly generate str5 q4_12 = ""
quietly generate byte q4_12_1 = .
quietly generate byte q4_12_2 = .
quietly generate byte q4_12_3 = .
quietly generate byte q4_12_4 = .
quietly generate byte q4_13 = .
quietly generate byte q4_15 = .
quietly generate byte q4_16 = .
quietly generate byte q4_17 = .
quietly generate byte q4_1_1 = .
quietly generate byte q4_1_2 = .
quietly generate byte q4_1_3 = .
quietly generate byte q4_1_4 = .
quietly generate byte q4_1_5 = .
quietly generate byte q4_1_6 = .
quietly generate byte q4_1_7 = .
quietly generate byte q4_1_8 = .
quietly generate byte q4_1_9 = .
quietly generate byte q4_1_98 = .
quietly generate byte q4_24 = .
quietly generate byte q4_25 = .
quietly generate byte q4_26 = .
quietly generate byte q4_27 = .
quietly generate byte q4_5 = .
quietly generate byte q4_6 = .
quietly generate byte q5 = .
quietly generate str13 q5_13 = ""
quietly generate byte q5_13_1 = .
quietly generate byte q5_13_2 = .
quietly generate byte q5_13_3 = .
quietly generate byte q5_13_4 = .
quietly generate byte q5_13_5 = .
quietly generate byte q5_13_6 = .
quietly generate byte q5_13_7 = .
quietly generate byte q5_13_98 = .
quietly generate byte q5_14 = .
quietly generate byte q5_15 = .
quietly generate byte q5_16 = .
quietly generate str7 q5_2 = ""
quietly generate byte q5_21 = .
quietly generate byte q5_22 = .
quietly generate byte q5_23 = .
quietly generate byte q5_2_1 = .
quietly generate byte q5_2_2 = .
quietly generate byte q5_2_3 = .
quietly generate byte q5_2_4 = .
quietly generate byte q5_2_5 = .
quietly generate byte q5_2_6 = .
quietly generate byte q5_2_98 = .
quietly generate byte q5_5 = .
quietly generate byte q5_7 = .
quietly generate byte q5_9 = .
quietly generate byte q6_11 = .
quietly generate byte q6_13 = .
quietly generate byte q6_14 = .
quietly generate byte q6_15 = .
quietly generate byte q6_16 = .
quietly generate byte q6_17 = .
quietly generate byte q6_18 = .
quietly generate byte q6_2 = .
quietly generate byte q6_20 = .
quietly generate byte q6_21 = .
quietly generate byte q6_22 = .
quietly generate byte q6_23 = .
quietly generate byte q6_24 = .
quietly generate byte q6_4 = .
quietly generate byte q6_6 = .
quietly generate byte q6_9 = .
quietly generate byte q7_1 = .
quietly generate byte q7_10 = .
quietly generate byte q7_11 = .
quietly generate byte q7_12 = .
quietly generate byte q7_13 = .
quietly generate byte q7_14 = .
quietly generate byte q7_15 = .
quietly generate byte q7_2 = .
quietly generate byte q7_5 = .
quietly generate byte q7_6 = .
quietly generate byte q7_7 = .
quietly generate byte q7_8 = .
quietly generate byte q7_9 = .
quietly generate byte q9_1 = .
quietly generate byte q9_11 = .
quietly generate byte q9_13 = .
quietly generate byte q9_15 = .
quietly generate byte q9_16 = .
quietly generate str7 q9_17 = ""
quietly generate byte q9_17_1 = .
quietly generate byte q9_17_2 = .
quietly generate byte q9_17_3 = .
quietly generate byte q9_17_4 = .
quietly generate byte q9_17_5 = .
quietly generate byte q9_17_98 = .
quietly generate byte q9_18 = .
quietly generate byte q9_19 = .
quietly generate byte q9_20 = .
quietly generate str5 q9_21 = ""
quietly generate byte q9_21_1 = .
quietly generate byte q9_21_2 = .
quietly generate byte q9_21_3 = .
quietly generate byte q9_21_4 = .
quietly generate byte q9_21_5 = .
quietly generate byte q9_22 = .
quietly generate byte q9_4 = .
quietly generate byte q9_5 = .
quietly generate byte q9_6 = .
quietly generate byte q9_7 = .
quietly generate byte q9_8 = .
quietly generate byte q9_9 = .
quietly generate double starttime = .
quietly replace KEY = "FIXTURE-" + string(_n)
quietly replace formdef_version = 2512090157 if mod(_n,5)==0
quietly replace formdef_version = 2512091719 if mod(_n,5)==1
quietly replace formdef_version = 2512111044 if mod(_n,5)==2
quietly replace formdef_version = 2512121811 if mod(_n,5)==3
quietly replace formdef_version = 2602120658 if mod(_n,5)==4
quietly replace eligible_flag = 1
quietly replace consent = 1
quietly replace q1 = 1
quietly replace q4 = 30
quietly replace q5 = 1
quietly replace q3 = 4
quietly replace q3 = 5 if formdef_version == 2602120658
quietly replace q3_1 = 1
quietly replace q3_15 = 3
quietly replace q3_16 = 4
quietly replace q3_17 = 5
quietly replace q6_13 = 2
quietly replace q6_14 = 1
quietly replace q6_15 = 98
quietly replace q4_12 = "1"
quietly replace q4_12_1 = 1
quietly replace q4_12_2 = 0
quietly replace q4_12_3 = 0
quietly replace q4_12_4 = 0
quietly replace SubmissionDate = 2082758400000
quietly replace starttime = SubmissionDate
quietly replace endtime = starttime + 1000
quietly replace fecha = dofc(SubmissionDate)
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
