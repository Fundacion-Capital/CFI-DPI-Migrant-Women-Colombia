* Academic counterpart, not a replay of the historical IAT/IADT pair.
* Input is the separately verified preparation output already in memory.
exit 198

version 16
confirm numeric variable wp07_iat3 wp07_iadt2 wp07_iadt3, exact
assert missing(wp07_iadt3) | !missing(wp07_iadt2)
* Report overlap first. An IADT2/IADT3 comparison on different rows
* mixes the change in definition with a change in coverage.
count if !missing(wp07_iat3, wp07_iadt2)
local n_iadt2 = r(N)
count if !missing(wp07_iat3, wp07_iadt3)
local n_iadt3 = r(N)
count if !missing(wp07_iat3, wp07_iadt2, wp07_iadt3)
local n_common = r(N)

* Each named pair uses its own complete rows. No p-values are claimed.
if `n_iadt2' > 1 {
    pwcorr wp07_iat3 wp07_iadt2, obs
}
if `n_iadt3' > 1 {
    pwcorr wp07_iat3 wp07_iadt3, obs
}
* Separately compare on common support. Do not manufacture a coefficient at N < 2.
display as text "Academic common-case N: " as result `n_common'
if `n_common' > 1 {
    correlate wp07_iat3 wp07_iadt2 wp07_iadt3
}
