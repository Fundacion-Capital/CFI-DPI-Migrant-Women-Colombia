# Disabled P2 barrier successor

The successor and all five artificial case files start with `exit 198`.
They have not been run in Stata. No participant data or saved model was loaded.

`P2 Barrier-corrected draft.do` is a separate copy of P2, not a replacement for
the original or an activated selection. Its body differs only by 35 deleted
lines: 15 repeated classifier commands, 10 associated counts and 10 unsupported
uncertainty receipt rows. Option 4 in q10_1/q10_2 is the substantive barrier
“No sé cómo usarlos”; it is not uncertainty or an exclusive singleton.

All other source lines, route order, form versions, output columns and step
contract remain textually unchanged. The original P2 and its protected packets
remain intact. No master, dispatcher, reader or transport binding is updated.
The full successor retains TARGET33-specific receipt bindings, including the
historical 423-row checked denominator. It is not a general fixture runner.

## Artificial case files — prepared, NOT_RUN

1. **01 Barrier state cases.do:** 30 literal rows; compares both exact corrected
   P2 and reporting-layer recipes to hand-authored states and to each other.
2. **02 Version and route cases.do:** 48 rows across nine representative route,
   availability, mixed-version and numeric-edge families.
3. **03 Reporting denominator cases.do:** four exact item-report blocks on 20
   literal rows, plus an empty-base repeat. Covers uncertainty versus refusal,
   ordinary/recorded/applicable denominators and cross-item semantic diagnostics.
4. **04 Prepared coverage cases.do:** the exact prepared reporting body on four
   artificial rows and then zero rows. Values are literal reporting inputs,
   not reconstructed scores. One row is deliberately inconsistent to test the
   diagnostic, without repair or deletion by the reporting layer.
5. **05 Expected range rejection.do:** deliberately out-of-range input; after
   separately authorized activation it must stop at the production assertion
   with return code 9. As saved, it stops at the hold with code 198.

Each file requires empty memory before defining artificial rows. Subsequent
`drop` commands remove only the literal artificial rows created in that file;
there is no clearing of an existing participant dataset. There is no external
input/output path, fit, score formula, native launch, retry or helper framework.
Production fragments are copied verbatim and source-checked, not replaced by
a Python model of Stata. Expected values are literal and separately documented.

The state recipes deliberately retain P2's existing year/age bounds as test
targets; this does not resolve IVS reference clocks, normalization or eligibility.
Representative native cases do not exhaust all 93 items or all combinations.
The preserved reporting-layer static audit separately covers 465 item/version
contracts. No native case is marked successful by a static check.

See the [case/audit package](../../4%20Academic%20Submission/wp07-p2-barrier-successor/README.md).
Appendix C2 remains HOLD. Native execution, current access/output authority,
transport capacity, deadlines and owned-worker cancellation remain separate gates.
