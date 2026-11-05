* Barrier state regression cases -- artificial-only draft, not run.
* No source or participant file is loaded. Do not remove the hold under this task.
exit 198

version 16
assert _N == 0
* Literal artificial inputs; expected states are hand-authored, not calculated by the recipe.
input str4 case_id double formdef_version byte eligible_flag double q10_1 str20 q10_2 byte expected_main byte expected_additional
"B01" 2512090157 1 4 "4" 1 1
"B02" 2512090157 1 4 "2 4" 1 1
"B03" 2512091719 1 4 "4" 1 1
"B04" 2512091719 1 4 "2 4" 1 1
"B05" 2512111044 1 4 "4" 1 1
"B06" 2512111044 1 4 "2 4" 1 1
"B07" 2512121811 1 4 "4" 1 1
"B08" 2512121811 1 4 "2 4" 1 1
"B09" 2602120658 1 4 "4" 1 1
"B10" 2602120658 1 4 "2 4" 1 1
"B11" 2512090157 1 16 "1" 6 6
"B12" 2602120658 1 16 "1" 1 1
"B13" 2512090157 1 11 "16 4" 1 1
"B14" 2602120658 1 16 "16 4" 1 6
"B15" 2602120658 1 98 "98" 5 5
"B16" 2512090157 1 98 "98" 6 5
"B17" 2602120658 1 4 "98 4" 1 6
"B18" 2602120658 1 4 "4 4" 1 6
"B19" 2602120658 1 13 "13" 6 6
"B20" 2602120658 1 4 "04" 1 6
"B21" 2602120658 1 4 " 4  2 " 1 1
"B22" 2602120658 1 . "" 4 4
"B23" 2602120658 0 . "" 2 2
"B24" 2602120658 0 4 "4" 6 6
"B25" 2602120658 . . "" 6 6
"B26" 9999999999 1 4 "4" 6 6
"B27" 2602120658 1 4.5 "4" 6 1
"B28" 2602120658 1 4 "4x" 1 6
"B29" 2602120658 1 16 "16" 1 1
"B30" 2512090157 1 11 "16" 1 1
end

* BEGIN P2_q10_1
quietly gen byte _p24_q10_1 = 6
quietly gen byte _p24a_q10_1 = .
quietly replace _p24a_q10_1 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_1 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_1 = 2 if formdef_version == 2512090157 & _p24a_q10_1 == 0 & (missing(q10_1))
quietly replace _p24_q10_1 = 4 if formdef_version == 2512090157 & _p24a_q10_1 == 1 & (missing(q10_1))
quietly replace _p24_q10_1 = 1 if formdef_version == 2512090157 & _p24a_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11)
quietly replace _p24a_q10_1 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_1 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_1 = 2 if formdef_version == 2512091719 & _p24a_q10_1 == 0 & (missing(q10_1))
quietly replace _p24_q10_1 = 4 if formdef_version == 2512091719 & _p24a_q10_1 == 1 & (missing(q10_1))
quietly replace _p24_q10_1 = 1 if formdef_version == 2512091719 & _p24a_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
quietly replace _p24_q10_1 = 5 if formdef_version == 2512091719 & _p24_q10_1 == 1 & (q10_1 == 98)
quietly replace _p24a_q10_1 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_1 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_1 = 2 if formdef_version == 2512111044 & _p24a_q10_1 == 0 & (missing(q10_1))
quietly replace _p24_q10_1 = 4 if formdef_version == 2512111044 & _p24a_q10_1 == 1 & (missing(q10_1))
quietly replace _p24_q10_1 = 1 if formdef_version == 2512111044 & _p24a_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
quietly replace _p24_q10_1 = 5 if formdef_version == 2512111044 & _p24_q10_1 == 1 & (q10_1 == 98)
quietly replace _p24a_q10_1 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_1 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_1 = 2 if formdef_version == 2512121811 & _p24a_q10_1 == 0 & (missing(q10_1))
quietly replace _p24_q10_1 = 4 if formdef_version == 2512121811 & _p24a_q10_1 == 1 & (missing(q10_1))
quietly replace _p24_q10_1 = 1 if formdef_version == 2512121811 & _p24a_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
quietly replace _p24_q10_1 = 5 if formdef_version == 2512121811 & _p24_q10_1 == 1 & (q10_1 == 98)
quietly replace _p24a_q10_1 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_1 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_1 = 2 if formdef_version == 2602120658 & _p24a_q10_1 == 0 & (missing(q10_1))
quietly replace _p24_q10_1 = 4 if formdef_version == 2602120658 & _p24a_q10_1 == 1 & (missing(q10_1))
quietly replace _p24_q10_1 = 1 if formdef_version == 2602120658 & _p24a_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
quietly replace _p24_q10_1 = 5 if formdef_version == 2602120658 & _p24_q10_1 == 1 & (q10_1 == 98)
* END P2_q10_1

* BEGIN P2_q10_2
quietly gen byte _p24_q10_2 = 6
quietly gen byte _p24a_q10_2 = .
quietly replace _p24a_q10_2 = 1 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_2 = 0 if formdef_version == 2512090157 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_2 = 2 if formdef_version == 2512090157 & _p24a_q10_2 == 0 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 4 if formdef_version == 2512090157 & _p24a_q10_2 == 1 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 1 if formdef_version == 2512090157 & _p24a_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q10_2 = 6 if formdef_version == 2512090157 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512090157 & _p24_q10_2 == 1 & (strtrim(q10_2) == "98")
quietly replace _p24a_q10_2 = 1 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_2 = 0 if formdef_version == 2512091719 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_2 = 2 if formdef_version == 2512091719 & _p24a_q10_2 == 0 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 4 if formdef_version == 2512091719 & _p24a_q10_2 == 1 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 1 if formdef_version == 2512091719 & _p24a_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q10_2 = 6 if formdef_version == 2512091719 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 6 if formdef_version == 2512091719 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512091719 & _p24_q10_2 == 1 & (strtrim(q10_2) == "98")
quietly replace _p24a_q10_2 = 1 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_2 = 0 if formdef_version == 2512111044 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_2 = 2 if formdef_version == 2512111044 & _p24a_q10_2 == 0 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 4 if formdef_version == 2512111044 & _p24a_q10_2 == 1 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 1 if formdef_version == 2512111044 & _p24a_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q10_2 = 6 if formdef_version == 2512111044 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 6 if formdef_version == 2512111044 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512111044 & _p24_q10_2 == 1 & (strtrim(q10_2) == "98")
quietly replace _p24a_q10_2 = 1 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_2 = 0 if formdef_version == 2512121811 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_2 = 2 if formdef_version == 2512121811 & _p24a_q10_2 == 0 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 4 if formdef_version == 2512121811 & _p24a_q10_2 == 1 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 1 if formdef_version == 2512121811 & _p24a_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q10_2 = 6 if formdef_version == 2512121811 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 6 if formdef_version == 2512121811 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2512121811 & _p24_q10_2 == 1 & (strtrim(q10_2) == "98")
quietly replace _p24a_q10_2 = 1 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
quietly replace _p24a_q10_2 = 0 if formdef_version == 2602120658 & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
quietly replace _p24_q10_2 = 2 if formdef_version == 2602120658 & _p24a_q10_2 == 0 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 4 if formdef_version == 2602120658 & _p24a_q10_2 == 1 & (strtrim(q10_2) == "")
quietly replace _p24_q10_2 = 1 if formdef_version == 2602120658 & _p24a_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
quietly replace _p24_q10_2 = 6 if formdef_version == 2602120658 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 6 if formdef_version == 2602120658 & _p24_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
quietly replace _p24_q10_2 = 5 if formdef_version == 2602120658 & _p24_q10_2 == 1 & (strtrim(q10_2) == "98")
* END P2_q10_2

assert _N == 30
assert _p24_q10_1 == expected_main
assert _p24_q10_2 == expected_additional
* Unknown-version values above intentionally exceed float precision: version stays double.

* BEGIN REPORT_BARRIER_q10_1
gen byte _ar_q10_1 = 6
gen byte _ara_q10_1 = .
replace _ara_q10_1 = 1 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_1 = 0 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_1 = 2 if inlist(formdef_version, 2512090157) & _ara_q10_1 == 0 & (missing(q10_1))
replace _ar_q10_1 = 4 if inlist(formdef_version, 2512090157) & _ara_q10_1 == 1 & (missing(q10_1))
replace _ar_q10_1 = 1 if inlist(formdef_version, 2512090157) & _ara_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11)
replace _ara_q10_1 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_1 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_1 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_1 == 0 & (missing(q10_1))
replace _ar_q10_1 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_1 == 1 & (missing(q10_1))
replace _ar_q10_1 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_1 == 1 & (q10_1 == 1 | q10_1 == 2 | q10_1 == 3 | q10_1 == 4 | q10_1 == 5 | q10_1 == 6 | q10_1 == 7 | q10_1 == 8 | q10_1 == 9 | q10_1 == 10 | q10_1 == 11 | q10_1 == 12 | q10_1 == 14 | q10_1 == 15 | q10_1 == 16 | q10_1 == 98)
replace _ar_q10_1 = 5 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_1 == 1 & (q10_1 == 98)
* END REPORT_BARRIER_q10_1
assert _ar_q10_1 == expected_main
assert _ar_q10_1 == _p24_q10_1

* BEGIN REPORT_BARRIER_q10_2
gen byte _ar_q10_2 = 6
gen byte _ara_q10_2 = .
replace _ara_q10_2 = 1 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_2 = 0 if inlist(formdef_version, 2512090157) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_2 = 2 if inlist(formdef_version, 2512090157) & _ara_q10_2 == 0 & (strtrim(q10_2) == "")
replace _ar_q10_2 = 4 if inlist(formdef_version, 2512090157) & _ara_q10_2 == 1 & (strtrim(q10_2) == "")
replace _ar_q10_2 = 1 if inlist(formdef_version, 2512090157) & _ara_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
replace _ar_q10_2 = 6 if inlist(formdef_version, 2512090157) & _ar_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
replace _ar_q10_2 = 5 if inlist(formdef_version, 2512090157) & _ar_q10_2 == 1 & (strtrim(q10_2) == "98")
replace _ara_q10_2 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & (eligible_flag == 1))
replace _ara_q10_2 = 0 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & ((inlist(eligible_flag,0,1)) & !(eligible_flag == 1))
replace _ar_q10_2 = 2 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_2 == 0 & (strtrim(q10_2) == "")
replace _ar_q10_2 = 4 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_2 == 1 & (strtrim(q10_2) == "")
replace _ar_q10_2 = 1 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ara_q10_2 == 1 & (regexm(itrim(strtrim(q10_2)), "^(1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98)( (1|2|3|4|5|6|7|8|9|10|11|12|14|15|16|98))*$") & wordcount(q10_2) == ((strpos(" " + itrim(strtrim(q10_2)) + " ", " 1 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 2 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 3 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 4 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 5 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 6 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 7 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 8 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 9 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 10 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 11 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 12 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 14 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 15 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) + (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0)))
replace _ar_q10_2 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 16 ") > 0) & wordcount(q10_2) > 1
replace _ar_q10_2 = 6 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_2 == 1 & (strpos(" " + itrim(strtrim(q10_2)) + " ", " 98 ") > 0) & wordcount(q10_2) > 1
replace _ar_q10_2 = 5 if inlist(formdef_version, 2512091719, 2512111044, 2512121811, 2602120658) & _ar_q10_2 == 1 & (strtrim(q10_2) == "98")
* END REPORT_BARRIER_q10_2
assert _ar_q10_2 == expected_additional
assert _ar_q10_2 == _p24_q10_2
