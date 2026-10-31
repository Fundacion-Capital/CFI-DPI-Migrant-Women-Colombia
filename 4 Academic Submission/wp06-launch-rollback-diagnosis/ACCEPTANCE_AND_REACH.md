# Proposal acceptance and exact change reach

This document specifies artificial acceptance only. All selected-runtime, scientific and participant gates remain closed/unestablished.

| Place | Proposed change or preserved boundary | Required check |
|---|---|---|
| `win32_owner.Kernel.spawn_suspended` | Bound base image for native roles in application and argv[0] | Fake ABI observes both; unpinned image rejected before creation; suspended/hidden flags and private pipe ordering unchanged |
| `win32_owner.Kernel.stop_process` | Role-local override, without modifying shared `live_windows.Native` | Exact retained handle/PID/birth; already-exited fast path; single call; error-5 conditional exit proof; all other cases fail |
| `NativeOwner.__init__` / `_stop_retained` | Collect exact-shaped role receipts, including denial | Missing/extra/wrong-code receipts fail; no silent exception suppression |
| `NativeOwner._rollback` / `observe_exit` | Attribute inner/outer job and worker/watchdog process stages; publish receipts in rollback and uninitialized-shutdown exit paths | Job denial fatal; failed postchecks retain original denial and notes; exit/zero active/handle closure/evidence-write/absolute ceiling still required |
| `runtime_roles.check_bootstrap` | No change | Original identity mismatch still rejects; matching artificial identity can pass; no relabeling |
| `empty_client`, `mcp_adapter`, SDK stdio and venv inventory contract | No change | Do not globally replace `binding['python']`; that would alter both client routing and inventory-root derivation |
| Startup profiles/environment/inheritance/deadlines | No change | Existing artificial suite plus explicit creation flags, handle inheritance, resume order and absolute-ceiling fixtures |
| Shared `wp06-live-control` primitives and callers | No change | Source fingerprints preserved; no change to unrelated control paths |
| Catalog, deployment binding, grant and runtime acceptance readers | **Future disabled-successor work only** | New exact source catalog; pin base image; schema-aware parent receipt reader; reject malformed/missing evidence; no reused grants or old acceptance results |
| New fake ABI/owner fixtures | Private diagnostic case only | Source-derived candidate methods evaluated in memory under effect guards; normal and optimized Python |
| Exported patch | Review only; unapplied | Exactly equals `proposal.patch_text()`; AST changes limited to six named methods; no active source mutation |
| Historical packets/settings/institutional matters | Preserve, do not adopt or resolve | Seal readback; no retroactive native acceptance, settings restoration, institutional approval or scientific validation |

The `TerminateProcess` return receipt is an operation-level observation, not standalone cleanup acceptance. Even a proposed race-qualified receipt cannot substitute for both retained exits, no active owned processes, full handle closure, trusted evidence publication and the existing deadlines. In a future native verifier, an absent or unknown receipt must remain a failure, not a fallback to older witness formats.

No additional features, fallback executables, process enumeration, process-tree guessing, service changes or timeout extensions are included. Full SDK/base-interpreter compatibility and actual native cleanup behavior were deliberately not tested here.
