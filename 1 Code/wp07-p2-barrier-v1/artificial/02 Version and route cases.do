* Version and route state cases -- artificial-only draft, not run.
* No source or participant file is loaded. Do not remove the hold under this task.
exit 198

version 16
assert _N == 0

* q3: expected code/route states are literal; no new eligibility rule.
input double formdef_version byte eligible_flag double q3 byte expected
2512090157 1 4 1
2512111044 1 4 1
2602120658 1 5 1
2512090157 1 5 6
9999999999 1 4 6
2602120658 1 . 4
end
* BEGIN REPORT_STATE_q3
gen byte _ar_q3 = 6
gen byte _ara_q3 = .
replace _ara_q3 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811) & (1)
replace _ara_q3 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811) & (0)
replace _ar_q3 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811) & _ara_q3 == 0 & (missing(q3))
replace _ar_q3 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811) & _ara_q3 == 1 & (missing(q3))
replace _ar_q3 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811) & _ara_q3 == 1 & (q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4)
replace _ara_q3 = 1 if inlist(formdef_version, 2602120658) & (1)
replace _ara_q3 = 0 if inlist(formdef_version, 2602120658) & (0)
replace _ar_q3 = 2 if inlist(formdef_version, 2602120658) & _ara_q3 == 0 & (missing(q3))
replace _ar_q3 = 4 if inlist(formdef_version, 2602120658) & _ara_q3 == 1 & (missing(q3))
replace _ar_q3 = 1 if inlist(formdef_version, 2602120658) & _ara_q3 == 1 & (q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4 | q3 == 5)
* END REPORT_STATE_q3
assert _N == 6
assert _ar_q3 == expected
* Only this file's literal artificial rows exist: remove them for the next independent case family.
drop _all
assert _N == 0

* q3_15: expected code/route states are literal; no new eligibility rule.
input double formdef_version byte eligible_flag double q3_1 double q3_15 byte expected
2602120658 1 1 3 1
2602120658 1 2 . 2
2602120658 1 3 3 6
2602120658 1 . . 6
2602120658 1 1 . 4
end
* BEGIN REPORT_STATE_q3_15
gen byte _ar_q3_15 = 6
gen byte _ara_q3_15 = .
replace _ara_q3_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)))
replace _ara_q3_15 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)))
replace _ar_q3_15 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_15 == 0 & (missing(q3_15))
replace _ar_q3_15 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_15 == 1 & (missing(q3_15))
replace _ar_q3_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_15 == 1 & (q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
* END REPORT_STATE_q3_15
assert _N == 5
assert _ar_q3_15 == expected
* Only this file's literal artificial rows exist: remove them for the next independent case family.
drop _all
assert _N == 0

* q6_15: expected code/route states are literal; no new eligibility rule.
input double formdef_version byte eligible_flag double q6_14 double q6_15 byte expected
2602120658 1 1 1 1
2602120658 1 1 98 5
2602120658 1 0 . 2
2602120658 1 0 1 6
2602120658 1 98 . 2
2602120658 1 . . 6
end
* BEGIN REPORT_STATE_q6_15
gen byte _ar_q6_15 = 6
gen byte _ara_q6_15 = .
replace _ara_q6_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace _ara_q6_15 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace _ar_q6_15 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_15 == 0 & (missing(q6_15))
replace _ar_q6_15 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_15 == 1 & (missing(q6_15))
replace _ar_q6_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_15 == 1 & (q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
replace _ar_q6_15 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_15 == 1 & (q6_15 == 98)
* END REPORT_STATE_q6_15
assert _N == 6
assert _ar_q6_15 == expected
* Only this file's literal artificial rows exist: remove them for the next independent case family.
drop _all
assert _N == 0

* q7_2: expected code/route states are literal; no new eligibility rule.
input double formdef_version byte eligible_flag double q7_1 double q7_2 byte expected
2602120658 1 1 1 1
2602120658 1 2 5 1
2602120658 1 3 . 2
2602120658 1 4 1 6
2602120658 1 . . 6
end
* BEGIN REPORT_STATE_q7_2
gen byte _ar_q7_2 = 6
gen byte _ara_q7_2 = .
replace _ara_q7_2 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 1)) | ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 2))))
replace _ara_q7_2 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 1)) & ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 2))))
replace _ar_q7_2 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_2 == 0 & (missing(q7_2))
replace _ar_q7_2 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_2 == 1 & (missing(q7_2))
replace _ar_q7_2 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_2 == 1 & (q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
* END REPORT_STATE_q7_2
assert _N == 5
assert _ar_q7_2 == expected
* Only this file's literal artificial rows exist: remove them for the next independent case family.
drop _all
assert _N == 0

* q7_13: expected code/route states are literal; no new eligibility rule.
input double formdef_version byte eligible_flag double q7_11 double q7_12 double q7_13 byte expected
2602120658 1 1 1 5 1
2602120658 1 1 6 . 2
2602120658 1 1 . . 6
2512090157 1 1 7 2 1
2602120658 1 1 7 2 6
2602120658 1 0 1 . 2
end
* BEGIN REPORT_STATE_q7_13
gen byte _ar_q7_13 = 6
gen byte _ara_q7_13 = .
replace _ara_q7_13 = 1 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & (q7_12 != 6))))
replace _ara_q7_13 = 0 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & !(q7_12 != 6))))
replace _ar_q7_13 = 2 if inlist(formdef_version, 2512090157) & _ara_q7_13 == 0 & (missing(q7_13))
replace _ar_q7_13 = 4 if inlist(formdef_version, 2512090157) & _ara_q7_13 == 1 & (missing(q7_13))
replace _ar_q7_13 = 1 if inlist(formdef_version, 2512090157) & _ara_q7_13 == 1 & (q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
replace _ara_q7_13 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
replace _ara_q7_13 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
replace _ar_q7_13 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_13 == 0 & (missing(q7_13))
replace _ar_q7_13 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_13 == 1 & (missing(q7_13))
replace _ar_q7_13 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_13 == 1 & (q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
* END REPORT_STATE_q7_13
assert _N == 6
assert _ar_q7_13 == expected
* Only this file's literal artificial rows exist: remove them for the next independent case family.
drop _all
assert _N == 0

* q9_21: expected code/route states are literal; no new eligibility rule.
input double formdef_version byte eligible_flag double q9_20 str15 q9_21 byte expected
2602120658 1 1 "1 2" 1
2602120658 1 0 "" 2
2602120658 1 98 "" 2
2602120658 1 1 "98" 6
2602120658 1 . "" 6
end
* BEGIN REPORT_STATE_q9_21
gen byte _ar_q9_21 = 6
gen byte _ara_q9_21 = .
replace _ara_q9_21 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & (q9_20 == 1)))
replace _ara_q9_21 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & !(q9_20 == 1)))
replace _ar_q9_21 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_21 == 0 & (strtrim(q9_21) == "")
replace _ar_q9_21 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_21 == 1 & (strtrim(q9_21) == "")
replace _ar_q9_21 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_21 == 1 & (regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
* END REPORT_STATE_q9_21
assert _N == 5
assert _ar_q9_21 == expected
* Only this file's literal artificial rows exist: remove them for the next independent case family.
drop _all
assert _N == 0

* q10_12: expected code/route states are literal; no new eligibility rule.
input double formdef_version byte eligible_flag double q10_10 double q10_12 byte expected
2602120658 1 1 3 1
2602120658 1 2 5 1
2602120658 1 3 . 2
2602120658 1 98 . 2
2602120658 1 1 . 4
end
* BEGIN REPORT_STATE_q10_12
gen byte _ar_q10_12 = 6
gen byte _ara_q10_12 = .
replace _ara_q10_12 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
replace _ara_q10_12 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
replace _ar_q10_12 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_12 == 0 & (missing(q10_12))
replace _ar_q10_12 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_12 == 1 & (missing(q10_12))
replace _ar_q10_12 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_12 == 1 & (q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
* END REPORT_STATE_q10_12
assert _N == 5
assert _ar_q10_12 == expected
* Only this file's literal artificial rows exist: remove them for the next independent case family.
drop _all
assert _N == 0

* q2_1: expected code/route states are literal; no new eligibility rule.
input double formdef_version byte eligible_flag double q2_1 byte expected
2602120658 1 1950 1
2602120658 1 2026 1
2602120658 1 2027 6
2602120658 1 2025.5 6
2602120658 1 . 4
end
* BEGIN REPORT_STATE_q2_1
gen byte _ar_q2_1 = 6
gen byte _ara_q2_1 = .
replace _ara_q2_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q2_1 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q2_1 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_1 == 0 & (missing(q2_1))
replace _ar_q2_1 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_1 == 1 & (missing(q2_1))
replace _ar_q2_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_1 == 1 & (inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
* END REPORT_STATE_q2_1
assert _N == 5
assert _ar_q2_1 == expected
* Only this file's literal artificial rows exist: remove them for the next independent case family.
drop _all
assert _N == 0

* q4: expected code/route states are literal; no new eligibility rule.
input double formdef_version byte consent double q4 byte expected
2602120658 1 18 1
2602120658 1 100 1
2602120658 1 17 6
2602120658 1 18.5 6
2602120658 1 . 4
end
* BEGIN REPORT_STATE_q4
gen byte _ar_q4 = 6
gen byte _ara_q4 = .
replace _ara_q4 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
replace _ara_q4 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
replace _ar_q4 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4 == 0 & (missing(q4))
replace _ar_q4 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4 == 1 & (missing(q4))
replace _ar_q4 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4 == 1 & (inrange(q4,18,100) & q4 == floor(q4))
* END REPORT_STATE_q4
assert _N == 5
assert _ar_q4 == expected
* Only this file's literal artificial rows exist: remove them for the next independent case family.
drop _all
assert _N == 0
