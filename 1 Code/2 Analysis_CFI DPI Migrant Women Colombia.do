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
{
	/*--------------------------*
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
		
	*-----------------------*
	*		1. Setup		*
	*-----------------------*
	{
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

	}
	
	*-----------------------------------------------------------------------*
	*		2. FAMILY 1: ADOPTION, DIGITAL INTENSITY, AND FORMALIZATION		*
	*-----------------------------------------------------------------------*
	{
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
	}
	
	*-----------------------------------------------------------*
	*		3. FAMILY 2: TRANSACTION QUALITY AND ONBOARDING		*
	*-----------------------------------------------------------*
	{
	* 3.1 Outcome: IETR (transactional experience, OLS)        *

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
	}

	*-------------------------------------------------------*
	*		4. FAMILY 3: SAFETY, FRAUD, AND RECOURSE		*
	*-------------------------------------------------------*
	{	
	* 4.1 Outcome: IPCS (safe conduct, OLS)         *

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
	}

	*-------------------------------------------------------*
	*		5. FAMILY 4: AUTONOMY, AGENCY, AND TRUST		*
	*-------------------------------------------------------*
	{	
	* 5.1 Outcome: IAER (autonomy, OLS)

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
	}

	*---------------------------------------------------*
	*		6. INTERACTION / HETEROGENEITY ANALYSIS		*
	*---------------------------------------------------*
	{
	* We use a small set of theory-driven interactions to keep the analysis focused
	* and interpretable given the available sample size.

	* 6.1 Interaction 1: Vulnerability × Digital access -> IURD  *

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

	logit formal_remittance $demo_controls ///
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

	reg ietr_score_01 $demo_controls ///
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

	reg iurd_score_01 $demo_controls ///
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
	}

	*-----------------------------------------------*
	*		7. SUPPLEMENTARY ITEM-LEVEL MODELS		*
	*-----------------------------------------------*
	{
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
	}
}

*-----------------------------------*
*		III. Cluster Analysis		*
*-----------------------------------*
{

*-----------------------*
*		0. Preamble		*
*-----------------------*
{	
*-------------------------------------------------------------------------------*
* 0.1 Define output folders for cluster/LCA analysis
*-------------------------------------------------------------------------------*

global cluster_dir      "${output_dir}/cluster"
global cluster_tables   "${cluster_dir}/tables"
global cluster_figures  "${cluster_dir}/figures"
global cluster_models   "${cluster_dir}/models"
global cluster_data     "${cluster_dir}/data"

foreach d in "${cluster_dir}" "${cluster_tables}" "${cluster_figures}" ///
             "${cluster_models}" "${cluster_data}" {
    capture mkdir "`d'"
}


*-------------------------------------------------------------------------------*
* 0.2 Graph style and reproducibility settings
*-------------------------------------------------------------------------------*

capture graph set window fontface "Times New Roman"

capture set scheme plotplain
if _rc {
    noisily display as error "WARNING: scheme(plotplain) not available. Falling back to s2color."
    set scheme s2color
}
}
*---------------------------------------------------------------*
*		1. DATA INTAKE AND ANALYTICAL SAMPLE VERIFICATION		*
*---------------------------------------------------------------*
{
* Preferred source: coded data used in the existing analysis pipeline.
local data_path_1 "${input_dir}/3 Coded/CFI_DPI Data for analysis.dta"

* Fallback source: output copy, if the coded-data folder structure changes.
local data_path_2 "${output_dir}/CFI_DPI Data for analysis.dta"

capture confirm file "`data_path_1'"
if !_rc {
    use "`data_path_1'", clear
    local loaded_path "`data_path_1'"
}
else {
    capture confirm file "`data_path_2'"
    if !_rc {
        use "`data_path_2'", clear
        local loaded_path "`data_path_2'"
    }
    else {
        noisily display as error "ERROR: Could not find the analysis dataset in either expected location."
        noisily display as error "Checked:"
        noisily display as error "  1. `data_path_1'"
        noisily display as error "  2. `data_path_2'"
        log close lca_log
        exit 601
    }
}

noisily display as result "Loaded dataset: `loaded_path'"

* Dataset signature for reproducibility tracking.
capture datasignature
if !_rc {
    noisily display as text "Data signature recorded above for reproducibility tracking."
}
	
*-------------------------------------------------------------------------------*
* 1.1 Confirm expected analytical sample size
*-------------------------------------------------------------------------------*

count
local N_total = r(N)
local N_expected = 423

local sample_status "OK"
if `N_total' != `N_expected' {
    local sample_status "REVIEW"
    noisily display as error "WARNING: Current sample size is `N_total', expected `N_expected'."
}
else {
    noisily display as result "Sample size check OK: N = `N_total'"
}

* Create explicit analysis-sample flag for the LCA workflow.
capture drop __lca_analysis_sample
gen byte __lca_analysis_sample = 1
label var __lca_analysis_sample "Final coded analytical sample used for LCA workflow"	
	
*-------------------------------------------------------------------------------*
* 1.2 Verify unique respondent identifier
*-------------------------------------------------------------------------------*

capture drop lca_id
capture drop __dup_KEY

local idvar ""
local id_status ""
local id_notes ""
local N_id_nonmiss = .
local N_dup_id = .

capture confirm variable KEY

if !_rc {

    count if !missing(KEY)
    local N_id_nonmiss = r(N)

    capture isid KEY

    if !_rc {
        local idvar "KEY"
        local id_status "OK"
        local id_notes "KEY uniquely identifies observations."
        local N_dup_id = 0

        noisily display as result "ID check OK: KEY uniquely identifies observations."
    }
    else {
        duplicates tag KEY, gen(__dup_KEY)

        count if __dup_KEY > 0 & !missing(KEY)
        local N_dup_id = r(N)

        gen long lca_id = _n
        label var lca_id "Fallback sequential ID created for LCA workflow"

        local idvar "lca_id"
        local id_status "REVIEW"
        local id_notes "KEY exists but is not unique. Fallback lca_id created."

        noisily display as error "WARNING: KEY is not unique. Fallback lca_id created."
        noisily display as error "Duplicated nonmissing KEY observations: `N_dup_id'"
    }
}
else {
    gen long lca_id = _n
    label var lca_id "Fallback sequential ID created for LCA workflow"

    local idvar "lca_id"
    local id_status "REVIEW"
    local id_notes "KEY variable not found. Fallback lca_id created."
    local N_id_nonmiss = `N_total'
    local N_dup_id = 0

    noisily display as error "WARNING: KEY variable not found. Fallback lca_id created."
}

* Confirm fallback/current ID is unique.
capture isid `idvar'
if _rc {
    noisily display as error "ERROR: Final LCA ID variable `idvar' is not unique."
    log close lca_log
    exit 459
}
else {
    noisily display as result "Final LCA ID variable: `idvar'"
}	

*-------------------------------------------------------------------------------*
* 1.3 Verify availability of preliminary core indices and LCA candidate inputs
*-------------------------------------------------------------------------------*
/*
    These lists are preliminary and diagnostic.
    Final LCA inputs will be selected only after the distribution, missingness,
    sparsity, and redundancy checks in the next workflow section.
*/

local candidate_indices ///
    ivs_score ///
    iat_score ///
    iadt_score ///
    icdp_score ///
    iaff_score ///
    iuof_score_01 ///
    oqi_score_01 ///
    iurd_score_01 ///
    ietr_score_01 ///
    IPCS ///
    IEDF ///
    IAER ///
    ICPF ///
    IEH ///
    IBPD

local prelim_core_lca_inputs ///
    ivs_score ///
    iat_score ///
    icdp_score ///
    iaff_score ///
    iuof_score_01 ///
    oqi_score_01 ///
    iurd_score_01 ///
    IPCS ///
    IEDF ///
    ICPF ///
    IEH

local expanded_lca_inputs ///
    ivs_score ///
    iat_score ///
    iadt_score ///
    icdp_score ///
    iaff_score ///
    iuof_score_01 ///
    oqi_score_01 ///
    iurd_score_01 ///
    ietr_score_01 ///
    IPCS ///
    IEDF ///
    IAER ///
    ICPF ///
    IEH ///
    IBPD

* Check variable existence: candidate indices.
local present_candidate ""
local missing_candidate ""

foreach v of local candidate_indices {
    capture confirm variable `v'
    if !_rc {
        local present_candidate "`present_candidate' `v'"
    }
    else {
        local missing_candidate "`missing_candidate' `v'"
    }
}

* Check variable existence: preliminary core LCA inputs.
local present_core ""
local missing_core ""

foreach v of local prelim_core_lca_inputs {
    capture confirm variable `v'
    if !_rc {
        local present_core "`present_core' `v'"
    }
    else {
        local missing_core "`missing_core' `v'"
    }
}

* Check variable existence: expanded LCA inputs.
local present_expanded ""
local missing_expanded ""

foreach v of local expanded_lca_inputs {
    capture confirm variable `v'
    if !_rc {
        local present_expanded "`present_expanded' `v'"
    }
    else {
        local missing_expanded "`missing_expanded' `v'"
    }
}

noisily display as text "Candidate indices present: `present_candidate'"
if "`missing_candidate'" != "" {
    noisily display as error "Candidate indices missing: `missing_candidate'"
}

noisily display as text "Preliminary core LCA inputs present: `present_core'"
if "`missing_core'" != "" {
    noisily display as error "Preliminary core LCA inputs missing: `missing_core'"
}

noisily display as text "Expanded LCA inputs present: `present_expanded'"
if "`missing_expanded'" != "" {
    noisily display as error "Expanded LCA inputs missing: `missing_expanded'"
}

*-------------------------------------------------------------------------------*
* 1.4 Nonmissingness flags for diagnostic sample integrity
*-------------------------------------------------------------------------------*

capture drop __nmiss_candidate __nonmiss_candidate
capture drop __nmiss_core_lca __nonmiss_core_lca
capture drop __nmiss_expanded_lca __nonmiss_expanded_lca

if "`present_candidate'" != "" {
    egen __nmiss_candidate = rowmiss(`present_candidate')
    gen byte __nonmiss_candidate = (__nmiss_candidate == 0)
    label var __nonmiss_candidate "Nonmissing on all available candidate LCA indices"
    count if __nonmiss_candidate == 1
    local N_nonmiss_candidate = r(N)
}
else {
    local N_nonmiss_candidate = .
}

if "`present_core'" != "" {
    egen __nmiss_core_lca = rowmiss(`present_core')
    gen byte __nonmiss_core_lca = (__nmiss_core_lca == 0)
    label var __nonmiss_core_lca "Nonmissing on all available preliminary core LCA inputs"
    count if __nonmiss_core_lca == 1
    local N_nonmiss_core = r(N)
}
else {
    local N_nonmiss_core = .
}

if "`present_expanded'" != "" {
    egen __nmiss_expanded_lca = rowmiss(`present_expanded')
    gen byte __nonmiss_expanded_lca = (__nmiss_expanded_lca == 0)
    label var __nonmiss_expanded_lca "Nonmissing on all available expanded LCA inputs"
    count if __nonmiss_expanded_lca == 1
    local N_nonmiss_expanded = r(N)
}
else {
    local N_nonmiss_expanded = .
}

* Percentages.
local pct_total = 100

local pct_nonmiss_candidate = .
if `N_nonmiss_candidate' < . {
    local pct_nonmiss_candidate = 100 * `N_nonmiss_candidate' / `N_total'
}

local pct_nonmiss_core = .
if `N_nonmiss_core' < . {
    local pct_nonmiss_core = 100 * `N_nonmiss_core' / `N_total'
}

local pct_nonmiss_expanded = .
if `N_nonmiss_expanded' < . {
    local pct_nonmiss_expanded = 100 * `N_nonmiss_expanded' / `N_total'
}

* Status labels.
local candidate_status "OK"
if "`missing_candidate'" != "" {
    local candidate_status "WARNING"
}
else if `N_nonmiss_candidate' < `N_total' {
    local candidate_status "REVIEW"
}

local core_status "OK"
if "`missing_core'" != "" {
    local core_status "WARNING"
}
else if `N_nonmiss_core' < `N_total' {
    local core_status "REVIEW"
}

local expanded_status "OK"
if "`missing_expanded'" != "" {
    local expanded_status "WARNING"
}
else if `N_nonmiss_expanded' < `N_total' {
    local expanded_status "REVIEW"
}

*-------------------------------------------------------------------------------*
* 1.5 Produce sample integrity table
*-------------------------------------------------------------------------------*

tempfile sample_integrity
tempname post_integrity

postfile `post_integrity' ///
    str35 section ///
    str70 check ///
    str120 definition ///
    double count ///
    double percent ///
    str20 status ///
    str240 notes ///
    using "`sample_integrity'", replace

post `post_integrity' ///
    ("Data intake") ///
    ("Loaded dataset") ///
    ("Dataset successfully loaded from coded analysis path or fallback path") ///
    (`N_total') ///
    (`pct_total') ///
    ("OK") ///
    ("`loaded_path'")

post `post_integrity' ///
    ("Sample size") ///
    ("Total observations") ///
    ("Number of rows in the final coded analytical dataset") ///
    (`N_total') ///
    (`pct_total') ///
    ("`sample_status'") ///
    ("Expected analytical N = 423")

post `post_integrity' ///
    ("Sample definition") ///
    ("Final analysis sample") ///
    ("Dataset treated as the already-cleaned eligible/completed analysis sample") ///
    (`N_total') ///
    (`pct_total') ///
    ("OK") ///
    ("Eligibility, consent, and completion filters are assumed to have been applied upstream in data preparation.")

post `post_integrity' ///
    ("Identifier") ///
    ("Nonmissing ID observations") ///
    ("Observations with nonmissing KEY if available; otherwise fallback lca_id") ///
    (`N_id_nonmiss') ///
    (100 * `N_id_nonmiss' / `N_total') ///
    ("`id_status'") ///
    ("`id_notes'")

post `post_integrity' ///
    ("Identifier") ///
    ("Duplicated ID observations") ///
    ("Number of observations involved in duplicated nonmissing KEY values") ///
    (`N_dup_id') ///
    (100 * `N_dup_id' / `N_total') ///
    ("`id_status'") ///
    ("Final ID used in the LCA workflow: `idvar'")

post `post_integrity' ///
    ("Candidate variables") ///
    ("Candidate index variables available") ///
    ("Number of expected candidate index variables found in the dataset") ///
    (`: word count `present_candidate'') ///
    (.z) ///
    ("`candidate_status'") ///
    ("Missing candidate indices:`missing_candidate'")

post `post_integrity' ///
    ("Candidate variables") ///
    ("Nonmissing candidate indices") ///
    ("Observations nonmissing across all available candidate indices") ///
    (`N_nonmiss_candidate') ///
    (`pct_nonmiss_candidate') ///
    ("`candidate_status'") ///
    ("Candidate indices are diagnostic only; final LCA inputs will be selected after distribution and redundancy checks.")

post `post_integrity' ///
    ("Preliminary LCA inputs") ///
    ("Core input variables available") ///
    ("Number of preliminary core LCA input variables found in the dataset") ///
    (`: word count `present_core'') ///
    (.z) ///
    ("`core_status'") ///
    ("Missing preliminary core inputs:`missing_core'")

post `post_integrity' ///
    ("Preliminary LCA inputs") ///
    ("Nonmissing core LCA inputs") ///
    ("Observations nonmissing across all available preliminary core LCA inputs") ///
    (`N_nonmiss_core') ///
    (`pct_nonmiss_core') ///
    ("`core_status'") ///
    ("This is the main starting sample for diagnostic LCA input selection.")

post `post_integrity' ///
    ("Expanded LCA inputs") ///
    ("Expanded input variables available") ///
    ("Number of expanded LCA input variables found in the dataset") ///
    (`: word count `present_expanded'') ///
    (.z) ///
    ("`expanded_status'") ///
    ("Missing expanded inputs:`missing_expanded'")

post `post_integrity' ///
    ("Expanded LCA inputs") ///
    ("Nonmissing expanded LCA inputs") ///
    ("Observations nonmissing across all available expanded LCA inputs") ///
    (`N_nonmiss_expanded') ///
    (`pct_nonmiss_expanded') ///
    ("`expanded_status'") ///
    ("Expanded model may be used later as a sensitivity or richer segmentation specification.")

postclose `post_integrity'

preserve

use "`sample_integrity'", clear

format count %12.0fc
format percent %9.2f

export excel using "${cluster_tables}/Table_C0_sample_integrity.xlsx", ///
    sheet("sample_integrity") firstrow(variables) replace

restore

noisily display as result "Sample integrity table exported:"
noisily display as result "${cluster_tables}/Table_C0_sample_integrity.xlsx"

*-------------------------------------------------------------------------------*
* 1.6 Save cluster-analysis base dataset
*-------------------------------------------------------------------------------*

notes _dta: "Cluster-analysis base dataset created from `loaded_path' on $S_DATE $S_TIME."
notes _dta: "Seed set to 6427961. Final ID variable for LCA workflow: `idvar'."
notes _dta: "Preliminary LCA nonmissing flags created before variable diagnostics and transformation."

save "${cluster_data}/CFI_DPI_cluster_base_sample.dta", replace

noisily display as result "Cluster base dataset saved:"
noisily display as result "${cluster_data}/CFI_DPI_cluster_base_sample.dta"

noisily display as text "------------------------------------------------------------"
noisily display as text "LCA setup and sample verification completed"
noisily display as text "Date/time: $S_DATE $S_TIME"
noisily display as text "------------------------------------------------------------"
}
*-------------------------------------------------------------------*
*		2. VARIABLE INVENTORY AND MEASUREMENT-MAP DOCUMENTATION		*
*-------------------------------------------------------------------*
{
/*
    Purpose:
    Create a transparent measurement map from theory -> construct -> variable ->
    candidate role in the cluster/LCA workflow.

    Key methodological rule:
    The LCA should not include both an index and the direct survey items used to
    build that same index in the same model. Doing so would mechanically
    overweight one construct.
*/

* Start from the verified cluster-analysis base sample

* Start from the verified cluster-analysis base sample.
use "${cluster_data}/CFI_DPI_cluster_base_sample.dta", clear

count
local N_lca_base = r(N)

noisily display as text "------------------------------------------------------------"
noisily display as text "Section 2: Variable inventory and measurement-map documentation"
noisily display as text "Current LCA base sample N = `N_lca_base'"
noisily display as text "------------------------------------------------------------"

* Confirm output folders exist.
capture mkdir "${cluster_tables}"
capture mkdir "${cluster_data}"

*-------------------------------------------------------------------------------*
* 2.1 Helper program to post one inventory row with metadata
*-------------------------------------------------------------------------------*

capture program drop __post_lca_inventory
program define __post_lca_inventory
    version 16

    syntax , ///
        POSTname(name) ///
        DOMAIN(string asis) ///
        CONSTRUCT(string asis) ///
        VARname(name) ///
        SCALE(string asis) ///
        SOURCE(string asis) ///
        DIRECTION(string asis) ///
        CURRENTROLE(string asis) ///
        CANDIDATEROLE(string asis) ///
        TREATMENT(string asis) ///
        MAINLCA(string asis) ///
        NOTES(string asis)

    local N_total = _N

    local variable_exists = 0
    local variable_label ""
    local N_nonmissing = .
    local N_missing = .
    local pct_nonmissing = .
    local min_value = .
    local max_value = .
    local n_distinct = .
    local status "MISSING_VAR"

    capture confirm variable `varname'

    if !_rc {

        local variable_exists = 1

        local variable_label : variable label `varname'
        if `"`variable_label'"' == "" {
            local variable_label "(no variable label)"
        }

        quietly count if !missing(`varname')
        local N_nonmissing = r(N)
        local N_missing = `N_total' - `N_nonmissing'

        if `N_total' > 0 {
            local pct_nonmissing = 100 * `N_nonmissing' / `N_total'
        }

        capture confirm numeric variable `varname'
        if !_rc & `N_nonmissing' > 0 {
            quietly summarize `varname' if !missing(`varname'), meanonly
            local min_value = r(min)
            local max_value = r(max)

            capture quietly levelsof `varname' if !missing(`varname'), local(__levels)
            if !_rc {
                local n_distinct : word count `__levels'
            }
            else {
                local n_distinct = .
            }
        }

        local status "OK"

        if `N_nonmissing' == 0 {
            local status "NO_DATA"
        }
        else if `N_nonmissing' < `N_total' {
            local status "REVIEW_MISSING"
        }
    }

    post `postname' ///
        (`"`domain'"') ///
        (`"`construct'"') ///
        (`"`varname'"') ///
        (`"`scale'"') ///
        (`"`source'"') ///
        (`"`direction'"') ///
        (`"`currentrole'"') ///
        (`"`candidaterole'"') ///
        (`"`treatment'"') ///
        (`"`mainlca'"') ///
        (`"`notes'"') ///
        (`variable_exists') ///
        (`"`variable_label'"') ///
        (`N_nonmissing') ///
        (`N_missing') ///
        (`pct_nonmissing') ///
        (`min_value') ///
        (`max_value') ///
        (`n_distinct') ///
        (`"`status'"')
end


*-------------------------------------------------------------------------------*
* 2.2 Create full variable inventory
*-------------------------------------------------------------------------------*

tempfile variable_inventory
tempname invpost

postfile `invpost' ///
    str55 theory_mechanism ///
    str55 construct ///
    str32 variable ///
    str35 scale ///
    str45 source_section ///
    str90 score_direction ///
    str70 current_role ///
    str70 candidate_role ///
    str70 preferred_lca_treatment ///
    str25 main_lca ///
    str240 notes ///
    byte variable_exists ///
    str140 variable_label ///
    double N_nonmissing ///
    double N_missing ///
    double pct_nonmissing ///
    double min_value ///
    double max_value ///
    double n_distinct ///
    str25 status ///
    using "`variable_inventory'", replace

*-------------------------------------------------------------------------------*
* 2.2.1 Core and candidate index variables
*-------------------------------------------------------------------------------*

#delimit ;

__post_lca_inventory, postname(`invpost')
    domain("Structural vulnerability")
    construct("Socioeconomic vulnerability")
    varname(ivs_score)
    scale("Continuous 0-1")
    source("Section B demographics")
    direction("Higher = more vulnerable")
    currentrole("Diagnostic continuous score")
    candidaterole("Candidate construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Use as source measure. Ordinal ivs_cat is preferred for categorical LCA.");

__post_lca_inventory, postname(`invpost')
    domain("Structural vulnerability")
    construct("Socioeconomic vulnerability")
    varname(ivs_cat)
    scale("Ordinal 1-3")
    source("Constructed from IVS")
    direction("Higher = more vulnerable")
    currentrole("Categorical construct")
    candidaterole("Candidate LCA input")
    treatment("Ordered categorical")
    mainlca("Candidate")
    notes("Candidate input if vulnerability is included in the segmentation model.");

__post_lca_inventory, postname(`invpost')
    domain("Cost-convenience")
    construct("Telecommunications access")
    varname(iat_score)
    scale("Continuous 0-1")
    source("Section C0")
    direction("Higher = better access")
    currentrole("Diagnostic continuous score")
    candidaterole("Candidate construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Use as source measure. Ordinal iat_cat is preferred for categorical LCA.");

__post_lca_inventory, postname(`invpost')
    domain("Cost-convenience")
    construct("Telecommunications access")
    varname(iat_cat)
    scale("Ordinal 1-3")
    source("Constructed from IAT")
    direction("Higher = better access")
    currentrole("Categorical construct")
    candidaterole("Candidate LCA input")
    treatment("Ordered categorical")
    mainlca("Candidate")
    notes("Captures quality and stability of digital access.");

__post_lca_inventory, postname(`invpost')
    domain("Cost-convenience")
    construct("Digital self-efficacy")
    varname(iadt_score)
    scale("Continuous 0-1")
    source("Section C1")
    direction("Higher = stronger self-efficacy")
    currentrole("Diagnostic continuous score")
    candidaterole("Candidate or sensitivity")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Conceptually overlaps with practical competence. Use cautiously with ICDP.");

__post_lca_inventory, postname(`invpost')
    domain("Cost-convenience")
    construct("Digital self-efficacy")
    varname(iadt_cat)
    scale("Ordinal 1-3")
    source("Constructed from IADT")
    direction("Higher = stronger self-efficacy")
    currentrole("Categorical construct")
    candidaterole("Sensitivity LCA input")
    treatment("Ordered categorical")
    mainlca("Sensitivity")
    notes("Useful for sensitivity models if ICDP alone does not capture perceived capability.");

__post_lca_inventory, postname(`invpost')
    domain("Cost-convenience")
    construct("Practical digital competence")
    varname(icdp_score)
    scale("Continuous 0-1")
    source("Section C2")
    direction("Higher = stronger practical competence")
    currentrole("Diagnostic continuous score")
    candidaterole("Core construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Strongly supported by regression results. Ordinal icdp_cat preferred for LCA.");

__post_lca_inventory, postname(`invpost')
    domain("Cost-convenience")
    construct("Practical digital competence")
    varname(icdp_cat)
    scale("Ordinal 1-3")
    source("Constructed from ICDP")
    direction("Higher = stronger practical competence")
    currentrole("Categorical construct")
    candidaterole("Core LCA input")
    treatment("Ordered categorical")
    mainlca("Yes")
    notes("Core input capturing applied ability to use QR, OTP, PIN, and fraud-response skills.");

__post_lca_inventory, postname(`invpost')
    domain("Remittance formalization")
    construct("Formal financial access")
    varname(iaff_score)
    scale("Continuous 0-1")
    source("Section C3")
    direction("Higher = stronger formal access")
    currentrole("Diagnostic continuous score")
    candidaterole("Core construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Use as source measure. Ordinal iaff_cat preferred for categorical LCA.");

__post_lca_inventory, postname(`invpost')
    domain("Remittance formalization")
    construct("Formal financial access")
    varname(iaff_cat)
    scale("Ordinal 1-3")
    source("Constructed from IAFF")
    direction("Higher = stronger formal access")
    currentrole("Categorical construct")
    candidaterole("Core LCA input")
    treatment("Ordered categorical")
    mainlca("Yes")
    notes("Core input capturing documentation, address, phone ownership, and account access.");

__post_lca_inventory, postname(`invpost')
    domain("Remittance formalization")
    construct("Financial operability")
    varname(iuof_score_01)
    scale("Continuous 0-1")
    source("Section C3 continued")
    direction("Higher = more operational use")
    currentrole("Diagnostic continuous score")
    candidaterole("Core construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Use as source measure. Ordinal iuof_cat preferred for categorical LCA.");

__post_lca_inventory, postname(`invpost')
    domain("Remittance formalization")
    construct("Financial operability")
    varname(iuof_cat)
    scale("Ordinal 1-3")
    source("Constructed from IUOF")
    direction("Higher = more operational use")
    currentrole("Categorical construct")
    candidaterole("Core LCA input")
    treatment("Ordered categorical")
    mainlca("Yes")
    notes("Core input capturing whether access translates into active account and wallet use.");

__post_lca_inventory, postname(`invpost')
    domain("DPI governance and usability")
    construct("Onboarding quality")
    varname(oqi_score_01)
    scale("Continuous 0-1")
    source("Section C4")
    direction("Higher = better onboarding")
    currentrole("Diagnostic continuous score")
    candidaterole("Core construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Use as source measure. Ordinal oqi_cat preferred for categorical LCA.");

__post_lca_inventory, postname(`invpost')
    domain("DPI governance and usability")
    construct("Onboarding quality")
    varname(oqi_cat)
    scale("Ordinal 1-3")
    source("Constructed from OQI")
    direction("Higher = better onboarding")
    currentrole("Categorical construct")
    candidaterole("Core LCA input")
    treatment("Ordered categorical")
    mainlca("Yes")
    notes("Core input given strong descriptive and regression evidence on onboarding as a gateway.");

__post_lca_inventory, postname(`invpost')
    domain("Remittance formalization")
    construct("Digital remittance use intensity")
    varname(iurd_score_01)
    scale("Continuous 0-1")
    source("Section D")
    direction("Higher = greater digital use intensity")
    currentrole("Diagnostic continuous score")
    candidaterole("Core construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Use as source measure. Ordinal iurd_cat preferred for categorical LCA.");

__post_lca_inventory, postname(`invpost')
    domain("Remittance formalization")
    construct("Digital remittance use intensity")
    varname(iurd_cat)
    scale("Ordinal 1-3")
    source("Constructed from IURD")
    direction("Higher = greater digital use intensity")
    currentrole("Categorical construct")
    candidaterole("Core LCA input")
    treatment("Ordered categorical")
    mainlca("Yes")
    notes("Core input capturing digital remittance and payment participation.");

__post_lca_inventory, postname(`invpost')
    domain("DPI governance and usability")
    construct("Transactional experience")
    varname(ietr_score_01)
    scale("Continuous 0-1")
    source("Section D")
    direction("Higher = better transactional experience")
    currentrole("Diagnostic continuous score")
    candidaterole("Candidate construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("May be used in expanded LCA or as an external profiling outcome.");

__post_lca_inventory, postname(`invpost')
    domain("DPI governance and usability")
    construct("Transactional experience")
    varname(ietr_cat)
    scale("Ordinal 1-3")
    source("Constructed from IETR")
    direction("Higher = better transactional experience")
    currentrole("Categorical construct")
    candidaterole("Candidate or sensitivity")
    treatment("Ordered categorical")
    mainlca("Sensitivity")
    notes("Potential expanded input. Avoid overfitting if OQI and IUOF already capture experience-related variation.");

__post_lca_inventory, postname(`invpost')
    domain("Trust-safety and recourse")
    construct("Safe conduct")
    varname(IPCS)
    scale("Continuous 0-100")
    source("Section E")
    direction("Higher = safer conduct")
    currentrole("Diagnostic continuous score")
    candidaterole("Core construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Use as source measure. Ordinal IPCS_cat preferred due ceiling concentration.");

__post_lca_inventory, postname(`invpost')
    domain("Trust-safety and recourse")
    construct("Safe conduct")
    varname(IPCS_cat)
    scale("Ordinal 1-3")
    source("Constructed from IPCS")
    direction("Higher = safer conduct")
    currentrole("Categorical construct")
    candidaterole("Core LCA input")
    treatment("Ordered categorical")
    mainlca("Yes")
    notes("Core input but needs sparsity check because many respondents may score high.");

__post_lca_inventory, postname(`invpost')
    domain("Trust-safety and recourse")
    construct("Fraud harm and recourse failure")
    varname(IEDF)
    scale("Continuous 0-100")
    source("Section E")
    direction("Higher = greater harm or recourse failure")
    currentrole("Diagnostic continuous score")
    candidaterole("Core construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Use as source measure. May require binary or ordinal treatment due floor concentration.");

__post_lca_inventory, postname(`invpost')
    domain("Trust-safety and recourse")
    construct("Fraud harm and recourse failure")
    varname(IEDF_cat)
    scale("Ordinal 1-3")
    source("Constructed from IEDF")
    direction("Higher = greater harm or recourse failure")
    currentrole("Categorical construct")
    candidaterole("Core or binary LCA input")
    treatment("Ordered or binary categorical")
    mainlca("Yes")
    notes("Core safety-risk input. Next diagnostics should decide whether 3-category or binary version is better.");

__post_lca_inventory, postname(`invpost')
    domain("Financial control and autonomy")
    construct("Economic autonomy in remittances")
    varname(IAER)
    scale("Continuous 0-100")
    source("Section F")
    direction("Higher = greater autonomy")
    currentrole("Diagnostic continuous score")
    candidaterole("Sensitivity or profile")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Ceiling concentration expected. Prefer as external profile outcome unless diagnostics support inclusion.");

__post_lca_inventory, postname(`invpost')
    domain("Financial control and autonomy")
    construct("Economic autonomy in remittances")
    varname(IAER_cat)
    scale("Ordinal 1-3")
    source("Constructed from IAER")
    direction("Higher = greater autonomy")
    currentrole("Categorical construct")
    candidaterole("Sensitivity or profile")
    treatment("Ordered categorical")
    mainlca("Sensitivity")
    notes("Use cautiously due limited variation. Useful for cluster interpretation and validation.");

__post_lca_inventory, postname(`invpost')
    domain("Financial control and autonomy")
    construct("Trust and relational climate")
    varname(ICPF)
    scale("Continuous 0-100")
    source("Section F")
    direction("Higher = stronger trust climate")
    currentrole("Diagnostic continuous score")
    candidaterole("Core construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Use as source measure. Ordinal ICPF_cat preferred for categorical LCA.");

__post_lca_inventory, postname(`invpost')
    domain("Financial control and autonomy")
    construct("Trust and relational climate")
    varname(ICPF_cat)
    scale("Ordinal 1-3")
    source("Constructed from ICPF")
    direction("Higher = stronger trust climate")
    currentrole("Categorical construct")
    candidaterole("Core LCA input")
    treatment("Ordered categorical")
    mainlca("Yes")
    notes("Core input for the autonomy and trust mechanism.");

__post_lca_inventory, postname(`invpost')
    domain("Enabling environment")
    construct("Enabling environment")
    varname(IEH)
    scale("Continuous 0-100")
    source("Section G")
    direction("Higher = more enabling environment")
    currentrole("Diagnostic continuous score")
    candidaterole("Core construct")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Use as source measure. Ordinal IEH_cat preferred for categorical LCA.");

__post_lca_inventory, postname(`invpost')
    domain("Enabling environment")
    construct("Enabling environment")
    varname(IEH_cat)
    scale("Ordinal 1-3")
    source("Constructed from IEH")
    direction("Higher = more enabling environment")
    currentrole("Categorical construct")
    candidaterole("Core LCA input")
    treatment("Ordered categorical")
    mainlca("Yes")
    notes("Core input capturing information, support, training, and cash-out environment.");

__post_lca_inventory, postname(`invpost')
    domain("Enabling environment")
    construct("Perceived barriers to digitalization")
    varname(IBPD)
    scale("Continuous 0-100")
    source("Section G")
    direction("Higher = more perceived barriers")
    currentrole("Diagnostic continuous score")
    candidaterole("Candidate or sensitivity")
    treatment("Continuous source for recoding")
    mainlca("No")
    notes("Potentially overlaps inversely with IEH. Do not force both into the same main LCA without redundancy checks.");

__post_lca_inventory, postname(`invpost')
    domain("Enabling environment")
    construct("Perceived barriers to digitalization")
    varname(IBPD_cat)
    scale("Ordinal 1-3")
    source("Constructed from IBPD")
    direction("Higher = more perceived barriers")
    currentrole("Categorical construct")
    candidaterole("Candidate or sensitivity")
    treatment("Ordered categorical")
    mainlca("Sensitivity")
    notes("Candidate input for sensitivity model or external cluster interpretation.");

#delimit cr

*-------------------------------------------------------------------------------*
* 2.2.2 Auxiliary direct survey items for interpretation and validation only
*-------------------------------------------------------------------------------*
/*
    These variables should not automatically enter the main LCA if their parent
    construct index is already included. They are documented here so they can be
    used later to profile, validate, and interpret the resulting clusters.
*/

#delimit ;

__post_lca_inventory, postname(`invpost')
    domain("Remittance formalization")
    construct("Latest remittance channel")
    varname(q6_4)
    scale("Categorical")
    source("Section D")
    direction("Channel categories")
    currentrole("Auxiliary profile variable")
    candidaterole("Not main LCA input")
    treatment("External validation or profile")
    mainlca("No")
    notes("Use to describe clusters by remittance channel. Avoid using with IURD in same main LCA.");

__post_lca_inventory, postname(`invpost')
    domain("Remittance formalization")
    construct("Recent digital transaction use")
    varname(q6_14)
    scale("Binary")
    source("Section D")
    direction("1 = recent digital use")
    currentrole("Auxiliary profile variable")
    candidaterole("Not main LCA input")
    treatment("External validation or profile")
    mainlca("No")
    notes("Useful for cluster validation because it is a simple behavioral outcome.");

__post_lca_inventory, postname(`invpost')
    domain("Cost-convenience")
    construct("Recent QR use")
    varname(q5_4)
    scale("Categorical")
    source("Section C4")
    direction("Higher code is not monotonic")
    currentrole("Auxiliary profile variable")
    candidaterole("Not main LCA input")
    treatment("Recode before use")
    mainlca("No")
    notes("Can be converted into any QR use. Use only as descriptive profile variable unless needed for sensitivity.");

__post_lca_inventory, postname(`invpost')
    domain("Trust-safety and recourse")
    construct("Suspicious messages or calls")
    varname(q7_1)
    scale("Categorical")
    source("Section E")
    direction("Higher code is not monotonic")
    currentrole("Auxiliary profile variable")
    candidaterole("Not main LCA input")
    treatment("Recode before use")
    mainlca("No")
    notes("Useful for validating IEDF-based cluster differences.");

__post_lca_inventory, postname(`invpost')
    domain("Trust-safety and recourse")
    construct("Payment or remittance problem")
    varname(q7_11)
    scale("Binary plus DK")
    source("Section E")
    direction("1 = had problem")
    currentrole("Auxiliary profile variable")
    candidaterole("Not main LCA input")
    treatment("External validation or profile")
    mainlca("No")
    notes("Use to profile realized problems across clusters.");

__post_lca_inventory, postname(`invpost')
    domain("Financial control and autonomy")
    construct("Avoided digital use due household conflict")
    varname(q9_20)
    scale("Binary plus PNR")
    source("Section F")
    direction("1 = avoided use due conflict")
    currentrole("Auxiliary profile variable")
    candidaterole("Not main LCA input")
    treatment("External validation or profile")
    mainlca("No")
    notes("Useful for checking whether clusters differ in relational constraints.");

__post_lca_inventory, postname(`invpost')
    domain("Enabling environment")
    construct("Training participation")
    varname(q10_10)
    scale("Categorical")
    source("Section G")
    direction("Lower code = more recent training")
    currentrole("Auxiliary profile variable")
    candidaterole("Not main LCA input")
    treatment("External validation or profile")
    mainlca("No")
    notes("Use to describe program exposure across clusters.");

__post_lca_inventory, postname(`invpost')
    domain("Enabling environment")
    construct("Individual accompaniment")
    varname(q10_13)
    scale("Binary plus PNR")
    source("Section G")
    direction("1 = received accompaniment")
    currentrole("Auxiliary profile variable")
    candidaterole("Not main LCA input")
    treatment("External validation or profile")
    mainlca("No")
    notes("Use to validate whether support exposure differs across profiles.");

#delimit cr

postclose `invpost'

*-------------------------------------------------------------------------------*
* 2.3 Format, label, export, and save the inventory table
*-------------------------------------------------------------------------------*

preserve

use "`variable_inventory'", clear

label variable theory_mechanism       "Theory mechanism / analytical domain"
label variable construct              "Construct"
label variable variable               "Variable name"
label variable scale                  "Measurement scale"
label variable source_section         "Survey / constructed source"
label variable score_direction        "Direction of interpretation"
label variable current_role           "Current measurement role"
label variable candidate_role         "Candidate role in clustering"
label variable preferred_lca_treatment "Preferred LCA treatment"
label variable main_lca               "Recommended for main LCA"
label variable notes                  "Methodological notes"
label variable variable_exists        "Variable exists in analysis data"
label variable variable_label         "Variable label in Stata dataset"
label variable N_nonmissing           "Nonmissing observations"
label variable N_missing              "Missing observations"
label variable pct_nonmissing         "Percent nonmissing"
label variable min_value              "Minimum value"
label variable max_value              "Maximum value"
label variable n_distinct             "Number of distinct observed values"
label variable status                 "Inventory audit status"

format N_nonmissing N_missing n_distinct %12.0fc
format pct_nonmissing %9.2f
format min_value max_value %12.4f

order ///
    theory_mechanism ///
    construct ///
    variable ///
    scale ///
    source_section ///
    score_direction ///
    current_role ///
    candidate_role ///
    preferred_lca_treatment ///
    main_lca ///
    notes ///
    variable_exists ///
    variable_label ///
    N_nonmissing ///
    N_missing ///
    pct_nonmissing ///
    min_value ///
    max_value ///
    n_distinct ///
    status

sort theory_mechanism construct variable

* Console checks for immediate review.
noisily display as text "Inventory audit status:"
tab status, missing

noisily display as text "Recommended main-LCA role:"
tab main_lca, missing

noisily display as text "Variables requiring review:"
list construct variable scale candidate_role N_nonmissing N_missing n_distinct status ///
    if status != "OK", noobs abbreviate(28)

* Export main inventory sheet.
export excel using "${cluster_tables}/Table_C1_variable_inventory.xlsx", ///
    sheet("variable_inventory") firstrow(variables) replace

* Save Stata copy for future sections.
save "${cluster_data}/CFI_DPI_lca_variable_inventory.dta", replace

restore


*-------------------------------------------------------------------------------*
* 2.4 Export methodological rules sheet
*-------------------------------------------------------------------------------*

preserve

clear
set obs 6

gen byte rule_id = _n
gen str80 rule_area = ""
gen str240 rule_text = ""

replace rule_area = "No double counting" in 1
replace rule_text = "Do not include an index and the direct survey items used to construct that same index in the same LCA model." in 1

replace rule_area = "Categorical LCA preference" in 2
replace rule_text = "For the main LCA, prefer ordered categorical versions of the indices rather than raw continuous scores." in 2

replace rule_area = "Continuous scores" in 3
replace rule_text = "Continuous scores are retained for diagnostics, threshold validation, robustness checks, and post-LCA cluster profiling." in 3

replace rule_area = "Auxiliary variables" in 4
replace rule_text = "Direct survey items listed as auxiliary variables should be used mainly to interpret and validate the clusters after model estimation." in 4

replace rule_area = "Redundancy checks" in 5
replace rule_text = "Highly overlapping constructs should not be forced into the same main model unless diagnostics show they add distinct information." in 5

replace rule_area = "Interpretability" in 6
replace rule_text = "Final model selection should balance fit statistics, classification quality, minimum class size, stability, and substantive interpretability." in 6

export excel using "${cluster_tables}/Table_C1_variable_inventory.xlsx", ///
    sheet("methodological_rules", replace) firstrow(variables)

restore
*-------------------------------------------------------------------------------*
* 2.5 Export preliminary construct-role summary
*-------------------------------------------------------------------------------*

preserve

use "${cluster_data}/CFI_DPI_lca_variable_inventory.dta", clear

* Clean string fields in case of leading/trailing blanks.
foreach v in main_lca candidate_role preferred_lca_treatment construct variable {
    capture confirm string variable `v'
    if !_rc {
        replace `v' = strtrim(`v')
    }
}

* Diagnostic display.
noisily display as text "Observed values in main_lca before filtering:"
tab main_lca, missing

* If main_lca was not populated correctly, reconstruct it from candidate_role.
capture count if inlist(main_lca, "Yes", "Candidate", "Sensitivity")
if r(N) == 0 {

    noisily display as error "main_lca has no usable Yes/Candidate/Sensitivity values."
    noisily display as text  "Reconstructing main_lca from candidate_role..."

    replace main_lca = "Yes" if ///
        strpos(candidate_role, "Core LCA input") > 0 | ///
        strpos(candidate_role, "Core or binary LCA input") > 0

    replace main_lca = "Candidate" if ///
        strpos(candidate_role, "Candidate LCA input") > 0 | ///
        strpos(candidate_role, "Candidate construct") > 0

    replace main_lca = "Sensitivity" if ///
        strpos(candidate_role, "Sensitivity") > 0 | ///
        strpos(candidate_role, "profile") > 0

    noisily display as text "Observed values in main_lca after reconstruction:"
    tab main_lca, missing
}

* Keep only variables relevant for the candidate-input summary.
keep if inlist(main_lca, "Yes", "Candidate", "Sensitivity")

count
if r(N) == 0 {
    noisily display as error "No observations available for candidate_inputs_summary. Skipping this export."
}
else {

    keep theory_mechanism construct variable scale candidate_role ///
         preferred_lca_treatment main_lca notes ///
         N_nonmissing pct_nonmissing n_distinct status

    sort main_lca theory_mechanism construct variable

    export excel using "${cluster_tables}/Table_C1_variable_inventory.xlsx", ///
        sheet("candidate_inputs_summary", replace) firstrow(variables)  
		
    noisily display as result "Candidate-input summary exported successfully."
}

restore

}
*-------------------------------------------------------------------*
*		3. DIAGNOSTIC ANALYSIS OF CANDIDATE CLUSTERING INPUTS		*
*-------------------------------------------------------------------*
{
/*
    Purpose:
    Diagnose all candidate clustering/LCA inputs before model estimation.

    This section evaluates:
    1. Missingness, unique values, and distributional properties.
    2. Category sparsity and concentration.
    3. Redundancy / local-dependence risks across candidate inputs.
    4. Continuous correlation structure and categorical association structure.

    Main outputs:
    - Table_C2_missingness_unique_values.xlsx
    - Table_C3_category_distributions.xlsx
    - Table_C4_pairwise_associations.xlsx
    - figC1_index_distributions.png
    - figC2_correlation_heatmap.png
*/
*-------------------------------------------------------------------------------*
* 3.0 Load verified cluster-analysis base sample
*-------------------------------------------------------------------------------*

use "${cluster_data}/CFI_DPI_cluster_base_sample.dta", clear

count
local N_cluster = r(N)

noisily display as text "------------------------------------------------------------"
noisily display as text "Section 3: Diagnostic analysis of candidate clustering inputs"
noisily display as text "Current cluster-analysis base sample N = `N_cluster'"
noisily display as text "------------------------------------------------------------"

capture mkdir "${cluster_tables}"
capture mkdir "${cluster_figures}"
capture mkdir "${cluster_data}"

set more off
set seed 6427961
graph set window fontface "Times New Roman"

*-------------------------------------------------------------------------------*
* 3.0.1 Generate auxiliary formal remittance indicator for diagnostics
*-------------------------------------------------------------------------------*
/*
    Definition:
    formal_remittance = 1 if latest remittance was received through bank transfer
                        or wallet/app.
    formal_remittance = 0 if latest remittance was received through cash pickup
                        or hand-carried traveler.
    Other channels are treated as missing for the binary formalization diagnostic.
*/

capture drop formal_remittance
gen byte formal_remittance = .
replace formal_remittance = 1 if inlist(q6_4, 1, 2)
replace formal_remittance = 0 if inlist(q6_4, 3, 4)

label define formal_remit_lbl ///
    0 "Cash pickup / traveler" ///
    1 "Bank transfer / wallet-app", replace
label values formal_remittance formal_remit_lbl
label var formal_remittance "Latest remittance received through formal digital channel"

*-------------------------------------------------------------------------------*
* 3.0.2 Define candidate input lists
*-------------------------------------------------------------------------------*

* Continuous source indices: retained for diagnostics, recoding, and profiling.
local cont_indices ///
    ivs_score ///
    iat_score ///
    iadt_score ///
    icdp_score ///
    iaff_score ///
    iuof_score_01 ///
    oqi_score_01 ///
    iurd_score_01 ///
    ietr_score_01 ///
    IPCS ///
    IEDF ///
    IAER ///
    ICPF ///
    IEH ///
    IBPD

* Existing categorical versions of the constructed indices.
local cat_indices ///
    ivs_cat ///
    iat_cat ///
    iadt_cat ///
    icdp_cat ///
    iaff_cat ///
    iuof_cat ///
    oqi_cat ///
    iurd_cat ///
    ietr_cat ///
    IPCS_cat ///
    IEDF_cat ///
    IAER_cat ///
    ICPF_cat ///
    IEH_cat ///
    IBPD_cat

* Auxiliary categorical variables for interpretation and validation.
local aux_cat_vars ///
    formal_remittance ///
    q6_4 ///
    q6_14 ///
    q5_4 ///
    q7_1 ///
    q7_11 ///
    q9_20 ///
    q10_10 ///
    q10_13

* Build available-variable lists to avoid hard failures if any variable is absent.
local cont_available
foreach v of local cont_indices {
    capture confirm numeric variable `v'
    if !_rc {
        local cont_available `cont_available' `v'
    }
    else {
        noisily display as error "WARNING: continuous candidate variable not found: `v'"
    }
}

local cat_available
foreach v of local cat_indices {
    capture confirm numeric variable `v'
    if !_rc {
        local cat_available `cat_available' `v'
    }
    else {
        noisily display as error "WARNING: categorical candidate variable not found: `v'"
    }
}

local aux_cat_available
foreach v of local aux_cat_vars {
    capture confirm numeric variable `v'
    if !_rc {
        local aux_cat_available `aux_cat_available' `v'
    }
    else {
        noisily display as error "WARNING: auxiliary categorical variable not found: `v'"
    }
}

noisily display as text "Continuous variables available for diagnostics:"
noisily display as result "`cont_available'"

noisily display as text "Categorical variables available for diagnostics:"
noisily display as result "`cat_available'"

noisily display as text "Auxiliary categorical variables available for diagnostics:"
noisily display as result "`aux_cat_available'"


*-------------------------------------------------------------------------------*
* 3.1 Missingness, unique values, and summary statistics
*-------------------------------------------------------------------------------*

tempfile missingness_table
tempname misspost

postfile `misspost' ///
    str32 variable ///
    str140 variable_label ///
    str30 variable_group ///
    double N_total ///
    double N_nonmissing ///
    double N_missing ///
    double pct_missing ///
    double n_distinct ///
    double min_value ///
    double max_value ///
    double mean_value ///
    double sd_value ///
    double p25 ///
    double p50 ///
    double p75 ///
    str45 diagnostic_flag ///
    using "`missingness_table'", replace

local all_diag_vars `cont_available' `cat_available' `aux_cat_available'

foreach v of local all_diag_vars {

    local vlab : variable label `v'
    if `"`vlab'"' == "" local vlab "(no variable label)"

    local vgroup "Auxiliary categorical"
    if strpos(" `cont_available' ", " `v' ") > 0 local vgroup "Continuous index"
    if strpos(" `cat_available' ",  " `v' ") > 0 local vgroup "Categorical index"

    quietly count
    local N_total = r(N)

    quietly count if !missing(`v')
    local N_nonmissing = r(N)
    local N_missing = `N_total' - `N_nonmissing'
    local pct_missing = 100 * `N_missing' / `N_total'

    local min_value = .
    local max_value = .
    local mean_value = .
    local sd_value = .
    local p25 = .
    local p50 = .
    local p75 = .
    local n_distinct = .

    if `N_nonmissing' > 0 {
        quietly summarize `v' if !missing(`v'), detail
        local min_value = r(min)
        local max_value = r(max)
        local mean_value = r(mean)
        local sd_value = r(sd)
        local p25 = r(p25)
        local p50 = r(p50)
        local p75 = r(p75)

        capture quietly levelsof `v' if !missing(`v'), local(__levels)
        if !_rc {
            local n_distinct : word count `__levels'
        }
    }

    local flag "OK"

    if `N_nonmissing' == 0 {
        local flag "NO_DATA"
    }
    else if `pct_missing' > 10 {
        local flag "HIGH_MISSING"
    }
    else if `pct_missing' > 0 {
        local flag "SOME_MISSING"
    }

    if "`vgroup'" == "Categorical index" & `n_distinct' < 3 {
        local flag "`flag'; LOW_CATEGORY_VARIATION"
    }

    if "`vgroup'" == "Continuous index" & `sd_value' < 0.05 {
        local flag "`flag'; LOW_SD"
    }

    post `misspost' ///
        (`"`v'"') ///
        (`"`vlab'"') ///
        (`"`vgroup'"') ///
        (`N_total') ///
        (`N_nonmissing') ///
        (`N_missing') ///
        (`pct_missing') ///
        (`n_distinct') ///
        (`min_value') ///
        (`max_value') ///
        (`mean_value') ///
        (`sd_value') ///
        (`p25') ///
        (`p50') ///
        (`p75') ///
        (`"`flag'"')
}

postclose `misspost'

preserve

use "`missingness_table'", clear

format N_total N_nonmissing N_missing n_distinct %12.0fc
format pct_missing min_value max_value mean_value sd_value p25 p50 p75 %9.3f

sort variable_group variable

export excel using "${cluster_tables}/Table_C2_missingness_unique_values.xlsx", ///
    sheet("missingness_unique_values") firstrow(variables) replace

save "${cluster_data}/CFI_DPI_lca_missingness_diagnostics.dta", replace

noisily display as text "Missingness / unique-values diagnostic flags:"
list variable variable_group N_nonmissing N_missing pct_missing n_distinct diagnostic_flag ///
    if diagnostic_flag != "OK", noobs abbreviate(28)

restore

*-------------------------------------------------------------------------------*
* 3.1.1 Category frequency diagnostics
*-------------------------------------------------------------------------------*

tempfile category_distribution
tempname catpost

postfile `catpost' ///
    str32 variable ///
    str140 variable_label ///
    str30 variable_group ///
    double category_value ///
    str140 category_label ///
    double frequency ///
    double percent ///
    double cumulative_percent ///
    byte sparse_flag ///
    str50 diagnostic_flag ///
    using "`category_distribution'", replace

local cat_diag_vars `cat_available' `aux_cat_available'

foreach v of local cat_diag_vars {

    local vlab : variable label `v'
    if `"`vlab'"' == "" local vlab "(no variable label)"

    local vgroup "Auxiliary categorical"
    if strpos(" `cat_available' ", " `v' ") > 0 local vgroup "Categorical index"

    quietly count if !missing(`v')
    local N_valid = r(N)

    local cumulative = 0

    capture quietly levelsof `v' if !missing(`v'), local(levels)
    if !_rc & `N_valid' > 0 {

        local vallab : value label `v'

        foreach level of local levels {

            quietly count if `v' == `level'
            local freq = r(N)
            local pct = 100 * `freq' / `N_valid'
            local cumulative = `cumulative' + `pct'

            local level_label ""
            if "`vallab'" != "" {
                capture local level_label : label `vallab' `level'
            }
            if `"`level_label'"' == "" {
                local level_label "`level'"
            }

            local sparse = 0
            local flag "OK"

            if `freq' < 20 | `pct' < 5 {
                local sparse = 1
                local flag "SPARSE_CATEGORY"
            }

            post `catpost' ///
                (`"`v'"') ///
                (`"`vlab'"') ///
                (`"`vgroup'"') ///
                (`level') ///
                (`"`level_label'"') ///
                (`freq') ///
                (`pct') ///
                (`cumulative') ///
                (`sparse') ///
                (`"`flag'"')
        }
    }
}

postclose `catpost'

preserve

use "`category_distribution'", clear

format frequency %12.0fc
format percent cumulative_percent %9.2f

sort variable category_value

export excel using "${cluster_tables}/Table_C3_category_distributions.xlsx", ///
    sheet("category_distributions") firstrow(variables) replace

save "${cluster_data}/CFI_DPI_lca_category_distributions.dta", replace

noisily display as text "Sparse categories detected:"
list variable category_value category_label frequency percent diagnostic_flag ///
    if sparse_flag == 1, noobs abbreviate(32)

restore


*-------------------------------------------------------------------------------*
* 3.2 Distribution diagnostics for continuous indices
*-------------------------------------------------------------------------------*

* Short labels for clean graph titles.
local lab_ivs_score      "IVS"
local lab_iat_score      "IAT"
local lab_iadt_score     "IADT"
local lab_icdp_score     "ICDP"
local lab_iaff_score     "IAFF"
local lab_iuof_score_01  "IUOF"
local lab_oqi_score_01   "OQI"
local lab_iurd_score_01  "IURD"
local lab_ietr_score_01  "IETR"
local lab_IPCS           "IPCS"
local lab_IEDF           "IEDF"
local lab_IAER           "IAER"
local lab_ICPF           "ICPF"
local lab_IEH            "IEH"
local lab_IBPD           "IBPD"

local hist_graphs
local box_graphs
local k = 0

foreach v of local cont_available {

    local ++k
    local short "`lab_`v''"
    if "`short'" == "" local short "`v'"

    quietly summarize `v', detail
    local vmin = r(min)
    local vmax = r(max)

    * Histogram.
    capture noisily histogram `v' if !missing(`v'), percent ///
        title("`short'", size(small)) ///
        xtitle("") ///
        ytitle("Percent", size(vsmall)) ///
        xlabel(, labsize(vsmall)) ///
        ylabel(, labsize(vsmall)) ///
        graphregion(color(white)) plotregion(color(white)) ///
        name(hist`k', replace) ///
        scheme(plotplain)

    if !_rc {
        local hist_graphs `hist_graphs' hist`k'
        graph export "${cluster_figures}/dist_hist_`v'.png", replace
    }

    * Kernel density, only if there is enough variation.
    if `vmin' < `vmax' {
        capture noisily kdensity `v' if !missing(`v'), ///
            title("`short'", size(small)) ///
            xtitle("") ///
            ytitle("Density", size(vsmall)) ///
            xlabel(, labsize(vsmall)) ///
            ylabel(, labsize(vsmall)) ///
            graphregion(color(white)) plotregion(color(white)) ///
            name(kden`k', replace) ///
            scheme(plotplain)

        if !_rc {
            graph export "${cluster_figures}/dist_kdensity_`v'.png", replace
        }
    }

    * Boxplot.
    capture noisily graph box `v' if !missing(`v'), ///
        title("`short'", size(small)) ///
        ytitle("") ///
        ylabel(, labsize(vsmall)) ///
        graphregion(color(white)) plotregion(color(white)) ///
        name(box`k', replace) ///
        scheme(plotplain)

    if !_rc {
        local box_graphs `box_graphs' box`k'
        graph export "${cluster_figures}/dist_box_`v'.png", replace
    }
}

* Combined histogram panel for all continuous inputs.
capture graph combine `hist_graphs', ///
    cols(3) ///
    title("Distribution of candidate continuous indices", size(medsmall)) ///
    graphregion(color(white)) ///
    scheme(plotplain)

if !_rc {
    graph export "${cluster_figures}/figC1a_index_histograms.png", replace
}

* Combined standardized boxplot: main distribution diagnostic figure.
preserve

keep `cont_available'
gen long __id = _n

foreach v of local cont_available {
    capture drop zdiag_`v'
    egen zdiag_`v' = std(`v')
}

keep __id zdiag_*
reshape long zdiag_, i(__id) j(index_name) string

gen byte index_order = .
replace index_order = 1  if index_name == "ivs_score"
replace index_order = 2  if index_name == "iat_score"
replace index_order = 3  if index_name == "iadt_score"
replace index_order = 4  if index_name == "icdp_score"
replace index_order = 5  if index_name == "iaff_score"
replace index_order = 6  if index_name == "iuof_score_01"
replace index_order = 7  if index_name == "oqi_score_01"
replace index_order = 8  if index_name == "iurd_score_01"
replace index_order = 9  if index_name == "ietr_score_01"
replace index_order = 10 if index_name == "IPCS"
replace index_order = 11 if index_name == "IEDF"
replace index_order = 12 if index_name == "IAER"
replace index_order = 13 if index_name == "ICPF"
replace index_order = 14 if index_name == "IEH"
replace index_order = 15 if index_name == "IBPD"

label define index_order_lbl ///
    1  "IVS" ///
    2  "IAT" ///
    3  "IADT" ///
    4  "ICDP" ///
    5  "IAFF" ///
    6  "IUOF" ///
    7  "OQI" ///
    8  "IURD" ///
    9  "IETR" ///
    10 "IPCS" ///
    11 "IEDF" ///
    12 "IAER" ///
    13 "ICPF" ///
    14 "IEH" ///
    15 "IBPD", replace

label values index_order index_order_lbl

graph box zdiag_, ///
    over(index_order, label(angle(45) labsize(vsmall))) ///
    yline(0, lcolor(gs8) lpattern(dash)) ///
    ytitle("Standardized value", size(small)) ///
    title("Standardized distributions of candidate clustering inputs", size(medsmall)) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(figC1_index_distributions, replace) ///
    scheme(plotplain)

graph export "${cluster_figures}/figC1_index_distributions.png", replace

restore

*-------------------------------------------------------------------------------*
* 3.2.1 Category frequency plots
*-------------------------------------------------------------------------------*

local cat_plot_graphs
local c = 0

foreach v of local cat_available {

    local ++c
    local short "`lab_`v''"
    if "`short'" == "" local short "`v'"

    preserve

    keep if !missing(`v')

    capture decode `v', gen(__cat_label)
    if _rc {
        tostring `v', gen(__cat_label) usedisplayformat force
    }

    contract __cat_label, freq(__freq)
    sort __cat_label

    graph bar (sum) __freq, ///
        over(__cat_label, label(angle(45) labsize(vsmall))) ///
        title("`v'", size(small)) ///
        ytitle("Frequency", size(vsmall)) ///
        ylabel(, labsize(vsmall)) ///
        graphregion(color(white)) plotregion(color(white)) ///
        name(catbar`c', replace) ///
        scheme(plotplain)

    graph export "${cluster_figures}/cat_distribution_`v'.png", replace

    restore
}

*-------------------------------------------------------------------------------*
* 3.3 Redundancy / local-dependence diagnostics: continuous correlations
*-------------------------------------------------------------------------------*

tempfile corr_long
tempname corrpost

* Add formal_remittance to long pairwise correlations, but not to the heatmap.
local cont_assoc_vars `cont_available' formal_remittance

postfile `corrpost' ///
    str32 var1 ///
    str32 var2 ///
    double N_pair ///
    double correlation ///
    double abs_correlation ///
    byte high_corr_flag ///
    byte theory_flag ///
    str120 flag_reason ///
    using "`corr_long'", replace

local n_cont_assoc : word count `cont_assoc_vars'

forvalues i = 1/`=`n_cont_assoc'-1' {

    local x : word `i' of `cont_assoc_vars'

    forvalues j = `=`i'+1'/`n_cont_assoc' {

        local y : word `j' of `cont_assoc_vars'

        quietly count if !missing(`x', `y')
        local N_pair = r(N)

        local rho = .
        local absrho = .
        local highflag = 0
        local theoryflag = 0
        local reason ""

        if `N_pair' > 2 {
            quietly correlate `x' `y' if !missing(`x', `y')
            matrix __R = r(C)
            local rho = __R[1,2]
            local absrho = abs(`rho')
        }

        if `absrho' >= 0.50 & `absrho' < . {
            local highflag = 1
            local reason "High absolute correlation >= 0.50"
        }

        if ("`x'" == "iat_score"      & "`y'" == "iadt_score") | ///
           ("`x'" == "iadt_score"     & "`y'" == "icdp_score") | ///
           ("`x'" == "oqi_score_01"   & "`y'" == "ietr_score_01") | ///
           ("`x'" == "IEH"            & "`y'" == "IBPD") | ///
           ("`x'" == "iurd_score_01"  & "`y'" == "formal_remittance") {
            local theoryflag = 1
            if "`reason'" == "" {
                local reason "Theory-flagged pair for redundancy/local dependence review"
            }
            else {
                local reason "`reason'; theory-flagged pair"
            }
        }

        post `corrpost' ///
            (`"`x'"') ///
            (`"`y'"') ///
            (`N_pair') ///
            (`rho') ///
            (`absrho') ///
            (`highflag') ///
            (`theoryflag') ///
            (`"`reason'"')
    }
}

postclose `corrpost'

preserve

use "`corr_long'", clear

format N_pair %12.0fc
format correlation abs_correlation %9.3f

gsort -abs_correlation +var1 +var2

export excel using "${cluster_tables}/Table_C4_pairwise_associations.xlsx", ///
    sheet("continuous_correlations_long") firstrow(variables) replace

save "${cluster_data}/CFI_DPI_lca_continuous_correlations.dta", replace

noisily display as text "Continuous pairs flagged for redundancy/local-dependence review:"
list var1 var2 N_pair correlation abs_correlation flag_reason ///
    if high_corr_flag == 1 | theory_flag == 1, noobs abbreviate(32)

restore


*-------------------------------------------------------------------------------*
* 3.3.1 Continuous correlation matrix and heatmap
*-------------------------------------------------------------------------------*

preserve

correlate `cont_available'
matrix C = r(C)

putexcel set "${cluster_tables}/Table_C4_pairwise_associations.xlsx", ///
    sheet("continuous_correlation_matrix", replace) modify
putexcel A1 = matrix(C), names nformat(number_d3)

capture which heatplot

if !_rc {
    capture noisily heatplot C, ///
        values(format(%4.2f) size(vsmall)) ///
        color(hcl, diverging intensity(.7)) ///
        cuts(-1(.20)1) ///
        legend(title("Correlation", size(vsmall)) size(vsmall)) ///
        xlabel(, labsize(vsmall) angle(45)) ///
        ylabel(, labsize(vsmall)) ///
        title("Pairwise correlations across continuous candidate indices", size(medsmall)) ///
        graphregion(color(white)) plotregion(color(white)) ///
        name(figC2_correlation_heatmap, replace) ///
        scheme(plotplain)

    if !_rc {
        graph export "${cluster_figures}/figC2_correlation_heatmap.png", replace
    }
    else {
        noisily display as error "heatplot failed. Exporting fallback graph matrix instead."

        graph matrix `cont_available', half ///
            title("Correlation diagnostic: graph-matrix fallback", size(medsmall)) ///
            graphregion(color(white)) ///
            name(figC2_correlation_heatmap, replace) ///
            scheme(plotplain)

        graph export "${cluster_figures}/figC2_correlation_heatmap.png", replace
    }
}
else {
    noisily display as error "heatplot not installed. Exporting fallback graph matrix instead."

    graph matrix `cont_available', half ///
        title("Correlation diagnostic: graph-matrix fallback", size(medsmall)) ///
        graphregion(color(white)) ///
        name(figC2_correlation_heatmap, replace) ///
        scheme(plotplain)

    graph export "${cluster_figures}/figC2_correlation_heatmap.png", replace
}

restore


*-------------------------------------------------------------------------------*
* 3.3.2 Redundancy / local-dependence diagnostics: categorical Cramer's V
*-------------------------------------------------------------------------------*

tempfile cramer_long
tempname crampost

local cat_assoc_vars `cat_available' formal_remittance

postfile `crampost' ///
    str32 var1 ///
    str32 var2 ///
    double N_pair ///
    double chi2 ///
    double p_value ///
    double n_rows ///
    double n_cols ///
    double cramers_v ///
    byte high_assoc_flag ///
    byte theory_flag ///
    str120 flag_reason ///
    using "`cramer_long'", replace

local n_cat_assoc : word count `cat_assoc_vars'

forvalues i = 1/`=`n_cat_assoc'-1' {

    local x : word `i' of `cat_assoc_vars'

    forvalues j = `=`i'+1'/`n_cat_assoc' {

        local y : word `j' of `cat_assoc_vars'

        quietly count if !missing(`x', `y')
        local N_pair = r(N)

        local chi2 = .
        local pval = .
        local rows = .
        local cols = .
        local cv = .
        local highflag = 0
        local theoryflag = 0
        local reason ""

        if `N_pair' > 2 {
            capture quietly tabulate `x' `y' if !missing(`x', `y'), chi2

            if !_rc {
                local chi2 = r(chi2)
                local pval = r(p)
                local rows = r(r)
                local cols = r(c)

                local mindim = min(`rows' - 1, `cols' - 1)

                if `mindim' > 0 & `N_pair' > 0 {
                    local cv = sqrt(`chi2' / (`N_pair' * `mindim'))
                }
            }
        }

        if `cv' >= 0.30 & `cv' < . {
            local highflag = 1
            local reason "Cramer's V >= 0.30"
        }

        if ("`x'" == "iat_cat"      & "`y'" == "iadt_cat") | ///
           ("`x'" == "iadt_cat"     & "`y'" == "icdp_cat") | ///
           ("`x'" == "oqi_cat"      & "`y'" == "ietr_cat") | ///
           ("`x'" == "IEH_cat"      & "`y'" == "IBPD_cat") | ///
           ("`x'" == "iurd_cat"     & "`y'" == "formal_remittance") {
            local theoryflag = 1
            if "`reason'" == "" {
                local reason "Theory-flagged pair for redundancy/local dependence review"
            }
            else {
                local reason "`reason'; theory-flagged pair"
            }
        }

        post `crampost' ///
            (`"`x'"') ///
            (`"`y'"') ///
            (`N_pair') ///
            (`chi2') ///
            (`pval') ///
            (`rows') ///
            (`cols') ///
            (`cv') ///
            (`highflag') ///
            (`theoryflag') ///
            (`"`reason'"')
    }
}

postclose `crampost'

preserve

use "`cramer_long'", clear

format N_pair n_rows n_cols %12.0fc
format chi2 p_value cramers_v %9.3f

gsort -cramers_v +var1 +var2

export excel using "${cluster_tables}/Table_C4_pairwise_associations.xlsx", ///
    sheet("categorical_cramersv", replace) firstrow(variables)

save "${cluster_data}/CFI_DPI_lca_categorical_cramersv.dta", replace

noisily display as text "Categorical pairs flagged for redundancy/local-dependence review:"
list var1 var2 N_pair cramers_v p_value flag_reason ///
    if high_assoc_flag == 1 | theory_flag == 1, noobs abbreviate(32)

restore


*-------------------------------------------------------------------------------*
* 3.3.3 Consolidated flagged-pair table
*-------------------------------------------------------------------------------*

preserve

use "${cluster_data}/CFI_DPI_lca_continuous_correlations.dta", clear

gen str35 association_type = "Pearson correlation"
gen double association_value = correlation
gen double abs_association_value = abs_correlation
gen byte flagged = high_corr_flag == 1 | theory_flag == 1

keep if flagged == 1

keep association_type var1 var2 N_pair association_value abs_association_value ///
     high_corr_flag theory_flag flag_reason

tempfile flagged_cont
save "`flagged_cont'", replace

use "${cluster_data}/CFI_DPI_lca_categorical_cramersv.dta", clear

gen str35 association_type = "Cramer's V"
gen double association_value = cramers_v
gen double abs_association_value = cramers_v
gen byte flagged = high_assoc_flag == 1 | theory_flag == 1

keep if flagged == 1

rename high_assoc_flag high_corr_flag

keep association_type var1 var2 N_pair association_value abs_association_value ///
     high_corr_flag theory_flag flag_reason

append using "`flagged_cont'"

gsort +association_type -abs_association_value +var1 +var2

format N_pair %12.0fc
format association_value abs_association_value %9.3f

export excel using "${cluster_tables}/Table_C4_pairwise_associations.xlsx", ///
    sheet("flagged_redundancy_pairs", replace) firstrow(variables)

save "${cluster_data}/CFI_DPI_lca_flagged_redundancy_pairs.dta", replace

restore


*-------------------------------------------------------------------------------*
* 3.4 Console summary for methodological decisions
*-------------------------------------------------------------------------------*

noisily display as text "------------------------------------------------------------"
noisily display as text "Section 3 outputs created:"
noisily display as result "1. ${cluster_tables}/Table_C2_missingness_unique_values.xlsx"
noisily display as result "2. ${cluster_tables}/Table_C3_category_distributions.xlsx"
noisily display as result "3. ${cluster_tables}/Table_C4_pairwise_associations.xlsx"
noisily display as result "4. ${cluster_figures}/figC1_index_distributions.png"
noisily display as result "5. ${cluster_figures}/figC2_correlation_heatmap.png"
noisily display as text "------------------------------------------------------------"

noisily display as text "Next step after reviewing outputs:"
noisily display as text "Use these diagnostics to decide final LCA-safe inputs, including:"
noisily display as text "- whether sparse categories should be collapsed;"
noisily display as text "- whether ceiling-heavy indicators should be profile variables instead of LCA inputs;"
noisily display as text "- whether locally dependent pairs should be excluded or moved to sensitivity models."
noisily display as text "------------------------------------------------------------"

}
*-----------------------------------------------*
*		4. CONSTRUCT LCA-READY VARIABLES		*
*-----------------------------------------------*
{
/*
    Purpose:
    Create clean, theoretically interpretable categorical variables for LCA.

    General coding rules:
    - Binary variables for gsem logit remain coded 0/1.
    - Ordinal variables for gsem ologit are coded 1=low, 2=medium, 3=high.
    - Nominal variables for gsem mlogit should have clean integer categories.
    - Sparse categories are collapsed before entering preferred LCA models.
    - Variables used for profiling / validation are prepared but not forced into
      the preferred class-defining model.

    Main outputs:
    - Table_C5_LCA_variable_recoding.xlsx
    - CFI_DPI_lca_ready_variables.dta
*/

*-------------------------------------------------------------------------------*
* 4.0 Load verified cluster-analysis base sample
*-------------------------------------------------------------------------------*

use "${cluster_data}/CFI_DPI_cluster_base_sample.dta", clear

count
local N_cluster = r(N)

noisily display as text "------------------------------------------------------------"
noisily display as text "Section 4: Construct LCA-ready variables"
noisily display as text "Current cluster-analysis base sample N = `N_cluster'"
noisily display as text "------------------------------------------------------------"

set more off
set seed 6427961
graph set window fontface "Times New Roman"

capture mkdir "${cluster_tables}"
capture mkdir "${cluster_figures}"
capture mkdir "${cluster_data}"
capture mkdir "${cluster_models}"

*-------------------------------------------------------------------------------*
* 4.1 Define value labels for clean LCA variables
*-------------------------------------------------------------------------------*

label define lca_ivs_lbl ///
    1 "Low vulnerability" ///
    2 "Medium vulnerability" ///
    3 "High vulnerability", replace

label define lca_iat3_lbl ///
    1 "Low digital access" ///
    2 "Medium digital access" ///
    3 "High digital access", replace

label define lca_iat2_lbl ///
    0 "Low/medium digital access" ///
    1 "High digital access", replace

label define lca_iadt3_lbl ///
    1 "Low digital self-efficacy" ///
    2 "Medium digital self-efficacy" ///
    3 "High digital self-efficacy", replace

label define lca_iadt2_lbl ///
    0 "Low/medium digital self-efficacy" ///
    1 "High digital self-efficacy", replace

label define lca_icdp_lbl ///
    1 "Low practical digital competence" ///
    2 "Medium practical digital competence" ///
    3 "High practical digital competence", replace

label define lca_iaff_lbl ///
    1 "Low formal financial access" ///
    2 "Medium formal financial access" ///
    3 "High formal financial access", replace

label define lca_iuof_lbl ///
    1 "Low financial operability" ///
    2 "Medium financial operability" ///
    3 "High financial operability", replace

label define lca_oqi_lbl ///
    1 "High onboarding friction" ///
    2 "Medium onboarding quality" ///
    3 "Good onboarding / low friction", replace

label define lca_iurd_lbl ///
    1 "Low digital-remittance intensity" ///
    2 "Medium digital-remittance intensity" ///
    3 "High digital-remittance intensity", replace

label define lca_ietr3_lbl ///
    1 "Poor transactional experience" ///
    2 "Regular transactional experience" ///
    3 "Good transactional experience", replace

label define lca_ietr2_lbl ///
    0 "Poor/regular transactional experience" ///
    1 "Good transactional experience", replace

label define lca_ipcs_lbl ///
    1 "Low safe-conduct/prevention" ///
    2 "Medium safe-conduct/prevention" ///
    3 "High safe-conduct/prevention", replace

label define lca_iedf3_lbl ///
    1 "Low fraud harm / recourse failure" ///
    2 "Medium fraud harm / recourse failure" ///
    3 "High fraud harm / recourse failure", replace

label define lca_iedf2_lbl ///
    0 "Low/no fraud harm or recourse failure" ///
    1 "Medium/high fraud harm or recourse failure", replace

label define lca_iaer3_lbl ///
    1 "Low autonomy" ///
    2 "Medium autonomy" ///
    3 "High autonomy", replace

label define lca_iaer2_lbl ///
    0 "Low/medium autonomy" ///
    1 "High autonomy", replace

label define lca_icpf3_lbl ///
    1 "Low trust/relational climate" ///
    2 "Medium trust/relational climate" ///
    3 "High trust/relational climate", replace

label define lca_icpf2_lbl ///
    0 "Low/medium trust climate" ///
    1 "High trust climate", replace

label define lca_ieh_lbl ///
    1 "Low enabling environment" ///
    2 "Medium enabling environment" ///
    3 "High enabling environment", replace

label define lca_ibpd_lbl ///
    1 "Low perceived barriers" ///
    2 "Medium perceived barriers" ///
    3 "High perceived barriers", replace

label define lca_yesno_lbl ///
    0 "No" ///
    1 "Yes", replace

label define lca_formal_remit_lbl ///
    0 "Cash pickup / traveler" ///
    1 "Bank transfer / wallet-app", replace

*-------------------------------------------------------------------------------*
* 4.2 Core LCA-ready transformations
*-------------------------------------------------------------------------------*

*-----------------------------*
* Socioeconomic vulnerability *
*-----------------------------*

capture drop lca_ivs3
gen byte lca_ivs3 = .
replace lca_ivs3 = ivs_cat if inrange(ivs_cat, 1, 3)
label values lca_ivs3 lca_ivs_lbl
label var lca_ivs3 "LCA: Socioeconomic vulnerability, 3 levels"

*-----------------------------*
* Telecommunications access   *
*-----------------------------*

capture drop lca_iat3
gen byte lca_iat3 = .
replace lca_iat3 = iat_cat if inrange(iat_cat, 1, 3)
label values lca_iat3 lca_iat3_lbl
label var lca_iat3 "LCA: Digital access, 3 levels"

capture drop lca_iat2
gen byte lca_iat2 = .
replace lca_iat2 = 0 if inlist(iat_cat, 1, 2)
replace lca_iat2 = 1 if iat_cat == 3
label values lca_iat2 lca_iat2_lbl
label var lca_iat2 "LCA: High digital access, binary"


*-----------------------------*
* Digital self-efficacy       *
* Sensitivity / profile input *
*-----------------------------*

capture drop lca_iadt3
gen byte lca_iadt3 = .
replace lca_iadt3 = iadt_cat if inrange(iadt_cat, 1, 3)
label values lca_iadt3 lca_iadt3_lbl
label var lca_iadt3 "LCA sensitivity: Digital self-efficacy, 3 levels"

capture drop lca_iadt2
gen byte lca_iadt2 = .
replace lca_iadt2 = 0 if inlist(iadt_cat, 1, 2)
replace lca_iadt2 = 1 if iadt_cat == 3
label values lca_iadt2 lca_iadt2_lbl
label var lca_iadt2 "LCA sensitivity: High digital self-efficacy, binary"

*-----------------------------*
* Practical digital competence*
*-----------------------------*

capture drop lca_icdp3
gen byte lca_icdp3 = .
replace lca_icdp3 = icdp_cat if inrange(icdp_cat, 1, 3)
label values lca_icdp3 lca_icdp_lbl
label var lca_icdp3 "LCA: Practical digital competence, 3 levels"


*-----------------------------*
* Formal financial access     *
*-----------------------------*

capture drop lca_iaff3
gen byte lca_iaff3 = .
replace lca_iaff3 = iaff_cat if inrange(iaff_cat, 1, 3)
label values lca_iaff3 lca_iaff_lbl
label var lca_iaff3 "LCA: Formal financial access, 3 levels"


*-----------------------------*
* Financial operability       *
* Recreated from continuous   *
*-----------------------------*

capture drop lca_iuof3
gen byte lca_iuof3 = .
replace lca_iuof3 = 1 if iuof_score_01 < 0.50
replace lca_iuof3 = 2 if iuof_score_01 >= 0.50 & iuof_score_01 < 0.80
replace lca_iuof3 = 3 if iuof_score_01 >= 0.80 & iuof_score_01 < .
label values lca_iuof3 lca_iuof_lbl
label var lca_iuof3 "LCA sensitivity/profile: Financial operability, threshold 3 levels"

capture drop lca_iuof3_q
xtile lca_iuof3_q = iuof_score_01, nq(3)
label values lca_iuof3_q lca_iuof_lbl
label var lca_iuof3_q "LCA sensitivity: Financial operability, tercile 3 levels"


*-----------------------------*
* Onboarding quality          *
*-----------------------------*

capture drop lca_oqi3
gen byte lca_oqi3 = .
replace lca_oqi3 = oqi_cat if inrange(oqi_cat, 1, 3)
label values lca_oqi3 lca_oqi_lbl
label var lca_oqi3 "LCA: Onboarding quality, 3 levels"


*-----------------------------*
* Digital remittance intensity*
*-----------------------------*

capture drop lca_iurd3
gen byte lca_iurd3 = .
replace lca_iurd3 = iurd_cat if inrange(iurd_cat, 1, 3)
label values lca_iurd3 lca_iurd_lbl
label var lca_iurd3 "LCA: Digital remittance/payment intensity, 3 levels"


*-----------------------------*
* Transactional experience    *
*-----------------------------*

capture drop lca_ietr3
gen byte lca_ietr3 = .
replace lca_ietr3 = ietr_cat if inrange(ietr_cat, 1, 3)
label values lca_ietr3 lca_ietr3_lbl
label var lca_ietr3 "LCA sensitivity/profile: Transactional experience, 3 levels"

capture drop lca_ietr2
gen byte lca_ietr2 = .
replace lca_ietr2 = 0 if inlist(ietr_cat, 1, 2)
replace lca_ietr2 = 1 if ietr_cat == 3
label values lca_ietr2 lca_ietr2_lbl
label var lca_ietr2 "LCA sensitivity/profile: Good transactional experience, binary"


*-----------------------------*
* Safe conduct / prevention   *
*-----------------------------*

capture drop lca_ipcs3
gen byte lca_ipcs3 = .
replace lca_ipcs3 = IPCS_cat if inrange(IPCS_cat, 1, 3)
label values lca_ipcs3 lca_ipcs_lbl
label var lca_ipcs3 "LCA sensitivity/profile: Safe conduct and prevention, 3 levels"


*-----------------------------*
* Fraud harm / recourse       *
*-----------------------------*

capture drop lca_iedf3
gen byte lca_iedf3 = .
replace lca_iedf3 = IEDF_cat if inrange(IEDF_cat, 1, 3)
label values lca_iedf3 lca_iedf3_lbl
label var lca_iedf3 "LCA sensitivity/profile: Fraud harm and recourse failure, 3 levels"

capture drop lca_iedf2
gen byte lca_iedf2 = .
replace lca_iedf2 = 0 if IEDF_cat == 1
replace lca_iedf2 = 1 if inlist(IEDF_cat, 2, 3)
label values lca_iedf2 lca_iedf2_lbl
label var lca_iedf2 "LCA: Medium/high fraud harm or recourse failure, binary"


*-----------------------------*
* Autonomy                    *
* Profile / sensitivity only  *
*-----------------------------*

capture drop lca_iaer3
gen byte lca_iaer3 = .
replace lca_iaer3 = IAER_cat if inrange(IAER_cat, 1, 3)
label values lca_iaer3 lca_iaer3_lbl
label var lca_iaer3 "LCA profile/sensitivity: Autonomy, 3 levels"

capture drop lca_iaer2
gen byte lca_iaer2 = .
replace lca_iaer2 = 0 if inlist(IAER_cat, 1, 2)
replace lca_iaer2 = 1 if IAER_cat == 3
label values lca_iaer2 lca_iaer2_lbl
label var lca_iaer2 "LCA profile/sensitivity: High autonomy, binary"


*-----------------------------*
* Trust and relational climate*
*-----------------------------*

capture drop lca_icpf3
gen byte lca_icpf3 = .
replace lca_icpf3 = ICPF_cat if inrange(ICPF_cat, 1, 3)
label values lca_icpf3 lca_icpf3_lbl
label var lca_icpf3 "LCA sensitivity: Trust and relational climate, 3 levels"

capture drop lca_icpf2
gen byte lca_icpf2 = .
replace lca_icpf2 = 0 if inlist(ICPF_cat, 1, 2)
replace lca_icpf2 = 1 if ICPF_cat == 3
label values lca_icpf2 lca_icpf2_lbl
label var lca_icpf2 "LCA: High trust and relational climate, binary"


*-----------------------------*
* Enabling environment        *
*-----------------------------*

capture drop lca_ieh3
gen byte lca_ieh3 = .
replace lca_ieh3 = IEH_cat if inrange(IEH_cat, 1, 3)
label values lca_ieh3 lca_ieh_lbl
label var lca_ieh3 "LCA: Enabling environment, 3 levels"


*-----------------------------*
* Perceived barriers          *
* Sensitivity / profile input *
*-----------------------------*

capture drop lca_ibpd3
gen byte lca_ibpd3 = .
replace lca_ibpd3 = IBPD_cat if inrange(IBPD_cat, 1, 3)
label values lca_ibpd3 lca_ibpd_lbl
label var lca_ibpd3 "LCA sensitivity/profile: Perceived barriers, 3 levels"

*-------------------------------------------------------------------------------*
* 4.3 Auxiliary profile and validation variables
*-------------------------------------------------------------------------------*

* Formal remittance channel, regenerated here to make this section self-contained.
capture drop formal_remittance
gen byte formal_remittance = .
replace formal_remittance = 1 if inlist(q6_4, 1, 2)
replace formal_remittance = 0 if inlist(q6_4, 3, 4)
label values formal_remittance lca_formal_remit_lbl
label var formal_remittance "Profile: Latest remittance through formal digital channel"

* Clean remittance channel profile variable.
capture drop remit_channel_profile
gen byte remit_channel_profile = .
replace remit_channel_profile = q6_4 if inrange(q6_4, 1, 5)
label values remit_channel_profile q6_4
label var remit_channel_profile "Profile: Latest remittance channel, original valid categories"

* Recent digital transaction use.
capture drop recent_digital_txn
gen byte recent_digital_txn = .
replace recent_digital_txn = 1 if q6_14 == 1
replace recent_digital_txn = 0 if q6_14 == 0
label values recent_digital_txn lca_yesno_lbl
label var recent_digital_txn "Profile: Used digital payments/remittances in last 60 days"

* QR use in the last 30 days.
capture drop any_qr_use
gen byte any_qr_use = .
replace any_qr_use = 1 if inlist(q5_4, 1, 2, 3)
replace any_qr_use = 0 if q5_4 == 4
label values any_qr_use lca_yesno_lbl
label var any_qr_use "Profile: Used QR to pay or receive in last 30 days"

* Any payment/remittance problem.
capture drop any_problem
gen byte any_problem = .
replace any_problem = 1 if q7_11 == 1
replace any_problem = 0 if q7_11 == 2
label values any_problem lca_yesno_lbl
label var any_problem "Profile: Had at least one payment/remittance problem"

* Avoided digital use due to household conflict.
capture drop avoided_due_conflict
gen byte avoided_due_conflict = .
replace avoided_due_conflict = 1 if q9_20 == 1
replace avoided_due_conflict = 0 if q9_20 == 0
label values avoided_due_conflict lca_yesno_lbl
label var avoided_due_conflict "Profile: Avoided digital payments due to household conflict"

* Any training on digital payments/remittances/security in last 3 years.
capture drop any_training_3y
gen byte any_training_3y = .
replace any_training_3y = 1 if inlist(q10_10, 1, 2)
replace any_training_3y = 0 if q10_10 == 3
label values any_training_3y lca_yesno_lbl
label var any_training_3y "Profile: Any training in last 3 years"

* Training in last 12 months.
capture drop recent_training_12m
gen byte recent_training_12m = .
replace recent_training_12m = 1 if q10_10 == 1
replace recent_training_12m = 0 if inlist(q10_10, 2, 3)
label values recent_training_12m lca_yesno_lbl
label var recent_training_12m "Profile: Training in last 12 months"

* Individual support for digital payments/remittances.
capture drop individual_support
gen byte individual_support = .
replace individual_support = 1 if q10_13 == 1
replace individual_support = 0 if q10_13 == 0
label values individual_support lca_yesno_lbl
label var individual_support "Profile: Received individual support for digital payments/remittances"

* Bre-B awareness and usage, if variables exist.
capture drop aware_breb
capture confirm numeric variable q5_1_1
if !_rc {
    gen byte aware_breb = .
    replace aware_breb = 1 if q5_1_1 == 1
    replace aware_breb = 0 if q5_1_1 == 0
}
else {
    gen byte aware_breb = .
}
label values aware_breb lca_yesno_lbl
label var aware_breb "Profile: Aware of Bre-B"

capture drop used_breb
capture confirm numeric variable q5_2_1
if !_rc {
    gen byte used_breb = .
    replace used_breb = 1 if q5_2_1 == 1
    replace used_breb = 0 if q5_2_1 == 0
}
else {
    gen byte used_breb = .
}
label values used_breb lca_yesno_lbl
label var used_breb "Profile: Used Bre-B in last 60 days"

* Any payment rail usage.
local rail_use_vars
foreach v in q5_2_1 q5_2_2 q5_2_3 q5_2_4 q5_2_5 {
    capture confirm numeric variable `v'
    if !_rc {
        local rail_use_vars `rail_use_vars' `v'
    }
}

capture drop rails_used_count any_rail_use
if "`rail_use_vars'" != "" {
    egen rails_used_count = rowtotal(`rail_use_vars')
    gen byte any_rail_use = (rails_used_count > 0) if !missing(rails_used_count)
}
else {
    gen rails_used_count = .
    gen byte any_rail_use = .
}
label values any_rail_use lca_yesno_lbl
label var rails_used_count "Profile: Count of named payment rails used"
label var any_rail_use "Profile: Used at least one named payment rail"


*-------------------------------------------------------------------------------*
* 4.4 Define preferred, alternative, sensitivity, and profile variable lists
*-------------------------------------------------------------------------------*

/*
    Preferred class-defining variables:
    This list reflects the diagnostic decision to avoid overloading the model with
    locally dependent variables such as IURD + formal_remittance, OQI + IETR,
    IEH + IBPD, or ICDP + IADT + IPCS simultaneously.
*/

local lca_main_preferred ///
    lca_ivs3 ///
    lca_iat2 ///
    lca_icdp3 ///
    lca_iaff3 ///
    lca_oqi3 ///
    lca_iurd3 ///
    lca_iedf2 ///
    lca_icpf2 ///
    lca_ieh3

local lca_expanded_candidates ///
    lca_iat3 ///
    lca_iadt2 ///
    lca_iadt3 ///
    lca_iuof3 ///
    lca_iuof3_q ///
    lca_ietr2 ///
    lca_ietr3 ///
    lca_ipcs3 ///
    lca_iedf3 ///
    lca_iaer2 ///
    lca_iaer3 ///
    lca_icpf3 ///
    lca_ibpd3

local profile_validation_vars ///
    formal_remittance ///
    remit_channel_profile ///
    recent_digital_txn ///
    any_qr_use ///
    any_problem ///
    avoided_due_conflict ///
    any_training_3y ///
    recent_training_12m ///
    individual_support ///
    aware_breb ///
    used_breb ///
    any_rail_use ///
    rails_used_count

local lca_all_recoded ///
    `lca_main_preferred' ///
    `lca_expanded_candidates' ///
    `profile_validation_vars'


*-------------------------------------------------------------------------------*
* 4.5 Validate recoded variables
*-------------------------------------------------------------------------------*

* Check that preferred LCA inputs are complete.
capture drop lca_main_missing_count lca_main_complete
egen lca_main_missing_count = rowmiss(`lca_main_preferred')
gen byte lca_main_complete = (lca_main_missing_count == 0)
label var lca_main_missing_count "Number of missing preferred LCA inputs"
label var lca_main_complete "Complete data on preferred LCA inputs"

count if lca_main_complete == 1
local N_lca_main_complete = r(N)

count if lca_main_complete == 0
local N_lca_main_incomplete = r(N)

noisily display as text "Preferred LCA complete-case N = `N_lca_main_complete'"
noisily display as text "Preferred LCA incomplete-case N = `N_lca_main_incomplete'"

* Verify no 98/99 values remain in preferred LCA variables.
foreach v of local lca_main_preferred {
    quietly count if inlist(`v', 98, 99)
    if r(N) > 0 {
        noisily display as error "WARNING: `v' still contains 98/99 values. N = " r(N)
    }
}

* Console frequency checks.
noisily display as text "------------------------------------------------------------"
noisily display as text "Preferred LCA input distributions:"
noisily display as text "------------------------------------------------------------"

foreach v of local lca_main_preferred {
    noisily display as text "Variable: `v'"
    tab `v', missing
}


*-------------------------------------------------------------------------------*
* 4.6 Create recoding metadata table
*-------------------------------------------------------------------------------*

tempfile recoding_metadata
tempname recpost

postfile `recpost' ///
    str36 lca_variable ///
    str36 source_variable ///
    str60 construct ///
    str36 variable_type ///
    str36 planned_role ///
    str220 coding_rule ///
    str220 methodological_note ///
    using "`recoding_metadata'", replace

post `recpost' (`"lca_ivs3"') (`"ivs_cat"') (`"Socioeconomic vulnerability"') (`"Ordinal 1-3"') (`"Preferred main LCA"') ///
    (`"Keeps original IVS categories: 1 low, 2 medium, 3 high vulnerability"') ///
    (`"Retained because it captures structural socioeconomic constraints with acceptable variation"')

post `recpost' (`"lca_iat2"') (`"iat_cat"') (`"Telecommunications access"') (`"Binary 0/1"') (`"Preferred main LCA"') ///
    (`"Collapses low and medium access into 0; high access coded 1"') ///
    (`"Preferred because the low digital access category is sparse"')

post `recpost' (`"lca_iat3"') (`"iat_cat"') (`"Telecommunications access"') (`"Ordinal 1-3"') (`"Sensitivity"') ///
    (`"Keeps original IAT categories: 1 low, 2 medium, 3 high"') ///
    (`"Used to test whether the binary collapse hides meaningful variation"')

post `recpost' (`"lca_iadt2"') (`"iadt_cat"') (`"Digital self-efficacy"') (`"Binary 0/1"') (`"Sensitivity/profile"') ///
    (`"Collapses low and medium self-efficacy into 0; high self-efficacy coded 1"') ///
    (`"Not preferred in main LCA because it is ceiling-heavy and overlaps with ICDP"')

post `recpost' (`"lca_iadt3"') (`"iadt_cat"') (`"Digital self-efficacy"') (`"Ordinal 1-3"') (`"Sensitivity/profile"') ///
    (`"Keeps original IADT categories: 1 low, 2 medium, 3 high"') ///
    (`"Low category is sparse; mainly retained for diagnostics and sensitivity"')

post `recpost' (`"lca_icdp3"') (`"icdp_cat"') (`"Practical digital competence"') (`"Ordinal 1-3"') (`"Preferred main LCA"') ///
    (`"Keeps original ICDP categories: 1 low, 2 medium, 3 high competence"') ///
    (`"Core capability construct; stronger behavioral meaning than self-efficacy alone"')

post `recpost' (`"lca_iaff3"') (`"iaff_cat"') (`"Formal financial access"') (`"Ordinal 1-3"') (`"Preferred main LCA"') ///
    (`"Keeps original IAFF categories: 1 low, 2 medium, 3 high formal access"') ///
    (`"Core formalization gateway construct"')

post `recpost' (`"lca_iuof3"') (`"iuof_score_01"') (`"Financial operability"') (`"Ordinal 1-3"') (`"Sensitivity/profile"') ///
    (`"Recreated using thresholds: <0.50 low, 0.50-0.79 medium, >=0.80 high"') ///
    (`"Important outcome-like construct but locally dependent with ICDP, OQI, and IPCS"')

post `recpost' (`"lca_iuof3_q"') (`"iuof_score_01"') (`"Financial operability"') (`"Ordinal 1-3"') (`"Sensitivity"') ///
    (`"Recreated using terciles of IUOF distribution"') ///
    (`"Used only to test sensitivity to threshold-based categorization"')

post `recpost' (`"lca_oqi3"') (`"oqi_cat"') (`"Onboarding quality"') (`"Ordinal 1-3"') (`"Preferred main LCA"') ///
    (`"Keeps original OQI categories: 1 high friction, 2 medium, 3 good onboarding"') ///
    (`"Core DPI design construct capturing entry friction and transparency"')

post `recpost' (`"lca_iurd3"') (`"iurd_cat"') (`"Digital remittance/payment intensity"') (`"Ordinal 1-3"') (`"Preferred main LCA"') ///
    (`"Keeps original IURD categories: 1 low, 2 medium, 3 high intensity"') ///
    (`"Core behavioral construct; formal_remittance excluded from main LCA to avoid overlap"')

post `recpost' (`"lca_ietr2"') (`"ietr_cat"') (`"Transactional experience"') (`"Binary 0/1"') (`"Sensitivity/profile"') ///
    (`"Collapses poor and regular experience into 0; good experience coded 1"') ///
    (`"Preferred over 3-level version if included because poor-experience category is sparse"')

post `recpost' (`"lca_ietr3"') (`"ietr_cat"') (`"Transactional experience"') (`"Ordinal 1-3"') (`"Sensitivity/profile"') ///
    (`"Keeps original IETR categories: 1 poor, 2 regular, 3 good experience"') ///
    (`"Not preferred in main LCA because it overlaps with OQI and has sparse low category"')

post `recpost' (`"lca_ipcs3"') (`"IPCS_cat"') (`"Safe conduct and prevention"') (`"Ordinal 1-3"') (`"Sensitivity/profile"') ///
    (`"Keeps original IPCS categories: 1 low, 2 medium, 3 high safe conduct"') ///
    (`"Important safety construct but locally dependent with ICDP and IUOF"')

post `recpost' (`"lca_iedf2"') (`"IEDF_cat"') (`"Fraud harm and recourse failure"') (`"Binary 0/1"') (`"Preferred main LCA"') ///
    (`"Collapses medium and high harm into 1; low/no harm coded 0"') ///
    (`"Preferred because high-harm category is extremely sparse"')

post `recpost' (`"lca_iedf3"') (`"IEDF_cat"') (`"Fraud harm and recourse failure"') (`"Ordinal 1-3"') (`"Sensitivity/profile"') ///
    (`"Keeps original IEDF categories: 1 low, 2 medium, 3 high harm"') ///
    (`"Retained only for diagnostics because high category is sparse"')

post `recpost' (`"lca_iaer2"') (`"IAER_cat"') (`"Autonomy"') (`"Binary 0/1"') (`"Profile/sensitivity"') ///
    (`"Collapses low and medium autonomy into 0; high autonomy coded 1"') ///
    (`"Autonomy is ceiling-heavy; better treated as profile outcome than main class-defining input"')

post `recpost' (`"lca_iaer3"') (`"IAER_cat"') (`"Autonomy"') (`"Ordinal 1-3"') (`"Profile/sensitivity"') ///
    (`"Keeps original IAER categories: 1 low, 2 medium, 3 high autonomy"') ///
    (`"Low category is extremely sparse; not recommended for preferred LCA"')

post `recpost' (`"lca_icpf2"') (`"ICPF_cat"') (`"Trust and relational climate"') (`"Binary 0/1"') (`"Preferred main LCA"') ///
    (`"Collapses low and medium trust climate into 0; high trust climate coded 1"') ///
    (`"Preferred because the low trust category is sparse"')

post `recpost' (`"lca_icpf3"') (`"ICPF_cat"') (`"Trust and relational climate"') (`"Ordinal 1-3"') (`"Sensitivity"') ///
    (`"Keeps original ICPF categories: 1 low, 2 medium, 3 high climate"') ///
    (`"Used to test sensitivity to binary collapse"')

post `recpost' (`"lca_ieh3"') (`"IEH_cat"') (`"Enabling environment"') (`"Ordinal 1-3"') (`"Preferred main LCA"') ///
    (`"Keeps original IEH categories: 1 low, 2 medium, 3 high enabling environment"') ///
    (`"Preferred external-support construct; IBPD excluded from main model due inverse overlap"')

post `recpost' (`"lca_ibpd3"') (`"IBPD_cat"') (`"Perceived barriers"') (`"Ordinal 1-3"') (`"Sensitivity/profile"') ///
    (`"Keeps original IBPD categories: 1 low, 2 medium, 3 high barriers"') ///
    (`"Alternative to IEH in sensitivity models; not used together in preferred LCA"')

post `recpost' (`"formal_remittance"') (`"q6_4"') (`"Formal remittance channel"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Bank transfer or wallet/app coded 1; cash pickup or traveler coded 0; other coded missing"') ///
    (`"Excluded from main LCA because it strongly overlaps with IURD"')

post `recpost' (`"remit_channel_profile"') (`"q6_4"') (`"Remittance channel"') (`"Nominal"') (`"Profile/validation"') ///
    (`"Keeps valid latest-remittance channel categories 1 to 5"') ///
    (`"Used for descriptive interpretation of final classes"')

post `recpost' (`"recent_digital_txn"') (`"q6_14"') (`"Recent digital use"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Yes coded 1; No coded 0; prefer not to respond coded missing"') ///
    (`"Highly skewed, so retained as profiling variable"')

post `recpost' (`"any_qr_use"') (`"q5_4"') (`"QR use"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Any QR payment or receipt coded 1; no QR use coded 0"') ///
    (`"Useful behavioral profile variable"')

post `recpost' (`"any_problem"') (`"q7_11"') (`"Payment/remittance problem"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Had problem coded 1; no problem coded 0; DK coded missing"') ///
    (`"Used to validate risk/recourse class interpretation"')

post `recpost' (`"avoided_due_conflict"') (`"q9_20"') (`"Household conflict and digital use"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Avoided digital use due to conflict coded 1; otherwise coded 0; prefer not coded missing"') ///
    (`"Used to connect final profiles to household autonomy constraints"')

post `recpost' (`"any_training_3y"') (`"q10_10"') (`"Training exposure"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Any training in last 3 years coded 1; never coded 0; DK coded missing"') ///
    (`"Used to profile exposure to support and programs"')

post `recpost' (`"recent_training_12m"') (`"q10_10"') (`"Recent training exposure"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Training in last 12 months coded 1; older or never coded 0; DK coded missing"') ///
    (`"Used to distinguish recent from older program exposure"')

post `recpost' (`"individual_support"') (`"q10_13"') (`"Individual support"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Received individual support coded 1; no support coded 0; prefer not coded missing"') ///
    (`"Useful for interpreting support-dependent profiles"')

post `recpost' (`"aware_breb"') (`"q5_1_1"') (`"Bre-B awareness"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Aware of Bre-B coded 1; otherwise coded 0"') ///
    (`"Likely sparse; retained for profiling only"')

post `recpost' (`"used_breb"') (`"q5_2_1"') (`"Bre-B use"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Used Bre-B coded 1; otherwise coded 0"') ///
    (`"Likely sparse; retained for profiling only"')

post `recpost' (`"any_rail_use"') (`"q5_2_1-q5_2_5"') (`"Payment rail use"') (`"Binary 0/1"') (`"Profile/validation"') ///
    (`"Used at least one named payment rail coded 1; otherwise coded 0"') ///
    (`"Used to profile actual rails engagement outside the class-defining model"')

postclose `recpost'


*-------------------------------------------------------------------------------*
* 4.7 Create category distribution table for recoded variables
*-------------------------------------------------------------------------------*

tempfile recoded_distribution
tempname distpost

postfile `distpost' ///
    str36 variable ///
    str140 variable_label ///
    str36 planned_role ///
    double category_value ///
    str160 category_label ///
    double frequency ///
    double percent ///
    double cumulative_percent ///
    byte sparse_flag ///
    str60 diagnostic_flag ///
    using "`recoded_distribution'", replace

foreach v of local lca_all_recoded {

    capture confirm variable `v'
    if !_rc {

        local vlab : variable label `v'
        if `"`vlab'"' == "" local vlab "(no variable label)"

        local role "Profile/validation"
        if strpos(" `lca_main_preferred' ", " `v' ") > 0 local role "Preferred main LCA"
        if strpos(" `lca_expanded_candidates' ", " `v' ") > 0 local role "Sensitivity/profile"

        quietly count if !missing(`v')
        local N_valid = r(N)

        local cumulative = 0

        capture quietly levelsof `v' if !missing(`v'), local(levels)
        if !_rc & `N_valid' > 0 {

            local vallab : value label `v'

            foreach level of local levels {

                quietly count if `v' == `level'
                local freq = r(N)
                local pct = 100 * `freq' / `N_valid'
                local cumulative = `cumulative' + `pct'

                local level_label ""
                if "`vallab'" != "" {
                    capture local level_label : label `vallab' `level'
                }
                if `"`level_label'"' == "" local level_label "`level'"

                local sparse = 0
                local flag "OK"

                if `freq' < 20 | `pct' < 5 {
                    local sparse = 1
                    local flag "SPARSE_CATEGORY"
                }

                post `distpost' ///
                    (`"`v'"') ///
                    (`"`vlab'"') ///
                    (`"`role'"') ///
                    (`level') ///
                    (`"`level_label'"') ///
                    (`freq') ///
                    (`pct') ///
                    (`cumulative') ///
                    (`sparse') ///
                    (`"`flag'"')
            }
        }
    }
}

postclose `distpost'


*-------------------------------------------------------------------------------*
* 4.8 Export recoding audit workbook
*-------------------------------------------------------------------------------*

preserve

use "`recoding_metadata'", clear
sort planned_role construct lca_variable

export excel using "${cluster_tables}/Table_C5_LCA_variable_recoding.xlsx", ///
    sheet("recoding_metadata", replace) firstrow(variables)

save "${cluster_data}/CFI_DPI_lca_recoding_metadata.dta", replace

restore


preserve

use "`recoded_distribution'", clear

format frequency %12.0fc
format percent cumulative_percent %9.2f

sort planned_role variable category_value

export excel using "${cluster_tables}/Table_C5_LCA_variable_recoding.xlsx", ///
    sheet("recoded_distributions", replace) firstrow(variables)

save "${cluster_data}/CFI_DPI_lca_recoded_distributions.dta", replace

noisily display as text "Sparse categories in recoded LCA/profile variables:"
list variable planned_role category_value category_label frequency percent diagnostic_flag ///
    if sparse_flag == 1, noobs abbreviate(32)

restore


*-------------------------------------------------------------------------------*
* 4.9 Create complete-case indicators for alternative model families
*-------------------------------------------------------------------------------*

* Preferred main LCA complete case.
capture drop lca_preferred_missing_count lca_preferred_complete
egen lca_preferred_missing_count = rowmiss(`lca_main_preferred')
gen byte lca_preferred_complete = (lca_preferred_missing_count == 0)
label var lca_preferred_missing_count "Missing count: preferred LCA inputs"
label var lca_preferred_complete "Complete case: preferred LCA inputs"

* Expanded candidate complete case.
capture drop lca_expanded_missing_count lca_expanded_complete
egen lca_expanded_missing_count = rowmiss(`lca_main_preferred' lca_iuof3 lca_ietr2 lca_ipcs3 lca_ibpd3)
gen byte lca_expanded_complete = (lca_expanded_missing_count == 0)
label var lca_expanded_missing_count "Missing count: preferred + expanded candidate LCA inputs"
label var lca_expanded_complete "Complete case: preferred + expanded candidate LCA inputs"

* Sensitivity model with 3-level IAT and 3-level ICPF.
capture drop lca_alt3_missing_count lca_alt3_complete
egen lca_alt3_missing_count = rowmiss(lca_ivs3 lca_iat3 lca_icdp3 lca_iaff3 ///
                                      lca_oqi3 lca_iurd3 lca_iedf2 ///
                                      lca_icpf3 lca_ieh3)
gen byte lca_alt3_complete = (lca_alt3_missing_count == 0)
label var lca_alt3_missing_count "Missing count: alternative 3-level IAT/ICPF LCA inputs"
label var lca_alt3_complete "Complete case: alternative 3-level IAT/ICPF LCA inputs"

noisily display as text "------------------------------------------------------------"
noisily display as text "Complete-case counts for future LCA estimation:"
noisily display as text "------------------------------------------------------------"

count if lca_preferred_complete == 1
noisily display as result "Preferred main LCA complete N = " r(N)

count if lca_expanded_complete == 1
noisily display as result "Expanded candidate LCA complete N = " r(N)

count if lca_alt3_complete == 1
noisily display as result "Alternative 3-level IAT/ICPF LCA complete N = " r(N)

noisily display as text "------------------------------------------------------------"


*-------------------------------------------------------------------------------*
* 4.10 Store preferred variable lists as dataset characteristics
*-------------------------------------------------------------------------------*

char _dta[lca_main_preferred] "`lca_main_preferred'"
char _dta[lca_expanded_candidates] "`lca_expanded_candidates'"
char _dta[lca_profile_validation_vars] "`profile_validation_vars'"

notes _dta: Preferred main LCA variables are stored in characteristic lca_main_preferred.
notes _dta: Expanded candidate variables are stored in characteristic lca_expanded_candidates.
notes _dta: Profile and validation variables are stored in characteristic lca_profile_validation_vars.
notes _dta: Binary variables are intentionally coded 0/1 for gsem logit.
notes _dta: Ordinal variables are coded 1=low, 2=medium, 3=high unless otherwise labeled.


*-------------------------------------------------------------------------------*
* 4.11 Save LCA-ready dataset
*-------------------------------------------------------------------------------*

compress

save "${cluster_data}/CFI_DPI_lca_ready_variables.dta", replace

noisily display as text "------------------------------------------------------------"
noisily display as text "Section 4 outputs created:"
noisily display as result "1. ${cluster_tables}/Table_C5_LCA_variable_recoding.xlsx"
noisily display as result "2. ${cluster_data}/CFI_DPI_lca_ready_variables.dta"
noisily display as result "3. ${cluster_data}/CFI_DPI_lca_recoding_metadata.dta"
noisily display as result "4. ${cluster_data}/CFI_DPI_lca_recoded_distributions.dta"
noisily display as text "------------------------------------------------------------"

noisily display as text "Next step after reviewing outputs:"
noisily display as text "- Confirm preferred LCA variables and sparse-category diagnostics."
noisily display as text "- Estimate candidate LCA solutions for k = 2 to 7 classes using gsem."
noisily display as text "- Compare fit, entropy-like classification quality, class sizes, and interpretability."
noisily display as text "------------------------------------------------------------"

}
*-------------------------------------------------------------------------------*
*		5. DEFINE COMPETING FEATURE SETS FOR LCA AND BENCHMARK CLUSTERING		*
*-------------------------------------------------------------------------------*
{

*-------------------------------------------------------------------------------*
* Optional profile collapses for cleaner post-LCA interpretation
*-------------------------------------------------------------------------------*

* Collapsed remittance channel: bank, wallet/app, cash pickup, other/nonstandard
capture drop remit_channel_4cat
gen byte remit_channel_4cat = .
replace remit_channel_4cat = 1 if q6_4 == 1
replace remit_channel_4cat = 2 if q6_4 == 2
replace remit_channel_4cat = 3 if q6_4 == 3
replace remit_channel_4cat = 4 if inlist(q6_4, 4, 5)

label define remit_channel_4cat_lbl ///
    1 "Bank transfer" ///
    2 "Wallet/app" ///
    3 "Cash pickup" ///
    4 "Traveler/other", replace

label values remit_channel_4cat remit_channel_4cat_lbl
label var remit_channel_4cat "Profile: Latest remittance channel, collapsed 4-category"


* Collapsed count of named payment rails used: 0, 1, 2, 3+
capture drop rails_used_count_3plus
gen byte rails_used_count_3plus = .
replace rails_used_count_3plus = rails_used_count if inlist(rails_used_count, 0, 1, 2)
replace rails_used_count_3plus = 3 if rails_used_count >= 3 & rails_used_count < .

label define rails_used_count_3plus_lbl ///
    0 "0 rails" ///
    1 "1 rail" ///
    2 "2 rails" ///
    3 "3+ rails", replace

label values rails_used_count_3plus rails_used_count_3plus_lbl
label var rails_used_count_3plus "Profile: Number of named payment rails used, collapsed"


/*
    Purpose:
    Define multiple theoretically motivated feature sets for the segmentation
    analysis before estimating latent class models.

    This section does NOT estimate the LCA models yet. It prepares and documents:
    - Core categorical-index LCA feature sets
    - Expanded categorical-index LCA feature sets
    - Reduced high-stability LCA feature sets
    - Direct-item LCA sensitivity feature set
    - Continuous-index benchmark clustering feature sets

    Main outputs:
    - Table_C6_LCA_feature_sets.xlsx
    - CFI_DPI_lca_feature_set_overview.dta
    - CFI_DPI_lca_feature_set_variables.dta
    - CFI_DPI_lca_feature_set_diagnostics.dta
    - Updated CFI_DPI_lca_ready_variables.dta with feature-set characteristics
*/

*-------------------------------------------------------------------------------*
* 5.0 Load LCA-ready dataset
*-------------------------------------------------------------------------------*

use "${cluster_data}/CFI_DPI_lca_ready_variables.dta", clear

count
local N_cluster = r(N)

noisily display as text "------------------------------------------------------------"
noisily display as text "Section 5: Define competing feature sets"
noisily display as text "Current LCA-ready sample N = `N_cluster'"
noisily display as text "------------------------------------------------------------"

set more off
set seed 6427961
graph set window fontface "Times New Roman"

capture mkdir "${cluster_tables}"
capture mkdir "${cluster_figures}"
capture mkdir "${cluster_data}"
capture mkdir "${cluster_models}"


*-------------------------------------------------------------------------------*
* 5.1 Ensure optional collapsed profile variables exist
*-------------------------------------------------------------------------------*

* Collapsed remittance channel: bank, wallet/app, cash pickup, traveler/other
capture confirm variable remit_channel_4cat
if _rc {
    capture drop remit_channel_4cat
    gen byte remit_channel_4cat = .
    replace remit_channel_4cat = 1 if q6_4 == 1
    replace remit_channel_4cat = 2 if q6_4 == 2
    replace remit_channel_4cat = 3 if q6_4 == 3
    replace remit_channel_4cat = 4 if inlist(q6_4, 4, 5)

    label define remit_channel_4cat_lbl ///
        1 "Bank transfer" ///
        2 "Wallet/app" ///
        3 "Cash pickup" ///
        4 "Traveler/other", replace

    label values remit_channel_4cat remit_channel_4cat_lbl
    label var remit_channel_4cat "Profile: Latest remittance channel, collapsed 4-category"
}

* Collapsed count of named payment rails used: 0, 1, 2, 3+
capture confirm variable rails_used_count_3plus
if _rc {
    capture confirm variable rails_used_count
    if !_rc {
        capture drop rails_used_count_3plus
        gen byte rails_used_count_3plus = .
        replace rails_used_count_3plus = rails_used_count if inlist(rails_used_count, 0, 1, 2)
        replace rails_used_count_3plus = 3 if rails_used_count >= 3 & rails_used_count < .

        label define rails_used_count_3plus_lbl ///
            0 "0 rails" ///
            1 "1 rail" ///
            2 "2 rails" ///
            3 "3+ rails", replace

        label values rails_used_count_3plus rails_used_count_3plus_lbl
        label var rails_used_count_3plus "Profile: Number of named payment rails used, collapsed"
    }
}


*-------------------------------------------------------------------------------*
* 5.2 Construct direct-item LCA sensitivity variables
*-------------------------------------------------------------------------------*

/*
    These variables are NOT used in the preferred model. They provide a
    sensitivity check based on raw survey behaviors rather than constructed
    indices. They are intentionally parsimonious and avoid including multiple
    items from the same index whenever possible.
*/

label define lca_di_yesno_lbl ///
    0 "No" ///
    1 "Yes", replace

label define lca_di_account_freq3_lbl ///
    1 "Low/no use" ///
    2 "Weekly or more" ///
    3 "Daily use", replace

label define lca_di_recourse3_lbl ///
    1 "No problem reported" ///
    2 "Problem resolved/managed" ///
    3 "Problem unresolved/negative recourse", replace

* Smartphone ownership
capture drop lca_di_smartphone
gen byte lca_di_smartphone = .
replace lca_di_smartphone = 1 if q3_1 == 1
replace lca_di_smartphone = 0 if inlist(q3_1, 2, 3)
label values lca_di_smartphone lca_di_yesno_lbl
label var lca_di_smartphone "Direct-item LCA: Owns smartphone"

* Stable data / connectivity
capture drop lca_di_data_stable
gen byte lca_di_data_stable = .
replace lca_di_data_stable = 1 if inlist(q3_7, 1, 2) & q3_8 == 3
replace lca_di_data_stable = 0 if inlist(q3_8, 1, 2, 99) | q3_7 == 3 | q3_1 == 3
label values lca_di_data_stable lca_di_yesno_lbl
label var lca_di_data_stable "Direct-item LCA: Stable mobile data for digital use"

* Any QR use in last 30 days
capture drop lca_di_qr_use
gen byte lca_di_qr_use = .
capture confirm variable any_qr_use
if !_rc {
    replace lca_di_qr_use = any_qr_use if inlist(any_qr_use, 0, 1)
}
else {
    replace lca_di_qr_use = 1 if inlist(q5_4, 1, 2, 3)
    replace lca_di_qr_use = 0 if q5_4 == 4
}
label values lca_di_qr_use lca_di_yesno_lbl
label var lca_di_qr_use "Direct-item LCA: Used QR to pay or receive"

* Formal/nonstandard remittance channel.
* For direct-item LCA, "other" is treated as non-formal/nonstandard to avoid listwise loss.
capture drop lca_di_formal_remit
gen byte lca_di_formal_remit = .
replace lca_di_formal_remit = 1 if inlist(q6_4, 1, 2)
replace lca_di_formal_remit = 0 if inlist(q6_4, 3, 4, 5)
label values lca_di_formal_remit lca_di_yesno_lbl
label var lca_di_formal_remit "Direct-item LCA: Latest remittance via bank transfer or wallet/app"

* Wallet ownership
capture drop lca_di_wallet_owner
gen byte lca_di_wallet_owner = .
replace lca_di_wallet_owner = 1 if q4_12_2 == 1
replace lca_di_wallet_owner = 0 if q4_12_2 == 0
label values lca_di_wallet_owner lca_di_yesno_lbl
label var lca_di_wallet_owner "Direct-item LCA: Owns digital wallet"

* Any formal account or wallet ownership
capture drop lca_di_any_account
gen byte lca_di_any_account = .
replace lca_di_any_account = 1 if q4_12_1 == 1 | q4_12_2 == 1 | q4_12_3 == 1 | q4_12_4 == 1
replace lca_di_any_account = 0 if q4_12_1 == 0 & q4_12_2 == 0 & q4_12_3 == 0 & q4_12_4 == 0
label values lca_di_any_account lca_di_yesno_lbl
label var lca_di_any_account "Direct-item LCA: Owns any formal account or wallet"

* Account/wallet use frequency, 3 levels
capture drop lca_di_account_freq3
gen byte lca_di_account_freq3 = .
replace lca_di_account_freq3 = 3 if q4_15 == 1
replace lca_di_account_freq3 = 2 if inlist(q4_15, 2, 3)
replace lca_di_account_freq3 = 1 if inlist(q4_15, 4, 5)
label values lca_di_account_freq3 lca_di_account_freq3_lbl
label var lca_di_account_freq3 "Direct-item LCA: Account/wallet use frequency, 3 levels"

* Needed help during onboarding
capture drop lca_di_onboard_help
gen byte lca_di_onboard_help = .
replace lca_di_onboard_help = 1 if q5_16 == 1
replace lca_di_onboard_help = 0 if q5_16 == 0
label values lca_di_onboard_help lca_di_yesno_lbl
label var lca_di_onboard_help "Direct-item LCA: Needed help during account/wallet registration"

* Fee visibility in last digital operation
capture drop lca_di_fee_clear
gen byte lca_di_fee_clear = .
replace lca_di_fee_clear = 1 if inlist(q6_18, 1, 4)
replace lca_di_fee_clear = 0 if inlist(q6_18, 2, 3)
label values lca_di_fee_clear lca_di_yesno_lbl
label var lca_di_fee_clear "Direct-item LCA: Fee clearly shown or no fee applied"

* Personal fraud attempt exposure
capture drop lca_di_fraud_attempt
gen byte lca_di_fraud_attempt = .
replace lca_di_fraud_attempt = 1 if inlist(q7_1, 1, 2)
replace lca_di_fraud_attempt = 0 if inlist(q7_1, 3, 4)
label values lca_di_fraud_attempt lca_di_yesno_lbl
label var lca_di_fraud_attempt "Direct-item LCA: Personal exposure to suspicious fraud attempt"

* Problem and recourse status
capture drop lca_di_recourse3
gen byte lca_di_recourse3 = .
replace lca_di_recourse3 = 1 if q7_11 == 2

* Problem resolved or relatively well managed.
replace lca_di_recourse3 = 2 if q7_11 == 1 & ///
    (q7_14 == 1 | inlist(q7_15, 3, 4, 5))

* Problem unresolved, partial, in process, or negative satisfaction.
replace lca_di_recourse3 = 3 if q7_11 == 1 & ///
    (inlist(q7_14, 2, 3, 4) | inlist(q7_15, 1, 2))

label values lca_di_recourse3 lca_di_recourse3_lbl
label var lca_di_recourse3 "Direct-item LCA: Payment/remittance problem and recourse status"

* Avoided digital use due to household conflict
capture drop lca_di_conflict_avoid
gen byte lca_di_conflict_avoid = .
capture confirm variable avoided_due_conflict
if !_rc {
    replace lca_di_conflict_avoid = avoided_due_conflict if inlist(avoided_due_conflict, 0, 1)
}
else {
    replace lca_di_conflict_avoid = 1 if q9_20 == 1
    replace lca_di_conflict_avoid = 0 if q9_20 == 0
}
label values lca_di_conflict_avoid lca_di_yesno_lbl
label var lca_di_conflict_avoid "Direct-item LCA: Avoided digital payments due to household conflict"

* Trust in provider
capture drop lca_di_provider_trust
gen byte lca_di_provider_trust = .
replace lca_di_provider_trust = 1 if inlist(q9_1, 4, 5)
replace lca_di_provider_trust = 0 if inlist(q9_1, 1, 2, 3)
label values lca_di_provider_trust lca_di_yesno_lbl
label var lca_di_provider_trust "Direct-item LCA: Trusts provider to keep money safe"


*-------------------------------------------------------------------------------*
* 5.3 Construct standardized continuous variables for benchmark clustering
*-------------------------------------------------------------------------------*

/*
    These variables are for sensitivity checks only:
    - k-means on standardized continuous indices
    - hierarchical clustering on standardized continuous indices

    They are NOT the preferred model because the primary segmentation strategy
    uses mixed-response categorical LCA.
*/

local benchmark_raw ///
    ivs_score ///
    iat_score ///
    iadt_score ///
    icdp_score ///
    iaff_score ///
    iuof_score_01 ///
    oqi_score_01 ///
    iurd_score_01 ///
    ietr_score_01 ///
    IPCS ///
    IEDF ///
    IAER ///
    ICPF ///
    IEH ///
    IBPD

local benchmark_z_all

foreach v of local benchmark_raw {

    capture confirm numeric variable `v'
    if !_rc {
        capture drop zcl_`v'
        egen zcl_`v' = std(`v')
        label var zcl_`v' "Benchmark standardized: `v'"
        local benchmark_z_all `benchmark_z_all' zcl_`v'
    }
}

local benchmark_z_reduced ///
    zcl_ivs_score ///
    zcl_icdp_score ///
    zcl_iaff_score ///
    zcl_iuof_score_01 ///
    zcl_oqi_score_01 ///
    zcl_iurd_score_01 ///
    zcl_IEDF ///
    zcl_ICPF ///
    zcl_IEH


*-------------------------------------------------------------------------------*
* 5.4 Define competing categorical LCA feature sets
*-------------------------------------------------------------------------------*

/*
    Internal feature-set IDs are intentionally short because Stata local macro
    names have length limits. The exported labels remain fully descriptive.
*/

* Reconstruct benchmark locals in case this section is re-run after an error.
local benchmark_z_all
foreach v in ///
    zcl_ivs_score ///
    zcl_iat_score ///
    zcl_iadt_score ///
    zcl_icdp_score ///
    zcl_iaff_score ///
    zcl_iuof_score_01 ///
    zcl_oqi_score_01 ///
    zcl_iurd_score_01 ///
    zcl_ietr_score_01 ///
    zcl_IPCS ///
    zcl_IEDF ///
    zcl_IAER ///
    zcl_ICPF ///
    zcl_IEH ///
    zcl_IBPD {

    capture confirm variable `v'
    if !_rc local benchmark_z_all `benchmark_z_all' `v'
}

local benchmark_z_reduced
foreach v in ///
    zcl_ivs_score ///
    zcl_icdp_score ///
    zcl_iaff_score ///
    zcl_iuof_score_01 ///
    zcl_oqi_score_01 ///
    zcl_iurd_score_01 ///
    zcl_IEDF ///
    zcl_ICPF ///
    zcl_IEH {

    capture confirm variable `v'
    if !_rc local benchmark_z_reduced `benchmark_z_reduced' `v'
}


* Model Set A: Core categorical-index LCA
local fs_A1_core ///
    lca_ivs3 ///
    lca_iat2 ///
    lca_icdp3 ///
    lca_iaff3 ///
    lca_iuof3 ///
    lca_oqi3 ///
    lca_iurd3 ///
    lca_ipcs3 ///
    lca_iedf2 ///
    lca_icpf2 ///
    lca_ieh3

local fs_A2_core ///
    lca_ivs3 ///
    lca_iat3 ///
    lca_icdp3 ///
    lca_iaff3 ///
    lca_iuof3 ///
    lca_oqi3 ///
    lca_iurd3 ///
    lca_ipcs3 ///
    lca_iedf2 ///
    lca_icpf3 ///
    lca_ieh3


* Model Set B: Expanded categorical-index LCA
local fs_B1_exp ///
    `fs_A1_core' ///
    lca_iadt2 ///
    lca_ietr2 ///
    lca_ibpd3

local fs_B2_expauto ///
    `fs_B1_exp' ///
    lca_iaer2


* Model Set C: Reduced high-stability LCA
local fs_C1_reduced ///
    lca_ivs3 ///
    lca_icdp3 ///
    lca_iaff3 ///
    lca_iuof3 ///
    lca_oqi3 ///
    lca_iurd3 ///
    lca_iedf2 ///
    lca_icpf2 ///
    lca_ieh3

local fs_C2_parsim ///
    lca_ivs3 ///
    lca_iat2 ///
    lca_icdp3 ///
    lca_iaff3 ///
    lca_oqi3 ///
    lca_iurd3 ///
    lca_iedf2 ///
    lca_icpf2 ///
    lca_ieh3


* Model Set D: Direct-item LCA sensitivity
local fs_D1_direct ///
    lca_di_smartphone ///
    lca_di_data_stable ///
    lca_di_qr_use ///
    lca_di_formal_remit ///
    lca_di_wallet_owner ///
    lca_di_account_freq3 ///
    lca_di_onboard_help ///
    lca_di_fee_clear ///
    lca_di_fraud_attempt ///
    lca_di_recourse3 ///
    lca_di_conflict_avoid ///
    lca_di_provider_trust


* Model Set E: Benchmark non-LCA clustering
local fs_E1_benchfull ///
    `benchmark_z_all'

local fs_E2_benchred ///
    `benchmark_z_reduced'


*-------------------------------------------------------------------------------*
* 5.5 Define response families for future gsem estimation
*-------------------------------------------------------------------------------*

local fam_lca_ivs3                 "ologit"
local fam_lca_iat2                 "logit"
local fam_lca_iat3                 "ologit"
local fam_lca_iadt2                "logit"
local fam_lca_iadt3                "ologit"
local fam_lca_icdp3                "ologit"
local fam_lca_iaff3                "ologit"
local fam_lca_iuof3                "ologit"
local fam_lca_iuof3_q              "ologit"
local fam_lca_oqi3                 "ologit"
local fam_lca_iurd3                "ologit"
local fam_lca_ietr2                "logit"
local fam_lca_ietr3                "ologit"
local fam_lca_ipcs3                "ologit"
local fam_lca_iedf2                "logit"
local fam_lca_iedf3                "ologit"
local fam_lca_iaer2                "logit"
local fam_lca_iaer3                "ologit"
local fam_lca_icpf2                "logit"
local fam_lca_icpf3                "ologit"
local fam_lca_ieh3                 "ologit"
local fam_lca_ibpd3                "ologit"

local fam_lca_di_smartphone        "logit"
local fam_lca_di_data_stable       "logit"
local fam_lca_di_qr_use            "logit"
local fam_lca_di_formal_remit      "logit"
local fam_lca_di_wallet_owner      "logit"
local fam_lca_di_any_account       "logit"
local fam_lca_di_account_freq3     "ologit"
local fam_lca_di_onboard_help      "logit"
local fam_lca_di_fee_clear         "logit"
local fam_lca_di_fraud_attempt     "logit"
local fam_lca_di_recourse3         "ologit"
local fam_lca_di_conflict_avoid    "logit"
local fam_lca_di_provider_trust    "logit"


*-------------------------------------------------------------------------------*
* 5.6 Define feature-set registry
*-------------------------------------------------------------------------------*

local feature_sets ///
    A1_core ///
    A2_core ///
    B1_exp ///
    B2_expauto ///
    C1_reduced ///
    C2_parsim ///
    D1_direct ///
    E1_benchfull ///
    E2_benchred

local name_A1_core       "Model Set A1: Core categorical-index LCA, balanced"
local name_A2_core       "Model Set A2: Core categorical-index LCA, richer 3-level access/trust"
local name_B1_exp        "Model Set B1: Expanded categorical-index LCA, no autonomy"
local name_B2_expauto    "Model Set B2: Expanded categorical-index LCA, with autonomy"
local name_C1_reduced    "Model Set C1: Reduced high-stability LCA"
local name_C2_parsim     "Model Set C2: Reduced LCA, lower redundancy"
local name_D1_direct     "Model Set D1: Direct-item LCA sensitivity"
local name_E1_benchfull  "Model Set E1: Benchmark continuous-index clustering, full"
local name_E2_benchred   "Model Set E2: Benchmark continuous-index clustering, reduced"

local type_A1_core       "LCA categorical-index"
local type_A2_core       "LCA categorical-index"
local type_B1_exp        "LCA categorical-index expanded"
local type_B2_expauto    "LCA categorical-index expanded"
local type_C1_reduced    "LCA categorical-index reduced"
local type_C2_parsim     "LCA categorical-index reduced"
local type_D1_direct     "LCA direct-item sensitivity"
local type_E1_benchfull  "Benchmark continuous clustering"
local type_E2_benchred   "Benchmark continuous clustering"

local priority_A1_core       "Main candidate"
local priority_A2_core       "Sensitivity"
local priority_B1_exp        "Sensitivity"
local priority_B2_expauto    "Sensitivity"
local priority_C1_reduced    "Fallback/main comparison"
local priority_C2_parsim     "Parsimonious diagnostic"
local priority_D1_direct     "Sensitivity"
local priority_E1_benchfull  "Benchmark only"
local priority_E2_benchred   "Benchmark only"

local rationale_A1_core ///
    "Main candidate covering vulnerability, access, competence, formal access/use, onboarding, use intensity, safety, trust, and support using stable categorical indicators."

local rationale_A2_core ///
    "Tests whether richer 3-level digital access and trust variables alter the segmentation despite sparse low categories."

local rationale_B1_exp ///
    "Tests whether self-efficacy, transactional experience, and perceived barriers add segmentation value beyond core constructs."

local rationale_B2_expauto ///
    "Adds high autonomy as a sensitivity input to test whether household agency becomes class-defining."

local rationale_C1_reduced ///
    "Reduced high-stability model preserving major dimensions while avoiding the most sparse expanded variables."

local rationale_C2_parsim ///
    "Parsimonious version that removes IUOF and IPCS to reduce overlap with competence, onboarding, and intensity constructs."

local rationale_D1_direct ///
    "Sensitivity model based on selected raw survey behaviors rather than constructed indices."

local rationale_E1_benchfull ///
    "Benchmark k-means/hierarchical feature set using all standardized continuous indices."

local rationale_E2_benchred ///
    "Benchmark k-means/hierarchical feature set using a reduced set of standardized continuous indices aligned with the preferred dimensions."

local risk_A1_core ///
    "Includes IUOF and IPCS, which may partially overlap with ICDP, OQI, and IURD; check fit and interpretability."

local risk_A2_core ///
    "3-level IAT and ICPF include sparse low categories; may create unstable class-response probabilities."

local risk_B1_exp ///
    "Higher dimensionality and local dependence risk, especially OQI-IETR and IEH-IBPD."

local risk_B2_expauto ///
    "Adds autonomy, which is ceiling-heavy; may overfit or create weakly separated classes."

local risk_C1_reduced ///
    "More stable but may still include some local dependence through IUOF and IPCS."

local risk_C2_parsim ///
    "Most parsimonious; may omit useful operational and prevention variation."

local risk_D1_direct ///
    "May have more item-level missingness and stronger dependence among raw behavioral indicators."

local risk_E1_benchfull ///
    "Not LCA; sensitive to scaling, outliers, and Euclidean distance assumptions."

local risk_E2_benchred ///
    "Not LCA; useful only as segmentation robustness benchmark."


*-------------------------------------------------------------------------------*
* 5.7 Build feature-set overview table
*-------------------------------------------------------------------------------*

tempfile feature_overview
tempname overviewpost

postfile `overviewpost' ///
    str24 feature_set_id ///
    str120 feature_set_name ///
    str60 model_type ///
    str40 priority ///
    double n_variables ///
    double N_complete ///
    double pct_complete ///
    str300 rationale ///
    str300 main_risk ///
    using "`feature_overview'", replace

foreach fs of local feature_sets {

    local vars `fs_`fs''
    local nvars : word count `vars'

    capture drop __fs_miss
    egen __fs_miss = rowmiss(`vars')

    quietly count if __fs_miss == 0
    local N_complete = r(N)
    local pct_complete = 100 * `N_complete' / _N

    post `overviewpost' ///
        (`"`fs'"') ///
        (`"`name_`fs''"') ///
        (`"`type_`fs''"') ///
        (`"`priority_`fs''"') ///
        (`nvars') ///
        (`N_complete') ///
        (`pct_complete') ///
        (`"`rationale_`fs''"') ///
        (`"`risk_`fs''"')
}

postclose `overviewpost'

preserve
use "`feature_overview'", clear
format n_variables N_complete %12.0fc
format pct_complete %9.2f

export excel using "${cluster_tables}/Table_C6_LCA_feature_sets.xlsx", ///
    sheet("feature_sets_overview", replace) firstrow(variables)

save "${cluster_data}/CFI_DPI_lca_feature_set_overview.dta", replace
restore


*-------------------------------------------------------------------------------*
* 5.8 Build feature-set variable membership and diagnostics table
*-------------------------------------------------------------------------------*

tempfile feature_variables
tempname varpost

postfile `varpost' ///
    str24 feature_set_id ///
    str120 feature_set_name ///
    str60 model_type ///
    str40 priority ///
    str36 variable ///
    str160 variable_label ///
    str20 response_family ///
    double N_nonmissing ///
    double pct_nonmissing ///
    double n_levels ///
    double min_category_n ///
    double min_category_pct ///
    byte sparse_category_flag ///
    str120 diagnostic_note ///
    using "`feature_variables'", replace

foreach fs of local feature_sets {

    local vars `fs_`fs''

    foreach v of local vars {

        capture confirm variable `v'

        if !_rc {

            local vlab : variable label `v'
            if `"`vlab'"' == "" local vlab "(no variable label)"

            local response_family "continuous"
            capture local response_family "`fam_`v''"
            if "`response_family'" == "" local response_family "continuous"

            quietly count if !missing(`v')
            local N_nonmissing = r(N)
            local pct_nonmissing = 100 * `N_nonmissing' / _N

            local n_levels = .
            local min_category_n = .
            local min_category_pct = .
            local sparse_flag = 0
            local diag "OK"

            if "`response_family'" != "continuous" {

                capture quietly levelsof `v' if !missing(`v'), local(levels)

                if !_rc {
                    local n_levels : word count `levels'

                    foreach lev of local levels {
                        quietly count if `v' == `lev'
                        local f = r(N)
                        local p = 100 * `f' / `N_nonmissing'

                        if missing(`min_category_n') | `f' < `min_category_n' {
                            local min_category_n = `f'
                            local min_category_pct = `p'
                        }
                    }

                    if `min_category_n' < 20 | `min_category_pct' < 5 {
                        local sparse_flag = 1
                        local diag "Sparse category: review before preferred use"
                    }
                }
            }

            post `varpost' ///
                (`"`fs'"') ///
                (`"`name_`fs''"') ///
                (`"`type_`fs''"') ///
                (`"`priority_`fs''"') ///
                (`"`v'"') ///
                (`"`vlab'"') ///
                (`"`response_family'"') ///
                (`N_nonmissing') ///
                (`pct_nonmissing') ///
                (`n_levels') ///
                (`min_category_n') ///
                (`min_category_pct') ///
                (`sparse_flag') ///
                (`"`diag'"')
        }

        else {
            post `varpost' ///
                (`"`fs'"') ///
                (`"`name_`fs''"') ///
                (`"`type_`fs''"') ///
                (`"`priority_`fs''"') ///
                (`"`v'"') ///
                (`"VARIABLE NOT FOUND"') ///
                (`"unknown"') ///
                (.) ///
                (.) ///
                (.) ///
                (.) ///
                (.) ///
                (1) ///
                (`"Variable not found in LCA-ready dataset"')
        }
    }
}

postclose `varpost'

preserve
use "`feature_variables'", clear
format N_nonmissing min_category_n %12.0fc
format pct_nonmissing min_category_pct %9.2f
sort feature_set_id variable

export excel using "${cluster_tables}/Table_C6_LCA_feature_sets.xlsx", ///
    sheet("feature_set_variables", replace) firstrow(variables)

save "${cluster_data}/CFI_DPI_lca_feature_set_variables.dta", replace
restore


*-------------------------------------------------------------------------------*
* 5.9 Build compact feature-set diagnostics table
*-------------------------------------------------------------------------------*

tempfile feature_diagnostics
tempname diagpost

postfile `diagpost' ///
    str24 feature_set_id ///
    str120 feature_set_name ///
    str60 model_type ///
    str40 priority ///
    double n_variables ///
    double N_complete ///
    double pct_complete ///
    double n_sparse_variables ///
    double pct_sparse_variables ///
    double n_binary ///
    double n_ordinal ///
    double n_continuous ///
    str240 recommended_use ///
    using "`feature_diagnostics'", replace

foreach fs of local feature_sets {

    local vars `fs_`fs''
    local nvars : word count `vars'

    capture drop __fs_miss
    egen __fs_miss = rowmiss(`vars')

    quietly count if __fs_miss == 0
    local N_complete = r(N)
    local pct_complete = 100 * `N_complete' / _N

    local n_sparse = 0
    local n_binary = 0
    local n_ordinal = 0
    local n_continuous = 0

    foreach v of local vars {

        capture confirm variable `v'

        if !_rc {

            local response_family "continuous"
            capture local response_family "`fam_`v''"
            if "`response_family'" == "" local response_family "continuous"

            if "`response_family'" == "logit" {
                local n_binary = `n_binary' + 1
            }
            else if "`response_family'" == "ologit" {
                local n_ordinal = `n_ordinal' + 1
            }
            else {
                local n_continuous = `n_continuous' + 1
            }

            if "`response_family'" != "continuous" {

                local minf = .
                capture quietly levelsof `v' if !missing(`v'), local(levels)

                if !_rc {
                    foreach lev of local levels {
                        quietly count if `v' == `lev'
                        local f = r(N)

                        if missing(`minf') | `f' < `minf' {
                            local minf = `f'
                        }
                    }

                    if `minf' < 20 {
                        local n_sparse = `n_sparse' + 1
                    }
                }
            }
        }

        else {
            local n_sparse = `n_sparse' + 1
        }
    }

    local pct_sparse = 100 * `n_sparse' / `nvars'

    local recommended_use "Estimate and compare"
    if "`fs'" == "A1_core"      local recommended_use "Primary candidate for k-search"
    if "`fs'" == "A2_core"      local recommended_use "Sensitivity: richer but sparse 3-level access/trust"
    if "`fs'" == "B1_exp"       local recommended_use "Sensitivity: expanded dimensionality and redundancy check"
    if "`fs'" == "B2_expauto"   local recommended_use "Sensitivity: expanded model with autonomy"
    if "`fs'" == "C1_reduced"   local recommended_use "Fallback/main comparison if A models overfit"
    if "`fs'" == "C2_parsim"    local recommended_use "Parsimonious diagnostic for local-dependence concerns"
    if "`fs'" == "D1_direct"    local recommended_use "Direct-item sensitivity only"
    if "`fs'" == "E1_benchfull" local recommended_use "Non-LCA benchmark only"
    if "`fs'" == "E2_benchred"  local recommended_use "Non-LCA benchmark only"

    post `diagpost' ///
        (`"`fs'"') ///
        (`"`name_`fs''"') ///
        (`"`type_`fs''"') ///
        (`"`priority_`fs''"') ///
        (`nvars') ///
        (`N_complete') ///
        (`pct_complete') ///
        (`n_sparse') ///
        (`pct_sparse') ///
        (`n_binary') ///
        (`n_ordinal') ///
        (`n_continuous') ///
        (`"`recommended_use'"')
}

postclose `diagpost'

preserve
use "`feature_diagnostics'", clear
format n_variables N_complete n_sparse_variables n_binary n_ordinal n_continuous %12.0fc
format pct_complete pct_sparse_variables %9.2f

export excel using "${cluster_tables}/Table_C6_LCA_feature_sets.xlsx", ///
    sheet("feature_set_diagnostics", replace) firstrow(variables)

save "${cluster_data}/CFI_DPI_lca_feature_set_diagnostics.dta", replace
restore


*-------------------------------------------------------------------------------*
* 5.10 Store feature-set lists as dataset characteristics
*-------------------------------------------------------------------------------*

char _dta[fs_A1_core]      "`fs_A1_core'"
char _dta[fs_A2_core]      "`fs_A2_core'"
char _dta[fs_B1_exp]       "`fs_B1_exp'"
char _dta[fs_B2_expauto]   "`fs_B2_expauto'"
char _dta[fs_C1_reduced]   "`fs_C1_reduced'"
char _dta[fs_C2_parsim]    "`fs_C2_parsim'"
char _dta[fs_D1_direct]    "`fs_D1_direct'"
char _dta[fs_E1_benchfull] "`fs_E1_benchfull'"
char _dta[fs_E2_benchred]  "`fs_E2_benchred'"

char _dta[feature_sets] "`feature_sets'"

notes _dta: Section 5 defines competing LCA and benchmark clustering feature sets.
notes _dta: A1_core is the primary categorical-index LCA candidate.
notes _dta: C1_reduced and C2_parsim are fallback or comparison models.
notes _dta: D1_direct is the direct-item LCA sensitivity model.
notes _dta: E1_benchfull and E2_benchred are non-LCA benchmark clustering feature sets.


*-------------------------------------------------------------------------------*
* 5.11 Console summary for review
*-------------------------------------------------------------------------------*

noisily display as text "------------------------------------------------------------"
noisily display as text "Feature-set complete-case diagnostics"
noisily display as text "------------------------------------------------------------"

preserve
use "${cluster_data}/CFI_DPI_lca_feature_set_diagnostics.dta", clear
list feature_set_id priority n_variables N_complete pct_complete ///
     n_sparse_variables n_binary n_ordinal n_continuous recommended_use, ///
     noobs abbreviate(32)
restore

noisily display as text "------------------------------------------------------------"
noisily display as text "Sparse-variable diagnostics by feature set"
noisily display as text "------------------------------------------------------------"

preserve
use "${cluster_data}/CFI_DPI_lca_feature_set_variables.dta", clear
list feature_set_id variable response_family N_nonmissing n_levels ///
     min_category_n min_category_pct diagnostic_note ///
     if sparse_category_flag == 1, noobs abbreviate(32)
restore


*-------------------------------------------------------------------------------*
* 5.12 Save updated LCA-ready dataset
*-------------------------------------------------------------------------------*

compress
save "${cluster_data}/CFI_DPI_lca_ready_variables.dta", replace

noisily display as text "------------------------------------------------------------"
noisily display as text "Section 5 outputs created:"
noisily display as result "1. ${cluster_tables}/Table_C6_LCA_feature_sets.xlsx"
noisily display as result "2. ${cluster_data}/CFI_DPI_lca_feature_set_overview.dta"
noisily display as result "3. ${cluster_data}/CFI_DPI_lca_feature_set_variables.dta"
noisily display as result "4. ${cluster_data}/CFI_DPI_lca_feature_set_diagnostics.dta"
noisily display as result "5. Updated ${cluster_data}/CFI_DPI_lca_ready_variables.dta"
noisily display as text "------------------------------------------------------------"
	
	
}
*---------------------------------------------------------------------------*
*		6. LCA AND BENCHMARK CLUSTERING: STABLE SEGMENTATION WORKFLOW		*
*---------------------------------------------------------------------------*
{
/*
    Purpose:
    Implement the final quantitative segmentation workflow after diagnostics showed
    that high-dimensional categorical-index LCA models were unstable for k >= 3.

    Core decision:
    Use smaller, theory-driven binary LCA feature sets to reduce response-pattern
    sparsity and local dependence. Then compare with benchmark k-means and
    hierarchical clustering on continuous standardized indices.

    Important:
    - This section should replace the previous broad LCA grid and the temporary
      diagnostic chunk.
    - It assumes Section 4 already created CFI_DPI_lca_ready_variables.dta.
    - Binary LCA inputs are coded 0/1 and modeled with logit.
    - Ordinal variables are not used in the main minimal LCA models.
*/

version 16
set more off
set seed 6427961
graph set window fontface "Times New Roman"

*-------------------------------------------------------------------------------*
* 6.0 Output folders and data intake
*-------------------------------------------------------------------------------*

if "${cluster_tables}" == "" global cluster_tables "${output_dir}/cluster/tables"
if "${cluster_figures}" == "" global cluster_figures "${output_dir}/cluster/figures"
if "${cluster_models}" == "" global cluster_models "${output_dir}/cluster/models"
if "${cluster_data}" == "" global cluster_data "${output_dir}/cluster/data"

capture mkdir "${output_dir}/cluster"
capture mkdir "${cluster_tables}"
capture mkdir "${cluster_figures}"
capture mkdir "${cluster_models}"
capture mkdir "${cluster_data}"

use "${cluster_data}/CFI_DPI_lca_ready_variables.dta", clear

count
display as text "Current LCA-ready analytical sample N = " r(N)

capture confirm variable KEY
if _rc {
    gen str20 KEY = string(_n)
    label var KEY "Fallback unique case ID created for LCA"
}

isid KEY


*-------------------------------------------------------------------------------*
* 6.1 Construct minimal binary LCA indicators
*-------------------------------------------------------------------------------*

/*
    Coding logic:
    Positive constructs:
        1 = stronger / more favorable condition
        0 = weaker / lower condition

    Constraint / risk constructs:
        1 = higher constraint / higher risk
        0 = lower constraint / lower risk

    These variables are deliberately simpler than the earlier 3-level categorical
    inputs. They are designed to reduce sparse multivariate response patterns.
*/

capture drop lca2_ivs_high
gen byte lca2_ivs_high = .
replace lca2_ivs_high = 1 if lca_ivs3 == 3
replace lca2_ivs_high = 0 if inlist(lca_ivs3, 1, 2)
label var lca2_ivs_high "High socioeconomic vulnerability"

capture drop lca2_icdp_high
gen byte lca2_icdp_high = .
replace lca2_icdp_high = 1 if lca_icdp3 == 3
replace lca2_icdp_high = 0 if inlist(lca_icdp3, 1, 2)
label var lca2_icdp_high "High practical digital competence"

capture drop lca2_iaff_high
gen byte lca2_iaff_high = .
replace lca2_iaff_high = 1 if lca_iaff3 == 3
replace lca2_iaff_high = 0 if inlist(lca_iaff3, 1, 2)
label var lca2_iaff_high "High formal financial access"

capture drop lca2_oqi_good
gen byte lca2_oqi_good = .
replace lca2_oqi_good = 1 if lca_oqi3 == 3
replace lca2_oqi_good = 0 if inlist(lca_oqi3, 1, 2)
label var lca2_oqi_good "Good onboarding quality"

capture drop lca2_iurd_high
gen byte lca2_iurd_high = .
replace lca2_iurd_high = 1 if lca_iurd3 == 3
replace lca2_iurd_high = 0 if inlist(lca_iurd3, 1, 2)
label var lca2_iurd_high "High digital remittance intensity"

capture drop lca2_iedf_harm
gen byte lca2_iedf_harm = .
replace lca2_iedf_harm = 1 if lca_iedf2 == 1
replace lca2_iedf_harm = 0 if lca_iedf2 == 0
label var lca2_iedf_harm "Any meaningful fraud exposure or harm"

capture drop lca2_icpf_high
capture confirm variable lca_icpf3
if !_rc {
    gen byte lca2_icpf_high = .
    replace lca2_icpf_high = 1 if lca_icpf3 == 3
    replace lca2_icpf_high = 0 if inlist(lca_icpf3, 1, 2)
}
else {
    gen byte lca2_icpf_high = lca_icpf2
}
label var lca2_icpf_high "High trust and norms climate"

capture drop lca2_ieh_adequate
gen byte lca2_ieh_adequate = .
replace lca2_ieh_adequate = 1 if inlist(lca_ieh3, 2, 3)
replace lca2_ieh_adequate = 0 if lca_ieh3 == 1
label var lca2_ieh_adequate "Adequate enabling environment"

label define yesno01 0 "No / lower category" 1 "Yes / higher category", replace
foreach v in lca2_ivs_high lca2_icdp_high lca2_iaff_high lca2_oqi_good ///
             lca2_iurd_high lca2_iedf_harm lca2_icpf_high lca2_ieh_adequate {
    label values `v' yesno01
}

save "${cluster_data}/CFI_DPI_lca_minimal_binary_inputs.dta", replace


*-------------------------------------------------------------------------------*
* 6.2 Minimal response-pattern diagnostics
*-------------------------------------------------------------------------------*

/*
    This table confirms whether the reduced feature sets are sufficiently stable
    before estimating k-class models.
*/

tempfile minimal_patterns
tempname patternpost

postfile `patternpost' ///
    str20 feature_set ///
    int n_indicators ///
    int N_complete ///
    int n_unique_patterns ///
    int n_singleton_patterns ///
    double pct_obs_in_singletons ///
    int min_pattern_n ///
    int max_pattern_n ///
    using "`minimal_patterns'", replace

preserve
    egen __miss = rowmiss(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                          lca2_oqi_good lca2_iurd_high lca2_iedf_harm ///
                          lca2_icpf_high)
    gen byte __touse = (__miss == 0)
    count if __touse == 1
    local N_complete = r(N)

    egen __pattern = group(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                           lca2_oqi_good lca2_iurd_high lca2_iedf_harm ///
                           lca2_icpf_high) if __touse == 1
    bysort __pattern: gen __pattern_n = _N if __touse == 1
    egen __tag = tag(__pattern) if __touse == 1

    count if __tag == 1
    local n_unique_patterns = r(N)
    count if __tag == 1 & __pattern_n == 1
    local n_singleton_patterns = r(N)
    count if __touse == 1 & __pattern_n == 1
    local obs_singletons = r(N)
    summarize __pattern_n if __tag == 1, meanonly
    local min_pattern_n = r(min)
    local max_pattern_n = r(max)

    post `patternpost' ///
        ("M1_7bin_main") ///
        (7) ///
        (`N_complete') ///
        (`n_unique_patterns') ///
        (`n_singleton_patterns') ///
        (100 * `obs_singletons' / `N_complete') ///
        (`min_pattern_n') ///
        (`max_pattern_n')
restore

preserve
    egen __miss = rowmiss(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                          lca2_oqi_good lca2_iurd_high lca2_icpf_high)
    gen byte __touse = (__miss == 0)
    count if __touse == 1
    local N_complete = r(N)

    egen __pattern = group(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                           lca2_oqi_good lca2_iurd_high lca2_icpf_high) ///
                           if __touse == 1
    bysort __pattern: gen __pattern_n = _N if __touse == 1
    egen __tag = tag(__pattern) if __touse == 1

    count if __tag == 1
    local n_unique_patterns = r(N)
    count if __tag == 1 & __pattern_n == 1
    local n_singleton_patterns = r(N)
    count if __touse == 1 & __pattern_n == 1
    local obs_singletons = r(N)
    summarize __pattern_n if __tag == 1, meanonly
    local min_pattern_n = r(min)
    local max_pattern_n = r(max)

    post `patternpost' ///
        ("M2_6bin_noharm") ///
        (6) ///
        (`N_complete') ///
        (`n_unique_patterns') ///
        (`n_singleton_patterns') ///
        (100 * `obs_singletons' / `N_complete') ///
        (`min_pattern_n') ///
        (`max_pattern_n')
restore

preserve
    egen __miss = rowmiss(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                          lca2_oqi_good lca2_iurd_high lca2_iedf_harm)
    gen byte __touse = (__miss == 0)
    count if __touse == 1
    local N_complete = r(N)

    egen __pattern = group(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                           lca2_oqi_good lca2_iurd_high lca2_iedf_harm) ///
                           if __touse == 1
    bysort __pattern: gen __pattern_n = _N if __touse == 1
    egen __tag = tag(__pattern) if __touse == 1

    count if __tag == 1
    local n_unique_patterns = r(N)
    count if __tag == 1 & __pattern_n == 1
    local n_singleton_patterns = r(N)
    count if __touse == 1 & __pattern_n == 1
    local obs_singletons = r(N)
    summarize __pattern_n if __tag == 1, meanonly
    local min_pattern_n = r(min)
    local max_pattern_n = r(max)

    post `patternpost' ///
        ("M3_6bin_notrust") ///
        (6) ///
        (`N_complete') ///
        (`n_unique_patterns') ///
        (`n_singleton_patterns') ///
        (100 * `obs_singletons' / `N_complete') ///
        (`min_pattern_n') ///
        (`max_pattern_n')
restore

preserve
    egen __miss = rowmiss(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                          lca2_oqi_good lca2_iurd_high)
    gen byte __touse = (__miss == 0)
    count if __touse == 1
    local N_complete = r(N)

    egen __pattern = group(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                           lca2_oqi_good lca2_iurd_high) if __touse == 1
    bysort __pattern: gen __pattern_n = _N if __touse == 1
    egen __tag = tag(__pattern) if __touse == 1

    count if __tag == 1
    local n_unique_patterns = r(N)
    count if __tag == 1 & __pattern_n == 1
    local n_singleton_patterns = r(N)
    count if __touse == 1 & __pattern_n == 1
    local obs_singletons = r(N)
    summarize __pattern_n if __tag == 1, meanonly
    local min_pattern_n = r(min)
    local max_pattern_n = r(max)

    post `patternpost' ///
        ("M4_5bin_ultra") ///
        (5) ///
        (`N_complete') ///
        (`n_unique_patterns') ///
        (`n_singleton_patterns') ///
        (100 * `obs_singletons' / `N_complete') ///
        (`min_pattern_n') ///
        (`max_pattern_n')
restore

postclose `patternpost'

preserve
    use "`minimal_patterns'", clear
    format pct_obs_in_singletons %9.2f

    export excel using "${cluster_tables}/Table_C10_minimal_LCA_response_patterns.xlsx", ///
        sheet("minimal_patterns", replace) firstrow(variables)

    save "${cluster_data}/CFI_DPI_minimal_LCA_response_patterns.dta", replace
restore


*-------------------------------------------------------------------------------*
* 6.3 Utility program to record LCA fit and posterior diagnostics
*-------------------------------------------------------------------------------*

/*
    The gsem calls below are intentionally explicit and verbose.
    This small program only records diagnostics after each model has run.
*/

capture program drop lca_record
program define lca_record
    syntax, MODELID(string) FEATURESET(string) MODELTYPE(string) K(integer) ///
            NINDICATORS(integer) NCOMPLETE(integer) RC(integer) STARTMETHOD(string)

    local converged = 0
    local ll = .
    local df = .
    local aic = .
    local bic = .
    local entropy = .
    local avg_maxpp = .
    local min_class_n = .
    local min_class_pct = .
    local small_class_flag = .
    local note ""

    if `rc' != 0 {
        local note "Model failed"
    }
    else {
        local converged = e(converged)

        if `converged' != 1 {
            local note "Model estimated but did not converge"
        }

        if `converged' == 1 {
            local ll = e(ll)
            local N_est = e(N)

            capture scalar __df_lca = e(rank)
            if _rc {
                capture scalar __df_lca = e(k)
                if _rc scalar __df_lca = .
            }

            local df = scalar(__df_lca)

            if `ll' < . & `df' < . & `N_est' < . {
                local aic = -2 * `ll' + 2 * `df'
                local bic = -2 * `ll' + ln(`N_est') * `df'
            }

            capture estimates store `modelid'
            capture estimates save "${cluster_models}/`modelid'.ster", replace

            capture drop pp_`modelid'_*
            capture drop cls_`modelid'
            capture drop __maxp __entropy_component

            capture predict double pp_`modelid'_*, classposteriorpr

            if _rc {
                local note "Converged but posterior prediction failed"
            }
            else {
                ds pp_`modelid'_*
                local pvars `r(varlist)'
                local npvars : word count `pvars'

                if `npvars' == `k' {
                    egen double __maxp = rowmax(`pvars')
                    gen byte cls_`modelid' = .

                    forvalues c = 1/`k' {
                        local pcvar : word `c' of `pvars'
                        replace cls_`modelid' = `c' if ///
                            missing(cls_`modelid') & ///
                            abs(`pcvar' - __maxp) < 1e-10 & e(sample)
                    }

                    gen double __entropy_component = 0 if e(sample)

                    foreach p of local pvars {
                        replace __entropy_component = __entropy_component + ///
                            cond(`p' > 0 & `p' < ., `p' * ln(`p'), 0) if e(sample)
                    }

                    summarize __entropy_component if e(sample), meanonly
                    local entropy = 1 + (r(sum) / (`N_est' * ln(`k')))

                    summarize __maxp if e(sample), meanonly
                    local avg_maxpp = r(mean)

                    local min_class_n = .
                    local min_class_pct = .
                    local small_class_flag = 0

                    forvalues c = 1/`k' {
                        count if cls_`modelid' == `c' & e(sample)
                        local modal_n = r(N)
                        local modal_pct = 100 * `modal_n' / `N_est'

                        if missing(`min_class_n') | `modal_n' < `min_class_n' {
                            local min_class_n = `modal_n'
                            local min_class_pct = `modal_pct'
                        }

                        if `modal_n' < 20 | `modal_pct' < 5 {
                            local small_class_flag = 1
                        }
                    }

                    preserve
                        keep if e(sample)
                        keep KEY pp_`modelid'_* cls_`modelid'
                        save "${cluster_data}/posterior_`modelid'.dta", replace
                    restore

                    if `small_class_flag' == 1 {
                        local note "Converged but has small modal class"
                    }
                    else {
                        local note "OK"
                    }
                }
                else {
                    local note "Unexpected number of posterior probability variables"
                }
            }

            capture drop pp_`modelid'_*
            capture drop cls_`modelid'
            capture drop __maxp __entropy_component
        }
    }

	post $LCA_FITPOST ///
        (`"`modelid'"') ///
        (`"`featureset'"') ///
        (`"`modeltype'"') ///
        (`k') ///
        (`nindicators') ///
        (`ncomplete') ///
        (`rc') ///
        (`converged') ///
        (`ll') ///
        (`df') ///
        (`aic') ///
        (`bic') ///
        (`entropy') ///
        (`avg_maxpp') ///
        (`min_class_n') ///
        (`min_class_pct') ///
        (`small_class_flag') ///
        (`"`startmethod'"') ///
        (`"`note'"')

    display as result "`modelid' | rc=`rc' | converged=`converged' | BIC=" ///
        %12.2f `bic' " | entropy=" %6.3f `entropy' ///
        " | min class %=" %6.2f `min_class_pct' " | `note'"
end


*-------------------------------------------------------------------------------*
* 6.4 Estimate minimal LCA models, k = 2 to 5
*-------------------------------------------------------------------------------*

tempfile lca_fit_results
tempname fitpost
global LCA_FITPOST "`fitpost'"

postfile `fitpost' ///
    str20 model_id ///
    str24 feature_set ///
    str60 model_type ///
    byte k ///
    byte n_indicators ///
    int N_complete ///
    int rc ///
    byte converged ///
    double ll ///
    double df ///
    double aic ///
    double bic ///
    double entropy ///
    double avg_max_posterior ///
    int min_class_n ///
    double min_class_pct ///
    byte small_class_flag ///
    str80 start_method ///
    str160 note ///
    using "`lca_fit_results'", replace
	
	


*===============================================================================*
* MODEL SET M1: 7-binary main model
* Dimensions: vulnerability, competence, formal access, onboarding, digital
* remittance intensity, fraud harm, trust/norms climate.
*===============================================================================*

egen __miss_M1 = rowmiss(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                         lca2_oqi_good lca2_iurd_high lca2_iedf_harm ///
                         lca2_icpf_high)
gen byte __touse_M1 = (__miss_M1 == 0)
count if __touse_M1 == 1
local N_M1 = r(N)

display as text "Estimating M1 7-binary main LCA models. Complete-case N = `N_M1'"

set seed 6429002
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_iedf_harm <-, logit) ///
    (lca2_icpf_high <-, logit) ///
    if __touse_M1 == 1, ///
    lclass(C 2) ///
    startvalues(randomid, draws(200)) ///
    difficult iterate(5000) nolog
local rc = _rc
lca_record, modelid("M1_k2") featureset("M1_7bin_main") ///
    modeltype("7-binary main LCA") k(2) nindicators(7) ///
    ncomplete(`N_M1') rc(`rc') startmethod("randomid_draws200_iter5000")

set seed 6429003
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_iedf_harm <-, logit) ///
    (lca2_icpf_high <-, logit) ///
    if __touse_M1 == 1, ///
    lclass(C 3) ///
    startvalues(randomid, draws(300)) ///
    difficult iterate(5000) nolog
local rc = _rc
lca_record, modelid("M1_k3") featureset("M1_7bin_main") ///
    modeltype("7-binary main LCA") k(3) nindicators(7) ///
    ncomplete(`N_M1') rc(`rc') startmethod("randomid_draws300_iter5000")

set seed 6429004
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_iedf_harm <-, logit) ///
    (lca2_icpf_high <-, logit) ///
    if __touse_M1 == 1, ///
    lclass(C 4) ///
    startvalues(randomid, draws(500)) ///
    difficult iterate(7000) nolog
local rc = _rc
lca_record, modelid("M1_k4") featureset("M1_7bin_main") ///
    modeltype("7-binary main LCA") k(4) nindicators(7) ///
    ncomplete(`N_M1') rc(`rc') startmethod("randomid_draws500_iter7000")

set seed 6429005
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_iedf_harm <-, logit) ///
    (lca2_icpf_high <-, logit) ///
    if __touse_M1 == 1, ///
    lclass(C 5) ///
    startvalues(randomid, draws(500)) ///
    difficult iterate(7000) nolog
local rc = _rc
lca_record, modelid("M1_k5") featureset("M1_7bin_main") ///
    modeltype("7-binary main LCA") k(5) nindicators(7) ///
    ncomplete(`N_M1') rc(`rc') startmethod("randomid_draws500_iter7000")


*===============================================================================*
* MODEL SET M2: 6-binary model excluding fraud harm
* Fraud harm is kept for post-hoc profiling rather than class definition.
*===============================================================================*

egen __miss_M2 = rowmiss(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                         lca2_oqi_good lca2_iurd_high lca2_icpf_high)
gen byte __touse_M2 = (__miss_M2 == 0)
count if __touse_M2 == 1
local N_M2 = r(N)

display as text "Estimating M2 6-binary no-harm LCA models. Complete-case N = `N_M2'"

set seed 6430002
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_icpf_high <-, logit) ///
    if __touse_M2 == 1, ///
    lclass(C 2) ///
    startvalues(randomid, draws(200)) ///
    difficult iterate(5000) nolog
local rc = _rc
lca_record, modelid("M2_k2") featureset("M2_6bin_noharm") ///
    modeltype("6-binary LCA excluding fraud harm") k(2) nindicators(6) ///
    ncomplete(`N_M2') rc(`rc') startmethod("randomid_draws200_iter5000")

set seed 6430003
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_icpf_high <-, logit) ///
    if __touse_M2 == 1, ///
    lclass(C 3) ///
    startvalues(randomid, draws(300)) ///
    difficult iterate(5000) nolog
local rc = _rc
lca_record, modelid("M2_k3") featureset("M2_6bin_noharm") ///
    modeltype("6-binary LCA excluding fraud harm") k(3) nindicators(6) ///
    ncomplete(`N_M2') rc(`rc') startmethod("randomid_draws300_iter5000")

set seed 6430004
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_icpf_high <-, logit) ///
    if __touse_M2 == 1, ///
    lclass(C 4) ///
    startvalues(randomid, draws(500)) ///
    difficult iterate(7000) nolog
local rc = _rc
lca_record, modelid("M2_k4") featureset("M2_6bin_noharm") ///
    modeltype("6-binary LCA excluding fraud harm") k(4) nindicators(6) ///
    ncomplete(`N_M2') rc(`rc') startmethod("randomid_draws500_iter7000")

set seed 6430005
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_icpf_high <-, logit) ///
    if __touse_M2 == 1, ///
    lclass(C 5) ///
    startvalues(randomid, draws(500)) ///
    difficult iterate(7000) nolog
local rc = _rc
lca_record, modelid("M2_k5") featureset("M2_6bin_noharm") ///
    modeltype("6-binary LCA excluding fraud harm") k(5) nindicators(6) ///
    ncomplete(`N_M2') rc(`rc') startmethod("randomid_draws500_iter7000")


*===============================================================================*
* MODEL SET M3: 6-binary model excluding trust climate
* Trust climate is kept for post-hoc profiling rather than class definition.
*===============================================================================*

egen __miss_M3 = rowmiss(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                         lca2_oqi_good lca2_iurd_high lca2_iedf_harm)
gen byte __touse_M3 = (__miss_M3 == 0)
count if __touse_M3 == 1
local N_M3 = r(N)

display as text "Estimating M3 6-binary no-trust LCA models. Complete-case N = `N_M3'"

set seed 6431002
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_iedf_harm <-, logit) ///
    if __touse_M3 == 1, ///
    lclass(C 2) ///
    startvalues(randomid, draws(200)) ///
    difficult iterate(5000) nolog
local rc = _rc
lca_record, modelid("M3_k2") featureset("M3_6bin_notrust") ///
    modeltype("6-binary LCA excluding trust climate") k(2) nindicators(6) ///
    ncomplete(`N_M3') rc(`rc') startmethod("randomid_draws200_iter5000")

set seed 6431003
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_iedf_harm <-, logit) ///
    if __touse_M3 == 1, ///
    lclass(C 3) ///
    startvalues(randomid, draws(300)) ///
    difficult iterate(5000) nolog
local rc = _rc
lca_record, modelid("M3_k3") featureset("M3_6bin_notrust") ///
    modeltype("6-binary LCA excluding trust climate") k(3) nindicators(6) ///
    ncomplete(`N_M3') rc(`rc') startmethod("randomid_draws300_iter5000")

set seed 6431004
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_iedf_harm <-, logit) ///
    if __touse_M3 == 1, ///
    lclass(C 4) ///
    startvalues(randomid, draws(500)) ///
    difficult iterate(7000) nolog
local rc = _rc
lca_record, modelid("M3_k4") featureset("M3_6bin_notrust") ///
    modeltype("6-binary LCA excluding trust climate") k(4) nindicators(6) ///
    ncomplete(`N_M3') rc(`rc') startmethod("randomid_draws500_iter7000")

set seed 6431005
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    (lca2_iedf_harm <-, logit) ///
    if __touse_M3 == 1, ///
    lclass(C 5) ///
    startvalues(randomid, draws(500)) ///
    difficult iterate(7000) nolog
local rc = _rc
lca_record, modelid("M3_k5") featureset("M3_6bin_notrust") ///
    modeltype("6-binary LCA excluding trust climate") k(5) nindicators(6) ///
    ncomplete(`N_M3') rc(`rc') startmethod("randomid_draws500_iter7000")


*===============================================================================*
* MODEL SET M4: 5-binary ultra-parsimonious model
* Core segmentation axes only: vulnerability, competence, formal access,
* onboarding, and digital remittance intensity.
*===============================================================================*

egen __miss_M4 = rowmiss(lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                         lca2_oqi_good lca2_iurd_high)
gen byte __touse_M4 = (__miss_M4 == 0)
count if __touse_M4 == 1
local N_M4 = r(N)

display as text "Estimating M4 5-binary ultra-parsimonious LCA models. Complete-case N = `N_M4'"

set seed 6432002
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    if __touse_M4 == 1, ///
    lclass(C 2) ///
    startvalues(randomid, draws(200)) ///
    difficult iterate(5000) nolog
local rc = _rc
lca_record, modelid("M4_k2") featureset("M4_5bin_ultra") ///
    modeltype("5-binary ultra-parsimonious LCA") k(2) nindicators(5) ///
    ncomplete(`N_M4') rc(`rc') startmethod("randomid_draws200_iter5000")

set seed 6432003
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    if __touse_M4 == 1, ///
    lclass(C 3) ///
    startvalues(randomid, draws(300)) ///
    difficult iterate(5000) nolog
local rc = _rc
lca_record, modelid("M4_k3") featureset("M4_5bin_ultra") ///
    modeltype("5-binary ultra-parsimonious LCA") k(3) nindicators(5) ///
    ncomplete(`N_M4') rc(`rc') startmethod("randomid_draws300_iter5000")

set seed 6432004
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    if __touse_M4 == 1, ///
    lclass(C 4) ///
    startvalues(randomid, draws(500)) ///
    difficult iterate(7000) nolog
local rc = _rc
lca_record, modelid("M4_k4") featureset("M4_5bin_ultra") ///
    modeltype("5-binary ultra-parsimonious LCA") k(4) nindicators(5) ///
    ncomplete(`N_M4') rc(`rc') startmethod("randomid_draws500_iter7000")

set seed 6432005
ereturn clear
capture noisily gsem ///
    (lca2_ivs_high <-, logit) ///
    (lca2_icdp_high <-, logit) ///
    (lca2_iaff_high <-, logit) ///
    (lca2_oqi_good <-, logit) ///
    (lca2_iurd_high <-, logit) ///
    if __touse_M4 == 1, ///
    lclass(C 5) ///
    startvalues(randomid, draws(500)) ///
    difficult iterate(7000) nolog
local rc = _rc
lca_record, modelid("M4_k5") featureset("M4_5bin_ultra") ///
    modeltype("5-binary ultra-parsimonious LCA") k(5) nindicators(5) ///
    ncomplete(`N_M4') rc(`rc') startmethod("randomid_draws500_iter7000")


postclose `fitpost'
macro drop LCA_FITPOST

preserve
    use "`lca_fit_results'", clear

    format aic bic %12.2f
    format entropy avg_max_posterior min_class_pct %9.3f

    gen byte report_candidate = ///
        converged == 1 & ///
        inlist(k, 4, 5) & ///
        min_class_pct >= 5 & ///
        entropy >= 0.60

    order model_id feature_set model_type k converged report_candidate ///
          bic aic entropy avg_max_posterior min_class_n min_class_pct ///
          small_class_flag rc start_method note

    export excel using "${cluster_tables}/Table_C11_minimal_LCA_fit_summary.xlsx", ///
        sheet("fit_summary", replace) firstrow(variables)

    save "${cluster_data}/CFI_DPI_minimal_LCA_fit_summary.dta", replace

    list model_id feature_set k converged report_candidate bic entropy ///
         avg_max_posterior min_class_pct note, noobs abbreviate(24)
restore


*-------------------------------------------------------------------------------*
* 6.5 FIXED: Generate class-profile tables for all saved converged LCA models
*-------------------------------------------------------------------------------*

use "${cluster_data}/CFI_DPI_lca_minimal_binary_inputs.dta", clear

foreach mid in M1_k2 M1_k3 M1_k4 ///
               M2_k2 M2_k3 M2_k4 ///
               M3_k2 M3_k3 M3_k4 ///
               M4_k2 M4_k3 M4_k4 {

    capture confirm file "${cluster_data}/posterior_`mid'.dta"

    if !_rc {

        preserve

            merge 1:1 KEY using "${cluster_data}/posterior_`mid'.dta", ///
                keep(match) nogen

            capture confirm variable cls_`mid'

            if !_rc {

                gen byte __one = 1

                collapse ///
                    (sum) N = __one ///
                    (mean) ///
                        lca2_ivs_high ///
                        lca2_icdp_high ///
                        lca2_iaff_high ///
                        lca2_oqi_good ///
                        lca2_iurd_high ///
                        lca2_iedf_harm ///
                        lca2_icpf_high ///
                        lca2_ieh_adequate ///
                        ivs_score ///
                        iat_score ///
                        iadt_score ///
                        icdp_score ///
                        iaff_score ///
                        iuof_score_01 ///
                        oqi_score_01 ///
                        iurd_score_01 ///
                        ietr_score_01 ///
                        IPCS ///
                        IEDF ///
                        IAER ///
                        ICPF ///
                        IEH ///
                        IBPD ///
                        formal_remittance, ///
                    by(cls_`mid')

                egen total_N = total(N)
                gen pct = 100 * N / total_N
                drop total_N

                format pct %9.2f

                order cls_`mid' N pct ///
                    lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                    lca2_oqi_good lca2_iurd_high lca2_iedf_harm ///
                    lca2_icpf_high lca2_ieh_adequate ///
                    ivs_score iat_score iadt_score icdp_score iaff_score ///
                    iuof_score_01 oqi_score_01 iurd_score_01 ietr_score_01 ///
                    IPCS IEDF IAER ICPF IEH IBPD formal_remittance

                export excel using "${cluster_tables}/Table_C12_LCA_class_profiles.xlsx", ///
                    sheet("`mid'", replace) firstrow(variables)
            }

        restore
    }
}

display as text "Fixed LCA class-profile export completed."

*-------------------------------------------------------------------------------*
* 6.5B Create segmentation dataset with all saved LCA modal class assignments
*-------------------------------------------------------------------------------*

use "${cluster_data}/CFI_DPI_lca_minimal_binary_inputs.dta", clear

foreach mid in M1_k2 M1_k3 M1_k4 ///
               M2_k2 M2_k3 M2_k4 ///
               M3_k2 M3_k3 M3_k4 ///
               M4_k2 M4_k3 M4_k4 {

    capture confirm file "${cluster_data}/posterior_`mid'.dta"

    if !_rc {
        merge 1:1 KEY using "${cluster_data}/posterior_`mid'.dta", ///
            keep(master match) nogen
    }
}

save "${cluster_data}/CFI_DPI_segmentation_LCA_assignments.dta", replace

display as text "Segmentation dataset with posterior probabilities and modal classes saved."

*-------------------------------------------------------------------------------*
* 6.6 Benchmark clustering on continuous standardized indices
*-------------------------------------------------------------------------------*

/*
    These are not the preferred latent-class models, but they are necessary
    sensitivity checks. They may also become the practical final segmentation
    if LCA does not support an interpretable 4- or 5-class solution.

    Continuous inputs:
    - vulnerability
    - digital access
    - practical digital competence
    - formal financial access
    - financial operability
    - onboarding quality
    - digital remittance intensity
    - transactional experience
    - fraud harm
    - prevention / safe conduct
    - autonomy
    - trust climate
    - enabling environment
    - barriers
*/

capture drop segz_ivs segz_iat segz_icdp segz_iaff segz_iuof segz_oqi ///
             segz_iurd segz_ietr segz_iedf segz_ipcs segz_iaer segz_icpf ///
             segz_ieh segz_ibpd

egen segz_ivs  = std(ivs_score)
egen segz_iat  = std(iat_score)
egen segz_icdp = std(icdp_score)
egen segz_iaff = std(iaff_score)
egen segz_iuof = std(iuof_score_01)
egen segz_oqi  = std(oqi_score_01)
egen segz_iurd = std(iurd_score_01)
egen segz_ietr = std(ietr_score_01)
egen segz_iedf = std(IEDF)
egen segz_ipcs = std(IPCS)
egen segz_iaer = std(IAER)
egen segz_icpf = std(ICPF)
egen segz_ieh  = std(IEH)
egen segz_ibpd = std(IBPD)


*-------------------------------------------------------------------------------*
* 6.6.1 K-means benchmark: 4 clusters
*-------------------------------------------------------------------------------*

set seed 7427961
capture cluster drop km4_main
capture drop km4_main

capture noisily cluster kmeans ///
    segz_ivs segz_icdp segz_iaff segz_iuof segz_oqi segz_iurd ///
    segz_ietr segz_iedf segz_ipcs segz_iaer segz_icpf segz_ieh ///
    , k(4) name(km4_main) measure(L2) start(krandom)

if _rc {
    display as error "k-means with start(krandom) failed; retrying with default starts."
    cluster kmeans ///
        segz_ivs segz_icdp segz_iaff segz_iuof segz_oqi segz_iurd ///
        segz_ietr segz_iedf segz_ipcs segz_iaer segz_icpf segz_ieh ///
        , k(4) name(km4_main) measure(L2)
}

cluster generate km4_main = groups(4), name(km4_main)
label var km4_main "K-means benchmark clusters, k=4"


*-------------------------------------------------------------------------------*
* 6.6.2 K-means benchmark: 5 clusters
*-------------------------------------------------------------------------------*

set seed 7427962
capture cluster drop km5_main
capture drop km5_main

capture noisily cluster kmeans ///
    segz_ivs segz_icdp segz_iaff segz_iuof segz_oqi segz_iurd ///
    segz_ietr segz_iedf segz_ipcs segz_iaer segz_icpf segz_ieh ///
    , k(5) name(km5_main) measure(L2) start(krandom)

if _rc {
    display as error "k-means with start(krandom) failed; retrying with default starts."
    cluster kmeans ///
        segz_ivs segz_icdp segz_iaff segz_iuof segz_oqi segz_iurd ///
        segz_ietr segz_iedf segz_ipcs segz_iaer segz_icpf segz_ieh ///
        , k(5) name(km5_main) measure(L2)
}

cluster generate km5_main = groups(5), name(km5_main)
label var km5_main "K-means benchmark clusters, k=5"


*-------------------------------------------------------------------------------*
* 6.6.3 Hierarchical benchmark: Ward linkage, 4 and 5 groups
*-------------------------------------------------------------------------------*

capture cluster drop ward_main
capture drop ward4_main ward5_main

cluster wardslinkage ///
    segz_ivs segz_icdp segz_iaff segz_iuof segz_oqi segz_iurd ///
    segz_ietr segz_iedf segz_ipcs segz_iaer segz_icpf segz_ieh ///
    , name(ward_main) measure(L2)

cluster generate ward4_main = groups(4), name(ward_main)
cluster generate ward5_main = groups(5), name(ward_main)

label var ward4_main "Ward hierarchical benchmark clusters, k=4"
label var ward5_main "Ward hierarchical benchmark clusters, k=5"


*-------------------------------------------------------------------------------*
* 6.7 Benchmark cluster profile tables
*-------------------------------------------------------------------------------*

preserve
    gen byte __one = 1

    collapse ///
        (sum) N = __one ///
        (mean) ///
            ivs_score ///
            iat_score ///
            iadt_score ///
            icdp_score ///
            iaff_score ///
            iuof_score_01 ///
            oqi_score_01 ///
            iurd_score_01 ///
            ietr_score_01 ///
            IPCS ///
            IEDF ///
            IAER ///
            ICPF ///
            IEH ///
            IBPD ///
            formal_remittance ///
            lca2_ivs_high ///
            lca2_icdp_high ///
            lca2_iaff_high ///
            lca2_oqi_good ///
            lca2_iurd_high ///
            lca2_iedf_harm ///
            lca2_icpf_high ///
            lca2_ieh_adequate, ///
        by(km4_main)

    egen total_N = total(N)
    gen pct = 100 * N / total_N
    drop total_N
    format pct %9.2f

    export excel using "${cluster_tables}/Table_C13_benchmark_cluster_profiles.xlsx", ///
        sheet("kmeans_k4", replace) firstrow(variables)
restore


preserve
    gen byte __one = 1

    collapse ///
        (sum) N = __one ///
        (mean) ///
            ivs_score ///
            iat_score ///
            iadt_score ///
            icdp_score ///
            iaff_score ///
            iuof_score_01 ///
            oqi_score_01 ///
            iurd_score_01 ///
            ietr_score_01 ///
            IPCS ///
            IEDF ///
            IAER ///
            ICPF ///
            IEH ///
            IBPD ///
            formal_remittance ///
            lca2_ivs_high ///
            lca2_icdp_high ///
            lca2_iaff_high ///
            lca2_oqi_good ///
            lca2_iurd_high ///
            lca2_iedf_harm ///
            lca2_icpf_high ///
            lca2_ieh_adequate, ///
        by(km5_main)

    egen total_N = total(N)
    gen pct = 100 * N / total_N
    drop total_N
    format pct %9.2f

    export excel using "${cluster_tables}/Table_C13_benchmark_cluster_profiles.xlsx", ///
        sheet("kmeans_k5", modify) firstrow(variables)
restore


preserve
    gen byte __one = 1

    collapse ///
        (sum) N = __one ///
        (mean) ///
            ivs_score ///
            iat_score ///
            iadt_score ///
            icdp_score ///
            iaff_score ///
            iuof_score_01 ///
            oqi_score_01 ///
            iurd_score_01 ///
            ietr_score_01 ///
            IPCS ///
            IEDF ///
            IAER ///
            ICPF ///
            IEH ///
            IBPD ///
            formal_remittance ///
            lca2_ivs_high ///
            lca2_icdp_high ///
            lca2_iaff_high ///
            lca2_oqi_good ///
            lca2_iurd_high ///
            lca2_iedf_harm ///
            lca2_icpf_high ///
            lca2_ieh_adequate, ///
        by(ward4_main)

    egen total_N = total(N)
    gen pct = 100 * N / total_N
    drop total_N
    format pct %9.2f

    export excel using "${cluster_tables}/Table_C13_benchmark_cluster_profiles.xlsx", ///
        sheet("ward_k4", modify) firstrow(variables)
restore


preserve
    gen byte __one = 1

    collapse ///
        (sum) N = __one ///
        (mean) ///
            ivs_score ///
            iat_score ///
            iadt_score ///
            icdp_score ///
            iaff_score ///
            iuof_score_01 ///
            oqi_score_01 ///
            iurd_score_01 ///
            ietr_score_01 ///
            IPCS ///
            IEDF ///
            IAER ///
            ICPF ///
            IEH ///
            IBPD ///
            formal_remittance ///
            lca2_ivs_high ///
            lca2_icdp_high ///
            lca2_iaff_high ///
            lca2_oqi_good ///
            lca2_iurd_high ///
            lca2_iedf_harm ///
            lca2_icpf_high ///
            lca2_ieh_adequate, ///
        by(ward5_main)

    egen total_N = total(N)
    gen pct = 100 * N / total_N
    drop total_N
    format pct %9.2f

    export excel using "${cluster_tables}/Table_C13_benchmark_cluster_profiles.xlsx", ///
        sheet("ward_k5", modify) firstrow(variables)
restore

*-------------------------------------------------------------------------------*
* 6.8 Save segmentation working dataset
*-------------------------------------------------------------------------------*

save "${cluster_data}/CFI_DPI_segmentation_working_dataset.dta", replace

display as text "------------------------------------------------------------"
display as text "Benchmark clustering section completed."
display as text "Review:"
display as text "1. Table_C13_benchmark_cluster_profiles.xlsx"
display as text "2. CFI_DPI_segmentation_working_dataset.dta"
display as text "------------------------------------------------------------"

}
*-----------------------------------------------------------*
*		7. HYBRID DISTRIBUTION-INFORMED CATEGORICAL LCA		*
*-----------------------------------------------------------*
{
/*
    Purpose:
    Final sensitivity/refinement test for the segmentation analysis.

    Motivation:
    The minimal binary LCA produced viable 4-class solutions. This section tests
    whether a more nuanced LCA can also work when selected continuous indices are
    recoded into distribution-informed categorical variables.

    Strategy:
    - Use quantile-based ordinal variables where distributions support more nuance.
    - Use binary splits for skewed, ceiling-heavy, or risk/harm constructs.
    - Avoid the earlier high-dimensional sparse categorical grid.
    - Estimate compact hybrid LCA models with ologit + logit indicators.
    - Compare convergence, BIC/AIC, entropy, posterior classification, class size,
      and substantive class profiles against the binary LCA models.

    Important:
    - This section does not use continuous indicators in the LCA.
    - This section does not include both direct items and indices together.
    - The main candidate models remain compact to reduce local dependence.
*/

version 16
set more off
set seed 6427961
graph set window fontface "Times New Roman"

*-------------------------------------------------------------------------------*
* 7.0 Data intake and output folders
*-------------------------------------------------------------------------------*

if "${cluster_tables}" == "" global cluster_tables "${output_dir}/cluster/tables"
if "${cluster_figures}" == "" global cluster_figures "${output_dir}/cluster/figures"
if "${cluster_models}" == "" global cluster_models "${output_dir}/cluster/models"
if "${cluster_data}" == "" global cluster_data "${output_dir}/cluster/data"

capture mkdir "${output_dir}/cluster"
capture mkdir "${cluster_tables}"
capture mkdir "${cluster_figures}"
capture mkdir "${cluster_models}"
capture mkdir "${cluster_data}"

use "${cluster_data}/CFI_DPI_lca_minimal_binary_inputs.dta", clear

count
display as text "Hybrid LCA analytical sample N = " r(N)

capture confirm variable KEY
if _rc {
    gen str20 KEY = string(_n)
    label var KEY "Fallback unique case ID created for hybrid LCA"
}

isid KEY


*-------------------------------------------------------------------------------*
* 7.1 Distribution diagnostics for candidate hybrid LCA inputs
*-------------------------------------------------------------------------------*

/*
    Diagnostic rules used to guide recoding:

    1. Variables with relatively continuous, non-degenerate distributions are
       recoded into tertiles: low / medium / high.
    2. Variables with strong ceiling/floor concentration, strong skew, or direct
       risk meaning are recoded as binary.
    3. More than 3 categories are avoided in the LCA model to prevent sparse
       response patterns and non-convergence.
*/

tempfile hybrid_diag
tempname hybridpost

postfile `hybridpost' ///
    str32 variable ///
    str80 construct ///
    int N_nonmissing ///
    int n_distinct ///
    double min ///
    double p25 ///
    double p33 ///
    double p50 ///
    double p67 ///
    double p75 ///
    double max ///
    double mean ///
    double sd ///
    double skewness ///
    double floor_pct ///
    double ceiling_pct ///
    str40 recommended_treatment ///
    str120 rationale ///
    using "`hybrid_diag'", replace

foreach x in ///
    ivs_score ///
    iat_score ///
    iadt_score ///
    icdp_score ///
    iaff_score ///
    iuof_score_01 ///
    oqi_score_01 ///
    iurd_score_01 ///
    ietr_score_01 ///
    IPCS ///
    IEDF ///
    IAER ///
    ICPF ///
    IEH ///
    IBPD {

    local construct ""

    if "`x'" == "ivs_score"       local construct "Socioeconomic vulnerability"
    if "`x'" == "iat_score"       local construct "Telecommunications access"
    if "`x'" == "iadt_score"      local construct "Digital self-efficacy"
    if "`x'" == "icdp_score"      local construct "Practical digital competence"
    if "`x'" == "iaff_score"      local construct "Formal financial access"
    if "`x'" == "iuof_score_01"   local construct "Financial operability"
    if "`x'" == "oqi_score_01"    local construct "Onboarding quality"
    if "`x'" == "iurd_score_01"   local construct "Digital remittance intensity"
    if "`x'" == "ietr_score_01"   local construct "Transactional experience"
    if "`x'" == "IPCS"            local construct "Prevention and safe conduct"
    if "`x'" == "IEDF"            local construct "Fraud exposure and recourse harm"
    if "`x'" == "IAER"            local construct "Autonomy over remittances"
    if "`x'" == "ICPF"            local construct "Trust and norms climate"
    if "`x'" == "IEH"             local construct "Enabling environment"
    if "`x'" == "IBPD"            local construct "Perceived barriers"

    quietly count if !missing(`x')
    local N_nonmissing = r(N)

    preserve
        keep if !missing(`x')
        keep `x'
        duplicates drop
        quietly count
        local n_distinct = r(N)
    restore

    quietly summarize `x', detail
    local min = r(min)
    local p25 = r(p25)
    local p50 = r(p50)
    local p75 = r(p75)
    local max = r(max)
    local mean = r(mean)
    local sd = r(sd)
    local skewness = r(skewness)

    _pctile `x' if !missing(`x'), p(33.333 66.667)
    local p33 = r(r1)
    local p67 = r(r2)

    quietly count if `x' == `min' & !missing(`x')
    local floor_pct = 100 * r(N) / `N_nonmissing'

    quietly count if `x' == `max' & !missing(`x')
    local ceiling_pct = 100 * r(N) / `N_nonmissing'

    local recommended_treatment "tertile"
    local rationale "Sufficient variation for low/medium/high ordinal recoding"

    if `n_distinct' <= 5 {
        local recommended_treatment "binary_or_existing"
        local rationale "Low number of distinct observed values"
    }

    if abs(`skewness') >= 1.25 {
        local recommended_treatment "binary"
        local rationale "Strongly skewed distribution"
    }

    if `floor_pct' >= 30 | `ceiling_pct' >= 30 {
        local recommended_treatment "binary"
        local rationale "High floor or ceiling concentration"
    }

    if "`x'" == "IEDF" {
        local recommended_treatment "binary"
        local rationale "Risk/harm construct; binary split is more interpretable"
    }

    if "`x'" == "IAER" {
        local recommended_treatment "profile_only_or_binary"
        local rationale "Autonomy is ceiling-heavy; better as profiling variable or sensitivity"
    }

    post `hybridpost' ///
        (`"`x'"') ///
        (`"`construct'"') ///
        (`N_nonmissing') ///
        (`n_distinct') ///
        (`min') ///
        (`p25') ///
        (`p33') ///
        (`p50') ///
        (`p67') ///
        (`p75') ///
        (`max') ///
        (`mean') ///
        (`sd') ///
        (`skewness') ///
        (`floor_pct') ///
        (`ceiling_pct') ///
        (`"`recommended_treatment'"') ///
        (`"`rationale'"')
}

postclose `hybridpost'

preserve
    use "`hybrid_diag'", clear
    format min p25 p33 p50 p67 p75 max mean sd skewness floor_pct ceiling_pct %9.3f

    export excel using "${cluster_tables}/Table_C14_hybrid_variable_distribution_diagnostics.xlsx", ///
        sheet("diagnostics", replace) firstrow(variables)

    save "${cluster_data}/CFI_DPI_hybrid_variable_distribution_diagnostics.dta", replace
restore


*-------------------------------------------------------------------------------*
* 7.2 Create hybrid LCA-ready categorical variables
*-------------------------------------------------------------------------------*

/*
    Tertile recoding:
        1 = low
        2 = medium
        3 = high

    Binary recoding:
        0 = low/no
        1 = high/yes

    For variables used as risk/constraint dimensions:
        1 still means "higher risk/constraint" where conceptually appropriate.
*/

label define hyb3 1 "Low" 2 "Medium" 3 "High", replace
label define hyb2 0 "Low / No" 1 "High / Yes", replace

*-----------------------------*
* Quantile-led ordinal inputs *
*-----------------------------*

capture drop h_ivs3
xtile h_ivs3 = ivs_score, nq(3)
label var h_ivs3 "Hybrid LCA: socioeconomic vulnerability tertile"
label values h_ivs3 hyb3

capture drop h_iat3
xtile h_iat3 = iat_score, nq(3)
label var h_iat3 "Hybrid LCA: telecommunications access tertile"
label values h_iat3 hyb3

capture drop h_iadt3
xtile h_iadt3 = iadt_score, nq(3)
label var h_iadt3 "Hybrid LCA: digital self-efficacy tertile"
label values h_iadt3 hyb3

capture drop h_icdp3
xtile h_icdp3 = icdp_score, nq(3)
label var h_icdp3 "Hybrid LCA: practical digital competence tertile"
label values h_icdp3 hyb3

capture drop h_iaff3
xtile h_iaff3 = iaff_score, nq(3)
label var h_iaff3 "Hybrid LCA: formal financial access tertile"
label values h_iaff3 hyb3

capture drop h_iuof3
xtile h_iuof3 = iuof_score_01, nq(3)
label var h_iuof3 "Hybrid LCA: financial operability tertile"
label values h_iuof3 hyb3

capture drop h_oqi3
xtile h_oqi3 = oqi_score_01, nq(3)
label var h_oqi3 "Hybrid LCA: onboarding quality tertile"
label values h_oqi3 hyb3

capture drop h_iurd3
xtile h_iurd3 = iurd_score_01, nq(3)
label var h_iurd3 "Hybrid LCA: digital remittance intensity tertile"
label values h_iurd3 hyb3

capture drop h_ietr3
xtile h_ietr3 = ietr_score_01, nq(3)
label var h_ietr3 "Hybrid LCA: transactional experience tertile"
label values h_ietr3 hyb3

capture drop h_ipcs3
xtile h_ipcs3 = IPCS, nq(3)
label var h_ipcs3 "Hybrid LCA: prevention and safe conduct tertile"
label values h_ipcs3 hyb3

capture drop h_icpf3
xtile h_icpf3 = ICPF, nq(3)
label var h_icpf3 "Hybrid LCA: trust and norms climate tertile"
label values h_icpf3 hyb3

capture drop h_ieh3
xtile h_ieh3 = IEH, nq(3)
label var h_ieh3 "Hybrid LCA: enabling environment tertile"
label values h_ieh3 hyb3

capture drop h_ibpd3
xtile h_ibpd3 = IBPD, nq(3)
label var h_ibpd3 "Hybrid LCA: perceived barriers tertile"
label values h_ibpd3 hyb3


*----------------------*
* Binary risk variables *
*----------------------*

capture drop h_iedf2
quietly summarize IEDF, detail
local iedf_median = r(p50)
gen byte h_iedf2 = .
replace h_iedf2 = 1 if IEDF > `iedf_median' & !missing(IEDF)
replace h_iedf2 = 0 if IEDF <= `iedf_median' & !missing(IEDF)
label var h_iedf2 "Hybrid LCA: above-median fraud/recourse harm"
label values h_iedf2 hyb2

capture drop h_iaer2
quietly summarize IAER, detail
local iaer_median = r(p50)
gen byte h_iaer2 = .
replace h_iaer2 = 1 if IAER > `iaer_median' & !missing(IAER)
replace h_iaer2 = 0 if IAER <= `iaer_median' & !missing(IAER)
label var h_iaer2 "Hybrid LCA: above-median autonomy"
label values h_iaer2 hyb2

capture drop h_icpf2
quietly summarize ICPF, detail
local icpf_median = r(p50)
gen byte h_icpf2 = .
replace h_icpf2 = 1 if ICPF > `icpf_median' & !missing(ICPF)
replace h_icpf2 = 0 if ICPF <= `icpf_median' & !missing(ICPF)
label var h_icpf2 "Hybrid LCA: above-median trust/norms climate"
label values h_icpf2 hyb2


*-------------------------------------------------------------------------------*
* 7.3 Export hybrid category distributions
*-------------------------------------------------------------------------------*

tempfile hybrid_cats
tempname catpost

postfile `catpost' ///
    str32 variable ///
    double category ///
    int N ///
    double pct ///
    using "`hybrid_cats'", replace

foreach v in ///
    h_ivs3 h_iat3 h_iadt3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 ///
    h_ietr3 h_ipcs3 h_iedf2 h_iaer2 h_icpf3 h_icpf2 h_ieh3 h_ibpd3 {

    quietly count if !missing(`v')
    local denom = r(N)

    levelsof `v' if !missing(`v'), local(vals)

    foreach c of local vals {
        quietly count if `v' == `c'
        local n = r(N)
        local pct = 100 * `n' / `denom'

        post `catpost' ///
            (`"`v'"') ///
            (`c') ///
            (`n') ///
            (`pct')
    }
}

postclose `catpost'

preserve
    use "`hybrid_cats'", clear
    format pct %9.2f

    export excel using "${cluster_tables}/Table_C15_hybrid_category_distributions.xlsx", ///
        sheet("category_distributions", replace) firstrow(variables)

    save "${cluster_data}/CFI_DPI_hybrid_category_distributions.dta", replace
restore

save "${cluster_data}/CFI_DPI_hybrid_LCA_ready_variables.dta", replace


*-------------------------------------------------------------------------------*
* 7.4 Hybrid response-pattern diagnostics
*-------------------------------------------------------------------------------*

tempfile hybrid_patterns
tempname patternpost

postfile `patternpost' ///
    str20 feature_set ///
    int n_indicators ///
    int N_complete ///
    int n_unique_patterns ///
    int n_singleton_patterns ///
    double pct_obs_in_singletons ///
    int min_pattern_n ///
    int max_pattern_n ///
    using "`hybrid_patterns'", replace


* H1: Core mixed model: vulnerability + competence + formal access/use + onboarding + digitalization + harm
preserve
    egen __miss = rowmiss(h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2)
    gen byte __touse = (__miss == 0)
    count if __touse == 1
    local N_complete = r(N)

    egen __pattern = group(h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2) if __touse == 1
    bysort __pattern: gen __pattern_n = _N if __touse == 1
    egen __tag = tag(__pattern) if __touse == 1

    count if __tag == 1
    local n_unique_patterns = r(N)
    count if __tag == 1 & __pattern_n == 1
    local n_singleton_patterns = r(N)
    count if __touse == 1 & __pattern_n == 1
    local obs_singletons = r(N)
    summarize __pattern_n if __tag == 1, meanonly
    local min_pattern_n = r(min)
    local max_pattern_n = r(max)

    post `patternpost' ///
        ("H1_mixed_core") ///
        (7) ///
        (`N_complete') ///
        (`n_unique_patterns') ///
        (`n_singleton_patterns') ///
        (100 * `obs_singletons' / `N_complete') ///
        (`min_pattern_n') ///
        (`max_pattern_n')
restore


* H2: Core mixed model + trust/norms climate
preserve
    egen __miss = rowmiss(h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2 h_icpf3)
    gen byte __touse = (__miss == 0)
    count if __touse == 1
    local N_complete = r(N)

    egen __pattern = group(h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2 h_icpf3) if __touse == 1
    bysort __pattern: gen __pattern_n = _N if __touse == 1
    egen __tag = tag(__pattern) if __touse == 1

    count if __tag == 1
    local n_unique_patterns = r(N)
    count if __tag == 1 & __pattern_n == 1
    local n_singleton_patterns = r(N)
    count if __touse == 1 & __pattern_n == 1
    local obs_singletons = r(N)
    summarize __pattern_n if __tag == 1, meanonly
    local min_pattern_n = r(min)
    local max_pattern_n = r(max)

    post `patternpost' ///
        ("H2_mixed_plus_trust") ///
        (8) ///
        (`N_complete') ///
        (`n_unique_patterns') ///
        (`n_singleton_patterns') ///
        (100 * `obs_singletons' / `N_complete') ///
        (`min_pattern_n') ///
        (`max_pattern_n')
restore


* H3: Core mixed model excluding harm, adding trust
preserve
    egen __miss = rowmiss(h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_icpf3)
    gen byte __touse = (__miss == 0)
    count if __touse == 1
    local N_complete = r(N)

    egen __pattern = group(h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_icpf3) if __touse == 1
    bysort __pattern: gen __pattern_n = _N if __touse == 1
    egen __tag = tag(__pattern) if __touse == 1

    count if __tag == 1
    local n_unique_patterns = r(N)
    count if __tag == 1 & __pattern_n == 1
    local n_singleton_patterns = r(N)
    count if __touse == 1 & __pattern_n == 1
    local obs_singletons = r(N)
    summarize __pattern_n if __tag == 1, meanonly
    local min_pattern_n = r(min)
    local max_pattern_n = r(max)

    post `patternpost' ///
        ("H3_mixed_noharm_trust") ///
        (7) ///
        (`N_complete') ///
        (`n_unique_patterns') ///
        (`n_singleton_patterns') ///
        (100 * `obs_singletons' / `N_complete') ///
        (`min_pattern_n') ///
        (`max_pattern_n')
restore


* H4: Parsimonious mixed model
preserve
    egen __miss = rowmiss(h_ivs3 h_icdp3 h_iaff3 h_oqi3 h_iurd3 h_iedf2)
    gen byte __touse = (__miss == 0)
    count if __touse == 1
    local N_complete = r(N)

    egen __pattern = group(h_ivs3 h_icdp3 h_iaff3 h_oqi3 h_iurd3 h_iedf2) if __touse == 1
    bysort __pattern: gen __pattern_n = _N if __touse == 1
    egen __tag = tag(__pattern) if __touse == 1

    count if __tag == 1
    local n_unique_patterns = r(N)
    count if __tag == 1 & __pattern_n == 1
    local n_singleton_patterns = r(N)
    count if __touse == 1 & __pattern_n == 1
    local obs_singletons = r(N)
    summarize __pattern_n if __tag == 1, meanonly
    local min_pattern_n = r(min)
    local max_pattern_n = r(max)

    post `patternpost' ///
        ("H4_mixed_parsim") ///
        (6) ///
        (`N_complete') ///
        (`n_unique_patterns') ///
        (`n_singleton_patterns') ///
        (100 * `obs_singletons' / `N_complete') ///
        (`min_pattern_n') ///
        (`max_pattern_n')
restore

postclose `patternpost'

preserve
    use "`hybrid_patterns'", clear
    format pct_obs_in_singletons %9.2f

    export excel using "${cluster_tables}/Table_C16_hybrid_LCA_response_patterns.xlsx", ///
        sheet("response_patterns", replace) firstrow(variables)

    save "${cluster_data}/CFI_DPI_hybrid_LCA_response_patterns.dta", replace
restore


*-------------------------------------------------------------------------------*
* 7.5 Utility program to record hybrid LCA fit and posterior diagnostics
*-------------------------------------------------------------------------------*

capture program drop hyb_lca_record
program define hyb_lca_record
    syntax, MODELID(string) FEATURESET(string) MODELTYPE(string) K(integer) ///
            NINDICATORS(integer) NCOMPLETE(integer) RC(integer) STARTMETHOD(string)

    local converged = 0
    local ll = .
    local df = .
    local aic = .
    local bic = .
    local entropy = .
    local avg_maxpp = .
    local min_class_n = .
    local min_class_pct = .
    local small_class_flag = .
    local note ""

    if `rc' != 0 {
        local note "Model failed"
    }
    else {
        local converged = e(converged)

        if `converged' != 1 {
            local note "Model estimated but did not converge"
        }

        if `converged' == 1 {
            local ll = e(ll)
            local N_est = e(N)

            capture scalar __df_hyb = e(rank)
            if _rc {
                capture scalar __df_hyb = e(k)
                if _rc scalar __df_hyb = .
            }

            local df = scalar(__df_hyb)

            if `ll' < . & `df' < . & `N_est' < . {
                local aic = -2 * `ll' + 2 * `df'
                local bic = -2 * `ll' + ln(`N_est') * `df'
            }

            capture estimates store `modelid'
            capture estimates save "${cluster_models}/`modelid'.ster", replace

            capture drop pp_`modelid'_*
            capture drop cls_`modelid'
            capture drop __maxp __entropy_component

            capture predict double pp_`modelid'_*, classposteriorpr

            if _rc {
                local note "Converged but posterior prediction failed"
            }
            else {
                ds pp_`modelid'_*
                local pvars `r(varlist)'
                local npvars : word count `pvars'

                if `npvars' == `k' {
                    egen double __maxp = rowmax(`pvars')
                    gen byte cls_`modelid' = .

                    forvalues c = 1/`k' {
                        local pcvar : word `c' of `pvars'
                        replace cls_`modelid' = `c' if ///
                            missing(cls_`modelid') & ///
                            abs(`pcvar' - __maxp) < 1e-10 & e(sample)
                    }

                    gen double __entropy_component = 0 if e(sample)

                    foreach p of local pvars {
                        replace __entropy_component = __entropy_component + ///
                            cond(`p' > 0 & `p' < ., `p' * ln(`p'), 0) if e(sample)
                    }

                    summarize __entropy_component if e(sample), meanonly
                    local entropy = 1 + (r(sum) / (`N_est' * ln(`k')))

                    summarize __maxp if e(sample), meanonly
                    local avg_maxpp = r(mean)

                    local min_class_n = .
                    local min_class_pct = .
                    local small_class_flag = 0

                    forvalues c = 1/`k' {
                        count if cls_`modelid' == `c' & e(sample)
                        local modal_n = r(N)
                        local modal_pct = 100 * `modal_n' / `N_est'

                        if missing(`min_class_n') | `modal_n' < `min_class_n' {
                            local min_class_n = `modal_n'
                            local min_class_pct = `modal_pct'
                        }

                        if `modal_n' < 20 | `modal_pct' < 5 {
                            local small_class_flag = 1
                        }
                    }

                    preserve
                        keep if e(sample)
                        keep KEY pp_`modelid'_* cls_`modelid'
                        save "${cluster_data}/posterior_`modelid'.dta", replace
                    restore

                    if `small_class_flag' == 1 {
                        local note "Converged but has small modal class"
                    }
                    else {
                        local note "OK"
                    }
                }
                else {
                    local note "Unexpected number of posterior probability variables"
                }
            }

            capture drop pp_`modelid'_*
            capture drop cls_`modelid'
            capture drop __maxp __entropy_component
        }
    }

    post $HYBLCA_FITPOST ///
        (`"`modelid'"') ///
        (`"`featureset'"') ///
        (`"`modeltype'"') ///
        (`k') ///
        (`nindicators') ///
        (`ncomplete') ///
        (`rc') ///
        (`converged') ///
        (`ll') ///
        (`df') ///
        (`aic') ///
        (`bic') ///
        (`entropy') ///
        (`avg_maxpp') ///
        (`min_class_n') ///
        (`min_class_pct') ///
        (`small_class_flag') ///
        (`"`startmethod'"') ///
        (`"`note'"')

    display as result "`modelid' | rc=`rc' | converged=`converged' | BIC=" ///
        %12.2f `bic' " | entropy=" %6.3f `entropy' ///
        " | min class %=" %6.2f `min_class_pct' " | `note'"
end


*-------------------------------------------------------------------------------*
* 7.6 Estimate hybrid categorical LCA models, k = 2 to 5
*-------------------------------------------------------------------------------*

tempfile hybrid_lca_fit_results
tempname hybfitpost
global HYBLCA_FITPOST "`hybfitpost'"

postfile `hybfitpost' ///
    str20 model_id ///
    str28 feature_set ///
    str70 model_type ///
    byte k ///
    byte n_indicators ///
    int N_complete ///
    int rc ///
    byte converged ///
    double ll ///
    double df ///
    double aic ///
    double bic ///
    double entropy ///
    double avg_max_posterior ///
    int min_class_n ///
    double min_class_pct ///
    byte small_class_flag ///
    str80 start_method ///
    str160 note ///
    using "`hybrid_lca_fit_results'", replace


*===============================================================================*
* H1: Mixed core model
*===============================================================================*

egen __miss_H1 = rowmiss(h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2)
gen byte __touse_H1 = (__miss_H1 == 0)
count if __touse_H1 == 1
local N_H1 = r(N)

display as text "Estimating H1 mixed core LCA models. Complete-case N = `N_H1'"

set seed 6529002
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    if __touse_H1 == 1, ///
    lclass(C 2) ///
    startvalues(randomid, draws(300)) ///
    difficult iterate(5000) nolog
local rc = _rc
hyb_lca_record, modelid("H1_k2") featureset("H1_mixed_core") ///
    modeltype("Hybrid mixed core LCA") k(2) nindicators(7) ///
    ncomplete(`N_H1') rc(`rc') startmethod("randomid_draws300_iter5000")

set seed 6529003
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    if __touse_H1 == 1, ///
    lclass(C 3) ///
    startvalues(randomid, draws(400)) ///
    difficult iterate(6000) nolog
local rc = _rc
hyb_lca_record, modelid("H1_k3") featureset("H1_mixed_core") ///
    modeltype("Hybrid mixed core LCA") k(3) nindicators(7) ///
    ncomplete(`N_H1') rc(`rc') startmethod("randomid_draws400_iter6000")

set seed 6529004
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    if __touse_H1 == 1, ///
    lclass(C 4) ///
    startvalues(randomid, draws(600)) ///
    difficult iterate(8000) nolog
local rc = _rc
hyb_lca_record, modelid("H1_k4") featureset("H1_mixed_core") ///
    modeltype("Hybrid mixed core LCA") k(4) nindicators(7) ///
    ncomplete(`N_H1') rc(`rc') startmethod("randomid_draws600_iter8000")

set seed 6529005
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    if __touse_H1 == 1, ///
    lclass(C 5) ///
    startvalues(randomid, draws(600)) ///
    difficult iterate(8000) nolog
local rc = _rc
hyb_lca_record, modelid("H1_k5") featureset("H1_mixed_core") ///
    modeltype("Hybrid mixed core LCA") k(5) nindicators(7) ///
    ncomplete(`N_H1') rc(`rc') startmethod("randomid_draws600_iter8000")


*===============================================================================*
* H2: Mixed core model + trust/norms climate
*===============================================================================*

egen __miss_H2 = rowmiss(h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2 h_icpf3)
gen byte __touse_H2 = (__miss_H2 == 0)
count if __touse_H2 == 1
local N_H2 = r(N)

display as text "Estimating H2 mixed core + trust LCA models. Complete-case N = `N_H2'"

set seed 6530002
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    (h_icpf3 <-, ologit) ///
    if __touse_H2 == 1, ///
    lclass(C 2) ///
    startvalues(randomid, draws(300)) ///
    difficult iterate(5000) nolog
local rc = _rc
hyb_lca_record, modelid("H2_k2") featureset("H2_mixed_plus_trust") ///
    modeltype("Hybrid mixed core + trust LCA") k(2) nindicators(8) ///
    ncomplete(`N_H2') rc(`rc') startmethod("randomid_draws300_iter5000")

set seed 6530003
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    (h_icpf3 <-, ologit) ///
    if __touse_H2 == 1, ///
    lclass(C 3) ///
    startvalues(randomid, draws(400)) ///
    difficult iterate(6000) nolog
local rc = _rc
hyb_lca_record, modelid("H2_k3") featureset("H2_mixed_plus_trust") ///
    modeltype("Hybrid mixed core + trust LCA") k(3) nindicators(8) ///
    ncomplete(`N_H2') rc(`rc') startmethod("randomid_draws400_iter6000")

set seed 6530004
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    (h_icpf3 <-, ologit) ///
    if __touse_H2 == 1, ///
    lclass(C 4) ///
    startvalues(randomid, draws(600)) ///
    difficult iterate(8000) nolog
local rc = _rc
hyb_lca_record, modelid("H2_k4") featureset("H2_mixed_plus_trust") ///
    modeltype("Hybrid mixed core + trust LCA") k(4) nindicators(8) ///
    ncomplete(`N_H2') rc(`rc') startmethod("randomid_draws600_iter8000")

set seed 6530005
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    (h_icpf3 <-, ologit) ///
    if __touse_H2 == 1, ///
    lclass(C 5) ///
    startvalues(randomid, draws(600)) ///
    difficult iterate(8000) nolog
local rc = _rc
hyb_lca_record, modelid("H2_k5") featureset("H2_mixed_plus_trust") ///
    modeltype("Hybrid mixed core + trust LCA") k(5) nindicators(8) ///
    ncomplete(`N_H2') rc(`rc') startmethod("randomid_draws600_iter8000")


*===============================================================================*
* H3: Mixed model excluding harm, adding trust
*===============================================================================*

egen __miss_H3 = rowmiss(h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_icpf3)
gen byte __touse_H3 = (__miss_H3 == 0)
count if __touse_H3 == 1
local N_H3 = r(N)

display as text "Estimating H3 mixed no-harm + trust LCA models. Complete-case N = `N_H3'"

set seed 6531002
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_icpf3 <-, ologit) ///
    if __touse_H3 == 1, ///
    lclass(C 2) ///
    startvalues(randomid, draws(300)) ///
    difficult iterate(5000) nolog
local rc = _rc
hyb_lca_record, modelid("H3_k2") featureset("H3_mixed_noharm_trust") ///
    modeltype("Hybrid mixed no-harm + trust LCA") k(2) nindicators(7) ///
    ncomplete(`N_H3') rc(`rc') startmethod("randomid_draws300_iter5000")

set seed 6531003
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_icpf3 <-, ologit) ///
    if __touse_H3 == 1, ///
    lclass(C 3) ///
    startvalues(randomid, draws(400)) ///
    difficult iterate(6000) nolog
local rc = _rc
hyb_lca_record, modelid("H3_k3") featureset("H3_mixed_noharm_trust") ///
    modeltype("Hybrid mixed no-harm + trust LCA") k(3) nindicators(7) ///
    ncomplete(`N_H3') rc(`rc') startmethod("randomid_draws400_iter6000")

set seed 6531004
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_icpf3 <-, ologit) ///
    if __touse_H3 == 1, ///
    lclass(C 4) ///
    startvalues(randomid, draws(600)) ///
    difficult iterate(8000) nolog
local rc = _rc
hyb_lca_record, modelid("H3_k4") featureset("H3_mixed_noharm_trust") ///
    modeltype("Hybrid mixed no-harm + trust LCA") k(4) nindicators(7) ///
    ncomplete(`N_H3') rc(`rc') startmethod("randomid_draws600_iter8000")

set seed 6531005
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_icpf3 <-, ologit) ///
    if __touse_H3 == 1, ///
    lclass(C 5) ///
    startvalues(randomid, draws(600)) ///
    difficult iterate(8000) nolog
local rc = _rc
hyb_lca_record, modelid("H3_k5") featureset("H3_mixed_noharm_trust") ///
    modeltype("Hybrid mixed no-harm + trust LCA") k(5) nindicators(7) ///
    ncomplete(`N_H3') rc(`rc') startmethod("randomid_draws600_iter8000")


*===============================================================================*
* H4: Parsimonious mixed model
*===============================================================================*

egen __miss_H4 = rowmiss(h_ivs3 h_icdp3 h_iaff3 h_oqi3 h_iurd3 h_iedf2)
gen byte __touse_H4 = (__miss_H4 == 0)
count if __touse_H4 == 1
local N_H4 = r(N)

display as text "Estimating H4 parsimonious mixed LCA models. Complete-case N = `N_H4'"

set seed 6532002
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    if __touse_H4 == 1, ///
    lclass(C 2) ///
    startvalues(randomid, draws(300)) ///
    difficult iterate(5000) nolog
local rc = _rc
hyb_lca_record, modelid("H4_k2") featureset("H4_mixed_parsim") ///
    modeltype("Hybrid parsimonious mixed LCA") k(2) nindicators(6) ///
    ncomplete(`N_H4') rc(`rc') startmethod("randomid_draws300_iter5000")

set seed 6532003
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    if __touse_H4 == 1, ///
    lclass(C 3) ///
    startvalues(randomid, draws(400)) ///
    difficult iterate(6000) nolog
local rc = _rc
hyb_lca_record, modelid("H4_k3") featureset("H4_mixed_parsim") ///
    modeltype("Hybrid parsimonious mixed LCA") k(3) nindicators(6) ///
    ncomplete(`N_H4') rc(`rc') startmethod("randomid_draws400_iter6000")

set seed 6532004
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    if __touse_H4 == 1, ///
    lclass(C 4) ///
    startvalues(randomid, draws(600)) ///
    difficult iterate(8000) nolog
local rc = _rc
hyb_lca_record, modelid("H4_k4") featureset("H4_mixed_parsim") ///
    modeltype("Hybrid parsimonious mixed LCA") k(4) nindicators(6) ///
    ncomplete(`N_H4') rc(`rc') startmethod("randomid_draws600_iter8000")

set seed 6532005
ereturn clear
capture noisily gsem ///
    (h_ivs3 <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_oqi3 <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    if __touse_H4 == 1, ///
    lclass(C 5) ///
    startvalues(randomid, draws(600)) ///
    difficult iterate(8000) nolog
local rc = _rc
hyb_lca_record, modelid("H4_k5") featureset("H4_mixed_parsim") ///
    modeltype("Hybrid parsimonious mixed LCA") k(5) nindicators(6) ///
    ncomplete(`N_H4') rc(`rc') startmethod("randomid_draws600_iter8000")


postclose `hybfitpost'
macro drop HYBLCA_FITPOST


*-------------------------------------------------------------------------------*
* 7.7 Export hybrid LCA fit summary
*-------------------------------------------------------------------------------*

preserve
    use "`hybrid_lca_fit_results'", clear

    format aic bic %12.2f
    format entropy avg_max_posterior min_class_pct %9.3f

    gen byte report_candidate = ///
        converged == 1 & ///
        inlist(k, 4, 5) & ///
        min_class_pct >= 5 & ///
        entropy >= 0.60

    order model_id feature_set model_type k converged report_candidate ///
          bic aic entropy avg_max_posterior min_class_n min_class_pct ///
          small_class_flag rc start_method note

    export excel using "${cluster_tables}/Table_C17_hybrid_LCA_fit_summary.xlsx", ///
        sheet("fit_summary", replace) firstrow(variables)

    save "${cluster_data}/CFI_DPI_hybrid_LCA_fit_summary.dta", replace

    list model_id feature_set k converged report_candidate bic entropy ///
         avg_max_posterior min_class_pct note, noobs abbreviate(24)
restore


*-------------------------------------------------------------------------------*
* 7.8 Export hybrid LCA class profile tables
*-------------------------------------------------------------------------------*

use "${cluster_data}/CFI_DPI_hybrid_LCA_ready_variables.dta", clear

foreach mid in H1_k2 H1_k3 H1_k4 H1_k5 ///
               H2_k2 H2_k3 H2_k4 H2_k5 ///
               H3_k2 H3_k3 H3_k4 H3_k5 ///
               H4_k2 H4_k3 H4_k4 H4_k5 {

    capture confirm file "${cluster_data}/posterior_`mid'.dta"

    if !_rc {

        preserve

            merge 1:1 KEY using "${cluster_data}/posterior_`mid'.dta", ///
                keep(match) nogen

            capture confirm variable cls_`mid'

            if !_rc {

                gen byte __one = 1

                collapse ///
                    (sum) N = __one ///
                    (mean) ///
                        h_ivs3 ///
                        h_icdp3 ///
                        h_iaff3 ///
                        h_iuof3 ///
                        h_oqi3 ///
                        h_iurd3 ///
                        h_iedf2 ///
                        h_icpf3 ///
                        h_ieh3 ///
                        ivs_score ///
                        iat_score ///
                        iadt_score ///
                        icdp_score ///
                        iaff_score ///
                        iuof_score_01 ///
                        oqi_score_01 ///
                        iurd_score_01 ///
                        ietr_score_01 ///
                        IPCS ///
                        IEDF ///
                        IAER ///
                        ICPF ///
                        IEH ///
                        IBPD ///
                        formal_remittance ///
                        lca2_ivs_high ///
                        lca2_icdp_high ///
                        lca2_iaff_high ///
                        lca2_oqi_good ///
                        lca2_iurd_high ///
                        lca2_iedf_harm ///
                        lca2_icpf_high ///
                        lca2_ieh_adequate, ///
                    by(cls_`mid')

                egen total_N = total(N)
                gen pct = 100 * N / total_N
                drop total_N

                format pct %9.2f

                order cls_`mid' N pct ///
                    h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 ///
                    h_iedf2 h_icpf3 h_ieh3 ///
                    ivs_score iat_score iadt_score icdp_score iaff_score ///
                    iuof_score_01 oqi_score_01 iurd_score_01 ietr_score_01 ///
                    IPCS IEDF IAER ICPF IEH IBPD formal_remittance ///
                    lca2_ivs_high lca2_icdp_high lca2_iaff_high ///
                    lca2_oqi_good lca2_iurd_high lca2_iedf_harm ///
                    lca2_icpf_high lca2_ieh_adequate

                export excel using "${cluster_tables}/Table_C18_hybrid_LCA_class_profiles.xlsx", ///
                    sheet("`mid'", replace) firstrow(variables)
            }

        restore
    }
}


*-------------------------------------------------------------------------------*
* 7.9 Create hybrid LCA assignment dataset
*-------------------------------------------------------------------------------*

use "${cluster_data}/CFI_DPI_hybrid_LCA_ready_variables.dta", clear

foreach mid in H1_k2 H1_k3 H1_k4 H1_k5 ///
               H2_k2 H2_k3 H2_k4 H2_k5 ///
               H3_k2 H3_k3 H3_k4 H3_k5 ///
               H4_k2 H4_k3 H4_k4 H4_k5 {

    capture confirm file "${cluster_data}/posterior_`mid'.dta"

    if !_rc {
        merge 1:1 KEY using "${cluster_data}/posterior_`mid'.dta", ///
            keep(master match) nogen
    }
}

save "${cluster_data}/CFI_DPI_hybrid_LCA_assignments.dta", replace


*-------------------------------------------------------------------------------*
* 7.10 End-of-section message
*-------------------------------------------------------------------------------*

display as text "------------------------------------------------------------"
display as text "Hybrid distribution-informed categorical LCA completed."
display as text "Review the following outputs:"
display as text "1. Table_C14_hybrid_variable_distribution_diagnostics.xlsx"
display as text "2. Table_C15_hybrid_category_distributions.xlsx"
display as text "3. Table_C16_hybrid_LCA_response_patterns.xlsx"
display as text "4. Table_C17_hybrid_LCA_fit_summary.xlsx"
display as text "5. Table_C18_hybrid_LCA_class_profiles.xlsx"
display as text "6. CFI_DPI_hybrid_LCA_assignments.dta"
display as text "------------------------------------------------------------"

}

*-------------------------------------------------------------------------------*
* 9. ESTIMATE FINAL PREFERRED LCA MODEL
*-------------------------------------------------------------------------------*
{
/*
    Preferred specification:
    Hybrid mixed core LCA, k = 4 classes.

    Selected model:
    H1_k4

    Class-defining indicators:
        h_ivs3     Socioeconomic vulnerability tertile
        h_icdp3    Practical digital competence tertile
        h_iaff3    Formal financial access tertile
        h_iuof3    Financial operability tertile
        h_oqi3     Onboarding quality tertile
        h_iurd3    Digital remittance intensity tertile
        h_iedf2    Above-median fraud / recourse harm

    Measurement treatment:
        h_ivs3     ologit
        h_icdp3    ologit
        h_iaff3    ologit
        h_iuof3    ologit
        h_oqi3     ologit
        h_iurd3    ologit
        h_iedf2    logit

    This block re-estimates the preferred model cleanly and produces:
        - final posterior probabilities
        - most likely latent class
        - classification certainty indicators
        - final fit table
        - posterior-certainty table
        - analysis dataset with LCA classes
*/

*-------------------------------------------------------------------------------*
* 9.0 Load hybrid LCA-ready dataset
*-------------------------------------------------------------------------------*

use "${cluster_data}/CFI_DPI_hybrid_LCA_ready_variables.dta", clear

count
display as text "Final LCA analytical sample N = " r(N)

capture confirm variable KEY
if _rc {
    gen str20 KEY = string(_n)
    label var KEY "Fallback unique respondent ID"
}

isid KEY


*-------------------------------------------------------------------------------*
* 9.1 Verify required final LCA indicators
*-------------------------------------------------------------------------------*

foreach v in h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2 {
    capture confirm variable `v'
    if _rc {
        display as error "Required final LCA indicator missing: `v'"
        exit 111
    }
}

misstable summarize h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2

egen final_lca_miss = rowmiss(h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2)
gen byte final_lca_sample = (final_lca_miss == 0)
label var final_lca_sample "Complete-case sample for final preferred hybrid LCA"

count if final_lca_sample == 1
local final_N = r(N)

display as text "Complete-case N for final preferred LCA = `final_N'"


*-------------------------------------------------------------------------------*
* 9.2 Estimate final preferred H1_k4 hybrid LCA model - reproducibility locked
*-------------------------------------------------------------------------------*

* Ensure stable observation order before estimation and posterior assignment
sort KEY

* Optional but useful for sort-related reproducibility if supported by Stata version
capture set sortseed 6529004

set seed 6529004
estimates clear

gsem ///
    (h_ivs3  <-, ologit) ///
    (h_icdp3 <-, ologit) ///
    (h_iaff3 <-, ologit) ///
    (h_iuof3 <-, ologit) ///
    (h_oqi3  <-, ologit) ///
    (h_iurd3 <-, ologit) ///
    (h_iedf2 <-, logit) ///
    if final_lca_sample == 1, ///
    lclass(C 4) ///
    startvalues(randomid, draws(600) seed(6529004)) ///
    difficult ///
    iterate(8000) ///
    nolog

estimates store lca_final_hybrid_H1_k4
estimates save "${cluster_models}/lca_final_hybrid_H1_k4.ster", replace


*-------------------------------------------------------------------------------*
* 9.3 Display official post-estimation outputs in Stata log
*-------------------------------------------------------------------------------*

display as text "------------------------------------------------------------"
display as text "Final LCA model: class probabilities"
display as text "------------------------------------------------------------"
estat lcprob

display as text "------------------------------------------------------------"
display as text "Final LCA model: latent class means / response summaries"
display as text "------------------------------------------------------------"
capture noisily estat lcmean

display as text "------------------------------------------------------------"
display as text "Final LCA model: information criteria"
display as text "------------------------------------------------------------"
estat ic


*-------------------------------------------------------------------------------*
* 9.4 Predict posterior probabilities and assign most likely class
*-------------------------------------------------------------------------------*

capture drop classpost1 classpost2 classpost3 classpost4
capture drop maxpost lca_class uncertain_class high_certainty_class medium_certainty_class
capture drop posterior_margin posterior_secondmax

predict double classpost*, classposteriorpr

label var classpost1 "Posterior probability: final LCA class 1"
label var classpost2 "Posterior probability: final LCA class 2"
label var classpost3 "Posterior probability: final LCA class 3"
label var classpost4 "Posterior probability: final LCA class 4"

egen double maxpost = rowmax(classpost1 classpost2 classpost3 classpost4)
label var maxpost "Maximum posterior probability for assigned final LCA class"

gen byte lca_class = .
replace lca_class = 1 if final_lca_sample == 1 & maxpost == classpost1
replace lca_class = 2 if final_lca_sample == 1 & maxpost == classpost2 & missing(lca_class)
replace lca_class = 3 if final_lca_sample == 1 & maxpost == classpost3 & missing(lca_class)
replace lca_class = 4 if final_lca_sample == 1 & maxpost == classpost4 & missing(lca_class)

label define lca_class_lbl ///
    1 "Raw LCA class 1" ///
    2 "Raw LCA class 2" ///
    3 "Raw LCA class 3" ///
    4 "Raw LCA class 4", replace

label values lca_class lca_class_lbl
label var lca_class "Raw most likely class from final preferred hybrid LCA"

gen byte uncertain_class = maxpost < 0.60 if final_lca_sample == 1
gen byte high_certainty_class = maxpost >= 0.80 if final_lca_sample == 1
gen byte medium_certainty_class = maxpost >= 0.60 & maxpost < 0.80 if final_lca_sample == 1

label var uncertain_class "Classification uncertainty: max posterior probability < 0.60"
label var high_certainty_class "High-certainty classification: max posterior probability >= 0.80"
label var medium_certainty_class "Medium-certainty classification: max posterior probability 0.60-0.79"

egen double posterior_secondmax = rowmax(classpost1 classpost2 classpost3 classpost4)
replace posterior_secondmax = . if posterior_secondmax == maxpost

forvalues c = 1/4 {
    replace posterior_secondmax = classpost`c' if ///
        classpost`c' < maxpost & ///
        (missing(posterior_secondmax) | classpost`c' > posterior_secondmax) & ///
        final_lca_sample == 1
}

gen double posterior_margin = maxpost - posterior_secondmax if final_lca_sample == 1
label var posterior_margin "Posterior probability margin between assigned and second-best class"


*-------------------------------------------------------------------------------*
* 9.5 Create final model fit table - corrected base version
*-------------------------------------------------------------------------------*

/*
    This block creates the base fit table using only quantities available
    immediately after model estimation.

    Entropy, average posterior probability, posterior margins, and class-size
    diagnostics are added later in Section 9.7 after posterior probabilities
    are predicted and processed.
*/

preserve

    clear
    set obs 1

    gen str40 model_id = "lca_final_hybrid_H1_k4"
    gen str80 model_description = "Final preferred hybrid mixed core LCA"
    gen byte k_classes = 4
    gen byte n_indicators = 7
    gen int N = `final_N'

    gen double log_likelihood = e(ll)

    capture scalar __df_final = e(rank)
    if _rc {
        capture scalar __df_final = e(k)
        if _rc scalar __df_final = .
    }

    gen double df = scalar(__df_final)
    gen double AIC = -2 * log_likelihood + 2 * df
    gen double BIC = -2 * log_likelihood + ln(N) * df
    gen byte converged = e(converged)

    gen str140 lca_inputs = "h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2"
    gen str140 measurement = "ologit ologit ologit ologit ologit ologit logit"
    gen str80 start_method = "randomid, draws(600), seed(6529004)"
    gen int max_iterations = 8000
    gen long seed = 6529004
    gen byte selected_model = 1

    format log_likelihood AIC BIC %12.3f

    order model_id model_description selected_model k_classes n_indicators N ///
          log_likelihood df AIC BIC converged seed start_method max_iterations ///
          lca_inputs measurement

    tempfile final_fit_base
    save "`final_fit_base'", replace

restore


*-------------------------------------------------------------------------------*
* 9.6 Posterior-certainty diagnostics
*-------------------------------------------------------------------------------*

preserve

    keep if final_lca_sample == 1

    gen byte __one = 1

    collapse ///
        (sum) N = __one ///
        (mean) mean_maxpost = maxpost ///
        (mean) mean_posterior_margin = posterior_margin ///
        (mean) share_uncertain = uncertain_class ///
        (mean) share_medium_certainty = medium_certainty_class ///
        (mean) share_high_certainty = high_certainty_class ///
        (min) min_maxpost = maxpost ///
        (p25) p25_maxpost = maxpost ///
        (p50) median_maxpost = maxpost ///
        (p75) p75_maxpost = maxpost ///
        (max) max_maxpost = maxpost, ///
        by(lca_class)

    egen total_N = total(N)
    gen class_pct = 100 * N / total_N

    format class_pct %9.2f
    format mean_maxpost mean_posterior_margin share_uncertain ///
           share_medium_certainty share_high_certainty ///
           min_maxpost p25_maxpost median_maxpost p75_maxpost max_maxpost %9.3f

    label var N "Number of respondents assigned to class"
    label var class_pct "Class share of analytical sample (%)"
    label var mean_maxpost "Mean maximum posterior probability"
    label var mean_posterior_margin "Mean posterior probability margin"
    label var share_uncertain "Share with max posterior probability < 0.60"
    label var share_medium_certainty "Share with max posterior probability 0.60-0.79"
    label var share_high_certainty "Share with max posterior probability >= 0.80"

    order lca_class N class_pct mean_maxpost mean_posterior_margin ///
          share_uncertain share_medium_certainty share_high_certainty ///
          min_maxpost p25_maxpost median_maxpost p75_maxpost max_maxpost

    export excel using "${cluster_tables}/Table_C8_posterior_certainty.xlsx", ///
        sheet("by_class", replace) firstrow(variables)

    tempfile posterior_by_class
    save "`posterior_by_class'", replace

restore


preserve

    keep if final_lca_sample == 1

    gen byte __one = 1
    gen double __entropy_component = 0

    foreach p in classpost1 classpost2 classpost3 classpost4 {
        replace __entropy_component = __entropy_component + ///
            cond(`p' > 0 & `p' < ., `p' * ln(`p'), 0)
    }

    quietly summarize __entropy_component, meanonly
    scalar final_entropy = 1 + (r(sum) / (`final_N' * ln(4)))

    quietly summarize maxpost, meanonly
    scalar final_avg_maxpost = r(mean)

    quietly summarize posterior_margin, meanonly
    scalar final_avg_margin = r(mean)

    quietly count if uncertain_class == 1
    scalar final_N_uncertain = r(N)
    scalar final_pct_uncertain = 100 * r(N) / `final_N'

    quietly count if high_certainty_class == 1
    scalar final_N_high_certainty = r(N)
    scalar final_pct_high_certainty = 100 * r(N) / `final_N'

    quietly tab lca_class, matcell(__class_counts)
    mata: st_numscalar("final_min_class_n", min(st_matrix("__class_counts")))
    scalar final_min_class_pct = 100 * final_min_class_n / `final_N'

    clear
    set obs 1

    gen str40 model_id = "lca_final_hybrid_H1_k4"
    gen int N = `final_N'
    gen double entropy = scalar(final_entropy)
    gen double avg_max_posterior = scalar(final_avg_maxpost)
    gen double avg_posterior_margin = scalar(final_avg_margin)
    gen double min_class_n = scalar(final_min_class_n)
    gen double min_class_pct = scalar(final_min_class_pct)
    gen double N_uncertain = scalar(final_N_uncertain)
    gen double pct_uncertain = scalar(final_pct_uncertain)
    gen double N_high_certainty = scalar(final_N_high_certainty)
    gen double pct_high_certainty = scalar(final_pct_high_certainty)

    format entropy avg_max_posterior avg_posterior_margin min_class_pct ///
           pct_uncertain pct_high_certainty %9.3f

    export excel using "${cluster_tables}/Table_C8_posterior_certainty.xlsx", ///
        sheet("overall", replace) firstrow(variables)

    tempfile posterior_overall
    save "`posterior_overall'", replace

restore


*-------------------------------------------------------------------------------*
* 9.7 Complete final fit table with entropy and posterior diagnostics
*-------------------------------------------------------------------------------*

preserve

    use "`final_fit_base'", clear

    gen double entropy = scalar(final_entropy)
    gen double avg_max_posterior = scalar(final_avg_maxpost)
    gen double avg_posterior_margin = scalar(final_avg_margin)
    gen double min_class_n = scalar(final_min_class_n)
    gen double min_class_pct = scalar(final_min_class_pct)
    gen double pct_uncertain = scalar(final_pct_uncertain)
    gen double pct_high_certainty = scalar(final_pct_high_certainty)

    format log_likelihood AIC BIC %12.3f
    format entropy avg_max_posterior avg_posterior_margin ///
           min_class_pct pct_uncertain pct_high_certainty %9.3f

    order model_id model_description selected_model k_classes n_indicators N ///
          log_likelihood df AIC BIC converged entropy avg_max_posterior ///
          avg_posterior_margin min_class_n min_class_pct pct_uncertain ///
          pct_high_certainty seed start_method max_iterations ///
          lca_inputs measurement

    export excel using "${cluster_tables}/Table_C7_final_lca_fit.xlsx", ///
        sheet("final_fit", replace) firstrow(variables)

    save "${cluster_data}/CFI_DPI_final_lca_fit_summary.dta", replace

restore


*-------------------------------------------------------------------------------*
* 9.8 Save final dataset with LCA classes and posterior probabilities
*-------------------------------------------------------------------------------*

compress

order KEY final_lca_sample lca_class classpost1 classpost2 classpost3 classpost4 ///
      maxpost posterior_secondmax posterior_margin ///
      uncertain_class medium_certainty_class high_certainty_class, first

save "${cluster_data}/CFI_DPI_Data_with_LCA_classes.dta", replace

export excel using "${cluster_data}/CFI_DPI_Data_with_LCA_classes.xlsx", ///
    sheet("data_with_lca_classes", replace) firstrow(variables)


*-------------------------------------------------------------------------------*
* 9.9 Console summary
*-------------------------------------------------------------------------------*

display as text "------------------------------------------------------------"
display as text "SECTION 9 COMPLETED: FINAL PREFERRED HYBRID LCA MODEL"
display as text "Model: H1_k4"
display as text "N = `final_N'"
display as text "Entropy = " %6.3f scalar(final_entropy)
display as text "Average max posterior probability = " %6.3f scalar(final_avg_maxpost)
display as text "Minimum class N = " %6.0f scalar(final_min_class_n)
display as text "Minimum class % = " %6.2f scalar(final_min_class_pct)
display as text "Uncertain classifications, maxpost < 0.60: " %6.2f scalar(final_pct_uncertain) "%"
display as text "High-certainty classifications, maxpost >= 0.80: " %6.2f scalar(final_pct_high_certainty) "%"
display as text "Outputs created:"
display as text "1. ${cluster_data}/CFI_DPI_Data_with_LCA_classes.dta"
display as text "2. ${cluster_data}/CFI_DPI_Data_with_LCA_classes.xlsx"
display as text "3. ${cluster_tables}/Table_C7_final_lca_fit.xlsx"
display as text "4. ${cluster_tables}/Table_C8_posterior_certainty.xlsx"
display as text "5. ${cluster_models}/lca_final_hybrid_H1_k4.ster"
display as text "------------------------------------------------------------"
}









}