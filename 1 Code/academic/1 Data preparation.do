/*
CFI DPI — academic quantitative analysis
Authors: Jorge E. Zavala and Angélica Cardozo Cadavid
Integrated source revision: 7 November 2026. Stata 16 syntax.
*/
* Source-review candidate only. No execution is authorized by this code revision.
exit 198

version 16
set varabbrev off

* Input: the historical admitted cohort's fixed mixed-type research-field projection.
* Raw answers, recorded clocks and cohort membership are never modified here.
confirm numeric variable formdef_version eligible_flag consent q1 q5 q3 q3_1 q3_5 q3_6 q3_7 q3_8 q3_12 q2_1 ///
    q2_2 q2_3 q4 q3_15 q3_16 q3_17 q3_20 q3_21 q3_22 q3_23 q4_5 q4_6 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 ///
    q4_26 q4_27 q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 q6_13 q6_14 q6_15 q6_6 q6_9 q6_11 q6_16 q6_17 ///
    q6_18 q6_20 q6_21 q6_22 q6_23 q6_24 q7_1 q7_2 q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 q7_11 q7_12 q7_13 q7_14 ///
    q7_15 q9_4 q9_5 q9_6 q9_7 q9_8 q9_9 q9_11 q9_13 q9_16 q9_18 q9_19 q9_20 q9_1 q9_15 q9_22 q10_4 q10_6 ///
    q10_10 q10_11 q10_12 q10_13 q10_14 q10_16 q10_1, exact
confirm string variable q4_1 q4_12 q5_13 q9_17 q9_21 q10_2, exact

* The five submitted form versions have distinct offered options and routes.
gen byte wp07_known_form = inlist(formdef_version, 2512090157, 2512091719, ///
    2512111044, 2512121811, 2602120658) if !missing(formdef_version)

* Lexical checks are written once so repeated account/complaint routes remain readable.
* These flags validate a response string; they are not measures or a nonuse category.
gen byte _valid_q4_1_1 = (regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") ///
    & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + ///
    (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") ///
    > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", ///
    " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) ///
    + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
gen byte _valid_q4_12_1 = (regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ///
    ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", ///
    " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
gen byte _valid_q5_13_1 = (regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & ///
    wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + ///
    (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", ///
    " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
gen byte _valid_q9_17_1 = (regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & ///
    wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + ///
    (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", ///
    " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
gen byte _valid_q9_21_1 = (regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) ///
    == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", ///
    " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
gen byte _valid_q10_2_1 = (regexm(itrim(strtrim(q10_2)), ///
    "^(2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) ///
    == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", ///
    " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + ///
    (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", ///
    " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + ///
    (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", ///
    " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
gen byte _valid_q10_2_2 = (regexm(itrim(strtrim(q10_2)), ///
    "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & ///
    wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + ///
    (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", ///
    " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + ///
    (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", ///
    " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + ///
    itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + ///
    (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", ///
    " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))

* Six reporting states: never turn skips, refusal, uncertainty or unknown routes into zero.
label define wp07_response_state 1 "Ordinary valid" 2 "Structural skip" ///
    3 "Unavailable in version" 4 "Applicable nonresponse" ///
    5 "Item-specific sentinel" 6 "Unresolved"


* ============================================================================
* IAT: version, route and response-state classification

* ITEM q3_1 | ¿Usted tiene personalmente un teléfono móvil que usa con regularidad?
gen byte wp07_state_q3_1 = 6
gen byte wp07_route_q3_1 = .
replace wp07_route_q3_1 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q3_1 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q3_1 = 2 if (wp07_known_form == 1) & wp07_route_q3_1 == 0 & (missing(q3_1))
replace wp07_state_q3_1 = 4 if (wp07_known_form == 1) & wp07_route_q3_1 == 1 & (missing(q3_1))
replace wp07_state_q3_1 = 1 if (wp07_known_form == 1) & wp07_route_q3_1 == 1 & (q3_1 == 1 | q3_1 == 2 | q3_1 ///
    == 3)
assert inrange(wp07_state_q3_1, 1, 6)

* ITEM q3_5 | ¿Con qué frecuencia usa Internet en cualquier dispositivo?
gen byte wp07_state_q3_5 = 6
gen byte wp07_route_q3_5 = .
replace wp07_route_q3_5 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q3_5 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q3_5 = 2 if (wp07_known_form == 1) & wp07_route_q3_5 == 0 & (missing(q3_5))
replace wp07_state_q3_5 = 4 if (wp07_known_form == 1) & wp07_route_q3_5 == 1 & (missing(q3_5))
replace wp07_state_q3_5 = 1 if (wp07_known_form == 1) & wp07_route_q3_5 == 1 & (q3_5 == 1 | q3_5 == 2 | q3_5 ///
    == 3 | q3_5 == 4 | q3_5 == 5)
assert inrange(wp07_state_q3_5, 1, 6)

* ITEM q3_6 | ¿Dónde accede principalmente a Internet?
gen byte wp07_state_q3_6 = 6
gen byte wp07_route_q3_6 = .
replace wp07_route_q3_6 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5)))
replace wp07_route_q3_6 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5)))
replace wp07_state_q3_6 = 2 if (wp07_known_form == 1) & wp07_route_q3_6 == 0 & (missing(q3_6))
replace wp07_state_q3_6 = 4 if (wp07_known_form == 1) & wp07_route_q3_6 == 1 & (missing(q3_6))
replace wp07_state_q3_6 = 1 if (wp07_known_form == 1) & wp07_route_q3_6 == 1 & (q3_6 == 1 | q3_6 == 2 | q3_6 ///
    == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
assert inrange(wp07_state_q3_6, 1, 6)

* ITEM q3_7 | Actualmente, ¿cuenta con un plan de datos móviles activo en su teléfono principal?
gen byte wp07_state_q3_7 = 6
gen byte wp07_route_q3_7 = .
replace wp07_route_q3_7 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    (q3_1 == 2))))
replace wp07_route_q3_7 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    !(q3_1 == 2))))
replace wp07_state_q3_7 = 2 if (wp07_known_form == 1) & wp07_route_q3_7 == 0 & (missing(q3_7))
replace wp07_state_q3_7 = 4 if (wp07_known_form == 1) & wp07_route_q3_7 == 1 & (missing(q3_7))
replace wp07_state_q3_7 = 1 if (wp07_known_form == 1) & wp07_route_q3_7 == 1 & (q3_7 == 1 | q3_7 == 2 | q3_7 ///
    == 3 | q3_7 == 99)
replace wp07_state_q3_7 = 5 if (wp07_known_form == 1) & wp07_state_q3_7 == 1 & (q3_7 == 99)
assert inrange(wp07_state_q3_7, 1, 6)

* ITEM q3_8 | En el último mes, ¿se quedó sin datos o saldo y eso le impidió usar servicios financieros o comunicarse?
gen byte wp07_state_q3_8 = 6
gen byte wp07_route_q3_8 = .
replace wp07_route_q3_8 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    (q3_1 == 2))))
replace wp07_route_q3_8 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    !(q3_1 == 2))))
replace wp07_state_q3_8 = 2 if (wp07_known_form == 1) & wp07_route_q3_8 == 0 & (missing(q3_8))
replace wp07_state_q3_8 = 4 if (wp07_known_form == 1) & wp07_route_q3_8 == 1 & (missing(q3_8))
replace wp07_state_q3_8 = 1 if (wp07_known_form == 1) & wp07_route_q3_8 == 1 & (q3_8 == 1 | q3_8 == 2 | q3_8 ///
    == 3 | q3_8 == 99)
replace wp07_state_q3_8 = 5 if (wp07_known_form == 1) & wp07_state_q3_8 == 1 & (q3_8 == 99)
assert inrange(wp07_state_q3_8, 1, 6)

* ITEM q3_12 | ¿Puede leer mensajes cortos en su teléfono sin ayuda de otra persona?
gen byte wp07_state_q3_12 = 6
gen byte wp07_route_q3_12 = .
replace wp07_route_q3_12 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    (q3_1 == 2))))
replace wp07_route_q3_12 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    !(q3_1 == 2))))
replace wp07_state_q3_12 = 2 if (wp07_known_form == 1) & wp07_route_q3_12 == 0 & (missing(q3_12))
replace wp07_state_q3_12 = 4 if (wp07_known_form == 1) & wp07_route_q3_12 == 1 & (missing(q3_12))
replace wp07_state_q3_12 = 1 if (wp07_known_form == 1) & wp07_route_q3_12 == 1 & (q3_12 == 1 | q3_12 == 2 | ///
    q3_12 == 3)
assert inrange(wp07_state_q3_12, 1, 6)


* ============================================================================
* IVS: version, route and response-state classification

* ITEM q2_1 | ¿En qué año llegó a vivir a Colombia por primera vez?
* First-arrival calendar year only; no tenure, reference year, IVS gap or normalization is calculated.
gen byte wp07_state_q2_1 = 6
gen byte wp07_route_q2_1 = .
replace wp07_route_q2_1 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q2_1 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q2_1 = 2 if (wp07_known_form == 1) & wp07_route_q2_1 == 0 & (missing(q2_1))
replace wp07_state_q2_1 = 4 if (wp07_known_form == 1) & wp07_route_q2_1 == 1 & (missing(q2_1))
replace wp07_state_q2_1 = 1 if (wp07_known_form == 1) & wp07_route_q2_1 == 1 & (inrange(q2_1,1950,2026) & ///
    q2_1 == floor(q2_1))
assert inrange(wp07_state_q2_1, 1, 6)

* ITEM q2_2 | ¿Cuál es el último nivel de estudios que completó?
gen byte wp07_state_q2_2 = 6
gen byte wp07_route_q2_2 = .
replace wp07_route_q2_2 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q2_2 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q2_2 = 2 if (wp07_known_form == 1) & wp07_route_q2_2 == 0 & (missing(q2_2))
replace wp07_state_q2_2 = 4 if (wp07_known_form == 1) & wp07_route_q2_2 == 1 & (missing(q2_2))
replace wp07_state_q2_2 = 1 if (wp07_known_form == 1) & wp07_route_q2_2 == 1 & (q2_2 == 1 | q2_2 == 2 | q2_2 ///
    == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
assert inrange(wp07_state_q2_2, 1, 6)

* ITEM q2_3 | Actualmente, ¿cuál es su ocupación principal?
gen byte wp07_state_q2_3 = 6
gen byte wp07_route_q2_3 = .
replace wp07_route_q2_3 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q2_3 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q2_3 = 2 if (wp07_known_form == 1) & wp07_route_q2_3 == 0 & (missing(q2_3))
replace wp07_state_q2_3 = 4 if (wp07_known_form == 1) & wp07_route_q2_3 == 1 & (missing(q2_3))
replace wp07_state_q2_3 = 1 if (wp07_known_form == 1) & wp07_route_q2_3 == 1 & (q2_3 == 1 | q2_3 == 2 | q2_3 ///
    == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
assert inrange(wp07_state_q2_3, 1, 6)

* ITEM q4 | ¿Cuál es su edad en años cumplidos?
gen byte wp07_state_q4 = 6
gen byte wp07_route_q4 = .
replace wp07_route_q4 = 1 if (wp07_known_form == 1) & ((consent == 0 | consent == 1 | consent == 98) & ///
    (consent == 1))
replace wp07_route_q4 = 0 if (wp07_known_form == 1) & ((consent == 0 | consent == 1 | consent == 98) & ///
    !(consent == 1))
replace wp07_state_q4 = 2 if (wp07_known_form == 1) & wp07_route_q4 == 0 & (missing(q4))
replace wp07_state_q4 = 4 if (wp07_known_form == 1) & wp07_route_q4 == 1 & (missing(q4))
replace wp07_state_q4 = 1 if (wp07_known_form == 1) & wp07_route_q4 == 1 & (inrange(q4,18,100) & q4 == ///
    floor(q4))
assert inrange(wp07_state_q4, 1, 6)

* ITEM q3 | Residence geography; accepted D2 version-aware meanings
* D2 meanings: early code 4 Other; later code 4 Soacha; code 5 Meta only in the latest version.
gen byte wp07_state_q3 = 6
gen byte wp07_route_q3 = .
replace wp07_route_q3 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811) & (1)
replace wp07_route_q3 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811) & (0)
replace wp07_state_q3 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811) & ///
    wp07_route_q3 == 0 & (missing(q3))
replace wp07_state_q3 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811) & ///
    wp07_route_q3 == 1 & (missing(q3))
replace wp07_state_q3 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811) & ///
    wp07_route_q3 == 1 & (q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4)
replace wp07_route_q3 = 1 if inlist(formdef_version, 2602120658) & (1)
replace wp07_route_q3 = 0 if inlist(formdef_version, 2602120658) & (0)
replace wp07_state_q3 = 2 if inlist(formdef_version, 2602120658) & wp07_route_q3 == 0 & (missing(q3))
replace wp07_state_q3 = 4 if inlist(formdef_version, 2602120658) & wp07_route_q3 == 1 & (missing(q3))
replace wp07_state_q3 = 1 if inlist(formdef_version, 2602120658) & wp07_route_q3 == 1 & (q3 == 1 | q3 == 2 | ///
    q3 == 3 | q3 == 4 | q3 == 5)
assert inrange(wp07_state_q3, 1, 6)


* ============================================================================
* IADT: version, route and response-state classification

* ITEM q3_15 | Sé descargar e instalar una aplicación en mi teléfono.
gen byte wp07_state_q3_15 = 6
gen byte wp07_route_q3_15 = .
replace wp07_route_q3_15 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)))
replace wp07_route_q3_15 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)))
replace wp07_state_q3_15 = 2 if (wp07_known_form == 1) & wp07_route_q3_15 == 0 & (missing(q3_15))
replace wp07_state_q3_15 = 4 if (wp07_known_form == 1) & wp07_route_q3_15 == 1 & (missing(q3_15))
replace wp07_state_q3_15 = 1 if (wp07_known_form == 1) & wp07_route_q3_15 == 1 & (q3_15 == 1 | q3_15 == 2 | ///
    q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
assert inrange(wp07_state_q3_15, 1, 6)

* ITEM q3_16 | Sé usar mi teléfono para enviar o recibir dinero (transferencias, billetera digital, pago móvil).
gen byte wp07_state_q3_16 = 6
gen byte wp07_route_q3_16 = .
replace wp07_route_q3_16 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    (q3_1 == 2))))
replace wp07_route_q3_16 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    !(q3_1 == 2))))
replace wp07_state_q3_16 = 2 if (wp07_known_form == 1) & wp07_route_q3_16 == 0 & (missing(q3_16))
replace wp07_state_q3_16 = 4 if (wp07_known_form == 1) & wp07_route_q3_16 == 1 & (missing(q3_16))
replace wp07_state_q3_16 = 1 if (wp07_known_form == 1) & wp07_route_q3_16 == 1 & (q3_16 == 1 | q3_16 == 2 | ///
    q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
assert inrange(wp07_state_q3_16, 1, 6)

* ITEM q3_17 | Me siento segura evitando fraudes y mensajes sospechosos en línea (PIN, códigos OTP, enlaces).
gen byte wp07_state_q3_17 = 6
gen byte wp07_route_q3_17 = .
replace wp07_route_q3_17 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q3_17 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q3_17 = 2 if (wp07_known_form == 1) & wp07_route_q3_17 == 0 & (missing(q3_17))
replace wp07_state_q3_17 = 4 if (wp07_known_form == 1) & wp07_route_q3_17 == 1 & (missing(q3_17))
replace wp07_state_q3_17 = 1 if (wp07_known_form == 1) & wp07_route_q3_17 == 1 & (q3_17 == 1 | q3_17 == 2 | ///
    q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
assert inrange(wp07_state_q3_17, 1, 6)


* ============================================================================
* ICDP: version, route and response-state classification

* ITEM q3_20 | En los últimos 3 meses, ¿escaneó un código QR para pagar o para que le paguen?
gen byte wp07_state_q3_20 = 6
gen byte wp07_route_q3_20 = .
replace wp07_route_q3_20 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 ///
    == 4 | q3_5 == 5) & (q3_5 != 5))))
replace wp07_route_q3_20 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 ///
    == 4 | q3_5 == 5) & !(q3_5 != 5))))
replace wp07_state_q3_20 = 2 if (wp07_known_form == 1) & wp07_route_q3_20 == 0 & (missing(q3_20))
replace wp07_state_q3_20 = 4 if (wp07_known_form == 1) & wp07_route_q3_20 == 1 & (missing(q3_20))
replace wp07_state_q3_20 = 1 if (wp07_known_form == 1) & wp07_route_q3_20 == 1 & (q3_20 == 1 | q3_20 == 2 | ///
    q3_20 == 3 | q3_20 == 4)
assert inrange(wp07_state_q3_20, 1, 6)

* ITEM q3_21 | Si recibe un SMS con un código de verificación (OTP), ¿puede leerlo y usarlo sin ayuda?
gen byte wp07_state_q3_21 = 6
gen byte wp07_route_q3_21 = .
replace wp07_route_q3_21 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    (q3_1 == 2))))
replace wp07_route_q3_21 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    !(q3_1 == 2))))
replace wp07_state_q3_21 = 2 if (wp07_known_form == 1) & wp07_route_q3_21 == 0 & (missing(q3_21))
replace wp07_state_q3_21 = 4 if (wp07_known_form == 1) & wp07_route_q3_21 == 1 & (missing(q3_21))
replace wp07_state_q3_21 = 1 if (wp07_known_form == 1) & wp07_route_q3_21 == 1 & (q3_21 == 1 | q3_21 == 2 | ///
    q3_21 == 3 | q3_21 == 4)
replace wp07_state_q3_21 = 5 if (wp07_known_form == 1) & wp07_state_q3_21 == 1 & (q3_21 == 4)
assert inrange(wp07_state_q3_21, 1, 6)

* ITEM q3_22 | ¿Sabe crear o cambiar el PIN de su aplicación bancaria o billetera digital?
gen byte wp07_state_q3_22 = 6
gen byte wp07_route_q3_22 = .
replace wp07_route_q3_22 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    (q3_1 == 2))))
replace wp07_route_q3_22 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & ///
    !(q3_1 == 2))))
replace wp07_state_q3_22 = 2 if (wp07_known_form == 1) & wp07_route_q3_22 == 0 & (missing(q3_22))
replace wp07_state_q3_22 = 4 if (wp07_known_form == 1) & wp07_route_q3_22 == 1 & (missing(q3_22))
replace wp07_state_q3_22 = 1 if (wp07_known_form == 1) & wp07_route_q3_22 == 1 & (q3_22 == 1 | q3_22 == 2 | ///
    q3_22 == 3)
replace wp07_state_q3_22 = 5 if (wp07_known_form == 1) & wp07_state_q3_22 == 1 & (q3_22 == 3)
assert inrange(wp07_state_q3_22, 1, 6)

* ITEM q3_23 | Si recibe por WhatsApp o SMS un mensaje sospechoso que solicita dinero, claves o códigos, ¿qué haría primero?
gen byte wp07_state_q3_23 = 6
gen byte wp07_route_q3_23 = .
replace wp07_route_q3_23 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 ///
    == 4 | q3_5 == 5) & (q3_5 != 5))))
replace wp07_route_q3_23 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 ///
    == 4 | q3_5 == 5) & !(q3_5 != 5))))
replace wp07_state_q3_23 = 2 if (wp07_known_form == 1) & wp07_route_q3_23 == 0 & (missing(q3_23))
replace wp07_state_q3_23 = 4 if (wp07_known_form == 1) & wp07_route_q3_23 == 1 & (missing(q3_23))
replace wp07_state_q3_23 = 1 if (wp07_known_form == 1) & wp07_route_q3_23 == 1 & (q3_23 == 1 | q3_23 == 2 | ///
    q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
replace wp07_state_q3_23 = 5 if (wp07_known_form == 1) & wp07_state_q3_23 == 1 & (q3_23 == 5)
assert inrange(wp07_state_q3_23, 1, 6)


* ============================================================================
* IAFF: version, route and response-state classification

* ITEM q4_1 | ¿Cuáles de los siguientes documentos de identidad posee actualmente? (Marque todas las que apliquen).
gen byte wp07_state_q4_1 = 6
gen byte wp07_route_q4_1 = .
replace wp07_route_q4_1 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q4_1 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q4_1 = 2 if (wp07_known_form == 1) & wp07_route_q4_1 == 0 & (strtrim(q4_1) == "")
replace wp07_state_q4_1 = 4 if (wp07_known_form == 1) & wp07_route_q4_1 == 1 & (strtrim(q4_1) == "")
replace wp07_state_q4_1 = 1 if (wp07_known_form == 1) & wp07_route_q4_1 == 1 & (_valid_q4_1_1 == 1)
replace wp07_state_q4_1 = 6 if (wp07_known_form == 1) & wp07_state_q4_1 == 1 & (strpos(" " + ///
    itrim(strtrim(q4_1)) + " ", " 9 ") > 0) & wordcount(q4_1) > 1
replace wp07_state_q4_1 = 6 if (wp07_known_form == 1) & wp07_state_q4_1 == 1 & (strpos(" " + ///
    itrim(strtrim(q4_1)) + " ", " 98 ") > 0) & wordcount(q4_1) > 1
replace wp07_state_q4_1 = 5 if (wp07_known_form == 1) & wp07_state_q4_1 == 1 & (strtrim(q4_1) == "98")
assert inrange(wp07_state_q4_1, 1, 6)

* ITEM q4_5 | ¿Tiene a su nombre algún comprobante de dirección aceptado por entidades financieras (recibo de servicios, contrato de arriendo, certificado de residencia)?
gen byte wp07_state_q4_5 = 6
gen byte wp07_route_q4_5 = .
replace wp07_route_q4_5 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q4_5 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q4_5 = 2 if (wp07_known_form == 1) & wp07_route_q4_5 == 0 & (missing(q4_5))
replace wp07_state_q4_5 = 4 if (wp07_known_form == 1) & wp07_route_q4_5 == 1 & (missing(q4_5))
replace wp07_state_q4_5 = 1 if (wp07_known_form == 1) & wp07_route_q4_5 == 1 & (q4_5 == 1 | q4_5 == 2 | q4_5 ///
    == 3 | q4_5 == 4)
replace wp07_state_q4_5 = 5 if (wp07_known_form == 1) & wp07_state_q4_5 == 1 & (q4_5 == 3)
replace wp07_state_q4_5 = 5 if (wp07_known_form == 1) & wp07_state_q4_5 == 1 & (q4_5 == 4)
assert inrange(wp07_state_q4_5, 1, 6)

* ITEM q4_6 | El número de teléfono que normalmente usa para sus cuentas o billeteras digitales, ¿está registrado a su nombre?
gen byte wp07_state_q4_6 = 6
gen byte wp07_route_q4_6 = .
replace wp07_route_q4_6 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q4_6 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q4_6 = 2 if (wp07_known_form == 1) & wp07_route_q4_6 == 0 & (missing(q4_6))
replace wp07_state_q4_6 = 4 if (wp07_known_form == 1) & wp07_route_q4_6 == 1 & (missing(q4_6))
replace wp07_state_q4_6 = 1 if (wp07_known_form == 1) & wp07_route_q4_6 == 1 & (q4_6 == 1 | q4_6 == 2 | q4_6 ///
    == 3 | q4_6 == 4)
replace wp07_state_q4_6 = 5 if (wp07_known_form == 1) & wp07_state_q4_6 == 1 & (q4_6 == 4)
assert inrange(wp07_state_q4_6, 1, 6)

* ITEM q4_12 | ¿Usted tiene personalmente alguna cuenta en una institución financiera o una cuenta/billetera de dinero móvil? (Marque todas las que apliquen).
gen byte wp07_state_q4_12 = 6
gen byte wp07_route_q4_12 = .
replace wp07_route_q4_12 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q4_12 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q4_12 = 2 if (wp07_known_form == 1) & wp07_route_q4_12 == 0 & (strtrim(q4_12) == "")
replace wp07_state_q4_12 = 4 if (wp07_known_form == 1) & wp07_route_q4_12 == 1 & (strtrim(q4_12) == "")
replace wp07_state_q4_12 = 1 if (wp07_known_form == 1) & wp07_route_q4_12 == 1 & (_valid_q4_12_1 == 1)
assert inrange(wp07_state_q4_12, 1, 6)


* ============================================================================
* IUOF: version, route and response-state classification

* ITEM q4_13 | De las cuentas o billeteras que mencionó, ¿cuál es la principal para recibir o manejar dinero?
gen byte wp07_state_q4_13 = 6
gen byte wp07_route_q4_13 = .
replace wp07_route_q4_13 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q4_13 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q4_13 = 2 if (wp07_known_form == 1) & wp07_route_q4_13 == 0 & (missing(q4_13))
replace wp07_state_q4_13 = 4 if (wp07_known_form == 1) & wp07_route_q4_13 == 1 & (missing(q4_13))
replace wp07_state_q4_13 = 1 if (wp07_known_form == 1) & wp07_route_q4_13 == 1 & (q4_13 == 1 | q4_13 == 2 | ///
    q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
assert inrange(wp07_state_q4_13, 1, 6)

* ITEM q4_15 | En los últimos 60 días (2 meses), ¿con qué frecuencia usó su cuenta o billetera principal para cualquier operación (recibir, pagar, retirar, consultar saldo)?
gen byte wp07_state_q4_15 = 6
gen byte wp07_route_q4_15 = .
replace wp07_route_q4_15 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q4_15 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q4_15 = 2 if (wp07_known_form == 1) & wp07_route_q4_15 == 0 & (missing(q4_15))
replace wp07_state_q4_15 = 4 if (wp07_known_form == 1) & wp07_route_q4_15 == 1 & (missing(q4_15))
replace wp07_state_q4_15 = 1 if (wp07_known_form == 1) & wp07_route_q4_15 == 1 & (q4_15 == 1 | q4_15 == 2 | ///
    q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
assert inrange(wp07_state_q4_15, 1, 6)

* ITEM q4_16 | ¿Qué tan fácil le resulta depositar o retirar efectivo (cash-in / cash-out) cerca de su vivienda o trabajo?
gen byte wp07_state_q4_16 = 6
gen byte wp07_route_q4_16 = .
replace wp07_route_q4_16 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q4_16 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q4_16 = 2 if (wp07_known_form == 1) & wp07_route_q4_16 == 0 & (missing(q4_16))
replace wp07_state_q4_16 = 4 if (wp07_known_form == 1) & wp07_route_q4_16 == 1 & (missing(q4_16))
replace wp07_state_q4_16 = 1 if (wp07_known_form == 1) & wp07_route_q4_16 == 1 & (q4_16 == 1 | q4_16 == 2 | ///
    q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
replace wp07_state_q4_16 = 5 if (wp07_known_form == 1) & wp07_state_q4_16 == 1 & (q4_16 == 99)
assert inrange(wp07_state_q4_16, 1, 6)

* ITEM q4_17 | ¿Aproximadamente cuánto tiempo tarda en llegar al punto de agente, cajero o sucursal más cercano donde puede hacer cash-in/cash-out?
gen byte wp07_state_q4_17 = 6
gen byte wp07_route_q4_17 = .
replace wp07_route_q4_17 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q4_17 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q4_17 = 2 if (wp07_known_form == 1) & wp07_route_q4_17 == 0 & (missing(q4_17))
replace wp07_state_q4_17 = 4 if (wp07_known_form == 1) & wp07_route_q4_17 == 1 & (missing(q4_17))
replace wp07_state_q4_17 = 1 if (wp07_known_form == 1) & wp07_route_q4_17 == 1 & (q4_17 == 1 | q4_17 == 2 | ///
    q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
replace wp07_state_q4_17 = 5 if (wp07_known_form == 1) & wp07_state_q4_17 == 1 & (q4_17 == 99)
assert inrange(wp07_state_q4_17, 1, 6)

* ITEM q4_24 | ¿Usa su cuenta o billetera principal para pagar en comercios (por ejemplo, QR, transferencia, datafono sin tarjeta física)?
gen byte wp07_state_q4_24 = 6
gen byte wp07_route_q4_24 = .
replace wp07_route_q4_24 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q4_24 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q4_24 = 2 if (wp07_known_form == 1) & wp07_route_q4_24 == 0 & (missing(q4_24))
replace wp07_state_q4_24 = 4 if (wp07_known_form == 1) & wp07_route_q4_24 == 1 & (missing(q4_24))
replace wp07_state_q4_24 = 1 if (wp07_known_form == 1) & wp07_route_q4_24 == 1 & (q4_24 == 1 | q4_24 == 2 | ///
    q4_24 == 3 | q4_24 == 99)
replace wp07_state_q4_24 = 5 if (wp07_known_form == 1) & wp07_state_q4_24 == 1 & (q4_24 == 99)
assert inrange(wp07_state_q4_24, 1, 6)

* ITEM q4_25 | ¿Mantiene ahorros en su cuenta o billetera principal (es decir, deja dinero guardado por más de una semana)?
gen byte wp07_state_q4_25 = 6
gen byte wp07_route_q4_25 = .
replace wp07_route_q4_25 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q4_25 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q4_25 = 2 if (wp07_known_form == 1) & wp07_route_q4_25 == 0 & (missing(q4_25))
replace wp07_state_q4_25 = 4 if (wp07_known_form == 1) & wp07_route_q4_25 == 1 & (missing(q4_25))
replace wp07_state_q4_25 = 1 if (wp07_known_form == 1) & wp07_route_q4_25 == 1 & (q4_25 == 1 | q4_25 == 2 | ///
    q4_25 == 3 | q4_25 == 99)
replace wp07_state_q4_25 = 5 if (wp07_known_form == 1) & wp07_state_q4_25 == 1 & (q4_25 == 99)
assert inrange(wp07_state_q4_25, 1, 6)

* ITEM q4_26 | ¿Recibe notificaciones (SMS o app) cuando llega una transferencia o remesa a su cuenta o billetera principal?
gen byte wp07_state_q4_26 = 6
gen byte wp07_route_q4_26 = .
replace wp07_route_q4_26 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q4_26 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q4_26 = 2 if (wp07_known_form == 1) & wp07_route_q4_26 == 0 & (missing(q4_26))
replace wp07_state_q4_26 = 4 if (wp07_known_form == 1) & wp07_route_q4_26 == 1 & (missing(q4_26))
replace wp07_state_q4_26 = 1 if (wp07_known_form == 1) & wp07_route_q4_26 == 1 & (q4_26 == 1 | q4_26 == 2 | ///
    q4_26 == 3 | q4_26 == 99)
replace wp07_state_q4_26 = 5 if (wp07_known_form == 1) & wp07_state_q4_26 == 1 & (q4_26 == 99)
assert inrange(wp07_state_q4_26, 1, 6)

* ITEM q4_27 | En los últimos 60 días (2 meses), ¿prestó su cuenta o billetera a otra persona para que recibiera o moviera dinero?
gen byte wp07_state_q4_27 = 6
gen byte wp07_route_q4_27 = .
replace wp07_route_q4_27 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q4_27 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q4_27 = 2 if (wp07_known_form == 1) & wp07_route_q4_27 == 0 & (missing(q4_27))
replace wp07_state_q4_27 = 4 if (wp07_known_form == 1) & wp07_route_q4_27 == 1 & (missing(q4_27))
replace wp07_state_q4_27 = 1 if (wp07_known_form == 1) & wp07_route_q4_27 == 1 & (q4_27 == 0 | q4_27 == 1 | ///
    q4_27 == 98)
replace wp07_state_q4_27 = 5 if (wp07_known_form == 1) & wp07_state_q4_27 == 1 & (q4_27 == 98)
assert inrange(wp07_state_q4_27, 1, 6)


* ============================================================================
* OQI: version, route and response-state classification

* ITEM q5_13 | En su registro (onboarding) más reciente, ¿qué le pidieron para verificar su identidad? (Marque todo lo que aplique).
gen byte wp07_state_q5_13 = 6
gen byte wp07_route_q5_13 = .
replace wp07_route_q5_13 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q5_13 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q5_13 = 2 if (wp07_known_form == 1) & wp07_route_q5_13 == 0 & (strtrim(q5_13) == "")
replace wp07_state_q5_13 = 4 if (wp07_known_form == 1) & wp07_route_q5_13 == 1 & (strtrim(q5_13) == "")
replace wp07_state_q5_13 = 1 if (wp07_known_form == 1) & wp07_route_q5_13 == 1 & (_valid_q5_13_1 == 1)
replace wp07_state_q5_13 = 6 if (wp07_known_form == 1) & wp07_state_q5_13 == 1 & (strpos(" " + ///
    itrim(strtrim(q5_13)) + " ", " 98 ") > 0) & wordcount(q5_13) > 1
replace wp07_state_q5_13 = 5 if (wp07_known_form == 1) & wp07_state_q5_13 == 1 & (strtrim(q5_13) == "98")
assert inrange(wp07_state_q5_13, 1, 6)

* ITEM q5_14 | En general, ¿qué tan fácil o difícil fue completar el registro hasta poder usar la cuenta o billetera principal?
gen byte wp07_state_q5_14 = 6
gen byte wp07_route_q5_14 = .
replace wp07_route_q5_14 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q5_14 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q5_14 = 2 if (wp07_known_form == 1) & wp07_route_q5_14 == 0 & (missing(q5_14))
replace wp07_state_q5_14 = 4 if (wp07_known_form == 1) & wp07_route_q5_14 == 1 & (missing(q5_14))
replace wp07_state_q5_14 = 1 if (wp07_known_form == 1) & wp07_route_q5_14 == 1 & (q5_14 == 1 | q5_14 == 2 | ///
    q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
replace wp07_state_q5_14 = 5 if (wp07_known_form == 1) & wp07_state_q5_14 == 1 & (q5_14 == 98)
assert inrange(wp07_state_q5_14, 1, 6)

* ITEM q5_15 | ¿Cuánto tiempo tardó su registro hasta que la cuenta o billetera quedó activada para recibir o enviar dinero?
gen byte wp07_state_q5_15 = 6
gen byte wp07_route_q5_15 = .
replace wp07_route_q5_15 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q5_15 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q5_15 = 2 if (wp07_known_form == 1) & wp07_route_q5_15 == 0 & (missing(q5_15))
replace wp07_state_q5_15 = 4 if (wp07_known_form == 1) & wp07_route_q5_15 == 1 & (missing(q5_15))
replace wp07_state_q5_15 = 1 if (wp07_known_form == 1) & wp07_route_q5_15 == 1 & (q5_15 == 1 | q5_15 == 2 | ///
    q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
replace wp07_state_q5_15 = 5 if (wp07_known_form == 1) & wp07_state_q5_15 == 1 & (q5_15 == 98)
assert inrange(wp07_state_q5_15, 1, 6)

* ITEM q5_16 | ¿Necesitó ayuda para registrarse en esa cuenta o billetera principal?
gen byte wp07_state_q5_16 = 6
gen byte wp07_route_q5_16 = .
replace wp07_route_q5_16 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q5_16 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q5_16 = 2 if (wp07_known_form == 1) & wp07_route_q5_16 == 0 & (missing(q5_16))
replace wp07_state_q5_16 = 4 if (wp07_known_form == 1) & wp07_route_q5_16 == 1 & (missing(q5_16))
replace wp07_state_q5_16 = 1 if (wp07_known_form == 1) & wp07_route_q5_16 == 1 & (q5_16 == 0 | q5_16 == 1 | ///
    q5_16 == 98)
replace wp07_state_q5_16 = 5 if (wp07_known_form == 1) & wp07_state_q5_16 == 1 & (q5_16 == 98)
assert inrange(wp07_state_q5_16, 1, 6)

* ITEM q5_21 | ¿Recuerda haber aceptado términos y condiciones y autorización de manejo de datos personales durante el registro?
gen byte wp07_state_q5_21 = 6
gen byte wp07_route_q5_21 = .
replace wp07_route_q5_21 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q5_21 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q5_21 = 2 if (wp07_known_form == 1) & wp07_route_q5_21 == 0 & (missing(q5_21))
replace wp07_state_q5_21 = 4 if (wp07_known_form == 1) & wp07_route_q5_21 == 1 & (missing(q5_21))
replace wp07_state_q5_21 = 1 if (wp07_known_form == 1) & wp07_route_q5_21 == 1 & (q5_21 == 1 | q5_21 == 2 | ///
    q5_21 == 3 | q5_21 == 98)
replace wp07_state_q5_21 = 5 if (wp07_known_form == 1) & wp07_state_q5_21 == 1 & (q5_21 == 98)
assert inrange(wp07_state_q5_21, 1, 6)

* ITEM q5_22 | En su opinión, ¿el registro protegió adecuadamente su privacidad (solo pidió lo necesario y explicó el uso de sus datos)?
gen byte wp07_state_q5_22 = 6
gen byte wp07_route_q5_22 = .
replace wp07_route_q5_22 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q5_22 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q5_22 = 2 if (wp07_known_form == 1) & wp07_route_q5_22 == 0 & (missing(q5_22))
replace wp07_state_q5_22 = 4 if (wp07_known_form == 1) & wp07_route_q5_22 == 1 & (missing(q5_22))
replace wp07_state_q5_22 = 1 if (wp07_known_form == 1) & wp07_route_q5_22 == 1 & (q5_22 == 1 | q5_22 == 2 | ///
    q5_22 == 3 | q5_22 == 98)
replace wp07_state_q5_22 = 5 if (wp07_known_form == 1) & wp07_state_q5_22 == 1 & (q5_22 == 98)
assert inrange(wp07_state_q5_22, 1, 6)

* ITEM q5_23 | En el registro o en el primer uso, ¿el sistema o app ofreció mensajes en español claro y algún tipo de asistencia (tutorial, ayuda paso a paso, chat)?
gen byte wp07_state_q5_23 = 6
gen byte wp07_route_q5_23 = .
replace wp07_route_q5_23 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | ///
    (((_valid_q4_12_1 == 1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((_valid_q4_12_1 == ///
    1) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((_valid_q4_12_1 == 1) & (strpos(" " + ///
    itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_route_q5_23 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & ///
    (((_valid_q4_12_1 == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((_valid_q4_12_1 ///
    == 1) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((_valid_q4_12_1 == 1) & !(strpos(" " ///
    + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace wp07_state_q5_23 = 2 if (wp07_known_form == 1) & wp07_route_q5_23 == 0 & (missing(q5_23))
replace wp07_state_q5_23 = 4 if (wp07_known_form == 1) & wp07_route_q5_23 == 1 & (missing(q5_23))
replace wp07_state_q5_23 = 1 if (wp07_known_form == 1) & wp07_route_q5_23 == 1 & (q5_23 == 1 | q5_23 == 2 | ///
    q5_23 == 3 | q5_23 == 98)
replace wp07_state_q5_23 = 5 if (wp07_known_form == 1) & wp07_state_q5_23 == 1 & (q5_23 == 98)
assert inrange(wp07_state_q5_23, 1, 6)


* ============================================================================
* IURD: version, route and response-state classification

* ITEM q6_2 | Pensando solo en los últimos 12 meses, ¿con qué frecuencia recibió remesas del exterior?
gen byte wp07_state_q6_2 = 6
gen byte wp07_route_q6_2 = .
replace wp07_route_q6_2 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q6_2 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q6_2 = 2 if (wp07_known_form == 1) & wp07_route_q6_2 == 0 & (missing(q6_2))
replace wp07_state_q6_2 = 4 if (wp07_known_form == 1) & wp07_route_q6_2 == 1 & (missing(q6_2))
replace wp07_state_q6_2 = 1 if (wp07_known_form == 1) & wp07_route_q6_2 == 1 & (q6_2 == 1 | q6_2 == 2 | q6_2 ///
    == 3 | q6_2 == 99)
replace wp07_state_q6_2 = 5 if (wp07_known_form == 1) & wp07_state_q6_2 == 1 & (q6_2 == 99)
assert inrange(wp07_state_q6_2, 1, 6)

* ITEM q6_4 | ¿A través de qué canal recibió esa remesa más reciente?
gen byte wp07_state_q6_4 = 6
gen byte wp07_route_q6_4 = .
replace wp07_route_q6_4 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q6_4 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q6_4 = 2 if (wp07_known_form == 1) & wp07_route_q6_4 == 0 & (missing(q6_4))
replace wp07_state_q6_4 = 4 if (wp07_known_form == 1) & wp07_route_q6_4 == 1 & (missing(q6_4))
replace wp07_state_q6_4 = 1 if (wp07_known_form == 1) & wp07_route_q6_4 == 1 & (q6_4 == 1 | q6_4 == 2 | q6_4 ///
    == 3 | q6_4 == 4 | q6_4 == 5)
assert inrange(wp07_state_q6_4, 1, 6)

* ITEM q6_13 | En general, pensando en todas las remesas que recibe, ¿qué proporción termina en efectivo y qué proporción se mantiene o usa de forma digital?
* Keep all five dispositions; not a monetary share or the latest receipt channel.
gen byte wp07_state_q6_13 = 6
gen byte wp07_route_q6_13 = .
replace wp07_route_q6_13 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q6_13 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q6_13 = 2 if (wp07_known_form == 1) & wp07_route_q6_13 == 0 & (missing(q6_13))
replace wp07_state_q6_13 = 4 if (wp07_known_form == 1) & wp07_route_q6_13 == 1 & (missing(q6_13))
replace wp07_state_q6_13 = 1 if (wp07_known_form == 1) & wp07_route_q6_13 == 1 & (q6_13 == 1 | q6_13 == 2 | ///
    q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
assert inrange(wp07_state_q6_13, 1, 6)

* ITEM q6_14 | En los últimos 60 días (2 meses), ¿realizó o recibió pagos digitales o remesas dentro de Colombia usando apps, transferencias, billeteras o códigos QR?
gen byte wp07_state_q6_14 = 6
gen byte wp07_route_q6_14 = .
replace wp07_route_q6_14 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q6_14 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q6_14 = 2 if (wp07_known_form == 1) & wp07_route_q6_14 == 0 & (missing(q6_14))
replace wp07_state_q6_14 = 4 if (wp07_known_form == 1) & wp07_route_q6_14 == 1 & (missing(q6_14))
replace wp07_state_q6_14 = 1 if (wp07_known_form == 1) & wp07_route_q6_14 == 1 & (q6_14 == 0 | q6_14 == 1 | ///
    q6_14 == 98)
replace wp07_state_q6_14 = 5 if (wp07_known_form == 1) & wp07_state_q6_14 == 1 & (q6_14 == 98)
assert inrange(wp07_state_q6_14, 1, 6)

* ITEM q6_15 | En esos últimos 60 días (2 meses), aproximadamente ¿cuántas operaciones digitales (enviar o recibir dinero) realizó en total?
* Operation bins only under affirmative domestic participation; uncertainty is separate, not the lowest bin.
gen byte wp07_state_q6_15 = 6
gen byte wp07_route_q6_15 = .
replace wp07_route_q6_15 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace wp07_route_q6_15 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace wp07_state_q6_15 = 2 if (wp07_known_form == 1) & wp07_route_q6_15 == 0 & (missing(q6_15))
replace wp07_state_q6_15 = 4 if (wp07_known_form == 1) & wp07_route_q6_15 == 1 & (missing(q6_15))
replace wp07_state_q6_15 = 1 if (wp07_known_form == 1) & wp07_route_q6_15 == 1 & (q6_15 == 1 | q6_15 == 2 | ///
    q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
replace wp07_state_q6_15 = 5 if (wp07_known_form == 1) & wp07_state_q6_15 == 1 & (q6_15 == 98)
assert inrange(wp07_state_q6_15, 1, 6)


* ============================================================================
* IETR: version, route and response-state classification

* ITEM q6_6 | ¿Cuánto tiempo pasó desde que la persona que envió la remesa hizo el envío hasta que usted pudo usar el dinero?
gen byte wp07_state_q6_6 = 6
gen byte wp07_route_q6_6 = .
replace wp07_route_q6_6 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q6_6 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q6_6 = 2 if (wp07_known_form == 1) & wp07_route_q6_6 == 0 & (missing(q6_6))
replace wp07_state_q6_6 = 4 if (wp07_known_form == 1) & wp07_route_q6_6 == 1 & (missing(q6_6))
replace wp07_state_q6_6 = 1 if (wp07_known_form == 1) & wp07_route_q6_6 == 1 & (q6_6 == 1 | q6_6 == 2 | q6_6 ///
    == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
replace wp07_state_q6_6 = 5 if (wp07_known_form == 1) & wp07_state_q6_6 == 1 & (q6_6 == 98)
assert inrange(wp07_state_q6_6, 1, 6)

* ITEM q6_9 | Pensando en esa remesa más reciente, ¿qué tan clara fue para usted la tasa de cambio aplicada (si hubo cambio de moneda)?
gen byte wp07_state_q6_9 = 6
gen byte wp07_route_q6_9 = .
replace wp07_route_q6_9 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q6_9 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q6_9 = 2 if (wp07_known_form == 1) & wp07_route_q6_9 == 0 & (missing(q6_9))
replace wp07_state_q6_9 = 4 if (wp07_known_form == 1) & wp07_route_q6_9 == 1 & (missing(q6_9))
replace wp07_state_q6_9 = 1 if (wp07_known_form == 1) & wp07_route_q6_9 == 1 & (q6_9 == 1 | q6_9 == 2 | q6_9 ///
    == 3 | q6_9 == 4 | q6_9 == 99)
replace wp07_state_q6_9 = 5 if (wp07_known_form == 1) & wp07_state_q6_9 == 1 & (q6_9 == 99)
assert inrange(wp07_state_q6_9, 1, 6)

* ITEM q6_11 | ¿Recibió alguna confirmación cuando llegó esa remesa (SMS, notificación de app, correo electrónico o recibo en papel)?
gen byte wp07_state_q6_11 = 6
gen byte wp07_route_q6_11 = .
replace wp07_route_q6_11 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q6_11 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q6_11 = 2 if (wp07_known_form == 1) & wp07_route_q6_11 == 0 & (missing(q6_11))
replace wp07_state_q6_11 = 4 if (wp07_known_form == 1) & wp07_route_q6_11 == 1 & (missing(q6_11))
replace wp07_state_q6_11 = 1 if (wp07_known_form == 1) & wp07_route_q6_11 == 1 & (q6_11 == 1 | q6_11 == 2 | ///
    q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
replace wp07_state_q6_11 = 5 if (wp07_known_form == 1) & wp07_state_q6_11 == 1 & (q6_11 == 98)
assert inrange(wp07_state_q6_11, 1, 6)

* ITEM q6_16 | En esos últimos 60 días (2 meses), ¿tuvo algún problema con pagos o transferencias digitales (por ejemplo, dinero que no llegó, reversos, operaciones rechazadas o duplicadas)?
gen byte wp07_state_q6_16 = 6
gen byte wp07_route_q6_16 = .
replace wp07_route_q6_16 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace wp07_route_q6_16 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace wp07_state_q6_16 = 2 if (wp07_known_form == 1) & wp07_route_q6_16 == 0 & (missing(q6_16))
replace wp07_state_q6_16 = 4 if (wp07_known_form == 1) & wp07_route_q6_16 == 1 & (missing(q6_16))
replace wp07_state_q6_16 = 1 if (wp07_known_form == 1) & wp07_route_q6_16 == 1 & (q6_16 == 1 | q6_16 == 2 | ///
    q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
replace wp07_state_q6_16 = 5 if (wp07_known_form == 1) & wp07_state_q6_16 == 1 & (q6_16 == 98)
assert inrange(wp07_state_q6_16, 1, 6)

* ITEM q6_17 | ¿Ha encontrado límites o topes que le impidan completar operaciones digitales (por monto por transacción, límite diario o mensual, o número de operaciones)?
gen byte wp07_state_q6_17 = 6
gen byte wp07_route_q6_17 = .
replace wp07_route_q6_17 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace wp07_route_q6_17 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace wp07_state_q6_17 = 2 if (wp07_known_form == 1) & wp07_route_q6_17 == 0 & (missing(q6_17))
replace wp07_state_q6_17 = 4 if (wp07_known_form == 1) & wp07_route_q6_17 == 1 & (missing(q6_17))
replace wp07_state_q6_17 = 1 if (wp07_known_form == 1) & wp07_route_q6_17 == 1 & (q6_17 == 1 | q6_17 == 2 | ///
    q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
replace wp07_state_q6_17 = 5 if (wp07_known_form == 1) & wp07_state_q6_17 == 1 & (q6_17 == 98)
assert inrange(wp07_state_q6_17, 1, 6)

* ITEM q6_18 | En la última operación digital que hizo en esos 90 días, ¿las comisiones se mostraron claramente antes de que usted confirmara la operación?
gen byte wp07_state_q6_18 = 6
gen byte wp07_route_q6_18 = .
replace wp07_route_q6_18 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace wp07_route_q6_18 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace wp07_state_q6_18 = 2 if (wp07_known_form == 1) & wp07_route_q6_18 == 0 & (missing(q6_18))
replace wp07_state_q6_18 = 4 if (wp07_known_form == 1) & wp07_route_q6_18 == 1 & (missing(q6_18))
replace wp07_state_q6_18 = 1 if (wp07_known_form == 1) & wp07_route_q6_18 == 1 & (q6_18 == 1 | q6_18 == 2 | ///
    q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
replace wp07_state_q6_18 = 5 if (wp07_known_form == 1) & wp07_state_q6_18 == 1 & (q6_18 == 4)
replace wp07_state_q6_18 = 5 if (wp07_known_form == 1) & wp07_state_q6_18 == 1 & (q6_18 == 98)
assert inrange(wp07_state_q6_18, 1, 6)

* ITEM q6_20 | En esa última operación digital, ¿recibió una confirmación inmediata (por SMS o notificación en la app) al enviar o recibir el dinero?
gen byte wp07_state_q6_20 = 6
gen byte wp07_route_q6_20 = .
replace wp07_route_q6_20 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace wp07_route_q6_20 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace wp07_state_q6_20 = 2 if (wp07_known_form == 1) & wp07_route_q6_20 == 0 & (missing(q6_20))
replace wp07_state_q6_20 = 4 if (wp07_known_form == 1) & wp07_route_q6_20 == 1 & (missing(q6_20))
replace wp07_state_q6_20 = 1 if (wp07_known_form == 1) & wp07_route_q6_20 == 1 & (q6_20 == 1 | q6_20 == 2 | ///
    q6_20 == 3 | q6_20 == 98)
replace wp07_state_q6_20 = 5 if (wp07_known_form == 1) & wp07_state_q6_20 == 1 & (q6_20 == 98)
assert inrange(wp07_state_q6_20, 1, 6)

* ITEM q6_21 | En general, ¿qué tan rápidos le resultan sus pagos o remesas digitales (desde que se envían hasta que usted puede usar el dinero)?
gen byte wp07_state_q6_21 = 6
gen byte wp07_route_q6_21 = .
replace wp07_route_q6_21 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace wp07_route_q6_21 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace wp07_state_q6_21 = 2 if (wp07_known_form == 1) & wp07_route_q6_21 == 0 & (missing(q6_21))
replace wp07_state_q6_21 = 4 if (wp07_known_form == 1) & wp07_route_q6_21 == 1 & (missing(q6_21))
replace wp07_state_q6_21 = 1 if (wp07_known_form == 1) & wp07_route_q6_21 == 1 & (q6_21 == 1 | q6_21 == 2 | ///
    q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
assert inrange(wp07_state_q6_21, 1, 6)

* ITEM q6_22 | ¿Ha notado cargos adicionales al pagar con QR o transferencia en comercios, comparado con pagar en efectivo (por ejemplo, recargo o comisión extra)?
gen byte wp07_state_q6_22 = 6
gen byte wp07_route_q6_22 = .
replace wp07_route_q6_22 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace wp07_route_q6_22 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace wp07_state_q6_22 = 2 if (wp07_known_form == 1) & wp07_route_q6_22 == 0 & (missing(q6_22))
replace wp07_state_q6_22 = 4 if (wp07_known_form == 1) & wp07_route_q6_22 == 1 & (missing(q6_22))
replace wp07_state_q6_22 = 1 if (wp07_known_form == 1) & wp07_route_q6_22 == 1 & (q6_22 == 1 | q6_22 == 2 | ///
    q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
replace wp07_state_q6_22 = 5 if (wp07_known_form == 1) & wp07_state_q6_22 == 1 & (q6_22 == 98)
replace wp07_state_q6_22 = 5 if (wp07_known_form == 1) & wp07_state_q6_22 == 1 & (q6_22 == 99)
assert inrange(wp07_state_q6_22, 1, 6)

* ITEM q6_23 | En general, ¿qué tan clara le resulta la información que dan los proveedores sobre límites, horarios, comisiones y tiempos de abono de las operaciones digitales?
gen byte wp07_state_q6_23 = 6
gen byte wp07_route_q6_23 = .
replace wp07_route_q6_23 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace wp07_route_q6_23 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace wp07_state_q6_23 = 2 if (wp07_known_form == 1) & wp07_route_q6_23 == 0 & (missing(q6_23))
replace wp07_state_q6_23 = 4 if (wp07_known_form == 1) & wp07_route_q6_23 == 1 & (missing(q6_23))
replace wp07_state_q6_23 = 1 if (wp07_known_form == 1) & wp07_route_q6_23 == 1 & (q6_23 == 1 | q6_23 == 2 | ///
    q6_23 == 3 | q6_23 == 4)
assert inrange(wp07_state_q6_23, 1, 6)

* ITEM q6_24 | En los últimos 60 días (2 meses), ¿cómo evaluaría su experiencia transaccional digital en general?
gen byte wp07_state_q6_24 = 6
gen byte wp07_route_q6_24 = .
replace wp07_route_q6_24 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace wp07_route_q6_24 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace wp07_state_q6_24 = 2 if (wp07_known_form == 1) & wp07_route_q6_24 == 0 & (missing(q6_24))
replace wp07_state_q6_24 = 4 if (wp07_known_form == 1) & wp07_route_q6_24 == 1 & (missing(q6_24))
replace wp07_state_q6_24 = 1 if (wp07_known_form == 1) & wp07_route_q6_24 == 1 & (q6_24 == 1 | q6_24 == 2 | ///
    q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
assert inrange(wp07_state_q6_24, 1, 6)


* ============================================================================
* IPCS: version, route and response-state classification

* ITEM q7_1 | En los últimos 12 meses, ¿recibió mensajes o llamadas sospechosas (SMS, WhatsApp, redes sociales o teléfono) pidiéndole códigos SMS/OTP, claves, PIN o que hiciera una transferencia urgente?
gen byte wp07_state_q7_1 = 6
gen byte wp07_route_q7_1 = .
replace wp07_route_q7_1 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q7_1 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q7_1 = 2 if (wp07_known_form == 1) & wp07_route_q7_1 == 0 & (missing(q7_1))
replace wp07_state_q7_1 = 4 if (wp07_known_form == 1) & wp07_route_q7_1 == 1 & (missing(q7_1))
replace wp07_state_q7_1 = 1 if (wp07_known_form == 1) & wp07_route_q7_1 == 1 & (q7_1 == 1 | q7_1 == 2 | q7_1 ///
    == 3 | q7_1 == 4 | q7_1 == 98)
replace wp07_state_q7_1 = 5 if (wp07_known_form == 1) & wp07_state_q7_1 == 1 & (q7_1 == 98)
assert inrange(wp07_state_q7_1, 1, 6)

* ITEM q7_2 | Pensando en el último mensaje o llamada sospechosa que recibió, ¿qué hizo usted primero?
gen byte wp07_state_q7_2 = 6
gen byte wp07_route_q7_2 = .
replace wp07_route_q7_2 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 1)) | ((q7_1 == 1 | q7_1 ///
    == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 2))))
replace wp07_route_q7_2 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 1)) & ((q7_1 == 1 | ///
    q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 2))))
replace wp07_state_q7_2 = 2 if (wp07_known_form == 1) & wp07_route_q7_2 == 0 & (missing(q7_2))
replace wp07_state_q7_2 = 4 if (wp07_known_form == 1) & wp07_route_q7_2 == 1 & (missing(q7_2))
replace wp07_state_q7_2 = 1 if (wp07_known_form == 1) & wp07_route_q7_2 == 1 & (q7_2 == 1 | q7_2 == 2 | q7_2 ///
    == 3 | q7_2 == 4 | q7_2 == 5)
assert inrange(wp07_state_q7_2, 1, 6)

* ITEM q7_6 | Actualmente, ¿usa algún método de autenticación segura en su teléfono o app (por ejemplo, huella, reconocimiento facial, PIN, patrón o bloqueo de pantalla)?
gen byte wp07_state_q7_6 = 6
gen byte wp07_route_q7_6 = .
replace wp07_route_q7_6 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q7_6 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q7_6 = 2 if (wp07_known_form == 1) & wp07_route_q7_6 == 0 & (missing(q7_6))
replace wp07_state_q7_6 = 4 if (wp07_known_form == 1) & wp07_route_q7_6 == 1 & (missing(q7_6))
replace wp07_state_q7_6 = 1 if (wp07_known_form == 1) & wp07_route_q7_6 == 1 & (q7_6 == 1 | q7_6 == 2 | q7_6 ///
    == 3 | q7_6 == 98)
replace wp07_state_q7_6 = 5 if (wp07_known_form == 1) & wp07_state_q7_6 == 1 & (q7_6 == 98)
assert inrange(wp07_state_q7_6, 1, 6)

* ITEM q7_7 | ¿Con qué frecuencia cambia sus claves o PIN y revisa sus movimientos para detectar operaciones no reconocidas?
gen byte wp07_state_q7_7 = 6
gen byte wp07_route_q7_7 = .
replace wp07_route_q7_7 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q7_7 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q7_7 = 2 if (wp07_known_form == 1) & wp07_route_q7_7 == 0 & (missing(q7_7))
replace wp07_state_q7_7 = 4 if (wp07_known_form == 1) & wp07_route_q7_7 == 1 & (missing(q7_7))
replace wp07_state_q7_7 = 1 if (wp07_known_form == 1) & wp07_route_q7_7 == 1 & (q7_7 == 1 | q7_7 == 2 | q7_7 ///
    == 3 | q7_7 == 4)
assert inrange(wp07_state_q7_7, 1, 6)

* ITEM q7_8 | ¿Recibió en los últimos 12 meses mensajes de educación o alertas de su banco/app sobre estafas comunes (por ejemplo, “no comparta OTP”, “no haga clic en enlaces desconocidos”)?
gen byte wp07_state_q7_8 = 6
gen byte wp07_route_q7_8 = .
replace wp07_route_q7_8 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q7_8 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q7_8 = 2 if (wp07_known_form == 1) & wp07_route_q7_8 == 0 & (missing(q7_8))
replace wp07_state_q7_8 = 4 if (wp07_known_form == 1) & wp07_route_q7_8 == 1 & (missing(q7_8))
replace wp07_state_q7_8 = 1 if (wp07_known_form == 1) & wp07_route_q7_8 == 1 & (q7_8 == 1 | q7_8 == 2 | q7_8 ///
    == 3 | q7_8 == 98)
replace wp07_state_q7_8 = 5 if (wp07_known_form == 1) & wp07_state_q7_8 == 1 & (q7_8 == 98)
assert inrange(wp07_state_q7_8, 1, 6)

* ITEM q7_9 | En general, ¿qué tan segura se siente al recibir remesas o pagos por canales digitales (app, QR, transferencia)?
gen byte wp07_state_q7_9 = 6
gen byte wp07_route_q7_9 = .
replace wp07_route_q7_9 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q7_9 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q7_9 = 2 if (wp07_known_form == 1) & wp07_route_q7_9 == 0 & (missing(q7_9))
replace wp07_state_q7_9 = 4 if (wp07_known_form == 1) & wp07_route_q7_9 == 1 & (missing(q7_9))
replace wp07_state_q7_9 = 1 if (wp07_known_form == 1) & wp07_route_q7_9 == 1 & (q7_9 == 1 | q7_9 == 2 | q7_9 ///
    == 3 | q7_9 == 4)
assert inrange(wp07_state_q7_9, 1, 6)

* ITEM q7_10 | ¿Qué medida de seguridad considera más útil para evitar fraudes en su caso?
gen byte wp07_state_q7_10 = 6
gen byte wp07_route_q7_10 = .
replace wp07_route_q7_10 = 1 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & ///
    (eligible_flag == 1))
replace wp07_route_q7_10 = 0 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & ///
    !(eligible_flag == 1))
replace wp07_state_q7_10 = 2 if inlist(formdef_version, 2512090157) & wp07_route_q7_10 == 0 & (missing(q7_10))
replace wp07_state_q7_10 = 4 if inlist(formdef_version, 2512090157) & wp07_route_q7_10 == 1 & (missing(q7_10))
replace wp07_state_q7_10 = 1 if inlist(formdef_version, 2512090157) & wp07_route_q7_10 == 1 & (q7_10 == 1 | ///
    q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6 | q7_10 == 7)
replace wp07_route_q7_10 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q7_10 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q7_10 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_10 == 0 & (missing(q7_10))
replace wp07_state_q7_10 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_10 == 1 & (missing(q7_10))
replace wp07_state_q7_10 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_10 == 1 & (q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6)
assert inrange(wp07_state_q7_10, 1, 6)


* ============================================================================
* IEDF: version, route and response-state classification

* ITEM q7_5 | En los últimos 12 meses, ¿su cuenta, tarjeta o app fue bloqueada o limitada por intentos fallidos, contraseñas erradas o sospecha de fraude?
gen byte wp07_state_q7_5 = 6
gen byte wp07_route_q7_5 = .
replace wp07_route_q7_5 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q7_5 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q7_5 = 2 if (wp07_known_form == 1) & wp07_route_q7_5 == 0 & (missing(q7_5))
replace wp07_state_q7_5 = 4 if (wp07_known_form == 1) & wp07_route_q7_5 == 1 & (missing(q7_5))
replace wp07_state_q7_5 = 1 if (wp07_known_form == 1) & wp07_route_q7_5 == 1 & (q7_5 == 1 | q7_5 == 2 | q7_5 ///
    == 3 | q7_5 == 4 | q7_5 == 98)
replace wp07_state_q7_5 = 5 if (wp07_known_form == 1) & wp07_state_q7_5 == 1 & (q7_5 == 98)
assert inrange(wp07_state_q7_5, 1, 6)

* ITEM q7_11 | En los últimos 12 meses, ¿tuvo algún problema con un pago o remesa digital (por ejemplo, dinero que no llegó, llegó incompleto o tarde, cobro indebido, error de destinatario)?
gen byte wp07_state_q7_11 = 6
gen byte wp07_route_q7_11 = .
replace wp07_route_q7_11 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q7_11 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q7_11 = 2 if (wp07_known_form == 1) & wp07_route_q7_11 == 0 & (missing(q7_11))
replace wp07_state_q7_11 = 4 if (wp07_known_form == 1) & wp07_route_q7_11 == 1 & (missing(q7_11))
replace wp07_state_q7_11 = 1 if (wp07_known_form == 1) & wp07_route_q7_11 == 1 & (q7_11 == 1 | q7_11 == 2 | ///
    q7_11 == 98)
replace wp07_state_q7_11 = 5 if (wp07_known_form == 1) & wp07_state_q7_11 == 1 & (q7_11 == 98)
assert inrange(wp07_state_q7_11, 1, 6)

* ITEM q7_12 | Pensando en el problema más reciente, ¿a quién presentó el reclamo primero?
gen byte wp07_state_q7_12 = 6
gen byte wp07_route_q7_12 = .
replace wp07_route_q7_12 = 1 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & ///
    (eligible_flag == 1)) & ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)))
replace wp07_route_q7_12 = 0 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & ///
    !(eligible_flag == 1)) | ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)))
replace wp07_state_q7_12 = 2 if inlist(formdef_version, 2512090157) & wp07_route_q7_12 == 0 & (missing(q7_12))
replace wp07_state_q7_12 = 4 if inlist(formdef_version, 2512090157) & wp07_route_q7_12 == 1 & (missing(q7_12))
replace wp07_state_q7_12 = 1 if inlist(formdef_version, 2512090157) & wp07_route_q7_12 == 1 & (q7_12 == 1 | ///
    q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7)
replace wp07_route_q7_12 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & ///
    (q7_11 == 1)))
replace wp07_route_q7_12 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & ///
    !(q7_11 == 1)))
replace wp07_state_q7_12 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_12 == 0 & (missing(q7_12))
replace wp07_state_q7_12 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_12 == 1 & (missing(q7_12))
replace wp07_state_q7_12 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_12 == 1 & (q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6)
assert inrange(wp07_state_q7_12, 1, 6)

* ITEM q7_13 | ¿Cuánto tiempo tardó en recibir una primera respuesta de ese canal de reclamo?
gen byte wp07_state_q7_13 = 6
gen byte wp07_route_q7_13 = .
replace wp07_route_q7_13 = 1 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & ///
    (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 ///
    == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & (q7_12 != 6))))
replace wp07_route_q7_13 = 0 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & ///
    !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | ///
    q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & !(q7_12 != 6))))
replace wp07_state_q7_13 = 2 if inlist(formdef_version, 2512090157) & wp07_route_q7_13 == 0 & (missing(q7_13))
replace wp07_state_q7_13 = 4 if inlist(formdef_version, 2512090157) & wp07_route_q7_13 == 1 & (missing(q7_13))
replace wp07_state_q7_13 = 1 if inlist(formdef_version, 2512090157) & wp07_route_q7_13 == 1 & (q7_13 == 1 | ///
    q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
replace wp07_route_q7_13 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & ///
    (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 ///
    != 6))))
replace wp07_route_q7_13 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & ///
    !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & ///
    !(q7_12 != 6))))
replace wp07_state_q7_13 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_13 == 0 & (missing(q7_13))
replace wp07_state_q7_13 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_13 == 1 & (missing(q7_13))
replace wp07_state_q7_13 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_13 == 1 & (q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
assert inrange(wp07_state_q7_13, 1, 6)

* ITEM q7_14 | ¿El problema quedó resuelto y el dinero fue restituido o corregido?
* Pending remains a recorded category; do not require an earlier reply or convert statuses to money fractions.
gen byte wp07_state_q7_14 = 6
gen byte wp07_route_q7_14 = .
replace wp07_route_q7_14 = 1 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & ///
    (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 ///
    == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & (q7_12 != 6))))
replace wp07_route_q7_14 = 0 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & ///
    !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | ///
    q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & !(q7_12 != 6))))
replace wp07_state_q7_14 = 2 if inlist(formdef_version, 2512090157) & wp07_route_q7_14 == 0 & (missing(q7_14))
replace wp07_state_q7_14 = 4 if inlist(formdef_version, 2512090157) & wp07_route_q7_14 == 1 & (missing(q7_14))
replace wp07_state_q7_14 = 1 if inlist(formdef_version, 2512090157) & wp07_route_q7_14 == 1 & (q7_14 == 1 | ///
    q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
replace wp07_state_q7_14 = 5 if inlist(formdef_version, 2512090157) & wp07_state_q7_14 == 1 & (q7_14 == 4)
replace wp07_route_q7_14 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & ///
    (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 ///
    != 6))))
replace wp07_route_q7_14 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & ///
    !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & ///
    !(q7_12 != 6))))
replace wp07_state_q7_14 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_14 == 0 & (missing(q7_14))
replace wp07_state_q7_14 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_14 == 1 & (missing(q7_14))
replace wp07_state_q7_14 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_14 == 1 & (q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
replace wp07_state_q7_14 = 5 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_state_q7_14 == 1 & (q7_14 == 4)
assert inrange(wp07_state_q7_14, 1, 6)

* ITEM q7_15 | En una escala de 1 a 5, ¿qué tan satisfecha quedó con la atención del proveedor o entidad que gestionó su reclamo?
gen byte wp07_state_q7_15 = 6
gen byte wp07_route_q7_15 = .
replace wp07_route_q7_15 = 1 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & ///
    (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 ///
    == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & (q7_12 != 6))))
replace wp07_route_q7_15 = 0 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & ///
    !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | ///
    q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & !(q7_12 != 6))))
replace wp07_state_q7_15 = 2 if inlist(formdef_version, 2512090157) & wp07_route_q7_15 == 0 & (missing(q7_15))
replace wp07_state_q7_15 = 4 if inlist(formdef_version, 2512090157) & wp07_route_q7_15 == 1 & (missing(q7_15))
replace wp07_state_q7_15 = 1 if inlist(formdef_version, 2512090157) & wp07_route_q7_15 == 1 & (q7_15 == 1 | ///
    q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
replace wp07_route_q7_15 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & ///
    (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 ///
    != 6))))
replace wp07_route_q7_15 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & ///
    !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & ///
    !(q7_12 != 6))))
replace wp07_state_q7_15 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_15 == 0 & (missing(q7_15))
replace wp07_state_q7_15 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_15 == 1 & (missing(q7_15))
replace wp07_state_q7_15 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q7_15 == 1 & (q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
assert inrange(wp07_state_q7_15, 1, 6)


* ============================================================================
* IAER: version, route and response-state classification

* ITEM q9_4 | Yo decido cómo se usan las remesas del hogar la mayor parte del tiempo.
gen byte wp07_state_q9_4 = 6
gen byte wp07_route_q9_4 = .
replace wp07_route_q9_4 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_4 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_4 = 2 if (wp07_known_form == 1) & wp07_route_q9_4 == 0 & (missing(q9_4))
replace wp07_state_q9_4 = 4 if (wp07_known_form == 1) & wp07_route_q9_4 == 1 & (missing(q9_4))
replace wp07_state_q9_4 = 1 if (wp07_known_form == 1) & wp07_route_q9_4 == 1 & (q9_4 == 1 | q9_4 == 2 | q9_4 ///
    == 3 | q9_4 == 4 | q9_4 == 5)
assert inrange(wp07_state_q9_4, 1, 6)

* ITEM q9_5 | En el último mes en que recibió remesas, ¿quién guardó o administró la mayor parte de ese dinero?
gen byte wp07_state_q9_5 = 6
gen byte wp07_route_q9_5 = .
replace wp07_route_q9_5 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_5 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_5 = 2 if (wp07_known_form == 1) & wp07_route_q9_5 == 0 & (missing(q9_5))
replace wp07_state_q9_5 = 4 if (wp07_known_form == 1) & wp07_route_q9_5 == 1 & (missing(q9_5))
replace wp07_state_q9_5 = 1 if (wp07_known_form == 1) & wp07_route_q9_5 == 1 & (q9_5 == 1 | q9_5 == 2 | q9_5 ///
    == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
replace wp07_state_q9_5 = 5 if (wp07_known_form == 1) & wp07_state_q9_5 == 1 & (q9_5 == 98)
assert inrange(wp07_state_q9_5, 1, 6)

* ITEM q9_6 | Si usted quisiera destinar parte de la remesa a ahorro o a su negocio, ¿podría hacerlo sin pedir permiso a otra persona?
gen byte wp07_state_q9_6 = 6
gen byte wp07_route_q9_6 = .
replace wp07_route_q9_6 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_6 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_6 = 2 if (wp07_known_form == 1) & wp07_route_q9_6 == 0 & (missing(q9_6))
replace wp07_state_q9_6 = 4 if (wp07_known_form == 1) & wp07_route_q9_6 == 1 & (missing(q9_6))
replace wp07_state_q9_6 = 1 if (wp07_known_form == 1) & wp07_route_q9_6 == 1 & (q9_6 == 1 | q9_6 == 2 | q9_6 ///
    == 3 | q9_6 == 98)
replace wp07_state_q9_6 = 5 if (wp07_known_form == 1) & wp07_state_q9_6 == 1 & (q9_6 == 98)
assert inrange(wp07_state_q9_6, 1, 6)

* ITEM q9_7 | En general, me siento en control de mi dinero y de las decisiones sobre las remesas.
gen byte wp07_state_q9_7 = 6
gen byte wp07_route_q9_7 = .
replace wp07_route_q9_7 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_7 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_7 = 2 if (wp07_known_form == 1) & wp07_route_q9_7 == 0 & (missing(q9_7))
replace wp07_state_q9_7 = 4 if (wp07_known_form == 1) & wp07_route_q9_7 == 1 & (missing(q9_7))
replace wp07_state_q9_7 = 1 if (wp07_known_form == 1) & wp07_route_q9_7 == 1 & (q9_7 == 1 | q9_7 == 2 | q9_7 ///
    == 3 | q9_7 == 4 | q9_7 == 5)
assert inrange(wp07_state_q9_7, 1, 6)

* ITEM q9_8 | En los últimos 12 meses, ¿alguna persona le pidió ver su teléfono o sus códigos (PIN/OTP) para manejar la remesa en contra de su voluntad?
gen byte wp07_state_q9_8 = 6
gen byte wp07_route_q9_8 = .
replace wp07_route_q9_8 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_8 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_8 = 2 if (wp07_known_form == 1) & wp07_route_q9_8 == 0 & (missing(q9_8))
replace wp07_state_q9_8 = 4 if (wp07_known_form == 1) & wp07_route_q9_8 == 1 & (missing(q9_8))
replace wp07_state_q9_8 = 1 if (wp07_known_form == 1) & wp07_route_q9_8 == 1 & (q9_8 == 0 | q9_8 == 1 | q9_8 ///
    == 98)
replace wp07_state_q9_8 = 5 if (wp07_known_form == 1) & wp07_state_q9_8 == 1 & (q9_8 == 98)
assert inrange(wp07_state_q9_8, 1, 6)

* ITEM q9_9 | Si pudiera elegir libremente, ¿a nombre de quién preferiría que estuviera la cuenta o billetera donde entra la remesa?
gen byte wp07_state_q9_9 = 6
gen byte wp07_route_q9_9 = .
replace wp07_route_q9_9 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_9 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_9 = 2 if (wp07_known_form == 1) & wp07_route_q9_9 == 0 & (missing(q9_9))
replace wp07_state_q9_9 = 4 if (wp07_known_form == 1) & wp07_route_q9_9 == 1 & (missing(q9_9))
replace wp07_state_q9_9 = 1 if (wp07_known_form == 1) & wp07_route_q9_9 == 1 & (q9_9 == 1 | q9_9 == 2 | q9_9 ///
    == 3 | q9_9 == 4 | q9_9 == 98)
replace wp07_state_q9_9 = 5 if (wp07_known_form == 1) & wp07_state_q9_9 == 1 & (q9_9 == 98)
assert inrange(wp07_state_q9_9, 1, 6)

* ITEM q9_11 | En su hogar, ¿quién suele decidir sobre su atención de salud (visitas a médico, exámenes, tratamientos)?
gen byte wp07_state_q9_11 = 6
gen byte wp07_route_q9_11 = .
replace wp07_route_q9_11 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_11 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_11 = 2 if (wp07_known_form == 1) & wp07_route_q9_11 == 0 & (missing(q9_11))
replace wp07_state_q9_11 = 4 if (wp07_known_form == 1) & wp07_route_q9_11 == 1 & (missing(q9_11))
replace wp07_state_q9_11 = 1 if (wp07_known_form == 1) & wp07_route_q9_11 == 1 & (q9_11 == 1 | q9_11 == 2 | ///
    q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
replace wp07_state_q9_11 = 5 if (wp07_known_form == 1) & wp07_state_q9_11 == 1 & (q9_11 == 98)
assert inrange(wp07_state_q9_11, 1, 6)

* ITEM q9_13 | En su hogar, ¿quién toma la decisión sobre los gastos importantes del hogar (por ejemplo, electrodomésticos, arriendo, matrículas)?
gen byte wp07_state_q9_13 = 6
gen byte wp07_route_q9_13 = .
replace wp07_route_q9_13 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_13 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_13 = 2 if (wp07_known_form == 1) & wp07_route_q9_13 == 0 & (missing(q9_13))
replace wp07_state_q9_13 = 4 if (wp07_known_form == 1) & wp07_route_q9_13 == 1 & (missing(q9_13))
replace wp07_state_q9_13 = 1 if (wp07_known_form == 1) & wp07_route_q9_13 == 1 & (q9_13 == 1 | q9_13 == 2 | ///
    q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
replace wp07_state_q9_13 = 5 if (wp07_known_form == 1) & wp07_state_q9_13 == 1 & (q9_13 == 98)
assert inrange(wp07_state_q9_13, 1, 6)

* ITEM q9_16 | En los últimos 12 meses, ¿ha sentido presión de alguien para entregar todo el dinero de la remesa o mostrar sus movimientos cuando usted no quería?
gen byte wp07_state_q9_16 = 6
gen byte wp07_route_q9_16 = .
replace wp07_route_q9_16 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_16 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_16 = 2 if (wp07_known_form == 1) & wp07_route_q9_16 == 0 & (missing(q9_16))
replace wp07_state_q9_16 = 4 if (wp07_known_form == 1) & wp07_route_q9_16 == 1 & (missing(q9_16))
replace wp07_state_q9_16 = 1 if (wp07_known_form == 1) & wp07_route_q9_16 == 1 & (q9_16 == 0 | q9_16 == 1 | ///
    q9_16 == 98)
replace wp07_state_q9_16 = 5 if (wp07_known_form == 1) & wp07_state_q9_16 == 1 & (q9_16 == 98)
assert inrange(wp07_state_q9_16, 1, 6)

* ITEM q9_18 | En general, siento que mi opinión sobre el uso de la remesa es escuchada y respetada en mi hogar.
gen byte wp07_state_q9_18 = 6
gen byte wp07_route_q9_18 = .
replace wp07_route_q9_18 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_18 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_18 = 2 if (wp07_known_form == 1) & wp07_route_q9_18 == 0 & (missing(q9_18))
replace wp07_state_q9_18 = 4 if (wp07_known_form == 1) & wp07_route_q9_18 == 1 & (missing(q9_18))
replace wp07_state_q9_18 = 1 if (wp07_known_form == 1) & wp07_route_q9_18 == 1 & (q9_18 == 1 | q9_18 == 2 | ///
    q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
assert inrange(wp07_state_q9_18, 1, 6)

* ITEM q9_19 | Si usted quisiera abrir una nueva cuenta o cambiar la cuenta donde llega la remesa, ¿podría decidirlo?
gen byte wp07_state_q9_19 = 6
gen byte wp07_route_q9_19 = .
replace wp07_route_q9_19 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_19 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_19 = 2 if (wp07_known_form == 1) & wp07_route_q9_19 == 0 & (missing(q9_19))
replace wp07_state_q9_19 = 4 if (wp07_known_form == 1) & wp07_route_q9_19 == 1 & (missing(q9_19))
replace wp07_state_q9_19 = 1 if (wp07_known_form == 1) & wp07_route_q9_19 == 1 & (q9_19 == 1 | q9_19 == 2 | ///
    q9_19 == 3 | q9_19 == 98)
replace wp07_state_q9_19 = 5 if (wp07_known_form == 1) & wp07_state_q9_19 == 1 & (q9_19 == 98)
assert inrange(wp07_state_q9_19, 1, 6)

* ITEM q9_20 | ¿Ha evitado usar pagos digitales o aplicaciones por miedo a conflictos o discusiones dentro del hogar?
gen byte wp07_state_q9_20 = 6
gen byte wp07_route_q9_20 = .
replace wp07_route_q9_20 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_20 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_20 = 2 if (wp07_known_form == 1) & wp07_route_q9_20 == 0 & (missing(q9_20))
replace wp07_state_q9_20 = 4 if (wp07_known_form == 1) & wp07_route_q9_20 == 1 & (missing(q9_20))
replace wp07_state_q9_20 = 1 if (wp07_known_form == 1) & wp07_route_q9_20 == 1 & (q9_20 == 0 | q9_20 == 1 | ///
    q9_20 == 98)
replace wp07_state_q9_20 = 5 if (wp07_known_form == 1) & wp07_state_q9_20 == 1 & (q9_20 == 98)
assert inrange(wp07_state_q9_20, 1, 6)


* ============================================================================
* ICPF: version, route and response-state classification

* ITEM q9_1 | Confío en que mi proveedor principal de pagos o cuenta mantendrá mi dinero seguro.
gen byte wp07_state_q9_1 = 6
gen byte wp07_route_q9_1 = .
replace wp07_route_q9_1 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_1 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_1 = 2 if (wp07_known_form == 1) & wp07_route_q9_1 == 0 & (missing(q9_1))
replace wp07_state_q9_1 = 4 if (wp07_known_form == 1) & wp07_route_q9_1 == 1 & (missing(q9_1))
replace wp07_state_q9_1 = 1 if (wp07_known_form == 1) & wp07_route_q9_1 == 1 & (q9_1 == 1 | q9_1 == 2 | q9_1 ///
    == 3 | q9_1 == 4 | q9_1 == 5)
assert inrange(wp07_state_q9_1, 1, 6)

* ITEM q9_15 | En mi hogar, se considera apropiado que las mujeres usen pagos digitales (app, QR, transferencias).
gen byte wp07_state_q9_15 = 6
gen byte wp07_route_q9_15 = .
replace wp07_route_q9_15 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_15 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_15 = 2 if (wp07_known_form == 1) & wp07_route_q9_15 == 0 & (missing(q9_15))
replace wp07_state_q9_15 = 4 if (wp07_known_form == 1) & wp07_route_q9_15 == 1 & (missing(q9_15))
replace wp07_state_q9_15 = 1 if (wp07_known_form == 1) & wp07_route_q9_15 == 1 & (q9_15 == 1 | q9_15 == 2 | ///
    q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
assert inrange(wp07_state_q9_15, 1, 6)

* ITEM q9_17 | Si usted rechaza compartir su PIN/OTP o su teléfono para manejar la remesa, ¿qué podría ocurrir en su hogar?
gen byte wp07_state_q9_17 = 6
gen byte wp07_route_q9_17 = .
replace wp07_route_q9_17 = 1 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & ///
    (eligible_flag == 1))
replace wp07_route_q9_17 = 0 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & ///
    !(eligible_flag == 1))
replace wp07_state_q9_17 = 2 if inlist(formdef_version, 2512090157) & wp07_route_q9_17 == 0 & ///
    (strtrim(q9_17) == "")
replace wp07_state_q9_17 = 4 if inlist(formdef_version, 2512090157) & wp07_route_q9_17 == 1 & ///
    (strtrim(q9_17) == "")
replace wp07_state_q9_17 = 1 if inlist(formdef_version, 2512090157) & wp07_route_q9_17 == 1 & ///
    (_valid_q9_17_1 == 1)
replace wp07_state_q9_17 = 6 if inlist(formdef_version, 2512090157) & wp07_state_q9_17 == 1 & (strpos(" " + ///
    itrim(strtrim(q9_17)) + " ", " 1 ") > 0) & wordcount(q9_17) > 1
replace wp07_state_q9_17 = 6 if inlist(formdef_version, 2512090157) & wp07_state_q9_17 == 1 & (strpos(" " + ///
    itrim(strtrim(q9_17)) + " ", " 98 ") > 0) & wordcount(q9_17) > 1
replace wp07_state_q9_17 = 5 if inlist(formdef_version, 2512090157) & wp07_state_q9_17 == 1 & ///
    (strtrim(q9_17) == "98")
replace wp07_route_q9_17 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_17 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_17 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q9_17 == 0 & (strtrim(q9_17) == "")
replace wp07_state_q9_17 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q9_17 == 1 & (strtrim(q9_17) == "")
replace wp07_state_q9_17 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q9_17 == 1 & (_valid_q9_17_1 == 1)
replace wp07_state_q9_17 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_state_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) & wordcount(q9_17) > 1
replace wp07_state_q9_17 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_state_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) & wordcount(q9_17) > 1
replace wp07_state_q9_17 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_state_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0) & wordcount(q9_17) > 1
replace wp07_state_q9_17 = 5 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_state_q9_17 == 1 & (strtrim(q9_17) == "98")
assert inrange(wp07_state_q9_17, 1, 6)

* ITEM q9_21 | ¿Qué cambios harían más seguro para usted usar pagos digitales y evitar conflictos en el hogar?
gen byte wp07_state_q9_21 = 6
gen byte wp07_route_q9_21 = .
replace wp07_route_q9_21 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & (q9_20 == 1)))
replace wp07_route_q9_21 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & !(q9_20 == 1)))
replace wp07_state_q9_21 = 2 if (wp07_known_form == 1) & wp07_route_q9_21 == 0 & (strtrim(q9_21) == "")
replace wp07_state_q9_21 = 4 if (wp07_known_form == 1) & wp07_route_q9_21 == 1 & (strtrim(q9_21) == "")
replace wp07_state_q9_21 = 1 if (wp07_known_form == 1) & wp07_route_q9_21 == 1 & (_valid_q9_21_1 == 1)
assert inrange(wp07_state_q9_21, 1, 6)

* ITEM q9_22 | En su comunidad, ¿la mayoría cree que las mujeres deben poder decidir sobre el uso de las remesas del hogar?
gen byte wp07_state_q9_22 = 6
gen byte wp07_route_q9_22 = .
replace wp07_route_q9_22 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q9_22 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q9_22 = 2 if (wp07_known_form == 1) & wp07_route_q9_22 == 0 & (missing(q9_22))
replace wp07_state_q9_22 = 4 if (wp07_known_form == 1) & wp07_route_q9_22 == 1 & (missing(q9_22))
replace wp07_state_q9_22 = 1 if (wp07_known_form == 1) & wp07_route_q9_22 == 1 & (q9_22 == 1 | q9_22 == 2 | ///
    q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
replace wp07_state_q9_22 = 5 if (wp07_known_form == 1) & wp07_state_q9_22 == 1 & (q9_22 == 98)
assert inrange(wp07_state_q9_22, 1, 6)


* ============================================================================
* IEH: version, route and response-state classification

* ITEM q10_4 | En general, ¿cuánta información siente que tiene sobre comisiones, tipos de cambio y qué hacer si tiene un problema con un pago digital o remesa?
gen byte wp07_state_q10_4 = 6
gen byte wp07_route_q10_4 = .
replace wp07_route_q10_4 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q10_4 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q10_4 = 2 if (wp07_known_form == 1) & wp07_route_q10_4 == 0 & (missing(q10_4))
replace wp07_state_q10_4 = 4 if (wp07_known_form == 1) & wp07_route_q10_4 == 1 & (missing(q10_4))
replace wp07_state_q10_4 = 1 if (wp07_known_form == 1) & wp07_route_q10_4 == 1 & (q10_4 == 1 | q10_4 == 2 | ///
    q10_4 == 3 | q10_4 == 4)
assert inrange(wp07_state_q10_4, 1, 6)

* ITEM q10_6 | Pensando en los puntos donde retira efectivo (cash-out) cerca de su casa o trabajo, ¿cómo describiría el tiempo y el costo adicional para retirar dinero que llega de forma digital?
gen byte wp07_state_q10_6 = 6
gen byte wp07_route_q10_6 = .
replace wp07_route_q10_6 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q10_6 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q10_6 = 2 if (wp07_known_form == 1) & wp07_route_q10_6 == 0 & (missing(q10_6))
replace wp07_state_q10_6 = 4 if (wp07_known_form == 1) & wp07_route_q10_6 == 1 & (missing(q10_6))
replace wp07_state_q10_6 = 1 if (wp07_known_form == 1) & wp07_route_q10_6 == 1 & (q10_6 == 1 | q10_6 == 2 | ///
    q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
replace wp07_state_q10_6 = 5 if (wp07_known_form == 1) & wp07_state_q10_6 == 1 & (q10_6 == 98)
assert inrange(wp07_state_q10_6, 1, 6)

* ITEM q10_10 | En los últimos 3 años, ¿participó en alguna capacitación sobre pagos digitales, remesas, billeteras o seguridad en línea?
* This is training timing. q10_11 is the conditional provider, not a substitute.
gen byte wp07_state_q10_10 = 6
gen byte wp07_route_q10_10 = .
replace wp07_route_q10_10 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q10_10 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q10_10 = 2 if (wp07_known_form == 1) & wp07_route_q10_10 == 0 & (missing(q10_10))
replace wp07_state_q10_10 = 4 if (wp07_known_form == 1) & wp07_route_q10_10 == 1 & (missing(q10_10))
replace wp07_state_q10_10 = 1 if (wp07_known_form == 1) & wp07_route_q10_10 == 1 & (q10_10 == 1 | q10_10 == ///
    2 | q10_10 == 3 | q10_10 == 98)
replace wp07_state_q10_10 = 5 if (wp07_known_form == 1) & wp07_state_q10_10 == 1 & (q10_10 == 98)
assert inrange(wp07_state_q10_10, 1, 6)

* ITEM q10_11 | ¿Quién organizó la capacitación más reciente a la que asistió?
gen byte wp07_state_q10_11 = 6
gen byte wp07_route_q10_11 = .
replace wp07_route_q10_11 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | ///
    q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
replace wp07_route_q10_11 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | ///
    q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
replace wp07_state_q10_11 = 2 if (wp07_known_form == 1) & wp07_route_q10_11 == 0 & (missing(q10_11))
replace wp07_state_q10_11 = 4 if (wp07_known_form == 1) & wp07_route_q10_11 == 1 & (missing(q10_11))
replace wp07_state_q10_11 = 1 if (wp07_known_form == 1) & wp07_route_q10_11 == 1 & (q10_11 == 1 | q10_11 == ///
    2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
assert inrange(wp07_state_q10_11, 1, 6)

* ITEM q10_12 | Después de esa capacitación, ¿cómo cambió su disposición a usar pagos digitales o remesas por app?
* Reported post-training willingness, not a causal training effect or measured adoption.
gen byte wp07_state_q10_12 = 6
gen byte wp07_route_q10_12 = .
replace wp07_route_q10_12 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | ///
    q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
replace wp07_route_q10_12 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | ///
    q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
replace wp07_state_q10_12 = 2 if (wp07_known_form == 1) & wp07_route_q10_12 == 0 & (missing(q10_12))
replace wp07_state_q10_12 = 4 if (wp07_known_form == 1) & wp07_route_q10_12 == 1 & (missing(q10_12))
replace wp07_state_q10_12 = 1 if (wp07_known_form == 1) & wp07_route_q10_12 == 1 & (q10_12 == 1 | q10_12 == ///
    2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
assert inrange(wp07_state_q10_12, 1, 6)

* ITEM q10_13 | En los últimos 12 meses, ¿recibió acompañamiento individual para usar pagos digitales o remesas? (por ejemplo, alguien que le ayudó a instalar una app, abrir cuenta, activar QR o hacer sus primeras operaciones)
gen byte wp07_state_q10_13 = 6
gen byte wp07_route_q10_13 = .
replace wp07_route_q10_13 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q10_13 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q10_13 = 2 if (wp07_known_form == 1) & wp07_route_q10_13 == 0 & (missing(q10_13))
replace wp07_state_q10_13 = 4 if (wp07_known_form == 1) & wp07_route_q10_13 == 1 & (missing(q10_13))
replace wp07_state_q10_13 = 1 if (wp07_known_form == 1) & wp07_route_q10_13 == 1 & (q10_13 == 0 | q10_13 == ///
    1 | q10_13 == 98)
replace wp07_state_q10_13 = 5 if (wp07_known_form == 1) & wp07_state_q10_13 == 1 & (q10_13 == 98)
assert inrange(wp07_state_q10_13, 1, 6)

* ITEM q10_14 | ¿Quién le brindó ese acompañamiento individual la última vez?
gen byte wp07_state_q10_14 = 6
gen byte wp07_route_q10_14 = .
replace wp07_route_q10_14 = 1 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & (eligible_flag == ///
    1)) & ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & (q10_13 == 1)))
replace wp07_route_q10_14 = 0 if (wp07_known_form == 1) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == ///
    1)) | ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & !(q10_13 == 1)))
replace wp07_state_q10_14 = 2 if (wp07_known_form == 1) & wp07_route_q10_14 == 0 & (missing(q10_14))
replace wp07_state_q10_14 = 4 if (wp07_known_form == 1) & wp07_route_q10_14 == 1 & (missing(q10_14))
replace wp07_state_q10_14 = 1 if (wp07_known_form == 1) & wp07_route_q10_14 == 1 & (q10_14 == 1 | q10_14 == ///
    2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
assert inrange(wp07_state_q10_14, 1, 6)

* ITEM q10_16 | En los últimos 12 meses, ¿con qué frecuencia ha visto o usado materiales (folletos, videos, mensajes por WhatsApp, redes sociales) sobre fraudes y uso seguro de pagos digitales?
gen byte wp07_state_q10_16 = 6
gen byte wp07_route_q10_16 = .
replace wp07_route_q10_16 = 1 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q10_16 = 0 if (wp07_known_form == 1) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q10_16 = 2 if (wp07_known_form == 1) & wp07_route_q10_16 == 0 & (missing(q10_16))
replace wp07_state_q10_16 = 4 if (wp07_known_form == 1) & wp07_route_q10_16 == 1 & (missing(q10_16))
replace wp07_state_q10_16 = 1 if (wp07_known_form == 1) & wp07_route_q10_16 == 1 & (q10_16 == 1 | q10_16 == ///
    2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
replace wp07_state_q10_16 = 5 if (wp07_known_form == 1) & wp07_state_q10_16 == 1 & (q10_16 == 98)
assert inrange(wp07_state_q10_16, 1, 6)


* ============================================================================
* IBPD: version, route and response-state classification

* ITEM q10_1 | ¿Cuál diría que es el principal motivo por el cual no usa más pagos digitales (o no los usa en absoluto)?
* Option 4 is substantive lack of know-how, including when selected with other barriers.
gen byte wp07_state_q10_1 = 6
gen byte wp07_route_q10_1 = .
replace wp07_route_q10_1 = 1 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & ///
    (eligible_flag == 1))
replace wp07_route_q10_1 = 0 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & ///
    !(eligible_flag == 1))
replace wp07_state_q10_1 = 2 if inlist(formdef_version, 2512090157) & wp07_route_q10_1 == 0 & (missing(q10_1))
replace wp07_state_q10_1 = 4 if inlist(formdef_version, 2512090157) & wp07_route_q10_1 == 1 & (missing(q10_1))
replace wp07_state_q10_1 = 1 if inlist(formdef_version, 2512090157) & wp07_route_q10_1 == 1 & (q10_1 == 1 | ///
    q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | ///
    q10_1 == 10 | q10_1 == 11)
replace wp07_route_q10_1 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q10_1 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q10_1 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q10_1 == 0 & (missing(q10_1))
replace wp07_state_q10_1 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q10_1 == 1 & (missing(q10_1))
replace wp07_state_q10_1 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | ///
    q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == ///
    15 | q10_1 == 16 | q10_1 == 98)
replace wp07_state_q10_1 = 5 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_state_q10_1 == 1 & (q10_1 == 98)
assert inrange(wp07_state_q10_1, 1, 6)

* ITEM q10_2 | Además de esa razón principal, ¿qué otras dificultades o barreras siente que enfrenta para usar pagos digitales?
* Option 4 is substantive lack of know-how, including when selected with other barriers.
gen byte wp07_state_q10_2 = 6
gen byte wp07_route_q10_2 = .
replace wp07_route_q10_2 = 1 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & ///
    (eligible_flag == 1))
replace wp07_route_q10_2 = 0 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & ///
    !(eligible_flag == 1))
replace wp07_state_q10_2 = 2 if inlist(formdef_version, 2512090157) & wp07_route_q10_2 == 0 & ///
    (strtrim(q10_2) == "")
replace wp07_state_q10_2 = 4 if inlist(formdef_version, 2512090157) & wp07_route_q10_2 == 1 & ///
    (strtrim(q10_2) == "")
replace wp07_state_q10_2 = 1 if inlist(formdef_version, 2512090157) & wp07_route_q10_2 == 1 & ///
    (_valid_q10_2_1 == 1)
replace wp07_state_q10_2 = 6 if inlist(formdef_version, 2512090157) & wp07_state_q10_2 == 1 & (strpos(" " + ///
    itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
replace wp07_state_q10_2 = 5 if inlist(formdef_version, 2512090157) & wp07_state_q10_2 == 1 & ///
    (strtrim(q10_2) == "98")
replace wp07_route_q10_2 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace wp07_route_q10_2 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace wp07_state_q10_2 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q10_2 == 0 & (strtrim(q10_2) == "")
replace wp07_state_q10_2 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q10_2 == 1 & (strtrim(q10_2) == "")
replace wp07_state_q10_2 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_route_q10_2 == 1 & (_valid_q10_2_2 == 1)
replace wp07_state_q10_2 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_state_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
replace wp07_state_q10_2 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_state_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
replace wp07_state_q10_2 = 5 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    wp07_state_q10_2 == 1 & (strtrim(q10_2) == "98")
assert inrange(wp07_state_q10_2, 1, 6)

label values wp07_state_* wp07_response_state
drop _valid_q4_1_1 _valid_q4_12_1 _valid_q5_13_1 _valid_q9_17_1 _valid_q9_21_1 _valid_q10_2_1 _valid_q10_2_2

* ============================================================================
* Accepted fixed-component candidates and distinct engagement outcomes
* A component is scored only in its ordinary-valid item state. No available-item mean.

* Residence: code 4 changes meaning; code 5 is Meta only on the later form.
gen byte wp07_residence = q3 if wp07_known_form == 1 & inlist(q3, 1, 2, 3)
replace wp07_residence = 4 if q3 == 4 & inlist(formdef_version, 2512090157, 2512091719)
replace wp07_residence = 5 if q3 == 4 & inlist(formdef_version, 2512111044, 2512121811, 2602120658)
replace wp07_residence = 6 if q3 == 5 & formdef_version == 2602120658
label define wp07_residence_lbl 1 "Bogota" 2 "Cali" 3 "Medellin" 4 "Other (early forms)" ///
    5 "Soacha" 6 "Meta (municipality unspecified)"
label values wp07_residence wp07_residence_lbl

* Account applicability reuses the exact item route, including duplicate-code review.
* Empty or malformed account selections are not evidence of account nonuse.
gen byte wp07_account_route = wp07_route_q4_15

* D3 IVS: education component only. The date source and fixed bounds are still open.
gen double wp07_ivs_educ = (10 - q2_2) / 9 if wp07_state_q2_2 == 1

* IAT: fixed weights; location, plan status and reading stay separate.
gen double wp07_iat_phone = .
replace wp07_iat_phone = 1 if q3_1 == 1 & wp07_state_q3_1 == 1
replace wp07_iat_phone = .5 if q3_1 == 2 & wp07_state_q3_1 == 1
replace wp07_iat_phone = 0 if q3_1 == 3 & wp07_state_q3_1 == 1
gen double wp07_iat_internet = .
replace wp07_iat_internet = 1 if q3_5 == 1 & wp07_state_q3_5 == 1
replace wp07_iat_internet = .75 if q3_5 == 2 & wp07_state_q3_5 == 1
replace wp07_iat_internet = .5 if q3_5 == 3 & wp07_state_q3_5 == 1
replace wp07_iat_internet = .25 if q3_5 == 4 & wp07_state_q3_5 == 1
replace wp07_iat_internet = 0 if q3_5 == 5 & wp07_state_q3_5 == 1
gen double wp07_iat_runout = .
replace wp07_iat_runout = 0 if q3_8 == 1 & wp07_state_q3_8 == 1
replace wp07_iat_runout = .5 if q3_8 == 2 & wp07_state_q3_8 == 1
replace wp07_iat_runout = 1 if q3_8 == 3 & wp07_state_q3_8 == 1
gen double wp07_iat3 = (wp07_iat_phone + wp07_iat_internet + wp07_iat_runout) / 3

* IADT: app installation is smartphone-only; transfer also allows basic phones.
gen double wp07_iadt_app = (q3_15 - 1) / 4 if wp07_state_q3_15 == 1
gen double wp07_iadt_transfer = (q3_16 - 1) / 4 if wp07_state_q3_16 == 1
gen double wp07_iadt_confidence = (q3_17 - 1) / 4 if wp07_state_q3_17 == 1
gen double wp07_iadt3 = (wp07_iadt_app + wp07_iadt_transfer + wp07_iadt_confidence) / 3
gen double wp07_iadt2 = (wp07_iadt_transfer + wp07_iadt_confidence) / 2

* ICDP: unfamiliarity with OTP and app nonuse do not score zero.
gen double wp07_icdp_otp = .
replace wp07_icdp_otp = 1 if q3_21 == 1 & wp07_state_q3_21 == 1
replace wp07_icdp_otp = .5 if q3_21 == 2 & wp07_state_q3_21 == 1
replace wp07_icdp_otp = 0 if q3_21 == 3 & wp07_state_q3_21 == 1
gen double wp07_icdp_pin = .
replace wp07_icdp_pin = 1 if q3_22 == 1 & wp07_state_q3_22 == 1
replace wp07_icdp_pin = 0 if q3_22 == 2 & wp07_state_q3_22 == 1
gen double wp07_icdp2 = (wp07_icdp_otp + wp07_icdp_pin) / 2

* IAFF: own-name proof and telephone only; documentation and account types stay separate.
gen double wp07_iaff_address = .
replace wp07_iaff_address = 1 if q4_5 == 1 & wp07_state_q4_5 == 1
replace wp07_iaff_address = 0 if q4_5 == 2 & wp07_state_q4_5 == 1
gen double wp07_iaff_phone = .
replace wp07_iaff_phone = 1 if q4_6 == 1 & wp07_state_q4_6 == 1
replace wp07_iaff_phone = 0 if inlist(q4_6, 2, 3) & wp07_state_q4_6 == 1
gen double wp07_iaff2 = (wp07_iaff_address + wp07_iaff_phone) / 2

* IUOF: selected activity, not cash access or general operability.
gen double wp07_iuof_frequency = .
replace wp07_iuof_frequency = 1 if q4_15 == 1 & wp07_state_q4_15 == 1
replace wp07_iuof_frequency = .75 if q4_15 == 2 & wp07_state_q4_15 == 1
replace wp07_iuof_frequency = .5 if q4_15 == 3 & wp07_state_q4_15 == 1
replace wp07_iuof_frequency = .25 if q4_15 == 4 & wp07_state_q4_15 == 1
replace wp07_iuof_frequency = 0 if q4_15 == 5 & wp07_state_q4_15 == 1
gen double wp07_iuof_merchant = .
replace wp07_iuof_merchant = 1 if q4_24 == 1 & wp07_state_q4_24 == 1
replace wp07_iuof_merchant = .5 if q4_24 == 2 & wp07_state_q4_24 == 1
replace wp07_iuof_merchant = 0 if q4_24 == 3 & wp07_state_q4_24 == 1
gen double wp07_iuof_saving = .
replace wp07_iuof_saving = 1 if q4_25 == 1 & wp07_state_q4_25 == 1
replace wp07_iuof_saving = .5 if q4_25 == 2 & wp07_state_q4_25 == 1
replace wp07_iuof_saving = 0 if q4_25 == 3 & wp07_state_q4_25 == 1
gen double wp07_iuof3 = (wp07_iuof_frequency + wp07_iuof_merchant + wp07_iuof_saving) / 3
* These are alternative definitions, not substitutes for missing items.
gen double wp07_iuof_frequency_oldmap = .
replace wp07_iuof_frequency_oldmap = 1 if q4_15 == 1 & wp07_state_q4_15 == 1
replace wp07_iuof_frequency_oldmap = .8 if q4_15 == 2 & wp07_state_q4_15 == 1
replace wp07_iuof_frequency_oldmap = .6 if q4_15 == 3 & wp07_state_q4_15 == 1
replace wp07_iuof_frequency_oldmap = .4 if q4_15 == 4 & wp07_state_q4_15 == 1
replace wp07_iuof_frequency_oldmap = 0 if q4_15 == 5 & wp07_state_q4_15 == 1
gen double wp07_iuof3_oldmap = (wp07_iuof_frequency_oldmap + wp07_iuof_merchant + wp07_iuof_saving) / 3
gen double wp07_iuof2_no_frequency = (wp07_iuof_merchant + wp07_iuof_saving) / 2

* OQI: registration ease and initial support only; activation time stays separate.
gen double wp07_oqi_ease = .
replace wp07_oqi_ease = 1 if q5_14 == 1 & wp07_state_q5_14 == 1
replace wp07_oqi_ease = 2/3 if q5_14 == 2 & wp07_state_q5_14 == 1
replace wp07_oqi_ease = 1/3 if q5_14 == 3 & wp07_state_q5_14 == 1
replace wp07_oqi_ease = 0 if q5_14 == 4 & wp07_state_q5_14 == 1
gen double wp07_oqi_support = .
replace wp07_oqi_support = 1 if q5_23 == 1 & wp07_state_q5_23 == 1
replace wp07_oqi_support = .5 if q5_23 == 2 & wp07_state_q5_23 == 1
replace wp07_oqi_support = 0 if q5_23 == 3 & wp07_state_q5_23 == 1
gen double wp07_oqi2 = (wp07_oqi_ease + wp07_oqi_support) / 2
gen double wp07_oqi_ease_oldmap = .
replace wp07_oqi_ease_oldmap = 1 if q5_14 == 1 & wp07_state_q5_14 == 1
replace wp07_oqi_ease_oldmap = .75 if q5_14 == 2 & wp07_state_q5_14 == 1
replace wp07_oqi_ease_oldmap = .25 if q5_14 == 3 & wp07_state_q5_14 == 1
replace wp07_oqi_ease_oldmap = 0 if q5_14 == 4 & wp07_state_q5_14 == 1
gen double wp07_oqi2_oldmap = (wp07_oqi_ease_oldmap + wp07_oqi_support) / 2

* D3 IURD and D4: two distinct engagement outcomes; neither is latest receipt channel.
gen byte wp07_remit_disposition = q6_13 if wp07_state_q6_13 == 1
gen byte wp07_remit_any_digital = (q6_13 != 1) if !missing(wp07_remit_disposition)
gen byte wp07_domestic_60d = q6_14 if wp07_state_q6_14 == 1
* Preserve the offered uncertainty category; it is not a substantive operation bin.
gen byte wp07_domestic_ops_bin = q6_15 if inlist(wp07_state_q6_15, 1, 5)
* Literal category wording is retained; these are not measured cash/digital fractions.
label define wp07_remit_lbl 1 "Todo lo retiro en efectivo" ///
    2 "Retiro menos de la mitad en efectivo" ///
    3 "Dejo la mitad en efectivo y la mitad de manera digital" ///
    4 "Dejo más de la mitad digital" ///
    5 "Mantengo el 100% del dinero de manera digital"
label values wp07_remit_disposition wp07_remit_lbl
label define wp07_ops_lbl 1 "Menos de 5" 2 "Entre 5 y 10" ///
    3 "Entre 10 y 20" 4 "Entre 20 y 50" 5 "Más de 50" ///
    98 "No sabe / No recuerda"
label values wp07_domestic_ops_bin wp07_ops_lbl
label define wp07_yesno_lbl 0 "No" 1 "Sí"
label values wp07_remit_any_digital wp07_domestic_60d wp07_yesno_lbl
label variable wp07_remit_any_digital "Reported any digital remittance retention or use"
label variable wp07_domestic_60d "Reported domestic digital participation, 60 days"

* No replacement pooled IURD, IETR, IPCS, IEDF, IAER, ICPF, IEH or IBPD score.
label variable wp07_ivs_educ "Education component; not a normalized IVS composite"
label variable wp07_iat3 "Access/basic use: fixed three-item candidate"
label variable wp07_iadt2 "Reported transfer/confidence: fixed two-item candidate"
label variable wp07_iadt3 "Reported app/transfer/confidence: smartphone comparison"
label variable wp07_icdp2 "Reported OTP/PIN practices: fixed two-item alternative"
label variable wp07_iaff2 "Address-proof/own-name phone: fixed two-condition candidate"
label variable wp07_iuof3 "Selected activity: frequency/merchant/saving candidate"
label variable wp07_iuof3_oldmap "Selected activity: historical frequency-spacing comparison"
label variable wp07_iuof2_no_frequency "Merchant/saving: declared frequency-omission comparison"
label variable wp07_oqi2 "Registration ease/offered support: two-item candidate"
label variable wp07_oqi2_oldmap "Registration/support: historical ease-spacing comparison"
* Their accepted item-level representations use the unchanged original fields.
* No D4 estimators or D6 class inputs are constructed here.

