# WP07 — AQ06 summary audit and AQ07–AQ12 review

13 November 2026 · **Offline only. No staging, provider calls or Stata runs.**
[Prior execution](../wp07-aq05-aq12-digest-execution/VALIDATION.json) ·
[Exact six-case contract](RUN_CONTRACT.json) · [Local verifier](local-audit.mjs) ·
[Offline tests](local-audit.test.mjs)

## What the saved records establish

| Case | Verified in this audit | Disposition |
| --- | --- | --- |
| AQ04 | Sealed saved file: 2,650 bytes, 96 lines. The expected `prep` RC 9, cleanup 0, empty state and no file were found. No independent pre-write fingerprint or original comparison operands survived. | Original response-equality stop stands. Not accepted and not rebound. |
| AQ05 | Independently matched the pre-write digest for all 2,663 bytes. Expected `prep` RC 9, ordered receipts, clean empty exit and no file. | Accepted previously; preserved, not rerun. |
| AQ06 | Independently matched the pre-write digest for all 2,664 bytes. Expected `prep` RC 7, ordered receipts at lines 51/52/53/82/96, clean empty exit and no file. | Original summary-parse stop stands. Not accepted for advancement and not rebound. |

AQ06 stopped at the orchestration JSON parse of the **audit summary**.
The saved error identifies the beginning of the rejected input as
`Warning: a…`; it does not preserve the full string or identify the
warning source. A fresh offline read of the exact saved response
reconfirmed the digest before reading its receipts. This rules out a
mismatch between that saved file and its preserved pre-write seal; it
does not reconstruct the malformed summary or prove what emitted the
warning. AQ04 had a different failure and lacks that independent seal.
The gate and AQ01–AQ03 remain accepted. Both older grants are closed.

## Local decision gate

For a separately authorized selection, keep the entire returned envelope,
its independent pre-write byte count and SHA-256, and the raw evidence
on new paths. The CLI compares the independently supplied pin with the
saved pre-write record, hashes the response, and parses the **same verified
bytes**. It checks actual ordered native receipts (not echoes), allowed
log routes, exact return/cleanup state, and the case file inventory.
It writes a new decision record and separate seal with no overwrite,
reads both back, and returns an exit code. A future controller must
verify exit zero **and** the sealed local decision, case identity, accepted
flag and exact response fingerprint before advancing. It must preserve the
full raw CLI tool return (including any warning or error), but must not
parse that display text to decide acceptance. Missing evidence or any
ambiguity stops the sequence. A matching hash is not proof of complete
provider output or research clearance.

Five offline tests passed across the local-audit and original digest
suites. They cover invalid display JSON with intact local evidence,
changed bytes, digest mismatch before receipts, wrong/duplicate/reordered
or echoed receipts, wrong log routing, AQ09's distinct ordinary-log
branches, missing or wrong save/reopen receipts, and no overwrite. The
actual CLI was exercised on an artificial response; AQ04/AQ05/AQ06
were inspected read-only without accepting or changing any disposition.
No participant file, Stata dataset or model was opened.

## Six exact requests, review only

Only **AQ07–AQ12** are bound, in order, in fresh named sessions with
a 60-second soft timeout each and no retries. The operational caller
changes only the synthetic root and session prefix; the six reused
payloads and original case oracles are unchanged. Keep the AQ07 sentinel
byte-identical. AQ09 still needs the distinct ordinary-log rejection,
clean exit and owned artificial log; a generic `r(459)` is not enough.
AQ08/AQ11 are the only two possible artificial saves and reopens.
Before staging, obtain fresh exact authority and recheck live name
vacancy/capacity, all seals, exact unused paths and the scope of the
synthetic-only route. Even successful execution would leave AQ04 and
AQ06 requiring separate disposition before full qualification.
Contract SHA-256: `75f600b97544f59bebd26be75d44ff451ba853e6d549ee31fbae2ccdaab76a34`.

## Policy and welfare handoff

Connect policy implications to the existing
[joint evidence map](../wp07-e5-v3-logging-native-validation/MIXED_EVIDENCE.md)
once the specific study exhibits are accepted. Use remittance
disposition and domestic digital participation separately. Other
measured outcomes can qualify their interpretation: fee visibility
and cash-out conditions can inform a cost and access discussion;
reported adverse experiences, perceived safety and complaint resolution
can inform a protection and recourse discussion; reported decision
arrangements and assistance can inform the discussion of agency.
Respect each question's route and denominator. These are reported
conditions and associations, not estimates of time or money saved,
verified fraud, empowerment, or household welfare gains. If a plausible
welfare pathway is not measured or identified, label it as such and
state what evidence would test it. No outcome, manuscript result or
policy recommendation was added or changed in this offline package.

**Next:** Review and separately authorize only the six bound cases.
Full qualification, the restricted dataset build, **E.5 and Appendix C2 remain held**.
