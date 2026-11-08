# One independent read-only review — source preparation only

Reviewer: `/root/package_e_final_source_review`, 8 November 2026.
Initial verdict: **changes needed before native dispatch**. No Stata command,
participant/model read, edit or Git mutation was performed by the reviewer.
There was no second review of the corrected source or final validation receipt.

## Findings and parent disposition

1. **Tool-state evidence (reviewer Critical; parent scope correction).** Reviewer
   catalog exposed `mcp__stata_mcp__stata_run_selection`, `stata_session` and
   `stata_run_file`; primary inventory still exposed none and its session/run
   properties were undefined. Corrected evidence to distinguish contexts, without
   asserting a global installation problem or a qualified session. No calls.
2. **Signature syntax (Important).** Four `datasignature <varlist>` lines would
   enter the ordinary subcommand interface. Replaced them with `_datasignature`
   and a nonempty initial signature guard. This was verified against official
   syntax/source, not reproduced by executing Stata.
3. **Positional invocation (Important).** `local 0` alone does not supply the
   numbered locals consumed by `args`. Replaced instructions with a native
   one-line `do` invocation transported through `stata_run_selection`.
4. **Denominator receipt observations (Important).** Added hand-derived expected
   latest-form q9_5 bases 25/24/1/25 and code-98 share 1/25; q4_12 ordinary base
   22, option 2 share 1/22 and genuine option-3 zero 0/22. Empty-state stress
   must emit neither percentage. These are future expectations, never results.
5. **IADT distinction (reviewer Minor; parent regraded Important test gap).** Added
   row-20 app response 1, with IADT3=.5 versus IADT2=.75, because identical
   case-1 expectations alone could miss an incorrectly duplicated construction.
6. **Scalar/log guards (reviewer Minor; parent regraded Important false-pass risk).**
   Made required return codes and N/k dimensions scalar `if` failures and
   required the expected log file before testing that its named handle is closed.
   A log never opened cannot now count as successful cleanup in those cases.
7. **E.2 residence scope (reviewer Minor; parent clarified material scope).**
   Raw classification ends at preparation line 1584, before `wp07_residence`.
   E.2 now explicitly reviews raw q3-by-version counts, not that later derived
   field. No extra preparation segment or participant operation was authorized.

Parent also retained an explicit synthetic row-ordinal assertion after full
analysis because a data signature alone is not row-order proof. Canonical
research scripts did not change. The regraded findings were corrected together;
no unrelated polish or new abstraction was introduced.

## Declined-to-judge boundaries, adopted explicitly by parent

- Copied-text/Unicode fidelity and native parsing: require actual native receipt
  and copy comparison; still NOT_RUN, not inferred from text checks.
- Numerical percentages/coefficients and actual signature behavior: require
  native results; all fourteen cases stay NOT_RUN.
- Actual session/log custody and mid-save disk failure: unqualified/untested;
  prepared control cases do not establish these facts.
- Participant N, scoring coverage or validity: no participant operation approved
  or performed. E.2/E.3 remain separate proposed scopes.
- State 3: no raw assignment exists in pinned classifier; no invented passing
  unavailable-item test or survey-administration claim.
- C2, institutional/scientific adoption and release: independent HOLD/decisions
  remain; source preparation is not clearance.
- Final metadata receipt: not yet written during review; parent must verify it
  freshly and cannot attribute its acceptance to the independent reviewer.

No deferred minor change remains after the substantive regrading/clarifications.
The parent's verdict is **source preparation audited, native acceptance pending**,
not executed correctness or readiness to process participants.
