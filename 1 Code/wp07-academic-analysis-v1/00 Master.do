* WP07 academic analysis v1 — disabled review draft.
* Remove this stop only after the exact prepared input and stage are approved.
exit 198

* Pass the script folder and one verified prepared dataset as quoted arguments.
* The historical and style-only do-files are not called by this master.
version 16
args code_dir prepared_data
set varabbrev off

confirm file "`code_dir'/02 Engagement descriptives.do"
confirm file "`prepared_data'"

* Only the two approved reporting variables are needed here.
use wp07_remit_disposition wp07_domestic_60d using "`prepared_data'", clear
do "`code_dir'/02 Engagement descriptives.do"
