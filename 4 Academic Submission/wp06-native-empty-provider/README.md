# WP06 native empty-runtime provider

This is an implemented, **disabled** candidate for one isolated, empty Stata-MCP session. Its present acceptance scope is source inspection, artificial tests and a no-execution preflight. It has not started Stata, an isolated worker, a watchdog, an MCP server or a native control operation.

The scientific, participant-processing, institutional and release gates are not changed by this package. No historical analysis, manuscript, participant file, exclusion rule, installed extension, shared service or user setting is edited.

## What is implemented

| File | Responsibility |
| --- | --- |
| `native_provider.py` | One-use worker allocation, retained physical identity, ownership-before-initialization, watchdog startup, bounded transport, independent control, rollback, exit and handle-closure evidence. |
| `win32_owner.py` | Lazy Windows operations: suspended hidden creation, explicit inherited capabilities, nested jobs, private bootstrap, resolved module paths and retained-handle cleanup. No DLL is resolved on import. |
| `private_channel.py` | Create-only, bounded, role-key-authenticated messages tied to run, session, epoch and sequence; fixed parent ownership/runtime/exit/closure records. |
| `native_session.py` | A separately identified native-domain port of the sealed artificial admission policy. The original is unchanged. The clock origin is refined to use the provider's single global origin. |
| `runtime_roles.py` | Fixed empty worker and independent watchdog. Only the two source-exact selections can enter the engine; engine/interpreter/PyStata path-and-disk evidence is checked before readiness. |
| `mcp_adapter.py` | Separate stdio MCP binding using the existing pinned SDK and the installed manager's exact `execute`/join source, without importing or constructing its shared/default manager. Only `stata_run_selection` and `stata_session` are registered. An independent parent lifecycle loop handles idle clients. |
| `deployment.py`, `preflight.py` | Exact inventory coverage, critical pins, loaded-identity evidence validation, explicit grant checks and no-execution compatibility inspection. |
| `deployment.json` | Machine-specific disabled deployment descriptor. It is neither an active configuration nor permission to execute. The larger runtime file inventory remains in the ignored private audit packet. |

The existing Python 3.11 environment belonging to Stata-MCP 0.5.3 is selected as a **future** runtime, together with the installed Stata 19 MP engine and PyStata utilities. Its executable was not launched for this work. Tests use a separate existing test interpreter. No dependencies were installed.

The proposed isolated interpreter uses `-I -S -B -X utf8`, explicit source/dependency locations, a private working directory, private home/temp directories and private named logs. It does not use the shared HTTP service or shell/batch Stata. Role keys stay in memory and a private anonymous bootstrap pipe, not command-line arguments or retained credentials.

## Preserved empty-runtime contract

The selections and bounds are inherited byte-for-byte from `../wp06-empty-stata-contract/contract.json`. There is one nondefault logical session, one worker epoch, exactly two permitted selections, a nominal 10-second timeout per call, no retries and no replacements. The selections check the active frame has zero observations and zero variables. This is not a claim about every possible Stata startup object.

Deadlines share one origin: bootstrap 60 seconds; last dispatch 80; cooperative stop 90; watchdog containment 95; independent observation 100; parent outer containment 110; final evidence ceiling 120. Windows jobs and the watchdog are implemented containment paths; their behavior on this host has not been measured by artificial tests.

Both watchdog readiness and the worker's source-bound runtime identity precede command admission. Normal completion requires actual exit witnesses, zero active owned descendants and closure attempts for all retained handles. Failure consumes the reservation; it does not create a replacement session. A partial allocation also directly stops a retained suspended process that has not yet entered its job.

## Validation and its limits

The completion evidence is `preflight.json` and `audit_summary.json`, backed by an ignored, separately sealed private packet. The package has 75 public artificial tests plus seven private checkpoint/provenance/qualification tests: **82 tests in each of normal and optimized Python modes**. Another **235 inherited pure-test executions** check the existing Stage-B, live-control, contract and owned-policy suites without changing them. These counts include reused policy tests; they are not a count of unique independent experiments.

Tests exercise fake Windows calls/handles, artificial clocks and files, role messages, fake SDK registration and the source-ported policy. They cover wrong code/session/epoch, extra selections, timeout consumption, authenticated frames, partial startup failures, idle-client deadlines, complete inventory additions/removals, finite grant expiration, identity mismatches and refusal to seal changed artifacts. They do not execute an actual stdio conversation or initialize a native engine.

An independent pre-fix review identified five important implementation defects and a nonfinite-expiration defect. Each was reproduced and corrected with regression coverage. The integrator also added the missing resolved-module evidence check during final contract reconciliation. There was no separate post-fix independent endorsement. Failed and intermediate receipts remain preserved; they are not relabeled as passes.

The source inventory binds on-disk bytes and the declared directory/file set. Future worker evidence will compare the OS-resolved engine/interpreter path and imported PyStata paths against those pins. Neither measure attests in-memory code, every Windows system DLL, license behavior, all transitive import resolution or freedom from concurrent external changes.

The broad preservation audit **failed**, with exactly one difference: the global Codex settings fingerprint changed after the entry snapshot. All project files, preceding seals and other protected inputs matched. The original failed audit and both fingerprints are retained privately. The workflow did not edit or restore the settings, cannot attribute the change and has not obtained owner adoption of it. The separate qualified seal accepts only the new source/test artifacts and their documented exception; it does not convert the failed broad audit into a pass. No settings values or credentials are exposed. Any additional file difference, source/test failure or further unrecorded settings revision prevents this narrow qualification.

## Activation remains held

The saved descriptor has `activation_allowed: false`, `runtime_ready: false`, disabled stdio registration and no assigned run scope. No execution grant or active binding has been created. The following remain explicit holds:

1. Fresh authority for one exact bounded empty-native acceptance run—not participant processing or a fit.
2. Resolution of the startup/profile scope for that exact trial. Stata can execute `sysprofile.do` and `profile.do` at startup; a private directory alone does not prove startup is empty. See the [official Stata startup-profile guidance](https://www.stata.com/support/faqs/programming/profile-do-file/).
3. Native and MCP interoperability acceptance has not been performed. Any later authorized trial must preserve its own result, including failure, without retry and without treating this static package as runtime acceptance.
4. The current global-settings difference is unresolved and unadopted. It must not disappear through silent rebaselining.

The next step is the exact settings-difference, startup-scope and activation-readiness check for a separately authorized empty-native acceptance trial. Do not repeat historical fits, inspect participant records or alter the shared service as part of that step. Institutional and research-release issues remain as previously documented; this engineering result resolves none of them.

Implementation references: [official PyStata installation](https://www.stata.com/python/pystata17/install.html), [PyStata configuration API](https://www.stata.com/python/pystata17/config.html) and [official MCP stdio transport specification](https://github.com/modelcontextprotocol/modelcontextprotocol/blob/main/docs/specification/draft/basic/transports/stdio.mdx). The installed SDK's actual interface is pinned locally; citing a newer specification is not an interoperability test or a claim to implement it manually.
