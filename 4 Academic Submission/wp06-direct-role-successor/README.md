# WP06 — disabled direct-role successor

This is an **additive offline implementation**, not the active provider and not a native-ready runtime. The owner adopted the preceding reviewed proposal for this new folder on 1 November 2026. See [ADOPTION.md](ADOPTION.md) for the exact authority boundary and [PLAN.md](PLAN.md) for the implementation sequence and rulings.

## Implemented boundaries

- Native worker/watchdog creation selects the already-bound base interpreter in both the application argument and command line. The SDK client still uses its pinned venv executable; there is no executable discovery, fallback or PID relabeling.
- The exact accepted two-file candidate was the installed baseline. A documented review-driven delta now ensures persistent fresh-observation failure cannot suppress stored denial receipts in uninitialized shutdown; the exit state remains explicitly failed/unknown and errors propagate. The reader rejects this failure witness. Retained-process stops keep exact handle/PID/birth checks and the immediate same-identity exit check before qualifying error 5. All live/unknown/failed-observation and job-denial cases remain fatal.
- Both rollback and the uninitialized-shutdown normal-exit caller publish termination receipts. Existing exit, active-owned, closure and evidence-publication postconditions still apply. No deadline, retry, replacement, literal selection or ownership rule is relaxed.
- Artificial bindings and fake stop receipts are updated to the new interface; shared primitives and predecessor fixtures remain untouched.
- `termination_evidence.read_exit_witness(run_root, expected_scope, required_roles)` reads only the exact parent-exit file. The caller must supply the complete expected scope and all expected stop stages. It rejects legacy/missing receipts, wrong scopes, duplicate/unknown roles, malformed or failed operations, wrong operation/role combinations, noninteger error codes and incomplete coverage. It returns the validated payload, **not** an acceptance decision. A provenance string is not authentication or institutional attestation.
- The inventory marks the new reader and client contract as critical inputs. The static preflight also refuses enabled clients, assigned scopes and existing prepared roots before inventory verification.

## Disabled deployment

`deployment.json` retains `runtime_ready=false`, `activation_allowed=false`, nonempty holds, `stdio.enabled=false`, `client.enabled=false`, `run_scope=null` and an absent `UNASSIGNED_NOT_PREPARED` path. `CLIENT_CONTRACT.json` remains disabled and unassigned. No grant, active binding, profiles, live service or shared registration is created.

The private source/runtime catalog is an exact current on-disk inventory, not a loaded-memory measurement or adoption of historical runtime/cache drift. It intentionally lives under ignored `audit-local`; this folder alone is not a portable, runnable replication package. Old catalogs, providers, failures and seals remain preserved.

## Offline validation

The private case is `audit-local/intake/wp06-direct-role-successor-6438451-20261101`. It preserves the original 169-test baseline, installed-source RED→GREEN adoption checks, fake-interface regressions, reader and disabled-binding controls, complete catalog verification, normal/optimized final receipts, independent-review disposition and final custody evidence. Final outcome is recorded in `AUDIT_SUMMARY.md` and `OFFLINE_ACCEPTANCE.json` only after successful checks.

The existing Graphify map was queried read-only with its own vocabulary as a locator. No rebuild, reflection/save-back, settings change or participant-file ingestion was performed. Exact source and saved witnesses take precedence over that older bounded map.

## What remains separate

No selected venv executable, MCP client, worker/watchdog, Stata engine or participant process is launched by this implementation workflow. Ordinary Python runs only file-based preparation and artificial tests. Passing static and fake tests does not establish Windows/SDK/base-interpreter compatibility, native cancellation, scientific validity or institutional clearance.

The next possible operational stage is a **fresh source-exact readiness and authorization package**, without launching. It must assess the then-current source/catalog, settings observations, operational holds and exact empty-only trial contract. A future native trial requires its own explicit bounded authorization; adoption of this folder is not that authorization. No research analysis or manuscript results change here.
