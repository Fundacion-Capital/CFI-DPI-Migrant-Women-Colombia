# WP06 settings, startup scope and empty-native activation readiness

**Review complete; activation is not ready and is not authorized.** This is a no-execution review of the existing sealed candidate. It does not change the candidate, historical analysis, manuscript, participant data, installed extension, global settings or institutional/release decisions.

## 1. Settings difference: established facts and limits

The preceding packet expected a 12,442-byte global Codex configuration with SHA-256 prefix `4b00bef7`. It later observed another 12,442-byte version, prefix `2f2cb198`, without owner adoption. The current review observes a third version: 12,734 bytes, prefix `61e2d707`. Full fingerprints are retained privately. The old failed broad audit remains failed; the old qualified seal remains artifact-only. A current entry observation is not a substitute approved baseline.

The two specifically retained September configuration backups are identical to each other, 9,554 bytes, and match neither historical fingerprint. The project configuration records retain fingerprints, not comparable copies of the two historical contents. This bounded investigation therefore cannot establish an exact field-level diff, the cause or the actor. It did not search unrelated application histories, recover deleted files, infer changes from equal file sizes, expose credentials or restore/adopt settings.

The current TOML parses successfully. Redacted structural inspection finds a URL-based `stata-mcp` declaration, not a configured local stdio instance of the disabled native candidate. No endpoint was contacted. Settings precedence means a user file alone does not establish all effective client settings; project overrides, selected profiles and managed constraints may matter. See [official Codex configuration guidance](https://learn.chatgpt.com/docs/config-file/config-basic).

The isolated source path does not itself read the global Codex TOML. That limits its direct relevance to worker initialization, but does not resolve the historical preservation exception or authorize a new client configuration.

## 2. Startup scope: what was and was not checked

Installed source confirms the worker calls `config.init('mp', splash=False)`. This suppresses the splash display, not startup profiles. Windows Stata searches the installation directory, working directory, PATH, USERPROFILE and ado-path for startup profiles; `sysprofile.do` precedes `profile.do`. See [Windows startup documentation](https://www.stata.com/manuals/gswb.pdf), [startup-profile guidance](https://www.stata.com/support/faqs/programming/profile-do-file/) and [PyStata configuration API](https://www.stata.com/python/pystata17/config.html).

The review checked 39 exact named locations for `profile.do`, `sysprofile.do` and `pystata.conf`, plus 12 conventional ado-letter paths for the two profile names. No file was found at those checked paths. Coverage includes the installation directory, proposed private cwd/home, repository and host-home comparison paths, proposed bounded Windows PATH directories and conventional ado directories. The unassigned future run directory was not created.

This is point-in-time absence at named paths, not an exhaustive machine search or proof of effective startup emptiness. No registry or saved-preference query, native initialization, effective ado-path observation or all-frame/object inspection occurred. Host-home and repository observations are context only: they are not the proposed worker's home/cwd. The 51 path checks are not 51 existing files.

## 3. Concrete compatibility finding

The sealed child environment explicitly supplies `SYSTEMROOT`, `TEMP`, `TMP`, `STATATMP` and `USERPROFILE`, but omits `PATH`. Installed PyStata's Java-home helper reads `os.environ['PATH']` when its Stata Java-home value is nonempty.

A source-extracted function fixture, with fake `sfi`, platform and environment objects, establishes:

| Artificial case | Observed result |
| --- | --- |
| No PATH; nonempty artificial Java home | `KeyError('PATH')` |
| No PATH; empty artificial Java home | Returns without that error |
| Explicit bounded PATH; nonempty artificial Java home | Returns; only the fake environment changes |

This is a confirmed conditional compatibility defect, **not an observed failed Stata launch** and not proof that the host's Java-home value is nonempty. No Stata module, engine or native control API was used in the fixture. No real environment variable was changed.

## 4. Minimum successor remediation—not applied here

Preserve the old source and seal. Make an additive, separately identified local successor addressing these three items together:

1. Add an explicit, bounded child PATH containing only the Windows `System32` and Windows directories initially. Do not inherit the full host PATH or change global settings. Validate the installed helper's behavior with the same artificial cases; any later Java-directory addition must be accounted for within the pinned Stata installation.
2. Require a fresh per-run root and known-empty private home/temp directories. The current `mkdir(..., exist_ok=True)` is not, by itself, proof of empty startup contents. Reject pre-existing or unaccounted startup files; do not erase them.
3. Place fixed comment-only `sysprofile.do` and `profile.do` files in the private cwd, under create-only writes and exact fingerprints. Recheck that no installation-directory profile precedes them. This is the proposed narrow way to stop profile search before unrelated PATH/home/ado locations, rather than changing users' profiles or inferring effective defaults. It is a proposed application of the documented search order, not a measured native guarantee.

Suggested literal content for each private profile is one comment line: `* WP06 empty-runtime startup: no commands, data or external sources.` These are inert proposed startup inputs, not replacements for either approved selection and not permission to execute extra analysis. No `.do` file or active run directory is created by this review.

Other binary initialization, preferences, dependencies, licensing and native control behavior remain unmeasured. The proposal narrows profile-file risk; it does not prove every startup object is absent or resolve those runtime limits.

## 5. Activation disposition

| Bundle | Current disposition |
| --- | --- |
| Historical settings exception | Unresolved and unadopted; third current observation recorded without rewriting history |
| Source/runtime bytes | Existing candidate's fresh static preflight passes; old seals must also pass final preservation audit |
| Startup compatibility | Conditional PATH defect reproduced; minimum correction proposed, not applied |
| Profile/private-directory confinement | Named-path evidence gathered; fresh-root and inert-profile guards remain proposed |
| Exact isolated client route | Not registered or exercised; shared URL declaration is not the isolated candidate |
| Execution authority and native acceptance | No grant, assigned run or authority; actual native/SDK/exit behavior untested |

The appropriate next task is one **combined additive local startup-remediation and no-execution preflight package**: PATH, fresh-directory/profile guards, exact isolated client/deployment contract and the remaining settings checkpoint. It must preserve the old package and use artificial tests only. A later empty-native trial still requires separate exact authorization, one fit-free run, no retries and the existing two literal selections. Do not change global settings or clear the historical exception without express owner direction.

This review does not reopen participant processing, statistical fits or public release. Institutional and coauthor questions retain their existing documentary status.

## Evidence and completion boundary

The ignored review packet contains the entry observation, settings fingerprints and redacted structure, 51 named-path observations, source pins, artificial fixture results, fresh provider preflight, source-bound test receipts, independent-review disposition, final preservation audit and exact artifact seal/readback. `readiness.json` is a documentary decision record, not an executable deployment or grant. `audit_summary.json` distinguishes preservation during this review from the still-failed historical full-preservation contract.
