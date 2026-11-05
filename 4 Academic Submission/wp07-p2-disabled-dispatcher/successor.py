"""Disabled artificial-only successor. No native or participant interface."""
import csv
from dataclasses import dataclass
import hashlib
import io
import json
from pathlib import Path
import secrets
import sys
from types import ModuleType

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
PREVIOUS = ROOT / "4 Academic Submission/wp07-p2-reader-requalification"


def _pinned(path, wanted):
    raw = path.read_bytes()
    if hashlib.sha256(raw).hexdigest() != wanted:
        raise ValueError("Pinned documentary source changed")
    return raw


def _pinned_module(name, path, wanted):
    raw = _pinned(path, wanted)
    module = ModuleType(name)
    module.__file__ = str(path)
    sys.modules[name] = module
    # Execute the checked Python bytes, not a second read of the pathname.
    exec(compile(raw, str(path), "exec"), module.__dict__)
    return module


CONTRACT = _pinned_module("_wp07_requalification_contract", PREVIOUS / "offline_contract.py",
                          "9b4756f3af7d5944c3ed8a1ae1a0c11e4290d1458744b1b6057b3d0913866e54")
READER = _pinned_module("_wp07_disabled_pure_reader", ROOT / CONTRACT.READER_PATH, CONTRACT.READER_SHA)


def bindings():
    return json.loads(_pinned(PREVIOUS / "BINDINGS.json", "95cadb261d01a6e46db5cfc3aa9e5acdb4b1c6e0f41631046b9e9dbbbc6497d4"))


def _records(track):
    if type(track) is not str or track not in ("aggregate", "cases"):
        raise ValueError("Artificial-only track required")
    return bindings()["participant_proposal" if track == "aggregate" else "artificial_cases"]


def _checks():
    path = ROOT / "4 Academic Submission/wp06-nofit-verification-preflight/verification_checks.csv"
    raw = _pinned(path, "c0d159c76e5b0c81de53b1220fc28557333d7c80c6a5ea2d9e01b1776d340a4f")
    return tuple((row["check_id"], row["operation"]) for row in csv.DictReader(io.StringIO(raw.decode("utf-8-sig"))))


@dataclass(frozen=True)
class Prepared:
    track: str
    steps: tuple
    versions: tuple
    checks: tuple


def prepare(track):
    steps = []
    for record in _records(track):
        path = ROOT / record["path"]
        if path.resolve(strict=True) != path:
            raise ValueError("Source alias rejected")
        with path.open("rb") as source:
            raw = source.read(record["as_saved_bytes"] + 1)
        if len(raw) != record["as_saved_bytes"] or CONTRACT.sha(raw) != record["as_saved_sha256"]:
            raise ValueError("Held source size or digest mismatch")
        body = CONTRACT.candidate_payload(raw) if record["payload_transform"] == "REMOVE_FIRST_EXECUTABLE_EXIT_198_ONLY" else raw
        if len(body) != record["candidate_payload_bytes"] or CONTRACT.sha(body) != record["candidate_payload_sha256"]:
            raise ValueError("Prospective payload mismatch")
        name = record["stage"] if track == "aggregate" else record["case_id"]
        outputs = READER.templates(body, CONTRACT.VERSIONS) if track == "aggregate" else ()
        steps.append(READER.Step(name, body, CONTRACT.sha(body), outputs))
    return Prepared(track, tuple(steps), CONTRACT.VERSIONS, _checks() if track == "aggregate" else ())


def _admit(prepared):
    if type(prepared) is not Prepared:
        raise ValueError("Exact prepared package required")
    if type(prepared.steps) is not tuple or type(prepared.versions) is not tuple or type(prepared.checks) is not tuple:
        raise ValueError("Immutable prepared containers required")
    if not all(type(value) is str for value in prepared.versions) or not all(type(pair) is tuple and len(pair) == 2 and all(type(value) is str for value in pair) for pair in prepared.checks):
        raise ValueError("Plain prepared metadata required")
    records = _records(prepared.track)
    if prepared.versions != CONTRACT.VERSIONS or prepared.checks != (_checks() if prepared.track == "aggregate" else ()) or len(prepared.steps) != len(records):
        raise ValueError("Prepared scope changed")
    for step, record in zip(prepared.steps, records):
        name = record["stage"] if prepared.track == "aggregate" else record["case_id"]
        if type(step) is not READER.Step or type(step.body) is not bytes or type(step.id) is not str or type(step.sha256) is not str or step.id != name or len(step.body) != record["candidate_payload_bytes"] or CONTRACT.sha(step.body) != step.sha256 or step.sha256 != record["candidate_payload_sha256"]:
            raise ValueError("Prepared payload changed")
        if not _plain_outputs(step.outputs):
            raise ValueError("Plain receipt inventory required")
        outputs = READER.templates(step.body, prepared.versions) if prepared.track == "aggregate" else ()
        if step.outputs != outputs or (prepared.track == "aggregate" and CONTRACT.output_inventory(READER, step.body) != record["outputs"]):
            raise ValueError("Prepared receipt inventory changed")


def _plain_outputs(outputs):
    if type(outputs) is not tuple:
        return False
    for output in outputs:
        if type(output) is not READER.Output or type(output.name) is not str or type(output.header) is not tuple or type(output.rows) is not tuple or not all(type(value) is str for value in output.header):
            return False
        if output.header:
            if not all(type(row) is tuple and all(type(value) is str or value is READER.COUNT or value is READER.STATUS for value in row) for row in output.rows):
                return False
        elif not all(type(row) is str for row in output.rows):
            return False
    return True


def _record_copy(value, depth=0):
    if depth > 6:
        raise ValueError("Artificial record nesting limit")
    if type(value) in (str, int, bool, type(None)):
        return value
    if type(value) is dict and all(type(key) is str for key in value):
        return {key: _record_copy(item, depth + 1) for key, item in value.items()}
    raise ValueError("Plain artificial record data required")


class FixedFileFixture:
    """Compact references to checked code buffers; no callback or real worker."""
    def __init__(self, prepared, records=None, durations=(1, 1, 1, 1), fault=None,
                 cleanup_duration=1, cleanup_ok=True, cancel_ok=True):
        _admit(prepared)
        if type(durations) is not tuple or len(durations) != 4 or any(type(n) is not int or n < 0 for n in durations) or type(cleanup_duration) is not int or cleanup_duration < 0 or type(cleanup_ok) is not bool or type(cancel_ok) is not bool:
            raise ValueError("Plain artificial clock values required")
        if fault is not None and (type(fault) is not str or fault not in {"missing_row", "raw_value", "foreign_scope", "wrong_digest", "nonaggregate_log", "extra_output", "count_not_reconciled"}):
            raise ValueError("Known artificial fault required")
        if prepared.track == "cases" and (durations != (1, 1, 1, 1) or fault is not None or cleanup_duration != 1 or cleanup_ok is not True or cancel_ok is not True):
            raise ValueError("Four-stage simulation options cannot enter case track")
        if (prepared.track == "aggregate" and records is not None) or (prepared.track == "cases" and records is not None and type(records) is not dict):
            raise ValueError("Artificial records belong only to the case track")
        self.prepared = prepared
        self.records = _record_copy(records)
        plan = READER.Plan(prepared.steps, HERE / "_never_provisioned_output", prepared.versions, prepared.checks, (), False)
        self.aggregate = READER.ArtificialTransport(plan, durations, fault, cleanup_duration, cleanup_ok, cancel_ok) if prepared.track == "aggregate" else None
        self.position = 0
        self.identity = secrets.token_hex(16)
        self.pending = None
        self.used = self.closed = False
        self.handed_buffers = []
        self.trace = []

    def reserve(self):
        if self.closed or self.pending is not None or self.position >= len(self.prepared.steps):
            self.closed = True
            raise ValueError("Artificial reservation denied")
        step = self.prepared.steps[self.position]
        self.pending = json.dumps(dict(scope="WP07_P2_ARTIFICIAL_TRANSPORT_ONLY", owner=self.identity, track=self.prepared.track,
                                       seq=self.position + 1, stage=step.id, bytes=len(step.body), sha256=step.sha256),
                                  separators=(",", ":")).encode("ascii")
        return self.pending

    def select(self, reference, deadline=None):
        if self.closed or self.pending is None or type(reference) is not bytes or len(reference) > 8192 or reference != self.pending:
            self.closed = True
            raise ValueError("Artificial reference denied")
        self.pending = None
        step = self.prepared.steps[self.position]
        self.position += 1
        self.handed_buffers.append(step.body)
        self.trace.append(dict(scope="ARTIFICIAL_ONLY", track=self.prepared.track, stage=step.id,
                               context=self.identity + ":" + step.id, sha256=step.sha256, bytes=len(step.body)))
        if self.prepared.track == "aggregate":
            return self.aggregate.select(step, deadline)
        if type(self.records) is not dict or step.id not in self.records:
            self.closed = True
            raise ValueError("Artificial case record absent")
        return _record_copy(self.records[step.id])


def _start(prepared, fixture, track):
    _admit(prepared)
    if prepared.track != track or type(fixture) is not FixedFileFixture or fixture.prepared is not prepared or fixture.used or fixture.closed or fixture.position != 0 or fixture.pending is not None:
        raise ValueError("Exact unused artificial channel required")
    if track == "cases" and (type(fixture.records) is not dict or set(fixture.records) != {s.id for s in prepared.steps}):
        raise ValueError("Exact five artificial records required")
    if track == "aggregate" and fixture.records is not None:
        raise ValueError("Case records cannot enter aggregate track")
    if (track == "aggregate" and type(fixture.aggregate) is not READER.ArtificialTransport) or (track == "cases" and fixture.aggregate is not None):
        raise ValueError("Preserved artificial inner transport required")
    fixture.used = True


def dispatch_aggregate(prepared, fixture):
    """Simulate only the preserved four-stage budget; never admit a live route."""
    _start(prepared, fixture, "aggregate")
    clock = fixture.aggregate
    origin = clock.tick
    dispositions = {key: "not_executed" for key, _ in prepared.checks}
    loads = 0
    errors = []
    canceled = True
    try:
        for step in prepared.steps:
            deadline = min(clock.tick + READER.PER_STEP, origin + READER.WORK)
            try:
                READER.need(clock.tick < deadline, "work_deadline")
                started = clock.tick
                result = fixture.select(fixture.reserve(), deadline)
                READER.need(type(clock.tick) is int and started <= clock.tick < deadline, "step_deadline")
                READER.need(type(result) is dict and set(result) == {"scope", "step", "sha256", "ok", "simulated_loads", "outputs", "log"}
                            and result["scope"] == "ARTIFICIAL_ONLY" and result["step"] == step.id
                            and result["sha256"] == step.sha256 and result["ok"] is True
                            and type(result["simulated_loads"]) is int and result["simulated_loads"] == int(step.id == "P1")
                            and result["log"] == READER.LOG_PREFIX + step.id, "receipt_contract")
                loads += result["simulated_loads"]
                READER.check_outputs(step, result["outputs"], prepared.versions)
            except (ValueError, TypeError, KeyError, csv.Error) as error:
                errors.append(str(error))
                for key, stage in prepared.checks:
                    if stage == step.id:
                        dispositions[key] = "technical_stop"
                canceled = clock.cancel() is True
                break
            for key, stage in prepared.checks:
                if stage == step.id:
                    dispositions[key] = "artificial_complete"
        started = clock.tick
        deadline = min(started + READER.CLEANUP, origin + READER.TOTAL)
        cleaned = clock.cleanup(deadline) is True and started <= clock.tick < deadline
    finally:
        fixture.closed = True
    status = "QUARANTINED" if not (cleaned and canceled) else "TECHNICAL_STOP" if errors else "ARTIFICIAL_PASS"
    return dict(status=status, check_dispositions=dispositions, simulated_loads=loads,
                actual_loads=0, actual_stata_calls=0, native_result="NOT_RUN", cleanup_verified=cleaned,
                artificial_cancel_verified=canceled, errors=errors, retries=0, live_ready=False)


def dispatch_cases(prepared, fixture):
    """Read five independent fake case records; do not fabricate observed facts."""
    _start(prepared, fixture, "cases")
    dispositions = {step.id: "not_executed" for step in prepared.steps}
    errors = []
    status = "ARTIFICIAL_METADATA_CONSISTENT_NOT_NATIVE_VERIFIED"
    try:
        for step, spec in zip(prepared.steps, _records("cases")):
            try:
                record = fixture.select(fixture.reserve())
                outcome = CONTRACT.check_case_record(spec, record)
                if outcome == "HELD_NOT_TESTED":
                    dispositions[step.id] = "held_not_tested"
                    status = "HELD_NOT_TESTED"
                    break
                dispositions[step.id] = "metadata_consistent"
            except (ValueError, TypeError, KeyError) as error:
                dispositions[step.id] = "technical_stop"
                errors.append(str(error))
                status = "TECHNICAL_STOP"
                break
    finally:
        fixture.closed = True
    return dict(status=status, case_dispositions=dispositions, actual_loads=0,
                actual_stata_calls=0, native_result="NOT_RUN", retries=0,
                errors=errors, live_ready=False, native_provenance="UNQUALIFIED")
