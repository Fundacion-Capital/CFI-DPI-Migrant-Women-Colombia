* WP07 regression source revision v1 — 5 November 2026.
* Disabled review copy; no Stata execution or scientific adoption.
exit 198
* Requires the source-bound historical setup; not an academic prepared dataset.
* All 45 equations retain their original outcome, term order and robust VCE.
* Model-specific complete observations determine each fitted sample; no common
* sample is imposed. Actual e(sample), omissions and N are not verified here.
* i.q3 uses the historically pooled geography, not version-aware academic geography.
* D_z models are preserved specifications, not necessarily rescalings of D.
* Table numbers/labels, OR exports, AME posting and figure settings stay historical.
* Historical source: 2 Analysis_CFI DPI Migrant Women Colombia.do
* Source lines 1248-1693. See the companion README and audit ledger.
version 19
set varabbrev off
confirm numeric variable age_cat q3 ivs_score iat_score iadt_score icdp_score iaff_score ///
    oqi_score_01 IEDF IEH iurd_score_01 formal_remittance iuof_score_01 ietr_score_01 ///
    IPCS IAER ICPF z_iurd z_ivs z_iat z_iadt ///
    z_icdp z_iaff z_oqi z_iedf z_ieh z_iuof z_ietr ///
    z_ipcs z_iaer z_icpf, exact
* Local palettes are repeated here because do-file locals do not cross scope.
local blue "58 103 177"
local orange "245 130 48"
local gray "167 169 172"

* BEGIN HISTORICAL COMMAND BODY
* 2.1 Historical IURD models A-D and standardized display model.
eststo clear

regress iurd_score_01 i.age_cat i.q3, vce(robust)
eststo iurd_A
outreg2 using "${output_dir}/regression/tables/Table_F1_IURD.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress iurd_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score, vce(robust)
eststo iurd_B
outreg2 using "${output_dir}/regression/tables/Table_F1_IURD.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress iurd_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.iaff_score ///
    c.oqi_score_01, vce(robust)
eststo iurd_C
outreg2 using "${output_dir}/regression/tables/Table_F1_IURD.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress iurd_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.iaff_score ///
    c.oqi_score_01 c.IEDF c.IEH, vce(robust)
eststo iurd_D
outreg2 using "${output_dir}/regression/tables/Table_F1_IURD.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot
* IADT is absent here although present in the raw full model.

regress z_iurd i.age_cat i.q3 c.z_ivs c.z_iat c.z_icdp c.z_iaff c.z_oqi c.z_iedf c.z_ieh, vce(robust)
eststo iurd_D_z

coefplot (iurd_D_z, ///
    keep(z_iat z_icdp z_iaff z_oqi z_ivs z_iedf z_ieh) ///
    msymbol(D) msize(medsmall) mcolor("`blue'") ///
    ciopts(recast(rcap) lcolor("`blue'"))), ///
    xline(0, lcolor(gs8) lpattern(dash)) ///
    xlabel(, labsize(small)) ///
    ylabel(, labsize(small) angle(0)) ///
    xtitle("Standardized coefficient", size(small)) ///
    ytitle("") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig40_coef_iurd.png", replace



*===========================================================*
* 2.2 Outcome: Formal remittance channel (binary, logit)    *
*===========================================================*/

eststo clear

logit formal_remittance i.age_cat i.q3, vce(robust)
eststo form_A
outreg2 using "${output_dir}/regression/tables/Table_F1_FormalRemittance.doc", replace ///
    word dec(3) eform ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

logit formal_remittance i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score, vce(robust)
eststo form_B
outreg2 using "${output_dir}/regression/tables/Table_F1_FormalRemittance.doc", append ///
    word dec(3) eform ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

logit formal_remittance i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score ///
    c.iaff_score c.oqi_score_01, vce(robust)
eststo form_C
outreg2 using "${output_dir}/regression/tables/Table_F1_FormalRemittance.doc", append ///
    word dec(3) eform ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

logit formal_remittance i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score ///
    c.iaff_score c.oqi_score_01 c.IEDF c.IEH, vce(robust)
eststo form_D
outreg2 using "${output_dir}/regression/tables/Table_F1_FormalRemittance.doc", append ///
    word dec(3) eform ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

* Historical AMEs use a different predictor set from the raw Model D.

logit formal_remittance i.age_cat i.q3 c.z_ivs c.z_iat c.z_icdp c.z_iaff c.z_oqi c.z_iedf c.z_ieh, ///
    vce(robust)
margins, dydx(z_iat z_icdp z_iaff z_oqi z_ivs z_iedf z_ieh) post
eststo form_ame

coefplot (form_ame, ///
    keep(z_iat z_icdp z_iaff z_oqi z_ivs z_iedf z_ieh) ///
    msymbol(D) msize(medsmall) mcolor("`blue'") ///
    ciopts(recast(rcap) lcolor("`blue'"))), ///
    xline(0, lcolor(gs8) lpattern(dash)) ///
    xlabel(, labsize(small)) ///
    ylabel(, labsize(small) angle(0)) ///
    xtitle("Average marginal effect", size(small)) ///
    ytitle("") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig41_ame_formal_remittance.png", replace



*===================================================*
* 2.3 Outcome: IUOF (financial operability, OLS)    *
*===================================================*/

eststo clear

regress iuof_score_01 i.age_cat i.q3, vce(robust)
eststo iuof_A
outreg2 using "${output_dir}/regression/tables/Table_F1_IUOF.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress iuof_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score, vce(robust)
eststo iuof_B
outreg2 using "${output_dir}/regression/tables/Table_F1_IUOF.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Note: IAFF is conceptually important for IUOF, but IUOF should not predict itself.

regress iuof_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.iaff_score ///
    c.oqi_score_01, vce(robust)
eststo iuof_C
outreg2 using "${output_dir}/regression/tables/Table_F1_IUOF.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress iuof_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.iaff_score ///
    c.oqi_score_01 c.IEDF c.IEH, vce(robust)
eststo iuof_D
outreg2 using "${output_dir}/regression/tables/Table_F1_IUOF.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot
* IADT is absent here although present in the raw full model.

regress z_iuof i.age_cat i.q3 c.z_ivs c.z_iat c.z_icdp c.z_iaff c.z_oqi c.z_iedf c.z_ieh, vce(robust)
eststo iuof_D_z

coefplot (iuof_D_z, ///
    keep(z_iat z_icdp z_iaff z_oqi z_ivs z_iedf z_ieh) ///
    msymbol(D) msize(medsmall) mcolor("`blue'") ///
    ciopts(recast(rcap) lcolor("`blue'"))), ///
    xline(0, lcolor(gs8) lpattern(dash)) ///
    xlabel(, labsize(small)) ///
    ylabel(, labsize(small) angle(0)) ///
    xtitle("Standardized coefficient", size(small)) ///
    ytitle("") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig42_coef_iuof.png", replace


*-----------------------------------------------------------*
*		3. FAMILY 2: TRANSACTION QUALITY AND ONBOARDING		*
*-----------------------------------------------------------*
* 3.1 Outcome: IETR (transactional experience, OLS)        *

eststo clear

regress ietr_score_01 i.age_cat i.q3, vce(robust)
eststo ietr_A
outreg2 using "${output_dir}/regression/tables/Table_F2_IETR.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress ietr_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score, vce(robust)
eststo ietr_B
outreg2 using "${output_dir}/regression/tables/Table_F2_IETR.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress ietr_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.iaff_score ///
    c.oqi_score_01, vce(robust)
eststo ietr_C
outreg2 using "${output_dir}/regression/tables/Table_F2_IETR.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress ietr_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.iaff_score ///
    c.oqi_score_01 c.IEDF c.IEH, vce(robust)
eststo ietr_D
outreg2 using "${output_dir}/regression/tables/Table_F2_IETR.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot
* IADT is absent here although present in the raw full model.

regress z_ietr i.age_cat i.q3 c.z_ivs c.z_iat c.z_icdp c.z_iaff c.z_oqi c.z_iedf c.z_ieh, vce(robust)
eststo ietr_D_z

coefplot (ietr_D_z, ///
    keep(z_iat z_icdp z_iaff z_oqi z_ivs z_iedf z_ieh) ///
    msymbol(D) msize(medsmall) mcolor("`blue'") ///
    ciopts(recast(rcap) lcolor("`blue'"))), ///
    xline(0, lcolor(gs8) lpattern(dash)) ///
    xlabel(, labsize(small)) ///
    ylabel(, labsize(small) angle(0)) ///
    xtitle("Standardized coefficient", size(small)) ///
    ytitle("") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig43_coef_ietr.png", replace



* 3.2 Outcome: OQI (onboarding quality, OLS)            *

eststo clear

regress oqi_score_01 i.age_cat i.q3, vce(robust)
eststo oqi_A
outreg2 using "${output_dir}/regression/tables/Table_F2_OQI.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress oqi_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score, vce(robust)
eststo oqi_B
outreg2 using "${output_dir}/regression/tables/Table_F2_OQI.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress oqi_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.iaff_score, ///
    vce(robust)
eststo oqi_C
outreg2 using "${output_dir}/regression/tables/Table_F2_OQI.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress oqi_score_01 i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.iaff_score ///
    c.IEH, vce(robust)
eststo oqi_D
outreg2 using "${output_dir}/regression/tables/Table_F2_OQI.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot

regress z_oqi i.age_cat i.q3 c.z_ivs c.z_iat c.z_iadt c.z_icdp c.z_iaff c.z_ieh, vce(robust)
eststo oqi_D_z

coefplot (oqi_D_z, ///
    keep(z_iat z_iadt z_icdp z_iaff z_ivs z_ieh) ///
    msymbol(D) msize(medsmall) mcolor("`blue'") ///
    ciopts(recast(rcap) lcolor("`blue'"))), ///
    xline(0, lcolor(gs8) lpattern(dash)) ///
    xlabel(, labsize(small)) ///
    ylabel(, labsize(small) angle(0)) ///
    xtitle("Standardized coefficient", size(small)) ///
    ytitle("") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig44_coef_oqi.png", replace


*-------------------------------------------------------*
*		4. FAMILY 3: SAFETY, FRAUD, AND RECOURSE		*
*-------------------------------------------------------*
* 4.1 Outcome: IPCS (safe conduct, OLS)         *

eststo clear

regress IPCS i.age_cat i.q3, vce(robust)
eststo ipcs_A
outreg2 using "${output_dir}/regression/tables/Table_F3_IPCS.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress IPCS i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score, vce(robust)
eststo ipcs_B
outreg2 using "${output_dir}/regression/tables/Table_F3_IPCS.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress IPCS i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.oqi_score_01, vce(robust)
eststo ipcs_C
outreg2 using "${output_dir}/regression/tables/Table_F3_IPCS.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress IPCS i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.oqi_score_01 c.IEH, ///
    vce(robust)
eststo ipcs_D
outreg2 using "${output_dir}/regression/tables/Table_F3_IPCS.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot

regress z_ipcs i.age_cat i.q3 c.z_ivs c.z_iat c.z_iadt c.z_icdp c.z_oqi c.z_ieh, vce(robust)
eststo ipcs_D_z

coefplot (ipcs_D_z, ///
    keep(z_iat z_iadt z_icdp z_oqi z_ivs z_ieh) ///
    msymbol(D) msize(medsmall) mcolor("`blue'") ///
    ciopts(recast(rcap) lcolor("`blue'"))), ///
    xline(0, lcolor(gs8) lpattern(dash)) ///
    xlabel(, labsize(small)) ///
    ylabel(, labsize(small) angle(0)) ///
    xtitle("Standardized coefficient", size(small)) ///
    ytitle("") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig45_coef_ipcs.png", replace



* 4.2 Outcome: IEDF (fraud exposure / recourse failure, OLS)  *

eststo clear

regress IEDF i.age_cat i.q3, vce(robust)
eststo iedf_A
outreg2 using "${output_dir}/regression/tables/Table_F3_IEDF.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress IEDF i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score, vce(robust)
eststo iedf_B
outreg2 using "${output_dir}/regression/tables/Table_F3_IEDF.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress IEDF i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.oqi_score_01, vce(robust)
eststo iedf_C
outreg2 using "${output_dir}/regression/tables/Table_F3_IEDF.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress IEDF i.age_cat i.q3 c.ivs_score c.iat_score c.iadt_score c.icdp_score c.oqi_score_01 c.IEH, ///
    vce(robust)
eststo iedf_D
outreg2 using "${output_dir}/regression/tables/Table_F3_IEDF.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot

regress z_iedf i.age_cat i.q3 c.z_ivs c.z_iat c.z_iadt c.z_icdp c.z_oqi c.z_ieh, vce(robust)
eststo iedf_D_z

coefplot (iedf_D_z, ///
    keep(z_iat z_iadt z_icdp z_oqi z_ivs z_ieh) ///
    msymbol(D) msize(medsmall) mcolor("`orange'") ///
    ciopts(recast(rcap) lcolor("`orange'"))), ///
    xline(0, lcolor(gs8) lpattern(dash)) ///
    xlabel(, labsize(small)) ///
    ylabel(, labsize(small) angle(0)) ///
    xtitle("Standardized coefficient", size(small)) ///
    ytitle("") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig46_coef_iedf.png", replace


*-------------------------------------------------------*
*		5. FAMILY 4: AUTONOMY, AGENCY, AND TRUST		*
*-------------------------------------------------------*
* 5.1 Outcome: IAER (autonomy, OLS)

eststo clear

regress IAER i.age_cat i.q3, vce(robust)
eststo iaer_A
outreg2 using "${output_dir}/regression/tables/Table_F4_IAER.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress IAER i.age_cat i.q3 c.ivs_score c.iurd_score_01, vce(robust)
eststo iaer_B
outreg2 using "${output_dir}/regression/tables/Table_F4_IAER.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress IAER i.age_cat i.q3 c.ivs_score c.iurd_score_01 c.iaff_score c.ICPF, vce(robust)
eststo iaer_C
outreg2 using "${output_dir}/regression/tables/Table_F4_IAER.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress IAER i.age_cat i.q3 c.ivs_score c.iurd_score_01 c.iaff_score c.ICPF c.IEDF c.IEH, vce(robust)
eststo iaer_D
outreg2 using "${output_dir}/regression/tables/Table_F4_IAER.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot

regress z_iaer i.age_cat i.q3 c.z_ivs c.z_iurd c.z_iaff c.z_icpf c.z_iedf c.z_ieh, vce(robust)
eststo iaer_D_z

coefplot (iaer_D_z, ///
    keep(z_iurd z_icpf z_iaff z_ivs z_iedf z_ieh) ///
    msymbol(D) msize(medsmall) mcolor("`blue'") ///
    ciopts(recast(rcap) lcolor("`blue'"))), ///
    xline(0, lcolor(gs8) lpattern(dash)) ///
    xlabel(, labsize(small)) ///
    ylabel(, labsize(small) angle(0)) ///
    xtitle("Standardized coefficient", size(small)) ///
    ytitle("") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig47_coef_iaer.png", replace



* 5.2 Outcome: ICPF (trust / climate, OLS)          *

eststo clear

regress ICPF i.age_cat i.q3, vce(robust)
eststo icpf_A
outreg2 using "${output_dir}/regression/tables/Table_F4_ICPF.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress ICPF i.age_cat i.q3 c.ivs_score c.iurd_score_01, vce(robust)
eststo icpf_B
outreg2 using "${output_dir}/regression/tables/Table_F4_ICPF.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress ICPF i.age_cat i.q3 c.ivs_score c.iurd_score_01 c.iaff_score, vce(robust)
eststo icpf_C
outreg2 using "${output_dir}/regression/tables/Table_F4_ICPF.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

regress ICPF i.age_cat i.q3 c.ivs_score c.iurd_score_01 c.iaff_score c.IEDF c.IEH, vce(robust)
eststo icpf_D
outreg2 using "${output_dir}/regression/tables/Table_F4_ICPF.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot

regress z_icpf i.age_cat i.q3 c.z_ivs c.z_iurd c.z_iaff c.z_iedf c.z_ieh, vce(robust)
eststo icpf_D_z

coefplot (icpf_D_z, ///
    keep(z_iurd z_iaff z_ivs z_iedf z_ieh) ///
    msymbol(D) msize(medsmall) mcolor("`blue'") ///
    ciopts(recast(rcap) lcolor("`blue'"))), ///
    xline(0, lcolor(gs8) lpattern(dash)) ///
    xlabel(, labsize(small)) ///
    ylabel(, labsize(small) angle(0)) ///
    xtitle("Standardized coefficient", size(small)) ///
    ytitle("") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    scheme(plotplain)

graph export "${output_dir}/regression/figures/fig48_coef_icpf.png", replace
