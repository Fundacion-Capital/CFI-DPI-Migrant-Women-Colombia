# WP06 — artificial identity/bootstrap implementation

Owner-approved successor to [the preserved written contract](WP06_RUN_ACTOR_TARGET_BOOTSTRAP_CONTRACT.md), checkpoint `5e0d6b071cf224eb3184c1d056624ab8bdb309e3`. The contract's historical AWAITING_SPEC_REVIEW/NOT_IMPLEMENTED labels describe its creation stage; this report records the subsequent explicit approval and implementation without overwriting it.

## Implemented boundary

Three additive modules implement run/actor/target separation, split capture and quiescent resume, role-isolated authenticated bootstrap over the injected native I/O boundary, roster and worker-target admission, target-bound actor frames and controlled legacy-worker adoption. The eleven prior Stage-B Python sources and all earlier packets remain unchanged.

- [identity_contract.py](wp06-stage-b/identity_contract.py): exact records, pure canonical validation, domain-separated role authentication, shared local revocation, eighteen-field worker projection, own-key endpoints and directional target-frame encoding.
- [identity_bootstrap.py](wp06-stage-b/identity_bootstrap.py): actual split ABI capture/resume implementation using existing unbound structures/resource helpers; parent/topology/grant checks; kernel peer plus retained-identity verification; actual artificial pipe write/read completion intake; sealed roster/target; guarded legacy adoption and native target-frame readback.
- [test_identity_bootstrap.py](wp06-stage-b/test_identity_bootstrap.py): dynamic external fake API, T01–T24 contract/integration obligations and additional target-frame tests. The policy, identity, cryptography, ownership, supervisor, actor and fresh SQLite journal code are not replaced by a model.

Manifest intents contain no predicted PID or creation time. The four synthetic captured child PIDs in the fixed happy-path fixture are700/717/734/751; L is an externally anchored synthetic600. These are artificial API outputs, not host observations. The admitted worker binding correctly uses751; O, S and C retain their own process identities. Capturing and authenticating an actor is distinct from admitting W as a target.

## Integration and acceptance

The source test path performs L→O, O→S/C, S→W logical ownership, one creation allowance per child, suspended capture, creator registration, quiescent resume, peer-bound one-use challenge exchange and complete roster/target admission. A role endpoint receives its own signing key plus pinned verification callbacks, not unrelated signing keys. No key is written into grant/transcript/argv/environment/journal records.

Post-target native intake binds run, target, both captured actor digests, exact role/credential, clock/frequency and directional sequence/hash chain. A valid MAC for the wrong recipient cannot pass. Tested parent/child transport directions remain constrained to registered topology; arbitrary C→S routes are not silently invented.

The controlled legacy worker view is created by a real one-use successor capability from the validated capture registry, not by a test-side dictionary insertion. It exposes no launch/rebootstrap/owner-switch path. Separate synthetic target phase policies, observed prearm inputs and an actual fresh artificial Journal reservation are still required before the old Supervisor and actors compose one bounded stop. Delivery, worker application and retained-handle exit remain separate; the overall result stays HOLD without independent final evidence. Revoking the V2 authority reaches the legacy cached stop path.

Pre-review cumulative result:108/108 tests passed, consisting of81 preserved regressions and27 new identity/bootstrap tests. This is an intermediate count only: final normal/optimized source-bound receipts, fresh review disposition and seal/readback determine bounded acceptance. All failure snapshots and stores are retained in `audit-local/intake/wp06-identity-bootstrap-5e0d6b0`.

## T01–T24 coverage crosswalk

| Contract case | Executed source behavior / evidence |
|---|---|
| T01–T02 | Exact run/actor/manifest schemas, no predicted PID, canonical numeric/type/parent/generation restrictions |
| T03–T08 | Actual dynamic ABI capture, four distinct native identities, parent topology, duplicate identity rejection, fixed capabilities, consumed failure allowance, capture-before-resume and expiry |
| T09–T15 | Canonical bounded/malformed frames, locally pinned registration, kernel peer verification, one-use challenges, expiry/rollback/revocation and own-role endpoint keys |
| T16–T18 | Complete authenticated roster/external anchor, exact eighteen-field projection and conflicting/cross-roster target rejection |
| T19 | Controlled one-use adoption; arbitrary dictionaries and launch/rebootstrap refused |
| T20–T21 | Bootstrap is not prearm; separate real artificial journal/prearm compose one attempted stop and worker event transition without proving actual exit/cleanup |
| T22–T23 | Pending native I/O remains owned after failure; default and unknown-role execution refused |
| T24 | Shared authority invalidates the legacy cached action; whole-suite preservation, source pinning and separate seal/readback are additionally enforced by the packet audit, not inferred from that unit test |

The cases cover bounded source behavior, not every Windows error or every field mutation. Final review may identify additional gaps; its findings and the single owner correction pass must be preserved rather than replaced by a clean-looking report.

## What remains unadopted

### Final review corrections and bounded evidence

One fresh source critic found three Important issues and two Minor issues. All five were addressed in one owner correction pass after a preserved RED run (34 tests,3 failures,2 errors): shorter grant expiry now bounds registration/resume; direct legacy Supervisor actions check the adopted provider's pinned local revocation generation; legacy MACs include the enclosing V2 compatibility scope; pipe names use the fixed run digest; and failed-state completion may be drained only before the cleanup ceiling without delivery, admission or revival credit. The critic did not re-review those owner edits or execute tests.

The corrected successor has36 tests; the preserved inherited suite has81, making117 in each final normal/optimized run. Source-bound receipts, exact counts, failures/errors and final seal/readback are authoritative in the packet rather than inferred from this prose. The inherited documentary preflight has17 tests in each mode. All prior failed attempts and reviewed snapshots remain preserved.

Additional regressions explicitly cover a valid C MAC presented as W, IPC expiry equality without another read, partial writes, completion-close uncertainty and pending/success/cancelled failed-state drains. Overbroad frame-test names were narrowed. T01–T24 remain grouped bounded coverage, not exhaustive field/native-error certification. Duplicate native-handle aliasing under a malicious injected API remains unverified; the injected API is an expressly trusted fixture boundary. Full findings, owner dispositions and every declined review category are retained in the packet's review.json/review.md and progress ledger.

No DLL resolver, host probe, actual actor launch, native event/pipe traffic, process resumption/termination, service change, Stata or participant processing occurred. Ordinary interpreter/test/evidence operations are not actor launches. An injected ARTIFICIAL label is trusted fixture configuration, not a sandbox against arbitrary malicious Python functions.

Serial artificial coordination establishes logical topology and protocol behavior only, not independent OS processes, scheduling, concurrency, real parent process inheritance, real ACL isolation, production credential transport, institutional authority, measured timing, actual image measurement, protected-store durability or O/L cleanup certification. Declared image pins remain distinct from measured loaded modules.

The earlier four-role/full-target-binding incompatibility is resolved in this additive artificial source path, not by changing the old launcher. Native operational adoption is still unavailable. Replacement generations, AC19 numeric reuse and AC21 real grants/termination remain unimplemented or conditional as explicitly scoped in the approved contract. No real AC17–AC22 case is executed or passed; operational, scientific, publication and release acceptance remain false.

## Next boundary

After final bounded source acceptance, the next safe combined work is an artificial-only deployment-interface/credential-handoff and independent-evidence acceptance contract. Any host compatibility probe, executable role deployment, live bootstrap/control, service action or statistical replay requires separately defined authority and evidence. Do not treat this packet as such authorization.
