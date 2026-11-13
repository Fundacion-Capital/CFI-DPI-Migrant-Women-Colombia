# WP07 — AQ07–AQ12 accepted

13 November 2026 · [Sealed request set](../wp07-aq07-aq12-local-audit/RUN_CONTRACT.json) · [Validation and evidence pins](VALIDATION.json) · [Next substantive package](NEXT_PACKAGE.md)

All six separately authorized Stata MCP selections passed in order
with the 60-second soft timeout, no retries, and no extra selection.
The response digest was computed independently before each write and
checked before any receipt was parsed. The local verifier read those
same bytes, wrote an exclusive decision and seal, and returned exit 0.
Before advancing, the controller independently checked the response
digest, decision hash, exact case, phase and return code. No rendered
audit-summary text was used to authorize advancement.

| Case | Expected rejection verified | Artifact disposition |
| --- | --- | --- |
| AQ07 | Occupied target, RC 459 | 39-byte artificial sentinel unchanged |
| AQ08 | Value mismatch on reopen, RC 9 | 423 × 322 artificial save/reopen verified; rejected file sealed |
| AQ09 | Ordinary-log count rejection, RC 459 | Own artificial log only; no command-log or save/reopen receipt |
| AQ10 | Schema mismatch, RC 111 | No file |
| AQ11 | Metadata mismatch on reopen, RC 459 | 423 × 322 artificial save/reopen verified; rejected file sealed |
| AQ12 | Preparation assertion, RC 459 | No file |

All six had the exact cleanup and empty-memory receipts. For the five
ordinary runtime receipts, the reported path matched the case-specific
route and was absent at metadata readback. No ordinary provider log was
opened or Temp searched; hidden capture is not ruled out. The manager
reported all six new sessions ready and not busy. One unrelated session
was absent from the closing inventory; none was acted on. Manager
status is not OS-exit evidence.

Postflight matched 47 new evidence files, 69 prior receipt files, 29
source pins, three installed provider source pins, three earlier staged
roots, all seven new staged sources and the earlier accepted artifacts.
No participant or model data were loaded, no fits ran, and the restricted
destination remained absent. Scientific source was unchanged.

The earlier text gate and AQ01–AQ03/AQ05 remain accepted. That makes
**10 of 12 qualification cases accepted, plus the separate text gate**.
AQ04 and AQ06 remain stopped and unaccepted: their saved transcripts
support the expected native outcomes, but the prior evidence gates were
not passed. No prior grant is revived. The restricted build, **E.5 and
Appendix C2 remain held**.
