"""Only source bytes and artificial in-memory receipts; never Stata or data."""
import copy
from dataclasses import replace
import importlib.util
import json
from pathlib import Path
import sys
import unittest
from unittest.mock import patch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


class SuccessorChecks(unittest.TestCase):
    def module(self):
        path = HERE / "successor.py"
        self.assertTrue(path.is_file(), "Disabled successor is not implemented")
        if "_wp07_disabled_successor" not in sys.modules:
            spec = importlib.util.spec_from_file_location("_wp07_disabled_successor", path)
            module = importlib.util.module_from_spec(spec)
            sys.modules[spec.name] = module
            spec.loader.exec_module(module)
        return sys.modules["_wp07_disabled_successor"]

    def test_exact_preparation_and_single_use_same_buffer_handoff(self):
        m = self.module()
        prepared = m.prepare("aggregate")
        self.assertEqual(tuple(s.id for s in prepared.steps), ("P1", "P2", "P3", "P4"))
        self.assertEqual(len(prepared.steps[1].body), 952843)
        self.assertEqual(prepared.steps[1].sha256, "caf58c6d7f0564f75adde9371f3a1f47655c20e05a24362b98205136b6ca4354")
        self.assertEqual(len(prepared.steps[1].outputs[0].rows), 4129)
        fixture = m.FixedFileFixture(prepared)
        reference = fixture.reserve()
        self.assertLess(len(reference), 8192)
        self.assertNotIn(b"quietly", reference)
        self.assertNotIn(b"path", reference)
        receipt = fixture.select(reference, 45)
        self.assertEqual(receipt["step"], "P1")
        self.assertIs(fixture.handed_buffers[0], prepared.steps[0].body)
        with self.assertRaises(ValueError):
            fixture.select(reference, 45)
        self.assertTrue(fixture.closed)

    def test_forged_payload_or_order_is_rejected_before_selection(self):
        m = self.module()
        prepared = m.prepare("aggregate")
        bad_step = replace(prepared.steps[1], body=prepared.steps[1].body + b"\n")
        for steps in ((prepared.steps[1], prepared.steps[0], *prepared.steps[2:]),
                      (prepared.steps[0], bad_step, *prepared.steps[2:])):
            with self.assertRaises(ValueError):
                m.FixedFileFixture(replace(prepared, steps=steps))

    def test_invalid_reference_closes_fake_channel(self):
        m = self.module()
        for invalid in (b"foreign", b"x" * 8193, "not bytes"):
            fixture = m.FixedFileFixture(m.prepare("aggregate"))
            fixture.reserve()
            with self.assertRaises(ValueError):
                fixture.select(invalid, 45)
            self.assertTrue(fixture.closed)
            self.assertEqual(fixture.handed_buffers, [])

    def test_track_is_fixed_and_case_payloads_remain_separate(self):
        m = self.module()
        with self.assertRaises(ValueError):
            m.prepare("live")
        cases = m.prepare("cases")
        self.assertEqual(tuple(s.id for s in cases.steps), ("A1", "A2", "A3", "A4", "A5"))
        self.assertEqual(tuple(len(s.body) for s in cases.steps), (21846, 15113, 36450, 42144, 440))
        self.assertEqual(cases.checks, ())
        self.assertTrue(all(s.outputs == () for s in cases.steps))

    def case_records(self, m):
        # Literal values checked against the preserved fixture assertions.
        facts = [
            dict(rows=30,p2_main_mismatches=0,p2_additional_mismatches=0,report_main_mismatches=0,report_additional_mismatches=0,cross_recipe_mismatches=0),
            dict(families=9,asserted_rows=48,state_mismatches=0),
            {"q3.applicable_n":2,"q3.regular_n":1,"q3.sentinel_n":0,"q3.recorded_n":1,
             "q5_13.applicable_n":5,"q5_13.regular_n":2,"q5_13.sentinel_n":1,"q5_13.recorded_n":3,"q5_13.uncertainty_n":1,
             "q4_13.applicable_n":3,"q4_13.regular_n":3,"q4_13.sentinel_n":0,"q4_13.recorded_n":3,
             "q10_2.applicable_n":5,"q10_2.regular_n":3,"q10_2.sentinel_n":1,"q10_2.recorded_n":4,"q10_2.refusal_n":1,
             "q4_13.no_account_after_selection":1,"q4_13.unselected_principal_2":1,"q10_2.main_none_additional_named":1,
             "empty.recorded_n":0,"empty.regular_n":0,"empty.sentinel_n":0,"empty.percentage_values_emitted":0},
            {"own_n.wp07_ivs_educ":3,"own_n.wp07_iat3":3,"own_n.wp07_iadt2":3,"own_n.wp07_iadt3":2,
             "own_n.wp07_icdp2":2,"own_n.wp07_iaff2":2,"own_n.wp07_iuof3":2,"own_n.wp07_iuof3_oldmap":2,
             "own_n.wp07_iuof2_no_frequency":3,"own_n.wp07_oqi2":3,"own_n.wp07_oqi2_oldmap":2,
             "common_n.IADT_TWO_VS_THREE":2,"common_n.IUOF_FREQUENCY_DEFINITIONS":2,"common_n.OQI_EASE_SPACING":2,
             "iat_summary_without_components":1,"remittance_n":3,"remittance_binary_n":3,"domestic_n":4,"users_n":3,
             "bins_n":1,"uncertain_bins_n":1,"missing_bins_n":1,"empty.candidate_n":0,"empty.common_n":0,
             "empty.domestic_n":0,"empty.users_n":0,"empty.bins_n":0},
            {"failed_statement":"assert missing(wp07_iat3) | inrange(wp07_iat3, 0, 1)"},
        ]
        return {s["case_id"]:dict(scope="ARTIFICIAL_CASES_ONLY",case_id=s["case_id"],source_sha256=s["as_saved_sha256"],
                 payload_sha256=s["candidate_payload_sha256"],native_return_code=9 if i==4 else 0,
                 terminal_phase="range_assertion" if i==4 else "completed_full_payload",facts=facts[i],
                 participant_loads=0,fits=0,retries=0,admission=dict(observed_n=0,observed_k=0,fresh_owned_runtime=True))
                for i,s in enumerate(m.bindings()["artificial_cases"])}

    def test_cross_fixture_reference_is_not_transferable(self):
        m=self.module(); prepared=m.prepare("aggregate")
        first=m.FixedFileFixture(prepared); second=m.FixedFileFixture(prepared)
        reference=first.reserve(); second.reserve()
        with self.assertRaises(ValueError):
            second.select(reference,45)
        self.assertTrue(second.closed)
        self.assertEqual(second.handed_buffers,[])

    def test_source_mismatch_fails_without_editing_any_original(self):
        import io
        m=self.module(); original_open=Path.open
        target=ROOT/"1 Code/wp07-p2-barrier-v1/P2 Barrier-corrected draft.do"
        def changed(path,*args,**kwargs):
            return io.BytesIO(b"changed artificial source") if path==target else original_open(path,*args,**kwargs)
        with patch.object(Path,"open",changed),self.assertRaises(ValueError):
            m.prepare("aggregate")

    def test_aggregate_dispatch_reads_all_corrected_receipts_and_closes(self):
        m=self.module(); self.assertTrue(hasattr(m,"dispatch_aggregate"),"Aggregate successor not implemented")
        prepared=m.prepare("aggregate"); fixture=m.FixedFileFixture(prepared)
        result=m.dispatch_aggregate(prepared,fixture)
        self.assertEqual(result["status"],"ARTIFICIAL_PASS")
        self.assertEqual(result["simulated_loads"],1)
        self.assertEqual(result["actual_loads"],0)
        self.assertEqual(result["actual_stata_calls"],0)
        self.assertIs(result["live_ready"],False)
        self.assertEqual(len(result["check_dispositions"]),33)
        self.assertEqual(set(result["check_dispositions"].values()),{"artificial_complete"})
        self.assertEqual(fixture.position,4)
        self.assertTrue(fixture.closed)
        self.assertEqual(fixture.aggregate.cleanup_calls,1)
        self.assertTrue(all(body is step.body for body,step in zip(fixture.handed_buffers,prepared.steps)))
        with self.assertRaises(ValueError):
            m.dispatch_aggregate(prepared,fixture)

    def test_bad_aggregate_receipt_stops_at_p2_without_retry(self):
        m=self.module(); self.assertTrue(hasattr(m,"dispatch_aggregate"))
        for fault in ("missing_row","foreign_scope","wrong_digest","nonaggregate_log","extra_output","count_not_reconciled"):
            prepared=m.prepare("aggregate"); fixture=m.FixedFileFixture(prepared,fault=fault)
            result=m.dispatch_aggregate(prepared,fixture)
            self.assertEqual(result["status"],"TECHNICAL_STOP",fault)
            self.assertEqual(fixture.position,2)
            self.assertEqual(fixture.aggregate.calls,["P1","P2"])
            self.assertEqual((fixture.aggregate.cancel_calls,fixture.aggregate.cleanup_calls),(1,1))
            self.assertEqual(result["check_dispositions"]["P3.01"],"not_executed")
            self.assertEqual(result["retries"],0)

    def test_artificial_deadline_and_cleanup_failures_do_not_pass(self):
        m=self.module(); self.assertTrue(hasattr(m,"dispatch_aggregate"))
        for options,status in ((dict(durations=(45,1,1,1)),"TECHNICAL_STOP"),
                               (dict(cleanup_ok=False),"QUARANTINED"),
                               (dict(fault="missing_row",cancel_ok=False),"QUARANTINED"),
                               (dict(cleanup_duration=30),"QUARANTINED")):
            prepared=m.prepare("aggregate"); fixture=m.FixedFileFixture(prepared,**options)
            self.assertEqual(m.dispatch_aggregate(prepared,fixture)["status"],status)
            self.assertTrue(fixture.closed)

    def test_live_or_foreign_transport_and_cross_track_are_rejected(self):
        m=self.module(); self.assertTrue(hasattr(m,"dispatch_aggregate"))
        prepared=m.prepare("aggregate")
        with self.assertRaises(ValueError):
            m.dispatch_aggregate(prepared,object())
        cases=m.prepare("cases"); fixture=m.FixedFileFixture(cases,records=self.case_records(m))
        with self.assertRaises(ValueError):
            m.dispatch_aggregate(cases,fixture)
        self.assertEqual(fixture.position,0)

    def test_cases_dispatch_all_literal_readouts_but_never_native_success(self):
        m=self.module(); self.assertTrue(hasattr(m,"dispatch_cases"),"Case successor not implemented")
        prepared=m.prepare("cases"); fixture=m.FixedFileFixture(prepared,records=self.case_records(m))
        result=m.dispatch_cases(prepared,fixture)
        self.assertEqual(result["status"],"ARTIFICIAL_METADATA_CONSISTENT_NOT_NATIVE_VERIFIED")
        self.assertEqual(set(result["case_dispositions"].values()),{"metadata_consistent"})
        self.assertEqual(result["actual_stata_calls"],0)
        self.assertEqual(result["actual_loads"],0)
        self.assertEqual(result["native_result"],"NOT_RUN")
        self.assertFalse(result["live_ready"])
        self.assertEqual(fixture.position,5)
        self.assertEqual(len({row["context"] for row in fixture.trace}),5)
        self.assertTrue(fixture.closed)

    def test_case_entry_hold_does_not_pass_and_later_cases_are_not_selected(self):
        m=self.module(); self.assertTrue(hasattr(m,"dispatch_cases"))
        records=self.case_records(m); held=records["A2"]
        held.update(payload_sha256=held["source_sha256"],native_return_code=198,terminal_phase="entry_hold",facts={})
        prepared=m.prepare("cases"); fixture=m.FixedFileFixture(prepared,records=records)
        result=m.dispatch_cases(prepared,fixture)
        self.assertEqual(result["status"],"HELD_NOT_TESTED")
        self.assertEqual(result["case_dispositions"]["A3"],"not_executed")
        self.assertEqual(fixture.position,2)

    def test_malformed_or_nonempty_case_stops_without_retry(self):
        m=self.module(); self.assertTrue(hasattr(m,"dispatch_cases"))
        for change in ("scope","fact","nonempty","range_location"):
            records=self.case_records(m); item=records["A5" if change=="range_location" else "A1"]
            if change=="scope": item["scope"]="FOREIGN"
            if change=="fact": item["facts"]["rows"]=29
            if change=="nonempty": item["admission"]["observed_k"]=1
            if change=="range_location": item["terminal_phase"]="empty_memory_guard"
            prepared=m.prepare("cases"); fixture=m.FixedFileFixture(prepared,records=records)
            result=m.dispatch_cases(prepared,fixture)
            self.assertEqual(result["status"],"TECHNICAL_STOP",change)
            self.assertEqual(fixture.position,5 if change=="range_location" else 1)
            self.assertEqual(result["retries"],0)
            self.assertTrue(fixture.closed)

    def test_missing_or_extra_case_record_rejected_before_selection(self):
        m=self.module(); self.assertTrue(hasattr(m,"dispatch_cases"))
        for extra in (False,True):
            records=self.case_records(m)
            if extra: records["A6"]={}
            else: del records["A3"]
            prepared=m.prepare("cases"); fixture=m.FixedFileFixture(prepared,records=records)
            with self.assertRaises(ValueError):
                m.dispatch_cases(prepared,fixture)
            self.assertEqual(fixture.position,0)

    def test_replaced_inner_transport_rejected_before_any_method_call(self):
        m=self.module(); prepared=m.prepare("aggregate")
        fixture=m.FixedFileFixture(prepared)
        fixture.aggregate=object()
        with self.assertRaises(ValueError):
            m.dispatch_aggregate(prepared,fixture)
        self.assertEqual(fixture.position,0)

    def test_case_track_rejects_a_four_stage_clock_budget(self):
        m=self.module(); prepared=m.prepare("cases")
        with self.assertRaises(ValueError):
            m.FixedFileFixture(prepared,records=self.case_records(m),durations=(45,45,45,45))

    def test_second_reservation_and_cross_track_descriptor_are_rejected(self):
        m=self.module(); prepared=m.prepare("aggregate")
        fixture=m.FixedFileFixture(prepared); reference=fixture.reserve()
        with self.assertRaises(ValueError): fixture.reserve()
        self.assertTrue(fixture.closed)
        cases=m.prepare("cases"); fixture=m.FixedFileFixture(cases,records=self.case_records(m))
        fixture.reserve()
        with self.assertRaises(ValueError): fixture.select(reference)
        self.assertTrue(fixture.closed)
        self.assertEqual(fixture.position,0)

    def test_fake_trace_contains_only_metadata_and_no_files_are_provisioned(self):
        m=self.module(); prepared=m.prepare("aggregate")
        fixture=m.FixedFileFixture(prepared); m.dispatch_aggregate(prepared,fixture)
        for row in fixture.trace:
            self.assertEqual(set(row),{"scope","track","stage","context","sha256","bytes"})
        self.assertFalse((HERE/"_never_provisioned_output").exists())
        self.assertFalse((HERE/"__pycache__").exists())

    def test_all_case_readout_keys_and_types_are_enforced_in_dispatch(self):
        m=self.module()
        for change in ("missing_fact","extra_fact","bool_fact","participant","retry","fit"):
            records=self.case_records(m); item=records["A1"]
            if change=="missing_fact": del item["facts"]["rows"]
            elif change=="extra_fact": item["facts"]["extra"]=0
            elif change=="bool_fact": item["facts"]["p2_main_mismatches"]=False
            elif change=="participant": item["participant_loads"]=1
            elif change=="retry": item["retries"]=1
            else: item["fits"]=1
            prepared=m.prepare("cases"); fixture=m.FixedFileFixture(prepared,records=records)
            result=m.dispatch_cases(prepared,fixture)
            self.assertEqual(result["status"],"TECHNICAL_STOP",change)
            self.assertEqual(fixture.position,1)

    def test_no_second_dispatch_after_case_metadata_pass(self):
        m=self.module(); prepared=m.prepare("cases")
        fixture=m.FixedFileFixture(prepared,records=self.case_records(m))
        m.dispatch_cases(prepared,fixture)
        with self.assertRaises(ValueError): m.dispatch_cases(prepared,fixture)
        self.assertEqual(fixture.position,5)

    def test_dispatch_never_reopens_a_prepared_stata_source(self):
        m=self.module(); original_open=Path.open
        prepared=m.prepare("aggregate"); fixture=m.FixedFileFixture(prepared)
        def forbid_reopen(path,*args,**kwargs):
            if path.suffix.lower()==".do":
                raise AssertionError("Prepared source reopened instead of checked buffer handoff")
            return original_open(path,*args,**kwargs)
        with patch.object(Path,"open",forbid_reopen):
            result=m.dispatch_aggregate(prepared,fixture)
        self.assertEqual(result["status"],"ARTIFICIAL_PASS")

    def test_all_188_preserved_source_fingerprints_match(self):
        import hashlib
        raw=(HERE/"source_pins.json").read_bytes()
        self.assertEqual(hashlib.sha256(raw).hexdigest(),"44b3474c9b7094132cea286e512ae944da74d9b7d9d530faa2a81f447e45e7fc")
        pins=json.loads(raw)
        prior=(ROOT/pins["previous_manifest"]).read_bytes()
        self.assertEqual(hashlib.sha256(prior).hexdigest(),pins["previous_manifest_sha256"])
        files=json.loads(prior)["files"]+pins["additional_files"]
        self.assertEqual(len(files),188)
        self.assertEqual(len({r["path"] for r in files}),188)
        for row in files:
            relative=Path(row["path"])
            self.assertFalse(relative.is_absolute() or ".." in relative.parts)
            path=(ROOT/relative).resolve()
            self.assertTrue(path.is_relative_to(ROOT))
            self.assertIn(path.suffix.lower(),{".do",".py",".md",".json",".csv",".txt",".tex"})
            self.assertEqual(path.stat().st_size,row["bytes"],row["path"])
            self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(),row["sha256"],row["path"])

    def test_saved_status_does_not_activate_or_qualify_native_work(self):
        status=json.loads((HERE/"STATUS.json").read_text(encoding="utf-8"))
        self.assertTrue(status["implementation_present"])
        self.assertEqual((status["appendix_c2"],status["native_result"]),("HOLD","NOT_RUN"))
        for key in ("actual_stata_calls","actual_participant_loads","actual_model_loads"):
            self.assertIs(type(status[key]),int)
            self.assertEqual(status[key],0)
        for key in ("shared_integration_installed","activation_authorized","unheld_stata_files_written",
                    "runtime_output_root_provisioned","participant_budget_adopted","artificial_case_budget_adopted",
                    "settings_or_service_changes","scientific_adoption","release"):
            self.assertIs(status[key],False)

    def test_pinned_python_imports_execute_checked_bytes_without_reopening(self):
        from importlib.machinery import SourceFileLoader
        from types import ModuleType
        module=ModuleType("_wp07_import_buffer_test")
        module.__file__=str(HERE/"successor.py")
        sys.modules[module.__name__]=module
        original=SourceFileLoader.get_code
        paths={str(ROOT/"4 Academic Submission/wp07-p2-reader-requalification/offline_contract.py"),
               str(ROOT/"4 Academic Submission/wp07-target33-offline-dispatcher/dispatcher.py")}
        def forbid_reopen(loader,name):
            if loader.path in paths:
                raise AssertionError("Pinned Python module reopened after its hash check")
            return original(loader,name)
        try:
            with patch.object(SourceFileLoader,"get_code",forbid_reopen):
                exec(compile((HERE/"successor.py").read_bytes(),module.__file__,"exec"),module.__dict__)
            self.assertEqual(len(module.prepare("cases").steps),5)
        finally:
            sys.modules.pop(module.__name__,None)

    def test_mutable_step_container_is_rejected_at_admission(self):
        m=self.module(); prepared=m.prepare("aggregate")
        with self.assertRaises(ValueError):
            m.FixedFileFixture(replace(prepared,steps=list(prepared.steps)))

    def test_record_copy_never_invokes_caller_defined_hooks(self):
        m=self.module(); prepared=m.prepare("cases"); called=[]
        class Hook:
            def __deepcopy__(self,memo):
                called.append("deepcopy")
                return self
        for value in (Hook(),{"A1":{"facts":{"unexpected":Hook()}}}):
            with self.assertRaises(ValueError):
                m.FixedFileFixture(prepared,records=value)
        self.assertEqual(called,[])

    def test_simulation_options_reject_objects_without_calling_hooks(self):
        m=self.module(); prepared=m.prepare("aggregate"); called=[]
        class Hook:
            def __eq__(self,other):
                called.append("eq"); return False
            def __iter__(self):
                called.append("iter"); return iter((1,1,1,1))
        for kwargs in (dict(fault=Hook()),dict(durations=Hook()),dict(fault="unknown_fault")):
            with self.assertRaises(ValueError):
                m.FixedFileFixture(prepared,**kwargs)
        self.assertEqual(called,[])

    def test_prepared_metadata_rejects_callback_bearing_values(self):
        m=self.module(); prepared=m.prepare("aggregate"); called=[]
        class Hook:
            def __eq__(self,other):
                called.append("eq"); return False
        mutated=(replace(prepared,track=Hook()),replace(prepared,versions=(Hook(),)),
                 replace(prepared,checks=((Hook(),"P1"),)),
                 replace(prepared,steps=(replace(prepared.steps[0],outputs=Hook()),*prepared.steps[1:])))
        for item in mutated:
            with self.assertRaises(ValueError): m.FixedFileFixture(item)
        self.assertEqual(called,[])


if __name__ == "__main__":
    unittest.main(verbosity=2)
