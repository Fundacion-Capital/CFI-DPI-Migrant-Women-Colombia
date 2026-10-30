# Targeted remediation proposal — unapplied, no execution authority

This is a bounded source-change proposal, not an implemented patch. Keep the sealed provider, failed trial, grants and all prior packets immutable. If authorized, create one additive **disabled** successor from the exact sealed source. Do not add a new service, dependency, generalized adapter, fallback launcher, retry or replacement mechanism.

## A. One cleanup effect, one durable terminal result

Touch the existing `OwnedBoundary.__init__/close`, `build_server` closure and their actual callers/tests, not the empirical code. The manager owns the terminal cleanup result, including failures. Every path—bootstrap error, invalid request, normal completion, deadline supervisor and server finally—must obtain the same recorded outcome. A later read may retrieve the outcome; it must not execute cleanup again. The first failure must not be erased by a later finalizer exception or a `None` result.

Do not merely catch/ignore the consumed-reservation exception or skip cleanup when `_close_started` is true. That flag alone says nothing about completion. Distinguish no cleanup started, cleanup in progress, terminal recorded result, and interrupted/failed closure. Serialize state transitions with the existing lock. An in-progress or missing outcome must remain a failure/incomplete state, never an accepted closed state. Cache an immutable copy only after terminal evidence is assembled; prevent callers from modifying the saved result through a returned dictionary. No caller may replay native effects or consume a new allocation.

## B. Retain failure-path containment evidence before discarding capabilities

Review `NativeOwner.initialize/_rollback/observe_exit`, manager cleanup and the wrapper together. `_rollback()` currently closes retained handles before later manager observation; a successful-artificial-kernel observation after that does not establish a valid native-handle observation. A future failure-path result must record the exact retained identities, exit observations and owned-job inventory **before** closing the capabilities used to observe them, then separately record attempted handle closure and failures.

Keep failed execution separate from containment/closure: watchdog exit code 1 can be consistent with an observed failed child, but must never make the empty recipe accepted. A missing/mismatched exit witness, nonzero active inventory, capability-close error, interrupted observation or unobserved process remains explicit. Do not interrogate a PID afresh, infer zero descendants from a parent exit, query a closed handle, or retrospectively fabricate a witness for the preserved trial. Restrict any new records to the future exact private run and make them create-only.

## C. Instrument the first bootstrap rejection without weakening it

Touch `runtime_roles.main` and, only where needed, its existing producer/pipe boundary. Preserve exact schema, role, digest, frequency, creation-identity and original 60-second monotonic deadline checks. No extra grace, origin reset, fallback acceptance or coercion is proposed. Existing 10-second tool arguments and all cumulative design ceilings remain unchanged.

On a future run, retain a small create-only private diagnostic for the **first actually evaluated failing predicate**, with the validated binding/run reference, source identity, role, reason, original origin/frequency/deadline and sampled tick where that predicate was evaluated. Preserve short-circuit behavior: operands not reached are `NOT_EVALUATED`, not recomputed afterward. Keep scope/identity operands private and distinguish reported values from trusted observations. Do not log raw bootstrap keys, role credentials, full payloads, participant information or untrusted-path names. A malformed packet must not choose a file path. An instrumentation write failure must itself remain explicit and cannot produce acceptance. No record from this step may be grafted onto the old failed root.

The current evidence does not justify a primary bootstrap repair. Instrumentation is the minimum proposed way to make a later separately authorized rejection diagnosable. Reassess startup/runtime-inventory cost offline; measurements do not authorize extending or restarting the original deadline.

## Required artificial acceptance cases for that successor

| Case | Required observable result |
| --- | --- |
| AC-D01 normal two-selection path | Exact inherited literal order; one worker; cached final outcome; no second cleanup effects |
| AC-D02 bootstrap rejection and server finally | Original bootstrap error preserved; one terminal manager outcome shared with wrapper; no consumed-reservation masking or `None` |
| AC-D03 preallocation expiry | No worker allocated; explicit failed outcome available to finally; no new origin or grant |
| AC-D04 in-flight allocation/cleanup race | No premature closed/success claim; returned late capabilities are contained once; no replacement |
| AC-D05 supervisor/finalizer contention | One effect owner; other caller sees pending or recorded outcome without repeating effects; no deadlock |
| AC-D06 partial rollback and failed handle observation | Exit/inventory evidence precedes capability disposal; observation/close failures remain separate and unsuccessful |
| AC-D07 cleanup exception or interrupted result | No cached success, empty-result acceptance or suppressed primary failure; no automatic second effect |
| AC-D08 result immutability | Changing a returned dictionary cannot alter the terminal stored outcome |
| AC-D09 every guard mismatch and deadline edge | Same accept/reject boundary; exact deadline rejects; first failing predicate only; unevaluated fields remain marked |
| AC-D10 instrumentation failure/foreign payload | No secret spill, path injection, overwriting or fallback acceptance; bounded diagnostic size and explicit write failure |
| AC-D11 large integer and source/role tamper | Exact creation-identity preservation through pipe/JSON; altered source/binding/role rejected before engine |
| AC-D12 full regression and preservation | All existing and new tests pass normally/optimized; disabled metadata and all old packets unchanged; independent review, seal/readback |

These are **future repair acceptance requirements**, not tests claimed passed by the present diagnostic packet. Its fourteen tests establish the current characterization and guard/producer compatibility only.

## Authorization boundary

The recommended next authorization is source-only: implement A–C in an additive disabled successor, using artificial fixtures only, and audit it. It need not authorize native activation, host probes/control, participant inspection, fitting, global settings changes, service changes, Git commits/pushes or publication. Any later live trial requires its own exact contract and authority after that successor is reviewed.
