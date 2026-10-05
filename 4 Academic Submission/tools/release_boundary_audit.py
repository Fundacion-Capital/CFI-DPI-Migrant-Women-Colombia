"""Read-only provenance and release-specification support; never processes survey cells.

Stata performs all field counts through MCP. This helper pins file bytes, prepares
that metadata-only selection, and validates/classifies its returned schema.
All generated receipts stay in ignored audit-local; no originals are altered.
"""
import argparse
import csv
import json
import re
import subprocess
from collections import Counter, defaultdict
from datetime import datetime, timezone
from pathlib import Path

from intake_audit import inventory, sha256, write_json


def read_csv(path):
    with path.open(encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle))


def write_csv(path, rows):
    if not rows:
        raise ValueError("Refuse an empty evidence table")
    with path.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)


def scoped(root, relative):
    path = (root / relative).resolve(strict=True)
    if not path.is_relative_to(root):
        raise ValueError("Source escapes the approved root")
    return path


def baseline(repo, dropbox, onedrive, out):
    if any(out.iterdir()):
        raise ValueError("Baseline already exists: use assess or a fresh ignored output directory")
    pin = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=repo, text=True).strip()
    roots = {"dropbox": dropbox, "onedrive": onedrive}
    manifest = []
    for label, root in roots.items():
        manifest.extend(inventory(root, label, sorted(p for p in root.rglob("*") if p.is_file())))
    write_csv(out / "restricted_baseline_manifest.csv", manifest)
    targets = read_csv(repo / "4 Academic Submission/audit-local/intake/privacy_cleanup_targets.csv")
    sources, preservation = [], []
    for n, row in enumerate(targets, 1):
        relative = row["relative_path"]
        path = (scoped(repo, relative) if row["presence"] == "CURRENT_HEAD" else
                scoped(repo, "4 Academic Submission/audit-local/intake/history-blobs/" + row["git_blob"] + ".dta"))
        digest = sha256(path)
        if digest != row["sha256"]:
            raise ValueError("A selected sensitive source changed; stop and reconcile the new version")
        matches = [m for m in manifest if m["scope"] == "dropbox" and m["sha256"] == digest]
        other = [m for m in manifest if m["scope"] == "onedrive" and m["sha256"] == digest]
        source_id = f"TARGET{n:02d}"
        sources.append({"source_id": source_id, "path": path.as_posix(),
                        "source_kind": "excel" if path.suffix.lower() == ".xlsx" else "dta",
                        "sheet": "", "role": row["classification"], "presence": row["presence"],
                        "expected_sha256": digest, "expected_N": row["observations"],
                        "expected_K": row["variables"]})
        preservation.append({"source_id": source_id, "relative_path": relative, "source_commit": row["source_commit"],
                             "git_blob": row["git_blob"], "sha256": digest,
                             "dropbox_byte_identical_count": len(matches),
                             "dropbox_byte_identical_paths": ";".join(m["relative_path"] for m in matches),
                             "onedrive_byte_identical_count_NOT_permanent_archive": len(other),
                             "proposed_archive_relative_path": "2 Data/4 Restricted replication archive/" + row["git_blob"] + "/" + relative,
                             "status": "LOCAL_DROPBOX_BYTE_MATCH_ACL_UNVERIFIED" if matches else "RESTRICTED_PRESERVATION_GAP"})
    core = [("RAW01", "2 Data/1 Raw/CFI DPI Encuesta Cuantitativa_WIDE.xlsx", "excel", "data", "raw-survey"),
            ("CODED01", "2 Data/3 Coded/CFI_DPI Data for analysis.dta", "dta", "", "coded-original"),
            ("CODED02", "2 Data/3 Coded/CFI_DPI Data for analysis_NoPII.dta", "dta", "", "coded-NoPII-label-not-certification")]
    for sid, relative, kind, sheet, role in core:
        path = scoped(dropbox, relative)
        sources.append({"source_id": sid, "path": path.as_posix(), "source_kind": kind,
                        "sheet": sheet, "role": role, "presence": "LOCAL_DROPBOX",
                        "expected_sha256": sha256(path), "expected_N": "", "expected_K": ""})
    pins = []
    for root, label, relative in [(repo, "git", f"1 Code/{name}") for name in
                                 ("0 Master Code_CFI DPI Migrant Women Colombia.do", "1 Data Preparation_CFI DPI Migrant Women Colombia.do", "2 Analysis_CFI DPI Migrant Women Colombia.do")]:
        path = scoped(root, relative)
        pins.append({"scope": label, "relative_path": relative, "sha256": sha256(path), "bytes": path.stat().st_size})
    legacy = [m for m in manifest if Path(m["relative_path"]).name.startswith("Cardozo & Zavala - 2026 - Digital bridges") and m["relative_path"].endswith(".docx")]
    if not any(m["sha256"] == "99919BBE239C5CE319B986B6B18C534DB02D6E3CB5469FF55EDFC1294CAFC76F" and m["scope"] == "dropbox" for m in legacy):
        raise ValueError("Author-selected legacy foundation not hash-verified in Dropbox")
    pins.extend({k: m[k] for k in ("scope", "relative_path", "sha256", "bytes")} for m in legacy)
    write_csv(out / "source_pins.csv", pins)
    write_csv(out / "restricted_preservation_matches.csv", preservation)
    write_csv(out / "release_source_catalogue.csv", sources)
    write_json(out / "baseline_receipt.json", {"captured_utc": datetime.now(timezone.utc).isoformat(), "repository_commit": pin,
               "archive_occurrences": dict(Counter(m["scope"] for m in manifest)),
               "archive_readability": dict(Counter(m["status"] for m in manifest)),
               "selected_sources": len(sources), "selected_sensitive_targets": len(targets),
               "local_dropbox_identical_targets": sum(bool(r["dropbox_byte_identical_count"]) for r in preservation),
               "preservation_scope": "33 selected path/version receipts; not all historical blobs or remote copies",
               "access_control_certified": False, "scientific_replication_completed": False})
    selection = ['version 16', 'set more off', 'assert scalar(cfi_rel_mata_selfcheck) == 1',
                 'tempfile cfi_fields cfi_sources', 'tempname cfi_ph cfi_sh',
                 'postfile `cfi_ph\' str16 source_id str32 variable str12 storage_type str49 display_format str32 value_label_name str244 variable_label long N nonmissing_n distinct_n singleton_n using "`cfi_fields\'", replace',
                 'postfile `cfi_sh\' str16 source_id long N K using "`cfi_sources\'", replace',
                 'frame create cfi_release_data', 'frame change cfi_release_data']
    for row in sources:
        path = row["path"].replace('"', '')
        selection.append('quietly ' + (f'use "{path}", clear' if row["source_kind"] == "dta" else
                         f'import excel using "{path}", ' + (f'sheet("{row["sheet"]}") ' if row["sheet"] else '') + 'firstrow clear'))
        selection.extend(['quietly describe', f'post `cfi_sh\' ("{row["source_id"]}") (r(N)) (r(k))',
                          'unab cfi_vars : _all', 'foreach cfi_v of local cfi_vars {',
                          '    local cfi_t : type `cfi_v\'', '    local cfi_f : format `cfi_v\'',
                          '    local cfi_l : value label `cfi_v\'', '    local cfi_vl : variable label `cfi_v\'',
                          '    quietly mata: cfi_release_counts("`cfi_v\'")',
                          f'    post `cfi_ph\' ("{row["source_id"]}") ("`cfi_v\'") ("`cfi_t\'") ("`cfi_f\'") ("`cfi_l\'") (`"`cfi_vl\'"\') (_N) (scalar(cfi_rel_nonmissing)) (scalar(cfi_rel_distinct)) (scalar(cfi_rel_singleton))', '}'])
    selection.extend(['postclose `cfi_ph\'', 'postclose `cfi_sh\'', 'quietly use "`cfi_fields\'", clear',
                      f'quietly export delimited using "{(out / "stata_release_fields.csv").as_posix()}", replace quote',
                      'quietly use "`cfi_sources\'", clear',
                      f'quietly export delimited using "{(out / "stata_release_source_counts.csv").as_posix()}", replace quote',
                      'frame change default', 'frame drop cfi_release_data',
                      'display "PASS: metadata and aggregate field counts exported; source frames dropped"', 'frame dir'])
    (out / "release_schema_selection.do").write_text("\n".join(selection) + "\n", encoding="utf-8")
    print(json.dumps({"baseline": "PINNED", "sources": len(sources), "targets": len(targets),
                      "byte_preserved_in_local_dropbox": sum(bool(r["dropbox_byte_identical_count"]) for r in preservation)}))


def statements(text):
    """Lexical locators, not execution/dataflow proof. Preserve physical line ranges."""
    depth, pending, first, semicolon = 0, "", 0, False
    for number, line in enumerate(text.splitlines(), 1):
        if not depth and line.lstrip().startswith("*"):
            continue
        chars, quote, continuation, i = [], False, False, 0
        while i < len(line):
            pair = line[i:i+2]
            if depth:
                if pair == "/*":
                    depth += 1
                    i += 2
                elif pair == "*/":
                    depth -= 1
                    i += 2
                else:
                    i += 1
            elif not quote and pair == "/*":
                depth = 1
                i += 2
            elif not quote and pair == "//":
                continuation = line[i:i+3] == "///"
                break
            else:
                if line[i] == '"':
                    quote = not quote
                chars.append(line[i])
                i += 1
        clean = "".join(chars).strip()
        if clean.lower().startswith("#delimit"):
            if pending:
                raise ValueError("Delimiter switch inside an unfinished statement")
            semicolon = ";" in clean
            continue
        if not clean:
            continue
        if semicolon:
            # Split only outside quoted strings; these are source locators, not a Stata interpreter.
            parts = re.split(r';(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)', clean)
            for j, part in enumerate(parts):
                if part.strip():
                    if not pending:
                        first = number
                    pending += " " + part.strip()
                if j < len(parts) - 1 and pending:
                    yield first, number, pending.strip()
                    pending = ""
            continue
        if not pending:
            first = number
        pending += " " + clean
        if not continuation:
            yield first, number, pending.strip()
            pending = ""
    if depth or pending:
        raise ValueError("Unclosed block comment or continuation; do not certify locators")


def field_treatment(variable, types, item_type):
    """Conservative proposal only. No field becomes release-approved here."""
    lower = variable.lower()
    if lower in {"q11_2", "q11_3", "devicephonenum"}:
        return "DIRECT_CONTACT", "DROP_PUBLIC", "Genuine respondent contact/device telephone field; restricted originals only."
    if lower in {"key", "instanceid", "lca_id", "caseid"}:
        return "LINKING_IDENTIFIER", "REKEY_PRIVATE_CROSSWALK", "Replace with an opaque release-specific key after owner approval; never publish the source key, reversible mapping, or source row order."
    if lower in {"enumerator", "username", "deviceid", "device_info"}:
        return "PERSONNEL_OR_DEVICE", "DROP_PUBLIC", "Staff/account/device metadata is not an analytical smartphone-ownership indicator. Preserve privately."
    if lower in {"submissiondate", "starttime", "endtime", "duration", "formdef_version", "fecha", "review_comments", "review_corrections", "review_quality"}:
        return "OPERATIONAL_AUDIT", "PRIVATE_SOURCE_ONLY", "Keep collection/review metadata restricted; reproduce any necessary eligibility checks before public stripping."
    if lower in {"consent", "q11_1"}:
        return "CONSENT_OR_RECONTACT", "PRIVATE_SOURCE_ONLY", "Study/recontact permission is not public microdata consent. Preserve enrolment provenance privately and authorize release separately."
    if re.fullmatch(r"S\d+_[A-Z_]+", variable):
        return "FORM_SECTION_MARKER", "OMIT_WRAPPER_AFTER_DEPENDENCY_CHECK", "Questionnaire group wrapper, not a substantive outcome; verify no sample dependency before omission."
    if lower in {"ward_main_id", "ward_main_ord", "ward_main_hgt"}:
        return "CLUSTER_INTERNAL_LINKAGE", "RECOMPUTE_ONLY_IF_REQUIRED", "Hierarchical cluster identifiers/order/heights require linkage review; regenerate from approved anonymous input rather than release internal row links."
    if "posterior" in lower or lower.startswith(("pp_", "classpost", "segment_post")) or lower in {"maxpost", "segment_maxpost", "segment_assigned_post", "segment_secondpost"}:
        return "HIGH_PRECISION_LINKED_OUTPUT", "RECOMPUTE_OR_RESTRICT_PENDING_DISCLOSURE", "Posterior vectors/precision may fingerprint already exposed records; preserve the LCA specification and check all linkage channels before any microdata release."
    if lower in {"q3", "q4", "q2_1", "q2_2", "q2_3", "age_cat", "years_cat", "years_in_col", "antig_norm", "educ_norm", "ocup_norm"} or lower.startswith(("s15_age", "s15_city", "s15_educ", "s15_occ")):
        return "QUASI_IDENTIFIER", "UNCHANGED_ANALYTIC_CANDIDATE_WITH_JOINT_REVIEW", "Age/residence/migration/education/occupation can link people in combination. No automatic binning, perturbation, or sample changes; hold if exact-value reproduction cannot be safely released."
    if lower in {"segment_name_export", "policy_segment_name", "policy_segment_short", "defining_traits", "core_constraint", "main_intervention_lever", "baseline_profile_evidence", "adjusted_outcome_evidence", "interpretive_caution"}:
        return "RESEARCHER_CLASS_LOOKUP_TEXT", "CLASS_LEVEL_LOOKUP_AFTER_SOURCE_CHECK", "Candidate deterministic class annotation, not participant narrative; verify against code and publish as approved class-level metadata, not a contact-linked spreadsheet."
    if lower.endswith("_otro") or item_type == "text" or lower == "q2":
        return "FREE_TEXT_OR_UNVALIDATED_STRING", "PRIVATE_TEXT_OR_EXACT_CODED_DERIVATIVE", "Review response text privately for identifiers and code dependencies. Do not expose verbatim text or invent a new scientific recode under the privacy task."
    if any(t.startswith("str") for t in types):
        if any(not t.startswith("str") for t in types):
            return "MIXED_STORAGE_ANALYTIC_CANDIDATE", "CANONICAL_CODE_WITH_EXPORT_PARITY_REVIEW", "Both numeric and string copies exist. Verify Excel/category-label serialization against canonical Stata values; do not mistake analytical category text for free narrative or blindly destring it. Preserve exact canonical codes and joint disclosure review."
        if item_type.startswith("select_multiple"):
            return "CODED_MULTISELECT_STRING", "UNCHANGED_CODED_CANDIDATE_WITH_JOINT_REVIEW", "Instrument declares multiple-choice codes, not arbitrary narrative. Verify code-only content privately and preserve exact parsing/missing conventions if release is approved."
        if item_type.startswith("select_one"):
            return "CODED_SINGLE_CHOICE_STRING", "EXACT_CODED_CANDIDATE_WITH_CONTENT_REVIEW", "Instrument declares a single-choice field. Verify that strings are approved choice codes/labels rather than identifiers, and reproduce canonical analysis without an unapproved scientific recode."
        return "UNRESOLVED_STRING", "HOLD_PRIVATE_FOR_CONTENT_AND_DEPENDENCY_REVIEW", "String content is not presumed anonymous; inspect privately and adjudicate before release."
    return "SENSITIVE_ANALYTIC_OR_HELPER", "UNCHANGED_CANDIDATE_OR_RECOMPUTE_AFTER_REVIEW", "Retain only what the verified pipeline needs, unchanged in scientific meaning, missingness and sample membership; assess joint disclosure and earlier public linkage. Not release approved."


def assess(repo, dropbox, onedrive, out):
    sources = read_csv(out / "release_source_catalogue.csv")
    fields = read_csv(out / "stata_release_fields.csv")
    counts = read_csv(out / "stata_release_source_counts.csv")
    types = {r["name"]: r["type"] for r in read_csv(out / "instrument_question_types.csv") if r["name"]}
    grouped = defaultdict(list)
    seen = set()
    for r in fields:
        key = r["source_id"], r["variable"]
        if key in seen:
            raise ValueError("Duplicate source/field receipt")
        seen.add(key)
        n, nonmiss, distinct, singleton = (int(r[k]) for k in ("N", "nonmissing_n", "distinct_n", "singleton_n"))
        if not (0 <= singleton <= distinct <= nonmiss <= n):
            raise ValueError("Stata count invariant failed")
        grouped[r["variable"]].append(r)
    if {r["source_id"] for r in sources} != {r["source_id"] for r in counts}:
        raise ValueError("Not every selected source has a count receipt")
    for r in counts:
        if sum(f["source_id"] == r["source_id"] for f in fields) != int(r["K"]):
            raise ValueError("Field coverage does not equal source K")
        if any(int(f["N"]) != int(r["N"]) for f in fields if f["source_id"] == r["source_id"]):
            raise ValueError("Source N and field N disagree")
    discrepancies = []
    for source in sources:
        path = Path(source["path"]).resolve(strict=True)
        if not any(path.is_relative_to(root) for root in (repo, dropbox, onedrive)):
            raise ValueError("Catalogue source escapes the approved project roots")
        if sha256(path) != source["expected_sha256"]:
            raise ValueError("Original changed during the read-only checks")
        count = next(r for r in counts if r["source_id"] == source["source_id"])
        for item in ("N", "K"):
            if source["expected_" + item] and source["expected_" + item] != count[item]:
                discrepancies.append({"source_id": source["source_id"], "dimension": item,
                                      "prior": source["expected_" + item], "current": count[item]})
    references = []
    archives = read_csv(out / "restricted_baseline_manifest.csv")
    for row in archives:
        root = {"dropbox": dropbox, "onedrive": onedrive}[row["scope"]]
        if row["status"] != "HASHED" or sha256(scoped(root, row["relative_path"])) != row["sha256"]:
            raise ValueError("A scoped archive original is unreadable or changed since this workflow's baseline")
    for pin in read_csv(out / "source_pins.csv"):
        if pin["scope"] != "git":
            continue
        path = scoped(repo, pin["relative_path"])
        if sha256(path) != pin["sha256"]:
            raise ValueError("Historical Stata source changed during privacy task")
        for first, last, statement in statements(path.read_text(encoding="utf-8-sig")):
            tokens = set(re.findall(r"\b[A-Za-z_][A-Za-z_0-9]*\b", statement))
            # ponytail: lexical/macro-wildcard candidates only, never transitive dependency proof.
            wildcards = re.findall(r"\b([A-Za-z_][A-Za-z_0-9]*)\*(?!\w)", statement)
            exact = tokens & grouped.keys()
            candidates = {v for prefix in wildcards for v in grouped if v.startswith(prefix)} - exact
            command = statement.split()[0]
            role = ("SCHEMA_OR_LABEL" if re.match(r"^(label|la|notes|note|char|format|order)\b", statement) else
                    "VARLIST_OR_MACRO" if re.match(r"^(local|global|unab|foreach)\b", statement) else
                    "LINKAGE_OR_ORDER" if re.search(r"\b(isid|merge|frlink|frget|sort|gsort|duplicates)\b", statement) else
                    "ESTIMATION_OR_MODEL_CANDIDATE" if re.search(r"\b(regress|reg|logit|ologit|mlogit|glm|gsem|sem|poisson)\b", statement) else
                    "TRANSFORM_OR_SAMPLE_CANDIDATE")
            references.extend({"variable": v, "file": pin["relative_path"], "line_start": first, "line_end": last,
                               "command": command, "role": role,
                               "evidence": "EXPLICIT_LEXICAL_CANDIDATE" if v in exact else "WILDCARD_CANDIDATE"}
                              for v in sorted(exact | candidates))
    byvar = defaultdict(list)
    for r in references:
        byvar[r["variable"]].append(r)
    specification = []
    for variable, rows in sorted(grouped.items()):
        storage = sorted({r["storage_type"] for r in rows})
        risk, action, rationale = field_treatment(variable, storage, types.get(variable, ""))
        refs = byvar[variable]
        non_schema = [r for r in refs if r["role"] != "SCHEMA_OR_LABEL"]
        specification.append({"variable": variable, "source_ids": ";".join(sorted({r["source_id"] for r in rows})),
                              "storage_types": ";".join(storage), "instrument_type_CURRENT_not_historical_proof": types.get(variable, ""),
                              "variable_labels": " || ".join(sorted({r["variable_label"] for r in rows if r["variable_label"]})),
                              "risk_class": risk, "proposed_public_treatment": action, "rationale": rationale,
                              "code_reference_count": len(refs), "non_schema_candidate_references": len(non_schema),
                              "reference_status": "LEXICAL_CANDIDATES_REQUIRE_TRANSITIVE_REVIEW" if refs else "NO_EXPLICIT_HIT_NOT_PROOF_OF_UNUSED",
                              "singleton_screen_flag": "PRESENT_IN_AT_LEAST_ONE_SOURCE" if any(int(r["singleton_n"]) for r in rows) else "NONE_IN_MARGINAL_COUNTS_NOT_ANONYMITY_PROOF",
                              "approval_status": "PROPOSED_NOT_RELEASE_APPROVED", "semantic_parity_status": "NOT_TESTED"})
    write_csv(out / "field_code_references.csv", references)
    write_csv(out / "release_field_specification.csv", specification)
    write_json(out / "release_boundary_validation.json", {"captured_utc": datetime.now(timezone.utc).isoformat(),
               "selected_sources": len(sources), "field_occurrences": len(fields), "distinct_field_names": len(grouped),
               "all_source_field_counts_match_K": True, "count_invariants_pass": True, "source_hashes_unchanged": True,
               "archive_occurrences_rechecked": len(archives), "archive_original_hashes_unchanged": True,
               "historical_Stata_hashes_unchanged": True, "prior_dimension_discrepancies": discrepancies,
               "field_specification_coverage": len(specification) == len(grouped), "code_locator_rows": len(references),
               "risk_class_counts": dict(Counter(r["risk_class"] for r in specification)),
               "approved_public_fields": 0, "anonymized_dataset_created": False, "restricted_backup_created": False,
               "full_dependency_proof": False, "scientific_gate_passes": 0, "release_eligible": False,
               "holds": ["PUBLIC_DROPBOX_PARENT_LINK", "RESTRICTED_VERSION_PRESERVATION_GAPS", "CURRENT_RAW_VS_CODED_INPUT_VERSION_DISCREPANCY", "GIT_AND_HISTORY_CONTACT_EXPOSURE", "DISCLOSURE_AND_PARITY_NOT_COMPLETED", "ETHICS_REUSE_AND_OWNER_AUTHORITY_PENDING"]})
    print(json.dumps({"specification": "COMPLETE_PROPOSAL", "sources": len(sources), "field_occurrences": len(fields),
                      "unique_fields": len(specification), "code_candidates": len(references), "dimension_discrepancies": discrepancies,
                      "source_bytes_unchanged": True, "release_eligible": False}))


def self_test():
    text = '* ignore x\n/* outer /* nested */ hidden */ gen x = y ///\n + z // ignored w\nlocal uri "https://example.org/x"\n'
    locators = list(statements(text))
    assert locators == [(2, 3, "gen x = y + z"), (4, 4, 'local uri "https://example.org/x"')]
    semicolon = '#delimit ;\npost_inventory,\n variable("x") notes("text; not a terminator");\n#delimit cr\ngen z = x\n'
    try:
        semicolon_locators = list(statements(semicolon))
    except ValueError:
        semicolon_locators = None
    assert semicolon_locators == [(2, 3, 'post_inventory, variable("x") notes("text; not a terminator")'), (5, 5, 'gen z = x')], "Semicolon mode must keep multiline source locators and quoted semicolons"
    assert field_treatment("q11_3", ["str21"], "text")[1] == "DROP_PUBLIC"
    assert field_treatment("KEY", ["str41"], "")[1] == "REKEY_PRIVATE_CROSSWALK"
    assert field_treatment("iaff_phone", ["byte"], "")[0] == "SENSITIVE_ANALYTIC_OR_HELPER"
    assert field_treatment("lca_di_smartphone", ["byte"], "")[0] == "SENSITIVE_ANALYTIC_OR_HELPER"
    assert field_treatment("q5_13", ["str13"], "select_multiple kyc")[0] == "CODED_MULTISELECT_STRING"
    assert field_treatment("IAER_cat", ["byte", "str13"], "")[0] == "MIXED_STORAGE_ANALYTIC_CANDIDATE", "Excel category text must not imply that a canonical numeric analytical field is free narrative"
    assert field_treatment("q4_1_otro", ["byte", "str104"], "text")[0] == "FREE_TEXT_OR_UNVALIDATED_STRING"
    assert field_treatment("q4", ["byte"], "integer")[0] == "QUASI_IDENTIFIER"
    root = Path(__file__).resolve().parent
    assert scoped(root, ".") == root
    try:
        scoped(root, "..")
    except ValueError:
        pass
    else:
        raise AssertionError("Source scope guard accepted an ancestor outside its root")
    try:
        list(statements("/* unclosed"))
    except ValueError:
        pass
    else:
        raise AssertionError("Parser accepted unclosed block comment")
    print("PASS: scope guard; nested comments, continuations, semicolon/quoted-string locators; contact/key/text, analytical phone and mixed Excel-category treatment")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("--phase", choices=("baseline", "assess"), default="baseline")
    parser.add_argument("--repo", type=Path)
    parser.add_argument("--dropbox", type=Path)
    parser.add_argument("--onedrive", type=Path)
    parser.add_argument("--out", type=Path)
    args = parser.parse_args()
    if args.self_test:
        self_test()
        raise SystemExit(0)
    if not all((args.repo, args.dropbox, args.onedrive, args.out)):
        parser.error("Supply --self-test or all four scoped paths")
    repo, db, od = (p.resolve(strict=True) for p in (args.repo, args.dropbox, args.onedrive))
    out = args.out.resolve()
    if not out.is_relative_to(repo / "4 Academic Submission/audit-local"):
        raise ValueError("Receipts must stay in the private audit boundary")
    if subprocess.run(["git", "check-ignore", "--no-index", str(out / "probe.csv")], cwd=repo, capture_output=True).returncode != 0:
        raise ValueError("Private output location is not Git-ignored")
    out.mkdir(parents=True, exist_ok=True)
    if args.phase == "baseline":
        baseline(repo, db, od, out)
    else:
        assess(repo, db, od, out)
