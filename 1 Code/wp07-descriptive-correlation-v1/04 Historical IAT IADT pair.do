* Section I line 231: historical IAT–IADT association, not a model.
* Input is the verified descriptive carrier already in memory.
exit 198

confirm numeric variable iat_score iadt_score, exact
* Preserve historical significance output and make the pair's N visible.
pwcorr iat_score iadt_score, sig obs
