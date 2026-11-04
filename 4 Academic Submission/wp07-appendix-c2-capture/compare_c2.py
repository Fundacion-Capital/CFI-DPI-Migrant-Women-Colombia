"""Read a block-05 aggregate transcript; never load data or run Stata."""

import csv
from fractions import Fraction
from hashlib import sha256
import io
import json
from pathlib import Path
import re
import struct
import sys

AXES = ("ivs_score iat_score iadt_score icdp_score iaff_score iuof_score_01 "
        "oqi_score_01 iurd_score_01 ietr_score_01 IPCS IEDF IAER ICPF IEH IBPD").split()
TARGET = (Path(__file__).resolve().parents[2] / "3 Research Paper Online Appendix"
          / "C Variable Construction/tables/Table_C2_Index_Correlation_Matrix.csv")
TARGET_SHA = "94abf6b1bf291f923ad7f03486099cb42dac90dba9f6d1ab5d5abe0f185eefff"


def archived_bytes():
    raw = TARGET.read_bytes()
    if len(raw) != 4140 or sha256(raw).hexdigest() != TARGET_SHA:
        raise ValueError("archived C2 target fingerprint mismatch")
    return raw


def parse_target(raw):
    rows = list(csv.reader(io.StringIO(raw.decode("utf-8"), newline=""), strict=True))
    if len(rows) != 16 or any(len(row) != 16 for row in rows):
        raise ValueError("archived target is not 15 by 15")
    if rows[0] != ["index", *AXES] or [row[0] for row in rows[1:]] != AXES:
        raise ValueError("archived axes differ")
    cells = [row[1:] for row in rows[1:]]
    for i in range(15):
        for j in range(15):
            token = cells[i][j]
            if i == j:
                valid = token == "1"
            else:
                valid = (re.fullmatch(r"[+-]?0?\.\d{15,16}", token) is not None
                         and -1 <= Fraction(token) <= 1 and token == cells[j][i])
            if not valid:
                raise ValueError(f"invalid archived cell {i+1},{j+1}")
    return cells


def parse_capture(transcript):
    if re.search(r"^\s*r\(\d+\);\s*$", transcript, re.MULTILINE):
        raise ValueError("native Stata error in transcript")
    records = [line for line in transcript.splitlines() if line.startswith("C2|")]
    if len(records) != 243 or records[0] != "C2|BEGIN|WP07_C2_V1" or records[-1] != "C2|END|225":
        raise ValueError("missing, duplicate or incomplete C2 capture")
    n_record = re.fullmatch(r"C2\|N\|423\|([1-9][0-9]{0,2})\|([1-9][0-9]{0,2})", records[1])
    if not n_record or n_record[1] != n_record[2] or not 2 <= int(n_record[1]) <= 423:
        raise ValueError("complete-case N evidence disagrees")
    if records[2:17] != [f"C2|AXIS|{i}|{name}|{name}" for i, name in enumerate(AXES, 1)]:
        raise ValueError("captured axes differ")
    bits = []
    for index, line in enumerate(records[17:-1]):
        i, j = divmod(index, 15)
        match = re.fullmatch(rf"C2\|CELL\|{i+1}\|{j+1}\|([0-9a-fA-F]{{16}})", line)
        if not match:
            raise ValueError(f"missing or reordered captured cell {i+1},{j+1}")
        hex_value = match[1].lower()
        value, = struct.unpack(">d", bytes.fromhex(hex_value))
        if not -1 <= value <= 1 or (i == j and hex_value != "3ff0000000000000"):
            raise ValueError(f"invalid captured value {i+1},{j+1}")
        bits.append((hex_value, Fraction.from_float(value)))
    for i in range(15):
        for j in range(i):
            if bits[i*15+j] != bits[j*15+i]:
                raise ValueError(f"asymmetric captured cell {i+1},{j+1}")
    return int(n_record[1]), bits


def compare(raw_target, transcript):
    tokens = parse_target(raw_target)
    n, capture = parse_capture(transcript)
    counts = dict(roundtrip_equal=0, decimal_compatible=0, mismatch=0)
    cells = []
    for index, (hex_value, actual) in enumerate(capture):
        i, j = divmod(index, 15)
        token = tokens[i][j]
        difference = abs(actual - Fraction(token))
        bound = Fraction(0) if i == j else Fraction(1, 2 * 10**len(token.split(".")[1]))
        if difference > bound:
            status = "mismatch"
        elif hex_value == struct.pack(">d", float(token)).hex():
            status = "roundtrip_equal"
        else:
            status = "decimal_compatible"
        counts[status] += 1
        cells.append(dict(row=AXES[i], column=AXES[j], archived_token=token, binary64_hex=hex_value,
                          absolute_error=str(difference), bound=str(bound), status=status))
    return dict(complete_case_n=n, archived_complete_case_n=None, counts=counts, cells=cells)


if __name__ == "__main__":
    if len(sys.argv) != 2 or Path(sys.argv[1]).suffix.lower() not in {".txt", ".log"}:
        sys.exit("Usage: compare_c2.py <aggregate Stata transcript.txt>")
    try:
        report = compare(archived_bytes(), Path(sys.argv[1]).read_text(encoding="utf-8-sig"))
    except (ValueError, OSError, csv.Error) as exc:
        sys.exit(f"C2 readback rejected: {exc}")
    print(json.dumps(report, indent=2))
    sys.exit(1 if report["counts"]["mismatch"] else 0)
