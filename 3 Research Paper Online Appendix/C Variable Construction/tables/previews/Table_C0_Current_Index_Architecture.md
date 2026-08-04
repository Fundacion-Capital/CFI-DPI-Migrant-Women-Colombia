# Current index architecture and item-to-index mapping

This is a display-only Markdown rendering of [the authoritative Excel workbook](../Table_C0_Current_Index_Architecture.xlsx). The workbook remains the source file for download and replication.

## Sheet: Index Architecture

| Index | Construct | Current components | Aggregation | Published scale | Direction | Current descriptive categories | Code location |
| --- | --- | --- | --- | --- | --- | --- | --- |
| IVS | Socioeconomic vulnerability | Migration recency; education; employment insertion | Row mean of three normalized components | 0-1 | Higher = greater vulnerability | Low <=0.33; Medium >0.33 to <=0.66; High >0.66 | Data Preparation, lines 1128-1182 |
| IAT | Telecommunications access | Phone type; internet frequency; access point; data stability; ability to read messages | Row mean of five 0-100 components, divided by 100 | 0-1 | Higher = better access | Low <=0.45; Medium >0.45 to <=0.80; High >0.80 | Lines 1186-1246 |
| IADT | Digital transactional self-efficacy | Install apps; send/receive money; avoid fraud | Likert items normalized as (response-1)/4; row mean | 0-1 | Higher = greater self-efficacy | Low <=0.33; Medium >0.33 to <=0.66; High >0.66 | Lines 1251-1288 |
| ICDP | Practical digital competence | QR use; SMS/OTP; PIN management; suspicious-message response | Row mean of four 0-100 components, divided by 100 | 0-1 | Higher = greater practical competence | Low <=0.45; Medium >0.45 to <=0.80; High >0.80 | Lines 1291-1347 |
| IAFF | Formal financial access | Valid KYC document; proof of address; own-name phone; account/wallet ownership | Row mean of four 0-100 components, divided by 100 | 0-1 | Higher = greater formal access | Low <0.50; Medium 0.50 to 0.80; High >0.80 | Lines 1351-1409 |
| IUOF | Financial use and operability | Use frequency; cash-in/out; proximity; payments; saving; notifications; no account lending | Row mean of seven 0-100 components; 0-1 version used in models | 0-100 and 0-1 | Higher = greater operability | Low <0.50; Medium 0.50 to <0.80; High >=0.80 | Lines 1414-1489 |
| OQI | Onboarding quality | KYC burden; registration ease; activation time; no-help registration; confirmation; cost clarity; failures; terms/privacy; support | Row mean of nine 0-100 components; 0-1 version used in models | 0-100 and 0-1 | Higher = better onboarding | Low <45; Medium 45 to <85; High >=85 | Lines 1492-1611 |
| IURD | Digital remittance-use intensity | Receipt frequency; digital share; recent use; operation volume; receipt channel | Row mean of five 0-100 components; 0-1 version used in models | 0-100 and 0-1 | Higher = greater digital intensity | Low <30; Medium 30 to <55; High >=55 | Lines 1622-1676 |
| IETR | Remittance/payment transactional experience | Speed; cost/FX clarity; confirmations; problems; limits; perceived speed; surcharges; provider clarity; evaluation | Row mean of nine 0-100 components; 0-1 version used in models | 0-100 and 0-1 | Higher = better experience | Poor <45; Regular 45 to <85; Good >=85 | Lines 1679-1783 |
| IPCS | Prevention and safe conduct | Safe reaction; authentication; password habits; antifraud education; perceived safety; prevention valuation | Row mean of six binary components multiplied by 100 | 0-100 | Higher = safer conduct | Low <45; Medium 45 to <85; High >=85 | Lines 1793-1847 |
| IEDF | Fraud exposure and recourse harm | Exposure; blocking; transaction problem; response delay; unresolved problem; dissatisfaction | Row mean of available six binary components multiplied by 100 | 0-100 | Higher = greater exposure/harm | Low <45; Medium 45 to <80; High >=80 | Lines 1850-1906 |
| IAER | Economic autonomy in remittances | Twelve decision, control, privacy, and coercion indicators | Row mean of twelve binary components multiplied by 100 | 0-100 | Higher = greater autonomy | Low <40; Medium 40 to <85; High >=85 | Lines 1916-2010 |
| ICPF | Trust and financial climate | Provider trust; household norms; community trust; no privacy consequences; no conflict mitigation | Row mean of five binary components multiplied by 100 | 0-100 | Higher = more favorable climate | Low <40; Medium 40 to <70; High >=70 | Lines 2013-2068 |
| IEH | Enabling environment | Information; cash-out; training; training impact; individual support; educational materials | Row mean of six binary components multiplied by 100 | 0-100 | Higher = more enabling environment | Low <40; Medium 40 to <70; High >=70 | Lines 2113-2155 |
| IBPD | Perceived barriers to digitalization | Main barrier; additional barriers; low information; difficult cash-out; no educational materials | Row mean of five binary components multiplied by 100 | 0-100 | Higher = more perceived barriers | Low <40; Medium 40 to <70; High >=70 | Lines 2158-2200 |

## Sheet: Item Mapping

| Index | Component variable | Survey item(s) | Current scoring rule | Role in index |
| --- | --- | --- | --- | --- |
| IVS | antig_norm | q2_1 -> years_in_col | (stored maximum - years in Colombia)/(stored maximum - stored minimum) | Higher = more recent arrival |
| IVS | educ_norm | q2_2 | Education categories mapped from 1.00 (no education) to 0.00 (postgraduate) | Higher = lower education |
| IVS | ocup_norm | q2_3 | Categories mapped to 0, 0.5, or 1 | Higher = weaker labor insertion |
| IAT | tel_score | q3_1 | Smartphone 100; basic phone 50; no phone 0 | Device access |
| IAT | internet_score | q3_5 | 100, 75, 50, 25, 0 from daily to never | Internet-use frequency |
| IAT | access_score | q3_6 | Category 1=100; 2/5=80; 3/4/6=40 | Main access point |
| IAT | data_stability | q3_7, q3_8 | 100 if plan and data never runs out; 50 if sometimes; 0 if always/no plan | Connection stability |
| IAT | read_score | q3_12 | Without help 100; needs help 25; cannot read 0 | Message literacy |
| IADT | iadt_appinstall | q3_15 | (response-1)/4 after 98/99 -> missing | Install applications |
| IADT | iadt_sendmoney | q3_16 | (response-1)/4 after 98/99 -> missing | Send/receive digital money |
| IADT | iadt_fraudesafe | q3_17 | (response-1)/4 after 98/99 -> missing | Avoid digital fraud |
| ICDP | icdp_qr | q3_20 | Pay and receive 100; only pay/receive 75; no QR 0 | QR competence |
| ICDP | icdp_sms | q3_21 | Always 100; sometimes 50; never 25; does not know OTP 0 | SMS/OTP competence |
| ICDP | icdp_pin | q3_22 | Yes 100; no/no apps 0 | PIN management |
| ICDP | icdp_fraud | q3_23 | Block/report 100; verify 75; ask 25; click/does not know 0 | Suspicious-message response |
| IAFF | iaff_doc | q4_1_1-q4_1_4 | 100 if any accepted KYC document is selected; otherwise 0 | KYC documentation |
| IAFF | iaff_address | q4_5 | Yes 100; in process 50; no/not stated 0 | Proof of address |
| IAFF | iaff_phone | q4_6 | Own-name phone 100; all coded alternatives 0 | Own-name telephone |
| IAFF | iaff_account | q4_12_1-q4_12_4 | 100 if bank, wallet, cooperative, or fintech account selected; otherwise 0 | Account ownership |
| IUOF | iuof_freq | q4_15 | 100, 80, 60, 40, 0 across use-frequency categories | Account-use frequency |
| IUOF | iuof_cash | q4_16 | 100, 70, 30, 0; code 99 also 0 | Cash-in/cash-out ease |
| IUOF | iuof_time | q4_17 | 100, 75, 40, 0; code 99 also 0 | Proximity |
| IUOF | iuof_pay | q4_24 | 100, 50, 0; code 99 also 0 | Payments use |
| IUOF | iuof_save | q4_25 | 100, 50, 0; code 99 also 0 | Savings use |
| IUOF | iuof_notify | q4_26 | 100, 50, 0; code 99 also 0 | Notifications |
| IUOF | iuof_risk | q4_27 | Account lending=0; no lending or code 98=100 | No account lending |
| OQI | oqi_kyc | q5_13_1-q5_13_6 | Requirement count: <=2=100; 3=70; 4=40; >=5=0 | KYC burden |
| OQI | oqi_easy | q5_14 | 100, 75, 25, 0; code 98 also 0 | Registration ease |
| OQI | oqi_time | q5_15 | 100, 80, 60, 30, 0; code 98 also 0 | Activation time |
| OQI | oqi_help | q5_16 | No help 100; help/code 98=0 | Independent registration |
| OQI | oqi_confirm | q5_5 | Categories 1/2/3=100; 4/code 98=0 | Transaction confirmation |
| OQI | oqi_cost | q5_7 | 100, 70, 30, 0; code 98 also 0 | Cost clarity |
| OQI | oqi_fail | q5_9 | No failures 100; one response category 50; failure/code 98=0 | Absence of failures |
| OQI | oqi_terms | q5_21, q5_22 | Both 1=100; both 2=50; either 3/98=0 | Terms/privacy clarity |
| OQI | oqi_support | q5_23 | 100, 50, 0; code 98 also 0 | Registration support |
| IURD | iurd_freq | q6_2 | 100, 75, 25, 0 | Remittance receipt frequency |
| IURD | iurd_digital | q6_13 | Category 1=0; categories 2/3/4/5=100 | Digital share |
| IURD | iurd_recent | q6_14 | Yes 100; no 0 | Recent digital use |
| IURD | iurd_ops | q6_15 | 20, 40, 60, 80, 100 | Digital-operation volume |
| IURD | iurd_canal | q6_4 | Bank/wallet 100; cash/physical/other 0 | Latest receipt channel |
| IETR | ietr_time | q6_6 | 100, 80, 60, 30, 0 | Remittance availability speed |
| IETR | ietr_cost | q6_9, q6_18 | Row mean of fee clarity and FX/commission display components | Cost and FX clarity |
| IETR | ietr_confirm | q6_11, q6_20 | Row mean of remittance and payment confirmation components | Confirmation |
| IETR | ietr_problem | q6_16 | 100, 75, 25, 0 according to problem category | Absence/severity of problems |
| IETR | ietr_limits | q6_17 | Never prevented operation 100; categories 1/2/3=0 | Absence of restrictive limits |
| IETR | ietr_speed | q6_21 | 100, 80, 60, 30, 0 | Perceived speed |
| IETR | ietr_surcharge | q6_22 | Extra charge 0; same/discount 100; 98/99 missing | Absence of surcharges |
| IETR | ietr_clarity | q6_23 | 100, 50, 0, 0 | Provider communication |
| IETR | ietr_eval | q6_24 | 0, 25, 50, 75, 100 | Overall evaluation |
| IPCS | e1_reaccion_segura | q7_2 | Categories 1/2/3=1; 4/5=0 | Safe reaction |
| IPCS | e1_autenticacion | q7_6 | Categories 1/2=1; 3/98=0 | Secure authentication |
| IPCS | e1_habitos_claves | q7_7 | Categories 1/2=1; 3/4=0 | Password/review habits |
| IPCS | e1_educacion | q7_8 | Category 1=1; 2/3/98=0 | Antifraud education |
| IPCS | e1_seguridad_percibida | q7_9 | Categories 1/2=1; 3/4=0 | Perceived safety |
| IPCS | e1_valora_prevencion | q7_10 | Categories 1-5=1; 6/7=0 | Prevention valuation |
| IEDF | e2_exposicion | q7_1 | Categories 1/2=1; 3/98=0 | Suspicious-message exposure |
| IEDF | e2_bloqueo | q7_5 | Categories 1/2/3=1; 4/98=0 | Fraud/error blocking |
| IEDF | e2_problema | q7_11 | Yes=1; no/98=0 | Payment/remittance problem |
| IEDF | e2_demora | q7_13 | Categories 3/4/5=1; 1/2=0 | Response delay |
| IEDF | e2_no_resuelto | q7_14 | Categories 2/3=1; 1=0 | Unresolved problem |
| IEDF | e2_insatisfaccion | q7_15 | Categories 1/2=1; 3/4=0; other codes remain missing | Resolution dissatisfaction |
| IAER | f1_decide_remesa | q9_4 | Categories 4/5=1; 1/2/3=0 | Decision over remittances |
| IAER | f1_administra | q9_5 | Categories 1/3=1; 2/4/5/98=0 | Remittance administration |
| IAER | f1_ahorro_negocio | q9_6 | Categories 1/2=1; 3/98=0 | Saving/business autonomy |
| IAER | f1_control | q9_7 | Categories 4/5=1; 1/2/3=0 | Financial control |
| IAER | f1_cuenta_propia | q9_9 | Categories 1/2=1; 3/4/98=0 | Own-name account preference |
| IAER | f1_salud | q9_11 | Categories 1/2=1; 3/4/98=0 | Health decision |
| IAER | f1_gastos | q9_13 | Categories 1/2=1; 3/4/98=0 | Household-expense decision |
| IAER | f1_opinion | q9_18 | Categories 4/5=1; 1/2/3=0 | Opinion respected |
| IAER | f1_cambiar_cuenta | q9_19 | Categories 1/2=1; 3/98=0 | Open/change account |
| IAER | f1_no_evito | q9_20 | No avoidance=1; avoidance/98=0 | No conflict-related avoidance |
| IAER | f1_sin_coercion1 | q9_8 | Code 1=0; codes 0/98=1 | Absence of account-use coercion |
| IAER | f1_sin_coercion2 | q9_16 | Code 1=0; codes 0/98=1 | Absence of remittance pressure |
| ICPF | f2_confianza | q9_1 | Categories 4/5=1; 1/2/3=0 | Provider trust |
| ICPF | f2_normas | q9_15 | Categories 4/5=1; 1/2/3=0 | Household norms |
| ICPF | f2_comunidad | q9_22 | Category 1=1; 2/3/4/98=0 | Community trust |
| ICPF | f2_sin_consecuencias | q9_17_1-q9_17_3 | Row total=0 ->1; >0 ->0 | No privacy consequences |
| ICPF | f2_sin_mitigaciones | q9_21_1-q9_21_3 | Row total=0 ->1; >0 ->0 | No conflict mitigation |
| IEH | g1_info | q10_4 | Categories 3/4=1 | Information |
| IEH | g1_cashout | q10_6 | Categories 1/2=1 | Cash-out environment |
| IEH | g1_capacitacion | q10_10 | Categories 1/2=1 | Training participation |
| IEH | g1_impacto_cap | q10_12 | Categories 3/4=1 | Training impact |
| IEH | g1_acompanamiento | q10_13 | Category 1=1 | Individual support |
| IEH | g1_materiales | q10_16 | Categories 1/2=1 | Educational materials |
| IBPD | g2_barrera_principal | q10_1 | Codes 1-15=1 | Main barrier |
| IBPD | g2_barreras_extra_bin | q10_2_1-q10_2_12, q10_2_14-q10_2_15 | Row total >0 ->1 | Additional barriers |
| IBPD | g2_poca_info | q10_4 | Categories 1/2=1 | Low information |
| IBPD | g2_cashout_dificil | q10_6 | Categories 3/4/5/98=1 | Cash-out difficulty |
| IBPD | g2_sin_materiales | q10_16 | Categories 4/98=1 | No educational materials |

## Sheet: Notes

| Current-analysis freeze |
| --- |
| This workbook documents the quantitative indices exactly as implemented in the current Stata data-preparation code. It does not correct, reinterpret, or replace any score, model, regression, interaction, LCA specification, class assignment, or segment label. |
| Aggregation |
| All index calculations use egen rowmean() unless otherwise stated. Consequently, an index can be calculated from the nonmissing subset of its components. The tables document the current implementation and should be read together with the Stata code. |
| Public-release scope |
| Only aggregate definitions are included. No respondent-level values or direct identifiers are reproduced in this workbook. |
| Source |
| 1 Code/1 Data Preparation_CFI DPI Migrant Women Colombia.do, current working-tree version. |
