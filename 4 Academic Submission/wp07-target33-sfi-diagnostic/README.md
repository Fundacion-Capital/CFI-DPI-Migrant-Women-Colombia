# WP07 TARGET33 — failed SFI lookup diagnostic plan

**Prepared offline. Execution remains on hold.** The saved V6 attempt returned
−7100 at native initialization; PyStata later reported that it could not import
`sfi`. No selection ran. The saved return and rollback identify the boundary,
not the particular failed lookup. The earlier static `LIBDIR` observation is
a hypothesis, not evidence that Windows ran that probe. The goal is to identify
the failed operation and establish its relationship to the native return.

## Select a diagnostic route

1. Prefer StataCorp-supported diagnostic instructions for this exact Windows,
   Stata and Python build combination. First ask, in a separately authorized
   contact, whether a documented diagnostic can report the discovery branch,
   probe result and first unrecovered loader error without changing settings
   or opening any data. Send only a reviewed, redacted summary, not the raw
   packet. The [public PyStata documentation](https://www.stata.com/python/pystata19/install.html)
   describes configuration, not a trace of the private native resolver.
2. If that route is unavailable or cannot distinguish the branches, consider
   one separately authorized capture using [Microsoft Process Monitor](https://learn.microsoft.com/en-us/sysinternals/downloads/procmon)
   on a dedicated, empty, approved Windows environment. Its file, Registry,
   process and stack events can correlate a lookup with a process and module;
   it cannot show Python probe stdout or prove why a successful file open did
   not result in a mapped image. Capture only if the approved collector and
   its driver can be used without installation or settings/service changes
   under the applicable authorization. Filters are not a privacy boundary;
   if the collector can acquire unrelated activity on that host, do not run it
   there. If the dedicated environment differs from the historical one, report
   the result as diagnostic-environment evidence, not proof about V6.
3. Do not enable [Loader Snaps](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/show-loader-snaps),
   GFlags, boot logging, IFEO, shared-service tracing, remote symbol fetching,
   or machine-wide instrumentation here. Loader Snaps uses a registry entry
   or kernel flag. Do not edit vendor code, search paths, Python configuration,
   or registry to see whether the error disappears.

## Preflight and one capture, only under separate authorization

- Pin the exact documented entry point, collector version/signature/hash,
  approved privileges and driver lifecycle, OS/build, native engine,
  PyStata and interpreter binaries, Python DLL, SFI artifacts, canonical and
  raw paths, allowed environment, working directory and dependency roots.
  Record junction resolution without changing it. Select a new restricted
  diagnostics-only destination and confirm that participant storage, shared
  workers and prior run directories are not reachable from the diagnostic
  target. Record authorized readers, retention, and treatment of partial traces.
- Require a distinct bootstrap-only diagnostic binding, no V6 grant or
  launcher reuse, no selections, no dataset path, and zero retries or
  replacements. A direct Python import test or a manually reconstructed probe
  is not a substitute for the actual native caller. If the approved entry
  point cannot exercise the same discovery boundary, stop rather than stage
  a misleading experiment.
- Before seeking authorization, bind a finite duration and capture size,
  with a fixed stop deadline and reserved cleanup budget. Start collection
  before discovery, then retain the native entry and return markers plus
  target creation and exit. Stop after the first terminal bootstrap outcome
  or on any limit, foreign activity, lost identity, event loss or scope drift.
  No extension. Verify collector stop and owned target/child exit independently.
  Preserve failed, partial and ambiguous packets; quarantine unverified closure.
- Attribute events by exact image, process birth, parent/child relationship,
  session, and thread where available—not by name or PID alone. Correlate the
  native call window with event sequence and clock anchors. Preserve ordered
  file and Registry lookups, process creation/exit, image loads, operation and
  result codes, requested/resolved paths and available stack/module offsets.
  Capture a discovery child's arguments, exit and stdout/stderr only through
  the approved diagnostic if available. No registry dumps, memory dumps,
  general environment dumps or collection outside the approved scope.

## Evidence and decision rules

| Pattern in a complete, attributable capture | What may be concluded |
| --- | --- |
| Native discovery invokes a probe; captured probe result is missing/invalid and the diagnostic ties that result to the terminal branch | Probe failure is supported. Do not assume `LIBDIR` without the actual expression and result. |
| A Python DLL lookup ends in an explicit loader failure with requested image, status and no successful fallback | The named image lookup failed. Earlier `NAME NOT FOUND` events alone are normal search evidence, not a terminal error. |
| The intended DLL opens, but image mapping fails or a named dependency has a terminal failure | Report the recorded map/dependency error. Opening a file alone proves neither loading nor dependency resolution. |
| Native engine and required images load; subsequent evidence shows SFI registration or Python import failure | Distinguish registration from Python module resolution. Attribute one only with positive evidence; do not infer it from the final import exception. |
| Missing stack, lost events, ordinary search misses, unmatched clock window, or no reproduction | Inconclusive. State what the collector could not observe; no retry or loader change follows automatically. |

Keep the raw trace and any stdout restricted, hashed and separate from the
reviewer summary. The summary should identify the event range, observed
operation/status and why it is terminal or still ambiguous. A later repair
proposal must change only what the evidence supports and requires its own
review. Even a conclusive diagnosis does not qualify native startup,
four-selection transport, independent stop delivery, or protected execution.
