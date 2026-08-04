# Interaction specifications

This is a display-only rendering of [the authoritative Stata table export](../Table_E10_Interactions.txt).

```text
	(1)	(2)	(3)	(4)
VARIABLES	I1: IVS x IAT -> IURD	I2: Years x IAFF -> Formal channel	I3: ICDP x OQI -> IETR	I4: IEDF x ICPF -> IURD
				
2.age_cat	-0.067***	0.704	0.010	-0.066***
	(0.022)	(0.204)	(0.015)	(0.022)
3.age_cat	-0.057**	0.744	0.018	-0.056**
	(0.025)	(0.242)	(0.017)	(0.025)
4.age_cat	-0.032	0.499	-0.015	-0.026
	(0.052)	(0.353)	(0.033)	(0.054)
2.q3	-0.077**	0.489**	0.060***	-0.076**
	(0.030)	(0.178)	(0.021)	(0.030)
3.q3	-0.095***	0.799	0.050**	-0.095***
	(0.033)	(0.263)	(0.022)	(0.034)
4.q3	-0.108***	0.544	0.018	-0.105***
	(0.035)	(0.203)	(0.026)	(0.035)
ivs_score	-0.302		-0.022	-0.228***
	(0.259)		(0.048)	(0.067)
iat_score	0.025	3.268		0.085
	(0.224)	(3.112)		(0.080)
c.ivs_score#c.iat_score	0.100			
	(0.335)			
icdp_score	0.163***	4.368**	-0.094	0.163***
	(0.059)	(3.180)	(0.145)	(0.059)
iaff_score	0.107**	22.790**	0.034	0.113**
	(0.045)	(32.154)	(0.032)	(0.046)
oqi_score_01	0.150*	0.736	0.287**	0.149*
	(0.077)	(0.556)	(0.145)	(0.077)
IEDF	0.000		-0.001*	0.001
	(0.000)		(0.000)	(0.001)
IEH	0.001*	1.007	0.001***	0.001*
	(0.000)	(0.005)	(0.000)	(0.000)
formal_remittance		.		
		(.)		
years_in_col		1.338*		
		(0.208)		
c.years_in_col#c.iaff_score		0.662*		
		(0.140)		
c.icdp_score#c.oqi_score_01			0.045	
			(0.191)	
ICPF				0.000
				(0.001)
c.IEDF#c.ICPF				-0.000
				(0.000)
Constant	0.430**	0.033***	0.493***	0.354***
	(0.180)	(0.040)	(0.112)	(0.112)
				
Observations	423	402	423	423
R-squared	0.274		0.238	0.276
City FE	Yes	Yes	Yes	Yes
Robust SE	Yes	Yes	Yes	Yes
Estimator		Logit OR		
Robust standard errors in parentheses				
*** p<0.01, ** p<0.05, * p<0.1
```
