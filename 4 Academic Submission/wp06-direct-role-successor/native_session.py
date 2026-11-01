"""Native-domain source port of the sealed owned policy; no activation on import."""
import copy
import re
import threading
from types import SimpleNamespace, MappingProxyType
from deployment import validate


class OwnedBoundary:
    def __init__(self, base, owner, scope, manifest):
        validate(manifest)
        if (owner.evidence_domain != 'NATIVE_EMPTY' or
                getattr(base, '__source_sha256__', None) != manifest['manager_sha256']):
            raise ValueError('Only source-pinned artificial effects are admitted')
        fields = {'run_id', 'session_id', 'worker_epoch', 'owner_nonce', 'clock_domain'}
        if (type(scope) is not dict or set(scope) != fields or
                any(type(v) is not str or not re.fullmatch(r'[A-Za-z0-9_-]{1,80}', v) for v in scope.values())
                or scope['session_id'] == 'default' or owner.clock_domain != scope['clock_domain']
                or type(owner.frequency_hz) is not int or owner.frequency_hz <= 0):
            raise ValueError('Explicit artificial run/session/epoch/clock scope required')
        self._owner = owner
        self._scope = copy.deepcopy(scope)
        self._selections = tuple(manifest['literal_selections'])
        self._frequency = owner.frequency_hz
        self._source_execute = base.execute
        self._lock = threading.RLock()
        self._phase = 'NEW'
        self._failed = False
        self._resource = None
        self._identity = None
        self._pending = None
        self._controls = set()
        self._last = None
        self._now()
        self._origin = owner.origin
        self._close_started = False
        self._close_result = None
        self._close_requested = False
        self._allocation_pending = False
        self._session = SimpleNamespace(session_id=self._scope['session_id'])
        self._sessions = {}
        self.command_timeout = 10
        self.calls = 0
        self._completed = 0
        self.failures = []

    def _now(self):
        if (self._owner.evidence_domain != 'NATIVE_EMPTY' or
                self._owner.clock_domain != self._scope['clock_domain'] or
                self._owner.frequency_hz != self._frequency):
            raise ValueError('Artificial clock/owner scope changed')
        now = self._owner.now_tick()
        if type(now) is not int or now < 0 or (self._last is not None and now < self._last):
            raise ValueError('Clock invalid or rolled back')
        self._last = now
        return now

    def _before(self, seconds):
        if self._now() >= self._origin + seconds * self._frequency:
            raise ValueError('Cumulative deadline expired')

    def _fail(self, error):
        with self._lock:
            self._failed = True
            self._phase = 'FAILED'
            self.failures.append(str(error))

    def _observe(self):
        row = self._owner.observe(self._resource)
        fields = {*self._scope, 'pid', 'creation_time', 'process_handle', 'job'}
        if (set(row) != fields | {'assigned', 'suspended'} or row['assigned'] is not True
                or any(row[k] != v for k, v in self._scope.items())
                or any(type(row[k]) is not int or row[k] <= 0 for k in ('pid', 'creation_time'))
                or any(row[k] != self._resource[k] for k in ('process_handle', 'job'))):
            raise ValueError('Ownership observation invalid')
        identity = {k: row[k] for k in fields}
        if self._identity is not None and identity != self._identity:
            raise ValueError('Owned physical epoch changed')
        return identity, row['suspended']

    def open(self):
        with self._lock:
            if self._phase != 'NEW':
                self._fail('Creation reservation already consumed')
                raise ValueError('No second creation or replacement')
            self._phase = 'CREATING'
            self._allocation_pending = True
        try:
            self._before(60)
            with self._lock:
                if self._failed or self._close_requested or self._close_started:
                    raise ValueError('Creation admission was closed before allocation')
            allocated = self._owner.allocate_suspended(copy.deepcopy(self._scope))
            with self._lock:
                self._resource = MappingProxyType(copy.deepcopy(allocated))
                if self._failed or self._close_requested or self._close_started:
                    raise ValueError('Creation returned after closure was requested')
            if set(self._resource) != {'process_handle', 'job'} or not all(self._resource.values()):
                raise ValueError('No exact owned resource capabilities')
            self._owner.assign_job(self._resource)
            with self._lock:
                if self._failed or self._close_requested or self._close_started:
                    raise ValueError('Ownership assignment returned after closure')
            self._identity, suspended = self._observe()
            if suspended is not True:
                raise ValueError('Initialization must follow suspended ownership')
            self._before(60)
            if self._failed or self._close_requested or self._close_started:
                raise ValueError('Initialization admission was closed')
            self._owner.initialize(self._resource)
            self._before(60)
            _, suspended = self._observe()
            if suspended is not False:
                raise ValueError('Artificial initialization incomplete')
            with self._lock:
                self._allocation_pending = False
                if self._failed or self._close_started:
                    raise ValueError('Admission was closed during initialization')
                self._sessions[self._scope['session_id']] = self._session
                self._phase = 'READY'
        except BaseException as error:
            with self._lock:
                self._allocation_pending = False
                self._fail(error)
                needs_cleanup = not self._close_started
            if needs_cleanup:
                self.close()
            raise ValueError('Owned bootstrap failed; reservation consumed') from error
        return self._scope['session_id']

    def execute(self, code, session_id=None, timeout=None, execution_id=None):
        try:
            with self._lock:
                if self._failed or self._phase != 'READY' or self._close_started:
                    raise ValueError('Run is not open for admission')
                self._before(80)
                self._observe()
                if (session_id != self._scope['session_id'] or type(timeout) is not int or timeout != 10
                        or execution_id is not None or self.calls >= 2 or code != self._selections[self.calls]):
                    raise ValueError('Only the next literal bound selection is permitted')
                self.calls += 1  # Consume before any transport effect, including timeout.
                self._pending = dict(code=code, sent=False,
                    transport_code=code.removesuffix('\n'),
                    execution_id=f"{self._scope['run_id']}-{self.calls}",
                    deadline=self._now() + 10 * self._frequency)
                self._phase = 'BUSY'
            result = self._source_execute(self, code, session_id=session_id, timeout=10,
                execution_id=self._pending['execution_id'])
            with self._lock:
                self._observe()
                if self._failed or self._close_started or self._phase != 'BUSY':
                    raise ValueError('Result arrived after admission closed')
                if self._now() >= self._pending['deadline']:
                    raise ValueError('Late result; no retry')
                self._before(90)
                if (type(result) is not dict or set(result) != {'status', 'output', 'error', 'session_id', 'extra'}
                        or result['status'] != 'success' or result['error'] != ''
                        or type(result['output']) is not str or result['extra'] != {}
                        or result['session_id'] != self._scope['session_id']):
                    raise ValueError('Malformed, failed, recovered or auxiliary result')
                self._pending = None
                self._completed += 1
                self._phase = 'READY'
            return copy.deepcopy(result)
        except Exception as error:
            self._fail(error)
            raise ValueError('Selection rejected; run consumed without recovery') from error

    def _prepare_session_for_execution(self, session_id, timeout):
        with self._lock:
            if (self._phase != 'BUSY' or self._failed or self._pending is None
                    or session_id != self._scope['session_id'] or timeout != 10
                    or self._sessions.get(session_id) is not self._session):
                self._fail('Invalid direct preparation attempt')
                raise ValueError('No implicit creation or source preparation recovery')
            return self._session, None, None

    def _execute_command(self, session, command_type, payload, timeout):
        with self._lock:
            if (self._pending is None or self._pending['sent'] or self._phase != 'BUSY'
                    or self._failed or self._close_started or session is not self._session
                    or getattr(command_type, 'name', None) != 'EXECUTE' or timeout != 10
                    or payload != {'code': self._pending['transport_code'],
                        'execution_id': self._pending['execution_id'], 'timeout': 10}):
                self._fail('Invalid direct command attempt')
                raise ValueError('No low-level command or transport bypass')
            self._observe()
            self._before(80)
            self._pending['sent'] = True
            deadline = self._pending['deadline']
        # The control callback never waits for this request lock or uses MCP recovery.
        return self._owner.exchange(self._resource, copy.deepcopy(payload), deadline)

    def control_tick(self):
        actions = []
        with self._lock:
            if self._phase == 'CLOSED':
                return
            if self._resource is None:
                self._fail('No owned resource exists for control')
                return
            try:
                now = self._now()
                if self._phase == 'CREATING' and now >= self._origin + 60 * self._frequency:
                    self._fail('Bootstrap expired')
                for seconds, action in ((90, 'cooperative_stop'), (95, 'supervisor_containment'),
                        (100, 'observer_containment'), (110, 'outer_containment')):
                    if now >= self._origin + seconds * self._frequency and action not in self._controls:
                        self._controls.add(action)
                        self._fail('Control deadline reached')
                        actions.append(action)
            except Exception as error:
                self._fail(error)
                raise ValueError('Clock/control quarantined') from error
        for action in actions:
            try:
                with self._lock:
                    if self._close_result is not None:
                        return
                    self._owner.control(self._resource, action)
            except Exception as error:
                self._fail(error)

    def close(self):
        with self._lock:
            if self._close_result is not None:
                return copy.deepcopy(self._close_result)
            self._close_requested = True
            if self._close_started:
                return dict(accepted=False, cleanup_pending=True, calls=self.calls,
                    completed=self._completed, failures=list(self.failures),
                    domain='NATIVE_EMPTY', execution_ready=False)
            if self._allocation_pending:
                self._fail('Cleanup awaits the in-flight bootstrap outcome')
                self._owner.request_cleanup()
                return dict(accepted=False, cleanup_pending=True, calls=self.calls,
                    completed=self._completed, failures=list(self.failures),
                    domain='NATIVE_EMPTY', execution_ready=False)
            if getattr(self._owner, '_rollback_started', False) and self._owner.rollback_result is None:
                return dict(accepted=False, cleanup_pending=True, calls=self.calls,
                    completed=self._completed, failures=list(self.failures),
                    domain='NATIVE_EMPTY', execution_ready=False)
            self._close_started = True
            self._phase = 'CLOSING'
        cleanup_complete = True
        rollback = getattr(self._owner, 'rollback_result', None)
        if rollback is not None:
            cleanup_complete = rollback['cleanup_complete']
            if not cleanup_complete:
                self._fail('Recorded native rollback was incomplete: '+str(rollback['failures']))
        elif self._resource is not None:
            try:
                if self._identity is not None:
                    self._observe()
            except BaseException as error:
                cleanup_complete = False
                self._fail(type(error).__name__+': '+str(error))
            try:
                self._owner.shutdown(self._resource)
            except BaseException as error:
                cleanup_complete = False
                self._fail(type(error).__name__+': '+str(error))
            try:
                evidence = self._owner.observe_exit(self._resource)
                if evidence['exit_observed'] is not True or evidence['active_owned'] != 0:
                    raise ValueError('Exit/owned-inventory evidence missing')
                if self._identity is not None and {k: evidence['identity'].get(k) for k in self._identity} != self._identity:
                    raise ValueError('Exit witness belongs to a different physical epoch')
            except BaseException as error:
                cleanup_complete = False
                self._fail(type(error).__name__+': '+str(error))
            finally:
                for token in self._resource.values():
                    try:
                        self._owner.close_handle(token)
                    except BaseException as error:
                        cleanup_complete = False
                        self._fail(type(error).__name__+': '+str(error))
        try:
            self._before(120)
        except BaseException as error:
            cleanup_complete = False
            self._fail(type(error).__name__+': '+str(error))
        with self._lock:
            if getattr(self._owner, '_rollback_started', False) and self._owner.rollback_result is None:
                cleanup_complete = False
                self._fail('Native rollback evidence is still pending')
            if getattr(self._owner, 'handles', []):
                cleanup_complete = False
                self._fail('Retained native capabilities remain after cleanup')
            result = dict(accepted=cleanup_complete and not self._failed and self.calls == self._completed == 2,
                cleanup_complete=cleanup_complete, calls=self.calls, completed=self._completed,
                failures=list(self.failures), domain='NATIVE_EMPTY', execution_ready=False)
            try:
                self._owner.record_cleanup(result)
            except BaseException as error:
                self._fail(type(error).__name__+': '+str(error))
                result.update(accepted=False, cleanup_complete=False, failures=list(self.failures))
            self._sessions.clear()
            self._close_result = copy.deepcopy(result)
            self._phase = 'CLOSED'
            return copy.deepcopy(self._close_result)

    def _forbidden(self, *args, **kwargs):
        self._fail('Legacy lifecycle/file/control entry point forbidden')
        raise ValueError('No default, recovery, restart, replacement or foreign cleanup')

    start = _forbidden
    stop = _forbidden
    create_session = _forbidden
    _create_session_internal = _forbidden
    _restart_session_with_same_id = _forbidden
    restart_default_session = _forbidden
    _recover_session = _forbidden
    _check_sessions = _forbidden
    execute_file = _forbidden
    get_data = _forbidden
    stop_execution = _forbidden
    _terminate_worker = _forbidden
    destroy_session = _forbidden
    _get_or_create_session = _forbidden
    _wait_for_matching_result = _forbidden


def isolated_manager(base_class, owner, scope, manifest):
    # A new class only: neither an existing manager nor the installed class is patched.
    class IsolatedManager(OwnedBoundary, base_class):
        pass
    return IsolatedManager(base_class, owner, scope, manifest)


def bind_dispatcher(manager):
    if not isinstance(manager, OwnedBoundary):
        raise ValueError('No exact isolated manager; never fall back')
    # The manager is captured once, never accepted from a request or later route argument.
    def dispatch_selection(parameters, multi_session_enabled):
        if multi_session_enabled is not True or type(parameters) is not dict or set(parameters) != {'selection', 'session_id', 'timeout'}:
            manager._forbidden()
        return manager.execute(parameters['selection'], session_id=parameters['session_id'], timeout=parameters['timeout'])
    return dispatch_selection
