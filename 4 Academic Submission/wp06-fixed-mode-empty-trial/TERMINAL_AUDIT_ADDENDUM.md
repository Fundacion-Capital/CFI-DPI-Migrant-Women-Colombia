# Terminal result — failed trial and failed final live-input qualification

This addendum records the final result after the frozen REPORT, review, test receipts, audit_final, audit_summary and final_snapshot were produced. Those originals remain unchanged. Read this addendum with REPORT.md; it does not replace or repair any earlier failure.

## Final boundary result

The broad final comparison checked all 27,913 pre-existing project files and 11,734 external files and found zero byte-content differences at that boundary. All 18 predecessor seals, covering 3,155 file references, remained intact. All 17 saved run files still match the immediate post-trial snapshot.

Nevertheless, the final qualification correctly FAILED. Settings returned from the previously observed PROSE state B to the entry COMMANDS content state A while the broad scan was running. The recorded modification time is 31 October 2026, 01:28:34.612633 Berlin time (00:28:34.612633 UTC). The current content hash again equals the entry hash, but metadata changed and the observed A → B → A history cannot be treated as continuous unchanged settings.

Both frozen final artificial receipts had passed 182 tests when run against state B. At the final boundary, their sole fingerprint mismatch was the global config path. The final audit therefore reports FAILED_ARTIFACT_AUDIT, artifact_audit_passed=false and overall passed=false, with errors for stale final-suite inputs and the unrecorded settings return. There were no other input differences, project changes or prior-seal changes. The writer remains unknown. This workflow neither changed nor restored settings.

No replacement observation window, test refreeze, renewed grant, native rerun or settings adoption was taken to turn this result into a pass. The native failure remains the watchdog identity rejection, later parent initialization expiry and incomplete access-denied cleanup described in REPORT.md. These are separate from the settings-history issue.

## Preservation-only closure

The normal success-path semantic seal/readback cannot pass after this failed qualification and will not be represented as passed. Instead, an explicitly named failure_custody_seal and separate-process failure_custody_readback preserve and check the bytes and complete file/directory set of the failed packet, including its original failed final audit and snapshot, all run witnesses, the terminal settings observation and this addendum.

A custody-only readback proves that the failed record is intact; it does not make stale tests current, restore settings continuity, validate native cleanup, clear institutional/scientific/participant gates or authorize another attempt.

The original source/provider/client and trial operator files were not repaired or retried. The one native attempt remains consumed and its admission grant expired. No participant records were inspected or processed, no fitting occurred, and no settings/service change, commit, push, synchronization or publication was performed by this workflow.

## Next substantive work

One consolidated source/saved-state diagnostic and artificial-fixture remediation proposal should address the actual launch-identity mismatch and the recorded access-denied rollback path. Settings-writer/continuity investigation remains separate and unresolved. No further native execution or source/settings correction is authorized by this failed-trial closure.
