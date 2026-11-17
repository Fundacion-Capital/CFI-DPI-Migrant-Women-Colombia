/*
Measurement and latent-class analysis | Digital Payments, Partial Inclusion
Five reported conditions; one complete-case base across all candidates.
LI: local independence. LD: joint response for the two agreement items.
*/
version 19.0
args source reference out codedir
set more off
set varabbrev off
if c(MP) != 1 | c(N) != 0 | c(k) != 0 {
    exit 459
}

* Run in the private batch directory and leave the implicit batch log there.
if lower(subinstr("`c(pwd)'", char(92), "/", .)) != lower("`out'") {
    exit 459
}
quietly log query _all
local logs = r(numlogs)
* On Windows /e, _all counts explicit logs only and returns missing if none are open.
if !missing(`logs') & `logs' != 0 {
    exit 459
}
quietly cmdlog
if "`r(status)'" == "on" | "`r(filename)'" != "" {
    exit 459
}

* Start with the locked prepared cohort, not the questionnaire export.
local retained f3_order f3_y1 f3_y2 f3_y3 f3_y4 f3_y5 f3_joint
local options difficult iterate(2400) ltolerance(1e-8) nrtolerance(1e-6) vce(oim) emopts(iterate(20))
foreach name in sample.csv baselines.csv baseline_probabilities.csv observed.csv initialized.txt runtime.txt closed.txt {
    confirm new file "`out'/`name'"
}

local fields formdef_version wp07_known_form eligible_flag ///
    q3_1 wp07_route_q3_1 wp07_state_q3_1 ///
    q4_5 wp07_route_q4_5 wp07_state_q4_5 ///
    q3_17 wp07_route_q3_17 wp07_state_q3_17 ///
    q9_4 wp07_route_q9_4 wp07_state_q9_4 ///
    q10_4 wp07_route_q10_4 wp07_state_q10_4
use `fields' using "`source'", clear
assert _N == 423 & c(k) == 18
assert inlist(formdef_version, 2512090157,2512091719,2512111044,2512121811,2602120658)
assert wp07_known_form == 1 & eligible_flag == 1
gen int f3_order = _n
gen byte f3_sample = wp07_known_form == 1 & eligible_flag == 1
foreach item in q3_1 q4_5 q3_17 q9_4 q10_4 {
    assert wp07_route_`item' == 1
    if "`item'" != "q4_5" {
        assert wp07_state_`item' == 1
    }
    replace f3_sample = 0 if wp07_route_`item' != 1 | wp07_state_`item' != 1
}
assert inlist(q4_5, 1,2,3,4)
assert inlist(q3_1,1,2,3) & inlist(q3_17,1,2,3,4,5) & inlist(q9_4,1,2,3,4,5) & inlist(q10_4,1,2,3,4)
assert wp07_state_q4_5 == cond(inlist(q4_5,1,2), 1, 5)
assert f3_sample == (inlist(formdef_version, 2512090157,2512091719,2512111044,2512121811,2602120658) ///
    & eligible_flag == 1 & inlist(q3_1,1,2,3) & inlist(q4_5,1,2) ///
    & inlist(q3_17,1,2,3,4,5) & inlist(q9_4,1,2,3,4,5) & inlist(q10_4,1,2,3,4))
count if !f3_sample & q4_5 == 3
assert r(N) == 11
count if !f3_sample & q4_5 == 4
assert r(N) == 5

tempname sample
file open `sample' using "`out'/sample.csv", write text
file write `sample' "base,n" _n "Locked eligible cohort,423" _n ///
    "Address proof in process,11" _n "Address proof refusal,5" _n ///
    "Complete-case LCA sample,407" _n
file close `sample'
keep if f3_sample
assert _N == 407
* Y1/Y2 are binary; keep neutral separate in Y3/Y4; retain all four Y5 levels.
gen byte f3_y1 = q3_1 == 1
gen byte f3_y2 = q4_5 == 1
gen byte f3_y3 = cond(q3_17 <= 2, 1, cond(q3_17 == 3, 2, 3))
gen byte f3_y4 = cond(q9_4 <= 2, 1, cond(q9_4 == 3, 2, 3))
gen byte f3_y5 = q10_4
gen byte f3_joint = 3*(f3_y3 - 1) + f3_y4
keep `retained'
assert f3_order > f3_order[_n-1] if _n > 1
fvset base 1 f3_joint
_datasignature `retained'
local signature "`r(datasignature)'"

* Compare all 144 counts to the frozen no-fit ledger before estimation.
tempname observed frozen
file open `frozen' using "`reference'", read text
file read `frozen' line
assert trim("`line'") == "y1,y2,y3,y4,y5,n"
file open `observed' using "`out'/observed.csv", write text
file write `observed' "y1,y2,y3,y4,y5,n" _n
forvalues a = 0/1 {
    forvalues b = 0/1 {
        forvalues c = 1/3 {
            forvalues d = 1/3 {
                forvalues e = 1/4 {
                    count if f3_y1 == `a' & f3_y2 == `b' & f3_y3 == `c' & f3_y4 == `d' & f3_y5 == `e'
                    local n = r(N)
                    file read `frozen' line
                    assert r(eof) == 0
                    assert subinstr(trim("`line'"), " ", "", .) == "`a',`b',`c',`d',`e',`n'"
                    file write `observed' "`a',`b',`c',`d',`e',`n'" _n
                }
            }
        }
    }
}
file close `observed'
file read `frozen' line
assert r(eof) == 1
file close `frozen'
display "F3_PATTERN_REFERENCE_MATCHED: 144 cells, 407 complete cases"

* The one-class MLEs are the matching marginal frequencies, not native fits.
tempname baseline probs
file open `baseline' using "`out'/baselines.csv", write text
file write `baseline' "order,family,k,n,d,ll,aic,bic" _n
file open `probs' using "`out'/baseline_probabilities.csv", write text
file write `probs' "family,response,code,n,probability" _n
foreach family in LI LD {
    local factors f3_y1 f3_y2 f3_y3 f3_y4 f3_y5
    local order = 1
    local dimension = 9
    if "`family'" == "LD" {
        local factors f3_y1 f3_y2 f3_joint f3_y5
        local order = 2
        local dimension = 13
    }
    tempname ll
    scalar `ll' = 0
    foreach response of local factors {
        local first = cond(inlist("`response'","f3_y1","f3_y2"), 0, 1)
        local last = cond(`first'==0, 1, cond("`response'"=="f3_joint",9,cond("`response'"=="f3_y5",4,3)))
        forvalues level = `first'/`last' {
            count if `response' == `level'
            local count = r(N)
            assert `count' > 0
            scalar `ll' = `ll' + `count'*ln(`count'/407)
            file write `probs' "`family',`response',`level',`count'," %24.17g (`count'/407) _n
        }
    }
    file write `baseline' "`order',`family',1,407,`dimension'," %24.17g (`ll') "," ///
        %24.17g (-2*`ll'+2*`dimension') "," %24.17g (-2*`ll'+`dimension'*ln(407)) _n
}
file close `baseline'
file close `probs'
tempname runtime
file open `runtime' using "`out'/runtime.txt", write text
file write `runtime' "Stata version " (c(stata_version)) "; MP=" (c(MP)) "; build " (c(born_date)) _n
file close `runtime'

tempname initialized
file open `initialized' using "`out'/initialized.txt", write text
file write `initialized' "F3_NATIVE_INITIALIZED n=407 baselines=2" _n
file close `initialized'

* For each class count, run three independent seeds in each model family.
* Give each fit the same search budget; never replace a failed fit.
forvalues order = 3/32 {
    local slot = `order'
    local k = 2 + floor((`order' - 3)/6)
    local family = cond(mod(`order' - 3,6) < 3,"LI","LD")
    local attempt = 1 + mod(`order' - 3,3)
    local seed = 26111600 + 100*("`family'" == "LD") + 10*`k' + `attempt'
    local dimension = cond("`family'"=="LI",10,14)*`k' - 1
    foreach name in started.txt status.csv matrices.csv probabilities.csv diagnostics.csv assignments.csv finished.txt optimizer.log {
        confirm new file "`out'/slot`slot'_`name'"
    }
    tempname start
    file open `start' using "`out'/slot`slot'_started.txt", write text
    file write `start' "F3_FIT_STARTED order=`order' seed=`seed'" _n
    file close `start'

    * The batch log and each optimizer log are written in the restricted run directory.
    log using "`out'/slot`slot'_optimizer.log", text name(f3_optimizer)
    ereturn clear
    timer clear 15
    timer on 15
    if "`family'" == "LI" {
        capture noisily gsem (f3_y1 f3_y2 <-, logit) (f3_y3 f3_y4 f3_y5 <-, ologit), ///
            lclass(C `k', base(1)) lcinvariant(none) ///
            startvalues(randomid, draws(120) seed(`seed') iterate(20)) `options' coeflegend
        local rc = _rc
    }
    else {
        capture noisily gsem (f3_y1 f3_y2 <-, logit) (b1.f3_joint <-, mlogit) (f3_y5 <-, ologit), ///
            lclass(C `k', base(1)) lcinvariant(none) ///
            startvalues(randomid, draws(120) seed(`seed') iterate(20)) `options' coeflegend
        local rc = _rc
    }
    timer off 15
    quietly timer list 15
    local seconds = r(t15)
    log close f3_optimizer

    tempname status
    file open `status' using "`out'/slot`slot'_status.csv", write text
    file write `status' "order,family,k,seed,planned_d,rc,scalars_present,converged,n,ll,native_k,rank,iterations,seconds,optimizer_rc" _n
    local returned = ("`e(cmd)'" == "gsem")
    file write `status' "`order',`family',`k',`seed',`dimension',`rc',`returned',"
    if `returned' {
        file write `status' (e(converged)) "," (e(N)) "," %24.17g (e(ll)) "," (e(k)) "," (e(rank)) "," (e(ic))
    }
    else {
        file write `status' ".,.,.,.,.,."
    }
    file write `status' "," %24.17g (`seconds') "," (e(rc)) _n
    file close `status'

    * Keep failed optimization endpoints without treating them as fits for reporting.
    if missing(`seconds') {
        exit 459
    }
    if !inlist(`rc',0,430,498,504,506,1400) | (`rc' == 0 & !`returned') {
        exit 459
    }
    local capture_rc = .
    if `returned' {
        assert e(N) == 407
        assert e(sample) == 1
        assert inlist(e(converged),0,1)
        if e(converged) == 1 {
            assert !missing(e(ll)) & e(ll) < 0 & "`e(vce)'" == "oim"
        }
        if `rc' == 430 {
            assert e(converged) == 0
        }
        capture noisily do "`codedir'/2b LCA capture.do" "`slot'" "`family'" "`k'" "`out'"
        local capture_rc = _rc
    }

    _datasignature `retained'
    assert _N == 407 & "`r(datasignature)'" == "`signature'"
    tempname terminal
    file open `terminal' using "`out'/slot`slot'_finished.txt", write text
    file write `terminal' "F3_FIT_RETURNED order=`order' capture_rc=`capture_rc'" _n
    file close `terminal'
}

* No participant-level result is saved. Unload the analytical sample on normal return.
clear all
if c(N) != 0 | c(k) != 0 {
    exit 459
}
tempname receipt
file open `receipt' using "`out'/closed.txt", write text
file write `receipt' "F3_NATIVE_CLOSED N=0 K=0" _n
file close `receipt'
