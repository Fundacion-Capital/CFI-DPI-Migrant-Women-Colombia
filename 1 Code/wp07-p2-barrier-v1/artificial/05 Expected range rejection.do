* Expected range rejection -- future expected return code 9 -- artificial-only draft, not run.
* No source or participant file is loaded. Do not remove the hold under this task.
exit 198

version 16
assert _N == 0
* Deliberately invalid prepared-field input, not a participant observation.
input double wp07_iat3
1.01
end
* Exact production assertion. Do not capture/nostop the expected failure.
assert missing(wp07_iat3) | inrange(wp07_iat3, 0, 1)
