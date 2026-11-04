* Historical Section I: numerical inputs to the broader descriptive figures.
* Only on the separately verified descriptive carrier; do not load it here.
* Review copy: no graph rendering, relabelling or export.
exit 198

set varabbrev off

* Figures 1–5: the first three variables below have different meanings.
* q4 is age; q3 is historical residence; years_in_col is the legacy calendar gap.
summarize q4, detail
tabulate q3
summarize years_in_col, detail
tabulate years_in_col
tabulate q2_2
tabulate q2_3

* Figures 6–10 and Table 2 have a separate old-state comparison do-file.

* Figures 11–15: separate response distributions and group means.
tabulate q3_16
tabstat iadt_score if !missing(iat_cat), by(iat_cat) statistics(n mean)
tabulate q3_20
tabulate age_cat icdp_cat, row
tabstat icdp_score if q2_2 != 1 & !missing(q2_2), by(q2_2) statistics(n mean semean)

* Figure 16: last matching product wins in the source. This is not prevalence.
* Keep the original fixed denominator and the four mutually exclusive counts.
quietly count if q4_12_1 == 1 & q4_12_2 != 1 & q4_12_3 != 1 & q4_12_4 != 1
display as text "Bank N and % of 423: " as result r(N) "  " 100*r(N)/423
quietly count if q4_12_2 == 1 & q4_12_3 != 1 & q4_12_4 != 1
display as text "Wallet N and % of 423: " as result r(N) "  " 100*r(N)/423
quietly count if q4_12_3 == 1 & q4_12_4 != 1
display as text "Cooperative N and % of 423: " as result r(N) "  " 100*r(N)/423
quietly count if q4_12_4 == 1
display as text "Fintech/EMI N and % of 423: " as result r(N) "  " 100*r(N)/423

* Figures 17–24: historical group bins, rail dummies and receipt channels.
tabulate years_cat iaff_cat, row
tabstat iaff_score if q2_2 != 1 & !missing(q2_2), by(q2_2) statistics(n mean semean)
summarize iuof_score_01, detail
* Figure 20 groups on iaff_cat, not the separately named tercile.
tabulate iaff_cat iuof_cat, row
* Means are proportions, multiplied by 100 in the original graphic.
tabstat q5_1_1 q5_1_2 q5_1_3 q5_1_4 q5_2_1 q5_2_2 q5_2_3 q5_2_4, ///
    statistics(n mean) columns(statistics)
tabstat oqi_score_01 if !missing(iaff_cat), by(iaff_cat) statistics(n mean semean)
tabstat oqi_score_01 if !missing(icdp_cat), by(icdp_cat) statistics(n mean semean)
* Preserve the literal system-missing rule used in the receipt-channel source.
tabulate q6_4 if q6_4 != ., missing

* Figures 25–30: legacy scales and filters, not revised adverse-event measures.
summarize ietr_score_01, detail
tabulate oqi_cat iurd_cat, row
* Legacy Figure 27 put every q7_5 code outside 1–3 in the reference group.
* These are two q7_9 distributions; the second is not verified unexposed.
tabulate q7_9 if inlist(q7_5, 1, 2, 3)
tabulate q7_9 if !inlist(q7_5, 1, 2, 3)
* Figures 28–29 and 32–34 scale these means and SEs by 1/100 for plotting.
tabstat IEDF if oqi_cat != . & IEDF != ., by(oqi_cat) statistics(n mean semean)
tabstat IEDF if icdp_cat != . & IEDF != ., by(icdp_cat) statistics(n mean semean)
tabulate q7_15 if q7_15 != . & q7_15 != 98, missing

* Figures 31–34: historical agency/trust scores on stored units (divide by 100 for plotting).
summarize IAER, detail
tabstat IAER if iurd_cat != . & IAER != ., by(iurd_cat) statistics(n mean semean)
tabstat IEDF if IAER_cat != . & IEDF != ., by(IAER_cat) statistics(n mean semean)
tabstat ICPF if iurd_cat != . & ICPF != ., by(iurd_cat) statistics(n mean semean)

* Figures 35–37: report ranking inputs, not an invented tie-break rule.
* All three original percentages used 423, not valid answers to the item.
* Figure 36's stored enabler names do not reliably describe their source options.
* Read the q10_3 crosswalk in the audit before interpreting these counts.
tabulate q10_1 if !missing(q10_1) & q10_1 != 98, sort
display as text "Figures 35–37 historical percentage denominator: 423"
tabstat enabler_capacitacion enabler_comisiones_bajas enabler_mejor_tc ///
    enabler_material_claro enabler_mas_comercios enabler_ayuda_cuenta ///
    enabler_mejor_internet, statistics(n sum) columns(statistics) varwidth(32)
tabstat tema_comisiones tema_tiempos tema_riesgos_fraude tema_reclamos ///
    tema_agentes tema_beneficios, statistics(n sum) columns(statistics) varwidth(32)

* Figures 38–39: display group-conditioned audit counts; verify graph percentages separately.
tabulate ivs_cat IBPD_cat, row
tabulate iat_cat IBPD_cat, row
