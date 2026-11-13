# WP07 artificial qualification attempt — stopped at AQ01

13 November 2026 · **1 exact request dispatched, 0 accepted, 11 not
dispatched.** See [validation and evidence pins](VALIDATION.json) and the
unchanged [qualification contract](../wp07-preparation-only-qualification/QUALIFICATION.json).

The preflight matched the seven predecessor pins, exact twelve request
strings, seven staged source hashes, twelve fresh case directories and
AQ07's literal sentinel. The read-only entry inventory showed none of the
bound session names in use. The synthetic route was explicitly accepted
by the user; the participant destination remained absent and was not used.

AQ01 dispatched once, unchanged. Stata reported the exact bound
`run_artificial.do` path as not found and emitted
`WP07_AQ_OUTER case=aq01 rc=601 N=0 K=0`. The response envelope's
`isError: false` only indicates transport success. The full output was
recovered from the output-compression reference and preserved before
applying the receipt gate; this was not a Stata middleware spill path.
There was no inner or runtime receipt. The failure occurred at the
outer `do`, before the caller, fixture, preparation, save, or reopen.
No other selection was dispatched or retried. See [Stata's do-file
return-code example](https://www.stata.com/manuals/u.pdf).

Post-stop checks found the caller still present in the shell view at the
exact path, 4,920 bytes with its original hash. All seven staged hashes,
twelve case leaves and AQ07 sentinel still match. No case output was
created. The final read-only session inventory showed only AQ01 among
the proposed sessions, ready and nonbusy. That does not establish OS
exit or prove the worker could traverse/read the same path. No session
was destroyed or re-used; no native command or log search followed the
failure. The actual provider log and native temporary directory were
not reported because the caller never started.

**Disposition:** This isolates the failure to file visibility at the
Stata caller boundary. It does not yet identify the cause: worker path
resolution or effective access could differ from the shell's. Do not
assume a missing staged file, an ACL denial, or a preparation-script bug.
The batch is stopped with no remaining executable authority under this
attempt. Preserve the exact staged root, receipts, and old contracts.

**Next:** Use existing provider documentation and saved working-route
evidence to reconcile the shell/provider path boundary. If a native
check is still necessary, prepare a separately authorized synthetic
file-visibility check on one exact path and a fresh session. Do not
re-run AQ01, move the staged files, widen permissions, or change provider
settings under this grant. Only a verified route and fresh binding/grant
can reopen artificial qualification. No participant data, fits, E.5 or
C2 work occurred. Both holds remain.
