# E.5 six-slot aggregate exhibit producer implementation plan

> Execution is inline in this checkout, with one independent final review. No
> Stata execution, participant/model load, fit, Git action or release is included.

Goal: implement the approved six-slot exhibit specification as explicit native
Stata reporting, artificial aggregate fixtures and a separately gated no-fit test
contract. Spec: ../wp07-e5-restricted-exhibit-map/EXHIBIT_SPEC.md.

Architecture: one held producer, five fixed aggregate CSV inputs, five LaTeX
tables and one PDF/PNG figure plus numeric audit CSVs. No helper programs,
estimators, stored-model restores, participant files or additional dependencies.
QS3 derives SE=sqrt(V diagonal) and normal 95% coefficient intervals in Stata;
reference columns are labeled reference and have no estimated SE/interval.

## Scope and interfaces

- Create `1 Code/academic/3 E4 exhibits.do`, with line7 entry hold and one marked
  body accepting exact input/output directory arguments. Existing three scripts
  and all old packets remain unchanged; no master call is enabled.
- Create this package's artificial five-file fixture, finite case manifest,
  native artificial caller, exact output manifest and offline verifier.
- Preserve entry fingerprints and the two navigation before-images privately;
  update only this task's current checkpoint/register after review.
- Do not execute Stata or compile/render a surrogate output in another language.

## Steps and checks

1. Freeze entry sources; write independent artificial expectations before the
   producer. Record missing-producer red check. Native behavioral tests are
   authored, not run: source/fixture checks cannot substitute for native parsing.
2. Implement all six slots with one admission/output-collision check, explicit
   imports, required-key/status/units checks, deterministic order and full-precision
   audit exports. Stop rather than repair malformed/unavailable inputs.
3. Add artificial validation cases: complete positive output; reordered input;
   near-zero/unclipped bounds; duplicate/missing records; wrong units/endpoints;
   bad model status; broken covariance reference; existing destination collision.
   Native contract: zero fits, zero participant/model loads, finite selections,
   fresh private destinations, no retries, stop on unexpected result.
4. Run file-only fixture/source/preservation checks, including negative controls;
   obtain independent read-only review, resolve material findings, reseal artifacts
   and update the E.5 checkpoint only to source/fixture/contract completion.

## Review focus

Exact source tokens versus display rounding; references versus estimated zeros;
pointwise versus Holm inference; input/key/link mismatches before file creation;
collision safety and partial-output preservation; LaTeX escaping/width and plot
axis labels; native parsing/rendering still pending.

Ruling: the approved E.5 spec and current implementation request supply the
design; no renewed design interview is needed. Native Stata testing remains
separately gated, so no native RED/GREEN or rendered-layout claim is made.
Ruling: retain the existing checkout and audit-local custody pattern rather than
creating a worktree, commits or generic execution infrastructure; preserve all
before-images and old failures. Source-only completion is not empirical approval.
