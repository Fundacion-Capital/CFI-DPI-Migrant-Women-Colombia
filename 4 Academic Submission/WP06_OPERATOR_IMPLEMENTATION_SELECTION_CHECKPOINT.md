# WP06 — O01–O07 operator implementation-selection checkpoint

18 October 2026 · Baseline `5605021082b8e00afbddf6b31f9b9c7bf52b534a` · **Recommendations complete; actual adoption pending.**

This checkpoint supplies concrete, evidence-backed recommendations for the seven open choices in the [operational integration contract](WP06_OPERATIONAL_INTEGRATION_CONTRACT.md). It does not edit that preserved contract, fill its open choices, approve a service change or authorize a probe. All real response fields remain blank in [the checkpoint record](wp06-operator-checkpoint/checkpoint.json). The 24 existing project responses and 28 planned acceptance cases remain unchanged.

## 1. Recommendation profile

| Choice | Preferred design recommendation | Not established by this checkpoint |
|---|---|---|
| O01 journal | Local SQLite, rollback DELETE + synchronous EXTRA, single writer and transactional unique reservation/command claims | Installed version, filesystem power-loss durability, implemented crash recovery |
| O02 control/authentication | Local explicitly restricted Windows pipe, bounded overlapped I/O, peer identity checks, role/per-scope HMAC-SHA256 + RFC8785 canonical messages, protected local keys | Effective ACLs, principal separation, protocol implementation, credentials or host security |
| O03 supervision | Dedicated out-of-process supervisor outside MCP/worker/client lifetime; cooperative-only initial profile, fallback/automatic kill disabled | Survival/independence on this host or reliable native interruption |
| O04 registration/build | Fresh owned registrar/worker, versioned isolated sidecar, pinned build and minimal-rights process handles | Loaded-bytecode attestation, current process ownership or deployed integration |
| O05 clocks/budgets | Integer monotonic nanoseconds bound to host/boot/domain; absolute ceilings; no real budget defaults | A defensible production timeout, transport-delay bound or real-time guarantee |
| O06 adoption roles | Scope-specific owner/operator decisions plus independent acceptance and institutional disclosure review | Named verified principals, signed decisions or permission inheritance |
| O07 evidence/storage | Non-synced restricted active store outside Git; coherent sealed exports to an approved restricted archive; public allowlist only | Approved real paths, current ACLs, legal retention term or portable key escrow |

These are **design judgments informed by official documentation and project evidence**. The 16 primary documentation sources are enumerated with verified claims and URLs in [the source register](wp06-operator-checkpoint/sources.json). None was used to infer that an API, privilege, runtime version, security setting or timing property has been validated on this machine. No database, pipe, key, process, job, access rule or external folder was created.

## 2. O01 — Durable reservation journal

**Recommendation:** SQLite on an approved local, non-synced disk, one journal writer, `journal_mode=DELETE`, `synchronous=EXTRA`, explicit `BEGIN IMMEDIATE`, unique reservation and command keys, and fail-fast contention rather than automatic redispatch. These are proposed future settings, not commands applied here.

**Verified basis:** SQLite describes rollback atomicity and its storage/flush assumptions. Its synchronous documentation recommends EXTRA for rollback-mode durability; immediate transactions can fail when a writer is active. These support the proposed mechanism, not a guarantee for this hardware. [Atomic commit](https://www.sqlite.org/atomiccommit.html), [synchronous settings](https://www.sqlite.org/pragma.html#pragma_synchronous), [transactions](https://www.sqlite.org/lang_transaction.html).

**Judgment/tradeoff:** The small single-host control journal does not currently justify WAL complexity or a remote database. WAL remains an alternative if measured concurrency requires it; its current official advisory identifies a reset race fixed in 3.51.3 and specified backports. No installed SQLite version was queried. [WAL documentation/advisory](https://www.sqlite.org/wal.html).

Reserve and durably commit before dispatch; uncertain commit or lost response consumes/quarantines the attempt. A process-crash test cannot prove actual power-loss behavior. Recommend coherent SQLite-managed snapshots, never casual copying of a live database. Restoring an older ledger must not reopen consumed commands: reconcile against separately sealed high-watermark evidence, or keep dispatch blocked. That anti-rollback rule is an application requirement, not a property the backup API provides. [SQLite backup API](https://www.sqlite.org/backup.html).

**Operator must supply:** exact runtime/build, storage location and filesystem assumptions, failure/backup/recovery design and evidence. Acceptance: AC03–05/AC14, with C03/C09/C10.

## 3. O02 — Control channel, authentication and proof

**Recommendation:** a local Windows named pipe with explicit narrow principal/logon permissions, remote clients rejected, bounded overlapped I/O and peer-process/creation/registration checks. Do not reuse default pipe permissions or treat `PIPE_NOWAIT` as the asynchronous design. Microsoft documents the default-access hazard and distinguishes the I/O modes. [Pipe security](https://learn.microsoft.com/en-us/windows/win32/ipc/named-pipe-security-and-access-rights), [CreateNamedPipe](https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-createnamedpipea).

Use peer process IDs as inputs to fresh ownership checks, not as ownership proofs themselves. [Client PID API](https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-getnamedpipeclientprocessid), [server PID API](https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-getnamedpipeserverprocessid).

**Recommended bounded authentication profile:** role-separated, per-scope HMAC-SHA256 keys over strictly validated RFC8785 canonical envelopes, explicit credential IDs/revocation and replay/sequence/lease fences. Validate fixed tag type/length and use the documented comparison primitive. Use tested canonicalization/test vectors, not an approximate serializer. Encode nanosecond integers as canonical decimal strings on the wire where needed to avoid numeric precision loss. RFC8785 is an **Informational specification**, not proof of a secure complete protocol. [Python HMAC](https://docs.python.org/3.11/library/hmac.html), [RFC8785](https://www.rfc-editor.org/info/rfc8785/).

**Threat boundary:** HMAC holders/verifiers can forge messages for keys they hold; it is not asymmetric attribution/non-repudiation. This local profile is acceptable only if the operator accepts that trust domain and verifies issuer-role/peer binding. If an independent assessor must establish issuer attribution against an untrusted verifier, select asymmetric receipt signatures instead. A compromised same-principal process or local administrator is not defeated by a pipe name or MAC alone. No cryptographic keys or protocol are implemented here.

Recommend user/service-scoped DPAPI for local secret protection only after the actual identities are selected. It normally ties decryption to credentials/computer; it is not portable institutional archive encryption or a recovery/escrow plan. [DPAPI documentation](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/nf-dpapi-cryptprotectdata).

**Operator must supply:** principals, trust model, tested canonicalization/proof dependency, framing limits, key lifecycle and recovery policy. Acceptance: AC01–02/AC06–08/AC12/AC20/AC24; C02/C04/C05/C08. Mutual TLS is the alternative for an explicitly adopted remote design; no remote listener is recommended now.

## 4. O03 — Independent supervisor and fallback

**Recommendation:** an owned dedicated supervisor process, armed before dispatch and outside the engine, MCP request loop and client lifetime. Do not install a Windows service in the initial artificial-development step. Begin **cooperative-only**: no termination right, automatic kill-on-close, job-tree kill or self-restart is enabled by this recommendation.

Microsoft distinguishes observation/synchronization rights from termination rights. Jobs can affect process groups and interact with inherited/nested jobs; neither fact proves safe containment on this host. [Process access rights](https://learn.microsoft.com/en-us/windows/win32/procthread/process-security-and-access-rights), [Job Objects](https://learn.microsoft.com/en-us/windows/win32/procthread/job-objects).

**Limits:** a separate process is not evidence of operational independence. Its parent/job/account/channel lifecycle must be tested. If the sole supervisor dies, cooperative-only control may leave work running; that remains a known unresolved failure mode, not fit readiness. Consider a managed service or owned Job Object fallback only under a new explicit installation/termination scope and successful acceptance. No such process, handle, job or membership inspection occurred here.

**Operator must supply:** launch/lifetime ownership, failure detection, independent observation and exact fallback policy. Acceptance: AC17–19/AC21–22; C07/C09/C11.

## 5. O04 — Trusted registrar and build adoption

**Recommendation:** prepare versioned isolated sidecar sources and a sealed dependency/build manifest; do not patch the installed extension in place. A future approved registrar must bind a **fresh, owned** worker to PID, creation time, boot, generation and command, retaining only necessary observation/synchronization rights. Existing default sessions and historical receipts are not a new registration.

Windows exposes process timing through a handle with required query rights; those observations must be combined with the complete contract binding. [GetProcessTimes](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-getprocesstimes), [process rights](https://learn.microsoft.com/en-us/windows/win32/procthread/process-security-and-access-rights).

**Judgment/limits:** pin source, dependency and engine-file digests, then distinguish those disk/build facts from fresh loaded-module observations and any unavailable resident-code attestation. Do not relabel a disk hash as loaded bytecode proof. The current service integration surface and chosen runtime/API availability remain unassessed. A vendor-supported bound-control feature is preferable if it later satisfies the same contract; attaching an existing worker is rejected unless ownership can be independently proved.

**Operator must supply:** approved build manifest, registrar/worker identity provenance, exact change surface and adoption/rollback procedure that retains the consumed ledger. Acceptance: AC01–02/AC19/AC23/AC26; C02/C05/C12.

## 6. O05 — Clock and numeric budget selection

**Recommendation:** integer `monotonic_ns`, explicit host/boot/clock-domain identity, UTC for audit only, one absolute execution ceiling and cleanup bounded by the earlier total ceiling or stop+allowance. Python documents integer nanoseconds and the distinction from wall time; scheduled waits can overshoot. That is not a hard real-time guarantee. [Python time documentation](https://docs.python.org/3.11/library/time.html#time.monotonic).

**Evidence limit:** no documentation can justify a safe production number of seconds for this host/engine. Therefore real execution and cleanup budgets remain **null**, not 0, an inherited historical timeout or an invented default. Symbolic 100/110/113 fixtures are not calibration. No timing/sleep/engine probe occurred.

**Operator must supply:** separately authorized calibration scope, measured delay/cleanup envelope, approved ceilings and a shared-domain or conservative translation proof. Unknown or incomparable timing blocks dispatch. A validated Windows counter profile is an alternative; cross-host translation requires independently demonstrated bounds. Acceptance: AC09–11/AC13/AC25; C06/C07/C09.

## 7. O06 — Actual decision and acceptance roles

**Recommendation:** distinguish project-owner development scope, runtime-operator build/target/budget adoption, independent acceptance assessment and institutional evidence/privacy stewardship. These are proposed roles, not verified people. Observation privileges do not imply termination privileges. [Process rights](https://learn.microsoft.com/en-us/windows/win32/procthread/process-security-and-access-rights); [existing project authority contract](WP06_OPERATIONAL_INTEGRATION_CONTRACT.md).

Every future response must identify decision-maker/role, date, exact selection/scope, rationale and verifiable evidence. Stage-A artificial work, disposable processes, empty engine, service/config changes and exact owned termination need distinct grants. Research fit/data/release remain separate even after operational acceptance. Equivalent institutional role titles are acceptable; combining roles requires an explicit conflict assessment and independent acceptance rather than silently self-approving.

**Operator/owner must supply:** named principals and responses. The JSON record is deliberately pending/blank, not a human-approval parser. Acceptance: AC16/AC21–23/AC28; C01/C11/C12.

## 8. O07 — Active state, restricted evidence and retention

**Recommendation:** active journal and secrets on approved restricted local storage **outside Git, OneDrive, Dropbox and network/synchronization folders**. Use coherent sealed exports for restricted archives; public artifacts get an explicit metadata allowlist and opaque references only. This is a design separation, not a claim that an existing folder currently meets access controls. [SQLite atomic/storage assumptions](https://www.sqlite.org/atomiccommit.html), [backup mechanism](https://www.sqlite.org/backup.html).

An institution-managed restricted archive is preferred. The previously restricted project Dropbox archive is only a candidate destination after renewed steward/path/access approval, and never an active SQLite working store. User-scoped DPAPI is not a cross-machine institutional backup-key solution. [DPAPI limits](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/nf-dpapi-cryptprotectdata).

**Unknowns remain null:** actual paths and retention years. No legal retention interval is asserted. Preserve every existing packet; no deletion or retention change is authorized. The institution must set access, encryption/recovery, disclosure and retention policy. No ACL, folder, backup, Dropbox sharing or retention configuration was inspected or changed here. Acceptance: AC14–15/AC22/AC27; C03/C10/C11.

## 9. How the checkpoint can be adopted later

For each O01–O07, the actual responsible decision-maker may accept the recommended profile, select the recorded alternative, request evidence or defer. A response needs the exact scope, identity/role, date, rationale and evidence. The current checker intentionally rejects populated approval fields: it validates this **pending recommendation packet**, not future human decisions. A later response must be a new, separately preserved intake with its own authority verification; do not overwrite this packet or the original contract to make it appear previously adopted.

Recommended next scope, if explicitly authorized, is an **isolated Stage-A implementation plan** using the selected profiles, with artificial-only data/credentials and no installed-service integration. Budget/path/retention facts needed for real stages still require actual evidence. No acceptance case, live control or fit is activated by endorsing a recommendation for development.

## 10. Verification and evidence limitations

The source register records brief paraphrases, not copied manuals; failed preliminary Microsoft URL guesses were resolved to official documented locations and were not treated as evidence. The [checkpoint checker](wp06-operator-checkpoint/check_checkpoint.py) validates typed pending decisions, zero authority, null unknowns, official-source reference structure and complete requirement/case coverage. It does not establish the truth of arbitrary source prose, refresh a web page, authenticate a real decision or test any recommended technology.

The successor packet is `audit-local/intake/wp06-operator-checkpoint-5605021`, with review, named tests, entry fingerprints, final seal and separate sibling readback. Prior contracts, adapters, all 28 NOT_EXECUTED cases, seven open parent choices and 24 pending real project responses remain immutable. Nothing in this package changes methodology, models, results, qualitative material, manuscripts, services or participant files.
