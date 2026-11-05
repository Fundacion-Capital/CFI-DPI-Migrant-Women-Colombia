"""Documentary-map checks only. No Stata imports, launches or participant reads."""
import copy
import csv
import hashlib
import json
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
PREVIOUS = ROOT / "4 Academic Submission/wp07-lca-downstream-source-review"


def table(path):
    with path.open(encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle))


def validate(stages, operations, decisions, wave, state):
    old_stages = table(PREVIOUS / "STAGES.csv")
    expected_stages = {r["stage"] for r in old_stages}
    if len(stages) != 16 or {r["stage"] for r in stages} != expected_stages:
        raise ValueError("Stage coverage mismatch")
    for row, old in zip(stages, old_stages):
        if (row["stage"], row["source_start"], row["source_end"]) != (old["stage"], old["source_start"], old["source_end"]):
            raise ValueError("Stage source identity mismatch")
    old_candidates = table(PREVIOUS / "CANDIDATES.csv")
    old_operations = table(ROOT / "4 Academic Submission/wp03-preflight/expanded_operations.csv")
    expected_ids = {"grid::" + r["model_id"] for r in old_candidates if r["model_id"] != "preferred_final_H1_k4"}
    expected_ids |= {"legacy::" + r["operation_id"] for r in old_operations}
    if len(operations) != 120 or len({r["operation_id"] for r in operations}) != 120 or {r["operation_id"] for r in operations} != expected_ids:
        raise ValueError("Operation coverage or preferred-final double count")
    for row in stages + operations:
        if row["authorized_now"] != "0":
            raise ValueError("Execution authority escalation")
        if row["owner_adopted_new_recipe"] != "false":
            raise ValueError("Unsupported scientific adoption")
        if row["disposition"] not in state["disposition_vocabulary"]:
            raise ValueError("Unknown disposition")
    if len(decisions) != 5 or {r["decision_id"] for r in decisions} != {"ML01","ML02","ML03","ML04","ML05"}:
        raise ValueError("Scientific decision coverage")
    if any(r["owner_choice"] or r["status"] != "PENDING_OWNER_CHOICE" for r in decisions):
        raise ValueError("Assumed owner decision")
    if any(state[key] for key in ("execution_authorized", "participant_processing_authorized", "fitting_authorized", "scientific_adoption", "release_authorized")):
        raise ValueError("Top-level authority escalation")
    if any(state[key] is not None for key in ("academic_lca_family", "academic_class_count", "new_fit_budget", "probability_tolerance", "minimum_class_size", "entropy_threshold", "uncertainty_method")):
        raise ValueError("Unapproved scientific setting")
    if [r["id"] for r in wave] != ["V00","V01","V02","V03","V04","V05"]:
        raise ValueError("No-fit sequence mismatch")
    if any(r["current_authority"] != "0" or r["fits_permitted"] != "0" or r["new_scores_permitted"] != "false" for r in wave):
        raise ValueError("No-fit scope escalation")
    if any(r["status"] != "PLANNED_NOT_EXECUTED" for r in wave):
        raise ValueError("Invented verification result")
    posterior = next(r for r in wave if r["id"] == "V04")
    if posterior["requires_separate_participant_scope"] != "true":
        raise ValueError("Posterior inspection folded into TARGET33")
    if state["appendix_c2"] != "HOLD" or state["retirement_means_deletion"]:
        raise ValueError("Retirement/Appendix boundary changed")


class MapChecks(unittest.TestCase):
    def load_maps(self):
        return (table(HERE / "STAGE_MAP.csv"), table(HERE / "OPERATION_MAP.csv"),
                table(HERE / "DECISIONS.csv"), table(HERE / "NOFIT_WAVE.csv"),
                json.loads((HERE / "map_state.json").read_text(encoding="utf-8")))

    def test_complete_documentary_map(self):
        self.assertTrue((HERE / "map_state.json").is_file(), "Replacement map not yet created")
        validate(*self.load_maps())

    def test_originals_and_predecessors_preserved(self):
        manifest = (HERE / "source_pins.json").read_bytes()
        self.assertEqual(hashlib.sha256(manifest).hexdigest(), "955d0b12782f5ce86c2ba47e654811ddb4c22dafacaf8abbf12fc10d763d4248")
        pins = json.loads(manifest)
        self.assertEqual(len(pins["files"]), 81)
        self.assertEqual(len({r["path"] for r in pins["files"]}), 81)
        for row in pins["files"]:
            with self.subTest(path=row["path"]):
                relative = Path(row["path"])
                self.assertFalse(relative.is_absolute() or ".." in relative.parts)
                path = (ROOT / relative).resolve()
                self.assertTrue(path.is_relative_to(ROOT))
                self.assertIn(path.suffix.lower(), {".do", ".md", ".tex", ".csv", ".json", ".py", ".txt"})
                self.assertEqual(path.stat().st_size, row["bytes"])
                self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(), row["sha256"])

    def test_reject_missing_duplicate_and_extra_operations(self):
        maps = self.load_maps()
        extra = copy.deepcopy(maps[1])
        extra[-1]["operation_id"] = "legacy::unapproved_extra_slot"
        for changed in (maps[1][:-1], maps[1] + [maps[1][0]], extra):
            candidate = copy.deepcopy(maps)
            candidate = list(candidate)
            candidate[1] = changed
            with self.assertRaises(ValueError):
                validate(*candidate)

    def test_reject_unauthorized_fit_adoption_and_class_count(self):
        maps = self.load_maps()
        for key, value in (("fitting_authorized", True), ("scientific_adoption", True), ("academic_class_count", 4)):
            candidate = list(copy.deepcopy(maps))
            candidate[4][key] = value
            with self.assertRaises(ValueError):
                validate(*candidate)
        candidate = list(copy.deepcopy(maps))
        candidate[1][0]["authorized_now"] = "1"
        with self.assertRaises(ValueError):
            validate(*candidate)

    def test_reject_new_score_permission(self):
        candidate = list(copy.deepcopy(self.load_maps()))
        candidate[3][0]["new_scores_permitted"] = "true"
        with self.assertRaises(ValueError):
            validate(*candidate)

    def test_reject_assumed_decision_or_posterior_scope(self):
        maps = self.load_maps()
        candidate = list(copy.deepcopy(maps))
        candidate[2][0]["owner_choice"] = "retain H1 k4"
        with self.assertRaises(ValueError):
            validate(*candidate)
        candidate = list(copy.deepcopy(maps))
        next(r for r in candidate[3] if r["id"] == "V04")["requires_separate_participant_scope"] = "false"
        with self.assertRaises(ValueError):
            validate(*candidate)

    def test_inherited_projection_not_expanded(self):
        fields = table(ROOT / "4 Academic Submission/wp06-academic-specification/field_allowlist.csv")
        self.assertEqual(len(fields), 163)
        self.assertEqual(len({r["field"] for r in fields}), 163)
        self.assertTrue(all(r["output_values_permitted"] == "false" for r in fields))
        self.assertFalse(any(p.suffix.lower() == ".do" for p in HERE.iterdir() if p.is_file()))

    def test_every_substantive_domain_has_a_destination(self):
        rows = table(HERE / "DOMAIN_DESTINATIONS.csv")
        constructs = {"IAT","IVS","IADT","ICDP","IAFF","IUOF","OQI","IURD","IETR","IPCS","IEDF","IAER","ICPF","IEH","IBPD"}
        self.assertEqual(len(rows), 15)
        self.assertEqual({r["construct"] for r in rows}, constructs)
        self.assertTrue(all(r["academic_destination"] and r["representation"] and r["limit"] for r in rows))
        self.assertTrue(all(r["scientific_output_generated"] == "false" for r in rows))

    def test_operation_source_locations_and_retirement_meaning(self):
        rows = table(HERE / "OPERATION_MAP.csv")
        sources = {"grid::" + r["model_id"]: r for r in table(PREVIOUS / "CANDIDATES.csv") if r["model_id"] != "preferred_final_H1_k4"}
        sources.update({"legacy::" + r["operation_id"]: r for r in table(ROOT / "4 Academic Submission/wp03-preflight/expanded_operations.csv")})
        for row in rows:
            original = sources[row["operation_id"]]
            self.assertEqual((row["source_start"], row["source_end"]), (original["source_start"], original["source_end"]))
        self.assertEqual(sum(r["disposition"] == "RETIRE_LEGACY_RETRY" for r in rows), 2)
        self.assertEqual(sum(r["stage"] == "preferred_final" for r in rows), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
