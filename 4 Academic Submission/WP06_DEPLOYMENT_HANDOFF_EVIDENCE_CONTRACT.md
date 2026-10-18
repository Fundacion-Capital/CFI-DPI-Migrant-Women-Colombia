# WP06 — artificial deployment, credential handoff and independent-evidence contract

## Authority and scope

Owner checkpoint:831bf0304f047e82e105993fdf68edc9b761a32f. This is the bounded successor to the sealed identity/bootstrap packet wp06-identity-bootstrap-5e0d6b0. The owner requested implementation and audit, with the prior no-further-design-checkpoint instruction retained. No host discovery, binding of native libraries, real actor launches, live transport/control, service changes, Stata, participant processing, Git mutation or cloud synchronization is permitted. Test interpreters and local hash/readback tooling are not actor deployments.

Deliverables: additive deployment_contract.py, test_deployment_contract.py, this contract, private source-bound test/review/preservation receipts and additive governance. The fourteen existing Stage-B Python files and every earlier packet are immutable. This stage is not a native orchestrator, secret-management service or evidence-collection service.

## D01 — deployment interface

Construct the contract only from an actual admitted Bootstrap instance with its complete sealed roster and target, not a caller-supplied registry or PID. Construction and subsequent checks read only retained in-memory metadata and the artificial clock; no kernel/API probe is issued. Pin exact RunContext, manifest, roster, target, budgets and compatibility scope digests, plus the caller-supplied implementation digest. The implementation digest is an explicit audit-provisioned pin, not a measured executable image or host attestation.

The returned request has exactly protocol, evidence_domain, run_digest, manifest_digest, roster_digest, target_digest, scope_digest, implementation_digest, budgets, actors, transport and effects. Protocol is WP06_DEPLOYMENT_V1_ARTIFICIAL; transport is IN_MEMORY_ONLY. Actors maps the five roles L/O/S/C/W to exactly actor_digest, credential_id and parent_role from the sealed roster. Effects contains exactly host_probe, launch, live_control, service_change, stata and participant_processing, all false. Request validation requires exact equality to the pinned profile; self-described live effects, new actors, replacements, changed budgets/build/scope and extra secret/configuration fields are rejected. Metadata validation creates no process, channel or control capability.

## D02 — one-use role credential handoff

The trusted artificial coordinator retains the existing Authority; no keys are read from disk, environment, command line, accounts or transport. An actor handoff ticket contains exactly protocol, deployment_digest, role, actor_digest, credential_id, issued_tick, expires_tick, tag. OWNER authenticates its complete body under a distinct deployment HANDOFF domain. An issued ticket is pinned locally; another correctly signed ticket cannot substitute for it. Issue and consume both require current authority and time strictly before the bootstrap ceiling. Expiry is positive integer, no later than that ceiling; equality is expired. Each L/O/S/C/W role has one issue allowance and one consumption allowance. Missing, forged, cross-role, replayed or expired consumption permanently quarantines this contract. No renewal/replacement/retry allowance exists.

The returned endpoint holds only its own role key, own identity metadata and a pinned local authority/clock callback. It receives no OWNER key and no peer key map. This is an in-memory artificial handoff to a trusted embedding, not encrypted delivery, process secret isolation or reauthentication of a live transport peer. The historical bootstrap transcript is not claimed as a fresh host observation. Handoff metadata and all evidence records exclude raw keys; synthetic fixture keys exist only inside tests and memory. Process isolation and production provisioning remain unadopted.

## D03 — evidence sources, schemas and deadlines

Every evidence record has exactly protocol, deployment_digest, role, actor_digest, credential_id, kind, sequence, previous_digest, tick, payload and tag. Protocol is WP06_EVIDENCE_V1_ARTIFICIAL. The MAC domain differs from ticket authentication and binds the complete body, including the deployment digest. That digest binds run, roster, target, implementation and budgets. Sequences are positive integers per role starting1, with zero64 genesis and hash chaining to the previous accepted record from that role. Sender role, captured actor digest and pinned credential must agree. Tick is integer, no earlier than target admission or the previous accepted global evidence tick, no later than the verifier clock, and strictly before the appropriate ceiling. S/W evidence uses the control ceiling; O/L uses cleanup. All acceptance remains before cleanup. Clock rollback/frequency/domain changes, root revocation/quarantine, metadata drift or malformed records stop this contract permanently.

The only accepted global sequence is:

| Stage | Required issuer | Exact payload | Additional acceptance condition |
|---|---|---|---|
| CONTROL_ATTEMPT | S | slot_digest, delivery_status | Slot is SHA-256 of projected worker binding; status ATTEMPTED. UNKNOWN does not advance. |
| WORKER_APPLICATION | W | attempt_digest, terminal | Exact accepted attempt digest; STOP_APPLIED. A supervisor attempt alone is not application. |
| APPLIED_OBSERVATION | O | worker_evidence_digest, applied | Exact accepted worker record; applied is boolean true; independent witness required. |
| EXIT_OBSERVATION | O | application_observation_digest, signaled, exit_code | Exact accepted application observation; signaled true and unsigned32 exit code; independent witness required. |
| CLEANUP_OBSERVATION | O | exit_evidence_digest, inventory | Exact exit record and exact inventory for S/C/W; independent witness required. |
| FINAL_INVENTORY | L | cleanup_evidence_digest, inventory | Exact O cleanup record and exact inventory for O/S/C/W; separate external-L witness required. |

Each inventory is a role-keyed mapping with no missing/extra/duplicated role. Every row has exactly actor_digest, resources_closed, pending_io, uncertainty; it references the captured actor, resources_closed is true, pending_io is integer0, uncertainty is false. O is not allowed to certify its own final closure; external L supplies the final O-inclusive inventory. L's own exit/cleanup is not certified by this contract.

## D04 — independent evidence acceptance

The coordinator is configured with two distinct pinned verifier functions, one for O and one for L. Each receives a defensive copy of the entire O/L record and must return literal boolean true. Missing verifiers, the same callable in both seats, false/nonboolean results, exceptions or unsupported evidence fail closed. A role MAC alone, a caller's success assertion, a supervisor receipt, a worker self-report or an empty inventory cannot establish independent observation. Witness verifiers are explicit trusted inputs and cannot be selected or replaced by the evidence record.

Tests use separately curated synthetic witness registries: the registry pins whole-record hashes to an artificial scenario, not current host facts. Positive exit/cleanup cases validate hypothetical evidence linkage and role separation; they do not derive real closure from still-retained fake backend resources. No receipt is promoted into a real observation. Distinct roles/keys/callbacks prove bounded structural separation, not independent operating-system processes, human institutions, witness honesty or nonrepudiation.

## D05 — failure and acceptance semantics

Record acceptance consumes the next exact stage and per-role sequence only after schema, scope, time, signature, dependency and witness checks. Acceptance snapshots the caller record, rejects a canonical record over8192 bytes, prevents synchronous reentrant acceptance and rechecks current authority/quarantine/metadata and the applicable phase deadline after the witness returns, immediately before commit. Invalid coordinator request/ticket/consume/accept calls quarantine the contract; subsequent clock changes or valid records cannot reset it. Endpoint-local unsupported-kind, serialization and oversized-construction errors are not coordinator intake and do not consume sequence or quarantine the contract. Payload shape and dependency validation are deferred to acceptance; an endpoint can sign malformed serializable input, but the coordinator rejects it and remains quarantined. The encoder does not automatically insert key material; it is not a secret-exfiltration filter against deliberately malicious payload construction. Endpoints are one-use handoffs, but may emit the allowed role's sequential evidence until its phase deadline; signed future/unsupported records cannot alter the verifier's order. Ticket or evidence errors do not delete resources or packets, reset bootstrap, signal a process or issue new authority.

Success is ARTIFICIAL_EVIDENCE_CHAIN_ACCEPTED only after all six stages. It always reports operational_acceptance=false, scientific_acceptance=false, release=false, host_actions=0. Earlier accepted records report ARTIFICIAL_EVIDENCE_PREFIX_ACCEPTED and cannot imply whole-chain completion. Deployment metadata, handoff, attempts, application, independent application observation, exit and cleanup remain distinct. AC17–AC22 operational completion and all scientific gates remain unchanged.

## Acceptance and audit plan

Exercise real successor contract logic with the actual preserved Bootstrap and injected artificial API only. Test absent/admitted root, exact metadata mutations, role-only keys/no serialization, ticket substitution/expiry/replay, revoked/rolled-back clock, cross-run records despite reused fixture keys, wrong-role valid MAC, global dependency order, role sequence/genesis, signature failure, each witness callback/exception/nonboolean case, unknown attempt, exit-code/inventory uncertainty, final L separation and complete positive chain. Verify no new injected API calls after contract construction/handoff/acceptance. Preserve RED and all intermediate snapshots; run the full inherited117-test suite plus new cases in normal and optimized modes and the documentary17-test preflight in both modes.

One fresh read-only critic reviews sources and contract; owner reproduces accepted Important/Critical findings before correction, records all limitations and dispositions, and makes no claim of a second review. Final source-bound receipts, old tracked/private hashes, old pointers, service-source pins, exact reversible state addition, strict path allowlist, final seal and separate-process readback govern acceptance. Prose is not the authoritative test receipt. No commit or push is included; provide a full proposed title and description.

## Final review disposition and evidence interpretation

The fresh source critic identified one Important callback-boundary defect, one Minor endpoint/specification mismatch and a further Minor direct-intake size gap. Four public-interface callback reproductions failed before correction: final-witness revocation, cleanup expiry, a caught nested failure and successful same-record recursion. The owner correction adds a non-reentrant commit boundary and post-witness authority/time checks. The endpoint issue is resolved by explicitly distinguishing local construction errors from permanent coordinator intake failure, with a recovery/non-consumption characterization test. Direct intake now shares the8192-byte limit; this is not a memory-safety or denial-of-service guarantee because canonicalization itself allocates memory.

The reviewer inspected sources and audit logic only, did not run tests, and did not review the subsequent owner correction. Final full-suite snapshots bind exact Python sources; documentary preflight receipts record counts/results/mode and are protected by preservation/final fingerprints, but do not carry the same per-run source-hash binding. Declared zero-action counters and an AST forbidden-entry screen are bounded audit aids, not independent host telemetry or a sandbox proof. All declined runtime, secrecy, institutional, scientific and release judgments remain outside acceptance.

## Verified execution receipts and closure criterion

Fresh final_normal and final_optimized receipts each record148 tests,0 failures and0 errors, with distinct correct optimization flags and all16 current Stage-B source snapshots. The total is117 inherited tests plus31 new contract cases. Documentary preflight records17 passing tests in each mode. Initial missing-module RED24 failures, the first GREEN's2 fixture errors, corrected24-test run, pre-review141-test run and review RED31/4-failure run remain preserved alongside final results. The source critic reported0 Critical,1 Important and2 Minor findings; their dispositions are retained separately from owner execution evidence.

| Contract requirement | Source behavior exercised |
|---|---|
| D01 metadata only | Actual admitted root required; exact effect/scope/actor schema; constructor and full chain issue no added injected API calls; drift/quarantine rejection |
| D02 handoff | Own-role key provisioning without peer/OWNER key map; one-use/replay/substitution/role rejection; expiry equality, extension, boolean type and revocation |
| D03 record rules | Full cross-run scope despite reused fixture keys; expected role/credential, signature, per-role chain, dependency order, future tick, control/cleanup equality and8192-byte direct bound |
| D04 independent evidence | MAC-only observation rejection; distinct witness seats; callback exception/nonboolean rejection; exact O cleanup and L O-inclusive inventory; signed malformed/uncertain/missing/extra inventory rejection |
| D05 acceptance | Six-stage positive chain versus prefix status; UNKNOWN attempt cannot advance; endpoint-local recovery explicitly separated; four callback-time revocation/expiry/reentry regressions cannot commit |

The new packet is audit-local/intake/wp06-deployment-contract-831bf03. Preservation baseline:1202 tracked files,22805 prior-private files,2429 existing pointers and3 service-source pins. Five explicitly allowlisted governance files are additive/reversibly extended; all other tracked files, all fourteen previous Stage-B sources and every prior-private fingerprint must remain exact. Twelve new pointers yield2441 total. Final acceptance requires validation.json and the sibling verification/closure.json matching seal hash and separate-process readback; this report alone is not that receipt. No Git/cloud operation or live/scientific adoption is included.

## Next immediate bounded task

Consolidate the already-tested artificial contracts and receipts into the existing WP06 scientific/operational execution-gate crosswalk. Identify which author/institutional decisions and operational evidence remain necessary before any protected fit, without processing participant data, fitting, collecting host evidence or inventing another live capability. Do not use structural synthetic acceptance to resolve those gates automatically. No historical manuscript, qualitative input, scientific decision or sealed analytical result is changed here.
