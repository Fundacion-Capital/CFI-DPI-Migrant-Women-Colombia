# WP07 Stata MCP containment finding

13 November 2026 · [Audit evidence](VALIDATION.json) · [Custodian brief](CUSTODIAN_BRIEF.md)

**No existing route is verified for the proposed private build.**
Do not stage or bind an exact artificial qualification under this
checkpoint. This is a scoped negative finding about the available evidence,
not a claim that no supported contained Stata MCP deployment could exist.

| Route or control | Observed evidence | Disposition |
| --- | --- | --- |
| Existing Stata MCP | The configured endpoint is loopback. Both sealed AQ04/AQ06 responses reported native scratch in a worker subdirectory under profile Temp and one ordinary capture log directly in profile Temp, outside the reserved private leaf. Current profile Temp has a protected DACL but two additional allow entries with write rights. | **Fails the private path criterion on the observed route.** Loopback and the synthetic pass are not worker-token, confidentiality or retention evidence. No new probe or session query was performed. |
| Working directory and native guards | Installed server source passes the working directory by prepending a Stata directory-change command in the multi-session path (lines 337–345 and 3129–3138). Installed worker source opens its diagnostic log before initialization (381–397), makes the worker scratch directory from its initial temp root (439–448), and opens ordinary capture before executing the caller (541–551). The held caller's `c(tmpdir)` and ordinary-log guards are inside the caller. | **Not a containment control by itself.** The guard can stop the carrier load but cannot undo earlier provider writes. The reviewed MCP request exposes no per-call temp or capture-root parameter. Source findings are about the pinned installed files, not attestation of the active process image. |
| Output and failure paths | The installed output filter can write an oversized result to extension logs, profile Temp, or the process working directory (lines 360–407). This is a source capability, not an observation of a spill in either synthetic call. Server diagnostics, transport retention, and failure/timeout spill behavior have no independently verified private binding. The ordinary log being absent at postflight does not establish that no output persisted elsewhere. | **Unverified; fail closed.** Do not search broad log folders or open unbound spill files. |
| Earlier isolated alternatives | The V6 successor is disabled and not runtime-ready. Its one saved empty-native trial returned −7100 before a selection; rollback was verified, bootstrap was not accepted. TARGET33's static preflight records no ready runtime or bound executable adapter. | **Not eligible as a substitute.** Do not restart or retrofit either route for this milestone. |
| Private destination and inputs | The private root and leaf are absent. Five existing ancestors showed no reparse point; encryption, backup/sync exclusion and effective native permissions are not verified. Carrier length matches, but the carrier is a cloud reparse point with an extra inherited read ACE. The four references matched unique manifest records, file lengths and observed restricted ACL structure; their contents were not opened. | **Documentary and metadata checks only.** No provisioning, permission edits, hydration, reference reads, or substitution. |

### Evidence needed to reconsider

1. Identify one existing supported route and its actual executable/source
   binding, service/controller and native worker principals. Show that
   startup/debug logs, capture, native scratch, save/readback scratch,
   overflow/error output, and transport retention remain within the same
   approved private boundary from startup, or are disabled by verified
   supported controls. Include the exact no-sync/encrypted directory and
   effective ACLs, not just account names or configured defaults.
2. Independently verify that the candidate path and runtime route match
   the held caller. A different route needs a new source-exact review.
   After these prerequisites, bind a fresh artificial review with
   artificial metadata, exact-schema round trip, changed metadata and
   value rejection, coverage checks, and negative logging/path cases.
   Test the approved route and exact caller behavior without loading any
   real carrier. This is an acceptance outline, **not** a runnable
   selection, fixture binding, or grant.
3. Record actual custodian decisions and pursue a separate exact
   participant-build grant only after artificial qualification and
   metadata approval. Until then, continue source, exhibit and manuscript
   work; do not start another worker-development cycle.
