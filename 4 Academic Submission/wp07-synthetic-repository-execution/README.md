# WP07 synthetic repository successor — gate stopped

13 November 2026 · **One text-gate selection, zero qualification cases dispatched.**
[Sealed contract](../wp07-synthetic-repository-successor/RUN_CONTRACT.json) ·
[Validation and evidence pins](VALIDATION.json)

The authorized gate stopped in the explicit command-log guard with
Stata `r(459)`, before the runtime receipt or the first file command.
The response contains the conditional `if "`r(status)'" != "off"`
and its executed `exit 459`. The repository working-directory/empty-memory
check and ordinary-log guards did not trigger. Neither the value returned
by the quiet `cmdlog` nor a log filename was reported. An active command log
is not established. [StataCorp's logging reference](https://www.stata.com/manuals/rlog.pdf#page=5)
documents the status result, but it does not settle which value this worker
returned or what any unreported provider capture did.

The full returned response was saved before reading its receipts. The
tool envelope was not flagged as an error, but the native failure was
explicit. No spill was named; no Temp file was searched or inferred.
The exact gate directory was empty after the call. The postflight found
no new dataset or case output; the existing AQ07 sentinel retained its
exact bytes. No write, reopen, fixture, participant load or fit ran.

Before dispatch, the contract, 13 source pins, seven staging sources and
18 earlier receipts matched; all 27 proposed paths were unused. The
session manager showed 85 available slots and no bound names in use.
The seven files were staged by exact byte copy. The same pins and the
staging inventory matched after the stop. The manager then reported the
one gate session ready and not busy; none of AQ01–AQ12 was present.
This is not a process-exit attestation. No session was destroyed and
no permissions, settings or scientific code changed.

**Next:** Review the command-log guard in both the gate and the case
caller using saved evidence and the documented native interface. Do not
assume the macro was empty or relax the logging requirement. Any new
native diagnostic or changed request needs fresh exact authorization.
Keep all 12 unused requests stopped under this grant. The restricted
build, **E.5 and C2 remain held**.
