"""Bounded MAC frames in fixed create-only per-run files. Keys stay in memory/pipes."""
import hashlib
import hmac
import json
from pathlib import Path

LIMIT = 8192


def canonical(body):
    return json.dumps(body, sort_keys=True, separators=(',', ':'), ensure_ascii=True).encode('ascii')


def unique(pairs):
    result = {}
    for name, value in pairs:
        if name in result:
            raise ValueError('Duplicate frame field')
        result[name] = value
    return result


class Channel:
    def __init__(self, kernel):
        self.kernel = kernel

    def prepare(self, binding, scope, keys):
        self.root = Path(binding['private_root']).resolve()
        self.scope = dict(scope)
        self.keys = dict(keys)
        if any(type(key) is not bytes or len(key) != 32 for key in keys.values()):
            raise ValueError('Explicit per-role keys required')
        self.root.mkdir(parents=True, exist_ok=True)
        for name in ('home', 'temp'):
            (self.root / name).mkdir(exist_ok=True)

    def reserve(self):
        with (self.root / 'LAUNCH_RESERVED').open('xb') as stream:
            stream.write(canonical(self.scope))

    def record_parent(self, kind, payload):
        if kind not in {'ownership', 'runtime', 'exit', 'closure'}:
            raise ValueError('No arbitrary parent evidence path')
        wire = canonical(dict(scope=self.scope, kind=kind, payload=payload,
            provenance='trusted parent retained-handle observation; not institutional attestation'))
        if len(wire) > LIMIT:
            raise ValueError('Parent evidence exceeds fixed bound')
        with (self.root / f'parent.{kind}.json').open('xb') as stream:
            stream.write(wire)
            stream.flush()

    def path(self, role, kind, sequence):
        if (role not in self.keys or role not in {'worker', 'watchdog'}
                or kind not in {'ready', 'command', 'result', 'shutdown', 'exit'}
                or type(sequence) is not int or not 0 <= sequence <= 2):
            raise ValueError('No arbitrary role/frame/path')
        return self.root / f'{role}.{kind}.{sequence}.json'

    def publish(self, role, kind, sequence, payload):
        path = self.path(role, kind, sequence)
        body = dict(scope=self.scope, role=role, kind=kind, sequence=sequence, payload=payload)
        body['tag'] = hmac.new(self.keys[role], canonical(body), hashlib.sha256).hexdigest()
        wire = canonical(body)
        if len(wire) > LIMIT:
            raise ValueError('Frame exceeds exact bound')
        pending = path.with_suffix('.pending')
        with pending.open('xb') as stream:
            stream.write(wire)
            stream.flush()
        pending.rename(path)  # Windows rename rejects an existing final target.

    def read(self, role, kind, sequence):
        path = self.path(role, kind, sequence)
        if not path.exists():
            return None
        with path.open('rb') as stream:
            wire = stream.read(LIMIT + 1)
        if len(wire) > LIMIT:
            raise ValueError('Oversized frame')
        try:
            body = json.loads(wire, object_pairs_hook=unique)
            if set(body) != {'scope', 'role', 'kind', 'sequence', 'payload', 'tag'}:
                raise ValueError('Frame schema mismatch')
            tag = body.pop('tag')
            expected = hmac.new(self.keys[role], canonical(body), hashlib.sha256).hexdigest()
            if (type(tag) is not str or not hmac.compare_digest(tag, expected)
                    or body['scope'] != self.scope or body['role'] != role
                    or body['kind'] != kind or body['sequence'] != sequence):
                raise ValueError('Foreign or unauthenticated frame')
            return body['payload']
        except (TypeError, KeyError, UnicodeError, RecursionError, json.JSONDecodeError) as error:
            raise ValueError('Malformed frame') from error

    def wait(self, role, kind, sequence, deadline):
        while self.kernel.now() < deadline:
            value = self.read(role, kind, sequence)
            if value is not None:
                if self.kernel.now() >= deadline:
                    raise TimeoutError('Late frame')
                return value
            self.kernel.pause()
        raise TimeoutError('Absolute frame deadline expired')
