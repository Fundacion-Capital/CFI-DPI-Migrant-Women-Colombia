# WP06 — source-exact startup and verification-cost reconciliation

Date: 30 October 2026. Scope: offline source review, one instrumented disabled preflight and artificial tests. No native, selected-interpreter, SDK or Stata launch; no participant inspection or fitting.

## Conclusion

The cost concern is real at the contract level: the conditional successful preparation-to-engine path contains **five full-inventory verifications**, not one. **Two role verifications are sequential under the same owner-origin + 60-second bootstrap deadline.** The client and server checks precede the owner clock; the client check also precedes its asyncio timeout. These are exact-source findings, not observations of a native run or a diagnosis of the earlier failed attempt.

A single instrumented offline preflight verified the complete unchanged 11,785-file inventory in **15.958 seconds**. File-content hashing accounted for about **1.736 seconds**; scanning and other catalog work accounted for most of this observation. This identifies metadata/path handling as the bounded investigation target. It does not establish the cause of the prior 19.797/137.469/47.032-second variability or clear native capacity.

**Current settings differ from the preceding readiness checkpoint.** The settings file changed from 12,734 to 12,735 bytes, with a different SHA-256 and modification identity. No contents were inspected, settings changed, or difference adopted. The preceding request remains unchanged and unapproved; it cannot be treated as current readiness evidence. This report creates no replacement request or authority.

## Exact path and clocks

| Conditional stage | Complete inventory check | Relation to clocks |
|---|---|---|
| Authorized preparation | `startup_guard.prepare_authorized` calls `verify_inventory` | Before the client timeout and owner origin |
| Client entry | `empty_client.main` calls `load_active` | Before the client timeout and owner origin |
| Server entry | `mcp_adapter.main` calls `load_active` | Inside the client timeout scope, before owner origin |
| Watchdog role entry | `runtime_roles.main` calls `load_active` | After owner origin, before watchdog readiness |
| Worker role entry | `runtime_roles.main` calls `load_active` | After watchdog readiness, before engine readiness |

`load_active` performs a full catalog verification, identity-pin checks and smaller startup-directory/profile checks ([deployment.py](../wp06-lifecycle-remediation/deployment.py#L162)). The full check enumerates the expected runtime set, resolves catalog paths, checks sizes and hashes every catalog file ([check_catalog](../wp06-lifecycle-remediation/deployment.py#L106)). The offline `preflight.inspect` is a separate one-check diagnostic; it is not an additional stage automatically included in the five-stage path.

The client timeout begins in `_connect`, after entry validation, client reservation and SDK-environment entry ([empty_client.py](../wp06-lifecycle-remediation/empty_client.py#L74)). The server validates its inventory before constructing its native kernel, importing the SDK and creating `NativeOwner` ([mcp_adapter.py](../wp06-lifecycle-remediation/mcp_adapter.py#L109)). The owner records its origin after channel preparation ([native_provider.py](../wp06-lifecycle-remediation/native_provider.py#L15)). Therefore, a 120-second owner deadline is not a whole-invocation deadline, and the client's asyncio timeout is not proof of independent hard termination.

The parent resumes the watchdog and waits for its readiness before bootstrapping/resuming the worker; both waits use **the same** origin + 60 deadline ([initialize](../wp06-lifecycle-remediation/native_provider.py#L211)). Each role performs `load_active` before reading/admitting its bootstrap packet ([runtime_roles.py](../wp06-lifecycle-remediation/runtime_roles.py#L202)). `check_bootstrap` rejects a tick at or beyond the deadline, and worker readiness is checked again after Stata initialization. The second role does not receive a fresh 60 seconds.

The owner clock also includes server setup, client handshake and delay before the first selection. Selection admission must precede origin + 80 seconds; each selection has its own nominal 10-second result deadline, with result acceptance before origin + 90. Existing containment/final-evidence thresholds remain 90/95/100/110/120 seconds. These are source-designed predicates and controls, not measured native guarantees. A future 900-second grant lifetime would not extend any of them.

## One instrumented offline observation

| Span | Calls | Inclusive elapsed seconds |
|---|---:|---:|
| Whole disabled preflight | 1 | 15.958 |
| `verify_inventory` | 1 | 15.862 |
| `check_catalog` | 1 | 15.831 |
| `scan_roots` | 1 | 5.190 |
| File-content digest operations | 11,785 | 1.736 |
| Python grammar parsing | 23 | 0.074 |

The spans are nested and must not be summed. Within `check_catalog`, approximately 8.905 seconds remain after subtracting the separate scan and digest spans. The source places path resolution, membership construction and per-file metadata/opening around those operations; this profile does **not** separately measure each of them. No OS/antivirus/load/cache explanation is established. Instrumentation adds overhead, and the interpreter, filesystem/cache state and path differ from an actual isolated native startup.

All 11,785 digests were unique and exactly matched the catalog file set; no checks were skipped. The catalog describes 780,867,581 file bytes. Before/after fingerprints for all 23 provider modules matched. No native/SDK/process/endpoint operation was admitted. No overlapping scan or test was launched by this workflow during this measurement; external host load was not probed.

## Sensitivity, not a native prediction

The following arithmetic assumes every full check costs the same retained duration and every other operation costs zero. Actual stage costs may differ, and earlier failure prevents later stages. Positive headroom is not feasibility; exhausted headroom means only that this artificial scenario cannot meet the strict predicate even with zero other work.

| Uniform seconds per full check | Two role checks under 60 seconds | Bootstrap headroom | Server + two roles under client 120 seconds | Client-scope headroom |
|---:|---:|---:|---:|---:|
| 19.797 | 39.594 | 20.406 | 59.391 | 60.609 |
| 137.469 | 274.938 | -214.938 | 412.407 | -292.407 |
| 47.032 | 94.064 | -34.064 | 141.096 | -21.096 |

The strict bootstrap boundary exhausts at 30 seconds per role check, before all other work; the three-check client illustration exhausts at 40 seconds per check. Preparation and client-entry work remain outside that client timeout, and server-entry work remains outside the owner clock. Do not multiply the observed preflight into a claimed measured startup duration.

## Recommended disposition

Keep the exact provider, inventory, deadlines and historical request unchanged. Do not authorize the trial from this packet. Proceed next with a **fresh disabled, security-preserving inventory-verification optimization**, focused on redundant path/metadata operations, followed by complete artificial rejection tests and offline profiling. Do not cache away per-role validation, trust metadata instead of hashes, narrow the inventory, raise deadlines or run native code as part of that work. The exact bounded requirements are in [RECOMMENDATION.md](RECOMMENDATION.md).

The graph was read only for vocabulary and navigation; it has no nodes for this later successor. Exact source citations and the extracted [SOURCE_TRACE.json](SOURCE_TRACE.json) establish the static claims. The graph was not rebuilt and caches were not refreshed. No new scientific, participant-data, institutional, submission or release decision follows.

## Validation and preservation status

The private packet retains the deliberately failing model regression, initial extractor failures, successful artificial tests, one complete offline profile, source fingerprints and final audit/readback. Consult `audit_summary.json` for the final test counts and preservation outcome rather than treating this narrative as a runtime acceptance receipt. All authority and native-capacity flags remain false.

One fresh-context independent review confirmed the principal source findings and identified one important stale-evidence acceptance gap. The executor added fixed fingerprints for the non-output report/JSON inputs, fresh JSON loading at both audit boundaries, and a second identity check within validation. Regression tests cover changed report/profile/trace/settings observations and between-pass changes. The original review verdict and all earlier receipts remain preserved; there is no independent post-fix endorsement. One minor improvement—direct provenance links from historical timing rows to the original receipt fields—is deferred; the reviewer found the copied values agree with those retained receipts.
