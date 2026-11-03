* TARGET33 P2: actual-version routes and response states -- held source; no execution authority.
* The protected dispatcher must validate the pinned contract before invoking this selection.
assert "$wp07_target33_step" == "1"
assert inlist(formdef_version,2512090157,2512091719,2512111044,2512121811,2602120658)
tempname out
file open `out' using "$wp07_target33_out/version_route_domain_states.csv", write text
file write `out' "check_id,field,form_version,state,state_subtype,checked_n,observed_n,discrepancy_n,status" _n
quietly count if formdef_version == 2512090157
file write `out' "P2.01,formdef_version,2512090157,known_version,,423," (r(N)) ",NA,supported" _n
quietly count if formdef_version == 2512091719
file write `out' "P2.01,formdef_version,2512091719,known_version,,423," (r(N)) ",NA,supported" _n
quietly count if formdef_version == 2512111044
file write `out' "P2.01,formdef_version,2512111044,known_version,,423," (r(N)) ",NA,supported" _n
quietly count if formdef_version == 2512121811
file write `out' "P2.01,formdef_version,2512121811,known_version,,423," (r(N)) ",NA,supported" _n
quietly count if formdef_version == 2602120658
file write `out' "P2.01,formdef_version,2602120658,known_version,,423," (r(N)) ",NA,supported" _n
* consent: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_consent = 6
quietly gen byte _p24a_consent = .
quietly replace _p24a_consent = 1 if formdef_version == 2512090157 & (1)
quietly replace _p24a_consent = 0 if formdef_version == 2512090157 & (0)
quietly replace _p24_consent = 2 if formdef_version == 2512090157 & _p24a_consent == 0 & (missing(consent))
quietly replace _p24_consent = 4 if formdef_version == 2512090157 & _p24a_consent == 1 & (missing(consent))
quietly replace _p24_consent = 1 if formdef_version == 2512090157 & _p24a_consent == 1 & (consent == 0 | consent == 1 | consent == 98)
quietly replace _p24_consent = 5 if formdef_version == 2512090157 & _p24_consent == 1 & (consent == 98)
quietly count if formdef_version == 2512090157 & _p24_consent == 5 & (consent == 98)
file write `out' "P2.08,consent,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_consent = 1 if formdef_version == 2512091719 & (1)
quietly replace _p24a_consent = 0 if formdef_version == 2512091719 & (0)
quietly replace _p24_consent = 2 if formdef_version == 2512091719 & _p24a_consent == 0 & (missing(consent))
quietly replace _p24_consent = 4 if formdef_version == 2512091719 & _p24a_consent == 1 & (missing(consent))
quietly replace _p24_consent = 1 if formdef_version == 2512091719 & _p24a_consent == 1 & (consent == 0 | consent == 1 | consent == 98)
quietly replace _p24_consent = 5 if formdef_version == 2512091719 & _p24_consent == 1 & (consent == 98)
quietly count if formdef_version == 2512091719 & _p24_consent == 5 & (consent == 98)
file write `out' "P2.08,consent,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_consent = 1 if formdef_version == 2512111044 & (1)
quietly replace _p24a_consent = 0 if formdef_version == 2512111044 & (0)
quietly replace _p24_consent = 2 if formdef_version == 2512111044 & _p24a_consent == 0 & (missing(consent))
quietly replace _p24_consent = 4 if formdef_version == 2512111044 & _p24a_consent == 1 & (missing(consent))
quietly replace _p24_consent = 1 if formdef_version == 2512111044 & _p24a_consent == 1 & (consent == 0 | consent == 1 | consent == 98)
quietly replace _p24_consent = 5 if formdef_version == 2512111044 & _p24_consent == 1 & (consent == 98)
quietly count if formdef_version == 2512111044 & _p24_consent == 5 & (consent == 98)
file write `out' "P2.08,consent,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_consent = 1 if formdef_version == 2512121811 & (1)
quietly replace _p24a_consent = 0 if formdef_version == 2512121811 & (0)
quietly replace _p24_consent = 2 if formdef_version == 2512121811 & _p24a_consent == 0 & (missing(consent))
quietly replace _p24_consent = 4 if formdef_version == 2512121811 & _p24a_consent == 1 & (missing(consent))
quietly replace _p24_consent = 1 if formdef_version == 2512121811 & _p24a_consent == 1 & (consent == 0 | consent == 1 | consent == 98)
quietly replace _p24_consent = 5 if formdef_version == 2512121811 & _p24_consent == 1 & (consent == 98)
quietly count if formdef_version == 2512121811 & _p24_consent == 5 & (consent == 98)
file write `out' "P2.08,consent,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_consent = 1 if formdef_version == 2602120658 & (1)
quietly replace _p24a_consent = 0 if formdef_version == 2602120658 & (0)
quietly replace _p24_consent = 2 if formdef_version == 2602120658 & _p24a_consent == 0 & (missing(consent))
quietly replace _p24_consent = 4 if formdef_version == 2602120658 & _p24a_consent == 1 & (missing(consent))
quietly replace _p24_consent = 1 if formdef_version == 2602120658 & _p24a_consent == 1 & (consent == 0 | consent == 1 | consent == 98)
quietly replace _p24_consent = 5 if formdef_version == 2602120658 & _p24_consent == 1 & (consent == 98)
quietly count if formdef_version == 2602120658 & _p24_consent == 5 & (consent == 98)
file write `out' "P2.08,consent,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_consent == `state' 
        file write `out' "P2.03,consent,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_consent == 1 & !(missing(consent)) & !(consent == 0 | consent == 1 | consent == 98)
file write `out' "P2.04,consent,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_consent == 1 & !(missing(consent)) & !(consent == 0 | consent == 1 | consent == 98)
file write `out' "P2.04,consent,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_consent == 1 & !(missing(consent)) & !(consent == 0 | consent == 1 | consent == 98)
file write `out' "P2.04,consent,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_consent == 1 & !(missing(consent)) & !(consent == 0 | consent == 1 | consent == 98)
file write `out' "P2.04,consent,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_consent == 1 & !(missing(consent)) & !(consent == 0 | consent == 1 | consent == 98)
file write `out' "P2.04,consent,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q1: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q1 = 6
quietly gen byte _p24a_q1 = .
quietly replace _p24a_q1 = 1 if formdef_version == 2512090157 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q1 = 0 if formdef_version == 2512090157 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q1 = 2 if formdef_version == 2512090157 & _p24a_q1 == 0 & (missing(q1))
quietly replace _p24_q1 = 4 if formdef_version == 2512090157 & _p24a_q1 == 1 & (missing(q1))
quietly replace _p24_q1 = 1 if formdef_version == 2512090157 & _p24a_q1 == 1 & (q1 == 1 | q1 == 2 | q1 == 3 | q1 == 98)
quietly replace _p24_q1 = 5 if formdef_version == 2512090157 & _p24_q1 == 1 & (q1 == 98)
quietly count if formdef_version == 2512090157 & _p24_q1 == 5 & (q1 == 98)
file write `out' "P2.08,q1,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q1 = 1 if formdef_version == 2512091719 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q1 = 0 if formdef_version == 2512091719 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q1 = 2 if formdef_version == 2512091719 & _p24a_q1 == 0 & (missing(q1))
quietly replace _p24_q1 = 4 if formdef_version == 2512091719 & _p24a_q1 == 1 & (missing(q1))
quietly replace _p24_q1 = 1 if formdef_version == 2512091719 & _p24a_q1 == 1 & (q1 == 1 | q1 == 2 | q1 == 3 | q1 == 98)
quietly replace _p24_q1 = 5 if formdef_version == 2512091719 & _p24_q1 == 1 & (q1 == 98)
quietly count if formdef_version == 2512091719 & _p24_q1 == 5 & (q1 == 98)
file write `out' "P2.08,q1,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q1 = 1 if formdef_version == 2512111044 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q1 = 0 if formdef_version == 2512111044 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q1 = 2 if formdef_version == 2512111044 & _p24a_q1 == 0 & (missing(q1))
quietly replace _p24_q1 = 4 if formdef_version == 2512111044 & _p24a_q1 == 1 & (missing(q1))
quietly replace _p24_q1 = 1 if formdef_version == 2512111044 & _p24a_q1 == 1 & (q1 == 1 | q1 == 2 | q1 == 3 | q1 == 98)
quietly replace _p24_q1 = 5 if formdef_version == 2512111044 & _p24_q1 == 1 & (q1 == 98)
quietly count if formdef_version == 2512111044 & _p24_q1 == 5 & (q1 == 98)
file write `out' "P2.08,q1,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q1 = 1 if formdef_version == 2512121811 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q1 = 0 if formdef_version == 2512121811 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q1 = 2 if formdef_version == 2512121811 & _p24a_q1 == 0 & (missing(q1))
quietly replace _p24_q1 = 4 if formdef_version == 2512121811 & _p24a_q1 == 1 & (missing(q1))
quietly replace _p24_q1 = 1 if formdef_version == 2512121811 & _p24a_q1 == 1 & (q1 == 1 | q1 == 2 | q1 == 3 | q1 == 98)
quietly replace _p24_q1 = 5 if formdef_version == 2512121811 & _p24_q1 == 1 & (q1 == 98)
quietly count if formdef_version == 2512121811 & _p24_q1 == 5 & (q1 == 98)
file write `out' "P2.08,q1,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q1 = 1 if formdef_version == 2602120658 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q1 = 0 if formdef_version == 2602120658 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q1 = 2 if formdef_version == 2602120658 & _p24a_q1 == 0 & (missing(q1))
quietly replace _p24_q1 = 4 if formdef_version == 2602120658 & _p24a_q1 == 1 & (missing(q1))
quietly replace _p24_q1 = 1 if formdef_version == 2602120658 & _p24a_q1 == 1 & (q1 == 1 | q1 == 2 | q1 == 3 | q1 == 98)
quietly replace _p24_q1 = 5 if formdef_version == 2602120658 & _p24_q1 == 1 & (q1 == 98)
quietly count if formdef_version == 2602120658 & _p24_q1 == 5 & (q1 == 98)
file write `out' "P2.08,q1,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q1 == `state' 
        file write `out' "P2.03,q1,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q1 == 1 & !(missing(q1)) & !(q1 == 1 | q1 == 2 | q1 == 3 | q1 == 98)
file write `out' "P2.04,q1,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q1 == 1 & !(missing(q1)) & !(q1 == 1 | q1 == 2 | q1 == 3 | q1 == 98)
file write `out' "P2.04,q1,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q1 == 1 & !(missing(q1)) & !(q1 == 1 | q1 == 2 | q1 == 3 | q1 == 98)
file write `out' "P2.04,q1,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q1 == 1 & !(missing(q1)) & !(q1 == 1 | q1 == 2 | q1 == 3 | q1 == 98)
file write `out' "P2.04,q1,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q1 == 1 & !(missing(q1)) & !(q1 == 1 | q1 == 2 | q1 == 3 | q1 == 98)
file write `out' "P2.04,q1,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q10_1: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q10_1 = 6
quietly gen byte _p24a_q10_1 = .
quietly replace _p24a_q10_1 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_1 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_1 = 2 if formdef_version == 2512090157 & _p24a_q10_1 == 0 & (missing(q10_1))
quietly replace _p24_q10_1 = 4 if formdef_version == 2512090157 & _p24a_q10_1 == 1 & (missing(q10_1))
quietly replace _p24_q10_1 = 1 if formdef_version == 2512090157 & _p24a_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11)
quietly replace _p24_q10_1 = 5 if formdef_version == 2512090157 & _p24_q10_1 == 1 & (q10_1 == 4)
quietly count if formdef_version == 2512090157 & _p24_q10_1 == 5 & (q10_1 == 4)
file write `out' "P2.08,q10_1,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_1 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_1 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_1 = 2 if formdef_version == 2512091719 & _p24a_q10_1 == 0 & (missing(q10_1))
quietly replace _p24_q10_1 = 4 if formdef_version == 2512091719 & _p24a_q10_1 == 1 & (missing(q10_1))
quietly replace _p24_q10_1 = 1 if formdef_version == 2512091719 & _p24a_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
quietly replace _p24_q10_1 = 5 if formdef_version == 2512091719 & _p24_q10_1 == 1 & (q10_1 == 4)
quietly count if formdef_version == 2512091719 & _p24_q10_1 == 5 & (q10_1 == 4)
file write `out' "P2.08,q10_1,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q10_1 = 5 if formdef_version == 2512091719 & _p24_q10_1 == 1 & (q10_1 == 98)
quietly count if formdef_version == 2512091719 & _p24_q10_1 == 5 & (q10_1 == 98)
file write `out' "P2.08,q10_1,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_1 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_1 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_1 = 2 if formdef_version == 2512111044 & _p24a_q10_1 == 0 & (missing(q10_1))
quietly replace _p24_q10_1 = 4 if formdef_version == 2512111044 & _p24a_q10_1 == 1 & (missing(q10_1))
quietly replace _p24_q10_1 = 1 if formdef_version == 2512111044 & _p24a_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
quietly replace _p24_q10_1 = 5 if formdef_version == 2512111044 & _p24_q10_1 == 1 & (q10_1 == 4)
quietly count if formdef_version == 2512111044 & _p24_q10_1 == 5 & (q10_1 == 4)
file write `out' "P2.08,q10_1,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q10_1 = 5 if formdef_version == 2512111044 & _p24_q10_1 == 1 & (q10_1 == 98)
quietly count if formdef_version == 2512111044 & _p24_q10_1 == 5 & (q10_1 == 98)
file write `out' "P2.08,q10_1,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_1 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_1 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_1 = 2 if formdef_version == 2512121811 & _p24a_q10_1 == 0 & (missing(q10_1))
quietly replace _p24_q10_1 = 4 if formdef_version == 2512121811 & _p24a_q10_1 == 1 & (missing(q10_1))
quietly replace _p24_q10_1 = 1 if formdef_version == 2512121811 & _p24a_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
quietly replace _p24_q10_1 = 5 if formdef_version == 2512121811 & _p24_q10_1 == 1 & (q10_1 == 4)
quietly count if formdef_version == 2512121811 & _p24_q10_1 == 5 & (q10_1 == 4)
file write `out' "P2.08,q10_1,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q10_1 = 5 if formdef_version == 2512121811 & _p24_q10_1 == 1 & (q10_1 == 98)
quietly count if formdef_version == 2512121811 & _p24_q10_1 == 5 & (q10_1 == 98)
file write `out' "P2.08,q10_1,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_1 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_1 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_1 = 2 if formdef_version == 2602120658 & _p24a_q10_1 == 0 & (missing(q10_1))
quietly replace _p24_q10_1 = 4 if formdef_version == 2602120658 & _p24a_q10_1 == 1 & (missing(q10_1))
quietly replace _p24_q10_1 = 1 if formdef_version == 2602120658 & _p24a_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
quietly replace _p24_q10_1 = 5 if formdef_version == 2602120658 & _p24_q10_1 == 1 & (q10_1 == 4)
quietly count if formdef_version == 2602120658 & _p24_q10_1 == 5 & (q10_1 == 4)
file write `out' "P2.08,q10_1,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q10_1 = 5 if formdef_version == 2602120658 & _p24_q10_1 == 1 & (q10_1 == 98)
quietly count if formdef_version == 2602120658 & _p24_q10_1 == 5 & (q10_1 == 98)
file write `out' "P2.08,q10_1,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q10_1 == `state' 
        file write `out' "P2.03,q10_1,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q10_1 == 1 & !(missing(q10_1)) & !(q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11)
file write `out' "P2.04,q10_1,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q10_1 == 1 & !(missing(q10_1)) & !(q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
file write `out' "P2.04,q10_1,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q10_1 == 1 & !(missing(q10_1)) & !(q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
file write `out' "P2.04,q10_1,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q10_1 == 1 & !(missing(q10_1)) & !(q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
file write `out' "P2.04,q10_1,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q10_1 == 1 & !(missing(q10_1)) & !(q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
file write `out' "P2.04,q10_1,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q10_10: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q10_10 = 6
quietly gen byte _p24a_q10_10 = .
quietly replace _p24a_q10_10 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_10 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_10 = 2 if formdef_version == 2512090157 & _p24a_q10_10 == 0 & (missing(q10_10))
quietly replace _p24_q10_10 = 4 if formdef_version == 2512090157 & _p24a_q10_10 == 1 & (missing(q10_10))
quietly replace _p24_q10_10 = 1 if formdef_version == 2512090157 & _p24a_q10_10 == 1 & (q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
quietly replace _p24_q10_10 = 5 if formdef_version == 2512090157 & _p24_q10_10 == 1 & (q10_10 == 98)
quietly count if formdef_version == 2512090157 & _p24_q10_10 == 5 & (q10_10 == 98)
file write `out' "P2.08,q10_10,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_10 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_10 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_10 = 2 if formdef_version == 2512091719 & _p24a_q10_10 == 0 & (missing(q10_10))
quietly replace _p24_q10_10 = 4 if formdef_version == 2512091719 & _p24a_q10_10 == 1 & (missing(q10_10))
quietly replace _p24_q10_10 = 1 if formdef_version == 2512091719 & _p24a_q10_10 == 1 & (q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
quietly replace _p24_q10_10 = 5 if formdef_version == 2512091719 & _p24_q10_10 == 1 & (q10_10 == 98)
quietly count if formdef_version == 2512091719 & _p24_q10_10 == 5 & (q10_10 == 98)
file write `out' "P2.08,q10_10,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_10 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_10 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_10 = 2 if formdef_version == 2512111044 & _p24a_q10_10 == 0 & (missing(q10_10))
quietly replace _p24_q10_10 = 4 if formdef_version == 2512111044 & _p24a_q10_10 == 1 & (missing(q10_10))
quietly replace _p24_q10_10 = 1 if formdef_version == 2512111044 & _p24a_q10_10 == 1 & (q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
quietly replace _p24_q10_10 = 5 if formdef_version == 2512111044 & _p24_q10_10 == 1 & (q10_10 == 98)
quietly count if formdef_version == 2512111044 & _p24_q10_10 == 5 & (q10_10 == 98)
file write `out' "P2.08,q10_10,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_10 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_10 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_10 = 2 if formdef_version == 2512121811 & _p24a_q10_10 == 0 & (missing(q10_10))
quietly replace _p24_q10_10 = 4 if formdef_version == 2512121811 & _p24a_q10_10 == 1 & (missing(q10_10))
quietly replace _p24_q10_10 = 1 if formdef_version == 2512121811 & _p24a_q10_10 == 1 & (q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
quietly replace _p24_q10_10 = 5 if formdef_version == 2512121811 & _p24_q10_10 == 1 & (q10_10 == 98)
quietly count if formdef_version == 2512121811 & _p24_q10_10 == 5 & (q10_10 == 98)
file write `out' "P2.08,q10_10,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_10 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_10 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_10 = 2 if formdef_version == 2602120658 & _p24a_q10_10 == 0 & (missing(q10_10))
quietly replace _p24_q10_10 = 4 if formdef_version == 2602120658 & _p24a_q10_10 == 1 & (missing(q10_10))
quietly replace _p24_q10_10 = 1 if formdef_version == 2602120658 & _p24a_q10_10 == 1 & (q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
quietly replace _p24_q10_10 = 5 if formdef_version == 2602120658 & _p24_q10_10 == 1 & (q10_10 == 98)
quietly count if formdef_version == 2602120658 & _p24_q10_10 == 5 & (q10_10 == 98)
file write `out' "P2.08,q10_10,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q10_10 == `state' 
        file write `out' "P2.03,q10_10,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q10_10 == 1 & !(missing(q10_10)) & !(q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
file write `out' "P2.04,q10_10,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q10_10 == 1 & !(missing(q10_10)) & !(q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
file write `out' "P2.04,q10_10,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q10_10 == 1 & !(missing(q10_10)) & !(q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
file write `out' "P2.04,q10_10,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q10_10 == 1 & !(missing(q10_10)) & !(q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
file write `out' "P2.04,q10_10,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q10_10 == 1 & !(missing(q10_10)) & !(q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98)
file write `out' "P2.04,q10_10,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q10_11: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q10_11 = 6
quietly gen byte _p24a_q10_11 = .
quietly replace _p24a_q10_11 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
quietly replace _p24a_q10_11 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
quietly replace _p24_q10_11 = 2 if formdef_version == 2512090157 & _p24a_q10_11 == 0 & (missing(q10_11))
quietly replace _p24_q10_11 = 4 if formdef_version == 2512090157 & _p24a_q10_11 == 1 & (missing(q10_11))
quietly replace _p24_q10_11 = 1 if formdef_version == 2512090157 & _p24a_q10_11 == 1 & (q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
quietly replace _p24a_q10_11 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
quietly replace _p24a_q10_11 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
quietly replace _p24_q10_11 = 2 if formdef_version == 2512091719 & _p24a_q10_11 == 0 & (missing(q10_11))
quietly replace _p24_q10_11 = 4 if formdef_version == 2512091719 & _p24a_q10_11 == 1 & (missing(q10_11))
quietly replace _p24_q10_11 = 1 if formdef_version == 2512091719 & _p24a_q10_11 == 1 & (q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
quietly replace _p24a_q10_11 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
quietly replace _p24a_q10_11 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
quietly replace _p24_q10_11 = 2 if formdef_version == 2512111044 & _p24a_q10_11 == 0 & (missing(q10_11))
quietly replace _p24_q10_11 = 4 if formdef_version == 2512111044 & _p24a_q10_11 == 1 & (missing(q10_11))
quietly replace _p24_q10_11 = 1 if formdef_version == 2512111044 & _p24a_q10_11 == 1 & (q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
quietly replace _p24a_q10_11 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
quietly replace _p24a_q10_11 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
quietly replace _p24_q10_11 = 2 if formdef_version == 2512121811 & _p24a_q10_11 == 0 & (missing(q10_11))
quietly replace _p24_q10_11 = 4 if formdef_version == 2512121811 & _p24a_q10_11 == 1 & (missing(q10_11))
quietly replace _p24_q10_11 = 1 if formdef_version == 2512121811 & _p24a_q10_11 == 1 & (q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
quietly replace _p24a_q10_11 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
quietly replace _p24a_q10_11 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
quietly replace _p24_q10_11 = 2 if formdef_version == 2602120658 & _p24a_q10_11 == 0 & (missing(q10_11))
quietly replace _p24_q10_11 = 4 if formdef_version == 2602120658 & _p24a_q10_11 == 1 & (missing(q10_11))
quietly replace _p24_q10_11 = 1 if formdef_version == 2602120658 & _p24a_q10_11 == 1 & (q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q10_11 == `state' 
        file write `out' "P2.03,q10_11,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q10_11 == 1 & !(missing(q10_11)) & !(q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
file write `out' "P2.04,q10_11,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q10_11 == 1 & !(missing(q10_11)) & !(q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
file write `out' "P2.04,q10_11,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q10_11 == 1 & !(missing(q10_11)) & !(q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
file write `out' "P2.04,q10_11,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q10_11 == 1 & !(missing(q10_11)) & !(q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
file write `out' "P2.04,q10_11,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q10_11 == 1 & !(missing(q10_11)) & !(q10_11 == 1 | q10_11 == 2 | q10_11 == 3 | q10_11 == 4 | q10_11 == 5)
file write `out' "P2.04,q10_11,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q10_12: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q10_12 = 6
quietly gen byte _p24a_q10_12 = .
quietly replace _p24a_q10_12 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
quietly replace _p24a_q10_12 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
quietly replace _p24_q10_12 = 2 if formdef_version == 2512090157 & _p24a_q10_12 == 0 & (missing(q10_12))
quietly replace _p24_q10_12 = 4 if formdef_version == 2512090157 & _p24a_q10_12 == 1 & (missing(q10_12))
quietly replace _p24_q10_12 = 1 if formdef_version == 2512090157 & _p24a_q10_12 == 1 & (q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
quietly replace _p24a_q10_12 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
quietly replace _p24a_q10_12 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
quietly replace _p24_q10_12 = 2 if formdef_version == 2512091719 & _p24a_q10_12 == 0 & (missing(q10_12))
quietly replace _p24_q10_12 = 4 if formdef_version == 2512091719 & _p24a_q10_12 == 1 & (missing(q10_12))
quietly replace _p24_q10_12 = 1 if formdef_version == 2512091719 & _p24a_q10_12 == 1 & (q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
quietly replace _p24a_q10_12 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
quietly replace _p24a_q10_12 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
quietly replace _p24_q10_12 = 2 if formdef_version == 2512111044 & _p24a_q10_12 == 0 & (missing(q10_12))
quietly replace _p24_q10_12 = 4 if formdef_version == 2512111044 & _p24a_q10_12 == 1 & (missing(q10_12))
quietly replace _p24_q10_12 = 1 if formdef_version == 2512111044 & _p24a_q10_12 == 1 & (q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
quietly replace _p24a_q10_12 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
quietly replace _p24a_q10_12 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
quietly replace _p24_q10_12 = 2 if formdef_version == 2512121811 & _p24a_q10_12 == 0 & (missing(q10_12))
quietly replace _p24_q10_12 = 4 if formdef_version == 2512121811 & _p24a_q10_12 == 1 & (missing(q10_12))
quietly replace _p24_q10_12 = 1 if formdef_version == 2512121811 & _p24a_q10_12 == 1 & (q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
quietly replace _p24a_q10_12 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 1)) | ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & (q10_10 == 2))))
quietly replace _p24a_q10_12 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 1)) & ((q10_10 == 1 | q10_10 == 2 | q10_10 == 3 | q10_10 == 98) & !(q10_10 == 2))))
quietly replace _p24_q10_12 = 2 if formdef_version == 2602120658 & _p24a_q10_12 == 0 & (missing(q10_12))
quietly replace _p24_q10_12 = 4 if formdef_version == 2602120658 & _p24a_q10_12 == 1 & (missing(q10_12))
quietly replace _p24_q10_12 = 1 if formdef_version == 2602120658 & _p24a_q10_12 == 1 & (q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q10_12 == `state' 
        file write `out' "P2.03,q10_12,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q10_12 == 1 & !(missing(q10_12)) & !(q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
file write `out' "P2.04,q10_12,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q10_12 == 1 & !(missing(q10_12)) & !(q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
file write `out' "P2.04,q10_12,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q10_12 == 1 & !(missing(q10_12)) & !(q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
file write `out' "P2.04,q10_12,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q10_12 == 1 & !(missing(q10_12)) & !(q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
file write `out' "P2.04,q10_12,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q10_12 == 1 & !(missing(q10_12)) & !(q10_12 == 1 | q10_12 == 2 | q10_12 == 3 | q10_12 == 4 | q10_12 == 5)
file write `out' "P2.04,q10_12,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q10_13: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q10_13 = 6
quietly gen byte _p24a_q10_13 = .
quietly replace _p24a_q10_13 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_13 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_13 = 2 if formdef_version == 2512090157 & _p24a_q10_13 == 0 & (missing(q10_13))
quietly replace _p24_q10_13 = 4 if formdef_version == 2512090157 & _p24a_q10_13 == 1 & (missing(q10_13))
quietly replace _p24_q10_13 = 1 if formdef_version == 2512090157 & _p24a_q10_13 == 1 & (q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
quietly replace _p24_q10_13 = 5 if formdef_version == 2512090157 & _p24_q10_13 == 1 & (q10_13 == 98)
quietly count if formdef_version == 2512090157 & _p24_q10_13 == 5 & (q10_13 == 98)
file write `out' "P2.08,q10_13,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_13 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_13 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_13 = 2 if formdef_version == 2512091719 & _p24a_q10_13 == 0 & (missing(q10_13))
quietly replace _p24_q10_13 = 4 if formdef_version == 2512091719 & _p24a_q10_13 == 1 & (missing(q10_13))
quietly replace _p24_q10_13 = 1 if formdef_version == 2512091719 & _p24a_q10_13 == 1 & (q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
quietly replace _p24_q10_13 = 5 if formdef_version == 2512091719 & _p24_q10_13 == 1 & (q10_13 == 98)
quietly count if formdef_version == 2512091719 & _p24_q10_13 == 5 & (q10_13 == 98)
file write `out' "P2.08,q10_13,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_13 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_13 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_13 = 2 if formdef_version == 2512111044 & _p24a_q10_13 == 0 & (missing(q10_13))
quietly replace _p24_q10_13 = 4 if formdef_version == 2512111044 & _p24a_q10_13 == 1 & (missing(q10_13))
quietly replace _p24_q10_13 = 1 if formdef_version == 2512111044 & _p24a_q10_13 == 1 & (q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
quietly replace _p24_q10_13 = 5 if formdef_version == 2512111044 & _p24_q10_13 == 1 & (q10_13 == 98)
quietly count if formdef_version == 2512111044 & _p24_q10_13 == 5 & (q10_13 == 98)
file write `out' "P2.08,q10_13,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_13 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_13 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_13 = 2 if formdef_version == 2512121811 & _p24a_q10_13 == 0 & (missing(q10_13))
quietly replace _p24_q10_13 = 4 if formdef_version == 2512121811 & _p24a_q10_13 == 1 & (missing(q10_13))
quietly replace _p24_q10_13 = 1 if formdef_version == 2512121811 & _p24a_q10_13 == 1 & (q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
quietly replace _p24_q10_13 = 5 if formdef_version == 2512121811 & _p24_q10_13 == 1 & (q10_13 == 98)
quietly count if formdef_version == 2512121811 & _p24_q10_13 == 5 & (q10_13 == 98)
file write `out' "P2.08,q10_13,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_13 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_13 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_13 = 2 if formdef_version == 2602120658 & _p24a_q10_13 == 0 & (missing(q10_13))
quietly replace _p24_q10_13 = 4 if formdef_version == 2602120658 & _p24a_q10_13 == 1 & (missing(q10_13))
quietly replace _p24_q10_13 = 1 if formdef_version == 2602120658 & _p24a_q10_13 == 1 & (q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
quietly replace _p24_q10_13 = 5 if formdef_version == 2602120658 & _p24_q10_13 == 1 & (q10_13 == 98)
quietly count if formdef_version == 2602120658 & _p24_q10_13 == 5 & (q10_13 == 98)
file write `out' "P2.08,q10_13,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q10_13 == `state' 
        file write `out' "P2.03,q10_13,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q10_13 == 1 & !(missing(q10_13)) & !(q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
file write `out' "P2.04,q10_13,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q10_13 == 1 & !(missing(q10_13)) & !(q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
file write `out' "P2.04,q10_13,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q10_13 == 1 & !(missing(q10_13)) & !(q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
file write `out' "P2.04,q10_13,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q10_13 == 1 & !(missing(q10_13)) & !(q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
file write `out' "P2.04,q10_13,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q10_13 == 1 & !(missing(q10_13)) & !(q10_13 == 0 | q10_13 == 1 | q10_13 == 98)
file write `out' "P2.04,q10_13,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q10_14: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q10_14 = 6
quietly gen byte _p24a_q10_14 = .
quietly replace _p24a_q10_14 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & (q10_13 == 1)))
quietly replace _p24a_q10_14 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & !(q10_13 == 1)))
quietly replace _p24_q10_14 = 2 if formdef_version == 2512090157 & _p24a_q10_14 == 0 & (missing(q10_14))
quietly replace _p24_q10_14 = 4 if formdef_version == 2512090157 & _p24a_q10_14 == 1 & (missing(q10_14))
quietly replace _p24_q10_14 = 1 if formdef_version == 2512090157 & _p24a_q10_14 == 1 & (q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
quietly replace _p24a_q10_14 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & (q10_13 == 1)))
quietly replace _p24a_q10_14 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & !(q10_13 == 1)))
quietly replace _p24_q10_14 = 2 if formdef_version == 2512091719 & _p24a_q10_14 == 0 & (missing(q10_14))
quietly replace _p24_q10_14 = 4 if formdef_version == 2512091719 & _p24a_q10_14 == 1 & (missing(q10_14))
quietly replace _p24_q10_14 = 1 if formdef_version == 2512091719 & _p24a_q10_14 == 1 & (q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
quietly replace _p24a_q10_14 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & (q10_13 == 1)))
quietly replace _p24a_q10_14 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & !(q10_13 == 1)))
quietly replace _p24_q10_14 = 2 if formdef_version == 2512111044 & _p24a_q10_14 == 0 & (missing(q10_14))
quietly replace _p24_q10_14 = 4 if formdef_version == 2512111044 & _p24a_q10_14 == 1 & (missing(q10_14))
quietly replace _p24_q10_14 = 1 if formdef_version == 2512111044 & _p24a_q10_14 == 1 & (q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
quietly replace _p24a_q10_14 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & (q10_13 == 1)))
quietly replace _p24a_q10_14 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & !(q10_13 == 1)))
quietly replace _p24_q10_14 = 2 if formdef_version == 2512121811 & _p24a_q10_14 == 0 & (missing(q10_14))
quietly replace _p24_q10_14 = 4 if formdef_version == 2512121811 & _p24a_q10_14 == 1 & (missing(q10_14))
quietly replace _p24_q10_14 = 1 if formdef_version == 2512121811 & _p24a_q10_14 == 1 & (q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
quietly replace _p24a_q10_14 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & (q10_13 == 1)))
quietly replace _p24a_q10_14 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q10_13 == 0 | q10_13 == 1 | q10_13 == 98) & !(q10_13 == 1)))
quietly replace _p24_q10_14 = 2 if formdef_version == 2602120658 & _p24a_q10_14 == 0 & (missing(q10_14))
quietly replace _p24_q10_14 = 4 if formdef_version == 2602120658 & _p24a_q10_14 == 1 & (missing(q10_14))
quietly replace _p24_q10_14 = 1 if formdef_version == 2602120658 & _p24a_q10_14 == 1 & (q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q10_14 == `state' 
        file write `out' "P2.03,q10_14,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q10_14 == 1 & !(missing(q10_14)) & !(q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
file write `out' "P2.04,q10_14,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q10_14 == 1 & !(missing(q10_14)) & !(q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
file write `out' "P2.04,q10_14,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q10_14 == 1 & !(missing(q10_14)) & !(q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
file write `out' "P2.04,q10_14,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q10_14 == 1 & !(missing(q10_14)) & !(q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
file write `out' "P2.04,q10_14,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q10_14 == 1 & !(missing(q10_14)) & !(q10_14 == 1 | q10_14 == 2 | q10_14 == 3 | q10_14 == 4 | q10_14 == 5 | q10_14 == 6)
file write `out' "P2.04,q10_14,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q10_16: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q10_16 = 6
quietly gen byte _p24a_q10_16 = .
quietly replace _p24a_q10_16 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_16 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_16 = 2 if formdef_version == 2512090157 & _p24a_q10_16 == 0 & (missing(q10_16))
quietly replace _p24_q10_16 = 4 if formdef_version == 2512090157 & _p24a_q10_16 == 1 & (missing(q10_16))
quietly replace _p24_q10_16 = 1 if formdef_version == 2512090157 & _p24a_q10_16 == 1 & (q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
quietly replace _p24_q10_16 = 5 if formdef_version == 2512090157 & _p24_q10_16 == 1 & (q10_16 == 98)
quietly count if formdef_version == 2512090157 & _p24_q10_16 == 5 & (q10_16 == 98)
file write `out' "P2.08,q10_16,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_16 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_16 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_16 = 2 if formdef_version == 2512091719 & _p24a_q10_16 == 0 & (missing(q10_16))
quietly replace _p24_q10_16 = 4 if formdef_version == 2512091719 & _p24a_q10_16 == 1 & (missing(q10_16))
quietly replace _p24_q10_16 = 1 if formdef_version == 2512091719 & _p24a_q10_16 == 1 & (q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
quietly replace _p24_q10_16 = 5 if formdef_version == 2512091719 & _p24_q10_16 == 1 & (q10_16 == 98)
quietly count if formdef_version == 2512091719 & _p24_q10_16 == 5 & (q10_16 == 98)
file write `out' "P2.08,q10_16,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_16 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_16 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_16 = 2 if formdef_version == 2512111044 & _p24a_q10_16 == 0 & (missing(q10_16))
quietly replace _p24_q10_16 = 4 if formdef_version == 2512111044 & _p24a_q10_16 == 1 & (missing(q10_16))
quietly replace _p24_q10_16 = 1 if formdef_version == 2512111044 & _p24a_q10_16 == 1 & (q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
quietly replace _p24_q10_16 = 5 if formdef_version == 2512111044 & _p24_q10_16 == 1 & (q10_16 == 98)
quietly count if formdef_version == 2512111044 & _p24_q10_16 == 5 & (q10_16 == 98)
file write `out' "P2.08,q10_16,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_16 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_16 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_16 = 2 if formdef_version == 2512121811 & _p24a_q10_16 == 0 & (missing(q10_16))
quietly replace _p24_q10_16 = 4 if formdef_version == 2512121811 & _p24a_q10_16 == 1 & (missing(q10_16))
quietly replace _p24_q10_16 = 1 if formdef_version == 2512121811 & _p24a_q10_16 == 1 & (q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
quietly replace _p24_q10_16 = 5 if formdef_version == 2512121811 & _p24_q10_16 == 1 & (q10_16 == 98)
quietly count if formdef_version == 2512121811 & _p24_q10_16 == 5 & (q10_16 == 98)
file write `out' "P2.08,q10_16,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_16 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_16 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_16 = 2 if formdef_version == 2602120658 & _p24a_q10_16 == 0 & (missing(q10_16))
quietly replace _p24_q10_16 = 4 if formdef_version == 2602120658 & _p24a_q10_16 == 1 & (missing(q10_16))
quietly replace _p24_q10_16 = 1 if formdef_version == 2602120658 & _p24a_q10_16 == 1 & (q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
quietly replace _p24_q10_16 = 5 if formdef_version == 2602120658 & _p24_q10_16 == 1 & (q10_16 == 98)
quietly count if formdef_version == 2602120658 & _p24_q10_16 == 5 & (q10_16 == 98)
file write `out' "P2.08,q10_16,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q10_16 == `state' 
        file write `out' "P2.03,q10_16,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q10_16 == 1 & !(missing(q10_16)) & !(q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
file write `out' "P2.04,q10_16,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q10_16 == 1 & !(missing(q10_16)) & !(q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
file write `out' "P2.04,q10_16,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q10_16 == 1 & !(missing(q10_16)) & !(q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
file write `out' "P2.04,q10_16,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q10_16 == 1 & !(missing(q10_16)) & !(q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
file write `out' "P2.04,q10_16,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q10_16 == 1 & !(missing(q10_16)) & !(q10_16 == 1 | q10_16 == 2 | q10_16 == 3 | q10_16 == 4 | q10_16 == 98)
file write `out' "P2.04,q10_16,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q10_2: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q10_2 = 6
quietly gen byte _p24a_q10_2 = .
quietly replace _p24a_q10_2 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_2 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_2 = 2 if formdef_version == 2512090157 & _p24a_q10_2 == 0 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 4 if formdef_version == 2512090157 & _p24a_q10_2 == 1 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 1 if formdef_version == 2512090157 & _p24a_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q10_2 = 6 if formdef_version == 2512090157 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512090157 & _p24_q10_2 == 1 & (strtrim(q10_2) == "4")
quietly count if formdef_version == 2512090157 & _p24_q10_2 == 5 & (strtrim(q10_2) == "4")
file write `out' "P2.08,q10_2,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q10_2 = 6 if formdef_version == 2512090157 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512090157 & _p24_q10_2 == 1 & (strtrim(q10_2) == "98")
quietly count if formdef_version == 2512090157 & _p24_q10_2 == 5 & (strtrim(q10_2) == "98")
file write `out' "P2.08,q10_2,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_2 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_2 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_2 = 2 if formdef_version == 2512091719 & _p24a_q10_2 == 0 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 4 if formdef_version == 2512091719 & _p24a_q10_2 == 1 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 1 if formdef_version == 2512091719 & _p24a_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q10_2 = 6 if formdef_version == 2512091719 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512091719 & _p24_q10_2 == 1 & (strtrim(q10_2) == "4")
quietly count if formdef_version == 2512091719 & _p24_q10_2 == 5 & (strtrim(q10_2) == "4")
file write `out' "P2.08,q10_2,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q10_2 = 6 if formdef_version == 2512091719 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 6 if formdef_version == 2512091719 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512091719 & _p24_q10_2 == 1 & (strtrim(q10_2) == "98")
quietly count if formdef_version == 2512091719 & _p24_q10_2 == 5 & (strtrim(q10_2) == "98")
file write `out' "P2.08,q10_2,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_2 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_2 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_2 = 2 if formdef_version == 2512111044 & _p24a_q10_2 == 0 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 4 if formdef_version == 2512111044 & _p24a_q10_2 == 1 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 1 if formdef_version == 2512111044 & _p24a_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q10_2 = 6 if formdef_version == 2512111044 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512111044 & _p24_q10_2 == 1 & (strtrim(q10_2) == "4")
quietly count if formdef_version == 2512111044 & _p24_q10_2 == 5 & (strtrim(q10_2) == "4")
file write `out' "P2.08,q10_2,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q10_2 = 6 if formdef_version == 2512111044 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 6 if formdef_version == 2512111044 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512111044 & _p24_q10_2 == 1 & (strtrim(q10_2) == "98")
quietly count if formdef_version == 2512111044 & _p24_q10_2 == 5 & (strtrim(q10_2) == "98")
file write `out' "P2.08,q10_2,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_2 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_2 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_2 = 2 if formdef_version == 2512121811 & _p24a_q10_2 == 0 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 4 if formdef_version == 2512121811 & _p24a_q10_2 == 1 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 1 if formdef_version == 2512121811 & _p24a_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q10_2 = 6 if formdef_version == 2512121811 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512121811 & _p24_q10_2 == 1 & (strtrim(q10_2) == "4")
quietly count if formdef_version == 2512121811 & _p24_q10_2 == 5 & (strtrim(q10_2) == "4")
file write `out' "P2.08,q10_2,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q10_2 = 6 if formdef_version == 2512121811 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 6 if formdef_version == 2512121811 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512121811 & _p24_q10_2 == 1 & (strtrim(q10_2) == "98")
quietly count if formdef_version == 2512121811 & _p24_q10_2 == 5 & (strtrim(q10_2) == "98")
file write `out' "P2.08,q10_2,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_2 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_2 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_2 = 2 if formdef_version == 2602120658 & _p24a_q10_2 == 0 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 4 if formdef_version == 2602120658 & _p24a_q10_2 == 1 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 1 if formdef_version == 2602120658 & _p24a_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q10_2 = 6 if formdef_version == 2602120658 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2602120658 & _p24_q10_2 == 1 & (strtrim(q10_2) == "4")
quietly count if formdef_version == 2602120658 & _p24_q10_2 == 5 & (strtrim(q10_2) == "4")
file write `out' "P2.08,q10_2,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q10_2 = 6 if formdef_version == 2602120658 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 6 if formdef_version == 2602120658 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2602120658 & _p24_q10_2 == 1 & (strtrim(q10_2) == "98")
quietly count if formdef_version == 2602120658 & _p24_q10_2 == 5 & (strtrim(q10_2) == "98")
file write `out' "P2.08,q10_2,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q10_2 == `state' 
        file write `out' "P2.03,q10_2,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q10_2 == 1 & !(strtrim(q10_2) == "") & !(regexm(itrim(strtrim(q10_2)), "^(2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q10_2,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q10_2 == 1 & !(strtrim(q10_2) == "") & !(regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q10_2,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q10_2 == 1 & !(strtrim(q10_2) == "") & !(regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q10_2,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q10_2 == 1 & !(strtrim(q10_2) == "") & !(regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q10_2,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q10_2 == 1 & !(strtrim(q10_2) == "") & !(regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q10_2,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q10_4: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q10_4 = 6
quietly gen byte _p24a_q10_4 = .
quietly replace _p24a_q10_4 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_4 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_4 = 2 if formdef_version == 2512090157 & _p24a_q10_4 == 0 & (missing(q10_4))
quietly replace _p24_q10_4 = 4 if formdef_version == 2512090157 & _p24a_q10_4 == 1 & (missing(q10_4))
quietly replace _p24_q10_4 = 1 if formdef_version == 2512090157 & _p24a_q10_4 == 1 & (q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
quietly replace _p24a_q10_4 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_4 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_4 = 2 if formdef_version == 2512091719 & _p24a_q10_4 == 0 & (missing(q10_4))
quietly replace _p24_q10_4 = 4 if formdef_version == 2512091719 & _p24a_q10_4 == 1 & (missing(q10_4))
quietly replace _p24_q10_4 = 1 if formdef_version == 2512091719 & _p24a_q10_4 == 1 & (q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
quietly replace _p24a_q10_4 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_4 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_4 = 2 if formdef_version == 2512111044 & _p24a_q10_4 == 0 & (missing(q10_4))
quietly replace _p24_q10_4 = 4 if formdef_version == 2512111044 & _p24a_q10_4 == 1 & (missing(q10_4))
quietly replace _p24_q10_4 = 1 if formdef_version == 2512111044 & _p24a_q10_4 == 1 & (q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
quietly replace _p24a_q10_4 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_4 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_4 = 2 if formdef_version == 2512121811 & _p24a_q10_4 == 0 & (missing(q10_4))
quietly replace _p24_q10_4 = 4 if formdef_version == 2512121811 & _p24a_q10_4 == 1 & (missing(q10_4))
quietly replace _p24_q10_4 = 1 if formdef_version == 2512121811 & _p24a_q10_4 == 1 & (q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
quietly replace _p24a_q10_4 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_4 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_4 = 2 if formdef_version == 2602120658 & _p24a_q10_4 == 0 & (missing(q10_4))
quietly replace _p24_q10_4 = 4 if formdef_version == 2602120658 & _p24a_q10_4 == 1 & (missing(q10_4))
quietly replace _p24_q10_4 = 1 if formdef_version == 2602120658 & _p24a_q10_4 == 1 & (q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q10_4 == `state' 
        file write `out' "P2.03,q10_4,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q10_4 == 1 & !(missing(q10_4)) & !(q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
file write `out' "P2.04,q10_4,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q10_4 == 1 & !(missing(q10_4)) & !(q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
file write `out' "P2.04,q10_4,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q10_4 == 1 & !(missing(q10_4)) & !(q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
file write `out' "P2.04,q10_4,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q10_4 == 1 & !(missing(q10_4)) & !(q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
file write `out' "P2.04,q10_4,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q10_4 == 1 & !(missing(q10_4)) & !(q10_4 == 1 | q10_4 == 2 | q10_4 == 3 | q10_4 == 4)
file write `out' "P2.04,q10_4,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q10_6: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q10_6 = 6
quietly gen byte _p24a_q10_6 = .
quietly replace _p24a_q10_6 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_6 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_6 = 2 if formdef_version == 2512090157 & _p24a_q10_6 == 0 & (missing(q10_6))
quietly replace _p24_q10_6 = 4 if formdef_version == 2512090157 & _p24a_q10_6 == 1 & (missing(q10_6))
quietly replace _p24_q10_6 = 1 if formdef_version == 2512090157 & _p24a_q10_6 == 1 & (q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
quietly replace _p24_q10_6 = 5 if formdef_version == 2512090157 & _p24_q10_6 == 1 & (q10_6 == 98)
quietly count if formdef_version == 2512090157 & _p24_q10_6 == 5 & (q10_6 == 98)
file write `out' "P2.08,q10_6,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_6 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_6 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_6 = 2 if formdef_version == 2512091719 & _p24a_q10_6 == 0 & (missing(q10_6))
quietly replace _p24_q10_6 = 4 if formdef_version == 2512091719 & _p24a_q10_6 == 1 & (missing(q10_6))
quietly replace _p24_q10_6 = 1 if formdef_version == 2512091719 & _p24a_q10_6 == 1 & (q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
quietly replace _p24_q10_6 = 5 if formdef_version == 2512091719 & _p24_q10_6 == 1 & (q10_6 == 98)
quietly count if formdef_version == 2512091719 & _p24_q10_6 == 5 & (q10_6 == 98)
file write `out' "P2.08,q10_6,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_6 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_6 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_6 = 2 if formdef_version == 2512111044 & _p24a_q10_6 == 0 & (missing(q10_6))
quietly replace _p24_q10_6 = 4 if formdef_version == 2512111044 & _p24a_q10_6 == 1 & (missing(q10_6))
quietly replace _p24_q10_6 = 1 if formdef_version == 2512111044 & _p24a_q10_6 == 1 & (q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
quietly replace _p24_q10_6 = 5 if formdef_version == 2512111044 & _p24_q10_6 == 1 & (q10_6 == 98)
quietly count if formdef_version == 2512111044 & _p24_q10_6 == 5 & (q10_6 == 98)
file write `out' "P2.08,q10_6,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_6 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_6 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_6 = 2 if formdef_version == 2512121811 & _p24a_q10_6 == 0 & (missing(q10_6))
quietly replace _p24_q10_6 = 4 if formdef_version == 2512121811 & _p24a_q10_6 == 1 & (missing(q10_6))
quietly replace _p24_q10_6 = 1 if formdef_version == 2512121811 & _p24a_q10_6 == 1 & (q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
quietly replace _p24_q10_6 = 5 if formdef_version == 2512121811 & _p24_q10_6 == 1 & (q10_6 == 98)
quietly count if formdef_version == 2512121811 & _p24_q10_6 == 5 & (q10_6 == 98)
file write `out' "P2.08,q10_6,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q10_6 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_6 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_6 = 2 if formdef_version == 2602120658 & _p24a_q10_6 == 0 & (missing(q10_6))
quietly replace _p24_q10_6 = 4 if formdef_version == 2602120658 & _p24a_q10_6 == 1 & (missing(q10_6))
quietly replace _p24_q10_6 = 1 if formdef_version == 2602120658 & _p24a_q10_6 == 1 & (q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
quietly replace _p24_q10_6 = 5 if formdef_version == 2602120658 & _p24_q10_6 == 1 & (q10_6 == 98)
quietly count if formdef_version == 2602120658 & _p24_q10_6 == 5 & (q10_6 == 98)
file write `out' "P2.08,q10_6,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q10_6 == `state' 
        file write `out' "P2.03,q10_6,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q10_6 == 1 & !(missing(q10_6)) & !(q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
file write `out' "P2.04,q10_6,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q10_6 == 1 & !(missing(q10_6)) & !(q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
file write `out' "P2.04,q10_6,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q10_6 == 1 & !(missing(q10_6)) & !(q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
file write `out' "P2.04,q10_6,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q10_6 == 1 & !(missing(q10_6)) & !(q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
file write `out' "P2.04,q10_6,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q10_6 == 1 & !(missing(q10_6)) & !(q10_6 == 1 | q10_6 == 2 | q10_6 == 3 | q10_6 == 4 | q10_6 == 5 | q10_6 == 98)
file write `out' "P2.04,q10_6,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q2_1: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q2_1 = 6
quietly gen byte _p24a_q2_1 = .
quietly replace _p24a_q2_1 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_1 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_1 = 2 if formdef_version == 2512090157 & _p24a_q2_1 == 0 & (missing(q2_1))
quietly replace _p24_q2_1 = 4 if formdef_version == 2512090157 & _p24a_q2_1 == 1 & (missing(q2_1))
quietly replace _p24_q2_1 = 1 if formdef_version == 2512090157 & _p24a_q2_1 == 1 & (inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
quietly replace _p24a_q2_1 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_1 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_1 = 2 if formdef_version == 2512091719 & _p24a_q2_1 == 0 & (missing(q2_1))
quietly replace _p24_q2_1 = 4 if formdef_version == 2512091719 & _p24a_q2_1 == 1 & (missing(q2_1))
quietly replace _p24_q2_1 = 1 if formdef_version == 2512091719 & _p24a_q2_1 == 1 & (inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
quietly replace _p24a_q2_1 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_1 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_1 = 2 if formdef_version == 2512111044 & _p24a_q2_1 == 0 & (missing(q2_1))
quietly replace _p24_q2_1 = 4 if formdef_version == 2512111044 & _p24a_q2_1 == 1 & (missing(q2_1))
quietly replace _p24_q2_1 = 1 if formdef_version == 2512111044 & _p24a_q2_1 == 1 & (inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
quietly replace _p24a_q2_1 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_1 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_1 = 2 if formdef_version == 2512121811 & _p24a_q2_1 == 0 & (missing(q2_1))
quietly replace _p24_q2_1 = 4 if formdef_version == 2512121811 & _p24a_q2_1 == 1 & (missing(q2_1))
quietly replace _p24_q2_1 = 1 if formdef_version == 2512121811 & _p24a_q2_1 == 1 & (inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
quietly replace _p24a_q2_1 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_1 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_1 = 2 if formdef_version == 2602120658 & _p24a_q2_1 == 0 & (missing(q2_1))
quietly replace _p24_q2_1 = 4 if formdef_version == 2602120658 & _p24a_q2_1 == 1 & (missing(q2_1))
quietly replace _p24_q2_1 = 1 if formdef_version == 2602120658 & _p24a_q2_1 == 1 & (inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q2_1 == `state' 
        file write `out' "P2.03,q2_1,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q2_1 == 1 & !(missing(q2_1)) & !(inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
file write `out' "P2.04,q2_1,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q2_1 == 1 & !(missing(q2_1)) & !(inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
file write `out' "P2.04,q2_1,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q2_1 == 1 & !(missing(q2_1)) & !(inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
file write `out' "P2.04,q2_1,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q2_1 == 1 & !(missing(q2_1)) & !(inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
file write `out' "P2.04,q2_1,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q2_1 == 1 & !(missing(q2_1)) & !(inrange(q2_1,1950,2026) & q2_1 == floor(q2_1))
file write `out' "P2.04,q2_1,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q2_2: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q2_2 = 6
quietly gen byte _p24a_q2_2 = .
quietly replace _p24a_q2_2 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_2 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_2 = 2 if formdef_version == 2512090157 & _p24a_q2_2 == 0 & (missing(q2_2))
quietly replace _p24_q2_2 = 4 if formdef_version == 2512090157 & _p24a_q2_2 == 1 & (missing(q2_2))
quietly replace _p24_q2_2 = 1 if formdef_version == 2512090157 & _p24a_q2_2 == 1 & (q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
quietly replace _p24a_q2_2 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_2 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_2 = 2 if formdef_version == 2512091719 & _p24a_q2_2 == 0 & (missing(q2_2))
quietly replace _p24_q2_2 = 4 if formdef_version == 2512091719 & _p24a_q2_2 == 1 & (missing(q2_2))
quietly replace _p24_q2_2 = 1 if formdef_version == 2512091719 & _p24a_q2_2 == 1 & (q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
quietly replace _p24a_q2_2 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_2 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_2 = 2 if formdef_version == 2512111044 & _p24a_q2_2 == 0 & (missing(q2_2))
quietly replace _p24_q2_2 = 4 if formdef_version == 2512111044 & _p24a_q2_2 == 1 & (missing(q2_2))
quietly replace _p24_q2_2 = 1 if formdef_version == 2512111044 & _p24a_q2_2 == 1 & (q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
quietly replace _p24a_q2_2 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_2 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_2 = 2 if formdef_version == 2512121811 & _p24a_q2_2 == 0 & (missing(q2_2))
quietly replace _p24_q2_2 = 4 if formdef_version == 2512121811 & _p24a_q2_2 == 1 & (missing(q2_2))
quietly replace _p24_q2_2 = 1 if formdef_version == 2512121811 & _p24a_q2_2 == 1 & (q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
quietly replace _p24a_q2_2 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_2 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_2 = 2 if formdef_version == 2602120658 & _p24a_q2_2 == 0 & (missing(q2_2))
quietly replace _p24_q2_2 = 4 if formdef_version == 2602120658 & _p24a_q2_2 == 1 & (missing(q2_2))
quietly replace _p24_q2_2 = 1 if formdef_version == 2602120658 & _p24a_q2_2 == 1 & (q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q2_2 == `state' 
        file write `out' "P2.03,q2_2,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q2_2 == 1 & !(missing(q2_2)) & !(q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
file write `out' "P2.04,q2_2,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q2_2 == 1 & !(missing(q2_2)) & !(q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
file write `out' "P2.04,q2_2,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q2_2 == 1 & !(missing(q2_2)) & !(q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
file write `out' "P2.04,q2_2,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q2_2 == 1 & !(missing(q2_2)) & !(q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
file write `out' "P2.04,q2_2,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q2_2 == 1 & !(missing(q2_2)) & !(q2_2 == 1 | q2_2 == 2 | q2_2 == 3 | q2_2 == 4 | q2_2 == 5 | q2_2 == 6 | q2_2 == 7 | q2_2 == 8 | q2_2 == 9 | q2_2 == 10)
file write `out' "P2.04,q2_2,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q2_3: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q2_3 = 6
quietly gen byte _p24a_q2_3 = .
quietly replace _p24a_q2_3 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_3 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_3 = 2 if formdef_version == 2512090157 & _p24a_q2_3 == 0 & (missing(q2_3))
quietly replace _p24_q2_3 = 4 if formdef_version == 2512090157 & _p24a_q2_3 == 1 & (missing(q2_3))
quietly replace _p24_q2_3 = 1 if formdef_version == 2512090157 & _p24a_q2_3 == 1 & (q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
quietly replace _p24a_q2_3 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_3 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_3 = 2 if formdef_version == 2512091719 & _p24a_q2_3 == 0 & (missing(q2_3))
quietly replace _p24_q2_3 = 4 if formdef_version == 2512091719 & _p24a_q2_3 == 1 & (missing(q2_3))
quietly replace _p24_q2_3 = 1 if formdef_version == 2512091719 & _p24a_q2_3 == 1 & (q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
quietly replace _p24a_q2_3 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_3 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_3 = 2 if formdef_version == 2512111044 & _p24a_q2_3 == 0 & (missing(q2_3))
quietly replace _p24_q2_3 = 4 if formdef_version == 2512111044 & _p24a_q2_3 == 1 & (missing(q2_3))
quietly replace _p24_q2_3 = 1 if formdef_version == 2512111044 & _p24a_q2_3 == 1 & (q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
quietly replace _p24a_q2_3 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_3 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_3 = 2 if formdef_version == 2512121811 & _p24a_q2_3 == 0 & (missing(q2_3))
quietly replace _p24_q2_3 = 4 if formdef_version == 2512121811 & _p24a_q2_3 == 1 & (missing(q2_3))
quietly replace _p24_q2_3 = 1 if formdef_version == 2512121811 & _p24a_q2_3 == 1 & (q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
quietly replace _p24a_q2_3 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q2_3 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q2_3 = 2 if formdef_version == 2602120658 & _p24a_q2_3 == 0 & (missing(q2_3))
quietly replace _p24_q2_3 = 4 if formdef_version == 2602120658 & _p24a_q2_3 == 1 & (missing(q2_3))
quietly replace _p24_q2_3 = 1 if formdef_version == 2602120658 & _p24a_q2_3 == 1 & (q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q2_3 == `state' 
        file write `out' "P2.03,q2_3,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q2_3 == 1 & !(missing(q2_3)) & !(q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
file write `out' "P2.04,q2_3,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q2_3 == 1 & !(missing(q2_3)) & !(q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
file write `out' "P2.04,q2_3,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q2_3 == 1 & !(missing(q2_3)) & !(q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
file write `out' "P2.04,q2_3,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q2_3 == 1 & !(missing(q2_3)) & !(q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
file write `out' "P2.04,q2_3,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q2_3 == 1 & !(missing(q2_3)) & !(q2_3 == 1 | q2_3 == 2 | q2_3 == 3 | q2_3 == 4 | q2_3 == 5 | q2_3 == 6 | q2_3 == 7 | q2_3 == 8 | q2_3 == 9)
file write `out' "P2.04,q2_3,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3 = 6
quietly gen byte _p24a_q3 = .
quietly replace _p24a_q3 = 1 if formdef_version == 2512090157 & (1)
quietly replace _p24a_q3 = 0 if formdef_version == 2512090157 & (0)
quietly replace _p24_q3 = 2 if formdef_version == 2512090157 & _p24a_q3 == 0 & (missing(q3))
quietly replace _p24_q3 = 4 if formdef_version == 2512090157 & _p24a_q3 == 1 & (missing(q3))
quietly replace _p24_q3 = 1 if formdef_version == 2512090157 & _p24a_q3 == 1 & (q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4)
quietly replace _p24a_q3 = 1 if formdef_version == 2512091719 & (1)
quietly replace _p24a_q3 = 0 if formdef_version == 2512091719 & (0)
quietly replace _p24_q3 = 2 if formdef_version == 2512091719 & _p24a_q3 == 0 & (missing(q3))
quietly replace _p24_q3 = 4 if formdef_version == 2512091719 & _p24a_q3 == 1 & (missing(q3))
quietly replace _p24_q3 = 1 if formdef_version == 2512091719 & _p24a_q3 == 1 & (q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4)
quietly replace _p24a_q3 = 1 if formdef_version == 2512111044 & (1)
quietly replace _p24a_q3 = 0 if formdef_version == 2512111044 & (0)
quietly replace _p24_q3 = 2 if formdef_version == 2512111044 & _p24a_q3 == 0 & (missing(q3))
quietly replace _p24_q3 = 4 if formdef_version == 2512111044 & _p24a_q3 == 1 & (missing(q3))
quietly replace _p24_q3 = 1 if formdef_version == 2512111044 & _p24a_q3 == 1 & (q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4)
quietly replace _p24a_q3 = 1 if formdef_version == 2512121811 & (1)
quietly replace _p24a_q3 = 0 if formdef_version == 2512121811 & (0)
quietly replace _p24_q3 = 2 if formdef_version == 2512121811 & _p24a_q3 == 0 & (missing(q3))
quietly replace _p24_q3 = 4 if formdef_version == 2512121811 & _p24a_q3 == 1 & (missing(q3))
quietly replace _p24_q3 = 1 if formdef_version == 2512121811 & _p24a_q3 == 1 & (q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4)
quietly replace _p24a_q3 = 1 if formdef_version == 2602120658 & (1)
quietly replace _p24a_q3 = 0 if formdef_version == 2602120658 & (0)
quietly replace _p24_q3 = 2 if formdef_version == 2602120658 & _p24a_q3 == 0 & (missing(q3))
quietly replace _p24_q3 = 4 if formdef_version == 2602120658 & _p24a_q3 == 1 & (missing(q3))
quietly replace _p24_q3 = 1 if formdef_version == 2602120658 & _p24a_q3 == 1 & (q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4 | q3 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3 == `state' 
        file write `out' "P2.03,q3,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3 == 1 & !(missing(q3)) & !(q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4)
file write `out' "P2.04,q3,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3 == 1 & !(missing(q3)) & !(q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4)
file write `out' "P2.04,q3,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3 == 1 & !(missing(q3)) & !(q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4)
file write `out' "P2.04,q3,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3 == 1 & !(missing(q3)) & !(q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4)
file write `out' "P2.04,q3,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3 == 1 & !(missing(q3)) & !(q3 == 1 | q3 == 2 | q3 == 3 | q3 == 4 | q3 == 5)
file write `out' "P2.04,q3,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_1: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_1 = 6
quietly gen byte _p24a_q3_1 = .
quietly replace _p24a_q3_1 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_1 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_1 = 2 if formdef_version == 2512090157 & _p24a_q3_1 == 0 & (missing(q3_1))
quietly replace _p24_q3_1 = 4 if formdef_version == 2512090157 & _p24a_q3_1 == 1 & (missing(q3_1))
quietly replace _p24_q3_1 = 1 if formdef_version == 2512090157 & _p24a_q3_1 == 1 & (q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
quietly replace _p24a_q3_1 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_1 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_1 = 2 if formdef_version == 2512091719 & _p24a_q3_1 == 0 & (missing(q3_1))
quietly replace _p24_q3_1 = 4 if formdef_version == 2512091719 & _p24a_q3_1 == 1 & (missing(q3_1))
quietly replace _p24_q3_1 = 1 if formdef_version == 2512091719 & _p24a_q3_1 == 1 & (q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
quietly replace _p24a_q3_1 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_1 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_1 = 2 if formdef_version == 2512111044 & _p24a_q3_1 == 0 & (missing(q3_1))
quietly replace _p24_q3_1 = 4 if formdef_version == 2512111044 & _p24a_q3_1 == 1 & (missing(q3_1))
quietly replace _p24_q3_1 = 1 if formdef_version == 2512111044 & _p24a_q3_1 == 1 & (q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
quietly replace _p24a_q3_1 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_1 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_1 = 2 if formdef_version == 2512121811 & _p24a_q3_1 == 0 & (missing(q3_1))
quietly replace _p24_q3_1 = 4 if formdef_version == 2512121811 & _p24a_q3_1 == 1 & (missing(q3_1))
quietly replace _p24_q3_1 = 1 if formdef_version == 2512121811 & _p24a_q3_1 == 1 & (q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
quietly replace _p24a_q3_1 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_1 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_1 = 2 if formdef_version == 2602120658 & _p24a_q3_1 == 0 & (missing(q3_1))
quietly replace _p24_q3_1 = 4 if formdef_version == 2602120658 & _p24a_q3_1 == 1 & (missing(q3_1))
quietly replace _p24_q3_1 = 1 if formdef_version == 2602120658 & _p24a_q3_1 == 1 & (q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_1 == `state' 
        file write `out' "P2.03,q3_1,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_1 == 1 & !(missing(q3_1)) & !(q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
file write `out' "P2.04,q3_1,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_1 == 1 & !(missing(q3_1)) & !(q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
file write `out' "P2.04,q3_1,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_1 == 1 & !(missing(q3_1)) & !(q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
file write `out' "P2.04,q3_1,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_1 == 1 & !(missing(q3_1)) & !(q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
file write `out' "P2.04,q3_1,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_1 == 1 & !(missing(q3_1)) & !(q3_1 == 1 | q3_1 == 2 | q3_1 == 3)
file write `out' "P2.04,q3_1,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_12: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_12 = 6
quietly gen byte _p24a_q3_12 = .
quietly replace _p24a_q3_12 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_12 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_12 = 2 if formdef_version == 2512090157 & _p24a_q3_12 == 0 & (missing(q3_12))
quietly replace _p24_q3_12 = 4 if formdef_version == 2512090157 & _p24a_q3_12 == 1 & (missing(q3_12))
quietly replace _p24_q3_12 = 1 if formdef_version == 2512090157 & _p24a_q3_12 == 1 & (q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
quietly replace _p24a_q3_12 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_12 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_12 = 2 if formdef_version == 2512091719 & _p24a_q3_12 == 0 & (missing(q3_12))
quietly replace _p24_q3_12 = 4 if formdef_version == 2512091719 & _p24a_q3_12 == 1 & (missing(q3_12))
quietly replace _p24_q3_12 = 1 if formdef_version == 2512091719 & _p24a_q3_12 == 1 & (q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
quietly replace _p24a_q3_12 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_12 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_12 = 2 if formdef_version == 2512111044 & _p24a_q3_12 == 0 & (missing(q3_12))
quietly replace _p24_q3_12 = 4 if formdef_version == 2512111044 & _p24a_q3_12 == 1 & (missing(q3_12))
quietly replace _p24_q3_12 = 1 if formdef_version == 2512111044 & _p24a_q3_12 == 1 & (q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
quietly replace _p24a_q3_12 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_12 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_12 = 2 if formdef_version == 2512121811 & _p24a_q3_12 == 0 & (missing(q3_12))
quietly replace _p24_q3_12 = 4 if formdef_version == 2512121811 & _p24a_q3_12 == 1 & (missing(q3_12))
quietly replace _p24_q3_12 = 1 if formdef_version == 2512121811 & _p24a_q3_12 == 1 & (q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
quietly replace _p24a_q3_12 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_12 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_12 = 2 if formdef_version == 2602120658 & _p24a_q3_12 == 0 & (missing(q3_12))
quietly replace _p24_q3_12 = 4 if formdef_version == 2602120658 & _p24a_q3_12 == 1 & (missing(q3_12))
quietly replace _p24_q3_12 = 1 if formdef_version == 2602120658 & _p24a_q3_12 == 1 & (q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_12 == `state' 
        file write `out' "P2.03,q3_12,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_12 == 1 & !(missing(q3_12)) & !(q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
file write `out' "P2.04,q3_12,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_12 == 1 & !(missing(q3_12)) & !(q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
file write `out' "P2.04,q3_12,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_12 == 1 & !(missing(q3_12)) & !(q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
file write `out' "P2.04,q3_12,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_12 == 1 & !(missing(q3_12)) & !(q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
file write `out' "P2.04,q3_12,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_12 == 1 & !(missing(q3_12)) & !(q3_12 == 1 | q3_12 == 2 | q3_12 == 3)
file write `out' "P2.04,q3_12,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_15: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_15 = 6
quietly gen byte _p24a_q3_15 = .
quietly replace _p24a_q3_15 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)))
quietly replace _p24a_q3_15 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)))
quietly replace _p24_q3_15 = 2 if formdef_version == 2512090157 & _p24a_q3_15 == 0 & (missing(q3_15))
quietly replace _p24_q3_15 = 4 if formdef_version == 2512090157 & _p24a_q3_15 == 1 & (missing(q3_15))
quietly replace _p24_q3_15 = 1 if formdef_version == 2512090157 & _p24a_q3_15 == 1 & (q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
quietly replace _p24a_q3_15 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)))
quietly replace _p24a_q3_15 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)))
quietly replace _p24_q3_15 = 2 if formdef_version == 2512091719 & _p24a_q3_15 == 0 & (missing(q3_15))
quietly replace _p24_q3_15 = 4 if formdef_version == 2512091719 & _p24a_q3_15 == 1 & (missing(q3_15))
quietly replace _p24_q3_15 = 1 if formdef_version == 2512091719 & _p24a_q3_15 == 1 & (q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
quietly replace _p24a_q3_15 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)))
quietly replace _p24a_q3_15 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)))
quietly replace _p24_q3_15 = 2 if formdef_version == 2512111044 & _p24a_q3_15 == 0 & (missing(q3_15))
quietly replace _p24_q3_15 = 4 if formdef_version == 2512111044 & _p24a_q3_15 == 1 & (missing(q3_15))
quietly replace _p24_q3_15 = 1 if formdef_version == 2512111044 & _p24a_q3_15 == 1 & (q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
quietly replace _p24a_q3_15 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)))
quietly replace _p24a_q3_15 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)))
quietly replace _p24_q3_15 = 2 if formdef_version == 2512121811 & _p24a_q3_15 == 0 & (missing(q3_15))
quietly replace _p24_q3_15 = 4 if formdef_version == 2512121811 & _p24a_q3_15 == 1 & (missing(q3_15))
quietly replace _p24_q3_15 = 1 if formdef_version == 2512121811 & _p24a_q3_15 == 1 & (q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
quietly replace _p24a_q3_15 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)))
quietly replace _p24a_q3_15 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)))
quietly replace _p24_q3_15 = 2 if formdef_version == 2602120658 & _p24a_q3_15 == 0 & (missing(q3_15))
quietly replace _p24_q3_15 = 4 if formdef_version == 2602120658 & _p24a_q3_15 == 1 & (missing(q3_15))
quietly replace _p24_q3_15 = 1 if formdef_version == 2602120658 & _p24a_q3_15 == 1 & (q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_15 == `state' 
        file write `out' "P2.03,q3_15,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_15 == 1 & !(missing(q3_15)) & !(q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
file write `out' "P2.04,q3_15,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_15 == 1 & !(missing(q3_15)) & !(q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
file write `out' "P2.04,q3_15,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_15 == 1 & !(missing(q3_15)) & !(q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
file write `out' "P2.04,q3_15,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_15 == 1 & !(missing(q3_15)) & !(q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
file write `out' "P2.04,q3_15,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_15 == 1 & !(missing(q3_15)) & !(q3_15 == 1 | q3_15 == 2 | q3_15 == 3 | q3_15 == 4 | q3_15 == 5)
file write `out' "P2.04,q3_15,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_16: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_16 = 6
quietly gen byte _p24a_q3_16 = .
quietly replace _p24a_q3_16 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_16 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_16 = 2 if formdef_version == 2512090157 & _p24a_q3_16 == 0 & (missing(q3_16))
quietly replace _p24_q3_16 = 4 if formdef_version == 2512090157 & _p24a_q3_16 == 1 & (missing(q3_16))
quietly replace _p24_q3_16 = 1 if formdef_version == 2512090157 & _p24a_q3_16 == 1 & (q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
quietly replace _p24a_q3_16 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_16 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_16 = 2 if formdef_version == 2512091719 & _p24a_q3_16 == 0 & (missing(q3_16))
quietly replace _p24_q3_16 = 4 if formdef_version == 2512091719 & _p24a_q3_16 == 1 & (missing(q3_16))
quietly replace _p24_q3_16 = 1 if formdef_version == 2512091719 & _p24a_q3_16 == 1 & (q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
quietly replace _p24a_q3_16 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_16 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_16 = 2 if formdef_version == 2512111044 & _p24a_q3_16 == 0 & (missing(q3_16))
quietly replace _p24_q3_16 = 4 if formdef_version == 2512111044 & _p24a_q3_16 == 1 & (missing(q3_16))
quietly replace _p24_q3_16 = 1 if formdef_version == 2512111044 & _p24a_q3_16 == 1 & (q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
quietly replace _p24a_q3_16 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_16 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_16 = 2 if formdef_version == 2512121811 & _p24a_q3_16 == 0 & (missing(q3_16))
quietly replace _p24_q3_16 = 4 if formdef_version == 2512121811 & _p24a_q3_16 == 1 & (missing(q3_16))
quietly replace _p24_q3_16 = 1 if formdef_version == 2512121811 & _p24a_q3_16 == 1 & (q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
quietly replace _p24a_q3_16 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_16 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_16 = 2 if formdef_version == 2602120658 & _p24a_q3_16 == 0 & (missing(q3_16))
quietly replace _p24_q3_16 = 4 if formdef_version == 2602120658 & _p24a_q3_16 == 1 & (missing(q3_16))
quietly replace _p24_q3_16 = 1 if formdef_version == 2602120658 & _p24a_q3_16 == 1 & (q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_16 == `state' 
        file write `out' "P2.03,q3_16,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_16 == 1 & !(missing(q3_16)) & !(q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
file write `out' "P2.04,q3_16,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_16 == 1 & !(missing(q3_16)) & !(q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
file write `out' "P2.04,q3_16,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_16 == 1 & !(missing(q3_16)) & !(q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
file write `out' "P2.04,q3_16,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_16 == 1 & !(missing(q3_16)) & !(q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
file write `out' "P2.04,q3_16,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_16 == 1 & !(missing(q3_16)) & !(q3_16 == 1 | q3_16 == 2 | q3_16 == 3 | q3_16 == 4 | q3_16 == 5)
file write `out' "P2.04,q3_16,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_17: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_17 = 6
quietly gen byte _p24a_q3_17 = .
quietly replace _p24a_q3_17 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_17 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_17 = 2 if formdef_version == 2512090157 & _p24a_q3_17 == 0 & (missing(q3_17))
quietly replace _p24_q3_17 = 4 if formdef_version == 2512090157 & _p24a_q3_17 == 1 & (missing(q3_17))
quietly replace _p24_q3_17 = 1 if formdef_version == 2512090157 & _p24a_q3_17 == 1 & (q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
quietly replace _p24a_q3_17 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_17 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_17 = 2 if formdef_version == 2512091719 & _p24a_q3_17 == 0 & (missing(q3_17))
quietly replace _p24_q3_17 = 4 if formdef_version == 2512091719 & _p24a_q3_17 == 1 & (missing(q3_17))
quietly replace _p24_q3_17 = 1 if formdef_version == 2512091719 & _p24a_q3_17 == 1 & (q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
quietly replace _p24a_q3_17 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_17 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_17 = 2 if formdef_version == 2512111044 & _p24a_q3_17 == 0 & (missing(q3_17))
quietly replace _p24_q3_17 = 4 if formdef_version == 2512111044 & _p24a_q3_17 == 1 & (missing(q3_17))
quietly replace _p24_q3_17 = 1 if formdef_version == 2512111044 & _p24a_q3_17 == 1 & (q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
quietly replace _p24a_q3_17 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_17 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_17 = 2 if formdef_version == 2512121811 & _p24a_q3_17 == 0 & (missing(q3_17))
quietly replace _p24_q3_17 = 4 if formdef_version == 2512121811 & _p24a_q3_17 == 1 & (missing(q3_17))
quietly replace _p24_q3_17 = 1 if formdef_version == 2512121811 & _p24a_q3_17 == 1 & (q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
quietly replace _p24a_q3_17 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_17 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_17 = 2 if formdef_version == 2602120658 & _p24a_q3_17 == 0 & (missing(q3_17))
quietly replace _p24_q3_17 = 4 if formdef_version == 2602120658 & _p24a_q3_17 == 1 & (missing(q3_17))
quietly replace _p24_q3_17 = 1 if formdef_version == 2602120658 & _p24a_q3_17 == 1 & (q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_17 == `state' 
        file write `out' "P2.03,q3_17,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_17 == 1 & !(missing(q3_17)) & !(q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
file write `out' "P2.04,q3_17,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_17 == 1 & !(missing(q3_17)) & !(q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
file write `out' "P2.04,q3_17,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_17 == 1 & !(missing(q3_17)) & !(q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
file write `out' "P2.04,q3_17,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_17 == 1 & !(missing(q3_17)) & !(q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
file write `out' "P2.04,q3_17,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_17 == 1 & !(missing(q3_17)) & !(q3_17 == 1 | q3_17 == 2 | q3_17 == 3 | q3_17 == 4 | q3_17 == 5)
file write `out' "P2.04,q3_17,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_20: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_20 = 6
quietly gen byte _p24a_q3_20 = .
quietly replace _p24a_q3_20 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
quietly replace _p24a_q3_20 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
quietly replace _p24_q3_20 = 2 if formdef_version == 2512090157 & _p24a_q3_20 == 0 & (missing(q3_20))
quietly replace _p24_q3_20 = 4 if formdef_version == 2512090157 & _p24a_q3_20 == 1 & (missing(q3_20))
quietly replace _p24_q3_20 = 1 if formdef_version == 2512090157 & _p24a_q3_20 == 1 & (q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
quietly replace _p24a_q3_20 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
quietly replace _p24a_q3_20 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
quietly replace _p24_q3_20 = 2 if formdef_version == 2512091719 & _p24a_q3_20 == 0 & (missing(q3_20))
quietly replace _p24_q3_20 = 4 if formdef_version == 2512091719 & _p24a_q3_20 == 1 & (missing(q3_20))
quietly replace _p24_q3_20 = 1 if formdef_version == 2512091719 & _p24a_q3_20 == 1 & (q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
quietly replace _p24a_q3_20 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
quietly replace _p24a_q3_20 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
quietly replace _p24_q3_20 = 2 if formdef_version == 2512111044 & _p24a_q3_20 == 0 & (missing(q3_20))
quietly replace _p24_q3_20 = 4 if formdef_version == 2512111044 & _p24a_q3_20 == 1 & (missing(q3_20))
quietly replace _p24_q3_20 = 1 if formdef_version == 2512111044 & _p24a_q3_20 == 1 & (q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
quietly replace _p24a_q3_20 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
quietly replace _p24a_q3_20 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
quietly replace _p24_q3_20 = 2 if formdef_version == 2512121811 & _p24a_q3_20 == 0 & (missing(q3_20))
quietly replace _p24_q3_20 = 4 if formdef_version == 2512121811 & _p24a_q3_20 == 1 & (missing(q3_20))
quietly replace _p24_q3_20 = 1 if formdef_version == 2512121811 & _p24a_q3_20 == 1 & (q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
quietly replace _p24a_q3_20 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
quietly replace _p24a_q3_20 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
quietly replace _p24_q3_20 = 2 if formdef_version == 2602120658 & _p24a_q3_20 == 0 & (missing(q3_20))
quietly replace _p24_q3_20 = 4 if formdef_version == 2602120658 & _p24a_q3_20 == 1 & (missing(q3_20))
quietly replace _p24_q3_20 = 1 if formdef_version == 2602120658 & _p24a_q3_20 == 1 & (q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_20 == `state' 
        file write `out' "P2.03,q3_20,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_20 == 1 & !(missing(q3_20)) & !(q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
file write `out' "P2.04,q3_20,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_20 == 1 & !(missing(q3_20)) & !(q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
file write `out' "P2.04,q3_20,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_20 == 1 & !(missing(q3_20)) & !(q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
file write `out' "P2.04,q3_20,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_20 == 1 & !(missing(q3_20)) & !(q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
file write `out' "P2.04,q3_20,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_20 == 1 & !(missing(q3_20)) & !(q3_20 == 1 | q3_20 == 2 | q3_20 == 3 | q3_20 == 4)
file write `out' "P2.04,q3_20,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_21: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_21 = 6
quietly gen byte _p24a_q3_21 = .
quietly replace _p24a_q3_21 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_21 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_21 = 2 if formdef_version == 2512090157 & _p24a_q3_21 == 0 & (missing(q3_21))
quietly replace _p24_q3_21 = 4 if formdef_version == 2512090157 & _p24a_q3_21 == 1 & (missing(q3_21))
quietly replace _p24_q3_21 = 1 if formdef_version == 2512090157 & _p24a_q3_21 == 1 & (q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
quietly replace _p24_q3_21 = 5 if formdef_version == 2512090157 & _p24_q3_21 == 1 & (q3_21 == 4)
quietly count if formdef_version == 2512090157 & _p24_q3_21 == 5 & (q3_21 == 4)
file write `out' "P2.08,q3_21,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_21 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_21 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_21 = 2 if formdef_version == 2512091719 & _p24a_q3_21 == 0 & (missing(q3_21))
quietly replace _p24_q3_21 = 4 if formdef_version == 2512091719 & _p24a_q3_21 == 1 & (missing(q3_21))
quietly replace _p24_q3_21 = 1 if formdef_version == 2512091719 & _p24a_q3_21 == 1 & (q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
quietly replace _p24_q3_21 = 5 if formdef_version == 2512091719 & _p24_q3_21 == 1 & (q3_21 == 4)
quietly count if formdef_version == 2512091719 & _p24_q3_21 == 5 & (q3_21 == 4)
file write `out' "P2.08,q3_21,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_21 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_21 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_21 = 2 if formdef_version == 2512111044 & _p24a_q3_21 == 0 & (missing(q3_21))
quietly replace _p24_q3_21 = 4 if formdef_version == 2512111044 & _p24a_q3_21 == 1 & (missing(q3_21))
quietly replace _p24_q3_21 = 1 if formdef_version == 2512111044 & _p24a_q3_21 == 1 & (q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
quietly replace _p24_q3_21 = 5 if formdef_version == 2512111044 & _p24_q3_21 == 1 & (q3_21 == 4)
quietly count if formdef_version == 2512111044 & _p24_q3_21 == 5 & (q3_21 == 4)
file write `out' "P2.08,q3_21,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_21 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_21 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_21 = 2 if formdef_version == 2512121811 & _p24a_q3_21 == 0 & (missing(q3_21))
quietly replace _p24_q3_21 = 4 if formdef_version == 2512121811 & _p24a_q3_21 == 1 & (missing(q3_21))
quietly replace _p24_q3_21 = 1 if formdef_version == 2512121811 & _p24a_q3_21 == 1 & (q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
quietly replace _p24_q3_21 = 5 if formdef_version == 2512121811 & _p24_q3_21 == 1 & (q3_21 == 4)
quietly count if formdef_version == 2512121811 & _p24_q3_21 == 5 & (q3_21 == 4)
file write `out' "P2.08,q3_21,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_21 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_21 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_21 = 2 if formdef_version == 2602120658 & _p24a_q3_21 == 0 & (missing(q3_21))
quietly replace _p24_q3_21 = 4 if formdef_version == 2602120658 & _p24a_q3_21 == 1 & (missing(q3_21))
quietly replace _p24_q3_21 = 1 if formdef_version == 2602120658 & _p24a_q3_21 == 1 & (q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
quietly replace _p24_q3_21 = 5 if formdef_version == 2602120658 & _p24_q3_21 == 1 & (q3_21 == 4)
quietly count if formdef_version == 2602120658 & _p24_q3_21 == 5 & (q3_21 == 4)
file write `out' "P2.08,q3_21,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_21 == `state' 
        file write `out' "P2.03,q3_21,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_21 == 1 & !(missing(q3_21)) & !(q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
file write `out' "P2.04,q3_21,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_21 == 1 & !(missing(q3_21)) & !(q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
file write `out' "P2.04,q3_21,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_21 == 1 & !(missing(q3_21)) & !(q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
file write `out' "P2.04,q3_21,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_21 == 1 & !(missing(q3_21)) & !(q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
file write `out' "P2.04,q3_21,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_21 == 1 & !(missing(q3_21)) & !(q3_21 == 1 | q3_21 == 2 | q3_21 == 3 | q3_21 == 4)
file write `out' "P2.04,q3_21,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_22: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_22 = 6
quietly gen byte _p24a_q3_22 = .
quietly replace _p24a_q3_22 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_22 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_22 = 2 if formdef_version == 2512090157 & _p24a_q3_22 == 0 & (missing(q3_22))
quietly replace _p24_q3_22 = 4 if formdef_version == 2512090157 & _p24a_q3_22 == 1 & (missing(q3_22))
quietly replace _p24_q3_22 = 1 if formdef_version == 2512090157 & _p24a_q3_22 == 1 & (q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
quietly replace _p24_q3_22 = 5 if formdef_version == 2512090157 & _p24_q3_22 == 1 & (q3_22 == 3)
quietly count if formdef_version == 2512090157 & _p24_q3_22 == 5 & (q3_22 == 3)
file write `out' "P2.08,q3_22,2512090157,sentinel,nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_22 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_22 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_22 = 2 if formdef_version == 2512091719 & _p24a_q3_22 == 0 & (missing(q3_22))
quietly replace _p24_q3_22 = 4 if formdef_version == 2512091719 & _p24a_q3_22 == 1 & (missing(q3_22))
quietly replace _p24_q3_22 = 1 if formdef_version == 2512091719 & _p24a_q3_22 == 1 & (q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
quietly replace _p24_q3_22 = 5 if formdef_version == 2512091719 & _p24_q3_22 == 1 & (q3_22 == 3)
quietly count if formdef_version == 2512091719 & _p24_q3_22 == 5 & (q3_22 == 3)
file write `out' "P2.08,q3_22,2512091719,sentinel,nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_22 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_22 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_22 = 2 if formdef_version == 2512111044 & _p24a_q3_22 == 0 & (missing(q3_22))
quietly replace _p24_q3_22 = 4 if formdef_version == 2512111044 & _p24a_q3_22 == 1 & (missing(q3_22))
quietly replace _p24_q3_22 = 1 if formdef_version == 2512111044 & _p24a_q3_22 == 1 & (q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
quietly replace _p24_q3_22 = 5 if formdef_version == 2512111044 & _p24_q3_22 == 1 & (q3_22 == 3)
quietly count if formdef_version == 2512111044 & _p24_q3_22 == 5 & (q3_22 == 3)
file write `out' "P2.08,q3_22,2512111044,sentinel,nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_22 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_22 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_22 = 2 if formdef_version == 2512121811 & _p24a_q3_22 == 0 & (missing(q3_22))
quietly replace _p24_q3_22 = 4 if formdef_version == 2512121811 & _p24a_q3_22 == 1 & (missing(q3_22))
quietly replace _p24_q3_22 = 1 if formdef_version == 2512121811 & _p24a_q3_22 == 1 & (q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
quietly replace _p24_q3_22 = 5 if formdef_version == 2512121811 & _p24_q3_22 == 1 & (q3_22 == 3)
quietly count if formdef_version == 2512121811 & _p24_q3_22 == 5 & (q3_22 == 3)
file write `out' "P2.08,q3_22,2512121811,sentinel,nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_22 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_22 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_22 = 2 if formdef_version == 2602120658 & _p24a_q3_22 == 0 & (missing(q3_22))
quietly replace _p24_q3_22 = 4 if formdef_version == 2602120658 & _p24a_q3_22 == 1 & (missing(q3_22))
quietly replace _p24_q3_22 = 1 if formdef_version == 2602120658 & _p24a_q3_22 == 1 & (q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
quietly replace _p24_q3_22 = 5 if formdef_version == 2602120658 & _p24_q3_22 == 1 & (q3_22 == 3)
quietly count if formdef_version == 2602120658 & _p24_q3_22 == 5 & (q3_22 == 3)
file write `out' "P2.08,q3_22,2602120658,sentinel,nonuse,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_22 == `state' 
        file write `out' "P2.03,q3_22,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_22 == 1 & !(missing(q3_22)) & !(q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
file write `out' "P2.04,q3_22,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_22 == 1 & !(missing(q3_22)) & !(q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
file write `out' "P2.04,q3_22,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_22 == 1 & !(missing(q3_22)) & !(q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
file write `out' "P2.04,q3_22,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_22 == 1 & !(missing(q3_22)) & !(q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
file write `out' "P2.04,q3_22,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_22 == 1 & !(missing(q3_22)) & !(q3_22 == 1 | q3_22 == 2 | q3_22 == 3)
file write `out' "P2.04,q3_22,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_23: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_23 = 6
quietly gen byte _p24a_q3_23 = .
quietly replace _p24a_q3_23 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
quietly replace _p24a_q3_23 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
quietly replace _p24_q3_23 = 2 if formdef_version == 2512090157 & _p24a_q3_23 == 0 & (missing(q3_23))
quietly replace _p24_q3_23 = 4 if formdef_version == 2512090157 & _p24a_q3_23 == 1 & (missing(q3_23))
quietly replace _p24_q3_23 = 1 if formdef_version == 2512090157 & _p24a_q3_23 == 1 & (q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
quietly replace _p24_q3_23 = 5 if formdef_version == 2512090157 & _p24_q3_23 == 1 & (q3_23 == 5)
quietly count if formdef_version == 2512090157 & _p24_q3_23 == 5 & (q3_23 == 5)
file write `out' "P2.08,q3_23,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_23 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
quietly replace _p24a_q3_23 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
quietly replace _p24_q3_23 = 2 if formdef_version == 2512091719 & _p24a_q3_23 == 0 & (missing(q3_23))
quietly replace _p24_q3_23 = 4 if formdef_version == 2512091719 & _p24a_q3_23 == 1 & (missing(q3_23))
quietly replace _p24_q3_23 = 1 if formdef_version == 2512091719 & _p24a_q3_23 == 1 & (q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
quietly replace _p24_q3_23 = 5 if formdef_version == 2512091719 & _p24_q3_23 == 1 & (q3_23 == 5)
quietly count if formdef_version == 2512091719 & _p24_q3_23 == 5 & (q3_23 == 5)
file write `out' "P2.08,q3_23,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_23 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
quietly replace _p24a_q3_23 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
quietly replace _p24_q3_23 = 2 if formdef_version == 2512111044 & _p24a_q3_23 == 0 & (missing(q3_23))
quietly replace _p24_q3_23 = 4 if formdef_version == 2512111044 & _p24a_q3_23 == 1 & (missing(q3_23))
quietly replace _p24_q3_23 = 1 if formdef_version == 2512111044 & _p24a_q3_23 == 1 & (q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
quietly replace _p24_q3_23 = 5 if formdef_version == 2512111044 & _p24_q3_23 == 1 & (q3_23 == 5)
quietly count if formdef_version == 2512111044 & _p24_q3_23 == 5 & (q3_23 == 5)
file write `out' "P2.08,q3_23,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_23 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
quietly replace _p24a_q3_23 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
quietly replace _p24_q3_23 = 2 if formdef_version == 2512121811 & _p24a_q3_23 == 0 & (missing(q3_23))
quietly replace _p24_q3_23 = 4 if formdef_version == 2512121811 & _p24a_q3_23 == 1 & (missing(q3_23))
quietly replace _p24_q3_23 = 1 if formdef_version == 2512121811 & _p24a_q3_23 == 1 & (q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
quietly replace _p24_q3_23 = 5 if formdef_version == 2512121811 & _p24_q3_23 == 1 & (q3_23 == 5)
quietly count if formdef_version == 2512121811 & _p24_q3_23 == 5 & (q3_23 == 5)
file write `out' "P2.08,q3_23,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_23 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5))))
quietly replace _p24a_q3_23 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5))))
quietly replace _p24_q3_23 = 2 if formdef_version == 2602120658 & _p24a_q3_23 == 0 & (missing(q3_23))
quietly replace _p24_q3_23 = 4 if formdef_version == 2602120658 & _p24a_q3_23 == 1 & (missing(q3_23))
quietly replace _p24_q3_23 = 1 if formdef_version == 2602120658 & _p24a_q3_23 == 1 & (q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
quietly replace _p24_q3_23 = 5 if formdef_version == 2602120658 & _p24_q3_23 == 1 & (q3_23 == 5)
quietly count if formdef_version == 2602120658 & _p24_q3_23 == 5 & (q3_23 == 5)
file write `out' "P2.08,q3_23,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_23 == `state' 
        file write `out' "P2.03,q3_23,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_23 == 1 & !(missing(q3_23)) & !(q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
file write `out' "P2.04,q3_23,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_23 == 1 & !(missing(q3_23)) & !(q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
file write `out' "P2.04,q3_23,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_23 == 1 & !(missing(q3_23)) & !(q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
file write `out' "P2.04,q3_23,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_23 == 1 & !(missing(q3_23)) & !(q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
file write `out' "P2.04,q3_23,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_23 == 1 & !(missing(q3_23)) & !(q3_23 == 1 | q3_23 == 2 | q3_23 == 3 | q3_23 == 4 | q3_23 == 5)
file write `out' "P2.04,q3_23,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_5: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_5 = 6
quietly gen byte _p24a_q3_5 = .
quietly replace _p24a_q3_5 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_5 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_5 = 2 if formdef_version == 2512090157 & _p24a_q3_5 == 0 & (missing(q3_5))
quietly replace _p24_q3_5 = 4 if formdef_version == 2512090157 & _p24a_q3_5 == 1 & (missing(q3_5))
quietly replace _p24_q3_5 = 1 if formdef_version == 2512090157 & _p24a_q3_5 == 1 & (q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
quietly replace _p24a_q3_5 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_5 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_5 = 2 if formdef_version == 2512091719 & _p24a_q3_5 == 0 & (missing(q3_5))
quietly replace _p24_q3_5 = 4 if formdef_version == 2512091719 & _p24a_q3_5 == 1 & (missing(q3_5))
quietly replace _p24_q3_5 = 1 if formdef_version == 2512091719 & _p24a_q3_5 == 1 & (q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
quietly replace _p24a_q3_5 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_5 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_5 = 2 if formdef_version == 2512111044 & _p24a_q3_5 == 0 & (missing(q3_5))
quietly replace _p24_q3_5 = 4 if formdef_version == 2512111044 & _p24a_q3_5 == 1 & (missing(q3_5))
quietly replace _p24_q3_5 = 1 if formdef_version == 2512111044 & _p24a_q3_5 == 1 & (q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
quietly replace _p24a_q3_5 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_5 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_5 = 2 if formdef_version == 2512121811 & _p24a_q3_5 == 0 & (missing(q3_5))
quietly replace _p24_q3_5 = 4 if formdef_version == 2512121811 & _p24a_q3_5 == 1 & (missing(q3_5))
quietly replace _p24_q3_5 = 1 if formdef_version == 2512121811 & _p24a_q3_5 == 1 & (q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
quietly replace _p24a_q3_5 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q3_5 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q3_5 = 2 if formdef_version == 2602120658 & _p24a_q3_5 == 0 & (missing(q3_5))
quietly replace _p24_q3_5 = 4 if formdef_version == 2602120658 & _p24a_q3_5 == 1 & (missing(q3_5))
quietly replace _p24_q3_5 = 1 if formdef_version == 2602120658 & _p24a_q3_5 == 1 & (q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_5 == `state' 
        file write `out' "P2.03,q3_5,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_5 == 1 & !(missing(q3_5)) & !(q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
file write `out' "P2.04,q3_5,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_5 == 1 & !(missing(q3_5)) & !(q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
file write `out' "P2.04,q3_5,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_5 == 1 & !(missing(q3_5)) & !(q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
file write `out' "P2.04,q3_5,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_5 == 1 & !(missing(q3_5)) & !(q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
file write `out' "P2.04,q3_5,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_5 == 1 & !(missing(q3_5)) & !(q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5)
file write `out' "P2.04,q3_5,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_6: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_6 = 6
quietly gen byte _p24a_q3_6 = .
quietly replace _p24a_q3_6 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5)))
quietly replace _p24a_q3_6 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5)))
quietly replace _p24_q3_6 = 2 if formdef_version == 2512090157 & _p24a_q3_6 == 0 & (missing(q3_6))
quietly replace _p24_q3_6 = 4 if formdef_version == 2512090157 & _p24a_q3_6 == 1 & (missing(q3_6))
quietly replace _p24_q3_6 = 1 if formdef_version == 2512090157 & _p24a_q3_6 == 1 & (q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
quietly replace _p24a_q3_6 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5)))
quietly replace _p24a_q3_6 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5)))
quietly replace _p24_q3_6 = 2 if formdef_version == 2512091719 & _p24a_q3_6 == 0 & (missing(q3_6))
quietly replace _p24_q3_6 = 4 if formdef_version == 2512091719 & _p24a_q3_6 == 1 & (missing(q3_6))
quietly replace _p24_q3_6 = 1 if formdef_version == 2512091719 & _p24a_q3_6 == 1 & (q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
quietly replace _p24a_q3_6 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5)))
quietly replace _p24a_q3_6 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5)))
quietly replace _p24_q3_6 = 2 if formdef_version == 2512111044 & _p24a_q3_6 == 0 & (missing(q3_6))
quietly replace _p24_q3_6 = 4 if formdef_version == 2512111044 & _p24a_q3_6 == 1 & (missing(q3_6))
quietly replace _p24_q3_6 = 1 if formdef_version == 2512111044 & _p24a_q3_6 == 1 & (q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
quietly replace _p24a_q3_6 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5)))
quietly replace _p24a_q3_6 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5)))
quietly replace _p24_q3_6 = 2 if formdef_version == 2512121811 & _p24a_q3_6 == 0 & (missing(q3_6))
quietly replace _p24_q3_6 = 4 if formdef_version == 2512121811 & _p24a_q3_6 == 1 & (missing(q3_6))
quietly replace _p24_q3_6 = 1 if formdef_version == 2512121811 & _p24a_q3_6 == 1 & (q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
quietly replace _p24a_q3_6 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & (q3_5 != 5)))
quietly replace _p24a_q3_6 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q3_5 == 1 | q3_5 == 2 | q3_5 == 3 | q3_5 == 4 | q3_5 == 5) & !(q3_5 != 5)))
quietly replace _p24_q3_6 = 2 if formdef_version == 2602120658 & _p24a_q3_6 == 0 & (missing(q3_6))
quietly replace _p24_q3_6 = 4 if formdef_version == 2602120658 & _p24a_q3_6 == 1 & (missing(q3_6))
quietly replace _p24_q3_6 = 1 if formdef_version == 2602120658 & _p24a_q3_6 == 1 & (q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_6 == `state' 
        file write `out' "P2.03,q3_6,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_6 == 1 & !(missing(q3_6)) & !(q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
file write `out' "P2.04,q3_6,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_6 == 1 & !(missing(q3_6)) & !(q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
file write `out' "P2.04,q3_6,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_6 == 1 & !(missing(q3_6)) & !(q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
file write `out' "P2.04,q3_6,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_6 == 1 & !(missing(q3_6)) & !(q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
file write `out' "P2.04,q3_6,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_6 == 1 & !(missing(q3_6)) & !(q3_6 == 1 | q3_6 == 2 | q3_6 == 3 | q3_6 == 4 | q3_6 == 5 | q3_6 == 6)
file write `out' "P2.04,q3_6,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_7: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_7 = 6
quietly gen byte _p24a_q3_7 = .
quietly replace _p24a_q3_7 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_7 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_7 = 2 if formdef_version == 2512090157 & _p24a_q3_7 == 0 & (missing(q3_7))
quietly replace _p24_q3_7 = 4 if formdef_version == 2512090157 & _p24a_q3_7 == 1 & (missing(q3_7))
quietly replace _p24_q3_7 = 1 if formdef_version == 2512090157 & _p24a_q3_7 == 1 & (q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
quietly replace _p24_q3_7 = 5 if formdef_version == 2512090157 & _p24_q3_7 == 1 & (q3_7 == 99)
quietly count if formdef_version == 2512090157 & _p24_q3_7 == 5 & (q3_7 == 99)
file write `out' "P2.08,q3_7,2512090157,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_7 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_7 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_7 = 2 if formdef_version == 2512091719 & _p24a_q3_7 == 0 & (missing(q3_7))
quietly replace _p24_q3_7 = 4 if formdef_version == 2512091719 & _p24a_q3_7 == 1 & (missing(q3_7))
quietly replace _p24_q3_7 = 1 if formdef_version == 2512091719 & _p24a_q3_7 == 1 & (q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
quietly replace _p24_q3_7 = 5 if formdef_version == 2512091719 & _p24_q3_7 == 1 & (q3_7 == 99)
quietly count if formdef_version == 2512091719 & _p24_q3_7 == 5 & (q3_7 == 99)
file write `out' "P2.08,q3_7,2512091719,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_7 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_7 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_7 = 2 if formdef_version == 2512111044 & _p24a_q3_7 == 0 & (missing(q3_7))
quietly replace _p24_q3_7 = 4 if formdef_version == 2512111044 & _p24a_q3_7 == 1 & (missing(q3_7))
quietly replace _p24_q3_7 = 1 if formdef_version == 2512111044 & _p24a_q3_7 == 1 & (q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
quietly replace _p24_q3_7 = 5 if formdef_version == 2512111044 & _p24_q3_7 == 1 & (q3_7 == 99)
quietly count if formdef_version == 2512111044 & _p24_q3_7 == 5 & (q3_7 == 99)
file write `out' "P2.08,q3_7,2512111044,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_7 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_7 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_7 = 2 if formdef_version == 2512121811 & _p24a_q3_7 == 0 & (missing(q3_7))
quietly replace _p24_q3_7 = 4 if formdef_version == 2512121811 & _p24a_q3_7 == 1 & (missing(q3_7))
quietly replace _p24_q3_7 = 1 if formdef_version == 2512121811 & _p24a_q3_7 == 1 & (q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
quietly replace _p24_q3_7 = 5 if formdef_version == 2512121811 & _p24_q3_7 == 1 & (q3_7 == 99)
quietly count if formdef_version == 2512121811 & _p24_q3_7 == 5 & (q3_7 == 99)
file write `out' "P2.08,q3_7,2512121811,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_7 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_7 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_7 = 2 if formdef_version == 2602120658 & _p24a_q3_7 == 0 & (missing(q3_7))
quietly replace _p24_q3_7 = 4 if formdef_version == 2602120658 & _p24a_q3_7 == 1 & (missing(q3_7))
quietly replace _p24_q3_7 = 1 if formdef_version == 2602120658 & _p24a_q3_7 == 1 & (q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
quietly replace _p24_q3_7 = 5 if formdef_version == 2602120658 & _p24_q3_7 == 1 & (q3_7 == 99)
quietly count if formdef_version == 2602120658 & _p24_q3_7 == 5 & (q3_7 == 99)
file write `out' "P2.08,q3_7,2602120658,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_7 == `state' 
        file write `out' "P2.03,q3_7,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_7 == 1 & !(missing(q3_7)) & !(q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
file write `out' "P2.04,q3_7,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_7 == 1 & !(missing(q3_7)) & !(q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
file write `out' "P2.04,q3_7,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_7 == 1 & !(missing(q3_7)) & !(q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
file write `out' "P2.04,q3_7,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_7 == 1 & !(missing(q3_7)) & !(q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
file write `out' "P2.04,q3_7,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_7 == 1 & !(missing(q3_7)) & !(q3_7 == 1 | q3_7 == 2 | q3_7 == 3 | q3_7 == 99)
file write `out' "P2.04,q3_7,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q3_8: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q3_8 = 6
quietly gen byte _p24a_q3_8 = .
quietly replace _p24a_q3_8 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_8 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_8 = 2 if formdef_version == 2512090157 & _p24a_q3_8 == 0 & (missing(q3_8))
quietly replace _p24_q3_8 = 4 if formdef_version == 2512090157 & _p24a_q3_8 == 1 & (missing(q3_8))
quietly replace _p24_q3_8 = 1 if formdef_version == 2512090157 & _p24a_q3_8 == 1 & (q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
quietly replace _p24_q3_8 = 5 if formdef_version == 2512090157 & _p24_q3_8 == 1 & (q3_8 == 99)
quietly count if formdef_version == 2512090157 & _p24_q3_8 == 5 & (q3_8 == 99)
file write `out' "P2.08,q3_8,2512090157,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_8 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_8 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_8 = 2 if formdef_version == 2512091719 & _p24a_q3_8 == 0 & (missing(q3_8))
quietly replace _p24_q3_8 = 4 if formdef_version == 2512091719 & _p24a_q3_8 == 1 & (missing(q3_8))
quietly replace _p24_q3_8 = 1 if formdef_version == 2512091719 & _p24a_q3_8 == 1 & (q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
quietly replace _p24_q3_8 = 5 if formdef_version == 2512091719 & _p24_q3_8 == 1 & (q3_8 == 99)
quietly count if formdef_version == 2512091719 & _p24_q3_8 == 5 & (q3_8 == 99)
file write `out' "P2.08,q3_8,2512091719,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_8 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_8 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_8 = 2 if formdef_version == 2512111044 & _p24a_q3_8 == 0 & (missing(q3_8))
quietly replace _p24_q3_8 = 4 if formdef_version == 2512111044 & _p24a_q3_8 == 1 & (missing(q3_8))
quietly replace _p24_q3_8 = 1 if formdef_version == 2512111044 & _p24a_q3_8 == 1 & (q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
quietly replace _p24_q3_8 = 5 if formdef_version == 2512111044 & _p24_q3_8 == 1 & (q3_8 == 99)
quietly count if formdef_version == 2512111044 & _p24_q3_8 == 5 & (q3_8 == 99)
file write `out' "P2.08,q3_8,2512111044,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_8 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_8 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_8 = 2 if formdef_version == 2512121811 & _p24a_q3_8 == 0 & (missing(q3_8))
quietly replace _p24_q3_8 = 4 if formdef_version == 2512121811 & _p24a_q3_8 == 1 & (missing(q3_8))
quietly replace _p24_q3_8 = 1 if formdef_version == 2512121811 & _p24a_q3_8 == 1 & (q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
quietly replace _p24_q3_8 = 5 if formdef_version == 2512121811 & _p24_q3_8 == 1 & (q3_8 == 99)
quietly count if formdef_version == 2512121811 & _p24_q3_8 == 5 & (q3_8 == 99)
file write `out' "P2.08,q3_8,2512121811,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q3_8 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 1)) | ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & (q3_1 == 2))))
quietly replace _p24a_q3_8 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 1)) & ((q3_1 == 1 | q3_1 == 2 | q3_1 == 3) & !(q3_1 == 2))))
quietly replace _p24_q3_8 = 2 if formdef_version == 2602120658 & _p24a_q3_8 == 0 & (missing(q3_8))
quietly replace _p24_q3_8 = 4 if formdef_version == 2602120658 & _p24a_q3_8 == 1 & (missing(q3_8))
quietly replace _p24_q3_8 = 1 if formdef_version == 2602120658 & _p24a_q3_8 == 1 & (q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
quietly replace _p24_q3_8 = 5 if formdef_version == 2602120658 & _p24_q3_8 == 1 & (q3_8 == 99)
quietly count if formdef_version == 2602120658 & _p24_q3_8 == 5 & (q3_8 == 99)
file write `out' "P2.08,q3_8,2602120658,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q3_8 == `state' 
        file write `out' "P2.03,q3_8,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q3_8 == 1 & !(missing(q3_8)) & !(q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
file write `out' "P2.04,q3_8,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q3_8 == 1 & !(missing(q3_8)) & !(q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
file write `out' "P2.04,q3_8,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q3_8 == 1 & !(missing(q3_8)) & !(q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
file write `out' "P2.04,q3_8,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q3_8 == 1 & !(missing(q3_8)) & !(q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
file write `out' "P2.04,q3_8,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q3_8 == 1 & !(missing(q3_8)) & !(q3_8 == 1 | q3_8 == 2 | q3_8 == 3 | q3_8 == 99)
file write `out' "P2.04,q3_8,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4 = 6
quietly gen byte _p24a_q4 = .
quietly replace _p24a_q4 = 1 if formdef_version == 2512090157 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q4 = 0 if formdef_version == 2512090157 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q4 = 2 if formdef_version == 2512090157 & _p24a_q4 == 0 & (missing(q4))
quietly replace _p24_q4 = 4 if formdef_version == 2512090157 & _p24a_q4 == 1 & (missing(q4))
quietly replace _p24_q4 = 1 if formdef_version == 2512090157 & _p24a_q4 == 1 & (inrange(q4,18,100) & q4 == floor(q4))
quietly replace _p24a_q4 = 1 if formdef_version == 2512091719 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q4 = 0 if formdef_version == 2512091719 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q4 = 2 if formdef_version == 2512091719 & _p24a_q4 == 0 & (missing(q4))
quietly replace _p24_q4 = 4 if formdef_version == 2512091719 & _p24a_q4 == 1 & (missing(q4))
quietly replace _p24_q4 = 1 if formdef_version == 2512091719 & _p24a_q4 == 1 & (inrange(q4,18,100) & q4 == floor(q4))
quietly replace _p24a_q4 = 1 if formdef_version == 2512111044 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q4 = 0 if formdef_version == 2512111044 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q4 = 2 if formdef_version == 2512111044 & _p24a_q4 == 0 & (missing(q4))
quietly replace _p24_q4 = 4 if formdef_version == 2512111044 & _p24a_q4 == 1 & (missing(q4))
quietly replace _p24_q4 = 1 if formdef_version == 2512111044 & _p24a_q4 == 1 & (inrange(q4,18,100) & q4 == floor(q4))
quietly replace _p24a_q4 = 1 if formdef_version == 2512121811 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q4 = 0 if formdef_version == 2512121811 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q4 = 2 if formdef_version == 2512121811 & _p24a_q4 == 0 & (missing(q4))
quietly replace _p24_q4 = 4 if formdef_version == 2512121811 & _p24a_q4 == 1 & (missing(q4))
quietly replace _p24_q4 = 1 if formdef_version == 2512121811 & _p24a_q4 == 1 & (inrange(q4,18,100) & q4 == floor(q4))
quietly replace _p24a_q4 = 1 if formdef_version == 2602120658 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q4 = 0 if formdef_version == 2602120658 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q4 = 2 if formdef_version == 2602120658 & _p24a_q4 == 0 & (missing(q4))
quietly replace _p24_q4 = 4 if formdef_version == 2602120658 & _p24a_q4 == 1 & (missing(q4))
quietly replace _p24_q4 = 1 if formdef_version == 2602120658 & _p24a_q4 == 1 & (inrange(q4,18,100) & q4 == floor(q4))
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4 == `state' 
        file write `out' "P2.03,q4,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4 == 1 & !(missing(q4)) & !(inrange(q4,18,100) & q4 == floor(q4))
file write `out' "P2.04,q4,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4 == 1 & !(missing(q4)) & !(inrange(q4,18,100) & q4 == floor(q4))
file write `out' "P2.04,q4,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4 == 1 & !(missing(q4)) & !(inrange(q4,18,100) & q4 == floor(q4))
file write `out' "P2.04,q4,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4 == 1 & !(missing(q4)) & !(inrange(q4,18,100) & q4 == floor(q4))
file write `out' "P2.04,q4,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4 == 1 & !(missing(q4)) & !(inrange(q4,18,100) & q4 == floor(q4))
file write `out' "P2.04,q4,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_1: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_1 = 6
quietly gen byte _p24a_q4_1 = .
quietly replace _p24a_q4_1 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_1 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_1 = 2 if formdef_version == 2512090157 & _p24a_q4_1 == 0 & (strtrim(q4_1) == "")
quietly replace _p24_q4_1 = 4 if formdef_version == 2512090157 & _p24a_q4_1 == 1 & (strtrim(q4_1) == "")
quietly replace _p24_q4_1 = 1 if formdef_version == 2512090157 & _p24a_q4_1 == 1 & (regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
quietly replace _p24_q4_1 = 6 if formdef_version == 2512090157 & _p24_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) & wordcount(q4_1) > 1
quietly replace _p24_q4_1 = 6 if formdef_version == 2512090157 & _p24_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0) & wordcount(q4_1) > 1
quietly replace _p24_q4_1 = 5 if formdef_version == 2512090157 & _p24_q4_1 == 1 & (strtrim(q4_1) == "98")
quietly count if formdef_version == 2512090157 & _p24_q4_1 == 5 & (strtrim(q4_1) == "98")
file write `out' "P2.08,q4_1,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_1 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_1 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_1 = 2 if formdef_version == 2512091719 & _p24a_q4_1 == 0 & (strtrim(q4_1) == "")
quietly replace _p24_q4_1 = 4 if formdef_version == 2512091719 & _p24a_q4_1 == 1 & (strtrim(q4_1) == "")
quietly replace _p24_q4_1 = 1 if formdef_version == 2512091719 & _p24a_q4_1 == 1 & (regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
quietly replace _p24_q4_1 = 6 if formdef_version == 2512091719 & _p24_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) & wordcount(q4_1) > 1
quietly replace _p24_q4_1 = 6 if formdef_version == 2512091719 & _p24_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0) & wordcount(q4_1) > 1
quietly replace _p24_q4_1 = 5 if formdef_version == 2512091719 & _p24_q4_1 == 1 & (strtrim(q4_1) == "98")
quietly count if formdef_version == 2512091719 & _p24_q4_1 == 5 & (strtrim(q4_1) == "98")
file write `out' "P2.08,q4_1,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_1 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_1 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_1 = 2 if formdef_version == 2512111044 & _p24a_q4_1 == 0 & (strtrim(q4_1) == "")
quietly replace _p24_q4_1 = 4 if formdef_version == 2512111044 & _p24a_q4_1 == 1 & (strtrim(q4_1) == "")
quietly replace _p24_q4_1 = 1 if formdef_version == 2512111044 & _p24a_q4_1 == 1 & (regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
quietly replace _p24_q4_1 = 6 if formdef_version == 2512111044 & _p24_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) & wordcount(q4_1) > 1
quietly replace _p24_q4_1 = 6 if formdef_version == 2512111044 & _p24_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0) & wordcount(q4_1) > 1
quietly replace _p24_q4_1 = 5 if formdef_version == 2512111044 & _p24_q4_1 == 1 & (strtrim(q4_1) == "98")
quietly count if formdef_version == 2512111044 & _p24_q4_1 == 5 & (strtrim(q4_1) == "98")
file write `out' "P2.08,q4_1,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_1 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_1 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_1 = 2 if formdef_version == 2512121811 & _p24a_q4_1 == 0 & (strtrim(q4_1) == "")
quietly replace _p24_q4_1 = 4 if formdef_version == 2512121811 & _p24a_q4_1 == 1 & (strtrim(q4_1) == "")
quietly replace _p24_q4_1 = 1 if formdef_version == 2512121811 & _p24a_q4_1 == 1 & (regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
quietly replace _p24_q4_1 = 6 if formdef_version == 2512121811 & _p24_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) & wordcount(q4_1) > 1
quietly replace _p24_q4_1 = 6 if formdef_version == 2512121811 & _p24_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0) & wordcount(q4_1) > 1
quietly replace _p24_q4_1 = 5 if formdef_version == 2512121811 & _p24_q4_1 == 1 & (strtrim(q4_1) == "98")
quietly count if formdef_version == 2512121811 & _p24_q4_1 == 5 & (strtrim(q4_1) == "98")
file write `out' "P2.08,q4_1,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_1 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_1 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_1 = 2 if formdef_version == 2602120658 & _p24a_q4_1 == 0 & (strtrim(q4_1) == "")
quietly replace _p24_q4_1 = 4 if formdef_version == 2602120658 & _p24a_q4_1 == 1 & (strtrim(q4_1) == "")
quietly replace _p24_q4_1 = 1 if formdef_version == 2602120658 & _p24a_q4_1 == 1 & (regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
quietly replace _p24_q4_1 = 6 if formdef_version == 2602120658 & _p24_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) & wordcount(q4_1) > 1
quietly replace _p24_q4_1 = 6 if formdef_version == 2602120658 & _p24_q4_1 == 1 & (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0) & wordcount(q4_1) > 1
quietly replace _p24_q4_1 = 5 if formdef_version == 2602120658 & _p24_q4_1 == 1 & (strtrim(q4_1) == "98")
quietly count if formdef_version == 2602120658 & _p24_q4_1 == 5 & (strtrim(q4_1) == "98")
file write `out' "P2.08,q4_1,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_1 == `state' 
        file write `out' "P2.03,q4_1,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_1 == 1 & !(strtrim(q4_1) == "") & !(regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q4_1,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_1 == 1 & !(strtrim(q4_1) == "") & !(regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q4_1,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_1 == 1 & !(strtrim(q4_1) == "") & !(regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q4_1,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_1 == 1 & !(strtrim(q4_1) == "") & !(regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q4_1,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_1 == 1 & !(strtrim(q4_1) == "") & !(regexm(itrim(strtrim(q4_1)), "^(1|2|3|4|5|6|7|8|9|98)( (1|2|3|4|5|6|7|8|9|98))*$") & wordcount(q4_1) == ((strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q4_1,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_12: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_12 = 6
quietly gen byte _p24a_q4_12 = .
quietly replace _p24a_q4_12 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_12 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_12 = 2 if formdef_version == 2512090157 & _p24a_q4_12 == 0 & (strtrim(q4_12) == "")
quietly replace _p24_q4_12 = 4 if formdef_version == 2512090157 & _p24a_q4_12 == 1 & (strtrim(q4_12) == "")
quietly replace _p24_q4_12 = 1 if formdef_version == 2512090157 & _p24a_q4_12 == 1 & (regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
quietly replace _p24a_q4_12 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_12 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_12 = 2 if formdef_version == 2512091719 & _p24a_q4_12 == 0 & (strtrim(q4_12) == "")
quietly replace _p24_q4_12 = 4 if formdef_version == 2512091719 & _p24a_q4_12 == 1 & (strtrim(q4_12) == "")
quietly replace _p24_q4_12 = 1 if formdef_version == 2512091719 & _p24a_q4_12 == 1 & (regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
quietly replace _p24a_q4_12 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_12 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_12 = 2 if formdef_version == 2512111044 & _p24a_q4_12 == 0 & (strtrim(q4_12) == "")
quietly replace _p24_q4_12 = 4 if formdef_version == 2512111044 & _p24a_q4_12 == 1 & (strtrim(q4_12) == "")
quietly replace _p24_q4_12 = 1 if formdef_version == 2512111044 & _p24a_q4_12 == 1 & (regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
quietly replace _p24a_q4_12 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_12 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_12 = 2 if formdef_version == 2512121811 & _p24a_q4_12 == 0 & (strtrim(q4_12) == "")
quietly replace _p24_q4_12 = 4 if formdef_version == 2512121811 & _p24a_q4_12 == 1 & (strtrim(q4_12) == "")
quietly replace _p24_q4_12 = 1 if formdef_version == 2512121811 & _p24a_q4_12 == 1 & (regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
quietly replace _p24a_q4_12 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_12 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_12 = 2 if formdef_version == 2602120658 & _p24a_q4_12 == 0 & (strtrim(q4_12) == "")
quietly replace _p24_q4_12 = 4 if formdef_version == 2602120658 & _p24a_q4_12 == 1 & (strtrim(q4_12) == "")
quietly replace _p24_q4_12 = 1 if formdef_version == 2602120658 & _p24a_q4_12 == 1 & (regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_12 == `state' 
        file write `out' "P2.03,q4_12,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_12 == 1 & !(strtrim(q4_12) == "") & !(regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
file write `out' "P2.04,q4_12,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_12 == 1 & !(strtrim(q4_12) == "") & !(regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
file write `out' "P2.04,q4_12,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_12 == 1 & !(strtrim(q4_12) == "") & !(regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
file write `out' "P2.04,q4_12,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_12 == 1 & !(strtrim(q4_12) == "") & !(regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
file write `out' "P2.04,q4_12,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_12 == 1 & !(strtrim(q4_12) == "") & !(regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)))
file write `out' "P2.04,q4_12,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_13: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_13 = 6
quietly gen byte _p24a_q4_13 = .
quietly replace _p24a_q4_13 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_13 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_13 = 2 if formdef_version == 2512090157 & _p24a_q4_13 == 0 & (missing(q4_13))
quietly replace _p24_q4_13 = 4 if formdef_version == 2512090157 & _p24a_q4_13 == 1 & (missing(q4_13))
quietly replace _p24_q4_13 = 1 if formdef_version == 2512090157 & _p24a_q4_13 == 1 & (q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
quietly replace _p24a_q4_13 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_13 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_13 = 2 if formdef_version == 2512091719 & _p24a_q4_13 == 0 & (missing(q4_13))
quietly replace _p24_q4_13 = 4 if formdef_version == 2512091719 & _p24a_q4_13 == 1 & (missing(q4_13))
quietly replace _p24_q4_13 = 1 if formdef_version == 2512091719 & _p24a_q4_13 == 1 & (q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
quietly replace _p24a_q4_13 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_13 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_13 = 2 if formdef_version == 2512111044 & _p24a_q4_13 == 0 & (missing(q4_13))
quietly replace _p24_q4_13 = 4 if formdef_version == 2512111044 & _p24a_q4_13 == 1 & (missing(q4_13))
quietly replace _p24_q4_13 = 1 if formdef_version == 2512111044 & _p24a_q4_13 == 1 & (q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
quietly replace _p24a_q4_13 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_13 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_13 = 2 if formdef_version == 2512121811 & _p24a_q4_13 == 0 & (missing(q4_13))
quietly replace _p24_q4_13 = 4 if formdef_version == 2512121811 & _p24a_q4_13 == 1 & (missing(q4_13))
quietly replace _p24_q4_13 = 1 if formdef_version == 2512121811 & _p24a_q4_13 == 1 & (q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
quietly replace _p24a_q4_13 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_13 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_13 = 2 if formdef_version == 2602120658 & _p24a_q4_13 == 0 & (missing(q4_13))
quietly replace _p24_q4_13 = 4 if formdef_version == 2602120658 & _p24a_q4_13 == 1 & (missing(q4_13))
quietly replace _p24_q4_13 = 1 if formdef_version == 2602120658 & _p24a_q4_13 == 1 & (q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_13 == `state' 
        file write `out' "P2.03,q4_13,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_13 == 1 & !(missing(q4_13)) & !(q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
file write `out' "P2.04,q4_13,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_13 == 1 & !(missing(q4_13)) & !(q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
file write `out' "P2.04,q4_13,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_13 == 1 & !(missing(q4_13)) & !(q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
file write `out' "P2.04,q4_13,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_13 == 1 & !(missing(q4_13)) & !(q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
file write `out' "P2.04,q4_13,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_13 == 1 & !(missing(q4_13)) & !(q4_13 == 1 | q4_13 == 2 | q4_13 == 3 | q4_13 == 4 | q4_13 == 5)
file write `out' "P2.04,q4_13,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_15: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_15 = 6
quietly gen byte _p24a_q4_15 = .
quietly replace _p24a_q4_15 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_15 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_15 = 2 if formdef_version == 2512090157 & _p24a_q4_15 == 0 & (missing(q4_15))
quietly replace _p24_q4_15 = 4 if formdef_version == 2512090157 & _p24a_q4_15 == 1 & (missing(q4_15))
quietly replace _p24_q4_15 = 1 if formdef_version == 2512090157 & _p24a_q4_15 == 1 & (q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
quietly replace _p24a_q4_15 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_15 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_15 = 2 if formdef_version == 2512091719 & _p24a_q4_15 == 0 & (missing(q4_15))
quietly replace _p24_q4_15 = 4 if formdef_version == 2512091719 & _p24a_q4_15 == 1 & (missing(q4_15))
quietly replace _p24_q4_15 = 1 if formdef_version == 2512091719 & _p24a_q4_15 == 1 & (q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
quietly replace _p24a_q4_15 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_15 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_15 = 2 if formdef_version == 2512111044 & _p24a_q4_15 == 0 & (missing(q4_15))
quietly replace _p24_q4_15 = 4 if formdef_version == 2512111044 & _p24a_q4_15 == 1 & (missing(q4_15))
quietly replace _p24_q4_15 = 1 if formdef_version == 2512111044 & _p24a_q4_15 == 1 & (q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
quietly replace _p24a_q4_15 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_15 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_15 = 2 if formdef_version == 2512121811 & _p24a_q4_15 == 0 & (missing(q4_15))
quietly replace _p24_q4_15 = 4 if formdef_version == 2512121811 & _p24a_q4_15 == 1 & (missing(q4_15))
quietly replace _p24_q4_15 = 1 if formdef_version == 2512121811 & _p24a_q4_15 == 1 & (q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
quietly replace _p24a_q4_15 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_15 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_15 = 2 if formdef_version == 2602120658 & _p24a_q4_15 == 0 & (missing(q4_15))
quietly replace _p24_q4_15 = 4 if formdef_version == 2602120658 & _p24a_q4_15 == 1 & (missing(q4_15))
quietly replace _p24_q4_15 = 1 if formdef_version == 2602120658 & _p24a_q4_15 == 1 & (q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_15 == `state' 
        file write `out' "P2.03,q4_15,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_15 == 1 & !(missing(q4_15)) & !(q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
file write `out' "P2.04,q4_15,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_15 == 1 & !(missing(q4_15)) & !(q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
file write `out' "P2.04,q4_15,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_15 == 1 & !(missing(q4_15)) & !(q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
file write `out' "P2.04,q4_15,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_15 == 1 & !(missing(q4_15)) & !(q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
file write `out' "P2.04,q4_15,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_15 == 1 & !(missing(q4_15)) & !(q4_15 == 1 | q4_15 == 2 | q4_15 == 3 | q4_15 == 4 | q4_15 == 5)
file write `out' "P2.04,q4_15,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_16: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_16 = 6
quietly gen byte _p24a_q4_16 = .
quietly replace _p24a_q4_16 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_16 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_16 = 2 if formdef_version == 2512090157 & _p24a_q4_16 == 0 & (missing(q4_16))
quietly replace _p24_q4_16 = 4 if formdef_version == 2512090157 & _p24a_q4_16 == 1 & (missing(q4_16))
quietly replace _p24_q4_16 = 1 if formdef_version == 2512090157 & _p24a_q4_16 == 1 & (q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
quietly replace _p24_q4_16 = 5 if formdef_version == 2512090157 & _p24_q4_16 == 1 & (q4_16 == 99)
quietly count if formdef_version == 2512090157 & _p24_q4_16 == 5 & (q4_16 == 99)
file write `out' "P2.08,q4_16,2512090157,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_16 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_16 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_16 = 2 if formdef_version == 2512091719 & _p24a_q4_16 == 0 & (missing(q4_16))
quietly replace _p24_q4_16 = 4 if formdef_version == 2512091719 & _p24a_q4_16 == 1 & (missing(q4_16))
quietly replace _p24_q4_16 = 1 if formdef_version == 2512091719 & _p24a_q4_16 == 1 & (q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
quietly replace _p24_q4_16 = 5 if formdef_version == 2512091719 & _p24_q4_16 == 1 & (q4_16 == 99)
quietly count if formdef_version == 2512091719 & _p24_q4_16 == 5 & (q4_16 == 99)
file write `out' "P2.08,q4_16,2512091719,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_16 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_16 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_16 = 2 if formdef_version == 2512111044 & _p24a_q4_16 == 0 & (missing(q4_16))
quietly replace _p24_q4_16 = 4 if formdef_version == 2512111044 & _p24a_q4_16 == 1 & (missing(q4_16))
quietly replace _p24_q4_16 = 1 if formdef_version == 2512111044 & _p24a_q4_16 == 1 & (q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
quietly replace _p24_q4_16 = 5 if formdef_version == 2512111044 & _p24_q4_16 == 1 & (q4_16 == 99)
quietly count if formdef_version == 2512111044 & _p24_q4_16 == 5 & (q4_16 == 99)
file write `out' "P2.08,q4_16,2512111044,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_16 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_16 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_16 = 2 if formdef_version == 2512121811 & _p24a_q4_16 == 0 & (missing(q4_16))
quietly replace _p24_q4_16 = 4 if formdef_version == 2512121811 & _p24a_q4_16 == 1 & (missing(q4_16))
quietly replace _p24_q4_16 = 1 if formdef_version == 2512121811 & _p24a_q4_16 == 1 & (q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
quietly replace _p24_q4_16 = 5 if formdef_version == 2512121811 & _p24_q4_16 == 1 & (q4_16 == 99)
quietly count if formdef_version == 2512121811 & _p24_q4_16 == 5 & (q4_16 == 99)
file write `out' "P2.08,q4_16,2512121811,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_16 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_16 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_16 = 2 if formdef_version == 2602120658 & _p24a_q4_16 == 0 & (missing(q4_16))
quietly replace _p24_q4_16 = 4 if formdef_version == 2602120658 & _p24a_q4_16 == 1 & (missing(q4_16))
quietly replace _p24_q4_16 = 1 if formdef_version == 2602120658 & _p24a_q4_16 == 1 & (q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
quietly replace _p24_q4_16 = 5 if formdef_version == 2602120658 & _p24_q4_16 == 1 & (q4_16 == 99)
quietly count if formdef_version == 2602120658 & _p24_q4_16 == 5 & (q4_16 == 99)
file write `out' "P2.08,q4_16,2602120658,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_16 == `state' 
        file write `out' "P2.03,q4_16,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_16 == 1 & !(missing(q4_16)) & !(q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
file write `out' "P2.04,q4_16,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_16 == 1 & !(missing(q4_16)) & !(q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
file write `out' "P2.04,q4_16,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_16 == 1 & !(missing(q4_16)) & !(q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
file write `out' "P2.04,q4_16,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_16 == 1 & !(missing(q4_16)) & !(q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
file write `out' "P2.04,q4_16,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_16 == 1 & !(missing(q4_16)) & !(q4_16 == 1 | q4_16 == 2 | q4_16 == 3 | q4_16 == 4 | q4_16 == 99)
file write `out' "P2.04,q4_16,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_17: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_17 = 6
quietly gen byte _p24a_q4_17 = .
quietly replace _p24a_q4_17 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_17 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_17 = 2 if formdef_version == 2512090157 & _p24a_q4_17 == 0 & (missing(q4_17))
quietly replace _p24_q4_17 = 4 if formdef_version == 2512090157 & _p24a_q4_17 == 1 & (missing(q4_17))
quietly replace _p24_q4_17 = 1 if formdef_version == 2512090157 & _p24a_q4_17 == 1 & (q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
quietly replace _p24_q4_17 = 5 if formdef_version == 2512090157 & _p24_q4_17 == 1 & (q4_17 == 99)
quietly count if formdef_version == 2512090157 & _p24_q4_17 == 5 & (q4_17 == 99)
file write `out' "P2.08,q4_17,2512090157,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_17 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_17 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_17 = 2 if formdef_version == 2512091719 & _p24a_q4_17 == 0 & (missing(q4_17))
quietly replace _p24_q4_17 = 4 if formdef_version == 2512091719 & _p24a_q4_17 == 1 & (missing(q4_17))
quietly replace _p24_q4_17 = 1 if formdef_version == 2512091719 & _p24a_q4_17 == 1 & (q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
quietly replace _p24_q4_17 = 5 if formdef_version == 2512091719 & _p24_q4_17 == 1 & (q4_17 == 99)
quietly count if formdef_version == 2512091719 & _p24_q4_17 == 5 & (q4_17 == 99)
file write `out' "P2.08,q4_17,2512091719,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_17 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_17 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_17 = 2 if formdef_version == 2512111044 & _p24a_q4_17 == 0 & (missing(q4_17))
quietly replace _p24_q4_17 = 4 if formdef_version == 2512111044 & _p24a_q4_17 == 1 & (missing(q4_17))
quietly replace _p24_q4_17 = 1 if formdef_version == 2512111044 & _p24a_q4_17 == 1 & (q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
quietly replace _p24_q4_17 = 5 if formdef_version == 2512111044 & _p24_q4_17 == 1 & (q4_17 == 99)
quietly count if formdef_version == 2512111044 & _p24_q4_17 == 5 & (q4_17 == 99)
file write `out' "P2.08,q4_17,2512111044,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_17 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_17 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_17 = 2 if formdef_version == 2512121811 & _p24a_q4_17 == 0 & (missing(q4_17))
quietly replace _p24_q4_17 = 4 if formdef_version == 2512121811 & _p24a_q4_17 == 1 & (missing(q4_17))
quietly replace _p24_q4_17 = 1 if formdef_version == 2512121811 & _p24a_q4_17 == 1 & (q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
quietly replace _p24_q4_17 = 5 if formdef_version == 2512121811 & _p24_q4_17 == 1 & (q4_17 == 99)
quietly count if formdef_version == 2512121811 & _p24_q4_17 == 5 & (q4_17 == 99)
file write `out' "P2.08,q4_17,2512121811,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_17 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_17 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_17 = 2 if formdef_version == 2602120658 & _p24a_q4_17 == 0 & (missing(q4_17))
quietly replace _p24_q4_17 = 4 if formdef_version == 2602120658 & _p24a_q4_17 == 1 & (missing(q4_17))
quietly replace _p24_q4_17 = 1 if formdef_version == 2602120658 & _p24a_q4_17 == 1 & (q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
quietly replace _p24_q4_17 = 5 if formdef_version == 2602120658 & _p24_q4_17 == 1 & (q4_17 == 99)
quietly count if formdef_version == 2602120658 & _p24_q4_17 == 5 & (q4_17 == 99)
file write `out' "P2.08,q4_17,2602120658,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_17 == `state' 
        file write `out' "P2.03,q4_17,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_17 == 1 & !(missing(q4_17)) & !(q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
file write `out' "P2.04,q4_17,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_17 == 1 & !(missing(q4_17)) & !(q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
file write `out' "P2.04,q4_17,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_17 == 1 & !(missing(q4_17)) & !(q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
file write `out' "P2.04,q4_17,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_17 == 1 & !(missing(q4_17)) & !(q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
file write `out' "P2.04,q4_17,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_17 == 1 & !(missing(q4_17)) & !(q4_17 == 1 | q4_17 == 2 | q4_17 == 3 | q4_17 == 4 | q4_17 == 99)
file write `out' "P2.04,q4_17,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_24: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_24 = 6
quietly gen byte _p24a_q4_24 = .
quietly replace _p24a_q4_24 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_24 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_24 = 2 if formdef_version == 2512090157 & _p24a_q4_24 == 0 & (missing(q4_24))
quietly replace _p24_q4_24 = 4 if formdef_version == 2512090157 & _p24a_q4_24 == 1 & (missing(q4_24))
quietly replace _p24_q4_24 = 1 if formdef_version == 2512090157 & _p24a_q4_24 == 1 & (q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
quietly replace _p24_q4_24 = 5 if formdef_version == 2512090157 & _p24_q4_24 == 1 & (q4_24 == 99)
quietly count if formdef_version == 2512090157 & _p24_q4_24 == 5 & (q4_24 == 99)
file write `out' "P2.08,q4_24,2512090157,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_24 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_24 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_24 = 2 if formdef_version == 2512091719 & _p24a_q4_24 == 0 & (missing(q4_24))
quietly replace _p24_q4_24 = 4 if formdef_version == 2512091719 & _p24a_q4_24 == 1 & (missing(q4_24))
quietly replace _p24_q4_24 = 1 if formdef_version == 2512091719 & _p24a_q4_24 == 1 & (q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
quietly replace _p24_q4_24 = 5 if formdef_version == 2512091719 & _p24_q4_24 == 1 & (q4_24 == 99)
quietly count if formdef_version == 2512091719 & _p24_q4_24 == 5 & (q4_24 == 99)
file write `out' "P2.08,q4_24,2512091719,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_24 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_24 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_24 = 2 if formdef_version == 2512111044 & _p24a_q4_24 == 0 & (missing(q4_24))
quietly replace _p24_q4_24 = 4 if formdef_version == 2512111044 & _p24a_q4_24 == 1 & (missing(q4_24))
quietly replace _p24_q4_24 = 1 if formdef_version == 2512111044 & _p24a_q4_24 == 1 & (q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
quietly replace _p24_q4_24 = 5 if formdef_version == 2512111044 & _p24_q4_24 == 1 & (q4_24 == 99)
quietly count if formdef_version == 2512111044 & _p24_q4_24 == 5 & (q4_24 == 99)
file write `out' "P2.08,q4_24,2512111044,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_24 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_24 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_24 = 2 if formdef_version == 2512121811 & _p24a_q4_24 == 0 & (missing(q4_24))
quietly replace _p24_q4_24 = 4 if formdef_version == 2512121811 & _p24a_q4_24 == 1 & (missing(q4_24))
quietly replace _p24_q4_24 = 1 if formdef_version == 2512121811 & _p24a_q4_24 == 1 & (q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
quietly replace _p24_q4_24 = 5 if formdef_version == 2512121811 & _p24_q4_24 == 1 & (q4_24 == 99)
quietly count if formdef_version == 2512121811 & _p24_q4_24 == 5 & (q4_24 == 99)
file write `out' "P2.08,q4_24,2512121811,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_24 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_24 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_24 = 2 if formdef_version == 2602120658 & _p24a_q4_24 == 0 & (missing(q4_24))
quietly replace _p24_q4_24 = 4 if formdef_version == 2602120658 & _p24a_q4_24 == 1 & (missing(q4_24))
quietly replace _p24_q4_24 = 1 if formdef_version == 2602120658 & _p24a_q4_24 == 1 & (q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
quietly replace _p24_q4_24 = 5 if formdef_version == 2602120658 & _p24_q4_24 == 1 & (q4_24 == 99)
quietly count if formdef_version == 2602120658 & _p24_q4_24 == 5 & (q4_24 == 99)
file write `out' "P2.08,q4_24,2602120658,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_24 == `state' 
        file write `out' "P2.03,q4_24,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_24 == 1 & !(missing(q4_24)) & !(q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
file write `out' "P2.04,q4_24,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_24 == 1 & !(missing(q4_24)) & !(q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
file write `out' "P2.04,q4_24,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_24 == 1 & !(missing(q4_24)) & !(q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
file write `out' "P2.04,q4_24,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_24 == 1 & !(missing(q4_24)) & !(q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
file write `out' "P2.04,q4_24,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_24 == 1 & !(missing(q4_24)) & !(q4_24 == 1 | q4_24 == 2 | q4_24 == 3 | q4_24 == 99)
file write `out' "P2.04,q4_24,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_25: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_25 = 6
quietly gen byte _p24a_q4_25 = .
quietly replace _p24a_q4_25 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_25 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_25 = 2 if formdef_version == 2512090157 & _p24a_q4_25 == 0 & (missing(q4_25))
quietly replace _p24_q4_25 = 4 if formdef_version == 2512090157 & _p24a_q4_25 == 1 & (missing(q4_25))
quietly replace _p24_q4_25 = 1 if formdef_version == 2512090157 & _p24a_q4_25 == 1 & (q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
quietly replace _p24_q4_25 = 5 if formdef_version == 2512090157 & _p24_q4_25 == 1 & (q4_25 == 99)
quietly count if formdef_version == 2512090157 & _p24_q4_25 == 5 & (q4_25 == 99)
file write `out' "P2.08,q4_25,2512090157,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_25 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_25 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_25 = 2 if formdef_version == 2512091719 & _p24a_q4_25 == 0 & (missing(q4_25))
quietly replace _p24_q4_25 = 4 if formdef_version == 2512091719 & _p24a_q4_25 == 1 & (missing(q4_25))
quietly replace _p24_q4_25 = 1 if formdef_version == 2512091719 & _p24a_q4_25 == 1 & (q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
quietly replace _p24_q4_25 = 5 if formdef_version == 2512091719 & _p24_q4_25 == 1 & (q4_25 == 99)
quietly count if formdef_version == 2512091719 & _p24_q4_25 == 5 & (q4_25 == 99)
file write `out' "P2.08,q4_25,2512091719,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_25 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_25 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_25 = 2 if formdef_version == 2512111044 & _p24a_q4_25 == 0 & (missing(q4_25))
quietly replace _p24_q4_25 = 4 if formdef_version == 2512111044 & _p24a_q4_25 == 1 & (missing(q4_25))
quietly replace _p24_q4_25 = 1 if formdef_version == 2512111044 & _p24a_q4_25 == 1 & (q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
quietly replace _p24_q4_25 = 5 if formdef_version == 2512111044 & _p24_q4_25 == 1 & (q4_25 == 99)
quietly count if formdef_version == 2512111044 & _p24_q4_25 == 5 & (q4_25 == 99)
file write `out' "P2.08,q4_25,2512111044,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_25 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_25 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_25 = 2 if formdef_version == 2512121811 & _p24a_q4_25 == 0 & (missing(q4_25))
quietly replace _p24_q4_25 = 4 if formdef_version == 2512121811 & _p24a_q4_25 == 1 & (missing(q4_25))
quietly replace _p24_q4_25 = 1 if formdef_version == 2512121811 & _p24a_q4_25 == 1 & (q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
quietly replace _p24_q4_25 = 5 if formdef_version == 2512121811 & _p24_q4_25 == 1 & (q4_25 == 99)
quietly count if formdef_version == 2512121811 & _p24_q4_25 == 5 & (q4_25 == 99)
file write `out' "P2.08,q4_25,2512121811,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_25 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_25 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_25 = 2 if formdef_version == 2602120658 & _p24a_q4_25 == 0 & (missing(q4_25))
quietly replace _p24_q4_25 = 4 if formdef_version == 2602120658 & _p24a_q4_25 == 1 & (missing(q4_25))
quietly replace _p24_q4_25 = 1 if formdef_version == 2602120658 & _p24a_q4_25 == 1 & (q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
quietly replace _p24_q4_25 = 5 if formdef_version == 2602120658 & _p24_q4_25 == 1 & (q4_25 == 99)
quietly count if formdef_version == 2602120658 & _p24_q4_25 == 5 & (q4_25 == 99)
file write `out' "P2.08,q4_25,2602120658,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_25 == `state' 
        file write `out' "P2.03,q4_25,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_25 == 1 & !(missing(q4_25)) & !(q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
file write `out' "P2.04,q4_25,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_25 == 1 & !(missing(q4_25)) & !(q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
file write `out' "P2.04,q4_25,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_25 == 1 & !(missing(q4_25)) & !(q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
file write `out' "P2.04,q4_25,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_25 == 1 & !(missing(q4_25)) & !(q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
file write `out' "P2.04,q4_25,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_25 == 1 & !(missing(q4_25)) & !(q4_25 == 1 | q4_25 == 2 | q4_25 == 3 | q4_25 == 99)
file write `out' "P2.04,q4_25,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_26: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_26 = 6
quietly gen byte _p24a_q4_26 = .
quietly replace _p24a_q4_26 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_26 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_26 = 2 if formdef_version == 2512090157 & _p24a_q4_26 == 0 & (missing(q4_26))
quietly replace _p24_q4_26 = 4 if formdef_version == 2512090157 & _p24a_q4_26 == 1 & (missing(q4_26))
quietly replace _p24_q4_26 = 1 if formdef_version == 2512090157 & _p24a_q4_26 == 1 & (q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
quietly replace _p24_q4_26 = 5 if formdef_version == 2512090157 & _p24_q4_26 == 1 & (q4_26 == 99)
quietly count if formdef_version == 2512090157 & _p24_q4_26 == 5 & (q4_26 == 99)
file write `out' "P2.08,q4_26,2512090157,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_26 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_26 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_26 = 2 if formdef_version == 2512091719 & _p24a_q4_26 == 0 & (missing(q4_26))
quietly replace _p24_q4_26 = 4 if formdef_version == 2512091719 & _p24a_q4_26 == 1 & (missing(q4_26))
quietly replace _p24_q4_26 = 1 if formdef_version == 2512091719 & _p24a_q4_26 == 1 & (q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
quietly replace _p24_q4_26 = 5 if formdef_version == 2512091719 & _p24_q4_26 == 1 & (q4_26 == 99)
quietly count if formdef_version == 2512091719 & _p24_q4_26 == 5 & (q4_26 == 99)
file write `out' "P2.08,q4_26,2512091719,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_26 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_26 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_26 = 2 if formdef_version == 2512111044 & _p24a_q4_26 == 0 & (missing(q4_26))
quietly replace _p24_q4_26 = 4 if formdef_version == 2512111044 & _p24a_q4_26 == 1 & (missing(q4_26))
quietly replace _p24_q4_26 = 1 if formdef_version == 2512111044 & _p24a_q4_26 == 1 & (q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
quietly replace _p24_q4_26 = 5 if formdef_version == 2512111044 & _p24_q4_26 == 1 & (q4_26 == 99)
quietly count if formdef_version == 2512111044 & _p24_q4_26 == 5 & (q4_26 == 99)
file write `out' "P2.08,q4_26,2512111044,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_26 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_26 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_26 = 2 if formdef_version == 2512121811 & _p24a_q4_26 == 0 & (missing(q4_26))
quietly replace _p24_q4_26 = 4 if formdef_version == 2512121811 & _p24a_q4_26 == 1 & (missing(q4_26))
quietly replace _p24_q4_26 = 1 if formdef_version == 2512121811 & _p24a_q4_26 == 1 & (q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
quietly replace _p24_q4_26 = 5 if formdef_version == 2512121811 & _p24_q4_26 == 1 & (q4_26 == 99)
quietly count if formdef_version == 2512121811 & _p24_q4_26 == 5 & (q4_26 == 99)
file write `out' "P2.08,q4_26,2512121811,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_26 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_26 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_26 = 2 if formdef_version == 2602120658 & _p24a_q4_26 == 0 & (missing(q4_26))
quietly replace _p24_q4_26 = 4 if formdef_version == 2602120658 & _p24a_q4_26 == 1 & (missing(q4_26))
quietly replace _p24_q4_26 = 1 if formdef_version == 2602120658 & _p24a_q4_26 == 1 & (q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
quietly replace _p24_q4_26 = 5 if formdef_version == 2602120658 & _p24_q4_26 == 1 & (q4_26 == 99)
quietly count if formdef_version == 2602120658 & _p24_q4_26 == 5 & (q4_26 == 99)
file write `out' "P2.08,q4_26,2602120658,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_26 == `state' 
        file write `out' "P2.03,q4_26,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_26 == 1 & !(missing(q4_26)) & !(q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
file write `out' "P2.04,q4_26,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_26 == 1 & !(missing(q4_26)) & !(q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
file write `out' "P2.04,q4_26,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_26 == 1 & !(missing(q4_26)) & !(q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
file write `out' "P2.04,q4_26,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_26 == 1 & !(missing(q4_26)) & !(q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
file write `out' "P2.04,q4_26,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_26 == 1 & !(missing(q4_26)) & !(q4_26 == 1 | q4_26 == 2 | q4_26 == 3 | q4_26 == 99)
file write `out' "P2.04,q4_26,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_27: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_27 = 6
quietly gen byte _p24a_q4_27 = .
quietly replace _p24a_q4_27 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_27 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_27 = 2 if formdef_version == 2512090157 & _p24a_q4_27 == 0 & (missing(q4_27))
quietly replace _p24_q4_27 = 4 if formdef_version == 2512090157 & _p24a_q4_27 == 1 & (missing(q4_27))
quietly replace _p24_q4_27 = 1 if formdef_version == 2512090157 & _p24a_q4_27 == 1 & (q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
quietly replace _p24_q4_27 = 5 if formdef_version == 2512090157 & _p24_q4_27 == 1 & (q4_27 == 98)
quietly count if formdef_version == 2512090157 & _p24_q4_27 == 5 & (q4_27 == 98)
file write `out' "P2.08,q4_27,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_27 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_27 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_27 = 2 if formdef_version == 2512091719 & _p24a_q4_27 == 0 & (missing(q4_27))
quietly replace _p24_q4_27 = 4 if formdef_version == 2512091719 & _p24a_q4_27 == 1 & (missing(q4_27))
quietly replace _p24_q4_27 = 1 if formdef_version == 2512091719 & _p24a_q4_27 == 1 & (q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
quietly replace _p24_q4_27 = 5 if formdef_version == 2512091719 & _p24_q4_27 == 1 & (q4_27 == 98)
quietly count if formdef_version == 2512091719 & _p24_q4_27 == 5 & (q4_27 == 98)
file write `out' "P2.08,q4_27,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_27 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_27 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_27 = 2 if formdef_version == 2512111044 & _p24a_q4_27 == 0 & (missing(q4_27))
quietly replace _p24_q4_27 = 4 if formdef_version == 2512111044 & _p24a_q4_27 == 1 & (missing(q4_27))
quietly replace _p24_q4_27 = 1 if formdef_version == 2512111044 & _p24a_q4_27 == 1 & (q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
quietly replace _p24_q4_27 = 5 if formdef_version == 2512111044 & _p24_q4_27 == 1 & (q4_27 == 98)
quietly count if formdef_version == 2512111044 & _p24_q4_27 == 5 & (q4_27 == 98)
file write `out' "P2.08,q4_27,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_27 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_27 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_27 = 2 if formdef_version == 2512121811 & _p24a_q4_27 == 0 & (missing(q4_27))
quietly replace _p24_q4_27 = 4 if formdef_version == 2512121811 & _p24a_q4_27 == 1 & (missing(q4_27))
quietly replace _p24_q4_27 = 1 if formdef_version == 2512121811 & _p24a_q4_27 == 1 & (q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
quietly replace _p24_q4_27 = 5 if formdef_version == 2512121811 & _p24_q4_27 == 1 & (q4_27 == 98)
quietly count if formdef_version == 2512121811 & _p24_q4_27 == 5 & (q4_27 == 98)
file write `out' "P2.08,q4_27,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_27 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q4_27 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q4_27 = 2 if formdef_version == 2602120658 & _p24a_q4_27 == 0 & (missing(q4_27))
quietly replace _p24_q4_27 = 4 if formdef_version == 2602120658 & _p24a_q4_27 == 1 & (missing(q4_27))
quietly replace _p24_q4_27 = 1 if formdef_version == 2602120658 & _p24a_q4_27 == 1 & (q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
quietly replace _p24_q4_27 = 5 if formdef_version == 2602120658 & _p24_q4_27 == 1 & (q4_27 == 98)
quietly count if formdef_version == 2602120658 & _p24_q4_27 == 5 & (q4_27 == 98)
file write `out' "P2.08,q4_27,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_27 == `state' 
        file write `out' "P2.03,q4_27,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_27 == 1 & !(missing(q4_27)) & !(q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
file write `out' "P2.04,q4_27,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_27 == 1 & !(missing(q4_27)) & !(q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
file write `out' "P2.04,q4_27,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_27 == 1 & !(missing(q4_27)) & !(q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
file write `out' "P2.04,q4_27,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_27 == 1 & !(missing(q4_27)) & !(q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
file write `out' "P2.04,q4_27,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_27 == 1 & !(missing(q4_27)) & !(q4_27 == 0 | q4_27 == 1 | q4_27 == 98)
file write `out' "P2.04,q4_27,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_5: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_5 = 6
quietly gen byte _p24a_q4_5 = .
quietly replace _p24a_q4_5 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_5 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_5 = 2 if formdef_version == 2512090157 & _p24a_q4_5 == 0 & (missing(q4_5))
quietly replace _p24_q4_5 = 4 if formdef_version == 2512090157 & _p24a_q4_5 == 1 & (missing(q4_5))
quietly replace _p24_q4_5 = 1 if formdef_version == 2512090157 & _p24a_q4_5 == 1 & (q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
quietly replace _p24_q4_5 = 5 if formdef_version == 2512090157 & _p24_q4_5 == 1 & (q4_5 == 3)
quietly count if formdef_version == 2512090157 & _p24_q4_5 == 5 & (q4_5 == 3)
file write `out' "P2.08,q4_5,2512090157,sentinel,in_process,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q4_5 = 5 if formdef_version == 2512090157 & _p24_q4_5 == 1 & (q4_5 == 4)
quietly count if formdef_version == 2512090157 & _p24_q4_5 == 5 & (q4_5 == 4)
file write `out' "P2.08,q4_5,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_5 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_5 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_5 = 2 if formdef_version == 2512091719 & _p24a_q4_5 == 0 & (missing(q4_5))
quietly replace _p24_q4_5 = 4 if formdef_version == 2512091719 & _p24a_q4_5 == 1 & (missing(q4_5))
quietly replace _p24_q4_5 = 1 if formdef_version == 2512091719 & _p24a_q4_5 == 1 & (q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
quietly replace _p24_q4_5 = 5 if formdef_version == 2512091719 & _p24_q4_5 == 1 & (q4_5 == 3)
quietly count if formdef_version == 2512091719 & _p24_q4_5 == 5 & (q4_5 == 3)
file write `out' "P2.08,q4_5,2512091719,sentinel,in_process,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q4_5 = 5 if formdef_version == 2512091719 & _p24_q4_5 == 1 & (q4_5 == 4)
quietly count if formdef_version == 2512091719 & _p24_q4_5 == 5 & (q4_5 == 4)
file write `out' "P2.08,q4_5,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_5 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_5 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_5 = 2 if formdef_version == 2512111044 & _p24a_q4_5 == 0 & (missing(q4_5))
quietly replace _p24_q4_5 = 4 if formdef_version == 2512111044 & _p24a_q4_5 == 1 & (missing(q4_5))
quietly replace _p24_q4_5 = 1 if formdef_version == 2512111044 & _p24a_q4_5 == 1 & (q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
quietly replace _p24_q4_5 = 5 if formdef_version == 2512111044 & _p24_q4_5 == 1 & (q4_5 == 3)
quietly count if formdef_version == 2512111044 & _p24_q4_5 == 5 & (q4_5 == 3)
file write `out' "P2.08,q4_5,2512111044,sentinel,in_process,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q4_5 = 5 if formdef_version == 2512111044 & _p24_q4_5 == 1 & (q4_5 == 4)
quietly count if formdef_version == 2512111044 & _p24_q4_5 == 5 & (q4_5 == 4)
file write `out' "P2.08,q4_5,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_5 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_5 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_5 = 2 if formdef_version == 2512121811 & _p24a_q4_5 == 0 & (missing(q4_5))
quietly replace _p24_q4_5 = 4 if formdef_version == 2512121811 & _p24a_q4_5 == 1 & (missing(q4_5))
quietly replace _p24_q4_5 = 1 if formdef_version == 2512121811 & _p24a_q4_5 == 1 & (q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
quietly replace _p24_q4_5 = 5 if formdef_version == 2512121811 & _p24_q4_5 == 1 & (q4_5 == 3)
quietly count if formdef_version == 2512121811 & _p24_q4_5 == 5 & (q4_5 == 3)
file write `out' "P2.08,q4_5,2512121811,sentinel,in_process,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q4_5 = 5 if formdef_version == 2512121811 & _p24_q4_5 == 1 & (q4_5 == 4)
quietly count if formdef_version == 2512121811 & _p24_q4_5 == 5 & (q4_5 == 4)
file write `out' "P2.08,q4_5,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_5 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_5 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_5 = 2 if formdef_version == 2602120658 & _p24a_q4_5 == 0 & (missing(q4_5))
quietly replace _p24_q4_5 = 4 if formdef_version == 2602120658 & _p24a_q4_5 == 1 & (missing(q4_5))
quietly replace _p24_q4_5 = 1 if formdef_version == 2602120658 & _p24a_q4_5 == 1 & (q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
quietly replace _p24_q4_5 = 5 if formdef_version == 2602120658 & _p24_q4_5 == 1 & (q4_5 == 3)
quietly count if formdef_version == 2602120658 & _p24_q4_5 == 5 & (q4_5 == 3)
file write `out' "P2.08,q4_5,2602120658,sentinel,in_process,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q4_5 = 5 if formdef_version == 2602120658 & _p24_q4_5 == 1 & (q4_5 == 4)
quietly count if formdef_version == 2602120658 & _p24_q4_5 == 5 & (q4_5 == 4)
file write `out' "P2.08,q4_5,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_5 == `state' 
        file write `out' "P2.03,q4_5,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_5 == 1 & !(missing(q4_5)) & !(q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
file write `out' "P2.04,q4_5,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_5 == 1 & !(missing(q4_5)) & !(q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
file write `out' "P2.04,q4_5,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_5 == 1 & !(missing(q4_5)) & !(q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
file write `out' "P2.04,q4_5,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_5 == 1 & !(missing(q4_5)) & !(q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
file write `out' "P2.04,q4_5,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_5 == 1 & !(missing(q4_5)) & !(q4_5 == 1 | q4_5 == 2 | q4_5 == 3 | q4_5 == 4)
file write `out' "P2.04,q4_5,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q4_6: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q4_6 = 6
quietly gen byte _p24a_q4_6 = .
quietly replace _p24a_q4_6 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_6 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_6 = 2 if formdef_version == 2512090157 & _p24a_q4_6 == 0 & (missing(q4_6))
quietly replace _p24_q4_6 = 4 if formdef_version == 2512090157 & _p24a_q4_6 == 1 & (missing(q4_6))
quietly replace _p24_q4_6 = 1 if formdef_version == 2512090157 & _p24a_q4_6 == 1 & (q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
quietly replace _p24_q4_6 = 5 if formdef_version == 2512090157 & _p24_q4_6 == 1 & (q4_6 == 4)
quietly count if formdef_version == 2512090157 & _p24_q4_6 == 5 & (q4_6 == 4)
file write `out' "P2.08,q4_6,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_6 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_6 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_6 = 2 if formdef_version == 2512091719 & _p24a_q4_6 == 0 & (missing(q4_6))
quietly replace _p24_q4_6 = 4 if formdef_version == 2512091719 & _p24a_q4_6 == 1 & (missing(q4_6))
quietly replace _p24_q4_6 = 1 if formdef_version == 2512091719 & _p24a_q4_6 == 1 & (q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
quietly replace _p24_q4_6 = 5 if formdef_version == 2512091719 & _p24_q4_6 == 1 & (q4_6 == 4)
quietly count if formdef_version == 2512091719 & _p24_q4_6 == 5 & (q4_6 == 4)
file write `out' "P2.08,q4_6,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_6 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_6 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_6 = 2 if formdef_version == 2512111044 & _p24a_q4_6 == 0 & (missing(q4_6))
quietly replace _p24_q4_6 = 4 if formdef_version == 2512111044 & _p24a_q4_6 == 1 & (missing(q4_6))
quietly replace _p24_q4_6 = 1 if formdef_version == 2512111044 & _p24a_q4_6 == 1 & (q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
quietly replace _p24_q4_6 = 5 if formdef_version == 2512111044 & _p24_q4_6 == 1 & (q4_6 == 4)
quietly count if formdef_version == 2512111044 & _p24_q4_6 == 5 & (q4_6 == 4)
file write `out' "P2.08,q4_6,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_6 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_6 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_6 = 2 if formdef_version == 2512121811 & _p24a_q4_6 == 0 & (missing(q4_6))
quietly replace _p24_q4_6 = 4 if formdef_version == 2512121811 & _p24a_q4_6 == 1 & (missing(q4_6))
quietly replace _p24_q4_6 = 1 if formdef_version == 2512121811 & _p24a_q4_6 == 1 & (q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
quietly replace _p24_q4_6 = 5 if formdef_version == 2512121811 & _p24_q4_6 == 1 & (q4_6 == 4)
quietly count if formdef_version == 2512121811 & _p24_q4_6 == 5 & (q4_6 == 4)
file write `out' "P2.08,q4_6,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q4_6 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q4_6 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q4_6 = 2 if formdef_version == 2602120658 & _p24a_q4_6 == 0 & (missing(q4_6))
quietly replace _p24_q4_6 = 4 if formdef_version == 2602120658 & _p24a_q4_6 == 1 & (missing(q4_6))
quietly replace _p24_q4_6 = 1 if formdef_version == 2602120658 & _p24a_q4_6 == 1 & (q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
quietly replace _p24_q4_6 = 5 if formdef_version == 2602120658 & _p24_q4_6 == 1 & (q4_6 == 4)
quietly count if formdef_version == 2602120658 & _p24_q4_6 == 5 & (q4_6 == 4)
file write `out' "P2.08,q4_6,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q4_6 == `state' 
        file write `out' "P2.03,q4_6,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q4_6 == 1 & !(missing(q4_6)) & !(q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
file write `out' "P2.04,q4_6,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q4_6 == 1 & !(missing(q4_6)) & !(q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
file write `out' "P2.04,q4_6,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q4_6 == 1 & !(missing(q4_6)) & !(q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
file write `out' "P2.04,q4_6,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q4_6 == 1 & !(missing(q4_6)) & !(q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
file write `out' "P2.04,q4_6,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q4_6 == 1 & !(missing(q4_6)) & !(q4_6 == 1 | q4_6 == 2 | q4_6 == 3 | q4_6 == 4)
file write `out' "P2.04,q4_6,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5 = 6
quietly gen byte _p24a_q5 = .
quietly replace _p24a_q5 = 1 if formdef_version == 2512090157 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q5 = 0 if formdef_version == 2512090157 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q5 = 2 if formdef_version == 2512090157 & _p24a_q5 == 0 & (missing(q5))
quietly replace _p24_q5 = 4 if formdef_version == 2512090157 & _p24a_q5 == 1 & (missing(q5))
quietly replace _p24_q5 = 1 if formdef_version == 2512090157 & _p24a_q5 == 1 & (q5 == 0 | q5 == 1 | q5 == 98)
quietly replace _p24_q5 = 5 if formdef_version == 2512090157 & _p24_q5 == 1 & (q5 == 98)
quietly count if formdef_version == 2512090157 & _p24_q5 == 5 & (q5 == 98)
file write `out' "P2.08,q5,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5 = 1 if formdef_version == 2512091719 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q5 = 0 if formdef_version == 2512091719 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q5 = 2 if formdef_version == 2512091719 & _p24a_q5 == 0 & (missing(q5))
quietly replace _p24_q5 = 4 if formdef_version == 2512091719 & _p24a_q5 == 1 & (missing(q5))
quietly replace _p24_q5 = 1 if formdef_version == 2512091719 & _p24a_q5 == 1 & (q5 == 0 | q5 == 1 | q5 == 98)
quietly replace _p24_q5 = 5 if formdef_version == 2512091719 & _p24_q5 == 1 & (q5 == 98)
quietly count if formdef_version == 2512091719 & _p24_q5 == 5 & (q5 == 98)
file write `out' "P2.08,q5,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5 = 1 if formdef_version == 2512111044 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q5 = 0 if formdef_version == 2512111044 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q5 = 2 if formdef_version == 2512111044 & _p24a_q5 == 0 & (missing(q5))
quietly replace _p24_q5 = 4 if formdef_version == 2512111044 & _p24a_q5 == 1 & (missing(q5))
quietly replace _p24_q5 = 1 if formdef_version == 2512111044 & _p24a_q5 == 1 & (q5 == 0 | q5 == 1 | q5 == 98)
quietly replace _p24_q5 = 5 if formdef_version == 2512111044 & _p24_q5 == 1 & (q5 == 98)
quietly count if formdef_version == 2512111044 & _p24_q5 == 5 & (q5 == 98)
file write `out' "P2.08,q5,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5 = 1 if formdef_version == 2512121811 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q5 = 0 if formdef_version == 2512121811 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q5 = 2 if formdef_version == 2512121811 & _p24a_q5 == 0 & (missing(q5))
quietly replace _p24_q5 = 4 if formdef_version == 2512121811 & _p24a_q5 == 1 & (missing(q5))
quietly replace _p24_q5 = 1 if formdef_version == 2512121811 & _p24a_q5 == 1 & (q5 == 0 | q5 == 1 | q5 == 98)
quietly replace _p24_q5 = 5 if formdef_version == 2512121811 & _p24_q5 == 1 & (q5 == 98)
quietly count if formdef_version == 2512121811 & _p24_q5 == 5 & (q5 == 98)
file write `out' "P2.08,q5,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5 = 1 if formdef_version == 2602120658 & ((consent == 0 | consent == 1 | consent == 98) & (consent == 1))
quietly replace _p24a_q5 = 0 if formdef_version == 2602120658 & ((consent == 0 | consent == 1 | consent == 98) & !(consent == 1))
quietly replace _p24_q5 = 2 if formdef_version == 2602120658 & _p24a_q5 == 0 & (missing(q5))
quietly replace _p24_q5 = 4 if formdef_version == 2602120658 & _p24a_q5 == 1 & (missing(q5))
quietly replace _p24_q5 = 1 if formdef_version == 2602120658 & _p24a_q5 == 1 & (q5 == 0 | q5 == 1 | q5 == 98)
quietly replace _p24_q5 = 5 if formdef_version == 2602120658 & _p24_q5 == 1 & (q5 == 98)
quietly count if formdef_version == 2602120658 & _p24_q5 == 5 & (q5 == 98)
file write `out' "P2.08,q5,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5 == `state' 
        file write `out' "P2.03,q5,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5 == 1 & !(missing(q5)) & !(q5 == 0 | q5 == 1 | q5 == 98)
file write `out' "P2.04,q5,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5 == 1 & !(missing(q5)) & !(q5 == 0 | q5 == 1 | q5 == 98)
file write `out' "P2.04,q5,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5 == 1 & !(missing(q5)) & !(q5 == 0 | q5 == 1 | q5 == 98)
file write `out' "P2.04,q5,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5 == 1 & !(missing(q5)) & !(q5 == 0 | q5 == 1 | q5 == 98)
file write `out' "P2.04,q5,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5 == 1 & !(missing(q5)) & !(q5 == 0 | q5 == 1 | q5 == 98)
file write `out' "P2.04,q5,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_13: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_13 = 6
quietly gen byte _p24a_q5_13 = .
quietly replace _p24a_q5_13 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_13 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_13 = 2 if formdef_version == 2512090157 & _p24a_q5_13 == 0 & (strtrim(q5_13) == "")
quietly replace _p24_q5_13 = 4 if formdef_version == 2512090157 & _p24a_q5_13 == 1 & (strtrim(q5_13) == "")
quietly replace _p24_q5_13 = 1 if formdef_version == 2512090157 & _p24a_q5_13 == 1 & (regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
quietly replace _p24_q5_13 = 6 if formdef_version == 2512090157 & _p24_q5_13 == 1 & (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0) & wordcount(q5_13) > 1
quietly replace _p24_q5_13 = 5 if formdef_version == 2512090157 & _p24_q5_13 == 1 & (strtrim(q5_13) == "98")
quietly count if formdef_version == 2512090157 & _p24_q5_13 == 5 & (strtrim(q5_13) == "98")
file write `out' "P2.08,q5_13,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_13 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_13 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_13 = 2 if formdef_version == 2512091719 & _p24a_q5_13 == 0 & (strtrim(q5_13) == "")
quietly replace _p24_q5_13 = 4 if formdef_version == 2512091719 & _p24a_q5_13 == 1 & (strtrim(q5_13) == "")
quietly replace _p24_q5_13 = 1 if formdef_version == 2512091719 & _p24a_q5_13 == 1 & (regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
quietly replace _p24_q5_13 = 6 if formdef_version == 2512091719 & _p24_q5_13 == 1 & (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0) & wordcount(q5_13) > 1
quietly replace _p24_q5_13 = 5 if formdef_version == 2512091719 & _p24_q5_13 == 1 & (strtrim(q5_13) == "98")
quietly count if formdef_version == 2512091719 & _p24_q5_13 == 5 & (strtrim(q5_13) == "98")
file write `out' "P2.08,q5_13,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_13 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_13 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_13 = 2 if formdef_version == 2512111044 & _p24a_q5_13 == 0 & (strtrim(q5_13) == "")
quietly replace _p24_q5_13 = 4 if formdef_version == 2512111044 & _p24a_q5_13 == 1 & (strtrim(q5_13) == "")
quietly replace _p24_q5_13 = 1 if formdef_version == 2512111044 & _p24a_q5_13 == 1 & (regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
quietly replace _p24_q5_13 = 6 if formdef_version == 2512111044 & _p24_q5_13 == 1 & (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0) & wordcount(q5_13) > 1
quietly replace _p24_q5_13 = 5 if formdef_version == 2512111044 & _p24_q5_13 == 1 & (strtrim(q5_13) == "98")
quietly count if formdef_version == 2512111044 & _p24_q5_13 == 5 & (strtrim(q5_13) == "98")
file write `out' "P2.08,q5_13,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_13 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_13 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_13 = 2 if formdef_version == 2512121811 & _p24a_q5_13 == 0 & (strtrim(q5_13) == "")
quietly replace _p24_q5_13 = 4 if formdef_version == 2512121811 & _p24a_q5_13 == 1 & (strtrim(q5_13) == "")
quietly replace _p24_q5_13 = 1 if formdef_version == 2512121811 & _p24a_q5_13 == 1 & (regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
quietly replace _p24_q5_13 = 6 if formdef_version == 2512121811 & _p24_q5_13 == 1 & (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0) & wordcount(q5_13) > 1
quietly replace _p24_q5_13 = 5 if formdef_version == 2512121811 & _p24_q5_13 == 1 & (strtrim(q5_13) == "98")
quietly count if formdef_version == 2512121811 & _p24_q5_13 == 5 & (strtrim(q5_13) == "98")
file write `out' "P2.08,q5_13,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_13 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_13 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_13 = 2 if formdef_version == 2602120658 & _p24a_q5_13 == 0 & (strtrim(q5_13) == "")
quietly replace _p24_q5_13 = 4 if formdef_version == 2602120658 & _p24a_q5_13 == 1 & (strtrim(q5_13) == "")
quietly replace _p24_q5_13 = 1 if formdef_version == 2602120658 & _p24a_q5_13 == 1 & (regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
quietly replace _p24_q5_13 = 6 if formdef_version == 2602120658 & _p24_q5_13 == 1 & (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0) & wordcount(q5_13) > 1
quietly replace _p24_q5_13 = 5 if formdef_version == 2602120658 & _p24_q5_13 == 1 & (strtrim(q5_13) == "98")
quietly count if formdef_version == 2602120658 & _p24_q5_13 == 5 & (strtrim(q5_13) == "98")
file write `out' "P2.08,q5_13,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_13 == `state' 
        file write `out' "P2.03,q5_13,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_13 == 1 & !(strtrim(q5_13) == "") & !(regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q5_13,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_13 == 1 & !(strtrim(q5_13) == "") & !(regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q5_13,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_13 == 1 & !(strtrim(q5_13) == "") & !(regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q5_13,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_13 == 1 & !(strtrim(q5_13) == "") & !(regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q5_13,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_13 == 1 & !(strtrim(q5_13) == "") & !(regexm(itrim(strtrim(q5_13)), "^(1|2|3|4|5|6|7|98)( (1|2|3|4|5|6|7|98))*$") & wordcount(q5_13) == ((strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q5_13,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_14: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_14 = 6
quietly gen byte _p24a_q5_14 = .
quietly replace _p24a_q5_14 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_14 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_14 = 2 if formdef_version == 2512090157 & _p24a_q5_14 == 0 & (missing(q5_14))
quietly replace _p24_q5_14 = 4 if formdef_version == 2512090157 & _p24a_q5_14 == 1 & (missing(q5_14))
quietly replace _p24_q5_14 = 1 if formdef_version == 2512090157 & _p24a_q5_14 == 1 & (q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
quietly replace _p24_q5_14 = 5 if formdef_version == 2512090157 & _p24_q5_14 == 1 & (q5_14 == 98)
quietly count if formdef_version == 2512090157 & _p24_q5_14 == 5 & (q5_14 == 98)
file write `out' "P2.08,q5_14,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_14 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_14 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_14 = 2 if formdef_version == 2512091719 & _p24a_q5_14 == 0 & (missing(q5_14))
quietly replace _p24_q5_14 = 4 if formdef_version == 2512091719 & _p24a_q5_14 == 1 & (missing(q5_14))
quietly replace _p24_q5_14 = 1 if formdef_version == 2512091719 & _p24a_q5_14 == 1 & (q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
quietly replace _p24_q5_14 = 5 if formdef_version == 2512091719 & _p24_q5_14 == 1 & (q5_14 == 98)
quietly count if formdef_version == 2512091719 & _p24_q5_14 == 5 & (q5_14 == 98)
file write `out' "P2.08,q5_14,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_14 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_14 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_14 = 2 if formdef_version == 2512111044 & _p24a_q5_14 == 0 & (missing(q5_14))
quietly replace _p24_q5_14 = 4 if formdef_version == 2512111044 & _p24a_q5_14 == 1 & (missing(q5_14))
quietly replace _p24_q5_14 = 1 if formdef_version == 2512111044 & _p24a_q5_14 == 1 & (q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
quietly replace _p24_q5_14 = 5 if formdef_version == 2512111044 & _p24_q5_14 == 1 & (q5_14 == 98)
quietly count if formdef_version == 2512111044 & _p24_q5_14 == 5 & (q5_14 == 98)
file write `out' "P2.08,q5_14,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_14 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_14 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_14 = 2 if formdef_version == 2512121811 & _p24a_q5_14 == 0 & (missing(q5_14))
quietly replace _p24_q5_14 = 4 if formdef_version == 2512121811 & _p24a_q5_14 == 1 & (missing(q5_14))
quietly replace _p24_q5_14 = 1 if formdef_version == 2512121811 & _p24a_q5_14 == 1 & (q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
quietly replace _p24_q5_14 = 5 if formdef_version == 2512121811 & _p24_q5_14 == 1 & (q5_14 == 98)
quietly count if formdef_version == 2512121811 & _p24_q5_14 == 5 & (q5_14 == 98)
file write `out' "P2.08,q5_14,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_14 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_14 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_14 = 2 if formdef_version == 2602120658 & _p24a_q5_14 == 0 & (missing(q5_14))
quietly replace _p24_q5_14 = 4 if formdef_version == 2602120658 & _p24a_q5_14 == 1 & (missing(q5_14))
quietly replace _p24_q5_14 = 1 if formdef_version == 2602120658 & _p24a_q5_14 == 1 & (q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
quietly replace _p24_q5_14 = 5 if formdef_version == 2602120658 & _p24_q5_14 == 1 & (q5_14 == 98)
quietly count if formdef_version == 2602120658 & _p24_q5_14 == 5 & (q5_14 == 98)
file write `out' "P2.08,q5_14,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_14 == `state' 
        file write `out' "P2.03,q5_14,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_14 == 1 & !(missing(q5_14)) & !(q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
file write `out' "P2.04,q5_14,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_14 == 1 & !(missing(q5_14)) & !(q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
file write `out' "P2.04,q5_14,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_14 == 1 & !(missing(q5_14)) & !(q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
file write `out' "P2.04,q5_14,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_14 == 1 & !(missing(q5_14)) & !(q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
file write `out' "P2.04,q5_14,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_14 == 1 & !(missing(q5_14)) & !(q5_14 == 1 | q5_14 == 2 | q5_14 == 3 | q5_14 == 4 | q5_14 == 98)
file write `out' "P2.04,q5_14,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_15: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_15 = 6
quietly gen byte _p24a_q5_15 = .
quietly replace _p24a_q5_15 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_15 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_15 = 2 if formdef_version == 2512090157 & _p24a_q5_15 == 0 & (missing(q5_15))
quietly replace _p24_q5_15 = 4 if formdef_version == 2512090157 & _p24a_q5_15 == 1 & (missing(q5_15))
quietly replace _p24_q5_15 = 1 if formdef_version == 2512090157 & _p24a_q5_15 == 1 & (q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
quietly replace _p24_q5_15 = 5 if formdef_version == 2512090157 & _p24_q5_15 == 1 & (q5_15 == 98)
quietly count if formdef_version == 2512090157 & _p24_q5_15 == 5 & (q5_15 == 98)
file write `out' "P2.08,q5_15,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_15 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_15 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_15 = 2 if formdef_version == 2512091719 & _p24a_q5_15 == 0 & (missing(q5_15))
quietly replace _p24_q5_15 = 4 if formdef_version == 2512091719 & _p24a_q5_15 == 1 & (missing(q5_15))
quietly replace _p24_q5_15 = 1 if formdef_version == 2512091719 & _p24a_q5_15 == 1 & (q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
quietly replace _p24_q5_15 = 5 if formdef_version == 2512091719 & _p24_q5_15 == 1 & (q5_15 == 98)
quietly count if formdef_version == 2512091719 & _p24_q5_15 == 5 & (q5_15 == 98)
file write `out' "P2.08,q5_15,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_15 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_15 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_15 = 2 if formdef_version == 2512111044 & _p24a_q5_15 == 0 & (missing(q5_15))
quietly replace _p24_q5_15 = 4 if formdef_version == 2512111044 & _p24a_q5_15 == 1 & (missing(q5_15))
quietly replace _p24_q5_15 = 1 if formdef_version == 2512111044 & _p24a_q5_15 == 1 & (q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
quietly replace _p24_q5_15 = 5 if formdef_version == 2512111044 & _p24_q5_15 == 1 & (q5_15 == 98)
quietly count if formdef_version == 2512111044 & _p24_q5_15 == 5 & (q5_15 == 98)
file write `out' "P2.08,q5_15,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_15 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_15 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_15 = 2 if formdef_version == 2512121811 & _p24a_q5_15 == 0 & (missing(q5_15))
quietly replace _p24_q5_15 = 4 if formdef_version == 2512121811 & _p24a_q5_15 == 1 & (missing(q5_15))
quietly replace _p24_q5_15 = 1 if formdef_version == 2512121811 & _p24a_q5_15 == 1 & (q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
quietly replace _p24_q5_15 = 5 if formdef_version == 2512121811 & _p24_q5_15 == 1 & (q5_15 == 98)
quietly count if formdef_version == 2512121811 & _p24_q5_15 == 5 & (q5_15 == 98)
file write `out' "P2.08,q5_15,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_15 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_15 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_15 = 2 if formdef_version == 2602120658 & _p24a_q5_15 == 0 & (missing(q5_15))
quietly replace _p24_q5_15 = 4 if formdef_version == 2602120658 & _p24a_q5_15 == 1 & (missing(q5_15))
quietly replace _p24_q5_15 = 1 if formdef_version == 2602120658 & _p24a_q5_15 == 1 & (q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
quietly replace _p24_q5_15 = 5 if formdef_version == 2602120658 & _p24_q5_15 == 1 & (q5_15 == 98)
quietly count if formdef_version == 2602120658 & _p24_q5_15 == 5 & (q5_15 == 98)
file write `out' "P2.08,q5_15,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_15 == `state' 
        file write `out' "P2.03,q5_15,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_15 == 1 & !(missing(q5_15)) & !(q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
file write `out' "P2.04,q5_15,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_15 == 1 & !(missing(q5_15)) & !(q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
file write `out' "P2.04,q5_15,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_15 == 1 & !(missing(q5_15)) & !(q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
file write `out' "P2.04,q5_15,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_15 == 1 & !(missing(q5_15)) & !(q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
file write `out' "P2.04,q5_15,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_15 == 1 & !(missing(q5_15)) & !(q5_15 == 1 | q5_15 == 2 | q5_15 == 3 | q5_15 == 4 | q5_15 == 5 | q5_15 == 98)
file write `out' "P2.04,q5_15,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_16: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_16 = 6
quietly gen byte _p24a_q5_16 = .
quietly replace _p24a_q5_16 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_16 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_16 = 2 if formdef_version == 2512090157 & _p24a_q5_16 == 0 & (missing(q5_16))
quietly replace _p24_q5_16 = 4 if formdef_version == 2512090157 & _p24a_q5_16 == 1 & (missing(q5_16))
quietly replace _p24_q5_16 = 1 if formdef_version == 2512090157 & _p24a_q5_16 == 1 & (q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
quietly replace _p24_q5_16 = 5 if formdef_version == 2512090157 & _p24_q5_16 == 1 & (q5_16 == 98)
quietly count if formdef_version == 2512090157 & _p24_q5_16 == 5 & (q5_16 == 98)
file write `out' "P2.08,q5_16,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_16 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_16 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_16 = 2 if formdef_version == 2512091719 & _p24a_q5_16 == 0 & (missing(q5_16))
quietly replace _p24_q5_16 = 4 if formdef_version == 2512091719 & _p24a_q5_16 == 1 & (missing(q5_16))
quietly replace _p24_q5_16 = 1 if formdef_version == 2512091719 & _p24a_q5_16 == 1 & (q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
quietly replace _p24_q5_16 = 5 if formdef_version == 2512091719 & _p24_q5_16 == 1 & (q5_16 == 98)
quietly count if formdef_version == 2512091719 & _p24_q5_16 == 5 & (q5_16 == 98)
file write `out' "P2.08,q5_16,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_16 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_16 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_16 = 2 if formdef_version == 2512111044 & _p24a_q5_16 == 0 & (missing(q5_16))
quietly replace _p24_q5_16 = 4 if formdef_version == 2512111044 & _p24a_q5_16 == 1 & (missing(q5_16))
quietly replace _p24_q5_16 = 1 if formdef_version == 2512111044 & _p24a_q5_16 == 1 & (q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
quietly replace _p24_q5_16 = 5 if formdef_version == 2512111044 & _p24_q5_16 == 1 & (q5_16 == 98)
quietly count if formdef_version == 2512111044 & _p24_q5_16 == 5 & (q5_16 == 98)
file write `out' "P2.08,q5_16,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_16 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_16 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_16 = 2 if formdef_version == 2512121811 & _p24a_q5_16 == 0 & (missing(q5_16))
quietly replace _p24_q5_16 = 4 if formdef_version == 2512121811 & _p24a_q5_16 == 1 & (missing(q5_16))
quietly replace _p24_q5_16 = 1 if formdef_version == 2512121811 & _p24a_q5_16 == 1 & (q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
quietly replace _p24_q5_16 = 5 if formdef_version == 2512121811 & _p24_q5_16 == 1 & (q5_16 == 98)
quietly count if formdef_version == 2512121811 & _p24_q5_16 == 5 & (q5_16 == 98)
file write `out' "P2.08,q5_16,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_16 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_16 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_16 = 2 if formdef_version == 2602120658 & _p24a_q5_16 == 0 & (missing(q5_16))
quietly replace _p24_q5_16 = 4 if formdef_version == 2602120658 & _p24a_q5_16 == 1 & (missing(q5_16))
quietly replace _p24_q5_16 = 1 if formdef_version == 2602120658 & _p24a_q5_16 == 1 & (q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
quietly replace _p24_q5_16 = 5 if formdef_version == 2602120658 & _p24_q5_16 == 1 & (q5_16 == 98)
quietly count if formdef_version == 2602120658 & _p24_q5_16 == 5 & (q5_16 == 98)
file write `out' "P2.08,q5_16,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_16 == `state' 
        file write `out' "P2.03,q5_16,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_16 == 1 & !(missing(q5_16)) & !(q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
file write `out' "P2.04,q5_16,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_16 == 1 & !(missing(q5_16)) & !(q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
file write `out' "P2.04,q5_16,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_16 == 1 & !(missing(q5_16)) & !(q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
file write `out' "P2.04,q5_16,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_16 == 1 & !(missing(q5_16)) & !(q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
file write `out' "P2.04,q5_16,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_16 == 1 & !(missing(q5_16)) & !(q5_16 == 0 | q5_16 == 1 | q5_16 == 98)
file write `out' "P2.04,q5_16,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_2: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_2 = 6
quietly gen byte _p24a_q5_2 = .
quietly replace _p24a_q5_2 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q5_2 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q5_2 = 2 if formdef_version == 2512090157 & _p24a_q5_2 == 0 & (strtrim(q5_2) == "")
quietly replace _p24_q5_2 = 4 if formdef_version == 2512090157 & _p24a_q5_2 == 1 & (strtrim(q5_2) == "")
quietly replace _p24_q5_2 = 1 if formdef_version == 2512090157 & _p24a_q5_2 == 1 & (regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q5_2 = 6 if formdef_version == 2512090157 & _p24_q5_2 == 1 & (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) & wordcount(q5_2) > 1
quietly replace _p24_q5_2 = 6 if formdef_version == 2512090157 & _p24_q5_2 == 1 & (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0) & wordcount(q5_2) > 1
quietly replace _p24_q5_2 = 5 if formdef_version == 2512090157 & _p24_q5_2 == 1 & (strtrim(q5_2) == "98")
quietly count if formdef_version == 2512090157 & _p24_q5_2 == 5 & (strtrim(q5_2) == "98")
file write `out' "P2.08,q5_2,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_2 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q5_2 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q5_2 = 2 if formdef_version == 2512091719 & _p24a_q5_2 == 0 & (strtrim(q5_2) == "")
quietly replace _p24_q5_2 = 4 if formdef_version == 2512091719 & _p24a_q5_2 == 1 & (strtrim(q5_2) == "")
quietly replace _p24_q5_2 = 1 if formdef_version == 2512091719 & _p24a_q5_2 == 1 & (regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q5_2 = 6 if formdef_version == 2512091719 & _p24_q5_2 == 1 & (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) & wordcount(q5_2) > 1
quietly replace _p24_q5_2 = 6 if formdef_version == 2512091719 & _p24_q5_2 == 1 & (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0) & wordcount(q5_2) > 1
quietly replace _p24_q5_2 = 5 if formdef_version == 2512091719 & _p24_q5_2 == 1 & (strtrim(q5_2) == "98")
quietly count if formdef_version == 2512091719 & _p24_q5_2 == 5 & (strtrim(q5_2) == "98")
file write `out' "P2.08,q5_2,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_2 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q5_2 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q5_2 = 2 if formdef_version == 2512111044 & _p24a_q5_2 == 0 & (strtrim(q5_2) == "")
quietly replace _p24_q5_2 = 4 if formdef_version == 2512111044 & _p24a_q5_2 == 1 & (strtrim(q5_2) == "")
quietly replace _p24_q5_2 = 1 if formdef_version == 2512111044 & _p24a_q5_2 == 1 & (regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q5_2 = 6 if formdef_version == 2512111044 & _p24_q5_2 == 1 & (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) & wordcount(q5_2) > 1
quietly replace _p24_q5_2 = 6 if formdef_version == 2512111044 & _p24_q5_2 == 1 & (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0) & wordcount(q5_2) > 1
quietly replace _p24_q5_2 = 5 if formdef_version == 2512111044 & _p24_q5_2 == 1 & (strtrim(q5_2) == "98")
quietly count if formdef_version == 2512111044 & _p24_q5_2 == 5 & (strtrim(q5_2) == "98")
file write `out' "P2.08,q5_2,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_2 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q5_2 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q5_2 = 2 if formdef_version == 2512121811 & _p24a_q5_2 == 0 & (strtrim(q5_2) == "")
quietly replace _p24_q5_2 = 4 if formdef_version == 2512121811 & _p24a_q5_2 == 1 & (strtrim(q5_2) == "")
quietly replace _p24_q5_2 = 1 if formdef_version == 2512121811 & _p24a_q5_2 == 1 & (regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q5_2 = 6 if formdef_version == 2512121811 & _p24_q5_2 == 1 & (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) & wordcount(q5_2) > 1
quietly replace _p24_q5_2 = 6 if formdef_version == 2512121811 & _p24_q5_2 == 1 & (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0) & wordcount(q5_2) > 1
quietly replace _p24_q5_2 = 5 if formdef_version == 2512121811 & _p24_q5_2 == 1 & (strtrim(q5_2) == "98")
quietly count if formdef_version == 2512121811 & _p24_q5_2 == 5 & (strtrim(q5_2) == "98")
file write `out' "P2.08,q5_2,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_2 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q5_2 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q5_2 = 2 if formdef_version == 2602120658 & _p24a_q5_2 == 0 & (strtrim(q5_2) == "")
quietly replace _p24_q5_2 = 4 if formdef_version == 2602120658 & _p24a_q5_2 == 1 & (strtrim(q5_2) == "")
quietly replace _p24_q5_2 = 1 if formdef_version == 2602120658 & _p24a_q5_2 == 1 & (regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q5_2 = 6 if formdef_version == 2602120658 & _p24_q5_2 == 1 & (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) & wordcount(q5_2) > 1
quietly replace _p24_q5_2 = 6 if formdef_version == 2602120658 & _p24_q5_2 == 1 & (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0) & wordcount(q5_2) > 1
quietly replace _p24_q5_2 = 5 if formdef_version == 2602120658 & _p24_q5_2 == 1 & (strtrim(q5_2) == "98")
quietly count if formdef_version == 2602120658 & _p24_q5_2 == 5 & (strtrim(q5_2) == "98")
file write `out' "P2.08,q5_2,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_2 == `state' 
        file write `out' "P2.03,q5_2,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_2 == 1 & !(strtrim(q5_2) == "") & !(regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q5_2,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_2 == 1 & !(strtrim(q5_2) == "") & !(regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q5_2,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_2 == 1 & !(strtrim(q5_2) == "") & !(regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q5_2,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_2 == 1 & !(strtrim(q5_2) == "") & !(regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q5_2,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_2 == 1 & !(strtrim(q5_2) == "") & !(regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q5_2,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_21: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_21 = 6
quietly gen byte _p24a_q5_21 = .
quietly replace _p24a_q5_21 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_21 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_21 = 2 if formdef_version == 2512090157 & _p24a_q5_21 == 0 & (missing(q5_21))
quietly replace _p24_q5_21 = 4 if formdef_version == 2512090157 & _p24a_q5_21 == 1 & (missing(q5_21))
quietly replace _p24_q5_21 = 1 if formdef_version == 2512090157 & _p24a_q5_21 == 1 & (q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
quietly replace _p24_q5_21 = 5 if formdef_version == 2512090157 & _p24_q5_21 == 1 & (q5_21 == 98)
quietly count if formdef_version == 2512090157 & _p24_q5_21 == 5 & (q5_21 == 98)
file write `out' "P2.08,q5_21,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_21 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_21 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_21 = 2 if formdef_version == 2512091719 & _p24a_q5_21 == 0 & (missing(q5_21))
quietly replace _p24_q5_21 = 4 if formdef_version == 2512091719 & _p24a_q5_21 == 1 & (missing(q5_21))
quietly replace _p24_q5_21 = 1 if formdef_version == 2512091719 & _p24a_q5_21 == 1 & (q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
quietly replace _p24_q5_21 = 5 if formdef_version == 2512091719 & _p24_q5_21 == 1 & (q5_21 == 98)
quietly count if formdef_version == 2512091719 & _p24_q5_21 == 5 & (q5_21 == 98)
file write `out' "P2.08,q5_21,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_21 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_21 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_21 = 2 if formdef_version == 2512111044 & _p24a_q5_21 == 0 & (missing(q5_21))
quietly replace _p24_q5_21 = 4 if formdef_version == 2512111044 & _p24a_q5_21 == 1 & (missing(q5_21))
quietly replace _p24_q5_21 = 1 if formdef_version == 2512111044 & _p24a_q5_21 == 1 & (q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
quietly replace _p24_q5_21 = 5 if formdef_version == 2512111044 & _p24_q5_21 == 1 & (q5_21 == 98)
quietly count if formdef_version == 2512111044 & _p24_q5_21 == 5 & (q5_21 == 98)
file write `out' "P2.08,q5_21,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_21 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_21 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_21 = 2 if formdef_version == 2512121811 & _p24a_q5_21 == 0 & (missing(q5_21))
quietly replace _p24_q5_21 = 4 if formdef_version == 2512121811 & _p24a_q5_21 == 1 & (missing(q5_21))
quietly replace _p24_q5_21 = 1 if formdef_version == 2512121811 & _p24a_q5_21 == 1 & (q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
quietly replace _p24_q5_21 = 5 if formdef_version == 2512121811 & _p24_q5_21 == 1 & (q5_21 == 98)
quietly count if formdef_version == 2512121811 & _p24_q5_21 == 5 & (q5_21 == 98)
file write `out' "P2.08,q5_21,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_21 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_21 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_21 = 2 if formdef_version == 2602120658 & _p24a_q5_21 == 0 & (missing(q5_21))
quietly replace _p24_q5_21 = 4 if formdef_version == 2602120658 & _p24a_q5_21 == 1 & (missing(q5_21))
quietly replace _p24_q5_21 = 1 if formdef_version == 2602120658 & _p24a_q5_21 == 1 & (q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
quietly replace _p24_q5_21 = 5 if formdef_version == 2602120658 & _p24_q5_21 == 1 & (q5_21 == 98)
quietly count if formdef_version == 2602120658 & _p24_q5_21 == 5 & (q5_21 == 98)
file write `out' "P2.08,q5_21,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_21 == `state' 
        file write `out' "P2.03,q5_21,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_21 == 1 & !(missing(q5_21)) & !(q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
file write `out' "P2.04,q5_21,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_21 == 1 & !(missing(q5_21)) & !(q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
file write `out' "P2.04,q5_21,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_21 == 1 & !(missing(q5_21)) & !(q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
file write `out' "P2.04,q5_21,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_21 == 1 & !(missing(q5_21)) & !(q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
file write `out' "P2.04,q5_21,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_21 == 1 & !(missing(q5_21)) & !(q5_21 == 1 | q5_21 == 2 | q5_21 == 3 | q5_21 == 98)
file write `out' "P2.04,q5_21,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_22: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_22 = 6
quietly gen byte _p24a_q5_22 = .
quietly replace _p24a_q5_22 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_22 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_22 = 2 if formdef_version == 2512090157 & _p24a_q5_22 == 0 & (missing(q5_22))
quietly replace _p24_q5_22 = 4 if formdef_version == 2512090157 & _p24a_q5_22 == 1 & (missing(q5_22))
quietly replace _p24_q5_22 = 1 if formdef_version == 2512090157 & _p24a_q5_22 == 1 & (q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
quietly replace _p24_q5_22 = 5 if formdef_version == 2512090157 & _p24_q5_22 == 1 & (q5_22 == 98)
quietly count if formdef_version == 2512090157 & _p24_q5_22 == 5 & (q5_22 == 98)
file write `out' "P2.08,q5_22,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_22 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_22 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_22 = 2 if formdef_version == 2512091719 & _p24a_q5_22 == 0 & (missing(q5_22))
quietly replace _p24_q5_22 = 4 if formdef_version == 2512091719 & _p24a_q5_22 == 1 & (missing(q5_22))
quietly replace _p24_q5_22 = 1 if formdef_version == 2512091719 & _p24a_q5_22 == 1 & (q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
quietly replace _p24_q5_22 = 5 if formdef_version == 2512091719 & _p24_q5_22 == 1 & (q5_22 == 98)
quietly count if formdef_version == 2512091719 & _p24_q5_22 == 5 & (q5_22 == 98)
file write `out' "P2.08,q5_22,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_22 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_22 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_22 = 2 if formdef_version == 2512111044 & _p24a_q5_22 == 0 & (missing(q5_22))
quietly replace _p24_q5_22 = 4 if formdef_version == 2512111044 & _p24a_q5_22 == 1 & (missing(q5_22))
quietly replace _p24_q5_22 = 1 if formdef_version == 2512111044 & _p24a_q5_22 == 1 & (q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
quietly replace _p24_q5_22 = 5 if formdef_version == 2512111044 & _p24_q5_22 == 1 & (q5_22 == 98)
quietly count if formdef_version == 2512111044 & _p24_q5_22 == 5 & (q5_22 == 98)
file write `out' "P2.08,q5_22,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_22 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_22 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_22 = 2 if formdef_version == 2512121811 & _p24a_q5_22 == 0 & (missing(q5_22))
quietly replace _p24_q5_22 = 4 if formdef_version == 2512121811 & _p24a_q5_22 == 1 & (missing(q5_22))
quietly replace _p24_q5_22 = 1 if formdef_version == 2512121811 & _p24a_q5_22 == 1 & (q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
quietly replace _p24_q5_22 = 5 if formdef_version == 2512121811 & _p24_q5_22 == 1 & (q5_22 == 98)
quietly count if formdef_version == 2512121811 & _p24_q5_22 == 5 & (q5_22 == 98)
file write `out' "P2.08,q5_22,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_22 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_22 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_22 = 2 if formdef_version == 2602120658 & _p24a_q5_22 == 0 & (missing(q5_22))
quietly replace _p24_q5_22 = 4 if formdef_version == 2602120658 & _p24a_q5_22 == 1 & (missing(q5_22))
quietly replace _p24_q5_22 = 1 if formdef_version == 2602120658 & _p24a_q5_22 == 1 & (q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
quietly replace _p24_q5_22 = 5 if formdef_version == 2602120658 & _p24_q5_22 == 1 & (q5_22 == 98)
quietly count if formdef_version == 2602120658 & _p24_q5_22 == 5 & (q5_22 == 98)
file write `out' "P2.08,q5_22,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_22 == `state' 
        file write `out' "P2.03,q5_22,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_22 == 1 & !(missing(q5_22)) & !(q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
file write `out' "P2.04,q5_22,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_22 == 1 & !(missing(q5_22)) & !(q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
file write `out' "P2.04,q5_22,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_22 == 1 & !(missing(q5_22)) & !(q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
file write `out' "P2.04,q5_22,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_22 == 1 & !(missing(q5_22)) & !(q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
file write `out' "P2.04,q5_22,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_22 == 1 & !(missing(q5_22)) & !(q5_22 == 1 | q5_22 == 2 | q5_22 == 3 | q5_22 == 98)
file write `out' "P2.04,q5_22,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_23: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_23 = 6
quietly gen byte _p24a_q5_23 = .
quietly replace _p24a_q5_23 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_23 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_23 = 2 if formdef_version == 2512090157 & _p24a_q5_23 == 0 & (missing(q5_23))
quietly replace _p24_q5_23 = 4 if formdef_version == 2512090157 & _p24a_q5_23 == 1 & (missing(q5_23))
quietly replace _p24_q5_23 = 1 if formdef_version == 2512090157 & _p24a_q5_23 == 1 & (q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
quietly replace _p24_q5_23 = 5 if formdef_version == 2512090157 & _p24_q5_23 == 1 & (q5_23 == 98)
quietly count if formdef_version == 2512090157 & _p24_q5_23 == 5 & (q5_23 == 98)
file write `out' "P2.08,q5_23,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_23 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_23 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_23 = 2 if formdef_version == 2512091719 & _p24a_q5_23 == 0 & (missing(q5_23))
quietly replace _p24_q5_23 = 4 if formdef_version == 2512091719 & _p24a_q5_23 == 1 & (missing(q5_23))
quietly replace _p24_q5_23 = 1 if formdef_version == 2512091719 & _p24a_q5_23 == 1 & (q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
quietly replace _p24_q5_23 = 5 if formdef_version == 2512091719 & _p24_q5_23 == 1 & (q5_23 == 98)
quietly count if formdef_version == 2512091719 & _p24_q5_23 == 5 & (q5_23 == 98)
file write `out' "P2.08,q5_23,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_23 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_23 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_23 = 2 if formdef_version == 2512111044 & _p24a_q5_23 == 0 & (missing(q5_23))
quietly replace _p24_q5_23 = 4 if formdef_version == 2512111044 & _p24a_q5_23 == 1 & (missing(q5_23))
quietly replace _p24_q5_23 = 1 if formdef_version == 2512111044 & _p24a_q5_23 == 1 & (q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
quietly replace _p24_q5_23 = 5 if formdef_version == 2512111044 & _p24_q5_23 == 1 & (q5_23 == 98)
quietly count if formdef_version == 2512111044 & _p24_q5_23 == 5 & (q5_23 == 98)
file write `out' "P2.08,q5_23,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_23 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_23 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_23 = 2 if formdef_version == 2512121811 & _p24a_q5_23 == 0 & (missing(q5_23))
quietly replace _p24_q5_23 = 4 if formdef_version == 2512121811 & _p24a_q5_23 == 1 & (missing(q5_23))
quietly replace _p24_q5_23 = 1 if formdef_version == 2512121811 & _p24a_q5_23 == 1 & (q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
quietly replace _p24_q5_23 = 5 if formdef_version == 2512121811 & _p24_q5_23 == 1 & (q5_23 == 98)
quietly count if formdef_version == 2512121811 & _p24_q5_23 == 5 & (q5_23 == 98)
file write `out' "P2.08,q5_23,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_23 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) | ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24a_q5_23 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)) & (((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)) & ((regexm(itrim(strtrim(q4_12)), "^(1|2|3|4)( (1|2|3|4))*$") & wordcount(q4_12) == ((strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))) & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))))))
quietly replace _p24_q5_23 = 2 if formdef_version == 2602120658 & _p24a_q5_23 == 0 & (missing(q5_23))
quietly replace _p24_q5_23 = 4 if formdef_version == 2602120658 & _p24a_q5_23 == 1 & (missing(q5_23))
quietly replace _p24_q5_23 = 1 if formdef_version == 2602120658 & _p24a_q5_23 == 1 & (q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
quietly replace _p24_q5_23 = 5 if formdef_version == 2602120658 & _p24_q5_23 == 1 & (q5_23 == 98)
quietly count if formdef_version == 2602120658 & _p24_q5_23 == 5 & (q5_23 == 98)
file write `out' "P2.08,q5_23,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_23 == `state' 
        file write `out' "P2.03,q5_23,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_23 == 1 & !(missing(q5_23)) & !(q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
file write `out' "P2.04,q5_23,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_23 == 1 & !(missing(q5_23)) & !(q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
file write `out' "P2.04,q5_23,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_23 == 1 & !(missing(q5_23)) & !(q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
file write `out' "P2.04,q5_23,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_23 == 1 & !(missing(q5_23)) & !(q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
file write `out' "P2.04,q5_23,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_23 == 1 & !(missing(q5_23)) & !(q5_23 == 1 | q5_23 == 2 | q5_23 == 3 | q5_23 == 98)
file write `out' "P2.04,q5_23,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_5: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_5 = 6
quietly gen byte _p24a_q5_5 = .
quietly replace _p24a_q5_5 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & (wordcount(q5_2) > 0)))
quietly replace _p24a_q5_5 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & !(wordcount(q5_2) > 0)))
quietly replace _p24_q5_5 = 2 if formdef_version == 2512090157 & _p24a_q5_5 == 0 & (missing(q5_5))
quietly replace _p24_q5_5 = 4 if formdef_version == 2512090157 & _p24a_q5_5 == 1 & (missing(q5_5))
quietly replace _p24_q5_5 = 1 if formdef_version == 2512090157 & _p24a_q5_5 == 1 & (q5_5 == 1 | q5_5 == 2 | q5_5 == 3 | q5_5 == 4 | q5_5 == 98)
quietly replace _p24_q5_5 = 5 if formdef_version == 2512090157 & _p24_q5_5 == 1 & (q5_5 == 98)
quietly count if formdef_version == 2512090157 & _p24_q5_5 == 5 & (q5_5 == 98)
file write `out' "P2.08,q5_5,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_5 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & (wordcount(q5_2) > 0)))
quietly replace _p24a_q5_5 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & !(wordcount(q5_2) > 0)))
quietly replace _p24_q5_5 = 2 if formdef_version == 2512091719 & _p24a_q5_5 == 0 & (missing(q5_5))
quietly replace _p24_q5_5 = 4 if formdef_version == 2512091719 & _p24a_q5_5 == 1 & (missing(q5_5))
quietly replace _p24_q5_5 = 1 if formdef_version == 2512091719 & _p24a_q5_5 == 1 & (q5_5 == 1 | q5_5 == 2 | q5_5 == 3 | q5_5 == 4 | q5_5 == 98)
quietly replace _p24_q5_5 = 5 if formdef_version == 2512091719 & _p24_q5_5 == 1 & (q5_5 == 98)
quietly count if formdef_version == 2512091719 & _p24_q5_5 == 5 & (q5_5 == 98)
file write `out' "P2.08,q5_5,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_5 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & (wordcount(q5_2) > 0)))
quietly replace _p24a_q5_5 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & !(wordcount(q5_2) > 0)))
quietly replace _p24_q5_5 = 2 if formdef_version == 2512111044 & _p24a_q5_5 == 0 & (missing(q5_5))
quietly replace _p24_q5_5 = 4 if formdef_version == 2512111044 & _p24a_q5_5 == 1 & (missing(q5_5))
quietly replace _p24_q5_5 = 1 if formdef_version == 2512111044 & _p24a_q5_5 == 1 & (q5_5 == 1 | q5_5 == 2 | q5_5 == 3 | q5_5 == 4 | q5_5 == 98)
quietly replace _p24_q5_5 = 5 if formdef_version == 2512111044 & _p24_q5_5 == 1 & (q5_5 == 98)
quietly count if formdef_version == 2512111044 & _p24_q5_5 == 5 & (q5_5 == 98)
file write `out' "P2.08,q5_5,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_5 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & (wordcount(q5_2) > 0)))
quietly replace _p24a_q5_5 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & !(wordcount(q5_2) > 0)))
quietly replace _p24_q5_5 = 2 if formdef_version == 2512121811 & _p24a_q5_5 == 0 & (missing(q5_5))
quietly replace _p24_q5_5 = 4 if formdef_version == 2512121811 & _p24a_q5_5 == 1 & (missing(q5_5))
quietly replace _p24_q5_5 = 1 if formdef_version == 2512121811 & _p24a_q5_5 == 1 & (q5_5 == 1 | q5_5 == 2 | q5_5 == 3 | q5_5 == 4 | q5_5 == 98)
quietly replace _p24_q5_5 = 5 if formdef_version == 2512121811 & _p24_q5_5 == 1 & (q5_5 == 98)
quietly count if formdef_version == 2512121811 & _p24_q5_5 == 5 & (q5_5 == 98)
file write `out' "P2.08,q5_5,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_5 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & (wordcount(q5_2) > 0)))
quietly replace _p24a_q5_5 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & !(wordcount(q5_2) > 0)))
quietly replace _p24_q5_5 = 2 if formdef_version == 2602120658 & _p24a_q5_5 == 0 & (missing(q5_5))
quietly replace _p24_q5_5 = 4 if formdef_version == 2602120658 & _p24a_q5_5 == 1 & (missing(q5_5))
quietly replace _p24_q5_5 = 1 if formdef_version == 2602120658 & _p24a_q5_5 == 1 & (q5_5 == 1 | q5_5 == 2 | q5_5 == 3 | q5_5 == 4 | q5_5 == 98)
quietly replace _p24_q5_5 = 5 if formdef_version == 2602120658 & _p24_q5_5 == 1 & (q5_5 == 98)
quietly count if formdef_version == 2602120658 & _p24_q5_5 == 5 & (q5_5 == 98)
file write `out' "P2.08,q5_5,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_5 == `state' 
        file write `out' "P2.03,q5_5,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_5 == 1 & !(missing(q5_5)) & !(q5_5 == 1 | q5_5 == 2 | q5_5 == 3 | q5_5 == 4 | q5_5 == 98)
file write `out' "P2.04,q5_5,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_5 == 1 & !(missing(q5_5)) & !(q5_5 == 1 | q5_5 == 2 | q5_5 == 3 | q5_5 == 4 | q5_5 == 98)
file write `out' "P2.04,q5_5,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_5 == 1 & !(missing(q5_5)) & !(q5_5 == 1 | q5_5 == 2 | q5_5 == 3 | q5_5 == 4 | q5_5 == 98)
file write `out' "P2.04,q5_5,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_5 == 1 & !(missing(q5_5)) & !(q5_5 == 1 | q5_5 == 2 | q5_5 == 3 | q5_5 == 4 | q5_5 == 98)
file write `out' "P2.04,q5_5,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_5 == 1 & !(missing(q5_5)) & !(q5_5 == 1 | q5_5 == 2 | q5_5 == 3 | q5_5 == 4 | q5_5 == 98)
file write `out' "P2.04,q5_5,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_7: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_7 = 6
quietly gen byte _p24a_q5_7 = .
quietly replace _p24a_q5_7 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & (wordcount(q5_2) > 0)))
quietly replace _p24a_q5_7 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & !(wordcount(q5_2) > 0)))
quietly replace _p24_q5_7 = 2 if formdef_version == 2512090157 & _p24a_q5_7 == 0 & (missing(q5_7))
quietly replace _p24_q5_7 = 4 if formdef_version == 2512090157 & _p24a_q5_7 == 1 & (missing(q5_7))
quietly replace _p24_q5_7 = 1 if formdef_version == 2512090157 & _p24a_q5_7 == 1 & (q5_7 == 1 | q5_7 == 2 | q5_7 == 3 | q5_7 == 4 | q5_7 == 98)
quietly replace _p24a_q5_7 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & (wordcount(q5_2) > 0)))
quietly replace _p24a_q5_7 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & !(wordcount(q5_2) > 0)))
quietly replace _p24_q5_7 = 2 if formdef_version == 2512091719 & _p24a_q5_7 == 0 & (missing(q5_7))
quietly replace _p24_q5_7 = 4 if formdef_version == 2512091719 & _p24a_q5_7 == 1 & (missing(q5_7))
quietly replace _p24_q5_7 = 1 if formdef_version == 2512091719 & _p24a_q5_7 == 1 & (q5_7 == 1 | q5_7 == 2 | q5_7 == 3 | q5_7 == 4 | q5_7 == 98)
quietly replace _p24a_q5_7 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & (wordcount(q5_2) > 0)))
quietly replace _p24a_q5_7 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & !(wordcount(q5_2) > 0)))
quietly replace _p24_q5_7 = 2 if formdef_version == 2512111044 & _p24a_q5_7 == 0 & (missing(q5_7))
quietly replace _p24_q5_7 = 4 if formdef_version == 2512111044 & _p24a_q5_7 == 1 & (missing(q5_7))
quietly replace _p24_q5_7 = 1 if formdef_version == 2512111044 & _p24a_q5_7 == 1 & (q5_7 == 1 | q5_7 == 2 | q5_7 == 3 | q5_7 == 4 | q5_7 == 98)
quietly replace _p24a_q5_7 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & (wordcount(q5_2) > 0)))
quietly replace _p24a_q5_7 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & !(wordcount(q5_2) > 0)))
quietly replace _p24_q5_7 = 2 if formdef_version == 2512121811 & _p24a_q5_7 == 0 & (missing(q5_7))
quietly replace _p24_q5_7 = 4 if formdef_version == 2512121811 & _p24a_q5_7 == 1 & (missing(q5_7))
quietly replace _p24_q5_7 = 1 if formdef_version == 2512121811 & _p24a_q5_7 == 1 & (q5_7 == 1 | q5_7 == 2 | q5_7 == 3 | q5_7 == 4 | q5_7 == 98)
quietly replace _p24a_q5_7 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & (wordcount(q5_2) > 0)))
quietly replace _p24a_q5_7 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((regexm(itrim(strtrim(q5_2)), "^(1|2|3|4|5|6|98)( (1|2|3|4|5|6|98))*$") & wordcount(q5_2) == ((strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))) & !(wordcount(q5_2) > 0)))
quietly replace _p24_q5_7 = 2 if formdef_version == 2602120658 & _p24a_q5_7 == 0 & (missing(q5_7))
quietly replace _p24_q5_7 = 4 if formdef_version == 2602120658 & _p24a_q5_7 == 1 & (missing(q5_7))
quietly replace _p24_q5_7 = 1 if formdef_version == 2602120658 & _p24a_q5_7 == 1 & (q5_7 == 1 | q5_7 == 2 | q5_7 == 3 | q5_7 == 4 | q5_7 == 98)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_7 == `state' 
        file write `out' "P2.03,q5_7,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_7 == 1 & !(missing(q5_7)) & !(q5_7 == 1 | q5_7 == 2 | q5_7 == 3 | q5_7 == 4 | q5_7 == 98)
file write `out' "P2.04,q5_7,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_7 == 1 & !(missing(q5_7)) & !(q5_7 == 1 | q5_7 == 2 | q5_7 == 3 | q5_7 == 4 | q5_7 == 98)
file write `out' "P2.04,q5_7,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_7 == 1 & !(missing(q5_7)) & !(q5_7 == 1 | q5_7 == 2 | q5_7 == 3 | q5_7 == 4 | q5_7 == 98)
file write `out' "P2.04,q5_7,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_7 == 1 & !(missing(q5_7)) & !(q5_7 == 1 | q5_7 == 2 | q5_7 == 3 | q5_7 == 4 | q5_7 == 98)
file write `out' "P2.04,q5_7,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_7 == 1 & !(missing(q5_7)) & !(q5_7 == 1 | q5_7 == 2 | q5_7 == 3 | q5_7 == 4 | q5_7 == 98)
file write `out' "P2.04,q5_7,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q5_9: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q5_9 = 6
quietly gen byte _p24a_q5_9 = .
quietly replace _p24a_q5_9 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q5_9 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q5_9 = 2 if formdef_version == 2512090157 & _p24a_q5_9 == 0 & (missing(q5_9))
quietly replace _p24_q5_9 = 4 if formdef_version == 2512090157 & _p24a_q5_9 == 1 & (missing(q5_9))
quietly replace _p24_q5_9 = 1 if formdef_version == 2512090157 & _p24a_q5_9 == 1 & (q5_9 == 1 | q5_9 == 2 | q5_9 == 3 | q5_9 == 98)
quietly replace _p24_q5_9 = 5 if formdef_version == 2512090157 & _p24_q5_9 == 1 & (q5_9 == 98)
quietly count if formdef_version == 2512090157 & _p24_q5_9 == 5 & (q5_9 == 98)
file write `out' "P2.08,q5_9,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_9 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q5_9 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q5_9 = 2 if formdef_version == 2512091719 & _p24a_q5_9 == 0 & (missing(q5_9))
quietly replace _p24_q5_9 = 4 if formdef_version == 2512091719 & _p24a_q5_9 == 1 & (missing(q5_9))
quietly replace _p24_q5_9 = 1 if formdef_version == 2512091719 & _p24a_q5_9 == 1 & (q5_9 == 1 | q5_9 == 2 | q5_9 == 3 | q5_9 == 98)
quietly replace _p24_q5_9 = 5 if formdef_version == 2512091719 & _p24_q5_9 == 1 & (q5_9 == 98)
quietly count if formdef_version == 2512091719 & _p24_q5_9 == 5 & (q5_9 == 98)
file write `out' "P2.08,q5_9,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_9 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q5_9 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q5_9 = 2 if formdef_version == 2512111044 & _p24a_q5_9 == 0 & (missing(q5_9))
quietly replace _p24_q5_9 = 4 if formdef_version == 2512111044 & _p24a_q5_9 == 1 & (missing(q5_9))
quietly replace _p24_q5_9 = 1 if formdef_version == 2512111044 & _p24a_q5_9 == 1 & (q5_9 == 1 | q5_9 == 2 | q5_9 == 3 | q5_9 == 98)
quietly replace _p24_q5_9 = 5 if formdef_version == 2512111044 & _p24_q5_9 == 1 & (q5_9 == 98)
quietly count if formdef_version == 2512111044 & _p24_q5_9 == 5 & (q5_9 == 98)
file write `out' "P2.08,q5_9,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_9 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q5_9 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q5_9 = 2 if formdef_version == 2512121811 & _p24a_q5_9 == 0 & (missing(q5_9))
quietly replace _p24_q5_9 = 4 if formdef_version == 2512121811 & _p24a_q5_9 == 1 & (missing(q5_9))
quietly replace _p24_q5_9 = 1 if formdef_version == 2512121811 & _p24a_q5_9 == 1 & (q5_9 == 1 | q5_9 == 2 | q5_9 == 3 | q5_9 == 98)
quietly replace _p24_q5_9 = 5 if formdef_version == 2512121811 & _p24_q5_9 == 1 & (q5_9 == 98)
quietly count if formdef_version == 2512121811 & _p24_q5_9 == 5 & (q5_9 == 98)
file write `out' "P2.08,q5_9,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q5_9 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q5_9 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q5_9 = 2 if formdef_version == 2602120658 & _p24a_q5_9 == 0 & (missing(q5_9))
quietly replace _p24_q5_9 = 4 if formdef_version == 2602120658 & _p24a_q5_9 == 1 & (missing(q5_9))
quietly replace _p24_q5_9 = 1 if formdef_version == 2602120658 & _p24a_q5_9 == 1 & (q5_9 == 1 | q5_9 == 2 | q5_9 == 3 | q5_9 == 98)
quietly replace _p24_q5_9 = 5 if formdef_version == 2602120658 & _p24_q5_9 == 1 & (q5_9 == 98)
quietly count if formdef_version == 2602120658 & _p24_q5_9 == 5 & (q5_9 == 98)
file write `out' "P2.08,q5_9,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q5_9 == `state' 
        file write `out' "P2.03,q5_9,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q5_9 == 1 & !(missing(q5_9)) & !(q5_9 == 1 | q5_9 == 2 | q5_9 == 3 | q5_9 == 98)
file write `out' "P2.04,q5_9,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q5_9 == 1 & !(missing(q5_9)) & !(q5_9 == 1 | q5_9 == 2 | q5_9 == 3 | q5_9 == 98)
file write `out' "P2.04,q5_9,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q5_9 == 1 & !(missing(q5_9)) & !(q5_9 == 1 | q5_9 == 2 | q5_9 == 3 | q5_9 == 98)
file write `out' "P2.04,q5_9,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q5_9 == 1 & !(missing(q5_9)) & !(q5_9 == 1 | q5_9 == 2 | q5_9 == 3 | q5_9 == 98)
file write `out' "P2.04,q5_9,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q5_9 == 1 & !(missing(q5_9)) & !(q5_9 == 1 | q5_9 == 2 | q5_9 == 3 | q5_9 == 98)
file write `out' "P2.04,q5_9,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_11: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_11 = 6
quietly gen byte _p24a_q6_11 = .
quietly replace _p24a_q6_11 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_11 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_11 = 2 if formdef_version == 2512090157 & _p24a_q6_11 == 0 & (missing(q6_11))
quietly replace _p24_q6_11 = 4 if formdef_version == 2512090157 & _p24a_q6_11 == 1 & (missing(q6_11))
quietly replace _p24_q6_11 = 1 if formdef_version == 2512090157 & _p24a_q6_11 == 1 & (q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
quietly replace _p24_q6_11 = 5 if formdef_version == 2512090157 & _p24_q6_11 == 1 & (q6_11 == 98)
quietly count if formdef_version == 2512090157 & _p24_q6_11 == 5 & (q6_11 == 98)
file write `out' "P2.08,q6_11,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_11 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_11 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_11 = 2 if formdef_version == 2512091719 & _p24a_q6_11 == 0 & (missing(q6_11))
quietly replace _p24_q6_11 = 4 if formdef_version == 2512091719 & _p24a_q6_11 == 1 & (missing(q6_11))
quietly replace _p24_q6_11 = 1 if formdef_version == 2512091719 & _p24a_q6_11 == 1 & (q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
quietly replace _p24_q6_11 = 5 if formdef_version == 2512091719 & _p24_q6_11 == 1 & (q6_11 == 98)
quietly count if formdef_version == 2512091719 & _p24_q6_11 == 5 & (q6_11 == 98)
file write `out' "P2.08,q6_11,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_11 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_11 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_11 = 2 if formdef_version == 2512111044 & _p24a_q6_11 == 0 & (missing(q6_11))
quietly replace _p24_q6_11 = 4 if formdef_version == 2512111044 & _p24a_q6_11 == 1 & (missing(q6_11))
quietly replace _p24_q6_11 = 1 if formdef_version == 2512111044 & _p24a_q6_11 == 1 & (q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
quietly replace _p24_q6_11 = 5 if formdef_version == 2512111044 & _p24_q6_11 == 1 & (q6_11 == 98)
quietly count if formdef_version == 2512111044 & _p24_q6_11 == 5 & (q6_11 == 98)
file write `out' "P2.08,q6_11,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_11 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_11 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_11 = 2 if formdef_version == 2512121811 & _p24a_q6_11 == 0 & (missing(q6_11))
quietly replace _p24_q6_11 = 4 if formdef_version == 2512121811 & _p24a_q6_11 == 1 & (missing(q6_11))
quietly replace _p24_q6_11 = 1 if formdef_version == 2512121811 & _p24a_q6_11 == 1 & (q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
quietly replace _p24_q6_11 = 5 if formdef_version == 2512121811 & _p24_q6_11 == 1 & (q6_11 == 98)
quietly count if formdef_version == 2512121811 & _p24_q6_11 == 5 & (q6_11 == 98)
file write `out' "P2.08,q6_11,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_11 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_11 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_11 = 2 if formdef_version == 2602120658 & _p24a_q6_11 == 0 & (missing(q6_11))
quietly replace _p24_q6_11 = 4 if formdef_version == 2602120658 & _p24a_q6_11 == 1 & (missing(q6_11))
quietly replace _p24_q6_11 = 1 if formdef_version == 2602120658 & _p24a_q6_11 == 1 & (q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
quietly replace _p24_q6_11 = 5 if formdef_version == 2602120658 & _p24_q6_11 == 1 & (q6_11 == 98)
quietly count if formdef_version == 2602120658 & _p24_q6_11 == 5 & (q6_11 == 98)
file write `out' "P2.08,q6_11,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_11 == `state' 
        file write `out' "P2.03,q6_11,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_11 == 1 & !(missing(q6_11)) & !(q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
file write `out' "P2.04,q6_11,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_11 == 1 & !(missing(q6_11)) & !(q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
file write `out' "P2.04,q6_11,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_11 == 1 & !(missing(q6_11)) & !(q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
file write `out' "P2.04,q6_11,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_11 == 1 & !(missing(q6_11)) & !(q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
file write `out' "P2.04,q6_11,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_11 == 1 & !(missing(q6_11)) & !(q6_11 == 1 | q6_11 == 2 | q6_11 == 3 | q6_11 == 4 | q6_11 == 5 | q6_11 == 98)
file write `out' "P2.04,q6_11,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_13: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_13 = 6
quietly gen byte _p24a_q6_13 = .
quietly replace _p24a_q6_13 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_13 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_13 = 2 if formdef_version == 2512090157 & _p24a_q6_13 == 0 & (missing(q6_13))
quietly replace _p24_q6_13 = 4 if formdef_version == 2512090157 & _p24a_q6_13 == 1 & (missing(q6_13))
quietly replace _p24_q6_13 = 1 if formdef_version == 2512090157 & _p24a_q6_13 == 1 & (q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
quietly replace _p24a_q6_13 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_13 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_13 = 2 if formdef_version == 2512091719 & _p24a_q6_13 == 0 & (missing(q6_13))
quietly replace _p24_q6_13 = 4 if formdef_version == 2512091719 & _p24a_q6_13 == 1 & (missing(q6_13))
quietly replace _p24_q6_13 = 1 if formdef_version == 2512091719 & _p24a_q6_13 == 1 & (q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
quietly replace _p24a_q6_13 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_13 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_13 = 2 if formdef_version == 2512111044 & _p24a_q6_13 == 0 & (missing(q6_13))
quietly replace _p24_q6_13 = 4 if formdef_version == 2512111044 & _p24a_q6_13 == 1 & (missing(q6_13))
quietly replace _p24_q6_13 = 1 if formdef_version == 2512111044 & _p24a_q6_13 == 1 & (q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
quietly replace _p24a_q6_13 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_13 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_13 = 2 if formdef_version == 2512121811 & _p24a_q6_13 == 0 & (missing(q6_13))
quietly replace _p24_q6_13 = 4 if formdef_version == 2512121811 & _p24a_q6_13 == 1 & (missing(q6_13))
quietly replace _p24_q6_13 = 1 if formdef_version == 2512121811 & _p24a_q6_13 == 1 & (q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
quietly replace _p24a_q6_13 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_13 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_13 = 2 if formdef_version == 2602120658 & _p24a_q6_13 == 0 & (missing(q6_13))
quietly replace _p24_q6_13 = 4 if formdef_version == 2602120658 & _p24a_q6_13 == 1 & (missing(q6_13))
quietly replace _p24_q6_13 = 1 if formdef_version == 2602120658 & _p24a_q6_13 == 1 & (q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_13 == `state' 
        file write `out' "P2.03,q6_13,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_13 == 1 & !(missing(q6_13)) & !(q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
file write `out' "P2.04,q6_13,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_13 == 1 & !(missing(q6_13)) & !(q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
file write `out' "P2.04,q6_13,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_13 == 1 & !(missing(q6_13)) & !(q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
file write `out' "P2.04,q6_13,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_13 == 1 & !(missing(q6_13)) & !(q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
file write `out' "P2.04,q6_13,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_13 == 1 & !(missing(q6_13)) & !(q6_13 == 1 | q6_13 == 2 | q6_13 == 3 | q6_13 == 4 | q6_13 == 5)
file write `out' "P2.04,q6_13,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_14: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_14 = 6
quietly gen byte _p24a_q6_14 = .
quietly replace _p24a_q6_14 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_14 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_14 = 2 if formdef_version == 2512090157 & _p24a_q6_14 == 0 & (missing(q6_14))
quietly replace _p24_q6_14 = 4 if formdef_version == 2512090157 & _p24a_q6_14 == 1 & (missing(q6_14))
quietly replace _p24_q6_14 = 1 if formdef_version == 2512090157 & _p24a_q6_14 == 1 & (q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
quietly replace _p24_q6_14 = 5 if formdef_version == 2512090157 & _p24_q6_14 == 1 & (q6_14 == 98)
quietly count if formdef_version == 2512090157 & _p24_q6_14 == 5 & (q6_14 == 98)
file write `out' "P2.08,q6_14,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_14 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_14 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_14 = 2 if formdef_version == 2512091719 & _p24a_q6_14 == 0 & (missing(q6_14))
quietly replace _p24_q6_14 = 4 if formdef_version == 2512091719 & _p24a_q6_14 == 1 & (missing(q6_14))
quietly replace _p24_q6_14 = 1 if formdef_version == 2512091719 & _p24a_q6_14 == 1 & (q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
quietly replace _p24_q6_14 = 5 if formdef_version == 2512091719 & _p24_q6_14 == 1 & (q6_14 == 98)
quietly count if formdef_version == 2512091719 & _p24_q6_14 == 5 & (q6_14 == 98)
file write `out' "P2.08,q6_14,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_14 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_14 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_14 = 2 if formdef_version == 2512111044 & _p24a_q6_14 == 0 & (missing(q6_14))
quietly replace _p24_q6_14 = 4 if formdef_version == 2512111044 & _p24a_q6_14 == 1 & (missing(q6_14))
quietly replace _p24_q6_14 = 1 if formdef_version == 2512111044 & _p24a_q6_14 == 1 & (q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
quietly replace _p24_q6_14 = 5 if formdef_version == 2512111044 & _p24_q6_14 == 1 & (q6_14 == 98)
quietly count if formdef_version == 2512111044 & _p24_q6_14 == 5 & (q6_14 == 98)
file write `out' "P2.08,q6_14,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_14 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_14 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_14 = 2 if formdef_version == 2512121811 & _p24a_q6_14 == 0 & (missing(q6_14))
quietly replace _p24_q6_14 = 4 if formdef_version == 2512121811 & _p24a_q6_14 == 1 & (missing(q6_14))
quietly replace _p24_q6_14 = 1 if formdef_version == 2512121811 & _p24a_q6_14 == 1 & (q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
quietly replace _p24_q6_14 = 5 if formdef_version == 2512121811 & _p24_q6_14 == 1 & (q6_14 == 98)
quietly count if formdef_version == 2512121811 & _p24_q6_14 == 5 & (q6_14 == 98)
file write `out' "P2.08,q6_14,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_14 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_14 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_14 = 2 if formdef_version == 2602120658 & _p24a_q6_14 == 0 & (missing(q6_14))
quietly replace _p24_q6_14 = 4 if formdef_version == 2602120658 & _p24a_q6_14 == 1 & (missing(q6_14))
quietly replace _p24_q6_14 = 1 if formdef_version == 2602120658 & _p24a_q6_14 == 1 & (q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
quietly replace _p24_q6_14 = 5 if formdef_version == 2602120658 & _p24_q6_14 == 1 & (q6_14 == 98)
quietly count if formdef_version == 2602120658 & _p24_q6_14 == 5 & (q6_14 == 98)
file write `out' "P2.08,q6_14,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_14 == `state' 
        file write `out' "P2.03,q6_14,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_14 == 1 & !(missing(q6_14)) & !(q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
file write `out' "P2.04,q6_14,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_14 == 1 & !(missing(q6_14)) & !(q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
file write `out' "P2.04,q6_14,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_14 == 1 & !(missing(q6_14)) & !(q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
file write `out' "P2.04,q6_14,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_14 == 1 & !(missing(q6_14)) & !(q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
file write `out' "P2.04,q6_14,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_14 == 1 & !(missing(q6_14)) & !(q6_14 == 0 | q6_14 == 1 | q6_14 == 98)
file write `out' "P2.04,q6_14,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_15: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_15 = 6
quietly gen byte _p24a_q6_15 = .
quietly replace _p24a_q6_15 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_15 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_15 = 2 if formdef_version == 2512090157 & _p24a_q6_15 == 0 & (missing(q6_15))
quietly replace _p24_q6_15 = 4 if formdef_version == 2512090157 & _p24a_q6_15 == 1 & (missing(q6_15))
quietly replace _p24_q6_15 = 1 if formdef_version == 2512090157 & _p24a_q6_15 == 1 & (q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
quietly replace _p24_q6_15 = 5 if formdef_version == 2512090157 & _p24_q6_15 == 1 & (q6_15 == 98)
quietly count if formdef_version == 2512090157 & _p24_q6_15 == 5 & (q6_15 == 98)
file write `out' "P2.08,q6_15,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_15 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_15 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_15 = 2 if formdef_version == 2512091719 & _p24a_q6_15 == 0 & (missing(q6_15))
quietly replace _p24_q6_15 = 4 if formdef_version == 2512091719 & _p24a_q6_15 == 1 & (missing(q6_15))
quietly replace _p24_q6_15 = 1 if formdef_version == 2512091719 & _p24a_q6_15 == 1 & (q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
quietly replace _p24_q6_15 = 5 if formdef_version == 2512091719 & _p24_q6_15 == 1 & (q6_15 == 98)
quietly count if formdef_version == 2512091719 & _p24_q6_15 == 5 & (q6_15 == 98)
file write `out' "P2.08,q6_15,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_15 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_15 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_15 = 2 if formdef_version == 2512111044 & _p24a_q6_15 == 0 & (missing(q6_15))
quietly replace _p24_q6_15 = 4 if formdef_version == 2512111044 & _p24a_q6_15 == 1 & (missing(q6_15))
quietly replace _p24_q6_15 = 1 if formdef_version == 2512111044 & _p24a_q6_15 == 1 & (q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
quietly replace _p24_q6_15 = 5 if formdef_version == 2512111044 & _p24_q6_15 == 1 & (q6_15 == 98)
quietly count if formdef_version == 2512111044 & _p24_q6_15 == 5 & (q6_15 == 98)
file write `out' "P2.08,q6_15,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_15 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_15 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_15 = 2 if formdef_version == 2512121811 & _p24a_q6_15 == 0 & (missing(q6_15))
quietly replace _p24_q6_15 = 4 if formdef_version == 2512121811 & _p24a_q6_15 == 1 & (missing(q6_15))
quietly replace _p24_q6_15 = 1 if formdef_version == 2512121811 & _p24a_q6_15 == 1 & (q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
quietly replace _p24_q6_15 = 5 if formdef_version == 2512121811 & _p24_q6_15 == 1 & (q6_15 == 98)
quietly count if formdef_version == 2512121811 & _p24_q6_15 == 5 & (q6_15 == 98)
file write `out' "P2.08,q6_15,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_15 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_15 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_15 = 2 if formdef_version == 2602120658 & _p24a_q6_15 == 0 & (missing(q6_15))
quietly replace _p24_q6_15 = 4 if formdef_version == 2602120658 & _p24a_q6_15 == 1 & (missing(q6_15))
quietly replace _p24_q6_15 = 1 if formdef_version == 2602120658 & _p24a_q6_15 == 1 & (q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
quietly replace _p24_q6_15 = 5 if formdef_version == 2602120658 & _p24_q6_15 == 1 & (q6_15 == 98)
quietly count if formdef_version == 2602120658 & _p24_q6_15 == 5 & (q6_15 == 98)
file write `out' "P2.08,q6_15,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_15 == `state' 
        file write `out' "P2.03,q6_15,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_15 == 1 & !(missing(q6_15)) & !(q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
file write `out' "P2.04,q6_15,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_15 == 1 & !(missing(q6_15)) & !(q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
file write `out' "P2.04,q6_15,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_15 == 1 & !(missing(q6_15)) & !(q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
file write `out' "P2.04,q6_15,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_15 == 1 & !(missing(q6_15)) & !(q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
file write `out' "P2.04,q6_15,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_15 == 1 & !(missing(q6_15)) & !(q6_15 == 1 | q6_15 == 2 | q6_15 == 3 | q6_15 == 4 | q6_15 == 5 | q6_15 == 98)
file write `out' "P2.04,q6_15,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_16: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_16 = 6
quietly gen byte _p24a_q6_16 = .
quietly replace _p24a_q6_16 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_16 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_16 = 2 if formdef_version == 2512090157 & _p24a_q6_16 == 0 & (missing(q6_16))
quietly replace _p24_q6_16 = 4 if formdef_version == 2512090157 & _p24a_q6_16 == 1 & (missing(q6_16))
quietly replace _p24_q6_16 = 1 if formdef_version == 2512090157 & _p24a_q6_16 == 1 & (q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
quietly replace _p24_q6_16 = 5 if formdef_version == 2512090157 & _p24_q6_16 == 1 & (q6_16 == 98)
quietly count if formdef_version == 2512090157 & _p24_q6_16 == 5 & (q6_16 == 98)
file write `out' "P2.08,q6_16,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_16 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_16 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_16 = 2 if formdef_version == 2512091719 & _p24a_q6_16 == 0 & (missing(q6_16))
quietly replace _p24_q6_16 = 4 if formdef_version == 2512091719 & _p24a_q6_16 == 1 & (missing(q6_16))
quietly replace _p24_q6_16 = 1 if formdef_version == 2512091719 & _p24a_q6_16 == 1 & (q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
quietly replace _p24_q6_16 = 5 if formdef_version == 2512091719 & _p24_q6_16 == 1 & (q6_16 == 98)
quietly count if formdef_version == 2512091719 & _p24_q6_16 == 5 & (q6_16 == 98)
file write `out' "P2.08,q6_16,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_16 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_16 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_16 = 2 if formdef_version == 2512111044 & _p24a_q6_16 == 0 & (missing(q6_16))
quietly replace _p24_q6_16 = 4 if formdef_version == 2512111044 & _p24a_q6_16 == 1 & (missing(q6_16))
quietly replace _p24_q6_16 = 1 if formdef_version == 2512111044 & _p24a_q6_16 == 1 & (q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
quietly replace _p24_q6_16 = 5 if formdef_version == 2512111044 & _p24_q6_16 == 1 & (q6_16 == 98)
quietly count if formdef_version == 2512111044 & _p24_q6_16 == 5 & (q6_16 == 98)
file write `out' "P2.08,q6_16,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_16 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_16 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_16 = 2 if formdef_version == 2512121811 & _p24a_q6_16 == 0 & (missing(q6_16))
quietly replace _p24_q6_16 = 4 if formdef_version == 2512121811 & _p24a_q6_16 == 1 & (missing(q6_16))
quietly replace _p24_q6_16 = 1 if formdef_version == 2512121811 & _p24a_q6_16 == 1 & (q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
quietly replace _p24_q6_16 = 5 if formdef_version == 2512121811 & _p24_q6_16 == 1 & (q6_16 == 98)
quietly count if formdef_version == 2512121811 & _p24_q6_16 == 5 & (q6_16 == 98)
file write `out' "P2.08,q6_16,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_16 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_16 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_16 = 2 if formdef_version == 2602120658 & _p24a_q6_16 == 0 & (missing(q6_16))
quietly replace _p24_q6_16 = 4 if formdef_version == 2602120658 & _p24a_q6_16 == 1 & (missing(q6_16))
quietly replace _p24_q6_16 = 1 if formdef_version == 2602120658 & _p24a_q6_16 == 1 & (q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
quietly replace _p24_q6_16 = 5 if formdef_version == 2602120658 & _p24_q6_16 == 1 & (q6_16 == 98)
quietly count if formdef_version == 2602120658 & _p24_q6_16 == 5 & (q6_16 == 98)
file write `out' "P2.08,q6_16,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_16 == `state' 
        file write `out' "P2.03,q6_16,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_16 == 1 & !(missing(q6_16)) & !(q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
file write `out' "P2.04,q6_16,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_16 == 1 & !(missing(q6_16)) & !(q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
file write `out' "P2.04,q6_16,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_16 == 1 & !(missing(q6_16)) & !(q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
file write `out' "P2.04,q6_16,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_16 == 1 & !(missing(q6_16)) & !(q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
file write `out' "P2.04,q6_16,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_16 == 1 & !(missing(q6_16)) & !(q6_16 == 1 | q6_16 == 2 | q6_16 == 3 | q6_16 == 4 | q6_16 == 98)
file write `out' "P2.04,q6_16,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_17: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_17 = 6
quietly gen byte _p24a_q6_17 = .
quietly replace _p24a_q6_17 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_17 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_17 = 2 if formdef_version == 2512090157 & _p24a_q6_17 == 0 & (missing(q6_17))
quietly replace _p24_q6_17 = 4 if formdef_version == 2512090157 & _p24a_q6_17 == 1 & (missing(q6_17))
quietly replace _p24_q6_17 = 1 if formdef_version == 2512090157 & _p24a_q6_17 == 1 & (q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
quietly replace _p24_q6_17 = 5 if formdef_version == 2512090157 & _p24_q6_17 == 1 & (q6_17 == 98)
quietly count if formdef_version == 2512090157 & _p24_q6_17 == 5 & (q6_17 == 98)
file write `out' "P2.08,q6_17,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_17 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_17 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_17 = 2 if formdef_version == 2512091719 & _p24a_q6_17 == 0 & (missing(q6_17))
quietly replace _p24_q6_17 = 4 if formdef_version == 2512091719 & _p24a_q6_17 == 1 & (missing(q6_17))
quietly replace _p24_q6_17 = 1 if formdef_version == 2512091719 & _p24a_q6_17 == 1 & (q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
quietly replace _p24_q6_17 = 5 if formdef_version == 2512091719 & _p24_q6_17 == 1 & (q6_17 == 98)
quietly count if formdef_version == 2512091719 & _p24_q6_17 == 5 & (q6_17 == 98)
file write `out' "P2.08,q6_17,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_17 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_17 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_17 = 2 if formdef_version == 2512111044 & _p24a_q6_17 == 0 & (missing(q6_17))
quietly replace _p24_q6_17 = 4 if formdef_version == 2512111044 & _p24a_q6_17 == 1 & (missing(q6_17))
quietly replace _p24_q6_17 = 1 if formdef_version == 2512111044 & _p24a_q6_17 == 1 & (q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
quietly replace _p24_q6_17 = 5 if formdef_version == 2512111044 & _p24_q6_17 == 1 & (q6_17 == 98)
quietly count if formdef_version == 2512111044 & _p24_q6_17 == 5 & (q6_17 == 98)
file write `out' "P2.08,q6_17,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_17 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_17 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_17 = 2 if formdef_version == 2512121811 & _p24a_q6_17 == 0 & (missing(q6_17))
quietly replace _p24_q6_17 = 4 if formdef_version == 2512121811 & _p24a_q6_17 == 1 & (missing(q6_17))
quietly replace _p24_q6_17 = 1 if formdef_version == 2512121811 & _p24a_q6_17 == 1 & (q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
quietly replace _p24_q6_17 = 5 if formdef_version == 2512121811 & _p24_q6_17 == 1 & (q6_17 == 98)
quietly count if formdef_version == 2512121811 & _p24_q6_17 == 5 & (q6_17 == 98)
file write `out' "P2.08,q6_17,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_17 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_17 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_17 = 2 if formdef_version == 2602120658 & _p24a_q6_17 == 0 & (missing(q6_17))
quietly replace _p24_q6_17 = 4 if formdef_version == 2602120658 & _p24a_q6_17 == 1 & (missing(q6_17))
quietly replace _p24_q6_17 = 1 if formdef_version == 2602120658 & _p24a_q6_17 == 1 & (q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
quietly replace _p24_q6_17 = 5 if formdef_version == 2602120658 & _p24_q6_17 == 1 & (q6_17 == 98)
quietly count if formdef_version == 2602120658 & _p24_q6_17 == 5 & (q6_17 == 98)
file write `out' "P2.08,q6_17,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_17 == `state' 
        file write `out' "P2.03,q6_17,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_17 == 1 & !(missing(q6_17)) & !(q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
file write `out' "P2.04,q6_17,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_17 == 1 & !(missing(q6_17)) & !(q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
file write `out' "P2.04,q6_17,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_17 == 1 & !(missing(q6_17)) & !(q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
file write `out' "P2.04,q6_17,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_17 == 1 & !(missing(q6_17)) & !(q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
file write `out' "P2.04,q6_17,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_17 == 1 & !(missing(q6_17)) & !(q6_17 == 1 | q6_17 == 2 | q6_17 == 3 | q6_17 == 4 | q6_17 == 98)
file write `out' "P2.04,q6_17,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_18: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_18 = 6
quietly gen byte _p24a_q6_18 = .
quietly replace _p24a_q6_18 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_18 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_18 = 2 if formdef_version == 2512090157 & _p24a_q6_18 == 0 & (missing(q6_18))
quietly replace _p24_q6_18 = 4 if formdef_version == 2512090157 & _p24a_q6_18 == 1 & (missing(q6_18))
quietly replace _p24_q6_18 = 1 if formdef_version == 2512090157 & _p24a_q6_18 == 1 & (q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
quietly replace _p24_q6_18 = 5 if formdef_version == 2512090157 & _p24_q6_18 == 1 & (q6_18 == 4)
quietly count if formdef_version == 2512090157 & _p24_q6_18 == 5 & (q6_18 == 4)
file write `out' "P2.08,q6_18,2512090157,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q6_18 = 5 if formdef_version == 2512090157 & _p24_q6_18 == 1 & (q6_18 == 98)
quietly count if formdef_version == 2512090157 & _p24_q6_18 == 5 & (q6_18 == 98)
file write `out' "P2.08,q6_18,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_18 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_18 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_18 = 2 if formdef_version == 2512091719 & _p24a_q6_18 == 0 & (missing(q6_18))
quietly replace _p24_q6_18 = 4 if formdef_version == 2512091719 & _p24a_q6_18 == 1 & (missing(q6_18))
quietly replace _p24_q6_18 = 1 if formdef_version == 2512091719 & _p24a_q6_18 == 1 & (q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
quietly replace _p24_q6_18 = 5 if formdef_version == 2512091719 & _p24_q6_18 == 1 & (q6_18 == 4)
quietly count if formdef_version == 2512091719 & _p24_q6_18 == 5 & (q6_18 == 4)
file write `out' "P2.08,q6_18,2512091719,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q6_18 = 5 if formdef_version == 2512091719 & _p24_q6_18 == 1 & (q6_18 == 98)
quietly count if formdef_version == 2512091719 & _p24_q6_18 == 5 & (q6_18 == 98)
file write `out' "P2.08,q6_18,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_18 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_18 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_18 = 2 if formdef_version == 2512111044 & _p24a_q6_18 == 0 & (missing(q6_18))
quietly replace _p24_q6_18 = 4 if formdef_version == 2512111044 & _p24a_q6_18 == 1 & (missing(q6_18))
quietly replace _p24_q6_18 = 1 if formdef_version == 2512111044 & _p24a_q6_18 == 1 & (q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
quietly replace _p24_q6_18 = 5 if formdef_version == 2512111044 & _p24_q6_18 == 1 & (q6_18 == 4)
quietly count if formdef_version == 2512111044 & _p24_q6_18 == 5 & (q6_18 == 4)
file write `out' "P2.08,q6_18,2512111044,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q6_18 = 5 if formdef_version == 2512111044 & _p24_q6_18 == 1 & (q6_18 == 98)
quietly count if formdef_version == 2512111044 & _p24_q6_18 == 5 & (q6_18 == 98)
file write `out' "P2.08,q6_18,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_18 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_18 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_18 = 2 if formdef_version == 2512121811 & _p24a_q6_18 == 0 & (missing(q6_18))
quietly replace _p24_q6_18 = 4 if formdef_version == 2512121811 & _p24a_q6_18 == 1 & (missing(q6_18))
quietly replace _p24_q6_18 = 1 if formdef_version == 2512121811 & _p24a_q6_18 == 1 & (q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
quietly replace _p24_q6_18 = 5 if formdef_version == 2512121811 & _p24_q6_18 == 1 & (q6_18 == 4)
quietly count if formdef_version == 2512121811 & _p24_q6_18 == 5 & (q6_18 == 4)
file write `out' "P2.08,q6_18,2512121811,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q6_18 = 5 if formdef_version == 2512121811 & _p24_q6_18 == 1 & (q6_18 == 98)
quietly count if formdef_version == 2512121811 & _p24_q6_18 == 5 & (q6_18 == 98)
file write `out' "P2.08,q6_18,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_18 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_18 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_18 = 2 if formdef_version == 2602120658 & _p24a_q6_18 == 0 & (missing(q6_18))
quietly replace _p24_q6_18 = 4 if formdef_version == 2602120658 & _p24a_q6_18 == 1 & (missing(q6_18))
quietly replace _p24_q6_18 = 1 if formdef_version == 2602120658 & _p24a_q6_18 == 1 & (q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
quietly replace _p24_q6_18 = 5 if formdef_version == 2602120658 & _p24_q6_18 == 1 & (q6_18 == 4)
quietly count if formdef_version == 2602120658 & _p24_q6_18 == 5 & (q6_18 == 4)
file write `out' "P2.08,q6_18,2602120658,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q6_18 = 5 if formdef_version == 2602120658 & _p24_q6_18 == 1 & (q6_18 == 98)
quietly count if formdef_version == 2602120658 & _p24_q6_18 == 5 & (q6_18 == 98)
file write `out' "P2.08,q6_18,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_18 == `state' 
        file write `out' "P2.03,q6_18,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_18 == 1 & !(missing(q6_18)) & !(q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
file write `out' "P2.04,q6_18,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_18 == 1 & !(missing(q6_18)) & !(q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
file write `out' "P2.04,q6_18,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_18 == 1 & !(missing(q6_18)) & !(q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
file write `out' "P2.04,q6_18,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_18 == 1 & !(missing(q6_18)) & !(q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
file write `out' "P2.04,q6_18,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_18 == 1 & !(missing(q6_18)) & !(q6_18 == 1 | q6_18 == 2 | q6_18 == 3 | q6_18 == 4 | q6_18 == 98)
file write `out' "P2.04,q6_18,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_2: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_2 = 6
quietly gen byte _p24a_q6_2 = .
quietly replace _p24a_q6_2 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_2 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_2 = 2 if formdef_version == 2512090157 & _p24a_q6_2 == 0 & (missing(q6_2))
quietly replace _p24_q6_2 = 4 if formdef_version == 2512090157 & _p24a_q6_2 == 1 & (missing(q6_2))
quietly replace _p24_q6_2 = 1 if formdef_version == 2512090157 & _p24a_q6_2 == 1 & (q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
quietly replace _p24_q6_2 = 5 if formdef_version == 2512090157 & _p24_q6_2 == 1 & (q6_2 == 99)
quietly count if formdef_version == 2512090157 & _p24_q6_2 == 5 & (q6_2 == 99)
file write `out' "P2.08,q6_2,2512090157,sentinel,combined_na_uncertainty_or_nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_2 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_2 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_2 = 2 if formdef_version == 2512091719 & _p24a_q6_2 == 0 & (missing(q6_2))
quietly replace _p24_q6_2 = 4 if formdef_version == 2512091719 & _p24a_q6_2 == 1 & (missing(q6_2))
quietly replace _p24_q6_2 = 1 if formdef_version == 2512091719 & _p24a_q6_2 == 1 & (q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
quietly replace _p24_q6_2 = 5 if formdef_version == 2512091719 & _p24_q6_2 == 1 & (q6_2 == 99)
quietly count if formdef_version == 2512091719 & _p24_q6_2 == 5 & (q6_2 == 99)
file write `out' "P2.08,q6_2,2512091719,sentinel,combined_na_uncertainty_or_nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_2 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_2 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_2 = 2 if formdef_version == 2512111044 & _p24a_q6_2 == 0 & (missing(q6_2))
quietly replace _p24_q6_2 = 4 if formdef_version == 2512111044 & _p24a_q6_2 == 1 & (missing(q6_2))
quietly replace _p24_q6_2 = 1 if formdef_version == 2512111044 & _p24a_q6_2 == 1 & (q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
quietly replace _p24_q6_2 = 5 if formdef_version == 2512111044 & _p24_q6_2 == 1 & (q6_2 == 99)
quietly count if formdef_version == 2512111044 & _p24_q6_2 == 5 & (q6_2 == 99)
file write `out' "P2.08,q6_2,2512111044,sentinel,combined_na_uncertainty_or_nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_2 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_2 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_2 = 2 if formdef_version == 2512121811 & _p24a_q6_2 == 0 & (missing(q6_2))
quietly replace _p24_q6_2 = 4 if formdef_version == 2512121811 & _p24a_q6_2 == 1 & (missing(q6_2))
quietly replace _p24_q6_2 = 1 if formdef_version == 2512121811 & _p24a_q6_2 == 1 & (q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
quietly replace _p24_q6_2 = 5 if formdef_version == 2512121811 & _p24_q6_2 == 1 & (q6_2 == 99)
quietly count if formdef_version == 2512121811 & _p24_q6_2 == 5 & (q6_2 == 99)
file write `out' "P2.08,q6_2,2512121811,sentinel,combined_na_uncertainty_or_nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_2 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_2 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_2 = 2 if formdef_version == 2602120658 & _p24a_q6_2 == 0 & (missing(q6_2))
quietly replace _p24_q6_2 = 4 if formdef_version == 2602120658 & _p24a_q6_2 == 1 & (missing(q6_2))
quietly replace _p24_q6_2 = 1 if formdef_version == 2602120658 & _p24a_q6_2 == 1 & (q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
quietly replace _p24_q6_2 = 5 if formdef_version == 2602120658 & _p24_q6_2 == 1 & (q6_2 == 99)
quietly count if formdef_version == 2602120658 & _p24_q6_2 == 5 & (q6_2 == 99)
file write `out' "P2.08,q6_2,2602120658,sentinel,combined_na_uncertainty_or_nonuse,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_2 == `state' 
        file write `out' "P2.03,q6_2,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_2 == 1 & !(missing(q6_2)) & !(q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
file write `out' "P2.04,q6_2,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_2 == 1 & !(missing(q6_2)) & !(q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
file write `out' "P2.04,q6_2,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_2 == 1 & !(missing(q6_2)) & !(q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
file write `out' "P2.04,q6_2,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_2 == 1 & !(missing(q6_2)) & !(q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
file write `out' "P2.04,q6_2,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_2 == 1 & !(missing(q6_2)) & !(q6_2 == 1 | q6_2 == 2 | q6_2 == 3 | q6_2 == 99)
file write `out' "P2.04,q6_2,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_20: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_20 = 6
quietly gen byte _p24a_q6_20 = .
quietly replace _p24a_q6_20 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_20 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_20 = 2 if formdef_version == 2512090157 & _p24a_q6_20 == 0 & (missing(q6_20))
quietly replace _p24_q6_20 = 4 if formdef_version == 2512090157 & _p24a_q6_20 == 1 & (missing(q6_20))
quietly replace _p24_q6_20 = 1 if formdef_version == 2512090157 & _p24a_q6_20 == 1 & (q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
quietly replace _p24_q6_20 = 5 if formdef_version == 2512090157 & _p24_q6_20 == 1 & (q6_20 == 98)
quietly count if formdef_version == 2512090157 & _p24_q6_20 == 5 & (q6_20 == 98)
file write `out' "P2.08,q6_20,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_20 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_20 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_20 = 2 if formdef_version == 2512091719 & _p24a_q6_20 == 0 & (missing(q6_20))
quietly replace _p24_q6_20 = 4 if formdef_version == 2512091719 & _p24a_q6_20 == 1 & (missing(q6_20))
quietly replace _p24_q6_20 = 1 if formdef_version == 2512091719 & _p24a_q6_20 == 1 & (q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
quietly replace _p24_q6_20 = 5 if formdef_version == 2512091719 & _p24_q6_20 == 1 & (q6_20 == 98)
quietly count if formdef_version == 2512091719 & _p24_q6_20 == 5 & (q6_20 == 98)
file write `out' "P2.08,q6_20,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_20 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_20 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_20 = 2 if formdef_version == 2512111044 & _p24a_q6_20 == 0 & (missing(q6_20))
quietly replace _p24_q6_20 = 4 if formdef_version == 2512111044 & _p24a_q6_20 == 1 & (missing(q6_20))
quietly replace _p24_q6_20 = 1 if formdef_version == 2512111044 & _p24a_q6_20 == 1 & (q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
quietly replace _p24_q6_20 = 5 if formdef_version == 2512111044 & _p24_q6_20 == 1 & (q6_20 == 98)
quietly count if formdef_version == 2512111044 & _p24_q6_20 == 5 & (q6_20 == 98)
file write `out' "P2.08,q6_20,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_20 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_20 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_20 = 2 if formdef_version == 2512121811 & _p24a_q6_20 == 0 & (missing(q6_20))
quietly replace _p24_q6_20 = 4 if formdef_version == 2512121811 & _p24a_q6_20 == 1 & (missing(q6_20))
quietly replace _p24_q6_20 = 1 if formdef_version == 2512121811 & _p24a_q6_20 == 1 & (q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
quietly replace _p24_q6_20 = 5 if formdef_version == 2512121811 & _p24_q6_20 == 1 & (q6_20 == 98)
quietly count if formdef_version == 2512121811 & _p24_q6_20 == 5 & (q6_20 == 98)
file write `out' "P2.08,q6_20,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_20 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_20 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_20 = 2 if formdef_version == 2602120658 & _p24a_q6_20 == 0 & (missing(q6_20))
quietly replace _p24_q6_20 = 4 if formdef_version == 2602120658 & _p24a_q6_20 == 1 & (missing(q6_20))
quietly replace _p24_q6_20 = 1 if formdef_version == 2602120658 & _p24a_q6_20 == 1 & (q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
quietly replace _p24_q6_20 = 5 if formdef_version == 2602120658 & _p24_q6_20 == 1 & (q6_20 == 98)
quietly count if formdef_version == 2602120658 & _p24_q6_20 == 5 & (q6_20 == 98)
file write `out' "P2.08,q6_20,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_20 == `state' 
        file write `out' "P2.03,q6_20,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_20 == 1 & !(missing(q6_20)) & !(q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
file write `out' "P2.04,q6_20,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_20 == 1 & !(missing(q6_20)) & !(q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
file write `out' "P2.04,q6_20,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_20 == 1 & !(missing(q6_20)) & !(q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
file write `out' "P2.04,q6_20,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_20 == 1 & !(missing(q6_20)) & !(q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
file write `out' "P2.04,q6_20,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_20 == 1 & !(missing(q6_20)) & !(q6_20 == 1 | q6_20 == 2 | q6_20 == 3 | q6_20 == 98)
file write `out' "P2.04,q6_20,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_21: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_21 = 6
quietly gen byte _p24a_q6_21 = .
quietly replace _p24a_q6_21 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_21 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_21 = 2 if formdef_version == 2512090157 & _p24a_q6_21 == 0 & (missing(q6_21))
quietly replace _p24_q6_21 = 4 if formdef_version == 2512090157 & _p24a_q6_21 == 1 & (missing(q6_21))
quietly replace _p24_q6_21 = 1 if formdef_version == 2512090157 & _p24a_q6_21 == 1 & (q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
quietly replace _p24a_q6_21 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_21 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_21 = 2 if formdef_version == 2512091719 & _p24a_q6_21 == 0 & (missing(q6_21))
quietly replace _p24_q6_21 = 4 if formdef_version == 2512091719 & _p24a_q6_21 == 1 & (missing(q6_21))
quietly replace _p24_q6_21 = 1 if formdef_version == 2512091719 & _p24a_q6_21 == 1 & (q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
quietly replace _p24a_q6_21 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_21 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_21 = 2 if formdef_version == 2512111044 & _p24a_q6_21 == 0 & (missing(q6_21))
quietly replace _p24_q6_21 = 4 if formdef_version == 2512111044 & _p24a_q6_21 == 1 & (missing(q6_21))
quietly replace _p24_q6_21 = 1 if formdef_version == 2512111044 & _p24a_q6_21 == 1 & (q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
quietly replace _p24a_q6_21 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_21 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_21 = 2 if formdef_version == 2512121811 & _p24a_q6_21 == 0 & (missing(q6_21))
quietly replace _p24_q6_21 = 4 if formdef_version == 2512121811 & _p24a_q6_21 == 1 & (missing(q6_21))
quietly replace _p24_q6_21 = 1 if formdef_version == 2512121811 & _p24a_q6_21 == 1 & (q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
quietly replace _p24a_q6_21 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_21 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_21 = 2 if formdef_version == 2602120658 & _p24a_q6_21 == 0 & (missing(q6_21))
quietly replace _p24_q6_21 = 4 if formdef_version == 2602120658 & _p24a_q6_21 == 1 & (missing(q6_21))
quietly replace _p24_q6_21 = 1 if formdef_version == 2602120658 & _p24a_q6_21 == 1 & (q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_21 == `state' 
        file write `out' "P2.03,q6_21,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_21 == 1 & !(missing(q6_21)) & !(q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
file write `out' "P2.04,q6_21,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_21 == 1 & !(missing(q6_21)) & !(q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
file write `out' "P2.04,q6_21,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_21 == 1 & !(missing(q6_21)) & !(q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
file write `out' "P2.04,q6_21,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_21 == 1 & !(missing(q6_21)) & !(q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
file write `out' "P2.04,q6_21,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_21 == 1 & !(missing(q6_21)) & !(q6_21 == 1 | q6_21 == 2 | q6_21 == 3 | q6_21 == 4 | q6_21 == 5 | q6_21 == 6)
file write `out' "P2.04,q6_21,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_22: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_22 = 6
quietly gen byte _p24a_q6_22 = .
quietly replace _p24a_q6_22 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_22 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_22 = 2 if formdef_version == 2512090157 & _p24a_q6_22 == 0 & (missing(q6_22))
quietly replace _p24_q6_22 = 4 if formdef_version == 2512090157 & _p24a_q6_22 == 1 & (missing(q6_22))
quietly replace _p24_q6_22 = 1 if formdef_version == 2512090157 & _p24a_q6_22 == 1 & (q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
quietly replace _p24_q6_22 = 5 if formdef_version == 2512090157 & _p24_q6_22 == 1 & (q6_22 == 98)
quietly count if formdef_version == 2512090157 & _p24_q6_22 == 5 & (q6_22 == 98)
file write `out' "P2.08,q6_22,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q6_22 = 5 if formdef_version == 2512090157 & _p24_q6_22 == 1 & (q6_22 == 99)
quietly count if formdef_version == 2512090157 & _p24_q6_22 == 5 & (q6_22 == 99)
file write `out' "P2.08,q6_22,2512090157,sentinel,combined_na_uncertainty_or_nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_22 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_22 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_22 = 2 if formdef_version == 2512091719 & _p24a_q6_22 == 0 & (missing(q6_22))
quietly replace _p24_q6_22 = 4 if formdef_version == 2512091719 & _p24a_q6_22 == 1 & (missing(q6_22))
quietly replace _p24_q6_22 = 1 if formdef_version == 2512091719 & _p24a_q6_22 == 1 & (q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
quietly replace _p24_q6_22 = 5 if formdef_version == 2512091719 & _p24_q6_22 == 1 & (q6_22 == 98)
quietly count if formdef_version == 2512091719 & _p24_q6_22 == 5 & (q6_22 == 98)
file write `out' "P2.08,q6_22,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q6_22 = 5 if formdef_version == 2512091719 & _p24_q6_22 == 1 & (q6_22 == 99)
quietly count if formdef_version == 2512091719 & _p24_q6_22 == 5 & (q6_22 == 99)
file write `out' "P2.08,q6_22,2512091719,sentinel,combined_na_uncertainty_or_nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_22 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_22 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_22 = 2 if formdef_version == 2512111044 & _p24a_q6_22 == 0 & (missing(q6_22))
quietly replace _p24_q6_22 = 4 if formdef_version == 2512111044 & _p24a_q6_22 == 1 & (missing(q6_22))
quietly replace _p24_q6_22 = 1 if formdef_version == 2512111044 & _p24a_q6_22 == 1 & (q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
quietly replace _p24_q6_22 = 5 if formdef_version == 2512111044 & _p24_q6_22 == 1 & (q6_22 == 98)
quietly count if formdef_version == 2512111044 & _p24_q6_22 == 5 & (q6_22 == 98)
file write `out' "P2.08,q6_22,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q6_22 = 5 if formdef_version == 2512111044 & _p24_q6_22 == 1 & (q6_22 == 99)
quietly count if formdef_version == 2512111044 & _p24_q6_22 == 5 & (q6_22 == 99)
file write `out' "P2.08,q6_22,2512111044,sentinel,combined_na_uncertainty_or_nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_22 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_22 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_22 = 2 if formdef_version == 2512121811 & _p24a_q6_22 == 0 & (missing(q6_22))
quietly replace _p24_q6_22 = 4 if formdef_version == 2512121811 & _p24a_q6_22 == 1 & (missing(q6_22))
quietly replace _p24_q6_22 = 1 if formdef_version == 2512121811 & _p24a_q6_22 == 1 & (q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
quietly replace _p24_q6_22 = 5 if formdef_version == 2512121811 & _p24_q6_22 == 1 & (q6_22 == 98)
quietly count if formdef_version == 2512121811 & _p24_q6_22 == 5 & (q6_22 == 98)
file write `out' "P2.08,q6_22,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q6_22 = 5 if formdef_version == 2512121811 & _p24_q6_22 == 1 & (q6_22 == 99)
quietly count if formdef_version == 2512121811 & _p24_q6_22 == 5 & (q6_22 == 99)
file write `out' "P2.08,q6_22,2512121811,sentinel,combined_na_uncertainty_or_nonuse,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_22 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_22 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_22 = 2 if formdef_version == 2602120658 & _p24a_q6_22 == 0 & (missing(q6_22))
quietly replace _p24_q6_22 = 4 if formdef_version == 2602120658 & _p24a_q6_22 == 1 & (missing(q6_22))
quietly replace _p24_q6_22 = 1 if formdef_version == 2602120658 & _p24a_q6_22 == 1 & (q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
quietly replace _p24_q6_22 = 5 if formdef_version == 2602120658 & _p24_q6_22 == 1 & (q6_22 == 98)
quietly count if formdef_version == 2602120658 & _p24_q6_22 == 5 & (q6_22 == 98)
file write `out' "P2.08,q6_22,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24_q6_22 = 5 if formdef_version == 2602120658 & _p24_q6_22 == 1 & (q6_22 == 99)
quietly count if formdef_version == 2602120658 & _p24_q6_22 == 5 & (q6_22 == 99)
file write `out' "P2.08,q6_22,2602120658,sentinel,combined_na_uncertainty_or_nonuse,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_22 == `state' 
        file write `out' "P2.03,q6_22,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_22 == 1 & !(missing(q6_22)) & !(q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
file write `out' "P2.04,q6_22,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_22 == 1 & !(missing(q6_22)) & !(q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
file write `out' "P2.04,q6_22,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_22 == 1 & !(missing(q6_22)) & !(q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
file write `out' "P2.04,q6_22,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_22 == 1 & !(missing(q6_22)) & !(q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
file write `out' "P2.04,q6_22,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_22 == 1 & !(missing(q6_22)) & !(q6_22 == 1 | q6_22 == 2 | q6_22 == 3 | q6_22 == 98 | q6_22 == 99)
file write `out' "P2.04,q6_22,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_23: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_23 = 6
quietly gen byte _p24a_q6_23 = .
quietly replace _p24a_q6_23 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_23 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_23 = 2 if formdef_version == 2512090157 & _p24a_q6_23 == 0 & (missing(q6_23))
quietly replace _p24_q6_23 = 4 if formdef_version == 2512090157 & _p24a_q6_23 == 1 & (missing(q6_23))
quietly replace _p24_q6_23 = 1 if formdef_version == 2512090157 & _p24a_q6_23 == 1 & (q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
quietly replace _p24a_q6_23 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_23 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_23 = 2 if formdef_version == 2512091719 & _p24a_q6_23 == 0 & (missing(q6_23))
quietly replace _p24_q6_23 = 4 if formdef_version == 2512091719 & _p24a_q6_23 == 1 & (missing(q6_23))
quietly replace _p24_q6_23 = 1 if formdef_version == 2512091719 & _p24a_q6_23 == 1 & (q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
quietly replace _p24a_q6_23 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_23 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_23 = 2 if formdef_version == 2512111044 & _p24a_q6_23 == 0 & (missing(q6_23))
quietly replace _p24_q6_23 = 4 if formdef_version == 2512111044 & _p24a_q6_23 == 1 & (missing(q6_23))
quietly replace _p24_q6_23 = 1 if formdef_version == 2512111044 & _p24a_q6_23 == 1 & (q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
quietly replace _p24a_q6_23 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_23 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_23 = 2 if formdef_version == 2512121811 & _p24a_q6_23 == 0 & (missing(q6_23))
quietly replace _p24_q6_23 = 4 if formdef_version == 2512121811 & _p24a_q6_23 == 1 & (missing(q6_23))
quietly replace _p24_q6_23 = 1 if formdef_version == 2512121811 & _p24a_q6_23 == 1 & (q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
quietly replace _p24a_q6_23 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_23 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_23 = 2 if formdef_version == 2602120658 & _p24a_q6_23 == 0 & (missing(q6_23))
quietly replace _p24_q6_23 = 4 if formdef_version == 2602120658 & _p24a_q6_23 == 1 & (missing(q6_23))
quietly replace _p24_q6_23 = 1 if formdef_version == 2602120658 & _p24a_q6_23 == 1 & (q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_23 == `state' 
        file write `out' "P2.03,q6_23,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_23 == 1 & !(missing(q6_23)) & !(q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
file write `out' "P2.04,q6_23,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_23 == 1 & !(missing(q6_23)) & !(q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
file write `out' "P2.04,q6_23,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_23 == 1 & !(missing(q6_23)) & !(q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
file write `out' "P2.04,q6_23,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_23 == 1 & !(missing(q6_23)) & !(q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
file write `out' "P2.04,q6_23,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_23 == 1 & !(missing(q6_23)) & !(q6_23 == 1 | q6_23 == 2 | q6_23 == 3 | q6_23 == 4)
file write `out' "P2.04,q6_23,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_24: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_24 = 6
quietly gen byte _p24a_q6_24 = .
quietly replace _p24a_q6_24 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_24 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_24 = 2 if formdef_version == 2512090157 & _p24a_q6_24 == 0 & (missing(q6_24))
quietly replace _p24_q6_24 = 4 if formdef_version == 2512090157 & _p24a_q6_24 == 1 & (missing(q6_24))
quietly replace _p24_q6_24 = 1 if formdef_version == 2512090157 & _p24a_q6_24 == 1 & (q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
quietly replace _p24a_q6_24 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_24 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_24 = 2 if formdef_version == 2512091719 & _p24a_q6_24 == 0 & (missing(q6_24))
quietly replace _p24_q6_24 = 4 if formdef_version == 2512091719 & _p24a_q6_24 == 1 & (missing(q6_24))
quietly replace _p24_q6_24 = 1 if formdef_version == 2512091719 & _p24a_q6_24 == 1 & (q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
quietly replace _p24a_q6_24 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_24 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_24 = 2 if formdef_version == 2512111044 & _p24a_q6_24 == 0 & (missing(q6_24))
quietly replace _p24_q6_24 = 4 if formdef_version == 2512111044 & _p24a_q6_24 == 1 & (missing(q6_24))
quietly replace _p24_q6_24 = 1 if formdef_version == 2512111044 & _p24a_q6_24 == 1 & (q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
quietly replace _p24a_q6_24 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_24 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_24 = 2 if formdef_version == 2512121811 & _p24a_q6_24 == 0 & (missing(q6_24))
quietly replace _p24_q6_24 = 4 if formdef_version == 2512121811 & _p24a_q6_24 == 1 & (missing(q6_24))
quietly replace _p24_q6_24 = 1 if formdef_version == 2512121811 & _p24a_q6_24 == 1 & (q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
quietly replace _p24a_q6_24 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & (q6_14 == 1)))
quietly replace _p24a_q6_24 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q6_14 == 0 | q6_14 == 1 | q6_14 == 98) & !(q6_14 == 1)))
quietly replace _p24_q6_24 = 2 if formdef_version == 2602120658 & _p24a_q6_24 == 0 & (missing(q6_24))
quietly replace _p24_q6_24 = 4 if formdef_version == 2602120658 & _p24a_q6_24 == 1 & (missing(q6_24))
quietly replace _p24_q6_24 = 1 if formdef_version == 2602120658 & _p24a_q6_24 == 1 & (q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_24 == `state' 
        file write `out' "P2.03,q6_24,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_24 == 1 & !(missing(q6_24)) & !(q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
file write `out' "P2.04,q6_24,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_24 == 1 & !(missing(q6_24)) & !(q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
file write `out' "P2.04,q6_24,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_24 == 1 & !(missing(q6_24)) & !(q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
file write `out' "P2.04,q6_24,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_24 == 1 & !(missing(q6_24)) & !(q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
file write `out' "P2.04,q6_24,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_24 == 1 & !(missing(q6_24)) & !(q6_24 == 1 | q6_24 == 2 | q6_24 == 3 | q6_24 == 4 | q6_24 == 5)
file write `out' "P2.04,q6_24,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_4: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_4 = 6
quietly gen byte _p24a_q6_4 = .
quietly replace _p24a_q6_4 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_4 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_4 = 2 if formdef_version == 2512090157 & _p24a_q6_4 == 0 & (missing(q6_4))
quietly replace _p24_q6_4 = 4 if formdef_version == 2512090157 & _p24a_q6_4 == 1 & (missing(q6_4))
quietly replace _p24_q6_4 = 1 if formdef_version == 2512090157 & _p24a_q6_4 == 1 & (q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
quietly replace _p24a_q6_4 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_4 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_4 = 2 if formdef_version == 2512091719 & _p24a_q6_4 == 0 & (missing(q6_4))
quietly replace _p24_q6_4 = 4 if formdef_version == 2512091719 & _p24a_q6_4 == 1 & (missing(q6_4))
quietly replace _p24_q6_4 = 1 if formdef_version == 2512091719 & _p24a_q6_4 == 1 & (q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
quietly replace _p24a_q6_4 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_4 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_4 = 2 if formdef_version == 2512111044 & _p24a_q6_4 == 0 & (missing(q6_4))
quietly replace _p24_q6_4 = 4 if formdef_version == 2512111044 & _p24a_q6_4 == 1 & (missing(q6_4))
quietly replace _p24_q6_4 = 1 if formdef_version == 2512111044 & _p24a_q6_4 == 1 & (q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
quietly replace _p24a_q6_4 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_4 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_4 = 2 if formdef_version == 2512121811 & _p24a_q6_4 == 0 & (missing(q6_4))
quietly replace _p24_q6_4 = 4 if formdef_version == 2512121811 & _p24a_q6_4 == 1 & (missing(q6_4))
quietly replace _p24_q6_4 = 1 if formdef_version == 2512121811 & _p24a_q6_4 == 1 & (q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
quietly replace _p24a_q6_4 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_4 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_4 = 2 if formdef_version == 2602120658 & _p24a_q6_4 == 0 & (missing(q6_4))
quietly replace _p24_q6_4 = 4 if formdef_version == 2602120658 & _p24a_q6_4 == 1 & (missing(q6_4))
quietly replace _p24_q6_4 = 1 if formdef_version == 2602120658 & _p24a_q6_4 == 1 & (q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_4 == `state' 
        file write `out' "P2.03,q6_4,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_4 == 1 & !(missing(q6_4)) & !(q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
file write `out' "P2.04,q6_4,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_4 == 1 & !(missing(q6_4)) & !(q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
file write `out' "P2.04,q6_4,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_4 == 1 & !(missing(q6_4)) & !(q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
file write `out' "P2.04,q6_4,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_4 == 1 & !(missing(q6_4)) & !(q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
file write `out' "P2.04,q6_4,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_4 == 1 & !(missing(q6_4)) & !(q6_4 == 1 | q6_4 == 2 | q6_4 == 3 | q6_4 == 4 | q6_4 == 5)
file write `out' "P2.04,q6_4,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_6: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_6 = 6
quietly gen byte _p24a_q6_6 = .
quietly replace _p24a_q6_6 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_6 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_6 = 2 if formdef_version == 2512090157 & _p24a_q6_6 == 0 & (missing(q6_6))
quietly replace _p24_q6_6 = 4 if formdef_version == 2512090157 & _p24a_q6_6 == 1 & (missing(q6_6))
quietly replace _p24_q6_6 = 1 if formdef_version == 2512090157 & _p24a_q6_6 == 1 & (q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
quietly replace _p24_q6_6 = 5 if formdef_version == 2512090157 & _p24_q6_6 == 1 & (q6_6 == 98)
quietly count if formdef_version == 2512090157 & _p24_q6_6 == 5 & (q6_6 == 98)
file write `out' "P2.08,q6_6,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_6 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_6 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_6 = 2 if formdef_version == 2512091719 & _p24a_q6_6 == 0 & (missing(q6_6))
quietly replace _p24_q6_6 = 4 if formdef_version == 2512091719 & _p24a_q6_6 == 1 & (missing(q6_6))
quietly replace _p24_q6_6 = 1 if formdef_version == 2512091719 & _p24a_q6_6 == 1 & (q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
quietly replace _p24_q6_6 = 5 if formdef_version == 2512091719 & _p24_q6_6 == 1 & (q6_6 == 98)
quietly count if formdef_version == 2512091719 & _p24_q6_6 == 5 & (q6_6 == 98)
file write `out' "P2.08,q6_6,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_6 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_6 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_6 = 2 if formdef_version == 2512111044 & _p24a_q6_6 == 0 & (missing(q6_6))
quietly replace _p24_q6_6 = 4 if formdef_version == 2512111044 & _p24a_q6_6 == 1 & (missing(q6_6))
quietly replace _p24_q6_6 = 1 if formdef_version == 2512111044 & _p24a_q6_6 == 1 & (q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
quietly replace _p24_q6_6 = 5 if formdef_version == 2512111044 & _p24_q6_6 == 1 & (q6_6 == 98)
quietly count if formdef_version == 2512111044 & _p24_q6_6 == 5 & (q6_6 == 98)
file write `out' "P2.08,q6_6,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_6 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_6 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_6 = 2 if formdef_version == 2512121811 & _p24a_q6_6 == 0 & (missing(q6_6))
quietly replace _p24_q6_6 = 4 if formdef_version == 2512121811 & _p24a_q6_6 == 1 & (missing(q6_6))
quietly replace _p24_q6_6 = 1 if formdef_version == 2512121811 & _p24a_q6_6 == 1 & (q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
quietly replace _p24_q6_6 = 5 if formdef_version == 2512121811 & _p24_q6_6 == 1 & (q6_6 == 98)
quietly count if formdef_version == 2512121811 & _p24_q6_6 == 5 & (q6_6 == 98)
file write `out' "P2.08,q6_6,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_6 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_6 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_6 = 2 if formdef_version == 2602120658 & _p24a_q6_6 == 0 & (missing(q6_6))
quietly replace _p24_q6_6 = 4 if formdef_version == 2602120658 & _p24a_q6_6 == 1 & (missing(q6_6))
quietly replace _p24_q6_6 = 1 if formdef_version == 2602120658 & _p24a_q6_6 == 1 & (q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
quietly replace _p24_q6_6 = 5 if formdef_version == 2602120658 & _p24_q6_6 == 1 & (q6_6 == 98)
quietly count if formdef_version == 2602120658 & _p24_q6_6 == 5 & (q6_6 == 98)
file write `out' "P2.08,q6_6,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_6 == `state' 
        file write `out' "P2.03,q6_6,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_6 == 1 & !(missing(q6_6)) & !(q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
file write `out' "P2.04,q6_6,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_6 == 1 & !(missing(q6_6)) & !(q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
file write `out' "P2.04,q6_6,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_6 == 1 & !(missing(q6_6)) & !(q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
file write `out' "P2.04,q6_6,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_6 == 1 & !(missing(q6_6)) & !(q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
file write `out' "P2.04,q6_6,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_6 == 1 & !(missing(q6_6)) & !(q6_6 == 1 | q6_6 == 2 | q6_6 == 3 | q6_6 == 4 | q6_6 == 5 | q6_6 == 98)
file write `out' "P2.04,q6_6,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q6_9: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q6_9 = 6
quietly gen byte _p24a_q6_9 = .
quietly replace _p24a_q6_9 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_9 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_9 = 2 if formdef_version == 2512090157 & _p24a_q6_9 == 0 & (missing(q6_9))
quietly replace _p24_q6_9 = 4 if formdef_version == 2512090157 & _p24a_q6_9 == 1 & (missing(q6_9))
quietly replace _p24_q6_9 = 1 if formdef_version == 2512090157 & _p24a_q6_9 == 1 & (q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
quietly replace _p24_q6_9 = 5 if formdef_version == 2512090157 & _p24_q6_9 == 1 & (q6_9 == 99)
quietly count if formdef_version == 2512090157 & _p24_q6_9 == 5 & (q6_9 == 99)
file write `out' "P2.08,q6_9,2512090157,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_9 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_9 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_9 = 2 if formdef_version == 2512091719 & _p24a_q6_9 == 0 & (missing(q6_9))
quietly replace _p24_q6_9 = 4 if formdef_version == 2512091719 & _p24a_q6_9 == 1 & (missing(q6_9))
quietly replace _p24_q6_9 = 1 if formdef_version == 2512091719 & _p24a_q6_9 == 1 & (q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
quietly replace _p24_q6_9 = 5 if formdef_version == 2512091719 & _p24_q6_9 == 1 & (q6_9 == 99)
quietly count if formdef_version == 2512091719 & _p24_q6_9 == 5 & (q6_9 == 99)
file write `out' "P2.08,q6_9,2512091719,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_9 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_9 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_9 = 2 if formdef_version == 2512111044 & _p24a_q6_9 == 0 & (missing(q6_9))
quietly replace _p24_q6_9 = 4 if formdef_version == 2512111044 & _p24a_q6_9 == 1 & (missing(q6_9))
quietly replace _p24_q6_9 = 1 if formdef_version == 2512111044 & _p24a_q6_9 == 1 & (q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
quietly replace _p24_q6_9 = 5 if formdef_version == 2512111044 & _p24_q6_9 == 1 & (q6_9 == 99)
quietly count if formdef_version == 2512111044 & _p24_q6_9 == 5 & (q6_9 == 99)
file write `out' "P2.08,q6_9,2512111044,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_9 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_9 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_9 = 2 if formdef_version == 2512121811 & _p24a_q6_9 == 0 & (missing(q6_9))
quietly replace _p24_q6_9 = 4 if formdef_version == 2512121811 & _p24a_q6_9 == 1 & (missing(q6_9))
quietly replace _p24_q6_9 = 1 if formdef_version == 2512121811 & _p24a_q6_9 == 1 & (q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
quietly replace _p24_q6_9 = 5 if formdef_version == 2512121811 & _p24_q6_9 == 1 & (q6_9 == 99)
quietly count if formdef_version == 2512121811 & _p24_q6_9 == 5 & (q6_9 == 99)
file write `out' "P2.08,q6_9,2512121811,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q6_9 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q6_9 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q6_9 = 2 if formdef_version == 2602120658 & _p24a_q6_9 == 0 & (missing(q6_9))
quietly replace _p24_q6_9 = 4 if formdef_version == 2602120658 & _p24a_q6_9 == 1 & (missing(q6_9))
quietly replace _p24_q6_9 = 1 if formdef_version == 2602120658 & _p24a_q6_9 == 1 & (q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
quietly replace _p24_q6_9 = 5 if formdef_version == 2602120658 & _p24_q6_9 == 1 & (q6_9 == 99)
quietly count if formdef_version == 2602120658 & _p24_q6_9 == 5 & (q6_9 == 99)
file write `out' "P2.08,q6_9,2602120658,sentinel,not_applicable,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q6_9 == `state' 
        file write `out' "P2.03,q6_9,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q6_9 == 1 & !(missing(q6_9)) & !(q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
file write `out' "P2.04,q6_9,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q6_9 == 1 & !(missing(q6_9)) & !(q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
file write `out' "P2.04,q6_9,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q6_9 == 1 & !(missing(q6_9)) & !(q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
file write `out' "P2.04,q6_9,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q6_9 == 1 & !(missing(q6_9)) & !(q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
file write `out' "P2.04,q6_9,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q6_9 == 1 & !(missing(q6_9)) & !(q6_9 == 1 | q6_9 == 2 | q6_9 == 3 | q6_9 == 4 | q6_9 == 99)
file write `out' "P2.04,q6_9,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_1: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_1 = 6
quietly gen byte _p24a_q7_1 = .
quietly replace _p24a_q7_1 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_1 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_1 = 2 if formdef_version == 2512090157 & _p24a_q7_1 == 0 & (missing(q7_1))
quietly replace _p24_q7_1 = 4 if formdef_version == 2512090157 & _p24a_q7_1 == 1 & (missing(q7_1))
quietly replace _p24_q7_1 = 1 if formdef_version == 2512090157 & _p24a_q7_1 == 1 & (q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
quietly replace _p24_q7_1 = 5 if formdef_version == 2512090157 & _p24_q7_1 == 1 & (q7_1 == 98)
quietly count if formdef_version == 2512090157 & _p24_q7_1 == 5 & (q7_1 == 98)
file write `out' "P2.08,q7_1,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_1 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_1 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_1 = 2 if formdef_version == 2512091719 & _p24a_q7_1 == 0 & (missing(q7_1))
quietly replace _p24_q7_1 = 4 if formdef_version == 2512091719 & _p24a_q7_1 == 1 & (missing(q7_1))
quietly replace _p24_q7_1 = 1 if formdef_version == 2512091719 & _p24a_q7_1 == 1 & (q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
quietly replace _p24_q7_1 = 5 if formdef_version == 2512091719 & _p24_q7_1 == 1 & (q7_1 == 98)
quietly count if formdef_version == 2512091719 & _p24_q7_1 == 5 & (q7_1 == 98)
file write `out' "P2.08,q7_1,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_1 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_1 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_1 = 2 if formdef_version == 2512111044 & _p24a_q7_1 == 0 & (missing(q7_1))
quietly replace _p24_q7_1 = 4 if formdef_version == 2512111044 & _p24a_q7_1 == 1 & (missing(q7_1))
quietly replace _p24_q7_1 = 1 if formdef_version == 2512111044 & _p24a_q7_1 == 1 & (q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
quietly replace _p24_q7_1 = 5 if formdef_version == 2512111044 & _p24_q7_1 == 1 & (q7_1 == 98)
quietly count if formdef_version == 2512111044 & _p24_q7_1 == 5 & (q7_1 == 98)
file write `out' "P2.08,q7_1,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_1 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_1 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_1 = 2 if formdef_version == 2512121811 & _p24a_q7_1 == 0 & (missing(q7_1))
quietly replace _p24_q7_1 = 4 if formdef_version == 2512121811 & _p24a_q7_1 == 1 & (missing(q7_1))
quietly replace _p24_q7_1 = 1 if formdef_version == 2512121811 & _p24a_q7_1 == 1 & (q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
quietly replace _p24_q7_1 = 5 if formdef_version == 2512121811 & _p24_q7_1 == 1 & (q7_1 == 98)
quietly count if formdef_version == 2512121811 & _p24_q7_1 == 5 & (q7_1 == 98)
file write `out' "P2.08,q7_1,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_1 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_1 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_1 = 2 if formdef_version == 2602120658 & _p24a_q7_1 == 0 & (missing(q7_1))
quietly replace _p24_q7_1 = 4 if formdef_version == 2602120658 & _p24a_q7_1 == 1 & (missing(q7_1))
quietly replace _p24_q7_1 = 1 if formdef_version == 2602120658 & _p24a_q7_1 == 1 & (q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
quietly replace _p24_q7_1 = 5 if formdef_version == 2602120658 & _p24_q7_1 == 1 & (q7_1 == 98)
quietly count if formdef_version == 2602120658 & _p24_q7_1 == 5 & (q7_1 == 98)
file write `out' "P2.08,q7_1,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_1 == `state' 
        file write `out' "P2.03,q7_1,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_1 == 1 & !(missing(q7_1)) & !(q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
file write `out' "P2.04,q7_1,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_1 == 1 & !(missing(q7_1)) & !(q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
file write `out' "P2.04,q7_1,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_1 == 1 & !(missing(q7_1)) & !(q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
file write `out' "P2.04,q7_1,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_1 == 1 & !(missing(q7_1)) & !(q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
file write `out' "P2.04,q7_1,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_1 == 1 & !(missing(q7_1)) & !(q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98)
file write `out' "P2.04,q7_1,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_10: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_10 = 6
quietly gen byte _p24a_q7_10 = .
quietly replace _p24a_q7_10 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_10 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_10 = 2 if formdef_version == 2512090157 & _p24a_q7_10 == 0 & (missing(q7_10))
quietly replace _p24_q7_10 = 4 if formdef_version == 2512090157 & _p24a_q7_10 == 1 & (missing(q7_10))
quietly replace _p24_q7_10 = 1 if formdef_version == 2512090157 & _p24a_q7_10 == 1 & (q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6 | q7_10 == 7)
quietly replace _p24a_q7_10 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_10 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_10 = 2 if formdef_version == 2512091719 & _p24a_q7_10 == 0 & (missing(q7_10))
quietly replace _p24_q7_10 = 4 if formdef_version == 2512091719 & _p24a_q7_10 == 1 & (missing(q7_10))
quietly replace _p24_q7_10 = 1 if formdef_version == 2512091719 & _p24a_q7_10 == 1 & (q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6)
quietly replace _p24a_q7_10 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_10 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_10 = 2 if formdef_version == 2512111044 & _p24a_q7_10 == 0 & (missing(q7_10))
quietly replace _p24_q7_10 = 4 if formdef_version == 2512111044 & _p24a_q7_10 == 1 & (missing(q7_10))
quietly replace _p24_q7_10 = 1 if formdef_version == 2512111044 & _p24a_q7_10 == 1 & (q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6)
quietly replace _p24a_q7_10 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_10 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_10 = 2 if formdef_version == 2512121811 & _p24a_q7_10 == 0 & (missing(q7_10))
quietly replace _p24_q7_10 = 4 if formdef_version == 2512121811 & _p24a_q7_10 == 1 & (missing(q7_10))
quietly replace _p24_q7_10 = 1 if formdef_version == 2512121811 & _p24a_q7_10 == 1 & (q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6)
quietly replace _p24a_q7_10 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_10 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_10 = 2 if formdef_version == 2602120658 & _p24a_q7_10 == 0 & (missing(q7_10))
quietly replace _p24_q7_10 = 4 if formdef_version == 2602120658 & _p24a_q7_10 == 1 & (missing(q7_10))
quietly replace _p24_q7_10 = 1 if formdef_version == 2602120658 & _p24a_q7_10 == 1 & (q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_10 == `state' 
        file write `out' "P2.03,q7_10,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_10 == 1 & !(missing(q7_10)) & !(q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6 | q7_10 == 7)
file write `out' "P2.04,q7_10,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_10 == 1 & !(missing(q7_10)) & !(q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6)
file write `out' "P2.04,q7_10,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_10 == 1 & !(missing(q7_10)) & !(q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6)
file write `out' "P2.04,q7_10,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_10 == 1 & !(missing(q7_10)) & !(q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6)
file write `out' "P2.04,q7_10,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_10 == 1 & !(missing(q7_10)) & !(q7_10 == 1 | q7_10 == 2 | q7_10 == 3 | q7_10 == 4 | q7_10 == 5 | q7_10 == 6)
file write `out' "P2.04,q7_10,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_11: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_11 = 6
quietly gen byte _p24a_q7_11 = .
quietly replace _p24a_q7_11 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_11 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_11 = 2 if formdef_version == 2512090157 & _p24a_q7_11 == 0 & (missing(q7_11))
quietly replace _p24_q7_11 = 4 if formdef_version == 2512090157 & _p24a_q7_11 == 1 & (missing(q7_11))
quietly replace _p24_q7_11 = 1 if formdef_version == 2512090157 & _p24a_q7_11 == 1 & (q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
quietly replace _p24_q7_11 = 5 if formdef_version == 2512090157 & _p24_q7_11 == 1 & (q7_11 == 98)
quietly count if formdef_version == 2512090157 & _p24_q7_11 == 5 & (q7_11 == 98)
file write `out' "P2.08,q7_11,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_11 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_11 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_11 = 2 if formdef_version == 2512091719 & _p24a_q7_11 == 0 & (missing(q7_11))
quietly replace _p24_q7_11 = 4 if formdef_version == 2512091719 & _p24a_q7_11 == 1 & (missing(q7_11))
quietly replace _p24_q7_11 = 1 if formdef_version == 2512091719 & _p24a_q7_11 == 1 & (q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
quietly replace _p24_q7_11 = 5 if formdef_version == 2512091719 & _p24_q7_11 == 1 & (q7_11 == 98)
quietly count if formdef_version == 2512091719 & _p24_q7_11 == 5 & (q7_11 == 98)
file write `out' "P2.08,q7_11,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_11 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_11 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_11 = 2 if formdef_version == 2512111044 & _p24a_q7_11 == 0 & (missing(q7_11))
quietly replace _p24_q7_11 = 4 if formdef_version == 2512111044 & _p24a_q7_11 == 1 & (missing(q7_11))
quietly replace _p24_q7_11 = 1 if formdef_version == 2512111044 & _p24a_q7_11 == 1 & (q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
quietly replace _p24_q7_11 = 5 if formdef_version == 2512111044 & _p24_q7_11 == 1 & (q7_11 == 98)
quietly count if formdef_version == 2512111044 & _p24_q7_11 == 5 & (q7_11 == 98)
file write `out' "P2.08,q7_11,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_11 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_11 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_11 = 2 if formdef_version == 2512121811 & _p24a_q7_11 == 0 & (missing(q7_11))
quietly replace _p24_q7_11 = 4 if formdef_version == 2512121811 & _p24a_q7_11 == 1 & (missing(q7_11))
quietly replace _p24_q7_11 = 1 if formdef_version == 2512121811 & _p24a_q7_11 == 1 & (q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
quietly replace _p24_q7_11 = 5 if formdef_version == 2512121811 & _p24_q7_11 == 1 & (q7_11 == 98)
quietly count if formdef_version == 2512121811 & _p24_q7_11 == 5 & (q7_11 == 98)
file write `out' "P2.08,q7_11,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_11 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_11 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_11 = 2 if formdef_version == 2602120658 & _p24a_q7_11 == 0 & (missing(q7_11))
quietly replace _p24_q7_11 = 4 if formdef_version == 2602120658 & _p24a_q7_11 == 1 & (missing(q7_11))
quietly replace _p24_q7_11 = 1 if formdef_version == 2602120658 & _p24a_q7_11 == 1 & (q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
quietly replace _p24_q7_11 = 5 if formdef_version == 2602120658 & _p24_q7_11 == 1 & (q7_11 == 98)
quietly count if formdef_version == 2602120658 & _p24_q7_11 == 5 & (q7_11 == 98)
file write `out' "P2.08,q7_11,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_11 == `state' 
        file write `out' "P2.03,q7_11,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_11 == 1 & !(missing(q7_11)) & !(q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
file write `out' "P2.04,q7_11,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_11 == 1 & !(missing(q7_11)) & !(q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
file write `out' "P2.04,q7_11,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_11 == 1 & !(missing(q7_11)) & !(q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
file write `out' "P2.04,q7_11,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_11 == 1 & !(missing(q7_11)) & !(q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
file write `out' "P2.04,q7_11,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_11 == 1 & !(missing(q7_11)) & !(q7_11 == 1 | q7_11 == 2 | q7_11 == 98)
file write `out' "P2.04,q7_11,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_12: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_12 = 6
quietly gen byte _p24a_q7_12 = .
quietly replace _p24a_q7_12 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)))
quietly replace _p24a_q7_12 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)))
quietly replace _p24_q7_12 = 2 if formdef_version == 2512090157 & _p24a_q7_12 == 0 & (missing(q7_12))
quietly replace _p24_q7_12 = 4 if formdef_version == 2512090157 & _p24a_q7_12 == 1 & (missing(q7_12))
quietly replace _p24_q7_12 = 1 if formdef_version == 2512090157 & _p24a_q7_12 == 1 & (q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7)
quietly replace _p24a_q7_12 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)))
quietly replace _p24a_q7_12 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)))
quietly replace _p24_q7_12 = 2 if formdef_version == 2512091719 & _p24a_q7_12 == 0 & (missing(q7_12))
quietly replace _p24_q7_12 = 4 if formdef_version == 2512091719 & _p24a_q7_12 == 1 & (missing(q7_12))
quietly replace _p24_q7_12 = 1 if formdef_version == 2512091719 & _p24a_q7_12 == 1 & (q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6)
quietly replace _p24a_q7_12 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)))
quietly replace _p24a_q7_12 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)))
quietly replace _p24_q7_12 = 2 if formdef_version == 2512111044 & _p24a_q7_12 == 0 & (missing(q7_12))
quietly replace _p24_q7_12 = 4 if formdef_version == 2512111044 & _p24a_q7_12 == 1 & (missing(q7_12))
quietly replace _p24_q7_12 = 1 if formdef_version == 2512111044 & _p24a_q7_12 == 1 & (q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6)
quietly replace _p24a_q7_12 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)))
quietly replace _p24a_q7_12 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)))
quietly replace _p24_q7_12 = 2 if formdef_version == 2512121811 & _p24a_q7_12 == 0 & (missing(q7_12))
quietly replace _p24_q7_12 = 4 if formdef_version == 2512121811 & _p24a_q7_12 == 1 & (missing(q7_12))
quietly replace _p24_q7_12 = 1 if formdef_version == 2512121811 & _p24a_q7_12 == 1 & (q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6)
quietly replace _p24a_q7_12 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)))
quietly replace _p24a_q7_12 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)))
quietly replace _p24_q7_12 = 2 if formdef_version == 2602120658 & _p24a_q7_12 == 0 & (missing(q7_12))
quietly replace _p24_q7_12 = 4 if formdef_version == 2602120658 & _p24a_q7_12 == 1 & (missing(q7_12))
quietly replace _p24_q7_12 = 1 if formdef_version == 2602120658 & _p24a_q7_12 == 1 & (q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_12 == `state' 
        file write `out' "P2.03,q7_12,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_12 == 1 & !(missing(q7_12)) & !(q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7)
file write `out' "P2.04,q7_12,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_12 == 1 & !(missing(q7_12)) & !(q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6)
file write `out' "P2.04,q7_12,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_12 == 1 & !(missing(q7_12)) & !(q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6)
file write `out' "P2.04,q7_12,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_12 == 1 & !(missing(q7_12)) & !(q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6)
file write `out' "P2.04,q7_12,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_12 == 1 & !(missing(q7_12)) & !(q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6)
file write `out' "P2.04,q7_12,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_13: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_13 = 6
quietly gen byte _p24a_q7_13 = .
quietly replace _p24a_q7_13 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & (q7_12 != 6))))
quietly replace _p24a_q7_13 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & !(q7_12 != 6))))
quietly replace _p24_q7_13 = 2 if formdef_version == 2512090157 & _p24a_q7_13 == 0 & (missing(q7_13))
quietly replace _p24_q7_13 = 4 if formdef_version == 2512090157 & _p24a_q7_13 == 1 & (missing(q7_13))
quietly replace _p24_q7_13 = 1 if formdef_version == 2512090157 & _p24a_q7_13 == 1 & (q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
quietly replace _p24a_q7_13 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_13 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_13 = 2 if formdef_version == 2512091719 & _p24a_q7_13 == 0 & (missing(q7_13))
quietly replace _p24_q7_13 = 4 if formdef_version == 2512091719 & _p24a_q7_13 == 1 & (missing(q7_13))
quietly replace _p24_q7_13 = 1 if formdef_version == 2512091719 & _p24a_q7_13 == 1 & (q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
quietly replace _p24a_q7_13 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_13 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_13 = 2 if formdef_version == 2512111044 & _p24a_q7_13 == 0 & (missing(q7_13))
quietly replace _p24_q7_13 = 4 if formdef_version == 2512111044 & _p24a_q7_13 == 1 & (missing(q7_13))
quietly replace _p24_q7_13 = 1 if formdef_version == 2512111044 & _p24a_q7_13 == 1 & (q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
quietly replace _p24a_q7_13 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_13 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_13 = 2 if formdef_version == 2512121811 & _p24a_q7_13 == 0 & (missing(q7_13))
quietly replace _p24_q7_13 = 4 if formdef_version == 2512121811 & _p24a_q7_13 == 1 & (missing(q7_13))
quietly replace _p24_q7_13 = 1 if formdef_version == 2512121811 & _p24a_q7_13 == 1 & (q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
quietly replace _p24a_q7_13 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_13 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_13 = 2 if formdef_version == 2602120658 & _p24a_q7_13 == 0 & (missing(q7_13))
quietly replace _p24_q7_13 = 4 if formdef_version == 2602120658 & _p24a_q7_13 == 1 & (missing(q7_13))
quietly replace _p24_q7_13 = 1 if formdef_version == 2602120658 & _p24a_q7_13 == 1 & (q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_13 == `state' 
        file write `out' "P2.03,q7_13,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_13 == 1 & !(missing(q7_13)) & !(q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
file write `out' "P2.04,q7_13,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_13 == 1 & !(missing(q7_13)) & !(q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
file write `out' "P2.04,q7_13,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_13 == 1 & !(missing(q7_13)) & !(q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
file write `out' "P2.04,q7_13,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_13 == 1 & !(missing(q7_13)) & !(q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
file write `out' "P2.04,q7_13,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_13 == 1 & !(missing(q7_13)) & !(q7_13 == 1 | q7_13 == 2 | q7_13 == 3 | q7_13 == 4 | q7_13 == 5)
file write `out' "P2.04,q7_13,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_14: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_14 = 6
quietly gen byte _p24a_q7_14 = .
quietly replace _p24a_q7_14 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & (q7_12 != 6))))
quietly replace _p24a_q7_14 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & !(q7_12 != 6))))
quietly replace _p24_q7_14 = 2 if formdef_version == 2512090157 & _p24a_q7_14 == 0 & (missing(q7_14))
quietly replace _p24_q7_14 = 4 if formdef_version == 2512090157 & _p24a_q7_14 == 1 & (missing(q7_14))
quietly replace _p24_q7_14 = 1 if formdef_version == 2512090157 & _p24a_q7_14 == 1 & (q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
quietly replace _p24_q7_14 = 5 if formdef_version == 2512090157 & _p24_q7_14 == 1 & (q7_14 == 4)
quietly count if formdef_version == 2512090157 & _p24_q7_14 == 5 & (q7_14 == 4)
file write `out' "P2.08,q7_14,2512090157,sentinel,in_process,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_14 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_14 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_14 = 2 if formdef_version == 2512091719 & _p24a_q7_14 == 0 & (missing(q7_14))
quietly replace _p24_q7_14 = 4 if formdef_version == 2512091719 & _p24a_q7_14 == 1 & (missing(q7_14))
quietly replace _p24_q7_14 = 1 if formdef_version == 2512091719 & _p24a_q7_14 == 1 & (q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
quietly replace _p24_q7_14 = 5 if formdef_version == 2512091719 & _p24_q7_14 == 1 & (q7_14 == 4)
quietly count if formdef_version == 2512091719 & _p24_q7_14 == 5 & (q7_14 == 4)
file write `out' "P2.08,q7_14,2512091719,sentinel,in_process,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_14 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_14 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_14 = 2 if formdef_version == 2512111044 & _p24a_q7_14 == 0 & (missing(q7_14))
quietly replace _p24_q7_14 = 4 if formdef_version == 2512111044 & _p24a_q7_14 == 1 & (missing(q7_14))
quietly replace _p24_q7_14 = 1 if formdef_version == 2512111044 & _p24a_q7_14 == 1 & (q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
quietly replace _p24_q7_14 = 5 if formdef_version == 2512111044 & _p24_q7_14 == 1 & (q7_14 == 4)
quietly count if formdef_version == 2512111044 & _p24_q7_14 == 5 & (q7_14 == 4)
file write `out' "P2.08,q7_14,2512111044,sentinel,in_process,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_14 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_14 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_14 = 2 if formdef_version == 2512121811 & _p24a_q7_14 == 0 & (missing(q7_14))
quietly replace _p24_q7_14 = 4 if formdef_version == 2512121811 & _p24a_q7_14 == 1 & (missing(q7_14))
quietly replace _p24_q7_14 = 1 if formdef_version == 2512121811 & _p24a_q7_14 == 1 & (q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
quietly replace _p24_q7_14 = 5 if formdef_version == 2512121811 & _p24_q7_14 == 1 & (q7_14 == 4)
quietly count if formdef_version == 2512121811 & _p24_q7_14 == 5 & (q7_14 == 4)
file write `out' "P2.08,q7_14,2512121811,sentinel,in_process,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_14 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_14 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_14 = 2 if formdef_version == 2602120658 & _p24a_q7_14 == 0 & (missing(q7_14))
quietly replace _p24_q7_14 = 4 if formdef_version == 2602120658 & _p24a_q7_14 == 1 & (missing(q7_14))
quietly replace _p24_q7_14 = 1 if formdef_version == 2602120658 & _p24a_q7_14 == 1 & (q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
quietly replace _p24_q7_14 = 5 if formdef_version == 2602120658 & _p24_q7_14 == 1 & (q7_14 == 4)
quietly count if formdef_version == 2602120658 & _p24_q7_14 == 5 & (q7_14 == 4)
file write `out' "P2.08,q7_14,2602120658,sentinel,in_process,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_14 == `state' 
        file write `out' "P2.03,q7_14,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_14 == 1 & !(missing(q7_14)) & !(q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
file write `out' "P2.04,q7_14,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_14 == 1 & !(missing(q7_14)) & !(q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
file write `out' "P2.04,q7_14,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_14 == 1 & !(missing(q7_14)) & !(q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
file write `out' "P2.04,q7_14,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_14 == 1 & !(missing(q7_14)) & !(q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
file write `out' "P2.04,q7_14,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_14 == 1 & !(missing(q7_14)) & !(q7_14 == 1 | q7_14 == 2 | q7_14 == 3 | q7_14 == 4)
file write `out' "P2.04,q7_14,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_15: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_15 = 6
quietly gen byte _p24a_q7_15 = .
quietly replace _p24a_q7_15 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & (q7_12 != 6))))
quietly replace _p24a_q7_15 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6 | q7_12 == 7) & !(q7_12 != 6))))
quietly replace _p24_q7_15 = 2 if formdef_version == 2512090157 & _p24a_q7_15 == 0 & (missing(q7_15))
quietly replace _p24_q7_15 = 4 if formdef_version == 2512090157 & _p24a_q7_15 == 1 & (missing(q7_15))
quietly replace _p24_q7_15 = 1 if formdef_version == 2512090157 & _p24a_q7_15 == 1 & (q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
quietly replace _p24a_q7_15 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_15 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_15 = 2 if formdef_version == 2512091719 & _p24a_q7_15 == 0 & (missing(q7_15))
quietly replace _p24_q7_15 = 4 if formdef_version == 2512091719 & _p24a_q7_15 == 1 & (missing(q7_15))
quietly replace _p24_q7_15 = 1 if formdef_version == 2512091719 & _p24a_q7_15 == 1 & (q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
quietly replace _p24a_q7_15 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_15 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_15 = 2 if formdef_version == 2512111044 & _p24a_q7_15 == 0 & (missing(q7_15))
quietly replace _p24_q7_15 = 4 if formdef_version == 2512111044 & _p24a_q7_15 == 1 & (missing(q7_15))
quietly replace _p24_q7_15 = 1 if formdef_version == 2512111044 & _p24a_q7_15 == 1 & (q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
quietly replace _p24a_q7_15 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_15 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_15 = 2 if formdef_version == 2512121811 & _p24a_q7_15 == 0 & (missing(q7_15))
quietly replace _p24_q7_15 = 4 if formdef_version == 2512121811 & _p24a_q7_15 == 1 & (missing(q7_15))
quietly replace _p24_q7_15 = 1 if formdef_version == 2512121811 & _p24a_q7_15 == 1 & (q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
quietly replace _p24a_q7_15 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & (q7_11 == 1)) & ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & (q7_12 != 6))))
quietly replace _p24a_q7_15 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_11 == 1 | q7_11 == 2 | q7_11 == 98) & !(q7_11 == 1)) | ((q7_12 == 1 | q7_12 == 2 | q7_12 == 3 | q7_12 == 4 | q7_12 == 5 | q7_12 == 6) & !(q7_12 != 6))))
quietly replace _p24_q7_15 = 2 if formdef_version == 2602120658 & _p24a_q7_15 == 0 & (missing(q7_15))
quietly replace _p24_q7_15 = 4 if formdef_version == 2602120658 & _p24a_q7_15 == 1 & (missing(q7_15))
quietly replace _p24_q7_15 = 1 if formdef_version == 2602120658 & _p24a_q7_15 == 1 & (q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_15 == `state' 
        file write `out' "P2.03,q7_15,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_15 == 1 & !(missing(q7_15)) & !(q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
file write `out' "P2.04,q7_15,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_15 == 1 & !(missing(q7_15)) & !(q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
file write `out' "P2.04,q7_15,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_15 == 1 & !(missing(q7_15)) & !(q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
file write `out' "P2.04,q7_15,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_15 == 1 & !(missing(q7_15)) & !(q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
file write `out' "P2.04,q7_15,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_15 == 1 & !(missing(q7_15)) & !(q7_15 == 1 | q7_15 == 2 | q7_15 == 3 | q7_15 == 4 | q7_15 == 5)
file write `out' "P2.04,q7_15,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_2: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_2 = 6
quietly gen byte _p24a_q7_2 = .
quietly replace _p24a_q7_2 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 1)) | ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 2))))
quietly replace _p24a_q7_2 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 1)) & ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 2))))
quietly replace _p24_q7_2 = 2 if formdef_version == 2512090157 & _p24a_q7_2 == 0 & (missing(q7_2))
quietly replace _p24_q7_2 = 4 if formdef_version == 2512090157 & _p24a_q7_2 == 1 & (missing(q7_2))
quietly replace _p24_q7_2 = 1 if formdef_version == 2512090157 & _p24a_q7_2 == 1 & (q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
quietly replace _p24a_q7_2 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 1)) | ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 2))))
quietly replace _p24a_q7_2 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 1)) & ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 2))))
quietly replace _p24_q7_2 = 2 if formdef_version == 2512091719 & _p24a_q7_2 == 0 & (missing(q7_2))
quietly replace _p24_q7_2 = 4 if formdef_version == 2512091719 & _p24a_q7_2 == 1 & (missing(q7_2))
quietly replace _p24_q7_2 = 1 if formdef_version == 2512091719 & _p24a_q7_2 == 1 & (q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
quietly replace _p24a_q7_2 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 1)) | ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 2))))
quietly replace _p24a_q7_2 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 1)) & ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 2))))
quietly replace _p24_q7_2 = 2 if formdef_version == 2512111044 & _p24a_q7_2 == 0 & (missing(q7_2))
quietly replace _p24_q7_2 = 4 if formdef_version == 2512111044 & _p24a_q7_2 == 1 & (missing(q7_2))
quietly replace _p24_q7_2 = 1 if formdef_version == 2512111044 & _p24a_q7_2 == 1 & (q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
quietly replace _p24a_q7_2 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 1)) | ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 2))))
quietly replace _p24a_q7_2 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 1)) & ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 2))))
quietly replace _p24_q7_2 = 2 if formdef_version == 2512121811 & _p24a_q7_2 == 0 & (missing(q7_2))
quietly replace _p24_q7_2 = 4 if formdef_version == 2512121811 & _p24a_q7_2 == 1 & (missing(q7_2))
quietly replace _p24_q7_2 = 1 if formdef_version == 2512121811 & _p24a_q7_2 == 1 & (q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
quietly replace _p24a_q7_2 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 1)) | ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & (q7_1 == 2))))
quietly replace _p24a_q7_2 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | (((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 1)) & ((q7_1 == 1 | q7_1 == 2 | q7_1 == 3 | q7_1 == 4 | q7_1 == 98) & !(q7_1 == 2))))
quietly replace _p24_q7_2 = 2 if formdef_version == 2602120658 & _p24a_q7_2 == 0 & (missing(q7_2))
quietly replace _p24_q7_2 = 4 if formdef_version == 2602120658 & _p24a_q7_2 == 1 & (missing(q7_2))
quietly replace _p24_q7_2 = 1 if formdef_version == 2602120658 & _p24a_q7_2 == 1 & (q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_2 == `state' 
        file write `out' "P2.03,q7_2,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_2 == 1 & !(missing(q7_2)) & !(q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
file write `out' "P2.04,q7_2,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_2 == 1 & !(missing(q7_2)) & !(q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
file write `out' "P2.04,q7_2,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_2 == 1 & !(missing(q7_2)) & !(q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
file write `out' "P2.04,q7_2,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_2 == 1 & !(missing(q7_2)) & !(q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
file write `out' "P2.04,q7_2,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_2 == 1 & !(missing(q7_2)) & !(q7_2 == 1 | q7_2 == 2 | q7_2 == 3 | q7_2 == 4 | q7_2 == 5)
file write `out' "P2.04,q7_2,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_5: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_5 = 6
quietly gen byte _p24a_q7_5 = .
quietly replace _p24a_q7_5 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_5 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_5 = 2 if formdef_version == 2512090157 & _p24a_q7_5 == 0 & (missing(q7_5))
quietly replace _p24_q7_5 = 4 if formdef_version == 2512090157 & _p24a_q7_5 == 1 & (missing(q7_5))
quietly replace _p24_q7_5 = 1 if formdef_version == 2512090157 & _p24a_q7_5 == 1 & (q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
quietly replace _p24_q7_5 = 5 if formdef_version == 2512090157 & _p24_q7_5 == 1 & (q7_5 == 98)
quietly count if formdef_version == 2512090157 & _p24_q7_5 == 5 & (q7_5 == 98)
file write `out' "P2.08,q7_5,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_5 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_5 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_5 = 2 if formdef_version == 2512091719 & _p24a_q7_5 == 0 & (missing(q7_5))
quietly replace _p24_q7_5 = 4 if formdef_version == 2512091719 & _p24a_q7_5 == 1 & (missing(q7_5))
quietly replace _p24_q7_5 = 1 if formdef_version == 2512091719 & _p24a_q7_5 == 1 & (q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
quietly replace _p24_q7_5 = 5 if formdef_version == 2512091719 & _p24_q7_5 == 1 & (q7_5 == 98)
quietly count if formdef_version == 2512091719 & _p24_q7_5 == 5 & (q7_5 == 98)
file write `out' "P2.08,q7_5,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_5 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_5 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_5 = 2 if formdef_version == 2512111044 & _p24a_q7_5 == 0 & (missing(q7_5))
quietly replace _p24_q7_5 = 4 if formdef_version == 2512111044 & _p24a_q7_5 == 1 & (missing(q7_5))
quietly replace _p24_q7_5 = 1 if formdef_version == 2512111044 & _p24a_q7_5 == 1 & (q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
quietly replace _p24_q7_5 = 5 if formdef_version == 2512111044 & _p24_q7_5 == 1 & (q7_5 == 98)
quietly count if formdef_version == 2512111044 & _p24_q7_5 == 5 & (q7_5 == 98)
file write `out' "P2.08,q7_5,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_5 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_5 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_5 = 2 if formdef_version == 2512121811 & _p24a_q7_5 == 0 & (missing(q7_5))
quietly replace _p24_q7_5 = 4 if formdef_version == 2512121811 & _p24a_q7_5 == 1 & (missing(q7_5))
quietly replace _p24_q7_5 = 1 if formdef_version == 2512121811 & _p24a_q7_5 == 1 & (q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
quietly replace _p24_q7_5 = 5 if formdef_version == 2512121811 & _p24_q7_5 == 1 & (q7_5 == 98)
quietly count if formdef_version == 2512121811 & _p24_q7_5 == 5 & (q7_5 == 98)
file write `out' "P2.08,q7_5,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_5 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_5 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_5 = 2 if formdef_version == 2602120658 & _p24a_q7_5 == 0 & (missing(q7_5))
quietly replace _p24_q7_5 = 4 if formdef_version == 2602120658 & _p24a_q7_5 == 1 & (missing(q7_5))
quietly replace _p24_q7_5 = 1 if formdef_version == 2602120658 & _p24a_q7_5 == 1 & (q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
quietly replace _p24_q7_5 = 5 if formdef_version == 2602120658 & _p24_q7_5 == 1 & (q7_5 == 98)
quietly count if formdef_version == 2602120658 & _p24_q7_5 == 5 & (q7_5 == 98)
file write `out' "P2.08,q7_5,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_5 == `state' 
        file write `out' "P2.03,q7_5,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_5 == 1 & !(missing(q7_5)) & !(q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
file write `out' "P2.04,q7_5,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_5 == 1 & !(missing(q7_5)) & !(q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
file write `out' "P2.04,q7_5,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_5 == 1 & !(missing(q7_5)) & !(q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
file write `out' "P2.04,q7_5,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_5 == 1 & !(missing(q7_5)) & !(q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
file write `out' "P2.04,q7_5,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_5 == 1 & !(missing(q7_5)) & !(q7_5 == 1 | q7_5 == 2 | q7_5 == 3 | q7_5 == 4 | q7_5 == 98)
file write `out' "P2.04,q7_5,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_6: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_6 = 6
quietly gen byte _p24a_q7_6 = .
quietly replace _p24a_q7_6 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_6 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_6 = 2 if formdef_version == 2512090157 & _p24a_q7_6 == 0 & (missing(q7_6))
quietly replace _p24_q7_6 = 4 if formdef_version == 2512090157 & _p24a_q7_6 == 1 & (missing(q7_6))
quietly replace _p24_q7_6 = 1 if formdef_version == 2512090157 & _p24a_q7_6 == 1 & (q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
quietly replace _p24_q7_6 = 5 if formdef_version == 2512090157 & _p24_q7_6 == 1 & (q7_6 == 98)
quietly count if formdef_version == 2512090157 & _p24_q7_6 == 5 & (q7_6 == 98)
file write `out' "P2.08,q7_6,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_6 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_6 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_6 = 2 if formdef_version == 2512091719 & _p24a_q7_6 == 0 & (missing(q7_6))
quietly replace _p24_q7_6 = 4 if formdef_version == 2512091719 & _p24a_q7_6 == 1 & (missing(q7_6))
quietly replace _p24_q7_6 = 1 if formdef_version == 2512091719 & _p24a_q7_6 == 1 & (q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
quietly replace _p24_q7_6 = 5 if formdef_version == 2512091719 & _p24_q7_6 == 1 & (q7_6 == 98)
quietly count if formdef_version == 2512091719 & _p24_q7_6 == 5 & (q7_6 == 98)
file write `out' "P2.08,q7_6,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_6 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_6 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_6 = 2 if formdef_version == 2512111044 & _p24a_q7_6 == 0 & (missing(q7_6))
quietly replace _p24_q7_6 = 4 if formdef_version == 2512111044 & _p24a_q7_6 == 1 & (missing(q7_6))
quietly replace _p24_q7_6 = 1 if formdef_version == 2512111044 & _p24a_q7_6 == 1 & (q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
quietly replace _p24_q7_6 = 5 if formdef_version == 2512111044 & _p24_q7_6 == 1 & (q7_6 == 98)
quietly count if formdef_version == 2512111044 & _p24_q7_6 == 5 & (q7_6 == 98)
file write `out' "P2.08,q7_6,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_6 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_6 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_6 = 2 if formdef_version == 2512121811 & _p24a_q7_6 == 0 & (missing(q7_6))
quietly replace _p24_q7_6 = 4 if formdef_version == 2512121811 & _p24a_q7_6 == 1 & (missing(q7_6))
quietly replace _p24_q7_6 = 1 if formdef_version == 2512121811 & _p24a_q7_6 == 1 & (q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
quietly replace _p24_q7_6 = 5 if formdef_version == 2512121811 & _p24_q7_6 == 1 & (q7_6 == 98)
quietly count if formdef_version == 2512121811 & _p24_q7_6 == 5 & (q7_6 == 98)
file write `out' "P2.08,q7_6,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_6 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_6 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_6 = 2 if formdef_version == 2602120658 & _p24a_q7_6 == 0 & (missing(q7_6))
quietly replace _p24_q7_6 = 4 if formdef_version == 2602120658 & _p24a_q7_6 == 1 & (missing(q7_6))
quietly replace _p24_q7_6 = 1 if formdef_version == 2602120658 & _p24a_q7_6 == 1 & (q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
quietly replace _p24_q7_6 = 5 if formdef_version == 2602120658 & _p24_q7_6 == 1 & (q7_6 == 98)
quietly count if formdef_version == 2602120658 & _p24_q7_6 == 5 & (q7_6 == 98)
file write `out' "P2.08,q7_6,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_6 == `state' 
        file write `out' "P2.03,q7_6,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_6 == 1 & !(missing(q7_6)) & !(q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
file write `out' "P2.04,q7_6,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_6 == 1 & !(missing(q7_6)) & !(q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
file write `out' "P2.04,q7_6,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_6 == 1 & !(missing(q7_6)) & !(q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
file write `out' "P2.04,q7_6,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_6 == 1 & !(missing(q7_6)) & !(q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
file write `out' "P2.04,q7_6,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_6 == 1 & !(missing(q7_6)) & !(q7_6 == 1 | q7_6 == 2 | q7_6 == 3 | q7_6 == 98)
file write `out' "P2.04,q7_6,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_7: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_7 = 6
quietly gen byte _p24a_q7_7 = .
quietly replace _p24a_q7_7 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_7 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_7 = 2 if formdef_version == 2512090157 & _p24a_q7_7 == 0 & (missing(q7_7))
quietly replace _p24_q7_7 = 4 if formdef_version == 2512090157 & _p24a_q7_7 == 1 & (missing(q7_7))
quietly replace _p24_q7_7 = 1 if formdef_version == 2512090157 & _p24a_q7_7 == 1 & (q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
quietly replace _p24a_q7_7 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_7 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_7 = 2 if formdef_version == 2512091719 & _p24a_q7_7 == 0 & (missing(q7_7))
quietly replace _p24_q7_7 = 4 if formdef_version == 2512091719 & _p24a_q7_7 == 1 & (missing(q7_7))
quietly replace _p24_q7_7 = 1 if formdef_version == 2512091719 & _p24a_q7_7 == 1 & (q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
quietly replace _p24a_q7_7 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_7 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_7 = 2 if formdef_version == 2512111044 & _p24a_q7_7 == 0 & (missing(q7_7))
quietly replace _p24_q7_7 = 4 if formdef_version == 2512111044 & _p24a_q7_7 == 1 & (missing(q7_7))
quietly replace _p24_q7_7 = 1 if formdef_version == 2512111044 & _p24a_q7_7 == 1 & (q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
quietly replace _p24a_q7_7 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_7 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_7 = 2 if formdef_version == 2512121811 & _p24a_q7_7 == 0 & (missing(q7_7))
quietly replace _p24_q7_7 = 4 if formdef_version == 2512121811 & _p24a_q7_7 == 1 & (missing(q7_7))
quietly replace _p24_q7_7 = 1 if formdef_version == 2512121811 & _p24a_q7_7 == 1 & (q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
quietly replace _p24a_q7_7 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_7 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_7 = 2 if formdef_version == 2602120658 & _p24a_q7_7 == 0 & (missing(q7_7))
quietly replace _p24_q7_7 = 4 if formdef_version == 2602120658 & _p24a_q7_7 == 1 & (missing(q7_7))
quietly replace _p24_q7_7 = 1 if formdef_version == 2602120658 & _p24a_q7_7 == 1 & (q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_7 == `state' 
        file write `out' "P2.03,q7_7,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_7 == 1 & !(missing(q7_7)) & !(q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
file write `out' "P2.04,q7_7,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_7 == 1 & !(missing(q7_7)) & !(q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
file write `out' "P2.04,q7_7,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_7 == 1 & !(missing(q7_7)) & !(q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
file write `out' "P2.04,q7_7,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_7 == 1 & !(missing(q7_7)) & !(q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
file write `out' "P2.04,q7_7,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_7 == 1 & !(missing(q7_7)) & !(q7_7 == 1 | q7_7 == 2 | q7_7 == 3 | q7_7 == 4)
file write `out' "P2.04,q7_7,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_8: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_8 = 6
quietly gen byte _p24a_q7_8 = .
quietly replace _p24a_q7_8 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_8 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_8 = 2 if formdef_version == 2512090157 & _p24a_q7_8 == 0 & (missing(q7_8))
quietly replace _p24_q7_8 = 4 if formdef_version == 2512090157 & _p24a_q7_8 == 1 & (missing(q7_8))
quietly replace _p24_q7_8 = 1 if formdef_version == 2512090157 & _p24a_q7_8 == 1 & (q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
quietly replace _p24_q7_8 = 5 if formdef_version == 2512090157 & _p24_q7_8 == 1 & (q7_8 == 98)
quietly count if formdef_version == 2512090157 & _p24_q7_8 == 5 & (q7_8 == 98)
file write `out' "P2.08,q7_8,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_8 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_8 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_8 = 2 if formdef_version == 2512091719 & _p24a_q7_8 == 0 & (missing(q7_8))
quietly replace _p24_q7_8 = 4 if formdef_version == 2512091719 & _p24a_q7_8 == 1 & (missing(q7_8))
quietly replace _p24_q7_8 = 1 if formdef_version == 2512091719 & _p24a_q7_8 == 1 & (q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
quietly replace _p24_q7_8 = 5 if formdef_version == 2512091719 & _p24_q7_8 == 1 & (q7_8 == 98)
quietly count if formdef_version == 2512091719 & _p24_q7_8 == 5 & (q7_8 == 98)
file write `out' "P2.08,q7_8,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_8 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_8 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_8 = 2 if formdef_version == 2512111044 & _p24a_q7_8 == 0 & (missing(q7_8))
quietly replace _p24_q7_8 = 4 if formdef_version == 2512111044 & _p24a_q7_8 == 1 & (missing(q7_8))
quietly replace _p24_q7_8 = 1 if formdef_version == 2512111044 & _p24a_q7_8 == 1 & (q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
quietly replace _p24_q7_8 = 5 if formdef_version == 2512111044 & _p24_q7_8 == 1 & (q7_8 == 98)
quietly count if formdef_version == 2512111044 & _p24_q7_8 == 5 & (q7_8 == 98)
file write `out' "P2.08,q7_8,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_8 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_8 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_8 = 2 if formdef_version == 2512121811 & _p24a_q7_8 == 0 & (missing(q7_8))
quietly replace _p24_q7_8 = 4 if formdef_version == 2512121811 & _p24a_q7_8 == 1 & (missing(q7_8))
quietly replace _p24_q7_8 = 1 if formdef_version == 2512121811 & _p24a_q7_8 == 1 & (q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
quietly replace _p24_q7_8 = 5 if formdef_version == 2512121811 & _p24_q7_8 == 1 & (q7_8 == 98)
quietly count if formdef_version == 2512121811 & _p24_q7_8 == 5 & (q7_8 == 98)
file write `out' "P2.08,q7_8,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q7_8 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_8 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_8 = 2 if formdef_version == 2602120658 & _p24a_q7_8 == 0 & (missing(q7_8))
quietly replace _p24_q7_8 = 4 if formdef_version == 2602120658 & _p24a_q7_8 == 1 & (missing(q7_8))
quietly replace _p24_q7_8 = 1 if formdef_version == 2602120658 & _p24a_q7_8 == 1 & (q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
quietly replace _p24_q7_8 = 5 if formdef_version == 2602120658 & _p24_q7_8 == 1 & (q7_8 == 98)
quietly count if formdef_version == 2602120658 & _p24_q7_8 == 5 & (q7_8 == 98)
file write `out' "P2.08,q7_8,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_8 == `state' 
        file write `out' "P2.03,q7_8,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_8 == 1 & !(missing(q7_8)) & !(q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
file write `out' "P2.04,q7_8,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_8 == 1 & !(missing(q7_8)) & !(q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
file write `out' "P2.04,q7_8,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_8 == 1 & !(missing(q7_8)) & !(q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
file write `out' "P2.04,q7_8,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_8 == 1 & !(missing(q7_8)) & !(q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
file write `out' "P2.04,q7_8,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_8 == 1 & !(missing(q7_8)) & !(q7_8 == 1 | q7_8 == 2 | q7_8 == 3 | q7_8 == 98)
file write `out' "P2.04,q7_8,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q7_9: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q7_9 = 6
quietly gen byte _p24a_q7_9 = .
quietly replace _p24a_q7_9 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_9 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_9 = 2 if formdef_version == 2512090157 & _p24a_q7_9 == 0 & (missing(q7_9))
quietly replace _p24_q7_9 = 4 if formdef_version == 2512090157 & _p24a_q7_9 == 1 & (missing(q7_9))
quietly replace _p24_q7_9 = 1 if formdef_version == 2512090157 & _p24a_q7_9 == 1 & (q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
quietly replace _p24a_q7_9 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_9 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_9 = 2 if formdef_version == 2512091719 & _p24a_q7_9 == 0 & (missing(q7_9))
quietly replace _p24_q7_9 = 4 if formdef_version == 2512091719 & _p24a_q7_9 == 1 & (missing(q7_9))
quietly replace _p24_q7_9 = 1 if formdef_version == 2512091719 & _p24a_q7_9 == 1 & (q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
quietly replace _p24a_q7_9 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_9 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_9 = 2 if formdef_version == 2512111044 & _p24a_q7_9 == 0 & (missing(q7_9))
quietly replace _p24_q7_9 = 4 if formdef_version == 2512111044 & _p24a_q7_9 == 1 & (missing(q7_9))
quietly replace _p24_q7_9 = 1 if formdef_version == 2512111044 & _p24a_q7_9 == 1 & (q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
quietly replace _p24a_q7_9 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_9 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_9 = 2 if formdef_version == 2512121811 & _p24a_q7_9 == 0 & (missing(q7_9))
quietly replace _p24_q7_9 = 4 if formdef_version == 2512121811 & _p24a_q7_9 == 1 & (missing(q7_9))
quietly replace _p24_q7_9 = 1 if formdef_version == 2512121811 & _p24a_q7_9 == 1 & (q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
quietly replace _p24a_q7_9 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q7_9 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q7_9 = 2 if formdef_version == 2602120658 & _p24a_q7_9 == 0 & (missing(q7_9))
quietly replace _p24_q7_9 = 4 if formdef_version == 2602120658 & _p24a_q7_9 == 1 & (missing(q7_9))
quietly replace _p24_q7_9 = 1 if formdef_version == 2602120658 & _p24a_q7_9 == 1 & (q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q7_9 == `state' 
        file write `out' "P2.03,q7_9,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q7_9 == 1 & !(missing(q7_9)) & !(q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
file write `out' "P2.04,q7_9,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q7_9 == 1 & !(missing(q7_9)) & !(q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
file write `out' "P2.04,q7_9,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q7_9 == 1 & !(missing(q7_9)) & !(q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
file write `out' "P2.04,q7_9,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q7_9 == 1 & !(missing(q7_9)) & !(q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
file write `out' "P2.04,q7_9,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q7_9 == 1 & !(missing(q7_9)) & !(q7_9 == 1 | q7_9 == 2 | q7_9 == 3 | q7_9 == 4)
file write `out' "P2.04,q7_9,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_1: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_1 = 6
quietly gen byte _p24a_q9_1 = .
quietly replace _p24a_q9_1 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_1 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_1 = 2 if formdef_version == 2512090157 & _p24a_q9_1 == 0 & (missing(q9_1))
quietly replace _p24_q9_1 = 4 if formdef_version == 2512090157 & _p24a_q9_1 == 1 & (missing(q9_1))
quietly replace _p24_q9_1 = 1 if formdef_version == 2512090157 & _p24a_q9_1 == 1 & (q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
quietly replace _p24a_q9_1 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_1 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_1 = 2 if formdef_version == 2512091719 & _p24a_q9_1 == 0 & (missing(q9_1))
quietly replace _p24_q9_1 = 4 if formdef_version == 2512091719 & _p24a_q9_1 == 1 & (missing(q9_1))
quietly replace _p24_q9_1 = 1 if formdef_version == 2512091719 & _p24a_q9_1 == 1 & (q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
quietly replace _p24a_q9_1 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_1 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_1 = 2 if formdef_version == 2512111044 & _p24a_q9_1 == 0 & (missing(q9_1))
quietly replace _p24_q9_1 = 4 if formdef_version == 2512111044 & _p24a_q9_1 == 1 & (missing(q9_1))
quietly replace _p24_q9_1 = 1 if formdef_version == 2512111044 & _p24a_q9_1 == 1 & (q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
quietly replace _p24a_q9_1 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_1 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_1 = 2 if formdef_version == 2512121811 & _p24a_q9_1 == 0 & (missing(q9_1))
quietly replace _p24_q9_1 = 4 if formdef_version == 2512121811 & _p24a_q9_1 == 1 & (missing(q9_1))
quietly replace _p24_q9_1 = 1 if formdef_version == 2512121811 & _p24a_q9_1 == 1 & (q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
quietly replace _p24a_q9_1 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_1 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_1 = 2 if formdef_version == 2602120658 & _p24a_q9_1 == 0 & (missing(q9_1))
quietly replace _p24_q9_1 = 4 if formdef_version == 2602120658 & _p24a_q9_1 == 1 & (missing(q9_1))
quietly replace _p24_q9_1 = 1 if formdef_version == 2602120658 & _p24a_q9_1 == 1 & (q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_1 == `state' 
        file write `out' "P2.03,q9_1,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_1 == 1 & !(missing(q9_1)) & !(q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
file write `out' "P2.04,q9_1,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_1 == 1 & !(missing(q9_1)) & !(q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
file write `out' "P2.04,q9_1,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_1 == 1 & !(missing(q9_1)) & !(q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
file write `out' "P2.04,q9_1,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_1 == 1 & !(missing(q9_1)) & !(q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
file write `out' "P2.04,q9_1,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_1 == 1 & !(missing(q9_1)) & !(q9_1 == 1 | q9_1 == 2 | q9_1 == 3 | q9_1 == 4 | q9_1 == 5)
file write `out' "P2.04,q9_1,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_11: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_11 = 6
quietly gen byte _p24a_q9_11 = .
quietly replace _p24a_q9_11 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_11 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_11 = 2 if formdef_version == 2512090157 & _p24a_q9_11 == 0 & (missing(q9_11))
quietly replace _p24_q9_11 = 4 if formdef_version == 2512090157 & _p24a_q9_11 == 1 & (missing(q9_11))
quietly replace _p24_q9_11 = 1 if formdef_version == 2512090157 & _p24a_q9_11 == 1 & (q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
quietly replace _p24_q9_11 = 5 if formdef_version == 2512090157 & _p24_q9_11 == 1 & (q9_11 == 98)
quietly count if formdef_version == 2512090157 & _p24_q9_11 == 5 & (q9_11 == 98)
file write `out' "P2.08,q9_11,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_11 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_11 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_11 = 2 if formdef_version == 2512091719 & _p24a_q9_11 == 0 & (missing(q9_11))
quietly replace _p24_q9_11 = 4 if formdef_version == 2512091719 & _p24a_q9_11 == 1 & (missing(q9_11))
quietly replace _p24_q9_11 = 1 if formdef_version == 2512091719 & _p24a_q9_11 == 1 & (q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
quietly replace _p24_q9_11 = 5 if formdef_version == 2512091719 & _p24_q9_11 == 1 & (q9_11 == 98)
quietly count if formdef_version == 2512091719 & _p24_q9_11 == 5 & (q9_11 == 98)
file write `out' "P2.08,q9_11,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_11 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_11 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_11 = 2 if formdef_version == 2512111044 & _p24a_q9_11 == 0 & (missing(q9_11))
quietly replace _p24_q9_11 = 4 if formdef_version == 2512111044 & _p24a_q9_11 == 1 & (missing(q9_11))
quietly replace _p24_q9_11 = 1 if formdef_version == 2512111044 & _p24a_q9_11 == 1 & (q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
quietly replace _p24_q9_11 = 5 if formdef_version == 2512111044 & _p24_q9_11 == 1 & (q9_11 == 98)
quietly count if formdef_version == 2512111044 & _p24_q9_11 == 5 & (q9_11 == 98)
file write `out' "P2.08,q9_11,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_11 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_11 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_11 = 2 if formdef_version == 2512121811 & _p24a_q9_11 == 0 & (missing(q9_11))
quietly replace _p24_q9_11 = 4 if formdef_version == 2512121811 & _p24a_q9_11 == 1 & (missing(q9_11))
quietly replace _p24_q9_11 = 1 if formdef_version == 2512121811 & _p24a_q9_11 == 1 & (q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
quietly replace _p24_q9_11 = 5 if formdef_version == 2512121811 & _p24_q9_11 == 1 & (q9_11 == 98)
quietly count if formdef_version == 2512121811 & _p24_q9_11 == 5 & (q9_11 == 98)
file write `out' "P2.08,q9_11,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_11 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_11 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_11 = 2 if formdef_version == 2602120658 & _p24a_q9_11 == 0 & (missing(q9_11))
quietly replace _p24_q9_11 = 4 if formdef_version == 2602120658 & _p24a_q9_11 == 1 & (missing(q9_11))
quietly replace _p24_q9_11 = 1 if formdef_version == 2602120658 & _p24a_q9_11 == 1 & (q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
quietly replace _p24_q9_11 = 5 if formdef_version == 2602120658 & _p24_q9_11 == 1 & (q9_11 == 98)
quietly count if formdef_version == 2602120658 & _p24_q9_11 == 5 & (q9_11 == 98)
file write `out' "P2.08,q9_11,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_11 == `state' 
        file write `out' "P2.03,q9_11,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_11 == 1 & !(missing(q9_11)) & !(q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
file write `out' "P2.04,q9_11,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_11 == 1 & !(missing(q9_11)) & !(q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
file write `out' "P2.04,q9_11,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_11 == 1 & !(missing(q9_11)) & !(q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
file write `out' "P2.04,q9_11,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_11 == 1 & !(missing(q9_11)) & !(q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
file write `out' "P2.04,q9_11,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_11 == 1 & !(missing(q9_11)) & !(q9_11 == 1 | q9_11 == 2 | q9_11 == 3 | q9_11 == 4 | q9_11 == 98)
file write `out' "P2.04,q9_11,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_13: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_13 = 6
quietly gen byte _p24a_q9_13 = .
quietly replace _p24a_q9_13 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_13 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_13 = 2 if formdef_version == 2512090157 & _p24a_q9_13 == 0 & (missing(q9_13))
quietly replace _p24_q9_13 = 4 if formdef_version == 2512090157 & _p24a_q9_13 == 1 & (missing(q9_13))
quietly replace _p24_q9_13 = 1 if formdef_version == 2512090157 & _p24a_q9_13 == 1 & (q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
quietly replace _p24_q9_13 = 5 if formdef_version == 2512090157 & _p24_q9_13 == 1 & (q9_13 == 98)
quietly count if formdef_version == 2512090157 & _p24_q9_13 == 5 & (q9_13 == 98)
file write `out' "P2.08,q9_13,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_13 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_13 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_13 = 2 if formdef_version == 2512091719 & _p24a_q9_13 == 0 & (missing(q9_13))
quietly replace _p24_q9_13 = 4 if formdef_version == 2512091719 & _p24a_q9_13 == 1 & (missing(q9_13))
quietly replace _p24_q9_13 = 1 if formdef_version == 2512091719 & _p24a_q9_13 == 1 & (q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
quietly replace _p24_q9_13 = 5 if formdef_version == 2512091719 & _p24_q9_13 == 1 & (q9_13 == 98)
quietly count if formdef_version == 2512091719 & _p24_q9_13 == 5 & (q9_13 == 98)
file write `out' "P2.08,q9_13,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_13 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_13 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_13 = 2 if formdef_version == 2512111044 & _p24a_q9_13 == 0 & (missing(q9_13))
quietly replace _p24_q9_13 = 4 if formdef_version == 2512111044 & _p24a_q9_13 == 1 & (missing(q9_13))
quietly replace _p24_q9_13 = 1 if formdef_version == 2512111044 & _p24a_q9_13 == 1 & (q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
quietly replace _p24_q9_13 = 5 if formdef_version == 2512111044 & _p24_q9_13 == 1 & (q9_13 == 98)
quietly count if formdef_version == 2512111044 & _p24_q9_13 == 5 & (q9_13 == 98)
file write `out' "P2.08,q9_13,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_13 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_13 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_13 = 2 if formdef_version == 2512121811 & _p24a_q9_13 == 0 & (missing(q9_13))
quietly replace _p24_q9_13 = 4 if formdef_version == 2512121811 & _p24a_q9_13 == 1 & (missing(q9_13))
quietly replace _p24_q9_13 = 1 if formdef_version == 2512121811 & _p24a_q9_13 == 1 & (q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
quietly replace _p24_q9_13 = 5 if formdef_version == 2512121811 & _p24_q9_13 == 1 & (q9_13 == 98)
quietly count if formdef_version == 2512121811 & _p24_q9_13 == 5 & (q9_13 == 98)
file write `out' "P2.08,q9_13,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_13 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_13 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_13 = 2 if formdef_version == 2602120658 & _p24a_q9_13 == 0 & (missing(q9_13))
quietly replace _p24_q9_13 = 4 if formdef_version == 2602120658 & _p24a_q9_13 == 1 & (missing(q9_13))
quietly replace _p24_q9_13 = 1 if formdef_version == 2602120658 & _p24a_q9_13 == 1 & (q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
quietly replace _p24_q9_13 = 5 if formdef_version == 2602120658 & _p24_q9_13 == 1 & (q9_13 == 98)
quietly count if formdef_version == 2602120658 & _p24_q9_13 == 5 & (q9_13 == 98)
file write `out' "P2.08,q9_13,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_13 == `state' 
        file write `out' "P2.03,q9_13,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_13 == 1 & !(missing(q9_13)) & !(q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
file write `out' "P2.04,q9_13,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_13 == 1 & !(missing(q9_13)) & !(q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
file write `out' "P2.04,q9_13,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_13 == 1 & !(missing(q9_13)) & !(q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
file write `out' "P2.04,q9_13,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_13 == 1 & !(missing(q9_13)) & !(q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
file write `out' "P2.04,q9_13,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_13 == 1 & !(missing(q9_13)) & !(q9_13 == 1 | q9_13 == 2 | q9_13 == 3 | q9_13 == 4 | q9_13 == 98)
file write `out' "P2.04,q9_13,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_15: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_15 = 6
quietly gen byte _p24a_q9_15 = .
quietly replace _p24a_q9_15 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_15 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_15 = 2 if formdef_version == 2512090157 & _p24a_q9_15 == 0 & (missing(q9_15))
quietly replace _p24_q9_15 = 4 if formdef_version == 2512090157 & _p24a_q9_15 == 1 & (missing(q9_15))
quietly replace _p24_q9_15 = 1 if formdef_version == 2512090157 & _p24a_q9_15 == 1 & (q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
quietly replace _p24a_q9_15 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_15 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_15 = 2 if formdef_version == 2512091719 & _p24a_q9_15 == 0 & (missing(q9_15))
quietly replace _p24_q9_15 = 4 if formdef_version == 2512091719 & _p24a_q9_15 == 1 & (missing(q9_15))
quietly replace _p24_q9_15 = 1 if formdef_version == 2512091719 & _p24a_q9_15 == 1 & (q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
quietly replace _p24a_q9_15 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_15 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_15 = 2 if formdef_version == 2512111044 & _p24a_q9_15 == 0 & (missing(q9_15))
quietly replace _p24_q9_15 = 4 if formdef_version == 2512111044 & _p24a_q9_15 == 1 & (missing(q9_15))
quietly replace _p24_q9_15 = 1 if formdef_version == 2512111044 & _p24a_q9_15 == 1 & (q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
quietly replace _p24a_q9_15 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_15 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_15 = 2 if formdef_version == 2512121811 & _p24a_q9_15 == 0 & (missing(q9_15))
quietly replace _p24_q9_15 = 4 if formdef_version == 2512121811 & _p24a_q9_15 == 1 & (missing(q9_15))
quietly replace _p24_q9_15 = 1 if formdef_version == 2512121811 & _p24a_q9_15 == 1 & (q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
quietly replace _p24a_q9_15 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_15 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_15 = 2 if formdef_version == 2602120658 & _p24a_q9_15 == 0 & (missing(q9_15))
quietly replace _p24_q9_15 = 4 if formdef_version == 2602120658 & _p24a_q9_15 == 1 & (missing(q9_15))
quietly replace _p24_q9_15 = 1 if formdef_version == 2602120658 & _p24a_q9_15 == 1 & (q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_15 == `state' 
        file write `out' "P2.03,q9_15,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_15 == 1 & !(missing(q9_15)) & !(q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
file write `out' "P2.04,q9_15,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_15 == 1 & !(missing(q9_15)) & !(q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
file write `out' "P2.04,q9_15,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_15 == 1 & !(missing(q9_15)) & !(q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
file write `out' "P2.04,q9_15,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_15 == 1 & !(missing(q9_15)) & !(q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
file write `out' "P2.04,q9_15,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_15 == 1 & !(missing(q9_15)) & !(q9_15 == 1 | q9_15 == 2 | q9_15 == 3 | q9_15 == 4 | q9_15 == 5)
file write `out' "P2.04,q9_15,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_16: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_16 = 6
quietly gen byte _p24a_q9_16 = .
quietly replace _p24a_q9_16 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_16 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_16 = 2 if formdef_version == 2512090157 & _p24a_q9_16 == 0 & (missing(q9_16))
quietly replace _p24_q9_16 = 4 if formdef_version == 2512090157 & _p24a_q9_16 == 1 & (missing(q9_16))
quietly replace _p24_q9_16 = 1 if formdef_version == 2512090157 & _p24a_q9_16 == 1 & (q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
quietly replace _p24_q9_16 = 5 if formdef_version == 2512090157 & _p24_q9_16 == 1 & (q9_16 == 98)
quietly count if formdef_version == 2512090157 & _p24_q9_16 == 5 & (q9_16 == 98)
file write `out' "P2.08,q9_16,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_16 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_16 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_16 = 2 if formdef_version == 2512091719 & _p24a_q9_16 == 0 & (missing(q9_16))
quietly replace _p24_q9_16 = 4 if formdef_version == 2512091719 & _p24a_q9_16 == 1 & (missing(q9_16))
quietly replace _p24_q9_16 = 1 if formdef_version == 2512091719 & _p24a_q9_16 == 1 & (q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
quietly replace _p24_q9_16 = 5 if formdef_version == 2512091719 & _p24_q9_16 == 1 & (q9_16 == 98)
quietly count if formdef_version == 2512091719 & _p24_q9_16 == 5 & (q9_16 == 98)
file write `out' "P2.08,q9_16,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_16 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_16 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_16 = 2 if formdef_version == 2512111044 & _p24a_q9_16 == 0 & (missing(q9_16))
quietly replace _p24_q9_16 = 4 if formdef_version == 2512111044 & _p24a_q9_16 == 1 & (missing(q9_16))
quietly replace _p24_q9_16 = 1 if formdef_version == 2512111044 & _p24a_q9_16 == 1 & (q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
quietly replace _p24_q9_16 = 5 if formdef_version == 2512111044 & _p24_q9_16 == 1 & (q9_16 == 98)
quietly count if formdef_version == 2512111044 & _p24_q9_16 == 5 & (q9_16 == 98)
file write `out' "P2.08,q9_16,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_16 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_16 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_16 = 2 if formdef_version == 2512121811 & _p24a_q9_16 == 0 & (missing(q9_16))
quietly replace _p24_q9_16 = 4 if formdef_version == 2512121811 & _p24a_q9_16 == 1 & (missing(q9_16))
quietly replace _p24_q9_16 = 1 if formdef_version == 2512121811 & _p24a_q9_16 == 1 & (q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
quietly replace _p24_q9_16 = 5 if formdef_version == 2512121811 & _p24_q9_16 == 1 & (q9_16 == 98)
quietly count if formdef_version == 2512121811 & _p24_q9_16 == 5 & (q9_16 == 98)
file write `out' "P2.08,q9_16,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_16 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_16 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_16 = 2 if formdef_version == 2602120658 & _p24a_q9_16 == 0 & (missing(q9_16))
quietly replace _p24_q9_16 = 4 if formdef_version == 2602120658 & _p24a_q9_16 == 1 & (missing(q9_16))
quietly replace _p24_q9_16 = 1 if formdef_version == 2602120658 & _p24a_q9_16 == 1 & (q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
quietly replace _p24_q9_16 = 5 if formdef_version == 2602120658 & _p24_q9_16 == 1 & (q9_16 == 98)
quietly count if formdef_version == 2602120658 & _p24_q9_16 == 5 & (q9_16 == 98)
file write `out' "P2.08,q9_16,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_16 == `state' 
        file write `out' "P2.03,q9_16,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_16 == 1 & !(missing(q9_16)) & !(q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
file write `out' "P2.04,q9_16,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_16 == 1 & !(missing(q9_16)) & !(q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
file write `out' "P2.04,q9_16,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_16 == 1 & !(missing(q9_16)) & !(q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
file write `out' "P2.04,q9_16,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_16 == 1 & !(missing(q9_16)) & !(q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
file write `out' "P2.04,q9_16,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_16 == 1 & !(missing(q9_16)) & !(q9_16 == 0 | q9_16 == 1 | q9_16 == 98)
file write `out' "P2.04,q9_16,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_17: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_17 = 6
quietly gen byte _p24a_q9_17 = .
quietly replace _p24a_q9_17 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_17 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_17 = 2 if formdef_version == 2512090157 & _p24a_q9_17 == 0 & (strtrim(q9_17) == "")
quietly replace _p24_q9_17 = 4 if formdef_version == 2512090157 & _p24a_q9_17 == 1 & (strtrim(q9_17) == "")
quietly replace _p24_q9_17 = 1 if formdef_version == 2512090157 & _p24a_q9_17 == 1 & (regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
quietly replace _p24_q9_17 = 6 if formdef_version == 2512090157 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 6 if formdef_version == 2512090157 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 5 if formdef_version == 2512090157 & _p24_q9_17 == 1 & (strtrim(q9_17) == "98")
quietly count if formdef_version == 2512090157 & _p24_q9_17 == 5 & (strtrim(q9_17) == "98")
file write `out' "P2.08,q9_17,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_17 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_17 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_17 = 2 if formdef_version == 2512091719 & _p24a_q9_17 == 0 & (strtrim(q9_17) == "")
quietly replace _p24_q9_17 = 4 if formdef_version == 2512091719 & _p24a_q9_17 == 1 & (strtrim(q9_17) == "")
quietly replace _p24_q9_17 = 1 if formdef_version == 2512091719 & _p24a_q9_17 == 1 & (regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
quietly replace _p24_q9_17 = 6 if formdef_version == 2512091719 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 6 if formdef_version == 2512091719 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 6 if formdef_version == 2512091719 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 5 if formdef_version == 2512091719 & _p24_q9_17 == 1 & (strtrim(q9_17) == "98")
quietly count if formdef_version == 2512091719 & _p24_q9_17 == 5 & (strtrim(q9_17) == "98")
file write `out' "P2.08,q9_17,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_17 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_17 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_17 = 2 if formdef_version == 2512111044 & _p24a_q9_17 == 0 & (strtrim(q9_17) == "")
quietly replace _p24_q9_17 = 4 if formdef_version == 2512111044 & _p24a_q9_17 == 1 & (strtrim(q9_17) == "")
quietly replace _p24_q9_17 = 1 if formdef_version == 2512111044 & _p24a_q9_17 == 1 & (regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
quietly replace _p24_q9_17 = 6 if formdef_version == 2512111044 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 6 if formdef_version == 2512111044 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 6 if formdef_version == 2512111044 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 5 if formdef_version == 2512111044 & _p24_q9_17 == 1 & (strtrim(q9_17) == "98")
quietly count if formdef_version == 2512111044 & _p24_q9_17 == 5 & (strtrim(q9_17) == "98")
file write `out' "P2.08,q9_17,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_17 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_17 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_17 = 2 if formdef_version == 2512121811 & _p24a_q9_17 == 0 & (strtrim(q9_17) == "")
quietly replace _p24_q9_17 = 4 if formdef_version == 2512121811 & _p24a_q9_17 == 1 & (strtrim(q9_17) == "")
quietly replace _p24_q9_17 = 1 if formdef_version == 2512121811 & _p24a_q9_17 == 1 & (regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
quietly replace _p24_q9_17 = 6 if formdef_version == 2512121811 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 6 if formdef_version == 2512121811 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 6 if formdef_version == 2512121811 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 5 if formdef_version == 2512121811 & _p24_q9_17 == 1 & (strtrim(q9_17) == "98")
quietly count if formdef_version == 2512121811 & _p24_q9_17 == 5 & (strtrim(q9_17) == "98")
file write `out' "P2.08,q9_17,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_17 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_17 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_17 = 2 if formdef_version == 2602120658 & _p24a_q9_17 == 0 & (strtrim(q9_17) == "")
quietly replace _p24_q9_17 = 4 if formdef_version == 2602120658 & _p24a_q9_17 == 1 & (strtrim(q9_17) == "")
quietly replace _p24_q9_17 = 1 if formdef_version == 2602120658 & _p24a_q9_17 == 1 & (regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
quietly replace _p24_q9_17 = 6 if formdef_version == 2602120658 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 6 if formdef_version == 2602120658 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 6 if formdef_version == 2602120658 & _p24_q9_17 == 1 & (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0) & wordcount(q9_17) > 1
quietly replace _p24_q9_17 = 5 if formdef_version == 2602120658 & _p24_q9_17 == 1 & (strtrim(q9_17) == "98")
quietly count if formdef_version == 2602120658 & _p24_q9_17 == 5 & (strtrim(q9_17) == "98")
file write `out' "P2.08,q9_17,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_17 == `state' 
        file write `out' "P2.03,q9_17,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_17 == 1 & !(strtrim(q9_17) == "") & !(regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q9_17,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_17 == 1 & !(strtrim(q9_17) == "") & !(regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q9_17,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_17 == 1 & !(strtrim(q9_17) == "") & !(regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q9_17,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_17 == 1 & !(strtrim(q9_17) == "") & !(regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q9_17,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_17 == 1 & !(strtrim(q9_17) == "") & !(regexm(itrim(strtrim(q9_17)), "^(1|2|3|4|5|98)( (1|2|3|4|5|98))*$") & wordcount(q9_17) == ((strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0)))
file write `out' "P2.04,q9_17,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_18: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_18 = 6
quietly gen byte _p24a_q9_18 = .
quietly replace _p24a_q9_18 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_18 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_18 = 2 if formdef_version == 2512090157 & _p24a_q9_18 == 0 & (missing(q9_18))
quietly replace _p24_q9_18 = 4 if formdef_version == 2512090157 & _p24a_q9_18 == 1 & (missing(q9_18))
quietly replace _p24_q9_18 = 1 if formdef_version == 2512090157 & _p24a_q9_18 == 1 & (q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
quietly replace _p24a_q9_18 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_18 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_18 = 2 if formdef_version == 2512091719 & _p24a_q9_18 == 0 & (missing(q9_18))
quietly replace _p24_q9_18 = 4 if formdef_version == 2512091719 & _p24a_q9_18 == 1 & (missing(q9_18))
quietly replace _p24_q9_18 = 1 if formdef_version == 2512091719 & _p24a_q9_18 == 1 & (q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
quietly replace _p24a_q9_18 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_18 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_18 = 2 if formdef_version == 2512111044 & _p24a_q9_18 == 0 & (missing(q9_18))
quietly replace _p24_q9_18 = 4 if formdef_version == 2512111044 & _p24a_q9_18 == 1 & (missing(q9_18))
quietly replace _p24_q9_18 = 1 if formdef_version == 2512111044 & _p24a_q9_18 == 1 & (q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
quietly replace _p24a_q9_18 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_18 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_18 = 2 if formdef_version == 2512121811 & _p24a_q9_18 == 0 & (missing(q9_18))
quietly replace _p24_q9_18 = 4 if formdef_version == 2512121811 & _p24a_q9_18 == 1 & (missing(q9_18))
quietly replace _p24_q9_18 = 1 if formdef_version == 2512121811 & _p24a_q9_18 == 1 & (q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
quietly replace _p24a_q9_18 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_18 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_18 = 2 if formdef_version == 2602120658 & _p24a_q9_18 == 0 & (missing(q9_18))
quietly replace _p24_q9_18 = 4 if formdef_version == 2602120658 & _p24a_q9_18 == 1 & (missing(q9_18))
quietly replace _p24_q9_18 = 1 if formdef_version == 2602120658 & _p24a_q9_18 == 1 & (q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_18 == `state' 
        file write `out' "P2.03,q9_18,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_18 == 1 & !(missing(q9_18)) & !(q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
file write `out' "P2.04,q9_18,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_18 == 1 & !(missing(q9_18)) & !(q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
file write `out' "P2.04,q9_18,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_18 == 1 & !(missing(q9_18)) & !(q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
file write `out' "P2.04,q9_18,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_18 == 1 & !(missing(q9_18)) & !(q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
file write `out' "P2.04,q9_18,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_18 == 1 & !(missing(q9_18)) & !(q9_18 == 1 | q9_18 == 2 | q9_18 == 3 | q9_18 == 4 | q9_18 == 5)
file write `out' "P2.04,q9_18,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_19: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_19 = 6
quietly gen byte _p24a_q9_19 = .
quietly replace _p24a_q9_19 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_19 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_19 = 2 if formdef_version == 2512090157 & _p24a_q9_19 == 0 & (missing(q9_19))
quietly replace _p24_q9_19 = 4 if formdef_version == 2512090157 & _p24a_q9_19 == 1 & (missing(q9_19))
quietly replace _p24_q9_19 = 1 if formdef_version == 2512090157 & _p24a_q9_19 == 1 & (q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
quietly replace _p24_q9_19 = 5 if formdef_version == 2512090157 & _p24_q9_19 == 1 & (q9_19 == 98)
quietly count if formdef_version == 2512090157 & _p24_q9_19 == 5 & (q9_19 == 98)
file write `out' "P2.08,q9_19,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_19 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_19 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_19 = 2 if formdef_version == 2512091719 & _p24a_q9_19 == 0 & (missing(q9_19))
quietly replace _p24_q9_19 = 4 if formdef_version == 2512091719 & _p24a_q9_19 == 1 & (missing(q9_19))
quietly replace _p24_q9_19 = 1 if formdef_version == 2512091719 & _p24a_q9_19 == 1 & (q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
quietly replace _p24_q9_19 = 5 if formdef_version == 2512091719 & _p24_q9_19 == 1 & (q9_19 == 98)
quietly count if formdef_version == 2512091719 & _p24_q9_19 == 5 & (q9_19 == 98)
file write `out' "P2.08,q9_19,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_19 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_19 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_19 = 2 if formdef_version == 2512111044 & _p24a_q9_19 == 0 & (missing(q9_19))
quietly replace _p24_q9_19 = 4 if formdef_version == 2512111044 & _p24a_q9_19 == 1 & (missing(q9_19))
quietly replace _p24_q9_19 = 1 if formdef_version == 2512111044 & _p24a_q9_19 == 1 & (q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
quietly replace _p24_q9_19 = 5 if formdef_version == 2512111044 & _p24_q9_19 == 1 & (q9_19 == 98)
quietly count if formdef_version == 2512111044 & _p24_q9_19 == 5 & (q9_19 == 98)
file write `out' "P2.08,q9_19,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_19 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_19 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_19 = 2 if formdef_version == 2512121811 & _p24a_q9_19 == 0 & (missing(q9_19))
quietly replace _p24_q9_19 = 4 if formdef_version == 2512121811 & _p24a_q9_19 == 1 & (missing(q9_19))
quietly replace _p24_q9_19 = 1 if formdef_version == 2512121811 & _p24a_q9_19 == 1 & (q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
quietly replace _p24_q9_19 = 5 if formdef_version == 2512121811 & _p24_q9_19 == 1 & (q9_19 == 98)
quietly count if formdef_version == 2512121811 & _p24_q9_19 == 5 & (q9_19 == 98)
file write `out' "P2.08,q9_19,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_19 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_19 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_19 = 2 if formdef_version == 2602120658 & _p24a_q9_19 == 0 & (missing(q9_19))
quietly replace _p24_q9_19 = 4 if formdef_version == 2602120658 & _p24a_q9_19 == 1 & (missing(q9_19))
quietly replace _p24_q9_19 = 1 if formdef_version == 2602120658 & _p24a_q9_19 == 1 & (q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
quietly replace _p24_q9_19 = 5 if formdef_version == 2602120658 & _p24_q9_19 == 1 & (q9_19 == 98)
quietly count if formdef_version == 2602120658 & _p24_q9_19 == 5 & (q9_19 == 98)
file write `out' "P2.08,q9_19,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_19 == `state' 
        file write `out' "P2.03,q9_19,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_19 == 1 & !(missing(q9_19)) & !(q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
file write `out' "P2.04,q9_19,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_19 == 1 & !(missing(q9_19)) & !(q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
file write `out' "P2.04,q9_19,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_19 == 1 & !(missing(q9_19)) & !(q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
file write `out' "P2.04,q9_19,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_19 == 1 & !(missing(q9_19)) & !(q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
file write `out' "P2.04,q9_19,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_19 == 1 & !(missing(q9_19)) & !(q9_19 == 1 | q9_19 == 2 | q9_19 == 3 | q9_19 == 98)
file write `out' "P2.04,q9_19,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_20: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_20 = 6
quietly gen byte _p24a_q9_20 = .
quietly replace _p24a_q9_20 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_20 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_20 = 2 if formdef_version == 2512090157 & _p24a_q9_20 == 0 & (missing(q9_20))
quietly replace _p24_q9_20 = 4 if formdef_version == 2512090157 & _p24a_q9_20 == 1 & (missing(q9_20))
quietly replace _p24_q9_20 = 1 if formdef_version == 2512090157 & _p24a_q9_20 == 1 & (q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
quietly replace _p24_q9_20 = 5 if formdef_version == 2512090157 & _p24_q9_20 == 1 & (q9_20 == 98)
quietly count if formdef_version == 2512090157 & _p24_q9_20 == 5 & (q9_20 == 98)
file write `out' "P2.08,q9_20,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_20 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_20 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_20 = 2 if formdef_version == 2512091719 & _p24a_q9_20 == 0 & (missing(q9_20))
quietly replace _p24_q9_20 = 4 if formdef_version == 2512091719 & _p24a_q9_20 == 1 & (missing(q9_20))
quietly replace _p24_q9_20 = 1 if formdef_version == 2512091719 & _p24a_q9_20 == 1 & (q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
quietly replace _p24_q9_20 = 5 if formdef_version == 2512091719 & _p24_q9_20 == 1 & (q9_20 == 98)
quietly count if formdef_version == 2512091719 & _p24_q9_20 == 5 & (q9_20 == 98)
file write `out' "P2.08,q9_20,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_20 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_20 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_20 = 2 if formdef_version == 2512111044 & _p24a_q9_20 == 0 & (missing(q9_20))
quietly replace _p24_q9_20 = 4 if formdef_version == 2512111044 & _p24a_q9_20 == 1 & (missing(q9_20))
quietly replace _p24_q9_20 = 1 if formdef_version == 2512111044 & _p24a_q9_20 == 1 & (q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
quietly replace _p24_q9_20 = 5 if formdef_version == 2512111044 & _p24_q9_20 == 1 & (q9_20 == 98)
quietly count if formdef_version == 2512111044 & _p24_q9_20 == 5 & (q9_20 == 98)
file write `out' "P2.08,q9_20,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_20 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_20 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_20 = 2 if formdef_version == 2512121811 & _p24a_q9_20 == 0 & (missing(q9_20))
quietly replace _p24_q9_20 = 4 if formdef_version == 2512121811 & _p24a_q9_20 == 1 & (missing(q9_20))
quietly replace _p24_q9_20 = 1 if formdef_version == 2512121811 & _p24a_q9_20 == 1 & (q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
quietly replace _p24_q9_20 = 5 if formdef_version == 2512121811 & _p24_q9_20 == 1 & (q9_20 == 98)
quietly count if formdef_version == 2512121811 & _p24_q9_20 == 5 & (q9_20 == 98)
file write `out' "P2.08,q9_20,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_20 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_20 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_20 = 2 if formdef_version == 2602120658 & _p24a_q9_20 == 0 & (missing(q9_20))
quietly replace _p24_q9_20 = 4 if formdef_version == 2602120658 & _p24a_q9_20 == 1 & (missing(q9_20))
quietly replace _p24_q9_20 = 1 if formdef_version == 2602120658 & _p24a_q9_20 == 1 & (q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
quietly replace _p24_q9_20 = 5 if formdef_version == 2602120658 & _p24_q9_20 == 1 & (q9_20 == 98)
quietly count if formdef_version == 2602120658 & _p24_q9_20 == 5 & (q9_20 == 98)
file write `out' "P2.08,q9_20,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_20 == `state' 
        file write `out' "P2.03,q9_20,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_20 == 1 & !(missing(q9_20)) & !(q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
file write `out' "P2.04,q9_20,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_20 == 1 & !(missing(q9_20)) & !(q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
file write `out' "P2.04,q9_20,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_20 == 1 & !(missing(q9_20)) & !(q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
file write `out' "P2.04,q9_20,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_20 == 1 & !(missing(q9_20)) & !(q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
file write `out' "P2.04,q9_20,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_20 == 1 & !(missing(q9_20)) & !(q9_20 == 0 | q9_20 == 1 | q9_20 == 98)
file write `out' "P2.04,q9_20,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_21: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_21 = 6
quietly gen byte _p24a_q9_21 = .
quietly replace _p24a_q9_21 = 1 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & (q9_20 == 1)))
quietly replace _p24a_q9_21 = 0 if formdef_version == 2512090157 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & !(q9_20 == 1)))
quietly replace _p24_q9_21 = 2 if formdef_version == 2512090157 & _p24a_q9_21 == 0 & (strtrim(q9_21) == "")
quietly replace _p24_q9_21 = 4 if formdef_version == 2512090157 & _p24a_q9_21 == 1 & (strtrim(q9_21) == "")
quietly replace _p24_q9_21 = 1 if formdef_version == 2512090157 & _p24a_q9_21 == 1 & (regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
quietly replace _p24a_q9_21 = 1 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & (q9_20 == 1)))
quietly replace _p24a_q9_21 = 0 if formdef_version == 2512091719 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & !(q9_20 == 1)))
quietly replace _p24_q9_21 = 2 if formdef_version == 2512091719 & _p24a_q9_21 == 0 & (strtrim(q9_21) == "")
quietly replace _p24_q9_21 = 4 if formdef_version == 2512091719 & _p24a_q9_21 == 1 & (strtrim(q9_21) == "")
quietly replace _p24_q9_21 = 1 if formdef_version == 2512091719 & _p24a_q9_21 == 1 & (regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
quietly replace _p24a_q9_21 = 1 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & (q9_20 == 1)))
quietly replace _p24a_q9_21 = 0 if formdef_version == 2512111044 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & !(q9_20 == 1)))
quietly replace _p24_q9_21 = 2 if formdef_version == 2512111044 & _p24a_q9_21 == 0 & (strtrim(q9_21) == "")
quietly replace _p24_q9_21 = 4 if formdef_version == 2512111044 & _p24a_q9_21 == 1 & (strtrim(q9_21) == "")
quietly replace _p24_q9_21 = 1 if formdef_version == 2512111044 & _p24a_q9_21 == 1 & (regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
quietly replace _p24a_q9_21 = 1 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & (q9_20 == 1)))
quietly replace _p24a_q9_21 = 0 if formdef_version == 2512121811 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & !(q9_20 == 1)))
quietly replace _p24_q9_21 = 2 if formdef_version == 2512121811 & _p24a_q9_21 == 0 & (strtrim(q9_21) == "")
quietly replace _p24_q9_21 = 4 if formdef_version == 2512121811 & _p24a_q9_21 == 1 & (strtrim(q9_21) == "")
quietly replace _p24_q9_21 = 1 if formdef_version == 2512121811 & _p24a_q9_21 == 1 & (regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
quietly replace _p24a_q9_21 = 1 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & (eligible_flag == 1)) & ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & (q9_20 == 1)))
quietly replace _p24a_q9_21 = 0 if formdef_version == 2602120658 & (((inlist(eligible_flag,0,1)) & !(eligible_flag == 1)) | ((q9_20 == 0 | q9_20 == 1 | q9_20 == 98) & !(q9_20 == 1)))
quietly replace _p24_q9_21 = 2 if formdef_version == 2602120658 & _p24a_q9_21 == 0 & (strtrim(q9_21) == "")
quietly replace _p24_q9_21 = 4 if formdef_version == 2602120658 & _p24a_q9_21 == 1 & (strtrim(q9_21) == "")
quietly replace _p24_q9_21 = 1 if formdef_version == 2602120658 & _p24a_q9_21 == 1 & (regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_21 == `state' 
        file write `out' "P2.03,q9_21,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_21 == 1 & !(strtrim(q9_21) == "") & !(regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
file write `out' "P2.04,q9_21,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_21 == 1 & !(strtrim(q9_21) == "") & !(regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
file write `out' "P2.04,q9_21,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_21 == 1 & !(strtrim(q9_21) == "") & !(regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
file write `out' "P2.04,q9_21,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_21 == 1 & !(strtrim(q9_21) == "") & !(regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
file write `out' "P2.04,q9_21,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_21 == 1 & !(strtrim(q9_21) == "") & !(regexm(itrim(strtrim(q9_21)), "^(1|2|3|4|5)( (1|2|3|4|5))*$") & wordcount(q9_21) == ((strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0)))
file write `out' "P2.04,q9_21,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_22: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_22 = 6
quietly gen byte _p24a_q9_22 = .
quietly replace _p24a_q9_22 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_22 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_22 = 2 if formdef_version == 2512090157 & _p24a_q9_22 == 0 & (missing(q9_22))
quietly replace _p24_q9_22 = 4 if formdef_version == 2512090157 & _p24a_q9_22 == 1 & (missing(q9_22))
quietly replace _p24_q9_22 = 1 if formdef_version == 2512090157 & _p24a_q9_22 == 1 & (q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
quietly replace _p24_q9_22 = 5 if formdef_version == 2512090157 & _p24_q9_22 == 1 & (q9_22 == 98)
quietly count if formdef_version == 2512090157 & _p24_q9_22 == 5 & (q9_22 == 98)
file write `out' "P2.08,q9_22,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_22 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_22 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_22 = 2 if formdef_version == 2512091719 & _p24a_q9_22 == 0 & (missing(q9_22))
quietly replace _p24_q9_22 = 4 if formdef_version == 2512091719 & _p24a_q9_22 == 1 & (missing(q9_22))
quietly replace _p24_q9_22 = 1 if formdef_version == 2512091719 & _p24a_q9_22 == 1 & (q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
quietly replace _p24_q9_22 = 5 if formdef_version == 2512091719 & _p24_q9_22 == 1 & (q9_22 == 98)
quietly count if formdef_version == 2512091719 & _p24_q9_22 == 5 & (q9_22 == 98)
file write `out' "P2.08,q9_22,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_22 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_22 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_22 = 2 if formdef_version == 2512111044 & _p24a_q9_22 == 0 & (missing(q9_22))
quietly replace _p24_q9_22 = 4 if formdef_version == 2512111044 & _p24a_q9_22 == 1 & (missing(q9_22))
quietly replace _p24_q9_22 = 1 if formdef_version == 2512111044 & _p24a_q9_22 == 1 & (q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
quietly replace _p24_q9_22 = 5 if formdef_version == 2512111044 & _p24_q9_22 == 1 & (q9_22 == 98)
quietly count if formdef_version == 2512111044 & _p24_q9_22 == 5 & (q9_22 == 98)
file write `out' "P2.08,q9_22,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_22 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_22 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_22 = 2 if formdef_version == 2512121811 & _p24a_q9_22 == 0 & (missing(q9_22))
quietly replace _p24_q9_22 = 4 if formdef_version == 2512121811 & _p24a_q9_22 == 1 & (missing(q9_22))
quietly replace _p24_q9_22 = 1 if formdef_version == 2512121811 & _p24a_q9_22 == 1 & (q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
quietly replace _p24_q9_22 = 5 if formdef_version == 2512121811 & _p24_q9_22 == 1 & (q9_22 == 98)
quietly count if formdef_version == 2512121811 & _p24_q9_22 == 5 & (q9_22 == 98)
file write `out' "P2.08,q9_22,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_22 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_22 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_22 = 2 if formdef_version == 2602120658 & _p24a_q9_22 == 0 & (missing(q9_22))
quietly replace _p24_q9_22 = 4 if formdef_version == 2602120658 & _p24a_q9_22 == 1 & (missing(q9_22))
quietly replace _p24_q9_22 = 1 if formdef_version == 2602120658 & _p24a_q9_22 == 1 & (q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
quietly replace _p24_q9_22 = 5 if formdef_version == 2602120658 & _p24_q9_22 == 1 & (q9_22 == 98)
quietly count if formdef_version == 2602120658 & _p24_q9_22 == 5 & (q9_22 == 98)
file write `out' "P2.08,q9_22,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_22 == `state' 
        file write `out' "P2.03,q9_22,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_22 == 1 & !(missing(q9_22)) & !(q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
file write `out' "P2.04,q9_22,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_22 == 1 & !(missing(q9_22)) & !(q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
file write `out' "P2.04,q9_22,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_22 == 1 & !(missing(q9_22)) & !(q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
file write `out' "P2.04,q9_22,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_22 == 1 & !(missing(q9_22)) & !(q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
file write `out' "P2.04,q9_22,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_22 == 1 & !(missing(q9_22)) & !(q9_22 == 1 | q9_22 == 2 | q9_22 == 3 | q9_22 == 4 | q9_22 == 98)
file write `out' "P2.04,q9_22,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_4: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_4 = 6
quietly gen byte _p24a_q9_4 = .
quietly replace _p24a_q9_4 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_4 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_4 = 2 if formdef_version == 2512090157 & _p24a_q9_4 == 0 & (missing(q9_4))
quietly replace _p24_q9_4 = 4 if formdef_version == 2512090157 & _p24a_q9_4 == 1 & (missing(q9_4))
quietly replace _p24_q9_4 = 1 if formdef_version == 2512090157 & _p24a_q9_4 == 1 & (q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
quietly replace _p24a_q9_4 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_4 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_4 = 2 if formdef_version == 2512091719 & _p24a_q9_4 == 0 & (missing(q9_4))
quietly replace _p24_q9_4 = 4 if formdef_version == 2512091719 & _p24a_q9_4 == 1 & (missing(q9_4))
quietly replace _p24_q9_4 = 1 if formdef_version == 2512091719 & _p24a_q9_4 == 1 & (q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
quietly replace _p24a_q9_4 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_4 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_4 = 2 if formdef_version == 2512111044 & _p24a_q9_4 == 0 & (missing(q9_4))
quietly replace _p24_q9_4 = 4 if formdef_version == 2512111044 & _p24a_q9_4 == 1 & (missing(q9_4))
quietly replace _p24_q9_4 = 1 if formdef_version == 2512111044 & _p24a_q9_4 == 1 & (q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
quietly replace _p24a_q9_4 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_4 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_4 = 2 if formdef_version == 2512121811 & _p24a_q9_4 == 0 & (missing(q9_4))
quietly replace _p24_q9_4 = 4 if formdef_version == 2512121811 & _p24a_q9_4 == 1 & (missing(q9_4))
quietly replace _p24_q9_4 = 1 if formdef_version == 2512121811 & _p24a_q9_4 == 1 & (q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
quietly replace _p24a_q9_4 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_4 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_4 = 2 if formdef_version == 2602120658 & _p24a_q9_4 == 0 & (missing(q9_4))
quietly replace _p24_q9_4 = 4 if formdef_version == 2602120658 & _p24a_q9_4 == 1 & (missing(q9_4))
quietly replace _p24_q9_4 = 1 if formdef_version == 2602120658 & _p24a_q9_4 == 1 & (q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_4 == `state' 
        file write `out' "P2.03,q9_4,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_4 == 1 & !(missing(q9_4)) & !(q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
file write `out' "P2.04,q9_4,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_4 == 1 & !(missing(q9_4)) & !(q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
file write `out' "P2.04,q9_4,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_4 == 1 & !(missing(q9_4)) & !(q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
file write `out' "P2.04,q9_4,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_4 == 1 & !(missing(q9_4)) & !(q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
file write `out' "P2.04,q9_4,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_4 == 1 & !(missing(q9_4)) & !(q9_4 == 1 | q9_4 == 2 | q9_4 == 3 | q9_4 == 4 | q9_4 == 5)
file write `out' "P2.04,q9_4,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_5: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_5 = 6
quietly gen byte _p24a_q9_5 = .
quietly replace _p24a_q9_5 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_5 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_5 = 2 if formdef_version == 2512090157 & _p24a_q9_5 == 0 & (missing(q9_5))
quietly replace _p24_q9_5 = 4 if formdef_version == 2512090157 & _p24a_q9_5 == 1 & (missing(q9_5))
quietly replace _p24_q9_5 = 1 if formdef_version == 2512090157 & _p24a_q9_5 == 1 & (q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
quietly replace _p24_q9_5 = 5 if formdef_version == 2512090157 & _p24_q9_5 == 1 & (q9_5 == 98)
quietly count if formdef_version == 2512090157 & _p24_q9_5 == 5 & (q9_5 == 98)
file write `out' "P2.08,q9_5,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_5 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_5 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_5 = 2 if formdef_version == 2512091719 & _p24a_q9_5 == 0 & (missing(q9_5))
quietly replace _p24_q9_5 = 4 if formdef_version == 2512091719 & _p24a_q9_5 == 1 & (missing(q9_5))
quietly replace _p24_q9_5 = 1 if formdef_version == 2512091719 & _p24a_q9_5 == 1 & (q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
quietly replace _p24_q9_5 = 5 if formdef_version == 2512091719 & _p24_q9_5 == 1 & (q9_5 == 98)
quietly count if formdef_version == 2512091719 & _p24_q9_5 == 5 & (q9_5 == 98)
file write `out' "P2.08,q9_5,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_5 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_5 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_5 = 2 if formdef_version == 2512111044 & _p24a_q9_5 == 0 & (missing(q9_5))
quietly replace _p24_q9_5 = 4 if formdef_version == 2512111044 & _p24a_q9_5 == 1 & (missing(q9_5))
quietly replace _p24_q9_5 = 1 if formdef_version == 2512111044 & _p24a_q9_5 == 1 & (q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
quietly replace _p24_q9_5 = 5 if formdef_version == 2512111044 & _p24_q9_5 == 1 & (q9_5 == 98)
quietly count if formdef_version == 2512111044 & _p24_q9_5 == 5 & (q9_5 == 98)
file write `out' "P2.08,q9_5,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_5 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_5 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_5 = 2 if formdef_version == 2512121811 & _p24a_q9_5 == 0 & (missing(q9_5))
quietly replace _p24_q9_5 = 4 if formdef_version == 2512121811 & _p24a_q9_5 == 1 & (missing(q9_5))
quietly replace _p24_q9_5 = 1 if formdef_version == 2512121811 & _p24a_q9_5 == 1 & (q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
quietly replace _p24_q9_5 = 5 if formdef_version == 2512121811 & _p24_q9_5 == 1 & (q9_5 == 98)
quietly count if formdef_version == 2512121811 & _p24_q9_5 == 5 & (q9_5 == 98)
file write `out' "P2.08,q9_5,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_5 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_5 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_5 = 2 if formdef_version == 2602120658 & _p24a_q9_5 == 0 & (missing(q9_5))
quietly replace _p24_q9_5 = 4 if formdef_version == 2602120658 & _p24a_q9_5 == 1 & (missing(q9_5))
quietly replace _p24_q9_5 = 1 if formdef_version == 2602120658 & _p24a_q9_5 == 1 & (q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
quietly replace _p24_q9_5 = 5 if formdef_version == 2602120658 & _p24_q9_5 == 1 & (q9_5 == 98)
quietly count if formdef_version == 2602120658 & _p24_q9_5 == 5 & (q9_5 == 98)
file write `out' "P2.08,q9_5,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_5 == `state' 
        file write `out' "P2.03,q9_5,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_5 == 1 & !(missing(q9_5)) & !(q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
file write `out' "P2.04,q9_5,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_5 == 1 & !(missing(q9_5)) & !(q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
file write `out' "P2.04,q9_5,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_5 == 1 & !(missing(q9_5)) & !(q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
file write `out' "P2.04,q9_5,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_5 == 1 & !(missing(q9_5)) & !(q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
file write `out' "P2.04,q9_5,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_5 == 1 & !(missing(q9_5)) & !(q9_5 == 1 | q9_5 == 2 | q9_5 == 3 | q9_5 == 4 | q9_5 == 5 | q9_5 == 98)
file write `out' "P2.04,q9_5,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_6: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_6 = 6
quietly gen byte _p24a_q9_6 = .
quietly replace _p24a_q9_6 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_6 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_6 = 2 if formdef_version == 2512090157 & _p24a_q9_6 == 0 & (missing(q9_6))
quietly replace _p24_q9_6 = 4 if formdef_version == 2512090157 & _p24a_q9_6 == 1 & (missing(q9_6))
quietly replace _p24_q9_6 = 1 if formdef_version == 2512090157 & _p24a_q9_6 == 1 & (q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
quietly replace _p24_q9_6 = 5 if formdef_version == 2512090157 & _p24_q9_6 == 1 & (q9_6 == 98)
quietly count if formdef_version == 2512090157 & _p24_q9_6 == 5 & (q9_6 == 98)
file write `out' "P2.08,q9_6,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_6 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_6 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_6 = 2 if formdef_version == 2512091719 & _p24a_q9_6 == 0 & (missing(q9_6))
quietly replace _p24_q9_6 = 4 if formdef_version == 2512091719 & _p24a_q9_6 == 1 & (missing(q9_6))
quietly replace _p24_q9_6 = 1 if formdef_version == 2512091719 & _p24a_q9_6 == 1 & (q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
quietly replace _p24_q9_6 = 5 if formdef_version == 2512091719 & _p24_q9_6 == 1 & (q9_6 == 98)
quietly count if formdef_version == 2512091719 & _p24_q9_6 == 5 & (q9_6 == 98)
file write `out' "P2.08,q9_6,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_6 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_6 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_6 = 2 if formdef_version == 2512111044 & _p24a_q9_6 == 0 & (missing(q9_6))
quietly replace _p24_q9_6 = 4 if formdef_version == 2512111044 & _p24a_q9_6 == 1 & (missing(q9_6))
quietly replace _p24_q9_6 = 1 if formdef_version == 2512111044 & _p24a_q9_6 == 1 & (q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
quietly replace _p24_q9_6 = 5 if formdef_version == 2512111044 & _p24_q9_6 == 1 & (q9_6 == 98)
quietly count if formdef_version == 2512111044 & _p24_q9_6 == 5 & (q9_6 == 98)
file write `out' "P2.08,q9_6,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_6 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_6 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_6 = 2 if formdef_version == 2512121811 & _p24a_q9_6 == 0 & (missing(q9_6))
quietly replace _p24_q9_6 = 4 if formdef_version == 2512121811 & _p24a_q9_6 == 1 & (missing(q9_6))
quietly replace _p24_q9_6 = 1 if formdef_version == 2512121811 & _p24a_q9_6 == 1 & (q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
quietly replace _p24_q9_6 = 5 if formdef_version == 2512121811 & _p24_q9_6 == 1 & (q9_6 == 98)
quietly count if formdef_version == 2512121811 & _p24_q9_6 == 5 & (q9_6 == 98)
file write `out' "P2.08,q9_6,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_6 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_6 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_6 = 2 if formdef_version == 2602120658 & _p24a_q9_6 == 0 & (missing(q9_6))
quietly replace _p24_q9_6 = 4 if formdef_version == 2602120658 & _p24a_q9_6 == 1 & (missing(q9_6))
quietly replace _p24_q9_6 = 1 if formdef_version == 2602120658 & _p24a_q9_6 == 1 & (q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
quietly replace _p24_q9_6 = 5 if formdef_version == 2602120658 & _p24_q9_6 == 1 & (q9_6 == 98)
quietly count if formdef_version == 2602120658 & _p24_q9_6 == 5 & (q9_6 == 98)
file write `out' "P2.08,q9_6,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_6 == `state' 
        file write `out' "P2.03,q9_6,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_6 == 1 & !(missing(q9_6)) & !(q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
file write `out' "P2.04,q9_6,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_6 == 1 & !(missing(q9_6)) & !(q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
file write `out' "P2.04,q9_6,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_6 == 1 & !(missing(q9_6)) & !(q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
file write `out' "P2.04,q9_6,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_6 == 1 & !(missing(q9_6)) & !(q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
file write `out' "P2.04,q9_6,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_6 == 1 & !(missing(q9_6)) & !(q9_6 == 1 | q9_6 == 2 | q9_6 == 3 | q9_6 == 98)
file write `out' "P2.04,q9_6,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_7: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_7 = 6
quietly gen byte _p24a_q9_7 = .
quietly replace _p24a_q9_7 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_7 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_7 = 2 if formdef_version == 2512090157 & _p24a_q9_7 == 0 & (missing(q9_7))
quietly replace _p24_q9_7 = 4 if formdef_version == 2512090157 & _p24a_q9_7 == 1 & (missing(q9_7))
quietly replace _p24_q9_7 = 1 if formdef_version == 2512090157 & _p24a_q9_7 == 1 & (q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
quietly replace _p24a_q9_7 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_7 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_7 = 2 if formdef_version == 2512091719 & _p24a_q9_7 == 0 & (missing(q9_7))
quietly replace _p24_q9_7 = 4 if formdef_version == 2512091719 & _p24a_q9_7 == 1 & (missing(q9_7))
quietly replace _p24_q9_7 = 1 if formdef_version == 2512091719 & _p24a_q9_7 == 1 & (q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
quietly replace _p24a_q9_7 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_7 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_7 = 2 if formdef_version == 2512111044 & _p24a_q9_7 == 0 & (missing(q9_7))
quietly replace _p24_q9_7 = 4 if formdef_version == 2512111044 & _p24a_q9_7 == 1 & (missing(q9_7))
quietly replace _p24_q9_7 = 1 if formdef_version == 2512111044 & _p24a_q9_7 == 1 & (q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
quietly replace _p24a_q9_7 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_7 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_7 = 2 if formdef_version == 2512121811 & _p24a_q9_7 == 0 & (missing(q9_7))
quietly replace _p24_q9_7 = 4 if formdef_version == 2512121811 & _p24a_q9_7 == 1 & (missing(q9_7))
quietly replace _p24_q9_7 = 1 if formdef_version == 2512121811 & _p24a_q9_7 == 1 & (q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
quietly replace _p24a_q9_7 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_7 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_7 = 2 if formdef_version == 2602120658 & _p24a_q9_7 == 0 & (missing(q9_7))
quietly replace _p24_q9_7 = 4 if formdef_version == 2602120658 & _p24a_q9_7 == 1 & (missing(q9_7))
quietly replace _p24_q9_7 = 1 if formdef_version == 2602120658 & _p24a_q9_7 == 1 & (q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_7 == `state' 
        file write `out' "P2.03,q9_7,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_7 == 1 & !(missing(q9_7)) & !(q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
file write `out' "P2.04,q9_7,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_7 == 1 & !(missing(q9_7)) & !(q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
file write `out' "P2.04,q9_7,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_7 == 1 & !(missing(q9_7)) & !(q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
file write `out' "P2.04,q9_7,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_7 == 1 & !(missing(q9_7)) & !(q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
file write `out' "P2.04,q9_7,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_7 == 1 & !(missing(q9_7)) & !(q9_7 == 1 | q9_7 == 2 | q9_7 == 3 | q9_7 == 4 | q9_7 == 5)
file write `out' "P2.04,q9_7,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_8: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_8 = 6
quietly gen byte _p24a_q9_8 = .
quietly replace _p24a_q9_8 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_8 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_8 = 2 if formdef_version == 2512090157 & _p24a_q9_8 == 0 & (missing(q9_8))
quietly replace _p24_q9_8 = 4 if formdef_version == 2512090157 & _p24a_q9_8 == 1 & (missing(q9_8))
quietly replace _p24_q9_8 = 1 if formdef_version == 2512090157 & _p24a_q9_8 == 1 & (q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
quietly replace _p24_q9_8 = 5 if formdef_version == 2512090157 & _p24_q9_8 == 1 & (q9_8 == 98)
quietly count if formdef_version == 2512090157 & _p24_q9_8 == 5 & (q9_8 == 98)
file write `out' "P2.08,q9_8,2512090157,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_8 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_8 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_8 = 2 if formdef_version == 2512091719 & _p24a_q9_8 == 0 & (missing(q9_8))
quietly replace _p24_q9_8 = 4 if formdef_version == 2512091719 & _p24a_q9_8 == 1 & (missing(q9_8))
quietly replace _p24_q9_8 = 1 if formdef_version == 2512091719 & _p24a_q9_8 == 1 & (q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
quietly replace _p24_q9_8 = 5 if formdef_version == 2512091719 & _p24_q9_8 == 1 & (q9_8 == 98)
quietly count if formdef_version == 2512091719 & _p24_q9_8 == 5 & (q9_8 == 98)
file write `out' "P2.08,q9_8,2512091719,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_8 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_8 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_8 = 2 if formdef_version == 2512111044 & _p24a_q9_8 == 0 & (missing(q9_8))
quietly replace _p24_q9_8 = 4 if formdef_version == 2512111044 & _p24a_q9_8 == 1 & (missing(q9_8))
quietly replace _p24_q9_8 = 1 if formdef_version == 2512111044 & _p24a_q9_8 == 1 & (q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
quietly replace _p24_q9_8 = 5 if formdef_version == 2512111044 & _p24_q9_8 == 1 & (q9_8 == 98)
quietly count if formdef_version == 2512111044 & _p24_q9_8 == 5 & (q9_8 == 98)
file write `out' "P2.08,q9_8,2512111044,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_8 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_8 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_8 = 2 if formdef_version == 2512121811 & _p24a_q9_8 == 0 & (missing(q9_8))
quietly replace _p24_q9_8 = 4 if formdef_version == 2512121811 & _p24a_q9_8 == 1 & (missing(q9_8))
quietly replace _p24_q9_8 = 1 if formdef_version == 2512121811 & _p24a_q9_8 == 1 & (q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
quietly replace _p24_q9_8 = 5 if formdef_version == 2512121811 & _p24_q9_8 == 1 & (q9_8 == 98)
quietly count if formdef_version == 2512121811 & _p24_q9_8 == 5 & (q9_8 == 98)
file write `out' "P2.08,q9_8,2512121811,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_8 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_8 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_8 = 2 if formdef_version == 2602120658 & _p24a_q9_8 == 0 & (missing(q9_8))
quietly replace _p24_q9_8 = 4 if formdef_version == 2602120658 & _p24a_q9_8 == 1 & (missing(q9_8))
quietly replace _p24_q9_8 = 1 if formdef_version == 2602120658 & _p24a_q9_8 == 1 & (q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
quietly replace _p24_q9_8 = 5 if formdef_version == 2602120658 & _p24_q9_8 == 1 & (q9_8 == 98)
quietly count if formdef_version == 2602120658 & _p24_q9_8 == 5 & (q9_8 == 98)
file write `out' "P2.08,q9_8,2602120658,sentinel,refusal,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_8 == `state' 
        file write `out' "P2.03,q9_8,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_8 == 1 & !(missing(q9_8)) & !(q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
file write `out' "P2.04,q9_8,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_8 == 1 & !(missing(q9_8)) & !(q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
file write `out' "P2.04,q9_8,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_8 == 1 & !(missing(q9_8)) & !(q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
file write `out' "P2.04,q9_8,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_8 == 1 & !(missing(q9_8)) & !(q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
file write `out' "P2.04,q9_8,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_8 == 1 & !(missing(q9_8)) & !(q9_8 == 0 | q9_8 == 1 | q9_8 == 98)
file write `out' "P2.04,q9_8,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
* q9_9: keep the six states exclusive; invalid or out-of-route answers stay unresolved.
quietly gen byte _p24_q9_9 = 6
quietly gen byte _p24a_q9_9 = .
quietly replace _p24a_q9_9 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_9 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_9 = 2 if formdef_version == 2512090157 & _p24a_q9_9 == 0 & (missing(q9_9))
quietly replace _p24_q9_9 = 4 if formdef_version == 2512090157 & _p24a_q9_9 == 1 & (missing(q9_9))
quietly replace _p24_q9_9 = 1 if formdef_version == 2512090157 & _p24a_q9_9 == 1 & (q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
quietly replace _p24_q9_9 = 5 if formdef_version == 2512090157 & _p24_q9_9 == 1 & (q9_9 == 98)
quietly count if formdef_version == 2512090157 & _p24_q9_9 == 5 & (q9_9 == 98)
file write `out' "P2.08,q9_9,2512090157,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_9 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_9 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_9 = 2 if formdef_version == 2512091719 & _p24a_q9_9 == 0 & (missing(q9_9))
quietly replace _p24_q9_9 = 4 if formdef_version == 2512091719 & _p24a_q9_9 == 1 & (missing(q9_9))
quietly replace _p24_q9_9 = 1 if formdef_version == 2512091719 & _p24a_q9_9 == 1 & (q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
quietly replace _p24_q9_9 = 5 if formdef_version == 2512091719 & _p24_q9_9 == 1 & (q9_9 == 98)
quietly count if formdef_version == 2512091719 & _p24_q9_9 == 5 & (q9_9 == 98)
file write `out' "P2.08,q9_9,2512091719,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_9 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_9 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_9 = 2 if formdef_version == 2512111044 & _p24a_q9_9 == 0 & (missing(q9_9))
quietly replace _p24_q9_9 = 4 if formdef_version == 2512111044 & _p24a_q9_9 == 1 & (missing(q9_9))
quietly replace _p24_q9_9 = 1 if formdef_version == 2512111044 & _p24a_q9_9 == 1 & (q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
quietly replace _p24_q9_9 = 5 if formdef_version == 2512111044 & _p24_q9_9 == 1 & (q9_9 == 98)
quietly count if formdef_version == 2512111044 & _p24_q9_9 == 5 & (q9_9 == 98)
file write `out' "P2.08,q9_9,2512111044,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_9 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_9 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_9 = 2 if formdef_version == 2512121811 & _p24a_q9_9 == 0 & (missing(q9_9))
quietly replace _p24_q9_9 = 4 if formdef_version == 2512121811 & _p24a_q9_9 == 1 & (missing(q9_9))
quietly replace _p24_q9_9 = 1 if formdef_version == 2512121811 & _p24a_q9_9 == 1 & (q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
quietly replace _p24_q9_9 = 5 if formdef_version == 2512121811 & _p24_q9_9 == 1 & (q9_9 == 98)
quietly count if formdef_version == 2512121811 & _p24_q9_9 == 5 & (q9_9 == 98)
file write `out' "P2.08,q9_9,2512121811,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
quietly replace _p24a_q9_9 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q9_9 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q9_9 = 2 if formdef_version == 2602120658 & _p24a_q9_9 == 0 & (missing(q9_9))
quietly replace _p24_q9_9 = 4 if formdef_version == 2602120658 & _p24a_q9_9 == 1 & (missing(q9_9))
quietly replace _p24_q9_9 = 1 if formdef_version == 2602120658 & _p24a_q9_9 == 1 & (q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
quietly replace _p24_q9_9 = 5 if formdef_version == 2602120658 & _p24_q9_9 == 1 & (q9_9 == 98)
quietly count if formdef_version == 2602120658 & _p24_q9_9 == 5 & (q9_9 == 98)
file write `out' "P2.08,q9_9,2602120658,sentinel,uncertainty,NA," (r(N)) ",NA,supported" _n
foreach fv in 2512090157 2512091719 2512111044 2512121811 2602120658 {
    quietly count if formdef_version == `fv'
    local checked = r(N)
    forvalues state = 1/6 {
        local meaning : word `state' of observed_valid structural_skip unavailable_in_version applicable_nonresponse sentinel unresolved
        quietly count if formdef_version == `fv' & _p24_q9_9 == `state' 
        file write `out' "P2.03,q9_9,`fv',`meaning',," (`checked') "," (r(N)) ",NA," (cond(`state'==6,"indeterminate","supported")) _n
    }
}
quietly count if formdef_version == 2512090157 & _p24a_q9_9 == 1 & !(missing(q9_9)) & !(q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
file write `out' "P2.04,q9_9,2512090157,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & _p24a_q9_9 == 1 & !(missing(q9_9)) & !(q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
file write `out' "P2.04,q9_9,2512091719,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & _p24a_q9_9 == 1 & !(missing(q9_9)) & !(q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
file write `out' "P2.04,q9_9,2512111044,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & _p24a_q9_9 == 1 & !(missing(q9_9)) & !(q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
file write `out' "P2.04,q9_9,2512121811,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & _p24a_q9_9 == 1 & !(missing(q9_9)) & !(q9_9 == 1 | q9_9 == 2 | q9_9 == 3 | q9_9 == 4 | q9_9 == 98)
file write `out' "P2.04,q9_9,2602120658,domain_violation,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q10_2 == 6 & _p24a_q10_2 == 1
file write `out' "P2.05,q10_2,,unresolved_parent,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q4_12 == 6 & _p24a_q4_12 == 1
file write `out' "P2.05,q4_12,,unresolved_parent,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q4_1 == 6 & _p24a_q4_1 == 1
file write `out' "P2.05,q4_1,,unresolved_parent,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q5_13 == 6 & _p24a_q5_13 == 1
file write `out' "P2.05,q5_13,,unresolved_parent,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q5_2 == 6 & _p24a_q5_2 == 1
file write `out' "P2.05,q5_2,,unresolved_parent,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q9_17 == 6 & _p24a_q9_17 == 1
file write `out' "P2.05,q9_17,,unresolved_parent,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q9_21 == 6 & _p24a_q9_21 == 1
file write `out' "P2.05,q9_21,,unresolved_parent,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & !missing(q10_2_1) & q10_2_1 != 0
file write `out' "P2.07,q10_2_1,2512090157,unavailable_option_conflict,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_1) | q10_2_1 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0))
file write `out' "P2.06,q10_2_1,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_1) | q10_2_1 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0))
file write `out' "P2.06,q10_2_1,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_1) | q10_2_1 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0))
file write `out' "P2.06,q10_2_1,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_1) | q10_2_1 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0))
file write `out' "P2.06,q10_2_1,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_10) | q10_2_10 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0))
file write `out' "P2.06,q10_2_10,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_10) | q10_2_10 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0))
file write `out' "P2.06,q10_2_10,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_10) | q10_2_10 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0))
file write `out' "P2.06,q10_2_10,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_10) | q10_2_10 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0))
file write `out' "P2.06,q10_2_10,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_10) | q10_2_10 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0))
file write `out' "P2.06,q10_2_10,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_11) | q10_2_11 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0))
file write `out' "P2.06,q10_2_11,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_11) | q10_2_11 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0))
file write `out' "P2.06,q10_2_11,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_11) | q10_2_11 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0))
file write `out' "P2.06,q10_2_11,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_11) | q10_2_11 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0))
file write `out' "P2.06,q10_2_11,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_11) | q10_2_11 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0))
file write `out' "P2.06,q10_2_11,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_12) | q10_2_12 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0))
file write `out' "P2.06,q10_2_12,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_12) | q10_2_12 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0))
file write `out' "P2.06,q10_2_12,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_12) | q10_2_12 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0))
file write `out' "P2.06,q10_2_12,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_12) | q10_2_12 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0))
file write `out' "P2.06,q10_2_12,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_12) | q10_2_12 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0))
file write `out' "P2.06,q10_2_12,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_14) | q10_2_14 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0))
file write `out' "P2.06,q10_2_14,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_14) | q10_2_14 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0))
file write `out' "P2.06,q10_2_14,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_14) | q10_2_14 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0))
file write `out' "P2.06,q10_2_14,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_14) | q10_2_14 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0))
file write `out' "P2.06,q10_2_14,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_14) | q10_2_14 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0))
file write `out' "P2.06,q10_2_14,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_15) | q10_2_15 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0))
file write `out' "P2.06,q10_2_15,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_15) | q10_2_15 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0))
file write `out' "P2.06,q10_2_15,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_15) | q10_2_15 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0))
file write `out' "P2.06,q10_2_15,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_15) | q10_2_15 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0))
file write `out' "P2.06,q10_2_15,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_15) | q10_2_15 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0))
file write `out' "P2.06,q10_2_15,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_16) | q10_2_16 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0))
file write `out' "P2.06,q10_2_16,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_16) | q10_2_16 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0))
file write `out' "P2.06,q10_2_16,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_16) | q10_2_16 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0))
file write `out' "P2.06,q10_2_16,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_16) | q10_2_16 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0))
file write `out' "P2.06,q10_2_16,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_16) | q10_2_16 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0))
file write `out' "P2.06,q10_2_16,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_2) | q10_2_2 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0))
file write `out' "P2.06,q10_2_2,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_2) | q10_2_2 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0))
file write `out' "P2.06,q10_2_2,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_2) | q10_2_2 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0))
file write `out' "P2.06,q10_2_2,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_2) | q10_2_2 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0))
file write `out' "P2.06,q10_2_2,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_2) | q10_2_2 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0))
file write `out' "P2.06,q10_2_2,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_3) | q10_2_3 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0))
file write `out' "P2.06,q10_2_3,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_3) | q10_2_3 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0))
file write `out' "P2.06,q10_2_3,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_3) | q10_2_3 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0))
file write `out' "P2.06,q10_2_3,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_3) | q10_2_3 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0))
file write `out' "P2.06,q10_2_3,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_3) | q10_2_3 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0))
file write `out' "P2.06,q10_2_3,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_4) | q10_2_4 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0))
file write `out' "P2.06,q10_2_4,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_4) | q10_2_4 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0))
file write `out' "P2.06,q10_2_4,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_4) | q10_2_4 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0))
file write `out' "P2.06,q10_2_4,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_4) | q10_2_4 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0))
file write `out' "P2.06,q10_2_4,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_4) | q10_2_4 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0))
file write `out' "P2.06,q10_2_4,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_5) | q10_2_5 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0))
file write `out' "P2.06,q10_2_5,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_5) | q10_2_5 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0))
file write `out' "P2.06,q10_2_5,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_5) | q10_2_5 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0))
file write `out' "P2.06,q10_2_5,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_5) | q10_2_5 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0))
file write `out' "P2.06,q10_2_5,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_5) | q10_2_5 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0))
file write `out' "P2.06,q10_2_5,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_6) | q10_2_6 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0))
file write `out' "P2.06,q10_2_6,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_6) | q10_2_6 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0))
file write `out' "P2.06,q10_2_6,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_6) | q10_2_6 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0))
file write `out' "P2.06,q10_2_6,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_6) | q10_2_6 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0))
file write `out' "P2.06,q10_2_6,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_6) | q10_2_6 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0))
file write `out' "P2.06,q10_2_6,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_7) | q10_2_7 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0))
file write `out' "P2.06,q10_2_7,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_7) | q10_2_7 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0))
file write `out' "P2.06,q10_2_7,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_7) | q10_2_7 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0))
file write `out' "P2.06,q10_2_7,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_7) | q10_2_7 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0))
file write `out' "P2.06,q10_2_7,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_7) | q10_2_7 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0))
file write `out' "P2.06,q10_2_7,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_8) | q10_2_8 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0))
file write `out' "P2.06,q10_2_8,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_8) | q10_2_8 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0))
file write `out' "P2.06,q10_2_8,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_8) | q10_2_8 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0))
file write `out' "P2.06,q10_2_8,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_8) | q10_2_8 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0))
file write `out' "P2.06,q10_2_8,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_8) | q10_2_8 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0))
file write `out' "P2.06,q10_2_8,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_9) | q10_2_9 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0))
file write `out' "P2.06,q10_2_9,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_9) | q10_2_9 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0))
file write `out' "P2.06,q10_2_9,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_9) | q10_2_9 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0))
file write `out' "P2.06,q10_2_9,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_9) | q10_2_9 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0))
file write `out' "P2.06,q10_2_9,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_9) | q10_2_9 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0))
file write `out' "P2.06,q10_2_9,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q10_2,1,5) & (missing(q10_2_98) | q10_2_98 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0))
file write `out' "P2.06,q10_2_98,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q10_2,1,5) & (missing(q10_2_98) | q10_2_98 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0))
file write `out' "P2.06,q10_2_98,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q10_2,1,5) & (missing(q10_2_98) | q10_2_98 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0))
file write `out' "P2.06,q10_2_98,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q10_2,1,5) & (missing(q10_2_98) | q10_2_98 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0))
file write `out' "P2.06,q10_2_98,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q10_2,1,5) & (missing(q10_2_98) | q10_2_98 != (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0))
file write `out' "P2.06,q10_2_98,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_12,1,5) & (missing(q4_12_1) | q4_12_1 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0))
file write `out' "P2.06,q4_12_1,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_12,1,5) & (missing(q4_12_1) | q4_12_1 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0))
file write `out' "P2.06,q4_12_1,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_12,1,5) & (missing(q4_12_1) | q4_12_1 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0))
file write `out' "P2.06,q4_12_1,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_12,1,5) & (missing(q4_12_1) | q4_12_1 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0))
file write `out' "P2.06,q4_12_1,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_12,1,5) & (missing(q4_12_1) | q4_12_1 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0))
file write `out' "P2.06,q4_12_1,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_12,1,5) & (missing(q4_12_2) | q4_12_2 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0))
file write `out' "P2.06,q4_12_2,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_12,1,5) & (missing(q4_12_2) | q4_12_2 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0))
file write `out' "P2.06,q4_12_2,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_12,1,5) & (missing(q4_12_2) | q4_12_2 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0))
file write `out' "P2.06,q4_12_2,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_12,1,5) & (missing(q4_12_2) | q4_12_2 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0))
file write `out' "P2.06,q4_12_2,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_12,1,5) & (missing(q4_12_2) | q4_12_2 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0))
file write `out' "P2.06,q4_12_2,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_12,1,5) & (missing(q4_12_3) | q4_12_3 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0))
file write `out' "P2.06,q4_12_3,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_12,1,5) & (missing(q4_12_3) | q4_12_3 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0))
file write `out' "P2.06,q4_12_3,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_12,1,5) & (missing(q4_12_3) | q4_12_3 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0))
file write `out' "P2.06,q4_12_3,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_12,1,5) & (missing(q4_12_3) | q4_12_3 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0))
file write `out' "P2.06,q4_12_3,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_12,1,5) & (missing(q4_12_3) | q4_12_3 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0))
file write `out' "P2.06,q4_12_3,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_12,1,5) & (missing(q4_12_4) | q4_12_4 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))
file write `out' "P2.06,q4_12_4,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_12,1,5) & (missing(q4_12_4) | q4_12_4 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))
file write `out' "P2.06,q4_12_4,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_12,1,5) & (missing(q4_12_4) | q4_12_4 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))
file write `out' "P2.06,q4_12_4,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_12,1,5) & (missing(q4_12_4) | q4_12_4 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))
file write `out' "P2.06,q4_12_4,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_12,1,5) & (missing(q4_12_4) | q4_12_4 != (strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0))
file write `out' "P2.06,q4_12_4,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_1,1,5) & (missing(q4_1_1) | q4_1_1 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0))
file write `out' "P2.06,q4_1_1,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_1,1,5) & (missing(q4_1_1) | q4_1_1 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0))
file write `out' "P2.06,q4_1_1,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_1,1,5) & (missing(q4_1_1) | q4_1_1 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0))
file write `out' "P2.06,q4_1_1,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_1,1,5) & (missing(q4_1_1) | q4_1_1 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0))
file write `out' "P2.06,q4_1_1,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_1,1,5) & (missing(q4_1_1) | q4_1_1 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 1 ") > 0))
file write `out' "P2.06,q4_1_1,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_1,1,5) & (missing(q4_1_2) | q4_1_2 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0))
file write `out' "P2.06,q4_1_2,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_1,1,5) & (missing(q4_1_2) | q4_1_2 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0))
file write `out' "P2.06,q4_1_2,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_1,1,5) & (missing(q4_1_2) | q4_1_2 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0))
file write `out' "P2.06,q4_1_2,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_1,1,5) & (missing(q4_1_2) | q4_1_2 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0))
file write `out' "P2.06,q4_1_2,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_1,1,5) & (missing(q4_1_2) | q4_1_2 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 2 ") > 0))
file write `out' "P2.06,q4_1_2,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_1,1,5) & (missing(q4_1_3) | q4_1_3 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0))
file write `out' "P2.06,q4_1_3,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_1,1,5) & (missing(q4_1_3) | q4_1_3 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0))
file write `out' "P2.06,q4_1_3,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_1,1,5) & (missing(q4_1_3) | q4_1_3 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0))
file write `out' "P2.06,q4_1_3,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_1,1,5) & (missing(q4_1_3) | q4_1_3 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0))
file write `out' "P2.06,q4_1_3,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_1,1,5) & (missing(q4_1_3) | q4_1_3 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 3 ") > 0))
file write `out' "P2.06,q4_1_3,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_1,1,5) & (missing(q4_1_4) | q4_1_4 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0))
file write `out' "P2.06,q4_1_4,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_1,1,5) & (missing(q4_1_4) | q4_1_4 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0))
file write `out' "P2.06,q4_1_4,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_1,1,5) & (missing(q4_1_4) | q4_1_4 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0))
file write `out' "P2.06,q4_1_4,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_1,1,5) & (missing(q4_1_4) | q4_1_4 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0))
file write `out' "P2.06,q4_1_4,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_1,1,5) & (missing(q4_1_4) | q4_1_4 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 4 ") > 0))
file write `out' "P2.06,q4_1_4,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_1,1,5) & (missing(q4_1_5) | q4_1_5 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0))
file write `out' "P2.06,q4_1_5,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_1,1,5) & (missing(q4_1_5) | q4_1_5 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0))
file write `out' "P2.06,q4_1_5,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_1,1,5) & (missing(q4_1_5) | q4_1_5 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0))
file write `out' "P2.06,q4_1_5,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_1,1,5) & (missing(q4_1_5) | q4_1_5 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0))
file write `out' "P2.06,q4_1_5,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_1,1,5) & (missing(q4_1_5) | q4_1_5 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 5 ") > 0))
file write `out' "P2.06,q4_1_5,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_1,1,5) & (missing(q4_1_6) | q4_1_6 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0))
file write `out' "P2.06,q4_1_6,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_1,1,5) & (missing(q4_1_6) | q4_1_6 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0))
file write `out' "P2.06,q4_1_6,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_1,1,5) & (missing(q4_1_6) | q4_1_6 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0))
file write `out' "P2.06,q4_1_6,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_1,1,5) & (missing(q4_1_6) | q4_1_6 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0))
file write `out' "P2.06,q4_1_6,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_1,1,5) & (missing(q4_1_6) | q4_1_6 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 6 ") > 0))
file write `out' "P2.06,q4_1_6,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_1,1,5) & (missing(q4_1_7) | q4_1_7 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0))
file write `out' "P2.06,q4_1_7,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_1,1,5) & (missing(q4_1_7) | q4_1_7 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0))
file write `out' "P2.06,q4_1_7,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_1,1,5) & (missing(q4_1_7) | q4_1_7 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0))
file write `out' "P2.06,q4_1_7,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_1,1,5) & (missing(q4_1_7) | q4_1_7 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0))
file write `out' "P2.06,q4_1_7,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_1,1,5) & (missing(q4_1_7) | q4_1_7 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 7 ") > 0))
file write `out' "P2.06,q4_1_7,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_1,1,5) & (missing(q4_1_8) | q4_1_8 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0))
file write `out' "P2.06,q4_1_8,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_1,1,5) & (missing(q4_1_8) | q4_1_8 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0))
file write `out' "P2.06,q4_1_8,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_1,1,5) & (missing(q4_1_8) | q4_1_8 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0))
file write `out' "P2.06,q4_1_8,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_1,1,5) & (missing(q4_1_8) | q4_1_8 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0))
file write `out' "P2.06,q4_1_8,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_1,1,5) & (missing(q4_1_8) | q4_1_8 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 8 ") > 0))
file write `out' "P2.06,q4_1_8,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_1,1,5) & (missing(q4_1_9) | q4_1_9 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0))
file write `out' "P2.06,q4_1_9,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_1,1,5) & (missing(q4_1_9) | q4_1_9 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0))
file write `out' "P2.06,q4_1_9,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_1,1,5) & (missing(q4_1_9) | q4_1_9 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0))
file write `out' "P2.06,q4_1_9,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_1,1,5) & (missing(q4_1_9) | q4_1_9 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0))
file write `out' "P2.06,q4_1_9,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_1,1,5) & (missing(q4_1_9) | q4_1_9 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 9 ") > 0))
file write `out' "P2.06,q4_1_9,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q4_1,1,5) & (missing(q4_1_98) | q4_1_98 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0))
file write `out' "P2.06,q4_1_98,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q4_1,1,5) & (missing(q4_1_98) | q4_1_98 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0))
file write `out' "P2.06,q4_1_98,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q4_1,1,5) & (missing(q4_1_98) | q4_1_98 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0))
file write `out' "P2.06,q4_1_98,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q4_1,1,5) & (missing(q4_1_98) | q4_1_98 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0))
file write `out' "P2.06,q4_1_98,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q4_1,1,5) & (missing(q4_1_98) | q4_1_98 != (strpos(" " + itrim(strtrim(q4_1)) + " ", " 98 ") > 0))
file write `out' "P2.06,q4_1_98,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_13,1,5) & (missing(q5_13_1) | q5_13_1 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0))
file write `out' "P2.06,q5_13_1,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_13,1,5) & (missing(q5_13_1) | q5_13_1 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0))
file write `out' "P2.06,q5_13_1,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_13,1,5) & (missing(q5_13_1) | q5_13_1 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0))
file write `out' "P2.06,q5_13_1,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_13,1,5) & (missing(q5_13_1) | q5_13_1 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0))
file write `out' "P2.06,q5_13_1,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_13,1,5) & (missing(q5_13_1) | q5_13_1 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 1 ") > 0))
file write `out' "P2.06,q5_13_1,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_13,1,5) & (missing(q5_13_2) | q5_13_2 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0))
file write `out' "P2.06,q5_13_2,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_13,1,5) & (missing(q5_13_2) | q5_13_2 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0))
file write `out' "P2.06,q5_13_2,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_13,1,5) & (missing(q5_13_2) | q5_13_2 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0))
file write `out' "P2.06,q5_13_2,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_13,1,5) & (missing(q5_13_2) | q5_13_2 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0))
file write `out' "P2.06,q5_13_2,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_13,1,5) & (missing(q5_13_2) | q5_13_2 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 2 ") > 0))
file write `out' "P2.06,q5_13_2,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_13,1,5) & (missing(q5_13_3) | q5_13_3 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0))
file write `out' "P2.06,q5_13_3,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_13,1,5) & (missing(q5_13_3) | q5_13_3 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0))
file write `out' "P2.06,q5_13_3,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_13,1,5) & (missing(q5_13_3) | q5_13_3 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0))
file write `out' "P2.06,q5_13_3,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_13,1,5) & (missing(q5_13_3) | q5_13_3 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0))
file write `out' "P2.06,q5_13_3,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_13,1,5) & (missing(q5_13_3) | q5_13_3 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 3 ") > 0))
file write `out' "P2.06,q5_13_3,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_13,1,5) & (missing(q5_13_4) | q5_13_4 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0))
file write `out' "P2.06,q5_13_4,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_13,1,5) & (missing(q5_13_4) | q5_13_4 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0))
file write `out' "P2.06,q5_13_4,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_13,1,5) & (missing(q5_13_4) | q5_13_4 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0))
file write `out' "P2.06,q5_13_4,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_13,1,5) & (missing(q5_13_4) | q5_13_4 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0))
file write `out' "P2.06,q5_13_4,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_13,1,5) & (missing(q5_13_4) | q5_13_4 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 4 ") > 0))
file write `out' "P2.06,q5_13_4,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_13,1,5) & (missing(q5_13_5) | q5_13_5 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0))
file write `out' "P2.06,q5_13_5,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_13,1,5) & (missing(q5_13_5) | q5_13_5 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0))
file write `out' "P2.06,q5_13_5,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_13,1,5) & (missing(q5_13_5) | q5_13_5 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0))
file write `out' "P2.06,q5_13_5,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_13,1,5) & (missing(q5_13_5) | q5_13_5 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0))
file write `out' "P2.06,q5_13_5,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_13,1,5) & (missing(q5_13_5) | q5_13_5 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 5 ") > 0))
file write `out' "P2.06,q5_13_5,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_13,1,5) & (missing(q5_13_6) | q5_13_6 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0))
file write `out' "P2.06,q5_13_6,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_13,1,5) & (missing(q5_13_6) | q5_13_6 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0))
file write `out' "P2.06,q5_13_6,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_13,1,5) & (missing(q5_13_6) | q5_13_6 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0))
file write `out' "P2.06,q5_13_6,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_13,1,5) & (missing(q5_13_6) | q5_13_6 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0))
file write `out' "P2.06,q5_13_6,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_13,1,5) & (missing(q5_13_6) | q5_13_6 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 6 ") > 0))
file write `out' "P2.06,q5_13_6,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_13,1,5) & (missing(q5_13_7) | q5_13_7 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0))
file write `out' "P2.06,q5_13_7,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_13,1,5) & (missing(q5_13_7) | q5_13_7 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0))
file write `out' "P2.06,q5_13_7,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_13,1,5) & (missing(q5_13_7) | q5_13_7 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0))
file write `out' "P2.06,q5_13_7,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_13,1,5) & (missing(q5_13_7) | q5_13_7 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0))
file write `out' "P2.06,q5_13_7,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_13,1,5) & (missing(q5_13_7) | q5_13_7 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 7 ") > 0))
file write `out' "P2.06,q5_13_7,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_13,1,5) & (missing(q5_13_98) | q5_13_98 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0))
file write `out' "P2.06,q5_13_98,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_13,1,5) & (missing(q5_13_98) | q5_13_98 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0))
file write `out' "P2.06,q5_13_98,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_13,1,5) & (missing(q5_13_98) | q5_13_98 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0))
file write `out' "P2.06,q5_13_98,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_13,1,5) & (missing(q5_13_98) | q5_13_98 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0))
file write `out' "P2.06,q5_13_98,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_13,1,5) & (missing(q5_13_98) | q5_13_98 != (strpos(" " + itrim(strtrim(q5_13)) + " ", " 98 ") > 0))
file write `out' "P2.06,q5_13_98,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_2,1,5) & (missing(q5_2_1) | q5_2_1 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0))
file write `out' "P2.06,q5_2_1,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_2,1,5) & (missing(q5_2_1) | q5_2_1 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0))
file write `out' "P2.06,q5_2_1,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_2,1,5) & (missing(q5_2_1) | q5_2_1 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0))
file write `out' "P2.06,q5_2_1,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_2,1,5) & (missing(q5_2_1) | q5_2_1 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0))
file write `out' "P2.06,q5_2_1,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_2,1,5) & (missing(q5_2_1) | q5_2_1 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 1 ") > 0))
file write `out' "P2.06,q5_2_1,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_2,1,5) & (missing(q5_2_2) | q5_2_2 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0))
file write `out' "P2.06,q5_2_2,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_2,1,5) & (missing(q5_2_2) | q5_2_2 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0))
file write `out' "P2.06,q5_2_2,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_2,1,5) & (missing(q5_2_2) | q5_2_2 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0))
file write `out' "P2.06,q5_2_2,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_2,1,5) & (missing(q5_2_2) | q5_2_2 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0))
file write `out' "P2.06,q5_2_2,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_2,1,5) & (missing(q5_2_2) | q5_2_2 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 2 ") > 0))
file write `out' "P2.06,q5_2_2,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_2,1,5) & (missing(q5_2_3) | q5_2_3 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0))
file write `out' "P2.06,q5_2_3,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_2,1,5) & (missing(q5_2_3) | q5_2_3 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0))
file write `out' "P2.06,q5_2_3,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_2,1,5) & (missing(q5_2_3) | q5_2_3 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0))
file write `out' "P2.06,q5_2_3,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_2,1,5) & (missing(q5_2_3) | q5_2_3 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0))
file write `out' "P2.06,q5_2_3,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_2,1,5) & (missing(q5_2_3) | q5_2_3 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 3 ") > 0))
file write `out' "P2.06,q5_2_3,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_2,1,5) & (missing(q5_2_4) | q5_2_4 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0))
file write `out' "P2.06,q5_2_4,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_2,1,5) & (missing(q5_2_4) | q5_2_4 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0))
file write `out' "P2.06,q5_2_4,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_2,1,5) & (missing(q5_2_4) | q5_2_4 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0))
file write `out' "P2.06,q5_2_4,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_2,1,5) & (missing(q5_2_4) | q5_2_4 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0))
file write `out' "P2.06,q5_2_4,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_2,1,5) & (missing(q5_2_4) | q5_2_4 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 4 ") > 0))
file write `out' "P2.06,q5_2_4,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_2,1,5) & (missing(q5_2_5) | q5_2_5 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0))
file write `out' "P2.06,q5_2_5,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_2,1,5) & (missing(q5_2_5) | q5_2_5 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0))
file write `out' "P2.06,q5_2_5,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_2,1,5) & (missing(q5_2_5) | q5_2_5 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0))
file write `out' "P2.06,q5_2_5,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_2,1,5) & (missing(q5_2_5) | q5_2_5 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0))
file write `out' "P2.06,q5_2_5,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_2,1,5) & (missing(q5_2_5) | q5_2_5 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 5 ") > 0))
file write `out' "P2.06,q5_2_5,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_2,1,5) & (missing(q5_2_6) | q5_2_6 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0))
file write `out' "P2.06,q5_2_6,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_2,1,5) & (missing(q5_2_6) | q5_2_6 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0))
file write `out' "P2.06,q5_2_6,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_2,1,5) & (missing(q5_2_6) | q5_2_6 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0))
file write `out' "P2.06,q5_2_6,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_2,1,5) & (missing(q5_2_6) | q5_2_6 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0))
file write `out' "P2.06,q5_2_6,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_2,1,5) & (missing(q5_2_6) | q5_2_6 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 6 ") > 0))
file write `out' "P2.06,q5_2_6,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q5_2,1,5) & (missing(q5_2_98) | q5_2_98 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))
file write `out' "P2.06,q5_2_98,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q5_2,1,5) & (missing(q5_2_98) | q5_2_98 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))
file write `out' "P2.06,q5_2_98,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q5_2,1,5) & (missing(q5_2_98) | q5_2_98 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))
file write `out' "P2.06,q5_2_98,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q5_2,1,5) & (missing(q5_2_98) | q5_2_98 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))
file write `out' "P2.06,q5_2_98,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q5_2,1,5) & (missing(q5_2_98) | q5_2_98 != (strpos(" " + itrim(strtrim(q5_2)) + " ", " 98 ") > 0))
file write `out' "P2.06,q5_2_98,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_17,1,5) & (missing(q9_17_1) | q9_17_1 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0))
file write `out' "P2.06,q9_17_1,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_17,1,5) & (missing(q9_17_1) | q9_17_1 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0))
file write `out' "P2.06,q9_17_1,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_17,1,5) & (missing(q9_17_1) | q9_17_1 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0))
file write `out' "P2.06,q9_17_1,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_17,1,5) & (missing(q9_17_1) | q9_17_1 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0))
file write `out' "P2.06,q9_17_1,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_17,1,5) & (missing(q9_17_1) | q9_17_1 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 1 ") > 0))
file write `out' "P2.06,q9_17_1,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_17,1,5) & (missing(q9_17_2) | q9_17_2 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0))
file write `out' "P2.06,q9_17_2,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_17,1,5) & (missing(q9_17_2) | q9_17_2 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0))
file write `out' "P2.06,q9_17_2,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_17,1,5) & (missing(q9_17_2) | q9_17_2 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0))
file write `out' "P2.06,q9_17_2,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_17,1,5) & (missing(q9_17_2) | q9_17_2 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0))
file write `out' "P2.06,q9_17_2,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_17,1,5) & (missing(q9_17_2) | q9_17_2 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 2 ") > 0))
file write `out' "P2.06,q9_17_2,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_17,1,5) & (missing(q9_17_3) | q9_17_3 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0))
file write `out' "P2.06,q9_17_3,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_17,1,5) & (missing(q9_17_3) | q9_17_3 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0))
file write `out' "P2.06,q9_17_3,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_17,1,5) & (missing(q9_17_3) | q9_17_3 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0))
file write `out' "P2.06,q9_17_3,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_17,1,5) & (missing(q9_17_3) | q9_17_3 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0))
file write `out' "P2.06,q9_17_3,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_17,1,5) & (missing(q9_17_3) | q9_17_3 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 3 ") > 0))
file write `out' "P2.06,q9_17_3,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_17,1,5) & (missing(q9_17_4) | q9_17_4 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0))
file write `out' "P2.06,q9_17_4,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_17,1,5) & (missing(q9_17_4) | q9_17_4 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0))
file write `out' "P2.06,q9_17_4,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_17,1,5) & (missing(q9_17_4) | q9_17_4 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0))
file write `out' "P2.06,q9_17_4,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_17,1,5) & (missing(q9_17_4) | q9_17_4 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0))
file write `out' "P2.06,q9_17_4,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_17,1,5) & (missing(q9_17_4) | q9_17_4 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 4 ") > 0))
file write `out' "P2.06,q9_17_4,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_17,1,5) & (missing(q9_17_5) | q9_17_5 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0))
file write `out' "P2.06,q9_17_5,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_17,1,5) & (missing(q9_17_5) | q9_17_5 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0))
file write `out' "P2.06,q9_17_5,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_17,1,5) & (missing(q9_17_5) | q9_17_5 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0))
file write `out' "P2.06,q9_17_5,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_17,1,5) & (missing(q9_17_5) | q9_17_5 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0))
file write `out' "P2.06,q9_17_5,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_17,1,5) & (missing(q9_17_5) | q9_17_5 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 5 ") > 0))
file write `out' "P2.06,q9_17_5,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_17,1,5) & (missing(q9_17_98) | q9_17_98 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0))
file write `out' "P2.06,q9_17_98,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_17,1,5) & (missing(q9_17_98) | q9_17_98 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0))
file write `out' "P2.06,q9_17_98,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_17,1,5) & (missing(q9_17_98) | q9_17_98 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0))
file write `out' "P2.06,q9_17_98,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_17,1,5) & (missing(q9_17_98) | q9_17_98 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0))
file write `out' "P2.06,q9_17_98,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_17,1,5) & (missing(q9_17_98) | q9_17_98 != (strpos(" " + itrim(strtrim(q9_17)) + " ", " 98 ") > 0))
file write `out' "P2.06,q9_17_98,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_21,1,5) & (missing(q9_21_1) | q9_21_1 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0))
file write `out' "P2.06,q9_21_1,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_21,1,5) & (missing(q9_21_1) | q9_21_1 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0))
file write `out' "P2.06,q9_21_1,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_21,1,5) & (missing(q9_21_1) | q9_21_1 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0))
file write `out' "P2.06,q9_21_1,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_21,1,5) & (missing(q9_21_1) | q9_21_1 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0))
file write `out' "P2.06,q9_21_1,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_21,1,5) & (missing(q9_21_1) | q9_21_1 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 1 ") > 0))
file write `out' "P2.06,q9_21_1,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_21,1,5) & (missing(q9_21_2) | q9_21_2 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0))
file write `out' "P2.06,q9_21_2,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_21,1,5) & (missing(q9_21_2) | q9_21_2 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0))
file write `out' "P2.06,q9_21_2,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_21,1,5) & (missing(q9_21_2) | q9_21_2 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0))
file write `out' "P2.06,q9_21_2,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_21,1,5) & (missing(q9_21_2) | q9_21_2 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0))
file write `out' "P2.06,q9_21_2,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_21,1,5) & (missing(q9_21_2) | q9_21_2 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 2 ") > 0))
file write `out' "P2.06,q9_21_2,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_21,1,5) & (missing(q9_21_3) | q9_21_3 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0))
file write `out' "P2.06,q9_21_3,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_21,1,5) & (missing(q9_21_3) | q9_21_3 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0))
file write `out' "P2.06,q9_21_3,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_21,1,5) & (missing(q9_21_3) | q9_21_3 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0))
file write `out' "P2.06,q9_21_3,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_21,1,5) & (missing(q9_21_3) | q9_21_3 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0))
file write `out' "P2.06,q9_21_3,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_21,1,5) & (missing(q9_21_3) | q9_21_3 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 3 ") > 0))
file write `out' "P2.06,q9_21_3,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_21,1,5) & (missing(q9_21_4) | q9_21_4 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0))
file write `out' "P2.06,q9_21_4,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_21,1,5) & (missing(q9_21_4) | q9_21_4 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0))
file write `out' "P2.06,q9_21_4,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_21,1,5) & (missing(q9_21_4) | q9_21_4 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0))
file write `out' "P2.06,q9_21_4,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_21,1,5) & (missing(q9_21_4) | q9_21_4 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0))
file write `out' "P2.06,q9_21_4,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_21,1,5) & (missing(q9_21_4) | q9_21_4 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 4 ") > 0))
file write `out' "P2.06,q9_21_4,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512090157 & inlist(_p24_q9_21,1,5) & (missing(q9_21_5) | q9_21_5 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0))
file write `out' "P2.06,q9_21_5,2512090157,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512091719 & inlist(_p24_q9_21,1,5) & (missing(q9_21_5) | q9_21_5 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0))
file write `out' "P2.06,q9_21_5,2512091719,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512111044 & inlist(_p24_q9_21,1,5) & (missing(q9_21_5) | q9_21_5 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0))
file write `out' "P2.06,q9_21_5,2512111044,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2512121811 & inlist(_p24_q9_21,1,5) & (missing(q9_21_5) | q9_21_5 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0))
file write `out' "P2.06,q9_21_5,2512121811,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if formdef_version == 2602120658 & inlist(_p24_q9_21,1,5) & (missing(q9_21_5) | q9_21_5 != (strpos(" " + itrim(strtrim(q9_21)) + " ", " 5 ") > 0))
file write `out' "P2.06,q9_21_5,2602120658,parent_dummy_disagreement,,NA," (r(N)) ",NA,indeterminate" _n
file write `out' "P2.02,all,,documentary_route_bound,,NA,NA,NA,supported" _n
quietly count if _p24_q10_10 == 6
file write `out' "P2.09,q10_10,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q10_11 == 6
file write `out' "P2.09,q10_11,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q10_12 == 6
file write `out' "P2.09,q10_12,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q10_13 == 6
file write `out' "P2.09,q10_13,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q10_14 == 6
file write `out' "P2.09,q10_14,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q4_12 == 6
file write `out' "P2.10,q4_12,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q4_13 == 6
file write `out' "P2.10,q4_13,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q7_11 == 6
file write `out' "P2.10,q7_11,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q7_12 == 6
file write `out' "P2.10,q7_12,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q7_13 == 6
file write `out' "P2.10,q7_13,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q7_14 == 6
file write `out' "P2.10,q7_14,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q7_15 == 6
file write `out' "P2.10,q7_15,,route_or_domain_unresolved,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q4_12 == 1 & _p24a_q4_13 == 1 & q4_13 == 5
file write `out' "P2.10,q4_13,,no_account_after_selection,,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q4_12 == 1 & _p24_q4_13 == 1 & q4_13 == 1 & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 1 ") > 0)
file write `out' "P2.10,q4_13,,principal_product_not_selected,option_1,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q4_12 == 1 & _p24_q4_13 == 1 & q4_13 == 2 & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 2 ") > 0)
file write `out' "P2.10,q4_13,,principal_product_not_selected,option_2,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q4_12 == 1 & _p24_q4_13 == 1 & q4_13 == 3 & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 3 ") > 0)
file write `out' "P2.10,q4_13,,principal_product_not_selected,option_3,NA," (r(N)) ",NA,indeterminate" _n
quietly count if _p24_q4_12 == 1 & _p24_q4_13 == 1 & q4_13 == 4 & !(strpos(" " + itrim(strtrim(q4_12)) + " ", " 4 ") > 0)
file write `out' "P2.10,q4_13,,principal_product_not_selected,option_4,NA," (r(N)) ",NA,indeterminate" _n
file close `out'
global wp07_target33_step 2
