"""Static source/metadata checks only; never imports or invokes Stata."""
import copy
import csv
import hashlib
import json
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
CODE = ROOT / "1 Code/wp07-academic-reporting-v1"
FILES = ("01 Item and domain reports.do", "02 Prepared candidate reports.do")
DOMAINS = {"IAT","IVS","IADT","ICDP","IAFF","IUOF","OQI","IURD","IETR","IPCS","IEDF","IAER","ICPF","IEH","IBPD"}


def rows(name):
    with (HERE / name).open(encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle))


def check_boundary(text):
    logical = re.sub(r"///\s*\n\s*", " ", text)
    active = [line.strip() for line in logical.splitlines() if line.strip() and not line.lstrip().startswith("*")]
    if not active or active[0] != "exit 198":
        raise ValueError("Missing unconditional hold")
    banned = r"^(?:quietly\s+|capture\s+)?(?:use|import|export|save|keep|sort|gsort|merge|append|clear|erase|shell|python|mata|do|run|include|program|log|file|putexcel|putdocx|predict|regress|logit|gsem|cluster|correlate|pwcorr)\b"
    for line in active:
        command = re.sub(r"^quietly\s+", "", line).split()[0]
        if command not in {"exit", "version", "set", "confirm", "assert", "gen", "replace", "drop", "count", "local", "display", "if", "else", "foreach", "forvalues", "tabulate", "tabstat", "}"}:
            raise ValueError("Unreviewed command")
        if command == "if" and re.search(r"\b(?:formdef_version|eligible_flag|q\d+(?:_\d+)?|_ara?_\w+)\b", line):
            raise ValueError("Programming if cannot restrict participant rows")
        if re.search(banned, line, re.I):
            raise ValueError("Forbidden execution, data or output command")
        if command == "drop" and any(not re.fullmatch(r"_ar(?:a)?_q\d+(?:_\d+)?", name) for name in line.split()[1:]):
            raise ValueError("Drop outside reporting flags")
        if re.match(r"^(?:quietly\s+)?(?:gen(?:erate)?|replace|drop)\b", line):
            target = re.sub(r"^(?:quietly\s+)?(?:gen(?:erate)?\s+byte|replace|drop)\s+", "", line)
            if not target.startswith(("_ar_", "_ara_")):
                raise ValueError("Mutation outside local reporting flags")
        if "C2" in line and not line.startswith("display"):
            raise ValueError("Appendix C2 command")


class ReportingChecks(unittest.TestCase):
    def test_both_files_exist_and_are_disabled(self):
        for name in FILES:
            path = CODE / name
            self.assertTrue(path.is_file(), name + " not yet implemented")
            check_boundary(path.read_text(encoding="utf-8"))

    def test_all_domains_and_unique_items_have_denominators(self):
        items = rows("ITEMS.csv")
        self.assertEqual({r["domain"] for r in items}, DOMAINS)
        self.assertEqual(len(items), 93)
        self.assertEqual(len({r["field"] for r in items}), 93)
        text = (CODE / FILES[0]).read_text(encoding="utf-8")
        for item in items:
            self.assertIn("* ITEM " + item["field"] + " |", text)
            self.assertTrue(item["denominator"] and item["limit"])
            self.assertIn("drop _ar_" + item["field"] + " _ara_" + item["field"], text)

    def test_projection_and_privacy_boundaries(self):
        with (ROOT / "4 Academic Submission/wp06-academic-specification/field_allowlist.csv").open(encoding="utf-8-sig") as handle:
            allowed = {r["field"] for r in csv.DictReader(handle)}
        self.assertEqual(len(allowed), 163)
        text = (CODE / FILES[0]).read_text(encoding="utf-8")
        fields = set(re.findall(r"\bq\d+(?:_\d+)?\b", text))
        self.assertTrue(fields <= allowed)
        active = "\n".join(line for line in text.splitlines() if not line.lstrip().startswith("*"))
        self.assertNotRegex(active, r"\b(?:KEY|nombre|telefono|enumerator|_p24)\b")
        self.assertNotIn("tabulate q10_2 ", text)
        self.assertNotIn("tabulate q9_17 ", text)

    def test_barrier_option_four_is_substantive(self):
        text = (CODE / FILES[0]).read_text(encoding="utf-8")
        q1 = text.split("* ITEM q10_1 |", 1)[1].split("drop _ar_q10_1", 1)[0]
        q2 = text.split("* ITEM q10_2 |", 1)[1].split("drop _ar_q10_2", 1)[0]
        self.assertNotRegex(q1, r"replace _ar_q10_1 = 5.*q10_1 == 4")
        self.assertNotRegex(q2, r"replace _ar_q10_2 = [56].*(?:== \"4\"|\" 4 \")")
        book = rows("CODEBOOK.csv")
        for field in ("q10_1", "q10_2"):
            options = [r for r in book if r["field"] == field and r["code"] == "4"]
            self.assertEqual(len(options), 5)
            self.assertTrue(all(r["label"] == "No sé cómo usarlos" for r in options))

    def test_categories_remain_version_aware(self):
        book = rows("CODEBOOK.csv")
        def label(field, version, code):
            return next(r["label"] for r in book if r["field"] == field and r["version"] == version and r["code"] == code)
        self.assertIn("Other", label("q3", "2512090157", "4"))
        self.assertEqual(label("q3", "2512111044", "4"), "Soacha")
        self.assertIn("Otra", label("q10_2", "2512090157", "16"))
        self.assertEqual(label("q10_2", "2602120658", "16"), "Ninguna de las anteriores")
        self.assertFalse(any(r["field"] == "q10_2" and r["version"] == "2512090157" and r["code"] == "1" for r in book))

    def test_prepared_candidates_not_scored_or_substituted(self):
        contracts = rows("CANDIDATES.csv")
        self.assertEqual(len(contracts), 11)
        text = (CODE / FILES[1]).read_text(encoding="utf-8")
        self.assertNotRegex(text, r"(?m)^\s*(?:gen(?:erate)?|replace|egen)\b")
        self.assertNotIn("wp07_ivs2", text)
        self.assertNotIn("wp07_iurd", text)
        self.assertNotIn("wp07_iedf", text)
        producer = (ROOT / "1 Code/wp07-academic-preparation-v1/01 Approved preparation draft.do").read_text(encoding="utf-8")
        for row in contracts:
            for field in (row["field"] + " " + row["components"]).split():
                self.assertRegex(producer, r"\bgen (?:byte|double) " + field + r"\b")
            self.assertIn("* CANDIDATE " + row["field"], text)

    def test_version_local_rule_order_and_only_declared_changes(self):
        source = (ROOT / "4 Academic Submission/wp07-target33-selections/P2.do").read_text(encoding="utf-8")
        text = (CODE / FILES[0]).read_text(encoding="utf-8")
        versions = ("2512090157", "2512091719", "2512111044", "2512121811", "2602120658")
        for item in rows("ITEMS.csv"):
            field = item["field"]
            block = text.split("* ITEM " + field + " |", 1)[1].split("assert inrange(_ar_" + field, 1)[0]
            actual = {}
            for line in block.splitlines():
                group = re.match(r"(replace _ara?_\w+ = [0-6]) if inlist\(formdef_version, ([0-9, ]+)\) & (.*)", line)
                if group:
                    command = group[1] + " if " + group[3]
                    for version in group[2].split(", "):
                        actual.setdefault(version, []).append(command)
            for version in versions:
                expected = []
                for line in source.splitlines():
                    if not re.match(r"quietly replace _p24a?_" + field + r" = .* if formdef_version == " + version + r" & ", line):
                        continue
                    line = re.sub(r"^quietly ", "", line)
                    line = line.replace(" if formdef_version == " + version + " & ", " if ")
                    if field == "q10_1" and re.match(r"replace _p24_q10_1 = 5.*q10_1 == 4", line):
                        continue
                    if field == "q10_2" and re.match(r"replace _p24_q10_2 = [56]", line) and ('" 4 "' in line or '"4"' in line):
                        continue
                    expected.append(line.replace("_p24a_", "_ara_").replace("_p24_", "_ar_"))
                self.assertTrue(expected, field + " lacks source rules")
                self.assertEqual(actual[version], expected, field + " / " + version)

    def test_offered_options_and_empty_denominators(self):
        text = (CODE / FILES[0]).read_text(encoding="utf-8")
        book = rows("CODEBOOK.csv")
        for item in rows("ITEMS.csv"):
            if item["type"] == "numeric_context":
                continue
            field = item["field"]
            block = text.split("* ITEM " + field + " |", 1)[1].split("drop _ar_" + field, 1)[0]
            default = re.search(r'local options "([0-9 ]+)"', block)[1].split()
            overrides = dict(re.findall(r'if `fv\x27 == ([0-9]+) \{\n\s+local options "([0-9 ]+)"', block))
            for version in ("2512090157", "2512091719", "2512111044", "2512121811", "2602120658"):
                wanted = sorted([r["code"] for r in book if r["field"] == field and r["version"] == version], key=int)
                found = overrides[version].split() if version in overrides else default
                self.assertEqual(found, wanted, field + " / " + version)
            self.assertIn("if `recorded_n' == 0", block)
            self.assertIn("percentages undefined", block)
            if item["type"] == "multiple_response":
                has_98 = any(r["field"] == field and r["code"] == "98" for r in book)
                if has_98:
                    self.assertIn("if `option' == 98", block)
                    self.assertIn("Percent all recorded parents uncertain" if field == "q5_13" else "Percent all recorded parents refusing", block)
                else:
                    self.assertNotIn("if `option' == 98", block)

    def test_identity_requirement_uncertainty_is_not_refusal(self):
        text = (CODE / FILES[0]).read_text(encoding="utf-8")
        block = text.split("* ITEM q5_13 |", 1)[1].split("drop _ar_q5_13", 1)[0]
        self.assertNotIn("parents refusing", block)
        self.assertIn("q5_13 uncertainty N", block)

    def test_no_fit_or_publication_authority(self):
        state = json.loads((HERE / "STATUS.json").read_text(encoding="utf-8"))
        for key in ("execution_authorized", "participant_processing", "scoring_authorized", "fitting_authorized", "scientific_adoption", "release_authorized"):
            self.assertIs(state[key], False)
        self.assertEqual(state["appendix_c2"], "HOLD")
        self.assertEqual(state["native_validation"], "NOT_RUN")

    def test_negative_boundary_controls(self):
        with self.assertRaises(ValueError):
            check_boundary("version 16\ncount\n")
        for command in ('use "any.dta", clear', 'export delimited using "any.csv"', 'regress y x', 'replace q6_14 = 0', 'drop q6_14', 'drop _ar_q6_14 q6_14', 'egen new_score = rowmean(q6_13 q6_14)'):
            with self.subTest(command=command):
                with self.assertRaises(ValueError):
                    check_boundary("exit 198\n" + command + "\n")

    def test_reject_programming_if_on_participant_fields(self):
        with self.assertRaises(ValueError):
            check_boundary("exit 198\nif inlist(formdef_version, 2512090157) {\nreplace _ar_q3 = 1\n}\n")

    def test_main_none_additional_named_conflict_is_visible(self):
        text = (CODE / FILES[0]).read_text(encoding="utf-8")
        logical = re.sub(r"///\s*\n\s*", " ", text)
        checks = [line for line in logical.splitlines() if line.startswith("quietly count if") and "q10_1 == 16" in line and "_ar_q10_2 == 1" in line]
        self.assertEqual(len(checks), 1, "Missing cross-item semantic-review count")
        self.assertIn("2512091719, 2512111044, 2512121811, 2602120658", checks[0])
        self.assertNotIn("2512090157", checks[0])
        self.assertIn("regexm", checks[0])

    def test_principal_account_contradictions_are_visible(self):
        text = (CODE / FILES[0]).read_text(encoding="utf-8")
        logical = re.sub(r"///\s*\n\s*", " ", text)
        self.assertTrue(any("_ara_q4_13 == 1 & q4_13 == 5" in line and line.startswith("quietly count if") for line in logical.splitlines()), "Missing no-account-after-positive-selection diagnostic")
        self.assertIn("Principal product absent from selected accounts", text)
        self.assertTrue(any(line.lstrip().startswith("quietly count if _ar_q4_13 == 1 & q4_13 == `product'") and "strpos" in line for line in logical.splitlines()), "Missing selected-product mismatch diagnostic")

    def test_pinned_existing_sources_unchanged(self):
        payload = (HERE / "source_pins.json").read_bytes()
        self.assertEqual(hashlib.sha256(payload).hexdigest(), "22d6e6162ce9ec7279aac292d74e97bd069c23fd358bb6c32523355d1aa1e5f4")
        manifest = json.loads(payload)
        self.assertGreaterEqual(len(manifest["files"]), 100)
        self.assertEqual(len({r["path"] for r in manifest["files"]}), len(manifest["files"]))
        for row in manifest["files"]:
            relative = Path(row["path"])
            self.assertFalse(relative.is_absolute() or ".." in relative.parts)
            path = (ROOT / relative).resolve()
            self.assertTrue(path.is_relative_to(ROOT))
            self.assertIn(path.suffix.lower(), {".do", ".md", ".tex", ".csv", ".json", ".py", ".txt"})
            self.assertEqual(path.stat().st_size, row["bytes"], row["path"])
            self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(), row["sha256"], row["path"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
