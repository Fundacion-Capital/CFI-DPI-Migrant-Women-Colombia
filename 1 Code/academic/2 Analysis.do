/*
CFI DPI — academic quantitative analysis
Authors: Jorge E. Zavala and Angélica Cardozo Cadavid
Integrated source revision: 7 November 2026. Exact form labels: 8 November 2026. Stata 16 syntax.
*/
* Source-review candidate only. No execution is authorized by this code revision.
exit 198

version 16
set varabbrev off

* The same full prepared stage stays in memory. Do not load a numeric-only view.
* Every displayed count and percentage, including small cells, stays restricted.
count
local admitted_n = r(N)
display as text "Admitted cohort N (not a universal item denominator): " `admitted_n'
count if consent == 0 | consent == 98
display as text "Historical consent-filter disagreement; no new exclusion: " r(N)
count if q1 == 2
display as text "Historical gender-filter disagreement; no new exclusion: " r(N)
count if q5 == 0 | q5 == 98
display as text "Historical remittance-filter disagreement; no new exclusion: " r(N)
count if wp07_known_form != 1
display as text "Unknown/missing submitted form, retained for review: " r(N)

* ITEM AND DOMAIN REPORTS
* Scalar percentages use recorded applicable answers, including explicit sentinels.
* Multiple-response option shares use ordinary-valid parents in the actual form.
* An unoffered option has no invented zero or denominator. Empty bases are undefined.
* See the version-specific CODEBOOK.csv; raw legacy value labels are not authoritative.

* ============================================================================
* DOMAIN IAT

* ITEM q3_1 | ¿Usted tiene personalmente un teléfono móvil que usa con regularidad?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_1 == `state'
    display as text "q3_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3"
    quietly count if formdef_version == `fv' & wp07_route_q3_1 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_1 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_1 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_1, 1, 5)
    local recorded_n = r(N)
    display as text "q3_1 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_1, 1, 5) & q3_1 == `option'
        local category_n = r(N)
        display as text "q3_1 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q3_5 | ¿Con qué frecuencia usa Internet en cualquier dispositivo?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_5 == `state'
    display as text "q3_5 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q3_5 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_5 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_5 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_5, 1, 5)
    local recorded_n = r(N)
    display as text "q3_5 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_5, 1, 5) & q3_5 == `option'
        local category_n = r(N)
        display as text "q3_5 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q3_6 | ¿Dónde accede principalmente a Internet?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_6 == `state'
    display as text "q3_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6"
    quietly count if formdef_version == `fv' & wp07_route_q3_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_6, 1, 5)
    local recorded_n = r(N)
    display as text "q3_6 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_6, 1, 5) & q3_6 == `option'
        local category_n = r(N)
        display as text "q3_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q3_7 | Actualmente, ¿cuenta con un plan de datos móviles activo en su teléfono principal?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_7 == `state'
    display as text "q3_7 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & wp07_route_q3_7 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_7 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_7 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_7, 1, 5)
    local recorded_n = r(N)
    display as text "q3_7 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_7, 1, 5) & q3_7 == `option'
        local category_n = r(N)
        display as text "q3_7 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q3_8 | En el último mes, ¿se quedó sin datos o saldo y eso le impidió usar servicios financieros o comunicarse?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_8 == `state'
    display as text "q3_8 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & wp07_route_q3_8 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_8 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_8 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_8, 1, 5)
    local recorded_n = r(N)
    display as text "q3_8 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_8, 1, 5) & q3_8 == `option'
        local category_n = r(N)
        display as text "q3_8 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q3_12 | ¿Puede leer mensajes cortos en su teléfono sin ayuda de otra persona?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_12 == `state'
    display as text "q3_12 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3"
    quietly count if formdef_version == `fv' & wp07_route_q3_12 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_12 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_12 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_12, 1, 5)
    local recorded_n = r(N)
    display as text "q3_12 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_12, 1, 5) & q3_12 == `option'
        local category_n = r(N)
        display as text "q3_12 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN IVS

* ITEM q2_1 | ¿En qué año llegó a vivir a Colombia por primera vez?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q2_1 == `state'
    display as text "q2_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Numeric context only. Its own ordinary-valid N is not a common model sample.
quietly count if wp07_state_q2_1 == 1
if r(N) > 0 {
    tabstat q2_1 if wp07_state_q2_1 == 1, statistics(n mean sd min p25 p50 p75 max) columns(statistics)
}

* ITEM q2_2 | ¿Cuál es el último nivel de estudios que completó?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q2_2 == `state'
    display as text "q2_2 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 8 9 10"
    quietly count if formdef_version == `fv' & wp07_route_q2_2 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q2_2 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q2_2 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q2_2, 1, 5)
    local recorded_n = r(N)
    display as text "q2_2 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q2_2, 1, 5) & q2_2 == `option'
        local category_n = r(N)
        display as text "q2_2 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q2_3 | Actualmente, ¿cuál es su ocupación principal?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q2_3 == `state'
    display as text "q2_3 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 8 9"
    quietly count if formdef_version == `fv' & wp07_route_q2_3 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q2_3 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q2_3 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q2_3, 1, 5)
    local recorded_n = r(N)
    display as text "q2_3 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q2_3, 1, 5) & q2_3 == `option'
        local category_n = r(N)
        display as text "q2_3 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q4 | ¿Cuál es su edad en años cumplidos?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4 == `state'
    display as text "q4 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Numeric context only. Its own ordinary-valid N is not a common model sample.
quietly count if wp07_state_q4 == 1
if r(N) > 0 {
    tabstat q4 if wp07_state_q4 == 1, statistics(n mean sd min p25 p50 p75 max) columns(statistics)
}

* ITEM q3 | Residence geography; accepted D2 version-aware meanings
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3 == `state'
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
    quietly count if formdef_version == `fv' & wp07_route_q3 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3, 1, 5)
    local recorded_n = r(N)
    display as text "q3 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3, 1, 5) & q3 == `option'
        local category_n = r(N)
        display as text "q3 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN IADT

* ITEM q3_15 | Sé descargar e instalar una aplicación en mi teléfono.
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_15 == `state'
    display as text "q3_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q3_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_15, 1, 5)
    local recorded_n = r(N)
    display as text "q3_15 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_15, 1, 5) & q3_15 == `option'
        local category_n = r(N)
        display as text "q3_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q3_16 | Sé usar mi teléfono para enviar o recibir dinero (transferencias, billetera digital, pago móvil).
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_16 == `state'
    display as text "q3_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q3_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_16, 1, 5)
    local recorded_n = r(N)
    display as text "q3_16 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_16, 1, 5) & q3_16 == `option'
        local category_n = r(N)
        display as text "q3_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q3_17 | Me siento segura evitando fraudes y mensajes sospechosos en línea (PIN, códigos OTP, enlaces).
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_17 == `state'
    display as text "q3_17 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q3_17 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_17 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_17 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_17, 1, 5)
    local recorded_n = r(N)
    display as text "q3_17 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_17, 1, 5) & q3_17 == `option'
        local category_n = r(N)
        display as text "q3_17 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN ICDP

* ITEM q3_20 | En los últimos 3 meses, ¿escaneó un código QR para pagar o para que le paguen?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_20 == `state'
    display as text "q3_20 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & wp07_route_q3_20 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_20 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_20 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_20, 1, 5)
    local recorded_n = r(N)
    display as text "q3_20 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_20, 1, 5) & q3_20 == `option'
        local category_n = r(N)
        display as text "q3_20 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q3_21 | Si recibe un SMS con un código de verificación (OTP), ¿puede leerlo y usarlo sin ayuda?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_21 == `state'
    display as text "q3_21 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & wp07_route_q3_21 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_21 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_21 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_21, 1, 5)
    local recorded_n = r(N)
    display as text "q3_21 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_21, 1, 5) & q3_21 == `option'
        local category_n = r(N)
        display as text "q3_21 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q3_22 | ¿Sabe crear o cambiar el PIN de su aplicación bancaria o billetera digital?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_22 == `state'
    display as text "q3_22 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3"
    quietly count if formdef_version == `fv' & wp07_route_q3_22 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_22 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_22 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_22, 1, 5)
    local recorded_n = r(N)
    display as text "q3_22 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_22, 1, 5) & q3_22 == `option'
        local category_n = r(N)
        display as text "q3_22 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q3_23 | Si recibe por WhatsApp o SMS un mensaje sospechoso que solicita dinero, claves o códigos, ¿qué haría primero?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q3_23 == `state'
    display as text "q3_23 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q3_23 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_23 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q3_23 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q3_23, 1, 5)
    local recorded_n = r(N)
    display as text "q3_23 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q3_23, 1, 5) & q3_23 == `option'
        local category_n = r(N)
        display as text "q3_23 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN IAFF

* ITEM q4_1 | ¿Cuáles de los siguientes documentos de identidad posee actualmente? (Marque todas las que apliquen).
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_1 == `state'
    display as text "q4_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 8 9 98"
    quietly count if formdef_version == `fv' & wp07_route_q4_1 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_1 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_1 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_1, 1, 5)
    local recorded_n = r(N)
    display as text "q4_1 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        if `option' == 98 {
            quietly count if formdef_version == `fv' & wp07_state_q4_1 == 5 & ///
                strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0
            local refusal_n = r(N)
            display as text "q4_1 refusal N: " as result `refusal_n'
            if `recorded_n' > 0 {
                display as text "Percent all recorded parents refusing: " as result 100 * `refusal_n' / ///
                    `recorded_n'
            }
        }
        else {
            quietly count if formdef_version == `fv' & wp07_state_q4_1 == 1 & ///
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

* ITEM q4_5 | ¿Tiene a su nombre algún comprobante de dirección aceptado por entidades financieras (recibo de servicios, contrato de arriendo, certificado de residencia)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_5 == `state'
    display as text "q4_5 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & wp07_route_q4_5 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_5 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_5 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_5, 1, 5)
    local recorded_n = r(N)
    display as text "q4_5 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q4_5, 1, 5) & q4_5 == `option'
        local category_n = r(N)
        display as text "q4_5 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q4_6 | El número de teléfono que normalmente usa para sus cuentas o billeteras digitales, ¿está registrado a su nombre?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_6 == `state'
    display as text "q4_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & wp07_route_q4_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_6, 1, 5)
    local recorded_n = r(N)
    display as text "q4_6 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q4_6, 1, 5) & q4_6 == `option'
        local category_n = r(N)
        display as text "q4_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q4_12 | ¿Usted tiene personalmente alguna cuenta en una institución financiera o una cuenta/billetera de dinero móvil? (Marque todas las que apliquen).
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_12 == `state'
    display as text "q4_12 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & wp07_route_q4_12 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_12 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_12 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_12, 1, 5)
    local recorded_n = r(N)
    display as text "q4_12 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & wp07_state_q4_12 == 1 & ///
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


* ============================================================================
* DOMAIN IUOF

* ITEM q4_13 | De las cuentas o billeteras que mencionó, ¿cuál es la principal para recibir o manejar dinero?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_13 == `state'
    display as text "q4_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q4_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_13, 1, 5)
    local recorded_n = r(N)
    display as text "q4_13 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q4_13, 1, 5) & q4_13 == `option'
        local category_n = r(N)
        display as text "q4_13 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}
* IUOF cross-item semantic review; this route already requires a valid positive q4_12 parent.
quietly count if wp07_route_q4_13 == 1 & q4_13 == 5
display as text "No account after positive account selection (semantic hold, no repair) N: " as result r(N)
forvalues product = 1/4 {
    quietly count if wp07_state_q4_13 == 1 & q4_13 == `product' & ///
        !(strpos(" " + itrim(strtrim(q4_12)) + " ", " `product' ") > 0)
    display as text "Principal product absent from selected accounts (semantic hold, no repair) code " ///
        `product' " N: " as result r(N)
}

* ITEM q4_15 | En los últimos 60 días (2 meses), ¿con qué frecuencia usó su cuenta o billetera principal para cualquier operación (recibir, pagar, retirar, consultar saldo)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_15 == `state'
    display as text "q4_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q4_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_15, 1, 5)
    local recorded_n = r(N)
    display as text "q4_15 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q4_15, 1, 5) & q4_15 == `option'
        local category_n = r(N)
        display as text "q4_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q4_16 | ¿Qué tan fácil le resulta depositar o retirar efectivo (cash-in / cash-out) cerca de su vivienda o trabajo?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_16 == `state'
    display as text "q4_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 99"
    quietly count if formdef_version == `fv' & wp07_route_q4_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_16, 1, 5)
    local recorded_n = r(N)
    display as text "q4_16 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q4_16, 1, 5) & q4_16 == `option'
        local category_n = r(N)
        display as text "q4_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q4_17 | ¿Aproximadamente cuánto tiempo tarda en llegar al punto de agente, cajero o sucursal más cercano donde puede hacer cash-in/cash-out?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_17 == `state'
    display as text "q4_17 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 99"
    quietly count if formdef_version == `fv' & wp07_route_q4_17 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_17 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_17 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_17, 1, 5)
    local recorded_n = r(N)
    display as text "q4_17 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q4_17, 1, 5) & q4_17 == `option'
        local category_n = r(N)
        display as text "q4_17 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q4_24 | ¿Usa su cuenta o billetera principal para pagar en comercios (por ejemplo, QR, transferencia, datafono sin tarjeta física)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_24 == `state'
    display as text "q4_24 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & wp07_route_q4_24 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_24 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_24 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_24, 1, 5)
    local recorded_n = r(N)
    display as text "q4_24 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q4_24, 1, 5) & q4_24 == `option'
        local category_n = r(N)
        display as text "q4_24 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q4_25 | ¿Mantiene ahorros en su cuenta o billetera principal (es decir, deja dinero guardado por más de una semana)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_25 == `state'
    display as text "q4_25 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & wp07_route_q4_25 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_25 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_25 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_25, 1, 5)
    local recorded_n = r(N)
    display as text "q4_25 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q4_25, 1, 5) & q4_25 == `option'
        local category_n = r(N)
        display as text "q4_25 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q4_26 | ¿Recibe notificaciones (SMS o app) cuando llega una transferencia o remesa a su cuenta o billetera principal?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_26 == `state'
    display as text "q4_26 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & wp07_route_q4_26 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_26 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_26 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_26, 1, 5)
    local recorded_n = r(N)
    display as text "q4_26 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q4_26, 1, 5) & q4_26 == `option'
        local category_n = r(N)
        display as text "q4_26 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q4_27 | En los últimos 60 días (2 meses), ¿prestó su cuenta o billetera a otra persona para que recibiera o moviera dinero?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q4_27 == `state'
    display as text "q4_27 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & wp07_route_q4_27 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_27 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q4_27 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q4_27, 1, 5)
    local recorded_n = r(N)
    display as text "q4_27 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q4_27, 1, 5) & q4_27 == `option'
        local category_n = r(N)
        display as text "q4_27 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN OQI

* ITEM q5_13 | En su registro (onboarding) más reciente, ¿qué le pidieron para verificar su identidad? (Marque todo lo que aplique).
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q5_13 == `state'
    display as text "q5_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 98"
    quietly count if formdef_version == `fv' & wp07_route_q5_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q5_13, 1, 5)
    local recorded_n = r(N)
    display as text "q5_13 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        if `option' == 98 {
            quietly count if formdef_version == `fv' & wp07_state_q5_13 == 5 & ///
                strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0
            local uncertainty_n = r(N)
            display as text "q5_13 uncertainty N: " as result `uncertainty_n'
            if `recorded_n' > 0 {
                display as text "Percent all recorded parents uncertain: " as result 100 * `uncertainty_n' / ///
                    `recorded_n'
            }
        }
        else {
            quietly count if formdef_version == `fv' & wp07_state_q5_13 == 1 & ///
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

* ITEM q5_14 | En general, ¿qué tan fácil o difícil fue completar el registro hasta poder usar la cuenta o billetera principal?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q5_14 == `state'
    display as text "q5_14 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q5_14 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_14 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_14 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q5_14, 1, 5)
    local recorded_n = r(N)
    display as text "q5_14 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q5_14, 1, 5) & q5_14 == `option'
        local category_n = r(N)
        display as text "q5_14 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q5_15 | ¿Cuánto tiempo tardó su registro hasta que la cuenta o billetera quedó activada para recibir o enviar dinero?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q5_15 == `state'
    display as text "q5_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & wp07_route_q5_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q5_15, 1, 5)
    local recorded_n = r(N)
    display as text "q5_15 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q5_15, 1, 5) & q5_15 == `option'
        local category_n = r(N)
        display as text "q5_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q5_16 | ¿Necesitó ayuda para registrarse en esa cuenta o billetera principal?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q5_16 == `state'
    display as text "q5_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & wp07_route_q5_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q5_16, 1, 5)
    local recorded_n = r(N)
    display as text "q5_16 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q5_16, 1, 5) & q5_16 == `option'
        local category_n = r(N)
        display as text "q5_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q5_21 | ¿Recuerda haber aceptado términos y condiciones y autorización de manejo de datos personales durante el registro?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q5_21 == `state'
    display as text "q5_21 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & wp07_route_q5_21 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_21 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_21 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q5_21, 1, 5)
    local recorded_n = r(N)
    display as text "q5_21 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q5_21, 1, 5) & q5_21 == `option'
        local category_n = r(N)
        display as text "q5_21 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q5_22 | En su opinión, ¿el registro protegió adecuadamente su privacidad (solo pidió lo necesario y explicó el uso de sus datos)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q5_22 == `state'
    display as text "q5_22 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & wp07_route_q5_22 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_22 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_22 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q5_22, 1, 5)
    local recorded_n = r(N)
    display as text "q5_22 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q5_22, 1, 5) & q5_22 == `option'
        local category_n = r(N)
        display as text "q5_22 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q5_23 | En el registro o en el primer uso, ¿el sistema o app ofreció mensajes en español claro y algún tipo de asistencia (tutorial, ayuda paso a paso, chat)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q5_23 == `state'
    display as text "q5_23 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & wp07_route_q5_23 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_23 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q5_23 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q5_23, 1, 5)
    local recorded_n = r(N)
    display as text "q5_23 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q5_23, 1, 5) & q5_23 == `option'
        local category_n = r(N)
        display as text "q5_23 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN IURD

* ITEM q6_2 | Pensando solo en los últimos 12 meses, ¿con qué frecuencia recibió remesas del exterior?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_2 == `state'
    display as text "q6_2 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 99"
    quietly count if formdef_version == `fv' & wp07_route_q6_2 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_2 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_2 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_2, 1, 5)
    local recorded_n = r(N)
    display as text "q6_2 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_2, 1, 5) & q6_2 == `option'
        local category_n = r(N)
        display as text "q6_2 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_4 | ¿A través de qué canal recibió esa remesa más reciente?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_4 == `state'
    display as text "q6_4 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q6_4 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_4 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_4 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_4, 1, 5)
    local recorded_n = r(N)
    display as text "q6_4 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_4, 1, 5) & q6_4 == `option'
        local category_n = r(N)
        display as text "q6_4 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_13 | En general, pensando en todas las remesas que recibe, ¿qué proporción termina en efectivo y qué proporción se mantiene o usa de forma digital?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_13 == `state'
    display as text "q6_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q6_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_13, 1, 5)
    local recorded_n = r(N)
    display as text "q6_13 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_13, 1, 5) & q6_13 == `option'
        local category_n = r(N)
        display as text "q6_13 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_14 | En los últimos 60 días (2 meses), ¿realizó o recibió pagos digitales o remesas dentro de Colombia usando apps, transferencias, billeteras o códigos QR?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_14 == `state'
    display as text "q6_14 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & wp07_route_q6_14 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_14 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_14 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_14, 1, 5)
    local recorded_n = r(N)
    display as text "q6_14 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_14, 1, 5) & q6_14 == `option'
        local category_n = r(N)
        display as text "q6_14 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_15 | En esos últimos 60 días (2 meses), aproximadamente ¿cuántas operaciones digitales (enviar o recibir dinero) realizó en total?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_15 == `state'
    display as text "q6_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & wp07_route_q6_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_15, 1, 5)
    local recorded_n = r(N)
    display as text "q6_15 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_15, 1, 5) & q6_15 == `option'
        local category_n = r(N)
        display as text "q6_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN IETR

* ITEM q6_6 | ¿Cuánto tiempo pasó desde que la persona que envió la remesa hizo el envío hasta que usted pudo usar el dinero?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_6 == `state'
    display as text "q6_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & wp07_route_q6_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_6, 1, 5)
    local recorded_n = r(N)
    display as text "q6_6 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_6, 1, 5) & q6_6 == `option'
        local category_n = r(N)
        display as text "q6_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_9 | Pensando en esa remesa más reciente, ¿qué tan clara fue para usted la tasa de cambio aplicada (si hubo cambio de moneda)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_9 == `state'
    display as text "q6_9 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 99"
    quietly count if formdef_version == `fv' & wp07_route_q6_9 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_9 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_9 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_9, 1, 5)
    local recorded_n = r(N)
    display as text "q6_9 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_9, 1, 5) & q6_9 == `option'
        local category_n = r(N)
        display as text "q6_9 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_11 | ¿Recibió alguna confirmación cuando llegó esa remesa (SMS, notificación de app, correo electrónico o recibo en papel)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_11 == `state'
    display as text "q6_11 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & wp07_route_q6_11 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_11 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_11 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_11, 1, 5)
    local recorded_n = r(N)
    display as text "q6_11 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_11, 1, 5) & q6_11 == `option'
        local category_n = r(N)
        display as text "q6_11 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_16 | En esos últimos 60 días (2 meses), ¿tuvo algún problema con pagos o transferencias digitales (por ejemplo, dinero que no llegó, reversos, operaciones rechazadas o duplicadas)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_16 == `state'
    display as text "q6_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q6_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_16, 1, 5)
    local recorded_n = r(N)
    display as text "q6_16 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_16, 1, 5) & q6_16 == `option'
        local category_n = r(N)
        display as text "q6_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_17 | ¿Ha encontrado límites o topes que le impidan completar operaciones digitales (por monto por transacción, límite diario o mensual, o número de operaciones)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_17 == `state'
    display as text "q6_17 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q6_17 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_17 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_17 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_17, 1, 5)
    local recorded_n = r(N)
    display as text "q6_17 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_17, 1, 5) & q6_17 == `option'
        local category_n = r(N)
        display as text "q6_17 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_18 | En la última operación digital que hizo en esos 90 días, ¿las comisiones se mostraron claramente antes de que usted confirmara la operación?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_18 == `state'
    display as text "q6_18 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q6_18 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_18 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_18 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_18, 1, 5)
    local recorded_n = r(N)
    display as text "q6_18 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_18, 1, 5) & q6_18 == `option'
        local category_n = r(N)
        display as text "q6_18 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_20 | En esa última operación digital, ¿recibió una confirmación inmediata (por SMS o notificación en la app) al enviar o recibir el dinero?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_20 == `state'
    display as text "q6_20 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & wp07_route_q6_20 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_20 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_20 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_20, 1, 5)
    local recorded_n = r(N)
    display as text "q6_20 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_20, 1, 5) & q6_20 == `option'
        local category_n = r(N)
        display as text "q6_20 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_21 | En general, ¿qué tan rápidos le resultan sus pagos o remesas digitales (desde que se envían hasta que usted puede usar el dinero)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_21 == `state'
    display as text "q6_21 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6"
    quietly count if formdef_version == `fv' & wp07_route_q6_21 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_21 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_21 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_21, 1, 5)
    local recorded_n = r(N)
    display as text "q6_21 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_21, 1, 5) & q6_21 == `option'
        local category_n = r(N)
        display as text "q6_21 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_22 | ¿Ha notado cargos adicionales al pagar con QR o transferencia en comercios, comparado con pagar en efectivo (por ejemplo, recargo o comisión extra)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_22 == `state'
    display as text "q6_22 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98 99"
    quietly count if formdef_version == `fv' & wp07_route_q6_22 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_22 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_22 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_22, 1, 5)
    local recorded_n = r(N)
    display as text "q6_22 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_22, 1, 5) & q6_22 == `option'
        local category_n = r(N)
        display as text "q6_22 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_23 | En general, ¿qué tan clara le resulta la información que dan los proveedores sobre límites, horarios, comisiones y tiempos de abono de las operaciones digitales?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_23 == `state'
    display as text "q6_23 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & wp07_route_q6_23 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_23 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_23 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_23, 1, 5)
    local recorded_n = r(N)
    display as text "q6_23 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_23, 1, 5) & q6_23 == `option'
        local category_n = r(N)
        display as text "q6_23 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q6_24 | En los últimos 60 días (2 meses), ¿cómo evaluaría su experiencia transaccional digital en general?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q6_24 == `state'
    display as text "q6_24 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q6_24 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_24 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q6_24 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q6_24, 1, 5)
    local recorded_n = r(N)
    display as text "q6_24 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q6_24, 1, 5) & q6_24 == `option'
        local category_n = r(N)
        display as text "q6_24 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN IPCS

* ITEM q7_1 | En los últimos 12 meses, ¿recibió mensajes o llamadas sospechosas (SMS, WhatsApp, redes sociales o teléfono) pidiéndole códigos SMS/OTP, claves, PIN o que hiciera una transferencia urgente?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_1 == `state'
    display as text "q7_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q7_1 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_1 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_1 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_1, 1, 5)
    local recorded_n = r(N)
    display as text "q7_1 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_1, 1, 5) & q7_1 == `option'
        local category_n = r(N)
        display as text "q7_1 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_2 | Pensando en el último mensaje o llamada sospechosa que recibió, ¿qué hizo usted primero?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_2 == `state'
    display as text "q7_2 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q7_2 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_2 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_2 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_2, 1, 5)
    local recorded_n = r(N)
    display as text "q7_2 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_2, 1, 5) & q7_2 == `option'
        local category_n = r(N)
        display as text "q7_2 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_6 | Actualmente, ¿usa algún método de autenticación segura en su teléfono o app (por ejemplo, huella, reconocimiento facial, PIN, patrón o bloqueo de pantalla)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_6 == `state'
    display as text "q7_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & wp07_route_q7_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_6, 1, 5)
    local recorded_n = r(N)
    display as text "q7_6 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_6, 1, 5) & q7_6 == `option'
        local category_n = r(N)
        display as text "q7_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_7 | ¿Con qué frecuencia cambia sus claves o PIN y revisa sus movimientos para detectar operaciones no reconocidas?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_7 == `state'
    display as text "q7_7 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & wp07_route_q7_7 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_7 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_7 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_7, 1, 5)
    local recorded_n = r(N)
    display as text "q7_7 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_7, 1, 5) & q7_7 == `option'
        local category_n = r(N)
        display as text "q7_7 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_8 | ¿Recibió en los últimos 12 meses mensajes de educación o alertas de su banco/app sobre estafas comunes (por ejemplo, “no comparta OTP”, “no haga clic en enlaces desconocidos”)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_8 == `state'
    display as text "q7_8 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & wp07_route_q7_8 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_8 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_8 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_8, 1, 5)
    local recorded_n = r(N)
    display as text "q7_8 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_8, 1, 5) & q7_8 == `option'
        local category_n = r(N)
        display as text "q7_8 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_9 | En general, ¿qué tan segura se siente al recibir remesas o pagos por canales digitales (app, QR, transferencia)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_9 == `state'
    display as text "q7_9 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & wp07_route_q7_9 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_9 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_9 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_9, 1, 5)
    local recorded_n = r(N)
    display as text "q7_9 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_9, 1, 5) & q7_9 == `option'
        local category_n = r(N)
        display as text "q7_9 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_10 | ¿Qué medida de seguridad considera más útil para evitar fraudes en su caso?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_10 == `state'
    display as text "q7_10 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6"
    if `fv' == 2512090157 {
        local options "1 2 3 4 5 6 7"
    }
    quietly count if formdef_version == `fv' & wp07_route_q7_10 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_10 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_10 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_10, 1, 5)
    local recorded_n = r(N)
    display as text "q7_10 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_10, 1, 5) & q7_10 == `option'
        local category_n = r(N)
        display as text "q7_10 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* Shared q7_1 exposure is reported once under IPCS; it is not independent evidence.


* ============================================================================
* DOMAIN IEDF

* ITEM q7_5 | En los últimos 12 meses, ¿su cuenta, tarjeta o app fue bloqueada o limitada por intentos fallidos, contraseñas erradas o sospecha de fraude?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_5 == `state'
    display as text "q7_5 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q7_5 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_5 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_5 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_5, 1, 5)
    local recorded_n = r(N)
    display as text "q7_5 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_5, 1, 5) & q7_5 == `option'
        local category_n = r(N)
        display as text "q7_5 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_11 | En los últimos 12 meses, ¿tuvo algún problema con un pago o remesa digital (por ejemplo, dinero que no llegó, llegó incompleto o tarde, cobro indebido, error de destinatario)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_11 == `state'
    display as text "q7_11 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 98"
    quietly count if formdef_version == `fv' & wp07_route_q7_11 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_11 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_11 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_11, 1, 5)
    local recorded_n = r(N)
    display as text "q7_11 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_11, 1, 5) & q7_11 == `option'
        local category_n = r(N)
        display as text "q7_11 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_12 | Pensando en el problema más reciente, ¿a quién presentó el reclamo primero?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_12 == `state'
    display as text "q7_12 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6"
    if `fv' == 2512090157 {
        local options "1 2 3 4 5 6 7"
    }
    quietly count if formdef_version == `fv' & wp07_route_q7_12 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_12 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_12 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_12, 1, 5)
    local recorded_n = r(N)
    display as text "q7_12 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_12, 1, 5) & q7_12 == `option'
        local category_n = r(N)
        display as text "q7_12 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_13 | ¿Cuánto tiempo tardó en recibir una primera respuesta de ese canal de reclamo?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_13 == `state'
    display as text "q7_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q7_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_13, 1, 5)
    local recorded_n = r(N)
    display as text "q7_13 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_13, 1, 5) & q7_13 == `option'
        local category_n = r(N)
        display as text "q7_13 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_14 | ¿El problema quedó resuelto y el dinero fue restituido o corregido?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_14 == `state'
    display as text "q7_14 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & wp07_route_q7_14 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_14 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_14 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_14, 1, 5)
    local recorded_n = r(N)
    display as text "q7_14 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_14, 1, 5) & q7_14 == `option'
        local category_n = r(N)
        display as text "q7_14 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q7_15 | En una escala de 1 a 5, ¿qué tan satisfecha quedó con la atención del proveedor o entidad que gestionó su reclamo?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q7_15 == `state'
    display as text "q7_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q7_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q7_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q7_15, 1, 5)
    local recorded_n = r(N)
    display as text "q7_15 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q7_15, 1, 5) & q7_15 == `option'
        local category_n = r(N)
        display as text "q7_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN IAER

* ITEM q9_4 | Yo decido cómo se usan las remesas del hogar la mayor parte del tiempo.
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_4 == `state'
    display as text "q9_4 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q9_4 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_4 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_4 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_4, 1, 5)
    local recorded_n = r(N)
    display as text "q9_4 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_4, 1, 5) & q9_4 == `option'
        local category_n = r(N)
        display as text "q9_4 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_5 | En el último mes en que recibió remesas, ¿quién guardó o administró la mayor parte de ese dinero?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_5 == `state'
    display as text "q9_5 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_5 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_5 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_5 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_5, 1, 5)
    local recorded_n = r(N)
    display as text "q9_5 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_5, 1, 5) & q9_5 == `option'
        local category_n = r(N)
        display as text "q9_5 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_6 | Si usted quisiera destinar parte de la remesa a ahorro o a su negocio, ¿podría hacerlo sin pedir permiso a otra persona?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_6 == `state'
    display as text "q9_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_6, 1, 5)
    local recorded_n = r(N)
    display as text "q9_6 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_6, 1, 5) & q9_6 == `option'
        local category_n = r(N)
        display as text "q9_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_7 | En general, me siento en control de mi dinero y de las decisiones sobre las remesas.
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_7 == `state'
    display as text "q9_7 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q9_7 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_7 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_7 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_7, 1, 5)
    local recorded_n = r(N)
    display as text "q9_7 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_7, 1, 5) & q9_7 == `option'
        local category_n = r(N)
        display as text "q9_7 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_8 | En los últimos 12 meses, ¿alguna persona le pidió ver su teléfono o sus códigos (PIN/OTP) para manejar la remesa en contra de su voluntad?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_8 == `state'
    display as text "q9_8 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_8 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_8 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_8 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_8, 1, 5)
    local recorded_n = r(N)
    display as text "q9_8 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_8, 1, 5) & q9_8 == `option'
        local category_n = r(N)
        display as text "q9_8 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_9 | Si pudiera elegir libremente, ¿a nombre de quién preferiría que estuviera la cuenta o billetera donde entra la remesa?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_9 == `state'
    display as text "q9_9 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_9 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_9 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_9 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_9, 1, 5)
    local recorded_n = r(N)
    display as text "q9_9 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_9, 1, 5) & q9_9 == `option'
        local category_n = r(N)
        display as text "q9_9 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_11 | En su hogar, ¿quién suele decidir sobre su atención de salud (visitas a médico, exámenes, tratamientos)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_11 == `state'
    display as text "q9_11 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_11 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_11 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_11 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_11, 1, 5)
    local recorded_n = r(N)
    display as text "q9_11 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_11, 1, 5) & q9_11 == `option'
        local category_n = r(N)
        display as text "q9_11 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_13 | En su hogar, ¿quién toma la decisión sobre los gastos importantes del hogar (por ejemplo, electrodomésticos, arriendo, matrículas)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_13 == `state'
    display as text "q9_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_13, 1, 5)
    local recorded_n = r(N)
    display as text "q9_13 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_13, 1, 5) & q9_13 == `option'
        local category_n = r(N)
        display as text "q9_13 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_16 | En los últimos 12 meses, ¿ha sentido presión de alguien para entregar todo el dinero de la remesa o mostrar sus movimientos cuando usted no quería?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_16 == `state'
    display as text "q9_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_16, 1, 5)
    local recorded_n = r(N)
    display as text "q9_16 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_16, 1, 5) & q9_16 == `option'
        local category_n = r(N)
        display as text "q9_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_18 | En general, siento que mi opinión sobre el uso de la remesa es escuchada y respetada en mi hogar.
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_18 == `state'
    display as text "q9_18 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q9_18 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_18 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_18 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_18, 1, 5)
    local recorded_n = r(N)
    display as text "q9_18 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_18, 1, 5) & q9_18 == `option'
        local category_n = r(N)
        display as text "q9_18 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_19 | Si usted quisiera abrir una nueva cuenta o cambiar la cuenta donde llega la remesa, ¿podría decidirlo?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_19 == `state'
    display as text "q9_19 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_19 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_19 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_19 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_19, 1, 5)
    local recorded_n = r(N)
    display as text "q9_19 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_19, 1, 5) & q9_19 == `option'
        local category_n = r(N)
        display as text "q9_19 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_20 | ¿Ha evitado usar pagos digitales o aplicaciones por miedo a conflictos o discusiones dentro del hogar?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_20 == `state'
    display as text "q9_20 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_20 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_20 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_20 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_20, 1, 5)
    local recorded_n = r(N)
    display as text "q9_20 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_20, 1, 5) & q9_20 == `option'
        local category_n = r(N)
        display as text "q9_20 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN ICPF

* ITEM q9_1 | Confío en que mi proveedor principal de pagos o cuenta mantendrá mi dinero seguro.
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_1 == `state'
    display as text "q9_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q9_1 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_1 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_1 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_1, 1, 5)
    local recorded_n = r(N)
    display as text "q9_1 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_1, 1, 5) & q9_1 == `option'
        local category_n = r(N)
        display as text "q9_1 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_15 | En mi hogar, se considera apropiado que las mujeres usen pagos digitales (app, QR, transferencias).
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_15 == `state'
    display as text "q9_15 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q9_15 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_15 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_15 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_15, 1, 5)
    local recorded_n = r(N)
    display as text "q9_15 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_15, 1, 5) & q9_15 == `option'
        local category_n = r(N)
        display as text "q9_15 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q9_17 | Si usted rechaza compartir su PIN/OTP o su teléfono para manejar la remesa, ¿qué podría ocurrir en su hogar?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_17 == `state'
    display as text "q9_17 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_17 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_17 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_17 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_17, 1, 5)
    local recorded_n = r(N)
    display as text "q9_17 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        if `option' == 98 {
            quietly count if formdef_version == `fv' & wp07_state_q9_17 == 5 & ///
                strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0
            local refusal_n = r(N)
            display as text "q9_17 refusal N: " as result `refusal_n'
            if `recorded_n' > 0 {
                display as text "Percent all recorded parents refusing: " as result 100 * `refusal_n' / ///
                    `recorded_n'
            }
        }
        else {
            quietly count if formdef_version == `fv' & wp07_state_q9_17 == 1 & ///
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

* ITEM q9_21 | ¿Qué cambios harían más seguro para usted usar pagos digitales y evitar conflictos en el hogar?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_21 == `state'
    display as text "q9_21 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q9_21 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_21 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_21 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_21, 1, 5)
    local recorded_n = r(N)
    display as text "q9_21 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & wp07_state_q9_21 == 1 & ///
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

* ITEM q9_22 | En su comunidad, ¿la mayoría cree que las mujeres deben poder decidir sobre el uso de las remesas del hogar?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q9_22 == `state'
    display as text "q9_22 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q9_22 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_22 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q9_22 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q9_22, 1, 5)
    local recorded_n = r(N)
    display as text "q9_22 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q9_22, 1, 5) & q9_22 == `option'
        local category_n = r(N)
        display as text "q9_22 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}


* ============================================================================
* DOMAIN IEH

* ITEM q10_4 | En general, ¿cuánta información siente que tiene sobre comisiones, tipos de cambio y qué hacer si tiene un problema con un pago digital o remesa?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q10_4 == `state'
    display as text "q10_4 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4"
    quietly count if formdef_version == `fv' & wp07_route_q10_4 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_4 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_4 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q10_4, 1, 5)
    local recorded_n = r(N)
    display as text "q10_4 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q10_4, 1, 5) & q10_4 == `option'
        local category_n = r(N)
        display as text "q10_4 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q10_6 | Pensando en los puntos donde retira efectivo (cash-out) cerca de su casa o trabajo, ¿cómo describiría el tiempo y el costo adicional para retirar dinero que llega de forma digital?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q10_6 == `state'
    display as text "q10_6 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 98"
    quietly count if formdef_version == `fv' & wp07_route_q10_6 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_6 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_6 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q10_6, 1, 5)
    local recorded_n = r(N)
    display as text "q10_6 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q10_6, 1, 5) & q10_6 == `option'
        local category_n = r(N)
        display as text "q10_6 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q10_10 | En los últimos 3 años, ¿participó en alguna capacitación sobre pagos digitales, remesas, billeteras o seguridad en línea?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q10_10 == `state'
    display as text "q10_10 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 98"
    quietly count if formdef_version == `fv' & wp07_route_q10_10 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_10 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_10 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q10_10, 1, 5)
    local recorded_n = r(N)
    display as text "q10_10 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q10_10, 1, 5) & q10_10 == `option'
        local category_n = r(N)
        display as text "q10_10 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q10_11 | ¿Quién organizó la capacitación más reciente a la que asistió?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q10_11 == `state'
    display as text "q10_11 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q10_11 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_11 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_11 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q10_11, 1, 5)
    local recorded_n = r(N)
    display as text "q10_11 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q10_11, 1, 5) & q10_11 == `option'
        local category_n = r(N)
        display as text "q10_11 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q10_12 | Después de esa capacitación, ¿cómo cambió su disposición a usar pagos digitales o remesas por app?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q10_12 == `state'
    display as text "q10_12 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5"
    quietly count if formdef_version == `fv' & wp07_route_q10_12 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_12 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_12 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q10_12, 1, 5)
    local recorded_n = r(N)
    display as text "q10_12 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q10_12, 1, 5) & q10_12 == `option'
        local category_n = r(N)
        display as text "q10_12 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q10_13 | En los últimos 12 meses, ¿recibió acompañamiento individual para usar pagos digitales o remesas? (por ejemplo, alguien que le ayudó a instalar una app, abrir cuenta, activar QR o hacer sus primeras operaciones)
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q10_13 == `state'
    display as text "q10_13 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "0 1 98"
    quietly count if formdef_version == `fv' & wp07_route_q10_13 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_13 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_13 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q10_13, 1, 5)
    local recorded_n = r(N)
    display as text "q10_13 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q10_13, 1, 5) & q10_13 == `option'
        local category_n = r(N)
        display as text "q10_13 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q10_14 | ¿Quién le brindó ese acompañamiento individual la última vez?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q10_14 == `state'
    display as text "q10_14 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6"
    quietly count if formdef_version == `fv' & wp07_route_q10_14 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_14 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_14 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q10_14, 1, 5)
    local recorded_n = r(N)
    display as text "q10_14 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q10_14, 1, 5) & q10_14 == `option'
        local category_n = r(N)
        display as text "q10_14 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q10_16 | En los últimos 12 meses, ¿con qué frecuencia ha visto o usado materiales (folletos, videos, mensajes por WhatsApp, redes sociales) sobre fraudes y uso seguro de pagos digitales?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q10_16 == `state'
    display as text "q10_16 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 98"
    quietly count if formdef_version == `fv' & wp07_route_q10_16 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_16 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_16 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q10_16, 1, 5)
    local recorded_n = r(N)
    display as text "q10_16 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q10_16, 1, 5) & q10_16 == `option'
        local category_n = r(N)
        display as text "q10_16 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* Shared q10_4, q10_6 and q10_16 are reported once under IEH.


* ============================================================================
* DOMAIN IBPD

* ITEM q10_1 | ¿Cuál diría que es el principal motivo por el cual no usa más pagos digitales (o no los usa en absoluto)?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q10_1 == `state'
    display as text "q10_1 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 8 9 10 11 12 14 15 16 98"
    if `fv' == 2512090157 {
        local options "1 2 3 4 5 6 7 8 9 10 11"
    }
    quietly count if formdef_version == `fv' & wp07_route_q10_1 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_1 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_1 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q10_1, 1, 5)
    local recorded_n = r(N)
    display as text "q10_1 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Recorded-answer percentages retain offered sentinels as explicit categories.
    * They are not percentages of all sampled women or estimates of population prevalence.
    foreach option of local options {
        quietly count if formdef_version == `fv' & inlist(wp07_state_q10_1, 1, 5) & q10_1 == `option'
        local category_n = r(N)
        display as text "q10_1 category " `option' " N: " as result `category_n'
        if `recorded_n' > 0 {
            display as text "Percent recorded answers (sentinels included): " as result 100 * `category_n' / ///
                `recorded_n'
        }
    }
    if `recorded_n' == 0 {
        display as text "No recorded applicable answers in this version; percentages undefined."
    }
}

* ITEM q10_2 | Además de esa razón principal, ¿qué otras dificultades o barreras siente que enfrenta para usar pagos digitales?
* Full admitted denominator includes all six states, even unasked/unresolved cases.
foreach state in 1 2 3 4 5 6 {
    quietly count if wp07_state_q10_2 == `state'
    display as text "q10_2 response state " `state' " N / admitted: " as result r(N) " / " `admitted_n'
}
* Categories/options are interpreted within the actual form version.
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    local options "1 2 3 4 5 6 7 8 9 10 11 12 14 15 16 98"
    if `fv' == 2512090157 {
        local options "2 3 4 5 6 7 8 9 10 11 12 14 15 16 98"
    }
    quietly count if formdef_version == `fv' & wp07_route_q10_2 == 1
    local applicable_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_2 == 1
    local regular_n = r(N)
    quietly count if formdef_version == `fv' & wp07_state_q10_2 == 5
    local sentinel_n = r(N)
    quietly count if formdef_version == `fv' & inlist(wp07_state_q10_2, 1, 5)
    local recorded_n = r(N)
    display as text "q10_2 version `fv': applicable / ordinary / sentinel / recorded" as result " " ///
        `applicable_n' " / " `regular_n' " / " `sentinel_n' " / " `recorded_n'
    * Percent selecting an offered option uses ordinary valid parent responses.
    * Item-specific sentinels use recorded-parent N when offered; no parent strings are printed.
    * Multiple-response percentages may exceed 100; unselected does not prove absence.
    foreach option of local options {
        if `option' == 98 {
            quietly count if formdef_version == `fv' & wp07_state_q10_2 == 5 & ///
                strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0
            local refusal_n = r(N)
            display as text "q10_2 refusal N: " as result `refusal_n'
            if `recorded_n' > 0 {
                display as text "Percent all recorded parents refusing: " as result 100 * `refusal_n' / ///
                    `recorded_n'
            }
        }
        else {
            quietly count if formdef_version == `fv' & wp07_state_q10_2 == 1 & ///
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
    q10_1 == 16 & wp07_state_q10_2 == 1 & ///
    regexm(itrim(strtrim(q10_2)), "(^| )(1|2|3|4|5|6|7|8|9|10|11|12|14|15)( |$)")
display as text "Main None with valid additional named barriers (review, no repair) N: " as result r(N)

* No output files, participant records, scores, model objects or class labels are written.

* ============================================================================
* CANDIDATES: own nonmissing N and fixed-component/common-observation coverage

* CANDIDATE wp07_ivs_educ
* Education component only; not normalized IVS or continuous tenure
confirm numeric variable wp07_ivs_educ, exact
assert missing(wp07_ivs_educ) | inrange(wp07_ivs_educ, 0, 1)
quietly count if !missing(wp07_ivs_educ)
local summary_n = r(N)
display as text "Education component nonmissing N / admitted (not an IVS composite): " as result `summary_n' ///
    " / " `admitted_n'
if `summary_n' > 0 {
    tabstat wp07_ivs_educ, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iat3
* Fixed three-item candidate; financial-use content overlap remains
confirm numeric variable wp07_iat3 wp07_iat_phone wp07_iat_internet wp07_iat_runout, exact
assert missing(wp07_iat3) | inrange(wp07_iat3, 0, 1)
assert missing(wp07_iat_phone) | inrange(wp07_iat_phone, 0, 1)
assert missing(wp07_iat_internet) | inrange(wp07_iat_internet, 0, 1)
assert missing(wp07_iat_runout) | inrange(wp07_iat_runout, 0, 1)
quietly count if !missing(wp07_iat_phone, wp07_iat_internet, wp07_iat_runout)
local component_n = r(N)
quietly count if !missing(wp07_iat3)
local summary_n = r(N)
display as text "wp07_iat3 complete components / nonmissing summary / admitted: " as result `component_n' ///
    " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iat3) & !missing(wp07_iat_phone, wp07_iat_internet, wp07_iat_runout)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iat3) & missing(wp07_iat_phone, wp07_iat_internet, wp07_iat_runout)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iat3, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iadt2
* Two fixed components; phone applicability remains
confirm numeric variable wp07_iadt2 wp07_iadt_transfer wp07_iadt_confidence, exact
assert missing(wp07_iadt2) | inrange(wp07_iadt2, 0, 1)
assert missing(wp07_iadt_transfer) | inrange(wp07_iadt_transfer, 0, 1)
assert missing(wp07_iadt_confidence) | inrange(wp07_iadt_confidence, 0, 1)
quietly count if !missing(wp07_iadt_transfer, wp07_iadt_confidence)
local component_n = r(N)
quietly count if !missing(wp07_iadt2)
local summary_n = r(N)
display as text "wp07_iadt2 complete components / nonmissing summary / admitted: " as result `component_n' ///
    " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iadt2) & !missing(wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iadt2) & missing(wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iadt2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iadt3
* Smartphone-only app component; compare on common observations separately
confirm numeric variable wp07_iadt3 wp07_iadt_app wp07_iadt_transfer wp07_iadt_confidence, exact
assert missing(wp07_iadt3) | inrange(wp07_iadt3, 0, 1)
assert missing(wp07_iadt_app) | inrange(wp07_iadt_app, 0, 1)
assert missing(wp07_iadt_transfer) | inrange(wp07_iadt_transfer, 0, 1)
assert missing(wp07_iadt_confidence) | inrange(wp07_iadt_confidence, 0, 1)
quietly count if !missing(wp07_iadt_app, wp07_iadt_transfer, wp07_iadt_confidence)
local component_n = r(N)
quietly count if !missing(wp07_iadt3)
local summary_n = r(N)
display as text "wp07_iadt3 complete components / nonmissing summary / admitted: " as result `component_n' ///
    " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iadt3) & !missing(wp07_iadt_app, wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iadt3) & missing(wp07_iadt_app, wp07_iadt_transfer, wp07_iadt_confidence)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iadt3, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_icdp2
* Both valid applicable OTP/PIN components; unfamiliarity/nonuse not zero
confirm numeric variable wp07_icdp2 wp07_icdp_otp wp07_icdp_pin, exact
assert missing(wp07_icdp2) | inrange(wp07_icdp2, 0, 1)
assert missing(wp07_icdp_otp) | inrange(wp07_icdp_otp, 0, 1)
assert missing(wp07_icdp_pin) | inrange(wp07_icdp_pin, 0, 1)
quietly count if !missing(wp07_icdp_otp, wp07_icdp_pin)
local component_n = r(N)
quietly count if !missing(wp07_icdp2)
local summary_n = r(N)
display as text "wp07_icdp2 complete components / nonmissing summary / admitted: " as result `component_n' ///
    " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_icdp2) & !missing(wp07_icdp_otp, wp07_icdp_pin)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_icdp2) & missing(wp07_icdp_otp, wp07_icdp_pin)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_icdp2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iaff2
* Two specific administrative conditions, not comprehensive formal inclusion
confirm numeric variable wp07_iaff2 wp07_iaff_address wp07_iaff_phone, exact
assert missing(wp07_iaff2) | inrange(wp07_iaff2, 0, 1)
assert missing(wp07_iaff_address) | inrange(wp07_iaff_address, 0, 1)
assert missing(wp07_iaff_phone) | inrange(wp07_iaff_phone, 0, 1)
quietly count if !missing(wp07_iaff_address, wp07_iaff_phone)
local component_n = r(N)
quietly count if !missing(wp07_iaff2)
local summary_n = r(N)
display as text "wp07_iaff2 complete components / nonmissing summary / admitted: " as result `component_n' ///
    " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iaff2) & !missing(wp07_iaff_address, wp07_iaff_phone)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iaff2) & missing(wp07_iaff_address, wp07_iaff_phone)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iaff2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iuof3
* Accepted 1/.75/.5/.25/0 frequency map with fixed components
confirm numeric variable wp07_iuof3 wp07_iuof_frequency wp07_iuof_merchant wp07_iuof_saving, exact
assert missing(wp07_iuof3) | inrange(wp07_iuof3, 0, 1)
assert missing(wp07_iuof_frequency) | inrange(wp07_iuof_frequency, 0, 1)
assert missing(wp07_iuof_merchant) | inrange(wp07_iuof_merchant, 0, 1)
assert missing(wp07_iuof_saving) | inrange(wp07_iuof_saving, 0, 1)
quietly count if !missing(wp07_iuof_frequency, wp07_iuof_merchant, wp07_iuof_saving)
local component_n = r(N)
quietly count if !missing(wp07_iuof3)
local summary_n = r(N)
display as text "wp07_iuof3 complete components / nonmissing summary / admitted: " as result `component_n' ///
    " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iuof3) & !missing(wp07_iuof_frequency, wp07_iuof_merchant, wp07_iuof_saving)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iuof3) & missing(wp07_iuof_frequency, wp07_iuof_merchant, wp07_iuof_saving)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iuof3, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iuof3_oldmap
* Declared historical frequency-spacing sensitivity, not automatic replacement
confirm numeric variable wp07_iuof3_oldmap wp07_iuof_frequency_oldmap wp07_iuof_merchant wp07_iuof_saving, exact
assert missing(wp07_iuof3_oldmap) | inrange(wp07_iuof3_oldmap, 0, 1)
assert missing(wp07_iuof_frequency_oldmap) | inrange(wp07_iuof_frequency_oldmap, 0, 1)
assert missing(wp07_iuof_merchant) | inrange(wp07_iuof_merchant, 0, 1)
assert missing(wp07_iuof_saving) | inrange(wp07_iuof_saving, 0, 1)
quietly count if !missing(wp07_iuof_frequency_oldmap, wp07_iuof_merchant, wp07_iuof_saving)
local component_n = r(N)
quietly count if !missing(wp07_iuof3_oldmap)
local summary_n = r(N)
display as text "wp07_iuof3_oldmap complete components / nonmissing summary / admitted: " as result ///
    `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iuof3_oldmap) & !missing(wp07_iuof_frequency_oldmap, wp07_iuof_merchant, ///
    wp07_iuof_saving)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iuof3_oldmap) & missing(wp07_iuof_frequency_oldmap, wp07_iuof_merchant, ///
    wp07_iuof_saving)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iuof3_oldmap, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_iuof2_no_frequency
* Frequency-omission definition, not available-item fallback
confirm numeric variable wp07_iuof2_no_frequency wp07_iuof_merchant wp07_iuof_saving, exact
assert missing(wp07_iuof2_no_frequency) | inrange(wp07_iuof2_no_frequency, 0, 1)
assert missing(wp07_iuof_merchant) | inrange(wp07_iuof_merchant, 0, 1)
assert missing(wp07_iuof_saving) | inrange(wp07_iuof_saving, 0, 1)
quietly count if !missing(wp07_iuof_merchant, wp07_iuof_saving)
local component_n = r(N)
quietly count if !missing(wp07_iuof2_no_frequency)
local summary_n = r(N)
display as text "wp07_iuof2_no_frequency complete components / nonmissing summary / admitted: " as result ///
    `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_iuof2_no_frequency) & !missing(wp07_iuof_merchant, wp07_iuof_saving)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_iuof2_no_frequency) & missing(wp07_iuof_merchant, wp07_iuof_saving)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_iuof2_no_frequency, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_oqi2
* Registration ease and offered initial support; activation separate
confirm numeric variable wp07_oqi2 wp07_oqi_ease wp07_oqi_support, exact
assert missing(wp07_oqi2) | inrange(wp07_oqi2, 0, 1)
assert missing(wp07_oqi_ease) | inrange(wp07_oqi_ease, 0, 1)
assert missing(wp07_oqi_support) | inrange(wp07_oqi_support, 0, 1)
quietly count if !missing(wp07_oqi_ease, wp07_oqi_support)
local component_n = r(N)
quietly count if !missing(wp07_oqi2)
local summary_n = r(N)
display as text "wp07_oqi2 complete components / nonmissing summary / admitted: " as result `component_n' ///
    " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_oqi2) & !missing(wp07_oqi_ease, wp07_oqi_support)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_oqi2) & missing(wp07_oqi_ease, wp07_oqi_support)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_oqi2, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* CANDIDATE wp07_oqi2_oldmap
* Declared historical ease-spacing sensitivity
confirm numeric variable wp07_oqi2_oldmap wp07_oqi_ease_oldmap wp07_oqi_support, exact
assert missing(wp07_oqi2_oldmap) | inrange(wp07_oqi2_oldmap, 0, 1)
assert missing(wp07_oqi_ease_oldmap) | inrange(wp07_oqi_ease_oldmap, 0, 1)
assert missing(wp07_oqi_support) | inrange(wp07_oqi_support, 0, 1)
quietly count if !missing(wp07_oqi_ease_oldmap, wp07_oqi_support)
local component_n = r(N)
quietly count if !missing(wp07_oqi2_oldmap)
local summary_n = r(N)
display as text "wp07_oqi2_oldmap complete components / nonmissing summary / admitted: " as result ///
    `component_n' " / " `summary_n' " / " `admitted_n'
quietly count if missing(wp07_oqi2_oldmap) & !missing(wp07_oqi_ease_oldmap, wp07_oqi_support)
display as text "Complete components but summary missing (review, no repair): " as result r(N)
quietly count if !missing(wp07_oqi2_oldmap) & missing(wp07_oqi_ease_oldmap, wp07_oqi_support)
display as text "Summary present despite missing component (review, no repair): " as result r(N)
if `summary_n' > 0 {
    tabstat wp07_oqi2_oldmap, statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}
if `summary_n' == 0 {
    display as text "No nonmissing candidate; summary statistics undefined, not zero."
}

* COMMON_SAMPLE IADT_TWO_VS_THREE: Definition and applicability comparison, not simple rescaling
quietly count if !missing(wp07_iadt2, wp07_iadt3)
local common_n = r(N)
display as text "IADT_TWO_VS_THREE common nonmissing N / admitted: " as result `common_n' " / " `admitted_n'
if `common_n' > 0 {
    tabstat wp07_iadt2 wp07_iadt3 if !missing(wp07_iadt2, wp07_iadt3), ///
        statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}

* COMMON_SAMPLE IUOF_FREQUENCY_DEFINITIONS: Compare all three on their common observations; retain broader own-N reports above
quietly count if !missing(wp07_iuof3, wp07_iuof3_oldmap, wp07_iuof2_no_frequency)
local common_n = r(N)
display as text "IUOF_FREQUENCY_DEFINITIONS common nonmissing N / admitted: " as result `common_n' " / " ///
    `admitted_n'
if `common_n' > 0 {
    tabstat wp07_iuof3 wp07_iuof3_oldmap wp07_iuof2_no_frequency if !missing(wp07_iuof3, wp07_iuof3_oldmap, ///
        wp07_iuof2_no_frequency), ///
        statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}

* COMMON_SAMPLE OQI_EASE_SPACING: Declared ease-spacing definitions on the same nonmissing observations
quietly count if !missing(wp07_oqi2, wp07_oqi2_oldmap)
local common_n = r(N)
display as text "OQI_EASE_SPACING common nonmissing N / admitted: " as result `common_n' " / " `admitted_n'
if `common_n' > 0 {
    tabstat wp07_oqi2 wp07_oqi2_oldmap if !missing(wp07_oqi2, wp07_oqi2_oldmap), ///
        statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)
}

* The two accepted primary binary contrasts retain separate valid-answer denominators.
confirm numeric variable wp07_remit_disposition wp07_remit_any_digital wp07_domestic_60d ///
    wp07_domestic_ops_bin, exact
assert missing(wp07_remit_disposition) | inlist(wp07_remit_disposition, 1, 2, 3, 4, 5)
assert missing(wp07_remit_any_digital) | inlist(wp07_remit_any_digital, 0, 1)
assert missing(wp07_domestic_60d) | inlist(wp07_domestic_60d, 0, 1)
assert missing(wp07_domestic_ops_bin) | inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5, 98)
* Prepared-field reports consume their own nonmissing values, without claiming route validation.
quietly count if !missing(wp07_remit_disposition)
local remit_n = r(N)
quietly count if !missing(wp07_remit_any_digital)
local remit_binary_n = r(N)
quietly count if !missing(wp07_domestic_60d)
local domestic_n = r(N)
display as text "Remittance categories / binary / domestic binary / admitted: " as result `remit_n' " / " ///
    `remit_binary_n' " / " `domestic_n' " / " `admitted_n'
if `remit_n' > 0 {
    tabulate wp07_remit_disposition, nolabel
}
if `remit_binary_n' > 0 {
    tabulate wp07_remit_any_digital, nolabel
}
if `domestic_n' > 0 {
    tabulate wp07_domestic_60d, nolabel
}
* Bin uncertainty is a valid recorded category, but not a substantive operation bin.
quietly count if wp07_domestic_60d == 1
local users_n = r(N)
quietly count if wp07_domestic_60d == 1 & inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5)
local bins_n = r(N)
quietly count if wp07_domestic_60d == 1 & wp07_domestic_ops_bin == 98
local unknown_bins_n = r(N)
* Missing derived bins alone cannot distinguish an absent answer from an invalid one.
quietly count if wp07_domestic_60d == 1 & wp07_state_q6_15 == 4
local missing_bins_n = r(N)
quietly count if wp07_domestic_60d == 1 & wp07_state_q6_15 == 6
local unresolved_bins_n = r(N)
display as text "Affirmative users / valid bins / uncertainty / nonresponse / unresolved: " ///
    as result `users_n' " / " `bins_n' " / " `unknown_bins_n' " / " ///
    `missing_bins_n' " / " `unresolved_bins_n'
forvalues category = 1/5 {
    quietly count if wp07_domestic_60d == 1 & wp07_domestic_ops_bin == `category'
    local category_n = r(N)
    display as text "Operation bin " `category' " N: " as result `category_n'
    if `bins_n' > 0 {
        display as text "Percent valid operation bins: " as result 100 * `category_n' / `bins_n'
    }
}
* No change to scores, labels, rows, historical outputs or Appendix C2.

* ============================================================================
* NOMINATED MODEL INPUTS: nonmissing screens, not estimated model samples

* Exact prepared input in memory. No loading, scoring, filtering or output file.
confirm numeric variable formdef_version eligible_flag wp07_known_form, exact
confirm numeric variable q4 q2_2 q2_3 q2_1 wp07_residence, exact
confirm numeric variable wp07_iat3 wp07_iadt2 wp07_iaff2, exact
confirm numeric variable wp07_remit_disposition, exact
confirm numeric variable wp07_remit_any_digital wp07_domestic_60d, exact

* Verify the declared representation, not its scientific validity.
assert missing(wp07_iat3) | inrange(wp07_iat3, 0, 1)
assert missing(wp07_iadt2) | inrange(wp07_iadt2, 0, 1)
assert missing(wp07_iaff2) | inlist(wp07_iaff2, 0, .5, 1)
assert missing(wp07_remit_disposition) | ///
    inlist(wp07_remit_disposition, 1, 2, 3, 4, 5)
assert missing(wp07_remit_any_digital) | ///
    inlist(wp07_remit_any_digital, 0, 1)
assert missing(wp07_domestic_60d) | inlist(wp07_domestic_60d, 0, 1)
assert missing(wp07_remit_disposition) == missing(wp07_remit_any_digital)
assert wp07_remit_any_digital == (wp07_remit_disposition != 1) ///
    if !missing(wp07_remit_disposition)

* Every admitted row remains present. These are prospective restricted readouts.
count
display as text "Retained prepared rows; not a universal denominator: " r(N)
count if wp07_known_form != 1
display as text "Unknown or missing submitted-version status: " r(N)
count if eligible_flag != 1
display as text "Historical screening disagreement; no new exclusion: " r(N)

* Outcome support remains separate for the two questions and reference periods.
tabulate wp07_remit_disposition, missing
tabulate wp07_remit_any_digital, missing
tabulate wp07_domestic_60d, missing

* These counts are nonmissing-field screens, NOT certified model samples.
* They do not establish route validity, support, independence or estimability.
count if !missing(wp07_remit_any_digital, wp07_iat3, wp07_iadt2, ///
    wp07_iaff2, q4, q2_2, wp07_residence)
display as text "Remittance core nomination, nonmissing inputs only: " r(N)
count if !missing(wp07_domestic_60d, wp07_iat3, wp07_iadt2, ///
    wp07_iaff2, q4, q2_2, wp07_residence)
display as text "Domestic core nomination, nonmissing inputs only: " r(N)
count if !missing(wp07_remit_any_digital, wp07_iat3, wp07_iadt2, ///
    wp07_iaff2, q4, q2_2, wp07_residence, q2_3, q2_1)
display as text "Remittance extension, calendar input not yet resolved: " r(N)
count if !missing(wp07_domestic_60d, wp07_iat3, wp07_iadt2, ///
    wp07_iaff2, q4, q2_2, wp07_residence, q2_3, q2_1)
display as text "Domestic extension, calendar input not yet resolved: " r(N)

* Check raw covariate domains explicitly; never repair or drop an answer here.
count if !missing(q4) & (!inrange(q4, 18, 100) | q4 != floor(q4))
display as text "Age outside the instrument's integer 18-100 domain: " r(N)
count if !missing(q2_2) & ///
    (!inrange(q2_2, 1, 10) | q2_2 != floor(q2_2))
display as text "Education outside the ten offered codes: " r(N)
count if !missing(q2_3) & ///
    (!inrange(q2_3, 1, 9) | q2_3 != floor(q2_3))
display as text "Occupation outside the nine offered codes: " r(N)
count if !missing(q2_1) & ///
    (!inrange(q2_1, 1950, 2026) | q2_1 != floor(q2_1))
display as text "Arrival year outside the retained form's domain: " r(N)

* Code 5 is completed secondary education; code 3 is employee/worker.
* These are overall support counts, not support within an estimated model.
count if q2_2 == 5
display as text "Proposed education reference, full prepared stage: " r(N)
count if wp07_residence == 1
display as text "Proposed Bogota reference, full prepared stage: " r(N)
count if q2_3 == 3
display as text "Proposed occupation reference, full prepared stage: " r(N)

* Preserve Other/Soacha/Meta meanings by version. Small cells remain restricted.
tabulate wp07_residence formdef_version, missing
tabulate q2_2, missing
tabulate q2_3, missing

* Do not derive tenure from the current year or change any historical clock.
count if missing(q2_1)
display as text "Missing first-arrival calendar input: " r(N)

* No VCE, logit, margins, p-values, weights or LCA choices are made here.
* Joint support and covariate-domain review must precede any fit manifest.

* ============================================================================
* ASSOCIATION COMPARISON: declared IAT/IADT candidates only, not all-domain Pearson
* These are descriptive score associations, not latent-construct validity or effects.

confirm numeric variable wp07_iat3 wp07_iadt2 wp07_iadt3, exact
assert missing(wp07_iadt3) | !missing(wp07_iadt2)

* Each pair uses its own observed base. Constants have no correlation coefficient.
foreach skill in wp07_iadt2 wp07_iadt3 {
    quietly count if !missing(wp07_iat3, `skill')
    local pair_n = r(N)
    display as text "IAT and `skill', pair-complete N: " `pair_n'
    quietly summarize wp07_iat3 if !missing(wp07_iat3, `skill'), meanonly
    local iat_varies = r(min) < r(max)
    quietly summarize `skill' if !missing(wp07_iat3, `skill'), meanonly
    local skill_varies = r(min) < r(max)
    if `pair_n' > 1 & `iat_varies' & `skill_varies' {
        correlate wp07_iat3 `skill' if !missing(wp07_iat3, `skill')
    }
    else {
        display as text "Coefficient unavailable: insufficient N or a constant field."
    }
}

* Compare definitions on the identical three-field complete sample.
quietly count if !missing(wp07_iat3, wp07_iadt2, wp07_iadt3)
local common_n = r(N)
display as text "IAT/IADT common-case N: " `common_n'
quietly summarize wp07_iat3 if !missing(wp07_iat3, wp07_iadt2, wp07_iadt3), meanonly
local common_iat_varies = r(min) < r(max)
foreach skill in wp07_iadt2 wp07_iadt3 {
    quietly summarize `skill' if !missing(wp07_iat3, wp07_iadt2, wp07_iadt3), meanonly
    local skill_varies = r(min) < r(max)
    if `common_n' > 1 & `common_iat_varies' & `skill_varies' {
        correlate wp07_iat3 `skill' if !missing(wp07_iat3, wp07_iadt2, wp07_iadt3)
    }
    else {
        display as text "Common-case IAT / `skill' coefficient unavailable: N or variance."
    }
}

* Preserve the between-definition association on that same common base as well.
quietly summarize wp07_iadt2 if !missing(wp07_iat3, wp07_iadt2, wp07_iadt3), meanonly
local iadt2_varies = r(min) < r(max)
quietly summarize wp07_iadt3 if !missing(wp07_iat3, wp07_iadt2, wp07_iadt3), meanonly
local iadt3_varies = r(min) < r(max)
if `common_n' > 1 & `iadt2_varies' & `iadt3_varies' {
    correlate wp07_iadt2 wp07_iadt3 if !missing(wp07_iat3, wp07_iadt2, wp07_iadt3)
}
else {
    display as text "Common-case IADT2 / IADT3 coefficient unavailable: N or variance."
}

* ============================================================================ 
* REGRESSION SPECIFICATIONS — nominated, not executable until remaining choices close
*
* R0: binary logit for wp07_remit_any_digital.
* D0: binary logit for wp07_domestic_60d.
* Both nominate c.wp07_iat3 c.wp07_iadt2 c.wp07_iaff2 c.q4 ///
*     ib5.q2_2 ib1.wp07_residence, each with its own valid joint observations.
* R1 and D1 add ib3.q2_3 and first-arrival calendar history.
* Calendar representation is unresolved; raw q2_1 is not an adopted tenure measure.
*
* Before a fit: observed support, separation, variance/dependence method,
* exact probability contrasts and nonestimable-test treatment must be resolved.
* No executable logit or margins call silently adopts those choices.
* Probability summaries would average over the stated model sample, not at means.
* IAFF's supported values are 0, .5 and 1; no automatic .1 transition is assumed.
*
* PRIMARY FAMILY: exactly six overall focal tests, three candidates x two core outcomes.
* Holm adjustment is accepted conditionally at 5%; no p-values are computed here.
* Retain all six planned slots if a test is unavailable; do not silently shrink the family.
* Pointwise 95% intervals are not simultaneous family-wise intervals.
*
* HISTORICAL REGRESSION/LCA RETIREMENT
* Do not call the old five-model, interaction, supplementary or class-regression grids.
* Preserve their evidence as historical comparisons, not current academic results.
* No automatic 15-score correlation matrix or Appendix C2 execution.
* ML01-ML05 still govern whether LCA is retained and its family, population,
* finite fit plan, identification and uncertainty-aware downstream interpretation.
* No alias for retired IURD/IEDF scores or default historical H1/k4 is constructed.
*
* No charts, fitted effects or statistical tables are exported without verified results.
* The actual exhibit producers are completed in Package E after numerical validation.

