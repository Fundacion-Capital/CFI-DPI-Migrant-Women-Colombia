"""Disabled offline contract. No Stata, native provider, or participant interface."""

from dataclasses import dataclass
from hashlib import sha256
import hmac
import json
from pathlib import Path
import secrets
from threading import Lock


@dataclass(frozen=True)
class Spec:
    stage: str
    path: Path
    size: int
    sha256: str


def load_specs(academic):
    academic = academic.resolve()
    preflight = academic / 'wp07-target33-stata-preflight'
    selections = academic / 'wp07-target33-selections'
    capacity = (
        Spec('P1', preflight / 'P1 artificial no-load.do', 23196, '23f2cb5fe0c2e2941a84a6b09ab964ebccade4f9426a521153de83097fd446a8'),
        Spec('P2', selections / 'P2.do', 956192, 'dbfb0593dcf4ccb09f3b9cbe57b49ddb8ec4c1d6fc73dee476668ffad60b9a63'),
        Spec('P3', selections / 'P3.do', 7510, '7e8761029a09b5dd9f775225268182a8e5a13b68da4d4cfe88d0212aa1a64454'),
        Spec('P4', selections / 'P4.do', 36930, 'e8683c83e2e8e98acbd50ddcff68f91f66213b13e83d21c07bd735baf5624829'),
    )
    path = preflight / 'Cancellation artificial.do'
    return capacity, (Spec('CANCEL', path, 185, '25c51e4e30a65f34ddd3bc490f95898331be569caa777c7f251456b1359889e5'),)


class OwnedFixture:
    def __init__(self, specs, clock):
        capacity, cancel = load_specs(Path(__file__).resolve().parent.parent)
        if specs not in (capacity, cancel):
            raise ValueError('unbound fixture')
        self.specs = specs
        self.clock = clock
        self.origin = self.last = clock()
        self.lock = Lock()
        self.identity = secrets.token_hex(16)
        self.key = secrets.token_bytes(32)
        self.stop_capability = object()
        self.frame = None
        self.started = self.finished = None
        self.completed = 0
        self.busy = self.held = self.stopped = self.observed = self.closed = False

    def _time(self):
        now = self.clock()
        if now < self.last:
            self.held = True
            raise ValueError('clock moved backward')
        self.last = now
        return now

    def _reject(self, message):
        self.held = True
        raise ValueError(message)

    def reserve(self):
        with self.lock:
            now = self._time()
            if self.held or self.closed or self.stopped or self.busy or self.frame or self.completed == len(self.specs) or now >= self.origin + 180:
                self._reject('reservation denied')
            spec = self.specs[self.completed]
            self.deadline = min(now + 45, self.origin + 180)
            body = json.dumps(dict(scope='TARGET33-artificial', owner=self.identity,
                                   seq=self.completed + 1, stage=spec.stage,
                                   bytes=spec.size, sha256=spec.sha256, deadline=self.deadline),
                              separators=(',', ':')).encode('ascii')
            self.frame = body + b'.' + hmac.digest(self.key, body, 'sha256').hex().encode('ascii')
            if len(self.frame) > 8192:
                self._reject('reference exceeds transport cap')
            return self.frame

    def select(self, frame, consume=None):
        with self.lock:
            now = self._time()
            if (self.held or self.closed or self.stopped or self.busy or self.frame is None
                    or not isinstance(frame, bytes) or len(frame) > 8192
                    or not hmac.compare_digest(frame, self.frame) or now >= self.deadline):
                self._reject('selection denied')
            spec = self.specs[self.completed]
            self.frame = None
            self.busy = True
            self.started = now
        try:
            if spec.path.resolve(strict=True) != spec.path:
                raise ValueError('source alias')
            with spec.path.open('rb') as source:
                body = source.read(spec.size + 1)
            if len(body) != spec.size or sha256(body).hexdigest() != spec.sha256:
                raise ValueError('source size or digest mismatch')
            with self.lock:
                if self.stopped or self.held or self._time() >= self.deadline:
                    raise ValueError('handoff denied')
            if consume is not None:
                consume(body)
            with self.lock:
                now = self._time()
                if self.stopped or self.held or now >= self.deadline or spec.stage == 'CANCEL':
                    raise ValueError('completion denied')
                self.completed += 1
                self.finished = now
                self.busy = False
                return body
        except BaseException:
            with self.lock:
                self.busy = False
                self.finished = self._time()
                self.observed = self.stopped and self.finished < self.deadline
                self.held = not self.observed or self.held
            raise

    def stop(self, capability):
        with self.lock:
            if capability is not self.stop_capability:
                raise ValueError('foreign control')
            if self.stopped:
                return False
            now = self._time()
            if (self.specs[0].stage != 'CANCEL' or not self.busy or self.closed
                    or now > self.started + 40 or now >= self.deadline):
                self._reject('stop window closed')
            self.stopped = True
            return True

    def fixture_closure(self):
        return dict(owner=self.identity, worker_exit=True, control_exit=True,
                    active_owned=0, retained_handles=0)

    def close(self, receipt):
        with self.lock:
            if self.closed:
                return False
            self.closed = True
            now = self._time()
            clean = (not self.busy and not self.held and self.finished is not None
                     and (self.completed == len(self.specs) or self.observed)
                     and now < min(self.finished + 30, self.origin + 210)
                     and type(receipt) is dict and receipt.keys() == self.fixture_closure().keys()
                     and all(type(receipt[k]) is type(v) and receipt[k] == v
                             for k, v in self.fixture_closure().items()))
            self.held = not clean
            return clean
