"""Explicit LIVE_ARTIFICIAL role harness; never imports Stata or a participant input."""
import ctypes as c
import hashlib
import hmac
import json
import os
from pathlib import Path
import secrets
import sys
import uuid

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
from live_windows import Native, H, SYNC, WAIT_OBJECT, WAIT_TIMEOUT
from journal_protocol import canonical

PRIVATE = HERE.parents[0] / 'audit-local/intake/wp06-live-control-365fea7'
PROFILES = ('cooperative', 'controller_exit', 'worker_ignore', 'supervisor_stall', 'observer_stall', 'identity_reject')
DOMAIN = 'WP06_ISOLATED_LIVE_ARTIFICIAL_V1'

def validate_profile(profile):
    if type(profile) is not str or profile not in PROFILES:
        raise ValueError('Only fixed artificial profiles are permitted')
    return profile

def before(deadline, now):
    if type(deadline) is not int or type(now) is not int or now >= deadline:
        raise ValueError('DEADLINE_EXPIRED')

def identity_matches(expected, actual):
    if set(expected) != {'pid', 'birth'} or any(type(v) is not int or v <= 0 for v in expected.values()) or expected != actual:
        raise ValueError('IDENTITY_MISMATCH')

def encode(body, key):
    body = dict(body)
    body['tag'] = hmac.new(key, canonical(body), hashlib.sha256).hexdigest()
    wire = canonical(body)
    if len(wire) > 8192:
        raise ValueError('FRAME_TOO_LARGE')
    return wire

def decode(wire, key):
    if len(wire) > 8192:
        raise ValueError('FRAME_TOO_LARGE')
    def unique(pairs):
        value = {}
        for name, item in pairs:
            if name in value:
                raise ValueError('DUPLICATE_FIELD')
            value[name] = item
        return value
    body = json.loads(wire, object_pairs_hook=unique)
    tag = body.pop('tag', None)
    expected = hmac.new(key, canonical(body), hashlib.sha256).hexdigest()
    if type(tag) is not str or not hmac.compare_digest(tag, expected):
        raise ValueError('MAC_MISMATCH')
    return body

def sources():
    paths = [HERE / 'live_roles.py', HERE / 'live_windows.py', HERE.parent / 'wp06-stage-b/native_backend.py', HERE.parent / 'wp06-stage-b/journal_protocol.py', Path(sys.executable)]
    return {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths}

def publish(path, wire):
    pending = path.with_suffix('.pending')
    with pending.open('xb') as stream:
        stream.write(wire)
        stream.flush()
        os.fsync(stream.fileno())
    # Windows rename is atomic and rejects an existing destination; no record replacement.
    if path.parent.resolve() != pending.parent.resolve() or not path.parent.resolve().is_relative_to(PRIVATE.resolve()):
        raise ValueError('OUTSIDE_PACKET')
    os.rename(pending, path)

class Context:
    def __init__(self, native, packet):
        if type(packet) is not dict or set(packet) != {'domain', 'run', 'case', 'packet', 'sources',
            'frequency', 'origin', 'bootstrap', 'control', 'cleanup', 'outer', 'role', 'self_identity', 'keys', 'caps'}:
            raise ValueError('BOOTSTRAP_SCHEMA_MISMATCH')
        self.n = native
        self.b = packet
        self.role = packet['role']
        self.path = Path(packet['packet']).resolve()
        if not self.path.is_relative_to(PRIVATE.resolve()) or not self.path.is_dir():
            raise ValueError('OUTSIDE_PACKET')
        validate_profile(packet['case'])
        if packet['domain'] != DOMAIN or packet['sources'] != sources() or packet['frequency'] != native.frequency:
            raise ValueError('SOURCE_OR_CLOCK_SCOPE_MISMATCH')
        if type(packet['run']) is not str or len(packet['run']) != 32 or any(x not in '0123456789abcdef' for x in packet['run']):
            raise ValueError('RUN_ID_MISMATCH')
        if any(type(packet[key]) is not int for key in ['origin', 'bootstrap', 'control', 'cleanup', 'outer']):
            raise ValueError('DEADLINE_TYPE_MISMATCH')
        if any(packet[key] != packet['origin'] + seconds*native.frequency
               for key, seconds in [('bootstrap',5), ('control',8), ('cleanup',10), ('outer',12)]):
            raise ValueError('DEADLINE_ENVELOPE_MISMATCH')
        expected_keys = {'L': set('LOSCW'), 'O': set('OSCW'), 'S': set('SW'), 'C': {'C'}, 'W': {'W'}}
        if self.role not in expected_keys or set(packet['keys']) != expected_keys[self.role]:
            raise ValueError('ROLE_CREDENTIAL_SCOPE_MISMATCH')
        expected_caps = {'L': set(), 'O': {'gate'}, 'S': {'gate','request','controller'}, 'C': {'gate','request'}, 'W': {'gate','stop'}}
        if set(packet['caps']) != expected_caps[self.role] or any(type(x) is not int or x <= 0 for x in packet['caps'].values()) or len(set(packet['caps'].values())) != len(packet['caps']):
            raise ValueError('ROLE_CAPABILITY_SCOPE_MISMATCH')
        self.keys = {role: bytes.fromhex(value) for role, value in packet['keys'].items()}
        if any(len(value) != 32 for value in self.keys.values()):
            raise ValueError('ROLE_CREDENTIAL_SIZE')
        self.identity = native.identity(native.api.GetCurrentProcess())

    def admit(self):
        identity_matches(self.b['self_identity'], self.identity)
        before(self.b['bootstrap'], self.n.now())

    def write(self, kind, payload):
        body = dict(domain=DOMAIN, run=self.b['run'], case=self.b['case'], role=self.role,
            kind=kind, identity=self.identity, tick=self.n.now(), payload=payload)
        publish(self.path / f'{self.role}_{kind}.json', encode(body, self.keys[self.role]))
        return body

    def read(self, role, kind):
        path = self.path / f'{role}_{kind}.json'
        if not path.exists():
            return None
        with path.open('rb') as stream:
            wire = stream.read(8193)
        body = decode(wire, self.keys[role])
        if set(body) != {'domain', 'run', 'case', 'role', 'kind', 'identity', 'tick', 'payload'}:
            raise ValueError('REPORT_SCHEMA_MISMATCH')
        if (body['domain'], body['run'], body['case'], body['role'], body['kind']) != (DOMAIN, self.b['run'], self.b['case'], role, kind):
            raise ValueError('REPORT_SCOPE_MISMATCH')
        if type(body['tick']) is not int or body['tick'] < self.b['origin'] or body['tick'] > self.n.now() or body['tick'] >= self.b['outer']:
            raise ValueError('REPORT_TIME_MISMATCH')
        return body

    def await_report(self, role, kind):
        while self.n.now() < self.b['bootstrap']:
            value = self.read(role, kind)
            if value is not None:
                before(self.b['bootstrap'], self.n.now())
                return value
            self.n.api.Sleep(5)
        raise ValueError('BOOTSTRAP_EVIDENCE_MISSING')

    def child(self, role, job, caps):
        before(self.b['bootstrap'], self.n.now())
        wanted = {'O': set('OSCW'), 'S': set('SW'), 'C': {'C'}, 'W': {'W'}}[role]
        packet = {key: value for key, value in self.b.items() if key not in {'role', 'self_identity', 'keys', 'caps'}}
        packet['keys'] = {key: self.b['keys'][key] for key in wanted}
        packet['caps'] = caps
        try:
            return self.n.spawn(role, packet, HERE / 'live_roles.py', job, list(caps.values()))
        finally:
            for handle in caps.values():
                self.n.close(handle)

    def gate(self):
        if not self.n.wait(self.b['caps']['gate'], self.b['bootstrap']):
            raise ValueError('PREARM_GATE_NOT_RELEASED')
        before(self.b['bootstrap'], self.n.now())
        self.write('WORK_STARTED', {})

def check_evidence(ctx, identities, exits):
    """Match the whole fixed profile, including faults and native exit observations."""
    profile = ctx.b['case']
    codes = dict(zip('OSCW', [row['exit_code'] for row in exits]))
    expected_codes = {'cooperative': [0,0,0,0], 'controller_exit': [0,0,93,0],
        'worker_ignore': [0,0,0,73], 'supervisor_stall': [0,73,0,73],
        'observer_stall': [73,0,0,0]}
    if list(codes.values()) != expected_codes[profile] or len(exits) != 4:
        raise ValueError('NATIVE_EXIT_CONTRACT_MISMATCH')
    for role, row in zip('OSCW', exits):
        identity_matches(identities[role], row['identity'])
        if row['signaled'] is not True:
            raise ValueError('NATIVE_EXIT_NOT_OBSERVED')

    def report(role, kind, payload):
        value = ctx.read(role, kind)
        if value is None or canonical(value['payload']) != canonical(payload):
            raise ValueError('REQUIRED_REPORT_MISMATCH:' + role + '_' + kind)
        identity_matches(identities[role], value['identity'])
        if kind in {'BOOT', 'READY', 'WORK_STARTED'}:
            before(ctx.b['bootstrap'], value['tick'])
        return value

    for role in 'OSCW':
        report(role, 'WORK_STARTED', {})
        fault = ctx.read(role, 'FAULT')
        if role == 'C' and profile == 'controller_exit':
            report('C', 'FAULT', {'reason': 'APPROVED_CONTROLLER_EXIT'})
        elif fault is not None:
            raise ValueError('UNEXPECTED_ROLE_FAULT:' + role)
    report('C', 'BOOT', {})
    report('W', 'BOOT', {'stop_modify_denied': True})
    report('S', 'READY', {'worker': identities['W']})
    report('O', 'READY', {role: identities[role] for role in 'SCW'})
    if profile == 'controller_exit':
        if ctx.read('C', 'STOP_REQUEST') is not None:
            raise ValueError('UNEXPECTED_CONTROLLER_REQUEST')
    else:
        report('C', 'STOP_REQUEST', {'event_signaled': True})
    if profile == 'supervisor_stall':
        if any(ctx.read(role, kind) is not None for role, kind in [('S','CONTROL_ATTEMPT'), ('S','FINAL'), ('W','STOP_APPLIED')]):
            raise ValueError('UNEXPECTED_STALLED_SUPERVISOR_REPORT')
    else:
        report('S', 'CONTROL_ATTEMPT', {'trigger': 1 if profile == 'controller_exit' else 0, 'worker': identities['W']})
        report('S', 'FINAL', {'worker': identities['W'], 'forced': profile == 'worker_ignore', 'exit_code': codes['W']})
        if profile == 'worker_ignore':
            if ctx.read('W', 'STOP_APPLIED') is not None:
                raise ValueError('UNEXPECTED_WORKER_APPLICATION')
        else:
            report('W', 'STOP_APPLIED', {'event_observed': True})
    if ctx.read('W', 'SELF_CEILING') is not None:
        raise ValueError('UNEXPECTED_WORKER_SELF_CEILING')
    if profile == 'observer_stall':
        if ctx.read('O', 'FINAL') is not None:
            raise ValueError('UNEXPECTED_STALLED_OBSERVER_REPORT')
    else:
        report('O', 'FINAL', {**{role: codes[role] for role in 'SCW'},
            'supervisor_deadline_containment': profile == 'supervisor_stall', 'active_processes': 0})

def worker(ctx):
    n = ctx.n
    stop = ctx.b['caps']['stop']
    # A read-only inherited event must not let the worker forge its own stop request.
    if n.api.SetEvent(stop):
        raise ValueError('WORKER_HAS_EXCESS_EVENT_RIGHTS')
    if c.get_last_error() != 5:
        raise ValueError('EXPECTED_ACCESS_DENIAL_NOT_OBSERVED')
    ctx.write('BOOT', {'stop_modify_denied': True})
    ctx.gate()
    if ctx.b['case'] == 'worker_ignore':
        n.api.Sleep(30000)
        return 88
    # Leave the supervisor-stall case to O's independent control deadline, not W's timer.
    worker_ceiling = ctx.b['cleanup'] if ctx.b['case'] == 'supervisor_stall' else ctx.b['control']
    if n.wait(stop, worker_ceiling):
        ctx.write('STOP_APPLIED', {'event_observed': True})
        return 0
    ctx.write('SELF_CEILING', {})
    return 77

def controller(ctx):
    ctx.write('BOOT', {})
    ctx.gate()
    if ctx.b['case'] == 'controller_exit':
        ctx.write('FAULT', {'reason': 'APPROVED_CONTROLLER_EXIT'})
        return 93
    ctx.n.api.Sleep(200)
    before(ctx.b['control'], ctx.n.now())
    ctx.n.signal(ctx.b['caps']['request'])
    ctx.write('STOP_REQUEST', {'event_signaled': True})
    return 0

def supervisor(ctx):
    n = ctx.n
    stop = n.event()
    caps = {'gate': n.duplicate(ctx.b['caps']['gate'], SYNC), 'stop': n.duplicate(stop, SYNC)}
    target, identity = ctx.child('W', None, caps)
    boot = ctx.await_report('W', 'BOOT')
    identity_matches(identity, boot['identity'])
    ctx.write('READY', {'worker': identity})
    ctx.gate()
    if ctx.b['case'] == 'supervisor_stall':
        n.api.Sleep(30000)
        return 89
    handles = (H * 2)(ctx.b['caps']['request'], ctx.b['caps']['controller'])
    trigger = n.api.WaitForMultipleObjects(2, handles, False, n.milliseconds(ctx.b['control']))
    if trigger not in (WAIT_OBJECT, WAIT_OBJECT + 1, WAIT_TIMEOUT):
        raise c.WinError(c.get_last_error())
    n.signal(stop)
    ctx.write('CONTROL_ATTEMPT', {'trigger': int(trigger), 'worker': identity})
    grace = min(ctx.b['cleanup'], n.now() + n.frequency // 4)
    forced = False
    if not n.wait(target, grace):
        before(ctx.b['cleanup'], n.now())
        n.stop_process(target, identity)
        forced = True
    if not n.wait(target, ctx.b['cleanup']):
        raise ValueError('WORKER_EXIT_NOT_OBSERVED')
    ctx.write('FINAL', {'worker': identity, 'forced': forced, 'exit_code': n.exit_code(target)})
    return 0

def observer(ctx):
    n = ctx.n
    job = n.job()
    request = n.event()
    control, control_identity = ctx.child('C', job, {'gate': n.duplicate(ctx.b['caps']['gate'], SYNC), 'request': n.duplicate(request, 2)})
    sup, sup_identity = ctx.child('S', job, {'gate': n.duplicate(ctx.b['caps']['gate'], SYNC),
        'request': n.duplicate(request, SYNC), 'controller': n.duplicate(control, SYNC)})
    ready = ctx.await_report('S', 'READY')
    identity_matches(sup_identity, ready['identity'])
    cb = ctx.await_report('C', 'BOOT')
    identity_matches(control_identity, cb['identity'])
    worker_identity = ready['payload']['worker']
    target = n.open_identity(worker_identity, job)
    ctx.write('READY', {'S': sup_identity, 'C': control_identity, 'W': worker_identity})
    ctx.gate()
    if ctx.b['case'] == 'observer_stall':
        n.api.Sleep(30000)
        return 90
    contained = False
    if not n.wait(sup, ctx.b['control']):
        n.stop_job(job)
        contained = True
    for handle in [sup, control, target]:
        if not n.wait(handle, ctx.b['cleanup']):
            raise ValueError('CHILD_EXIT_NOT_OBSERVED')
    while n.active(job) and n.now() < ctx.b['cleanup']:
        n.api.Sleep(5)
    if n.active(job):
        raise ValueError('CHILD_JOB_NOT_EMPTY')
    ctx.write('FINAL', {'S': n.exit_code(sup), 'C': n.exit_code(control), 'W': n.exit_code(target),
        'supervisor_deadline_containment': contained, 'active_processes': 0})
    return 0

def run_case(directory, profile):
    validate_profile(profile)
    directory = directory.resolve()
    if not directory.is_relative_to(PRIVATE.resolve()) or directory.exists():
        raise ValueError('FRESH_RESTRICTED_PACKET_REQUIRED')
    directory.mkdir()
    n = Native()
    # Close the ownership boundary even if setup, observation or publication fails.
    try:
        result = run_owned_case(n, directory, profile)
    finally:
        n.close_all()
    result['end'] = n.now()
    result['elapsed_seconds'] = (result['end'] - result['origin']) / n.frequency
    result['owned_handles_closed'] = True
    result['accepted'] = result['accepted'] and result['end'] < result['outer_deadline']
    publish(directory / 'case_result.json', canonical(result))
    return result

def run_owned_case(n, directory, profile):
    root_job = n.job()
    gate = n.event()
    start = n.now()
    packet = dict(domain=DOMAIN, run=uuid.uuid4().hex, case=profile, packet=str(directory),
        sources=sources(), frequency=n.frequency, origin=start,
        bootstrap=start + 5*n.frequency, control=start + 8*n.frequency,
        cleanup=start + 10*n.frequency, outer=start + 12*n.frequency,
        role='L', self_identity=n.identity(n.api.GetCurrentProcess()),
        keys={role: secrets.token_hex(32) for role in 'LOSCW'}, caps={})
    ctx = Context(n, packet)
    observer_handle = None
    retained = []
    accepted = False
    classification = 'FAILED'
    details = {}
    identities = {}
    try:
        observer_handle, observer_identity = ctx.child('O', root_job, {'gate': n.duplicate(gate, SYNC)})
        retained.append(observer_handle)
        try:
            ready = ctx.await_report('O', 'READY')
            identity_matches(observer_identity, ready['identity'])
        except ValueError:
            fault = ctx.read('W', 'FAULT')
            if profile != 'identity_reject' or fault is None or fault['payload'].get('reason') != 'IDENTITY_MISMATCH':
                raise
            classification = 'REJECTED_BEFORE_WORK'
            accepted = True
        else:
            if profile == 'identity_reject':
                raise ValueError('INVALID_IDENTITY_WAS_ADMITTED')
            observed = ready['payload']
            if set(observed) != set('SCW') or len({row['pid'] for row in observed.values()} | {observer_identity['pid']}) != 4:
                raise ValueError('ROLE_IDENTITY_TOPOLOGY_MISMATCH')
            retained.extend(n.open_identity(observed[role], root_job) for role in 'SCW')
            identities = dict(observed, O=observer_identity)
            ctx.write('PREARM', {'actors': identities, 'sources': packet['sources'],
                'participant_data': False, 'fits': 0})
            before(packet['bootstrap'], n.now())
            n.signal(gate)
            if not n.wait(observer_handle, packet['cleanup']):
                n.stop_job(root_job)
                classification = 'OUTER_OBSERVER_CONTAINMENT'
            else:
                final = ctx.read('O', 'FINAL')
                if final is None:
                    raise ValueError('OBSERVER_FINAL_MISSING')
                classification = 'SUPERVISOR_DEADLINE_CONTAINMENT' if final['payload']['supervisor_deadline_containment'] else 'SUPERVISED_EXIT'
                details['observer'] = final['payload']
            expected = {'cooperative': 'SUPERVISED_EXIT', 'controller_exit': 'SUPERVISED_EXIT',
                'worker_ignore': 'SUPERVISED_EXIT', 'supervisor_stall': 'SUPERVISOR_DEADLINE_CONTAINMENT',
                'observer_stall': 'OUTER_OBSERVER_CONTAINMENT'}
            if classification != expected[profile]:
                raise ValueError('UNEXPECTED_CONTAINMENT_PATH')
            worker_application = ctx.read('W', 'STOP_APPLIED')
            sup_final = ctx.read('S', 'FINAL')
            details['worker_application_observed'] = worker_application is not None
            details['supervisor_final'] = sup_final['payload'] if sup_final else None
            if profile in {'cooperative', 'controller_exit'} and (worker_application is None or sup_final is None or sup_final['payload']['forced']):
                raise ValueError('COOPERATIVE_APPLICATION_NOT_ESTABLISHED')
            if profile == 'worker_ignore' and (worker_application is not None or sup_final is None or not sup_final['payload']['forced']):
                raise ValueError('FORCED_WORKER_EXIT_NOT_ESTABLISHED')
            accepted = True
    except Exception as exc:
        details['failure'] = type(exc).__name__ + ':' + str(exc)[:160]
    finally:
        if n.active(root_job):
            n.stop_job(root_job)
        exits = []
        for handle in retained:
            signaled = n.wait(handle, packet['outer'])
            exits.append({'identity': n.identity(handle), 'signaled': signaled,
                'exit_code': n.exit_code(handle) if signaled else None})
        while n.active(root_job) and n.now() < packet['outer']:
            n.api.Sleep(5)
        active = n.active(root_job)
        end = n.now()
        accepted = accepted and active == 0 and all(row['signaled'] for row in exits) and end < packet['outer']
        if accepted:
            try:
                if profile == 'identity_reject':
                    if (ctx.read('L', 'PREARM') is not None or any(ctx.read(role, 'WORK_STARTED') is not None for role in 'OSCW')
                            or len(exits) != 1 or exits[0]['exit_code'] not in {71, 73}):
                        raise ValueError('NEGATIVE_BOOTSTRAP_CONTRACT_MISMATCH')
                else:
                    check_evidence(ctx, identities, exits)
            except Exception as exc:
                accepted = False
                details['evidence_failure'] = type(exc).__name__ + ':' + str(exc)[:160]
        end = n.now()
        accepted = accepted and end < packet['outer']
        result = dict(domain=DOMAIN, case=profile, run=packet['run'], accepted=accepted,
            classification=classification, frequency=n.frequency, origin=start, end=end,
            bootstrap_deadline=packet['bootstrap'], control_deadline=packet['control'],
            cleanup_deadline=packet['cleanup'], outer_deadline=packet['outer'],
            elapsed_seconds=(end-start)/n.frequency, active_processes_after_cleanup=active,
            retained_handle_exit_observations=exits, details=details,
            participant_data=False, stata=False, fits=0, shared_service_changes=False,
            claim_production_or_participant_acceptance=False, source_hashes=packet['sources'])
    return result

def role_main(role, bootstrap_handle):
    n = Native()
    ctx = None
    try:
        packet = n.read_bootstrap(bootstrap_handle)
        if packet.get('role') != role:
            raise ValueError('ROLE_ARGUMENT_MISMATCH')
        ctx = Context(n, packet)
        ctx.admit()
        for handle in packet['caps'].values():
            n.own(handle)
        return {'O': observer, 'S': supervisor, 'C': controller, 'W': worker}[role](ctx)
    except Exception as exc:
        if ctx is not None:
            ctx.write('FAULT', {'reason': str(exc)[:160], 'type': type(exc).__name__})
        return 71
    finally:
        n.close_all()

def main(argv):
    if len(argv) == 2 and argv[0] in 'OSCW' and len(argv[0]) == 1:
        return role_main(argv[0], int(argv[1]))
    if len(argv) == 2 and argv[0] == '--approved-suite':
        directory = Path(argv[1]).resolve()
        if directory.parent != PRIVATE.resolve() or directory.exists():
            raise ValueError('Fresh suite folder under the current restricted packet required')
        grant = json.loads((PRIVATE / 'owner_grant.json').read_text(encoding='utf-8'))
        if grant != {'domain': DOMAIN, 'profiles': list(PROFILES), 'participant_data': False, 'stata': False, 'fits': 0, 'shared_service_changes': False}:
            raise ValueError('Exact artificial-only owner scope required')
        directory.mkdir()
        results = []
        for profile in PROFILES:
            result = run_case(directory / profile, profile)
            results.append(result)
            print(json.dumps({'case': profile, 'accepted': result['accepted'], 'classification': result['classification'], 'elapsed_seconds': result['elapsed_seconds']}), flush=True)
            if not result['accepted']:
                return 2
        publish(directory / 'suite_result.json', canonical({'domain': DOMAIN, 'cases': results, 'all_accepted': True,
            'participant_execution_authorized': False, 'stata_mcp_integration_verified': False}))
        return 0
    raise ValueError('No general launcher or foreign process-control interface')

if __name__ == '__main__':
    raise SystemExit(main(sys.argv[1:]))
