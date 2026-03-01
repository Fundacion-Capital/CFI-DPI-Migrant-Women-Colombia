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

*Edad
summarize q4, detail
local med = r(p50) // Guarda la mediana

hist q4, percent kdensity ///
    title("Distribución de Edad") ///
    xtitle("Años") ytitle("Porcentaje") ///
    xline(`med', lcolor(red) lwidth(medium)) ///
    note("Línea roja indica la mediana: `med' años")

graph box q4, title("Distribución de Edad") ytitle("Años")

*Residencia
tab q3
graph pie, over(q3) sort ///
    plabel(_all percent, format(%2.0f) size(medium) color(white)) ///
    title("Distribución por Departamento/Ciudad") ///
    legend(region(lcolor(none))) ///
    note("Fuente: Elaboración propia basada en q3")



*2.2 Migration trajectory and human capital

*2.3 Socioeconomic vulnerability indicator (IVS)

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

4.1 Empirical strategy (descriptive-causal boundary)

4.2 Outcomes (dependent variables) — recommended core set

4.3 Predictors (key independent variables)

4.4 Core regression specifications (report-ready templates)

4.5 Heterogeneity and interactions (policy-relevant cuts)

4.6 Presentation of regression results

*---------------------------------------*
*		III. Análisis de cluster   		*
*---------------------------------------*


5.1 Objective and conceptual framing

5.2 Feature selection for clustering (what goes in)

5.3 Pre-processing

5.4 Choosing number of clusters

5.5 Cluster interpretation and labeling

5.6 Comparing clusters on key outcomes and risks

5.7 Deliverable: “5-profile typology” (report-ready)

