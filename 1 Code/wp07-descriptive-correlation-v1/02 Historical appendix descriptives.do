* Historical Appendix C1/D1/D2: use only the verified final-segment carrier.
* Report aggregate bases in Results; do not save, export or change the data.
exit 198

set varabbrev off

* C1: each row has its own nonmissing N. This is not C2's complete-case N.
local indices ivs_score iat_score iadt_score icdp_score iaff_score ///
    iuof_score_01 oqi_score_01 iurd_score_01 ietr_score_01 IPCS IEDF IAER ICPF IEH IBPD
tabstat `indices', statistics(n mean sd min p25 p50 p75 max) columns(statistics) varwidth(32)

* D1: replicate the observed numeric nonmissing denominator of each item.
* Legacy sentinel codes may be in that denominator; this is not a valid-response map.
local items age_cat q3 q2_2 q2_3 years_cat q3_1 q3_5 q4_5 q4_6 q6_4 ///
    q7_1 q7_11 q10_10 q10_13
confirm numeric variable `items', exact
foreach item of local items {
    quietly count if !missing(`item')
    local denominator = r(N)
    display as text "`item' D1 nonmissing N: " as result `denominator'
    if `denominator' > 0 {
        tabulate `item'
    }
}

* D2: each dummy uses its own nonmissing N; multiple selections can coexist.
* Do not import this convention into the academic route-aware analysis.
local dummies q4_12_1 q4_12_2 q4_12_3 q4_12_4 ///
    q10_3_1 q10_3_2 q10_3_3 q10_3_4 q10_3_5 ///
    q10_3_6 q10_3_7 q10_3_8 q10_3_9 q10_3_10
confirm numeric variable `dummies', exact
foreach item of local dummies {
    quietly count if !missing(`item')
    local denominator = r(N)
    quietly count if `item' == 1
    display as text "`item' D2 yes / nonmissing: " as result r(N) " / " `denominator'
    if `denominator' > 0 {
        display as text "Percent: " as result 100*r(N)/`denominator'
    }
}
