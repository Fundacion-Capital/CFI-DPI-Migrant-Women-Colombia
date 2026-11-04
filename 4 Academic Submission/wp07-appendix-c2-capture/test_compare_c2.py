import importlib.util
import struct
import unittest


AXES = ("ivs_score iat_score iadt_score icdp_score iaff_score iuof_score_01 "
        "oqi_score_01 iurd_score_01 ietr_score_01 IPCS IEDF IAER ICPF IEH IBPD").split()
ONE = "3ff0000000000000"
HALF = "3fe0000000000000"
NEXT_HALF = "3fe0000000000001"


def target(pair=".5000000000000000"):
    rows = [[name, *("1" if i == j else pair for j in range(15))]
            for i, name in enumerate(AXES)]
    return ("\n".join(",".join(row) for row in [["index", *AXES], *rows]) + "\n").encode()


def capture(pair=HALF):
    return "\n".join([
        ". display \"C2|BEGIN|WP07_C2_V1\"",
        "C2|BEGIN|WP07_C2_V1", "C2|N|423|387|387",
        *(f"C2|AXIS|{i}|{name}|{name}" for i, name in enumerate(AXES, 1)),
        *(f"C2|CELL|{i}|{j}|{ONE if i == j else pair}"
          for i in range(1, 16) for j in range(1, 16)),
        "C2|END|225",
    ])


class ComparisonTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(importlib.util.find_spec("compare_c2"), "C2 reader not implemented")
        import compare_c2
        self.c2 = compare_c2

    def test_complete_and_roundtrip(self):
        result = self.c2.compare(target(), capture())
        self.assertEqual(result["complete_case_n"], 387)
        self.assertIsNone(result["archived_complete_case_n"])
        self.assertEqual(result["counts"], {"roundtrip_equal": 225, "decimal_compatible": 0, "mismatch": 0})
        self.assertEqual(len(result["cells"]), 225)

    def test_last_printed_digit_not_blanket_tolerance(self):
        self.assertEqual(self.c2.compare(target(".500000000000000"), capture(NEXT_HALF))["counts"]["decimal_compatible"], 210)
        self.assertEqual(self.c2.compare(target(), capture(NEXT_HALF))["counts"]["mismatch"], 210)

    def test_reject_native_errors_or_missing_end(self):
        for bad in (capture() + "\nr(9);", capture().replace("C2|END|225", "")):
            with self.assertRaises(ValueError):
                self.c2.compare(target(), bad)

    def test_reject_duplicate_reordered_and_nonfinite_cells(self):
        for bad in (
            capture().replace("C2|CELL|1|2|", "C2|CELL|1|1|", 1),
            capture().replace("C2|AXIS|1|ivs_score|ivs_score", "C2|AXIS|1|iat_score|ivs_score", 1),
            capture().replace(HALF, "7ff8000000000000", 1),
            capture().replace(HALF, NEXT_HALF, 1),
        ):
            with self.assertRaises(ValueError):
                self.c2.compare(target(), bad)

    def test_reject_n_disagreement_and_bad_diagonal(self):
        for bad in (
            capture().replace("423|387|387", "423|387|388"),
            capture().replace("423|387|387", "423|424|424"),
            capture().replace(f"C2|CELL|1|1|{ONE}", f"C2|CELL|1|1|{HALF}", 1),
        ):
            with self.assertRaises(ValueError):
                self.c2.compare(target(), bad)

    def test_reject_bad_target_headers_tokens_and_symmetry(self):
        for bad in (
            target().replace(b"index,ivs_score", b"index,iat_score", 1),
            target().replace(b".5000000000000000", b".500", 1),
            target().replace(b".5000000000000000", b".6000000000000000", 1),
        ):
            with self.assertRaises(ValueError):
                self.c2.compare(bad, capture())

    def test_real_archived_target_digest_and_token_profile(self):
        raw = self.c2.archived_bytes()
        tokens = self.c2.parse_target(raw)
        self.assertEqual(sum(len(tokens[i][j].split(".")[-1]) == 15
                             for i in range(15) for j in range(15) if i != j), 14)
        self.assertEqual(sum(len(tokens[i][j].split(".")[-1]) == 16
                             for i in range(15) for j in range(15) if i != j), 196)

    def test_each_archived_interval_has_a_representable_value(self):
        raw = self.c2.archived_bytes()
        tokens = self.c2.parse_target(raw)
        # Decimal readback fixture only; this is not a recovered native matrix.
        receipt = capture().splitlines()
        for i, row in enumerate(tokens, 1):
            for j, token in enumerate(row, 1):
                hex_value = struct.pack(">d", float(token)).hex()
                receipt[17 + (i - 1) * 15 + j] = f"C2|CELL|{i}|{j}|{hex_value}"
        result = self.c2.compare(raw, "\n".join(receipt))
        self.assertEqual(result["counts"], {"roundtrip_equal": 225, "decimal_compatible": 0, "mismatch": 0})
