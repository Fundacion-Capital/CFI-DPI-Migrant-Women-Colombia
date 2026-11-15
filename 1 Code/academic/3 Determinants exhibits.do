/*
Digital Payments, Partial Inclusion | Determinants exhibits
Release-candidate displays from audited aggregate ledgers only. No estimation.
*/
version 16
args ledgers out
if "`ledgers'" == "" | "`out'" == "" | c(N) != 0 | c(k) != 0 {
    exit 198
}
set more off
set varabbrev off
quietly findfile scheme-plotplain.scheme
foreach name in det_models.tex det_contrasts_core.tex det_contrasts_checks.tex ///
    det_wald.tex det_coefficients.tex det_coefficients_full_restricted.tex det_contrasts.csv det_figure_note.tex ///
    det_contrasts_core.pdf det_contrasts_all.pdf det_contrasts_core_slides.png det_contrasts_all_slides.png {
    confirm new file "`out'/`name'"
}
tempname tex screens variances chart
local br "_char(92) _char(92)"
local fitnotes "R0/D0 are the remittance and domestic cores; R1/D1 add occupation and arrival year on the same rows as their cores. R0C uses the remittance core specification on the common sample, which equals the D0 sample."
local infnotes "Intervals are pointwise; they use the delta method and the independent-record sandwich covariance. Unrecorded household or referral dependence is not accounted for. Associations are descriptive, not causal."
local notestart "\par\smallskip\begin{minipage}{0.96\linewidth}\footnotesize\raggedright Notes:"
local noteend "\end{minipage}\end{table}"
local endtab "\bottomrule\end{tabular}"

* Model roles and verified sample sizes.
import delimited using "`ledgers'/e4_model_status.csv", varnames(1) clear
assert _N == 5 & status == "ACCEPTED_WORKING_MODEL" & sample_mismatch == 0
file open `tex' using "`out'/det_models.tex", write text
file write `tex' "\begin{table}[tbp]\centering" _n ///
    "\caption{Determinants models and estimation samples}\label{tab:det-models}" _n ///
    "\begin{tabular}{lrrr}\toprule Model & Intended N & Fitted N & Rank " `br' _n "\midrule" _n
forvalues i = 1/5 {
    file write `tex' (subinstr(model[`i'], "_E4", "", .)) " & " (intended_n[`i']) " & " ///
        (estimator_n[`i']) " & " (rank[`i']) " " `br' _n
}
file write `tex' "`endtab'" _n "`notestart' `fitnotes' All five unweighted logit models converged and retained their intended rows. `noteend'" _n
file close `tex'

* Native logit coefficients and their covariance diagonal, not probability differences.
import delimited using "`ledgers'/e4_native_matrices.csv", varnames(1) asdouble clear
keep if matrix == "e4_B" | (matrix == "e4_V" & row == column)
gen str40 term = substr(column_name, strpos(column_name, ":") + 1, .)
frame put model term value if matrix == "e4_V", into(`variances')
frame `variances': rename value variance
keep if matrix == "e4_B"
frlink 1:1 model term, frame(`variances')
frget variance, from(`variances')
assert !missing(value, variance)
drop if strpos(term, "b.")
local terms "wp07_iat3 wp07_iadt2 wp07_iaff2 q4 1.e4_education3 3.e4_education3 2.e4_residence4 3.e4_residence4 4.e4_residence4 1.e4_occupation6 4.e4_occupation6 5.e4_occupation6 7.e4_occupation6 9.e4_occupation6 q2_1 _cons"
local labels `" "IAT3: digital access" "IADT2: reported skills" "IAFF2: own-name conditions" "Age (years)" "Below completed secondary" "Postsecondary study" "Cali" "Medellin" "Other recorded residence" "Employer/independent" "Paid domestic worker" "Student/pensioner/not working" "Unpaid family worker" "Other occupation" "Year of first arrival" "Constant" "'
* The shared exhibit omits level-specific coefficients for potentially rare groups.
foreach panel in coefficients coefficients_full_restricted {
    local nterms = 3
    if "`panel'" == "coefficients_full_restricted" local nterms = 16
    file open `tex' using "`out'/det_`panel'.tex", write text
    file write `tex' "\begin{table}[tbp]\centering\small" _n ///
        "\caption{Unweighted logit coefficients and standard errors}\label{tab:det-`panel'}" _n ///
        "\begin{tabular}{lrrrrr}\toprule Predictor & R0 & D0 & R1 & D1 & R0C " `br' _n "\midrule" _n
    forvalues k = 1/`nterms' {
        local term : word `k' of `terms'
        local label : word `k' of `labels'
        file write `tex' "`label'"
        foreach model in R0 D0 R1 D1 R0C {
            quietly summarize value if model == "`model'_E4" & term == "`term'", meanonly
            if r(N) == 1 {
                local b = r(mean)
                quietly summarize variance if model == "`model'_E4" & term == "`term'", meanonly
                file write `tex' " & \shortstack{" %7.3f (`b') `br' "(" %7.3f (sqrt(r(mean))) ")}"
            }
            else file write `tex' " & ---"
        }
        file write `tex' " " `br' _n
    }
    local context "The table shows the three focal measures only. All models adjust for age, education and residence; R1/D1 also adjust for occupation and year of arrival."
    if "`panel'" == "coefficients_full_restricted" {
        local context "Restricted full coefficient table. Completed secondary, Bogota and employee/worker are the reference levels. Dashes mark terms not in a specification."
    }
    file write `tex' "`endtab'" _n "`notestart' `context' Standard errors in parentheses use the independent-record sandwich covariance; no significance stars. `noteend'" _n
    file close `tex'
}
frame drop `variances'

* The fixed six tests are coefficient tests, not tests of differences across models.
import delimited using "`ledgers'/e4_primary_tests.csv", varnames(1) asdouble clear
assert _N == 6
gen str5 score = upper(substr(field, 6, .))
gen byte spec = (model == "D0_E4")
gen byte order = cond(score == "IAT3", 1, cond(score == "IADT2", 2, 3))
sort spec order
file open `tex' using "`out'/det_wald.tex", write text
file write `tex' "\begin{table}[tbp]\centering" _n ///
    "\caption{Six core coefficient-null tests}\label{tab:det-wald}" _n ///
    "\begin{tabular}{llrr}\toprule Model & Measure & Raw p & Holm p " `br' _n "\midrule" _n
forvalues i = 1/6 {
    file write `tex' (subinstr(model[`i'], "_E4", "", .)) " & " (score[`i']) " & " ///
        %10.4g (p_raw[`i']) " & " %10.4g (p_holm[`i']) " " `br' _n
}
file write `tex' "`endtab'" _n "`notestart' One-degree-of-freedom Wald tests use the fitted logit coefficient of each of three focal scores in each of the two core models. Holm adjusts these six tests only, not the probability-contrast intervals. `noteend'" _n
file close `tex'

* Match all 15 differences to the endpoint support screen on model and score.
frame create `screens'
frame `screens': import delimited using "`ledgers'/e4_joint_support.csv", varnames(1) asdouble clear
import delimited using "`ledgers'/e4_probabilities.csv", varnames(1) asdouble clear
keep if record == "higher_minus_lower"
frlink 1:1 model focal, frame(`screens')
frget intended_n lower higher lower_n higher_n nonempty_strata strata_with_both ///
    strata_outside_range support_status, from(`screens')
assert _N == 15 & !missing(`screens')
gen byte model_order = cond(model == "R0_E4", 1, cond(model == "D0_E4", 2, ///
    cond(model == "R1_E4", 3, cond(model == "D1_E4", 4, 5))))
replace model = subinstr(model, "_E4", "", .)
replace focal = upper(substr(focal, 6, .))
gen byte score_order = cond(focal == "IAT3", 1, cond(focal == "IADT2", 2, 3))
sort model_order score_order
gen byte plotrow = _n
rename (nonempty_strata strata_with_both strata_outside_range) ///
    (screened_strata both_screened_strata outside_screened_strata)
gen byte limited = support_status == "LIMITED_EXACT_SUPPORT"
gen str24 support_flag = cond(limited, "Limited exact support", "No screened gap")
* Keep small stratum record totals in the restricted ledgers, not the exhibits.
assert lower_n >= 10 & lower_n < . & higher_n >= 10 & higher_n < . & both_screened_strata > 0
assert status == "AVAILABLE_POINTWISE_WORKING_VCE" & inlist(support_status, ///
    "BOTH_IN_ALL_SCREENED_STRATA", "LIMITED_EXACT_SUPPORT")
format estimate se ll ul %24.17g
export delimited model focal intended_n lower higher estimate se ll ul lower_n higher_n ///
    both_screened_strata screened_strata outside_screened_strata support_flag ///
    using "`out'/det_contrasts.csv", datafmt

local supportnotes "Strata cross grouped education and recorded residence. The support fraction counts strata containing both exact endpoints. Outside counts strata where either endpoint is beyond the observed range. Full screened coverage does not establish overlap on all covariates."
local scorenotes "IAT3: reported phone/internet/data access; IADT2: reported transfer ability and fraud-avoidance confidence; IAFF2: own-name address proof and phone registration. The contrast is 0.50 to 0.75 for IAT3 and IADT2, and 0.50 (one condition) to 1.00 (both) for IAFF2."
foreach panel in core checks {
    local first = 1
    local last = 6
    local title "Core models"
    if "`panel'" == "checks" {
        local first = 7
        local last = 15
        local title "Extensions and common-sample check"
    }
    file open `tex' using "`out'/det_contrasts_`panel'.tex", write text
    file write `tex' "\begin{table}[tbp]\centering\small" _n ///
        "\caption{Model-standardized probability differences: `title'}\label{tab:det-`panel'}" _n ///
        "\begin{tabular}{llrrrrr}\toprule" _n ///
        "Model & Measure & Difference & 95\% interval & Endpoint N & Support & Outside " `br' _n "\midrule" _n
    forvalues i = `first'/`last' {
        local mark = cond(limited[`i'], "\textsuperscript{a}", "")
        file write `tex' (model[`i']) " & " (focal[`i']) " & " %6.2f (estimate[`i']) " & [" ///
            %6.2f (ll[`i']) ", " %6.2f (ul[`i']) "] & " (lower_n[`i']) "/" (higher_n[`i']) ///
            " & " (both_screened_strata[`i']) "/" (screened_strata[`i']) "`mark' & " (outside_screened_strata[`i']) " " `br' _n
    }
    file write `tex' "`endtab'" _n ///
        "`notestart' Differences and intervals are in percentage points, averaged over the entire fitted sample. Endpoint counts are lower/higher. \textsuperscript{a}Limited exact support. `supportnotes' `scorenotes' `infnotes' `noteend'" _n
    file close `tex'
}
file open `tex' using "`out'/det_figure_note.tex", write text
file write `tex' "Model-standardized higher-minus-lower probability differences in percentage points, not trimmed to supported strata. `fitnotes' `scorenotes' Open markers indicate limited exact support. `supportnotes' `infnotes'" _n
file close `tex'

* Outline markers flag limited support even when printed in grayscale.
foreach panel in core all {
    local last = cond("`panel'" == "core", 6, 15)
    local ymin = `last' + .5
    local height = cond("`panel'" == "core", 3.4, 6.7)
    local labels ""
    forvalues i = 1/`last' {
        local row = model[`i'] + ": " + focal[`i']
        local labels `"`labels' `i' "`row'""'
    }
    local title "All five models"
    if "`panel'" == "core" local title "Two core models"
    local style scheme(plotplain) xsize(8) ysize(`height') ///
        yscale(reverse range(0.5 `ymin')) ylabel(`labels', angle(horizontal) labsize(small) nogrid) ///
        xlabel(-10(5)25, labsize(small)) xline(0, lcolor(gs9) lpattern(dash)) ///
        xtitle("Adjusted probability difference (percentage points)", size(small)) ytitle("") ///
        legend(order(3 "No screened gap" 4 "Limited exact support") position(6) ring(1) rows(1) size(small)) ///
        graphregion(margin(medsmall))
    local layers (rcap ll ul plotrow if plotrow <= `last' & !limited, horizontal lcolor(navy)) ///
        (rcap ll ul plotrow if plotrow <= `last' & limited, horizontal lcolor(gs6)) ///
        (scatter plotrow estimate if plotrow <= `last' & !limited, msymbol(O) mcolor(navy)) ///
        (scatter plotrow estimate if plotrow <= `last' & limited, msymbol(Oh) mcolor(gs4))
    twoway `layers', `style' name(`chart', replace)
    graph export "`out'/det_contrasts_`panel'.pdf", name(`chart') as(pdf) width(6.4) fontface(Arial)
    twoway `layers', `style' name(`chart', replace) title("`title': reported digital participation") ///
        note("Differences average over the full fitted sample; bars are pointwise 95% intervals." ///
        "Open markers: at least one education-residence stratum lacks an exact endpoint." ///
        "R = digital retention/use of remittances; D = 60-day domestic participation. Not causal.", size(vsmall))
    graph export "`out'/det_contrasts_`panel'_slides.png", name(`chart') as(png) width(2400)
    graph drop `chart'
}
frame drop `screens'
clear
