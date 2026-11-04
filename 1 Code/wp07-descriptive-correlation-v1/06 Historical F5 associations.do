* Appendix F5 and the C2/F heatmap: verified historical LCA base sample only.
* Report the numeric bases. Do not write workbooks, images or participant files.
exit 198

set varabbrev off
local scores ivs_score iat_score iadt_score icdp_score iaff_score ///
    iuof_score_01 oqi_score_01 iurd_score_01 ietr_score_01 IPCS IEDF IAER ICPF IEH IBPD
local categories ivs_cat iat_cat iadt_cat icdp_cat iaff_cat iuof_cat oqi_cat ///
    iurd_cat ietr_cat IPCS_cat IEDF_cat IAER_cat ICPF_cat IEH_cat IBPD_cat
confirm numeric variable `scores' `categories' formal_remittance, exact

* F5 continuous matrix and heatmap coefficients: one complete-case N.
* The matrix excludes formal_remittance even though the long table includes it.
correlate `scores'
display as text "F5 continuous matrix complete-case N: " as result r(N)

* F5 continuous long table: count complete observations separately for each pair.
* Report a missing coefficient when fewer than three rows or no variance support it.
local continuous `scores' formal_remittance
local columns : word count `continuous'
tempname R
forvalues i = 1/`=`columns'-1' {
    local x : word `i' of `continuous'
    forvalues j = `=`i'+1'/`columns' {
        local y : word `j' of `continuous'
        quietly count if !missing(`x', `y')
        local n = r(N)
        local rho = .
        if `n' > 2 {
            quietly summarize `x' if !missing(`x', `y')
            local sd_x = r(sd)
            quietly summarize `y' if !missing(`x', `y')
            if `sd_x' > 0 & `sd_x' < . & r(sd) > 0 & r(sd) < . {
                quietly correlate `x' `y' if !missing(`x', `y')
                matrix `R' = r(C)
                local rho = `R'[1,2]
            }
        }
        local high = abs(`rho') >= .50 & !missing(`rho')
        local theory = inlist("`x':`y'", "iat_score:iadt_score", ///
            "iadt_score:icdp_score", "oqi_score_01:ietr_score_01", ///
            "IEH:IBPD", "iurd_score_01:formal_remittance")
        display as text "Pearson `x' : `y' | N, rho, |rho|, high, theory: " ///
            as result `n' "  " `rho' "  " abs(`rho') "  " `high' "  " `theory'
    }
}

* F5 categorical long table: Cramer's V uses the observed table dimensions.
* Zero-marginal categories add no degrees of freedom.
local categorical `categories' formal_remittance
local columns : word count `categorical'
forvalues i = 1/`=`columns'-1' {
    local x : word `i' of `categorical'
    forvalues j = `=`i'+1'/`columns' {
        local y : word `j' of `categorical'
        quietly count if !missing(`x', `y')
        local n = r(N)
        local v = .
        local chi2 = .
        local p = .
        local rows = .
        local cols = .
        if `n' > 2 {
            quietly tabulate `x' `y'
            local rows = r(r)
            local cols = r(c)
            if min(`rows', `cols') > 1 {
                quietly tabulate `x' `y', chi2
                local chi2 = r(chi2)
                local p = r(p)
                local v = sqrt(`chi2'/(`n'*(min(`rows', `cols')-1)))
            }
        }
        local high = `v' >= .30 & !missing(`v')
        local theory = inlist("`x':`y'", "iat_cat:iadt_cat", "iadt_cat:icdp_cat", ///
            "oqi_cat:ietr_cat", "IEH_cat:IBPD_cat", "iurd_cat:formal_remittance")
        display as text "Cramer's V `x' : `y' | N, chi2, p, rows, cols, V, high, theory: " ///
            as result `n' "  " `chi2' "  " `p' "  " `rows' "  " `cols' ///
            "  " `v' "  " `high' "  " `theory'
    }
}
* The two flags above identify rows for the flagged-pairs sheet.
* Sorting, flag prose and workbook production belong to a later exhibit check.
