# WP07 — AQ04/AQ06 stopped before dispatch

13 November 2026 · [Sealed input](../wp07-integrated-closure/CLOSURE_CONTRACT.json) · [Validation and evidence pins](VALIDATION.json)

The authorized two-case attempt stopped at the staging verification gate.
**Neither AQ04 nor AQ06 was dispatched.** There are no new Stata response
digests or receipts. Both remain unaccepted; the ten earlier accepted
cases and the separate text gate retain their previous status.

Before staging, all 35 contract pins, 116 earlier evidence files, and
28 earlier staged source files matched. All seven offline verifier tests
passed. The Stata MCP manager reported 94 slots available and neither
reserved name in use. Only the five allowed source files and the two
empty artificial case directories were staged; no datasets were copied.

The controller's strict directory-list comparison rejected arrays with
the same strings but different prototypes across the Node REPL and its
filesystem module. A separate read-only check reproduced the comparator
failure and showed that the sorted names were equal by value. Independent
postflight verified the five staged files against the original byte
lengths and hashes, and both case directories remained empty. This
identifies a controller error; it is not an AQ04 or AQ06 native outcome.

The exact error envelope, staging observation, preflight, stop record,
and manager inventories are preserved as six sealed files. Both
inventories lack the reserved session names; no unrelated session was
acted on. The private build destination remained absent. No participant
or model data were loaded, no fits ran, and no prior packet or canonical
Stata source was changed. **E.5 and Appendix C2 remain on hold.**

Next: prepare and test an offline value comparison for directory entries
that accepts identical names and rejects missing or extra entries.
Retain the stopped roots and evidence unchanged. Bind a new attempt for
review before seeking separate authorization. This stop carries no
execution authority forward.
