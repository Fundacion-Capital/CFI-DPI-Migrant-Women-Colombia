* WP07 academic descriptive exhibits and optional AS1; source review only.
* Use only an already prepared, separately authorized in-memory cohort.
exit 198

version 16
set varabbrev off
args out association_scope
if `"`out'"' == "" {
    exit 198
}
if !inlist("`association_scope'", "", "as1") {
    exit 198
}
assert _N == 423
local admitted = _N
confirm numeric variable formdef_version wp07_known_form eligible_flag ///
    q6_2 q6_4 q6_13 q6_14 q6_15 wp07_remit_disposition wp07_remit_any_digital ///
    wp07_domestic_60d wp07_domestic_ops_bin, exact
foreach item in q6_2 q6_4 q6_13 q6_14 q6_15 {
    confirm numeric variable wp07_route_`item' wp07_state_`item', exact
    assert missing(wp07_route_`item') | inlist(wp07_route_`item', 0, 1)
    assert inlist(wp07_state_`item', 1, 2, 3, 4, 5, 6)
    assert wp07_route_`item' == 1 if inlist(wp07_state_`item', 1, 4, 5)
    assert wp07_route_`item' == 0 if wp07_state_`item' == 2
}

* Check the accepted coding without recoding or excluding any admitted record.
assert missing(wp07_remit_disposition) == (wp07_state_q6_13 != 1)
assert wp07_remit_disposition == q6_13 if wp07_state_q6_13 == 1
assert missing(wp07_remit_any_digital) == missing(wp07_remit_disposition)
assert wp07_remit_any_digital == (wp07_remit_disposition != 1) if !missing(wp07_remit_disposition)
assert missing(wp07_domestic_60d) == (wp07_state_q6_14 != 1)
assert wp07_domestic_60d == q6_14 if wp07_state_q6_14 == 1
assert missing(wp07_domestic_ops_bin) == !inlist(wp07_state_q6_15, 1, 5)
assert wp07_domestic_ops_bin == q6_15 if inlist(wp07_state_q6_15, 1, 5)
assert missing(wp07_remit_disposition) | inlist(wp07_remit_disposition, 1, 2, 3, 4, 5)
assert missing(wp07_domestic_60d) | inlist(wp07_domestic_60d, 0, 1)
assert missing(wp07_domestic_ops_bin) | inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5, 98)
assert wp07_domestic_60d == 1 if !missing(wp07_domestic_ops_bin)
assert (wp07_domestic_ops_bin == 98) == (wp07_state_q6_15 == 5)
assert wp07_known_form == 1 if inlist(formdef_version, 2512090157, 2512091719, ///
    2512111044, 2512121811, 2602120658)
assert inlist(formdef_version, 2512090157, 2512091719, 2512111044, ///
    2512121811, 2602120658) if wp07_known_form == 1

foreach file in cohort.csv engagement.csv remittance_context.csv {
    confirm new file "`out'/`file'"
}
if "`association_scope'" == "as1" {
    confirm new file "`out'/associations.csv"
    confirm numeric variable wp07_iat3 wp07_iadt2 wp07_iadt3, exact
}

* T1: distinguish a version partition from a separate screening diagnostic.
tempname cohort
file open `cohort' using "`out'/cohort.csv", write text
file write `cohort' "section,category,n,admitted_n" _n
file write `cohort' "cohort,admitted," (`admitted') "," (`admitted') _n
local versions 0
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local versions = `versions' + r(N)
    file write `cohort' "version,`fv'," (r(N)) "," (`admitted') _n
}
quietly count if wp07_known_form != 1
assert `versions' + r(N) == `admitted'
file write `cohort' "version,UNKNOWN," (`admitted' - `versions') "," (`admitted') _n
quietly count if eligible_flag == 1
local eligible = r(N)
quietly count if eligible_flag == 0
local ineligible = r(N)
quietly count if missing(eligible_flag)
local screening_missing = r(N)
local screening_other = `admitted' - `eligible' - `ineligible' - `screening_missing'
file write `cohort' "screening,affirmative," (`eligible') "," (`admitted') _n
file write `cohort' "screening,negative," (`ineligible') "," (`admitted') _n
file write `cohort' "screening,missing," (`screening_missing') "," (`admitted') _n
file write `cohort' "screening,other," (`screening_other') "," (`admitted') _n
file close `cohort'

* T2/F1: fixed response rows, including offered zeroes. Undefined shares stay blank.
tempname engagement
file open `engagement' using "`out'/engagement.csv", write text
file write `engagement' "panel,basis,code,n,denominator_n,percent" _n
quietly count if !missing(wp07_remit_disposition)
local remit_n = r(N)
local remit_total 0
forvalues code = 1/5 {
    quietly count if wp07_remit_disposition == `code'
    local n = r(N)
    local remit_total = `remit_total' + `n'
    file write `engagement' "remittance,valid_category,`code'," (`n') "," (`remit_n') ","
    if `remit_n' > 0 {
        file write `engagement' %24.17g (100*`n'/`remit_n')
    }
    file write `engagement' _n
}
assert `remit_total' == `remit_n'
quietly count if wp07_remit_disposition == 1
local all_cash = r(N)
quietly count if wp07_remit_any_digital == 0
assert r(N) == `all_cash'
quietly count if wp07_remit_any_digital == 1
local any_digital = r(N)
assert `all_cash' + `any_digital' == `remit_n'
forvalues code = 0/1 {
    local n = cond(`code' == 0, `all_cash', `any_digital')
    file write `engagement' "remittance,valid_binary,`code'," (`n') "," (`remit_n') ","
    if `remit_n' > 0 {
        file write `engagement' %24.17g (100*`n'/`remit_n')
    }
    file write `engagement' _n
}
quietly count if !missing(wp07_domestic_60d)
local domestic_n = r(N)
quietly count if wp07_domestic_60d == 1
local users = r(N)
forvalues code = 0/1 {
    quietly count if wp07_domestic_60d == `code'
    local n = r(N)
    file write `engagement' "domestic,valid_binary,`code'," (`n') "," (`domestic_n') ","
    if `domestic_n' > 0 {
        file write `engagement' %24.17g (100*`n'/`domestic_n')
    }
    file write `engagement' _n
}
foreach item in q6_13 q6_14 {
    local panel "remittance"
    local valid = `remit_n'
    if "`item'" == "q6_14" {
        local panel "domestic"
        local valid = `domestic_n'
    }
    local unscored 0
    forvalues state = 2/6 {
        quietly count if wp07_state_`item' == `state'
        local n = r(N)
        local unscored = `unscored' + `n'
        file write `engagement' "`panel',unscored_state,`state'," (`n') "," (`admitted') "," ///
            %24.17g (100*`n'/`admitted') _n
    }
    assert `valid' + `unscored' == `admitted'
}
file close `engagement'

* S5: latest channel and 12-month frequency use their own recorded-answer bases.
tempname context
file open `context' using "`out'/remittance_context.csv", write text
file write `context' "item,basis,code,n,denominator_n,percent" _n
assert inlist(q6_2, 1, 2, 3) if wp07_state_q6_2 == 1
assert q6_2 == 99 if wp07_state_q6_2 == 5
assert inlist(q6_4, 1, 2, 3, 4, 5) if wp07_state_q6_4 == 1
assert wp07_state_q6_4 != 5
foreach item in q6_2 q6_4 {
    local codes "1 2 3 99"
    if "`item'" == "q6_4" {
        local codes "1 2 3 4 5"
    }
    quietly count if inlist(wp07_state_`item', 1, 5)
    local recorded = r(N)
    local total 0
    foreach code of local codes {
        quietly count if inlist(wp07_state_`item', 1, 5) & `item' == `code'
        local n = r(N)
        local total = `total' + `n'
        file write `context' "`item',recorded_category,`code'," (`n') "," (`recorded') ","
        if `recorded' > 0 {
            file write `context' %24.17g (100*`n'/`recorded')
        }
        file write `context' _n
    }
    assert `total' == `recorded'
    forvalues state = 1/6 {
        quietly count if wp07_state_`item' == `state'
        file write `context' "`item',admitted_state,`state'," (r(N)) "," (`admitted') "," ///
            %24.17g (100*r(N)/`admitted') _n
    }
}

* Frequency bins are conditional on affirmative users. Uncertainty is not a bin.
assert (inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5) == (wp07_state_q6_15 == 1)) ///
    if wp07_domestic_60d == 1
quietly count if wp07_domestic_60d == 1 & inlist(wp07_domestic_ops_bin, 1, 2, 3, 4, 5)
local bins = r(N)
local bin_total 0
forvalues code = 1/5 {
    quietly count if wp07_domestic_60d == 1 & wp07_domestic_ops_bin == `code'
    local n = r(N)
    local bin_total = `bin_total' + `n'
    file write `context' "q6_15,valid_bin,`code'," (`n') "," (`bins') ","
    if `bins' > 0 {
        file write `context' %24.17g (100*`n'/`bins')
    }
    file write `context' _n
}
assert `bin_total' == `bins'
local user_total 0
forvalues state = 1/6 {
    quietly count if wp07_domestic_60d == 1 & wp07_state_q6_15 == `state'
    local n = r(N)
    local user_total = `user_total' + `n'
    file write `context' "q6_15,affirmative_user_state,`state'," (`n') "," (`users') ","
    if `users' > 0 {
        file write `context' %24.17g (100*`n'/`users')
    }
    file write `context' _n
}
assert `user_total' == `users'
file close `context'

* AS1: two pair-complete and three common-complete correlations; never C2.
assert _N == `admitted'
if "`association_scope'" != "as1" {
    exit 0
}
assert missing(wp07_iadt3) | !missing(wp07_iadt2)
foreach field in wp07_iat3 wp07_iadt2 wp07_iadt3 {
    assert missing(`field') | inrange(`field', 0, 1)
}
tempname association
file open `association' using "`out'/associations.csv", write text
file write `association' "basis,left,right,n,pearson_r,status" _n
foreach basis in pair common {
    local left_fields "wp07_iat3 wp07_iat3"
    local right_fields "wp07_iadt2 wp07_iadt3"
    local pairs 2
    if "`basis'" == "common" {
        local left_fields "`left_fields' wp07_iadt2"
        local right_fields "`right_fields' wp07_iadt3"
        local pairs 3
    }
    forvalues pair = 1/`pairs' {
        local left : word `pair' of `left_fields'
        local right : word `pair' of `right_fields'
        local sample "!missing(`left', `right')"
        if "`basis'" == "common" {
            local sample "!missing(wp07_iat3, wp07_iadt2, wp07_iadt3)"
        }
        quietly count if `sample'
        local n = r(N)
        local status "insufficient_n"
        if `n' >= 2 {
            quietly summarize `left' if `sample', meanonly
            local left_varies = r(min) < r(max)
            quietly summarize `right' if `sample', meanonly
            local right_varies = r(min) < r(max)
            local status "constant_field"
            if `left_varies' & `right_varies' {
                quietly correlate `left' `right' if `sample'
                local rho = r(rho)
                assert r(N) == `n'
                assert abs(`rho') <= 1 + 1e-12
                local status "available"
            }
        }
        file write `association' "`basis',`left',`right'," (`n') ","
        if "`status'" == "available" {
            file write `association' %24.17g (`rho')
        }
        file write `association' ",`status'" _n
    }
}
file close `association'
assert _N == `admitted'
