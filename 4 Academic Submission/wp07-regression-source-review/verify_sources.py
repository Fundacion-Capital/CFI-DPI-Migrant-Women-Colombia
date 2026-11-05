"""Static source audit only. Never imports Stata or opens a participant file."""
import hashlib
import csv
import json
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PACKAGE = Path(__file__).resolve().parent
SOURCE = ROOT / "1 Code/2 Analysis_CFI DPI Migrant Women Colombia.do"
DRAFTS = ROOT / "1 Code/wp07-regression-v1"
BLOCKS = [
    ("01 Historical regression setup.do", 1112, 1236),
    ("02 Historical main regressions.do", 1248, 1693),
    ("03 Historical interactions.do", 1705, 1826),
    ("04 Historical supplementary regressions.do", 1839, 1895),
]
MACROS = {
    "demo_controls": "i.age_cat i.q3",
    "block_B": "c.ivs_score c.iat_score c.iadt_score c.icdp_score",
    "block_C": "c.iaff_score c.oqi_score_01",
    "block_D": "c.IEDF c.IEH",
}


def commands(text):
    """Join the reviewed syntax; not a general Stata parser."""
    result = []
    pending = ""
    for line in text.splitlines():
        line = line.strip()
        if not line or line.startswith(("*", "//")) or line in ("{", "}"):
            continue
        if "///" in line:
            pending += line.split("///", 1)[0].strip() + " "
            continue
        line = pending + line
        pending = ""
        for name, value in MACROS.items():
            line = re.sub(r"\$" + name + r"\b", value, line)
        line = re.sub(r"^reg ", "regress ", line)
        result.append(re.sub(r"\s+", " ", line).strip())
    if pending:
        raise ValueError("Unfinished continuation")
    return result


def expected_commands(first, last):
    lines = SOURCE.read_text(encoding="utf-8-sig").splitlines()
    return [
        cmd for cmd in commands("\n".join(lines[first - 1:last]))
        if not cmd.startswith(("global ", "local blue ", "local orange ",
                               "local gray ", "local green "))
    ]


class SourceAudit(unittest.TestCase):
    def test_originals_and_predecessors_unchanged(self):
        for item in json.loads((PACKAGE / "source_pins.json").read_text(encoding="utf-8"))["files"]:
            with self.subTest(path=item["path"]):
                self.assertEqual(hashlib.sha256((ROOT / item["path"]).read_bytes()).hexdigest(),
                                 item["sha256"])

    def test_every_revised_body_preserves_full_command_order(self):
        for name, first, last in BLOCKS:
            with self.subTest(block=name):
                path = DRAFTS / name
                self.assertTrue(path.is_file(), f"Missing review draft: {name}")
                text = path.read_text(encoding="utf-8")
                preamble, body = text.split("* BEGIN HISTORICAL COMMAND BODY\n", 1)
                self.assertEqual(commands(preamble)[0], "exit 198")
                self.assertEqual(commands(body), expected_commands(first, last))
                self.assertNotRegex(text, r"\$(demo_controls|block_[BCD])\b")
                self.assertNotRegex(text, r"(?m)^\s*(use|import|save|export|shell|python|gsem|program|do|include)\b")

    def test_finite_fit_and_reporting_inventory(self):
        all_commands = []
        for name, _, _ in BLOCKS:
            all_commands.extend(commands((DRAFTS / name).read_text(encoding="utf-8")))
        self.assertEqual(sum(c.startswith(("regress ", "logit ")) for c in all_commands), 56)
        self.assertEqual(sum(c.startswith("margins,") for c in all_commands), 5)
        self.assertEqual(sum(c.startswith("outreg2 ") for c in all_commands), 47)
        self.assertEqual(sum(c.startswith("graph export ") for c in all_commands), 13)

    def test_known_non_equivalences_remain_visible(self):
        main = commands((DRAFTS / BLOCKS[1][0]).read_text(encoding="utf-8"))
        raw = next(c for c in main if c.startswith("regress iurd_score_01 ") and "c.IEH" in c)
        standardized = next(c for c in main if c.startswith("regress z_iurd "))
        self.assertIn("c.iadt_score", raw)
        self.assertNotIn("c.z_iadt", standardized)
        self.assertIn("margins, dydx(z_iat z_icdp z_iaff z_oqi z_ivs z_iedf z_ieh) post", main)
        interactions = commands((DRAFTS / BLOCKS[2][0]).read_text(encoding="utf-8"))
        self.assertIn("margins, at(IEDF=(0(10)100) ICPF=(25 50 75))", interactions)
        setup = commands((DRAFTS / BLOCKS[0][0]).read_text(encoding="utf-8"))
        self.assertIn("replace q3 = 1 if q3 == 5", setup)
        self.assertIn("replace high_autonomy = 1 if IAER >= 85 & IAER < .", setup)
        self.assertIn("replace high_autonomy = 0 if IAER < 85", setup)

    def test_static_reader_handles_current_syntax_and_detects_drift(self):
        self.assertEqual(commands("reg y $demo_controls ///\n c.x, vce(robust)"),
                         ["regress y i.age_cat i.q3 c.x, vce(robust)"])
        with self.assertRaises(ValueError):
            commands("reg y x ///")
        source = commands("logit y i.age_cat i.q3 c.x, vce(robust)")
        self.assertNotEqual(source, commands("logit y i.age_cat i.q3 c.x, vce(cluster q3)"))
        self.assertNotEqual(source, commands("logit y i.age_cat i.q3, vce(robust)"))
        self.assertNotEqual(commands("margins, dydx(x) post"), commands("margins, dydx(x)"))

    def test_archived_aggregate_targets_unchanged(self):
        pins = json.loads((PACKAGE / "target_pins.json").read_text(encoding="utf-8"))
        self.assertEqual(len(pins), 35)
        for item in pins:
            with self.subTest(target=item["path"]):
                path = ROOT / item["path"]
                self.assertEqual(path.stat().st_size, item["bytes"])
                self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(), item["sha256"])

    def test_model_register_matches_56_actual_source_commands(self):
        with (PACKAGE / "MODEL_REGISTER.csv").open(encoding="utf-8", newline="") as handle:
            rows = list(csv.DictReader(handle))
        self.assertEqual(len(rows), 56)
        self.assertEqual(len({r["id"] for r in rows}), 56)
        observed = []
        for name, _, _ in BLOCKS:
            observed.extend(c for c in commands((DRAFTS / name).read_text(encoding="utf-8"))
                            if c.startswith(("regress ", "logit ")))
        self.assertEqual([r["command"] for r in rows], observed)
        self.assertEqual([r["id"] for r in rows[:5]], ["iurd_A", "iurd_B", "iurd_C", "iurd_D", "iurd_D_z"])
        self.assertEqual([r["id"] for r in rows[45:]], ["I1", "I2", "I3", "I4", "S1", "S2", "S3", "S4", "S5", "S6", "S7"])
        self.assertEqual(sum(bool(r["archived_numeric_target"]) for r in rows), 47)
        self.assertEqual(sum(bool(r["displayed_figure"]) for r in rows), 13)
        self.assertEqual(sum(bool(r["margins_command"]) for r in rows), 5)
        source_lines = SOURCE.read_text(encoding="utf-8-sig").splitlines()
        for row in rows:
            self.assertEqual(commands("\n".join(source_lines[int(row["source_first"]) - 1:int(row["source_last"])])),
                             [row["command"]])
            expected_fields = set(re.findall(r"[A-Za-z_][A-Za-z_0-9]*", row["command"].split(",", 1)[0])) - {"regress", "logit", "i", "c"}
            self.assertEqual(set(row["required_model_fields"].split()), expected_fields)
            if row["archived_numeric_target"]:
                target = ROOT / row["archived_numeric_target"]
                self.assertTrue(target.is_file())
                headers = target.read_text(encoding="utf-8-sig").splitlines()[1].split("\t")[1:]
                self.assertIn(row["displayed_column"], headers)

    def test_preambles_only_add_disabled_schema_checks_and_local_palette(self):
        for name, _, _ in BLOCKS:
            text = (DRAFTS / name).read_text(encoding="utf-8")
            preamble, body = text.split("* BEGIN HISTORICAL COMMAND BODY\n", 1)
            before = commands(preamble)
            self.assertEqual(before[:3], ["exit 198", "version 19", "set varabbrev off"])
            self.assertTrue(before[3].startswith("confirm numeric variable "))
            self.assertTrue(before[3].endswith(", exact"))
            palette = ['local blue "58 103 177"', 'local orange "245 130 48"', 'local gray "167 169 172"']
            self.assertEqual(before[4:], palette if name.startswith(("02", "03")) else [])
            required = set(before[3].removeprefix("confirm numeric variable ").removesuffix(", exact").split())
            for cmd in commands(body):
                if cmd.startswith(("regress ", "logit ")):
                    model_fields = set(re.findall(r"[A-Za-z_][A-Za-z_0-9]*", cmd.split(",", 1)[0])) - {"regress", "logit", "i", "c"}
                    self.assertFalse(model_fields - required, (name, model_fields - required))


if __name__ == "__main__":
    unittest.main(verbosity=2)
