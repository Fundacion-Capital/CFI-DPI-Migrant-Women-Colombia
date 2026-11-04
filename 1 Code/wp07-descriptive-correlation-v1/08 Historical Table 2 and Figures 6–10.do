* Only on the exact old-state projection named in the protected descriptive replay.
* The newer descriptive carrier and the academic scores are not substitutes.
exit 198

confirm numeric variable ivs_score ivs_cat iat_score iat_cat ///
    q3 age_cat q3_1 q3_5 q3_8, exact

* Figure 6: declared half-open 0.05 bins for the count comparison.
* The top endpoint belongs to the last bin. These are not renderer defaults.
summarize ivs_score, detail
count if !missing(ivs_score) & !inrange(ivs_score, 0, 1)
forvalues bin = 0/19 {
    quietly count if ivs_score >= `bin'/20 & ///
        (ivs_score < (`bin'+1)/20 | (`bin' == 19 & ivs_score == 1))
    display as text "Figure 6 bin " (`bin'+1) " N: " as result r(N)
}

* Word Figure 7 is age (file fig8); Word Figure 8 is residence (file fig7).
tabulate age_cat ivs_cat, row
tabulate q3 ivs_cat, row
* Figure 9 conditions device type on reported internet frequency.
tabulate q3_5 q3_1, row
* Figure 10 retains explicit N/A (99) in the plotted denominator.
tabulate q3_8
count if missing(q3_8)

* Table 2: row percentages and IAT means by IVS group are distinct targets.
tabulate ivs_cat iat_cat, row
tabulate ivs_cat, summarize(iat_score)
