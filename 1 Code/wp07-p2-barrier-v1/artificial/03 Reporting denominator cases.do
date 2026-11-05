* Exact reporting blocks: denominators and semantic diagnostics -- artificial-only draft, not run.
* No source or participant file is loaded. Do not remove the hold under this task.
exit 198

version 16
assert _N == 0

* Mixed version rows; early code4 Other vs later Soacha; Meta only latest; unknown retained.
input double formdef_version byte eligible_flag double q3
2512090157 1 4
2512111044 1 4
2602120658 1 5
2512090157 1 5
9999999999 1 4
2602120658 1 .
end
local admitted_n = _N
* BEGIN FULL_REPORT_q3
* ITEM q3 | Residence geography; accepted D2 version-aware meanings
* D2 meanings: early code 4 Other; later code 4 Soacha; code 5 Meta only in the latest version.
* Offered options [2512090157, 2512091719]:
* 1 = Bogota
* 2 = Cali
* 3 = Medellin
* 4 = Other (early forms)
* Offered options [2512111044, 2512121811]:
* 1 = Bogota
* 2 = Cali
* 3 = Medellin
* 4 = Soacha
* Offered options [2602120658]:
* 1 = Bogota
* 2 = Cali
* 3 = Medellin
* 4 = Soacha
* 5 = Meta (municipality unspecified)
confirm numeric variable q3, exact
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
assert inrange(_ar_q3, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3 == `state'
    display as text "q3 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    if `fv' == 2512090157 {
        local options "1 2 3 4"
    }
    if `fv' == 2512091719 {
        local options "1 2 3 4"
    }
    if `fv' == 2512111044 {
        local options "1 2 3 4"
    }
    if `fv' == 2512121811 {
        local options "1 2 3 4"
    }
    quietly count if formdef_version == `fv' & _ara_q3 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3, 1, 5)
    local recorded_n = r(N)
    display as text "q3 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3, 1, 5) & q3 == `option'
        local category_n = r(N)
        display as text "q3 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3 _ara_q3
* END FULL_REPORT_q3
assert _N == 6
assert `applicable_n' == 2
assert `regular_n' == 1
assert `sentinel_n' == 0
assert `recorded_n' == 1
drop _all
assert _N == 0

* Code98 uncertainty, not refusal; uncertainty combination unresolved; nonresponse kept.
input double formdef_version byte eligible_flag str8 q4_12 str20 q5_13
2602120658 1 "1" "1"
2602120658 1 "1" "1 2"
2602120658 1 "1" "98"
2602120658 1 "1" ""
2602120658 1 "1" "98 1"
end
local admitted_n = _N
* BEGIN FULL_REPORT_q5_13
* ITEM q5_13 | En su registro (onboarding) más reciente, ¿qué le pidieron para verificar su identidad? (Marque todo lo que aplique).
* Offered options [2512111044, 2512090157, 2512091719, 2512121811, 2602120658]:
* 1 = Documento con foto
* 2 = Foto o biometría
* 3 = Huella dactilar
* 4 = Prueba de dirección o domicilio (recibo)
* 5 = Línea a su nombre
* 6 = Referencia personal
* 7 = Otro (especifique)
* 98 = No sabe / No recuerda
confirm string variable q5_13, exact
gen byte _ar_q5_13 = 6
gen byte _ara_q5_13 = .
replace _ara_q5_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q5_13 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q5_13 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_13 == 0 & (strtrim(q5_13) == "")
replace _ar_q5_13 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_13 == 1 & (strtrim(q5_13) == "")
replace _ar_q5_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_13 == 1 & (regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
replace _ar_q5_13 = 6 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q5_13 == 1 & (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0) & wordcount(q5_13) > 1
replace _ar_q5_13 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q5_13 == 1 & (strtrim(q5_13) == "98")
assert inrange(_ar_q5_13, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q5_13 == `state'
    display as text "q5_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 98"
    quietly count if formdef_version == `fv' & _ara_q5_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q5_13, 1, 5)
    local recorded_n = r(N)
    display as text "q5_13 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        if `option' == 98 {
            quietly count if formdef_version == `fv' & _ar_q5_13 == 5 & ///
                strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0
            local uncertainty_n = r(N)
            display as text "q5_13 uncertainty N: " as result `uncertainty_n'
            if `recorded_n' > 0 {
                display as text "Percent all recorded parents uncertain: " as result 100 * `uncertainty_n' / `recorded_n'
            }
        }
        else {
            quietly count if formdef_version == `fv' & _ar_q5_13 == 1 & ///
                strpos(" " + itrim(strtrim(q5_13)) + " ", " `option' ") > 0
            local selected_n = r(N)
            display as text "q5_13 offered option " `option' " selected N: " as result `selected_n'
            if `regular_n' > 0 {
                display as text "Percent ordinary valid parents: " as result 100 * `selected_n' / `regular_n'
            }
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q5_13 _ara_q5_13
* END FULL_REPORT_q5_13
assert _N == 5
assert `applicable_n' == 5
assert `regular_n' == 2
assert `sentinel_n' == 1
assert `recorded_n' == 3
assert `uncertainty_n' == 1
drop _all
assert _N == 0

* No account after positive selection; missing principal product; duplicate selection remains unresolved.
input double formdef_version byte eligible_flag str8 q4_12 double q4_13
2602120658 1 "1" 5
2602120658 1 "1" 2
2602120658 1 "1 2" 2
2602120658 1 "1 1" 1
end
local admitted_n = _N
* BEGIN FULL_REPORT_q4_13
* ITEM q4_13 | De las cuentas o billeteras que mencionó, ¿cuál es la principal para recibir o manejar dinero?
* Offered options [2602120658, 2512090157, 2512091719, 2512111044, 2512121811]:
* 1 = Banco
* 2 = Billetera digital
* 3 = Cooperativa / Financiera solidaria
* 4 = Fintech/EMI
* 5 = No tengo una cuenta
confirm numeric variable q4_13, exact
gen byte _ar_q4_13 = 6
gen byte _ara_q4_13 = .
replace _ara_q4_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q4_13 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q4_13 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_13 == 0 & (missing(q4_13))
replace _ar_q4_13 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_13 == 1 & (missing(q4_13))
replace _ar_q4_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_13 == 1 & (q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
assert inrange(_ar_q4_13, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_13 == `state'
    display as text "q4_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q4_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_13, 1, 5)
    local recorded_n = r(N)
    display as text "q4_13 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q4_13, 1, 5) & q4_13 == `option'
        local category_n = r(N)
        display as text "q4_13 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
* IUOF cross-item semantic review; this route already requires a valid positive q4_12 parent.
quietly count if _ara_q4_13 == 1 & q4_13 == 5
display as text "No account after positive account selection (semantic hold, no repair) N: " as result r(N)
forvalues product = 1/4 {
    quietly count if _ar_q4_13 == 1 & q4_13 == `product' & ///
        !(strpos(" " + itrim(strtrim(q4_12)) + " ", " `product' ") > 0)
    display as text "Principal product absent from selected accounts (semantic hold, no repair) code " `product' " N: " as result r(N)
}
drop _ar_q4_13 _ara_q4_13
* END FULL_REPORT_q4_13
assert _N == 4
assert `applicable_n' == 3
assert `regular_n' == 3
assert `sentinel_n' == 0
assert `recorded_n' == 3
drop _all
assert _N == 0

* Substantive code4 including combinations; later None conflict; separate main-None semantic count.
input double formdef_version byte eligible_flag double q10_1 str20 q10_2
2602120658 1 16 "4"
2602120658 1 4 "2 4"
2602120658 1 4 "98"
2602120658 1 4 "16"
2602120658 1 4 "16 4"
end
local admitted_n = _N
* BEGIN FULL_REPORT_q10_2
* ITEM q10_2 | Además de esa razón principal, ¿qué otras dificultades o barreras siente que enfrenta para usar pagos digitales?
* Option 4 is substantive lack of know-how, including when selected with other barriers.
* Offered options [2512091719, 2512111044, 2602120658, 2512121811]:
* 1 = No tengo teléfono propio
* 2 = No tengo datos / internet
* 3 = No confío en estos sistemas
* 4 = No sé cómo usarlos
* 5 = Costos o comisiones son altos
* 6 = Documentos no aceptados
* 7 = Mala señal de celular o servicio inestable
* 8 = Agentes o cajeros lejos
* 9 = Por familia / prefiero efectivo
* 10 = Tuve malas experiencias o casos de fraude
* 11 = Idioma o términos que no entiendo
* 12 = Baja alfabetización
* 14 = Miedo a equivocarme
* 15 = Soporte o atención al cliente difícil de contactar
* 16 = Ninguna de las anteriores
* 98 = Prefiero no responder
* Offered options [2512090157]:
* 2 = No tengo datos / internet
* 3 = No confío en estos sistemas
* 4 = No sé cómo usarlos
* 5 = Costos o comisiones son altos
* 6 = Documnetos no aceptados
* 7 = Mala señal de celular o servicio inestable
* 8 = Agentes o cajeros lejps
* 9 = Por familia / prefiero efectivo
* 10 = Tuve malas experiencias o casos de fraude
* 11 = Idioma o términos que no entiendo
* 12 = Baja alfabetización
* 14 = Miedo a equivocarme
* 15 = Soporte o atención al cliente difícil de contactar
* 16 = Otra (especifique)
* 98 = Prefiero no responder
confirm string variable q10_2, exact
gen byte _ar_q10_2 = 6
gen byte _ara_q10_2 = .
replace _ara_q10_2 = 1 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_2 = 0 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_2 = 2 if inlist(formdef_version, 2512090157) & _ara_q10_2 == 0 & (strtrim(q10_2) == "")
replace _ar_q10_2 = 4 if inlist(formdef_version, 2512090157) & _ara_q10_2 == 1 & (strtrim(q10_2) == "")
replace _ar_q10_2 = 1 if inlist(formdef_version, 2512090157) & _ara_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
replace _ar_q10_2 = 6 if inlist(formdef_version, 2512090157) & _ar_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
replace _ar_q10_2 = 5 if inlist(formdef_version, 2512090157) & _ar_q10_2 == 1 & (strtrim(q10_2) == "98")
replace _ara_q10_2 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_2 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_2 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_2 == 0 & (strtrim(q10_2) == "")
replace _ar_q10_2 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_2 == 1 & (strtrim(q10_2) == "")
replace _ar_q10_2 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
replace _ar_q10_2 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
replace _ar_q10_2 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
replace _ar_q10_2 = 5 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_2 == 1 & (strtrim(q10_2) == "98")
assert inrange(_ar_q10_2, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q10_2 == `state'
    display as text "q10_2 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 8 9 10 11 12 14 15 16 98"
    if `fv' == 2512090157 {
        local options "2 3 4 5 6 7 8 9 10 11 12 14 15 16 98"
    }
    quietly count if formdef_version == `fv' & _ara_q10_2 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_2 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_2 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q10_2, 1, 5)
    local recorded_n = r(N)
    display as text "q10_2 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        if `option' == 98 {
            quietly count if formdef_version == `fv' & _ar_q10_2 == 5 & ///
                strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0
            local refusal_n = r(N)
            display as text "q10_2 refusal N: " as result `refusal_n'
            if `recorded_n' > 0 {
                display as text "Percent all recorded parents refusing: " as result 100 * `refusal_n' / `recorded_n'
            }
        }
        else {
            quietly count if formdef_version == `fv' & _ar_q10_2 == 1 & ///
                strpos(" " + itrim(strtrim(q10_2)) + " ", " `option' ") > 0
            local selected_n = r(N)
            display as text "q10_2 offered option " `option' " selected N: " as result `selected_n'
            if `regular_n' > 0 {
                display as text "Percent ordinary valid parents: " as result 100 * `selected_n' / `regular_n'
            }
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
* D3 cross-item semantic review: main None versus valid additional named barriers.
* Count only later forms where main code 16 means None; do not change either answer.
quietly count if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ///
    q10_1 == 16 & _ar_q10_2 == 1 & ///
    regexm(itrim(strtrim(q10_2)), "(^| )(1|2|3|4|5|6|7|8|9|10|11|12|14|15)( |$)")
display as text "Main None with valid additional named barriers (review, no repair) N: " as result r(N)
drop _ar_q10_2 _ara_q10_2
* END FULL_REPORT_q10_2
assert _N == 5
assert `applicable_n' == 5
assert `regular_n' == 3
assert `sentinel_n' == 1
assert `recorded_n' == 4
assert `refusal_n' == 1
drop _all
assert _N == 0

* Empty-base case: all input variables exist but there are zero observations.
input double formdef_version byte eligible_flag str8 q4_12 str20 q5_13
end
local admitted_n = _N
* BEGIN FULL_REPORT_q5_13_EMPTY
* ITEM q5_13 | En su registro (onboarding) más reciente, ¿qué le pidieron para verificar su identidad? (Marque todo lo que aplique).
* Offered options [2512111044, 2512090157, 2512091719, 2512121811, 2602120658]:
* 1 = Documento con foto
* 2 = Foto o biometría
* 3 = Huella dactilar
* 4 = Prueba de dirección o domicilio (recibo)
* 5 = Línea a su nombre
* 6 = Referencia personal
* 7 = Otro (especifique)
* 98 = No sabe / No recuerda
confirm string variable q5_13, exact
gen byte _ar_q5_13 = 6
gen byte _ara_q5_13 = .
replace _ara_q5_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q5_13 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q5_13 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_13 == 0 & (strtrim(q5_13) == "")
replace _ar_q5_13 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_13 == 1 & (strtrim(q5_13) == "")
replace _ar_q5_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_13 == 1 & (regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
replace _ar_q5_13 = 6 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q5_13 == 1 & (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0) & wordcount(q5_13) > 1
replace _ar_q5_13 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q5_13 == 1 & (strtrim(q5_13) == "98")
assert inrange(_ar_q5_13, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q5_13 == `state'
    display as text "q5_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 98"
    quietly count if formdef_version == `fv' & _ara_q5_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q5_13, 1, 5)
    local recorded_n = r(N)
    display as text "q5_13 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        if `option' == 98 {
            quietly count if formdef_version == `fv' & _ar_q5_13 == 5 & ///
                strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0
            local uncertainty_n = r(N)
            display as text "q5_13 uncertainty N: " as result `uncertainty_n'
            if `recorded_n' > 0 {
                display as text "Percent all recorded parents uncertain: " as result 100 * `uncertainty_n' / `recorded_n'
            }
        }
        else {
            quietly count if formdef_version == `fv' & _ar_q5_13 == 1 & ///
                strpos(" " + itrim(strtrim(q5_13)) + " ", " `option' ") > 0
            local selected_n = r(N)
            display as text "q5_13 offered option " `option' " selected N: " as result `selected_n'
            if `regular_n' > 0 {
                display as text "Percent ordinary valid parents: " as result 100 * `selected_n' / `regular_n'
            }
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q5_13 _ara_q5_13
* END FULL_REPORT_q5_13_EMPTY
assert _N == 0
assert `recorded_n' == 0
assert `regular_n' == 0
assert `sentinel_n' == 0
