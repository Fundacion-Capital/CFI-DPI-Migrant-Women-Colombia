# WP07 — preparation-only build contract

13 November 2026 · **Contract audited offline; execution held.**
See [the binding](BUILD_CONTRACT.json), [322-field schema](SCHEMA.csv),
[static audit](AUDIT.md), and [milestone roadmap](ROADMAP.md).

## 1. Carrier, cohort and exclusions

- Use the exact historical admitted carrier at the absolute path in the
  sealed [E.2/E.3 scope](../wp07-restricted-coverage/SCOPE.json), field
  `carrier.path`. Do not resolve by basename, latest timestamp, Git,
  OneDrive, an export labelled NoPII, or a refreshed SurveyCTO download.
- Bound size: **1,292,059 bytes**; recorded SHA-256:
  `95e0929d4ab5f4e0808c07f9eb636c24a0eeb88f676cace328bb064badcad756`.
  Current file length agrees. No fresh content checksum was taken. A future
  explicitly authorized opaque hash check before and after the build must
  agree with this pin; do not hydrate, copy, or rebind a cloud-managed
  carrier without authority.
- Require **423 rows** immediately after the single literal 98-field
  projection. The frozen carrier inherits all author-confirmed manual
  test/non-official exclusions and the coded exclusions. The historical
  script's lines 1011, 1014–1016 exclude empty key, consent codes 0/98,
  gender code 2 and remittance codes 0/98. In the preserved aggregate flow
  these remove 0, 4, 8 and 55 in sequence from 490 to 423. This does not
  locate every manual exclusion, label all 67 as tests, certify eligibility
  or give a response rate. Never reapply the filters or select keys to
  retest them. Preserve original rows, order, version values and answers.
- The 98-name projection is identical to E.3/E.4 and the held master.
  It has 92 numeric fields and six string multi-select parents. No
  name, contact field, key, enumerator identifier, clock, open-ended
  text or historical index is selected. A restricted 322-field
  respondent-level derivative is **not** anonymized or release-cleared.

## 2. Access and admission, before any carrier byte read

1. Confirm that present permissions and permitted use cover **the named
   carrier plus one new persistent private respondent-level derivative**.
   Current carrier metadata shows a Dropbox reparse point and inherited
   ReadAndExecute for `CodexSandboxUsers`, in addition to the owner, SYSTEM
   and Administrators. Check actual custody, permitted cloud access and
   effective access of the exact native and reviewer identities. Do not
   infer permission from prior E.3/E.4 runs or alter the original ACL.
2. Proposed root: `C:/Users/jzava/AppData/Local/CFI-DPI-WP07-Private`.
   Proposed fresh leaf: `preparation-only-20261113-dc48dbc`. Both were absent.
   No reparse point on the inspected existing AppData/Local ancestor chain;
   the existing parent has additional inherited allow entries. Under
   separate authority, provision **only new directories** with protected
   DACLs and inherited child rights limited to the approved owner,
   SYSTEM and Administrators (or a separately approved, exactly identified
   minimal native writer). Verify actual no-sync custody, no reparse point
   or path substitution, intended read/write/traverse access and no preexisting
   target. Never edit parent/shared ACLs. If any path or identity changes,
   prepare a successor contract before executing.
3. Bind the owned, fresh and empty Stata MCP session, exact caller/selection
   bytes, and all provider command/log, temporary save, spill and readback
   destinations, with restricted retention and no participant values
   in ordinary output. The E.5 Temp findings do not clear this route.
   A quiet invocation is not proof of hidden capture containment. If
   provider or transient-file custody cannot be verified, stop; do not
   substitute a worker, shell Stata, Python/R or change settings.
4. Before participant execution, qualify the exact caller and preparation
   body on artificial inputs only under a separate grant. Then obtain a
   new exact authorization for one restricted selection, one carrier
   load, one persistent save, one reopen of that save, and the named
   aggregate readback and receipts. The current scope is none of these.

## 3. Required future caller and readback sequence

The JSON pins the held preparation file and its deterministic body digest.
When separately preparing the native selection, extract only lines 9–1792
under the declared normalization. Verify both hashes; keep the original
line-7 hold and all prior scripts unchanged. The extraction is not
materialized and no dispatch request has been staged. Use direct native
Stata commands. Do not run the full master, full Analysis, historical
scripts, E.4 estimation, E.5 or Appendix C2.

| Order | Operation | Required result |
| --- | --- | --- |
| 1 | In the owned empty session, check fresh output, run route and private temporary location. Load the 98 literal fields once, without a row condition. | 423 rows; 98 exact names; 92 numeric and six string. Verify names exactly, not by abbreviation; abort before save on mismatch. |
| 2 | Apply the verified preparation body once. | The built-in count, temporary row ordinal and projected signature checks pass. Ordinal and all lexical validation fields are gone before save. Exactly 224 declared fields added (196 byte, 28 double); no new exclusion, filtering, weighting, label reinterpretation or alternative construction. |
| 3 | In memory, check full schema and response-state invariants, inspect metadata privately, then save `wp07_prepared_candidate.dta` once without `replace`. | Match all 322 names and types to the schema. Record the observed raw storage types, variable order and dataset/variable labels, value-label definitions, notes, formats and characteristics. Hold before save if metadata shows identifiers, unapproved free text or unexpected content; do not silently scrub and proceed. No by-product dataset, row listing or export. |
| 4 | Keep the exact pre-save frame; reopen the single candidate once in a separate owned frame. | Match 423×322; compare names, variable order, actual storage types and all cells at corresponding row positions using native frame comparison, e.g. assert field equality against the original frame's `_frval()` by `_n`, with no sort or linkage. Compare metadata separately; keep extended missing codes and string values exact. Data signatures supplement the check; they are not row-order or metadata proof. See [Stata 16 frame functions](https://www.stata.com/manuals16/fn.pdf). |
| 5 | From the readback frame reconcile coverage and write only the named private status/evidence records. Clear both owned frames and check the completion receipt. | All checks below pass; candidate bytes, size, ACL and lineage sealed privately after save. Verified execution state and no unexpected outputs. No empirically adopted or release-cleared artifact is produced by this preparation-only contract. |

Coverage checks: known versions plus unknown reconcile to admitted N. For
each of the 93 items and each ALL/five-version/UNKNOWN scope, route and
response-state partitions independently sum to the scope base and
recorded = ordinary + sentinel. Compare by `field,scope` to the one named
prepared coverage reference, with exact counts and all required keys.
Reconcile the 17 components and 11 candidates by `kind,variable`, and the
seven definition records across three comparisons by `group,definition`.
Check exact counts, storage, statuses and missingness; numeric summary
comparisons use the recorded E.3 `1e-12` tolerance, never edited counts or
clipped bounds. Preserve the domestic-use and remittance-disposition routes
and uncertainty/nonresponse semantics. Reconcile the four model input Ns
and the common N to the five exact E.3 selector records using
`observed_n`, **not** `base_n`. Use the adopted E.4 source mask predicates,
including the common/D0 equality and applicable grouped-input presence.
No fit, model save, predictions, correlation, or access to the five E.4
render ledgers. Any reference byte or keyed comparison needs the new
aggregate grant; an unverified reference means no final acceptance.

Artificial qualification must test an ordinary mixed-type round trip and
confirm fail-closed outcomes on empty or wrong-N input, a modified value,
permutation of otherwise identical rows during construction, wrong schema
or type, existing output, readback mismatch, and unexpected logging.
Test affirmative-use bin accounting in the separate reporting audit,
not by calling Analysis here. Bind exact fixtures, requests, and outputs
first; no genuine carrier or retries during qualification.

## 4. Custody, failure and completion

The proposed budget is one future MCP selection (60-second soft timeout),
one admitted-carrier projection, one private save, one candidate reopen,
zero fits and zero retries. Preserve source, intent, success/failure
receipt and any partial candidate at the exact private location; mark
partial or mismatched files unaccepted and never repurpose or overwrite
them. A timeout does not prove process exit. Stop and leave unknown worker
state for explicitly authorized review; no restart or substitution.
Do not disclose names, paths with participant content, cells or rare
aggregates through chat/Git/Overleaf.

`intent.json` must bind the approved request, inputs, destinations, identity
and ceilings before dispatch. `build_receipt.json` must record actual counts
of loads/saves, native status, observed cleanup and file seal, including
failure where applicable. `coverage_reconciliation.json` holds the private
schema/metadata and keyed comparison dispositions. These are future
evidence files, not outputs of this audit. Do not accept a file on the
basis of its existence, an echoed command, or an MCP success flag alone.

Proposed interim retention is restricted preservation of the approved
attempt and evidence until the authors and institution decide retention
and disposal; no automatic transfer, deletion, public access or
retention-period claim. Any disclosure and package release is a separate,
exact-version decision. E.5 and Appendix C2 stay **HOLD**.
