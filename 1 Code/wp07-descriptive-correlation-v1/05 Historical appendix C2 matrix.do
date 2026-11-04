* Appendix C2: 15 scores on the verified final-segment carrier.
* This is not Figure C2's matrix, which came from the LCA base sample.
exit 198

local indices ivs_score iat_score iadt_score icdp_score iaff_score ///
    iuof_score_01 oqi_score_01 iurd_score_01 ietr_score_01 IPCS IEDF IAER ICPF IEH IBPD
confirm numeric variable `indices', exact
* Stata correlate drops rows missing any of the listed variables.
correlate `indices'
display as text "Appendix C2 complete-case N: " as result r(N)
