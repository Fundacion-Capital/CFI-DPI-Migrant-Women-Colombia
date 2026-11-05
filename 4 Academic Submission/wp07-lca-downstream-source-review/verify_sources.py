"""File-only historical LCA review checks; no Stata imports or participant files."""
import csv
import hashlib
import json
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
SOURCE = ROOT / "1 Code/2 Analysis_CFI DPI Migrant Women Colombia.do"
DRAFT = ROOT / "1 Code/wp07-lca-downstream-v1/01 Historical LCA and downstream.do"
FIRST, LAST = 1900, 19300


def readable_alias(line):
    return re.sub(r"^(\s*(?:(?:capture|cap|quietly|qui|noisily|noi)\s+)*)reg(?=\s)",
                  r"\1regress", line)


def retained_lines(text, revised=False):
    """Keep every nonblank source line, including delimiters and literal strings."""
    result = []
    for line in text.splitlines():
        if revised and line.startswith("* WP07-"):
            continue
        if line.strip():
            result.append(readable_alias(line).rstrip())
    return result


def literal_gsem_sites(lines, source_first):
    sites = []
    for index, line in enumerate(lines):
        if re.match(r"^\s*(?:(?:capture|cap|noisily|quietly|qui)\s+)*gsem(?:\s|$)", line):
            sites.append(source_first + index)
    return sites


class SourceReview(unittest.TestCase):
    def test_preservation(self):
        pins = json.loads((HERE / "source_pins.json").read_text(encoding="utf-8"))
        for row in pins["files"]:
            with self.subTest(path=row["path"]):
                file = ROOT / row["path"]
                self.assertEqual(file.stat().st_size, row["bytes"])
                self.assertEqual(hashlib.sha256(file.read_bytes()).hexdigest(), row["sha256"])
        for row in json.loads((HERE / "supporting_pins.json").read_text(encoding="utf-8")):
            with self.subTest(supporting=row["path"]):
                file = ROOT / row["path"]
                self.assertEqual(file.stat().st_size, row["bytes"])
                self.assertEqual(hashlib.sha256(file.read_bytes()).hexdigest(), row["sha256"])

    def test_entire_review_body_preserves_all_source_lines(self):
        self.assertTrue(DRAFT.is_file(), "Missing disabled LCA/downstream review copy")
        preamble, body = DRAFT.read_text(encoding="utf-8").split("* BEGIN HISTORICAL SOURCE BODY\n", 1)
        executable = [s.strip() for s in preamble.splitlines()
                      if s.strip() and not s.lstrip().startswith("*")]
        self.assertEqual(executable, ["exit 198"])
        source = SOURCE.read_text(encoding="utf-8-sig").splitlines()[FIRST - 1:LAST]
        revisions = json.loads((HERE / "COMMENT_REVISIONS.json").read_text(encoding="utf-8"))
        for row in revisions:
            index = row["source_line"] - FIRST
            self.assertEqual(source[index], row["before"])
            source[index] = row["after"]
        self.assertEqual(retained_lines(body, revised=True), retained_lines("\n".join(source)))

    def test_candidate_catalogue_source_windows_and_distinct_final(self):
        with (HERE / "CANDIDATES.csv").open(encoding="utf-8", newline="") as handle:
            rows = list(csv.DictReader(handle))
        self.assertEqual(len(rows), 33)
        expected_ids = [f"{family}_k{k}" for family in ("M1","M2","M3","M4","H1","H2","H3","H4")
                        for k in (2,3,4,5)] + ["preferred_final_H1_k4"]
        self.assertEqual([r["model_id"] for r in rows], expected_ids)
        source = SOURCE.read_text(encoding="utf-8-sig").splitlines()
        self.assertEqual([int(r["source_start"]) for r in rows], literal_gsem_sites(source[FIRST-1:LAST], FIRST))
        for row in rows:
            start, end = int(row["source_start"]), int(row["source_end"])
            command = " ".join(s.split("///", 1)[0].strip() for s in source[start-1:end])
            self.assertEqual(re.sub(r"\s+", " ", command), row["command"])
            self.assertEqual(re.search(r"lclass\(C\s+(\d+)\)", command).group(1), row["k"])
            self.assertEqual(re.search(r"draws\((\d+)\)", command).group(1), row["draws"])
            self.assertEqual(re.search(r"iterate\((\d+)\)", command).group(1), row["iterations"])
        final = rows[-1]
        self.assertEqual((final["k"], final["seed"], final["draws"], final["iterations"]),
                         ("4", "6529004", "600", "8000"))
        self.assertEqual(final["inputs"], "h_ivs3 h_icdp3 h_iaff3 h_iuof3 h_oqi3 h_iurd3 h_iedf2")
        self.assertEqual(final["role"], "distinct sorted preferred-final refit; not the grid H1_k4")

    def test_stage_register_contiguous_and_no_scope_gap(self):
        with (HERE / "STAGES.csv").open(encoding="utf-8", newline="") as handle:
            rows = list(csv.DictReader(handle))
        self.assertEqual(int(rows[0]["source_start"]), FIRST)
        self.assertEqual(int(rows[-1]["source_end"]), LAST)
        for left, right in zip(rows, rows[1:]):
            self.assertEqual(int(left["source_end"]) + 1, int(right["source_start"]))
        text = DRAFT.read_text(encoding="utf-8").splitlines()
        source = SOURCE.read_text(encoding="utf-8-sig").splitlines()
        for row in rows:
            begin, end = int(row["source_start"]), int(row["source_end"])
            actual = "\n".join(source[begin - 1:end])
            self.assertEqual(hashlib.sha256(actual.encode()).hexdigest(), row["source_text_sha256"])
            self.assertIn(f"* WP07-STAGE {row['stage']} | source {begin}-{end}", text)

    def test_existing_downstream_88_slots_not_reauthorized(self):
        with (ROOT / "4 Academic Submission/wp03-preflight/expanded_operations.csv").open(encoding="utf-8-sig", newline="") as handle:
            rows = list(csv.DictReader(handle))
        self.assertEqual(len(rows), 88)
        self.assertTrue(all(r["authorized_now"] == "0" for r in rows))
        self.assertEqual(sum(r["legacy_fallback"] == "True" for r in rows), 2)
        self.assertEqual(sum(r["kind"] == "anova" for r in rows), 35)

    def test_line_drift_detection_including_macro_quotes_and_seed(self):
        self.assertEqual(retained_lines("reg y x\n"), ["regress y x"])
        for a, b in [
            ("set seed 6529004", "set seed 6529005"),
            ("local N = r(N)", "local N = r(mean)"),
            ("replace segment = 2 if raw_lca_class == 4", "replace segment = 2 if raw_lca_class == 2"),
            ('label var x "two  spaces"', 'label var x "two spaces"'),
            ("#delimit ;", "#delimit cr"),
        ]:
            self.assertNotEqual(retained_lines(a), retained_lines(b))
        self.assertEqual(retained_lines("* WP07-NOTE example\nset seed 7", True), ["set seed 7"])

    def test_comment_revisions_are_not_executable_changes(self):
        source = SOURCE.read_text(encoding="utf-8-sig").splitlines()
        revisions = json.loads((HERE / "COMMENT_REVISIONS.json").read_text(encoding="utf-8"))
        self.assertEqual(len(revisions), 19)
        comment_lines = set()
        block = False
        for index, line in enumerate(source, 1):
            if line.lstrip().startswith("/*"):
                block = True
            if block or line.lstrip().startswith("*"):
                comment_lines.add(index)
            if block and "*/" in line:
                block = False
        for row in revisions:
            self.assertIn(row["source_line"], comment_lines)
            self.assertEqual(source[row["source_line"]-1], row["before"])

    def test_dataflow_register_references_source_not_live_data(self):
        source = SOURCE.read_text(encoding="utf-8-sig").splitlines()
        with (HERE / "DATAFLOW.csv").open(encoding="utf-8", newline="") as handle:
            rows = list(csv.DictReader(handle))
        self.assertEqual(len(rows), 325)
        self.assertEqual(sum(r["direction"] == "read" for r in rows), 128)
        for row in rows:
            start, end = int(row["source_start"]), int(row["source_end"])
            self.assertGreaterEqual(start, FIRST)
            self.assertLessEqual(end, LAST)
            expected = " ".join(s.split("///", 1)[0].strip() for s in source[start-1:end])
            self.assertEqual(re.sub(r"\s+", " ", expected), row["command"])
        self.assertTrue(any("Data_with_Final_Segments" in r["command"] and r["direction"] == "write" for r in rows))

    def test_alias_and_removal_source_bindings(self):
        source = SOURCE.read_text(encoding="utf-8-sig").splitlines()
        with (HERE / "ALIAS_LINEAGE.csv").open(encoding="utf-8", newline="") as handle:
            aliases = list(csv.DictReader(handle))
        self.assertEqual((len(aliases), len({r["alias"] for r in aliases})), (64, 26))
        for row in aliases:
            self.assertEqual(source[int(row["source_line"])-1], row["source_line_text"])
        training = [r["source_line_text"] for r in aliases if r["alias"] == "recent_training_12m"]
        self.assertTrue(any("q10_10" in line for line in training))
        self.assertFalse(any("q10_11" in line for line in training))
        with (HERE / "REMOVAL_SITES.csv").open(encoding="utf-8", newline="") as handle:
            removals = list(csv.DictReader(handle))
        self.assertEqual(len(removals), 14)
        for row in removals:
            start, end = int(row["source_start"]), int(row["source_end"])
            command = " ".join(s.split("///", 1)[0].strip() for s in source[start-1:end])
            self.assertEqual(re.sub(r"\s+", " ", command), row["command"])
            self.assertRegex(row["command"], r"^(capture )?erase ")


if __name__ == "__main__":
    unittest.main(verbosity=2)
