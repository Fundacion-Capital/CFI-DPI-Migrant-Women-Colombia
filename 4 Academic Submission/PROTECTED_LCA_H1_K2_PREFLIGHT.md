# Protected original H1 two-class mixed-input and native-capture preflight

## Scope

**M6.03.40 / M6.05.40** prepares the original H1_k2 candidate **without fitting**. It validates mixed-input provenance and deterministic recoding, the held execution adapter, original saved-state native capture and refusal boundaries. No new fit, prediction, posterior assignment, participant export, production correction, preferred-model change or release is authorized. Passing a preflight is not scientific acceptance or numerical replication.

## Source-exact candidate

The original catalogue identifies H1_k2 as the first hybrid mixed-core candidate, distinct from the minimal-binary M4 family and the separately locked final H1 four-class refit. Original sample8214–8217, seed6529002 at8221, estimator8223–8234 and immediate return-code capture8235 are retained exactly: **two classes,300random-id starts,difficult optimization,5000iterations**, no added sort and original input row order.

| Indicator | Preserved construction | Estimator link |
|---|---|---|
| h_ivs3 | ivs_score tertiles | Ordered logit |
| h_icdp3 | icdp_score tertiles | Ordered logit |
| h_iaff3 | iaff_score tertiles | Ordered logit |
| h_iuof3 | iuof_score_01 tertiles | Ordered logit |
| h_oqi3 | oqi_score_01 tertiles | Ordered logit |
| h_iurd3 | iurd_score_01 tertiles | Ordered logit |
| h_iedf2 | IEDF above-median split; equal-to-median values assigned0 | Binary logit |

The original source loads `CFI_DPI_lca_minimal_binary_inputs.dta` before constructing the hybrid variables and saves `CFI_DPI_hybrid_LCA_ready_variables.dta` at7854. The protected preflight reads only KEY, these seven categorical indicators and their seven underlying scores from the latter file, plus KEY/seven scores from the former. In-memory frame checks compare score values and KEY in the preserved row order; no participant records or identifier values are printed or exported. The frame-copy syntax follows the [official Stata documentation](https://www.stata.com/manuals/dfrget.pdf).

Only the six selected tertile blocks and original IEDF median-split block are replayed, verbatim from their source ranges. Each reconstructed category must equal the archived category observation by observation. Ordinal domains1/2/3, binary domain0/1, unique nonmissing KEY, unchanged order and423complete-case eligibility are checked. No new thresholds, tie handling, weights or recoding corrections are introduced. This is provenance validation between preserved analytical artifacts, not independent upstream questionnaire/measurement validation or approval of scientific suitability.

## Held adapter and saved-state target

The prepared adapter exits459 **before loading participant data or reaching its estimator**. Its unreachable payload retains the original eight-column KEY+seven-indicator projection, sample, seed, estimator/immediate return-code capture and restricted native-capture call. A future replay requires separate explicit authorization and a separately pinned execution contract; removing the hold is not authorized here.

The frozen original H1_k2 estimate records N423, stored convergence1, rank27 and28coefficient slots. The native target comprises **819cells:7metadata,28coefficients and784covariance entries**, including the fixed base-class parameter. These are saved-state facts, not newly estimated convergence or proof of identification/inference validity. The [historical candidate export](lca-h1-k2-preflight/historical_candidate.csv) preserves the original grid row with explicit archival-only labeling.

Stata restores the original estimate without estimating it, captures it to a new private native carrier, and verifies both original and new carriers against saved matrices and metadata with exact coordinates, stripes, types and values. Refusal checks cover six invalid estimation states, eight malformed native carriers, an existing destination and an escaping destination. Rejected outputs and the held future-fit carrier must not exist. Only aggregate/model-level native carriers are written privately; no respondent dataset is saved.

The inherited Python intake completion-label text still contains `163`; that legacy label is not a cell-count assertion. The pinned contract, actual Stata `H1K2_BOTH_NATIVE819_EXACT_PASS` marker, full native verification and acceptance receipt all require819cells. Executed source is preserved rather than cosmetically rewritten after dispatch; correcting that display-only label is deferred to a future packet.

## Runtime and dependency boundary

The complete source/dependency graph and exact requests are pinned before dispatch. The no-fit guard rejects estimators, predictions, external execution, dynamic/unreserved dependencies, changed nested files and cycles under the reviewed packet grammar. The held adapter is the single pinned exception, whose early exit is checked independently. This is a purpose-bound guard for the frozen single-owner workflow, not a general hostile-code sandbox.

Exactly two bounded no-fit Stata selections are reserved in two owned workers. The main body must complete with return0; a controlled assertion failure must return9 while still cleaning up. Temporary maxvar32767 must be restored to5000 with empty runtime state. Both owned workers must be destroyed, and final session inventory must equal initial inventory without changing unrelated sessions. These checks validate observed normal/controlled-failure cleanup, not arbitrary process crashes or cross-platform invariance.

## Preservation and closure

Protected evidence is retained in `audit-local/intake/lca-h1-k2-adapter-67385bf`: authentic owner request, predecessor seal/proofs, preservation inventory and four tracker snapshots, source/input/target contract, deterministic recoding, held adapter, pinned no-fit requests and dependencies, actual MCP responses/events/logs, private native carrier, tests and review evidence. Every previous packet and failed attempt remains untouched.

Six public paths are in scope. State schema130 retains all2088previous artifact pointers and adds10, yielding2098. Technical closure requires exact actual MCP-event authentication, preservation/scope/source checks, selected safe software tests, independent review, fresh actual post-review verification bound to reviewed sources, sealing, separate saved-only verification and authenticated external closure/readback. No manuscript or live Overleaf file is changed.

## Next immediate task

**M6.04.40 / M6.08.39 — bounded original H1 two-class historical replay and native-target comparison.**

This is not authorized by the present no-fit preflight. It requires separate explicit single-fit authorization, immutable original seed/sample/specification and input order, stage-bound capture and honest native-target comparison. A discrepancy or failure must remain visible and does not authorize a retry, alternative seed, model correction, accepted posterior profiling or preferred-model change.
