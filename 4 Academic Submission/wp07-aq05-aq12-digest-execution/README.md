# WP07 — AQ05 accepted; AQ06 stopped at audit-summary parsing

13 November 2026 · [Sealed request set](../wp07-aq05-aq12-digest-successor/RUN_CONTRACT.json) ·
[Validation and evidence pins](VALIDATION.json)

**Two of eight authorized selections dispatched. One accepted. No retries.**

| Case | Disposition | Evidence |
| --- | --- | --- |
| AQ05 | Accepted expected rejection | The separately recorded pre-write fingerprint matched the saved response before receipt parsing. The verified response reports `prep`, RC 9, cleanup 0, and empty memory. No case artifact. |
| AQ06 | Dispatched once; not accepted for advancement | The orchestration step could not parse the returned audit-summary text as JSON. After stopping, independent local verification matched the complete response to its pre-write fingerprint. The saved receipts show the expected `prep`, RC 7, cleanup 0, empty memory, and no case artifact. |
| AQ07–AQ12 | Undispatched | Only the unchanged, pre-staged AQ07 sentinel occupies a leaf. AQ09 was not tested. |

The AQ06 stop records the beginning of the invalid JSON input
(`Unexpected token 'W', "Warning: a"...`), not its complete original
text. The source and exact content of the warning are not established.
The evidence distinguishes this summary-transport failure from AQ04's
earlier equality stop and from a native Stata or response-byte mismatch.
The offline check did not retroactively accept AQ06 or permit continuing
under this grant. No further selection was sent.

The postflight rechecked both complete response digests (2,663 bytes for
AQ05; 2,664 for AQ06), all 55 earlier receipts, 24 source pins, seven
new staged copies and the sentinel. The prior accepted text gate and
AQ01–AQ03 remain accepted; AQ04 remains stopped and unaccepted. Fourteen
new evidence files are fingerprinted. The two new sessions were reported
ready and not busy; no other session was acted on. This is not an
OS process-exit attestation. No new case file, participant/model load,
fit, synthetic save or reopen occurred.

**Next:** Audit the AQ06 summary boundary offline. Preserve the entire
raw summary envelope if it fails, and prefer a locally sealed audit
record with a strict, short status return. Do not weaken the response
digest check or rerun these cases under this grant. Resolve AQ04 and
AQ06 dispositions explicitly, then bind the six undispatched cases
for review. Restricted build, **E.5 and Appendix C2 stay held**.
