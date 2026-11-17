/*
Digital Payments, Partial Inclusion | Academic quantitative analysis
Jorge E. Zavala and Angélica Cardozo Cadavid
1. Descriptive analysis
2. Determinants: sample, support, five logit fits and reporting
3. Measurement and latent-class analysis: explicit native Stata/MP stage
*/
args stage out code source reference

* Revised LCA: single projected read and private output, separate from the frozen stages.
if "`stage'" == "lca" {
    if "`out'" == "" | "`code'" == "" | "`source'" == "" | "`reference'" == "" {
        exit 198
    }
    do "`code'/2a Measurement and LCA.do" "`source'" "`reference'" "`out'" "`code'"
    exit
}

* Both sections use the locked analytical data already in memory.
if !inlist("`stage'", "descriptives", "determinants") | "`out'" == "" {
    exit 198
}
if "`stage'" == "descriptives" {
if "`code'" == "" {
    exit 198
}

* BEGIN DESCRIPTIVES
version 16
set varabbrev off
* Supply an existing restricted output directory; files are not overwritten.
* Shares describe this unweighted referral sample, not a target population.
quietly findfile scheme-plotplain.scheme
local dictionary "`code'/descriptive_options.csv"
local admitted = _N

* 1.1. Admitted cohort and screening coverage
tempname cohort
file open `cohort' using "`out'/cohort.csv", write text
file write `cohort' "section,category,n,admitted_n" _n
file write `cohort' "cohort,admitted," (`admitted') "," (`admitted') _n
local versions 0
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local versions = `versions' + r(N)
    file write `cohort' "version,`fv'," (r(N)) "," (`admitted') _n
}
file write `cohort' "version,UNKNOWN," (`admitted' - `versions') "," (`admitted') _n
quietly count if eligible_flag == 1
local eligible = r(N)
quietly count if eligible_flag == 0
local ineligible = r(N)
quietly count if missing(eligible_flag)
local screening_missing = r(N)
local screening_other = `admitted' - `eligible' - `ineligible' - `screening_missing'
file write `cohort' "screening,affirmative," (`eligible') "," (`admitted') _n
file write `cohort' "screening,negative," (`ineligible') "," (`admitted') _n
file write `cohort' "screening,missing," (`screening_missing') "," (`admitted') _n
file write `cohort' "screening,other," (`screening_other') "," (`admitted') _n
file close `cohort'

* 1.2. Reported remittance disposition and domestic digital activity
tempname engagement
file open `engagement' using "`out'/engagement.csv", write text
file write `engagement' "panel,basis,code,n,denominator_n,percent" _n
quietly count if !missing(wp07_remit_disposition)
local remit_n = r(N)
forvalues code = 1/5 {
    quietly count if wp07_remit_disposition == `code'
    local n = r(N)
    file write `engagement' "remittance,valid_category,`code'," (`n') "," (`remit_n') ","
    if `remit_n' > 0 {
        file write `engagement' %24.17g (100*`n'/`remit_n')
    }
    file write `engagement' _n
}
quietly count if wp07_remit_disposition == 1
local all_cash = r(N)
quietly count if wp07_remit_any_digital == 1
local any_digital = r(N)
forvalues code = 0/1 {
    local n = cond(`code' == 0, `all_cash', `any_digital')
    file write `engagement' "remittance,valid_binary,`code'," (`n') "," (`remit_n') ","
    if `remit_n' > 0 {
        file write `engagement' %24.17g (100*`n'/`remit_n')
    }
    file write `engagement' _n
}
quietly count if !missing(wp07_domestic_60d)
local domestic_n = r(N)
quietly count if wp07_domestic_60d == 1
local users = r(N)
forvalues code = 0/1 {
    quietly count if wp07_domestic_60d == `code'
    local n = r(N)
    file write `engagement' "domestic,valid_binary,`code'," (`n') "," (`domestic_n') ","
    if `domestic_n' > 0 {
        file write `engagement' %24.17g (100*`n'/`domestic_n')
    }
    file write `engagement' _n
}
foreach item in q6_13 q6_14 {
    local panel "remittance"
    if "`item'" == "q6_14" {
        local panel "domestic"
    }
    forvalues state = 2/6 {
        quietly count if wp07_state_`item' == `state'
        local n = r(N)
        file write `engagement' "`panel',unscored_state,`state'," (`n') "," (`admitted') "," ///
            %24.17g (100*`n'/`admitted') _n
    }
}
file close `engagement'

* Keep latest receipt channel separate from frequency in the past 12 months.
tempname context
file open `context' using "`out'/remittance_context.csv", write text
file write `context' "item,basis,code,n,denominator_n,percent" _n
foreach item in q6_2 q6_4 {
    local codes "1 2 3 99"
    if "`item'" == "q6_4" {
        local codes "1 2 3 4 5"
    }
    quietly count if inlist(wp07_state_`item', 1, 5)
    local recorded = r(N)
    foreach code of local codes {
        quietly count if inlist(wp07_state_`item', 1, 5) & `item' == `code'
        local n = r(N)
        file write `context' "`item',recorded_category,`code'," (`n') "," (`recorded') ","
        if `recorded' > 0 {
            file write `context' %24.17g (100*`n'/`recorded')
        }
        file write `context' _n
    }
    forvalues state = 1/6 {
        quietly count if wp07_state_`item' == `state'
        file write `context' "`item',admitted_state,`state'," (r(N)) "," (`admitted') "," ///
            %24.17g (100*r(N)/`admitted') _n
    }
}

* Frequency bins are conditional on affirmative users. Uncertainty is not a bin.
quietly count if wp07_domestic_60d == 1 & inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5)
local bins = r(N)
forvalues code = 1/5 {
    quietly count if wp07_domestic_60d == 1 & wp07_domestic_ops_bin == `code'
    local n = r(N)
    file write `context' "q6_15,valid_bin,`code'," (`n') "," (`bins') ","
    if `bins' > 0 {
        file write `context' %24.17g (100*`n'/`bins')
    }
    file write `context' _n
}
forvalues state = 1/6 {
    quietly count if wp07_domestic_60d == 1 & wp07_state_q6_15 == `state'
    local n = r(N)
    file write `context' "q6_15,affirmative_user_state,`state'," (`n') "," (`users') ","
    if `users' > 0 {
        file write `context' %24.17g (100*`n'/`users')
    }
    file write `context' _n
}
file close `context'

* 1.3. IAT–IADT associations on pair-complete and common observation bases
tempname association
file open `association' using "`out'/associations.csv", write text
file write `association' "basis,left,right,n,pearson_r,status" _n
foreach basis in pair common {
    local left_fields "wp07_iat3 wp07_iat3"
    local right_fields "wp07_iadt2 wp07_iadt3"
    local pairs 2
    if "`basis'" == "common" {
        local left_fields "`left_fields' wp07_iadt2"
        local right_fields "`right_fields' wp07_iadt3"
        local pairs 3
    }
    forvalues pair = 1/`pairs' {
        local left : word `pair' of `left_fields'
        local right : word `pair' of `right_fields'
        local sample "!missing(`left', `right')"
        if "`basis'" == "common" {
            local sample "!missing(wp07_iat3, wp07_iadt2, wp07_iadt3)"
        }
        quietly count if `sample'
        local n = r(N)
        local status "insufficient_n"
        if `n' >= 2 {
            quietly summarize `left' if `sample', meanonly
            local left_varies = r(min) < r(max)
            quietly summarize `right' if `sample', meanonly
            local right_varies = r(min) < r(max)
            local status "constant_field"
            if `left_varies' & `right_varies' {
                quietly correlate `left' `right' if `sample'
                local rho = r(rho)
                local status "available"
            }
        }
        file write `association' "`basis',`left',`right'," (`n') ","
        if "`status'" == "available" {
            file write `association' %24.17g (`rho')
        }
        file write `association' ",`status'" _n
    }
}
file close `association'

* 1.4. Item routes, responses, residence and measure coverage
* Unoffered choices do not become zeros.
* The unknown-form bucket has state and route counts, but no choice shares.
tempname forms denominators choices display_choices context residency scores
frame create `forms'
frame `forms': import delimited using "`dictionary'", varnames(1) stringcols(_all) clear
frame `forms': destring form_version, replace
frame `forms': isid item form_version
frame `forms': levelsof item, local(items) clean
local form_versions "2512090157 2512091719 2512111044 2512121811 2602120658"

file open `denominators' using "`out'/item_denominators.csv", write text
file write `denominators' "item,form_version,kind,form_n,route_yes,route_no,route_unknown,state1,state2,state3,state4,state5,state6,recorded_n" _n
file open `choices' using "`out'/item_choices.csv", write text
file write `choices' "item,form_version,kind,code,n,denominator_n,percent,sentinel_mentions_n" _n
file open `display_choices' using "`out'/item_choice_display.csv", write text
file write `display_choices' "item,form_version,kind,code,share_basis,n,denominator_n,percent" _n
file open `context' using "`out'/numeric_context.csv", write text
file write `context' "item,form_version,n,mean,p25,median,p75" _n

foreach item of local items {
    frame `forms': levelsof kind if item == "`item'", local(kind) clean
    foreach fv in `form_versions' UNKNOWN {
        local group "formdef_version == `fv'"
        if "`fv'" == "UNKNOWN" {
            local group "wp07_known_form != 1"
        }
        quietly count if `group'
        local form_n = r(N)
        quietly count if `group' & wp07_route_`item' == 1
        local yes = r(N)
        quietly count if `group' & wp07_route_`item' == 0
        local no = r(N)
        local unknown = `form_n' - `yes' - `no'
        file write `denominators' "`item',`fv',`kind'," (`form_n') "," (`yes') "," (`no') "," (`unknown')
        forvalues state = 1/6 {
            quietly count if `group' & wp07_state_`item' == `state'
            local state`state' = r(N)
            file write `denominators' "," (r(N))
        }
        local recorded = `state1' + `state5'
        file write `denominators' "," (`recorded') _n
        if "`fv'" == "UNKNOWN" {
            continue
        }
        if "`kind'" == "numeric" {
            quietly summarize `item' if `group' & wp07_state_`item' == 1, detail
            file write `context' "`item',`fv'," (r(N)) ","
            if r(N) > 0 {
                file write `context' %24.17g (r(mean)) "," (r(p25)) "," (r(p50)) "," (r(p75))
            }
            else {
                file write `context' ",,,"
            }
            file write `context' _n
            continue
        }
        frame `forms': levelsof codes if item == "`item'" & form_version == `fv', local(offered) clean
        foreach code of local offered {
            local sentinel "."
            if "`kind'" == "multiple" {
                * Whole-token matches only; a sentinel is not an ordinary selection.
                quietly count if `group' & wp07_state_`item' == 5 & ///
                    strpos(" " + itrim(strtrim(`item')) + " ", " `code' ") > 0
                local sentinel = r(N)
                quietly count if `group' & wp07_state_`item' == 1 & ///
                    strpos(" " + itrim(strtrim(`item')) + " ", " `code' ") > 0
                local base = `state1'
            }
            else {
                quietly count if `group' & inlist(wp07_state_`item', 1, 5) & `item' == `code'
                local base = `recorded'
            }
            local n = r(N)
            file write `choices' "`item',`fv',`kind',`code'," (`n') "," (`base') ","
            if `base' > 0 {
                file write `choices' %24.17g (100*`n'/`base')
            }
            file write `choices' "," (`sentinel') _n

            local basis "recorded_answer"
            if "`kind'" == "multiple" {
                local basis "ordinary_parent"
                if `code' == 98 {
                    * Explicit refusal is a share of all recorded parent answers.
                    local basis "recorded_parent_refusal"
                    local n = `sentinel'
                    local base = `recorded'
                }
            }
            file write `display_choices' "`item',`fv',`kind',`code',`basis'," (`n') "," (`base') ","
            if `base' > 0 {
                file write `display_choices' %24.17g (100*`n'/`base')
            }
            file write `display_choices' _n
        }
    }
}
file close `denominators'
file close `choices'
file close `display_choices'
file close `context'
frame drop `forms'

* Geography is the detailed version-aware field, not the model grouping.
file open `residency' using "`out'/residence.csv", write text
file write `residency' "code,n,denominator_n" _n
foreach code in 1 2 3 4 5 6 . {
    quietly count if wp07_residence == `code'
    file write `residency' "`code'," (r(N)) "," (`admitted') _n
}
file close `residency'

* Score summaries keep fixed-component scores and their defined bases distinct.
file open `scores' using "`out'/scores.csv", write text
file write `scores' "field,basis,n,admitted_n,mean,sd,minimum,maximum" _n
foreach field in wp07_ivs_educ wp07_iat_phone wp07_iat_internet wp07_iat_runout wp07_iat3 ///
    wp07_iadt_app wp07_iadt_transfer wp07_iadt_confidence wp07_iadt2 wp07_iadt3 ///
    wp07_icdp_otp wp07_icdp_pin wp07_icdp2 wp07_iaff_address wp07_iaff_phone wp07_iaff2 ///
    wp07_iuof_frequency wp07_iuof_frequency_oldmap wp07_iuof_merchant wp07_iuof_saving ///
    wp07_iuof3 wp07_iuof3_oldmap wp07_iuof2_no_frequency wp07_oqi_ease wp07_oqi_ease_oldmap ///
    wp07_oqi_support wp07_oqi2 wp07_oqi2_oldmap {
    quietly summarize `field'
    file write `scores' "`field',own," (r(N)) "," (`admitted') "," ///
        %24.17g (r(mean)) "," %24.17g (r(sd)) "," %24.17g (r(min)) "," %24.17g (r(max)) _n
}
foreach family in iadt iuof oqi {
    if "`family'" == "iadt" {
        local compare "wp07_iadt2 wp07_iadt3"
        local complete "!missing(wp07_iadt2, wp07_iadt3)"
    }
    if "`family'" == "iuof" {
        local compare "wp07_iuof3 wp07_iuof3_oldmap wp07_iuof2_no_frequency"
        local complete "!missing(wp07_iuof3, wp07_iuof3_oldmap, wp07_iuof2_no_frequency)"
    }
    if "`family'" == "oqi" {
        local compare "wp07_oqi2 wp07_oqi2_oldmap"
        local complete "!missing(wp07_oqi2, wp07_oqi2_oldmap)"
    }
    foreach field of local compare {
        quietly summarize `field' if `complete'
        file write `scores' "`field',common_`family'," (r(N)) "," (`admitted') "," ///
            %24.17g (r(mean)) "," %24.17g (r(sd)) "," %24.17g (r(min)) "," %24.17g (r(max)) _n
    }
}
file close `scores'

* 1.5. Sample composition and reported onboarding conditions
tempname composition onboarding
file open `composition' using "`out'/sample_composition.csv", write text
file write `composition' "section,code,label,n,denominator_n,percent,median,p25,p75" _n
quietly summarize q4 if wp07_state_q4 == 1, detail
file write `composition' "age,1,Age in years," (r(N)) "," (`admitted') ",," ///
    %24.17g (r(p50)) "," (r(p25)) "," (r(p75)) _n

foreach section in residence education occupation {
    if "`section'" == "residence" {
        local field e4_residence4
        local levels 1 2 3 4
    }
    if "`section'" == "education" {
        local field e4_education3
        local levels 1 2 3
    }
    if "`section'" == "occupation" {
        local field e4_occupation6
        local levels 1 3 4 5 7 9
    }
    quietly count if !missing(`field')
    local base = r(N)
    local labels : value label `field'
    foreach level of local levels {
        local label : label `labels' `level'
        if "`section'" == "residence" & `level' == 4 {
            local label "Other recorded residence responses"
        }
        quietly count if `field' == `level'
        file write `composition' "`section',`level',`label'," (r(N)) "," (`base') ","
        if `base' > 0 {
            file write `composition' %24.17g (100*r(N)/`base')
        }
        file write `composition' ",,," _n
    }
}
file close `composition'

* Keep the four conditions separate, on the base with both answers observed.
file open `onboarding' using "`out'/onboarding_conditions.csv", write text
file write `onboarding' "pattern,address,phone,n,denominator_n,percent" _n
quietly count if !missing(wp07_iaff_address, wp07_iaff_phone)
local pair_n = r(N)
local onboarding_unscored = `admitted' - `pair_n'
forvalues address = 0/1 {
    forvalues phone = 0/1 {
        quietly count if wp07_iaff_address == `address' & wp07_iaff_phone == `phone'
        file write `onboarding' (2*`address'+`phone'+1) ",`address',`phone'," (r(N)) "," (`pair_n') ","
        if `pair_n' > 0 {
            file write `onboarding' %24.17g (100*r(N)/`pair_n')
        }
        file write `onboarding' _n
    }
}
file close `onboarding'

* 1.6. Paper, supplement and slide exhibits
* Only aggregate CSVs enter this separate frame.
tempname exhibit table remit_panel domestic_panel
frame create `exhibit'
local endrow "_char(92) _char(92) _n"
frame `exhibit' {
    * T1. Sample composition
    import delimited using "`out'/sample_composition.csv", varnames(1) asdouble clear
    file open `table' using "`out'/T1_sample_composition.tex", write text
    file write `table' "\begin{table}[htbp]" _n "\centering" _n ///
        "\caption{Characteristics of the recruited survey sample}" _n ///
        "\label{tab:sample-composition}" _n "\begin{tabular}{@{}lrrl@{}}" _n ///
        "\toprule Characteristic & Count & Base & Percent or summary " `endrow' "\midrule" _n ///
        "Admitted survey records & " (`admitted') " & " (`admitted') " & -- " `endrow'
    file write `table' "Age, median [25th, 75th percentile] & " (n[1]) " & " (denominator_n[1]) " & "
    if n[1] > 0 {
        file write `table' %4.1f (median[1]) " [" %4.1f (p25[1]) ", " %4.1f (p75[1]) "] "
    }
    else {
        file write `table' "-- "
    }
    file write `table' `endrow'
    foreach group in residence education occupation {
        if "`group'" == "residence" local header "Recorded residence"
        if "`group'" == "education" local header "Highest reported education"
        if "`group'" == "occupation" local header "Reported main occupation"
        file write `table' "\addlinespace \multicolumn{4}{@{}l}{\textit{`header'}} " `endrow'
        quietly summarize denominator_n if section == "`group'", meanonly
        local base = r(min)
        forvalues j = 2/`=_N' {
            if section[`j'] == "`group'" {
                local share = cond(`base' > 0, strtrim(string(percent[`j'], "%5.1f")), "--")
                file write `table' (label[`j']) " & " (n[`j']) " & " (denominator_n[`j']) " & `share' " `endrow'
            }
        }
        if `base' < `admitted' {
            file write `table' "No classifiable answer & " (`admitted'-`base') " & " (`admitted') " & -- " `endrow'
        }
    }
    file write `table' "\bottomrule" _n "\end{tabular}" _n ///
        "\par\smallskip{\footnotesize\raggedright Notes: Unweighted referral sample; not population estimates. Age uses ordinary recorded responses. Categorical percentages use classifiable answers. Other recorded residence combines early Other, Soacha and Meta; it is not one location. Occupation is self-reported, not a labour-force classification.\par}" _n "\end{table}" _n
    file close `table'

    * T2 and F1. The panels come from different questions, not a transaction funnel.
    import delimited using "`out'/engagement.csv", varnames(1) asdouble clear
    local r1 "Withdraw all in cash"
    local r2 "Withdraw less than half in cash"
    local r3 "Half cash, half digital"
    local r4 "Keep more than half digitally"
    local r5 "Keep all digitally"
    quietly summarize denominator_n if panel == "remittance" & basis == "valid_category", meanonly
    local remit_base = r(min)
    quietly summarize denominator_n if panel == "domestic" & basis == "valid_binary", meanonly
    local domestic_base = r(min)
    file open `table' using "`out'/T2_digital_engagement.tex", write text
    file write `table' "\begin{table}[htbp]" _n "\centering" _n ///
        "\caption{Reported remittance disposition and domestic digital payments}" _n ///
        "\label{tab:digital-engagement}" _n "\begin{tabular}{@{}lrrr@{}}" _n ///
        "\toprule Survey response & Count & Base & Percent " `endrow' "\midrule" _n ///
        "\multicolumn{4}{@{}l}{\textit{Disposition of received remittances}} " `endrow'
    forvalues j = 1/`=_N' {
        if panel[`j'] == "remittance" & (basis[`j'] == "valid_category" | (basis[`j'] == "valid_binary" & code[`j'] == 1)) {
            local k = code[`j']
            local label "Any digital retention or use (summary)"
            if basis[`j'] == "valid_category" local label "`r`k''"
            local share = cond(denominator_n[`j'] > 0, strtrim(string(percent[`j'], "%5.1f")), "--")
            file write `table' "`label' & " (n[`j']) " & " (denominator_n[`j']) " & `share' " `endrow'
        }
    }
    file write `table' "\addlinespace \multicolumn{4}{@{}l}{\textit{Domestic digital sending or receiving, past 60 days}} " `endrow'
    forvalues j = 1/`=_N' {
        if panel[`j'] == "domestic" & basis[`j'] == "valid_binary" {
            local label = cond(code[`j'] == 1, "Yes", "No")
            local share = cond(denominator_n[`j'] > 0, strtrim(string(percent[`j'], "%5.1f")), "--")
            file write `table' "`label' & " (n[`j']) " & " (denominator_n[`j']) " & `share' " `endrow'
        }
    }
    file write `table' "\bottomrule" _n "\end{tabular}" _n ///
        "\par\smallskip{\footnotesize\raggedright Notes: Each panel uses its own valid-answer base. Unscored records: " ///
        (`admitted'-`remit_base') " for remittances and " (`admitted'-`domestic_base') ///
        " for domestic payments. The original disposition options remain separate even where wording overlaps. The any-digital row sums options 2--5. These are shares of respondents, not monetary shares or stages of a single transfer.\par}" _n "\end{table}" _n
    file close `table'

    graph hbar (asis) percent if panel == "remittance" & basis == "valid_category", ///
        over(code, relabel(1 "`r1'" 2 "`r2'" 3 "`r3'" 4 "`r4'" 5 "`r5'") label(labsize(small))) ///
        title("A. Disposition of received remittances", size(medsmall)) ///
        subtitle("`remit_base' valid answers", size(small)) ///
        ytitle("Percent of valid answers", size(small)) ylabel(0(25)100, labsize(small)) ///
        yscale(range(0 105)) bar(1, color(gs6)) blabel(bar, format(%4.1f) size(small)) ///
        scheme(plotplain) name(`remit_panel') nodraw
    graph hbar (asis) percent if panel == "domestic" & basis == "valid_binary", ///
        over(code, relabel(1 "Did not send or receive digitally" ///
            2 "Sent or received money digitally") label(labsize(small))) ///
        title("B. Domestic digital sending or receiving", size(medsmall)) ///
        subtitle("Past 60 days; `domestic_base' valid answers", size(small)) ///
        ytitle("Percent of valid answers", size(small)) ylabel(0(25)100, labsize(small)) ///
        yscale(range(0 105)) bar(1, color(gs6)) blabel(bar, format(%4.1f) size(small)) ///
        scheme(plotplain) name(`domestic_panel') nodraw
    local domestic_unscored = `admitted' - `domestic_base'
    * Clean artwork has panel labels but no embedded caption or notes.
    graph combine `remit_panel' `domestic_panel', cols(1) ycommon xsize(7) ysize(6) scheme(plotplain)
    graph export "`out'/F1_digital_engagement_artwork.pdf", width(6.4) fontface(Arial)

    graph combine `remit_panel' `domestic_panel', cols(1) ycommon xsize(7) ysize(6.4) ///
        scheme(plotplain) ///
        note("Notes: Unweighted shares; the panels do not track the same transfer." ///
            "`domestic_unscored' domestic answers were unscored." ///
            "Two original remittance options overlap in wording; both are shown." ///
            "Source: Authors' calculations from the CFI-DPI survey in Colombia.", size(small))
    graph export "`out'/F1_digital_engagement.pdf", width(6.4) fontface(Arial)
    * Seminar version puts the two headline shares on one scale.
    graph bar (asis) percent if basis == "valid_binary" & code == 1, ///
        over(panel, relabel(1 `" "Domestic digital payments" "Past 60 days (N=`domestic_base')" "' ///
            2 `" "Any digital remittance retention or use" "(N=`remit_base')" "') label(labsize(medsmall))) ///
        title("Digital engagement in two settings", size(medlarge)) ///
        ytitle("Percent of valid answers", size(medsmall)) ylabel(0(25)100, labsize(medsmall)) ///
        yscale(range(0 105)) bar(1, color(gs5)) blabel(bar, format(%4.1f) size(medsmall)) ///
        scheme(plotplain) xsize(12) ysize(6.75) ///
        note("Notes: Unweighted shares from different questions, not the same transfer." ///
            "Any digital means an answer other than withdrawing all received remittances in cash." ///
            "Source: Authors' calculations from the CFI-DPI survey in Colombia.", size(small))
    graph export "`out'/F1_digital_engagement_slides.pdf", fontface(Arial)
    graph export "`out'/F1_digital_engagement_slides.png", width(2400)
    graph drop `remit_panel' `domestic_panel'

    file open `table' using "`out'/F1_digital_engagement_caption.tex", write text
    file write `table' "\caption{Reported remittance disposition and domestic digital payments}" _n ///
        "\label{fig:digital-engagement}" _n ///
        "\par\smallskip{\footnotesize\raggedright Notes: Panel A uses " (`remit_base') ///
        " valid answers about the disposition of received remittances. Two original response options overlap in wording; both are shown. Panel B uses " ///
        (`domestic_base') " valid answers about sending or receiving money digitally in Colombia in the past 60 days; " ///
        (`domestic_unscored') " records are unscored. Bars are unweighted shares of respondents, not monetary shares or stages of the same transfer." ///
        "\par Source: Authors' calculations from the CFI-DPI survey in Colombia.\par}" _n
    file close `table'

    * F2. Reported conditions are not provider-verified eligibility or ownership.
    import delimited using "`out'/onboarding_conditions.csv", varnames(1) asdouble clear
    graph hbar (asis) percent, over(pattern, relabel(1 "Neither condition" 2 "Phone only" ///
        3 "Proof of address only" 4 "Both conditions") label(labsize(medsmall))) ///
        ytitle("Percent of complete pairs", size(medsmall)) ylabel(0(25)100, labsize(medsmall)) ///
        yscale(range(0 105)) bar(1, color(gs5)) blabel(bar, format(%4.1f) size(medsmall)) ///
        scheme(plotplain) xsize(9.5) ysize(4.8)
    graph export "`out'/F2_onboarding_conditions_artwork.pdf", width(6.4) fontface(Arial)
    graph hbar (asis) percent, over(pattern, relabel(1 "Neither condition" 2 "Phone only" ///
        3 "Proof of address only" 4 "Both conditions") label(labsize(medsmall))) ///
        title("Reported own-name onboarding conditions", size(medlarge)) ///
        subtitle("`pair_n' complete pairs; `onboarding_unscored' unscored", size(medsmall)) ///
        ytitle("Percent of complete pairs", size(medsmall)) ylabel(0(25)100, labsize(medsmall)) ///
        yscale(range(0 105)) bar(1, color(gs5)) blabel(bar, format(%4.1f) size(medsmall)) ///
        note("Notes: Unweighted shares of complete pairs. Own-name address proof was reported" ///
            "as acceptable to financial institutions. Phone refers to the number normally used" ///
            "for digital accounts or wallets. Neither condition verifies eligibility or ownership." ///
            "Source: Authors' calculations from the CFI-DPI survey in Colombia.", size(small)) ///
        scheme(plotplain) xsize(9.5) ysize(5.34)
    graph export "`out'/F2_onboarding_conditions.pdf", width(6.4) fontface(Arial)
    graph export "`out'/F2_onboarding_conditions.png", width(2400)

    file open `table' using "`out'/F2_onboarding_conditions_caption.tex", write text
    file write `table' "\caption{Reported own-name onboarding conditions}" _n ///
        "\label{fig:onboarding-conditions}" _n ///
        "\par\smallskip{\footnotesize\raggedright Notes: Unweighted shares among the " ///
        (`pair_n') " records with both answers observed (" (`onboarding_unscored') ///
        " unscored). Own-name address proof was reported as acceptable to financial institutions. Phone refers to the number normally used for digital accounts or wallets. These conditions do not establish verified eligibility or account ownership." ///
        "\par Source: Authors' calculations from the CFI-DPI survey in Colombia.\par}" _n
    file close `table'

* S1. Form and screening partitions are independent, not an exclusion flow.
    import delimited using "`out'/cohort.csv", varnames(1) stringcols(2) clear
    file open `table' using "`out'/S1_cohort_coverage.tex", write text
    file write `table' "\begin{table}[htbp]" _n "\centering" _n ///
        "\caption{Admitted cohort: form versions and recorded screening}" _n ///
        "\label{tab:cohort-coverage}" _n "\begin{tabular}{@{}lrr@{}}" _n ///
        "\toprule Category & Count & Admitted base " `endrow' "\midrule" _n ///
        "Admitted survey records & " (n[1]) " & " (admitted_n[1]) " " `endrow'
    foreach group in version screening {
        if "`group'" == "version" local header "Submitted instrument version"
        if "`group'" == "screening" local header "Recorded screening flag"
        file write `table' "\addlinespace \multicolumn{3}{@{}l}{\textit{`header'}} " `endrow'
        forvalues j = 2/`=_N' {
            if section[`j'] == "`group'" {
                local label = strproper(category[`j'])
                if category[`j'] == "UNKNOWN" local label "Missing or unrecognized version"
                file write `table' "`label' & " (n[`j']) " & " (admitted_n[`j']) " " `endrow'
            }
        }
    }
    file write `table' "\bottomrule" _n "\end{tabular}" _n ///
        "\par\smallskip{\footnotesize\raggedright Notes: These two partitions describe the same locked cohort. The screening flag is a diagnostic. No records are removed here, and the table is not a response rate.\par}" _n "\end{table}" _n
    file close `table'

    * S2. Receipt frequency, latest channel and domestic operation bins.
    import delimited using "`out'/remittance_context.csv", varnames(1) asdouble clear
    local freq1 "Monthly or more often"
    local freq2 "Every 2--3 months"
    local freq3 "Once or twice a year"
    local freq99 "Not applicable / does not remember"
    local mode1 "Bank account"
    local mode2 "Digital wallet or app"
    local mode3 "Cash at a counter"
    local mode4 "Through a traveler"
    local mode5 "Other channel (unspecified)"
    local ops1 "Fewer than 5"
    local ops2 "Between 5 and 10"
    local ops3 "Between 10 and 20"
    local ops4 "Between 20 and 50"
    local ops5 "More than 50"
    file open `table' using "`out'/S2_payment_context.tex", write text
    file write `table' "\begin{table}[htbp]" _n "\centering" _n ///
        "\caption{Remittance receipt and domestic operation frequency}" _n ///
        "\label{tab:payment-context}" _n "\begin{tabular}{@{}lrrr@{}}" _n ///
        "\toprule Response & Count & Base & Percent " `endrow' "\midrule" _n
    foreach field in q6_2 q6_4 q6_15 {
        if "`field'" == "q6_2" {
            local header "Remittances from abroad in the past 12 months"
            local option freq
        }
        if "`field'" == "q6_4" {
            local header "Channel of most recent received remittance"
            local option mode
        }
        if "`field'" == "q6_15" {
            local header "Domestic sending or receiving in the past 60 days"
            local option ops
        }
        file write `table' "\addlinespace \multicolumn{4}{@{}l}{\textit{`header'}} " `endrow'
        forvalues j = 1/`=_N' {
            if item[`j'] == "`field'" & inlist(basis[`j'], "recorded_category", "valid_bin") {
                local k = code[`j']
                local label "``option'`k''"
                local share = cond(denominator_n[`j'] > 0, strtrim(string(percent[`j'], "%5.1f")), "--")
                file write `table' "`label' & " (n[`j']) " & " (denominator_n[`j']) " & `share' " `endrow'
            }
        }
    }
    quietly summarize denominator_n if item == "q6_15" & basis == "affirmative_user_state", meanonly
    local users = r(min)
    quietly summarize n if item == "q6_15" & basis == "affirmative_user_state" & code == 5, meanonly
    local uncertain = r(sum)
    local share = cond(`users' > 0, strtrim(string(100*`uncertain'/`users', "%5.1f")), "--")
    file write `table' "\addlinespace Does not know / remember domestic count & " ///
        (`uncertain') " & " (`users') " & `share' " `endrow' "\bottomrule" _n "\end{tabular}" _n ///
        "\par\smallskip{\footnotesize\raggedright Notes: The first two panels use their own recorded-answer bases. The combined frequency code is shown as recorded, not scored zero. The operation bins use affirmative domestic users with a valid bin. The separate uncertainty row uses all affirmative domestic users. Boundaries are as asked; bins are not converted to counts.\par}" _n "\end{table}" _n
    file close `table'

    * S3. Own-sample summaries and explicitly named common-base sensitivities.
    import delimited using "`out'/scores.csv", varnames(1) asdouble clear
    local fields wp07_iat3 wp07_iadt2 wp07_iadt3 wp07_icdp2 wp07_iaff2 ///
        wp07_iuof3 wp07_iuof3_oldmap wp07_iuof2_no_frequency wp07_oqi2 wp07_oqi2_oldmap
    local names `" "Reported access (IAT3)" "Reported transfer ability and safety confidence (IADT2)" "App-inclusive alternative (IADT3)" "Credential protection practices (ICDP2)" "Own-name onboarding conditions (IAFF2)" "Reported digital uses (IUOF3)" "Old-frequency mapping (IUOF3 alternative)" "Use summary without frequency (IUOF2)" "Ease and support (OQI2)" "Old-ease mapping (OQI2 alternative)" "'
    file open `table' using "`out'/S3_score_coverage.tex", write text
    file write `table' "\begin{table}[htbp]" _n "\centering\small" _n ///
        "\caption{Coverage and distribution of fixed-component measures}" _n ///
        "\label{tab:score-coverage}" _n "\begin{tabular}{@{}p{.59\linewidth}rrr@{}}" _n ///
        "\toprule Measure & Valid \(N\) & Mean & SD " `endrow' "\midrule" _n
    foreach base in own common_iadt common_iuof common_oqi {
        local label "Own complete-component base"
        if "`base'" == "common_iadt" local label "Common base: both IADT definitions"
        if "`base'" == "common_iuof" local label "Common base: three IUOF definitions"
        if "`base'" == "common_oqi" local label "Common base: both OQI definitions"
        file write `table' "\addlinespace \multicolumn{4}{@{}l}{\textit{`label'}} " `endrow'
        local index 0
        foreach field of local fields {
            local ++index
            local label : word `index' of `names'
            forvalues j = 1/`=_N' {
                if basis[`j'] == "`base'" & field[`j'] == "`field'" {
                    local average = cond(n[`j'] > 0, strtrim(string(mean[`j'], "%6.3f")), "--")
                    local spread = cond(n[`j'] > 1, strtrim(string(sd[`j'], "%6.3f")), "--")
                    file write `table' "`label' & " (n[`j']) " & `average' & `spread' " `endrow'
                }
            }
        }
    }
    file write `table' "\bottomrule" _n "\end{tabular}" _n ///
        "\par\smallskip{\footnotesize\raggedright Notes: Measures have a 0--1 scale and require all stipulated components. Alternative mappings are documented comparisons, not adopted replacements. A common base requires every indicated definition to be observed. The accompanying ledger gives all component and score summaries.\par}" _n "\end{table}" _n
    file close `table'

    * S4. The five declared correlations, not the held Appendix C2 matrix.
    import delimited using "`out'/associations.csv", varnames(1) asdouble clear
    file open `table' using "`out'/S4_iat_iadt_associations.tex", write text
    file write `table' "\begin{table}[htbp]" _n "\centering" _n ///
        "\caption{Descriptive correlations of access and alternative IADT definitions}" _n ///
        "\label{tab:iat-iadt-associations}" _n "\begin{tabular}{@{}llrr@{}}" _n ///
        "\toprule Measure pair & Observation base & Valid \(N\) & Pearson \(r\) " `endrow' "\midrule" _n
    forvalues j = 1/`=_N' {
        local pair = cond(left[`j'] == "wp07_iat3", "IAT3 and ", "IADT2 and ") + ///
            cond(right[`j'] == "wp07_iadt2", "IADT2", "IADT3")
        local base = cond(basis[`j'] == "pair", "Pair-complete", "Three-measure common")
        local coef = cond(status[`j'] == "available", strtrim(string(pearson_r[`j'], "%6.3f")), "--")
        file write `table' "`pair' & `base' & " (n[`j']) " & `coef' " `endrow'
    }
    file write `table' "\bottomrule" _n "\end{tabular}" _n ///
        "\par\smallskip{\footnotesize\raggedright Notes: Unweighted within-sample Pearson coefficients. IADT3 shares the two IADT2 items and adds an app-installation item. Their association includes mechanical overlap; these comparisons do not validate a latent trait. Undefined coefficients are not replaced by zero.\par}" _n "\end{table}" _n
    file close `table'

    * S5. Selected item states; the complete versioned ledgers are separate.
    import delimited using "`out'/item_denominators.csv", varnames(1) stringcols(2) clear
    local fields q4 q2_2 q2_3 q2_1 q3_1 q3_5 q3_8 q3_15 q3_16 q3_17 q4_5 q4_6 q6_2 q6_4 q6_13 q6_14 q6_15
    local names `" "Age" "Highest education" "Main occupation" "First-arrival calendar year" "Regular mobile phone use" "Internet-use frequency" "Data or balance ran out" "App installation" "Transfer ability by phone" "Confidence in avoiding online fraud" "Own-name proof of address" "Own-name phone line" "Remittance receipt frequency" "Latest remittance receipt channel" "Remittance disposition" "Domestic digital participation" "Domestic operation bin" "'
    file open `table' using "`out'/S5_response_coverage.tex", write text
    file write `table' "\begin{table}[htbp]" _n "\centering\small" _n ///
        "\caption{Response coverage for selected survey items}" _n "\setlength{\tabcolsep}{4pt}" _n ///
        "\label{tab:item-response-coverage}" _n "\begin{tabular}{@{}lrrrrrr@{}}" _n ///
        "\toprule Item & Ordinary & Skip & Unavailable & Blank & Special & Unresolved " `endrow' "\midrule" _n
    local index 0
    foreach field of local fields {
        local ++index
        local label : word `index' of `names'
        file write `table' "`label'"
        forvalues state = 1/6 {
            quietly summarize state`state' if item == "`field'", meanonly
            file write `table' " & " (r(sum))
        }
        file write `table' " " `endrow'
    }
    file write `table' "\bottomrule" _n "\end{tabular}" _n ///
        "\par\smallskip{\footnotesize\raggedright Notes: Each row partitions all " (`admitted') ///
        " admitted records. Skip is a closed route; unavailable is not offered in that version. Blank is an applicable unanswered item. Special includes instrument-specific uncertainty, refusal or another explicit unscored code. Unresolved includes unknown versions/routes and unresolved entries. The versioned ledgers give the offered options and their denominators.\par}" _n "\end{table}" _n
    file close `table'
}
frame drop `exhibit'

* END DESCRIPTIVES
exit
}

* 2. Determinants: core models, covariate extensions and a common-sample check.
* Working robust VCE is NOT a correction for unrecorded referral/household dependence.
* Associations concern each recruited-cohort model sample, not a causal/national effect.
local e4_output "`out'"
* BEGIN E4 BODY
version 16
set varabbrev off
* A bounded caller supplies one fresh, restricted output directory. No directory is created.
if "`e4_output'" == "" {
    exit 198
}
foreach filename in e4_model_status.csv e4_support.csv e4_native_matrices.csv ///
    e4_probabilities.csv e4_primary_tests.csv e4_joint_support.csv {
    confirm new file "`e4_output'/`filename'"
}
confirm numeric variable wp07_iat3 wp07_iadt2 wp07_iaff2 q4 wp07_state_q4 q2_2 q2_3 q2_1 ///
    wp07_residence e4_education3 e4_residence4 e4_occupation6 ///
    wp07_remit_any_digital wp07_domestic_60d, exact
assert missing(wp07_iat3) | inrange(wp07_iat3, 0, 1)
assert missing(wp07_iadt2) | inrange(wp07_iadt2, 0, 1)
assert missing(wp07_iaff2) | inlist(wp07_iaff2, 0, .5, 1)
assert missing(wp07_remit_any_digital) | inlist(wp07_remit_any_digital, 0, 1)
assert missing(wp07_domestic_60d) | inlist(wp07_domestic_60d, 0, 1)

* 2.1. Sample: ordinary age is required for modelling, not for cohort membership.
local e4_admitted_n = _N
local e4_raw "q4 wp07_state_q4 q2_2 q2_3 q2_1 wp07_residence wp07_iat3 wp07_iadt2 wp07_iaff2 wp07_remit_any_digital wp07_domestic_60d"
_datasignature `e4_raw'
local e4_signature "`r(datasignature)'"
gen long e4_row_order = _n
gen byte e4_mask_r0 = !missing(wp07_remit_any_digital, wp07_iat3, wp07_iadt2, ///
    wp07_iaff2, q4, q2_2, wp07_residence) & wp07_state_q4 == 1 & ///
    inrange(q4, 18, 100) & q4 == floor(q4) & inrange(q2_2, 1, 10) & q2_2 == floor(q2_2)
gen byte e4_mask_d0 = !missing(wp07_domestic_60d, wp07_iat3, wp07_iadt2, ///
    wp07_iaff2, q4, q2_2, wp07_residence) & wp07_state_q4 == 1 & ///
    inrange(q4, 18, 100) & q4 == floor(q4) & inrange(q2_2, 1, 10) & q2_2 == floor(q2_2)
gen byte e4_mask_r1 = e4_mask_r0 & !missing(q2_3, q2_1) & ///
    inrange(q2_3, 1, 9) & q2_3 == floor(q2_3) & ///
    inrange(q2_1, 1950, 2026) & q2_1 == floor(q2_1)
gen byte e4_mask_d1 = e4_mask_d0 & !missing(q2_3, q2_1) & ///
    inrange(q2_3, 1, 9) & q2_3 == floor(q2_3) & ///
    inrange(q2_1, 1950, 2026) & q2_1 == floor(q2_1)
gen byte e4_mask_common = e4_mask_r0 & e4_mask_d0
* The existing coverage evidence supports omitting a redundant domestic common fit.
* If exact equality fails, stop and amend the manifest; do not add a sixth fit.
assert e4_mask_common == e4_mask_d0
* Verify the intended core and extended rows on this locked cohort before fitting.
assert e4_mask_r1 == e4_mask_r0
assert e4_mask_d1 == e4_mask_d0
quietly count if e4_mask_r0
assert r(N) == 402
quietly count if e4_mask_d0
assert r(N) == 394
assert inlist(e4_education3, 1, 2, 3) & inlist(e4_residence4, 1, 2, 3, 4) ///
    if e4_mask_r0 | e4_mask_d0
assert !missing(e4_occupation6) if e4_mask_r1 | e4_mask_d1

tempname modelout supportout jointout matrixout probabilityout primary
local e4_open ""
capture noisily {
    file open `modelout' using "`e4_output'/e4_model_status.csv", write text
    local e4_open "`modelout'"
    file write `modelout' "model,intended_n,attempted,fit_rc,estimator_n,converged,rank,expected_rank,sample_mismatch,determined_successes,determined_failures,status" _n
    file open `supportout' using "`e4_output'/e4_support.csv", write text
    local e4_open "`e4_open' `supportout'"
    file write `supportout' "model,check,field,level,outcome,n,minimum,maximum" _n
    file open `jointout' using "`e4_output'/e4_joint_support.csv", write text
    local e4_open "`e4_open' `jointout'"
    file write `jointout' "model,focal,intended_n,lower,higher,lower_n,higher_n," ///
        "nonempty_strata,strata_with_both,n_in_strata_with_both," ///
        "strata_outside_range,n_in_strata_outside_range,support_status" _n
    file open `matrixout' using "`e4_output'/e4_native_matrices.csv", write text
    local e4_open "`e4_open' `matrixout'"
    file write `matrixout' "model,operation,matrix,row,column,row_name,column_name,value" _n
    file open `probabilityout' using "`e4_output'/e4_probabilities.csv", write text
    local e4_open "`e4_open' `probabilityout'"
    file write `probabilityout' "model,focal,record,endpoint,estimate,se,ll,ul,units,status" _n
    * Only six aggregate hypothesis records enter this temporary frame, never participants.
    frame create `primary' str8 slot str8 model str32 field double p_raw str40 status

    foreach model in R0_E4 D0_E4 R1_E4 D1_E4 R0C_E4 {
        local outcome "wp07_remit_any_digital"
        local mask "e4_mask_r0"
        if "`model'" == "D0_E4" {
            local outcome "wp07_domestic_60d"
            local mask "e4_mask_d0"
        }
        if "`model'" == "R1_E4" {
            local mask "e4_mask_r1"
        }
        if "`model'" == "D1_E4" {
            local outcome "wp07_domestic_60d"
            local mask "e4_mask_d1"
        }
        if "`model'" == "R0C_E4" {
            local mask "e4_mask_common"
        }
        quietly count if `mask'
        local intended_n = r(N)
        local prefit_ok = (`intended_n' > 0)
        local factors "e4_education3 e4_residence4"
        local continuous "wp07_iat3 wp07_iadt2 wp07_iaff2 q4"
        * Intercept plus four continuous terms; the extensions add original arrival year.
        local expected_rank = 5
        if inlist("`model'", "R1_E4", "D1_E4") {
            local factors "`factors' e4_occupation6"
            local continuous "`continuous' q2_1"
            local expected_rank = 6
        }

        * 2.2. Check outcome variation, covariate support and fixed score endpoints.
        foreach response in 0 1 {
            quietly count if `mask' & `outcome' == `response'
            file write `supportout' "`model',outcome,`outcome',,`response'," (r(N)) ",," _n
            if r(N) == 0 {
                local prefit_ok = 0
            }
        }
        if `intended_n' > 0 {
            foreach factor of local factors {
                local reference = 1
                if "`factor'" == "e4_education3" {
                    local reference = 2
                }
                if "`factor'" == "e4_occupation6" {
                    local reference = 3
                }
                quietly count if `mask' & `factor' == `reference'
                if r(N) == 0 {
                    local prefit_ok = 0
                }
                quietly levelsof `factor' if `mask', local(levels)
                local nlevels : word count `levels'
                local expected_rank = `expected_rank' + `nlevels' - 1
                foreach level of local levels {
                    foreach response in 0 1 {
                        quietly count if `mask' & `factor' == `level' & `outcome' == `response'
                        file write `supportout' "`model',factor,`factor',`level',`response'," (r(N)) ",," _n
                        if r(N) == 0 {
                            local prefit_ok = 0
                        }
                    }
                }
            }
            foreach field of local continuous {
                quietly summarize `field' if `mask', meanonly
                file write `supportout' "`model',continuous,`field',,," (r(N)) "," ///
                    %24.17g (r(min)) "," %24.17g (r(max)) _n
                if missing(r(min), r(max)) | r(min) == r(max) {
                    local prefit_ok = 0
                }
            }
        }
        if `intended_n' <= `expected_rank' {
            local prefit_ok = 0
        }

        * Endpoint counts are fixed and recorded before fitting, never chosen from p-values.
        * A missing endpoint blocks only its probability comparison, not the coefficient test.
        foreach focal in wp07_iat3 wp07_iadt2 wp07_iaff2 {
            local lower = 0.5
            local higher = 0.75
            if "`focal'" == "wp07_iaff2" {
                local higher = 1
            }
            quietly count if `mask' & `focal' == `lower'
            local lower_n = r(N)
            quietly count if `mask' & `focal' == `higher'
            local higher_n = r(N)
            local endpoint_ok = (`lower_n' > 0 & `higher_n' > 0)
            foreach endpoint in `lower' `higher' {
                foreach response in 0 1 {
                    quietly count if `mask' & `focal' == `endpoint' & `outcome' == `response'
                    file write `supportout' "`model',endpoint,`focal',`endpoint',`response'," (r(N)) ",," _n
                }
            }

            * Screen each education-residence stratum without trimming the margins sample.
            local nonempty = 0
            local both_strata = 0
            local both_n = 0
            local outside_strata = 0
            local outside_n = 0
            forvalues education = 1/3 {
                forvalues residence = 1/4 {
                    local stratum "`mask' & e4_education3 == `education' & e4_residence4 == `residence'"
                    quietly summarize `focal' if `stratum', meanonly
                    local stratum_n = r(N)
                    if `stratum_n' == 0 {
                        continue
                    }
                    local nonempty = `nonempty' + 1
                    if `lower' < r(min) | `higher' > r(max) {
                        local outside_strata = `outside_strata' + 1
                        local outside_n = `outside_n' + `stratum_n'
                        continue
                    }
                    quietly count if `stratum' & `focal' == `lower'
                    local stratum_lower_n = r(N)
                    quietly count if `stratum' & `focal' == `higher'
                    if `stratum_lower_n' > 0 & r(N) > 0 {
                        local both_strata = `both_strata' + 1
                        local both_n = `both_n' + `stratum_n'
                    }
                }
            }
            local support_status "BOTH_IN_ALL_SCREENED_STRATA"
            if `intended_n' == 0 {
                local support_status "NO_INTENDED_SAMPLE"
            }
            else if !`endpoint_ok' {
                local support_status "ENDPOINT_ABSENT"
            }
            else if `both_strata' == 0 {
                local support_status "NO_STRATUM_WITH_BOTH"
            }
            else if `both_strata' < `nonempty' {
                local support_status "LIMITED_EXACT_SUPPORT"
            }
            file write `jointout' "`model',`focal'," (`intended_n') ",`lower',`higher'," ///
                (`lower_n') "," (`higher_n') "," (`nonempty') "," (`both_strata') "," ///
                (`both_n') "," (`outside_strata') "," (`outside_n') ",`support_status'" _n

            if "`focal'" == "wp07_iat3" {
                local iat_endpoint_ok = `endpoint_ok'
            }
            if "`focal'" == "wp07_iadt2" {
                local iadt_endpoint_ok = `endpoint_ok'
            }
            if "`focal'" == "wp07_iaff2" {
                local iaff_endpoint_ok = `endpoint_ok'
            }
        }

        * 2.3. Fit the named model once, then verify the estimation sample and covariance.
        local attempted = 0
        local fit_rc = .
        local estimator_n = .
        local converged = .
        local model_rank = .
        local mismatch = .
        local determined_successes = .
        local determined_failures = .
        local model_ok = 0
        local model_status "PREFIT_SUPPORT_BLOCKED"
        if `prefit_ok' {
            local attempted = 1
            if "`model'" == "R0_E4" {
                capture noisily logit wp07_remit_any_digital c.wp07_iat3 c.wp07_iadt2 c.wp07_iaff2 ///
                    c.q4 ib2.e4_education3 ib1.e4_residence4 if e4_mask_r0, vce(robust) iterate(100) level(95)
                local fit_rc = _rc
            }
            if "`model'" == "D0_E4" {
                capture noisily logit wp07_domestic_60d c.wp07_iat3 c.wp07_iadt2 c.wp07_iaff2 ///
                    c.q4 ib2.e4_education3 ib1.e4_residence4 if e4_mask_d0, vce(robust) iterate(100) level(95)
                local fit_rc = _rc
            }
            if "`model'" == "R1_E4" {
                capture noisily logit wp07_remit_any_digital c.wp07_iat3 c.wp07_iadt2 c.wp07_iaff2 ///
                    c.q4 ib2.e4_education3 ib1.e4_residence4 ib3.e4_occupation6 c.q2_1 ///
                    if e4_mask_r1, vce(robust) iterate(100) level(95)
                local fit_rc = _rc
            }
            if "`model'" == "D1_E4" {
                capture noisily logit wp07_domestic_60d c.wp07_iat3 c.wp07_iadt2 c.wp07_iaff2 ///
                    c.q4 ib2.e4_education3 ib1.e4_residence4 ib3.e4_occupation6 c.q2_1 ///
                    if e4_mask_d1, vce(robust) iterate(100) level(95)
                local fit_rc = _rc
            }
            if "`model'" == "R0C_E4" {
                capture noisily logit wp07_remit_any_digital c.wp07_iat3 c.wp07_iadt2 c.wp07_iaff2 ///
                    c.q4 ib2.e4_education3 ib1.e4_residence4 if e4_mask_common, vce(robust) iterate(100) level(95)
                local fit_rc = _rc
            }
            local model_status "FIT_ERROR"
            if `fit_rc' == 0 {
                local estimator_n = e(N)
                local converged = e(converged)
                local model_rank = e(rank)
                * These counts can reflect numerical extremes, not only nonfinite MLEs.
                local determined_successes = e(N_cds)
                local determined_failures = e(N_cdf)
                local model_ok = (e(converged) == 1 & e(rank) == `expected_rank')
                if "`e(cmd)'" != "logit" | "`e(depvar)'" != "`outcome'" | "`e(vce)'" != "robust" {
                    local model_ok = 0
                }
                quietly count if e(sample) != `mask'
                local mismatch = r(N)
                if `mismatch' != 0 | e(N) != `intended_n' {
                    local model_ok = 0
                }
                matrix e4_B = e(b)
                matrix e4_V = e(V)
                local native_matrices "e4_B e4_V"
                * Retain a perfect-predictor rules matrix if Stata supplies one.
                capture matrix e4_RULES = e(rules)
                if _rc == 0 {
                    local native_matrices "`native_matrices' e4_RULES"
                    forvalues i = 1/`=rowsof(e4_RULES)' {
                        forvalues j = 1/`=colsof(e4_RULES)' {
                            if !missing(e4_RULES[`i',`j']) & e4_RULES[`i',`j'] != 0 {
                                local model_ok = 0
                            }
                        }
                    }
                }
                * All coefficients/covariances must be finite; focal SEs must be positive.
                forvalues j = 1/`=colsof(e4_B)' {
                    if missing(e4_B[1,`j']) {
                        local model_ok = 0
                    }
                }
                forvalues i = 1/`=rowsof(e4_V)' {
                    forvalues j = 1/`=colsof(e4_V)' {
                        if missing(e4_V[`i',`j']) {
                            local model_ok = 0
                        }
                    }
                }
                foreach focal in wp07_iat3 wp07_iadt2 wp07_iaff2 {
                    if missing(_se[`focal']) | _se[`focal'] <= 0 {
                        local model_ok = 0
                    }
                }
                * Native matrix cells retain full precision, including unsuccessful fits.
                foreach matrix of local native_matrices {
                    local rows : rowfullnames `matrix'
                    local columns : colfullnames `matrix'
                    forvalues i = 1/`=rowsof(`matrix')' {
                        local rowname : word `i' of `rows'
                        forvalues j = 1/`=colsof(`matrix')' {
                            local colname : word `j' of `columns'
                            file write `matrixout' "`model',fit,`matrix',`i',`j',`rowname',`colname'," ///
                                %24.17g (`matrix'[`i',`j']) _n
                        }
                    }
                }
                local model_status "POSTFIT_REVIEW_BLOCKED"
                if `model_ok' {
                    estimates store `model'
                    local model_status "ACCEPTED_WORKING_MODEL"
                }
            }
        }
        file write `modelout' "`model'," (`intended_n') "," (`attempted') "," (`fit_rc') "," ///
            (`estimator_n') "," (`converged') "," (`model_rank') "," (`expected_rank') "," ///
            (`mismatch') "," (`determined_successes') "," (`determined_failures') ",`model_status'" _n

        * 2.4. Test the three coefficient nulls in each core; no tests from extensions enter Holm.
        if inlist("`model'", "R0_E4", "D0_E4") {
            foreach focal in wp07_iat3 wp07_iadt2 wp07_iaff2 {
                local family_prefix "R"
                if "`model'" == "D0_E4" {
                    local family_prefix "D"
                }
                local construct "IAT"
                if "`focal'" == "wp07_iadt2" {
                    local construct "IADT"
                }
                if "`focal'" == "wp07_iaff2" {
                    local construct "IAFF"
                }
                local p_raw = .
                local test_status "MODEL_UNAVAILABLE"
                if `model_ok' {
                    capture test `focal'
                    local test_rc = _rc
                    local test_status "TEST_UNAVAILABLE"
                    if `test_rc' == 0 {
                        local test_p : display %24.17g r(p)
                        local test_df = r(df)
                        if `test_df' == 1 & !missing(`test_p') & inrange(`test_p', 0, 1) {
                            local p_raw "`test_p'"
                            local test_status "AVAILABLE_CONDITIONAL_WORKING_VCE"
                        }
                    }
                }
                frame post `primary' ("`family_prefix'_`construct'") ("`model'") ///
                    ("`focal'") (`p_raw') ("`test_status'")
            }
        }

        * 2.5. Standardize each comparison over the verified fitted sample.
        foreach focal in wp07_iat3 wp07_iadt2 wp07_iaff2 {
            local lower = 0.5
            local higher = 0.75
            local endpoint_ok = `iat_endpoint_ok'
            if "`focal'" == "wp07_iadt2" {
                local endpoint_ok = `iadt_endpoint_ok'
            }
            if "`focal'" == "wp07_iaff2" {
                local higher = 1
                local endpoint_ok = `iaff_endpoint_ok'
            }
            local contrast_status "MODEL_UNAVAILABLE"
            local probability_ok = 0
            if `model_ok' {
                local contrast_status "ENDPOINT_UNAVAILABLE"
                if `endpoint_ok' {
                    estimates restore `model'
                    if "`focal'" == "wp07_iat3" {
                        capture noisily margins, at(wp07_iat3=(0.5 0.75)) predict(pr) vce(delta) ///
                            level(95) pwcompare(effects) mcompare(noadjust)
                        local margins_rc = _rc
                    }
                    if "`focal'" == "wp07_iadt2" {
                        capture noisily margins, at(wp07_iadt2=(0.5 0.75)) predict(pr) vce(delta) ///
                            level(95) pwcompare(effects) mcompare(noadjust)
                        local margins_rc = _rc
                    }
                    if "`focal'" == "wp07_iaff2" {
                        capture noisily margins, at(wp07_iaff2=(0.5 1)) predict(pr) vce(delta) ///
                            level(95) pwcompare(effects) mcompare(noadjust)
                        local margins_rc = _rc
                    }
                    local contrast_status "MARGINS_UNAVAILABLE"
                    if `margins_rc' == 0 {
                        * Copy all declared returns before another r-class command can replace them.
                        capture {
                            matrix e4_MN = (r(N))
                            matrix e4_AT = r(at)
                            matrix e4_MB = r(b)
                            matrix e4_MV = r(V)
                            matrix e4_ME = r(error)
                            matrix e4_MT = r(table)
                            matrix e4_DB = r(b_vs)
                            matrix e4_DV = r(V_vs)
                            matrix e4_DE = r(error_vs)
                            matrix e4_DT = r(table_vs)
                            matrix e4_L = r(L)
                        }
                        local return_rc = _rc
                        local contrast_status "MATRIX_CAPTURE_UNAVAILABLE"
                        if `return_rc' == 0 {
                            capture matrix e4_MN_AT = r(_N)
                            local has_endpoint_counts = (_rc == 0)
                            local margins_matrices e4_MN e4_AT e4_MB e4_MV e4_ME e4_MT ///
                                e4_DB e4_DV e4_DE e4_DT e4_L
                            if `has_endpoint_counts' {
                                local margins_matrices "`margins_matrices' e4_MN_AT"
                            }
                            foreach matrix of local margins_matrices {
                                local rows : rowfullnames `matrix'
                                local columns : colfullnames `matrix'
                                forvalues i = 1/`=rowsof(`matrix')' {
                                    local rowname : word `i' of `rows'
                                    forvalues j = 1/`=colsof(`matrix')' {
                                        local colname : word `j' of `columns'
                                        file write `matrixout' "`model',`focal',`matrix',`i',`j',`rowname',`colname'," ///
                                            %24.17g (`matrix'[`i',`j']) _n
                                    }
                                }
                            }
                            * Do not assume a positional difference or override Stata's estimability.
                            local at_column = colnumb(e4_AT, "`focal'")
                            local b_row = rownumb(e4_MT, "b")
                            local se_row = rownumb(e4_MT, "se")
                            local ll_row = rownumb(e4_MT, "ll")
                            local ul_row = rownumb(e4_MT, "ul")
                            local db_row = rownumb(e4_DT, "b")
                            local dse_row = rownumb(e4_DT, "se")
                            local dll_row = rownumb(e4_DT, "ll")
                            local dul_row = rownumb(e4_DT, "ul")
                            local contrast_status "MATRIX_LAYOUT_OR_ESTIMABILITY_HOLD"
                            local layout_ok = !missing(`at_column', `b_row', `se_row', `ll_row', ///
                                `ul_row', `db_row', `dse_row', `dll_row', `dul_row')
                            if rowsof(e4_AT) != 2 | colsof(e4_MB) != 2 | colsof(e4_MT) != 2 | ///
                                colsof(e4_ME) != 2 | rowsof(e4_L) != 1 | colsof(e4_L) != 2 | ///
                                colsof(e4_DT) != 1 | colsof(e4_DE) != 1 {
                                local layout_ok = 0
                            }
                            if `layout_ok' {
                                if e4_AT[1,`at_column'] != `lower' | e4_AT[2,`at_column'] != `higher' | ///
                                    e4_L[1,1] != -1 | e4_L[1,2] != 1 | ///
                                    e4_ME[1,1] != 0 | e4_ME[1,2] != 0 | e4_DE[1,1] != 0 {
                                    local layout_ok = 0
                                }
                            }
                            if `layout_ok' {
                                local full_sample = 0
                                if `has_endpoint_counts' {
                                    local full_sample = (rowsof(e4_MN_AT) == 1 & colsof(e4_MN_AT) == 2)
                                }
                                if `full_sample' {
                                    local full_sample = (e4_MN[1,1] == `estimator_n' & ///
                                        e4_MN_AT[1,1] == `estimator_n' & e4_MN_AT[1,2] == `estimator_n')
                                }
                                if !`full_sample' {
                                    local contrast_status "MARGINS_SAMPLE_SIZE_HOLD"
                                    local layout_ok = 0
                                }
                            }
                            if `layout_ok' {
                                local probability_ok = 1
                                foreach row in `b_row' `se_row' `ll_row' `ul_row' {
                                    if missing(e4_MT[`row',1], e4_MT[`row',2]) {
                                        local probability_ok = 0
                                    }
                                }
                                foreach row in `db_row' `dse_row' `dll_row' `dul_row' {
                                    if missing(e4_DT[`row',1]) {
                                        local probability_ok = 0
                                    }
                                }
                                if e4_MT[`se_row',1] < 0 | e4_MT[`se_row',2] < 0 | ///
                                    e4_DT[`dse_row',1] < 0 {
                                    local probability_ok = 0
                                }
                                if `probability_ok' {
                                    local contrast_status "AVAILABLE_POINTWISE_WORKING_VCE"
                                }
                            }
                        }
                    }
                }
            }
            if `probability_ok' {
                file write `probabilityout' "`model',`focal',lower,`lower'," ///
                    %24.17g (e4_MT[`b_row',1]) "," %24.17g (e4_MT[`se_row',1]) "," ///
                    %24.17g (e4_MT[`ll_row',1]) "," %24.17g (e4_MT[`ul_row',1]) ///
                    ",probability,`contrast_status'" _n
                file write `probabilityout' "`model',`focal',higher,`higher'," ///
                    %24.17g (e4_MT[`b_row',2]) "," %24.17g (e4_MT[`se_row',2]) "," ///
                    %24.17g (e4_MT[`ll_row',2]) "," %24.17g (e4_MT[`ul_row',2]) ///
                    ",probability,`contrast_status'" _n
                * Delta-method bounds are not clipped; these are pointwise, not Holm intervals.
                file write `probabilityout' "`model',`focal',higher_minus_lower,," ///
                    %24.17g (100*e4_DT[`db_row',1]) "," %24.17g (100*e4_DT[`dse_row',1]) "," ///
                    %24.17g (100*e4_DT[`dll_row',1]) "," %24.17g (100*e4_DT[`dul_row',1]) ///
                    ",percentage_points,`contrast_status'" _n
            }
            else {
                file write `probabilityout' "`model',`focal',lower,`lower',.,.,.,.,probability,`contrast_status'" _n
                file write `probabilityout' "`model',`focal',higher,`higher',.,.,.,.,probability,`contrast_status'" _n
                file write `probabilityout' "`model',`focal',higher_minus_lower,,.,.,.,.,percentage_points,`contrast_status'" _n
            }
        }
    }

    * BEGIN E4 HOLM
    * Missing tests reserve unrejected slots: family size stays six, not observed k.
    frame `primary': assert _N == 6
    frame `primary': isid slot
    frame `primary': assert missing(p_raw) | inrange(p_raw, 0, 1)
    frame `primary': sort p_raw slot
    frame `primary': gen byte rank = _n if !missing(p_raw)
    frame `primary': gen double p_holm = min(1, (7 - rank)*p_raw) if !missing(p_raw)
    frame `primary': replace p_holm = max(p_holm, p_holm[_n - 1]) if _n > 1 & !missing(p_raw)
    frame `primary': assert missing(p_holm) == missing(p_raw)
    frame `primary': sort slot
    frame `primary': format p_raw p_holm %24.17g
    frame `primary': export delimited using "`e4_output'/e4_primary_tests.csv", datafmt
    * END E4 HOLM

    * Signatures cover named source inputs; masks/results never remove or reorder women.
    assert _N == `e4_admitted_n'
    assert e4_row_order == _n
    _datasignature `e4_raw'
    assert "`r(datasignature)'" == "`e4_signature'"
}
local e4_run_rc = _rc
* Close only this block's opened files, retaining partial output on every failure.
foreach handle of local e4_open {
    capture file close `handle'
    local e4_close_rc = _rc
    if `e4_run_rc' == 0 & `e4_close_rc' != 0 {
        local e4_run_rc = `e4_close_rc'
    }
}
capture frame drop `primary'
if `e4_run_rc' != 0 {
    exit `e4_run_rc'
}
* END E4 BODY

* HISTORICAL REGRESSION/LCA RETIREMENT
* No old model/interaction/supplementary grid, H1/k4 default or class assignment.
* No replacement IURD/IEDF score, survey/RDS weight or all-index Pearson matrix.
* Appendix C2 remains on hold. Working model results are not release approval.

