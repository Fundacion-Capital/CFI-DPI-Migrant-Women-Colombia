# E.5 v3 native validation — stopped before dispatch

10 November 2026. **Zero of twelve authorized selections were dispatched.**
The source/fixture/request/custody preflight passed, but a required completion
receipt is suppressed by the exact request's logging mode. The stop-on-failure
rule applies before execution as well. This is not a native v3 run failure,
numerical discrepancy, or new QS2 rendered-layout finding. E.5 remains partial
and C2 remains HOLD.

## What stopped the batch

The sealed preparation checklist and README require both the caller's
`E5_ARTIFICIAL_COMPLETE` line and the outer
`E5_ARTIFICIAL_SELECTION_COMPLETE` line. All twelve exact requests invoke the
unchanged caller with `capture quietly do`. Its ordinary final `display` is
therefore suppressed. The main JSON contract describes caller-asserted inner
return codes and the outer receipt; it does not independently demand the
additional printed caller receipt. We did not silently choose the weaker
reading of these sealed acceptance documents.

The preserved v2 AT01 run used the byte-identical caller with the same quiet
invocation. Its complete expanded response shows the outer completion line
and its receipt records rc0, but neither the expanded response nor the ordinary
native log contains the caller's completion line. The ordinary log is closed
before the outer line is printed; that outer line's absence from that file is
expected. These are saved observations, not a fabricated v3 replay.

StataCorp documents the output suppression and the supported way to capture
return codes while retaining output: [quietly/noisily manual](https://www.stata.com/manuals/pquietly.pdf)
and [capture manual](https://www.stata.com/manuals/pcapture.pdf).

## What was verified and preserved

- All981 inherited fingerprints matched; the two navigation updates retain
  exact before-images and979 other predecessors stay byte-identical.
- The complete all-empty preparation checker and frozen presentation-auditor
  unit tests passed before the stop. All24 case directories remain empty,
  all12 native logs are absent, and both future table wrappers remain uncompiled.
- One read-only manager inventory found multi-session operation,95 available
  slots and the proposed session ID absent. No worker was admitted, created,
  selected, replaced or destroyed. This is not native readiness/exit proof.
- The current grant, failed semantic preflight, twelve undispatched case
  statuses and source/saved-trace evidence are recorded. Prior v2/v3 packets,
  source bodies, requests, fixtures, output auditors and manuscripts are intact.
- Independent review confirmed the pre-dispatch stop. Zero Stata selections,
  retries, participant/model loads, fits or LaTeX compiles took place.

See AUTHORIZATION.json, INPUTS.json, AUDIT.md, CASE_STATUS.csv and VALIDATION.json.
The Git-ignored companion preserves the inventory, full evidence record and
before-images; do not stage it. The preparation snapshot remains historical,
not an invitation to dispatch the twelve still-empty cases.

## Next substantive task

Prepare one additive **request-logging-only successor**. Change the outer call
from `capture quietly do` to `capture noisily do` in the new selections only;
keep the existing caller body, v3 producer, fixtures, case design, return-code
assertions and all numeric/rendered gates unchanged. Bind new request hashes,
paths and session namespace. Check the observable receipt requirement against
the preserved failed evidence before seeking new execution authorization.
This correction is proposed, not applied or natively tested here.

The future check must distinguish actual caller/outer receipts from echoed
commands and expected inner r(9), r(459) or r(602) diagnostics. Read the caller
receipt from the retained output/log and the outer receipt from the expanded
response; do not require the outer line inside the already-closed ordinary log.
Keep no retries,60-second soft timeouts, no participant/model loads or fits,
AT01 numeric/render acceptance before continuation, and stop on first failure.

Unused capacity from this stopped grant is not continuation authority. No
scientific method, journal layout, institutional/disclosure/release decision or
C2 is advanced. Packages B/C/D/G continue the complete academic-paper scope.
No Python/worker/bootstrap or other infrastructure work is needed for this fix.
