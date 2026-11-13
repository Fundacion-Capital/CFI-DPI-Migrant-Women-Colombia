* Deliberately invented records; this script has no file reader.
args case
if "`case'" == "aq02" {
    set obs 1
}
else if "`case'" == "aq03" {
    set obs 422
}
else {
    set obs 423
}
foreach v in formdef_version eligible_flag consent q1 q5 q3 q3_1 q3_5 q3_6 q3_7 q3_8 q3_12 ///
    q2_1 q2_2 q2_3 q4 q3_15 q3_16 q3_17 q3_20 q3_21 q3_22 q3_23 q4_1 ///
    q4_5 q4_6 q4_12 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 q4_26 q4_27 q5_13 ///
    q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 q6_13 q6_14 q6_15 q6_6 ///
    q6_9 q6_11 q6_16 q6_17 q6_18 q6_20 q6_21 q6_22 q6_23 q6_24 q7_1 q7_2 ///
    q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 q7_11 q7_12 q7_13 q7_14 q7_15 q9_4 ///
    q9_5 q9_6 q9_7 q9_8 q9_9 q9_11 q9_13 q9_16 q9_18 q9_19 q9_20 q9_1 ///
    q9_15 q9_17 q9_21 q9_22 q10_4 q10_6 q10_10 q10_11 q10_12 q10_13 q10_14 q10_16 ///
    q10_1 q10_2 {
    if inlist("`v'", "q4_1", "q4_12", "q5_13", "q9_17", "q9_21", "q10_2") {
        generate str12 `v' = ""
    }
    else {
        generate double `v' = .
    }
}
if "`case'" == "aq02" {
    drop in 1
}
if "`case'" == "aq06" {
    drop q4_1
    generate byte q4_1 = 1
}
if _N == 0 | "`case'" == "aq03" {
    exit
}
replace formdef_version = 2602120658
replace eligible_flag = 1
replace q4 = 37
replace q6_13 = 1
replace q6_14 = 0
if "`case'" != "aq05" {
    replace formdef_version = 2512090157 in 1
    replace formdef_version = 2512091719 in 2
    replace formdef_version = 2512111044 in 3
    replace formdef_version = 2512121811 in 4
    replace formdef_version = 999999999 in 6
    replace q6_14 = 1 in 1/4
    replace q6_15 = 3 in 1
    replace q6_15 = 98 in 2
    replace q6_15 = 77 in 4
    replace q6_13 = 2 in 2
    replace q2_1 = .a in 1
    replace q2_1 = .z in 2
    if "`case'" != "aq06" {
        replace q4_1 = "1 2" in 1
        label variable q4_1 "Artificial string parent"
    }
    label data "Artificial WP07 fixture only"
    label define aq_binary 0 "No" 1 "Yes"
    label values q6_14 aq_binary
    notes q6_14: Artificial fixture note
}
