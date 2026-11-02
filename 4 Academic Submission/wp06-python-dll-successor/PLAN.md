# Disabled Python-DLL-bootstrap successor implementation plan

> Execution: superpowers:executing-plans, inline TDD, one fresh read-only final reviewer. The owner explicitly requested implementation of the existing conditional proposal, not another design checkpoint.

**Goal:** implement the approved worker-local candidate as a separate disabled provider and qualify its behavior with artificial inputs only.

**Architecture:** copy the preceding source into this new source-bound package, preserving it unchanged at its original path. Add one small Python-bootstrap module; extend the existing binding, worker lifecycle, authenticated ready payload, saved reader and artificial fixtures. No alternate launcher, fallback or service integration.

**Tech stack:** existing Python3.11 standard library and artificial Win32/MCP fixtures. Ordinary isolated audit Python only; no SDK/native/Stata/DLL execution.

**Spec:** [approved proposal](<C:/Users/jzava/Documents/GitHub/CFI-DPI-Migrant-Women-Colombia/4 Academic Submission/wp06-pystata-bootstrap-diagnosis/PROPOSAL.md>) and the owner's current implementation request. Base HEAD8d153167bc393cd021a1e040839193da13ac239f.

## Global constraints

- Preserve all packets and original source bytes; additive new source and ignored evidence only. No commit, push, cleanup, cloud synchronization or worktree relocation.
- Remain disabled/unassigned: activation_allowed=false, runtime_ready=false, client/stdio disabled, no grant or prepared run. No participant processing, fitting, settings/service changes or live probes.
- Keep direct base worker, SDK client interpreter, isolation/cache flags, six-field environment, profiles, commands, two literal empty selections and every deadline unchanged.
- Pin the exact canonical base executable, python311.dll and vendor sfi.py. Structural and file/PE checks are not native compatibility proof.
- Acquire only the exact worker-local DLL-directory handle, retain through worker lifetime, and close on initialization failure and normal/error closure. Never change global PATH or add an sfi directory.
- Bounded allowlisted pre-init/failure records; preserve the primary exception if recording or cleanup also fails. Require positive SFI/plugin and loaded Python-DLL/SFI-file evidence before worker.ready.

## Review focus

1. Disabled binding must reject before any native/DLL/SDK activity; a changed source invalidates earlier authority.
2. Foreign/missing/altered/aliased/wrong-architecture DLL/SFI pins must fail closed, not become a new baseline.
3. Constructor failures occur before main assigns engine: the acquired DLL handle must still close, retaining original and cleanup/recording errors.
4. File existence and a Stata-initialized flag are not SFI readiness; reject false/missing/foreign Python-plugin evidence. Synthetic builtin-plugin profiles are not adopted native observations.
5. Changed ready payload and identity keys must reach parent admission, saved readers and fixtures; no legacy fallback. Final normal/optimized tests must bind current sources, and final seal/readback must require them.

## Tasks and acceptance

- [ ] **1 — entry and source staging.** New ignored packet wp06-python-dll-successor-8d15316-20261102 records current scope, settings/cache endpoints,29 preceding seals and named source pins. Copy only existing Python source/tests plus the client contract, never prior status claims. Verify predecessor bytes; new root absent/unprepared. Expected: zero drift and no runtime authority.
- [ ] **2 — DLL specification and worker lifecycle (TDD).** New python_bootstrap.py exposes check_spec(binding), verify_files(binding), metadata(binding,runtime=sys), require_sfi(binding,config,sfi,plugin), check_ready(binding,proof), and bounded record(binding,kind,payload). First artificial tests must fail on absent behavior, then cover exact pins/schema/PE, metadata bounds, SFI rejection and acquired-handle cleanup. Update only this successor's deployment/preflight/runtime_roles and fixtures. Expected: no real import, DLL-directory call, thread, SDK, process or service effect.
- [ ] **3 — ready evidence and package integration (TDD).** Extend parent and saved reader to require the new bootstrap proof and six-component loaded identity. Rebind disabled schema/paths/client contract to new source and unassigned private root; build complete strict runtime inventory using the existing V2 cache policy. Test missing/foreign evidence, old schema/payload rejection, unchanged controls and no-grant denial. Expected: complete current artificial suite plus preserved predecessor source regressions pass in both modes; no run prepared.
- [ ] **4 — review and final acceptance.** One fresh read-only review; one material TDD correction pass if needed. Reverify all preserved pins, settings/cache endpoints, exact source delta and mandatory source-bound receipts; static preflight only, seal and separate readback. Add README/ACCEPTANCE/STATUS and full commit message. Expected: offline qualification only; loaded runtime, candidate effectiveness, participant/scientific/institutional/release acceptance remain false.

All source and metadata interfaces are inspected before implementation; scoped changes must be covered by the owning task. Preservation and the owner's no-launch constraints override skill-default commits, worktrees, deletions or unrelated test commands. Final JSON receipts govern actual closure, not checked boxes in this static plan.
