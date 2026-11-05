* WP07 academic prepared-data review -- disabled source draft.
* Keep every entry hold in this file and its callees. No execution is authorized.
exit 198

version 16
set varabbrev off

* Run from the repository root only after a separate input/runtime approval.
* Input is the exact restricted prepared stage already in memory, not TARGET33.
* This master does not load a file, construct scores or change cohort membership.

* Review nominated model inputs without fitting or declaring an estimation sample.
do "1 Code/wp07-academic-core-v1/01 Model input readiness.do"

* Reuse the existing two-outcome categorical description; do not duplicate it.
do "1 Code/wp07-academic-analysis-v1/02 Engagement descriptives.do"

* Raw item reports and prepared-candidate reports have different input contracts.
* They remain separate held stages in CODE_CROSSWALK.csv, not automatic calls.
* Historical regressions, C2 and all LCA/downstream scripts are not called.
* No executable regression is added while covariance/contrasts/support are open.
