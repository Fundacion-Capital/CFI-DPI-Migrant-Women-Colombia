# Original M3 four-class replay — no-fit operational recovery preflight

Task: **M6.04.34.R1 / M6.08.33.R1**. This is a bounded interface probe, not a research replay or new fit authorization. The parent **M6.04.34 / M6.08.33 remains HOLD** with no verified fit result or native-target comparison.

## Investigation and tested path

The preceding attempt recorded a code-mode wait timeout followed by a stale host generation. Its exact native termination and the underlying host failure cause remain unresolved. No estimator was rerun to investigate them.

A new uniquely owned, empty Stata MCP worker executed a metadata-only do-file: assert zero observations and variables, temporarily raise maxvar from 5000 to 32767, sleep for 35 seconds, restore maxvar to 5000, and emit beginning/capacity/restoration/completion markers. Code-mode result polls were bounded to 10 seconds rather than the previous failing 50-second wait. The complete result was returned; a separate MCP selection confirmed zero observations, zero variables, blank e(cmd), and restored capacity. Only this owned worker was destroyed; final session inventory equals baseline.

The persisted returned result sidecar contains the full 1313-character native output and is semantically identical to the separately authenticated MCP journal-result sidecar. Both are retained unchanged, and the actual result and private Stata log independently contain the required executed markers. An on-screen tool-output compression placeholder was initially mistaken for persisted content. Independent review caught that provenance-description error; the earlier report and owner receipt are preserved, and an additive correction/disposition supersedes that description. The original review is retained as issued, not relabelled as a clean PASS.

## Audit boundaries

Five completed MCP events are authenticated: baseline inventory, probe, independent readback, owned-worker destruction, final inventory. There were **zero fits, research-data loads, predictions or participant exports**. All 90 files already present in the interrupted packet and all 1001 tracked files at the current entry commit retain their fingerprints; the earlier preservation manifests also passed entry checks. The original 12 software guard tests passed again. Review and final-verification receipts are retained privately; closure depends on those receipts, not on this prose.

The consumed original reservation, interrupted log, all previous packets, source adapters, data, archived targets and normal replay acceptance gates are unchanged. Workflow schema 110 and 1899 artifact pointers remain at the earlier preflight. This standalone recovery record does not mark the original replay complete or create numerical outputs. No manuscript, qualitative, literature, cloud, Git index or commit changes are included.

## Limits and next gate

This establishes successful recovery/preflight **only for the observed 35-second metadata probe and its independent readback**. It does not reproduce or prove resolution of the prior intermittent host failure, certify 1800-second execution, resolve the original estimator's termination, or establish scientific validity or numerical equality. Short polls are an operational mitigation, not a guarantee.

Before another research fit: prepare a new bounded replay packet with a fresh one-use reservation, verified source/input/target pins, short result polls, prompt persistent capture of returned evidence, and explicit handling of any missing completion evidence. Verify persisted result content against authenticated journal output rather than inferring its contents from on-screen compression. **Fresh human authorization is required before any fit**; R1 does not renew the consumed authority. Never overwrite the interrupted packet, retry automatically, relax the normal acceptance gates, or infer nonconvergence from unavailable results.
