* WP07 academic item/domain reporting v1 -- disabled source draft.
* No execution or participant-processing permission. Appendix C2 remains on hold.
exit 198

version 16
set varabbrev off
* Input: the exact separately verified admitted carrier already in memory.
* Never load an alternative file, change cohort membership or repair source answers.
* All prospective output is restricted, including small cells and rare options.
* Numeric codes are deliberate: use the version-specific CODEBOOK.csv, not legacy labels.
* Each item uses its own route and recorded-answer denominator, never a common complete-case sample.
* Six states: 1 ordinary valid answer; 2 structural skip; 3 unavailable in version;
* 4 applicable nonresponse; 5 item-specific sentinel; 6 unresolved route/domain/combination.
* State 5 is not an invalid answer: N/A, pending, uncertainty and refusal retain their meanings.
* State 6 is a reporting hold, not a correction or a new cohort exclusion.
* Ordinary code/route validity is not clearance of cross-item semantic contradictions.
* No sentinel becomes zero. No optional binary or composite is constructed here.
confirm numeric variable formdef_version eligible_flag, exact
count
local admitted_n = r(N)
display as text "Admitted rows retained: " as result `admitted_n'
count if !inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658)
display as text "Unknown-version rows remain unresolved; they are not discarded."

* ============================================================================
* DOMAIN IAT: Telecommunications access and basic use
* No pooled domain score or model is estimated by this section.

* ITEM q3_1 | ¿Usted tiene personalmente un teléfono móvil que usa con regularidad?
* Offered options [2512091719, 2602120658, 2512121811, 2512090157, 2512111044]:
* 1 = Sí, un teléfono inteligente (smartphone)
* 2 = Sí, un teléfono básico
* 3 = No
confirm numeric variable q3_1, exact
gen byte _ar_q3_1 = 6
gen byte _ara_q3_1 = .
replace _ara_q3_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q3_1 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q3_1 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_1 == 0 & (missing(q3_1))
replace _ar_q3_1 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_1 == 1 & (missing(q3_1))
replace _ar_q3_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_1 == 1 & (q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
assert inrange(_ar_q3_1, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_1 == `state'
    display as text "q3_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3"
    quietly count if formdef_version == `fv' & _ara_q3_1 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_1 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_1 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_1, 1, 5)
    local recorded_n = r(N)
    display as text "q3_1 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_1, 1, 5) & q3_1 == `option'
        local category_n = r(N)
        display as text "q3_1 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_1 _ara_q3_1

* ITEM q3_5 | ¿Con qué frecuencia usa Internet en cualquier dispositivo?
* Offered options [2512090157, 2602120658, 2512111044, 2512091719, 2512121811]:
* 1 = Diariamente
* 2 = Varias veces por semana
* 3 = Una vez a la semana
* 4 = Menos de una vez a la semana
* 5 = Nunca
confirm numeric variable q3_5, exact
gen byte _ar_q3_5 = 6
gen byte _ara_q3_5 = .
replace _ara_q3_5 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q3_5 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q3_5 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_5 == 0 & (missing(q3_5))
replace _ar_q3_5 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_5 == 1 & (missing(q3_5))
replace _ar_q3_5 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_5 == 1 & (q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
assert inrange(_ar_q3_5, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_5 == `state'
    display as text "q3_5 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q3_5 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_5 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_5 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_5, 1, 5)
    local recorded_n = r(N)
    display as text "q3_5 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_5, 1, 5) & q3_5 == `option'
        local category_n = r(N)
        display as text "q3_5 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_5 _ara_q3_5

* ITEM q3_6 | ¿Dónde accede principalmente a Internet?
* Offered options [2602120658, 2512121811, 2512111044]:
* 1 = Hogar (wifi)
* 2 = Trabajo / lugar de estudios
* 3 = Datos del teléfono
* 4 = WI-FI público
* 5 = Casa de familiar / amigo
* 6 = Otro (especifique)
* Offered options [2512091719, 2512090157]:
* 1 = Hogar (wifi)
* 2 = Trabajo / lugar de estudios
* 3 = Datos del teléfono
* 4 = WI-FI público
* 5 = Casa de familiar / amigo
* 6 = Otro
confirm numeric variable q3_6, exact
gen byte _ar_q3_6 = 6
gen byte _ara_q3_6 = .
replace _ara_q3_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5)))
replace _ara_q3_6 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5)))
replace _ar_q3_6 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_6 == 0 & (missing(q3_6))
replace _ar_q3_6 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_6 == 1 & (missing(q3_6))
replace _ar_q3_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_6 == 1 & (q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
assert inrange(_ar_q3_6, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_6 == `state'
    display as text "q3_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6"
    quietly count if formdef_version == `fv' & _ara_q3_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_6, 1, 5)
    local recorded_n = r(N)
    display as text "q3_6 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_6, 1, 5) & q3_6 == `option'
        local category_n = r(N)
        display as text "q3_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_6 _ara_q3_6

* ITEM q3_7 | Actualmente, ¿cuenta con un plan de datos móviles activo en su teléfono principal?
* Offered options [2512091719, 2602120658, 2512121811, 2512090157, 2512111044]:
* 1 = Sí, postpago
* 2 = Sí, prepago/paquete de datos
* 3 = No
* 99 = No aplica (no uso datos)
confirm numeric variable q3_7, exact
gen byte _ar_q3_7 = 6
gen byte _ara_q3_7 = .
replace _ara_q3_7 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
replace _ara_q3_7 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
replace _ar_q3_7 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_7 == 0 & (missing(q3_7))
replace _ar_q3_7 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_7 == 1 & (missing(q3_7))
replace _ar_q3_7 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_7 == 1 & (q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
replace _ar_q3_7 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q3_7 == 1 & (q3_7 == 99)
assert inrange(_ar_q3_7, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_7 == `state'
    display as text "q3_7 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & _ara_q3_7 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_7 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_7 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_7, 1, 5)
    local recorded_n = r(N)
    display as text "q3_7 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_7, 1, 5) & q3_7 == `option'
        local category_n = r(N)
        display as text "q3_7 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_7 _ara_q3_7

* ITEM q3_8 | En el último mes, ¿se quedó sin datos o saldo y eso le impidió usar servicios financieros o comunicarse?
* Offered options [2512091719, 2512121811, 2602120658, 2512111044, 2512090157]:
* 1 = Sí, varias veces
* 2 = Sí, una vez
* 3 = No
* 99 = No aplica
confirm numeric variable q3_8, exact
gen byte _ar_q3_8 = 6
gen byte _ara_q3_8 = .
replace _ara_q3_8 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
replace _ara_q3_8 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
replace _ar_q3_8 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_8 == 0 & (missing(q3_8))
replace _ar_q3_8 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_8 == 1 & (missing(q3_8))
replace _ar_q3_8 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_8 == 1 & (q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
replace _ar_q3_8 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q3_8 == 1 & (q3_8 == 99)
assert inrange(_ar_q3_8, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_8 == `state'
    display as text "q3_8 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & _ara_q3_8 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_8 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_8 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_8, 1, 5)
    local recorded_n = r(N)
    display as text "q3_8 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_8, 1, 5) & q3_8 == `option'
        local category_n = r(N)
        display as text "q3_8 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_8 _ara_q3_8

* ITEM q3_12 | ¿Puede leer mensajes cortos en su teléfono sin ayuda de otra persona?
* Offered options [2512091719, 2512121811, 2512111044, 2602120658, 2512090157]:
* 1 = Siempre
* 2 = A veces
* 3 = Nunca
confirm numeric variable q3_12, exact
gen byte _ar_q3_12 = 6
gen byte _ara_q3_12 = .
replace _ara_q3_12 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
replace _ara_q3_12 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
replace _ar_q3_12 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_12 == 0 & (missing(q3_12))
replace _ar_q3_12 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_12 == 1 & (missing(q3_12))
replace _ar_q3_12 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_12 == 1 & (q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
assert inrange(_ar_q3_12, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_12 == `state'
    display as text "q3_12 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3"
    quietly count if formdef_version == `fv' & _ara_q3_12 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_12 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_12 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_12, 1, 5)
    local recorded_n = r(N)
    display as text "q3_12 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_12, 1, 5) & q3_12 == `option'
        local category_n = r(N)
        display as text "q3_12 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_12 _ara_q3_12

* ============================================================================
* DOMAIN IVS: Socioeconomic, migration and geographic context
* No pooled domain score or model is estimated by this section.

* ITEM q2_1 | ¿En qué año llegó a vivir a Colombia por primera vez?
* First-arrival calendar year only; no tenure, reference year, IVS gap or normalization is calculated.
confirm numeric variable q2_1, exact
gen byte _ar_q2_1 = 6
gen byte _ara_q2_1 = .
replace _ara_q2_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q2_1 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q2_1 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_1 == 0 & (missing(q2_1))
replace _ar_q2_1 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_1 == 1 & (missing(q2_1))
replace _ar_q2_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_1 == 1 & (inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
assert inrange(_ar_q2_1, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q2_1 == `state'
    display as text "q2_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Numeric context only. Its own ordinary-valid N is not a common model sample.
quietly count if _ar_q2_1 == 1
if r(N) > 0 {
    tabstat q2_1 if _ar_q2_1 == 1, statistics(n mean sd min p25 p50 p75 max) columns(statistics)
}
drop _ar_q2_1 _ara_q2_1

* ITEM q2_2 | ¿Cuál es el último nivel de estudios que completó?
* Offered options [2602120658, 2512111044, 2512121811, 2512090157, 2512091719]:
* 1 = Sin estudios
* 2 = Primaria incompleta
* 3 = Primaria completa
* 4 = Secundaria incompleta
* 5 = Secundaria completa
* 6 = Técnico superior incompleto
* 7 = Técnico superior completo
* 8 = Universitario incompleto
* 9 = Universitario completo
* 10 = Maestría o posgrado
confirm numeric variable q2_2, exact
gen byte _ar_q2_2 = 6
gen byte _ara_q2_2 = .
replace _ara_q2_2 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q2_2 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q2_2 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_2 == 0 & (missing(q2_2))
replace _ar_q2_2 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_2 == 1 & (missing(q2_2))
replace _ar_q2_2 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_2 == 1 & (q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
assert inrange(_ar_q2_2, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q2_2 == `state'
    display as text "q2_2 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 8 9 10"
    quietly count if formdef_version == `fv' & _ara_q2_2 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q2_2 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q2_2 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q2_2, 1, 5)
    local recorded_n = r(N)
    display as text "q2_2 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q2_2, 1, 5) & q2_2 == `option'
        local category_n = r(N)
        display as text "q2_2 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q2_2 _ara_q2_2

* ITEM q2_3 | Actualmente, ¿cuál es su ocupación principal?
* Offered options [2512090157, 2512091719, 2602120658, 2512121811, 2512111044]:
* 1 = Empleador o patrono
* 2 = Trabajador independiente
* 3 = Empleado u obrero
* 4 = Trabajador del hogar remunerado
* 5 = Estudiante
* 6 = Jubilado(a)/Pensionista
* 7 = Trabajador familiar no remunerado
* 8 = Actualmente no trabaja
* 9 = Otro (especifique)
confirm numeric variable q2_3, exact
gen byte _ar_q2_3 = 6
gen byte _ara_q2_3 = .
replace _ara_q2_3 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q2_3 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q2_3 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_3 == 0 & (missing(q2_3))
replace _ar_q2_3 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_3 == 1 & (missing(q2_3))
replace _ar_q2_3 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q2_3 == 1 & (q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
assert inrange(_ar_q2_3, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q2_3 == `state'
    display as text "q2_3 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 8 9"
    quietly count if formdef_version == `fv' & _ara_q2_3 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q2_3 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q2_3 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q2_3, 1, 5)
    local recorded_n = r(N)
    display as text "q2_3 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q2_3, 1, 5) & q2_3 == `option'
        local category_n = r(N)
        display as text "q2_3 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q2_3 _ara_q2_3

* ITEM q4 | ¿Cuál es su edad en años cumplidos?
confirm numeric variable q4, exact
gen byte _ar_q4 = 6
gen byte _ara_q4 = .
replace _ara_q4 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
replace _ara_q4 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
replace _ar_q4 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4 == 0 & (missing(q4))
replace _ar_q4 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4 == 1 & (missing(q4))
replace _ar_q4 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4 == 1 & (inrange(q4,18,100) & q4 == floor(q4))
assert inrange(_ar_q4, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4 == `state'
    display as text "q4 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Numeric context only. Its own ordinary-valid N is not a common model sample.
quietly count if _ar_q4 == 1
if r(N) > 0 {
    tabstat q4 if _ar_q4 == 1, statistics(n mean sd min p25 p50 p75 max) columns(statistics)
}
drop _ar_q4 _ara_q4

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

* ============================================================================
* DOMAIN IADT: Reported transactional capability and confidence
* No pooled domain score or model is estimated by this section.

* ITEM q3_15 | Sé descargar e instalar una aplicación en mi teléfono.
* Offered options [2512091719, 2512111044, 2512121811, 2512090157, 2602120658]:
* 1 = Nada cierta
* 2 = Poco cierta
* 3 = Medianamente cierta
* 4 = Muy cierta
* 5 = Totalmente cierta
confirm numeric variable q3_15, exact
gen byte _ar_q3_15 = 6
gen byte _ara_q3_15 = .
replace _ara_q3_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)))
replace _ara_q3_15 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)))
replace _ar_q3_15 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_15 == 0 & (missing(q3_15))
replace _ar_q3_15 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_15 == 1 & (missing(q3_15))
replace _ar_q3_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_15 == 1 & (q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
assert inrange(_ar_q3_15, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_15 == `state'
    display as text "q3_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q3_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_15, 1, 5)
    local recorded_n = r(N)
    display as text "q3_15 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_15, 1, 5) & q3_15 == `option'
        local category_n = r(N)
        display as text "q3_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_15 _ara_q3_15

* ITEM q3_16 | Sé usar mi teléfono para enviar o recibir dinero (transferencias, billetera digital, pago móvil).
* Offered options [2512111044, 2602120658, 2512091719, 2512121811, 2512090157]:
* 1 = Nada cierta
* 2 = Poco cierta
* 3 = Medianamente cierta
* 4 = Muy cierta
* 5 = Totalmente cierta
confirm numeric variable q3_16, exact
gen byte _ar_q3_16 = 6
gen byte _ara_q3_16 = .
replace _ara_q3_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
replace _ara_q3_16 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
replace _ar_q3_16 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_16 == 0 & (missing(q3_16))
replace _ar_q3_16 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_16 == 1 & (missing(q3_16))
replace _ar_q3_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_16 == 1 & (q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
assert inrange(_ar_q3_16, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_16 == `state'
    display as text "q3_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q3_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_16, 1, 5)
    local recorded_n = r(N)
    display as text "q3_16 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_16, 1, 5) & q3_16 == `option'
        local category_n = r(N)
        display as text "q3_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_16 _ara_q3_16

* ITEM q3_17 | Me siento segura evitando fraudes y mensajes sospechosos en línea (PIN, códigos OTP, enlaces).
* Offered options [2512121811, 2512090157, 2512091719, 2602120658, 2512111044]:
* 1 = Nada cierta
* 2 = Poco cierta
* 3 = Medianamente cierta
* 4 = Muy cierta
* 5 = Totalmente cierta
confirm numeric variable q3_17, exact
gen byte _ar_q3_17 = 6
gen byte _ara_q3_17 = .
replace _ara_q3_17 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q3_17 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q3_17 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_17 == 0 & (missing(q3_17))
replace _ar_q3_17 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_17 == 1 & (missing(q3_17))
replace _ar_q3_17 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_17 == 1 & (q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
assert inrange(_ar_q3_17, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_17 == `state'
    display as text "q3_17 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q3_17 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_17 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_17 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_17, 1, 5)
    local recorded_n = r(N)
    display as text "q3_17 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_17, 1, 5) & q3_17 == `option'
        local category_n = r(N)
        display as text "q3_17 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_17 _ara_q3_17

* ============================================================================
* DOMAIN ICDP: Reported OTP/PIN capability and separate responses
* No pooled domain score or model is estimated by this section.

* ITEM q3_20 | En los últimos 3 meses, ¿escaneó un código QR para pagar o para que le paguen?
* Offered options [2512091719, 2512111044, 2602120658, 2512121811, 2512090157]:
* 1 = Sí, para pagar
* 2 = Sí, para recibir
* 3 = Sí, para pagar y recibir pagos
* 4 = No
confirm numeric variable q3_20, exact
gen byte _ar_q3_20 = 6
gen byte _ara_q3_20 = .
replace _ara_q3_20 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
replace _ara_q3_20 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
replace _ar_q3_20 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_20 == 0 & (missing(q3_20))
replace _ar_q3_20 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_20 == 1 & (missing(q3_20))
replace _ar_q3_20 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_20 == 1 & (q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
assert inrange(_ar_q3_20, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_20 == `state'
    display as text "q3_20 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & _ara_q3_20 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_20 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_20 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_20, 1, 5)
    local recorded_n = r(N)
    display as text "q3_20 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_20, 1, 5) & q3_20 == `option'
        local category_n = r(N)
        display as text "q3_20 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_20 _ara_q3_20

* ITEM q3_21 | Si recibe un SMS con un código de verificación (OTP), ¿puede leerlo y usarlo sin ayuda?
* Offered options [2512091719, 2512121811, 2602120658, 2512090157, 2512111044]:
* 1 = Siempre
* 2 = A veces
* 3 = Nunca
* 4 = No sé qué es un OTP
confirm numeric variable q3_21, exact
gen byte _ar_q3_21 = 6
gen byte _ara_q3_21 = .
replace _ara_q3_21 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
replace _ara_q3_21 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
replace _ar_q3_21 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_21 == 0 & (missing(q3_21))
replace _ar_q3_21 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_21 == 1 & (missing(q3_21))
replace _ar_q3_21 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_21 == 1 & (q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
replace _ar_q3_21 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q3_21 == 1 & (q3_21 == 4)
assert inrange(_ar_q3_21, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_21 == `state'
    display as text "q3_21 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & _ara_q3_21 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_21 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_21 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_21, 1, 5)
    local recorded_n = r(N)
    display as text "q3_21 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_21, 1, 5) & q3_21 == `option'
        local category_n = r(N)
        display as text "q3_21 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_21 _ara_q3_21

* ITEM q3_22 | ¿Sabe crear o cambiar el PIN de su aplicación bancaria o billetera digital?
* Offered options [2512090157, 2512091719, 2602120658, 2512121811, 2512111044]:
* 1 = Sí
* 2 = No
* 3 = No uso apps financieras
confirm numeric variable q3_22, exact
gen byte _ar_q3_22 = 6
gen byte _ara_q3_22 = .
replace _ara_q3_22 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
replace _ara_q3_22 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
replace _ar_q3_22 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_22 == 0 & (missing(q3_22))
replace _ar_q3_22 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_22 == 1 & (missing(q3_22))
replace _ar_q3_22 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_22 == 1 & (q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
replace _ar_q3_22 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q3_22 == 1 & (q3_22 == 3)
assert inrange(_ar_q3_22, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_22 == `state'
    display as text "q3_22 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3"
    quietly count if formdef_version == `fv' & _ara_q3_22 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_22 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_22 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_22, 1, 5)
    local recorded_n = r(N)
    display as text "q3_22 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_22, 1, 5) & q3_22 == `option'
        local category_n = r(N)
        display as text "q3_22 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_22 _ara_q3_22

* ITEM q3_23 | Si recibe por WhatsApp o SMS un mensaje sospechoso que solicita dinero, claves o códigos, ¿qué haría primero?
* Offered options [2512111044, 2602120658, 2512091719, 2512121811, 2512090157]:
* 1 = No hago click/No respondo y verifico con la entidad por otro canal
* 2 = Bloqueo y reporto el número
* 3 = Pido más información al remitente
* 4 = Hago clic/comparto datos si parece urgente
* 5 = No sabe
confirm numeric variable q3_23, exact
gen byte _ar_q3_23 = 6
gen byte _ara_q3_23 = .
replace _ara_q3_23 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
replace _ara_q3_23 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
replace _ar_q3_23 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_23 == 0 & (missing(q3_23))
replace _ar_q3_23 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_23 == 1 & (missing(q3_23))
replace _ar_q3_23 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q3_23 == 1 & (q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
replace _ar_q3_23 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q3_23 == 1 & (q3_23 == 5)
assert inrange(_ar_q3_23, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q3_23 == `state'
    display as text "q3_23 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q3_23 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_23 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q3_23 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q3_23, 1, 5)
    local recorded_n = r(N)
    display as text "q3_23 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q3_23, 1, 5) & q3_23 == `option'
        local category_n = r(N)
        display as text "q3_23 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q3_23 _ara_q3_23

* ============================================================================
* DOMAIN IAFF: Administrative conditions and product context
* No pooled domain score or model is estimated by this section.

* ITEM q4_1 | ¿Cuáles de los siguientes documentos de identidad posee actualmente? (Marque todas las que apliquen).
* Offered options [2512090157, 2602120658, 2512121811, 2512091719, 2512111044]:
* 1 = Cédula de ciudadanía colombiana
* 2 = Carnet de extranjería
* 3 = Estatuto Temporal de Protección (PPT)
* 4 = Pasaporte (vigente)
* 5 = Pasaporte (vencido)
* 6 = Cédula venezolana
* 7 = Registro civil/Acta de nacimiento
* 8 = Otro (especifique)
* 9 = Ninguno
* 98 = Prefiero no decir
confirm string variable q4_1, exact
gen byte _ar_q4_1 = 6
gen byte _ara_q4_1 = .
replace _ara_q4_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q4_1 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q4_1 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_1 == 0 & (strtrim(q4_1) == "")
replace _ar_q4_1 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_1 == 1 & (strtrim(q4_1) == "")
replace _ar_q4_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_1 == 1 & (regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
replace _ar_q4_1 = 6 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) & wordcount(q4_1) > 1
replace _ar_q4_1 = 6 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0) & wordcount(q4_1) > 1
replace _ar_q4_1 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_1 == 1 & (strtrim(q4_1) == "98")
assert inrange(_ar_q4_1, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_1 == `state'
    display as text "q4_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 8 9 98"
    quietly count if formdef_version == `fv' & _ara_q4_1 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_1 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_1 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_1, 1, 5)
    local recorded_n = r(N)
    display as text "q4_1 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        if `option' == 98 {
            quietly count if formdef_version == `fv' & _ar_q4_1 == 5 & ///
                strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0
            local refusal_n = r(N)
            display as text "q4_1 refusal N: " as result `refusal_n'
            if `recorded_n' > 0 {
                display as text "Percent all recorded parents refusing: " as result 100 * `refusal_n' / `recorded_n'
            }
        }
        else {
            quietly count if formdef_version == `fv' & _ar_q4_1 == 1 & ///
                strpos(" " + itrim(strtrim(q4_1)) + " ", " `option' ") > 0
            local selected_n = r(N)
            display as text "q4_1 offered option " `option' " selected N: " as result `selected_n'
            if `regular_n' > 0 {
                display as text "Percent ordinary valid parents: " as result 100 * `selected_n' / `regular_n'
            }
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_1 _ara_q4_1

* ITEM q4_5 | ¿Tiene a su nombre algún comprobante de dirección aceptado por entidades financieras (recibo de servicios, contrato de arriendo, certificado de residencia)?
* Offered options [2512111044, 2512090157, 2512091719, 2512121811, 2602120658]:
* 1 = Sí
* 2 = No
* 3 = En trámite
* 4 = Prefiero no decir
confirm numeric variable q4_5, exact
gen byte _ar_q4_5 = 6
gen byte _ara_q4_5 = .
replace _ara_q4_5 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q4_5 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q4_5 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_5 == 0 & (missing(q4_5))
replace _ar_q4_5 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_5 == 1 & (missing(q4_5))
replace _ar_q4_5 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_5 == 1 & (q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
replace _ar_q4_5 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_5 == 1 & (q4_5 == 3)
replace _ar_q4_5 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_5 == 1 & (q4_5 == 4)
assert inrange(_ar_q4_5, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_5 == `state'
    display as text "q4_5 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & _ara_q4_5 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_5 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_5 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_5, 1, 5)
    local recorded_n = r(N)
    display as text "q4_5 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q4_5, 1, 5) & q4_5 == `option'
        local category_n = r(N)
        display as text "q4_5 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_5 _ara_q4_5

* ITEM q4_6 | El número de teléfono que normalmente usa para sus cuentas o billeteras digitales, ¿está registrado a su nombre?
* Offered options [2602120658, 2512090157, 2512121811, 2512091719, 2512111044]:
* 1 = Sí
* 2 = No
* 3 = No tengo línea propia
* 4 = No sabe / No recuerda
confirm numeric variable q4_6, exact
gen byte _ar_q4_6 = 6
gen byte _ara_q4_6 = .
replace _ara_q4_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q4_6 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q4_6 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_6 == 0 & (missing(q4_6))
replace _ar_q4_6 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_6 == 1 & (missing(q4_6))
replace _ar_q4_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_6 == 1 & (q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
replace _ar_q4_6 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_6 == 1 & (q4_6 == 4)
assert inrange(_ar_q4_6, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_6 == `state'
    display as text "q4_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & _ara_q4_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_6, 1, 5)
    local recorded_n = r(N)
    display as text "q4_6 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q4_6, 1, 5) & q4_6 == `option'
        local category_n = r(N)
        display as text "q4_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_6 _ara_q4_6

* ITEM q4_12 | ¿Usted tiene personalmente alguna cuenta en una institución financiera o una cuenta/billetera de dinero móvil? (Marque todas las que apliquen).
* Offered options [2512091719, 2512090157, 2602120658, 2512111044, 2512121811]:
* 1 = Sí, cuenta en banco
* 2 = Sí, billetera digital (p. ej., Nequi, Daviplata, Movii)
* 3 = Sí, en cooperativa/financiera solidaria
* 4 = Sí, fintech/EMI
confirm string variable q4_12, exact
gen byte _ar_q4_12 = 6
gen byte _ara_q4_12 = .
replace _ara_q4_12 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q4_12 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q4_12 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_12 == 0 & (strtrim(q4_12) == "")
replace _ar_q4_12 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_12 == 1 & (strtrim(q4_12) == "")
replace _ar_q4_12 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_12 == 1 & (regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
assert inrange(_ar_q4_12, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_12 == `state'
    display as text "q4_12 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & _ara_q4_12 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_12 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_12 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_12, 1, 5)
    local recorded_n = r(N)
    display as text "q4_12 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & _ar_q4_12 == 1 & ///
            strpos(" " + itrim(strtrim(q4_12)) + " ", " `option' ") > 0
        local selected_n = r(N)
        display as text "q4_12 offered option " `option' " selected N: " as result `selected_n'
        if `regular_n' > 0 {
            display as text "Percent ordinary valid parents: " as result 100 * `selected_n' / `regular_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_12 _ara_q4_12

* ============================================================================
* DOMAIN IUOF: Activity and operational context
* No pooled domain score or model is estimated by this section.

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

* ITEM q4_15 | En los últimos 60 días (2 meses), ¿con qué frecuencia usó su cuenta o billetera principal para cualquier operación (recibir, pagar, retirar, consultar saldo)?
* Offered options [2512090157, 2512121811, 2512111044, 2512091719, 2602120658]:
* 1 = A diario
* 2 = Más de una vez por semana
* 3 = Una vez a la semana
* 4 = Una vez al mes
* 5 = No la usé en los últimos 90 días
confirm numeric variable q4_15, exact
gen byte _ar_q4_15 = 6
gen byte _ara_q4_15 = .
replace _ara_q4_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q4_15 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q4_15 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_15 == 0 & (missing(q4_15))
replace _ar_q4_15 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_15 == 1 & (missing(q4_15))
replace _ar_q4_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_15 == 1 & (q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
assert inrange(_ar_q4_15, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_15 == `state'
    display as text "q4_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q4_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_15, 1, 5)
    local recorded_n = r(N)
    display as text "q4_15 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q4_15, 1, 5) & q4_15 == `option'
        local category_n = r(N)
        display as text "q4_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_15 _ara_q4_15

* ITEM q4_16 | ¿Qué tan fácil le resulta depositar o retirar efectivo (cash-in / cash-out) cerca de su vivienda o trabajo?
* Offered options [2512090157, 2602120658, 2512091719, 2512121811, 2512111044]:
* 1 = Muy fácil
* 2 = Algo fácil
* 3 = Algo difícil
* 4 = Muy difícil
* 99 = No aplica
confirm numeric variable q4_16, exact
gen byte _ar_q4_16 = 6
gen byte _ara_q4_16 = .
replace _ara_q4_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q4_16 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q4_16 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_16 == 0 & (missing(q4_16))
replace _ar_q4_16 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_16 == 1 & (missing(q4_16))
replace _ar_q4_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_16 == 1 & (q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
replace _ar_q4_16 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_16 == 1 & (q4_16 == 99)
assert inrange(_ar_q4_16, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_16 == `state'
    display as text "q4_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 99"
    quietly count if formdef_version == `fv' & _ara_q4_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_16, 1, 5)
    local recorded_n = r(N)
    display as text "q4_16 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q4_16, 1, 5) & q4_16 == `option'
        local category_n = r(N)
        display as text "q4_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_16 _ara_q4_16

* ITEM q4_17 | ¿Aproximadamente cuánto tiempo tarda en llegar al punto de agente, cajero o sucursal más cercano donde puede hacer cash-in/cash-out?
* Offered options [2512090157, 2512091719, 2512121811, 2512111044, 2602120658]:
* 1 = Menos de 10 minutos
* 2 = Entre 10 y 30 minutos
* 3 = Entre 30 y 60 minutos
* 4 = Más de una hora
* 99 = No aplica
confirm numeric variable q4_17, exact
gen byte _ar_q4_17 = 6
gen byte _ara_q4_17 = .
replace _ara_q4_17 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q4_17 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q4_17 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_17 == 0 & (missing(q4_17))
replace _ar_q4_17 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_17 == 1 & (missing(q4_17))
replace _ar_q4_17 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_17 == 1 & (q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
replace _ar_q4_17 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_17 == 1 & (q4_17 == 99)
assert inrange(_ar_q4_17, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_17 == `state'
    display as text "q4_17 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 99"
    quietly count if formdef_version == `fv' & _ara_q4_17 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_17 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_17 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_17, 1, 5)
    local recorded_n = r(N)
    display as text "q4_17 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q4_17, 1, 5) & q4_17 == `option'
        local category_n = r(N)
        display as text "q4_17 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_17 _ara_q4_17

* ITEM q4_24 | ¿Usa su cuenta o billetera principal para pagar en comercios (por ejemplo, QR, transferencia, datafono sin tarjeta física)?
* Offered options [2512090157, 2512111044, 2602120658, 2512121811, 2512091719]:
* 1 = Sí, frecuentemente
* 2 = Sí, ocasionalmente
* 3 = No
* 99 = No aplica
confirm numeric variable q4_24, exact
gen byte _ar_q4_24 = 6
gen byte _ara_q4_24 = .
replace _ara_q4_24 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q4_24 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q4_24 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_24 == 0 & (missing(q4_24))
replace _ar_q4_24 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_24 == 1 & (missing(q4_24))
replace _ar_q4_24 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_24 == 1 & (q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
replace _ar_q4_24 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_24 == 1 & (q4_24 == 99)
assert inrange(_ar_q4_24, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_24 == `state'
    display as text "q4_24 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & _ara_q4_24 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_24 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_24 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_24, 1, 5)
    local recorded_n = r(N)
    display as text "q4_24 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q4_24, 1, 5) & q4_24 == `option'
        local category_n = r(N)
        display as text "q4_24 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_24 _ara_q4_24

* ITEM q4_25 | ¿Mantiene ahorros en su cuenta o billetera principal (es decir, deja dinero guardado por más de una semana)?
* Offered options [2512111044, 2512090157, 2512121811, 2602120658, 2512091719]:
* 1 = Sí, regularmente
* 2 = A veces
* 3 = No
* 99 = No aplica
confirm numeric variable q4_25, exact
gen byte _ar_q4_25 = 6
gen byte _ara_q4_25 = .
replace _ara_q4_25 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q4_25 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q4_25 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_25 == 0 & (missing(q4_25))
replace _ar_q4_25 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_25 == 1 & (missing(q4_25))
replace _ar_q4_25 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_25 == 1 & (q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
replace _ar_q4_25 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_25 == 1 & (q4_25 == 99)
assert inrange(_ar_q4_25, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_25 == `state'
    display as text "q4_25 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & _ara_q4_25 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_25 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_25 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_25, 1, 5)
    local recorded_n = r(N)
    display as text "q4_25 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q4_25, 1, 5) & q4_25 == `option'
        local category_n = r(N)
        display as text "q4_25 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_25 _ara_q4_25

* ITEM q4_26 | ¿Recibe notificaciones (SMS o app) cuando llega una transferencia o remesa a su cuenta o billetera principal?
* Offered options [2512111044, 2512091719, 2512121811, 2512090157, 2602120658]:
* 1 = Sí, siempre
* 2 = A veces
* 3 = Nunca
* 99 = No aplica
confirm numeric variable q4_26, exact
gen byte _ar_q4_26 = 6
gen byte _ara_q4_26 = .
replace _ara_q4_26 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q4_26 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q4_26 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_26 == 0 & (missing(q4_26))
replace _ar_q4_26 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_26 == 1 & (missing(q4_26))
replace _ar_q4_26 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_26 == 1 & (q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
replace _ar_q4_26 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_26 == 1 & (q4_26 == 99)
assert inrange(_ar_q4_26, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_26 == `state'
    display as text "q4_26 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & _ara_q4_26 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_26 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_26 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_26, 1, 5)
    local recorded_n = r(N)
    display as text "q4_26 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q4_26, 1, 5) & q4_26 == `option'
        local category_n = r(N)
        display as text "q4_26 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_26 _ara_q4_26

* ITEM q4_27 | En los últimos 60 días (2 meses), ¿prestó su cuenta o billetera a otra persona para que recibiera o moviera dinero?
* Offered options [2512111044, 2512090157, 2512121811, 2512091719, 2602120658]:
* 0 = No
* 1 = Sí
* 98 = Prefiero no responder
confirm numeric variable q4_27, exact
gen byte _ar_q4_27 = 6
gen byte _ara_q4_27 = .
replace _ara_q4_27 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q4_27 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q4_27 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_27 == 0 & (missing(q4_27))
replace _ar_q4_27 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_27 == 1 & (missing(q4_27))
replace _ar_q4_27 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q4_27 == 1 & (q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
replace _ar_q4_27 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q4_27 == 1 & (q4_27 == 98)
assert inrange(_ar_q4_27, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q4_27 == `state'
    display as text "q4_27 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & _ara_q4_27 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_27 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q4_27 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q4_27, 1, 5)
    local recorded_n = r(N)
    display as text "q4_27 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q4_27, 1, 5) & q4_27 == `option'
        local category_n = r(N)
        display as text "q4_27 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q4_27 _ara_q4_27

* ============================================================================
* DOMAIN OQI: Registration and initial support
* No pooled domain score or model is estimated by this section.

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

* ITEM q5_14 | En general, ¿qué tan fácil o difícil fue completar el registro hasta poder usar la cuenta o billetera principal?
* Offered options [2512090157, 2602120658, 2512111044, 2512091719, 2512121811]:
* 1 = Muy fácil
* 2 = Algo fácil
* 3 = Algo difícil 
* 4 = Muy difícil
* 98 = No sabe / No recuerda
confirm numeric variable q5_14, exact
gen byte _ar_q5_14 = 6
gen byte _ara_q5_14 = .
replace _ara_q5_14 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q5_14 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q5_14 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_14 == 0 & (missing(q5_14))
replace _ar_q5_14 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_14 == 1 & (missing(q5_14))
replace _ar_q5_14 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_14 == 1 & (q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
replace _ar_q5_14 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q5_14 == 1 & (q5_14 == 98)
assert inrange(_ar_q5_14, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q5_14 == `state'
    display as text "q5_14 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q5_14 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_14 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_14 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q5_14, 1, 5)
    local recorded_n = r(N)
    display as text "q5_14 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q5_14, 1, 5) & q5_14 == `option'
        local category_n = r(N)
        display as text "q5_14 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q5_14 _ara_q5_14

* ITEM q5_15 | ¿Cuánto tiempo tardó su registro hasta que la cuenta o billetera quedó activada para recibir o enviar dinero?
* Offered options [2512111044, 2512121811, 2512091719, 2512090157, 2602120658]:
* 1 = Minutos
* 2 = Horas
* 3 = Mismo día
* 4 = 1-3 días
* 5 = Más de 3 días
* 98 = No sabe / No recuerda
confirm numeric variable q5_15, exact
gen byte _ar_q5_15 = 6
gen byte _ara_q5_15 = .
replace _ara_q5_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q5_15 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q5_15 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_15 == 0 & (missing(q5_15))
replace _ar_q5_15 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_15 == 1 & (missing(q5_15))
replace _ar_q5_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_15 == 1 & (q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
replace _ar_q5_15 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q5_15 == 1 & (q5_15 == 98)
assert inrange(_ar_q5_15, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q5_15 == `state'
    display as text "q5_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & _ara_q5_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q5_15, 1, 5)
    local recorded_n = r(N)
    display as text "q5_15 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q5_15, 1, 5) & q5_15 == `option'
        local category_n = r(N)
        display as text "q5_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q5_15 _ara_q5_15

* ITEM q5_16 | ¿Necesitó ayuda para registrarse en esa cuenta o billetera principal?
* Offered options [2602120658, 2512111044, 2512121811, 2512090157, 2512091719]:
* 0 = No
* 1 = Sí
* 98 = Prefiero no responder
confirm numeric variable q5_16, exact
gen byte _ar_q5_16 = 6
gen byte _ara_q5_16 = .
replace _ara_q5_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q5_16 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q5_16 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_16 == 0 & (missing(q5_16))
replace _ar_q5_16 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_16 == 1 & (missing(q5_16))
replace _ar_q5_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_16 == 1 & (q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
replace _ar_q5_16 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q5_16 == 1 & (q5_16 == 98)
assert inrange(_ar_q5_16, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q5_16 == `state'
    display as text "q5_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & _ara_q5_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q5_16, 1, 5)
    local recorded_n = r(N)
    display as text "q5_16 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q5_16, 1, 5) & q5_16 == `option'
        local category_n = r(N)
        display as text "q5_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q5_16 _ara_q5_16

* ITEM q5_21 | ¿Recuerda haber aceptado términos y condiciones y autorización de manejo de datos personales durante el registro?
* Offered options [2602120658, 2512121811, 2512091719, 2512090157, 2512111044]:
* 1 = Sí, leí y entendí
* 2 = Sí, pero no los leí o no entendi bien
* 3 = No
* 98 = No sabe / No recuerda
confirm numeric variable q5_21, exact
gen byte _ar_q5_21 = 6
gen byte _ara_q5_21 = .
replace _ara_q5_21 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q5_21 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q5_21 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_21 == 0 & (missing(q5_21))
replace _ar_q5_21 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_21 == 1 & (missing(q5_21))
replace _ar_q5_21 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_21 == 1 & (q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
replace _ar_q5_21 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q5_21 == 1 & (q5_21 == 98)
assert inrange(_ar_q5_21, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q5_21 == `state'
    display as text "q5_21 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & _ara_q5_21 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_21 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_21 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q5_21, 1, 5)
    local recorded_n = r(N)
    display as text "q5_21 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q5_21, 1, 5) & q5_21 == `option'
        local category_n = r(N)
        display as text "q5_21 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q5_21 _ara_q5_21

* ITEM q5_22 | En su opinión, ¿el registro protegió adecuadamente su privacidad (solo pidió lo necesario y explicó el uso de sus datos)?
* Offered options [2602120658, 2512121811, 2512090157, 2512111044, 2512091719]:
* 1 = Muy bien protegido
* 2 = Adecuado
* 3 = Insuficiente
* 98 = No sabe / No recuerda
confirm numeric variable q5_22, exact
gen byte _ar_q5_22 = 6
gen byte _ara_q5_22 = .
replace _ara_q5_22 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q5_22 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q5_22 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_22 == 0 & (missing(q5_22))
replace _ar_q5_22 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_22 == 1 & (missing(q5_22))
replace _ar_q5_22 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_22 == 1 & (q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
replace _ar_q5_22 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q5_22 == 1 & (q5_22 == 98)
assert inrange(_ar_q5_22, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q5_22 == `state'
    display as text "q5_22 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & _ara_q5_22 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_22 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_22 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q5_22, 1, 5)
    local recorded_n = r(N)
    display as text "q5_22 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q5_22, 1, 5) & q5_22 == `option'
        local category_n = r(N)
        display as text "q5_22 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q5_22 _ara_q5_22

* ITEM q5_23 | En el registro o en el primer uso, ¿el sistema o app ofreció mensajes en español claro y algún tipo de asistencia (tutorial, ayuda paso a paso, chat)?
* Offered options [2512111044, 2512091719, 2512090157, 2512121811, 2602120658]:
* 1 = Sí, suficiente
* 2 = Sí, pero insuficiente
* 3 = No
* 98 = No sabe / No recuerda
confirm numeric variable q5_23, exact
gen byte _ar_q5_23 = 6
gen byte _ara_q5_23 = .
replace _ara_q5_23 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ara_q5_23 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
replace _ar_q5_23 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_23 == 0 & (missing(q5_23))
replace _ar_q5_23 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_23 == 1 & (missing(q5_23))
replace _ar_q5_23 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q5_23 == 1 & (q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
replace _ar_q5_23 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q5_23 == 1 & (q5_23 == 98)
assert inrange(_ar_q5_23, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q5_23 == `state'
    display as text "q5_23 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & _ara_q5_23 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_23 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q5_23 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q5_23, 1, 5)
    local recorded_n = r(N)
    display as text "q5_23 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q5_23, 1, 5) & q5_23 == `option'
        local category_n = r(N)
        display as text "q5_23 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q5_23 _ara_q5_23

* ============================================================================
* DOMAIN IURD: Remittance disposition and domestic participation
* No pooled domain score or model is estimated by this section.

* ITEM q6_2 | Pensando solo en los últimos 12 meses, ¿con qué frecuencia recibió remesas del exterior?
* Offered options [2512091719, 2512121811, 2602120658, 2512111044, 2512090157]:
* 1 = Mensualmente o más frecuente
* 2 = Cada 2 a 3 meses
* 3 = 1 a 2 veces en el año 
* 99 = No aplica / No recuerda
confirm numeric variable q6_2, exact
gen byte _ar_q6_2 = 6
gen byte _ara_q6_2 = .
replace _ara_q6_2 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q6_2 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q6_2 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_2 == 0 & (missing(q6_2))
replace _ar_q6_2 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_2 == 1 & (missing(q6_2))
replace _ar_q6_2 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_2 == 1 & (q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
replace _ar_q6_2 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_2 == 1 & (q6_2 == 99)
assert inrange(_ar_q6_2, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_2 == `state'
    display as text "q6_2 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & _ara_q6_2 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_2 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_2 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_2, 1, 5)
    local recorded_n = r(N)
    display as text "q6_2 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_2, 1, 5) & q6_2 == `option'
        local category_n = r(N)
        display as text "q6_2 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_2 _ara_q6_2

* ITEM q6_4 | ¿A través de qué canal recibió esa remesa más reciente?
* Offered options [2512111044, 2512091719, 2512090157, 2602120658, 2512121811]:
* 1 = Transferencia a cuenta bancaria
* 2 = Billetera / app (Nequi, Daviplata)
* 3 = Cobro en efectivo en corresponsal / ventanilla
* 4 = Entrega en mano por viajero
* 5 = Otro medio (especifique)
confirm numeric variable q6_4, exact
gen byte _ar_q6_4 = 6
gen byte _ara_q6_4 = .
replace _ara_q6_4 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q6_4 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q6_4 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_4 == 0 & (missing(q6_4))
replace _ar_q6_4 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_4 == 1 & (missing(q6_4))
replace _ar_q6_4 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_4 == 1 & (q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
assert inrange(_ar_q6_4, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_4 == `state'
    display as text "q6_4 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q6_4 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_4 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_4 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_4, 1, 5)
    local recorded_n = r(N)
    display as text "q6_4 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_4, 1, 5) & q6_4 == `option'
        local category_n = r(N)
        display as text "q6_4 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_4 _ara_q6_4

* ITEM q6_13 | En general, pensando en todas las remesas que recibe, ¿qué proporción termina en efectivo y qué proporción se mantiene o usa de forma digital?
* Keep all five dispositions; not a monetary share or the latest receipt channel.
* Offered options [2512091719, 2512090157, 2602120658, 2512111044, 2512121811]:
* 1 = Todo lo retiro en efectivo
* 2 = Retiro menos de la mitad en efectivo
* 3 = Dejo la mitad en efectivo y la mitad de manera digital
* 4 = Dejo más de la mitad digital
* 5 = Mantengo el 100% del dinero de manera digital
confirm numeric variable q6_13, exact
gen byte _ar_q6_13 = 6
gen byte _ara_q6_13 = .
replace _ara_q6_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q6_13 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q6_13 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_13 == 0 & (missing(q6_13))
replace _ar_q6_13 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_13 == 1 & (missing(q6_13))
replace _ar_q6_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_13 == 1 & (q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
assert inrange(_ar_q6_13, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_13 == `state'
    display as text "q6_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q6_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_13, 1, 5)
    local recorded_n = r(N)
    display as text "q6_13 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_13, 1, 5) & q6_13 == `option'
        local category_n = r(N)
        display as text "q6_13 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_13 _ara_q6_13

* ITEM q6_14 | En los últimos 60 días (2 meses), ¿realizó o recibió pagos digitales o remesas dentro de Colombia usando apps, transferencias, billeteras o códigos QR?
* Offered options [2512111044, 2512091719, 2512121811, 2602120658, 2512090157]:
* 0 = No
* 1 = Sí
* 98 = Prefiero no responder
confirm numeric variable q6_14, exact
gen byte _ar_q6_14 = 6
gen byte _ara_q6_14 = .
replace _ara_q6_14 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q6_14 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q6_14 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_14 == 0 & (missing(q6_14))
replace _ar_q6_14 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_14 == 1 & (missing(q6_14))
replace _ar_q6_14 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_14 == 1 & (q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
replace _ar_q6_14 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_14 == 1 & (q6_14 == 98)
assert inrange(_ar_q6_14, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_14 == `state'
    display as text "q6_14 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & _ara_q6_14 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_14 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_14 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_14, 1, 5)
    local recorded_n = r(N)
    display as text "q6_14 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_14, 1, 5) & q6_14 == `option'
        local category_n = r(N)
        display as text "q6_14 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_14 _ara_q6_14

* ITEM q6_15 | En esos últimos 60 días (2 meses), aproximadamente ¿cuántas operaciones digitales (enviar o recibir dinero) realizó en total?
* Operation bins only under affirmative domestic participation; uncertainty is separate, not the lowest bin.
* Offered options [2602120658, 2512090157, 2512111044, 2512091719, 2512121811]:
* 1 = Menos de 5
* 2 = Entre 5 y 10
* 3 = Entre 10 y 20
* 4 = Entre 20 y 50
* 5 = Más de 50
* 98 = No sabe / No recuerda
confirm numeric variable q6_15, exact
gen byte _ar_q6_15 = 6
gen byte _ara_q6_15 = .
replace _ara_q6_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace _ara_q6_15 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace _ar_q6_15 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_15 == 0 & (missing(q6_15))
replace _ar_q6_15 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_15 == 1 & (missing(q6_15))
replace _ar_q6_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_15 == 1 & (q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
replace _ar_q6_15 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_15 == 1 & (q6_15 == 98)
assert inrange(_ar_q6_15, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_15 == `state'
    display as text "q6_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & _ara_q6_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_15, 1, 5)
    local recorded_n = r(N)
    display as text "q6_15 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_15, 1, 5) & q6_15 == `option'
        local category_n = r(N)
        display as text "q6_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_15 _ara_q6_15

* ============================================================================
* DOMAIN IETR: Distinct transaction experiences
* No pooled domain score or model is estimated by this section.

* ITEM q6_6 | ¿Cuánto tiempo pasó desde que la persona que envió la remesa hizo el envío hasta que usted pudo usar el dinero?
* Offered options [2512121811, 2602120658, 2512090157, 2512091719, 2512111044]:
* 1 = Minutos
* 2 = Horas
* 3 = Mismo día
* 4 = 1 a 3 días
* 5 = Más de 3 días
* 98 = No sabe / No recuerda
confirm numeric variable q6_6, exact
gen byte _ar_q6_6 = 6
gen byte _ara_q6_6 = .
replace _ara_q6_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q6_6 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q6_6 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_6 == 0 & (missing(q6_6))
replace _ar_q6_6 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_6 == 1 & (missing(q6_6))
replace _ar_q6_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_6 == 1 & (q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
replace _ar_q6_6 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_6 == 1 & (q6_6 == 98)
assert inrange(_ar_q6_6, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_6 == `state'
    display as text "q6_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & _ara_q6_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_6, 1, 5)
    local recorded_n = r(N)
    display as text "q6_6 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_6, 1, 5) & q6_6 == `option'
        local category_n = r(N)
        display as text "q6_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_6 _ara_q6_6

* ITEM q6_9 | Pensando en esa remesa más reciente, ¿qué tan clara fue para usted la tasa de cambio aplicada (si hubo cambio de moneda)?
* Offered options [2512090157, 2512111044, 2602120658, 2512091719, 2512121811]:
* 1 = Muy clara
* 2 = Algo clara
* 3 = Poco clara
* 4 = Nada clara
* 99 = No aplica
confirm numeric variable q6_9, exact
gen byte _ar_q6_9 = 6
gen byte _ara_q6_9 = .
replace _ara_q6_9 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q6_9 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q6_9 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_9 == 0 & (missing(q6_9))
replace _ar_q6_9 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_9 == 1 & (missing(q6_9))
replace _ar_q6_9 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_9 == 1 & (q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
replace _ar_q6_9 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_9 == 1 & (q6_9 == 99)
assert inrange(_ar_q6_9, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_9 == `state'
    display as text "q6_9 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 99"
    quietly count if formdef_version == `fv' & _ara_q6_9 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_9 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_9 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_9, 1, 5)
    local recorded_n = r(N)
    display as text "q6_9 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_9, 1, 5) & q6_9 == `option'
        local category_n = r(N)
        display as text "q6_9 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_9 _ara_q6_9

* ITEM q6_11 | ¿Recibió alguna confirmación cuando llegó esa remesa (SMS, notificación de app, correo electrónico o recibo en papel)?
* Offered options [2512111044, 2512090157, 2512091719, 2602120658, 2512121811]:
* 1 = SMS
* 2 = Notificación en app
* 3 = Recibo en papel
* 4 = Correo electrónico
* 5 = No recibí confirmación
* 98 = No sabe / No recuerda
confirm numeric variable q6_11, exact
gen byte _ar_q6_11 = 6
gen byte _ara_q6_11 = .
replace _ara_q6_11 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q6_11 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q6_11 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_11 == 0 & (missing(q6_11))
replace _ar_q6_11 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_11 == 1 & (missing(q6_11))
replace _ar_q6_11 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_11 == 1 & (q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
replace _ar_q6_11 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_11 == 1 & (q6_11 == 98)
assert inrange(_ar_q6_11, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_11 == `state'
    display as text "q6_11 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & _ara_q6_11 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_11 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_11 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_11, 1, 5)
    local recorded_n = r(N)
    display as text "q6_11 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_11, 1, 5) & q6_11 == `option'
        local category_n = r(N)
        display as text "q6_11 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_11 _ara_q6_11

* ITEM q6_16 | En esos últimos 60 días (2 meses), ¿tuvo algún problema con pagos o transferencias digitales (por ejemplo, dinero que no llegó, reversos, operaciones rechazadas o duplicadas)?
* Offered options [2512090157, 2512091719, 2512111044, 2512121811, 2602120658]:
* 1 = Sí, y se resolvió rápido (mismo día)
* 2 = Sí, tardó en resolvrse (más de un día)
* 3 = Sí, y no se resolvió
* 4 = No
* 98 = No sabe / No recuerda
confirm numeric variable q6_16, exact
gen byte _ar_q6_16 = 6
gen byte _ara_q6_16 = .
replace _ara_q6_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace _ara_q6_16 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace _ar_q6_16 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_16 == 0 & (missing(q6_16))
replace _ar_q6_16 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_16 == 1 & (missing(q6_16))
replace _ar_q6_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_16 == 1 & (q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
replace _ar_q6_16 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_16 == 1 & (q6_16 == 98)
assert inrange(_ar_q6_16, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_16 == `state'
    display as text "q6_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q6_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_16, 1, 5)
    local recorded_n = r(N)
    display as text "q6_16 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_16, 1, 5) & q6_16 == `option'
        local category_n = r(N)
        display as text "q6_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_16 _ara_q6_16

* ITEM q6_17 | ¿Ha encontrado límites o topes que le impidan completar operaciones digitales (por monto por transacción, límite diario o mensual, o número de operaciones)?
* Offered options [2512111044, 2512121811, 2602120658, 2512091719, 2512090157]:
* 1 = Sí, por monto de transacción
* 2 = Sí, por límitie diario / mensual
* 3 = Sí, por número de transacciones
* 4 = No
* 98 = No sabe / No recuerda
confirm numeric variable q6_17, exact
gen byte _ar_q6_17 = 6
gen byte _ara_q6_17 = .
replace _ara_q6_17 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace _ara_q6_17 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace _ar_q6_17 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_17 == 0 & (missing(q6_17))
replace _ar_q6_17 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_17 == 1 & (missing(q6_17))
replace _ar_q6_17 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_17 == 1 & (q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
replace _ar_q6_17 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_17 == 1 & (q6_17 == 98)
assert inrange(_ar_q6_17, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_17 == `state'
    display as text "q6_17 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q6_17 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_17 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_17 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_17, 1, 5)
    local recorded_n = r(N)
    display as text "q6_17 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_17, 1, 5) & q6_17 == `option'
        local category_n = r(N)
        display as text "q6_17 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_17 _ara_q6_17

* ITEM q6_18 | En la última operación digital que hizo en esos 90 días, ¿las comisiones se mostraron claramente antes de que usted confirmara la operación?
* Offered options [2512121811, 2512090157, 2602120658, 2512091719, 2512111044]:
* 1 = Sí, claramente
* 2 = Sí, pero poco claro
* 3 = No se mostró
* 4 = No aplicaba comisión
* 98 = No sabe / No recuerda
confirm numeric variable q6_18, exact
gen byte _ar_q6_18 = 6
gen byte _ara_q6_18 = .
replace _ara_q6_18 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace _ara_q6_18 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace _ar_q6_18 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_18 == 0 & (missing(q6_18))
replace _ar_q6_18 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_18 == 1 & (missing(q6_18))
replace _ar_q6_18 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_18 == 1 & (q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
replace _ar_q6_18 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_18 == 1 & (q6_18 == 4)
replace _ar_q6_18 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_18 == 1 & (q6_18 == 98)
assert inrange(_ar_q6_18, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_18 == `state'
    display as text "q6_18 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q6_18 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_18 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_18 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_18, 1, 5)
    local recorded_n = r(N)
    display as text "q6_18 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_18, 1, 5) & q6_18 == `option'
        local category_n = r(N)
        display as text "q6_18 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_18 _ara_q6_18

* ITEM q6_20 | En esa última operación digital, ¿recibió una confirmación inmediata (por SMS o notificación en la app) al enviar o recibir el dinero?
* Offered options [2512090157, 2512111044, 2512121811, 2602120658, 2512091719]:
* 1 = Sí, inmediata
* 2 = Sí, pero tardía
* 3 = No recibí confirmación
* 98 = No sabe / No recuerda
confirm numeric variable q6_20, exact
gen byte _ar_q6_20 = 6
gen byte _ara_q6_20 = .
replace _ara_q6_20 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace _ara_q6_20 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace _ar_q6_20 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_20 == 0 & (missing(q6_20))
replace _ar_q6_20 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_20 == 1 & (missing(q6_20))
replace _ar_q6_20 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_20 == 1 & (q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
replace _ar_q6_20 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_20 == 1 & (q6_20 == 98)
assert inrange(_ar_q6_20, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_20 == `state'
    display as text "q6_20 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & _ara_q6_20 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_20 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_20 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_20, 1, 5)
    local recorded_n = r(N)
    display as text "q6_20 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_20, 1, 5) & q6_20 == `option'
        local category_n = r(N)
        display as text "q6_20 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_20 _ara_q6_20

* ITEM q6_21 | En general, ¿qué tan rápidos le resultan sus pagos o remesas digitales (desde que se envían hasta que usted puede usar el dinero)?
* Offered options [2512090157, 2512111044, 2512091719, 2512121811, 2602120658]:
* 1 = Al instante
* 2 = En horas
* 3 = En el día
* 4 = De 1 a 3 días
* 5 = Más de 3 días
* 6 = Variable / No predecible
confirm numeric variable q6_21, exact
gen byte _ar_q6_21 = 6
gen byte _ara_q6_21 = .
replace _ara_q6_21 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace _ara_q6_21 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace _ar_q6_21 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_21 == 0 & (missing(q6_21))
replace _ar_q6_21 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_21 == 1 & (missing(q6_21))
replace _ar_q6_21 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_21 == 1 & (q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
assert inrange(_ar_q6_21, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_21 == `state'
    display as text "q6_21 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6"
    quietly count if formdef_version == `fv' & _ara_q6_21 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_21 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_21 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_21, 1, 5)
    local recorded_n = r(N)
    display as text "q6_21 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_21, 1, 5) & q6_21 == `option'
        local category_n = r(N)
        display as text "q6_21 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_21 _ara_q6_21

* ITEM q6_22 | ¿Ha notado cargos adicionales al pagar con QR o transferencia en comercios, comparado con pagar en efectivo (por ejemplo, recargo o comisión extra)?
* Offered options [2512111044, 2512121811, 2602120658, 2512091719, 2512090157]:
* 1 = Sí, suelen cobrar extra
* 2 = Precio igual que en efectivo
* 3 = Descuento por pagar digital
* 98 = No sabe / No recuerda
* 99 = No aplica / No usa
confirm numeric variable q6_22, exact
gen byte _ar_q6_22 = 6
gen byte _ara_q6_22 = .
replace _ara_q6_22 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace _ara_q6_22 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace _ar_q6_22 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_22 == 0 & (missing(q6_22))
replace _ar_q6_22 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_22 == 1 & (missing(q6_22))
replace _ar_q6_22 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_22 == 1 & (q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
replace _ar_q6_22 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_22 == 1 & (q6_22 == 98)
replace _ar_q6_22 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q6_22 == 1 & (q6_22 == 99)
assert inrange(_ar_q6_22, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_22 == `state'
    display as text "q6_22 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98 99"
    quietly count if formdef_version == `fv' & _ara_q6_22 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_22 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_22 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_22, 1, 5)
    local recorded_n = r(N)
    display as text "q6_22 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_22, 1, 5) & q6_22 == `option'
        local category_n = r(N)
        display as text "q6_22 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_22 _ara_q6_22

* ITEM q6_23 | En general, ¿qué tan clara le resulta la información que dan los proveedores sobre límites, horarios, comisiones y tiempos de abono de las operaciones digitales?
* Offered options [2512111044, 2602120658, 2512091719, 2512121811, 2512090157]:
* 1 = Muy clara
* 2 = Algo clara
* 3 = Poco clara
* 4 = Nada clara
confirm numeric variable q6_23, exact
gen byte _ar_q6_23 = 6
gen byte _ara_q6_23 = .
replace _ara_q6_23 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace _ara_q6_23 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace _ar_q6_23 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_23 == 0 & (missing(q6_23))
replace _ar_q6_23 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_23 == 1 & (missing(q6_23))
replace _ar_q6_23 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_23 == 1 & (q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
assert inrange(_ar_q6_23, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_23 == `state'
    display as text "q6_23 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & _ara_q6_23 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_23 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_23 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_23, 1, 5)
    local recorded_n = r(N)
    display as text "q6_23 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_23, 1, 5) & q6_23 == `option'
        local category_n = r(N)
        display as text "q6_23 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_23 _ara_q6_23

* ITEM q6_24 | En los últimos 60 días (2 meses), ¿cómo evaluaría su experiencia transaccional digital en general?
* Offered options [2512090157, 2512091719, 2512121811, 2512111044, 2602120658]:
* 1 = Muy mala
* 2 = Mala
* 3 = Regular
* 4 = Buena
* 5 = Excelente
confirm numeric variable q6_24, exact
gen byte _ar_q6_24 = 6
gen byte _ara_q6_24 = .
replace _ara_q6_24 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
replace _ara_q6_24 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
replace _ar_q6_24 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_24 == 0 & (missing(q6_24))
replace _ar_q6_24 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_24 == 1 & (missing(q6_24))
replace _ar_q6_24 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q6_24 == 1 & (q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
assert inrange(_ar_q6_24, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q6_24 == `state'
    display as text "q6_24 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q6_24 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_24 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q6_24 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q6_24, 1, 5)
    local recorded_n = r(N)
    display as text "q6_24 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q6_24, 1, 5) & q6_24 == `option'
        local category_n = r(N)
        display as text "q6_24 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q6_24 _ara_q6_24

* ============================================================================
* DOMAIN IPCS: Exposure, practices, safety and preferences
* No pooled domain score or model is estimated by this section.

* ITEM q7_1 | En los últimos 12 meses, ¿recibió mensajes o llamadas sospechosas (SMS, WhatsApp, redes sociales o teléfono) pidiéndole códigos SMS/OTP, claves, PIN o que hiciera una transferencia urgente?
* Offered options [2512091719, 2512090157, 2512111044, 2602120658, 2512121811]:
* 1 = Sí, varias veces
* 2 = Sí, al menos una vez
* 3 = No personalmente
* 4 = Conozco a alguien que sí recibió
* 98 = No sabe / No recuerda
confirm numeric variable q7_1, exact
gen byte _ar_q7_1 = 6
gen byte _ara_q7_1 = .
replace _ara_q7_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q7_1 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q7_1 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_1 == 0 & (missing(q7_1))
replace _ar_q7_1 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_1 == 1 & (missing(q7_1))
replace _ar_q7_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_1 == 1 & (q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
replace _ar_q7_1 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q7_1 == 1 & (q7_1 == 98)
assert inrange(_ar_q7_1, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_1 == `state'
    display as text "q7_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q7_1 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_1 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_1 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_1, 1, 5)
    local recorded_n = r(N)
    display as text "q7_1 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_1, 1, 5) & q7_1 == `option'
        local category_n = r(N)
        display as text "q7_1 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_1 _ara_q7_1

* ITEM q7_2 | Pensando en el último mensaje o llamada sospechosa que recibió, ¿qué hizo usted primero?
* Offered options [2512091719, 2602120658, 2512111044, 2512090157, 2512121811]:
* 1 = Lo ignoré/eliminé
* 2 = bloquee el número / cuenta
* 3 = Llamé al banco o proveedor
* 4 = Hice click / compartí datos por error
* 5 = Realicé otra acción (especifique)
confirm numeric variable q7_2, exact
gen byte _ar_q7_2 = 6
gen byte _ara_q7_2 = .
replace _ara_q7_2 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 1)) | ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 2))))
replace _ara_q7_2 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 1)) & ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 2))))
replace _ar_q7_2 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_2 == 0 & (missing(q7_2))
replace _ar_q7_2 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_2 == 1 & (missing(q7_2))
replace _ar_q7_2 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_2 == 1 & (q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
assert inrange(_ar_q7_2, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_2 == `state'
    display as text "q7_2 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q7_2 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_2 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_2 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_2, 1, 5)
    local recorded_n = r(N)
    display as text "q7_2 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_2, 1, 5) & q7_2 == `option'
        local category_n = r(N)
        display as text "q7_2 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_2 _ara_q7_2

* ITEM q7_6 | Actualmente, ¿usa algún método de autenticación segura en su teléfono o app (por ejemplo, huella, reconocimiento facial, PIN, patrón o bloqueo de pantalla)?
* Offered options [2512090157, 2602120658, 2512111044, 2512091719, 2512121811]:
* 1 = Sí, siempre
* 2 = Sí, a veces
* 3 = No, nunca
* 98 = No sabe / No recuerda
confirm numeric variable q7_6, exact
gen byte _ar_q7_6 = 6
gen byte _ara_q7_6 = .
replace _ara_q7_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q7_6 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q7_6 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_6 == 0 & (missing(q7_6))
replace _ar_q7_6 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_6 == 1 & (missing(q7_6))
replace _ar_q7_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_6 == 1 & (q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
replace _ar_q7_6 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q7_6 == 1 & (q7_6 == 98)
assert inrange(_ar_q7_6, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_6 == `state'
    display as text "q7_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & _ara_q7_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_6, 1, 5)
    local recorded_n = r(N)
    display as text "q7_6 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_6, 1, 5) & q7_6 == `option'
        local category_n = r(N)
        display as text "q7_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_6 _ara_q7_6

* ITEM q7_7 | ¿Con qué frecuencia cambia sus claves o PIN y revisa sus movimientos para detectar operaciones no reconocidas?
* Offered options [2512090157, 2512111044, 2512091719, 2602120658, 2512121811]:
* 1 = Todos los meses o más frecuente
* 2 = Cada 2 a 3 meses
* 3 = Rara vez (menos de una vez al año)
* 4 = Nunca las suelo cambiar
confirm numeric variable q7_7, exact
gen byte _ar_q7_7 = 6
gen byte _ara_q7_7 = .
replace _ara_q7_7 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q7_7 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q7_7 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_7 == 0 & (missing(q7_7))
replace _ar_q7_7 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_7 == 1 & (missing(q7_7))
replace _ar_q7_7 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_7 == 1 & (q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
assert inrange(_ar_q7_7, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_7 == `state'
    display as text "q7_7 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & _ara_q7_7 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_7 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_7 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_7, 1, 5)
    local recorded_n = r(N)
    display as text "q7_7 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_7, 1, 5) & q7_7 == `option'
        local category_n = r(N)
        display as text "q7_7 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_7 _ara_q7_7

* ITEM q7_8 | ¿Recibió en los últimos 12 meses mensajes de educación o alertas de su banco/app sobre estafas comunes (por ejemplo, “no comparta OTP”, “no haga clic en enlaces desconocidos”)?
* Offered options [2512091719, 2512121811, 2512090157, 2602120658, 2512111044]:
* 1 = Sí, claros y útiles
* 2 = Sí, pero poco claros
* 3 = No recibí
* 98 = No sabe / No recuerda
confirm numeric variable q7_8, exact
gen byte _ar_q7_8 = 6
gen byte _ara_q7_8 = .
replace _ara_q7_8 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q7_8 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q7_8 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_8 == 0 & (missing(q7_8))
replace _ar_q7_8 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_8 == 1 & (missing(q7_8))
replace _ar_q7_8 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_8 == 1 & (q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
replace _ar_q7_8 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q7_8 == 1 & (q7_8 == 98)
assert inrange(_ar_q7_8, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_8 == `state'
    display as text "q7_8 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & _ara_q7_8 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_8 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_8 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_8, 1, 5)
    local recorded_n = r(N)
    display as text "q7_8 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_8, 1, 5) & q7_8 == `option'
        local category_n = r(N)
        display as text "q7_8 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_8 _ara_q7_8

* ITEM q7_9 | En general, ¿qué tan segura se siente al recibir remesas o pagos por canales digitales (app, QR, transferencia)?
* Offered options [2512111044, 2512121811, 2602120658, 2512091719, 2512090157]:
* 1 = Muy segura
* 2 = Algo segura
* 3 = Poco segura
* 4 = Nada segura
confirm numeric variable q7_9, exact
gen byte _ar_q7_9 = 6
gen byte _ara_q7_9 = .
replace _ara_q7_9 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q7_9 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q7_9 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_9 == 0 & (missing(q7_9))
replace _ar_q7_9 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_9 == 1 & (missing(q7_9))
replace _ar_q7_9 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_9 == 1 & (q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
assert inrange(_ar_q7_9, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_9 == `state'
    display as text "q7_9 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & _ara_q7_9 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_9 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_9 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_9, 1, 5)
    local recorded_n = r(N)
    display as text "q7_9 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_9, 1, 5) & q7_9 == `option'
        local category_n = r(N)
        display as text "q7_9 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_9 _ara_q7_9

* ITEM q7_10 | ¿Qué medida de seguridad considera más útil para evitar fraudes en su caso?
* Offered options [2512091719, 2512121811, 2512111044, 2602120658]:
* 1 = Autenticación biométrica (huella / rostro)
* 2 = OTP pro SMS / confirmación en la app
* 3 = Bloqueo automático del teléfono
* 4 = Alertas de movimientos por SMS / WhatsApp
* 5 = Educación / alertas antifraude
* 6 = Atención al cliente rápida
* Offered options [2512090157]:
* 1 = Autenticación biométrica (huella / rostro)
* 2 = OTP pro SMS / confirmación en la app
* 3 = Bloqueo automático del teléfono
* 4 = Alertas de movimientos por SMS / WhatsApp
* 5 = Educación / alertas antifraude
* 6 = Atención al cliente rápida
* 7 = Otra (especifique)
confirm numeric variable q7_10, exact
gen byte _ar_q7_10 = 6
gen byte _ara_q7_10 = .
replace _ara_q7_10 = 1 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q7_10 = 0 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q7_10 = 2 if inlist(formdef_version, 2512090157) & _ara_q7_10 == 0 & (missing(q7_10))
replace _ar_q7_10 = 4 if inlist(formdef_version, 2512090157) & _ara_q7_10 == 1 & (missing(q7_10))
replace _ar_q7_10 = 1 if inlist(formdef_version, 2512090157) & _ara_q7_10 == 1 & (q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6 | q7_10 == 7)
replace _ara_q7_10 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q7_10 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q7_10 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_10 == 0 & (missing(q7_10))
replace _ar_q7_10 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_10 == 1 & (missing(q7_10))
replace _ar_q7_10 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_10 == 1 & (q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6)
assert inrange(_ar_q7_10, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_10 == `state'
    display as text "q7_10 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6"
    if `fv' == 2512090157 {
        local options "1 2 3 4 5 6 7"
    }
    quietly count if formdef_version == `fv' & _ara_q7_10 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_10 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_10 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_10, 1, 5)
    local recorded_n = r(N)
    display as text "q7_10 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_10, 1, 5) & q7_10 == `option'
        local category_n = r(N)
        display as text "q7_10 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_10 _ara_q7_10

* ============================================================================
* DOMAIN IEDF: Adverse experiences and conditional redress
* No pooled domain score or model is estimated by this section.
* Shared q7_1 exposure is reported once under IPCS; it is not independent evidence.

* ITEM q7_5 | En los últimos 12 meses, ¿su cuenta, tarjeta o app fue bloqueada o limitada por intentos fallidos, contraseñas erradas o sospecha de fraude?
* Offered options [2512090157, 2512091719, 2602120658, 2512111044, 2512121811]:
* 1 = Sí, y se resolvió rápido (mismo día)
* 2 = Sí, y tardó más de un día en resolverse
* 3 = Sí, y no se resolvió
* 4 = No
* 98 = No sabe / No recuerda
confirm numeric variable q7_5, exact
gen byte _ar_q7_5 = 6
gen byte _ara_q7_5 = .
replace _ara_q7_5 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q7_5 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q7_5 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_5 == 0 & (missing(q7_5))
replace _ar_q7_5 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_5 == 1 & (missing(q7_5))
replace _ar_q7_5 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_5 == 1 & (q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
replace _ar_q7_5 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q7_5 == 1 & (q7_5 == 98)
assert inrange(_ar_q7_5, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_5 == `state'
    display as text "q7_5 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q7_5 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_5 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_5 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_5, 1, 5)
    local recorded_n = r(N)
    display as text "q7_5 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_5, 1, 5) & q7_5 == `option'
        local category_n = r(N)
        display as text "q7_5 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_5 _ara_q7_5

* ITEM q7_11 | En los últimos 12 meses, ¿tuvo algún problema con un pago o remesa digital (por ejemplo, dinero que no llegó, llegó incompleto o tarde, cobro indebido, error de destinatario)?
* Offered options [2512121811, 2512090157, 2602120658, 2512091719, 2512111044]:
* 1 = Sí, al menos un problema
* 2 = No tuve problemas
* 98 = No sabe / No recuerda
confirm numeric variable q7_11, exact
gen byte _ar_q7_11 = 6
gen byte _ara_q7_11 = .
replace _ara_q7_11 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q7_11 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q7_11 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_11 == 0 & (missing(q7_11))
replace _ar_q7_11 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_11 == 1 & (missing(q7_11))
replace _ar_q7_11 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_11 == 1 & (q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
replace _ar_q7_11 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q7_11 == 1 & (q7_11 == 98)
assert inrange(_ar_q7_11, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_11 == `state'
    display as text "q7_11 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 98"
    quietly count if formdef_version == `fv' & _ara_q7_11 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_11 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_11 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_11, 1, 5)
    local recorded_n = r(N)
    display as text "q7_11 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_11, 1, 5) & q7_11 == `option'
        local category_n = r(N)
        display as text "q7_11 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_11 _ara_q7_11

* ITEM q7_12 | Pensando en el problema más reciente, ¿a quién presentó el reclamo primero?
* Offered options [2512091719, 2602120658, 2512121811, 2512111044]:
* 1 = App / Chat del proveedor
* 2 = Lllamada al proveedor
* 3 = Agente / sucursal
* 4 = Regulador
* 5 = Defensoría / Consumo
* 6 = No reclamé
* Offered options [2512090157]:
* 1 = App / Chat del proveedor
* 2 = Lllamada al proveedor
* 3 = Agente / sucursal
* 4 = Regulador
* 5 = Defensoría / Consumo
* 6 = No reclamé
* 7 = Otro (especifique)
confirm numeric variable q7_12, exact
gen byte _ar_q7_12 = 6
gen byte _ara_q7_12 = .
replace _ara_q7_12 = 1 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)))
replace _ara_q7_12 = 0 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)))
replace _ar_q7_12 = 2 if inlist(formdef_version, 2512090157) & _ara_q7_12 == 0 & (missing(q7_12))
replace _ar_q7_12 = 4 if inlist(formdef_version, 2512090157) & _ara_q7_12 == 1 & (missing(q7_12))
replace _ar_q7_12 = 1 if inlist(formdef_version, 2512090157) & _ara_q7_12 == 1 & (q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7)
replace _ara_q7_12 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)))
replace _ara_q7_12 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)))
replace _ar_q7_12 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_12 == 0 & (missing(q7_12))
replace _ar_q7_12 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_12 == 1 & (missing(q7_12))
replace _ar_q7_12 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_12 == 1 & (q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6)
assert inrange(_ar_q7_12, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_12 == `state'
    display as text "q7_12 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6"
    if `fv' == 2512090157 {
        local options "1 2 3 4 5 6 7"
    }
    quietly count if formdef_version == `fv' & _ara_q7_12 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_12 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_12 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_12, 1, 5)
    local recorded_n = r(N)
    display as text "q7_12 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_12, 1, 5) & q7_12 == `option'
        local category_n = r(N)
        display as text "q7_12 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_12 _ara_q7_12

* ITEM q7_13 | ¿Cuánto tiempo tardó en recibir una primera respuesta de ese canal de reclamo?
* Offered options [2512111044, 2512091719, 2602120658, 2512090157, 2512121811]:
* 1 = El mismo día
* 2 = 1 a 3 días
* 3 = 4 a 7 días
* 4 = Más de 7 días
* 5 = No recibió respuesta
confirm numeric variable q7_13, exact
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
assert inrange(_ar_q7_13, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_13 == `state'
    display as text "q7_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q7_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_13, 1, 5)
    local recorded_n = r(N)
    display as text "q7_13 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_13, 1, 5) & q7_13 == `option'
        local category_n = r(N)
        display as text "q7_13 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_13 _ara_q7_13

* ITEM q7_14 | ¿El problema quedó resuelto y el dinero fue restituido o corregido?
* Pending remains a recorded category; do not require an earlier reply or convert statuses to money fractions.
* Offered options [2512111044, 2512091719, 2512090157, 2512121811, 2602120658]:
* 1 = Sí, completamente resuelto
* 2 = Parcialmente resuelto
* 3 = No resuelto
* 4 = En trámite
confirm numeric variable q7_14, exact
gen byte _ar_q7_14 = 6
gen byte _ara_q7_14 = .
replace _ara_q7_14 = 1 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & (q7_12 != 6))))
replace _ara_q7_14 = 0 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & !(q7_12 != 6))))
replace _ar_q7_14 = 2 if inlist(formdef_version, 2512090157) & _ara_q7_14 == 0 & (missing(q7_14))
replace _ar_q7_14 = 4 if inlist(formdef_version, 2512090157) & _ara_q7_14 == 1 & (missing(q7_14))
replace _ar_q7_14 = 1 if inlist(formdef_version, 2512090157) & _ara_q7_14 == 1 & (q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
replace _ar_q7_14 = 5 if inlist(formdef_version, 2512090157) & _ar_q7_14 == 1 & (q7_14 == 4)
replace _ara_q7_14 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
replace _ara_q7_14 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
replace _ar_q7_14 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_14 == 0 & (missing(q7_14))
replace _ar_q7_14 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_14 == 1 & (missing(q7_14))
replace _ar_q7_14 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_14 == 1 & (q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
replace _ar_q7_14 = 5 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q7_14 == 1 & (q7_14 == 4)
assert inrange(_ar_q7_14, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_14 == `state'
    display as text "q7_14 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & _ara_q7_14 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_14 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_14 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_14, 1, 5)
    local recorded_n = r(N)
    display as text "q7_14 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_14, 1, 5) & q7_14 == `option'
        local category_n = r(N)
        display as text "q7_14 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_14 _ara_q7_14

* ITEM q7_15 | En una escala de 1 a 5, ¿qué tan satisfecha quedó con la atención del proveedor o entidad que gestionó su reclamo?
* Offered options [2512121811, 2602120658, 2512090157, 2512111044, 2512091719]:
* 1 = Muy insatisfecho
* 2 = Insatisfecha
* 3 = Ni satisfecha ni insatisfecha
* 4 = Satisfecha
* 5 = Muy satisfecha
confirm numeric variable q7_15, exact
gen byte _ar_q7_15 = 6
gen byte _ara_q7_15 = .
replace _ara_q7_15 = 1 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & (q7_12 != 6))))
replace _ara_q7_15 = 0 if inlist(formdef_version, 2512090157) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & !(q7_12 != 6))))
replace _ar_q7_15 = 2 if inlist(formdef_version, 2512090157) & _ara_q7_15 == 0 & (missing(q7_15))
replace _ar_q7_15 = 4 if inlist(formdef_version, 2512090157) & _ara_q7_15 == 1 & (missing(q7_15))
replace _ar_q7_15 = 1 if inlist(formdef_version, 2512090157) & _ara_q7_15 == 1 & (q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
replace _ara_q7_15 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
replace _ara_q7_15 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
replace _ar_q7_15 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_15 == 0 & (missing(q7_15))
replace _ar_q7_15 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_15 == 1 & (missing(q7_15))
replace _ar_q7_15 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q7_15 == 1 & (q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
assert inrange(_ar_q7_15, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q7_15 == `state'
    display as text "q7_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q7_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q7_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q7_15, 1, 5)
    local recorded_n = r(N)
    display as text "q7_15 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q7_15, 1, 5) & q7_15 == `option'
        local category_n = r(N)
        display as text "q7_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q7_15 _ara_q7_15

* ============================================================================
* DOMAIN IAER: Reported agency-related experiences and arrangements
* No pooled domain score or model is estimated by this section.

* ITEM q9_4 | Yo decido cómo se usan las remesas del hogar la mayor parte del tiempo.
* Offered options [2512091719, 2512090157, 2512121811, 2602120658, 2512111044]:
* 1 = Totalmente en desacuerdo
* 2 = En desacuerdo
* 3 = Ni de acuerdo ni en desacuerdo
* 4 = De acuerdo
* 5 = Totalmente de acuerdo
confirm numeric variable q9_4, exact
gen byte _ar_q9_4 = 6
gen byte _ara_q9_4 = .
replace _ara_q9_4 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_4 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_4 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_4 == 0 & (missing(q9_4))
replace _ar_q9_4 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_4 == 1 & (missing(q9_4))
replace _ar_q9_4 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_4 == 1 & (q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
assert inrange(_ar_q9_4, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_4 == `state'
    display as text "q9_4 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q9_4 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_4 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_4 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_4, 1, 5)
    local recorded_n = r(N)
    display as text "q9_4 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_4, 1, 5) & q9_4 == `option'
        local category_n = r(N)
        display as text "q9_4 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_4 _ara_q9_4

* ITEM q9_5 | En el último mes en que recibió remesas, ¿quién guardó o administró la mayor parte de ese dinero?
* Offered options [2602120658, 2512090157, 2512111044, 2512121811, 2512091719]:
* 1 = Yo sola
* 2 = Mi pareja o algún familiar en el hogar
* 3 = Ambos (decisión conjunta con pareja u otro familiar)
* 4 = Otra persona del hogar
* 5 = Otra persona fuera del hogar
* 98 = Prefiero no responder
confirm numeric variable q9_5, exact
gen byte _ar_q9_5 = 6
gen byte _ara_q9_5 = .
replace _ara_q9_5 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_5 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_5 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_5 == 0 & (missing(q9_5))
replace _ar_q9_5 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_5 == 1 & (missing(q9_5))
replace _ar_q9_5 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_5 == 1 & (q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
replace _ar_q9_5 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_5 == 1 & (q9_5 == 98)
assert inrange(_ar_q9_5, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_5 == `state'
    display as text "q9_5 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & _ara_q9_5 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_5 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_5 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_5, 1, 5)
    local recorded_n = r(N)
    display as text "q9_5 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_5, 1, 5) & q9_5 == `option'
        local category_n = r(N)
        display as text "q9_5 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_5 _ara_q9_5

* ITEM q9_6 | Si usted quisiera destinar parte de la remesa a ahorro o a su negocio, ¿podría hacerlo sin pedir permiso a otra persona?
* Offered options [2602120658, 2512090157, 2512121811, 2512111044, 2512091719]:
* 1 = Sí, sin pedir permiso
* 2 = Sí, pero debo avisar o acordar
* 3 = No, otras personas deciden
* 98 = Prefiero no responder
confirm numeric variable q9_6, exact
gen byte _ar_q9_6 = 6
gen byte _ara_q9_6 = .
replace _ara_q9_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_6 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_6 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_6 == 0 & (missing(q9_6))
replace _ar_q9_6 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_6 == 1 & (missing(q9_6))
replace _ar_q9_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_6 == 1 & (q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
replace _ar_q9_6 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_6 == 1 & (q9_6 == 98)
assert inrange(_ar_q9_6, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_6 == `state'
    display as text "q9_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & _ara_q9_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_6, 1, 5)
    local recorded_n = r(N)
    display as text "q9_6 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_6, 1, 5) & q9_6 == `option'
        local category_n = r(N)
        display as text "q9_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_6 _ara_q9_6

* ITEM q9_7 | En general, me siento en control de mi dinero y de las decisiones sobre las remesas.
* Offered options [2512121811, 2512111044, 2512091719, 2602120658, 2512090157]:
* 1 = Totalmente en desacuerdo
* 2 = En desacuerdo
* 3 = Ni de acuerdo ni en desacuerdo
* 4 = De acuerdo
* 5 = Totalmente de acuerdo
confirm numeric variable q9_7, exact
gen byte _ar_q9_7 = 6
gen byte _ara_q9_7 = .
replace _ara_q9_7 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_7 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_7 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_7 == 0 & (missing(q9_7))
replace _ar_q9_7 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_7 == 1 & (missing(q9_7))
replace _ar_q9_7 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_7 == 1 & (q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
assert inrange(_ar_q9_7, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_7 == `state'
    display as text "q9_7 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q9_7 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_7 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_7 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_7, 1, 5)
    local recorded_n = r(N)
    display as text "q9_7 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_7, 1, 5) & q9_7 == `option'
        local category_n = r(N)
        display as text "q9_7 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_7 _ara_q9_7

* ITEM q9_8 | En los últimos 12 meses, ¿alguna persona le pidió ver su teléfono o sus códigos (PIN/OTP) para manejar la remesa en contra de su voluntad?
* Offered options [2512091719, 2602120658, 2512090157, 2512121811, 2512111044]:
* 0 = No
* 1 = Sí
* 98 = Prefiero no responder
confirm numeric variable q9_8, exact
gen byte _ar_q9_8 = 6
gen byte _ara_q9_8 = .
replace _ara_q9_8 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_8 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_8 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_8 == 0 & (missing(q9_8))
replace _ar_q9_8 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_8 == 1 & (missing(q9_8))
replace _ar_q9_8 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_8 == 1 & (q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
replace _ar_q9_8 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_8 == 1 & (q9_8 == 98)
assert inrange(_ar_q9_8, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_8 == `state'
    display as text "q9_8 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & _ara_q9_8 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_8 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_8 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_8, 1, 5)
    local recorded_n = r(N)
    display as text "q9_8 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_8, 1, 5) & q9_8 == `option'
        local category_n = r(N)
        display as text "q9_8 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_8 _ara_q9_8

* ITEM q9_9 | Si pudiera elegir libremente, ¿a nombre de quién preferiría que estuviera la cuenta o billetera donde entra la remesa?
* Offered options [2512121811, 2602120658, 2512090157, 2512091719, 2512111044]:
* 1 = A mi cuenta personal
* 2 = A una cuenta conjunta
* 3 = A cuenta de otra persona
* 4 = Me es indiferente
* 98 = No sabe / No recuerda
confirm numeric variable q9_9, exact
gen byte _ar_q9_9 = 6
gen byte _ara_q9_9 = .
replace _ara_q9_9 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_9 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_9 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_9 == 0 & (missing(q9_9))
replace _ar_q9_9 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_9 == 1 & (missing(q9_9))
replace _ar_q9_9 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_9 == 1 & (q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
replace _ar_q9_9 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_9 == 1 & (q9_9 == 98)
assert inrange(_ar_q9_9, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_9 == `state'
    display as text "q9_9 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q9_9 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_9 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_9 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_9, 1, 5)
    local recorded_n = r(N)
    display as text "q9_9 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_9, 1, 5) & q9_9 == `option'
        local category_n = r(N)
        display as text "q9_9 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_9 _ara_q9_9

* ITEM q9_11 | En su hogar, ¿quién suele decidir sobre su atención de salud (visitas a médico, exámenes, tratamientos)?
* Offered options [2512091719, 2512121811, 2602120658, 2512111044, 2512090157]:
* 1 = Yo sola
* 2 = Yo y mi pareja / familiar (decisión conjunta)
* 3 = Mi pareja o familiar
* 4 = Otra persona
* 98 = Prefiero no responder
confirm numeric variable q9_11, exact
gen byte _ar_q9_11 = 6
gen byte _ara_q9_11 = .
replace _ara_q9_11 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_11 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_11 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_11 == 0 & (missing(q9_11))
replace _ar_q9_11 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_11 == 1 & (missing(q9_11))
replace _ar_q9_11 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_11 == 1 & (q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
replace _ar_q9_11 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_11 == 1 & (q9_11 == 98)
assert inrange(_ar_q9_11, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_11 == `state'
    display as text "q9_11 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q9_11 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_11 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_11 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_11, 1, 5)
    local recorded_n = r(N)
    display as text "q9_11 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_11, 1, 5) & q9_11 == `option'
        local category_n = r(N)
        display as text "q9_11 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_11 _ara_q9_11

* ITEM q9_13 | En su hogar, ¿quién toma la decisión sobre los gastos importantes del hogar (por ejemplo, electrodomésticos, arriendo, matrículas)?
* Offered options [2512090157, 2512091719, 2512121811, 2602120658, 2512111044]:
* 1 = Yo sola
* 2 = Yo y mi pareja / familiar (decisión conjunta)
* 3 = Mi pareja o familiar
* 4 = Otra persona
* 98 = Prefiero no responder
confirm numeric variable q9_13, exact
gen byte _ar_q9_13 = 6
gen byte _ara_q9_13 = .
replace _ara_q9_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_13 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_13 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_13 == 0 & (missing(q9_13))
replace _ar_q9_13 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_13 == 1 & (missing(q9_13))
replace _ar_q9_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_13 == 1 & (q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
replace _ar_q9_13 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_13 == 1 & (q9_13 == 98)
assert inrange(_ar_q9_13, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_13 == `state'
    display as text "q9_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q9_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_13, 1, 5)
    local recorded_n = r(N)
    display as text "q9_13 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_13, 1, 5) & q9_13 == `option'
        local category_n = r(N)
        display as text "q9_13 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_13 _ara_q9_13

* ITEM q9_16 | En los últimos 12 meses, ¿ha sentido presión de alguien para entregar todo el dinero de la remesa o mostrar sus movimientos cuando usted no quería?
* Offered options [2512091719, 2512121811, 2602120658, 2512111044, 2512090157]:
* 0 = No
* 1 = Sí
* 98 = Prefiero no responder
confirm numeric variable q9_16, exact
gen byte _ar_q9_16 = 6
gen byte _ara_q9_16 = .
replace _ara_q9_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_16 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_16 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_16 == 0 & (missing(q9_16))
replace _ar_q9_16 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_16 == 1 & (missing(q9_16))
replace _ar_q9_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_16 == 1 & (q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
replace _ar_q9_16 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_16 == 1 & (q9_16 == 98)
assert inrange(_ar_q9_16, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_16 == `state'
    display as text "q9_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & _ara_q9_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_16, 1, 5)
    local recorded_n = r(N)
    display as text "q9_16 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_16, 1, 5) & q9_16 == `option'
        local category_n = r(N)
        display as text "q9_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_16 _ara_q9_16

* ITEM q9_18 | En general, siento que mi opinión sobre el uso de la remesa es escuchada y respetada en mi hogar.
* Offered options [2512090157, 2512091719, 2512111044, 2602120658, 2512121811]:
* 1 = Totalmente en desacuerdo
* 2 = En desacuerdo
* 3 = Ni de acuerdo ni en desacuerdo
* 4 = De acuerdo
* 5 = Totalmente de acuerdo
confirm numeric variable q9_18, exact
gen byte _ar_q9_18 = 6
gen byte _ara_q9_18 = .
replace _ara_q9_18 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_18 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_18 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_18 == 0 & (missing(q9_18))
replace _ar_q9_18 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_18 == 1 & (missing(q9_18))
replace _ar_q9_18 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_18 == 1 & (q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
assert inrange(_ar_q9_18, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_18 == `state'
    display as text "q9_18 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q9_18 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_18 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_18 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_18, 1, 5)
    local recorded_n = r(N)
    display as text "q9_18 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_18, 1, 5) & q9_18 == `option'
        local category_n = r(N)
        display as text "q9_18 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_18 _ara_q9_18

* ITEM q9_19 | Si usted quisiera abrir una nueva cuenta o cambiar la cuenta donde llega la remesa, ¿podría decidirlo?
* Offered options [2512090157, 2602120658, 2512121811, 2512091719, 2512111044]:
* 1 = Sí, por mi cuenta
* 2 = Sí, pero en conjunto con otra persona
* 3 = No, deciden otras personas
* 98 = Prefiero no responder
confirm numeric variable q9_19, exact
gen byte _ar_q9_19 = 6
gen byte _ara_q9_19 = .
replace _ara_q9_19 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_19 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_19 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_19 == 0 & (missing(q9_19))
replace _ar_q9_19 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_19 == 1 & (missing(q9_19))
replace _ar_q9_19 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_19 == 1 & (q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
replace _ar_q9_19 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_19 == 1 & (q9_19 == 98)
assert inrange(_ar_q9_19, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_19 == `state'
    display as text "q9_19 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & _ara_q9_19 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_19 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_19 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_19, 1, 5)
    local recorded_n = r(N)
    display as text "q9_19 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_19, 1, 5) & q9_19 == `option'
        local category_n = r(N)
        display as text "q9_19 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_19 _ara_q9_19

* ITEM q9_20 | ¿Ha evitado usar pagos digitales o aplicaciones por miedo a conflictos o discusiones dentro del hogar?
* Offered options [2602120658, 2512091719, 2512090157, 2512121811, 2512111044]:
* 0 = No
* 1 = Sí
* 98 = Prefiero no responder
confirm numeric variable q9_20, exact
gen byte _ar_q9_20 = 6
gen byte _ara_q9_20 = .
replace _ara_q9_20 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_20 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_20 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_20 == 0 & (missing(q9_20))
replace _ar_q9_20 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_20 == 1 & (missing(q9_20))
replace _ar_q9_20 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_20 == 1 & (q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
replace _ar_q9_20 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_20 == 1 & (q9_20 == 98)
assert inrange(_ar_q9_20, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_20 == `state'
    display as text "q9_20 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & _ara_q9_20 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_20 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_20 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_20, 1, 5)
    local recorded_n = r(N)
    display as text "q9_20 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_20, 1, 5) & q9_20 == `option'
        local category_n = r(N)
        display as text "q9_20 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_20 _ara_q9_20

* ============================================================================
* DOMAIN ICPF: Trust, attitudes, anticipated consequences and requests
* No pooled domain score or model is estimated by this section.

* ITEM q9_1 | Confío en que mi proveedor principal de pagos o cuenta mantendrá mi dinero seguro.
* Offered options [2512111044, 2602120658, 2512090157, 2512121811, 2512091719]:
* 1 = Totalmente en desacuerdo
* 2 = En desacuerdo
* 3 = Ni de acuerdo ni en desacuerdo
* 4 = De acuerdo
* 5 = Totalmente de acuerdo
confirm numeric variable q9_1, exact
gen byte _ar_q9_1 = 6
gen byte _ara_q9_1 = .
replace _ara_q9_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_1 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_1 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_1 == 0 & (missing(q9_1))
replace _ar_q9_1 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_1 == 1 & (missing(q9_1))
replace _ar_q9_1 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_1 == 1 & (q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
assert inrange(_ar_q9_1, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_1 == `state'
    display as text "q9_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q9_1 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_1 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_1 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_1, 1, 5)
    local recorded_n = r(N)
    display as text "q9_1 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_1, 1, 5) & q9_1 == `option'
        local category_n = r(N)
        display as text "q9_1 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_1 _ara_q9_1

* ITEM q9_15 | En mi hogar, se considera apropiado que las mujeres usen pagos digitales (app, QR, transferencias).
* Offered options [2512091719, 2512111044, 2602120658, 2512121811, 2512090157]:
* 1 = Totalmente en desacuerdo
* 2 = En desacuerdo
* 3 = Ni de acuerdo ni en desacuerdo
* 4 = De acuerdo
* 5 = Totalmente de acuerdo
confirm numeric variable q9_15, exact
gen byte _ar_q9_15 = 6
gen byte _ara_q9_15 = .
replace _ara_q9_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_15 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_15 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_15 == 0 & (missing(q9_15))
replace _ar_q9_15 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_15 == 1 & (missing(q9_15))
replace _ar_q9_15 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_15 == 1 & (q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
assert inrange(_ar_q9_15, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_15 == `state'
    display as text "q9_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q9_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_15, 1, 5)
    local recorded_n = r(N)
    display as text "q9_15 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_15, 1, 5) & q9_15 == `option'
        local category_n = r(N)
        display as text "q9_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_15 _ara_q9_15

* ITEM q9_17 | Si usted rechaza compartir su PIN/OTP o su teléfono para manejar la remesa, ¿qué podría ocurrir en su hogar?
* Offered options [2512091719, 2512121811, 2602120658, 2512111044]:
* 1 = Nada (no pasaría nada)
* 2 = Discusión o enojo
* 3 = Me restringen dinero
* 4 = Me restringen movilidad o comunicación
* 5 = Ninguna de las anteriores
* 98 = Prefiero no responder
* Offered options [2512090157]:
* 1 = Nada (no pasaría nada)
* 2 = Discusión o enojo
* 3 = Me restringen dinero
* 4 = Me restringen movilidad o comunicación
* 5 = Otra (especifique)
* 98 = Prefiero no responder
confirm string variable q9_17, exact
gen byte _ar_q9_17 = 6
gen byte _ara_q9_17 = .
replace _ara_q9_17 = 1 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_17 = 0 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_17 = 2 if inlist(formdef_version, 2512090157) & _ara_q9_17 == 0 & (strtrim(q9_17) == "")
replace _ar_q9_17 = 4 if inlist(formdef_version, 2512090157) & _ara_q9_17 == 1 & (strtrim(q9_17) == "")
replace _ar_q9_17 = 1 if inlist(formdef_version, 2512090157) & _ara_q9_17 == 1 & (regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
replace _ar_q9_17 = 6 if inlist(formdef_version, 2512090157) & _ar_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) & wordcount(q9_17) > 1
replace _ar_q9_17 = 6 if inlist(formdef_version, 2512090157) & _ar_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0) & wordcount(q9_17) > 1
replace _ar_q9_17 = 5 if inlist(formdef_version, 2512090157) & _ar_q9_17 == 1 & (strtrim(q9_17) == "98")
replace _ara_q9_17 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_17 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_17 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_17 == 0 & (strtrim(q9_17) == "")
replace _ar_q9_17 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_17 == 1 & (strtrim(q9_17) == "")
replace _ar_q9_17 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_17 == 1 & (regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
replace _ar_q9_17 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) & wordcount(q9_17) > 1
replace _ar_q9_17 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) & wordcount(q9_17) > 1
replace _ar_q9_17 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0) & wordcount(q9_17) > 1
replace _ar_q9_17 = 5 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_17 == 1 & (strtrim(q9_17) == "98")
assert inrange(_ar_q9_17, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_17 == `state'
    display as text "q9_17 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & _ara_q9_17 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_17 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_17 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_17, 1, 5)
    local recorded_n = r(N)
    display as text "q9_17 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        if `option' == 98 {
            quietly count if formdef_version == `fv' & _ar_q9_17 == 5 & ///
                strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0
            local refusal_n = r(N)
            display as text "q9_17 refusal N: " as result `refusal_n'
            if `recorded_n' > 0 {
                display as text "Percent all recorded parents refusing: " as result 100 * `refusal_n' / `recorded_n'
            }
        }
        else {
            quietly count if formdef_version == `fv' & _ar_q9_17 == 1 & ///
                strpos(" " + itrim(strtrim(q9_17)) + " ", " `option' ") > 0
            local selected_n = r(N)
            display as text "q9_17 offered option " `option' " selected N: " as result `selected_n'
            if `regular_n' > 0 {
                display as text "Percent ordinary valid parents: " as result 100 * `selected_n' / `regular_n'
            }
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_17 _ara_q9_17

* ITEM q9_21 | ¿Qué cambios harían más seguro para usted usar pagos digitales y evitar conflictos en el hogar?
* Offered options [2512121811, 2602120658, 2512111044, 2512091719, 2512090157]:
* 1 = Más privacidad (ocultar saldos/notificaciones)
* 2 = Clave o biometría solo mía
* 3 = Educación para la familia
* 4 = Soporte o ayuda si hay coerción
* 5 = Otra
confirm string variable q9_21, exact
gen byte _ar_q9_21 = 6
gen byte _ara_q9_21 = .
replace _ara_q9_21 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & (q9_20 == 1)))
replace _ara_q9_21 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & !(q9_20 == 1)))
replace _ar_q9_21 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_21 == 0 & (strtrim(q9_21) == "")
replace _ar_q9_21 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_21 == 1 & (strtrim(q9_21) == "")
replace _ar_q9_21 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_21 == 1 & (regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
assert inrange(_ar_q9_21, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_21 == `state'
    display as text "q9_21 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q9_21 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_21 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_21 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_21, 1, 5)
    local recorded_n = r(N)
    display as text "q9_21 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & _ar_q9_21 == 1 & ///
            strpos(" " + itrim(strtrim(q9_21)) + " ", " `option' ") > 0
        local selected_n = r(N)
        display as text "q9_21 offered option " `option' " selected N: " as result `selected_n'
        if `regular_n' > 0 {
            display as text "Percent ordinary valid parents: " as result 100 * `selected_n' / `regular_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_21 _ara_q9_21

* ITEM q9_22 | En su comunidad, ¿la mayoría cree que las mujeres deben poder decidir sobre el uso de las remesas del hogar?
* Offered options [2512091719, 2512121811, 2512111044, 2512090157, 2602120658]:
* 1 = Sí, la mayoría
* 2 = Aproximadamente la mitad
* 3 = Pocas personas
* 4 = Casi nadie
* 98 = No sabe / No recuerda
confirm numeric variable q9_22, exact
gen byte _ar_q9_22 = 6
gen byte _ara_q9_22 = .
replace _ara_q9_22 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q9_22 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q9_22 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_22 == 0 & (missing(q9_22))
replace _ar_q9_22 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_22 == 1 & (missing(q9_22))
replace _ar_q9_22 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q9_22 == 1 & (q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
replace _ar_q9_22 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q9_22 == 1 & (q9_22 == 98)
assert inrange(_ar_q9_22, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q9_22 == `state'
    display as text "q9_22 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q9_22 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_22 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q9_22 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q9_22, 1, 5)
    local recorded_n = r(N)
    display as text "q9_22 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q9_22, 1, 5) & q9_22 == `option'
        local category_n = r(N)
        display as text "q9_22 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q9_22 _ara_q9_22

* ============================================================================
* DOMAIN IEH: Information, access conditions, training and support
* No pooled domain score or model is estimated by this section.

* ITEM q10_4 | En general, ¿cuánta información siente que tiene sobre comisiones, tipos de cambio y qué hacer si tiene un problema con un pago digital o remesa?
* Offered options [2602120658, 2512111044, 2512121811, 2512091719, 2512090157]:
* 1 = Ninguna
* 2 = Muy poca
* 3 = Algo
* 4 = Mucha
confirm numeric variable q10_4, exact
gen byte _ar_q10_4 = 6
gen byte _ara_q10_4 = .
replace _ara_q10_4 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_4 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_4 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_4 == 0 & (missing(q10_4))
replace _ar_q10_4 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_4 == 1 & (missing(q10_4))
replace _ar_q10_4 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_4 == 1 & (q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
assert inrange(_ar_q10_4, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q10_4 == `state'
    display as text "q10_4 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & _ara_q10_4 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_4 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_4 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q10_4, 1, 5)
    local recorded_n = r(N)
    display as text "q10_4 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q10_4, 1, 5) & q10_4 == `option'
        local category_n = r(N)
        display as text "q10_4 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q10_4 _ara_q10_4

* ITEM q10_6 | Pensando en los puntos donde retira efectivo (cash-out) cerca de su casa o trabajo, ¿cómo describiría el tiempo y el costo adicional para retirar dinero que llega de forma digital?
* Offered options [2512090157, 2512111044, 2602120658, 2512091719, 2512121811]:
* 1 = Rápido y sin costo extra
* 2 = Rápido pero con costo
* 3 = Lento y con costo
* 4 = Lento pero sin costo
* 5 = No hay puntos cercanos que yo sepa
* 98 = No sabe / No recuerda
confirm numeric variable q10_6, exact
gen byte _ar_q10_6 = 6
gen byte _ara_q10_6 = .
replace _ara_q10_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_6 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_6 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_6 == 0 & (missing(q10_6))
replace _ar_q10_6 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_6 == 1 & (missing(q10_6))
replace _ar_q10_6 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_6 == 1 & (q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
replace _ar_q10_6 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_6 == 1 & (q10_6 == 98)
assert inrange(_ar_q10_6, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q10_6 == `state'
    display as text "q10_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & _ara_q10_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q10_6, 1, 5)
    local recorded_n = r(N)
    display as text "q10_6 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q10_6, 1, 5) & q10_6 == `option'
        local category_n = r(N)
        display as text "q10_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q10_6 _ara_q10_6

* ITEM q10_10 | En los últimos 3 años, ¿participó en alguna capacitación sobre pagos digitales, remesas, billeteras o seguridad en línea?
* This is training timing. q10_11 is the conditional provider, not a substitute.
* Offered options [2512091719, 2602120658, 2512121811, 2512111044, 2512090157]:
* 1 = Sí, en los últimos 12 meses
* 2 = Sí, hace más de 12 meses
* 3 = No, nunca
* 98 = No sabe / No recuerda
confirm numeric variable q10_10, exact
gen byte _ar_q10_10 = 6
gen byte _ara_q10_10 = .
replace _ara_q10_10 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_10 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_10 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_10 == 0 & (missing(q10_10))
replace _ar_q10_10 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_10 == 1 & (missing(q10_10))
replace _ar_q10_10 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_10 == 1 & (q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
replace _ar_q10_10 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_10 == 1 & (q10_10 == 98)
assert inrange(_ar_q10_10, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q10_10 == `state'
    display as text "q10_10 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & _ara_q10_10 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_10 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_10 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q10_10, 1, 5)
    local recorded_n = r(N)
    display as text "q10_10 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q10_10, 1, 5) & q10_10 == `option'
        local category_n = r(N)
        display as text "q10_10 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q10_10 _ara_q10_10

* ITEM q10_11 | ¿Quién organizó la capacitación más reciente a la que asistió?
* Offered options [2512121811, 2512111044, 2602120658, 2512090157, 2512091719]:
* 1 = Gobierno (nacional o local)
* 2 = Organismo de la sociedad civil / ONG
* 3 = Banco o Cooperativa
* 4 = Fintech
* 5 = Otro (especifique)
confirm numeric variable q10_11, exact
gen byte _ar_q10_11 = 6
gen byte _ara_q10_11 = .
replace _ara_q10_11 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
replace _ara_q10_11 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
replace _ar_q10_11 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_11 == 0 & (missing(q10_11))
replace _ar_q10_11 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_11 == 1 & (missing(q10_11))
replace _ar_q10_11 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_11 == 1 & (q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
assert inrange(_ar_q10_11, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q10_11 == `state'
    display as text "q10_11 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q10_11 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_11 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_11 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q10_11, 1, 5)
    local recorded_n = r(N)
    display as text "q10_11 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q10_11, 1, 5) & q10_11 == `option'
        local category_n = r(N)
        display as text "q10_11 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q10_11 _ara_q10_11

* ITEM q10_12 | Después de esa capacitación, ¿cómo cambió su disposición a usar pagos digitales o remesas por app?
* Reported post-training willingness, not a causal training effect or measured adoption.
* Offered options [2512091719, 2602120658, 2512121811, 2512111044, 2512090157]:
* 1 = Mucho menos
* 2 = Algo menos
* 3 = Sin cambio
* 4 = Algo más
* 5 = Mucho más
confirm numeric variable q10_12, exact
gen byte _ar_q10_12 = 6
gen byte _ara_q10_12 = .
replace _ara_q10_12 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
replace _ara_q10_12 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
replace _ar_q10_12 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_12 == 0 & (missing(q10_12))
replace _ar_q10_12 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_12 == 1 & (missing(q10_12))
replace _ar_q10_12 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_12 == 1 & (q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
assert inrange(_ar_q10_12, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q10_12 == `state'
    display as text "q10_12 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & _ara_q10_12 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_12 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_12 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q10_12, 1, 5)
    local recorded_n = r(N)
    display as text "q10_12 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q10_12, 1, 5) & q10_12 == `option'
        local category_n = r(N)
        display as text "q10_12 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q10_12 _ara_q10_12

* ITEM q10_13 | En los últimos 12 meses, ¿recibió acompañamiento individual para usar pagos digitales o remesas? (por ejemplo, alguien que le ayudó a instalar una app, abrir cuenta, activar QR o hacer sus primeras operaciones)
* Offered options [2602120658, 2512090157, 2512121811, 2512091719, 2512111044]:
* 0 = No
* 1 = Sí
* 98 = Prefiero no responder
confirm numeric variable q10_13, exact
gen byte _ar_q10_13 = 6
gen byte _ara_q10_13 = .
replace _ara_q10_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_13 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_13 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_13 == 0 & (missing(q10_13))
replace _ar_q10_13 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_13 == 1 & (missing(q10_13))
replace _ar_q10_13 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_13 == 1 & (q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
replace _ar_q10_13 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_13 == 1 & (q10_13 == 98)
assert inrange(_ar_q10_13, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q10_13 == `state'
    display as text "q10_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & _ara_q10_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q10_13, 1, 5)
    local recorded_n = r(N)
    display as text "q10_13 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q10_13, 1, 5) & q10_13 == `option'
        local category_n = r(N)
        display as text "q10_13 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q10_13 _ara_q10_13

* ITEM q10_14 | ¿Quién le brindó ese acompañamiento individual la última vez?
* Offered options [2512091719, 2512090157]:
* 1 = Promotor comunitario
* 2 = Peronal del banco o cooperativa
* 3 = Fintech
* 4 = Organismo de la sociedad civil / ONG
* 5 = Familiar o amigo
* 6 = Otro (especifique)
* Offered options [2512121811, 2512111044, 2602120658]:
* 1 = Promotor comunitario
* 2 = Peronal del banco o cooperativa
* 3 = Fintech
* 4 = Organismo de la sociedad civil / ONG
* 5 = Familiar o amigo
* 6 = Otra entidad
confirm numeric variable q10_14, exact
gen byte _ar_q10_14 = 6
gen byte _ara_q10_14 = .
replace _ara_q10_14 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & (q10_13 == 1)))
replace _ara_q10_14 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & !(q10_13 == 1)))
replace _ar_q10_14 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_14 == 0 & (missing(q10_14))
replace _ar_q10_14 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_14 == 1 & (missing(q10_14))
replace _ar_q10_14 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_14 == 1 & (q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
assert inrange(_ar_q10_14, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q10_14 == `state'
    display as text "q10_14 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6"
    quietly count if formdef_version == `fv' & _ara_q10_14 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_14 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_14 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q10_14, 1, 5)
    local recorded_n = r(N)
    display as text "q10_14 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q10_14, 1, 5) & q10_14 == `option'
        local category_n = r(N)
        display as text "q10_14 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q10_14 _ara_q10_14

* ITEM q10_16 | En los últimos 12 meses, ¿con qué frecuencia ha visto o usado materiales (folletos, videos, mensajes por WhatsApp, redes sociales) sobre fraudes y uso seguro de pagos digitales?
* Offered options [2512111044, 2512090157, 2512121811, 2512091719, 2602120658]:
* 1 = Siempre
* 2 = A menudo
* 3 = Pocas veces
* 4 = Nunca
* 98 = No sabe / No recuerda
confirm numeric variable q10_16, exact
gen byte _ar_q10_16 = 6
gen byte _ara_q10_16 = .
replace _ara_q10_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_16 = 0 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_16 = 2 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_16 == 0 & (missing(q10_16))
replace _ar_q10_16 = 4 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_16 == 1 & (missing(q10_16))
replace _ar_q10_16 = 1 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_16 == 1 & (q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
replace _ar_q10_16 = 5 if inlist(formdef_version, 2512090157, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_16 == 1 & (q10_16 == 98)
assert inrange(_ar_q10_16, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q10_16 == `state'
    display as text "q10_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & _ara_q10_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q10_16, 1, 5)
    local recorded_n = r(N)
    display as text "q10_16 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q10_16, 1, 5) & q10_16 == `option'
        local category_n = r(N)
        display as text "q10_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q10_16 _ara_q10_16

* ============================================================================
* DOMAIN IBPD: Reported barriers
* No pooled domain score or model is estimated by this section.
* Shared q10_4, q10_6 and q10_16 are reported once under IEH.

* ITEM q10_1 | ¿Cuál diría que es el principal motivo por el cual no usa más pagos digitales (o no los usa en absoluto)?
* Option 4 is substantive lack of know-how, including when selected with other barriers.
* Offered options [2512121811, 2602120658, 2512091719, 2512111044]:
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
* 11 = Otra (especifique)
confirm numeric variable q10_1, exact
gen byte _ar_q10_1 = 6
gen byte _ara_q10_1 = .
replace _ara_q10_1 = 1 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_1 = 0 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_1 = 2 if inlist(formdef_version, 2512090157) & _ara_q10_1 == 0 & (missing(q10_1))
replace _ar_q10_1 = 4 if inlist(formdef_version, 2512090157) & _ara_q10_1 == 1 & (missing(q10_1))
replace _ar_q10_1 = 1 if inlist(formdef_version, 2512090157) & _ara_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11)
replace _ara_q10_1 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_1 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_1 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_1 == 0 & (missing(q10_1))
replace _ar_q10_1 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_1 == 1 & (missing(q10_1))
replace _ar_q10_1 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
replace _ar_q10_1 = 5 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_1 == 1 & (q10_1 == 98)
assert inrange(_ar_q10_1, 1, 6)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if _ar_q10_1 == `state'
    display as text "q10_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 8 9 10 11 12 14 15 16 98"
    if `fv' == 2512090157 {
        local options "1 2 3 4 5 6 7 8 9 10 11"
    }
    quietly count if formdef_version == `fv' & _ara_q10_1 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_1 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & _ar_q10_1 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(_ar_q10_1, 1, 5)
    local recorded_n = r(N)
    display as text "q10_1 version " `fv' ": applicable / ordinary / sentinel / recorded" as result " " `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(_ar_q10_1, 1, 5) & q10_1 == `option'
        local category_n = r(N)
        display as text "q10_1 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
drop _ar_q10_1 _ara_q10_1

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

* No output files, participant records, scores, model objects or class labels are written.
