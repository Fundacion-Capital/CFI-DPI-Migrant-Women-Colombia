"""In-process artificial effects and selected source-only compatibility loading."""
import ast
import copy
import enum
import hashlib
import json
from pathlib import Path
import re
import threading
from types import SimpleNamespace

HERE = Path(__file__).resolve().parent
CONTRACT = HERE.parent / 'wp06-empty-stata-contract/contract.json'
MANAGER = Path('C:/Users/jzava/.cursor/extensions/deepecon.stata-mcp-0.5.3-universal/src/session_manager.py')
MANAGER_SHA = '5f9b427ffbd0d01afc51542a47f2652aff02a084c7c08cc73700ad9b8fda2308'


def scope():
    return dict(run_id='artificial-run', session_id='wp06-empty-artificial',
        worker_epoch='epoch-one', owner_nonce='nonce-one', clock_domain='fake-qpc')


def manifest():
    contract = json.loads(CONTRACT.read_text(encoding='utf-8'))
    return dict(schema='WP06_ISOLATED_STATA_MANIFEST_V1', domain='ARTIFICIAL',
        runtime_ready=False, manager_sha256=MANAGER_SHA,
        contract_sha256=hashlib.sha256(CONTRACT.read_bytes()).hexdigest(),
        literal_selections=contract['literal_selections'], bounds=contract['proposed_bounds'],
        startup_review='UNBOUND', deployment='NOT_DEPLOYED')


def source_class():
    raw = MANAGER.read_bytes()
    if hashlib.sha256(raw).hexdigest() != MANAGER_SHA:
        raise ValueError('Installed manager source changed')
    tree = ast.parse(raw.decode('utf-8-sig'))
    # Compile definitions only: no module-level imports, constructor, thread or worker start.
    wanted = {'execute', 'execute_file', '_prepare_session_for_execution',
        '_get_or_create_session', '_recover_session', '_restart_session_with_same_id',
        'restart_default_session', 'start', '_check_sessions', '_execute_command',
        '_wait_for_matching_result', 'create_session', '_create_session_internal'}
    old = next(n for n in tree.body if isinstance(n, ast.ClassDef) and n.name == 'SessionManager')
    methods = [n for n in old.body if isinstance(n, ast.FunctionDef) and n.name in wanted]
    join = next(n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == 'join_stata_line_continuations')
    for item in [*methods, join]:
        for node in ast.walk(item):
            if isinstance(node, ast.arg):
                node.annotation = None
            elif isinstance(node, ast.FunctionDef):
                node.returns = None
                node.decorator_list = []
    definition = ast.ClassDef(name='SourceManager', bases=[], keywords=[], body=methods, decorator_list=[])
    module = ast.fix_missing_locations(ast.Module(body=[join, definition], type_ignores=[]))
    class CommandType(enum.Enum):
        EXECUTE = 'execute'
        EXECUTE_FILE = 'execute_file'
    namespace = {'re': re, 'CommandType': CommandType}
    exec(compile(module, str(MANAGER) + ':definitions-only', 'exec'), namespace)
    result = namespace['SourceManager']
    result.__source_sha256__ = MANAGER_SHA
    return result


class ArtificialOwner:
    evidence_domain = 'ARTIFICIAL'
    frequency_hz = 1
    clock_domain = 'fake-qpc'

    def __init__(self):
        self.tick = 0
        self.events = []
        self.allocated = False
        self.assigned = False
        self.initialized = False
        self.closed = set()
        self.pid = 101
        self.birth = 1001
        self.fail = None
        self.exchange_hook = None
        self.result = None
        self.shutdown_hook = None
        self.exit_identity_hook = None
        self.active = 1
        self.exit_observed = True
        self.source_class = source_class()

    def now_tick(self):
        return self.tick

    def allocate_suspended(self, value):
        self.events.append('allocate')
        if self.allocated:
            raise ValueError('Second allocation')
        self.allocated = True
        self.scope = copy.deepcopy(value)
        return dict(process_handle='fake-process', job='fake-job')

    def assign_job(self, resource):
        self.events.append('assign')
        if self.fail == 'assign':
            raise ValueError('Artificial assignment failure')
        self.assigned = True

    def observe(self, resource):
        return {**self.scope, **resource, 'pid': self.pid, 'creation_time': self.birth,
            'assigned': self.assigned, 'suspended': not self.initialized}

    def initialize(self, resource):
        self.events.append('initialize')
        if not self.assigned:
            raise ValueError('Initialization before ownership')
        if self.fail == 'initialize':
            raise ValueError('Artificial initialization failure')
        self.initialized = True

    def exchange(self, resource, payload, deadline):
        self.events.append(('exchange', payload['code'], deadline))
        if self.exchange_hook:
            self.exchange_hook()
        if self.fail == 'exchange':
            raise TimeoutError('Artificial transport timeout')
        return copy.deepcopy(self.result) if self.result is not None else dict(
            status='success', output='ARTIFICIAL_OUTPUT_ONLY', error='', session_id=self.scope['session_id'], extra={})

    def control(self, resource, action):
        self.events.append(action)
        if self.fail == action:
            raise ValueError('Artificial control failure')

    def shutdown(self, resource):
        self.events.append('shutdown')
        if self.shutdown_hook:
            self.shutdown_hook()
        self.active = 0

    def observe_exit(self, resource):
        identity = self.observe(resource)
        if self.exit_identity_hook:
            self.exit_identity_hook(identity)
        return dict(identity=identity, exit_observed=self.exit_observed, active_owned=self.active)

    def close_handle(self, token):
        self.events.append(('close', token))
        self.closed.add(token)
        if self.fail == token:
            raise ValueError('Artificial closure failure')
