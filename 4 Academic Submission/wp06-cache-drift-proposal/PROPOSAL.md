# Minimal coupled remediation proposal — not installed

## Disposition of the four differences

Current evidence supports **SOURCE_COMPATIBLE_CURRENT_CACHES; HISTORICAL_CHANGE_AND_WRITER_UNRESOLVED**. Each retained current cache has a valid CPython 3.11 format and a timestamp-based header whose source size/mtime matches the unchanged pinned source. Its complete payload can be reproduced by compiling that source in memory, using the filename label containing the versionless interpreter alias, and serializing the new code object. The comparison did not load or run a retained cached code object. The header interpretation follows [PEP 552](https://peps.python.org/pep-0552/).

The pre-drift 786-byte XML-package cache is represented by its historical hash/size, not its body among this task's inputs. The current 782-byte body is preserved. Therefore neither the exact old-to-new content change nor the writer/cause is established. An alias-label match is consistent with compilation through that path; it is not attribution or a reconstruction of the old file.

The four current caches and four source files are copied byte-exactly into restricted local software evidence. Sources match the original catalog; before/after hashes match. These copies are not a runnable replacement environment and will not be bundled for public redistribution by this proposal.

## Options considered

| Option | Disposition | Reason |
|---|---|---|
| Rebaseline the complete current all-file catalog | Not recommended alone | Would accept this snapshot but retain sensitivity to later unrelated normal cache regeneration. It also needs new explicit source-bound authorization. |
| Delete/restore shared interpreter caches | Rejected for this workflow | Mutates shared software and destroys or replaces evidence; no historical body restoration is justified. |
| Exclude all `.pyc` files while retaining only `-B` | Rejected | No-write is not no-read; sourceless and unusual compiled inputs cannot be ignored. |
| Private startup cache prefix plus narrow source-backed classification | Recommended, not applied | Avoids shared cache mutation and separates bypassed ordinary caches from strictly pinned executable inputs, with coupled admission checks. |

## Exact proposed policy

1. Add one `pycache` directory to the existing create-only private startup reservation. It must be plain, root-contained, unaliased and empty, like the existing guarded home/temp inputs. Do not create it in this proposal. Retain it and any failed attempt; do not clear or reuse it.
2. At interpreter startup, supply `-I -S -B -X utf8 -X pycache_prefix=<exact-run-root>/pycache` to **outer client, stdio adapter, worker and watchdog**. Use an explicit argument; an environment variable would be ignored under `-I`. Preserve the selected venv client/adapter and direct base-interpreter roles. Commands and prefix relocation must be exact new request inputs.
3. Before SDK import, native kernel construction or Stata initialization in each applicable main path, verify the actual process's absolute prefix, true no-write state and `cpython-311` tag. Retain all four observations: outer client terminal receipt; one scoped `parent.cache.json` for adapter; existing authenticated worker/watchdog readiness payloads for those roles. Missing, extra, foreign or malformed proof rejects acceptance. Readiness schemas and readers must be updated together; old packets are not reinterpreted.
4. Keep the raw scanner/reparse rejection and nine bounded roots. Classify only ordinary source-backed `__pycache__/<name>.cpython-311[.opt-1|.opt-2].pyc` entries whose corresponding `.py` is itself present in the strict inventory. Do not skip entire directories. Source files, non-cache files inside cache directories, other tags/optimization forms, adjacent legacy/sourceless `.pyc`, binaries, archives and all 21 critical inputs remain strict. Any new custom loader that would explicitly select an otherwise classified cache must keep that input strict; the ordinary source-loader rule is not a general sandbox.
5. Adopt a separately versioned catalog policy only in the new disabled successor. Its fixed `files` rows describe strict inputs; per-preflight cache observations are separately retained, not used as immutable execution pins. Membership and SHA-256/size checks remain mandatory for strict inputs. There is no fallback that interprets the old V1 all-file catalog under the new rule.
6. Couple classification to the new binding/startup policy, all four command/actual-state checks and an empty private prefix. The pure policy fixture assumes an empty prefix and exact flags; it does **not** prove a real reservation or native state. Final audit must detect unexpected prefix contents rather than delete or excuse them.
7. Preserve the same empty selections, no fitting/participants, ownership/identity controls, no replacement/retries, and all 60/80/90/95/100/110/120-second limits. Source compilation may affect startup timing; do not extend deadlines to make a later trial pass.

Python's version-pinned source calculates a different ordinary bytecode path when the prefix is set, reads that path before compiling, and consults the no-write flag only when deciding whether to write. This supports the coupling above; it does not certify every custom loader, archive, extension or native runtime. [CPython 3.11.15 import implementation](https://github.com/python/cpython/blob/v3.11.15/Lib/importlib/_bootstrap_external.py).

## What is proved now

The 16 artificial checks cover the narrow classifier, all four flag channels, rejection of an absent/wrong prefix or non-boolean/nonempty evidence, source/orphan/unknown/binary/archive retention, header/payload comparisons, and real ordinary-loader path selection using artificial files. A negative control demonstrates that no-write alone still attempts the adjacent cache; the private-prefix fixture bypasses it without executing the source body or writing cache files.

The current/historical projected strict sets both contain 10,021 files; no membership differences, no strict content differences and all critical inputs remain. The 1,770 current observational caches are not all individually decoded or source-compatibility-reviewed: only the four named differences received payload comparison. Safety of their future exclusion depends on the coupled bypass, not on assuming all cache bodies harmless.

## Authority and next task

This is **proposal-only artificial qualification**. No catalog, source, binding or installed setting was changed. No grant, actual run scope, startup reservation, runtime launch or participant authority was created. The old invalidated request stays invalidated.

Recommended next bounded task: implement this single coupled policy in an **additive disabled successor**, including every crosswalk surface and negative test, then perform its no-execution preflight. This can proceed only when separately requested; native activation or a trial would still require a fresh exact readiness request and authorization afterward.
