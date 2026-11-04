* WP07: report the prepared academic fields without redefining them.
* Input is the independently verified preparation output already in memory.
exit 198

version 16
set varabbrev off
confirm numeric variable wp07_known_form eligible_flag wp07_residence ///
    wp07_remit_disposition wp07_domestic_60d wp07_domestic_ops_bin, exact

* Keep the admitted denominator visible. The recorded gate is not proof of routing.
count
count if wp07_known_form == 1 & eligible_flag == 1
tabulate wp07_residence, missing
assert missing(wp07_remit_disposition) | inlist(wp07_remit_disposition, 1, 2, 3, 4, 5)
assert missing(wp07_domestic_60d) | inlist(wp07_domestic_60d, 0, 1)
assert missing(wp07_domestic_ops_bin) | inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5, 98)
assert missing(wp07_remit_disposition) | (wp07_known_form == 1 & eligible_flag == 1)
assert missing(wp07_domestic_60d) | (wp07_known_form == 1 & eligible_flag == 1)
assert missing(wp07_domestic_ops_bin) | wp07_domestic_60d == 1

* Remittance disposition is categorical. Show zero-count cells without inventing data.
quietly count if !missing(wp07_remit_disposition)
local remit_n = r(N)
display as text "Remittance valid / admitted: " as result `remit_n' " / " _N
count if missing(wp07_remit_disposition)
forvalues category = 1/5 {
    quietly count if wp07_remit_disposition == `category'
    display as text "Remittance code " `category' " N: " as result r(N)
    if `remit_n' > 0 {
        display as text "Percent of valid responses: " as result 100*r(N)/`remit_n'
    }
}

* Domestic participation: missing is unscored; it is not no.
quietly count if !missing(wp07_domestic_60d)
local domestic_n = r(N)
display as text "Domestic valid / admitted: " as result `domestic_n' " / " _N
count if missing(wp07_domestic_60d)
forvalues answer = 0/1 {
    quietly count if wp07_domestic_60d == `answer'
    display as text "Domestic code " `answer' " N: " as result r(N)
    if `domestic_n' > 0 {
        display as text "Percent of valid responses: " as result 100*r(N)/`domestic_n'
    }
}

* Operations: only affirmative users form the parent base; code 98 is uncertainty.
quietly count if wp07_domestic_60d == 1
local users = r(N)
quietly count if wp07_domestic_60d == 1 & inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5)
local ops_n = r(N)
display as text "Operation bins valid / affirmative users: " as result `ops_n' " / " `users'
count if wp07_domestic_60d == 1 & wp07_domestic_ops_bin == 98
count if wp07_domestic_60d == 1 & missing(wp07_domestic_ops_bin)
forvalues category = 1/5 {
    quietly count if wp07_domestic_60d == 1 & wp07_domestic_ops_bin == `category'
    display as text "Operation bin " `category' " N: " as result r(N)
    if `ops_n' > 0 {
        display as text "Percent of valid bins: " as result 100*r(N)/`ops_n'
    }
}

* Provisional D3 candidates are not replacements for the historical appendix scores.
* Each column uses its own nonmissing N. Do not combine these into a new index.
tabstat wp07_ivs_educ wp07_iat3 wp07_iadt2 wp07_iadt3 wp07_icdp2 wp07_iaff2 ///
    wp07_iuof3 wp07_iuof3_oldmap wp07_iuof2_no_frequency ///
    wp07_oqi2 wp07_oqi2_oldmap, statistics(n mean sd min p25 p50 p75 max) ///
    columns(statistics) varwidth(32)
