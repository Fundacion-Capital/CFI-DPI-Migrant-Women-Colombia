* WP07 regression source revision v1 — 5 November 2026.
* Disabled review copy; no Stata execution or scientific adoption.
exit 198
* This is historical recoding, not the accepted academic preparation.
* The verified carrier must already be in memory. No file is loaded here.
* Preserve the original q3=5 to q3=1 pooling for historical comparison only.
* Helper outcomes retain their original missing-value and sentinel handling.
* Each std() uses its own observed source values before any model restriction.
* The future caller must bind output_dir to a new restricted scratch destination.
* Historical source: 2 Analysis_CFI DPI Migrant Women Colombia.do
* Source lines 1112-1236. See the companion README and audit ledger.
version 19
set varabbrev off
confirm numeric variable q3 q6_4 q6_14 q6_16 q6_18 q6_23 q7_9 ///
    q7_11 ivs_score iat_score iadt_score icdp_score iaff_score iuof_score_01 ///
    oqi_score_01 iurd_score_01 ietr_score_01 IEDF IPCS IAER ICPF ///
    IEH IBPD, exact

* BEGIN HISTORICAL COMMAND BODY
replace q3 = 1 if q3 == 5

* 1. Setup, user-written packages, dirs *
graph set window fontface "Times New Roman"
set scheme plotplain
set linesize 255
version 19

* Create output folders for this section
cap mkdir "${output_dir}/regression"
cap mkdir "${output_dir}/regression/tables"
cap mkdir "${output_dir}/regression/figures"

* 1.1 Graph style and colors   *


* 1.2 Helper outcomes used in regression models *
* Main binary outcome: formal/digital remittance channel
capture drop formal_remittance
gen formal_remittance = .
replace formal_remittance = 1 if inlist(q6_4, 1, 2)
replace formal_remittance = 0 if inlist(q6_4, 3, 4)
label define formal_remittance_lab 0 "Cash / traveler / informal" ///
    1 "Bank / wallet / formal digital", replace
label values formal_remittance formal_remittance_lab
label var formal_remittance "Latest remittance received through formal digital channel"

* Supplementary binary outcomes for item-level models
capture drop recent_digital_use
gen recent_digital_use = .
replace recent_digital_use = 1 if q6_14 == 1
replace recent_digital_use = 0 if q6_14 == 0
label var recent_digital_use "Used digital payments/remittances in last 60 days"

capture drop digital_problem
gen digital_problem = .
replace digital_problem = 1 if inlist(q6_16, 1, 2, 3)
replace digital_problem = 0 if q6_16 == 4
label var digital_problem "Had at least one recent digital transaction problem"

capture drop fee_visible
gen fee_visible = .
replace fee_visible = 1 if q6_18 == 1
replace fee_visible = 0 if inlist(q6_18, 2, 3)
label var fee_visible "Fees clearly visible before confirmation"

capture drop provider_info_clear
gen provider_info_clear = .
replace provider_info_clear = 1 if inlist(q6_23, 1, 2)
replace provider_info_clear = 0 if inlist(q6_23, 3, 4)
label var provider_info_clear "Provider information at least somewhat clear"

capture drop feels_secure
gen feels_secure = .
replace feels_secure = 1 if inlist(q7_9, 1, 2)
replace feels_secure = 0 if inlist(q7_9, 3, 4)
label var feels_secure "Feels secure using digital payments/remittances"

capture drop any_payment_problem
gen any_payment_problem = .
replace any_payment_problem = 1 if q7_11 == 1
replace any_payment_problem = 0 if q7_11 == 2
label var any_payment_problem "Had any problem with digital payment/remittance in last 12 months"

capture drop high_autonomy
gen high_autonomy = .
replace high_autonomy = 1 if IAER >= 85 & IAER < .
replace high_autonomy = 0 if IAER < 85
label var high_autonomy "High autonomy in remittance management (IAER >= 85)"


* 1.3 Standardized versions for coefficient comparison   *

capture drop z_ivs z_iat z_iadt z_icdp z_iaff z_iuof z_oqi z_iurd z_ietr z_iedf z_ipcs z_iaer z_icpf z_ieh z_ibpd
egen z_ivs  = std(ivs_score)
egen z_iat  = std(iat_score)
egen z_iadt = std(iadt_score)
egen z_icdp = std(icdp_score)
egen z_iaff = std(iaff_score)
egen z_iuof = std(iuof_score_01)
egen z_oqi  = std(oqi_score_01)
egen z_iurd = std(iurd_score_01)
egen z_ietr = std(ietr_score_01)
egen z_iedf = std(IEDF)
egen z_ipcs = std(IPCS)
egen z_iaer = std(IAER)
egen z_icpf = std(ICPF)
egen z_ieh  = std(IEH)
egen z_ibpd = std(IBPD)

label var z_ivs  "Socioeconomic vulnerability (IVS)"
label var z_iat  "Digital access (IAT)"
label var z_iadt "Digital self-efficacy (IADT)"
label var z_icdp "Practical digital competence (ICDP)"
label var z_iaff "Formal financial access (IAFF)"
label var z_iuof "Financial operability (IUOF)"
label var z_oqi  "Onboarding quality (OQI)"
label var z_iurd "Digital use intensity (IURD)"
label var z_ietr "Transactional experience (IETR)"
label var z_iedf "Fraud exposure and recourse failure (IEDF)"
label var z_ipcs "Safe conduct and prevention (IPCS)"
label var z_iaer "Autonomy in remittances (IAER)"
label var z_icpf "Trust and relational climate (ICPF)"
label var z_ieh  "Enabling environment (IEH)"
label var z_ibpd "Perceived barriers (IBPD)"


* Predictor lists are written explicitly in the model files.
