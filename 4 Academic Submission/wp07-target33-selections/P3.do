* TARGET33 P3: time and residence lineage -- held source; no execution authority.
* The protected dispatcher must validate the pinned contract before invoking this selection.
assert "$wp07_target33_step" == "2"
tempname out
file open `out' using "$wp07_target33_out/time_geography_lineage.csv", write text
file write `out' "check_id,field,form_version,rule_id,checked_n,discrepancy_n,status,limitation" _n
quietly count if missing(SubmissionDate)
file write `out' "P3.01,SubmissionDate,,missing,423," (r(N)) ",indeterminate,No clock change" _n
quietly count if !missing(q2_1,SubmissionDate) & q2_1 > year(dofc(SubmissionDate))
file write `out' "P3.03,SubmissionDate,,arrival_after_candidate_year,NA," (r(N)) ",indeterminate,No calendar source adopted" _n
quietly count if missing(starttime)
file write `out' "P3.01,starttime,,missing,423," (r(N)) ",indeterminate,No clock change" _n
quietly count if !missing(q2_1,starttime) & q2_1 > year(dofc(starttime))
file write `out' "P3.03,starttime,,arrival_after_candidate_year,NA," (r(N)) ",indeterminate,No calendar source adopted" _n
quietly count if missing(endtime)
file write `out' "P3.01,endtime,,missing,423," (r(N)) ",indeterminate,No clock change" _n
quietly count if !missing(q2_1,endtime) & q2_1 > year(dofc(endtime))
file write `out' "P3.03,endtime,,arrival_after_candidate_year,NA," (r(N)) ",indeterminate,No calendar source adopted" _n
quietly count if missing(fecha)
file write `out' "P3.01,fecha,,missing,423," (r(N)) ",indeterminate,No clock change" _n
quietly count if !missing(q2_1,fecha) & q2_1 > year(fecha)
file write `out' "P3.03,fecha,,arrival_after_candidate_year,NA," (r(N)) ",indeterminate,No calendar source adopted" _n
quietly count if !missing(starttime,endtime) & starttime > endtime
file write `out' "P3.01,coded_clocks,,reversed_start_end,NA," (r(N)) ",indeterminate,Recorded clock comparison only" _n
quietly count if !missing(SubmissionDate,fecha) & dofc(SubmissionDate) != fecha
file write `out' "P3.01,coded_clocks,,fecha_agreement,NA," (r(N)) ",indeterminate,Recorded clock comparison only" _n
quietly count if formdef_version == 2512090157 & q3 == 1 & _p24_q3 == 1
file write `out' "P3.05,q3,2512090157,valid_bogota," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512090157 & q3 == 2 & _p24_q3 == 1
file write `out' "P3.05,q3,2512090157,valid_cali," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512090157 & q3 == 3 & _p24_q3 == 1
file write `out' "P3.05,q3,2512090157,valid_medellin," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512090157 & q3 == 4 & _p24_q3 == 1
file write `out' "P3.05,q3,2512090157,valid_other," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512090157 & _p24_q3 == 6
file write `out' "P3.05,q3,2512090157,version_domain_unresolved,NA," (r(N)) ",indeterminate,No locality inference" _n
quietly count if formdef_version == 2512091719 & q3 == 1 & _p24_q3 == 1
file write `out' "P3.05,q3,2512091719,valid_bogota," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512091719 & q3 == 2 & _p24_q3 == 1
file write `out' "P3.05,q3,2512091719,valid_cali," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512091719 & q3 == 3 & _p24_q3 == 1
file write `out' "P3.05,q3,2512091719,valid_medellin," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512091719 & q3 == 4 & _p24_q3 == 1
file write `out' "P3.05,q3,2512091719,valid_other," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512091719 & _p24_q3 == 6
file write `out' "P3.05,q3,2512091719,version_domain_unresolved,NA," (r(N)) ",indeterminate,No locality inference" _n
quietly count if formdef_version == 2512111044 & q3 == 1 & _p24_q3 == 1
file write `out' "P3.05,q3,2512111044,valid_bogota," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512111044 & q3 == 2 & _p24_q3 == 1
file write `out' "P3.05,q3,2512111044,valid_cali," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512111044 & q3 == 3 & _p24_q3 == 1
file write `out' "P3.05,q3,2512111044,valid_medellin," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512111044 & q3 == 4 & _p24_q3 == 1
file write `out' "P3.05,q3,2512111044,valid_soacha," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512111044 & _p24_q3 == 6
file write `out' "P3.05,q3,2512111044,version_domain_unresolved,NA," (r(N)) ",indeterminate,No locality inference" _n
quietly count if formdef_version == 2512121811 & q3 == 1 & _p24_q3 == 1
file write `out' "P3.05,q3,2512121811,valid_bogota," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512121811 & q3 == 2 & _p24_q3 == 1
file write `out' "P3.05,q3,2512121811,valid_cali," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512121811 & q3 == 3 & _p24_q3 == 1
file write `out' "P3.05,q3,2512121811,valid_medellin," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512121811 & q3 == 4 & _p24_q3 == 1
file write `out' "P3.05,q3,2512121811,valid_soacha," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2512121811 & _p24_q3 == 6
file write `out' "P3.05,q3,2512121811,version_domain_unresolved,NA," (r(N)) ",indeterminate,No locality inference" _n
quietly count if formdef_version == 2602120658 & q3 == 1 & _p24_q3 == 1
file write `out' "P3.05,q3,2602120658,valid_bogota," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2602120658 & q3 == 2 & _p24_q3 == 1
file write `out' "P3.05,q3,2602120658,valid_cali," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2602120658 & q3 == 3 & _p24_q3 == 1
file write `out' "P3.05,q3,2602120658,valid_medellin," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2602120658 & q3 == 4 & _p24_q3 == 1
file write `out' "P3.05,q3,2602120658,valid_soacha," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2602120658 & q3 == 5 & _p24_q3 == 1
file write `out' "P3.05,q3,2602120658,valid_meta_unspecified," (r(N)) ",NA,supported,Checked count is this restricted category only" _n
quietly count if formdef_version == 2602120658 & _p24_q3 == 6
file write `out' "P3.05,q3,2602120658,version_domain_unresolved,NA," (r(N)) ",indeterminate,No locality inference" _n
file write `out' "P3.02,coded_clocks,,historical_export_provenance,NA,NA,indeterminate,No raw export comparison" _n
file write `out' "P3.04,q2_1,,migration_duration,NA,NA,indeterminate,First arrival year only" _n
file write `out' "P3.06,q3,,historical_grouping,NA,NA,indeterminate,No pooling or overlay grouping applied" _n
file close `out'
global wp07_target33_step 3
