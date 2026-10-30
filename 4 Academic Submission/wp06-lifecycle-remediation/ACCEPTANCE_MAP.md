# Artificial acceptance crosswalk — AC-D01–12

This crosswalk points to executable tests, not native acceptance. Normal/optimized final receipts and the independent-review disposition determine the exact tested source version. All inherited tests remain enabled.

| Requirement | Successor coverage |
| --- | --- |
| AC-D01 exact normal recipe, one worker, no repeated cleanup | `test_lifecycle.LifecycleTests.test_ac_d01_normal_recipe_reuses_terminal_result`; inherited adapter/client order and identity tests |
| AC-D02 bootstrap error and server-finally share failed result | `test_ac_d02_bootstrap_error_survives_finalizer`; failed exit-record case retains the primary timeout alongside rollback failures |
| AC-D03 preallocation expiry, no worker/reset | `test_ac_d03_expired_bootstrap_never_allocates` |
| AC-D04 late allocation, no premature completion | `test_ac_d04_late_allocation_cannot_cache_pending_as_terminal`; initialization-in-flight and interrupted-allocation cases |
| AC-D05 competing finalizers and supervisor | `test_ac_d05_concurrent_finalizers_do_not_repeat_effects`; actual supervisor deadline test; inherited `test_control_remains_available_during_cleanup` |
| AC-D06 observe before disposal, retain partial failure | `test_ac_d06_rollback_observation_precedes_capability_disposal`; failed capability-close and exit-record tests; strict fake disposed-query rejection; observed nonzero child status remains failed recipe |
| AC-D07 interrupt/record failure never becomes success/retry | interrupted cleanup/allocation, terminal-record-write and final-deadline tests |
| AC-D08 immutable terminal readback | `test_ac_d08_terminal_dictionary_cannot_be_modified_by_reader` |
| AC-D09 same integer-packet guard boundaries and evaluated operands | `test_bootstrap.BootstrapTests.test_integer_packet_guard_matches_original_accept_reject_boundary`; all rejection categories; exact-deadline and first-failed-predicate cases |
| AC-D10 bounded, secret-free, fixed-path, exclusive evidence | credential/unknown-field omission, foreign-role path, malformed packet, invalid-origin redaction, oversized/write-denied/existing-record cases |
| AC-D11 precision and source/role integrity | large identity integer, changed manager source pin, matching unknown role; inherited pipe/ABI/source/loaded-identity tests |
| AC-D12 full suite and preservation | final normal/optimized receipts, complete disabled disk-inventory/grammar preflight, independent review, unchanged predecessor/source evidence, current-task audit/seal/readback |

Independent-review regressions add the earlier preallocation-guard interval and supervisor while worker/watchdog creation is actually outstanding (`test_review_fixes`). The same module tests full bytes followed by flush/close failure, normal atomic final publication, and a foreign existing final that must not be replaced. Its pending file is non-authoritative; only exclusive final publication commits cleanup evidence. These cases complement, not replace, the original tests.

The real Windows kernel, Stata engine, selected runtime, live cancellation, native timing, participant processing and scientific results are not tested by this crosswalk. No historical exception or owner/institutional approval is resolved here.
