# WP06 — disabled inventory-successor optimization and offline acceptance

Date: 30 October 2026. This is an additive disabled successor, not an active deployment or execution authorization. No original provider, analytical code, data, settings or deadline was changed.

## Implemented change

Only `deployment.check_catalog` changes operational logic. It obtains the freshly resolved scanned file set once and reuses exact canonical members when normalizing catalog rows. A nonmatching spelling, including every required-only path outside that scanned set, still undergoes the original full `Path.resolve` normalization. Required declarations are not themselves proof of canonical identity. The original scanner, per-entry reparse checks, file-set comparison, duplicate/critical-pin checks, size/stat operations and every content hash remain in place. There is no persistent cache, extra backend, optional validation mode, metadata-only trust or shared per-role acceptance result.

The existing 23 Python modules and client contract were copied byte-exact before modification. Of those modules, only `deployment.py` differs afterward; `test_inventory.py` is the sole added provider module. The fresh inventory retains the exact 11,762 non-provider rows from the old catalog and replaces its 23 source rows with the 24 new source/test rows. It does not silently adopt changed external-runtime bytes. Complete offline verification checks those retained bytes afresh.

The source, entry point and client/server descriptor paths point to this new folder. Runtime readiness, activation, client and stdio enablement remain false; run scope is unassigned and its private root is absent. No grant, active binding, launcher or run reservation is created. Older requests do not identify or authorize this successor.

## Tests and behavior preservation

The performance regression was observed failing before implementation: 25 path resolutions for 12 real artificial files and one root exceeded the 13-call ceiling. The same check passed after the change. It proves elimination of redundant canonical-member resolution, not a native timing limit.

The first candidate reused required declarations as well as scanned members. Self-audit found that a noncanonical required alias could hide an alias duplicate. A new regression reproduced acceptance where the predecessor rejected it. Before acceptance, version 1 was archived byte-exact (36 source/validation files plus its existing receipts), the fast-match set was limited to scanned members, and a new catalog/descriptor and full serial comparison were produced for corrected version 2. No version-1 measurement or passing receipt certifies final-source acceptance.

The new inventory tests exercise complete hashing, same-size/changed-size mutation, added/missing/renamed files, duplicate and missing critical rows, schema/root/required/empty/malformed cases, dot aliases, duplicate aliases, Windows case variants, ignored files, all/importable/top-level-DLL modes, reported reparse files/directories/ignored entries, and scan errors. Differential checks compare results or exception types with the preserved predecessor on those stable artificial fixtures. Reparse metadata is explicitly simulated; no real symlink, junction, native process or host probe is created.

The scanner still resolves each selected observed path. The optimization merely avoids resolving an already matching canonical catalog member again. Alias spellings retain predecessor handling; no intentional stricter alias policy is introduced. Scanning now occurs before the duplicate/critical-row decision, so a multiply-invalid catalog/filesystem may surface an earlier scan exception. Neither version supplies an atomic snapshot or a comprehensive defense against adversarial concurrent filesystem replacement; no such guarantee is inferred here.

## Complete serial offline comparison

The planned order was predecessor 1, successor 1, successor 2, predecessor 2, each in a fresh ordinary non-Stata Python process. This workflow ran no overlapping tests or broad scans during those observations. Inter-observation gaps and timestamps are retained. External host load, antivirus and cache state were not probed or controlled. Instrumentation adds overhead, and nested timing spans overlap.

| Observation | Full elapsed seconds | Files hashed | Path resolutions |
|---|---:|---:|---:|
| Predecessor 3 | 150.395 | 11,785 | 23,619 |
| Successor 3 | 19.905 | 11,786 | 11,836 |
| Successor 4 | 15.837 | 11,786 | 11,836 |
| Predecessor 4 | 23.779 | 11,785 | 23,619 |

Every observation verified the complete pinned catalog, with a unique digest for each listed file and matching before/after source, descriptor, catalog and settings identities. The one-file increase is the added test module, not a dropped or narrowed runtime scope. Exact timings, original receipt fingerprints and descriptive medians are in `OFFLINE_ACCEPTANCE.json`. The corrected-version medians are approximately 87.087 and 17.871 seconds; the computed percentage is dominated by the 150.395-second predecessor observation and must not be presented as a representative improvement. Both corrected-version successor observations are lower than both contemporaneous predecessor observations, but no general, cold-start, causal or native-runtime estimate follows.

The retired version-1 block remains intact: predecessor 1 = 23.063; successor 1 = 16.631; successor 2 = 15.476; predecessor 2 = 23.255 seconds. Its source archive and all eight observation receipts are preserved; none is discarded to select a faster-looking comparison.

All earlier fast and slow observations remain preserved in their original packets, including the 137.469-second offline observation. The new 150.395-second observation exceeds the unchanged 120-second design threshold in an offline verification context, not in a native run. These checks do not establish the cause of variability or prove it cannot recur. No limit was extended and no slow observation retried or replaced.

## Unchanged clocks and remaining gates

The conditional preparation-to-engine path still contains five full checks. The watchdog must complete its check and report ready before the worker is resumed; both role admissions still share owner-origin +60 seconds. The client timeout and owner origin remain distinct, with work outside each scope as previously documented. All 60/80/90/95/100/110/120-second thresholds, the two literal selections, ten-second call budget, and zero-retry/replacement rules are unchanged.

For illustration only, treating each role check as the slower displayed corrected-successor observation (19.905 seconds) would consume about 39.810 seconds before other bootstrap work, leaving about 20.190 seconds. Actual native role costs, imports, initialization, scheduling and containment remain unmeasured. Positive illustrative headroom is not capacity clearance; a future 900-second grant lifetime would not enlarge a runtime deadline.

The current settings content hash matches the preceding cost checkpoint, but its modification identity differs. The observation is preserved without contents inspection, restoration or adoption. Earlier settings/cache differences and institutional/scientific/release gates remain explicit and unresolved. No participant records were inspected or processed.

## Acceptance status

This report and `OFFLINE_ACCEPTANCE.json` describe an offline candidate. Final mode-specific tests, independent review, complete preservation and seal/readback determine documentary completion through `audit_summary.json` and the restricted packet. No artificial test, fast profile, seal or review alone establishes native compatibility, scientific validity or permission to execute.
