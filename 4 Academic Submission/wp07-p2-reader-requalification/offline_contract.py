"""Disabled requalification metadata only; no worker, Stata or dispatch interface."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
READER_PATH = "4 Academic Submission/wp07-target33-offline-dispatcher/dispatcher.py"
READER_SHA = "fcd89aed850e8f69eb0e6ca7388fde1aa988622e2bcb63127b44bb4edace2ad2"
VERSIONS = ("2512090157", "2512091719", "2512111044", "2512121811", "2602120658")
CASE_NAMES = ("01 Barrier state cases.do", "02 Version and route cases.do", "03 Reporting denominator cases.do", "04 Prepared coverage cases.do", "05 Expected range rejection.do")


def sha(raw):
    return hashlib.sha256(raw).hexdigest()


def load_preserved_reader():
    # The pinned module imports only standard libraries; never call its load_plan.
    path = ROOT / READER_PATH
    if sha(path.read_bytes()) != READER_SHA:
        raise ValueError("Preserved reader source changed")
    spec = importlib.util.spec_from_file_location("_wp07_preserved_reader", path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def candidate_payload(raw):
    """Compute a prospective byte string only; never write or execute it."""
    lines = raw.splitlines(keepends=True)
    first = next((i for i, line in enumerate(lines) if line.strip() and not line.lstrip().startswith(b"*")), None)
    if first is None or lines[first].strip() != b"exit 198":
        raise ValueError("Expected first-command hold")
    return b"".join(lines[:first] + lines[first + 1:])


def describe(path, held):
    raw = (ROOT / path).read_bytes()
    payload = candidate_payload(raw) if held else raw
    return dict(path=path, as_saved_bytes=len(raw), as_saved_sha256=sha(raw),
                candidate_payload_bytes=len(payload), candidate_payload_sha256=sha(payload),
                payload_transform="REMOVE_FIRST_EXECUTABLE_EXIT_198_ONLY" if held else "UNCHANGED_LEGACY_SOURCE",
                activation_authorized=False)


def output_inventory(reader, body):
    outputs = reader.templates(body, VERSIONS)
    result = []
    for output in outputs:
        rows = [["<COUNT>" if value is reader.COUNT else "<STATUS>" if value is reader.STATUS else value for value in row] for row in output.rows] if output.header else list(output.rows)
        canonical = json.dumps(dict(header=output.header, rows=rows), ensure_ascii=False, separators=(",", ":")).encode()
        result.append(dict(name=output.name, kind="csv" if output.header else "text", header=list(output.header), rows=len(output.rows), template_sha256=sha(canonical)))
    return result


def build_bindings():
    reader = load_preserved_reader()
    participant = []
    for stage in ("P1", "P2", "P3", "P4"):
        path = "1 Code/wp07-p2-barrier-v1/P2 Barrier-corrected draft.do" if stage == "P2" else "4 Academic Submission/wp07-target33-selections/" + stage + ".do"
        record = describe(path, stage == "P2")
        raw = (ROOT / path).read_bytes()
        body = candidate_payload(raw) if stage == "P2" else raw
        record.update(stage=stage, outputs=output_inventory(reader, body))
        participant.append(record)
    old = (ROOT / "4 Academic Submission/wp07-target33-selections/P2.do").read_bytes()
    legacy = dict(path="4 Academic Submission/wp07-target33-selections/P2.do", bytes=len(old), sha256=sha(old), outputs=output_inventory(reader, old))
    data = json.loads((ROOT / "4 Academic Submission/wp07-p2-barrier-successor/ARTIFICIAL_CASES.json").read_text(encoding="utf-8"))
    facts = [
        {"rows":30,"p2_main_mismatches":0,"p2_additional_mismatches":0,"report_main_mismatches":0,"report_additional_mismatches":0,"cross_recipe_mismatches":0},
        {"families":9,"asserted_rows":48,"state_mismatches":0},
        {**{case["field"] + "." + key:value for case in data["report_cases"] for key,value in case["expected"].items()},
         "q4_13.no_account_after_selection":1,"q4_13.unselected_principal_2":1,"q10_2.main_none_additional_named":1,
         "empty.recorded_n":0,"empty.regular_n":0,"empty.sentinel_n":0,"empty.percentage_values_emitted":0},
        {**{"own_n." + key:value for key,value in data["prepared_cases"]["expected_own_n"].items()},
         **{"common_n." + key:value for key,value in data["prepared_cases"]["expected_common_n"].items()},
         "iat_summary_without_components":1,"remittance_n":3,"remittance_binary_n":3,"domestic_n":4,"users_n":3,"bins_n":1,"uncertain_bins_n":1,"missing_bins_n":1,"empty.candidate_n":0,"empty.common_n":0,"empty.domestic_n":0,"empty.users_n":0,"empty.bins_n":0},
        {"failed_statement":"assert missing(wp07_iat3) | inrange(wp07_iat3, 0, 1)"}
    ]
    cases = []
    for number, name in enumerate(CASE_NAMES, 1):
        record = describe("1 Code/wp07-p2-barrier-v1/artificial/" + name, True)
        record.update(case_id="A" + str(number), expected_exit=9 if number == 5 else 0,
                      expected_phase="range_assertion" if number == 5 else "completed_full_payload",
                      expected_facts=facts[number - 1], native_result="NOT_RUN")
        cases.append(record)
    harness = "4 Academic Submission/wp07-target33-fixed-file-harness/harness.py"
    return dict(status="PREPARED_OFFLINE_NOT_REQUALIFIED", activation_authorized=False, appendix_c2="HOLD",
                reader=dict(path=READER_PATH,sha256=READER_SHA),
                fixed_file_harness=dict(path=harness,sha256=sha((ROOT/harness).read_bytes()),replacement_installed=False),
                legacy_p2=legacy, participant_proposal=participant, artificial_cases=cases,
                participant_order=["P1","P2","P3","P4"], artificial_order=["A1","A2","A3","A4","A5"],
                artificial_case_isolation="FRESH_EMPTY_OWNED_RUNTIME_PER_CASE",
                proposal_limits=dict(per_selection=45,work=180,cleanup=30,total=210,retries=0,fits=0,adopted=False),
                artificial_runtime_budget="NOT_ADOPTED_OR_DERIVED_FROM_PARTICIPANT_LIMITS")


def check_case_record(case, record):
    """Validate artificial metadata shape/consistency, not truth of native evidence."""
    keys = {"scope","case_id","source_sha256","payload_sha256","native_return_code","terminal_phase","facts","participant_loads","fits","retries","admission"}
    if type(record) is not dict or set(record) != keys:
        raise ValueError("Artificial record fields")
    if record["scope"] != "ARTIFICIAL_CASES_ONLY" or record["case_id"] != case["case_id"]:
        raise ValueError("Cross-scope or case mismatch")
    if record["source_sha256"] != case["as_saved_sha256"]:
        raise ValueError("Held source identity")
    admission = record["admission"]
    if type(admission) is not dict or set(admission) != {"observed_n","observed_k","fresh_owned_runtime"}:
        raise ValueError("Empty-runtime admission fields")
    if type(admission["observed_n"]) is not int or type(admission["observed_k"]) is not int or admission["observed_n"] != 0 or admission["observed_k"] != 0 or admission["fresh_owned_runtime"] is not True:
        raise ValueError("Independent empty runtime required")
    if any(type(record[key]) is not int or record[key] != 0 for key in ("participant_loads","fits","retries")):
        raise ValueError("Artificial-only counts")
    if type(record["native_return_code"]) is not int:
        raise ValueError("Native return type")
    if record["native_return_code"] == 198:
        if record["payload_sha256"] != case["as_saved_sha256"] or record["terminal_phase"] != "entry_hold" or record["facts"] != {}:
            raise ValueError("Invalid held-source record")
        return "HELD_NOT_TESTED"
    if record["payload_sha256"] != case["candidate_payload_sha256"] or record["native_return_code"] != case["expected_exit"] or record["terminal_phase"] != case["expected_phase"]:
        raise ValueError("Payload or terminal outcome mismatch")
    expected = case["expected_facts"]
    if type(record["facts"]) is not dict or set(record["facts"]) != set(expected):
        raise ValueError("Incomplete artificial readout")
    if any(type(record["facts"][key]) is not type(value) or record["facts"][key] != value for key,value in expected.items()):
        raise ValueError("Artificial expectation mismatch")
    return "ARTIFICIAL_METADATA_CONSISTENT_NOT_NATIVE_VERIFIED"
