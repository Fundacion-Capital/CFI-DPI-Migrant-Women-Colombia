# Source and evidence ledger

Inspected on 31 October 2026. Primary-source technical references explain mechanisms; they do not establish the missing historical process trace.

## Official technical sources

- [uv 0.11.28 trampoline implementation](https://raw.githubusercontent.com/astral-sh/uv/0.11.28/crates/uv-trampoline/src/bounce.rs): resource-selected Python path, venv launcher environment, child creation and waiting (`make_child_cmdline`, `spawn_child`, `bounce`; approximately lines 82–165, 248–285, 385–438). The local `pyvenv.cfg` records uv 0.11.28, but the exact binary build has not been independently attested or reproduced.
- [uv 0.11.28 trampoline README](https://raw.githubusercontent.com/astral-sh/uv/0.11.28/crates/uv-trampoline/README.md): Python/script trampoline resource model. No build, installation or replacement was performed.
- [Microsoft: TerminateProcess](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-terminateprocess): required termination rights, asynchronous completion, and error 5 for an already-terminated process. It does not prove the cause of the retained untagged denial.
- [Microsoft: TerminateJobObject](https://learn.microsoft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-terminatejobobject): job/child-job process termination and rights. A job-operation denial is not covered by the proposed process-race rule.
- [Python 3.11: venv](https://docs.python.org/3.11/library/venv.html): Windows redirectors as general context only. The actual selected binary is identified as a uv trampoline, not asserted to be the stock CPython redirector.

## Exact local evidence, restricted metadata

- Current `wp06-inventory-successor/deployment.json`, `win32_owner.py`, `native_provider.py`, `runtime_roles.py`, `deployment.py`, startup/channel code and existing fixtures; source-exact fingerprints retained privately.
- Shared `wp06-live-control/live_windows.py`: retained physical identity and original `stop_process`/`stop_job` methods. Definitions imported only for fake tests; native constructor never invoked.
- Selected venv executable: 45,568 bytes, SHA-256 `023574470d2cf8a3bd40ae9ead59e7d49608b0065675de00b83b57caf1060af0`. Contains uv trampoline/resource markers, a child-create API import and its exact base-image path.
- Bound base interpreter: 91,648 bytes, SHA-256 `ae7e969410d751d010c2ca03394fe5c53230fbf48ca7d368b897e455eca14fba`.
- Stock venv template under that base: 262,144 bytes, SHA-256 `4cca2027319c08dca5cc4b64c9ba415cc89205152202cb6805081277c43b610f`; not byte-identical to the selected image.
- `pyvenv.cfg`: 176 bytes, SHA-256 `664a76385bbf67a7d56541c380b0461105b70d94e6c4b9945e4dcd2d615c2c0e`; base `home`, CPython 3.11 and uv 0.11.28. No selected executable was run to inspect its version.
- Sealed failed empty trial: `bootstrap.watchdog.rejection.json`, parent ownership/exit/closure/cleanup, client receipt and logs. Python arbitrary-precision integers preserve native birth/tick operands exactly; no floating-point PID/birth reconstruction.
- Last failure-custody anchor: SHA-256 `5dd459c45e9ef1cada0b0e770dc17806e9e403f0c6a77697a08dc31eb5e2f24d`. It covers 84 failed-trial/final-audit files. Its passing readback is custody only, not native acceptance.
- Existing Graphify graph, read-only bounded locator query: `bootstrap identity launch native`, DFS budget 1,000; 166 matches, 11 displayed. Exact source and saved witnesses take precedence. No graph refresh or cache-write option was used.

## Explicit unknowns

No historical parent-child/image-chain attestation; no exact binary-build reproduction; no operation/role tag on the old access-denied error; no live reproduction of the proposed remedy; no SDK/base-interpreter native compatibility qualification; no identification of the settings writer. These unknowns are not replaced by passing fixtures.
