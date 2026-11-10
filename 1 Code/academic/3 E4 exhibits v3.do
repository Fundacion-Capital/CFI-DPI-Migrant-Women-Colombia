* E.5 v3: six exhibits from the five sealed E.4 aggregate CSV ledgers.
* No participant dataset, stored estimate, model fit or new hypothesis test.
* Run the marked body only through its separately authorized Stata MCP caller.
* Original master/preparation/analysis files and C2 remain held.
* Arguments: exact input directory and fresh restricted output directory.
* QS2 layout repair: saved-artifact rendering checked; native generation untested.
exit 198

* BEGIN E5 PRODUCER
args e5_input e5_output
version 16
set varabbrev off
assert _N == 0 & c(k) == 0
assert "`e5_input'" != "" & "`e5_output'" != ""
assert lower("`e5_input'") != lower("`e5_output'")

* Admit only the declared inputs and never overwrite an existing exhibit.
foreach filename in e4_model_status.csv e4_probabilities.csv e4_primary_tests.csv ///
    e4_native_matrices.csv e4_support.csv {
    confirm file "`e5_input'/`filename'"
}
foreach filename in QT1_models.tex QT1_models.csv QF1_core.pdf QF1_core.png ///
    QF1_core.csv QT2_primary.tex QT2_primary.csv QS1_comparisons.tex ///
    QS1_comparisons.csv QS2_endpoints.tex QS2_endpoints.csv ///
    QS3_coefficients.tex QS3_coefficients.csv QS3_covariance.csv ///
    QS3_support.csv CAPTIONS.txt e5_complete.csv {
    confirm new file "`e5_output'/`filename'"
}

* All frames, graphs and file handles below belong to this reporting call.
local original_frame "`c(frame)'"
tempname models probabilities primary matrices support coefficients variances comparisons
tempname qt1 qt2 qs1 qs2 qs3 captions receipt graph_r graph_d graph_both
local owned_frames "`models' `probabilities' `primary' `matrices' `support' `coefficients' `variances' `comparisons'"
local opened ""
foreach report_frame in `models' `probabilities' `primary' `matrices' `support' {
    frame create `report_frame'
}
capture noisily {
    * Model Ns are model-specific, not the admitted-cohort N or a response rate.
    frame change `models'
    import delimited "`e5_input'/e4_model_status.csv", varnames(1) stringcols(_all) clear
    assert _N == 5 & c(k) == 12
    isid model
    foreach field in intended_n attempted fit_rc estimator_n converged rank expected_rank ///
        sample_mismatch determined_successes determined_failures {
        destring `field', replace
        assert !missing(`field')
    }
    assert inlist(model, "R0_E4", "D0_E4", "R1_E4", "D1_E4", "R0C_E4")
    assert status == "ACCEPTED_WORKING_MODEL" & attempted == 1 & fit_rc == 0
    assert intended_n == estimator_n & estimator_n > rank & estimator_n == floor(estimator_n)
    assert converged == 1 & rank == expected_rank & sample_mismatch == 0
    assert rank == 10 if inlist(model, "R0_E4", "D0_E4", "R0C_E4")
    assert rank == 16 if inlist(model, "R1_E4", "D1_E4")
    gen byte model_order = .
    replace model_order = 1 if model == "R0_E4"
    replace model_order = 2 if model == "D0_E4"
    replace model_order = 3 if model == "R1_E4"
    replace model_order = 4 if model == "D1_E4"
    replace model_order = 5 if model == "R0C_E4"
    gen str3 model_label = subinstr(model, "_E4", "", .)
    gen str40 outcome = "Remittance retention/use"
    replace outcome = "Domestic participation (60 days)" if inlist(model, "D0_E4", "D1_E4")
    gen str30 role = "Core"
    replace role = "Extension" if inlist(model, "R1_E4", "D1_E4")
    replace role = "Common-observation core" if model == "R0C_E4"
    sort model_order

    * Preserve all forty-five records, including endpoints not drawn in QF1.
    frame change `probabilities'
    import delimited "`e5_input'/e4_probabilities.csv", varnames(1) stringcols(_all) clear
    isid model focal record
    assert _N == 45 & c(k) == 10
    foreach field in endpoint estimate se ll ul {
        destring `field', replace
    }
    assert status == "AVAILABLE_POINTWISE_WORKING_VCE"
    assert inlist(focal, "wp07_iat3", "wp07_iadt2", "wp07_iaff2")
    assert inlist(record, "lower", "higher", "higher_minus_lower")
    assert !missing(estimate, se, ll, ul) & se >= 0 & ll <= estimate & estimate <= ul
    assert units == "percentage_points" & missing(endpoint) if record == "higher_minus_lower"
    assert units == "probability" & inrange(estimate, 0, 1) if record != "higher_minus_lower"
    assert endpoint == .5 if record == "lower"
    assert endpoint == .75 if record == "higher" & focal != "wp07_iaff2"
    assert endpoint == 1 if record == "higher" & focal == "wp07_iaff2"
    bysort model focal: assert _N == 3
    frlink m:1 model, frame(`models') generate(model_link)
    assert !missing(model_link)
    frget model_order model_label estimator_n, from(model_link)
    gen byte focal_order = .
    replace focal_order = 1 if focal == "wp07_iat3"
    replace focal_order = 2 if focal == "wp07_iadt2"
    replace focal_order = 3 if focal == "wp07_iaff2"
    gen str50 candidate = "Access/basic use (IAT)"
    replace candidate = "Reported transfer/confidence (IADT)" if focal_order == 2
    replace candidate = "Own-name proof/telephone (IAFF)" if focal_order == 3
    gen str14 increment = "0.50 to 0.75"
    replace increment = "0.50 to 1.00" if focal_order == 3
    gen byte record_order = 1 if record == "lower"
    replace record_order = 2 if record == "higher"
    replace record_order = 3 if record == "higher_minus_lower"
    sort model_order focal_order record_order

    * Holm applies only to these six core coefficient-null Wald tests.
    frame change `primary'
    import delimited "`e5_input'/e4_primary_tests.csv", varnames(1) stringcols(_all) clear
    isid slot
    isid model field
    assert _N == 6 & c(k) == 7
    destring p_raw rank p_holm, replace
    assert status == "AVAILABLE_CONDITIONAL_WORKING_VCE"
    assert !missing(p_raw, p_holm, rank) & inrange(p_raw, 0, 1) & inrange(p_holm, p_raw, 1)
    assert inrange(rank, 1, 6) & rank == floor(rank)
    isid rank
    assert inlist(model, "R0_E4", "D0_E4")
    assert inlist(field, "wp07_iat3", "wp07_iadt2", "wp07_iaff2")
    gen str4 family = "R" if model == "R0_E4"
    replace family = "D" if model == "D0_E4"
    gen str4 construct = "IAT" if field == "wp07_iat3"
    replace construct = "IADT" if field == "wp07_iadt2"
    replace construct = "IAFF" if field == "wp07_iaff2"
    assert slot == family + "_" + construct
    frlink m:1 model, frame(`models') generate(model_link)
    assert !missing(model_link)
    frget model_order model_label estimator_n, from(model_link)
    gen byte focal_order = 1 if field == "wp07_iat3"
    replace focal_order = 2 if field == "wp07_iadt2"
    replace focal_order = 3 if field == "wp07_iaff2"
    gen str50 candidate = "Access/basic use (IAT)"
    replace candidate = "Reported transfer/confidence (IADT)" if focal_order == 2
    replace candidate = "Own-name proof/telephone (IAFF)" if focal_order == 3
    gen str16 raw_display = strtrim(string(p_raw, "%5.3f"))
    gen str16 holm_display = strtrim(string(p_holm, "%5.3f"))
    replace raw_display = char(36) + "<.001" + char(36) if p_raw < .001
    replace holm_display = char(36) + "<.001" + char(36) if p_holm < .001
    sort model_order focal_order

    * Native matrices are aggregate cells, never saved-model or respondent files.
    frame change `matrices'
    import delimited "`e5_input'/e4_native_matrices.csv", varnames(1) stringcols(_all) clear
    assert _N == 2262 & c(k) == 8
    destring row column value, replace
    isid model operation matrix row column
    assert !missing(row, column) & row >= 1 & column >= 1
    assert row == floor(row) & column == floor(column)
    frlink m:1 model, frame(`models') generate(model_link)
    assert !missing(model_link)
    frget model_order model_label estimator_n, from(model_link)
    assert !missing(value) if operation == "fit" & inlist(matrix, "e4_B", "e4_V")
    gen byte expected_columns = 12
    replace expected_columns = 19 if inlist(model, "R1_E4", "D1_E4")
    bysort model: egen int covariance_cells = total(operation == "fit" & matrix == "e4_V")
    assert covariance_cells == expected_columns^2
    assert row <= expected_columns & column <= expected_columns if operation == "fit" & matrix == "e4_V"

    frame change `support'
    import delimited "`e5_input'/e4_support.csv", varnames(1) stringcols(_all) clear
    assert _N == 186 & c(k) == 8
    destring level outcome n minimum maximum, replace
    isid model check field level outcome, missok
    assert !missing(n) & n >= 0 & n == floor(n)
    assert inlist(check, "outcome", "factor", "continuous", "endpoint")
    frlink m:1 model, frame(`models') generate(model_link)
    assert !missing(model_link)
    frget model_order estimator_n, from(model_link)
    assert n <= estimator_n
    assert !missing(minimum, maximum) & minimum < maximum & n == estimator_n if check == "continuous"
    assert missing(level) & missing(outcome) if check == "continuous"
    assert missing(minimum) & missing(maximum) if check != "continuous"
    assert inlist(outcome, 0, 1) if check != "continuous"
    assert missing(level) if check == "outcome"
    assert !missing(level) if inlist(check, "factor", "endpoint")

    * Build the technical coefficient table by exact B-column / V-diagonal keys.
    frame change `matrices'
    frame put model row column row_name column_name value model_order model_label ///
        estimator_n if operation == "fit" & matrix == "e4_B", into(`coefficients')
    frame put model column row_name column_name value if operation == "fit" & ///
        matrix == "e4_V" & row == column, into(`variances')
    frame change `variances'
    assert _N == 74
    isid model column
    assert row_name == column_name
    rename value variance
    rename column_name variance_name
    frame change `coefficients'
    assert _N == 74 & row == 1
    isid model column
    isid model column_name
    frlink 1:1 model column, frame(`variances') generate(variance_link)
    assert !missing(variance_link)
    frget variance variance_name, from(variance_link)
    assert column_name == variance_name
    rename value coefficient
    gen str45 term = substr(column_name, strpos(column_name, ":") + 1, .)
    gen byte reference = strpos(term, "b.") > 0
    assert coefficient == 0 & variance == 0 if reference
    assert variance > 0 & !missing(variance) if !reference
    quietly count if reference
    assert r(N) == 12
    gen double se = sqrt(variance) if !reference
    gen double ll = coefficient - invnormal(.975)*se if !reference
    gen double ul = coefficient + invnormal(.975)*se if !reference
    gen str65 term_label = ""
    replace term_label = "Access/basic use (IAT)" if term == "wp07_iat3"
    replace term_label = "Reported transfer/confidence (IADT)" if term == "wp07_iadt2"
    replace term_label = "Own-name proof/telephone (IAFF)" if term == "wp07_iaff2"
    replace term_label = "Age (years)" if term == "q4"
    replace term_label = "Below completed secondary" if term == "1.e4_education3"
    replace term_label = "Completed secondary (reference)" if term == "2b.e4_education3"
    replace term_label = "Any reported postsecondary" if term == "3.e4_education3"
    replace term_label = "Bogota (reference)" if term == "1b.e4_residence4"
    replace term_label = "Cali" if term == "2.e4_residence4"
    replace term_label = "Medellin" if term == "3.e4_residence4"
    replace term_label = "Other recorded residence responses" if term == "4.e4_residence4"
    replace term_label = "Employer/independent" if term == "1.e4_occupation6"
    replace term_label = "Employee/worker (reference)" if term == "3b.e4_occupation6"
    replace term_label = "Paid domestic work" if term == "4.e4_occupation6"
    replace term_label = "Student/pensioner/not currently working" if term == "5.e4_occupation6"
    replace term_label = "Unpaid family work" if term == "7.e4_occupation6"
    replace term_label = "Other occupation response" if term == "9.e4_occupation6"
    replace term_label = "Original first-arrival year (not tenure)" if term == "q2_1"
    replace term_label = "Intercept (year zero in extensions)" if term == "_cons"
    assert term_label != ""
    sort model_order column

    * Fixed contrasts retain native percentage-point units and exact zero inclusion.
    frame change `probabilities'
    frame put model focal candidate increment estimate se ll ul units status ///
        model_order model_label focal_order estimator_n if record == "higher_minus_lower", into(`comparisons')
    frame change `comparisons'
    assert _N == 15
    isid model focal
    gen str14 zero_relation = "Includes zero" if ll <= 0 & ul >= 0
    replace zero_relation = "Above zero" if ll > 0
    replace zero_relation = "Below zero" if ul < 0
    sort model_order focal_order

    * All input/link/availability checks precede the first output file.
    frame change `models'
    * frlink sorts the linked frame; restore display order only at emission.
    sort model_order
    format intended_n estimator_n %9.0f
    export delimited model model_label outcome role intended_n estimator_n status ///
        using "`e5_output'/QT1_models.csv", datafmt
    file open `qt1' using "`e5_output'/QT1_models.tex", write text
    local opened "`opened' `qt1'"
    file write `qt1' "\begin{table}[htbp]\centering\small" _n ///
        "\caption{Model roles and estimation samples}\label{tab:qt1-models}" _n ///
        "\setlength{\tabcolsep}{3pt}\begin{tabular}{lp{.23\linewidth}p{.19\linewidth}p{.15\linewidth}rr}\hline" _n ///
        "Model & Outcome & Role & Status & Intended N & Estimator N \tabularnewline \hline" _n
    forvalues i = 1/5 {
        file write `qt1' (model_label[`i']) " & " (outcome[`i']) " & " (role[`i']) ///
            " & Accepted working & " %9.0f (intended_n[`i']) " & " %9.0f (estimator_n[`i']) " \tabularnewline" _n
    }
    file write `qt1' "\hline\end{tabular}" _n ///
        "\medskip\par\begin{tabular}{lp{.75\linewidth}}\hline Candidate/outcome & Definition (all required components observed) \tabularnewline\hline" _n ///
        "IAT & Fixed mean of phone access, Internet frequency and running-out response; original item spacing is retained. Not a validated literacy scale. \tabularnewline" _n ///
        "IADT & Fixed mean of reported transfer and confidence items, each mapped from its five ordered responses to zero--one. The smartphone-only app item is not included. \tabularnewline" _n ///
        "IAFF & Fixed mean of two reported own-name conditions: address proof and telephone. It is not a full measure of account access or legal eligibility. \tabularnewline" _n ///
        "Remittance & q6.13: any reported digital retention/use versus taking everything in cash; not receipt channel or a measured money fraction. \tabularnewline" _n ///
        "Domestic & q6.14: separate reported domestic digital participation within 60 days; not transaction frequency. \tabularnewline\hline\end{tabular}" _n ///
        "\par\begin{minipage}{\linewidth}\footnotesize All models include the three fixed candidates, age, grouped education and recorded residence. Extensions add grouped occupation and original arrival year; R0C uses the shared core base. Model masks do not change the admitted cohort. Acceptance means programmed working-model gates passed, not scientific or population validation.\end{minipage}\end{table}" _n
    file close `qt1'

    * QF1: two panels with the same x-axis; no clipping or p-value filtering.
    frame change `comparisons'
    format estimate se ll ul %25.16e
    export delimited model focal increment estimator_n estimate se ll ul zero_relation ///
        if inlist(model, "R0_E4", "D0_E4") using "`e5_output'/QF1_core.csv", datafmt
    quietly levelsof estimator_n if model == "R0_E4", local(remittance_n) clean
    quietly levelsof estimator_n if model == "D0_E4", local(domestic_n) clean
    twoway (rcap ll ul focal_order if model == "R0_E4", horizontal lcolor(black)) ///
        (scatter focal_order estimate if model == "R0_E4", msymbol(O) mcolor(black)), ///
        ylabel(1 "IAT: 0.50 to 0.75" 2 "IADT: 0.50 to 0.75" 3 "IAFF: 0.50 to 1.00", angle(0) labsize(small)) ///
        yscale(reverse) ytitle("") xtitle("Adjusted difference (percentage points)") ///
        xlabel(, format(%5.1f)) ///
        xline(0, lcolor(gs8)) legend(off) title("Remittance retention/use" "N = `remittance_n'", size(medsmall)) ///
        scheme(s1mono) name(`graph_r') nodraw
    twoway (rcap ll ul focal_order if model == "D0_E4", horizontal lcolor(black)) ///
        (scatter focal_order estimate if model == "D0_E4", msymbol(D) mcolor(black)), ///
        ylabel(1 "IAT: 0.50 to 0.75" 2 "IADT: 0.50 to 0.75" 3 "IAFF: 0.50 to 1.00", angle(0) labsize(small)) ///
        yscale(reverse) ytitle("") xtitle("Adjusted difference (percentage points)") ///
        xlabel(, format(%5.1f)) ///
        xline(0, lcolor(gs8)) legend(off) title("Domestic participation (60 days)" "N = `domestic_n'", size(medsmall)) ///
        scheme(s1mono) name(`graph_d') nodraw
    graph combine `graph_r' `graph_d', cols(2) xcommon ycommon ///
        title("Fixed candidate comparisons in the recruited cohort", size(medsmall)) ///
        note("95% pointwise conditional delta intervals; not Holm-adjusted or causal effects." ///
        "Candidate increments differ. Exact N, bounds and zero inclusion: QF1 CSV and QS1.", size(vsmall)) ///
        graphregion(color(white)) xsize(11) ysize(4.5) name(`graph_both')
    graph export "`e5_output'/QF1_core.pdf", name(`graph_both') as(pdf)
    graph export "`e5_output'/QF1_core.png", name(`graph_both') as(png) width(3300)

    frame change `primary'
    format p_raw p_holm %25.16e
    export delimited slot model field estimator_n p_raw p_holm status ///
        using "`e5_output'/QT2_primary.csv", datafmt
    file open `qt2' using "`e5_output'/QT2_primary.tex", write text
    local opened "`opened' `qt2'"
    file write `qt2' "\begin{table}[htbp]\centering\small" _n ///
        "\caption{Six primary coefficient-null Wald tests}\label{tab:qt2-primary}" _n ///
        "\setlength{\tabcolsep}{3pt}\begin{tabular}{lp{.47\linewidth}rrr}\hline Model & Candidate & N & Raw p & Holm p \tabularnewline \hline" _n
    forvalues i = 1/6 {
        file write `qt2' (model_label[`i']) " & " (candidate[`i']) " & " ///
            %9.0f (estimator_n[`i']) " & " (raw_display[`i']) " & " (holm_display[`i']) " \tabularnewline" _n
    }
    file write `qt2' "\hline\end{tabular}" _n ///
        "\par\begin{minipage}{\linewidth}\footnotesize Fixed family of six coefficient-null tests in R0 and D0 only. Working robust covariance assumes independent records; it does not correct unrecorded network/household dependence. These p-values are not simultaneous intervals for QF1. No significance stars or substituted extension tests.\end{minipage}\end{table}" _n
    file close `qt2'

    frame change `comparisons'
    export delimited model focal increment estimator_n estimate se ll ul zero_relation units status ///
        using "`e5_output'/QS1_comparisons.csv", datafmt
    file open `qs1' using "`e5_output'/QS1_comparisons.tex", write text
    local opened "`opened' `qs1'"
    file write `qs1' "\begingroup\small\setlength{\tabcolsep}{3pt}\begin{longtable}{p{.06\linewidth}p{.26\linewidth}rrrp{.18\linewidth}p{.14\linewidth}}" _n ///
        "\caption{All fixed-endpoint adjusted probability comparisons}\label{tab:qs1-comparisons}\tabularnewline" _n ///
        "\hline Model & Candidate / increment & N & Difference & SE & 95\% interval & Zero \tabularnewline \hline\endfirsthead" _n ///
        "\hline Model & Candidate / increment & N & Difference & SE & 95\% interval & Zero \tabularnewline \hline\endhead" _n ///
        "\hline\endfoot" _n ///
        "\hline\multicolumn{7}{p{.94\linewidth}}{\footnotesize Differences, SEs and bounds are percentage points; intervals are pointwise conditional delta, not simultaneous. Higher minus lower, averaged over each unchanged model sample with other covariates observed. Unequal candidate increments are not comparable policy doses. Zero labels use unrounded bounds; the audit CSV retains exact bounds if rounding hides their sign. No cross-model/outcome difference test.}\tabularnewline\endlastfoot" _n
    forvalues i = 1/15 {
        file write `qs1' (model_label[`i']) " & " (candidate[`i']) " / " (increment[`i']) " & " ///
            %9.0f (estimator_n[`i']) " & " %7.2f (estimate[`i']) " & " %7.2f (se[`i']) ///
            " & [" %7.2f (ll[`i']) ", " %7.2f (ul[`i']) "] & " (zero_relation[`i']) " \tabularnewline" _n
        if ll[`i'] != 0 & round(ll[`i'], .01) == 0 {
            file write `qs1' "\multicolumn{7}{p{.95\linewidth}}{\footnotesize " ///
                (model_label[`i']) " / " (candidate[`i']) ": precise lower bound " ///
                %25.16e (ll[`i']) " percentage points.} \tabularnewline" _n
        }
        if ul[`i'] != 0 & round(ul[`i'], .01) == 0 {
            file write `qs1' "\multicolumn{7}{p{.95\linewidth}}{\footnotesize " ///
                (model_label[`i']) " / " (candidate[`i']) ": precise upper bound " ///
                %25.16e (ul[`i']) " percentage points.} \tabularnewline" _n
        }
    }
    file write `qs1' "\end{longtable}\endgroup" _n
    file close `qs1'

    frame change `probabilities'
    format endpoint estimate se ll ul %25.16e
    export delimited model focal record endpoint estimator_n estimate se ll ul units status ///
        if record != "higher_minus_lower" using "`e5_output'/QS2_endpoints.csv", datafmt
    file open `qs2' using "`e5_output'/QS2_endpoints.tex", write text
    local opened "`opened' `qs2'"
    * Reserve the full notes height so longtable, not the outer page builder, breaks QS2.
    file write `qs2' "\begingroup\small\setlength{\tabcolsep}{3pt}\begin{longtable}{p{.06\linewidth}p{.26\linewidth}rrrrp{.22\linewidth}}" _n ///
        "\caption{Model-standardized endpoint probabilities}\label{tab:qs2-endpoints}\tabularnewline" _n ///
        "\hline Model & Candidate & Endpoint & N & Probability & SE & 95\% interval \tabularnewline \hline\endfirsthead" _n ///
        "\hline Model & Candidate & Endpoint & N & Probability & SE & 95\% interval \tabularnewline \hline\endhead" _n ///
        "\hline\multicolumn{7}{p{.94\linewidth}}{\phantom{\parbox[t]{\linewidth}{\footnotesize Probability units, not percentages or observed prevalence. Each endpoint sets one candidate and averages predictions over that model's estimation sample; other covariates remain observed. Native pointwise conditional delta bounds are not clipped to zero/one. These are not within-woman transitions.{\small\strut}}}}\tabularnewline\noalign{\kern0pt}\endfoot" _n ///
        "\hline\multicolumn{7}{p{.94\linewidth}}{\footnotesize Probability units, not percentages or observed prevalence. Each endpoint sets one candidate and averages predictions over that model's estimation sample; other covariates remain observed. Native pointwise conditional delta bounds are not clipped to zero/one. These are not within-woman transitions.}\tabularnewline\noalign{\kern0pt}\endlastfoot" _n
    forvalues i = 1/45 {
        if record[`i'] != "higher_minus_lower" {
            file write `qs2' (model_label[`i']) " & " (candidate[`i']) " & " %4.2f (endpoint[`i']) ///
                " & " %9.0f (estimator_n[`i']) " & " %6.3f (estimate[`i']) " & " %6.3f (se[`i']) ///
                " & [" %6.3f (ll[`i']) ", " %6.3f (ul[`i']) "] \tabularnewline" _n
        }
    }
    file write `qs2' "\end{longtable}\endgroup" _n
    file close `qs2'

    frame change `coefficients'
    format coefficient variance se ll ul %25.16e
    export delimited model column column_name term_label estimator_n coefficient variance reference se ll ul ///
        using "`e5_output'/QS3_coefficients.csv", datafmt
    file open `qs3' using "`e5_output'/QS3_coefficients.tex", write text
    local opened "`opened' `qs3'"
    file write `qs3' "\begingroup\small\setlength{\tabcolsep}{3pt}\begin{longtable}{p{.06\linewidth}p{.34\linewidth}rrrp{.24\linewidth}}" _n ///
        "\caption{Native logit coefficients and covariance-derived uncertainty}\label{tab:qs3-coefficients}\tabularnewline" _n ///
        "\hline Model & Term & N & Coefficient & SE & 95\% interval \tabularnewline \hline\endfirsthead" _n ///
        "\hline Model & Term & N & Coefficient & SE & 95\% interval \tabularnewline \hline\endhead" _n ///
        "\hline\endfoot" _n ///
        "\hline\multicolumn{6}{p{.94\linewidth}}{\footnotesize Coefficients are log odds, not probability effects. SEs equal the square root of the saved working covariance diagonal; intervals use the normal 0.975 quantile. No fitted model is restored, no estimator is run and no control p-value is created. References are coding constraints, not estimated zero effects. Original arrival year is uncentered, so extension intercepts at year zero have no substantive baseline interpretation. QS3 covariance/support CSVs remain restricted pending disclosure review.}\tabularnewline\endlastfoot" _n
    forvalues i = 1/74 {
        file write `qs3' (model_label[`i']) " & " (term_label[`i']) " & " %9.0f (estimator_n[`i']) " & "
        if reference[`i'] {
            file write `qs3' "Reference & -- & -- \tabularnewline" _n
        }
        else {
            file write `qs3' %7.3f (coefficient[`i']) " & " %7.3f (se[`i']) ///
                " & [" %7.3f (ll[`i']) ", " %7.3f (ul[`i']) "] \tabularnewline" _n
        }
    }
    file write `qs3' "\end{longtable}\endgroup" _n
    file close `qs3'
    frame change `matrices'
    sort model_order row column
    format value %25.16e
    export delimited model row column row_name column_name value if operation == "fit" & ///
        matrix == "e4_V" using "`e5_output'/QS3_covariance.csv", datafmt
    frame change `support'
    sort model_order check field level outcome
    format minimum maximum %25.16e
    export delimited model check field level outcome n minimum maximum ///
        using "`e5_output'/QS3_support.csv", datafmt

    * Captions travel with the exhibits; no manuscript or external-link update.
    file open `captions' using "`e5_output'/CAPTIONS.txt", write text
    local opened "`opened' `captions'"
    file write `captions' "RESTRICTED CANDIDATES: exact-version author/disclosure/institutional release review remains separate." _n ///
        "QT1: Model-specific intended and estimator Ns; controls are IAT/IADT/IAFF candidates, age, education and recorded residence. Extensions add occupation and original first-arrival year; R0C uses the shared core base." _n ///
        "QF1: Fixed higher-minus-lower adjusted probability differences, averaged over each own estimation sample. Units are percentage points. Bars are 95% pointwise conditional delta intervals with independent-record working robust covariance, not Holm-adjusted simultaneous intervals or causal effects. Exact Ns and bounds are in the paired CSV and QS1." _n ///
        "QT2: All six core coefficient-null Wald tests and fixed-six Holm p-values. No extension test replaces a primary slot. Unequal increments and different outcomes are not directly comparable effects." _n ///
        "QS1: All fifteen comparisons; no significance filter, refit or cross-model/outcome test. Zero inclusion uses unrounded bounds." _n ///
        "QS2: All thirty endpoint predictions in probability units. Model-standardized, not observed prevalence or longitudinal transitions; no interval clipping." _n ///
        "QS3: Full coefficient and covariance record, with covariance-derived SE/normal intervals, reference constraints and restricted support cells. No new p-values, likelihood or pseudo-R2. Conditional working covariance does not correct unknown network/household dependence." _n ///
        "DEFINITIONS: IAT=fixed phone/internet/runout candidate; IADT=reported transfer/confidence; IAFF=own-name proof/phone conditions. Not validated literacy/empowerment measures. Remittance retention/use differs from receipt channel and domestic 60-day participation. No national or Bre-B causal inference. C2 remains HOLD." _n
    file close `captions'
    file open `receipt' using "`e5_output'/e5_complete.csv", write text
    local opened "`opened' `receipt'"
    file write `receipt' "slot,rows,status" _n "QT1,5,COMPLETE" _n "QF1,6,COMPLETE" _n ///
        "QT2,6,COMPLETE" _n "QS1,15,COMPLETE" _n "QS2,30,COMPLETE" _n "QS3,74,COMPLETE" _n
    file close `receipt'
}
local e5_rc = _rc
* Preserve partial outputs after errors; close/drop only resources owned here.
foreach handle of local opened {
    capture file close `handle'
}
frame change `original_frame'
foreach report_frame of local owned_frames {
    capture frame drop `report_frame'
}
foreach report_graph in `graph_r' `graph_d' `graph_both' {
    capture graph drop `report_graph'
}
if `e5_rc' != 0 {
    exit `e5_rc'
}
assert _N == 0 & c(k) == 0
display as text "E5_COMPLETE: rc=0 N=0 K=0"
* END E5 PRODUCER
