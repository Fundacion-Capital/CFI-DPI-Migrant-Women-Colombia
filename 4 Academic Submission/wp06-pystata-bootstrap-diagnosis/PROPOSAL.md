# Minimal conditional remediation proposal — not implemented or authorized

## Recommended next deliverable

An **additive disabled Python-DLL-bootstrap successor and artificial-only acceptance package**, preserving the failed provider and every run. No launch, grant, runtime adoption or settings/service change follows from accepting this proposal.

The evidence establishes the failing boundary, not the internal discovery cause. Therefore the proposed first intervention is deliberately narrow and falsifiable: make the exact pinned base Python DLL's directory available through a worker-local loader scope. It may be insufficient if Stata's internal logic does not consult that scope; no success probability or guaranteed fix is claimed.

## Exact intended change boundary

1. Pin the resolved base python.exe, python311.dll and its canonical parent against the existing3.11.15 installation. Extend the disabled binding/preflight's explicit runtime identity to cover the Python shared library rather than relying on a directory name. Do not select another Python version, SDK environment or engine edition.
2. In the future worker initialization only, retain an `os.add_dll_directory` handle for that exact directory before `config.init`; keep the handle owned until worker closure, including the exception path. No global PATH, PYTHONHOME/PYTHONPATH, registry, user-site, .pth or installed-file changes. This proposes a process-local loader change, not a finding that a library was absent or definitely searched incorrectly.
3. Record bounded non-participant pre-init evidence: actual sys.executable and resolved path, prefix/base_prefix, version/architecture, explicit import roots, isolation/site/cache flags and the bound DLL identity. Do not dump the complete environment, sys.modules or filesystem. Preserve the actual exception class/message if initialization fails.
4. If initialization returns, require positive SFI readiness and the actual Stata-provided plugin/module origin before publishing worker.ready. The existing full runtime-identity capture and acceptance recipe remain necessary. A true Stata-initialized flag alone is insufficient because the installed code has a special failed-SFI path. Do not invent the missing historical StataSO_Main return value or change installed config.py to obtain it.
5. Keep the direct base worker, exact isolated MCP recipe, private profiles/cache/home, all ownership/authentication/cleanup checks, every original deadline and the two fixed empty selections unchanged. No extra selection, discovery command, participant load or fit. Any binding/source change invalidates reuse of the prior request and grant.

## Changes specifically not recommended now

- Adding `ado/base/py` alone: it might change the final exception while leaving the earlier Python bridge failure and required stata_plugin unresolved.
- Installing pip packages called sfi/pystata, reinstalling Stata or switching Python: no evidence here justifies replacing the vendor-distributed integration or adding dependencies.
- Broadening PATH or disabling -I/-S: changes unrelated search surfaces and weakens the approved isolation boundary.
- Editing vendor config.py, suppressing its error, returning success after failure, or relaxing SFI/native evidence checks.
- Copying DLLs into the venv, patching uv/global settings, changing services, running exploratory live probes or lengthening deadlines.

## Artificial acceptance before any possible trial

Test correct exact DLL binding and rejection of altered bytes, foreign canonical paths, wrong architecture and unsupported schema; retained-handle lifetime/closure on success and exception; bounded metadata allowlist; rejection of false/missing SFI or foreign plugin evidence; unchanged isolated environment/commands/deadlines; missing/failed readiness; preservation of all earlier sources and packets. Use synthetic files/objects and existing artificial adapters only—never initialize a real DLL to test these cases.

The resulting source must remain disabled. A later empty-native trial would need fresh source/readiness seals and explicit single-attempt authority, no retries. Acceptance would require all existing cache proofs, worker/runtime/SFI identity and cleanup evidence plus successful completion of the unchanged empty recipe. Artificial passes are not operational compatibility or participant authority.

## Remaining unknowns

Stata's exact Python discovery result; native return code; effective worker Python/module/DLL state; which dependency, if any, could not resolve; trust/security restrictions; and whether explicit DLL scope changes that behavior. The current read-only task cannot resolve these by inference. If the proposed candidate is later ineffective, no automatic interpreter replacement, fallback or second attempt is permitted.
