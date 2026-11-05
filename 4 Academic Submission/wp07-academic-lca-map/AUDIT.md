# Documentary replacement-map audit

5 November 2026. Closed for this documentary task only.

## Scope and result

The new report and CSV registers crosswalk the protected historical LCA and
downstream source workflow to accepted D2/D3/D4/D6 policies, proposed replacements,
prospective retirements and five unresolved scientific choices. Retirement is
non-destructive: no source, result, failed attempt or prior packet is removed.
No replacement analytical do-file is implemented or adopted by this map.

The checked scope is:

| Register | Checked coverage |
|---|---|
| STAGE_MAP.csv | The exact 16 predecessor stages and source boundaries, lines 1900–19300 |
| OPERATION_MAP.csv | The exact 32 grid candidates plus 88 inherited downstream conditional slots; 120 unique IDs |
| Preferred-final distinction | The separate preferred-final H1 four-class refit is counted once, not merged with the grid H1 four-class candidate |
| DOMAIN_DESTINATIONS.csv | All 15 substantive quantitative domains retain an academic destination and explicit limitations |
| DECISIONS.csv | ML01–ML05 remain pending; no owner answer or new scientific adoption is inferred |
| NOFIT_WAVE.csv | V00–V05 remain planned, not executed; current authority, fits and new-score permission remain zero/false |
| TARGET33 | The existing 163-field allowlist remains unchanged; no posterior inspection is added to P1–P4 |
| Source custody | All 81 pinned existing code/document/metadata files match their recorded byte counts and SHA-256 fingerprints |

The operation count is a source-path inventory, not a count of completed fits,
future planned fits or authorized attempts. The two historical fallback slots
are identified for prospective retirement, not executed or deleted.

## Independent review and corrections

A separate read-only reviewer checked the map against the bounded predecessor
registers and accepted measurement/analysis accounts. The first review found no
substantive mismatch but identified two important verifier omissions:

1. The no-fit check did not reject an accidentally enabled new-score flag.
2. The preservation check trusted the manifest without first binding its exact
   membership, permitting an empty/altered manifest in principle.

Both were corrected in the new verifier. It now rejects score permission, binds
the exact reviewed manifest SHA-256 before any listed-file iteration, requires
81 unique entries, and checks repository-relative resolved documentary/code paths.
The operation negative control was also extended to reject an extra-ID substitution.
The independent reviewer read back the changes and reran all nine file-only tests:
9 passed, no remaining findings in this bounded review. See REVIEW.md.

## Executed validation

The implementer and reviewer each ran the isolated metadata-only verifier with
the exact pinned CPython 3.11.15 interpreter:

```text
C:/Users/jzava/AppData/Roaming/uv/python/cpython-3.11.15-windows-x86_64-none/python.exe -I -B "4 Academic Submission/wp07-academic-lca-map/verify_map.py"
```

This script uses only the Python standard library to read code/document/metadata
files. It does not import Stata/PyStata/SFI, discover or launch a native worker,
read a participant dataset or inspect a saved model/posterior payload. Its
in-memory negative cases are documentary-map mutations, not artificial Stata runs.

Tests cover map identities and coverage, source fingerprints, all-domain
destinations, unchanged projection shape, operation source locations, and rejection
of missing/duplicate/extra slots, invented authority/adoption/class count,
assumed owner answers, folded-in posterior scope and new-score permission.
The final rerun and new-artifact hash readback are recorded in VALIDATION.json.

Git HEAD remains 3e33f054da48a5c9f4f643f00271c22ccd87143b.
The tracked and staged diffs were empty at closeout; this task adds only its
new report and its new map/audit directory. The 81-file fingerprint check does
not claim a fresh byte audit of every private historical packet. Those packets
were neither opened nor changed by this task.

## Authority and scientific limits

- No Stata execution, participant load/export, score, fit, prediction, assignment
  or applied relabeling occurred.
- No historical, style-only or revised analytical code was changed.
- No new LCA family, class count, threshold, fit budget, probability tolerance,
  reference class, uncertainty method or dependence treatment was chosen.
- Accepted measurement and primary-analysis policies remain accepted within
  their recorded conditions. Recommendations in this map remain recommendations.
- No manuscript, qualitative content, data, sample, estimate, graph or historical
  exclusion was changed. Manual exclusions remain preserved.
- No setting/service changes, native probes, contacts, commit, push, release or
  cloud/Overleaf synchronization occurred.
- Institutional, coauthor and release matters remain as recorded, not resolved
  by this technical audit. Appendix C2 remains HOLD.

Scientific adequacy, empirical coverage, identification, posterior behaviour,
software-method compatibility, uncertainty validity and runtime qualification
were not established. Technical closure applies to this map alone.

## Next substantive code process

Prepare a separate, disabled academic item/domain reporting layer against the
accepted preparation fields. Keep original sources and historical outputs
intact; name unimplemented fields/denominators rather than inventing aliases.
This can advance without selecting an LCA family. Actual participant processing
and any later LCA implementation require their own exact scientific and
operational scope; this handoff is not an execution grant.
