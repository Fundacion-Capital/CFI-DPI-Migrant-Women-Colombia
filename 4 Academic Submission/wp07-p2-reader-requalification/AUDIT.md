# WP07 P2 reader/dispatcher requalification preparation audit

Date: 5 November 2026. Baseline HEAD: f25141211a4f6ee644c39076389cbaf8ab39722a.

## Scope and custody

This is an additive, offline package only. Existing Stata files, historical
outputs, artificial fixtures, readers, dispatchers, harnesses and prior packets
are unchanged. The preservation manifest covers 176 unique, explicitly named
source/documentation files. It does not contain participant or saved-model
payloads. The test verifies the manifest's own fixed hash, relative paths,
allowed source extensions, file sizes and every source SHA-256.

Only named CPython source/metadata checks were run. No Stata MCP/native call,
worker launch, participant-data or saved-model load, fitting, scoring, external
contact, settings/service change, commit, push or synchronization was performed.
No unheld Stata file or real output destination was written. C2 remains HOLD.

## What was reconciled

1. The legacy reader and fixed-file harness are pinned by source hash. The pure
   reader was imported only after checking its exact hash. Its load_plan and
   native providers were never called. The test builds documentary plans from
   fixed source paths and uses in-memory ArtificialTransport receipts only.
2. BINDINGS.json separates held source bytes from prospective payload bytes.
   The only prospective transform removes the first executable exit 198 line;
   it is computed in memory, never written or authorized for execution.
3. The participant proposal remains P1/P2/P3/P4. Corrected P2 is 952852 held
   bytes and 952843 prospective payload bytes, versus 956192 legacy bytes.
   Its receipt inventory is 4129 rows, versus 4139, with the same nine columns.
   Exactly ten q10_1/q10_2 uncertainty receipts disappear. The 500 six-state
   field/version groups are unchanged. Other stage inventories are preserved.
4. The preserved pure reader accepts artificial receipts using the corrected
   source template. It rejects old/new inventory mix-ups, invalid counts and
   duplicate rows. The old dispatcher rejects the new digest before simulated
   selection; this is an intact admission boundary, not a failed migration.
5. A1-A5 are a separate artificial-only proposal. Each requires a fresh owned
   empty runtime, with both N=0 and K=0. They are not five steps substituted
   into the four-stage participant dispatcher or its proposed deadline budget.
6. The artificial metadata contract requires 62 exact named facts and exact
   source/payload, scope, terminal phase and outcome. It rejects missing/extra
   facts, wrong values/types, fits, retries and participant loads. An as-saved
   exit 198 is HELD_NOT_TESTED; A5's expected exit 9 is valid only at its exact
   range assertion, never at an empty-memory admission failure.

## Fresh checks

- New offline contract: 16 tests passed.
- Preserved P2 successor checker: 13 tests passed.
- Preserved academic reporting checker: 15 tests passed.
- Preserved academic LCA/replacement-map checker: 9 tests passed.
- Total: 53 passing source/artificial checks; zero Stata tests.
- All 176 preservation fingerprints match. Existing tracked diff and index
  diff remain empty; only the new requalification directory is untracked.

During development, missing explicit empty-base/primary readouts and independent
empty-runtime admission were added before closeout. Regression tests now require
those fields; this does not change any prior fixture or scientific recipe.

## Limits and next implementation boundary

Artificial records in the checks are self-authored dictionaries. A consistency
pass does not authenticate execution, actor identity, native return, log output,
termination or cleanup. Real native-log extraction and independently verified
provenance are NOT qualified. No participant result or denominator is verified
by these tests.

MIGRATION_MAP.csv identifies the exact remaining consumer work: successor
loader/seals, P2 digest admission, fixed-file payload handoff, independent
artificial-case scheduling/readout, and local-only output/control/access/retention
bindings. None was installed into the preserved runtime. The 45/180/30/210-second
participant limits remain an unchanged, unadopted proposal; no artificial-case
budget was selected or deadline extended. A future operational package must
resolve those points separately before any trial is considered.

Completion is limited to preparing and auditing this offline package. It is not
runtime requalification, execution permission, scientific adoption or release.
