"""Concrete native ownership/control operations, injectable only for no-execution tests."""
import copy
import secrets
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

    def now_tick(self):
        return self.kernel.now()

    def _keep(self, handle):
        self.handles.append(handle)
        return handle

    def _rollback(self):
        failures = []
        for job in (self.inner, self.outer):
            if job is not None:
                try:
                    self.kernel.stop_job(job)
                except Exception as error:
                    failures.append(error)
        failures.extend(self._stop_retained())
        ceiling = self.origin + 110 * self.frequency_hz
        for process in (self.worker, self.watchdog):
            if process is not None:
                try:
                    while not self.kernel.signaled(process) and self.kernel.now() < ceiling:
                        self.kernel.pause()
                    if not self.kernel.signaled(process):
                        raise TimeoutError('Partial allocation exit not observed')
                    self.kernel.exit_code(process)
                except Exception as error:
                    failures.append(error)
        for handle in list(dict.fromkeys(self.handles)):
            try:
                self.kernel.close(handle)
            except Exception as error:
                failures.append(error)
        self.handles.clear()
        if failures:
            raise ExceptionGroup('Partial native allocation cleanup failed', failures)

    def allocate_suspended(self, scope):
        if self.used or scope != self.scope:
            raise ValueError('Native creation reservation consumed or foreign')
        self.used = True
        try:
            self.channel.reserve()
            self.outer = self._keep(self.kernel.job())
            self.inner = self._keep(self.kernel.job())
            self.stop = self._keep(self.kernel.event())
            self.ready = self._keep(self.kernel.event())
            worker_stop = self._keep(self.kernel.duplicate(self.stop, 0x100000))
            worker_ready = self._keep(self.kernel.duplicate(self.ready, EVENT_SIGNAL))
            self.worker = self._keep(self.kernel.spawn_suspended('worker', self.binding,
                {'stop_event': worker_stop, 'ready_event': worker_ready}))
            self.identities[self.worker] = self.kernel.identity(self.worker)
            return dict(process_handle=self.worker, job=self.inner)
        except Exception:
            self._rollback()
            raise

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
                except Exception as error:
                    failures.append(error)
        return failures

    def assign_job(self, resource):
        self._exact(resource)
        self.kernel.assign(self.outer, self.worker)
        self.kernel.assign(self.inner, self.worker)
        self.assigned = True
        self.channel.record_parent('ownership', dict(evidence_scope=self.evidence_scope,
            identity=self.kernel.identity(self.worker), inner_member=self.kernel.member(self.worker, self.inner),
            outer_member=self.kernel.member(self.worker, self.outer), origin=self.origin, frequency=self.frequency_hz))

    def observe(self, resource):
        self._exact(resource)
        actual = self.kernel.identity(self.worker)
        member = self.kernel.member(self.worker, self.inner) and self.kernel.member(self.worker, self.outer)
        return {**self.scope, **dict(resource), 'pid': actual['pid'], 'creation_time': actual['birth'],
            'assigned': self.assigned and member, 'suspended': not self.initialized}

    def initialize(self, resource):
        self._exact(resource)
        if not self.assigned or self.initialized or self.watchdog is not None:
            raise ValueError('Native initialization cannot repeat or precede ownership')
        try:
            inner_copy = self._keep(self.kernel.duplicate(self.inner, JOB_CONTROL))
            worker_copy = self._keep(self.kernel.duplicate(self.worker, SYNC_QUERY))
            stop_copy = self._keep(self.kernel.duplicate(self.stop, EVENT_SIGNAL))
            ready_copy = self._keep(self.kernel.duplicate(self.ready, 0x100000))
            self.watchdog = self._keep(self.kernel.spawn_suspended('watchdog', self.binding,
                dict(inner_job=inner_copy, worker=worker_copy, stop_event=stop_copy, ready_event=ready_copy)))
            self.identities[self.watchdog] = self.kernel.identity(self.watchdog)
            self.kernel.assign(self.outer, self.watchdog)
            common = dict(scope=self.scope, origin=self.origin, frequency=self.frequency_hz,
                binding_sha256=digest(self.binding), worker_identity=self.kernel.identity(self.worker))
            self.kernel.bootstrap(self.watchdog, {**common, 'role': 'watchdog',
                'key': self.keys['watchdog'].hex()})
            self.kernel.resume(self.watchdog)
            ready = self.channel.wait('watchdog', 'ready', 0, self.origin + 60 * self.frequency_hz)
            if ready != {'ready': True}:
                raise ValueError('Independent watchdog readiness not established')
            self.kernel.bootstrap(self.worker, {**common, 'role': 'worker',
                'key': self.keys['worker'].hex()})
            self.kernel.resume(self.worker)
            ready = self.channel.wait('worker', 'ready', 0, self.origin + 60 * self.frequency_hz)
            if type(ready) is not dict or set(ready) != {'ready', 'runtime_identity'} or ready['ready'] is not True:
                raise ValueError('Worker initialization readiness not established')
            check_runtime_identity(self.binding, ready['runtime_identity'])
            self.channel.record_parent('runtime', ready['runtime_identity'])
            self.initialized = True
        except Exception:
            self._rollback()
            raise

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
        self._exact(resource)
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
        if token not in self.handles:
            return
        if token == self.inner:
            failures = []
            for handle in list(dict.fromkeys(self.handles)):
                try:
                    self.kernel.close(handle)
                    self.handles.remove(handle)
                except Exception as error:
                    failures.append(error)
            self.channel.record_parent('closure', dict(evidence_scope=self.evidence_scope,
                owner_handles_remaining=len(self.handles), kernel_handles_remaining=len(self.kernel.handles),
                failures=[str(error) for error in failures], tick=self.kernel.now()))
            if failures:
                raise ExceptionGroup('All native closure attempts completed with failures', failures)
        else:
            self.kernel.close(token)
            self.handles.remove(token)
