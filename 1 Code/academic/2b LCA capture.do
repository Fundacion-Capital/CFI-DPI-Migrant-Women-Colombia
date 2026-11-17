* Save native aggregate evidence. Individual probabilities exist only in memory.
version 19.0
args slot family k out
tempname b V g meta m p pi h
capture matrix `b' = e(b)
if _rc {
    assert e(converged) == 0
    exit
}
local width = colsof(`b')
assert rowsof(`b') == 1 & inrange(`width',1,90)
local eqs : coleq `b'
local terms : colnames `b'
capture matrix `V' = e(V)
local hasV = (_rc == 0)
if e(converged) == 1 {
    assert `hasV' == 1
}
if `hasV' {
    assert rowsof(`V') == `width' & colsof(`V') == `width'
    local vr : rowfullnames `V'
    local vc : colfullnames `V'
    local bn : colfullnames `b'
    assert "`vr'" == "`bn'" & "`vc'" == "`bn'"
}
capture matrix `g' = e(gradient)
local hasg = (_rc == 0)
if `hasg' {
    local hasg = (rowsof(`g') == 1)
    local geq : coleq `g'
    local gterms : colnames `g'
}
file open `m' using "`out'/slot`slot'_matrices.csv", write text
file write `m' "object,row,column,equation,term,value" _n
foreach object in b_pclass Cns lclass_k_levels lclass_bases cat1 cat2 cat3 cat4 cat5 out1 out2 out3 out4 out5 ilog {
    capture matrix `meta' = e(`object')
    if !_rc {
        local nr = rowsof(`meta')
        local nc = colsof(`meta')
        assert inrange(`nr',1,91) & inrange(`nc',1,91)
        forvalues row = 1/`nr' {
            forvalues column = 1/`nc' {
                file write `m' "`object',`row',`column',,," %24.17g (`meta'[`row',`column']) _n
            }
        }
    }
}
forvalues i = 1/`width' {
    local eq : word `i' of `eqs'
    local term : word `i' of `terms'
    file write `m' "b,1,`i',`eq',`term'," %24.17g (`b'[1,`i']) _n
    if `hasV' {
        forvalues j = 1/`width' {
            file write `m' "V,`i',`j',,," %24.17g (`V'[`i',`j']) _n
        }
    }
}
if `hasg' {
    forvalues i = 1/`=colsof(`g')' {
        local eq : word `i' of `geq'
        local term : word `i' of `gterms'
        file write `m' "gradient,1,`i',`eq',`term'," %24.17g (`g'[1,`i']) _n
    }
}
file close `m'
if e(converged) == 0 {
    exit
}

local factors f3_y1 f3_y2 f3_y3 f3_y4 f3_y5
if "`family'" == "LD" {
    local factors f3_y1 f3_y2 f3_joint f3_y5
}
local nf : word count `factors'
matrix `p' = J(`k'*`nf',9,.)
matrix `pi' = J(1,`k',.)
tempvar predicted
local logmass
local mix_total = 0
local boundary = 0
local norm_error = 0
local minimum = 1
tempname probabilities
file open `probabilities' using "`out'/slot`slot'_probabilities.csv", write text
file write `probabilities' "class,response,code,probability" _n
forvalues class = 1/`k' {
    tempvar llvar
    local logmass `logmass' `llvar'
    predict double `predicted', classpr class(`class')
    summarize `predicted', meanonly
    matrix `pi'[1,`class'] = r(min)
    assert r(N) == 407 & r(max)-r(min) <= 1e-12 & inrange(r(min),0,1)
    local mix_total = `mix_total' + `pi'[1,`class']
    file write `probabilities' "`class',pi,0," %24.17g (`pi'[1,`class']) _n
    drop `predicted'
    local minimum = min(`minimum',`pi'[1,`class'],1-`pi'[1,`class'])
    gen double `llvar' = ln(`pi'[1,`class'])

    forvalues j = 1/`nf' {
        local y : word `j' of `factors'
        local first = cond(inlist("`y'","f3_y1","f3_y2"),0,1)
        local last = cond(`first'==0,1,cond("`y'"=="f3_joint",9,cond("`y'"=="f3_y5",4,3)))
        local row = (`class'-1)*`nf' + `j'
        local total = 0
        forvalues value = `first'/`last' {
            local col = `value'-`first'+1
            if `first' == 0 {
                predict double `predicted', pr outcome(`y') class(`class')
                if `value' == 0 {
                    replace `predicted' = 1 - `predicted'
                }
            }
            else {
                predict double `predicted', pr outcome(`y' `value') class(`class')
            }
            summarize `predicted', meanonly
            matrix `p'[`row',`col'] = r(min)
            assert r(N) == 407 & r(max)-r(min) <= 1e-12 & inrange(r(min),0,1)
            drop `predicted'
            local total = `total' + `p'[`row',`col']
            local minimum = min(`minimum',`p'[`row',`col'],1-`p'[`row',`col'])
            file write `probabilities' "`class',`y',`value'," %24.17g (`p'[`row',`col']) _n
            replace `llvar' = `llvar' + ln(`p'[`row',`col']) if `y' == `value'
        }
        local norm_error = max(`norm_error',abs(`total'-1))
    }
}
file close `probabilities'
local norm_error = max(`norm_error',abs(`mix_total'-1))
assert `norm_error' <= 1e-8
local boundary = (`minimum' < 1e-6)
tempname check
file open `check' using "`out'/slot`slot'_diagnostics.csv", write text
file write `check' "probability_boundary,min_p_or_1mp,prob_norm_max,ll_rebuilt,ll_delta,native_posterior_max,posterior_norm_max,mix_score_max,item_score_max,mean_max,entropy,ties,max_below_070,gap_below_010" _n
file write `check' (`boundary') "," %24.17g (`minimum') "," %24.17g (`norm_error')
if `boundary' {
    file write `check' ",.,.,.,.,.,.,.,.,.,.,." _n
    file close `check'
    exit
}

* Recompute every posterior from the category probabilities and compare in memory.
tempvar peak sumexp ell mass entropy best second gap
egen double `peak' = rowmax(`logmass')
gen double `sumexp' = 0
foreach llvar of local logmass {
    replace `sumexp' = `sumexp' + exp(`llvar'-`peak')
}
gen double `ell' = `peak'+ln(`sumexp')
summarize `ell', meanonly
local ll = r(sum)
local ll_delta = abs(`ll' - e(ll))
gen double `entropy' = 0
gen double `mass' = 0
local posts
local posterior_error = 0
local mix_error = 0
local item_error = 0
tempname assignments
file open `assignments' using "`out'/slot`slot'_assignments.csv", write text
file write `assignments' "class,modal_n,posterior_mass" _n
matrix `h' = J(1,`k',.)
forvalues class = 1/`k' {
    local llvar : word `class' of `logmass'
    tempvar post
    local posts `posts' `post'
    gen double `post' = exp(`llvar' - `ell')
    predict double `predicted', classposteriorpr class(`class')
    assert !missing(`predicted') & inrange(`predicted',0,1)
    replace `predicted' = abs(`predicted'-`post')
    summarize `predicted', meanonly
    local posterior_error = max(`posterior_error',r(max))
    drop `predicted'
    replace `mass' = `mass' + `post'
    replace `entropy' = `entropy' - `post'*ln(`post')
    summarize `post', meanonly
    matrix `h'[1,`class'] = r(sum)
    local mix_error = max(`mix_error',abs(`h'[1,`class']/407 - `pi'[1,`class']))
    forvalues j = 1/`nf' {
        local y : word `j' of `factors'
        local first = cond(inlist("`y'","f3_y1","f3_y2"),0,1)
        local last = cond(`first'==0,1,cond("`y'"=="f3_joint",9,cond("`y'"=="f3_y5",4,3)))
        local row = (`class'-1)*`nf' + `j'
        forvalues value = `first'/`last' {
            local col = `value'-`first'+1
            summarize `post' if `y' == `value', meanonly
            local item_error = max(`item_error',abs(r(sum)-`h'[1,`class']*`p'[`row',`col'])/407)
        }
    }
}
replace `mass' = abs(`mass'-1)
summarize `mass', meanonly
local posterior_norm = r(max)
* The second-largest probability can equal the largest (a top tie).
gen double `best' = 0
gen double `second' = 0
foreach post of local posts {
    replace `second' = max(`second',min(`best',`post'))
    replace `best' = max(`best',`post')
}
gen double `gap' = `best'-`second'
forvalues class = 1/`k' {
    local post : word `class' of `posts'
    count if `gap' > 1e-8 & `best' == `post'
    file write `assignments' "`class'," (r(N)) "," %24.17g (`h'[1,`class']) _n
}
count if `gap' <= 1e-8
local ties = r(N)
file write `assignments' "tie,`ties',." _n
file close `assignments'
count if `best' < .70
local low = r(N)
count if `gap' < .10
local near = r(N)
summarize `best', meanonly
local typical = r(mean)
summarize `entropy', meanonly
local separation = 1 - r(mean)/ln(`k')
assert !missing(`ll',`posterior_error',`posterior_norm') & `posterior_norm' <= 1e-8
file write `check' "," %24.17g (`ll') "," %24.17g (`ll_delta') "," %24.17g (`posterior_error') "," ///
    %24.17g (`posterior_norm') "," %24.17g (`mix_error') "," %24.17g (`item_error') "," ///
    %24.17g (`typical') "," %24.17g (`separation') ",`ties',`low',`near'" _n
file close `check'
assert `ll_delta' <= 1e-5 & `posterior_error' <= 1e-7
