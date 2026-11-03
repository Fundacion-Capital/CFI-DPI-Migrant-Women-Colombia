"""Verify custody and run the disabled fixture with launch/network tripwires."""

from hashlib import sha256
import json
from pathlib import Path
import sys
import unittest

HERE = Path(__file__).resolve().parent
ACADEMIC = HERE.parent
ROOT = ACADEMIC.parent
INTAKE = ACADEMIC / 'audit-local' / 'intake'
SEALS = {
    'wp07-target33-preflight-3c51c36': ('5abab6c465f42623ca2fb51a72c83b86cc9031d0047b040a6756de48475e1b99', 6),
    'wp07-target33-selections-3c51c36': ('c6f180167ea0c7b46544c1bea7d04156d40a7a8865bd2900504f8321ff89bf98', 10),
    'wp07-target33-offline-dispatcher-0eac5a2': ('92ba94177d3f79b59cf8cffca34ef3ccefa9bc7c5140072fd09c78c50c674c36', 9),
    'wp07-target33-stata-preflight-e477b07': ('9d52421820406155f185fc947ca07a410f93650cfe15c41cac1bd4c7639c78fd', 6),
}
DENIED = []


def guard(event, args):
    if (event.startswith(('subprocess.', 'socket.', 'ctypes.dlopen', 'os.startfile', 'os.spawn', 'os.exec', 'os.fork'))
            or event in {'os.system', 'os.add_dll_directory'}
            or (event == 'open' and isinstance(args[0], (str, bytes))
                and Path(str(args[0]).strip("'")).suffix.lower() in {'.dta', '.xlsx', '.xls', '.csv', '.sav', '.parquet'})):
        DENIED.append(event)
        raise RuntimeError('outside offline audit boundary')


def verified_members():
    checked = set()
    for name, (expected, count) in SEALS.items():
        seal = (INTAKE / name / 'seal.json').read_bytes()
        if sha256(seal).hexdigest() != expected:
            raise ValueError('predecessor seal drift')
        document = json.loads(seal)
        members = document.get('files', document)
        if isinstance(members, dict):
            members = [dict(path=p, sha256=d) for p, d in members.items()]
        if len(members) != count:
            raise ValueError('predecessor member count mismatch')
        for item in members:
            path = ROOT / item['path']
            if (not path.is_relative_to(ACADEMIC) or path.resolve(strict=True) != path
                    or path.suffix.lower() not in {'.md', '.json', '.py', '.do', '.log'}):
                raise ValueError('unexpected predecessor member')
            body = path.read_bytes()
            if sha256(body).hexdigest() != item['sha256'] or len(body) != item.get('bytes', len(body)):
                raise ValueError('predecessor member drift')
            checked.add(path)
    return checked


if __name__ == '__main__':
    sys.addaudithook(guard)
    sys.path.insert(0, str(HERE))
    from harness import OwnedFixture, load_specs

    verified = verified_members()
    capacity, cancel = load_specs(ACADEMIC)
    if not all(spec.path in verified for spec in capacity + cancel):
        raise ValueError('fixture outside custody')
    result = unittest.TextTestRunner(verbosity=2).run(unittest.defaultTestLoader.discover(str(HERE)))
    owner = OwnedFixture(capacity, lambda: 0)
    for spec in capacity:
        frame = owner.reserve()
        body = owner.select(frame)
        print(f'{spec.stage}: source={len(body)} bytes; reference={len(frame)} bytes; SHA256={sha256(body).hexdigest()}')
    if not owner.close(owner.fixture_closure()) or not result.wasSuccessful() or DENIED:
        raise SystemExit(1)
    if verified_members() != verified:
        raise SystemExit(1)
    print(f'Custody: {len(SEALS)} seals, {len(verified)} member files verified before and after.')
    print(f'Optimization: {sys.flags.optimize}; tripwire events: {len(DENIED)}')
