"""Metadata and artificial receipts only. No Stata import, carrier or native call."""
import csv
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import sys
import unittest
import copy

sys.path.insert(0, str(Path(__file__).resolve().parent))
import offline_contract as contract

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent


class RequalificationChecks(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.binding = json.loads((HERE / "BINDINGS.json").read_text(encoding="utf-8"))
        # Rebuild only fixed named code paths before using any path from the frozen artifact.
        if cls.binding != contract.build_bindings():
            raise ValueError("Frozen bindings do not match current named sources")
        cls.reader = contract.load_preserved_reader()

    def plans(self):
        old_steps, new_steps = [], []
        for item in self.binding["participant_proposal"]:
            stage = item["stage"]
            original = ROOT / ("4 Academic Submission/wp07-target33-selections/" + stage + ".do")
            raw = original.read_bytes()
            old_steps.append(self.reader.Step(stage,raw,contract.sha(raw),self.reader.templates(raw,contract.VERSIONS)))
            raw = (ROOT / item["path"]).read_bytes()
            body = contract.candidate_payload(raw) if stage == "P2" else raw
            new_steps.append(self.reader.Step(stage,body,contract.sha(body),self.reader.templates(body,contract.VERSIONS)))
        with (ROOT / "4 Academic Submission/wp06-nofit-verification-preflight/verification_checks.csv").open(encoding="utf-8-sig",newline="") as handle:
            checks = tuple((row["check_id"],row["operation"]) for row in csv.DictReader(handle))
        self.assertEqual(len(checks),33)
        root = HERE / "_never_provisioned_output"
        self.assertFalse(root.exists())
        return tuple(self.reader.Plan(tuple(steps),root,contract.VERSIONS,checks,("ARTIFICIAL_DOCUMENTARY_ONLY",),False) for steps in (old_steps,new_steps))

    def artificial_outputs(self, plan, stage="P2"):
        transport = self.reader.ArtificialTransport(plan)
        step = next(s for s in plan.steps if s.id == stage)
        record = transport.select(step,45)
        self.assertEqual(record["scope"],"ARTIFICIAL_ONLY")
        return step,record["outputs"]

    def case_record(self, spec):
        return dict(scope="ARTIFICIAL_CASES_ONLY",case_id=spec["case_id"],source_sha256=spec["as_saved_sha256"],
                    payload_sha256=spec["candidate_payload_sha256"],native_return_code=spec["expected_exit"],
                    terminal_phase=spec["expected_phase"],facts=copy.deepcopy(spec["expected_facts"]),
                    participant_loads=0,fits=0,retries=0,
                    admission=dict(observed_n=0,observed_k=0,fresh_owned_runtime=True))
    def test_exact_binding_package_exists_and_is_disabled(self):
        path = HERE / "BINDINGS.json"
        self.assertTrue(path.is_file(), "Source-exact binding package not yet prepared")
        binding = json.loads(path.read_text(encoding="utf-8"))
        self.assertIs(binding["activation_authorized"], False)
        self.assertEqual(binding["appendix_c2"], "HOLD")
        self.assertEqual([r["stage"] for r in binding["participant_proposal"]], ["P1", "P2", "P3", "P4"])
        self.assertEqual(len(binding["artificial_cases"]), 5)

    def test_frozen_bindings_match_current_named_sources(self):
        self.assertEqual(contract.build_bindings(),self.binding)
        for spec in self.binding["artificial_cases"]:
            self.assertEqual(spec["as_saved_bytes"] - spec["candidate_payload_bytes"],9)
            self.assertNotEqual(spec["as_saved_sha256"],spec["candidate_payload_sha256"])
            self.assertIs(spec["activation_authorized"],False)

    def test_candidate_transform_does_not_write_or_accept_unheld_source(self):
        source = b"* comment\nexit 198\nversion 16\ncount\n"
        self.assertEqual(contract.candidate_payload(source),b"* comment\nversion 16\ncount\n")
        with self.assertRaises(ValueError):
            contract.candidate_payload(b"version 16\ncount\n")

    def test_exact_ten_receipt_delta_and_unchanged_schema(self):
        old,new = self.plans()
        before,after=old.steps[1].outputs[0],new.steps[1].outputs[0]
        self.assertEqual(before.header,after.header)
        self.assertEqual((len(before.rows),len(after.rows)),(4139,4129))
        def removed(row):
            return row[0]=="P2.08" and row[1] in {"q10_1","q10_2"} and row[3:5]==("sentinel","uncertainty")
        self.assertEqual(sum(removed(row) for row in before.rows),10)
        self.assertEqual(tuple(row for row in before.rows if not removed(row)),after.rows)
        groups={(row[1],row[2]) for row in after.rows if row[0]=="P2.03"}
        self.assertEqual(len(groups),500)

    def test_preserved_reader_accepts_new_spec_artificial_receipts(self):
        _,plan=self.plans()
        step,outputs=self.artificial_outputs(plan)
        self.reader.check_outputs(step,outputs,contract.VERSIONS)

    def test_old_and_new_receipt_inventories_cannot_cross(self):
        old,new=self.plans()
        old_step,old_outputs=self.artificial_outputs(old)
        new_step,new_outputs=self.artificial_outputs(new)
        with self.assertRaises(ValueError):
            self.reader.check_outputs(old_step,new_outputs,contract.VERSIONS)
        with self.assertRaises(ValueError):
            self.reader.check_outputs(new_step,old_outputs,contract.VERSIONS)

    def test_legacy_dispatcher_rejects_new_source_before_selection(self):
        _,plan=self.plans()
        transport=self.reader.ArtificialTransport(plan)
        self.assertNotEqual(plan.steps[1].sha256,self.reader.SOURCE_DIGESTS[1])
        with self.assertRaisesRegex(ValueError,"offline_admission"):
            self.reader.dispatch(plan,transport)
        self.assertEqual(transport.calls,[])
        self.assertFalse(transport.used)

    def test_original_controller_baseline_stays_artificial(self):
        old,_=self.plans()
        transport=self.reader.ArtificialTransport(old)
        result=self.reader.dispatch(old,transport)
        self.assertEqual(result["status"],"ARTIFICIAL_PASS")
        self.assertEqual((result["actual_loads"],result["actual_stata_calls"]),(0,0))
        self.assertFalse(result["live_ready"])

    def test_reader_rejects_malformed_artificial_counts_and_rows(self):
        _,plan=self.plans()
        step,outputs=self.artificial_outputs(plan)
        name=next(iter(outputs))
        table=list(csv.reader(io.StringIO(outputs[name])))
        for value in ("-1","424","NaN","True"):
            changed=copy.deepcopy(table)
            changed[1][6]=value
            handle=io.StringIO();csv.writer(handle).writerows(changed)
            with self.assertRaises(ValueError):
                self.reader.check_outputs(step,{name:handle.getvalue()},contract.VERSIONS)
        with self.assertRaises(ValueError):
            self.reader.check_outputs(step,{name:outputs[name]+outputs[name].splitlines()[1]+"\n"},contract.VERSIONS)

    def test_case_record_consistency_is_not_native_qualification(self):
        for spec in self.binding["artificial_cases"]:
            record=self.case_record(spec)
            self.assertEqual(contract.check_case_record(spec,record),"ARTIFICIAL_METADATA_CONSISTENT_NOT_NATIVE_VERIFIED")
            record.update(native_return_code=198,terminal_phase="entry_hold",payload_sha256=spec["as_saved_sha256"],facts={})
            self.assertEqual(contract.check_case_record(spec,record),"HELD_NOT_TESTED")

    def test_case_reader_rejects_cross_scope_stale_and_partial_records(self):
        spec=self.binding["artificial_cases"][2]
        for key,value in (("scope","TARGET33_PARTICIPANT"),("payload_sha256",spec["as_saved_sha256"]),("participant_loads",1),("fits",True),("facts",{}),("native_return_code",False),("case_id","P2")):
            record=self.case_record(spec);record[key]=value
            with self.assertRaises(ValueError):
                contract.check_case_record(spec,record)
        record=self.case_record(spec);key=next(iter(record["facts"]));record["facts"][key]=True
        with self.assertRaises(ValueError):
            contract.check_case_record(spec,record)

    def test_negative_case_does_not_accept_empty_memory_guard_failure(self):
        spec=self.binding["artificial_cases"][4]
        record=self.case_record(spec);record["terminal_phase"]="empty_memory_guard"
        with self.assertRaises(ValueError):
            contract.check_case_record(spec,record)
        record=self.case_record(spec);record["facts"]["failed_statement"]="assert _N == 0"
        with self.assertRaises(ValueError):
            contract.check_case_record(spec,record)

    def test_all_explicit_empty_and_primary_counts_are_required(self):
        cases={s["case_id"]:s for s in self.binding["artificial_cases"]}
        self.assertIn("empty.regular_n",cases["A3"]["expected_facts"])
        self.assertEqual(cases["A3"]["expected_facts"]["empty.regular_n"],0)
        self.assertEqual(cases["A3"]["expected_facts"]["empty.sentinel_n"],0)
        for key in ("remittance_binary_n","empty.domestic_n","empty.users_n","empty.bins_n"):
            self.assertIn(key,cases["A4"]["expected_facts"])

    def test_five_cases_require_independent_empty_runtime_admission(self):
        self.assertEqual(self.binding.get("artificial_case_isolation"),"FRESH_EMPTY_OWNED_RUNTIME_PER_CASE")
        spec=self.binding["artificial_cases"][0]
        record=self.case_record(spec)
        self.assertIn("admission",record)
        for admission in ({"observed_n":1,"observed_k":0,"fresh_owned_runtime":True},{"observed_n":0,"observed_k":1,"fresh_owned_runtime":True},{"observed_n":0,"observed_k":0,"fresh_owned_runtime":False}):
            record=self.case_record(spec);record["admission"]=admission
            with self.assertRaises(ValueError):
                contract.check_case_record(spec,record)

    def test_preserved_original_and_predecessor_sources(self):
        payload=(HERE/"source_pins.json").read_bytes()
        self.assertEqual(hashlib.sha256(payload).hexdigest(),"c9d386319c8485d14ac8e217d5fa8e49a0227288bb2f68c10aa03dc1f9601ae4")
        pins=json.loads(payload)
        self.assertEqual(len(pins["files"]),176)
        self.assertEqual(len({r["path"] for r in pins["files"]}),176)
        for row in pins["files"]:
            relative=Path(row["path"])
            self.assertFalse(relative.is_absolute() or ".." in relative.parts)
            path=(ROOT/relative).resolve()
            self.assertTrue(path.is_relative_to(ROOT))
            self.assertIn(path.suffix.lower(),{".do",".py",".md",".json",".csv",".txt",".tex"})
            self.assertEqual(path.stat().st_size,row["bytes"],row["path"])
            self.assertEqual(contract.sha(path.read_bytes()),row["sha256"],row["path"])

    def test_status_does_not_adopt_or_activate_the_proposal(self):
        status=json.loads((HERE/"STATUS.json").read_text(encoding="utf-8"))
        self.assertEqual(status["appendix_c2"],"HOLD")
        self.assertEqual(status["native_result"],"NOT_RUN")
        for key in ("actual_stata_calls","actual_participant_loads"):
            self.assertIs(type(status[key]),int)
            self.assertEqual(status[key],0)
        for key in ("activation_authorized","dispatcher_installed","reader_installed",
                    "unheld_source_files_written","output_root_provisioned",
                    "scientific_adoption","release","service_or_settings_changes"):
            self.assertIs(status[key],False)
        self.assertEqual(status["real_native_log_extraction"],"UNQUALIFIED")
        self.assertEqual(status["independent_native_provenance"],"UNQUALIFIED")


if __name__ == "__main__":
    unittest.main(verbosity=2)
