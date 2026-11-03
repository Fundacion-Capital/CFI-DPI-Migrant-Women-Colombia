* TARGET33 P4: denominators and fixed input coverage only -- held source; no execution authority.
* The protected dispatcher must validate the pinned contract before invoking this selection.
assert "$wp07_target33_step" == "3"
tempname out
file open `out' using "$wp07_target33_out/coverage_denominators.csv", write text
file write `out' "coverage_id,question_or_candidate,applicable_n,valid_n,complete_input_n,reference_scope,status,limitation" _n
quietly count if _p24a_consent == 1
local applicable = r(N)
quietly count if _p24_consent == 1
file write `out' "P4.01,consent," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q1 == 1
local applicable = r(N)
quietly count if _p24_q1 == 1
file write `out' "P4.01,q1," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q10_1 == 1
local applicable = r(N)
quietly count if _p24_q10_1 == 1
file write `out' "P4.01,q10_1," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q10_10 == 1
local applicable = r(N)
quietly count if _p24_q10_10 == 1
file write `out' "P4.01,q10_10," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q10_11 == 1
local applicable = r(N)
quietly count if _p24_q10_11 == 1
file write `out' "P4.01,q10_11," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q10_12 == 1
local applicable = r(N)
quietly count if _p24_q10_12 == 1
file write `out' "P4.01,q10_12," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q10_13 == 1
local applicable = r(N)
quietly count if _p24_q10_13 == 1
file write `out' "P4.01,q10_13," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q10_14 == 1
local applicable = r(N)
quietly count if _p24_q10_14 == 1
file write `out' "P4.01,q10_14," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q10_16 == 1
local applicable = r(N)
quietly count if _p24_q10_16 == 1
file write `out' "P4.01,q10_16," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q10_2 == 1
local applicable = r(N)
quietly count if _p24_q10_2 == 1
file write `out' "P4.01,q10_2," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q10_4 == 1
local applicable = r(N)
quietly count if _p24_q10_4 == 1
file write `out' "P4.01,q10_4," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q10_6 == 1
local applicable = r(N)
quietly count if _p24_q10_6 == 1
file write `out' "P4.01,q10_6," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q2_1 == 1
local applicable = r(N)
quietly count if _p24_q2_1 == 1
file write `out' "P4.01,q2_1," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q2_2 == 1
local applicable = r(N)
quietly count if _p24_q2_2 == 1
file write `out' "P4.01,q2_2," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q2_3 == 1
local applicable = r(N)
quietly count if _p24_q2_3 == 1
file write `out' "P4.01,q2_3," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3 == 1
local applicable = r(N)
quietly count if _p24_q3 == 1
file write `out' "P4.01,q3," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_1 == 1
local applicable = r(N)
quietly count if _p24_q3_1 == 1
file write `out' "P4.01,q3_1," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_12 == 1
local applicable = r(N)
quietly count if _p24_q3_12 == 1
file write `out' "P4.01,q3_12," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_15 == 1
local applicable = r(N)
quietly count if _p24_q3_15 == 1
file write `out' "P4.01,q3_15," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_16 == 1
local applicable = r(N)
quietly count if _p24_q3_16 == 1
file write `out' "P4.01,q3_16," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_17 == 1
local applicable = r(N)
quietly count if _p24_q3_17 == 1
file write `out' "P4.01,q3_17," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_20 == 1
local applicable = r(N)
quietly count if _p24_q3_20 == 1
file write `out' "P4.01,q3_20," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_21 == 1
local applicable = r(N)
quietly count if _p24_q3_21 == 1
file write `out' "P4.01,q3_21," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_22 == 1
local applicable = r(N)
quietly count if _p24_q3_22 == 1
file write `out' "P4.01,q3_22," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_23 == 1
local applicable = r(N)
quietly count if _p24_q3_23 == 1
file write `out' "P4.01,q3_23," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_5 == 1
local applicable = r(N)
quietly count if _p24_q3_5 == 1
file write `out' "P4.01,q3_5," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_6 == 1
local applicable = r(N)
quietly count if _p24_q3_6 == 1
file write `out' "P4.01,q3_6," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_7 == 1
local applicable = r(N)
quietly count if _p24_q3_7 == 1
file write `out' "P4.01,q3_7," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_8 == 1
local applicable = r(N)
quietly count if _p24_q3_8 == 1
file write `out' "P4.01,q3_8," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4 == 1
local applicable = r(N)
quietly count if _p24_q4 == 1
file write `out' "P4.01,q4," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_1 == 1
local applicable = r(N)
quietly count if _p24_q4_1 == 1
file write `out' "P4.01,q4_1," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_12 == 1
local applicable = r(N)
quietly count if _p24_q4_12 == 1
file write `out' "P4.01,q4_12," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_13 == 1
local applicable = r(N)
quietly count if _p24_q4_13 == 1
file write `out' "P4.01,q4_13," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_15 == 1
local applicable = r(N)
quietly count if _p24_q4_15 == 1
file write `out' "P4.01,q4_15," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_16 == 1
local applicable = r(N)
quietly count if _p24_q4_16 == 1
file write `out' "P4.01,q4_16," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_17 == 1
local applicable = r(N)
quietly count if _p24_q4_17 == 1
file write `out' "P4.01,q4_17," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_24 == 1
local applicable = r(N)
quietly count if _p24_q4_24 == 1
file write `out' "P4.01,q4_24," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_25 == 1
local applicable = r(N)
quietly count if _p24_q4_25 == 1
file write `out' "P4.01,q4_25," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_26 == 1
local applicable = r(N)
quietly count if _p24_q4_26 == 1
file write `out' "P4.01,q4_26," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_27 == 1
local applicable = r(N)
quietly count if _p24_q4_27 == 1
file write `out' "P4.01,q4_27," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_5 == 1
local applicable = r(N)
quietly count if _p24_q4_5 == 1
file write `out' "P4.01,q4_5," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q4_6 == 1
local applicable = r(N)
quietly count if _p24_q4_6 == 1
file write `out' "P4.01,q4_6," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5 == 1
local applicable = r(N)
quietly count if _p24_q5 == 1
file write `out' "P4.01,q5," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_13 == 1
local applicable = r(N)
quietly count if _p24_q5_13 == 1
file write `out' "P4.01,q5_13," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_14 == 1
local applicable = r(N)
quietly count if _p24_q5_14 == 1
file write `out' "P4.01,q5_14," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_15 == 1
local applicable = r(N)
quietly count if _p24_q5_15 == 1
file write `out' "P4.01,q5_15," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_16 == 1
local applicable = r(N)
quietly count if _p24_q5_16 == 1
file write `out' "P4.01,q5_16," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_2 == 1
local applicable = r(N)
quietly count if _p24_q5_2 == 1
file write `out' "P4.01,q5_2," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_21 == 1
local applicable = r(N)
quietly count if _p24_q5_21 == 1
file write `out' "P4.01,q5_21," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_22 == 1
local applicable = r(N)
quietly count if _p24_q5_22 == 1
file write `out' "P4.01,q5_22," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_23 == 1
local applicable = r(N)
quietly count if _p24_q5_23 == 1
file write `out' "P4.01,q5_23," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_5 == 1
local applicable = r(N)
quietly count if _p24_q5_5 == 1
file write `out' "P4.01,q5_5," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_7 == 1
local applicable = r(N)
quietly count if _p24_q5_7 == 1
file write `out' "P4.01,q5_7," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q5_9 == 1
local applicable = r(N)
quietly count if _p24_q5_9 == 1
file write `out' "P4.01,q5_9," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_11 == 1
local applicable = r(N)
quietly count if _p24_q6_11 == 1
file write `out' "P4.01,q6_11," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_13 == 1
local applicable = r(N)
quietly count if _p24_q6_13 == 1
file write `out' "P4.01,q6_13," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_14 == 1
local applicable = r(N)
quietly count if _p24_q6_14 == 1
file write `out' "P4.01,q6_14," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_15 == 1
local applicable = r(N)
quietly count if _p24_q6_15 == 1
file write `out' "P4.01,q6_15," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_16 == 1
local applicable = r(N)
quietly count if _p24_q6_16 == 1
file write `out' "P4.01,q6_16," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_17 == 1
local applicable = r(N)
quietly count if _p24_q6_17 == 1
file write `out' "P4.01,q6_17," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_18 == 1
local applicable = r(N)
quietly count if _p24_q6_18 == 1
file write `out' "P4.01,q6_18," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_2 == 1
local applicable = r(N)
quietly count if _p24_q6_2 == 1
file write `out' "P4.01,q6_2," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_20 == 1
local applicable = r(N)
quietly count if _p24_q6_20 == 1
file write `out' "P4.01,q6_20," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_21 == 1
local applicable = r(N)
quietly count if _p24_q6_21 == 1
file write `out' "P4.01,q6_21," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_22 == 1
local applicable = r(N)
quietly count if _p24_q6_22 == 1
file write `out' "P4.01,q6_22," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_23 == 1
local applicable = r(N)
quietly count if _p24_q6_23 == 1
file write `out' "P4.01,q6_23," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_24 == 1
local applicable = r(N)
quietly count if _p24_q6_24 == 1
file write `out' "P4.01,q6_24," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_4 == 1
local applicable = r(N)
quietly count if _p24_q6_4 == 1
file write `out' "P4.01,q6_4," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_6 == 1
local applicable = r(N)
quietly count if _p24_q6_6 == 1
file write `out' "P4.01,q6_6," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q6_9 == 1
local applicable = r(N)
quietly count if _p24_q6_9 == 1
file write `out' "P4.01,q6_9," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_1 == 1
local applicable = r(N)
quietly count if _p24_q7_1 == 1
file write `out' "P4.01,q7_1," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_10 == 1
local applicable = r(N)
quietly count if _p24_q7_10 == 1
file write `out' "P4.01,q7_10," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_11 == 1
local applicable = r(N)
quietly count if _p24_q7_11 == 1
file write `out' "P4.01,q7_11," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_12 == 1
local applicable = r(N)
quietly count if _p24_q7_12 == 1
file write `out' "P4.01,q7_12," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_13 == 1
local applicable = r(N)
quietly count if _p24_q7_13 == 1
file write `out' "P4.01,q7_13," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_14 == 1
local applicable = r(N)
quietly count if _p24_q7_14 == 1
file write `out' "P4.01,q7_14," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_15 == 1
local applicable = r(N)
quietly count if _p24_q7_15 == 1
file write `out' "P4.01,q7_15," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_2 == 1
local applicable = r(N)
quietly count if _p24_q7_2 == 1
file write `out' "P4.01,q7_2," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_5 == 1
local applicable = r(N)
quietly count if _p24_q7_5 == 1
file write `out' "P4.01,q7_5," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_6 == 1
local applicable = r(N)
quietly count if _p24_q7_6 == 1
file write `out' "P4.01,q7_6," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_7 == 1
local applicable = r(N)
quietly count if _p24_q7_7 == 1
file write `out' "P4.01,q7_7," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_8 == 1
local applicable = r(N)
quietly count if _p24_q7_8 == 1
file write `out' "P4.01,q7_8," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q7_9 == 1
local applicable = r(N)
quietly count if _p24_q7_9 == 1
file write `out' "P4.01,q7_9," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_1 == 1
local applicable = r(N)
quietly count if _p24_q9_1 == 1
file write `out' "P4.01,q9_1," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_11 == 1
local applicable = r(N)
quietly count if _p24_q9_11 == 1
file write `out' "P4.01,q9_11," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_13 == 1
local applicable = r(N)
quietly count if _p24_q9_13 == 1
file write `out' "P4.01,q9_13," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_15 == 1
local applicable = r(N)
quietly count if _p24_q9_15 == 1
file write `out' "P4.01,q9_15," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_16 == 1
local applicable = r(N)
quietly count if _p24_q9_16 == 1
file write `out' "P4.01,q9_16," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_17 == 1
local applicable = r(N)
quietly count if _p24_q9_17 == 1
file write `out' "P4.01,q9_17," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_18 == 1
local applicable = r(N)
quietly count if _p24_q9_18 == 1
file write `out' "P4.01,q9_18," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_19 == 1
local applicable = r(N)
quietly count if _p24_q9_19 == 1
file write `out' "P4.01,q9_19," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_20 == 1
local applicable = r(N)
quietly count if _p24_q9_20 == 1
file write `out' "P4.01,q9_20," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_21 == 1
local applicable = r(N)
quietly count if _p24_q9_21 == 1
file write `out' "P4.01,q9_21," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_22 == 1
local applicable = r(N)
quietly count if _p24_q9_22 == 1
file write `out' "P4.01,q9_22," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_4 == 1
local applicable = r(N)
quietly count if _p24_q9_4 == 1
file write `out' "P4.01,q9_4," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_5 == 1
local applicable = r(N)
quietly count if _p24_q9_5 == 1
file write `out' "P4.01,q9_5," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_6 == 1
local applicable = r(N)
quietly count if _p24_q9_6 == 1
file write `out' "P4.01,q9_6," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_7 == 1
local applicable = r(N)
quietly count if _p24_q9_7 == 1
file write `out' "P4.01,q9_7," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_8 == 1
local applicable = r(N)
quietly count if _p24_q9_8 == 1
file write `out' "P4.01,q9_8," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q9_9 == 1
local applicable = r(N)
quietly count if _p24_q9_9 == 1
file write `out' "P4.01,q9_9," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Item-specific route; sentinel and unresolved excluded from valid" _n
quietly count if _p24a_q3_1 == 1 & _p24a_q3_5 == 1 & _p24a_q3_8 == 1
local applicable = r(N)
quietly count if _p24_q3_1 == 1 & _p24_q3_5 == 1 & _p24_q3_8 == 1
file write `out' "P4.02,IAT3," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Raw input coverage only; no candidate computed" _n
quietly count if _p24a_q2_1 == 1 & _p24a_q2_2 == 1
local applicable = r(N)
quietly count if _p24_q2_1 == 1 & _p24_q2_2 == 1
file write `out' "P4.02,IVS2_RAW_INPUTS," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Raw input coverage only; no candidate computed" _n
quietly count if _p24a_q3_16 == 1 & _p24a_q3_17 == 1
local applicable = r(N)
quietly count if _p24_q3_16 == 1 & _p24_q3_17 == 1
file write `out' "P4.02,IADT2," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Raw input coverage only; no candidate computed" _n
quietly count if _p24a_q3_15 == 1 & _p24a_q3_16 == 1 & _p24a_q3_17 == 1
local applicable = r(N)
quietly count if _p24_q3_15 == 1 & _p24_q3_16 == 1 & _p24_q3_17 == 1
file write `out' "P4.02,IADT3," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Raw input coverage only; no candidate computed" _n
quietly count if _p24a_q3_21 == 1 & _p24a_q3_22 == 1
local applicable = r(N)
quietly count if _p24_q3_21 == 1 & _p24_q3_22 == 1
file write `out' "P4.02,ICDP2," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Raw input coverage only; no candidate computed" _n
quietly count if _p24a_q4_5 == 1 & _p24a_q4_6 == 1
local applicable = r(N)
quietly count if _p24_q4_5 == 1 & _p24_q4_6 == 1
file write `out' "P4.02,IAFF2," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Raw input coverage only; no candidate computed" _n
quietly count if _p24a_q4_15 == 1 & _p24a_q4_24 == 1 & _p24a_q4_25 == 1
local applicable = r(N)
quietly count if _p24_q4_15 == 1 & _p24_q4_24 == 1 & _p24_q4_25 == 1
file write `out' "P4.02,IUOF3," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Raw input coverage only; no candidate computed" _n
quietly count if _p24a_q5_14 == 1 & _p24a_q5_23 == 1
local applicable = r(N)
quietly count if _p24_q5_14 == 1 & _p24_q5_23 == 1
file write `out' "P4.02,OQI2," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Raw input coverage only; no candidate computed" _n
quietly count if _p24a_q3_15 == 1 & _p24a_q3_16 == 1 & _p24a_q3_17 == 1
local applicable = r(N)
quietly count if _p24_q3_15 == 1 & _p24_q3_16 == 1 & _p24_q3_17 == 1
file write `out' "P4.03,IADT_common," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Intersection uses smartphone-only installation" _n
quietly count if _p24a_q6_13 == 1
local applicable = r(N)
quietly count if _p24_q6_13 == 1
file write `out' "P4.04,q6_13," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,No outcome binary created" _n
quietly count if _p24a_q3_1 == 1 & _p24a_q3_5 == 1 & _p24a_q3_8 == 1 & _p24a_q3_16 == 1 & _p24a_q3_17 == 1 & _p24a_q4_5 == 1 & _p24a_q4_6 == 1 & _p24a_q4 == 1 & _p24a_q2_2 == 1 & _p24a_q3 == 1 & _p24a_q6_13 == 1
local applicable = r(N)
quietly count if _p24_q3_1 == 1 & _p24_q3_5 == 1 & _p24_q3_8 == 1 & _p24_q3_16 == 1 & _p24_q3_17 == 1 & _p24_q4_5 == 1 & _p24_q4_6 == 1 & _p24_q4 == 1 & _p24_q2_2 == 1 & _p24_q3 == 1 & _p24_q6_13 == 1
file write `out' "P4.05,q6_13_main," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Potential input coverage not fitted sample" _n
quietly count if _p24a_q6_14 == 1
local applicable = r(N)
quietly count if _p24_q6_14 == 1
file write `out' "P4.04,q6_14," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,No outcome binary created" _n
quietly count if _p24a_q3_1 == 1 & _p24a_q3_5 == 1 & _p24a_q3_8 == 1 & _p24a_q3_16 == 1 & _p24a_q3_17 == 1 & _p24a_q4_5 == 1 & _p24a_q4_6 == 1 & _p24a_q4 == 1 & _p24a_q2_2 == 1 & _p24a_q3 == 1 & _p24a_q6_14 == 1
local applicable = r(N)
quietly count if _p24_q3_1 == 1 & _p24_q3_5 == 1 & _p24_q3_8 == 1 & _p24_q3_16 == 1 & _p24_q3_17 == 1 & _p24_q4_5 == 1 & _p24_q4_6 == 1 & _p24_q4 == 1 & _p24_q2_2 == 1 & _p24_q3 == 1 & _p24_q6_14 == 1
file write `out' "P4.05,q6_14_main," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Potential input coverage not fitted sample" _n
quietly count if _p24a_q3_1 == 1 & _p24a_q3_5 == 1 & _p24a_q3_8 == 1 & _p24a_q3_16 == 1 & _p24a_q3_17 == 1 & _p24a_q4_5 == 1 & _p24a_q4_6 == 1 & _p24a_q4 == 1 & _p24a_q2_2 == 1 & _p24a_q3 == 1 & _p24a_q6_13 == 1 & _p24a_q6_14 == 1
local applicable = r(N)
quietly count if _p24_q3_1 == 1 & _p24_q3_5 == 1 & _p24_q3_8 == 1 & _p24_q3_16 == 1 & _p24_q3_17 == 1 & _p24_q4_5 == 1 & _p24_q4_6 == 1 & _p24_q4 == 1 & _p24_q2_2 == 1 & _p24_q3 == 1 & _p24_q6_13 == 1 & _p24_q6_14 == 1
file write `out' "P4.05,common_outcome_inputs," (`applicable') "," (r(N)) "," (r(N)) ",coded_carrier,supported,Potential shared input coverage" _n
quietly count if !missing(q2_3)
file write `out' "P4.06,q2_3,NA," (r(N)) ",NA,coded_carrier,indeterminate,Raw availability only; no calendar source adopted" _n
quietly count if !missing(q2_1)
file write `out' "P4.06,q2_1,NA," (r(N)) ",NA,coded_carrier,indeterminate,Raw availability only; no calendar source adopted" _n
quietly count if !missing(SubmissionDate)
file write `out' "P4.06,SubmissionDate,NA," (r(N)) ",NA,coded_carrier,indeterminate,Raw availability only; no calendar source adopted" _n
quietly count if !missing(starttime)
file write `out' "P4.06,starttime,NA," (r(N)) ",NA,coded_carrier,indeterminate,Raw availability only; no calendar source adopted" _n
quietly count if !missing(endtime)
file write `out' "P4.06,endtime,NA," (r(N)) ",NA,coded_carrier,indeterminate,Raw availability only; no calendar source adopted" _n
quietly count if !missing(fecha)
file write `out' "P4.06,fecha,NA," (r(N)) ",NA,coded_carrier,indeterminate,Raw availability only; no calendar source adopted" _n
* Drop transient flags before comparing the in-memory projection signature.
drop _p24_consent _p24a_consent _p24_q1 _p24a_q1 _p24_q10_1 _p24a_q10_1 _p24_q10_10 _p24a_q10_10 _p24_q10_11 _p24a_q10_11 ///
    _p24_q10_12 _p24a_q10_12 _p24_q10_13 _p24a_q10_13 _p24_q10_14 _p24a_q10_14 _p24_q10_16 _p24a_q10_16 _p24_q10_2 _p24a_q10_2 ///
    _p24_q10_4 _p24a_q10_4 _p24_q10_6 _p24a_q10_6 _p24_q2_1 _p24a_q2_1 _p24_q2_2 _p24a_q2_2 _p24_q2_3 _p24a_q2_3 ///
    _p24_q3 _p24a_q3 _p24_q3_1 _p24a_q3_1 _p24_q3_12 _p24a_q3_12 _p24_q3_15 _p24a_q3_15 _p24_q3_16 _p24a_q3_16 ///
    _p24_q3_17 _p24a_q3_17 _p24_q3_20 _p24a_q3_20 _p24_q3_21 _p24a_q3_21 _p24_q3_22 _p24a_q3_22 _p24_q3_23 _p24a_q3_23 ///
    _p24_q3_5 _p24a_q3_5 _p24_q3_6 _p24a_q3_6 _p24_q3_7 _p24a_q3_7 _p24_q3_8 _p24a_q3_8 _p24_q4 _p24a_q4 ///
    _p24_q4_1 _p24a_q4_1 _p24_q4_12 _p24a_q4_12 _p24_q4_13 _p24a_q4_13 _p24_q4_15 _p24a_q4_15 _p24_q4_16 _p24a_q4_16 ///
    _p24_q4_17 _p24a_q4_17 _p24_q4_24 _p24a_q4_24 _p24_q4_25 _p24a_q4_25 _p24_q4_26 _p24a_q4_26 _p24_q4_27 _p24a_q4_27 ///
    _p24_q4_5 _p24a_q4_5 _p24_q4_6 _p24a_q4_6 _p24_q5 _p24a_q5 _p24_q5_13 _p24a_q5_13 _p24_q5_14 _p24a_q5_14 ///
    _p24_q5_15 _p24a_q5_15 _p24_q5_16 _p24a_q5_16 _p24_q5_2 _p24a_q5_2 _p24_q5_21 _p24a_q5_21 _p24_q5_22 _p24a_q5_22 ///
    _p24_q5_23 _p24a_q5_23 _p24_q5_5 _p24a_q5_5 _p24_q5_7 _p24a_q5_7 _p24_q5_9 _p24a_q5_9 _p24_q6_11 _p24a_q6_11 ///
    _p24_q6_13 _p24a_q6_13 _p24_q6_14 _p24a_q6_14 _p24_q6_15 _p24a_q6_15 _p24_q6_16 _p24a_q6_16 _p24_q6_17 _p24a_q6_17 ///
    _p24_q6_18 _p24a_q6_18 _p24_q6_2 _p24a_q6_2 _p24_q6_20 _p24a_q6_20 _p24_q6_21 _p24a_q6_21 _p24_q6_22 _p24a_q6_22 ///
    _p24_q6_23 _p24a_q6_23 _p24_q6_24 _p24a_q6_24 _p24_q6_4 _p24a_q6_4 _p24_q6_6 _p24a_q6_6 _p24_q6_9 _p24a_q6_9 ///
    _p24_q7_1 _p24a_q7_1 _p24_q7_10 _p24a_q7_10 _p24_q7_11 _p24a_q7_11 _p24_q7_12 _p24a_q7_12 _p24_q7_13 _p24a_q7_13 ///
    _p24_q7_14 _p24a_q7_14 _p24_q7_15 _p24a_q7_15 _p24_q7_2 _p24a_q7_2 _p24_q7_5 _p24a_q7_5 _p24_q7_6 _p24a_q7_6 ///
    _p24_q7_7 _p24a_q7_7 _p24_q7_8 _p24a_q7_8 _p24_q7_9 _p24a_q7_9 _p24_q9_1 _p24a_q9_1 _p24_q9_11 _p24a_q9_11 ///
    _p24_q9_13 _p24a_q9_13 _p24_q9_15 _p24a_q9_15 _p24_q9_16 _p24a_q9_16 _p24_q9_17 _p24a_q9_17 _p24_q9_18 _p24a_q9_18 ///
    _p24_q9_19 _p24a_q9_19 _p24_q9_20 _p24a_q9_20 _p24_q9_21 _p24a_q9_21 _p24_q9_22 _p24a_q9_22 _p24_q9_4 _p24a_q9_4 ///
    _p24_q9_5 _p24a_q9_5 _p24_q9_6 _p24a_q9_6 _p24_q9_7 _p24a_q9_7 _p24_q9_8 _p24a_q9_8 _p24_q9_9 _p24a_q9_9
quietly datasignature
assert "`r(datasignature)'" == "$wp07_target33_signature"
file write `out' "P4.07,carrier_integrity,NA,NA,NA,coded_carrier,supported,Projection signature unchanged" _n
file close `out'
file open `out' using "$wp07_target33_out/verification_readout.md", write text
file write `out' "# TARGET33 restricted no-fit verification" _n _n
file write `out' "Use the four aggregate ledgers and restricted execution receipt together. Counts describe the preserved coded cohort only." _n
file write `out' "NA is uncomputed or not applicable to the check. Unsupported and indeterminate evidence do not change membership." _n
file write `out' "No scores, fitted samples, participant rows or release clearance are produced." _n _n
file write `out' "- P1.01: carrier_and_membership_checks.csv" _n
file write `out' "- P1.02: carrier_and_membership_checks.csv" _n
file write `out' "- P1.03: carrier_and_membership_checks.csv" _n
file write `out' "- P1.04: carrier_and_membership_checks.csv" _n
file write `out' "- P1.05: carrier_and_membership_checks.csv" _n
file write `out' "- P1.06: carrier_and_membership_checks.csv" _n
file write `out' "- P1.07: carrier_and_membership_checks.csv" _n
file write `out' "- P1.08: carrier_and_membership_checks.csv" _n
file write `out' "- P1.09: carrier_and_membership_checks.csv" _n
file write `out' "- P2.01: version_route_domain_states.csv" _n
file write `out' "- P2.02: version_route_domain_states.csv" _n
file write `out' "- P2.03: version_route_domain_states.csv" _n
file write `out' "- P2.04: version_route_domain_states.csv" _n
file write `out' "- P2.05: version_route_domain_states.csv" _n
file write `out' "- P2.06: version_route_domain_states.csv" _n
file write `out' "- P2.07: version_route_domain_states.csv" _n
file write `out' "- P2.08: version_route_domain_states.csv" _n
file write `out' "- P2.09: version_route_domain_states.csv" _n
file write `out' "- P2.10: version_route_domain_states.csv" _n
file write `out' "- P3.01: time_geography_lineage.csv" _n
file write `out' "- P3.02: time_geography_lineage.csv" _n
file write `out' "- P3.03: time_geography_lineage.csv" _n
file write `out' "- P3.04: time_geography_lineage.csv" _n
file write `out' "- P3.05: time_geography_lineage.csv" _n
file write `out' "- P3.06: time_geography_lineage.csv" _n
file write `out' "- P4.01: coverage_denominators.csv" _n
file write `out' "- P4.02: coverage_denominators.csv" _n
file write `out' "- P4.03: coverage_denominators.csv" _n
file write `out' "- P4.04: coverage_denominators.csv" _n
file write `out' "- P4.05: coverage_denominators.csv" _n
file write `out' "- P4.06: coverage_denominators.csv" _n
file write `out' "- P4.07: coverage_denominators.csv" _n
file write `out' "- P4.08: verification_readout.md" _n
file close `out'
global wp07_target33_step 4
