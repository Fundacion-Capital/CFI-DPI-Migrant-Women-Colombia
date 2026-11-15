/*-----------------------------------------------------------------------------
  Master do-file | Digital Payments, Partial Inclusion
  Jorge E. Zavala and Angélica Cardozo Cadavid
  Prepare the survey data and run the academic analysis. Stata 16.
-----------------------------------------------------------------------------*/
* Held for source review. Run only under a separate execution authorization.
exit 198

version 16
set more off
set varabbrev off

/* Contents
   1. Project paths
   2. Stata commands
   3. Data preparation and analysis
*/

* 1. Project paths
* Pass the repository, restricted archive root and restricted output folder.
* Use the archived admitted dataset, not a fresh survey download.
args repository restricted_archive restricted_output
if "`repository'" == "" | "`restricted_archive'" == "" | "`restricted_output'" == "" {
    error 198
}
local code "`repository'/1 Code/academic"
local carrier ///
    "`restricted_archive'/7132afe058718e790305f51e78a215b383d22009/2 Output/CFI_DPI Data for analysis.dta"

* 2. Stata commands
* The academic scripts use official Stata commands only. No add-ons to install.
which logit
which margins

* 3. Data preparation and analysis
* Start in an empty session. Keep any run log in the restricted output location.
if c(k) > 0 | c(N) > 0 {
    error 4
}

* Load research fields only; the 423 records already reflect the exclusions.
use formdef_version eligible_flag consent q1 q5 q3 q3_1 q3_5 q3_6 q3_7 q3_8 q3_12 q2_1 q2_2 q2_3 q4 q3_15 ///
    q3_16 q3_17 q3_20 q3_21 q3_22 q3_23 q4_1 q4_5 q4_6 q4_12 q4_13 q4_15 q4_16 q4_17 q4_24 q4_25 q4_26 q4_27 ///
    q5_13 q5_14 q5_15 q5_16 q5_21 q5_22 q5_23 q6_2 q6_4 q6_13 q6_14 q6_15 q6_6 q6_9 q6_11 q6_16 q6_17 q6_18 ///
    q6_20 q6_21 q6_22 q6_23 q6_24 q7_1 q7_2 q7_6 q7_7 q7_8 q7_9 q7_10 q7_5 q7_11 q7_12 q7_13 q7_14 q7_15 ///
    q9_4 q9_5 q9_6 q9_7 q9_8 q9_9 q9_11 q9_13 q9_16 q9_18 q9_19 q9_20 q9_1 q9_15 q9_17 q9_21 q9_22 q10_4 ///
    q10_6 q10_10 q10_11 q10_12 q10_13 q10_14 q10_16 q10_1 q10_2 using "`carrier'", clear
assert _N == 423

do "`code'/1 Data preparation.do"
save "`restricted_output'/academic_prepared.dta"
do "`code'/2 Analysis.do" "`restricted_output'"

* Run 3 E4 exhibits v3.do separately in an empty session with sealed E.4 ledgers.
* Historical replication scripts and Appendix C2 are not part of this master.

