# WP07 AQ01 — saved-evidence file-visibility diagnosis

13 November 2026 · **No native or provider calls.** The stopped attempt,
all twelve original requests, seven staged sources and prior comparison
packets are unchanged. [Exact one-selection probe for review](PROBE_CONTRACT.json).

## What failed

The sealed AQ01 request had a nonempty `working_dir` ending in `/aq01`
under the artificial AppData/Local root. Its selection used a quoted
**absolute** path to `run_artificial.do`, with the correct `aq01` argument.
The complete saved response showed the worker seed command, that exact
invocation (wrapped across display lines), the file-not-found message,
and the actual line `WP07_AQ_OUTER case=aq01 rc=601 N=0 K=0`.
There was no injected `cd` echo, inner receipt, or runtime line. The
outer command was captured, so a successful transport envelope and a
ready/nonbusy manager do not contradict the native error. See [Stata's
do-file return-code example](https://www.stata.com/manuals/u.pdf).

The shell could see the same 4,920-byte caller before, after, and during
this offline recheck. Its exact SHA-256 agrees with the sealed staged
source. No path typo, missing shell-side file, changed caller bytes,
participant load, fixture code, preparation, save or reopen explains
the failure. The failure is **at the provider/Stata file-visibility
boundary, before the caller starts**. Its specific underlying cause is
not observable from the saved evidence.

## Matched historical comparison: E.5 AT03, artificial only

| Observation | AQ01, 13 November | AT03, 11 November |
| --- | --- | --- |
| Tool and request | Stata MCP selection, named session, 60 seconds | Same tool and timeout, different named session |
| Requested directory | New synthetic leaf under `AppData/Local` | Repository root under `Documents/GitHub` |
| Actual directory evidence | No `cd` or effective-directory observation in complete returned text | Actual `cd` echo followed by the repository path |
| File operation | Absolute quoted 87-character caller path; Stata reported not found | Absolute quoted 184-character caller path with spaces, under the repository's artificial intake; executed |
| Native completion | Outer 601, no inner receipt | Expected synthetic inner 459 **from inside** the fixture and actual terminal outer completion, N=0/K=0 |
| Current shell-side path metadata | Caller and ancestors not reparse-tagged; inherited sandbox-group ReadAndExecute, owner/SYSTEM/Administrators and a capability ACE | Caller is not a reparse point; repository chain has the `Documents/GitHub` reparse point; inherited sandbox-group Modify and additional allow entries |

The AT03 comparator is the sealed artificial request and raw response, not
an E.4 result or restricted E.5 input. The evidence includes the actual
successful caller execution, not just its existence. Current DACLs are
read-only observations, **not** proof of either worker's effective access
or proof that the historical DACLs were identical. Successful AT03 cannot
be used to clear a respondent-level run or to approve the Git/Cloud Files
path as a research-data destination.

## Why the directory difference matters

The three installed provider source files match their earlier WP06 disk
pins. Reading the installed sources, without import or launch, showed:

- `stata_mcp_server.py:337–344` prepends a native `cd` only if the
  non-sentinel `working_dir` passes the **server's** `os.path.isdir` check.
  Otherwise it returns the original selection, without a directory error
  at that boundary. The selection endpoint passes that result to the
  session manager in its multi-session branch (2398–2411).
- `session_manager.py:775–809` passes selection text as code after joining
  Stata line continuations. It does not send the caller's file bytes. The
  installed worker then executes wrapped code with echo enabled and
  normally captures output in a temporary log (`stata_worker.py:542–579`).
- The installed selection endpoint uses compact processing without asking
  it to suppress general command echoes (`stata_mcp_server.py:818–829,
  2421–2423`; `output_filter.py:246–273`). That path does not generally
  remove a top-level `cd` like the one present in the AT03 receipt.

This makes the missing AQ01 `cd` **consistent with** the server not seeing
the requested AppData leaf as a directory, alongside Stata not opening its
absolute caller. The missing `cd` did not itself cause an absolute lookup
to fail. Exact loaded modules, server and worker identities, live
`isdir`, native OS file status and effective permissions were not
captured for that attempt. A different provider execution context, path
visibility or traversal/access can explain the observations; the record
does not establish which. AT03's longer path weakens a generic path-length
or slash/quoting explanation. Neither a global Stata startup failure nor
a preparation defect is evidenced: native inline code and the outer
receipt ran, but the caller did not. No claim of historical or current
access equivalence is made.

## One proposed discriminator — review only

The contract binds one fresh session name, AQ01's exact historical
`working_dir`, and two existing **synthetic code files**: the failed
caller and the exact caller AT03 opened. It opens each **as text**, checks
one first-line marker and closes the handle. It never executes a caller,
generates or loads a dataset, writes any file itself or changes any
permission. The existing transport may create its ordinary synthetic log.
It reports only a directory-match flag, numeric open/read/close statuses,
boolean marker matches and final empty-memory state. Syntax reference:
[Stata file I/O](https://www.stata.com/manuals/pfile.pdf). No files were
staged at either run location for the probe. No provider request or live
inventory was made; the proposed name is absent only in the saved AQ01
inventory, not certified vacant now.

| Later result, only if separately authorized | Interpretation |
| --- | --- |
| Control matches, target open fails | Current path-specific visibility difference reproduced in one worker. Does not by itself prove ACL denial, cloud causation, or permanent incompatibility. |
| Both markers match, requested directory matches | Current worker can read both paths and is in the requested directory. AQ01's historical failure is not reproduced; do not call it fixed or silently retry. |
| Both markers match, requested directory does not match | Absolute reads work now; requested directory is still not established. Investigate directory admission before any successor with a cwd gate. |
| Control cannot be read, markers differ, or response/custody is incomplete | No reliable working control or identity proof. Preserve the response and stop, with no additional selection. |

The grant would cover **one** synthetic read-only selection and the
synthetic transport route only, after fresh hash/path/session checks.
Read and seal the complete response before accepting any markers; do not
rely on echoes or on a successful transport status. No AQ01 retry,
remaining batch authority, settings/service changes, restricted
preparation save, E.5 render or C2 work is implied. **E.5 and C2: HOLD.**

## Offline preservation audit

Entry HEAD `3305d8e71928f1c5cb05f4ce8c48d19b19a4712c`. The audit compared
the exact saved AQ01 and AT03 invocations and full response receipts,
checked both caller hashes and the installed-source pins, and verified
the probe has one request, two pinned text inputs and no study-data route.
The old execution receipt, source files and staged paths were left in
place. Exact navigation before-images are retained in the ignored
`audit-local/intake/package-e-restricted-20261113/wp07-aq01-visibility-diagnosis-3305d8e`.
Probe contract SHA-256:
`a48352db86506fd53da4cef0b2e81187a1525e7cc3728298179de6644314a401`.
