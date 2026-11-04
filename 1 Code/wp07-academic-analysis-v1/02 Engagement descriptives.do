* WP07 D4 — first descriptive block, disabled review draft.
exit 198

* Input: two fields from the separately verified WP07 preparation layer.
* The source rows stay in memory; no sample restriction or export is made.
version 16
confirm numeric variable wp07_remit_disposition wp07_domestic_60d, exact
assert missing(wp07_remit_disposition) | inlist(wp07_remit_disposition, 1, 2, 3, 4, 5)
assert missing(wp07_domestic_60d) | inlist(wp07_domestic_60d, 0, 1)

* q6_13: reported disposition of remittances, not their measured digital share.
* First show coverage in the full admitted sample, then report valid answers.
tabulate wp07_remit_disposition, missing
count if !missing(wp07_remit_disposition)
if r(N) > 0 {
    tabulate wp07_remit_disposition
}

* q6_14: reported domestic digital participation in the last 60 days.
* The missing row is unscored; it is not a negative response.
tabulate wp07_domestic_60d, missing
count if !missing(wp07_domestic_60d)
if r(N) > 0 {
    tabulate wp07_domestic_60d
}
