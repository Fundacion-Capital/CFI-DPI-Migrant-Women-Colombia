/*------------------------------------------------------------------------------*
| Title: 			Data Preparation code										|
| Project: 			CFI - Digital Public Infrastructure Migrant Women Colombia	|
| Authors:			Jorge Zavala 												|
| 					  									                        |
|																				|
| Description:		Imports and aggregates "CFI"			 					|
|                                                                               |
| Date created: 09/02/2026			 					                        |										          
|																			    |
| Version: Stata 16	                        							 	    |
*-------------------------------------------------------------------------------*/


/*--------------------------*
*           INDEX           *
*---------------------------*

	I.   Análisis descriptivo
	II.  Análisis con regresiones
	III. Análisis de cluster


*---------------------------*
*		0. Data intake		*
*---------------------------*/
	use "${output_dir}/CFI_DPI Data for analysis.dta", clear

*-------------------------------*
*		I. Descriptive  		*
*-------------------------------*
{
		*2.1 Demographic profile
		graph set window fontface "Times New Roman"

		*Edad
		summarize q4, detail
		local med = r(p50) // Guarda la mediana

		hist q4, percent kdensity ///
			color(gray) lcolor(black) /// Colores para consistencia visual
			xtitle("Age (years)", size(small)) ///
			ytitle("Percentage of respondents", size(small)) ///
			ylabel(, nogrid) ///
			graphregion(color(white)) plotregion(color(white)) ///
			addplot(pci 0 `med' 16 `med', lcolor(red) lwidth(medthick)) /// Esta línea va al frente
			legend(off) /// Oculta la leyenda del addplot
			scheme(plotplain)

		graph export "${output_dir}/fig1_hist_edad.png", replace


		*Residencia
		local color1 "245 130 48"  // Orange (Bogotá)
		local color2 "140 198 63"  // Green (Meta)
		local color3 "255 196 0"   // Yellow (Medellín)
		local color4 "167 169 172" // Gray (Soacha)
		local color5 "58 103 177"  // Blue (Cali)

		graph pie, over(q3) sort(q3) ///
			pie(1, color("`color1'")) ///
			pie(2, color("`color5'")) ///
			pie(3, color("`color3'")) ///
			pie(4, color("`color4'")) ///
			pie(5, color("`color2'")) ///
			plabel(_all percent, format(%2.1f) size(large) color(white) gap(3)) ///
			legend(region(lcolor(none)) position(3) cols(1) size(medium)) ///
			graphregion(color(white)) ///
			plotregion(color(white) margin(large)) ///
			scheme(plotplain)

		graph export "${output_dir}/fig2_pie_residence.png", replace



	*2.2 Migration trajectory and human capital


		*Years in Colombia
	kdensity years_in_col, ///
		title("") ///
		lcolor(navy) lwidth(medium) ///
		xtitle("Years in Colombia", size(small)) ///
		ytitle("Density", size(small)) ///
		graphregion(color(white)) plotregion(color(white)) ///
		note("") ///
		scheme(plotplain)
	graph export "${output_dir}/fig3_density_years_in_col.png", replace

	twoway (histogram years_in_col, percent discrete width(1) color("58 103 177") lcolor(white)), ///
		title("") ///
		xtitle("Years in Colombia", size(small)) ///
		ytitle("Percentage (%)", size(small)) ///
		ylabel(, labsize(small) nogrid) ///
		graphregion(color(white)) plotregion(color(white)) ///
		legend(off) scheme(plotplain)
	graph export "${output_dir}/fig3_porcentage_years_in_col.png", replace

		*Education
	graph hbar (percent), over(q2_2) ///
		blabel(bar, format(%2.1f) size(vsmall)) /// Mostrar decimal
		bar(1, color("58 103 177")) /// Azul consistente
		ytitle("Percentage (%)", size(small)) ///
		graphregion(color(white)) plotregion(color(white)) ///
		scheme(plotplain)
	graph export "${output_dir}/fig4_bar_education.png", replace


		*Occupation
	graph hbar (percent), over(q2_3, sort(1) descending) ///
		blabel(bar, format(%2.1f) size(vsmall)) ///
		bar(1, color("245 130 48")) /// Naranja consistente
		ytitle("Percentage (%)", size(small)) ///
		graphregion(color(white)) plotregion(color(white)) ///
		scheme(plotplain)
	graph export "${output_dir}/fig5_bar_occupation.png", replace

		




	*2.3 Socioeconomic vulnerability indicator (IVS)

	twoway (hist ivs_score, width(0.05) color(gray%50) lcolor(white)) ///
		   (kdensity ivs_score, lcolor(navy) lwidth(medthick)), ///
		xtitle("Socioeconomic Vulnerability Index (0-1)", size(small)) ///
		ytitle("Density / Frequency", size(small)) ///
		legend(off) ///
		graphregion(color(white)) plotregion(color(white)) ///
		scheme(plotplain)
	graph export "${output_dir}/fig6_ivs_distribution_apa.png", replace

	twoway (histogram ivs_score, percent width(0.05) start(0) color("58 103 177%90") lcolor(white)), ///
		xtitle("Socioeconomic Vulnerability Index (0-1)", size(small)) ///
		ytitle("Percentage (%)", size(small)) ///
		ylabel(, labsize(small) nogrid) ///
		legend(off) ///
		graphregion(color(white)) plotregion(color(white)) ///
		scheme(plotplain)

	graph export "${output_dir}/fig6_ivs_distribution_porcentage.png", replace

	*IVS x City
	graph bar, over(ivs_cat) over(q3) stack asyvars percent ///
		bar(1, color("58 103 177%80")) /// Low: Azul
		bar(2, color("167 169 172%80")) /// Medium: Gris
		bar(3, color("245 130 48%80")) /// High: Naranja
		ytitle("Percentage (%)", size(small)) ///
		legend(title("IVS Level", size(small)) position(3) cols(1) size(small) region(lcolor(none))) ///
		graphregion(color(white)) plotregion(color(white)) ///
		blabel(bar, pos(center) format(%2.0f) color(white) size(vsmall)) ///
		scheme(plotplain)
	graph export "${output_dir}/fig7_ivs_by_city.png", replace


	*IVS x Age Category
	graph bar, over(ivs_cat) over(age_cat) stack asyvars percent ///
		bar(1, color("58 103 177%80")) /// 
		bar(2, color("167 169 172%80")) /// 
		bar(3, color("245 130 48%80")) /// 
		ytitle("Percentage (%)", size(small)) ///
		legend(title("IVS Level", size(small)) position(3) cols(1) size(small) region(lcolor(none))) ///
		graphregion(color(white)) plotregion(color(white)) ///
		blabel(bar, pos(center) format(%2.0f) color(white) size(vsmall)) ///
		scheme(plotplain)

	graph export "${output_dir}/fig8_ivs_by_age.png", replace


	*3.1 Digital access and telecom constraints — IAT


	*Divice type y frequency
	graph bar, over(q3_1) over(q3_5) stack asyvars percent ///
		bar(1, color("58 103 177")) /// Smartphone (Azul)
		bar(2, color("167 169 172")) /// Basic (Gris)
		bar(3, color("245 130 48")) /// No phone (Naranja)
		ytitle("Percentage (%)") ///
		b1title("Internet usage frequency") ///
		legend(title("Device type", size(small)) position(3) cols(1) size(small) ///
			region(lcolor(gs12) lwidth(vthin))) /// 
		graphregion(color(white)) plotregion(color(white)) ///
		blabel(bar, pos(center) format(%2.0f) color(white) size(vsmall)) ///
		scheme(plotplain)
	graph export "${output_dir}/fig9_iat_phone_internet.png", replace



	*Data Stability
	label define q3_8_lab 1 "Yes, multiple times" 2 "Yes, once" 3 "No" 99 "N/A"
	label values q3_8 q3_8_lab

	graph pie, over(q3_8) ///
		pie(1, color("245 130 48")) ///
		pie(2, color("58 103 177")) ///
		pie(3, color("255 193 7")) ///
		pie(4, color("160 160 160")) ///
		pie(5, color("120 200 80")) ///
		plabel(_all percent, size(medium) color(white) format(%2.1f)) ///
		legend(cols(1) position(3) size(big) ///
			region(lcolor(gs12) lwidth(vthin))) /// 
		graphregion(color(white)) ///
		scheme(plotplain)
	graph export "${output_dir}/fig10_data_stability.png", replace


	* IAT X VSI
	tab ivs_cat iat_cat, row
	tab ivs_cat, summarize(iat_score) // Tabla 1



	*3.2 Perceived transactional digital self-efficacy — IADT

	label define escala_en 1 "Not at all true" 2 "Hardly true" 3 "Moderately true" 4 "Very true" 5 "Exactly true"
	label values q3_16 escala_en

	*Ability to send/recieve digital money
	graph bar (percent), over(q3_16, label(labsize(medium))) ///
		bar(1, color("58 103 177")) /// Color azul aplicado correctamente
		ytitle("Percentage (%)", size(medium)) ///
		ylabel(, labsize(medium)) ///
		graphregion(color(white)) /// 
		blabel(bar, format(%2.0f) size(medium) color(black)) ///
		b1title("Level of Confidence", size(medium)) ///
		scheme(plotplain)
	graph export "${output_dir}/fig11_sendmoney.png", replace

	* Correlación IAT e IADT
	pwcorr iat_score iadt_score, sig

	graph bar iadt_score, over(iat_cat, label(labsize(medium))) ///
		bar(1, color("58 103 177")) ///
		ytitle("Mean self-efficacy score (IADT)", size(medium)) ///
		ylabel(0(0.2)1, labsize(medium)) ///
		graphregion(color(white)) ///
		blabel(bar, format(%4.2f) size(medium)) ///
		b1title("Level of Digital Access (IAT)", size(medium)) ///
		scheme(plotplain)
	graph export "${output_dir}/fig12_iat_iadt.png", replace




	*3.3 Practical digital competence for payments/security — ICDP


	* Prevalence of QR Code Usage (q3_20)
	label define qr_en 1 "Only to pay" 2 "Only to receive" 3 "To pay and receive" 4 "Does not use QR"
	label values q3_20 qr_en

	graph bar (percent), over(q3_20, label(labsize(medium))) ///
		bar(1, color("58 103 177")) ///
		ytitle("Percentage (%)", size(medium)) ///
		ylabel(, labsize(medium)) ///
		graphregion(color(white)) ///
		blabel(bar, format(%2.0f) size(medium) color(black)) ///
		b1title("QR Code Usage Experience", size(medium)) ///
		scheme(plotplain)
	graph export "${output_dir}/fig13_qr.png", replace

	*ICDP by Age Category
	label define icdp_cat_en 1 "Low practical competence" 2 "Medium practical competence" 3 "High practical competence"
	label values icdp_cat icdp_cat_en

	graph bar, over(icdp_cat) over(age_cat) stack asyvars percent ///
		bar(1, color("245 130 48%80")) /// Rojo para Low
		bar(2, color("167 169 172%80")) /// Gris para Medium
		bar(3, color("58 103 177%80")) /// Azul para High
		ytitle("Percentage (%)", size(small)) ///
		b1title("Age Category", size(small)) ///
		legend(title("Practical competence level (ICDP)", size(small)) position(3) cols(1) size(small) region(lcolor(none))) ///
		graphregion(color(white)) plotregion(color(white)) ///
		blabel(bar, pos(center) format(%2.0f) color(white) size(vsmall)) ///
		scheme(plotplain)
	graph export "${output_dir}/fig14_icdp_age.png", replace


	*ICDP by Education

	label define edu_en 1 "No formal education" 2 "Primary (incomplete)" 3 "Primary (complete)" ///
		4 "Secondary (incomplete)" 5 "Secondary (complete)" 6 "Technical (incomplete)" ///
		7 "Technical (complete)" 8 "University (incomplete)" 9 "University (complete)" ///
		10 "Postgraduate/Master's"
	label values q2_2 edu_en

	preserve
		drop if q2_2==1
		statsby mean=r(mean) ub=r(ub) lb=r(lb), by(q2_2) clear: ci mean icdp_score
		gen mean_lab = "  " + string(mean, "%4.2f")
		
		twoway ///
			(bar mean q2_2, horizontal barwidth(0.7) color("58 103 177%85")) ///
			(rcap lb ub q2_2, horizontal lcolor(gs10) lwidth(medium)) /// Ajustado de msize a medium
			(scatter q2_2 ub, mlabel(mean_lab) mlabpos(3) mlabsize(vsmall) mcolor(none)), ///
			xtitle("Mean Practical Digital Competence Index (ICDP)", size(small)) ///
			xlabel(0(0.2)1, labsize(vsmall)) ///
			ylabel(2 "Primary (incomplete)" 3 "Primary (complete)" ///
				   4 "Secondary (incomplete)" 5 "Secondary (complete)" 6 "Technical (incomplete)" ///
				   7 "Technical (complete)" 8 "University (incomplete)" 9 "University (complete)" ///
				   10 "Postgraduate/Master's", ///
				   labsize(vsmall) angle(0) nogrid) ///
			yscale(reverse) /// 
			legend(off) ///
			graphregion(color(white)) ///
			scheme(plotplain) // Cambiado a s2mono (estándar) ya que no tienes plotplain
		
		graph export "${output_dir}/fig15_icdp_edu.png", replace
	restore




	*3.4 Formal access constraints: documents, proof of address, phone registration, account ownership — IAFF

	label variable q4_12_1 "Bank Account"
	label variable q4_12_2 "Digital Wallet"
	label variable q4_12_3 "Cooperative"
	label variable q4_12_4 "Fintech/EMI"

	gen product = .
	replace product = 1 if q4_12_1==1
	replace product = 2 if q4_12_2==1
	replace product = 3 if q4_12_3==1
	replace product = 4 if q4_12_4==1

	label define product_lab ///
	1 "Bank Account" ///
	2 "Digital Wallet" ///
	3 "Cooperative" ///
	4 "Fintech/EMI"
	label values product product_lab

	preserve
		scalar total_base = 423
		gen count = 1
		collapse (sum) count, by(product)
		drop if product == .
		gen pct = (count / total_base) * 100
		gen pct_lab = string(pct, "%2.1f") + "%"

		twoway ///
			(bar pct product, barwidth(0.6) color("58 103 177%90")) /// Capa 1: Barras
			(scatter pct product, mlabel(pct_lab) mlabpos(12) mlabsize(vsmall) mcolor(none)), /// Capa 2: Texto
			ytitle("Percentage (%)", size(small)) ///
			ylabel(0(10)100, labsize(small) nogrid) ///
			xlabel(1 "Bank Account" 2 "Digital Wallet" 3 "Cooperative" 4 "Fintech/EMI", labsize(small)) ///
			xtitle("Financial Products", size(small)) ///
			legend(off) ///
			graphregion(color(white)) ///
			scheme(plotplain)

		graph export "${output_dir}/fig16_account_types_pct.png", replace
	restore



	*IAFF by years in Colombia
	label define iaff_cat_en 1 "Low financial access" 2 "Medium financial access" 3 "High financial access"
	label values iaff_cat iaff_cat_en

	graph bar, over(iaff_cat) over(years_cat) stack asyvars percent ///
		bar(1, color("245 130 48%80")) /// Naranja para Low (Barrera)
		bar(2, color("167 169 172%80")) /// Gris para Medium
		bar(3, color("58 103 177%80")) /// Azul para High
		ytitle("Percentage (%)", size(small)) ///
		b1title("Years of Residency in Colombia", size(small)) ///
		legend(title("Formal financial access level (IAFF)", size(small)) position(3) cols(1) size(small) region(lcolor(none))) ///
		graphregion(color(white)) plotregion(color(white)) ///
		blabel(bar, pos(center) format(%2.0f) color(white) size(vsmall)) ///
		scheme(plotplain)
		
	graph export "${output_dir}/fig17_iaff_time.png", replace


	*IAFF by Education
	preserve
	drop if q2_2 == 1
	statsby mean=r(mean) ub=r(ub) lb=r(lb), by(q2_2) clear: ci mean iaff_score
	gen mean_lab = "  " + string(mean, "%4.2f")
	twoway (bar mean q2_2, horizontal barwidth(0.6) color("58 103 177%85")) ///
		   (rcap lb ub q2_2, horizontal lcolor(black) lwidth(medium)) ///
		   (scatter q2_2 ub, mlabel(mean_lab) mlabpos(3) mlabsize(vsmall) mcolor(none)), ///
		xtitle("Formal Financial Access Index (IAFF)", size(small)) ///
		xlabel(0(0.2)1, labsize(vsmall)) ///
		ylabel(2 "Primary (incomplete)" 3 "Primary (complete)" 4 "Secondary (incomplete)" 5 "Secondary (complete)" ///
			   6 "Technical (incomplete)" 7 "Technical (complete)" 8 "University (incomplete)" 9 "University (complete)" ///
			   10 "Postgraduate", labsize(vsmall) angle(0)) ///
		graphregion(color(white)) ///
		yscale(reverse) ///
		legend(off) ///
		scheme(plotplain) 

	graph export "${output_dir}/fig18_iaff_edu_plain.png", replace
	restore



	*3.5 Usage and operability of financial tool — IUOF


	* Crear terciles de IAFF (Acceso) para el cruce
	xtile iaff_tercile = iaff_score, n(3)
	label define iaff_terc_lbl 1 "Low Access" 2 "Medium Access" 3 "High Access"
	label values iaff_tercile iaff_terc_lbl

	* --- Gráfico 1: Distribución del IUOF (Score) ---

	twoway (hist iuof_score_01, width(0.05) start(0) color("120 120 120%60") lcolor(white)) ///
		   (kdensity iuof_score_01, lcolor("58 103 177") lwidth(medium)), ///
		title("", size(medium)) ///
		xtitle("Index Score (0-1)", size(small)) ///
		ytitle("Density", size(small)) ///
		xlabel(0(0.2)1, labsize(small)) ///
		legend(off) ///
		graphregion(color(white)) scheme(plotplain)
	graph export "${output_dir}/fig19_iuof_distrib.png", replace

	twoway (histogram iuof_score_01, percent width(0.05) start(0) color("58 103 177%90") lcolor(white)), ///
		title("") ///
		xtitle("Financial Usage and Operability Index Score (0-1)", size(small)) ///
		ytitle("Percentage (%)", size(small)) ///
		xlabel(0(0.2)1, labsize(small)) ///
		ylabel(, labsize(small) nogrid) ///
		legend(off) ///
		graphregion(color(white)) 

	graph export "${output_dir}/fig19_iuof_distrib_porcentage.png", replace


	* --- Gráfico 2: IUOF por Terciles de IAFF (Cruce solicitado) ---
	*Financial Usage (IUOF) by Access Terciles (IAFF)

	* 1. Definir etiquetas en inglés con los rangos definidos en tu código
	label define iaff_eng 1 "Low Access (<0.5)" 2 "Mid Access (0.5-0.8)" 3 "High Access (>0.8)", replace
	label values iaff_cat iaff_eng

	label define iuof_eng 1 "Low Usage (<0.5)" 2 "Mid Usage (0.5-0.8)" 3 "High Usage (>0.8)", replace
	label values iuof_cat iuof_eng

	* 2. Generar el gráfico de barras apiladas
	*Financial Usage (IUOF) by Access Level (IAFF)
	graph bar, over(iuof_cat) over(iaff_cat, label(labsize(vsmall))) asyvars stack ///
		percent ///
		bar(1, color("245 130 48%80")) bar(2, color("167 169 172%80")) bar(3, color("58 103 177%80")) ///
		blabel(bar, pos(center) format(%4.0f) color(white) size(1.8)) ///
		title("", size(medium)) ///
		ytitle("Percentage (%)", size(small)) ///
		legend(title("IUOF Score", size(vsmall)) pos(3) cols(1) size(vsmall) region(lcolor(gs12))) ///
		graphregion(color(white)) ///
		plotregion(lcolor(gs12) lwidth(thin) margin(medium)) /// 
		scheme(plotplain)

	graph export "${output_dir}/fig20_iuof_iaff.png", replace





	*3.6 Awareness and usage of payment rails + onboarding experience

	* FIGURE: AWARENESS VS USAGE OF PAYMENT RAILS (q5_1 vs q5_2)
	preserve
	foreach var of varlist q5_1_1 q5_1_2 q5_1_3 q5_1_4 q5_2_1 q5_2_2 q5_2_3 q5_2_4 {
		replace `var' = `var' * 100
	}

	* Colapsar para sacar la media (que equivale al %)
	collapse (mean) q5_1_1 q5_1_2 q5_1_3 q5_1_4 q5_2_1 q5_2_2 q5_2_3 q5_2_4

	* Reshape para poder graficar "Awareness" (q5_1_) y "Usage" (q5_2_) lado a lado
	gen id = 1
	reshape long q5_1_ q5_2_, i(id) j(rail)

	* Etiquetas de los rieles (Ajusta según tu choices.csv)
	label define rail_lab 1 "Bre-B" 2 "ACH" 3 "Redeban" 4 "Visionamos"
	label values rail rail_lab

	* Gráfico de barras agrupadas
	graph bar q5_1_ q5_2_, over(rail, label(labsize(small))) ///
		bar(1, color("167 169 172%90")) /// Gris para Awareness
		bar(2, color("58 103 177%90"))  /// Azul para Usage
		blabel(bar, format(%2.1f) size(vsmall) pos(outside)) ///
		legend(label(1 "Awareness (Heard of)") label(2 "Usage (Last 60 days)") ///
			   pos(6) rows(1) size(small) region(lcolor(none))) ///
		ytitle("Percentage (%)", size(small)) ///
		ylabel(0(20)100, labsize(small) nogrid) ///
		graphregion(color(white)) plotregion(color(white)) ///
		scheme(plotplain)

	graph export "${output_dir}/fig21_awareness_usage_rails.png", replace

	restore



	* FIGURE: OQI (IFO) MEAN BY IAFF CATEGORIES (WITH CONFIDENCE INTERVALS)
	preserve

	statsby mean=r(mean) ub=r(ub) lb=r(lb), by(iaff_cat) clear: ci mean oqi_score_01
	gen mean_lab = "  " + string(mean, "%4.2f")

	twoway (bar mean iaff_cat, horizontal barwidth(0.6) color("58 103 177%85")) /// Capa 1: Barras
		   (rcap lb ub iaff_cat, horizontal lcolor(black) lwidth(medium)) ///       Capa 2: Intervalo de confianza
		   (scatter iaff_cat ub, mlabel(mean_lab) mlabpos(3) mlabsize(vsmall) mcolor(none)), /// Capa 3: Etiquetas
		xtitle("Onboarding Quality Index (OQI) (0-1)", size(small)) /// 
		ytitle("Formal financial access level (IAFF)", size(small)) /// <--- TÍTULO DEL EJE Y EN INGLÉS
		xlabel(0(0.2)1, labsize(vsmall)) ///
		ylabel(1 "Low financial access" 2 "Medium financial access" 3 "High financial access", labsize(vsmall) angle(0)) ///
		graphregion(color(white)) ///
		yscale(reverse) ///
		legend(off) ///
		scheme(plotplain) 

	graph export "${output_dir}/fig22_oqi_by_iaff.png", replace

	restore




	* FIGURE: OQI (IFO) MEAN BY ICDP CATEGORIES (WITH CONFIDENCE INTERVALS)
	preserve
	statsby mean=r(mean) ub=r(ub) lb=r(lb), by(icdp_cat) clear: ci mean oqi_score_01
	gen mean_lab = "  " + string(mean, "%4.2f")

	* 3. Generar el gráfico
	twoway (bar mean icdp_cat, horizontal barwidth(0.6) color("58 103 177%85")) /// Capa 1: Barras
		   (rcap lb ub icdp_cat, horizontal lcolor(black) lwidth(medium)) ///       Capa 2: Intervalo de confianza
		   (scatter icdp_cat ub, mlabel(mean_lab) mlabpos(3) mlabsize(vsmall) mcolor(none)), /// Capa 3: Etiquetas
		xtitle("Onboarding Quality Index (OQI) (0-1)", size(small)) ///
		ytitle("Digital skills level (ICDP)", size(small)) /// <--- TÍTULO DEL EJE Y EN INGLÉS
		xlabel(0(0.2)1, labsize(vsmall)) ///
		ylabel(1 "Low digital skills" 2 "Medium digital skills" 3 "High digital skills", labsize(vsmall) angle(0)) /// Ajusta las etiquetas según tu base
		graphregion(color(white)) ///
		yscale(reverse) ///
		legend(off) ///
		scheme(plotplain) 

	graph export "${output_dir}/fig23_oqi_by_icdp.png", replace
	restore



	*3.7 Remittances: channels, formalization, intensity, and user experience — IURD & IETR


	* FIGURE: REMITTANCE CHANNEL SPLIT (q6_4)
	preserve

	* Etiquetas 
	label define channel_lab 1 "Bank account" 2 "Digital Wallet" 3 "Cash (Remittance house)" 4 "Traveler/Friend" 5 "Other"
	capture label values q6_4 channel_lab

	* Calcular porcentajes
	tempvar count total pct
	gen `count' = 1
	egen `total' = total(`count') if q6_4 != .
	egen `pct' = total(`count' / `total' * 100), by(q6_4)

	* Colapsar para graficar
	collapse (mean) `pct', by(q6_4)
	drop if q6_4 == .

	* Formato de etiquetas
	gen pct_lab = string(`pct', "%2.1f") + "%"

	* Gráfico
	twoway (bar `pct' q6_4, barwidth(0.6) color("58 103 177%90")) ///
		   (scatter `pct' q6_4, mlabel(pct_lab) mlabpos(12) mlabsize(vsmall) mcolor(none) mlabcolor(black)), ///
		ytitle("Percentage (%)", size(small)) ///
		ylabel(0(10)40, labsize(small) nogrid) ///  <-- Tope ajustado a 40
		yscale(range(0 45)) ///                     <-- Margen superior ajustado a 45
		xlabel(1 "Bank" 2 "Wallet" 3 "Cash" 4 "Traveler" 5 "Other", labsize(small)) ///
		xtitle("Latest remittance channel used", size(small)) ///
		legend(off) ///
		graphregion(color(white)) ///
		scheme(plotplain)

	graph export "${output_dir}/fig24_remittance_channels.png", replace
	restore


	* FIGURE: IETR DISTRIBUTION (Histogram + KDensity)

	twoway (hist ietr_score_01, width(0.05) start(0) color("120 120 120%60") lcolor(white)) ///
		   (kdensity ietr_score_01, lcolor("58 103 177") lwidth(medium)), ///
		title("", size(medium)) ///
		xtitle("Transactional Experience Index (IETR)", size(small)) ///
		ytitle("Density", size(small)) ///
		xlabel(0(0.2)1, labsize(small)) ///
		legend(off) ///
		graphregion(color(white)) scheme(plotplain)

	graph export "${output_dir}/fig25_ietr_distrib.png", replace


	twoway (histogram ietr_score_01, percent width(0.05) start(0) color("58 103 177%90") lcolor(white)), ///
		title("") ///
		xtitle("Transactional Experience Index (IETR)", size(small)) ///
		ytitle("Percentage (%)", size(small)) ///
		xlabel(0(0.2)1, labsize(small)) ///
		ylabel(, labsize(small) nogrid) ///
		legend(off) ///
		graphregion(color(white)) scheme(plotplain)

	graph export "${output_dir}/fig25_ietr_distrib_porcentage.png", replace

	* FIGURE: IURD x IFO/OQI CROSS-TAB (Stacked Bars)

	* 1. Definir etiquetas en inglés para que se vea bien en el gráfico
	label define oqi_eng 1 "High friction" 2 "Mid friction" 3 "Low friction", replace
	label values oqi_cat oqi_eng

	label define iurd_eng 1 "Low Intensity" 2 "Mid Intensity" 3 "High Intensity", replace
	label values iurd_cat iurd_eng

	* 2. Gráfico de barras apiladas al 100%
	graph bar, over(iurd_cat) over(oqi_cat, label(labsize(vsmall))) asyvars stack ///
		percent ///
		bar(1, color("245 130 48%80")) /// Naranja para baja intensidad
		bar(2, color("167 169 172%80")) /// Gris para media intensidad
		bar(3, color("58 103 177%80")) /// Azul para alta intensidad
		blabel(bar, pos(center) format(%4.0f) color(white) size(1.8)) ///
		ytitle("Percentage (%)", size(small)) ///
		b1title("Onboarding Quality Index (OQI)", size(small)) ///
		legend(title("Remittance Intensity (IURD)", size(vsmall)) pos(3) cols(1) size(vsmall) region(lcolor(none))) ///
		graphregion(color(white)) plotregion(color(white)) ///
		scheme(plotplain)

	graph export "${output_dir}/fig26_iurd_by_ifo.png", replace






	*3.8 Fraud, safety behaviors, and recourse — IPCS & IEDF


	* ====================================================================
	* OUTPUT 1: Figure - Exposure to suspicious messages vs Perceived safety
	* Muestra el % de mujeres que se sienten "Seguras/Muy seguras" (q7_9) 
	* dependiendo de si estuvieron expuestas a fraude (q7_1)
	* ====================================================================
	preserve
	*drop if inlist(q5_2, "6", "98")
	* 1. Dejar solo respuestas válidas
	*drop if q7_1 == 3 | q7_1 == 98 | q7_1 == . 
	*drop if q7_9 == 98 | q7_9 == .

	* 2. Crear variable de exposición
	gen exposed_fraud = 0
	replace exposed_fraud = 1 if inlist(q7_5, 1, 2,3)
	label define exp_lab 0 "Not exposed" 1 "Exposed to fraud"
	label values exposed_fraud exp_lab

	* 3. Asegurar etiquetas de seguridad (Ajusta según tus choices)
	label define safe_lab 1 "Very safe" 2 "Somewhat safe" 3 "Somewhat unsafe" 4 "Very unsafe"
	capture label values q7_9 safe_lab

	* 4. Gráfico de barras apiladas al 100%
	graph bar, over(q7_9) over(exposed_fraud) asyvars percentages stack ///
		bar(1, color("58 103 177%100")) /// Azul fuerte (Very safe)
		bar(2, color("133 171 224%100")) /// Azul claro (Somewhat safe)
		bar(3, color("244 177 131%100")) /// Naranja claro (Somewhat unsafe)
		bar(4, color("237 125 49%100"))  /// Naranja oscuro (Very unsafe)
		blabel(bar, position(center) format(%2.0f) color(white) size(small)) ///
		ytitle("Percentage (%)", size(small)) ///
		ylabel(0(20)100, labsize(small) nogrid) ///
		legend(position(6) rows(1) size(small) region(lcolor(none))) ///
		graphregion(color(white)) ///
		scheme(plotplain)

	graph export "${output_dir}/fig27_safety_vs_exposure.png", replace
	restore




	* ====================================================================
	* OUTPUT 2A: Figure - Mean IEDF (0-1) by OQI with CI (Horizontal)
	* ====================================================================
	preserve

	* 1. Clean missing values and scale IEDF to 0-1
	drop if oqi_cat == . | IEDF == .
	gen iedf_01 = IEDF / 100

	* 2. Calculate means and standard errors
	collapse (mean) mean_iedf=iedf_01 (semean) se_iedf=iedf_01, by(oqi_cat)

	* 3. Calculate 95% Confidence Interval
	gen ci_top = mean_iedf + 1.96 * se_iedf
	gen ci_bot = mean_iedf - 1.96 * se_iedf

	* 4. Text label for the mean (using 2 decimals for 0-1 scale)
	gen mean_label = string(mean_iedf, "%9.2f")

	* 5. Generate plot (Horizontal Bar + CI + Label on the right)
	twoway (bar mean_iedf oqi_cat, horizontal barw(0.6) color("58 103 177%100")) ///
		   (rcap ci_top ci_bot oqi_cat, horizontal lcolor(black)) ///
		   (scatter oqi_cat ci_top, mcolor(none) mlabel(mean_label) mlabpos(3) mlabcolor(black) mlabsize(small)), ///
		   legend(off) ///
		   ylabel(1 "Low" 2 "Medium" 3 "High", labsize(small) angle(horizontal) nogrid) ///
		   xtitle("Mean Fraud Damage (IEDF, 0-1 scale)", size(small) margin(top)) ///
		   ytitle("Onboarding Quality Index (OQI)", size(small) margin(right)) ///
		   xlabel(0(0.2)0.4, labsize(small)) /// <-- Eje cortado hasta 0.5
		   xscale(range(0 0.55)) /// <-- Margen para que el número no choque con el borde
		   graphregion(color(white)) ///
		   scheme(plotplain)

	graph export "${output_dir}/fig28_iedf_by_oqi.png", replace
	restore


	* ====================================================================
	* Figure - Mean IEDF (0-1) by ICDP with CI (Horizontal)
	* ====================================================================
	preserve

	* 1. Clean missing values and scale IEDF to 0-1
	drop if icdp_cat == . | IEDF == .
	gen iedf_01 = IEDF / 100

	* 2. Calculate means and standard errors
	collapse (mean) mean_iedf=iedf_01 (semean) se_iedf=iedf_01, by(icdp_cat)

	* 3. Calculate 95% Confidence Interval
	gen ci_top = mean_iedf + 1.96 * se_iedf
	gen ci_bot = mean_iedf - 1.96 * se_iedf

	* 4. Text label for the mean (using 2 decimals)
	gen mean_label = string(mean_iedf, "%9.2f")

	* 5. Generate plot (Horizontal Bar + CI + Label on the right)
	twoway (bar mean_iedf icdp_cat, horizontal barw(0.6) color("58 103 177%100")) ///
		   (rcap ci_top ci_bot icdp_cat, horizontal lcolor(black)) ///
		   (scatter icdp_cat ci_top, mcolor(none) mlabel(mean_label) mlabpos(3) mlabcolor(black) mlabsize(small)), ///
		   legend(off) ///
		   ylabel(1 "Low" 2 "Medium" 3 "High", labsize(small) angle(horizontal) nogrid) ///
		   xtitle("Mean Fraud Damage (IEDF, 0-1 scale)", size(small) margin(top)) ///
		   ytitle("Practical Digital Competence (ICDP)", size(small) margin(right)) ///
		   xlabel(0(0.2)0.4, labsize(small)) /// <-- Eje cortado hasta 0.5
		   xscale(range(0 0.55)) /// <-- Margen para que el número no choque con el borde
		   graphregion(color(white)) ///
		   scheme(plotplain)

	graph export "${output_dir}/fig29_iedf_by_icdp.png", replace
	restore



	* Satisfacción - experiencia de fraude

	* ====================================================================
	* OUTPUT 3 (Sugerido): Figure - Satisfaction with resolution (q7_15)
	* Cierra la historia mostrando la insatisfacción de quienes sí reclamaron
	* ====================================================================
	preserve

	drop if q7_15 == . | q7_15 == 98

	contract q7_15
	egen total_resp = total(_freq)
	gen pct = (_freq / total_resp) * 100
	gen pct_lab = string(pct, "%2.1f") + "%"

	* Asegurar etiquetas (Ajustadas a los 5 niveles reales de tus datos)
	label define sat_lab 1 "Very unsatisfied" 2 "Unsatisfied" 3 "Neutral" 4 "Satisfied" 5 "Very satisfied", replace
	capture label values q7_15 sat_lab

	twoway (bar pct q7_15, barwidth(0.6) color("58 103 177%100")) /// Azul tipo la imagen
		   (scatter pct q7_15, mlabel(pct_lab) mlabpos(12) mlabsize(small) mcolor(none) mlabcolor(black)), ///
		ytitle("Percentage (%)", size(small)) ///
		ylabel(0(10)60, labsize(small) nogrid) /// Ajustado a 60 porque el max es 55.7%
		yscale(range(0 65)) ///
		xlabel(1 "Very Unsatisf." 2 "Unsatisf." 3 "Neutral" 4 "Satisfied" 5 "Very Satisf.", labsize(small)) ///
		xtitle("", size(small)) ///
		legend(off) ///
		graphregion(color(white)) ///
		scheme(plotplain)

	graph export "${output_dir}/fig30_resolution_satisfaction.png", replace
	restore






	*3.9 Trust, autonomy, and social norms — IAER & ICPF

	* ====================================================================
	* OUTPUT 3.9A: Figure - IAER Distribution
	* ====================================================================

	preserve
	drop if IAER == .
	gen iaer_01 = IAER / 100

	twoway (hist iaer_01, width(0.05) start(0) color("120 120 120%60") lcolor(white)) ///
		   (kdensity iaer_01, lcolor("58 103 177") lwidth(medium)), ///
		title("Distribution of Economic Autonomy in Remittances (IAER)", size(medium) color(black)) ///
		xtitle("Autonomy Index Score (0-1)", size(small)) ///
		ytitle("Density", size(small)) ///
		xlabel(0(0.2)1, labsize(small)) ///
		legend(off) ///
		graphregion(color(white)) scheme(plotplain)

	graph export "${output_dir}/fig31_iaer_distribution.png", replace
	restore

	* Figura 30/31: Distribution of Economic Autonomy in Remittances (IAER)
	preserve
	drop if IAER == .
	gen iaer_01 = IAER / 100

	twoway (histogram iaer_01, percent width(0.05) start(0) color("58 103 177%90") lcolor(white)), ///
		title("Distribution of Economic Autonomy in Remittances (IAER)", size(medium) color(black)) ///
		xtitle("Autonomy Index Score (0-1)", size(small)) ///
		ytitle("Percentage (%)", size(small)) ///
		xlabel(0(0.2)1, labsize(small)) ///
		ylabel(, labsize(small) nogrid) ///
		legend(off) ///
		graphregion(color(white))

	graph export "${output_dir}/fig31_iaer_porcentage.png", replace
	restore

	* ====================================================================
	* OUTPUT 3.9B: Figure - Mean IAER (0-1) by Digital Use (IURD) with CI
	* ====================================================================
	preserve
	drop if iurd_cat == . | IAER == .
	gen iaer_01 = IAER / 100

	collapse (mean) mean_val=iaer_01 (semean) se_val=iaer_01, by(iurd_cat)

	gen ci_top = mean_val + 1.96 * se_val
	gen ci_bot = mean_val - 1.96 * se_val
	gen mean_label = string(mean_val, "%9.2f")

	twoway (bar mean_val iurd_cat, horizontal barw(0.6) color("58 103 177%100")) ///
		   (rcap ci_top ci_bot iurd_cat, horizontal lcolor(black)) ///
		   (scatter iurd_cat ci_top, mcolor(none) mlabel(mean_label) mlabpos(3) mlabcolor(black) mlabsize(small)), ///
		   legend(off) ///
		   ylabel(1 "Low" 2 "Medium" 3 "High", labsize(small) angle(horizontal) nogrid) ///
		   xtitle("Mean Autonomy Index (IAER, 0-1 scale)", size(small) margin(top)) ///
		   ytitle("Digital Remittance Use Index (IURD)", size(small) margin(right)) ///
		   xlabel(0(0.2)1, labsize(small)) /// xscale(range(0 1.1)) por si los valores son altos
		   graphregion(color(white)) ///
		   scheme(plotplain)

	graph export "${output_dir}/fig32_iaer_by_iurd.png", replace
	restore


	* ====================================================================
	* OUTPUT 3.9C: Figure - Mean Fraud Damage (IEDF) by Autonomy (IAER) with CI
	* ====================================================================
	preserve
	drop if IAER_cat == . | IEDF == .
	gen iedf_01 = IEDF / 100

	collapse (mean) mean_val=iedf_01 (semean) se_val=iedf_01, by(IAER_cat)

	gen ci_top = mean_val + 1.96 * se_val
	gen ci_bot = mean_val - 1.96 * se_val
	gen mean_label = string(mean_val, "%9.2f")

	twoway (bar mean_val IAER_cat, horizontal barw(0.6) color("58 103 177%100")) /// <-- Color rojo/alerta para fraude
		   (rcap ci_top ci_bot IAER_cat, horizontal lcolor(black)) ///
		   (scatter IAER_cat ci_top, mcolor(none) mlabel(mean_label) mlabpos(3) mlabcolor(black) mlabsize(small)), ///
		   legend(off) ///
		   ylabel(1 "Low" 2 "Medium" 3 "High", labsize(small) angle(horizontal) nogrid) ///
		   xtitle("Mean Fraud Damage (IEDF, 0-1 scale)", size(small) margin(top)) ///
		   ytitle("Economic Autonomy Index (IAER)", size(small) margin(right)) ///
		   xlabel(0(0.1)0.5, labsize(small)) /// <-- Cortado a 0.5 como el anterior de fraude
		   xscale(range(0 0.55)) ///
		   graphregion(color(white)) ///
		   scheme(plotplain)

	graph export "${output_dir}/fig33_iedf_by_iaer.png", replace
	restore


	* ====================================================================
	* OUTPUT 3.9D: Figure - Mean Trust & Norms (ICPF) by Digital Use (IURD)
	* ====================================================================
	preserve
	drop if iurd_cat == . | ICPF == .
	gen icpf_01 = ICPF / 100

	collapse (mean) mean_val=icpf_01 (semean) se_val=icpf_01, by(iurd_cat)

	gen ci_top = mean_val + 1.96 * se_val
	gen ci_bot = mean_val - 1.96 * se_val
	gen mean_label = string(mean_val, "%9.2f")

	twoway (bar mean_val iurd_cat, horizontal barw(0.6) color("58 103 177%100")) ///
		   (rcap ci_top ci_bot iurd_cat, horizontal lcolor(black)) ///
		   (scatter iurd_cat ci_top, mcolor(none) mlabel(mean_label) mlabpos(3) mlabcolor(black) mlabsize(small)), ///
		   legend(off) ///
		   ylabel(1 "Low" 2 "Medium" 3 "High", labsize(small) angle(horizontal) nogrid) ///
		   xtitle("Mean Trust & Norms Index (ICPF, 0-1 scale)", size(small) margin(top)) ///
		   ytitle("Digital Remittance Use Index (IURD)", size(small) margin(right)) ///
		   xlabel(0(0.2)1, labsize(small)) ///
		   graphregion(color(white)) ///
		   scheme(plotplain)

	graph export "${output_dir}/fig34_icpf_by_iurd.png", replace
	restore









	*3.10 Barriers, enabling environment, and program exposure — IEH & IBPD


	* ==============================================================================
	* D. SECTION 3.10 GRAPHS: BARRIERS, ENABLERS, AND TRAINING (APA STYLE & ENGLISH)
	* ==============================================================================


	* ------------------------------------------------------------------------------
	* 1. TOP 5 MAIN BARRIERS (q10_1) - AS PERCENTAGES
	* ------------------------------------------------------------------------------
	preserve

	* Drop missing and "Prefer not to answer" (98)
	drop if missing(q10_1) | q10_1 == 98 

	* 1. REETIQUETAR AL INGLÉS CON LOS CÓDIGOS EXACTOS DE LA BASE
	label define q10_1_eng ///
		1 "Don't own a phone" ///
		2 "No data / internet" ///
		3 "Lack of trust in systems" ///
		4 "Don't know how to use them" ///
		5 "High costs or fees" ///
		6 "Documents not accepted" ///
		7 "Poor signal / unstable service" ///
		8 "Agents/ATMs too far" ///
		9 "Prefer cash / family reasons" ///
		10 "Bad experiences / fraud" ///
		11 "Language / terminology" ///
		12 "Low literacy" ///
		14 "Fear of making a mistake" ///
		15 "Difficult customer support" ///
		16 "None of the above", replace

	* Aplicamos las etiquetas en inglés a la variable
	label values q10_1 q10_1_eng

	* 2. CONTRAER LOS DATOS Y SACAR PORCENTAJES
	contract q10_1, freq(frequency)
	gsort -frequency
	keep in 1/5 

	* Calculate percentage based on N = 423
	gen percent = (frequency / 423) * 100

	* 3. GRAFICAR EN FORMATO APA
	graph hbar (asis) percent, over(q10_1, sort(1) descending label(labsize(small))) ///
		ytitle("Percentage (%)") ///
		blabel(bar, format(%9.1f)) bar(1, fcolor("58 103 177%100") lcolor("58 103 177%100")) ///
		graphregion(color(white)) bgcolor(white) ///
		scheme(plotplain)

	graph export "${output_dir}/fig35_5barries.png", replace
	restore






	* ------------------------------------------------------------------------------
	* 2. TOP 5 ENABLERS (q10_3_*) - AS PERCENTAGES
	* ------------------------------------------------------------------------------
	preserve
	collapse (sum) enabler_*
	gen id = 1
	reshape long enabler_, i(id) j(enabler) string
	rename enabler_ frequency
	gsort -frequency
	keep in 1/5

	* Translate to English for the graph
	replace enabler = "Training" if enabler == "capacitacion"
	replace enabler = "Lower fees" if enabler == "comisiones_bajas"
	replace enabler = "Better exchange rate" if enabler == "mejor_tc"
	replace enabler = "Clear materials" if enabler == "material_claro"
	replace enabler = "More merchants" if enabler == "mas_comercios"
	replace enabler = "Account assistance" if enabler == "ayuda_cuenta"
	replace enabler = "Better internet" if enabler == "mejor_internet"

	* Calculate percentage based on N = 423
	gen percent = (frequency / 423) * 100

	graph hbar (asis) percent, over(enabler, sort(1) descending label(labsize(small))) ///
		ytitle("Percentage (%)") ///
		blabel(bar, format(%9.1f)) bar(1, fcolor("58 103 177%100") lcolor("58 103 177%100")) ///
		graphregion(color(white)) bgcolor(white) ///
		scheme(plotplain)

	graph export "${output_dir}/fig36_top5_enablers.png", replace
	restore


	* ------------------------------------------------------------------------------
	* 3. TOP TRAINING TOPICS (q10_17_*) - AS PERCENTAGES
	* ------------------------------------------------------------------------------
	preserve
	collapse (sum) tema_*
	gen id = 1
	reshape long tema_, i(id) j(topic) string
	rename tema_ frequency
	gsort -frequency

	* Translate to English for the graph
	replace topic = "Fees and limits" if topic == "comisiones"
	replace topic = "Processing times" if topic == "tiempos"
	replace topic = "Fraud & risk prevention" if topic == "riesgos_fraude"
	replace topic = "Claims process" if topic == "reclamos"
	replace topic = "Agent locations" if topic == "agentes"
	replace topic = "Benefits vs. cash" if topic == "beneficios"

	* Calculate percentage based on N = 423
	gen percent = (frequency / 423) * 100

	graph hbar (asis) percent, over(topic, sort(1) descending label(labsize(small))) ///
		ytitle("Percentage (%)") ///
		blabel(bar, format(%9.1f)) bar(1, fcolor(58 103 177%100) lcolor(58 103 177%100)) ///
		graphregion(color(white)) bgcolor(white) ///
		scheme(plotplain)

	graph export "${output_dir}/fig37_training_topics.png", replace
	restore




	* ==============================================================================
	* E. STRATEGIC CROSSTABS: IBPD BY VULNERABILITY (IVS) AND ADOPTION (IAT)
	* ==============================================================================

	* ------------------------------------------------------------------------------
	* 4. IBPD BY VULNERABILITY (IVS) - 100% STACKED BARS
	* ------------------------------------------------------------------------------
	preserve
	graph bar (percent), over(IBPD_cat) over(ivs_cat) asyvars stack ///
		ytitle("Percentage (%)") ///
		legend(title("IBPD Level", size(small)) position(6) rows(1) region(lcolor(none))) ///
		bar(1, color("245 130 48%80")) /// Naranja para Low (Barrera)
		bar(2, color("167 169 172%80")) /// Gris para Medium
		bar(3, color("58 103 177%80")) /// Azul para High
		blabel(bar, position(center) format(%9.0f) size(small)) ///
		graphregion(color(white)) bgcolor(white) ///
		scheme(plotplain)

	graph export "${output_dir}/fig38_ibpd_ivs.png", replace

	restore


	* ------------------------------------------------------------------------------
	* 5. IBPD BY TECH ADOPTION (IAT) - 100% STACKED BARS
	* ------------------------------------------------------------------------------
	preserve
	graph bar (percent), over(IBPD_cat) over(iat_cat) asyvars stack ///
		ytitle("Percentage (%)") ///
		legend(title("IBPD Level", size(small)) position(6) rows(1) region(lcolor(none))) ///
		bar(1, color("245 130 48%80")) /// Naranja para Low (Barrera)
		bar(2, color("167 169 172%80")) /// Gris para Medium
		bar(3, color("58 103 177%80")) /// Azul para High
		blabel(bar, position(center) format(%9.0f) size(small)) ///
		graphregion(color(white)) bgcolor(white) ///
		scheme(plotplain)

	graph export "${output_dir}/fig39_ibpd_vs_iat.png", replace
	restore
}


*---------------------------------------*
*		II. Regression Analysis  		*
*---------------------------------------*
	/*--------------------------*
	*           INDEX           *
	*---------------------------*
		II.  Regression analysis
			 1. Setup and helper variables
			 2. Family 1: Adoption and digital intensity
			 3. Family 2: Transaction quality and onboarding
			 4. Family 3: Safety, fraud, and recourse
			 5. Family 4: Autonomy and financial agency
			 6. Interaction / heterogeneity analysis
			 7. Supplementary item-level models

	*---------------------------*/

	use "${input_dir}/3 Coded/CFI_DPI Data for analysis.dta", ///
		clear
		
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
	local blue   "58 103 177"
	local orange "245 130 48"
	local gray   "167 169 172"
	local green  "140 198 63"


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


	* 1.4 Regression control architecture *

	* Baseline controls used in all core models
	global demo_controls "i.age_cat i.q3"

	* Nested blocks for the main specifications
	global block_B "c.ivs_score c.iat_score c.iadt_score c.icdp_score"
	global block_C "c.iaff_score c.oqi_score_01"
	global block_D "c.IEDF c.IEH"

	* Standardized versions for coefficient plots
	global block_B_z "c.z_ivs c.z_iat c.z_iadt c.z_icdp"
	global block_C_z "c.z_iaff c.z_oqi"
	global block_D_z "c.z_iedf c.z_ieh"

	* 2. FAMILY 1: ADOPTION, DIGITAL INTENSITY, AND FORMALIZATION              |

	*========================================*
	* 2.1 Outcome: IURD (digital intensity)  *
	*========================================*/

	eststo clear

	reg iurd_score_01 $demo_controls, vce(robust)
	eststo iurd_A
	outreg2 using "${output_dir}/regression/tables/Table_F1_IURD.doc", replace ///
		word dec(3) ctitle("Model A") ///
		addtext(City FE, Yes, Robust SE, Yes)

	reg iurd_score_01 $demo_controls $block_B, vce(robust)
	eststo iurd_B
	outreg2 using "${output_dir}/regression/tables/Table_F1_IURD.doc", append ///
		word dec(3) ctitle("Model B") ///
		addtext(City FE, Yes, Robust SE, Yes)

	reg iurd_score_01 $demo_controls $block_B $block_C, vce(robust)
	eststo iurd_C
	outreg2 using "${output_dir}/regression/tables/Table_F1_IURD.doc", append ///
		word dec(3) ctitle("Model C") ///
		addtext(City FE, Yes, Robust SE, Yes)

	reg iurd_score_01 $demo_controls $block_B $block_C $block_D, vce(robust)
	eststo iurd_D
	outreg2 using "${output_dir}/regression/tables/Table_F1_IURD.doc", append ///
		word dec(3) ctitle("Model D") ///
		addtext(City FE, Yes, Robust SE, Yes)

	* Standardized model for coefficient plot
	reg z_iurd $demo_controls c.z_ivs c.z_iat c.z_icdp c.z_iaff c.z_oqi c.z_iedf c.z_ieh, vce(robust)
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

	logit formal_remittance $demo_controls, vce(robust)
	eststo form_A
	outreg2 using "${output_dir}/regression/tables/Table_F1_FormalRemittance.doc", replace ///
		word dec(3) eform ctitle("Model A") ///
		addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

	logit formal_remittance $demo_controls $block_B, vce(robust)
	eststo form_B
	outreg2 using "${output_dir}/regression/tables/Table_F1_FormalRemittance.doc", append ///
		word dec(3) eform ctitle("Model B") ///
		addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

	logit formal_remittance $demo_controls $block_B $block_C, vce(robust)
	eststo form_C
	outreg2 using "${output_dir}/regression/tables/Table_F1_FormalRemittance.doc", append ///
		word dec(3) eform ctitle("Model C") ///
		addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

	logit formal_remittance $demo_controls $block_B $block_C $block_D, vce(robust)
	eststo form_D
	outreg2 using "${output_dir}/regression/tables/Table_F1_FormalRemittance.doc", append ///
		word dec(3) eform ctitle("Model D") ///
		addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

	* Average marginal effects using standardized predictors for comparability
	logit formal_remittance $demo_controls c.z_ivs c.z_iat c.z_icdp c.z_iaff c.z_oqi c.z_iedf c.z_ieh, vce(robust)
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

	reg iuof_score_01 $demo_controls, vce(robust)
	eststo iuof_A
	outreg2 using "${output_dir}/regression/tables/Table_F1_IUOF.doc", replace ///
		word dec(3) ctitle("Model A") ///
		addtext(City FE, Yes, Robust SE, Yes)

	reg iuof_score_01 $demo_controls $block_B, vce(robust)
	eststo iuof_B
	outreg2 using "${output_dir}/regression/tables/Table_F1_IUOF.doc", append ///
		word dec(3) ctitle("Model B") ///
		addtext(City FE, Yes, Robust SE, Yes)

	* Note: IAFF is conceptually important for IUOF, but IUOF should not predict itself.
	reg iuof_score_01 $demo_controls $block_B c.iaff_score c.oqi_score_01, vce(robust)
	eststo iuof_C
	outreg2 using "${output_dir}/regression/tables/Table_F1_IUOF.doc", append ///
		word dec(3) ctitle("Model C") ///
		addtext(City FE, Yes, Robust SE, Yes)

	reg iuof_score_01 $demo_controls $block_B c.iaff_score c.oqi_score_01 $block_D, vce(robust)
	eststo iuof_D
	outreg2 using "${output_dir}/regression/tables/Table_F1_IUOF.doc", append ///
		word dec(3) ctitle("Model D") ///
		addtext(City FE, Yes, Robust SE, Yes)

	* Standardized model for coefficient plot
	reg z_iuof $demo_controls c.z_ivs c.z_iat c.z_icdp c.z_iaff c.z_oqi c.z_iedf c.z_ieh, vce(robust)
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



/*==========================================================================*
 | 3. FAMILY 2: TRANSACTION QUALITY AND ONBOARDING                          |
 *==========================================================================*/

*==========================================================*
* 3.1 Outcome: IETR (transactional experience, OLS)        *
*==========================================================*/

eststo clear

reg ietr_score_01 $demo_controls, vce(robust)
eststo ietr_A
outreg2 using "${output_dir}/regression/tables/Table_F2_IETR.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg ietr_score_01 $demo_controls $block_B, vce(robust)
eststo ietr_B
outreg2 using "${output_dir}/regression/tables/Table_F2_IETR.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg ietr_score_01 $demo_controls $block_B c.iaff_score c.oqi_score_01, vce(robust)
eststo ietr_C
outreg2 using "${output_dir}/regression/tables/Table_F2_IETR.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg ietr_score_01 $demo_controls $block_B c.iaff_score c.oqi_score_01 c.IEDF c.IEH, vce(robust)
eststo ietr_D
outreg2 using "${output_dir}/regression/tables/Table_F2_IETR.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot
reg z_ietr $demo_controls c.z_ivs c.z_iat c.z_icdp c.z_iaff c.z_oqi c.z_iedf c.z_ieh, vce(robust)
eststo ietr_D_z

coefplot (ietr_D_z, ///
    keep(z_iat z_icdp z_iaff z_oqi z_ivs z_iedf z_ieh) ///
    coeflabels( ///
        z_iat  = "Digital access (IAT)" ///
        z_icdp = "Practical digital competence (ICDP)" ///
        z_iaff = "Formal financial access (IAFF)" ///
        z_oqi  = "Onboarding quality (OQI)" ///
        z_ivs  = "Socioeconomic vulnerability (IVS)" ///
        z_iedf = "Fraud exposure / recourse failure (IEDF)" ///
        z_ieh  = "Enabling environment (IEH)") ///
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


*=======================================================*
* 3.2 Outcome: OQI (onboarding quality, OLS)            *
*=======================================================*/

eststo clear

reg oqi_score_01 $demo_controls, vce(robust)
eststo oqi_A
outreg2 using "${output_dir}/regression/tables/Table_F2_OQI.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg oqi_score_01 $demo_controls $block_B, vce(robust)
eststo oqi_B
outreg2 using "${output_dir}/regression/tables/Table_F2_OQI.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg oqi_score_01 $demo_controls $block_B c.iaff_score, vce(robust)
eststo oqi_C
outreg2 using "${output_dir}/regression/tables/Table_F2_OQI.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg oqi_score_01 $demo_controls $block_B c.iaff_score c.IEH, vce(robust)
eststo oqi_D
outreg2 using "${output_dir}/regression/tables/Table_F2_OQI.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot
reg z_oqi $demo_controls c.z_ivs c.z_iat c.z_iadt c.z_icdp c.z_iaff c.z_ieh, vce(robust)
eststo oqi_D_z

coefplot (oqi_D_z, ///
    keep(z_iat z_iadt z_icdp z_iaff z_ivs z_ieh) ///
    coeflabels( ///
        z_iat  = "Digital access (IAT)" ///
        z_iadt = "Digital self-efficacy (IADT)" ///
        z_icdp = "Practical digital competence (ICDP)" ///
        z_iaff = "Formal financial access (IAFF)" ///
        z_ivs  = "Socioeconomic vulnerability (IVS)" ///
        z_ieh  = "Enabling environment (IEH)") ///
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



/*==========================================================================*
 | 4. FAMILY 3: SAFETY, FRAUD, AND RECOURSE                                 |
 *==========================================================================*/

*===============================================*
* 4.1 Outcome: IPCS (safe conduct, OLS)         *
*===============================================*/

eststo clear

reg IPCS $demo_controls, vce(robust)
eststo ipcs_A
outreg2 using "${output_dir}/regression/tables/Table_F3_IPCS.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg IPCS $demo_controls $block_B, vce(robust)
eststo ipcs_B
outreg2 using "${output_dir}/regression/tables/Table_F3_IPCS.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg IPCS $demo_controls c.ivs_score c.iat_score c.iadt_score c.icdp_score c.oqi_score_01, vce(robust)
eststo ipcs_C
outreg2 using "${output_dir}/regression/tables/Table_F3_IPCS.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg IPCS $demo_controls c.ivs_score c.iat_score c.iadt_score c.icdp_score c.oqi_score_01 c.IEH, vce(robust)
eststo ipcs_D
outreg2 using "${output_dir}/regression/tables/Table_F3_IPCS.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot
reg z_ipcs $demo_controls c.z_ivs c.z_iat c.z_iadt c.z_icdp c.z_oqi c.z_ieh, vce(robust)
eststo ipcs_D_z

coefplot (ipcs_D_z, ///
    keep(z_iat z_iadt z_icdp z_oqi z_ivs z_ieh) ///
    coeflabels( ///
        z_iat  = "Digital access (IAT)" ///
        z_iadt = "Digital self-efficacy (IADT)" ///
        z_icdp = "Practical digital competence (ICDP)" ///
        z_oqi  = "Onboarding quality (OQI)" ///
        z_ivs  = "Socioeconomic vulnerability (IVS)" ///
        z_ieh  = "Enabling environment (IEH)") ///
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


*=============================================================*
* 4.2 Outcome: IEDF (fraud exposure / recourse failure, OLS)  *
*=============================================================*/

eststo clear

reg IEDF $demo_controls, vce(robust)
eststo iedf_A
outreg2 using "${output_dir}/regression/tables/Table_F3_IEDF.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg IEDF $demo_controls $block_B, vce(robust)
eststo iedf_B
outreg2 using "${output_dir}/regression/tables/Table_F3_IEDF.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg IEDF $demo_controls c.ivs_score c.iat_score c.iadt_score c.icdp_score c.oqi_score_01, vce(robust)
eststo iedf_C
outreg2 using "${output_dir}/regression/tables/Table_F3_IEDF.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg IEDF $demo_controls c.ivs_score c.iat_score c.iadt_score c.icdp_score c.oqi_score_01 c.IEH, vce(robust)
eststo iedf_D
outreg2 using "${output_dir}/regression/tables/Table_F3_IEDF.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot
reg z_iedf $demo_controls c.z_ivs c.z_iat c.z_iadt c.z_icdp c.z_oqi c.z_ieh, vce(robust)
eststo iedf_D_z

coefplot (iedf_D_z, ///
    keep(z_iat z_iadt z_icdp z_oqi z_ivs z_ieh) ///
    coeflabels( ///
        z_iat  = "Digital access (IAT)" ///
        z_iadt = "Digital self-efficacy (IADT)" ///
        z_icdp = "Practical digital competence (ICDP)" ///
        z_oqi  = "Onboarding quality (OQI)" ///
        z_ivs  = "Socioeconomic vulnerability (IVS)" ///
        z_ieh  = "Enabling environment (IEH)") ///
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



/*==========================================================================*
 | 5. FAMILY 4: AUTONOMY, AGENCY, AND TRUST                                 |
 *==========================================================================*/

*===================================================*
* 5.1 Outcome: IAER (autonomy, OLS)                 *
*===================================================*/

eststo clear

reg IAER $demo_controls, vce(robust)
eststo iaer_A
outreg2 using "${output_dir}/regression/tables/Table_F4_IAER.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg IAER $demo_controls c.ivs_score c.iurd_score_01, vce(robust)
eststo iaer_B
outreg2 using "${output_dir}/regression/tables/Table_F4_IAER.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg IAER $demo_controls c.ivs_score c.iurd_score_01 c.iaff_score c.ICPF, vce(robust)
eststo iaer_C
outreg2 using "${output_dir}/regression/tables/Table_F4_IAER.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg IAER $demo_controls c.ivs_score c.iurd_score_01 c.iaff_score c.ICPF c.IEDF c.IEH, vce(robust)
eststo iaer_D
outreg2 using "${output_dir}/regression/tables/Table_F4_IAER.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot
reg z_iaer $demo_controls c.z_ivs c.z_iurd c.z_iaff c.z_icpf c.z_iedf c.z_ieh, vce(robust)
eststo iaer_D_z

coefplot (iaer_D_z, ///
    keep(z_iurd z_icpf z_iaff z_ivs z_iedf z_ieh) ///
    coeflabels( ///
        z_iurd = "Digital use intensity (IURD)" ///
        z_icpf = "Trust / relational climate (ICPF)" ///
        z_iaff = "Formal financial access (IAFF)" ///
        z_ivs  = "Socioeconomic vulnerability (IVS)" ///
        z_iedf = "Fraud exposure / recourse failure (IEDF)" ///
        z_ieh  = "Enabling environment (IEH)") ///
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


*===================================================*
* 5.2 Outcome: ICPF (trust / climate, OLS)          *
*===================================================*/

eststo clear

reg ICPF $demo_controls, vce(robust)
eststo icpf_A
outreg2 using "${output_dir}/regression/tables/Table_F4_ICPF.doc", replace ///
    word dec(3) ctitle("Model A") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg ICPF $demo_controls c.ivs_score c.iurd_score_01, vce(robust)
eststo icpf_B
outreg2 using "${output_dir}/regression/tables/Table_F4_ICPF.doc", append ///
    word dec(3) ctitle("Model B") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg ICPF $demo_controls c.ivs_score c.iurd_score_01 c.iaff_score, vce(robust)
eststo icpf_C
outreg2 using "${output_dir}/regression/tables/Table_F4_ICPF.doc", append ///
    word dec(3) ctitle("Model C") ///
    addtext(City FE, Yes, Robust SE, Yes)

reg ICPF $demo_controls c.ivs_score c.iurd_score_01 c.iaff_score c.IEDF c.IEH, vce(robust)
eststo icpf_D
outreg2 using "${output_dir}/regression/tables/Table_F4_ICPF.doc", append ///
    word dec(3) ctitle("Model D") ///
    addtext(City FE, Yes, Robust SE, Yes)

* Standardized model for coefficient plot
reg z_icpf $demo_controls c.z_ivs c.z_iurd c.z_iaff c.z_iedf c.z_ieh, vce(robust)
eststo icpf_D_z

coefplot (icpf_D_z, ///
    keep(z_iurd z_iaff z_ivs z_iedf z_ieh) ///
    coeflabels( ///
        z_iurd = "Digital use intensity (IURD)" ///
        z_iaff = "Formal financial access (IAFF)" ///
        z_ivs  = "Socioeconomic vulnerability (IVS)" ///
        z_iedf = "Fraud exposure / recourse failure (IEDF)" ///
        z_ieh  = "Enabling environment (IEH)") ///
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



/*==========================================================================*
 | 6. INTERACTION / HETEROGENEITY ANALYSIS                                  |
 *==========================================================================*/

* We use a small set of theory-driven interactions to keep the analysis focused
* and interpretable given the available sample size.


*=============================================================*
* 6.1 Interaction 1: Vulnerability × Digital access -> IURD  *
*=============================================================*/

summ ivs_score, detail
local ivs_p25 = r(p25)
local ivs_p50 = r(p50)
local ivs_p75 = r(p75)

reg iurd_score_01 $demo_controls ///
    c.ivs_score##c.iat_score ///
    c.icdp_score c.iaff_score c.oqi_score_01 c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Interactions.doc", replace ///
    word dec(3) ctitle("I1: IVS x IAT -> IURD") ///
    addtext(City FE, Yes, Robust SE, Yes)

margins, at(iat_score=(0(.1)1) ivs_score=(`ivs_p25' `ivs_p50' `ivs_p75'))
marginsplot, ///
    recast(line) ciopts(recast(rline)) ///
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


*======================================================================*
* 6.2 Interaction 2: Years in Colombia × IAFF -> Formal remittance     *
*======================================================================*/

summ years_in_col, detail
local years_p25 = r(p25)
local years_p50 = r(p50)
local years_p75 = r(p75)

logit formal_remittance $demo_controls ///
    c.years_in_col##c.iaff_score ///
    c.iat_score c.icdp_score c.oqi_score_01 c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Interactions.doc", append ///
    word dec(3) eform ctitle("I2: Years x IAFF -> Formal channel") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

margins, at(iaff_score=(.25(.25)1) years_in_col=(`years_p25' `years_p50' `years_p75')) predict(pr)
marginsplot, ///
    recast(line) ciopts(recast(rline)) ///
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


*==================================================================*
* 6.3 Interaction 3: ICDP × OQI -> Transactional experience        *
*==================================================================*/

summ icdp_score, detail
local icdp_p25 = r(p25)
local icdp_p75 = r(p75)

reg ietr_score_01 $demo_controls ///
    c.icdp_score##c.oqi_score_01 ///
    c.ivs_score c.iaff_score c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Interactions.doc", append ///
    word dec(3) ctitle("I3: ICDP x OQI -> IETR") ///
    addtext(City FE, Yes, Robust SE, Yes)

margins, at(oqi_score_01=(0(.1)1) icdp_score=(`icdp_p25'  `icdp_p75'))
marginsplot, ///
    recast(line) ciopts(recast(rline)) ///
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


*==================================================================*
* 6.4 Interaction 4: IEDF × ICPF -> IURD                           *
*==================================================================*/

summ IEDF, detail
local iedf_p25 = r(p25)
local iedf_p50 = r(p50)
local iedf_p75 = r(p75)

reg iurd_score_01 $demo_controls ///
    c.IEDF##c.ICPF ///
    c.ivs_score c.iat_score c.icdp_score c.iaff_score c.oqi_score_01 c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Interactions.doc", append ///
    word dec(3) ctitle("I4: IEDF x ICPF -> IURD") ///
    addtext(City FE, Yes, Robust SE, Yes)

margins, at(IEDF=(0(10)100) ICPF=(25 50 75))
marginsplot, ///
    recast(line) ciopts(recast(rline)) ///
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



/*==========================================================================*
 | 7. SUPPLEMENTARY ITEM-LEVEL MODELS                                       |
 *==========================================================================*/

* These models are not intended for the main body of the report tables/figures,
* but they are useful for appendices and for interpreting the main index results.

*-------------------------------------------------------------*
* 7.1 Supplementary adoption model: recent digital use        *
*-------------------------------------------------------------*/
logit recent_digital_use $demo_controls ///
    c.ivs_score c.iat_score c.icdp_score c.iaff_score c.oqi_score_01 c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", replace ///
    word dec(3) eform ctitle("Recent digital use") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

*-------------------------------------------------------------*
* 7.2 Supplementary quality models                            *
*-------------------------------------------------------------*/
logit digital_problem $demo_controls ///
    c.ivs_score c.iat_score c.icdp_score c.iaff_score c.oqi_score_01 c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("Recent digital problem") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

logit fee_visible $demo_controls ///
    c.ivs_score c.iat_score c.icdp_score c.iaff_score c.oqi_score_01 c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("Fees clearly visible") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

logit provider_info_clear $demo_controls ///
    c.ivs_score c.iat_score c.icdp_score c.iaff_score c.oqi_score_01 c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("Provider info clear") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

*-------------------------------------------------------------*
* 7.3 Supplementary safety / trust models                     *
*-------------------------------------------------------------*/
logit feels_secure $demo_controls ///
    c.ivs_score c.iat_score c.icdp_score c.oqi_score_01 c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("Feels secure") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

logit any_payment_problem $demo_controls ///
    c.ivs_score c.iat_score c.icdp_score c.oqi_score_01 c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("Any payment problem") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)

*-------------------------------------------------------------*
* 7.4 Supplementary autonomy robustness                       *
*-------------------------------------------------------------*/
logit high_autonomy $demo_controls ///
    c.ivs_score c.iurd_score_01 c.iaff_score c.ICPF c.IEDF c.IEH, vce(robust)

outreg2 using "${output_dir}/regression/tables/Table_Supplementary_Items.doc", append ///
    word dec(3) eform ctitle("High autonomy (binary)") ///
    addtext(City FE, Yes, Robust SE, Yes, Estimator, Logit OR)


*-------------------------------------*
* 8. Save cleaned analysis workspace  *
*-------------------------------------*/
save "${output_dir}/regression/CFI_DPI_Data_with_regression_helpers.dta", replace

log close
display "Regression analysis script finished successfully."




*4.1 Empirical strategy (descriptive-causal boundary)

*4.2 Outcomes (dependent variables) — recommended core set

*4.3 Predictors (key independent variables)

*4.4 Core regression specifications (report-ready templates)

*4.5 Heterogeneity and interactions (policy-relevant cuts)

*4.6 Presentation of regression results

*---------------------------------------*
*		III. Análisis de cluster   		*
*---------------------------------------*


*5.1 Objective and conceptual framing

*5.2 Feature selection for clustering (what goes in)

*5.3 Pre-processing

*5.4 Choosing number of clusters

*5.5 Cluster interpretation and labeling

*5.6 Comparing clusters on key outcomes and risks

*5.7 Deliverable: “5-profile typology” (report-ready)

