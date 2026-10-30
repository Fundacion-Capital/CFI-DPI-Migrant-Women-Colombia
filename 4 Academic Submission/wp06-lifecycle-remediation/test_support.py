"""Native-operation simulations only; no kernel DLL, process or Stata is touched."""
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
CONTRACT = HERE.parent / 'wp06-empty-stata-contract/contract.json'


def binding(root):
    raw = CONTRACT.read_bytes()
    contract = json.loads(raw)
    return dict(schema='WP06_NATIVE_EMPTY_V1', domain='NATIVE_EMPTY', runtime_ready=False, activation_allowed=False,
        activation_holds=['NO_EXECUTION_AUTHORITY', 'STARTUP_REVIEW_PENDING'],
        manager_sha256='5f9b427ffbd0d01afc51542a47f2652aff02a084c7c08cc73700ad9b8fda2308',
        contract_sha256=hashlib.sha256(raw).hexdigest(),
        literal_selections=contract['literal_selections'], bounds=contract['proposed_bounds'],
        python='C:/fixed/python.exe', entry=str(HERE / 'runtime_roles.py'),
        private_root=str(root), stata_home='C:/fixed/Stata19', site_packages='C:/fixed/site-packages',
        source_root=str(HERE), runtime_inventory=None,
        runtime_identity_files={name: [dict(path='C:/artificial/' + name, bytes=1, sha256='0' * 64)]
            for name in ('engine', 'python_image', 'pystata_config', 'pystata_stata')})


def scope():
    return dict(run_id='native-test', session_id='wp06-native-test', worker_epoch='epoch-one',
        owner_nonce='nonce-one', clock_domain='fake-qpc')


def prepared_binding(base):
    from startup_guard import spec, reserve
    windows = base / 'windows'
    (windows / 'System32').mkdir(parents=True)
    stata = base / 'stata'
    stata.mkdir()
    value = binding(base / 'run')
    value.update(stata_home=str(stata), run_scope=scope(), startup_contract=spec(str(windows)))
    reserve(value)
    return value


class FakeKernel:
    evidence_scope = 'FAKE_WIN32'
    frequency = 1

    def __init__(self):
        self.tick = 0
        self.events = []
        self.handles = set()
        self.closed = set()
        self.next = 100
        self.processes = {}
        self.members = {}
        self.fail = None
        self.birth_delta = 0
        self.event_states = {}

    def handle(self):
        self.next += 1
        self.handles.add(self.next)
        return self.next

    def now(self):
        return self.tick

    def job(self):
        value = self.handle()
        self.members[value] = set()
        self.events.append(('job', value))
        return value

    def event(self):
        value = self.handle()
        self.event_states[value] = False
        return value

    def spawn_suspended(self, role, descriptor, inherited):
        self.events.append(('spawn', role))
        if self.fail == role:
            raise ValueError('Artificial creation failure')
        process = self.handle()
        self.processes[process] = dict(pid=process + 1000, birth=process + 2000,
            alive=True, resumed=False, role=role)
        return process

    def assign(self, job, process):
        self.events.append(('assign', job, process))
        if self.fail == 'assign':
            raise ValueError('Artificial job assignment failure')
        self.members[job].add(process)

    def member(self, process, job):
        return process in self.members[job]

    def identity(self, process):
        row = self.processes[process]
        return dict(pid=row['pid'], birth=row['birth'] + self.birth_delta)

    def resume(self, process):
        self.events.append(('resume', self.processes[process]['role']))
        self.processes[process]['resumed'] = True

    def bootstrap(self, process, packet):
        self.events.append(('bootstrap', self.processes[process]['role']))

    def duplicate(self, handle, access):
        self.events.append(('duplicate', access))
        return self.handle()

    def parent_handle(self):
        return self.handle()

    def signal(self, event):
        self.events.append('signal_stop')
        self.event_states[event] = True

    def active(self, job):
        return sum(self.processes[p]['alive'] for p in self.members[job])

    def stop_job(self, job):
        self.events.append(('terminate_job', job))
        for process in self.members[job]:
            self.processes[process]['alive'] = False

    def stop_process(self, process, expected):
        if process not in self.handles or self.identity(process) != expected:
            raise ValueError('No retained physical process identity')
        self.events.append(('terminate_process', process))
        self.processes[process]['alive'] = False

    def signaled(self, process):
        return not self.processes[process]['alive'] if process in self.processes else self.event_states.get(process, False)

    def finish(self, process):
        self.processes[process]['alive'] = False

    def exit_code(self, process):
        if not self.signaled(process):
            raise ValueError('Exit not observed')
        return 0

    def pause(self):
        self.tick += 1

    def close(self, handle):
        self.events.append(('close', handle))
        self.handles.discard(handle)
        self.closed.add(handle)
        if self.fail == handle:
            raise ValueError('Artificial closure failure')


class FakeChannel:
    def __init__(self, kernel):
        self.kernel = kernel
        self.events = []
        self.fail = None

    def prepare(self, descriptor, value, keys):
        self.scope = copy.deepcopy(value)
        self.descriptor = copy.deepcopy(descriptor)

    def reserve(self):
        self.events.append('reserve')

    def record_parent(self, kind, payload):
        self.events.append(('record_parent', kind, copy.deepcopy(payload)))

    def wait(self, role, kind, sequence, deadline):
        self.events.append(('wait', role, kind, sequence))
        if self.fail == 'timeout':
            self.kernel.tick = deadline
            raise TimeoutError('Artificial response timeout')
        if kind == 'ready':
            if role == 'worker':
                return {'ready': True, 'runtime_identity':
                    {name: rows[0] for name, rows in self.descriptor['runtime_identity_files'].items()}}
            return {'ready': True}
        return dict(status='success', output='NATIVE_SIMULATION_ONLY', error='',
            session_id=self.scope['session_id'], extra={})

    def publish(self, role, kind, sequence, payload):
        self.events.append(('publish', role, kind, sequence, copy.deepcopy(payload)))
        if kind == 'shutdown':
            for process in self.kernel.processes:
                self.kernel.finish(process)
