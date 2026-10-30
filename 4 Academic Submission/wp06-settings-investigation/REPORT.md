# WP06 — read-only investigation of repeated settings changes

## Conclusion and scope

The read-only investigation is complete within its stated scope. **The exact recurring A/B difference is identified: `desktop.conversationDetailMode` alternates between `STEPS_COMMANDS` and `STEPS_PROSE`. Every other byte is identical between those two states. The historical writer remains unattributed.** No settings, service, logging policy, Stata analysis, participant data or scientific result was changed. No native/selected-runtime launch, fitting or renewed execution authority was exercised.

The prior optimized-successor request remains retired. This report does not adopt either settings state, restore a configuration, weaken a guard or create a new readiness checkpoint. A passed evidence/custody check for this investigation is not native readiness or historical writer attribution.

## Verified observations

The retained record contains two recurring identities:

| State | Bytes | SHA-256 |
|---|---:|---|
| A | 12,735 | f6dcdc58beb862bd49ec4e2d4d8460a80dc48db8236709fb1985d78d1bbbd235 |
| B | 12,732 | 70b7d140c8625b5e2dd56ba419be7bd284552ffb1971cc9022d0c54e2b448099 |

The changing SHA-256 values establish content differences, not merely modification-time changes. Hashes alone initially did not identify the field; a subsequent complete in-memory comparison and independent reconstruction established the exact difference. Modification timestamps below are reported filesystem metadata, not process-attribution records.

| Retained observation, UTC | State | Reported last-write time, UTC |
|---|---|---|
| Entry, 30 October 2026, 20:46:20 | A | 19:12:36 |
| First series, 20:53:15–20:54:15 | B | 20:46:38 |
| Second series, 21:05:39 | A | 21:00:39 |
| Same series, 21:05:59–21:06:39 | B | 21:05:44 |
| Final series, 21:08:59–21:09:59 | B | 21:05:44 |
| After failed final acceptance | A | 21:42:49 |

The native request was bound to B and its exact metadata. At final acceptance the settings had changed back to A, so the request and complete-input receipts were correctly rejected. The failed audit remains failed; it is not relabeled by this investigation.

### New bounded diagnostic observation

One passive diagnostic observation ran from **22:12:25 to 22:15:25 UTC**, taking **361 readings over 180.453 seconds**. It recorded state A throughout and no content change. Entry and final reads had matching size, hash and modification time, with internally consistent read boundaries. This is a bounded observation, not proof of uninterrupted or future stability.

After that window ended, a normal investigation read observed **state B again**, with reported last-write time **22:16:35.922 UTC**. Therefore the recurrence was still active; the quiet window did not solve it. No client action, settings toggle or file write was induced to produce this transition. The exact B bytes were held in memory only; no complete configuration or credentials were copied into this project.

The non-secret model, reasoning, personality, sandbox-mode, web-search, reasoning-summary, verbosity and service-tier lines displayed in the A and B observations were unchanged. A further natural recurrence then supplied a complete A/B comparison, resolving the earlier field-level uncertainty.

### Exact difference, independently reproduced

At a later observation, A had returned, with reported last-write time **22:30:28.416 UTC**. Comparing it against the B bytes still held in memory isolated line 248 under `[desktop]`. The changed value is:

| State | `desktop.conversationDetailMode` |
|---|---|
| A | `STEPS_COMMANDS` |
| B | `STEPS_PROSE` |

Replacing only that line in memory reproduced both entire historical files' hashes exactly, in both directions. A separate standard-library verification at **22:43:27 UTC** independently read the live configuration, reconstructed the other state without writing it, checked both historical size/hash anchors, parsed both TOML documents and found exactly one semantic changed path: `desktop.conversationDetailMode`. Both byte-for-byte round trips passed.

Thus the three-byte size difference is accounted for exactly. Every other byte—including model, sandbox, MCP declarations and credentials—is identical between this specific A/B pair. Credentials and full configurations were neither displayed nor archived. This establishes the recurring pair's field delta, not effective settings in other layers, native compatibility, empirical validity or the cause of older unrelated hash changes.

### Important qualification: do not dismiss it as cosmetic

Static inspection of the installed app build **26.1027.3384.0** found a schema describing how much turn detail Codex shows, with `STEPS_COMMANDS` as the default and `STEPS_PROSE`, `STEPS_COMMANDS` and `STEPS_EXECUTION` as allowed values. The same key also appears in everyday/coding work-mode mapping, execution-configuration loading/change subscriptions and Work-related access/surface logic. Fifteen source contexts were inspected; their fingerprints and the installed bundle identity are retained privately without copying the application source.

Therefore the safe conclusion is **a recurring desktop mode/detail preference**, not a proven presentation-only setting. Its exact effect on the protected native adapter has not been dynamically tested. The current whole-file guard correctly treated a change as invalidating its contract; this finding does not authorize ignoring the field or weakening that guard.

## What was checked

### 1. Preserved project evidence and code

All **16 preservation manifests** verified: **3,086 referenced files** matched their recorded sizes and SHA-256 values, with no changed manifests. This includes the previous 15 packets and the 82-file failed-checkpoint custody seal. Verification used opaque file hashes, not participant-record inspection.

The scoped WP06 settings helpers reference config.toml for reads, hashes or metadata checks. No direct settings-write action was found in the reviewed helper references. Their output paths are audit/proposal/documentary files. This observation does not rule out a client, tool host or another process outside those helpers.

The installed Headroom provider and its setup/registration code were inspected statically as possible configuration-writing components. Such code has the capability to write configuration during setup/registration, but no retained evidence links an invocation to these changes. **Capability is not attribution.** The provider was not started, stopped, reconfigured or contacted as a diagnostic probe.

### 2. Desktop logs

Six date-specific desktop log prefixes were examined with a literal `method=config/` filter. At the recorded extraction boundary they contained **881 config/read events and no configuration-write RPC events**. Thirteen config/read events were within five seconds of the five earlier retained modification-time anchors. The new 22:16:35 anchor was followed by configuration reads and a navigation event in the retained application log.

These are observations of application activity, not evidence that a read or navigation wrote the file. Direct filesystem writes, other clients, omitted log levels and unrecorded operations remain possible. The absence of a write RPC does not prove the app, the user, Headroom or another process did not write it.

Only redacted event metadata, source line hashes and complete-prefix fingerprints are retained in the evidence record. Live logs may append; full-file immutability is not claimed. An initial broad text filter also matched unrelated “configured … changed” warnings; those false positives were excluded from the accepted extraction.

### 3. Existing Windows audit records

Existing Security event 4663 records were queried only in narrow windows around 19:12:36, 20:46:38, 21:00:39, 21:05:44 and 21:42:49 UTC. Each query returned **NoMatchingEventsFound**. The corresponding Sysmon event-11 query returned **NoMatchingLogsFound**.

No audit policy, event logging or service was enabled or changed. These results mean the checked records do not provide a writer attribution; they do not establish that no write occurred or that all possible audit sources are absent.

### 4. Backups and bounded in-memory comparisons

The two inspected pre-Headroom backup files were fingerprinted, without exposing their contents. They did not supply a complete current A/B pair for a direct historical field-level comparison. No claim is made that every possible backup system was searched.

The current A content had no UTF-8 BOM or carriage-return characters. Removing a BOM or normalizing CRLF therefore did not reproduce B. A single documented sandbox substitution, four service-tier substitutions, and all **12,733 single contiguous three-byte deletions** of A also failed to reproduce B. From the subsequently observed B, **3,654 combinations of three non-secret Boolean substitutions** did not reproduce A; a notification-preference substitution did not match either.

Those were exploratory negative comparisons, not an exhaustive reconstruction. They did not establish a cause. The later complete A/B comparison supplied the decisive positive result: the mode value alone reproduces both exact hashes. No candidate was written to disk or adopted.

## Why global settings can matter here

The official configuration documentation distinguishes user-level config.toml from project overrides and other configuration layers. It also states that the CLI and IDE extension share configuration layers. Thus this user-level file is not an immutable, project-owned Stata artifact. The documentation does not identify the writer of this incident. [Official configuration documentation](https://learn.chatgpt.com/docs/config-file/config-basic)

WP06 currently pins the complete global settings identity and metadata. While that contract remains in force, an unexplained change must continue to invalidate an affected checkpoint. No recommendation here authorizes ignoring changes, dropping metadata checks or excluding allegedly cosmetic fields without first establishing the actual difference and separately reviewing any contract change.

## Remaining limits and practical next step

- No credential-bearing configuration was preserved as a project artifact. An initial buffer was lost at a diagnostic tool timeout, but a later natural recurrence supplied A and B, and the exact difference was independently reproduced from the historical hashes. The raw buffers remain unarchived; only the non-secret delta, fingerprints and verification result are retained.
- Existing checked logs do not identify a writer. Live SQLite/WAL state, browser profile databases, unrelated conversation contents and participant records were not inspected. No new logging or process monitor was installed or enabled.
- Two read-only diagnostic tool attempts exceeded their execution limits. An auxiliary invocation also failed without a usable detailed traceback through output compression, and a completed-command capture wrapper required correction. No incomplete result was accepted or exception type assumed. The explicit UTF-8 preservation pass and the later exact-delta proof completed successfully; these corrections did not alter source files or settings.
- This investigation did not establish effective runtime configuration, native capacity, licensing, SDK interoperability, process ownership, cancellation, host cleanup, scientific validity or institutional/release clearance.

The immediate next process is an **owner decision on mode stability and contract scope**, not another unfocused settings investigation. The smallest option is to retain the current strict contract and explicitly hold the intended app mode constant during a separately authorized fresh checkpoint/trial. No mode choice or settings change is assumed here. If normal app use cannot keep the shared mode fixed, the alternative is a separately authorized artificial-only assessment of configuration custody and execution-critical identity; because this key participates in execution-setting paths, it must not simply be excluded as cosmetic.

A controlled client action, new writer-attribution instrumentation, any contract amendment and any native trial would each need appropriate separate scope. No historical writer is inferred from nearby reads/navigation or from installed write capability. Older hash pairs outside the exact A/B pair above remain unadjudicated.

Once the operational choice is resolved, prepare a wholly fresh source-exact checkpoint with a new identity. Do not revive the retired request merely because B reappeared or the field is now understood. Capacity, custody and owner-authority checks still apply. Literature and other non-executing academic work can be planned separately; this investigation confers no authority for empirical execution.

## Disposition

**COMPLETE_EXACT_DELTA_IDENTIFIED_WRITER_UNATTRIBUTED.** The mechanism behind this recurring pair's contract failures is established; the writer, older unrelated changes and the appropriate operational remedy are not adopted or assumed. Existing packets and the prior invalidation remain intact. No settings or service changes, native trial, participant processing, fitting, commit, push, synchronization or publication were performed. The new files are diagnostic records only.
