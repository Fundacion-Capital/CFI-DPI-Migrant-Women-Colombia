"""Concrete native ownership/control operations, injectable only for no-execution tests."""
import copy
import secrets
import threading
from deployment import validate, digest, check_runtime_identity

SYNC_QUERY = 0x101000
JOB_CONTROL = 0xC  # JOB_OBJECT_QUERY | JOB_OBJECT_TERMINATE
EVENT_SIGNAL = 2


class NativeOwner:
    evidence_domain = 'NATIVE_EMPTY'

    def __init__(self, kernel, channel, binding, scope):
        validate(binding)
        if kernel.evidence_scope not in {'FAKE_WIN32', 'LIVE_NATIVE_EMPTY'}:
            raise ValueError('Unknown native-effect evidence scope')
        self.kernel, self.channel = kernel, channel
        self.binding, self.scope = copy.deepcopy(binding), copy.deepcopy(scope)
        self.evidence_scope = kernel.evidence_scope
        self.frequency_hz = kernel.frequency
        self.clock_domain = scope['clock_domain']
        self.keys = {role: secrets.token_bytes(32) for role in ('worker', 'watchdog')}
        self.channel.prepare(binding, scope, self.keys)
        self.origin = kernel.now()
        self.used = False
        self.assigned = False
        self.initialized = False
        self.handles = []
        self.worker = self.watchdog = self.inner = self.outer = self.stop = self.ready = None
        self.commands = 0
        self.identities = {}
        self._rollback_lock = threading.Lock()
        self._rollback_started = False
        self._rollback_result = None
        self._creation_pending = False
        self._rollback_requested = False

    def request_cleanup(self):
        with self._rollback_lock:
            self._rollback_requested = True

    def _check_creation(self):
        with self._rollback_lock:
            if self._rollback_requested or self._rollback_started:
                raise ValueError('Native creation admission was closed')

    @property
    def rollback_result(self):
        with self._rollback_lock:
            return copy.deepcopy(self._rollback_result)

    def record_cleanup(self, result):
        self.channel.record_parent('cleanup', copy.deepcopy(result))

    def now_tick(self):
        return self.kernel.now()

    def _keep(self, handle):
        self.handles.append(handle)
        return handle

    def _rollback(self):
        with self._rollback_lock:
            self._rollback_requested = True
            if self._creation_pending:
                return dict(cleanup_pending=True,cleanup_complete=False)
            if self._rollback_started:
                if self._rollback_result is None:
                    return dict(cleanup_pending=True,cleanup_complete=False)
                return copy.deepcopy(self._rollback_result)
            self._rollback_started = True
        failures = []
        for job in (self.inner, self.outer):
            if job is not None:
                try:
                    if job not in self.handles:
                        raise ValueError('No retained job capability for rollback')
                    self.kernel.stop_job(job)
                except BaseException as error:
                    failures.append(error)
        failures.extend(self._stop_retained())
        ceiling = self.origin + 110 * self.frequency_hz
        observations = []
        for process in (self.worker, self.watchdog):
            if process is not None:
                try:
                    if process not in self.handles:
                        raise ValueError('No retained process capability for rollback')
                    while not self.kernel.signaled(process) and self.kernel.now() < ceiling:
                        self.kernel.pause()
                    if not self.kernel.signaled(process):
                        raise TimeoutError('Partial allocation exit not observed')
                    identity = self.kernel.identity(process)
                    if identity != self.identities[process]:
                        raise ValueError('Rollback process identity changed')
                    observations.append(dict(identity=identity, exit_observed=True, exit_code=self.kernel.exit_code(process)))
                except BaseException as error:
                    failures.append(error)
        identity = None
        active_owned = None
        try:
            if self.worker is not None:
                actual = self.kernel.identity(self.worker)
                identity = {**self.scope, 'process_handle':self.worker, 'job':self.inner,
                    'pid':actual['pid'], 'creation_time':actual['birth']}
            active_owned = self.kernel.active(self.outer) if self.outer is not None else 0
            if active_owned != 0:
                raise ValueError('Rollback still has active owned processes')
        except BaseException as error:
            failures.append(error)
        exit_observed = len(observations)==sum(p is not None for p in (self.worker,self.watchdog))
        try:
            self.channel.record_parent('exit', dict(evidence_scope=self.evidence_scope, rollback=True,
                processes=observations, exit_observed=exit_observed, identity=identity,
                active_owned=active_owned, failures=[type(e).__name__+': '+str(e) for e in failures], tick=self.kernel.now()))
        except BaseException as error:
            failures.append(error)
        for handle in list(dict.fromkeys(self.handles)):
            try:
                self.kernel.close(handle)
                self.handles.remove(handle)
            except BaseException as error:
                failures.append(error)
        try:
            self.channel.record_parent('closure', dict(evidence_scope=self.evidence_scope, rollback=True,
                owner_handles_remaining=len(self.handles), kernel_handles_remaining=len(self.kernel.handles),
                failures=[type(e).__name__+': '+str(e) for e in failures], tick=self.kernel.now()))
        except BaseException as error:
            failures.append(error)
        result = dict(identity=identity, exit_observed=exit_observed, active_owned=active_owned,
            cleanup_complete=not failures and exit_observed and active_owned==0 and not self.handles,
            failures=[type(e).__name__+': '+str(e) for e in failures])
        with self._rollback_lock:
            self._rollback_result = copy.deepcopy(result)
        if failures:
            raise BaseExceptionGroup('Partial native allocation cleanup failed', failures)
        return copy.deepcopy(result)

    def allocate_suspended(self, scope):
        with self._rollback_lock:
            if self.used or scope != self.scope or self._rollback_requested:
                raise ValueError('Native creation reservation consumed or foreign')
            self.used = True
            self._creation_pending = True
        try:
            self.channel.reserve()
            self.outer = self._keep(self.kernel.job())
            self.inner = self._keep(self.kernel.job())
            self.stop = self._keep(self.kernel.event())
            self.ready = self._keep(self.kernel.event())
            worker_stop = self._keep(self.kernel.duplicate(self.stop, 0x100000))
            worker_ready = self._keep(self.kernel.duplicate(self.ready, EVENT_SIGNAL))
            self._check_creation()
            self.worker = self._keep(self.kernel.spawn_suspended('worker', self.binding,
                {'stop_event': worker_stop, 'ready_event': worker_ready}))
            self.identities[self.worker] = self.kernel.identity(self.worker)
            self._check_creation()
            return dict(process_handle=self.worker, job=self.inner)
        except BaseException as primary:
            with self._rollback_lock:
                self._creation_pending = False
            try:
                self._rollback()
            except BaseException as cleanup:
                raise BaseExceptionGroup(type(primary).__name__+': '+str(primary)+'; allocation rollback also failed', [primary,cleanup]) from primary
            raise
        finally:
            with self._rollback_lock:
                self._creation_pending = False
                contain = self._rollback_requested and not self._rollback_started
            if contain:
                self._rollback()

    def _exact(self, resource):
        if dict(resource) != {'process_handle': self.worker, 'job': self.inner}:
            raise ValueError('No foreign resource')

    def _stop_retained(self):
        failures = []
        for process in (self.worker, self.watchdog):
            if process is not None and process in self.handles:
                try:
                    if not self.kernel.signaled(process):
                        self.kernel.stop_process(process, self.identities[process])
                except BaseException as error:
                    failures.append(error)
        return failures

    def assign_job(self, resource):
        self._check_creation()
        self._exact(resource)
        self.kernel.assign(self.outer, self.worker)
        self.kernel.assign(self.inner, self.worker)
        self.assigned = True
        self.channel.record_parent('ownership', dict(evidence_scope=self.evidence_scope,
            identity=self.kernel.identity(self.worker), inner_member=self.kernel.member(self.worker, self.inner),
            outer_member=self.kernel.member(self.worker, self.outer), origin=self.origin, frequency=self.frequency_hz))

    def observe(self, resource):
        with self._rollback_lock:
            self._exact(resource)
            if self._rollback_started or any(h not in self.handles for h in (self.worker,self.inner,self.outer)):
                raise ValueError('No new observation after capability cleanup begins')
            actual = self.kernel.identity(self.worker)
            member = self.kernel.member(self.worker, self.inner) and self.kernel.member(self.worker, self.outer)
            return {**self.scope, **dict(resource), 'pid': actual['pid'], 'creation_time': actual['birth'],
                'assigned': self.assigned and member, 'suspended': not self.initialized}

    def initialize(self, resource):
        self._exact(resource)
        if not self.assigned or self.initialized or self.watchdog is not None:
            raise ValueError('Native initialization cannot repeat or precede ownership')
        with self._rollback_lock:
            if self._rollback_requested or self._rollback_started:
                raise ValueError('Native initialization admission was closed')
            self._creation_pending = True
        try:
            inner_copy = self._keep(self.kernel.duplicate(self.inner, JOB_CONTROL))
            worker_copy = self._keep(self.kernel.duplicate(self.worker, SYNC_QUERY))
            stop_copy = self._keep(self.kernel.duplicate(self.stop, EVENT_SIGNAL))
            ready_copy = self._keep(self.kernel.duplicate(self.ready, 0x100000))
            self._check_creation()
            self.watchdog = self._keep(self.kernel.spawn_suspended('watchdog', self.binding,
                dict(inner_job=inner_copy, worker=worker_copy, stop_event=stop_copy, ready_event=ready_copy)))
            self.identities[self.watchdog] = self.kernel.identity(self.watchdog)
            self._check_creation()
            self.kernel.assign(self.outer, self.watchdog)
            common = dict(scope=self.scope, origin=self.origin, frequency=self.frequency_hz,
                binding_sha256=digest(self.binding), worker_identity=self.kernel.identity(self.worker))
            self.kernel.bootstrap(self.watchdog, {**common, 'role': 'watchdog',
                'key': self.keys['watchdog'].hex()})
            self.kernel.resume(self.watchdog)
            ready = self.channel.wait('watchdog', 'ready', 0, self.origin + 60 * self.frequency_hz)
            if ready != {'ready': True}:
                raise ValueError('Independent watchdog readiness not established')
            self._check_creation()
            self.kernel.bootstrap(self.worker, {**common, 'role': 'worker',
                'key': self.keys['worker'].hex()})
            self.kernel.resume(self.worker)
            ready = self.channel.wait('worker', 'ready', 0, self.origin + 60 * self.frequency_hz)
            if type(ready) is not dict or set(ready) != {'ready', 'runtime_identity'} or ready['ready'] is not True:
                raise ValueError('Worker initialization readiness not established')
            check_runtime_identity(self.binding, ready['runtime_identity'])
            self.channel.record_parent('runtime', ready['runtime_identity'])
            self.initialized = True
        except BaseException as primary:
            with self._rollback_lock:
                self._creation_pending = False
            try:
                self._rollback()
            except BaseException as cleanup:
                raise BaseExceptionGroup(type(primary).__name__+': '+str(primary)+'; initialization rollback also failed', [primary,cleanup]) from primary
            raise
        finally:
            with self._rollback_lock:
                self._creation_pending = False
                contain = self._rollback_requested and not self._rollback_started
            if contain:
                self._rollback()

    def exchange(self, resource, payload, deadline):
        self._exact(resource)
        if (not self.initialized or self.commands >= 2 or payload != dict(
                code=self.binding['literal_selections'][self.commands].removesuffix('\n'),
                timeout=10, execution_id=f"{self.scope['run_id']}-{self.commands + 1}")):
            raise ValueError('No arbitrary native command or replay')
        self.commands += 1
        try:
            self.channel.publish('worker', 'command', self.commands, payload)
            return self.channel.wait('worker', 'result', self.commands, deadline)
        except Exception:
            self.kernel.signal(self.stop)
            self.kernel.stop_job(self.inner)
            raise

    def control(self, resource, action):
        with self._rollback_lock:
            self._exact(resource)
            if self._rollback_started or any(h not in self.handles for h in (self.stop,self.inner,self.outer)):
                raise ValueError('No control through disposed capabilities')
            if action == 'cooperative_stop':
                self.kernel.signal(self.stop)
            elif action in {'supervisor_containment', 'observer_containment'}:
                self.kernel.stop_job(self.inner)
            elif action == 'outer_containment':
                self.kernel.stop_job(self.outer)
            else:
                raise ValueError('No unscoped native control')

    def shutdown(self, resource):
        self._exact(resource)
        if self.worker not in self.handles:
            return
        if not self.initialized:
            failures = self._stop_retained()
            if failures:
                raise ExceptionGroup('Uninitialized retained process containment failed', failures)
        else:
            self.channel.publish('worker', 'shutdown', 0, {'shutdown': True})
        ceiling = self.origin + 110 * self.frequency_hz
        if self.kernel.signaled(self.worker) and (self.watchdog is None or self.kernel.signaled(self.watchdog)):
            return
        while self.kernel.now() < ceiling:
            if self.kernel.signaled(self.worker) and (self.watchdog is None or self.kernel.signaled(self.watchdog)):
                return
            if self.kernel.now() >= self.origin + 95 * self.frequency_hz:
                self.kernel.stop_job(self.inner)
            if self.kernel.now() >= self.origin + 100 * self.frequency_hz:
                self.kernel.stop_job(self.outer)
            self.kernel.pause()
        self.kernel.stop_job(self.outer)
        raise TimeoutError('Native cleanup exceeded envelope')

    def observe_exit(self, resource):
        self._exact(resource)
        if self.rollback_result is not None:
            result = self.rollback_result
            return dict(identity=result['identity'],exit_observed=result['exit_observed'],active_owned=result['active_owned'])
        exits = self.kernel.signaled(self.worker) and (self.watchdog is None or self.kernel.signaled(self.watchdog))
        if exits:
            exits = self.kernel.exit_code(self.worker) == 0
            if self.watchdog is not None:
                exits = exits and self.kernel.exit_code(self.watchdog) == 0
        result = dict(identity=self.observe(resource), exit_observed=exits,
            active_owned=self.kernel.active(self.outer))
        self.channel.record_parent('exit', dict(evidence_scope=self.evidence_scope,
            worker=self.kernel.identity(self.worker), worker_exit=self.kernel.exit_code(self.worker) if self.kernel.signaled(self.worker) else None,
            watchdog_exit=self.kernel.exit_code(self.watchdog) if self.watchdog is not None and self.kernel.signaled(self.watchdog) else None,
            active_owned=result['active_owned'], tick=self.kernel.now()))
        return result

    def close_handle(self, token):
        with self._rollback_lock:
            if self._rollback_started or token not in self.handles:
                return
            if token == self.inner:
                failures = []
                for handle in list(dict.fromkeys(self.handles)):
                    try:
                        self.kernel.close(handle)
                        self.handles.remove(handle)
                    except BaseException as error:
                        failures.append(error)
                self.channel.record_parent('closure', dict(evidence_scope=self.evidence_scope,
                    owner_handles_remaining=len(self.handles), kernel_handles_remaining=len(self.kernel.handles),
                    failures=[str(error) for error in failures], tick=self.kernel.now()))
                if failures:
                    raise BaseExceptionGroup('All native closure attempts completed with failures', failures)
            else:
                self.kernel.close(token)
                self.handles.remove(token)
