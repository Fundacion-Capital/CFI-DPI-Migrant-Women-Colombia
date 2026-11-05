* WP07 regression source revision v1 — 5 November 2026.
* Disabled review copy; no Stata execution or scientific adoption.
exit 198
* Four historical equations and their original prediction grids are unchanged.
* Percentiles are computed from each source field before its fit, not e(sample).
* Preserve that denominator distinction; support at grid points is unverified.
* The I4 IEDF percentiles are computed historically but not used in its grid.
* Original plots suppress intervals (noci); this is not an uncertainty endorsement.
* Margins are model-based adjusted predictions, not causal intervention effects.
* Historical source: 2 Analysis_CFI DPI Migrant Women Colombia.do
* Source lines 1705-1826. See the companion README and audit ledger.
version 19
set varabbrev off
confirm numeric variable age_cat q3 ivs_score iat_score icdp_score iaff_score oqi_score_01 ///
    IEDF IEH years_in_col formal_remittance ietr_score_01 iurd_score_01 ICPF, exact
* Local palettes are repeated here because do-file locals do not cross scope.
local blue "58 103 177"
local orange "245 130 48"
local gray "167 169 172"

* BEGIN HISTORICAL COMMAND BODY
summ ivs_score, detail
local ivs_p25 = r(p25)
local ivs_p50 = r(p50)
local ivs_p75 = r(p75)

regress iurd_score_01 i.age_cat i.q3 ///
    c.ivs_score##c.iat_score ///
    c.icdp_score c.iaff_score c.oqi_score_01 c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Interactions.doc", replace ///
    word dec(3) ctitle("I1: IVS x IAT -> IURD") ///
    addtext(City FE, Yes, Robust SE, Yes)

margins, at(iat_score=(0(.1)1) ivs_score=(`ivs_p25' `ivs_p50' `ivs_p75'))
marginsplot, ///
    recast(line) noci ///
    plot1opts(lcolor("`blue'") lwidth(medthick)) ///
    plot2opts(lcolor("`gray'") lwidth(medthick)) ///
    plot3opts(lcolor("`orange'") lwidth(medthick)) ///
    title("") ///
    xtitle("Digital access (IAT)", size(small)) ///
    ytitle("Predicted digital use intensity (IURD)", size(small)) ///
    legend(order(1 "Low vulnerability (p25)" 2 "Median vulnerability (p50)" 3 "High vulnerability (p75)") ///
    rows(1) pos(6) size(small) region(lcolor(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig49_interaction_iurd_ivs_iat.png", replace



* 6.2 Interaction 2: Years in Colombia × IAFF -> Formal remittance     *

summ years_in_col, detail
local years_p25 = r(p25)
local years_p50 = r(p50)
local years_p75 = r(p75)

logit formal_remittance i.age_cat i.q3 ///
    c.years_in_col##c.iaff_score ///
    c.iat_score c.icdp_score c.oqi_score_01 c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Interactions.doc", append ///
    word dec(3) eform ctitle("I2: Years x IAFF -> Formal channel") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

margins, at(iaff_score=(.25(.25)1) years_in_col=(`years_p25' `years_p50' `years_p75')) predict(pr)
marginsplot, ///
    recast(line) noci ///
    plot1opts(lcolor("`blue'") lwidth(medthick)) ///
    plot2opts(lcolor("`gray'") lwidth(medthick)) ///
    plot3opts(lcolor("`orange'") lwidth(medthick)) ///
    title("") ///
    xtitle("Formal financial access (IAFF)", size(small)) ///
    ytitle("Predicted probability of formal digital remittance channel", size(small)) ///
    legend(order(1 "Shorter tenure (p25)" 2 "Median tenure (p50)" 3 "Longer tenure (p75)") ///
    rows(1) pos(6) size(small) region(lcolor(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig50_interaction_formal_years_iaff.png", replace



* 6.3 Interaction 3: ICDP × OQI -> Transactional experience        *

summ icdp_score, detail
local icdp_p25 = r(p25)
local icdp_p75 = r(p75)

regress ietr_score_01 i.age_cat i.q3 ///
    c.icdp_score##c.oqi_score_01 ///
    c.ivs_score c.iaff_score c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Interactions.doc", append ///
    word dec(3) ctitle("I3: ICDP x OQI -> IETR") ///
    addtext(City FE, Yes, Robust SE, Yes)

margins, at(oqi_score_01=(0(.1)1) icdp_score=(`icdp_p25'  `icdp_p75'))
marginsplot, ///
    recast(line) noci ///
    plot1opts(lcolor("`blue'") lwidth(medthick)) ///
    plot2opts(lcolor("`gray'") lwidth(medthick)) ///
    title("") ///
    xtitle("Onboarding quality (OQI)", size(small)) ///
    ytitle("Predicted transactional experience (IETR)", size(small)) ///
    legend(order(1 "Low competence (p25)" 2 "High competence (p75)") ///
    rows(1) pos(6) size(small) region(lcolor(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig51_interaction_ietr_icdp_oqi.png", replace



* 6.4 Interaction 4: IEDF × ICPF -> IURD                           *

summ IEDF, detail
local iedf_p25 = r(p25)
local iedf_p50 = r(p50)
local iedf_p75 = r(p75)

regress iurd_score_01 i.age_cat i.q3 ///
    c.IEDF##c.ICPF ///
    c.ivs_score c.iat_score c.icdp_score c.iaff_score c.oqi_score_01 c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Interactions.doc", append ///
    word dec(3) ctitle("I4: IEDF x ICPF -> IURD") ///
    addtext(City FE, Yes, Robust SE, Yes)

margins, at(IEDF=(0(10)100) ICPF=(25 50 75))
marginsplot, ///
    recast(line) noci ///
    plot1opts(lcolor("`blue'") lwidth(medthick)) ///
    plot2opts(lcolor("`gray'") lwidth(medthick)) ///
    plot3opts(lcolor("`orange'") lwidth(medthick)) ///
    title("") ///
    xtitle("Fraud exposure and recourse failure (IEDF)", size(small)) ///
    ytitle("Predicted digital use intensity (IURD)", size(small)) ///
    legend(order(1 "Low trust climate (25)" 2 "Mid trust climate (50)" 3 "High trust climate (75)") ///
    rows(1) pos(6) size(small) region(lcolor(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig52_interaction_iurd_iedf_icpf.png", replace
