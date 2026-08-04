# LCA recoding

This is a display-only Markdown rendering of [the authoritative Excel workbook](../Table_F6_LCA_Recoding.xlsx). The workbook remains the source file for download and replication.

## Sheet: recoding_metadata

| lca_variable | source_variable | construct | variable_type | planned_role | coding_rule | methodological_note |
| --- | --- | --- | --- | --- | --- | --- |
| lca_iurd3 | iurd_cat | Digital remittance/payment intensity | Ordinal 1-3 | Preferred main LCA | Keeps original IURD categories: 1 low, 2 medium, 3 high intensity | Core behavioral construct; formal_remittance excluded from main LCA to avoid overlap |
| lca_ieh3 | IEH_cat | Enabling environment | Ordinal 1-3 | Preferred main LCA | Keeps original IEH categories: 1 low, 2 medium, 3 high enabling environment | Preferred external-support construct; IBPD excluded from main model due inverse overlap |
| lca_iaff3 | iaff_cat | Formal financial access | Ordinal 1-3 | Preferred main LCA | Keeps original IAFF categories: 1 low, 2 medium, 3 high formal access | Core formalization gateway construct |
| lca_iedf2 | IEDF_cat | Fraud harm and recourse failure | Binary 0/1 | Preferred main LCA | Collapses medium and high harm into 1; low/no harm coded 0 | Preferred because high-harm category is extremely sparse |
| lca_oqi3 | oqi_cat | Onboarding quality | Ordinal 1-3 | Preferred main LCA | Keeps original OQI categories: 1 high friction, 2 medium, 3 good onboarding | Core DPI design construct capturing entry friction and transparency |
| lca_icdp3 | icdp_cat | Practical digital competence | Ordinal 1-3 | Preferred main LCA | Keeps original ICDP categories: 1 low, 2 medium, 3 high competence | Core capability construct; stronger behavioral meaning than self-efficacy alone |
| lca_ivs3 | ivs_cat | Socioeconomic vulnerability | Ordinal 1-3 | Preferred main LCA | Keeps original IVS categories: 1 low, 2 medium, 3 high vulnerability | Retained because it captures structural socioeconomic constraints with acceptable variation |
| lca_iat2 | iat_cat | Telecommunications access | Binary 0/1 | Preferred main LCA | Collapses low and medium access into 0; high access coded 1 | Preferred because the low digital access category is sparse |
| lca_icpf2 | ICPF_cat | Trust and relational climate | Binary 0/1 | Preferred main LCA | Collapses low and medium trust climate into 0; high trust climate coded 1 | Preferred because the low trust category is sparse |
| lca_iaer2 | IAER_cat | Autonomy | Binary 0/1 | Profile/sensitivity | Collapses low and medium autonomy into 0; high autonomy coded 1 | Autonomy is ceiling-heavy; better treated as profile outcome than main class-defining input |
| lca_iaer3 | IAER_cat | Autonomy | Ordinal 1-3 | Profile/sensitivity | Keeps original IAER categories: 1 low, 2 medium, 3 high autonomy | Low category is extremely sparse; not recommended for preferred LCA |
| aware_breb | q5_1_1 | Bre-B awareness | Binary 0/1 | Profile/validation | Aware of Bre-B coded 1; otherwise coded 0 | Likely sparse; retained for profiling only |
| used_breb | q5_2_1 | Bre-B use | Binary 0/1 | Profile/validation | Used Bre-B coded 1; otherwise coded 0 | Likely sparse; retained for profiling only |
| formal_remittance | q6_4 | Formal remittance channel | Binary 0/1 | Profile/validation | Bank transfer or wallet/app coded 1; cash pickup or traveler coded 0; other coded missing | Excluded from main LCA because it strongly overlaps with IURD |
| avoided_due_conflict | q9_20 | Household conflict and digital use | Binary 0/1 | Profile/validation | Avoided digital use due to conflict coded 1; otherwise coded 0; prefer not coded missing | Used to connect final profiles to household autonomy constraints |
| individual_support | q10_13 | Individual support | Binary 0/1 | Profile/validation | Received individual support coded 1; no support coded 0; prefer not coded missing | Useful for interpreting support-dependent profiles |
| any_rail_use | q5_2_1-q5_2_5 | Payment rail use | Binary 0/1 | Profile/validation | Used at least one named payment rail coded 1; otherwise coded 0 | Used to profile actual rails engagement outside the class-defining model |
| any_problem | q7_11 | Payment/remittance problem | Binary 0/1 | Profile/validation | Had problem coded 1; no problem coded 0; DK coded missing | Used to validate risk/recourse class interpretation |
| any_qr_use | q5_4 | QR use | Binary 0/1 | Profile/validation | Any QR payment or receipt coded 1; no QR use coded 0 | Useful behavioral profile variable |
| recent_digital_txn | q6_14 | Recent digital use | Binary 0/1 | Profile/validation | Yes coded 1; No coded 0; prefer not to respond coded missing | Highly skewed, so retained as profiling variable |
| recent_training_12m | q10_10 | Recent training exposure | Binary 0/1 | Profile/validation | Training in last 12 months coded 1; older or never coded 0; DK coded missing | Used to distinguish recent from older program exposure |
| remit_channel_profile | q6_4 | Remittance channel | Nominal | Profile/validation | Keeps valid latest-remittance channel categories 1 to 5 | Used for descriptive interpretation of final classes |
| any_training_3y | q10_10 | Training exposure | Binary 0/1 | Profile/validation | Any training in last 3 years coded 1; never coded 0; DK coded missing | Used to profile exposure to support and programs |
| lca_iuof3_q | iuof_score_01 | Financial operability | Ordinal 1-3 | Sensitivity | Recreated using terciles of IUOF distribution | Used only to test sensitivity to threshold-based categorization |
| lca_iat3 | iat_cat | Telecommunications access | Ordinal 1-3 | Sensitivity | Keeps original IAT categories: 1 low, 2 medium, 3 high | Used to test whether the binary collapse hides meaningful variation |
| lca_icpf3 | ICPF_cat | Trust and relational climate | Ordinal 1-3 | Sensitivity | Keeps original ICPF categories: 1 low, 2 medium, 3 high climate | Used to test sensitivity to binary collapse |
| lca_iadt2 | iadt_cat | Digital self-efficacy | Binary 0/1 | Sensitivity/profile | Collapses low and medium self-efficacy into 0; high self-efficacy coded 1 | Not preferred in main LCA because it is ceiling-heavy and overlaps with ICDP |
| lca_iadt3 | iadt_cat | Digital self-efficacy | Ordinal 1-3 | Sensitivity/profile | Keeps original IADT categories: 1 low, 2 medium, 3 high | Low category is sparse; mainly retained for diagnostics and sensitivity |
| lca_iuof3 | iuof_score_01 | Financial operability | Ordinal 1-3 | Sensitivity/profile | Recreated using thresholds: <0.50 low, 0.50-0.79 medium, >=0.80 high | Important outcome-like construct but locally dependent with ICDP, OQI, and IPCS |
| lca_iedf3 | IEDF_cat | Fraud harm and recourse failure | Ordinal 1-3 | Sensitivity/profile | Keeps original IEDF categories: 1 low, 2 medium, 3 high harm | Retained only for diagnostics because high category is sparse |
| lca_ibpd3 | IBPD_cat | Perceived barriers | Ordinal 1-3 | Sensitivity/profile | Keeps original IBPD categories: 1 low, 2 medium, 3 high barriers | Alternative to IEH in sensitivity models; not used together in preferred LCA |
| lca_ipcs3 | IPCS_cat | Safe conduct and prevention | Ordinal 1-3 | Sensitivity/profile | Keeps original IPCS categories: 1 low, 2 medium, 3 high safe conduct | Important safety construct but locally dependent with ICDP and IUOF |
| lca_ietr2 | ietr_cat | Transactional experience | Binary 0/1 | Sensitivity/profile | Collapses poor and regular experience into 0; good experience coded 1 | Preferred over 3-level version if included because poor-experience category is sparse |
| lca_ietr3 | ietr_cat | Transactional experience | Ordinal 1-3 | Sensitivity/profile | Keeps original IETR categories: 1 poor, 2 regular, 3 good experience | Not preferred in main LCA because it overlaps with OQI and has sparse low category |

## Sheet: recoded_distributions

| variable | variable_label | planned_role | category_value | category_label | frequency | percent | cumulative_percent | sparse_flag | diagnostic_flag |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| lca_iaff3 | LCA: Formal financial access, 3 levels | Preferred main LCA | 1 | Low formal financial access | 31 | 7.3286 | 7.3286 | 0 | OK |
| lca_iaff3 | LCA: Formal financial access, 3 levels | Preferred main LCA | 2 | Medium formal financial access | 290 | 68.5579 | 75.8865 | 0 | OK |
| lca_iaff3 | LCA: Formal financial access, 3 levels | Preferred main LCA | 3 | High formal financial access | 102 | 24.1135 | 100 | 0 | OK |
| lca_iat2 | LCA: High digital access, binary | Preferred main LCA | 0 | Low/medium digital access | 217 | 51.3002 | 51.3002 | 0 | OK |
| lca_iat2 | LCA: High digital access, binary | Preferred main LCA | 1 | High digital access | 206 | 48.6998 | 100 | 0 | OK |
| lca_icdp3 | LCA: Practical digital competence, 3 levels | Preferred main LCA | 1 | Low practical digital competence | 30 | 7.0922 | 7.0922 | 0 | OK |
| lca_icdp3 | LCA: Practical digital competence, 3 levels | Preferred main LCA | 2 | Medium practical digital competence | 106 | 25.0591 | 32.1513 | 0 | OK |
| lca_icdp3 | LCA: Practical digital competence, 3 levels | Preferred main LCA | 3 | High practical digital competence | 287 | 67.8487 | 100 | 0 | OK |
| lca_icpf2 | LCA: High trust and relational climate, binary | Preferred main LCA | 0 | Low/medium trust climate | 209 | 49.409 | 49.409 | 0 | OK |
| lca_icpf2 | LCA: High trust and relational climate, binary | Preferred main LCA | 1 | High trust climate | 214 | 50.591 | 100 | 0 | OK |
| lca_iedf2 | LCA: Medium/high fraud harm or recourse failure, binary | Preferred main LCA | 0 | Low/no fraud harm or recourse failure | 307 | 72.5768 | 72.5768 | 0 | OK |
| lca_iedf2 | LCA: Medium/high fraud harm or recourse failure, binary | Preferred main LCA | 1 | Medium/high fraud harm or recourse failure | 116 | 27.4232 | 100 | 0 | OK |
| lca_ieh3 | LCA: Enabling environment, 3 levels | Preferred main LCA | 1 | Low enabling environment | 131 | 30.9693 | 30.9693 | 0 | OK |
| lca_ieh3 | LCA: Enabling environment, 3 levels | Preferred main LCA | 2 | Medium enabling environment | 230 | 54.3735 | 85.3428 | 0 | OK |
| lca_ieh3 | LCA: Enabling environment, 3 levels | Preferred main LCA | 3 | High enabling environment | 62 | 14.6572 | 100 | 0 | OK |
| lca_iurd3 | LCA: Digital remittance/payment intensity, 3 levels | Preferred main LCA | 1 | Low digital-remittance intensity | 45 | 10.6383 | 10.6383 | 0 | OK |
| lca_iurd3 | LCA: Digital remittance/payment intensity, 3 levels | Preferred main LCA | 2 | Medium digital-remittance intensity | 129 | 30.4965 | 41.1348 | 0 | OK |
| lca_iurd3 | LCA: Digital remittance/payment intensity, 3 levels | Preferred main LCA | 3 | High digital-remittance intensity | 249 | 58.8652 | 100 | 0 | OK |
| lca_ivs3 | LCA: Socioeconomic vulnerability, 3 levels | Preferred main LCA | 1 | Low vulnerability | 23 | 5.4374 | 5.4374 | 0 | OK |
| lca_ivs3 | LCA: Socioeconomic vulnerability, 3 levels | Preferred main LCA | 2 | Medium vulnerability | 283 | 66.9031 | 72.3404 | 0 | OK |
| lca_ivs3 | LCA: Socioeconomic vulnerability, 3 levels | Preferred main LCA | 3 | High vulnerability | 117 | 27.6596 | 100 | 0 | OK |
| lca_oqi3 | LCA: Onboarding quality, 3 levels | Preferred main LCA | 1 | High onboarding friction | 39 | 9.2199 | 9.2199 | 0 | OK |
| lca_oqi3 | LCA: Onboarding quality, 3 levels | Preferred main LCA | 2 | Medium onboarding quality | 241 | 56.974 | 66.1939 | 0 | OK |
| lca_oqi3 | LCA: Onboarding quality, 3 levels | Preferred main LCA | 3 | Good onboarding / low friction | 143 | 33.8061 | 100 | 0 | OK |
| any_problem | Profile: Had at least one payment/remittance problem | Profile/validation | 0 | No | 297 | 73.3333 | 73.3333 | 0 | OK |
| any_problem | Profile: Had at least one payment/remittance problem | Profile/validation | 1 | Yes | 108 | 26.6667 | 100 | 0 | OK |
| any_qr_use | Profile: Used QR to pay or receive in last 30 days | Profile/validation | 0 | No | 94 | 22.2222 | 22.2222 | 0 | OK |
| any_qr_use | Profile: Used QR to pay or receive in last 30 days | Profile/validation | 1 | Yes | 329 | 77.7778 | 100 | 0 | OK |
| any_rail_use | Profile: Used at least one named payment rail | Profile/validation | 0 | No | 60 | 14.1844 | 14.1844 | 0 | OK |
| any_rail_use | Profile: Used at least one named payment rail | Profile/validation | 1 | Yes | 363 | 85.8156 | 100 | 0 | OK |
| any_training_3y | Profile: Any training in last 3 years | Profile/validation | 0 | No | 210 | 53.0303 | 53.0303 | 0 | OK |
| any_training_3y | Profile: Any training in last 3 years | Profile/validation | 1 | Yes | 186 | 46.9697 | 100 | 0 | OK |
| avoided_due_conflict | Profile: Avoided digital payments due to household conflict | Profile/validation | 0 | No | 364 | 88.3495 | 88.3495 | 0 | OK |
| avoided_due_conflict | Profile: Avoided digital payments due to household conflict | Profile/validation | 1 | Yes | 48 | 11.6505 | 100 | 0 | OK |
| aware_breb | Profile: Aware of Bre-B | Profile/validation | 0 | No | 153 | 36.1702 | 36.1702 | 0 | OK |
| aware_breb | Profile: Aware of Bre-B | Profile/validation | 1 | Yes | 270 | 63.8298 | 100 | 0 | OK |
| formal_remittance | Profile: Latest remittance through formal digital channel | Profile/validation | 0 | Cash pickup / traveler | 156 | 38.806 | 38.806 | 0 | OK |
| formal_remittance | Profile: Latest remittance through formal digital channel | Profile/validation | 1 | Bank transfer / wallet-app | 246 | 61.194 | 100 | 0 | OK |
| individual_support | Profile: Received individual support for digital payments/remittances | Profile/validation | 0 | No | 265 | 64.4769 | 64.4769 | 0 | OK |
| individual_support | Profile: Received individual support for digital payments/remittances | Profile/validation | 1 | Yes | 146 | 35.5231 | 100 | 0 | OK |
| rails_used_count | Profile: Count of named payment rails used | Profile/validation | 0 | 0 | 60 | 14.1844 | 14.1844 | 0 | OK |
| rails_used_count | Profile: Count of named payment rails used | Profile/validation | 1 | 1 | 221 | 52.2459 | 66.4303 | 0 | OK |
| rails_used_count | Profile: Count of named payment rails used | Profile/validation | 2 | 2 | 87 | 20.5674 | 86.9976 | 0 | OK |
| rails_used_count | Profile: Count of named payment rails used | Profile/validation | 3 | 3 | 50 | 11.8203 | 98.818 | 0 | OK |
| rails_used_count | Profile: Count of named payment rails used | Profile/validation | 4 | 4 | 5 | 1.182 | 100 | 1 | SPARSE_CATEGORY |
| recent_digital_txn | Profile: Used digital payments/remittances in last 60 days | Profile/validation | 0 | No | 45 | 10.8959 | 10.8959 | 0 | OK |
| recent_digital_txn | Profile: Used digital payments/remittances in last 60 days | Profile/validation | 1 | Yes | 368 | 89.1041 | 100 | 0 | OK |
| recent_training_12m | Profile: Training in last 12 months | Profile/validation | 0 | No | 272 | 68.6869 | 68.6869 | 0 | OK |
| recent_training_12m | Profile: Training in last 12 months | Profile/validation | 1 | Yes | 124 | 31.3131 | 100 | 0 | OK |
| remit_channel_profile | Profile: Latest remittance channel, original valid categories | Profile/validation | 1 | Transferencia a cuenta bancaria | 130 | 30.7329 | 30.7329 | 0 | OK |
| remit_channel_profile | Profile: Latest remittance channel, original valid categories | Profile/validation | 2 | Billetera / app (Nequi, Daviplata) | 116 | 27.4232 | 58.156 | 0 | OK |
| remit_channel_profile | Profile: Latest remittance channel, original valid categories | Profile/validation | 3 | Cobro en efectivo en corresponsal / ventanilla | 144 | 34.0426 | 92.1986 | 0 | OK |
| remit_channel_profile | Profile: Latest remittance channel, original valid categories | Profile/validation | 4 | Entrega en mano por viajero | 12 | 2.8369 | 95.0355 | 1 | SPARSE_CATEGORY |
| remit_channel_profile | Profile: Latest remittance channel, original valid categories | Profile/validation | 5 | Otro medio (especifique) | 21 | 4.9645 | 100 | 1 | SPARSE_CATEGORY |
| used_breb | Profile: Used Bre-B in last 60 days | Profile/validation | 0 | No | 236 | 55.792 | 55.792 | 0 | OK |
| used_breb | Profile: Used Bre-B in last 60 days | Profile/validation | 1 | Yes | 187 | 44.208 | 100 | 0 | OK |
| lca_iadt2 | LCA sensitivity: High digital self-efficacy, binary | Sensitivity/profile | 0 | Low/medium digital self-efficacy | 72 | 17.0213 | 17.0213 | 0 | OK |
| lca_iadt2 | LCA sensitivity: High digital self-efficacy, binary | Sensitivity/profile | 1 | High digital self-efficacy | 351 | 82.9787 | 100 | 0 | OK |
| lca_iadt3 | LCA sensitivity: Digital self-efficacy, 3 levels | Sensitivity/profile | 1 | Low digital self-efficacy | 11 | 2.6005 | 2.6005 | 1 | SPARSE_CATEGORY |
| lca_iadt3 | LCA sensitivity: Digital self-efficacy, 3 levels | Sensitivity/profile | 2 | Medium digital self-efficacy | 61 | 14.4208 | 17.0213 | 0 | OK |
| lca_iadt3 | LCA sensitivity: Digital self-efficacy, 3 levels | Sensitivity/profile | 3 | High digital self-efficacy | 351 | 82.9787 | 100 | 0 | OK |
| lca_iaer2 | LCA profile/sensitivity: High autonomy, binary | Sensitivity/profile | 0 | Low/medium autonomy | 90 | 21.2766 | 21.2766 | 0 | OK |
| lca_iaer2 | LCA profile/sensitivity: High autonomy, binary | Sensitivity/profile | 1 | High autonomy | 333 | 78.7234 | 100 | 0 | OK |
| lca_iaer3 | LCA profile/sensitivity: Autonomy, 3 levels | Sensitivity/profile | 1 | Low autonomy | 4 | 0.9456 | 0.9456 | 1 | SPARSE_CATEGORY |
| lca_iaer3 | LCA profile/sensitivity: Autonomy, 3 levels | Sensitivity/profile | 2 | Medium autonomy | 86 | 20.331 | 21.2766 | 0 | OK |
| lca_iaer3 | LCA profile/sensitivity: Autonomy, 3 levels | Sensitivity/profile | 3 | High autonomy | 333 | 78.7234 | 100 | 0 | OK |
| lca_iat3 | LCA: Digital access, 3 levels | Sensitivity/profile | 1 | Low digital access | 10 | 2.3641 | 2.3641 | 1 | SPARSE_CATEGORY |
| lca_iat3 | LCA: Digital access, 3 levels | Sensitivity/profile | 2 | Medium digital access | 207 | 48.9362 | 51.3002 | 0 | OK |
| lca_iat3 | LCA: Digital access, 3 levels | Sensitivity/profile | 3 | High digital access | 206 | 48.6998 | 100 | 0 | OK |
| lca_ibpd3 | LCA sensitivity/profile: Perceived barriers, 3 levels | Sensitivity/profile | 1 | Low perceived barriers | 63 | 14.8936 | 14.8936 | 0 | OK |
| lca_ibpd3 | LCA sensitivity/profile: Perceived barriers, 3 levels | Sensitivity/profile | 2 | Medium perceived barriers | 265 | 62.6478 | 77.5414 | 0 | OK |
| lca_ibpd3 | LCA sensitivity/profile: Perceived barriers, 3 levels | Sensitivity/profile | 3 | High perceived barriers | 95 | 22.4586 | 100 | 0 | OK |
| lca_icpf3 | LCA sensitivity: Trust and relational climate, 3 levels | Sensitivity/profile | 1 | Low trust/relational climate | 18 | 4.2553 | 4.2553 | 1 | SPARSE_CATEGORY |
| lca_icpf3 | LCA sensitivity: Trust and relational climate, 3 levels | Sensitivity/profile | 2 | Medium trust/relational climate | 191 | 45.1537 | 49.409 | 0 | OK |
| lca_icpf3 | LCA sensitivity: Trust and relational climate, 3 levels | Sensitivity/profile | 3 | High trust/relational climate | 214 | 50.591 | 100 | 0 | OK |
| lca_iedf3 | LCA sensitivity/profile: Fraud harm and recourse failure, 3 levels | Sensitivity/profile | 1 | Low fraud harm / recourse failure | 307 | 72.5768 | 72.5768 | 0 | OK |
| lca_iedf3 | LCA sensitivity/profile: Fraud harm and recourse failure, 3 levels | Sensitivity/profile | 2 | Medium fraud harm / recourse failure | 110 | 26.0047 | 98.5816 | 0 | OK |
| lca_iedf3 | LCA sensitivity/profile: Fraud harm and recourse failure, 3 levels | Sensitivity/profile | 3 | High fraud harm / recourse failure | 6 | 1.4184 | 100 | 1 | SPARSE_CATEGORY |
| lca_ietr2 | LCA sensitivity/profile: Good transactional experience, binary | Sensitivity/profile | 0 | Poor/regular transactional experience | 331 | 78.2506 | 78.2506 | 0 | OK |
| lca_ietr2 | LCA sensitivity/profile: Good transactional experience, binary | Sensitivity/profile | 1 | Good transactional experience | 92 | 21.7494 | 100 | 0 | OK |
| lca_ietr3 | LCA sensitivity/profile: Transactional experience, 3 levels | Sensitivity/profile | 1 | Poor transactional experience | 13 | 3.0733 | 3.0733 | 1 | SPARSE_CATEGORY |
| lca_ietr3 | LCA sensitivity/profile: Transactional experience, 3 levels | Sensitivity/profile | 2 | Regular transactional experience | 318 | 75.1773 | 78.2506 | 0 | OK |
| lca_ietr3 | LCA sensitivity/profile: Transactional experience, 3 levels | Sensitivity/profile | 3 | Good transactional experience | 92 | 21.7494 | 100 | 0 | OK |
| lca_ipcs3 | LCA sensitivity/profile: Safe conduct and prevention, 3 levels | Sensitivity/profile | 1 | Low safe-conduct/prevention | 48 | 11.3475 | 11.3475 | 0 | OK |
| lca_ipcs3 | LCA sensitivity/profile: Safe conduct and prevention, 3 levels | Sensitivity/profile | 2 | Medium safe-conduct/prevention | 220 | 52.0095 | 63.357 | 0 | OK |
| lca_ipcs3 | LCA sensitivity/profile: Safe conduct and prevention, 3 levels | Sensitivity/profile | 3 | High safe-conduct/prevention | 155 | 36.643 | 100 | 0 | OK |
| lca_iuof3 | LCA sensitivity/profile: Financial operability, threshold 3 levels | Sensitivity/profile | 1 | Low financial operability | 61 | 14.4208 | 14.4208 | 0 | OK |
| lca_iuof3 | LCA sensitivity/profile: Financial operability, threshold 3 levels | Sensitivity/profile | 2 | Medium financial operability | 167 | 39.4799 | 53.9007 | 0 | OK |
| lca_iuof3 | LCA sensitivity/profile: Financial operability, threshold 3 levels | Sensitivity/profile | 3 | High financial operability | 195 | 46.0993 | 100 | 0 | OK |
| lca_iuof3_q | LCA sensitivity: Financial operability, tercile 3 levels | Sensitivity/profile | 1 | Low financial operability | 143 | 33.8061 | 33.8061 | 0 | OK |
| lca_iuof3_q | LCA sensitivity: Financial operability, tercile 3 levels | Sensitivity/profile | 2 | Medium financial operability | 142 | 33.5697 | 67.3759 | 0 | OK |
| lca_iuof3_q | LCA sensitivity: Financial operability, tercile 3 levels | Sensitivity/profile | 3 | High financial operability | 138 | 32.6241 | 100 | 0 | OK |
