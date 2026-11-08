/* Test the exact new coverage emitters on preserved invented values only. */
version 16
args repository out
if "`repository'" == "" | "`out'" == "" {
    exit 198
}
if c(k) > 0 | c(N) > 0 {
    exit 4
}
mkdir "`out'/artificial-check"
copy "`out'/raw_classification.do" "`out'/artificial-check/raw_classification.do"
copy "`out'/prepared_construction.do" "`out'/artificial-check/prepared_construction.do"
use "`repository'/4 Academic Submission/audit-local/intake/package-e-artificial/raw_artificial.dta", clear
assert _N == 32
assert case_id == _n
drop case_id
set obs 423
gen double SubmissionDate = clock("2025-12-15 10:30:00","YMDhms") in 1/32
gen double starttime = clock("2025-12-15 10:00:00","YMDhms") in 1/32
gen double endtime = clock("2025-12-15 10:25:00","YMDhms") in 1/32
gen double fecha = dofc(SubmissionDate)
format SubmissionDate starttime endtime %tc
format fecha %td
save "`out'/artificial-check/synthetic_coverage_input.dta"
clear
quietly do "`repository'/4 Academic Submission/wp07-restricted-coverage/E2 Raw coverage.do" ///
    "`out'/artificial-check/synthetic_coverage_input.dta" "`out'/artificial-check"
quietly do "`repository'/4 Academic Submission/wp07-restricted-coverage/E3 Prepared coverage.do" ///
    "`out'/artificial-check/synthetic_coverage_input.dta" "`out'/artificial-check"
if c(k) > 0 | c(N) > 0 {
    exit 459
}
noisily display "Artificial coverage-emitter check completed; no study data was used."
