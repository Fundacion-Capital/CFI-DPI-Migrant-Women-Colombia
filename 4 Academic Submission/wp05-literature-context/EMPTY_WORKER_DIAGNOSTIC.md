# WP07 Appendix C2 — R05 bounded empty-worker diagnostic

**Disposition: startup did not qualify.** One isolated Stata-MCP request admitted an empty arithmetic selection. The worker never became ready; no Stata result, participant load, comparison, fit or busy-stop test occurred. This diagnostic did not alter the approved Appendix C2 emitter or supersede earlier artificial validation of its arithmetic.

| Observation | Recorded evidence and limit |
|---|---|
| Admission | One invocation through a disposable local MCP stdio bridge using the installed session manager. The only selection was `display 2+2`; no file, dataset, model or participant operand. |
| Launch | One native worker launch recorded with a process handle and creation time. An initial probe recorded a live, unsignaled process. |
| Startup | The manager timed out after the 15-second admission window and returned “Session unavailable.” No child import sentinel or target-entry sentinel was observed; captured bridge stderr was empty. This places the failure before verified worker readiness, not at a proven Python/PyStata/SFI statement. |
| Exit and no replacement | Cleanup observed the same creation identity with a nonzero Windows exit time and signaled handle, exit code −15. Bridge registry was empty and stdio closed. A second cleanup observation referred to the same exited handle, not another launch. No other worker launch was observed on this isolated route. |
| Logging | Bridge log, stderr and native event trace stayed in the restricted local diagnostic directory; no Stata/selection transcript was produced by this failed admission. This does **not** demonstrate log confinement of a successfully running worker. |

The harness and the raw receipt hashes are retained in the ignored WP05/R05 audit packet; the diagnostic logs remain in the separate restricted local directory. There were no retries, global-settings or shared-service edits, participant loads, fitting, or Git/Overleaf changes. Distinguish the session manager’s startup error from a result returned by Stata.

**Next decision:** Do not submit Appendix C2’s protected carrier. If further runtime work is warranted, first evaluate the prior startup and StataCorp evidence to choose a diagnostic that observes the child bootstrap boundary or a separately approved isolated Stata-MCP deployment. A longer wait alone does not identify this failure. Any successful empty-start and busy-stop qualification should explicitly demonstrate local logs, same-identity exit and no replacement before protected consideration.
