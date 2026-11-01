"""Fixed native-empty roles. No role or Stata initialization runs on import."""
import sys
sys.dont_write_bytecode = True
from pathlib import Path
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import io
import os
import threading
from deployment import load_active, digest, check_runtime_identity
import hashlib
import json
from private_channel import Channel
from startup_guard import verify as verify_startup


def worker_loop(engine, kernel, wire, binding, scope, origin):
    for sequence in (1, 2):
        while True:
            if kernel.now() >= origin + 90 * kernel.frequency:
                raise TimeoutError('Worker command admission expired')
            if wire.read('worker', 'shutdown', 0) is not None:
                return
            command = wire.read('worker', 'command', sequence)
            if command is not None:
                break
            kernel.pause()
        expected = dict(code=binding['literal_selections'][sequence - 1].removesuffix('\n'),
            timeout=10, execution_id=f"{scope['run_id']}-{sequence}")
        if command != expected:
            raise ValueError('Worker rejects arbitrary code, order or command identity')
        output = engine.run(command['code'], sequence)
        wire.publish('worker', 'result', sequence, dict(status='success', output=output,
            error='', session_id=scope['session_id'], extra={}))


def watchdog_loop(kernel, wire, packet):
    caps = packet['inherited']
    worker, inner = caps['worker'], caps['inner_job']
    origin, frequency = packet['origin'], packet['frequency']
    signaled = contained = False
    while kernel.now() < origin + 100 * frequency:
        if kernel.identity(worker) != packet['worker_identity'] or not kernel.member(worker, inner):
            kernel.stop_job(inner)
            raise ValueError('Independent worker identity/membership mismatch')
        if kernel.signaled(worker):
            wire.publish('watchdog', 'exit', 0, dict(worker_exit=kernel.exit_code(worker),
                active_owned=kernel.active(inner)))
            return
        now = kernel.now()
        if now >= origin + 60 * frequency and not kernel.signaled(caps['ready_event']):
            kernel.stop_job(inner)
            contained = True
        if now >= origin + 90 * frequency and not signaled:
            signaled = True
            kernel.signal(caps['stop_event'])
        if now >= origin + 95 * frequency and not contained:
            contained = True
            kernel.stop_job(inner)
        kernel.pause()
    kernel.stop_job(inner)
    raise TimeoutError('Independent exit deadline exceeded')


def capture_runtime_identity(binding, kernel, config, stata):
    paths = {'engine': kernel.module_path(config.stlib._handle),
        'python_image': kernel.module_path(None), 'pystata_config': Path(config.__file__),
        'pystata_stata': Path(stata.__file__)}
    proof = {}
    for name, path in paths.items():
        path = path.resolve()
        data = path.read_bytes()
        matching = [row for row in binding['runtime_identity_files'][name]
            if os.path.normcase(row['path']) == os.path.normcase(str(path))]
        if len(matching) != 1:
            raise ValueError('Unbound resolved runtime path')
        proof[name] = dict(path=matching[0]['path'], bytes=len(data), sha256=hashlib.sha256(data).hexdigest())
    check_runtime_identity(binding, proof)
    return proof


class StataEngine:
    def __init__(self, binding, kernel, stop_event):
        verify_startup(binding)
        self.binding, self.kernel = binding, kernel
        self.busy = False
        self.stop = stop_event
        self.done = threading.Event()
        self.break_sent = False
        # Explicit paths under -I -S; .pth, user-site and implicit working-directory imports stay disabled.
        sys.path.insert(0, binding['site_packages'])
        sys.path.insert(0, str(Path(binding['stata_home']) / 'utilities'))
        os.environ['SYSDIR_STATA'] = binding['stata_home']
        from pystata import config
        config.init('mp', splash=False)
        from pystata import stata
        self.stata, self.config = stata, config
        self.identity = capture_runtime_identity(binding, kernel, config, stata)
        self.thread = threading.Thread(target=self.monitor, daemon=True)
        self.thread.start()

    def monitor(self):
        while not self.done.wait(0.01):
            if self.busy and not self.break_sent and self.kernel.signaled(self.stop):
                self.break_sent = True
                self.config.stlib.StataSO_SetBreak()

    def run(self, code, sequence):
        if self.kernel.signaled(self.stop) or self.break_sent:
            raise ValueError('Stopped worker cannot admit another selection')
        path = Path(self.binding['private_root']) / f'selection.{sequence}.log'
        if path.exists():
            raise FileExistsError('Selection output already exists')
        log = str(path).replace('\\', '/')
        wrapped = f'capture log close wp06native\nlog using "{log}", text name(wp06native)\n{code}\ncapture log close wp06native\n'
        self.busy = True
        try:
            self.stata.run(wrapped, echo=True, inline=False)
        finally:
            self.busy = False
            self.stata.run('capture log close wp06native', echo=False, inline=False)
        if self.break_sent:
            raise ValueError('Stopped selection is not a successful result')
        with path.open('rb') as stream:
            raw = stream.read(4097)
        if len(raw) > 4096:
            raise ValueError('Empty metadata output exceeds fixed bound')
        return raw.decode('utf-8')

    def close(self):
        self.done.set()
        self.thread.join(1)
        if self.thread.is_alive():
            raise ValueError('Stop-monitor closure not observed')


def check_bootstrap(role, packet, binding, kernel):
    names = ('schema','role_match','role_allowed','binding_digest','frequency','identity','deadline')
    checks = dict.fromkeys(names, 'NOT_EVALUATED')
    reason = None
    primary = ValueError('Foreign, late or mismatched native bootstrap')
    wanted = {'scope','origin','frequency','binding_sha256','worker_identity','role','key','identity','inherited'}
    checks['schema'] = type(packet) is dict and set(packet)==wanted
    if not checks['schema']: reason = 'schema'
    if reason is None:
        checks['role_match'] = packet['role']==role
        if not checks['role_match']: reason = 'role_match'
    if reason is None:
        checks['role_allowed'] = role in {'worker','watchdog'}
        if not checks['role_allowed']: reason = 'role_allowed'
    if reason is None:
        expected = digest(binding)
        checks['binding_digest'] = dict(matched=packet['binding_sha256']==expected, expected=expected)
        if not checks['binding_digest']['matched']: reason = 'binding_digest'
    if reason is None:
        frequency = kernel.frequency
        checks['frequency'] = dict(matched=packet['frequency']==frequency, observed=frequency,
            reported=packet['frequency'] if type(packet['frequency']) is int else 'INVALID_TYPE')
        if not checks['frequency']['matched']: reason = 'frequency'
    if reason is None:
        try:
            observed = kernel.identity(kernel.api.GetCurrentProcess())
            reported = packet['identity']
            checks['identity'] = dict(matched=observed==reported, observed=observed,
                reported={k:reported[k] for k in ('pid','birth')} if type(reported) is dict and set(reported)=={'pid','birth'}
                    and all(type(reported[k]) is int for k in reported) else 'INVALID_SHAPE')
            if not checks['identity']['matched']: reason = 'identity'
        except Exception as error:
            checks['identity'] = 'OBSERVATION_FAILED'
            primary = error
            reason = 'identity_observation'
    if reason is None:
        tick = 'NOT_EVALUATED'
        deadline = 'NOT_EVALUATED'
        try:
            tick = kernel.now()
            deadline = packet['origin'] + 60 * kernel.frequency
            checks['deadline'] = dict(origin=packet['origin'],frequency=kernel.frequency,deadline=deadline,tick=tick,matched=tick<deadline)
            if not checks['deadline']['matched']: reason = 'deadline'
        except Exception as error:
            primary = error
            reason = 'deadline_evaluation'
            checks['deadline'] = dict(origin=packet['origin'] if type(packet['origin']) is int else 'INVALID_TYPE',
                frequency=kernel.frequency, deadline=deadline, tick=tick, matched=False)
    if reason is None:
        return
    safe_role = role if type(role) is str and role in {'worker','watchdog'} else 'invalid-role'
    try:
        row = dict(reason=reason,role=safe_role if safe_role!='invalid-role' else 'UNSUPPORTED',checks=checks,
            validated_run_scope=binding['run_scope'], source_disk_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            provenance='guard operands actually evaluated; source hash is disk identity, not loaded-memory attestation')
        raw = json.dumps(row,sort_keys=True,separators=(',',':'),ensure_ascii=True).encode('utf-8')
        if len(raw)>4096: raise ValueError('Bootstrap diagnostic exceeds fixed bound')
        with (Path(binding['private_root'])/('bootstrap.'+safe_role+'.rejection.json')).open('xb') as stream:
            stream.write(raw)
            stream.flush()
    except Exception as error:
        raise ExceptionGroup('Bootstrap rejected; diagnostic write failed',[primary,error]) from primary
    raise primary


def main(role, reader, binding_path):
    binding, grant = load_active(binding_path)  # Denies before DLL, native probes or Stata import.
    from win32_owner import Kernel
    kernel = Kernel(binding, grant)
    packet = kernel.read_private_bootstrap(reader)
    check_bootstrap(role, packet, binding, kernel)
    for handle in packet['inherited'].values():
        kernel.own(handle)
    wire = Channel(kernel)
    wire.prepare(binding, packet['scope'], {role: bytes.fromhex(packet['key'])})
    engine = None
    try:
        if role == 'watchdog':
            caps = packet['inherited']
            if kernel.identity(caps['worker']) != packet['worker_identity'] or not kernel.member(caps['worker'], caps['inner_job']):
                raise ValueError('Watchdog cannot bind the retained worker')
            wire.publish('watchdog', 'ready', 0, {'ready': True})
            watchdog_loop(kernel, wire, packet)
        else:
            if kernel.identity(kernel.api.GetCurrentProcess()) != packet['worker_identity']:
                raise ValueError('Wrong worker epoch')
            engine = StataEngine(binding, kernel, packet['inherited']['stop_event'])
            if kernel.now() >= packet['origin'] + 60 * kernel.frequency:
                raise TimeoutError('Engine initialized after bootstrap deadline')
            wire.publish('worker', 'ready', 0, {'ready': True, 'runtime_identity': engine.identity})
            kernel.signal(packet['inherited']['ready_event'])
            worker_loop(engine, kernel, wire, binding, packet['scope'], packet['origin'])
            # Keep the same owned worker alive until the parent validates result 2 and requests cleanup.
            while wire.read('worker', 'shutdown', 0) is None:
                if (kernel.signaled(packet['inherited']['stop_event'])
                        or kernel.now() >= packet['origin'] + 90 * kernel.frequency):
                    raise TimeoutError('Post-result shutdown deadline expired')
                kernel.pause()
    finally:
        if engine is not None:
            engine.close()
        kernel.close_all()


if __name__ == '__main__':
    if len(sys.argv) != 4:
        raise SystemExit('Only a fixed privately bootstrapped role entry is supported')
    main(sys.argv[1], int(sys.argv[2]), sys.argv[3])
