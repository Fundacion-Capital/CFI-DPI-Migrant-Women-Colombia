* WP07 academic preparation v1 -- source draft, not authorized to run.
* The first command is an intentional hold. Leave it in place pending protected review.
exit

* Input contract: the separately authorized numeric TARGET33 projection in memory.
* This draft neither selects a carrier nor loads, filters, sorts, saves or exports data.
* The historical sample, submitted answers, clocks and historical variables stay intact.

* D2: scope version-sensitive derivations to the five documented submitted forms.
gen byte wp07_known_form = inlist(formdef_version, 2512090157, 2512091719, ///
    2512111044, 2512121811, 2602120658) if !missing(formdef_version)

* Residence: code 4 changes meaning; code 5 is Meta only on the later form.
gen byte wp07_residence = q3 if wp07_known_form == 1 & inlist(q3, 1, 2, 3)
replace wp07_residence = 4 if q3 == 4 & inlist(formdef_version, 2512090157, 2512091719)
replace wp07_residence = 5 if q3 == 4 & inlist(formdef_version, 2512111044, 2512121811, 2602120658)
replace wp07_residence = 6 if q3 == 5 & formdef_version == 2602120658
label define wp07_residence_lbl 1 "Bogota" 2 "Cali" 3 "Medellin" 4 "Other (early forms)" ///
    5 "Soacha" 6 "Meta (municipality unspecified)"
label values wp07_residence wp07_residence_lbl

* The form routes the IUOF and onboarding questions through selected account types.
* Do not interpret blank or malformed account selections as nonuse.
gen byte wp07_account_route = 1 if wp07_known_form == 1 & eligible_flag == 1 & ///
    regexm(itrim(strtrim(q4_12)), "^[1-4]( [1-4])*$")

* D3 IVS: education component only. The date source and fixed bounds are still open.
gen double wp07_ivs_educ = (10 - q2_2) / 9 if wp07_known_form == 1 & eligible_flag == 1 & inrange(q2_2, 1, 10) & q2_2 == floor(q2_2)

* IAT: fixed weights; location, plan status and reading stay separate.
gen double wp07_iat_phone = .
replace wp07_iat_phone = 1 if q3_1 == 1 & wp07_known_form == 1 & eligible_flag == 1
replace wp07_iat_phone = .5 if q3_1 == 2 & wp07_known_form == 1 & eligible_flag == 1
replace wp07_iat_phone = 0 if q3_1 == 3 & wp07_known_form == 1 & eligible_flag == 1
gen double wp07_iat_internet = .
replace wp07_iat_internet = 1 if q3_5 == 1 & wp07_known_form == 1 & eligible_flag == 1
replace wp07_iat_internet = .75 if q3_5 == 2 & wp07_known_form == 1 & eligible_flag == 1
replace wp07_iat_internet = .5 if q3_5 == 3 & wp07_known_form == 1 & eligible_flag == 1
replace wp07_iat_internet = .25 if q3_5 == 4 & wp07_known_form == 1 & eligible_flag == 1
replace wp07_iat_internet = 0 if q3_5 == 5 & wp07_known_form == 1 & eligible_flag == 1
gen double wp07_iat_runout = .
replace wp07_iat_runout = 0 if q3_8 == 1 & wp07_known_form == 1 & eligible_flag == 1 & inlist(q3_1, 1, 2)
replace wp07_iat_runout = .5 if q3_8 == 2 & wp07_known_form == 1 & eligible_flag == 1 & inlist(q3_1, 1, 2)
replace wp07_iat_runout = 1 if q3_8 == 3 & wp07_known_form == 1 & eligible_flag == 1 & inlist(q3_1, 1, 2)
gen double wp07_iat3 = (wp07_iat_phone + wp07_iat_internet + wp07_iat_runout) / 3

* IADT: app installation is smartphone-only; transfer also allows basic phones.
gen double wp07_iadt_app = (q3_15 - 1) / 4 if wp07_known_form == 1 & eligible_flag == 1 & q3_1 == 1 & inlist(q3_15, 1, 2, 3, 4, 5)
gen double wp07_iadt_transfer = (q3_16 - 1) / 4 if wp07_known_form == 1 & eligible_flag == 1 & inlist(q3_1, 1, 2) & inlist(q3_16, 1, 2, 3, 4, 5)
gen double wp07_iadt_confidence = (q3_17 - 1) / 4 if wp07_known_form == 1 & eligible_flag == 1 & inlist(q3_17, 1, 2, 3, 4, 5)
gen double wp07_iadt3 = (wp07_iadt_app + wp07_iadt_transfer + wp07_iadt_confidence) / 3
gen double wp07_iadt2 = (wp07_iadt_transfer + wp07_iadt_confidence) / 2

* ICDP: unfamiliarity with OTP and app nonuse do not score zero.
gen double wp07_icdp_otp = .
replace wp07_icdp_otp = 1 if q3_21 == 1 & wp07_known_form == 1 & eligible_flag == 1 & inlist(q3_1, 1, 2)
replace wp07_icdp_otp = .5 if q3_21 == 2 & wp07_known_form == 1 & eligible_flag == 1 & inlist(q3_1, 1, 2)
replace wp07_icdp_otp = 0 if q3_21 == 3 & wp07_known_form == 1 & eligible_flag == 1 & inlist(q3_1, 1, 2)
gen double wp07_icdp_pin = .
replace wp07_icdp_pin = 1 if q3_22 == 1 & wp07_known_form == 1 & eligible_flag == 1 & inlist(q3_1, 1, 2)
replace wp07_icdp_pin = 0 if q3_22 == 2 & wp07_known_form == 1 & eligible_flag == 1 & inlist(q3_1, 1, 2)
gen double wp07_icdp2 = (wp07_icdp_otp + wp07_icdp_pin) / 2

* IAFF: own-name proof and telephone only; documentation and account types stay separate.
gen double wp07_iaff_address = .
replace wp07_iaff_address = 1 if q4_5 == 1 & wp07_known_form == 1 & eligible_flag == 1
replace wp07_iaff_address = 0 if q4_5 == 2 & wp07_known_form == 1 & eligible_flag == 1
gen double wp07_iaff_phone = .
replace wp07_iaff_phone = 1 if q4_6 == 1 & wp07_known_form == 1 & eligible_flag == 1
replace wp07_iaff_phone = 0 if inlist(q4_6, 2, 3) & wp07_known_form == 1 & eligible_flag == 1
gen double wp07_iaff2 = (wp07_iaff_address + wp07_iaff_phone) / 2

* IUOF: selected activity, not cash access or general operability.
gen double wp07_iuof_frequency = .
replace wp07_iuof_frequency = 1 if q4_15 == 1 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_frequency = .75 if q4_15 == 2 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_frequency = .5 if q4_15 == 3 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_frequency = .25 if q4_15 == 4 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_frequency = 0 if q4_15 == 5 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
gen double wp07_iuof_merchant = .
replace wp07_iuof_merchant = 1 if q4_24 == 1 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_merchant = .5 if q4_24 == 2 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_merchant = 0 if q4_24 == 3 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
gen double wp07_iuof_saving = .
replace wp07_iuof_saving = 1 if q4_25 == 1 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_saving = .5 if q4_25 == 2 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_saving = 0 if q4_25 == 3 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
gen double wp07_iuof3 = (wp07_iuof_frequency + wp07_iuof_merchant + wp07_iuof_saving) / 3
* These are alternative definitions, not substitutes for missing items.
gen double wp07_iuof_frequency_oldmap = .
replace wp07_iuof_frequency_oldmap = 1 if q4_15 == 1 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_frequency_oldmap = .8 if q4_15 == 2 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_frequency_oldmap = .6 if q4_15 == 3 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_frequency_oldmap = .4 if q4_15 == 4 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_iuof_frequency_oldmap = 0 if q4_15 == 5 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
gen double wp07_iuof3_oldmap = (wp07_iuof_frequency_oldmap + wp07_iuof_merchant + wp07_iuof_saving) / 3
gen double wp07_iuof2_no_frequency = (wp07_iuof_merchant + wp07_iuof_saving) / 2

* OQI: registration ease and initial support only; activation time stays separate.
gen double wp07_oqi_ease = .
replace wp07_oqi_ease = 1 if q5_14 == 1 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_oqi_ease = 2/3 if q5_14 == 2 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_oqi_ease = 1/3 if q5_14 == 3 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_oqi_ease = 0 if q5_14 == 4 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
gen double wp07_oqi_support = .
replace wp07_oqi_support = 1 if q5_23 == 1 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_oqi_support = .5 if q5_23 == 2 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_oqi_support = 0 if q5_23 == 3 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
gen double wp07_oqi2 = (wp07_oqi_ease + wp07_oqi_support) / 2
gen double wp07_oqi_ease_oldmap = .
replace wp07_oqi_ease_oldmap = 1 if q5_14 == 1 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_oqi_ease_oldmap = .75 if q5_14 == 2 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_oqi_ease_oldmap = .25 if q5_14 == 3 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
replace wp07_oqi_ease_oldmap = 0 if q5_14 == 4 & wp07_known_form == 1 & eligible_flag == 1 & wp07_account_route == 1
gen double wp07_oqi2_oldmap = (wp07_oqi_ease_oldmap + wp07_oqi_support) / 2

* D3 IURD and D4: two distinct engagement outcomes; neither is latest receipt channel.
gen byte wp07_remit_disposition = q6_13 if wp07_known_form == 1 & eligible_flag == 1 & inlist(q6_13, 1, 2, 3, 4, 5)
gen byte wp07_remit_any_digital = (q6_13 != 1) if !missing(wp07_remit_disposition)
gen byte wp07_domestic_60d = q6_14 if wp07_known_form == 1 & eligible_flag == 1 & inlist(q6_14, 0, 1)
gen byte wp07_domestic_ops_bin = q6_15 if wp07_domestic_60d == 1 & inlist(q6_15, 1, 2, 3, 4, 5, 98)
label values wp07_remit_disposition q6_13
label values wp07_domestic_ops_bin q6_15
label variable wp07_remit_any_digital "Reported any digital remittance retention or use"
label variable wp07_domestic_60d "Reported domestic digital participation, 60 days"

* No replacement pooled IURD, IETR, IPCS, IEDF, IAER, ICPF, IEH or IBPD score.
* Their accepted item-level representations use the unchanged original fields.
* No D4 estimators or D6 class inputs are constructed here.
