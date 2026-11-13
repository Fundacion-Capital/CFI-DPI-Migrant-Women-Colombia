# WP07 — one command-log diagnostic completed

13 November 2026 · **One query selection. No retries, callers, data loads or fits.**
[Sealed request](../wp07-command-log-diagnosis/PROBE_CONTRACT.json) ·
[Validation and evidence pins](VALIDATION.json)

The full returned text was preserved and read back before checking
actual receipts. In order, the response established:

- Correct effective working directory and empty memory.
- One ordinary log matched the bound provider route; no actual filename
  was emitted. No Temp search or log-file read was performed.
- The native bare `cmdlog` printed `(closed)`. Its returned result was
  `rc=0 blank=1 on=0 off=0 filename=0`; memory remained empty at exit.

All seven relevant lines appeared once in the correct order, separate
from echoed commands. No native error, named spill or capping
indication appeared in the complete response returned by the tool.
The finding concerns the visible Stata query, not unreported provider
capture or restricted custody.

**Conclusion:** This fresh worker reproduced a closed/no-file state with
blank status. The previous guard's exact `off` comparison rejects that
observed state in both the text gate and the qualification caller.
The historical worker's actual status and filename remain unknown.
Repository write/save/reopen behavior was not tested. The twelve
qualification cases remain undispatched, and neither earlier grant
carries forward.

Before and after the run, the contract, four directly bound sources,
13 predecessor sources, seven staged payload pairs, 25 prior receipts
and three installed provider-source pins matched. The old gate leaf
remained empty and only the unchanged AQ07 sentinel populated the case
leaves. The post-inventory reported this diagnostic session ready and
not busy; it also showed two unrelated arrivals and one unrelated
departure. No other session was targeted or changed by this task.
Manager state is not an OS-exit attestation. Eight new evidence files
are fingerprinted in the validation record, including the full response,
intent, inventories and workplan before-images.

**Next:** Prepare an additive, offline successor for both guards.
Require a closed/no-file state using the observed result; do not accept
a blank status alone, an open or suspended command log, or a failed
query. Preserve the ordinary-log checks and AQ09’s separate failure
test. Review fresh bindings before any new synthetic execution. No
scientific code was changed. The restricted build, **E.5 and C2 stay held**.
