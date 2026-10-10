# I3 preservation recovery and authorized single-file restoration

10 October 2026. Entry: clean owner-created main `9333e2d3d3d8414b3a678b09db3e689513a8e266`, directly over `ed098223`. **The owner-authorized single-file restoration is verified; both observed and recovered versions are retained. M6.03.13 / M6.05.13 remains open pending owner-checkpoint adoption and final I3 closure. No I3 fit is authorized.**

## 1. What was recovered

The affected prior-I2 file is `audit-local/intake/interaction-i2-replay-0df85ab/native_model_acceptance.dta`. Its exclusive seal pins 1,835 bytes and SHA-256 `0DB38CAAEED97A4E225E11ADAC19BE73E20132A32D720B1B805C00CFB618C42A`. That exact sealed version is now restored. The later observed 1,913-byte version, SHA-256 `96B5A1C6B7D8E23099CA0DD78C12136E0927B1A2A25C629E01AC562BDC51E11C`, remains retained in two separate private copies.

A separately preserved reconstruction matches the original sealed size and SHA-256 exactly. It is not a newly found historical backup and is not a recomputed analytical result: it is a forensic, byte-exact recovered copy. That candidate and both retained observed copies remain intact after restoration. Nothing in the previous seal, source code, constructs, estimates or tables was repinned or changed.

Stata MCP confirms that the observed diagnostic contains two fields (`metric`, `value`) and one audit row, `I2_LOGIT_EARLY_LATE_ALL_FIELDS_STRIPES_EXACT = 1`. The recovered sealed diagnostic has the same two fields and zero rows. The separately accepted `native_model_acceptance04.dta` and all other 184 files in the earlier I2 seal are unchanged. This recovery concerns an intermediate audit diagnostic, not participant data or the accepted analytical results.

## 2. Evidence and limits

The initial append-only hypothesis failed: simply taking the first 1,835 bytes does not match the seal. Fresh empty-file prototypes with their timestamp replaced also failed to match; these unsuccessful hypotheses are not claimed as recovery.

An explicitly synthetic Stata MCP probe reproduced a posting buffer that remains zero rows / 1,835 bytes after one row is posted, then becomes one row / 1,913 bytes on `postclose`. The paired files show six changed header bytes and a 78-byte observation payload. Applying only this empirically measured inverse transition to a new in-memory copy of the observed diagnostic, while retaining every other original byte, yielded the exact old sealed hash. The verified candidate was then written exclusively to a new private file and read back. Stata confirms its zero-row/two-field readability.

The retained failed `postfit_validation03.do` creates that diagnostic with `postfile`, posts an early-state audit row and has later `postclose` code. Its failure receipt records r(9); the earlier final-cleanup source does not check or clear posting handles. This is source-compatible with the measured deferred-flush mechanism. It does **not** establish the exact historical handle lifetime, worker-shutdown event or responsible actor. The mechanism is demonstrated; exact historical event attribution remains unavailable.

Stata's official [postfile documentation](https://www.stata.com/manuals/ppostfile.pdf) explains that results can remain buffered and an incomplete file need not be fully current before `postclose`. Future owned-worker closure must explicitly close/check posting handles before freezing fingerprints. This is an audit-execution safeguard, not a change to the research specification.

All content-level checks and synthetic dataset creation used Stata MCP. The byte recovery is a tightly bounded file-preservation operation, not a general dataset editor. It rejects changed inputs, unexpected sizes or header transitions, a nonmatching recovered hash and an existing output destination. Seven real-input/mutation/collision checks pass. The recovery worker was explicitly closed after confirming empty data/results and no open posting handle; unrelated sessions and complete runtime equivalence are not certified.

The inherited suite was run both before and after restoration, executing all 64 command groups and 252 unit tests in each run. All unit tests and 63 groups pass; `current cumulative acceptance` fails at its dated HEAD assertion (`ed098223` versus the owner-created `9333e2d` checkpoint). Both sets of actual receipts are retained; this failure is not waived or described as an all-green closure suite. The initial recovery proof remains preserved as dated, proposal-only evidence. The separate post-restoration proof now authenticates the owner checkpoint and verifies all 185 actual prior-I2 fingerprints and all 5,898 actual cumulative fingerprints, not a prospective substitution. Adopting the owner checkpoint and completing final I3 closure remain separate future work.

Local filename searches in the restricted OneDrive and Dropbox project trees found no alternate `native_model_acceptance*` files. A remote-cloud backup/history search was unnecessary once the exact sealed bytes were recovered; no cloud changes were made.

## 3. Exact authorized restoration and verification

Private candidate: `audit-local/intake/interaction-i3-preservation-recovery-9333e2d/recovered_sealed_native_model_acceptance.dta`.

Restored target, **one file only**: `audit-local/intake/interaction-i2-replay-0df85ab/native_model_acceptance.dta`.

The actual human approval and full delivered independent review are preserved in the new private packet. The reviewer found no Critical or Important blocking issue in the recovery/proposal scope and independently reconstructed the exact sealed bytes. After fresh authentication of the candidate, observed target, earlier forensic copy and unchanged original seal, a private NTFS replacement/backup probe passed. The authorized replacement then restored only the specified target at 13:12:24 UTC on 10 October 2026, retaining the observed bytes in `observed_before_restoration.dta`; the earlier forensic copy and recovered candidate remain intact. The proposal-only report and proof remain preserved separately.

Post-restoration checks verify the exact 185-file prior-I2 set and all its byte fingerprints, all 5,898 cumulative prior-private fingerprints, all 768 original-source checks, 73 entry snapshots and 14 immutable I3 code pins. The original I2 seal is unchanged. No final I3 seal exists. The replacement and its byte proof were not part of the earlier independent proposal review; successful execution and separate full readback are recorded, but interruption/crash behavior is not certified.

Private evidence: `audit-local/intake/interaction-i3-preservation-recovery-9333e2d/restoration_verification.json`, `authorized_restoration_tool_receipt.json`, `review_full_text.md`, `REVIEW_RULINGS.md` and the original human approval record. These are local restricted evidence, not public participant-data releases.

## 4. Current status and next task

**Owner approval received and the exact single-file restoration verified.** The authorization does not extend to a research fit, result correction, archive deletion, changing the old seal, Git staging/commit/push, cloud change, Overleaf synchronization, release or submission.

Granular status:

1. M6.05.13.f.R1 — authenticate the owner-created held checkpoint and the mismatch: verified.
2. M6.05.13.f.R2 — test hypotheses and reproduce the deferred-posting transition with synthetic Stata evidence: verified, with historical attribution held.
3. M6.05.13.f.R3 — recover exact sealed bytes in a new private candidate; verify readability and seven rejection/collision cases: verified.
4. M6.05.13.f.R4 — independently review the proposal and perform final read-only preservation verification: accepted within the proposal scope; full review and all ten declined-judgment rulings retained.
5. M6.05.13.f.R5 — obtain owner approval and restore the single diagnostic with full preservation proof: **completed and verified; exactly one archive file restored, original seal unchanged**.
6. M6.05.13.f.R6 — authenticate adoption of the owner-created held checkpoint, then rerun and validate final I3 preflight closure: **next immediate task, without fitting**. Preserve dated failure receipts and tests; do not weaken their historical assertions or manufacture a new baseline. Fresh current acceptance, source/compiler/review bindings, exclusive sealing and separate exact-set/hash readback remain required.
7. M6.04.13 / M6.08.14 — bounded I3 historical fit/display comparison: **not cleared; requires separate future fit authority**.
