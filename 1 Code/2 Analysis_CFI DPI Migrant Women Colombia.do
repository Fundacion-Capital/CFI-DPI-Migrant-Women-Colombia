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
* Distribution of Financial Usage Score (IUOF)
twoway (hist iuof_score_01, width(0.05) start(0) color("120 120 120%60") lcolor(white)) ///
       (kdensity iuof_score_01, lcolor("58 103 177") lwidth(medium)), ///
    title("", size(medium)) ///
    xtitle("Index Score (0-1)", size(small)) ///
    ytitle("Density", size(small)) ///
    xlabel(0(0.2)1, labsize(small)) ///
    legend(off) ///
    graphregion(color(white)) scheme(plotplain)
graph export "${output_dir}/fig19_iuof_distrib.png", replace



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
    xtitle("Onboarding Quality Index (IFO) (0-1)", size(small)) /// 
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
    xtitle("Onboarding Quality Index (IFO) (0-1)", size(small)) ///
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



*3.8 Fraud, safety behaviors, and recourse — IPCS & IEDF



*3.9 Trust, autonomy, and social norms — IAER & ICPF



*3.10 Barriers, enabling environment, and program exposure — IEH & IBPD







*-------------------------------------------*
*		II. Análisis con regresiones  		*
*-------------------------------------------*

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

