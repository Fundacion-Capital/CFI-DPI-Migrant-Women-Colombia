# Hybrid distribution diagnostics

This is a display-only Markdown rendering of [the authoritative Excel workbook](../Table_F14_Hybrid_Distribution_Diagnostics.xlsx). The workbook remains the source file for download and replication.

## Sheet: diagnostics

| variable | construct | N_nonmissing | n_distinct | min | p25 | p33 | p50 | p67 | p75 | max | mean | sd | skewness | floor_pct | ceiling_pct | recommended_treatment | rationale |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ivs_score | Socioeconomic vulnerability | 423 | 131 | 0.2367 | 0.48 | 0.5167 | 0.6067 | 0.6433 | 0.6767 | 1 | 0.5938 | 0.1555 | 0.0305 | 0 | 0.2364 | tertile | Sufficient variation for low/medium/high ordinal recoding |
| iat_score | Telecommunications access | 423 | 36 | 0.35 | 0.7 | 0.75 | 0.78 | 0.8 | 0.88 | 1 | 0.7797 | 0.1365 | -0.4534 | 0.2364 | 11.8203 | tertile | Sufficient variation for low/medium/high ordinal recoding |
| iadt_score | Digital self-efficacy | 423 | 14 | 0 | 0.75 | 0.75 | 0.75 | 0.9167 | 1 | 1 | 0.783 | 0.2073 | -1.1032 | 1.4184 | 32.1513 | binary | High floor or ceiling concentration |
| icdp_score | Practical digital competence | 423 | 17 | 0 | 0.75 | 0.8125 | 0.9375 | 0.9375 | 0.9375 | 1 | 0.8169 | 0.2025 | -1.4782 | 0.2364 | 18.6761 | binary | Strongly skewed distribution |
| iaff_score | Formal financial access | 423 | 7 | 0.25 | 0.5 | 0.5 | 0.75 | 0.75 | 0.75 | 1 | 0.6894 | 0.2234 | -0.1062 | 7.0922 | 23.4043 | tertile | Sufficient variation for low/medium/high ordinal recoding |
| iuof_score_01 | Financial operability | 423 | 98 | 0.1 | 0.6286 | 0.6929 | 0.7857 | 0.8429 | 0.8857 | 1 | 0.7378 | 0.1872 | -0.8516 | 0 | 7.3286 | tertile | Sufficient variation for low/medium/high ordinal recoding |
| oqi_score_01 | Onboarding quality | 423 | 138 | 0.1111 | 0.6563 | 0.6833 | 0.7833 | 0.85 | 0.8813 | 1 | 0.7475 | 0.1826 | -0.987 | 0.2364 | 3.0733 | tertile | Sufficient variation for low/medium/high ordinal recoding |
| iurd_score_01 | Digital remittance intensity | 423 | 58 | 0 | 0.43 | 0.5 | 0.63 | 0.69 | 0.76 | 1 | 0.5866 | 0.2238 | -0.3859 | 1.182 | 0.9456 | tertile | Sufficient variation for low/medium/high ordinal recoding |
| ietr_score_01 | Transactional experience | 423 | 128 | 0 | 0.6167 | 0.6444 | 0.7188 | 0.8056 | 0.8389 | 1 | 0.7189 | 0.1525 | -0.6262 | 0.2364 | 2.8369 | tertile | Sufficient variation for low/medium/high ordinal recoding |
| IPCS | Prevention and safe conduct | 423 | 10 | 0 | 66.6667 | 66.6667 | 80 | 100 | 100 | 100 | 77.9117 | 22.592 | -0.943 | 0.4728 | 36.643 | binary | High floor or ceiling concentration |
| IEDF | Fraud exposure and recourse harm | 423 | 10 | 0 | 0 | 0 | 33.3333 | 33.3333 | 50 | 100 | 28.1403 | 23.9043 | 0.1715 | 35.9338 | 0.2364 | binary | Risk/harm construct; binary split is more interpretable |
| IAER | Autonomy over remittances | 423 | 11 | 16.6667 | 91.6667 | 91.6667 | 100 | 100 | 100 | 100 | 92.0016 | 13.5293 | -2.3801 | 0 | 58.156 | profile_only_or_binary | Autonomy is ceiling-heavy; better as profiling variable or sensitivity |
| ICPF | Trust and norms climate | 423 | 5 | 20 | 60 | 60 | 80 | 80 | 80 | 100 | 66.5248 | 17.9778 | -0.7461 | 4.2553 | 3.5461 | binary_or_existing | Low number of distinct observed values |
| IEH | Enabling environment | 423 | 10 | 0 | 20 | 40 | 50 | 60 | 66.6667 | 100 | 47.1789 | 24.3737 | 0.0332 | 4.9645 | 2.3641 | tertile | Sufficient variation for low/medium/high ordinal recoding |
| IBPD | Perceived barriers | 423 | 6 | 0 | 40 | 40 | 60 | 60 | 60 | 100 | 53.9007 | 21.9793 | -0.6734 | 4.9645 | 1.182 | tertile | Sufficient variation for low/medium/high ordinal recoding |
