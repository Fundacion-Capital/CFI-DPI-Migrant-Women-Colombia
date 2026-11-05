* WP07 regression source revision v1 — 5 November 2026.
* Disabled review copy; no Stata execution or scientific adoption.
exit 198
* Seven historical binary logits, in supplementary-table column order.
* Helper outcomes must be verified against the exact historical setup.
* Each model uses its own complete observations, not a universal N=423.
* The export requests odds ratios (eform); these are not marginal probabilities.
* Preserving a historical threshold or collapse is not academic adoption.
* Historical source: 2 Analysis_CFI DPI Migrant Women Colombia.do
* Source lines 1839-1895. See the companion README and audit ledger.
version 19
set varabbrev off
confirm numeric variable age_cat q3 recent_digital_use digital_problem fee_visible provider_info_clear feels_secure ///
    any_payment_problem high_autonomy ivs_score iat_score icdp_score iaff_score oqi_score_01 ///
    IEDF IEH iurd_score_01 ICPF, exact

* BEGIN HISTORICAL COMMAND BODY

logit recent_digital_use i.age_cat i.q3 ///
    c.ivs_score c.iat_score c.icdp_score c.iaff_score c.oqi_score_01 c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", replace ///
    word dec(3) eform ctitle("Recent digital use") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

*-------------------------------------------------------------*
* 7.2 Supplementary quality models                            *
*-------------------------------------------------------------*/

logit digital_problem i.age_cat i.q3 ///
    c.ivs_score c.iat_score c.icdp_score c.iaff_score c.oqi_score_01 c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("Recent digital problem") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

logit fee_visible i.age_cat i.q3 ///
    c.ivs_score c.iat_score c.icdp_score c.iaff_score c.oqi_score_01 c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("Fees clearly visible") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

logit provider_info_clear i.age_cat i.q3 ///
    c.ivs_score c.iat_score c.icdp_score c.iaff_score c.oqi_score_01 c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("Provider info clear") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

*-------------------------------------------------------------*
* 7.3 Supplementary safety / trust models                     *
*-------------------------------------------------------------*/

logit feels_secure i.age_cat i.q3 ///
    c.ivs_score c.iat_score c.icdp_score c.oqi_score_01 c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("Feels secure") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

logit any_payment_problem i.age_cat i.q3 ///
    c.ivs_score c.iat_score c.icdp_score c.oqi_score_01 c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("Any payment problem") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

*-------------------------------------------------------------*
* 7.4 Supplementary autonomy robustness                       *
*-------------------------------------------------------------*/

logit high_autonomy i.age_cat i.q3 ///
    c.ivs_score c.iurd_score_01 c.iaff_score c.ICPF c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("High autonomy (binary)") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)
