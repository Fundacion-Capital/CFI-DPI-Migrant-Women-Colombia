# SFI discovery and readiness-timeout diagnosis

## Conclusion and evidence boundary

The sealed trial failed upstream of usable SFI and completed no empty selection. The native Python-discovery cause is **not yet proven**. A distinct, source-confirmed observability gap is clear: after the worker fails, the parent waits for a worker-ready frame without testing whether that worker has exited. This converts a specific worker failure into a readiness timeout. The next change should expose that boundary and fail promptly, not guess another library-path repair.

This account combines the unchanged failed run, exact installed/provider source and official documentation. No native code was initialized, no live process or registry was inspected, no participant record was opened, and no implementation/settings/service repair was made. Static parsing and artificial clock fixtures are not native reproduction.

## Verified failure chain

1. The exact isolated worker records its pre-init metadata, adds the pinned Python DLL directory through a process-local handle, and enters `config.init('mp', splash=False)`. The saved traceback reaches that call; the source path therefore gets past directory-handle acquisition, but there is no positive loaded-library/SFI readiness proof.
2. Installed `config.py` locates/loads the Stata engine and calls `_init_stata`. That helper passes the Python executable to `StataSO_Main` using `-pyexec`. `_get_executable_path` returns the raw `sys.executable` string when that file exists; it does not canonicalize it first. Source locators: `_get_executable_path` 180–192; `_init_stata` 193–209; `init` 211 onward.
3. Saved metadata records a uv minor-version path ending `cpython-3.11-windows-x86_64-none/python.exe`, resolving to the exact pinned `cpython-3.11.15-windows-x86_64-none/python.exe`. This matches the documented uv minor-version alias mechanism. It is not evidence that the alias is defective. Neither registry inspection nor another executable invocation was performed.
4. Worker stdout reports failure to select the specified Python version and locate its shared library. The later exception is `ModuleNotFoundError: No module named 'sfi'` in vendor `_add_java_home_to_path`, reached by `_load_system_config`. The installed native engine file contains Python-prefix/sysconfig discovery strings. Those static bytes are clues about the discovery surface, not proof of the executed command, its output, library-search order or return code.
5. Installed `init` has a special `-7100` path that can mark SFI uninitialized while continuing far enough to set Stata's initialized flag and load configuration. The observed stack/warnings are consistent with that path, but **the trial did not retain the raw native return value**. Do not report `-7100` as an observed fact, treat `stinitialized` alone as usable SFI, or mistake the later Java-home import location for proof that Java caused the failure.
6. The worker produces a scoped failure diagnostic, not a ready frame. The watchdog records worker exit. The parent remains in `Channel.wait('worker','ready',0, origin + 60*frequency)` until that deadline. The wait polls only for the frame and the clock; it has no worker-exit test. Final rollback records report zero active owned processes and zero retained handles, with `accepted=false` and zero completed selections.

Relevant pinned provider locators are captured in private `facts.json` using Python AST line ranges. Installed `sfi.py` itself imports the native `stata_plugin`; making the Python file importable does not independently establish a registered, usable Stata bridge. Do not install an unrelated PyPI package named sfi or inject its path to conceal the native setup failure.

## Deadline reconciliation

The parent ownership, exit and closure records share the exact run scope. Their integer counters give:

| Saved quantity | Exact value |
| --- | ---: |
| Counter origin | 5,182,887,534,221 |
| Frequency | 10,000,000 ticks/second |
| Exit tick | 5,183,487,676,003 |
| Exit elapsed | **60.0141782 seconds** |
| Closure tick | 5,183,487,699,553 |
| Closure elapsed | **60.0165332 seconds** |
| Readiness deadline | 60 seconds |
| Final-evidence bound | 120 seconds |

The generic `Absolute frame deadline expired` error comes from the 60-second ready-frame wait. It does **not** prove that the 120-second final-evidence budget expired or that a longer budget is needed. This clarifies the retained historical wording without modifying it.

Retained file timestamps place the worker failure and watchdog exit before the parent's final rollback files. These are filesystem endpoint timestamps, not authenticated QPC event timestamps, so they are not used to invent an exact worker-failure counter or a precise native startup duration. The 60.014/60.016 calculations use saved parent counters only; they are not an independent host-clock measurement.

The `.pending` cleanup file and final cleanup file have identical bytes. Source intentionally publishes the final cleanup via a hard link while retaining the pending diagnostic. Their coexistence is not evidence of late-finalization drift or a missing final cleanup. All 21 frozen run files remain unchanged.

## Hypothesis and exclusion crosswalk

| Candidate explanation | Evidence and disposition |
| --- | --- |
| Parent waits on a frame after worker failure | Confirmed source behavior; artificial clock fixture reproduces deadline wait with no frame. Correct the failure detection, not the deadlines. |
| Java configuration is the primary cause | Not established. SFI import is attempted in the Java helper after earlier Python/shared-library warnings. Do not edit Java settings. |
| Missing pystata package or a needed reinstall | Not supported at the observed boundary: vendor config imported and native initialization was entered. Do not broadly upgrade/reinstall packages. |
| Missing Python DLL file or wrong declared architecture | Pinned file exists and saved worker metadata is 64-bit Python 3.11.15. That does not prove Stata discovered/mapped the right library. No reinstall is justified by file presence alone. |
| uv alias/prefix discovery difference | Real raw/resolved path difference; cause unproven. Keep both strings in future bounded diagnostics rather than silently normalizing one. |
| Process-local DLL-directory addition suffices | This attempt did not establish successful startup. Python documents loader scope for extension dependencies/ctypes, not a guarantee about Stata's discovery algorithm. |
| This provider blocks all child creation via a job-process cap | Its configured job code sets kill-on-close, not an active-process cap. Do not weaken containment on that unsupported premise. Inherited host policies were not probed. |
| Isolated environment, discovery subprocess, distribution-specific lookup or native return | Still unresolved. Static engine strings do not tell us which discovery probe ran or why it failed. Preserve these as hypotheses, not fixes. |
| Adding the vendor SFI path would make the bridge valid | Not established; SFI also requires the registered native plugin and positive bridge checks. Do not suppress or bypass those checks. |

The installed extension's normal worker source also adds Stata utilities paths and calls `config.init`; it is not an independently verified working reference under this trial's isolated flags/environment. Reading it did not involve the shared service.

## Workplan consequence

The bounded trial stays failed and its authority consumed. The proposal is an **additive disabled fail-fast/bootstrap-return-evidence successor with artificial-only acceptance**, not a claimed SFI fix. It targets the proven readiness-wait gap and the missing discovery/return evidence while retaining all original runtime and research boundaries. Any later native investigation needs a new exact request and separate owner authorization.
