* Exact E.3 aggregate definitions run on the reopened private candidate only.
version 16
args out
local admitted_n = _N
assert _N == 423
assert c(k) == 322
local accounted 0
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local accounted = `accounted' + r(N)
}
quietly count if wp07_known_form != 1
if `accounted' + r(N) != `admitted_n' {
    error 459
}

* Independent raw-code identities check the accepted component maps.
assert missing(wp07_ivs_educ) == (wp07_state_q2_2 != 1)
assert abs(wp07_ivs_educ - (10-q2_2)/9) < 1e-12 if wp07_state_q2_2 == 1
assert missing(wp07_iat_phone) == (wp07_state_q3_1 != 1)
assert wp07_iat_phone == (3-q3_1)/2 if wp07_state_q3_1 == 1
assert missing(wp07_iat_internet) == (wp07_state_q3_5 != 1)
assert wp07_iat_internet == (5-q3_5)/4 if wp07_state_q3_5 == 1
assert missing(wp07_iat_runout) == (wp07_state_q3_8 != 1)
assert wp07_iat_runout == (q3_8-1)/2 if wp07_state_q3_8 == 1
assert missing(wp07_iadt_app) == (wp07_state_q3_15 != 1)
assert wp07_iadt_app == (q3_15-1)/4 if wp07_state_q3_15 == 1
assert missing(wp07_iadt_transfer) == (wp07_state_q3_16 != 1)
assert wp07_iadt_transfer == (q3_16-1)/4 if wp07_state_q3_16 == 1
assert missing(wp07_iadt_confidence) == (wp07_state_q3_17 != 1)
assert wp07_iadt_confidence == (q3_17-1)/4 if wp07_state_q3_17 == 1
assert missing(wp07_icdp_otp) == (wp07_state_q3_21 != 1)
assert wp07_icdp_otp == (3-q3_21)/2 if wp07_state_q3_21 == 1
assert missing(wp07_icdp_pin) == (wp07_state_q3_22 != 1)
assert wp07_icdp_pin == 2-q3_22 if wp07_state_q3_22 == 1
assert missing(wp07_iaff_address) == (wp07_state_q4_5 != 1)
assert wp07_iaff_address == (q4_5 == 1) if wp07_state_q4_5 == 1
assert missing(wp07_iaff_phone) == (wp07_state_q4_6 != 1)
assert wp07_iaff_phone == (q4_6 == 1) if wp07_state_q4_6 == 1
assert missing(wp07_iuof_frequency) == (wp07_state_q4_15 != 1)
assert wp07_iuof_frequency == (5-q4_15)/4 if wp07_state_q4_15 == 1
assert missing(wp07_iuof_frequency_oldmap) == (wp07_state_q4_15 != 1)
assert abs(wp07_iuof_frequency_oldmap - cond(q4_15==5,0,1.2-.2*q4_15)) < 1e-12 ///
    if wp07_state_q4_15 == 1
assert missing(wp07_iuof_merchant) == (wp07_state_q4_24 != 1)
assert wp07_iuof_merchant == (3-q4_24)/2 if wp07_state_q4_24 == 1
assert missing(wp07_iuof_saving) == (wp07_state_q4_25 != 1)
assert wp07_iuof_saving == (3-q4_25)/2 if wp07_state_q4_25 == 1
assert missing(wp07_oqi_ease) == (wp07_state_q5_14 != 1)
assert abs(wp07_oqi_ease - (4-q5_14)/3) < 1e-12 if wp07_state_q5_14 == 1
assert missing(wp07_oqi_ease_oldmap) == (wp07_state_q5_14 != 1)
assert wp07_oqi_ease_oldmap == cond(q5_14==1,1,cond(q5_14==2,.75,cond(q5_14==3,.25,0))) ///
    if wp07_state_q5_14 == 1
assert missing(wp07_oqi_support) == (wp07_state_q5_23 != 1)
assert wp07_oqi_support == (3-q5_23)/2 if wp07_state_q5_23 == 1

* Fixed components must all be present; no available-item average or fallback.
assert missing(wp07_iat3) == missing(wp07_iat_phone,wp07_iat_internet,wp07_iat_runout)
assert missing(wp07_iadt2) == missing(wp07_iadt_transfer,wp07_iadt_confidence)
assert missing(wp07_iadt3) == missing(wp07_iadt_app,wp07_iadt_transfer,wp07_iadt_confidence)
assert missing(wp07_icdp2) == missing(wp07_icdp_otp,wp07_icdp_pin)
assert missing(wp07_iaff2) == missing(wp07_iaff_address,wp07_iaff_phone)
assert missing(wp07_iuof3) == missing(wp07_iuof_frequency,wp07_iuof_merchant,wp07_iuof_saving)
assert missing(wp07_iuof3_oldmap) == missing(wp07_iuof_frequency_oldmap,wp07_iuof_merchant,wp07_iuof_saving)
assert missing(wp07_iuof2_no_frequency) == missing(wp07_iuof_merchant,wp07_iuof_saving)
assert missing(wp07_oqi2) == missing(wp07_oqi_ease,wp07_oqi_support)
assert missing(wp07_oqi2_oldmap) == missing(wp07_oqi_ease_oldmap,wp07_oqi_support)
assert missing(wp07_iadt3) | !missing(wp07_iadt2)
assert abs(wp07_iat3-(wp07_iat_phone+wp07_iat_internet+wp07_iat_runout)/3) < 1e-12 if !missing(wp07_iat3)
assert abs(wp07_iadt2-(wp07_iadt_transfer+wp07_iadt_confidence)/2) < 1e-12 if !missing(wp07_iadt2)
assert abs(wp07_iadt3-(wp07_iadt_app+wp07_iadt_transfer+wp07_iadt_confidence)/3) < 1e-12 if !missing(wp07_iadt3)
assert abs(wp07_icdp2-(wp07_icdp_otp+wp07_icdp_pin)/2) < 1e-12 if !missing(wp07_icdp2)
assert abs(wp07_iaff2-(wp07_iaff_address+wp07_iaff_phone)/2) < 1e-12 if !missing(wp07_iaff2)
assert abs(wp07_iuof3-(wp07_iuof_frequency+wp07_iuof_merchant+wp07_iuof_saving)/3) < 1e-12 if !missing(wp07_iuof3)
assert abs(wp07_iuof3_oldmap-(wp07_iuof_frequency_oldmap+wp07_iuof_merchant+wp07_iuof_saving)/3) < 1e-12 if !missing(wp07_iuof3_oldmap)
assert abs(wp07_iuof2_no_frequency-(wp07_iuof_merchant+wp07_iuof_saving)/2) < 1e-12 if !missing(wp07_iuof2_no_frequency)
assert abs(wp07_oqi2-(wp07_oqi_ease+wp07_oqi_support)/2) < 1e-12 if !missing(wp07_oqi2)
assert abs(wp07_oqi2_oldmap-(wp07_oqi_ease_oldmap+wp07_oqi_support)/2) < 1e-12 if !missing(wp07_oqi2_oldmap)

* One ordinary loop applies the same coverage accounting to the 93 source items.
tempname coverage
file open `coverage' using "`out'/prepared_item_route_state_coverage.csv", write text
file write `coverage' "field,scope,scope_n,applicable_n,closed_n,unknown_route_n,ordinary_n,structural_n,unavailable_n,nonresponse_n,sentinel_n,unresolved_n,recorded_n" _n
local items q3_1 q3_5 q3_6 q3_7 q3_8 q3_12 q2_1 q2_2 q2_3 q4 q3 q3_15 q3_16 q3_17 q3_20 q3_21 q3_22 q3_23 q4_1 q4_5 q4_6 q4_12 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 q4_26 q4_27 q5_13 q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 q6_13 q6_14 q6_15 q6_6 q6_9 q6_11 q6_16 q6_17 q6_18 q6_20 q6_21 q6_22 q6_23 q6_24 q7_1 q7_2 q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 q7_11 q7_12 q7_13 q7_14 q7_15 q9_4 q9_5 q9_6 q9_7 q9_8 q9_9 q9_11 q9_13 q9_16 q9_18 q9_19 q9_20 q9_1 q9_15 q9_17 q9_21 q9_22 q10_4 q10_6 q10_10 q10_11 q10_12 q10_13 q10_14 q10_16 q10_1 q10_2
foreach item of local items {
    foreach scope in ALL 2512090157 2512091719 2512111044 2512121811 2602120658 UNKNOWN {
        local base "1"
        if "`scope'" == "UNKNOWN" {
            local base "wp07_known_form != 1"
        }
        else if "`scope'" != "ALL" {
            local base "formdef_version == `scope'"
        }
        count if `base'
        local scope_n = r(N)
        count if (`base') & wp07_route_`item' == 1
        local applicable_n = r(N)
        count if (`base') & wp07_route_`item' == 0
        local closed_n = r(N)
        count if (`base') & !inlist(wp07_route_`item', 0, 1)
        local unknown_route_n = r(N)
        forvalues state = 1/6 {
            count if (`base') & wp07_state_`item' == `state'
            local n`state' = r(N)
        }
        if `n1' + `n2' + `n3' + `n4' + `n5' + `n6' != `scope_n' | ///
            `applicable_n' + `closed_n' + `unknown_route_n' != `scope_n' {
            exit 459
        }
        local recorded_n = `n1' + `n5'
        file write `coverage' "`item',`scope'," (`scope_n') "," (`applicable_n') "," ///
            (`closed_n') "," (`unknown_route_n') "," (`n1') "," (`n2') "," (`n3') "," ///
            (`n4') "," (`n5') "," (`n6') "," (`recorded_n') _n
    }
}
file close `coverage'


* Summaries are provisional; means/ranges diagnose construction, not validity.
tempname measure
file open `measure' using "`out'/candidate_component_coverage.csv", write text
file write `measure' "kind,variable,admitted_n,nonmissing_n,unscored_n,minimum,maximum,mean,storage,limitation" _n
local components wp07_iat_phone wp07_iat_internet wp07_iat_runout wp07_iadt_app wp07_iadt_transfer wp07_iadt_confidence wp07_icdp_otp wp07_icdp_pin wp07_iaff_address wp07_iaff_phone wp07_iuof_frequency wp07_iuof_merchant wp07_iuof_saving wp07_iuof_frequency_oldmap wp07_oqi_ease wp07_oqi_support wp07_oqi_ease_oldmap
local candidates wp07_ivs_educ wp07_iat3 wp07_iadt2 wp07_iadt3 wp07_icdp2 ///
    wp07_iaff2 wp07_iuof3 wp07_iuof3_oldmap wp07_iuof2_no_frequency wp07_oqi2 wp07_oqi2_oldmap
foreach kind in component candidate {
    local variables "`components'"
    if "`kind'" == "candidate" {
        local variables "`candidates'"
    }
    foreach variable of local variables {
        local storage : type `variable'
        if "`storage'" != "double" {
            exit 459
        }
        assert missing(`variable') | inrange(`variable',0,1)
        summarize `variable', meanonly
        local n = r(N)
        local absent = `admitted_n' - `n'
        file write `measure' "`kind',`variable'," (`admitted_n') "," (`n') "," (`absent') "," ///
            %24.17g (r(min)) "," %24.17g (r(max)) "," %24.17g (r(mean)) ///
            ",`storage',Accepted map; not a validated scale" _n
    }
}
file close `measure'

* Three declared common-observation groups, retaining all own-N reports.
tempname comparisons
file open `comparisons' using "`out'/candidate_definition_comparisons.csv", write text
file write `comparisons' "group,definition,own_n,common_n,common_mean,common_min,common_max,status" _n
local definitions_iadt "wp07_iadt2 wp07_iadt3"
local definitions_iuof "wp07_iuof3 wp07_iuof3_oldmap wp07_iuof2_no_frequency"
local definitions_oqi "wp07_oqi2 wp07_oqi2_oldmap"
local common_iadt "!missing(wp07_iadt2,wp07_iadt3)"
local common_iuof "!missing(wp07_iuof3,wp07_iuof3_oldmap,wp07_iuof2_no_frequency)"
local common_oqi "!missing(wp07_oqi2,wp07_oqi2_oldmap)"
foreach group in iadt iuof oqi {
    count if `common_`group''
    local common_n = r(N)
    foreach definition of local definitions_`group' {
        count if !missing(`definition')
        local own_n = r(N)
        summarize `definition' if `common_`group'', meanonly
        file write `comparisons' "`group',`definition'," (`own_n') "," (`common_n') "," ///
            %24.17g (r(mean)) "," %24.17g (r(min)) "," %24.17g (r(max)) ///
            ",Definition comparison; not substitution or model selection" _n
    }
}
file close `comparisons'

* Two outcomes remain separate, and operation bins keep uncertainty.
assert missing(wp07_remit_disposition) == (wp07_state_q6_13 != 1)
assert wp07_remit_disposition == q6_13 if wp07_state_q6_13 == 1
assert missing(wp07_remit_any_digital) == missing(wp07_remit_disposition)
assert wp07_remit_any_digital == (q6_13 != 1) if wp07_state_q6_13 == 1
assert missing(wp07_domestic_60d) == (wp07_state_q6_14 != 1)
assert wp07_domestic_60d == q6_14 if wp07_state_q6_14 == 1
assert missing(wp07_domestic_ops_bin) == !inlist(wp07_state_q6_15,1,5)
assert wp07_domestic_ops_bin == q6_15 if inlist(wp07_state_q6_15,1,5)
assert missing(wp07_remit_disposition) | inrange(wp07_remit_disposition,1,5)
assert missing(wp07_remit_any_digital) | inlist(wp07_remit_any_digital,0,1)
assert missing(wp07_domestic_60d) | inlist(wp07_domestic_60d,0,1)
assert missing(wp07_domestic_ops_bin) | inlist(wp07_domestic_ops_bin,1,2,3,4,5,98)

tempname support
file open `support' using "`out'/outcome_model_input_support.csv", write text
file write `support' "nomination,check_id,field,category,base_n,observed_n,minimum,maximum,limitation" _n
foreach outcome in wp07_remit_disposition wp07_remit_any_digital wp07_domestic_60d wp07_domestic_ops_bin {
    count if !missing(`outcome')
    local valid_n = r(N)
    local codes "0 1"
    if "`outcome'" == "wp07_remit_disposition" {
        local codes "1 2 3 4 5"
    }
    if "`outcome'" == "wp07_domestic_ops_bin" {
        local codes "1 2 3 4 5 98"
    }
    foreach code of local codes {
        count if `outcome' == `code'
        file write `support' "OUTCOME,category,`outcome',`code'," (`valid_n') "," (r(N)) ///
            ",,,Own valid-answer base; no money-share interpretation" _n
    }
}
count if wp07_domestic_60d == 1
local users_n = r(N)
count if wp07_domestic_60d == 1 & inlist(wp07_domestic_ops_bin,1,2,3,4,5)
file write `support' "OUTCOME,substantive_operation_bins,q6_15,," (`users_n') "," (r(N)) ///
    ",,,Uncertainty98 is not a substantive bin" _n
foreach state in 2 4 5 6 {
    count if wp07_domestic_60d == 1 & wp07_state_q6_15 == `state'
    file write `support' "OUTCOME,operation_state,q6_15,`state'," (`users_n') "," (r(N)) ///
        ",,,Conditional on affirmative domestic participation" _n
}

* Readiness masks report prospective support; they never filter the cohort.
foreach model in R0 D0 R1 D1 {
    local outcome "wp07_remit_any_digital"
    if inlist("`model'","D0","D1") {
        local outcome "wp07_domestic_60d"
    }
    gen byte _e3_nonmissing_`model' = !missing(`outcome',wp07_iat3,wp07_iadt2, ///
        wp07_iaff2,q4,q2_2,wp07_residence)
    if inlist("`model'","R1","D1") {
        replace _e3_nonmissing_`model' = _e3_nonmissing_`model' & !missing(q2_3,q2_1)
    }
    gen byte _e3_domain_`model' = _e3_nonmissing_`model' & inrange(q4,18,100) & ///
        q4 == floor(q4) & inrange(q2_2,1,10) & q2_2 == floor(q2_2)
    if inlist("`model'","R1","D1") {
        replace _e3_domain_`model' = _e3_domain_`model' & inrange(q2_3,1,9) & ///
            q2_3 == floor(q2_3) & inrange(q2_1,1950,2026) & q2_1 == floor(q2_1)
    }
    count if _e3_nonmissing_`model'
    local nonmissing_n = r(N)
    count if _e3_domain_`model'
    local domain_n = r(N)
    file write `support' "`model',nonmissing_inputs,ALL,," (`admitted_n') "," (`nonmissing_n') ///
        ",,,Not an estimator sample; extension calendar unresolved" _n
    file write `support' "`model',domain_valid_inputs,ALL,," (`admitted_n') "," (`domain_n') ///
        ",,,Diagnostic only; no sample adoption or VCE decision" _n
    foreach code in 0 1 {
        count if _e3_domain_`model' & `outcome' == `code'
        file write `support' "`model',outcome_support,`outcome',`code'," (`domain_n') "," (r(N)) ///
            ",,,Input support not separation or estimability" _n
    }
    foreach field in q4 wp07_iat3 wp07_iadt2 wp07_iaff2 {
        summarize `field' if _e3_domain_`model', meanonly
        file write `support' "`model',continuous_support,`field',," (`domain_n') "," (r(N)) "," ///
            %24.17g (r(min)) "," %24.17g (r(max)) ",No functional form adopted" _n
    }
    foreach code in 1 2 3 4 5 6 7 8 9 10 {
        count if _e3_domain_`model' & q2_2 == `code'
        file write `support' "`model',education_category,q2_2,`code'," (`domain_n') "," (r(N)) ///
            ",,,Proposed reference is5; all categories retained" _n
    }
    forvalues code = 1/6 {
        count if _e3_domain_`model' & wp07_residence == `code'
        file write `support' "`model',residence_category,wp07_residence,`code'," (`domain_n') "," (r(N)) ///
            ",,,Proposed reference is1; early Other not Soacha" _n
    }
    if inlist("`model'","R1","D1") {
        forvalues code = 1/9 {
            count if _e3_domain_`model' & q2_3 == `code'
            file write `support' "`model',occupation_category,q2_3,`code'," (`domain_n') "," (r(N)) ///
                ",,,Proposed reference is3; calendar representation unresolved" _n
        }
        summarize q2_1 if _e3_domain_`model', meanonly
        file write `support' "`model',calendar_input,q2_1,," (`domain_n') "," (r(N)) "," ///
            %24.17g (r(min)) "," %24.17g (r(max)) ",Raw year not tenure; representation unresolved" _n
    }
}
count if _e3_domain_R0 & _e3_domain_D0
file write `support' "COMMON,core_common_inputs,ALL,," (`admitted_n') "," (r(N)) ///
    ",,,No common-sample fit performed" _n
count if _e3_domain_R0 & _e3_domain_D0 & _e3_domain_R1 & _e3_domain_D1
file write `support' "COMMON,four_nomination_common_inputs,ALL,," (`admitted_n') "," (r(N)) ///
    ",,,Calendar unresolved; no common-sample fit performed" _n
file close `support'

* These are adopted model-input mask identities, not a fit or a reused estimator N.
assert (_e3_domain_R0 & _e3_domain_D0) == _e3_domain_D0
assert !missing(e4_education3, e4_residence4) if _e3_domain_R0 | _e3_domain_D0
assert !missing(e4_occupation6) if _e3_domain_R1 | _e3_domain_D1
