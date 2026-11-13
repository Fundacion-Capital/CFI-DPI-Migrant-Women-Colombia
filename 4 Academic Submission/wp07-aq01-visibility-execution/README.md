# WP07 single visibility probe — executed and audited

13 November 2026 · **One exact selection; zero retries.** See the
[sealed probe](../wp07-aq01-visibility-diagnosis/PROBE_CONTRACT.json) and
[validation record](VALIDATION.json).

## Observed in one Stata MCP session

| Check | Actual receipt |
| --- | --- |
| Requested AQ01 directory | `match=0`: current working directory did not match the requested leaf |
| AppData target, `run_artificial.do` | `open=601`; no read, marker, or close because the open failed |
| Previously working AT03 repository caller | `open=0 read=0 marker=1 close=0` |
| End of selection | `N=0 K=0` |

This reproduces a **path-specific visibility difference** in the same
worker, with both files present and hash-matched in the shell. The probe
opened the repository control **as text**, not as a do-file. Neither
caller executed. The requested working directory did not take effect
as measured by the exact comparison. The missing directory-change echo
and the installed source are consistent with a provider-side directory
visibility difference, but the selection does not establish the loaded
implementation, worker identity, effective ACL, or native OS cause.
An unmatched working directory does not itself explain failure to open
an absolute path. The read success does not prove the repository route
can save a dataset, that it is private, or that it is approved for
participant data.

## Preflight, full readback, and preservation

Preflight verified the request seal, 15 source/evidence pins, all eight
AQ01 attempt receipts, seven staged source files, both first-line markers,
the original working directory and the expected reparse boundaries.
A read-only inventory showed the exact probe session name was absent.
The one selection was dispatched byte-for-byte from its intent.

The complete available response was recovered from an output-compression
reference and preserved before accepting the four ordered, non-echo
receipt lines. There was no named provider spill; no provider Temp path
was emitted or searched, and hidden capture is not certified. The closing
inventory showed the owned probe session ready and nonbusy. All entry
session rows remained unchanged; two additional unrelated rows appeared.
No operation on those sessions was dispatched. Manager readiness is not
OS exit proof.

Afterward, all 15 pins, eight AQ01 receipts and seven staged sources still
matched. None of the original case leaves acquired a file; AQ07's
synthetic sentinel was unchanged, and the participant output leaf remained
absent. Full/raw responses, exact intent, authorization, both inventories,
receipt audit, inventory comparison and navigation before-images are
preserved under the ignored evidence path in the validation record.
No caller ran; no dataset loaded, saved, or fitted. No permissions,
settings, Git index, commit or cloud state were changed.

## Disposition and next step

AQ01 and the eleven undispatched cases remain stopped. This probe's grant
is consumed. **Recommended next step:** prepare a separate synthetic-only
successor contract on the repository route that the provider could read,
with fresh exact paths, sessions and independently bounded write and
save/reopen checks. Rebind paths and evidence only; preserve the existing
preparation body and scientific rules. Verify that the proposed staging is
Git-ignored and approved for synthetic artifacts; do not place study
data there or treat it as a private production route. If a compliant
synthetic route cannot be established, stop rather than change ACLs,
the service or the worker.

Participant custody and private save/readback remain separate holds.
**E.5 and Appendix C2 remain on hold.**
