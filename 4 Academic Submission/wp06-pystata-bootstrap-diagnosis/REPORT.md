# WP06 — read-only PyStata/shared-library/sfi diagnosis

## Conclusion and scope

The retained failure is at **Stata's Python/SFI bootstrap boundary**, not at the initial import of pystata or initial loading of Stata's engine DLL. The final `No module named 'sfi'` is downstream of the earlier Python-version/shared-library diagnostic. It is not evidence that downloading an sfi package, changing the research code or adding one module directory would repair the runtime.

The exact reason Stata could not establish its Python bridge is **not identifiable from this packet alone**. Its internal Python-discovery/loader decision, native initialization return value and effective worker sys.path/DLL state were not retained. This investigation narrows the mechanism and specifies a minimal conditional next intervention; it does not claim a verified runtime fix.

No native/SDK/MCP/Stata process was launched, explicit DLL load attempted, provider imported, participant record inspected, model fitted, settings/service changed or source repair applied. Ordinary isolated audit Python was used only for file/JSON/AST/header calculations. New diagnostic records are additive. The previous trial remains failed and its authority consumed.

## Source-exact failure chain

1. The fixed owned-role launcher uses `python_base_root/python.exe` directly for worker/watchdog, with the isolated/cache flags and explicit bounded environment. The SDK client uses the venv trampoline; these are different roles. Source: [win32_owner.py](<C:/Users/jzava/Documents/GitHub/CFI-DPI-Migrant-Women-Colombia/4 Academic Submission/wp06-private-cache-successor/win32_owner.py:102>).
2. The worker explicitly adds the pinned site-packages directory and Stata `utilities`, sets process-local `SYSDIR_STATA`, imports pystata.config and calls `config.init('mp', splash=False)`. It does not explicitly add `ado/base/py`. Source: [runtime_roles.py](<C:/Users/jzava/Documents/GitHub/CFI-DPI-Migrant-Women-Colombia/4 Academic Submission/wp06-private-cache-successor/runtime_roles.py:80>).
3. Installed config.py finds and loads `mp-64.dll`, then calls `StataSO_Main` through `_init_stata`. `_init_stata` passes the existing `sys.executable` as `-pyexec`. Source: [installed config.py](<C:/Program Files/Stata19/utilities/pystata/config.py:180>).
4. Retained worker output shows that Stata ran both pinned inert private profiles, then emitted the Python-version/shared-library messages. Initial Stata engine loading therefore succeeded far enough to execute startup; this is not proof of successful Python integration or later analytical execution.
5. Config.init proceeded to `_load_system_config`, which unconditionally calls `_add_java_home_to_path` at its end. On Windows that helper imports sfi before it can inspect Java configuration. That import raises the retained exception. The function name does **not** establish a Java fault: no successful sfi macro lookup is shown. Sources: [config.py init](<C:/Program Files/Stata19/utilities/pystata/config.py:211>), [Windows helper](<C:/Program Files/Stata19/utilities/pystata/config.py:541>), [configuration tail](<C:/Program Files/Stata19/utilities/pystata/config.py:669>).
6. The existing config.init also contains a special negative-return branch for -7100 which can continue after marking SFI uninitialized. This establishes a source-level failure path, **not the actual return value of this run**, which was not captured.

The saved worker traceback, original assessment, failed trial's27 predecessor seals and its own seal remain unchanged. Detailed local evidence is in `audit-local/intake/wp06-pystata-bootstrap-diagnosis-2ff8989-20261102`; authoritative completion is its final seal/readback, not this narrative.

## Findings and their limits

| Question | Verified evidence | What it does not establish |
|---|---|---|
| Did Python find pystata? | The traceback executes the pinned installed config.py. | That config.init completed. |
| Was Stata's engine wholly absent? | Its startup executed the private profiles; the bound mp-64.dll exists and matches its preserved hash. | Complete initialization or a working Python bridge. |
| Is sfi.py absent from the installation? | `ado/base/py/sfi.py` exists,208265 bytes. Its source imports `stata_plugin`. | Importability at the failed point, or a ready in-memory plugin. |
| Is the Python shared library absent? | The canonical base directory contains python311.dll,5842944 bytes, and python3.dll. | That Stata selected, resolved or loaded the needed bridge/dependencies. |
| Is there an obvious 32/64-bit mismatch? | Base python.exe, python311.dll, mp-64.dll and the SDK trampoline have PE machine0x8664 and PE32+ magic0x20b. | Complete ABI, dependency, trust-policy or embedding compatibility. |
| Is the base alias broken? | Its junction resolves to the preserved CPython3.11.15 directory; the direct role source uses the alias. | The exact sys.executable text returned inside the failed worker. |
| Does the worker inherit the ordinary user environment? | Its source environment contains only the explicit Windows PATH and private home/temp variables; isolation flags remain. | Stata's closed-source internal discovery choices or registry behavior. |
| Can the old knowledge graph prove this failure? | A bounded read-only traversal locates older artificial bootstrap/workplan nodes. | Current installed bootstrap facts; no graph refresh or feedback write occurred. |

Static headers and file presence are deliberately not called loader tests. No missing dependency, Windows-policy block, uv defect, Python-version mix-up or Java defect is established. The audit interpreter's own environment is not substituted for the absent worker snapshot.

## Official-source comparison

Stata's documented direct configuration method adds `STATA_SYSDIR/utilities` before importing config and initializing the chosen edition. The provider already follows that locating mechanism, so missing stata_setup.py is not itself an error. NumPy/pandas are not required merely to execute Stata commands. [Stata19 configuration](https://www.stata.com/python/pystata19/install.html)

Stata documents the corresponding Python dynamically linked library as part of Python integration and associates error7100 with loading/freeing it. That is consistent with the observed stage but does not license assigning this run a return value it did not record. [Stata Python integration manual](https://www.stata.com/manuals/ppystataintegration.pdf)

Python's isolated mode ignores PYTHON environment variables, and -S suppresses automatic site initialization. Consequently, PYTHONPATH changes or enabling user-site/.pth processing are not appropriate substitutes for an explicit, source-qualified integration boundary. [Python3.11 command-line documentation](https://docs.python.org/3.11/using/cmdline.html)

Python documents os.add_dll_directory as a process-local search-path mechanism for extension dependencies and ctypes. It is relevant to a conditional loader-scope candidate, but does not guarantee that Stata's own discovery code consults it. [Python os documentation](https://docs.python.org/3.11/library/os.html#os.add_dll_directory)

An upstream Stata-MCP issue reports the same three-message sequence; the maintainer described an environment mix-up in that other case and reported Stata19.5 working elsewhere. It is primary contextual evidence against treating this signature as uniquely diagnostic, not proof of the same cause here. [Upstream issue53](https://github.com/hanlulong/stata-mcp/issues/53)

## Minimal recommendation

Prepare **one additive, disabled worker-local Python-DLL bootstrap successor** for artificial qualification only. Its bounded design is in [PROPOSAL.md](<C:/Users/jzava/Documents/GitHub/CFI-DPI-Migrant-Women-Colombia/4 Academic Submission/wp06-pystata-bootstrap-diagnosis/PROPOSAL.md>). First bind the exact canonical Python DLL and retain its process-local search-directory handle during worker initialization. Preserve all existing isolation, ownership, deadlines, startup profiles and two fixed empty selections. Add only bounded pre-init metadata and a fail-closed SFI-readiness check. This is a plausible minimal candidate, **not a demonstrated repair**; Stata's unobserved discovery behavior may mean it is insufficient or redundant.

Do not combine it with sfi-path injection, PATH expansion, interpreter replacement, pip installation, registry edits or persistent Python settings. Multiple simultaneous changes would hide which boundary mattered. If an eventual separately authorized empty trial still fails, preserve that one result and decide the next change from its evidence—no automatic fallback, retry or deadline extension.

## Audit completion boundary

Entry checks verified28 predecessor seals,3766 file references and3817 inherited protected pins, plus27 named diagnostic inputs. The new checker initially rejected270 legacy path spellings despite identical bytes; its path-preservation regression was observed failing and then passing, with the original records untouched.

One fresh independent read-only review confirmed the substantive diagnosis and conditional proposal, independently checked all3817 protected pins and27 diagnostic inputs, and found one Important closure-contract gap: qualification receipts were not mandatory at seal/readback. In one file-only corrective pass, a shared validator was added to both boundaries. It requires core documents, preserved test attempts and exact successful normal/optimized receipts bound to the current checker/test bytes. Missing, failed, wrong-mode, stale, missing/duplicate/foreign-source and native-claim mutations were observed failing before correction. Both final suites then passed **8/8**, with zero failures/errors/skips and zero native launches. No second independent review is claimed; no Critical or deferred Minor finding remains.

The final source-bound receipts, disposed review, preservation seal and separate readback govern actual closure, not this report. No historical provider tests or native qualifications are claimed to have been rerun. Settings/cache checks concern retained endpoints, not continuous surveillance. The participant, scientific, institutional and release gates are not advanced by this diagnosis.
