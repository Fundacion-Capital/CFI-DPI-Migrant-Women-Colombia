"""Source and artificial-case metadata checks only. Never invokes Stata."""
import csv
import hashlib
import json
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
ORIGINAL = ROOT / "4 Academic Submission/wp07-target33-selections/P2.do"
SUCCESSOR = ROOT / "1 Code/wp07-p2-barrier-v1/P2 Barrier-corrected draft.do"
ITEMS = ROOT / "1 Code/wp07-academic-reporting-v1/01 Item and domain reports.do"
PREPARED = ROOT / "1 Code/wp07-academic-reporting-v1/02 Prepared candidate reports.do"
FIXTURE_NAMES = {"01 Barrier state cases.do", "02 Version and route cases.do", "03 Reporting denominator cases.do", "04 Prepared coverage cases.do", "05 Expected range rejection.do"}


def forbidden_barrier_line(line):
    rule = bool(re.match(r"quietly replace _p24_q10_1 = 5 .*q10_1 == 4\)", line))
    rule |= bool(re.match(r"quietly replace _p24_q10_2 = [56] ", line) and ('" 4 "' in line or '"4"' in line))
    count = bool(line.startswith("quietly count if ") and (("_p24_q10_1 == 5" in line and "q10_1 == 4)" in line) or ("_p24_q10_2 == 5" in line and 'strtrim(q10_2) == "4"' in line)))
    receipt = bool(re.search(r'"P2[.]08,q10_[12],[0-9]+,sentinel,uncertainty,', line))
    return rule or count or receipt


class SuccessorChecks(unittest.TestCase):
    def test_disabled_successor_exists(self):
        self.assertTrue(SUCCESSOR.is_file(), "P2 successor not yet implemented")
        lines = SUCCESSOR.read_text(encoding="utf-8").splitlines()
        active = [x.strip() for x in lines if x.strip() and not x.lstrip().startswith("*")]
        self.assertEqual(active[0], "exit 198")

    def test_only_documented_original_lines_removed(self):
        original = ORIGINAL.read_text(encoding="utf-8").splitlines()
        current = SUCCESSOR.read_text(encoding="utf-8").splitlines()
        start = current.index("* ORIGINAL P2 BODY BEGINS")
        expected = [line for line in original if not forbidden_barrier_line(line)]
        self.assertEqual(current[start + 1:], expected)
        self.assertEqual(sum(forbidden_barrier_line(x) for x in original), 35)
        self.assertFalse(any(forbidden_barrier_line(x) for x in current))

    def test_receipt_delta_is_explicit(self):
        delta = json.loads((HERE / "CHANGE_CONTRACT.json").read_text(encoding="utf-8"))
        self.assertEqual(delta["removed_classifier_commands"], 15)
        self.assertEqual(delta["removed_sentinel_count_commands"], 10)
        self.assertEqual(delta["removed_false_uncertainty_receipts"], 10)
        self.assertEqual(delta["output_columns_changed"], False)
        self.assertEqual(delta["dispatcher_integrated"], False)

    def test_fixture_files_are_disabled_and_empty_input_only(self):
        manifest = json.loads((HERE / "FIXTURE_MANIFEST.json").read_text(encoding="utf-8"))
        self.assertEqual(len(manifest["files"]), 5)
        expected = {"1 Code/wp07-p2-barrier-v1/artificial/" + name for name in FIXTURE_NAMES}
        self.assertEqual({r["path"] for r in manifest["files"]}, expected)
        for item in manifest["files"]:
            path = ROOT / item["path"]
            text = path.read_text(encoding="utf-8")
            active = [x.strip() for x in text.splitlines() if x.strip() and not x.lstrip().startswith("*")]
            self.assertEqual(active[0], "exit 198")
            self.assertIn("assert _N == 0", text)
            self.assertLess(text.index("assert _N == 0"), text.index("input "))
            self.assertNotRegex(text, r"(?m)^\s*(?:use|import|export|save|file|log|shell|python|mata|gsem|regress|logit|predict|do|run)\b")
            self.assertEqual(item["native_result"], "NOT_RUN")
            self.assertEqual(item["current_execution_authority"], False)

    def test_production_fragments_are_exact(self):
        fragments = json.loads((HERE / "FRAGMENTS.json").read_text(encoding="utf-8"))
        self.assertGreaterEqual(len(fragments), 10)
        for item in fragments:
            self.assertIn(item["source_path"], {str(p.relative_to(ROOT)).replace("\\", "/") for p in (SUCCESSOR, ITEMS, PREPARED)})
            self.assertIn(item["fixture_path"], {"1 Code/wp07-p2-barrier-v1/artificial/" + name for name in FIXTURE_NAMES})
            source = ROOT / item["source_path"]
            fixture = ROOT / item["fixture_path"]
            source_lines = source.read_text(encoding="utf-8").splitlines()
            if item["kind"] == "state_rules":
                expected = "\n".join(line for line in source_lines if re.match(r"(?:quietly )?(?:gen byte|replace) " + item["prefix"] + r"a?_" + item["field"] + r" = ", line))
            elif item["kind"] == "item_report":
                text = "\n".join(source_lines)
                begin = text.index("* ITEM " + item["field"] + " |")
                end_marker = "drop _ar_" + item["field"] + " _ara_" + item["field"]
                expected = text[begin:text.index(end_marker, begin) + len(end_marker)]
            else:
                text = "\n".join(source_lines)
                expected = text.split("exit 198", 1)[1].lstrip("\n")
            observed = fixture.read_text(encoding="utf-8").split("* BEGIN " + item["id"] + "\n", 1)[1].split("\n* END " + item["id"], 1)[0]
            self.assertEqual(observed, expected, item["id"])

    def test_expectations_are_literal_and_cases_unique(self):
        cases = json.loads((HERE / "ARTIFICIAL_CASES.json").read_text(encoding="utf-8"))
        self.assertGreaterEqual(len(cases["barrier_rows"]), 25)
        self.assertEqual(len({r["id"] for r in cases["barrier_rows"]}), len(cases["barrier_rows"]))
        self.assertEqual({str(r["version"]) for r in cases["barrier_rows"] if r["version"] in [2512090157,2512091719,2512111044,2512121811,2602120658]}, {"2512090157","2512091719","2512111044","2512121811","2602120658"})
        for row in cases["barrier_rows"]:
            self.assertIn(row["expected_main"], range(1,7))
            self.assertIn(row["expected_additional"], range(1,7))

    def test_held_status_not_native_success(self):
        state = json.loads((HERE / "STATUS.json").read_text(encoding="utf-8"))
        self.assertEqual(state["native_validation"], "NOT_RUN")
        self.assertEqual(state["appendix_c2"], "HOLD")
        for field in ("stata_execution", "participant_processing", "fitting", "scoring", "release", "dispatcher_integrated"):
            self.assertIs(state[field], False)

    def test_barrier_change_predicate_leaves_other_meanings_untouched(self):
        self.assertTrue(forbidden_barrier_line('quietly replace _p24_q10_1 = 5 if formdef_version == 2602120658 & _p24_q10_1 == 1 & (q10_1 == 4)'))
        self.assertFalse(forbidden_barrier_line('quietly replace _p24_q10_1 = 5 if formdef_version == 2602120658 & _p24_q10_1 == 1 & (q10_1 == 98)'))
        self.assertFalse(forbidden_barrier_line('quietly replace _p24_q10_2 = 6 if formdef_version == 2602120658 & _p24_q10_2 == 1 & (strpos(q10_2, " 16 ") > 0)'))
        self.assertFalse(forbidden_barrier_line('file write `out\x27 "P2.08,q10_10,2602120658,sentinel,uncertainty,NA," (r(N))'))

    def test_barrier_fixture_compares_both_production_recipes(self):
        text = (ROOT / "1 Code/wp07-p2-barrier-v1/artificial/01 Barrier state cases.do").read_text(encoding="utf-8")
        self.assertIn("assert _ar_q10_1 == _p24_q10_1", text)
        self.assertIn("assert _ar_q10_2 == _p24_q10_2", text)
        self.assertEqual(text.count("input str4 case_id"), 1)

    def test_existing_sources_preserved(self):
        payload = (HERE / "source_pins.json").read_bytes()
        self.assertEqual(hashlib.sha256(payload).hexdigest(), "39260b61cdce8813342eb7bd4d25dee350a7aee540b88c87ab052cc622b96e6f")
        pins = json.loads(payload)
        self.assertEqual(len(pins["files"]), 147)
        self.assertEqual(len({r["path"] for r in pins["files"]}), 147)
        for row in pins["files"]:
            relative = Path(row["path"])
            self.assertFalse(relative.is_absolute() or ".." in relative.parts)
            path = (ROOT / relative).resolve()
            self.assertTrue(path.is_relative_to(ROOT))
            self.assertIn(path.suffix.lower(), {".do", ".md", ".tex", ".csv", ".json", ".py", ".txt"})
            self.assertEqual(path.stat().st_size, row["bytes"], row["path"])
            self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(), row["sha256"], row["path"])

    def test_fixture_declares_all_production_route_inputs(self):
        fragments = json.loads((HERE / "FRAGMENTS.json").read_text(encoding="utf-8"))
        for item in fragments:
            if item["kind"] != "state_rules":
                continue
            text = (ROOT / item["fixture_path"]).read_text(encoding="utf-8")
            before, after = text.split("* BEGIN " + item["id"] + "\n", 1)
            schema = before.rsplit("\ninput ", 1)[1].split("\n", 1)[0]
            body = after.split("\n* END " + item["id"], 1)[0]
            dependencies = set(re.findall(r"\b(?:q\d+(?:_\d+)?|consent|eligible_flag|formdef_version)\b", body))
            missing = sorted(name for name in dependencies if not re.search(r"\b" + name + r"\b", schema))
            self.assertEqual(missing, [], item["id"] + " missing inputs")

    def test_literal_fixture_rows_match_the_authored_catalogue(self):
        cases = json.loads((HERE / "ARTIFICIAL_CASES.json").read_text(encoding="utf-8"))
        def literal(value):
            return "." if value is None else json.dumps(value, ensure_ascii=False) if isinstance(value, str) else str(value)
        text = (ROOT / "1 Code/wp07-p2-barrier-v1/artificial/01 Barrier state cases.do").read_text(encoding="utf-8")
        block = text.split("\ninput str4 case_id ", 1)[1].split("\nend", 1)[0].split("\n", 1)[1]
        expected = [" ".join(literal(row[key]) for key in ("id", "version", "eligible", "main", "additional", "expected_main", "expected_additional")) for row in cases["barrier_rows"]]
        self.assertEqual(block.splitlines(), expected)
        text = (ROOT / "1 Code/wp07-p2-barrier-v1/artificial/02 Version and route cases.do").read_text(encoding="utf-8")
        for row in cases["route_families"]:
            block = text.split("\ninput " + row["schema"] + "\n", 1)[1].split("\nend", 1)[0]
            self.assertEqual(block.splitlines(), [" ".join(literal(value) for value in record) for record in row["rows"]])

    def test_range_rejection_assertion_matches_production(self):
        text = (ROOT / "1 Code/wp07-p2-barrier-v1/artificial/05 Expected range rejection.do").read_text(encoding="utf-8")
        assertions = [line for line in text.splitlines() if line.startswith("assert missing(wp07_iat3)")]
        self.assertEqual(len(assertions), 1)
        self.assertIn(assertions[0], PREPARED.read_text(encoding="utf-8").splitlines())
        self.assertIn("\n1.01\nend\n", text)


if __name__ == "__main__":
    unittest.main(verbosity=2)
