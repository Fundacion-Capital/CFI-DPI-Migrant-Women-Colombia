# WP07 — synthetic preparation qualification complete

13 November 2026 · [Sealed request set](../wp07-aq04-aq06-stage-successor/RUN_CONTRACT.json) · [Execution audit and evidence pins](VALIDATION.json)

The two authorized Stata MCP selections ran in order, once each, with
60-second soft timeouts. AQ06 was dispatched only after AQ04's
acceptance and response digest were verified. Both expected rejection
cases passed their test contract:

| Case | Expected preparation result | End state |
| --- | --- | --- |
| AQ04 | Native return code 9 | Cleanup 0, N=0, K=0, no output file |
| AQ06 | Native return code 7 | Cleanup 0, N=0, K=0, no output file |

Before each dispatch, the bound filename comparison checked the exact
root entries and both empty case directories, alongside the five source
hashes and live session availability. The complete delivered response
was fingerprinted before writing and read back before receipt parsing.
The local verifier produced an exclusive decision and seal; both were
checked independently. The rendered shell output was not used to
decide acceptance. Neither case saved or reopened a dataset.

Postflight verified all 21 new evidence files, 41 source pins, 122
prior evidence files, 33 earlier staged source files and five new staged
source files. Both case directories remained empty. Both runtime
receipts named one ordinary log on the expected synthetic route; neither
log was present at metadata readback. No log contents were opened, and
this does not establish private capture or temporary-file custody. Both
new sessions were reported ready and idle by the manager; no session was
destroyed or restarted. The previous stops remain preserved.

**All 12 artificial cases and the separate text gate are now accepted.**
The authorized selections are consumed. No participant or model loads
or fits; the private destination remains absent. **Private build, E.5
and Appendix C2 remain on hold.**

Next: resolve the private build's permitted use, effective worker and
reviewer access, no-sync destination, log and temporary-file custody,
and retention. Bind an exact private preparation-only caller and review
packet before asking for a separate build authorization. Do not treat
this synthetic pass as participant access or analytical dataset lock.
