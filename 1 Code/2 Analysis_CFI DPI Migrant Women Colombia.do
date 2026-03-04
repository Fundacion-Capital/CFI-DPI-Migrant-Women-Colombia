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
	clear
	use "${output_dir}/CFI_DPI Data for analysis.dta", replace

*---------------------------------------*
*		I. Análisis descriptivo  		*
*---------------------------------------*

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
    legend(off) // Oculta la leyenda del addplot

graph export "${output_dir}/hist_edad.png", replace

graph box q4, title("Distribución de Edad") ytitle("Años")

*Residencia
* Definición de colores
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
    plotregion(color(white) margin(large))

graph export "${output_dir}/pie_residence.png", replace



*2.2 Migration trajectory and human capital

	*Years in Colombia
kdensity years_in_col, ///
	title("") ///
    lcolor(navy) lwidth(medium) ///
    xtitle("Years in Colombia", size(small)) ///
    ytitle("Density", size(small)) ///
    graphregion(color(white)) plotregion(color(white))
graph export "${output_dir}/density_years_in_col.png", replace


	*Education

graph hbar (percent), over(q2_2, sort(1) descending) ///
    blabel(bar, format(%2.1f) size(vsmall)) /// Mostrar decimal
    bar(1, color("58 103 177")) /// Azul consistente
    ytitle("Percentage (%)", size(small)) ///
    graphregion(color(white)) plotregion(color(white))
graph export "${output_dir}/bar_education.png", replace

	*Occupation
graph hbar (percent), over(q2_3, sort(1) descending) ///
    blabel(bar, format(%2.1f) size(vsmall)) ///
    bar(1, color("245 130 48")) /// Naranja consistente
    ytitle("Percentage (%)", size(small)) ///
    graphregion(color(white)) plotregion(color(white))
graph export "${output_dir}/bar_occupation.png", replace

	




*2.3 Socioeconomic vulnerability indicator (IVS)

twoway (hist ivs_score, width(0.05) color(gray%50) lcolor(white)) ///
       (kdensity ivs_score, lcolor(navy) lwidth(medthick)), ///
    xtitle("Socioeconomic Vulnerability Index (0-1)", size(small)) ///
    ytitle("Density / Frequency", size(small)) ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white))
graph export "${output_dir}/ivs_distribution_apa.png", replace




*IVS x City
graph bar, over(ivs_cat) over(q3) stack asyvars percent ///
    bar(1, color("58 103 177%80")) /// Low: Azul
    bar(2, color("167 169 172%80")) /// Medium: Gris
    bar(3, color("245 130 48%80")) /// High: Naranja
    ytitle("Percentage (%)", size(small)) ///
    legend(title("SVI Level", size(small)) position(3) cols(1) size(small) region(lcolor(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    blabel(bar, pos(center) format(%2.0f) color(white) size(vsmall))

graph export "${output_dir}/ivs_by_city.png", replace

*IVS x Age Category
graph bar, over(ivs_cat) over(age_cat) stack asyvars percent ///
    bar(1, color("58 103 177%80")) /// 
    bar(2, color("167 169 172%80")) /// 
    bar(3, color("245 130 48%80")) /// 
    ytitle("Percentage (%)", size(small)) ///
    legend(title("SVI Level", size(small)) position(3) cols(1) size(small) region(lcolor(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    blabel(bar, pos(center) format(%2.0f) color(white) size(vsmall))

graph export "${output_dir}/ivs_by_age.png", replace




*3.1 Digital access and telecom constraints (Section C0) — IAT

*3.2 Perceived transactional digital self-efficacy (Section C1) — IADT

*3.3 Practical digital competence for payments/security (Section C2) — ICDP

*3.4 Formal access constraints: documents, proof of address, phone registration, account ownership (Section C3) — IAFF

*3.5 Usage and operability of financial tools (C3 continued) — IUOF

*3.6 Awareness and usage of payment rails + onboarding experience (Section C4)

*3.7 Remittances: channels, formalization, intensity, and user experience (Section D) — IURD & IETR

*3.8 Fraud, safety behaviors, and recourse (Section E) — IPCS & IEDF

*3.9 Trust, autonomy, and social norms (Section F) — IAER & ICPF

*3.10 Barriers, enabling environment, and program exposure (Section G) — IEH & IBPD







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

