# Supplementary item-level models

This is a display-only rendering of [the authoritative Stata table export](../Table_E11_Supplementary_Items.txt).

```text
	(1)	(2)	(3)	(4)	(5)	(6)	(7)
VARIABLES	Recent digital use	Recent digital problem	Fees clearly visible	Provider info clear	Feels secure	Any payment problem	High autonomy (binary)
							
recent_digital_use	.						
	(.)						
2.age_cat	0.548	1.073	1.138	2.634**	0.920	1.179	0.988
	(0.273)	(0.466)	(0.394)	(1.049)	(0.468)	(0.368)	(0.324)
3.age_cat	0.646	1.204	2.203*	4.345***	2.391	0.835	1.696
	(0.372)	(0.568)	(0.997)	(2.403)	(1.456)	(0.299)	(0.695)
4.age_cat	1.217	1.261	0.776	1.014	2.626		2.719
	(1.281)	(1.710)	(0.671)	(1.385)	(4.484)		(1.892)
2.q3	0.246***	1.841	0.689	0.893	0.728	0.820	0.222***
	(0.126)	(0.886)	(0.321)	(0.484)	(0.550)	(0.341)	(0.083)
3.q3	0.396*	0.643	0.868	2.911	0.850	0.605	0.385**
	(0.188)	(0.312)	(0.446)	(1.998)	(0.541)	(0.257)	(0.152)
4.q3	0.612	3.362*	0.236***	0.495	0.449	1.153	0.906
	(0.355)	(2.298)	(0.122)	(0.290)	(0.249)	(0.531)	(0.412)
ivs_score	1.557	0.458	0.182	2.434	0.180	1.063	0.200
	(2.311)	(0.687)	(0.225)	(3.212)	(0.248)	(0.953)	(0.228)
iat_score	5.513	0.239	1.565	1.641	387.441***	0.036***	
	(7.875)	(0.344)	(1.994)	(2.740)	(682.127)	(0.038)	
icdp_score	1.411	78.785***	0.167*	0.081**	2.261	80.741***	
	(1.241)	(120.007)	(0.171)	(0.097)	(2.290)	(86.677)	
iaff_score	1.428	0.058***	0.267**	0.203*			1.416
	(1.202)	(0.048)	(0.179)	(0.184)			(0.927)
oqi_score_01	75.035***	0.024***	68.950***	39.815***	121.854***	0.040***	
	(83.055)	(0.034)	(80.663)	(51.814)	(130.735)	(0.036)	
IEDF	0.994	1.093***			1.008		0.989*
	(0.009)	(0.014)			(0.009)		(0.006)
IEH	1.012	1.014*	1.039***	1.050***	1.011	1.015***	0.995
	(0.009)	(0.008)	(0.008)	(0.011)	(0.010)	(0.005)	(0.007)
digital_problem		.					
		(.)					
fee_visible			.				
			(.)				
provider_info_clear				.			
				(.)			
feels_secure					.		
					(.)		
any_payment_problem						.	
						(.)	
4o.age_cat						-	
							
high_autonomy							.
							(.)
iurd_score_01							0.889
							(0.693)
ICPF							1.061***
							(0.009)
Constant	0.090	0.143	0.327	0.234	0.005***	0.630	0.496
	(0.173)	(0.270)	(0.605)	(0.402)	(0.009)	(0.767)	(0.591)
							
Observations	413	360	336	368	423	391	423
City FE	Yes	Yes	Yes	Yes	Yes	Yes	Yes
Robust SE	Yes	Yes	Yes	Yes	Yes	Yes	Yes
Estimator	Logit OR	Logit OR	Logit OR	Logit OR	Logit OR	Logit OR	Logit OR
Robust seeform in parentheses							
*** p<0.01, ** p<0.05, * p<0.1
```
