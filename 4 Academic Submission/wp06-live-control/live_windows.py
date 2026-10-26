"""Narrow Win32 primitives for this package's disposable artificial roles only."""
import ctypes as c
import json
import os
from pathlib import Path
import subprocess
import sys

STAGE = Path(__file__).resolve().parents[1] / 'wp06-stage-b'
sys.path.insert(0, str(STAGE))
from native_backend import FILETIME, STARTUPINFOEX, PROCESS_INFORMATION, SECURITY_ATTRIBUTES, abi_signatures

H = c.c_void_p
D = c.c_uint32
SIZE = c.c_size_t
WAIT_OBJECT = 0
WAIT_TIMEOUT = 258
SYNC = 0x100000
QUERY = 0x1000

class BasicLimits(c.Structure):
    _fields_ = [('process_time', c.c_int64), ('job_time', c.c_int64), ('flags', D),
        ('min_ws', SIZE), ('max_ws', SIZE), ('active_limit', D), ('affinity', SIZE),
        ('priority', D), ('scheduling', D)]

class IoCounters(c.Structure):
    _fields_ = [(name, c.c_uint64) for name in ['read_ops', 'write_ops', 'other_ops', 'read_bytes', 'write_bytes', 'other_bytes']]

class ExtendedLimits(c.Structure):
    _fields_ = [('basic', BasicLimits), ('io', IoCounters), ('process_memory', SIZE),
        ('job_memory', SIZE), ('peak_process_memory', SIZE), ('peak_job_memory', SIZE)]

class Accounting(c.Structure):
    _fields_ = [('user', c.c_int64), ('kernel', c.c_int64), ('period_user', c.c_int64),
        ('period_kernel', c.c_int64), ('faults', D), ('total', D), ('active', D), ('terminated', D)]

class Native:
    def __init__(self):
        if os.name != 'nt' or c.sizeof(H) != 8:
            raise RuntimeError('This isolated harness requires 64-bit Windows')
        self.api = c.WinDLL('kernel32', use_last_error=True)
        wanted = {'CreateProcessW', 'InitializeProcThreadAttributeList', 'UpdateProcThreadAttribute',
            'DeleteProcThreadAttributeList', 'GetCurrentProcess', 'DuplicateHandle', 'CloseHandle',
            'GetProcessId', 'GetProcessTimes', 'ResumeThread', 'WaitForSingleObject',
            'GetExitCodeProcess', 'SetEvent', 'CreateEventW', 'TerminateProcess',
            'ReadFile', 'WriteFile', 'QueryPerformanceCounter', 'QueryPerformanceFrequency'}
        signatures = {name: signature for name, signature in abi_signatures().items() if name in wanted}
        signatures.update({
            'CreateJobObjectW': ([H, c.c_wchar_p], H),
            'SetInformationJobObject': ([H, c.c_int, H, D], c.c_int),
            'AssignProcessToJobObject': ([H, H], c.c_int),
            'QueryInformationJobObject': ([H, c.c_int, H, D, H], c.c_int),
            'TerminateJobObject': ([H, D], c.c_int),
            'IsProcessInJob': ([H, H, H], c.c_int),
            'OpenProcess': ([D, c.c_int, D], H),
            'CreatePipe': ([H, H, H, D], c.c_int),
            'SetHandleInformation': ([H, D, D], c.c_int),
            'WaitForMultipleObjects': ([D, H, c.c_int, D], D),
            'Sleep': ([D], None)})
        for name, (args, result) in signatures.items():
            function = getattr(self.api, name)
            function.argtypes = args
            function.restype = result
        frequency = c.c_int64()
        self.ok(self.api.QueryPerformanceFrequency(c.byref(frequency)))
        self.frequency = frequency.value
        self.handles = set()

    def ok(self, value):
        if not value:
            raise c.WinError(c.get_last_error())
        return value

    def own(self, handle):
        self.ok(handle)
        self.handles.add(handle)
        return handle

    def close(self, handle):
        if handle in self.handles:
            self.ok(self.api.CloseHandle(handle))
            self.handles.remove(handle)

    def close_all(self):
        errors = []
        for handle in list(self.handles):
            try:
                self.close(handle)
            except OSError as exc:
                errors.append(exc)
        if errors:
            raise ExceptionGroup('Owned handle closure failed', errors)

    def now(self):
        value = c.c_int64()
        self.ok(self.api.QueryPerformanceCounter(c.byref(value)))
        return value.value

    def milliseconds(self, deadline):
        remaining = deadline - self.now()
        return max(0, min(12000, (remaining * 1000 + self.frequency - 1) // self.frequency))

    def event(self):
        return self.own(self.api.CreateEventW(None, True, False, None))

    def duplicate(self, handle, access):
        result = H()
        current = self.api.GetCurrentProcess()
        self.ok(self.api.DuplicateHandle(current, handle, current, c.byref(result), access, True, 0))
        return self.own(result.value)

    def signal(self, handle):
        self.ok(self.api.SetEvent(handle))

    def wait(self, handle, deadline):
        result = self.api.WaitForSingleObject(handle, self.milliseconds(deadline))
        if result not in (WAIT_OBJECT, WAIT_TIMEOUT):
            raise c.WinError(c.get_last_error())
        return result == WAIT_OBJECT

    def identity(self, handle):
        created, exited, kernel, user = FILETIME(), FILETIME(), FILETIME(), FILETIME()
        self.ok(self.api.GetProcessTimes(handle, c.byref(created), c.byref(exited), c.byref(kernel), c.byref(user)))
        pid = self.api.GetProcessId(handle)
        self.ok(pid)
        return {'pid': pid, 'birth': (created.high << 32) | created.low}

    def open_identity(self, expected, job):
        handle = self.own(self.api.OpenProcess(SYNC | QUERY, False, expected['pid']))
        try:
            if self.identity(handle) != expected:
                raise ValueError('Process creation identity mismatch')
            member = c.c_int()
            self.ok(self.api.IsProcessInJob(handle, job, c.byref(member)))
            if member.value != 1:
                raise ValueError('Process is outside this owned job')
            return handle
        except Exception:
            self.close(handle)
            raise

    def job(self):
        handle = self.own(self.api.CreateJobObjectW(None, None))
        limits = ExtendedLimits()
        limits.basic.flags = 0x2000  # Kill descendants if the owning role exits/closes the job.
        self.ok(self.api.SetInformationJobObject(handle, 9, c.byref(limits), c.sizeof(limits)))
        return handle

    def active(self, job):
        value = Accounting()
        self.ok(self.api.QueryInformationJobObject(job, 1, c.byref(value), c.sizeof(value), None))
        return value.active

    def stop_job(self, job):
        if job not in self.handles:
            raise ValueError('Unowned or closed job')
        self.ok(self.api.TerminateJobObject(job, 73))

    def stop_process(self, handle, expected):
        if handle not in self.handles or self.identity(handle) != expected:
            raise ValueError('Unowned process or changed creation identity')
        self.ok(self.api.TerminateProcess(handle, 73))

    def exit_code(self, handle):
        if self.api.WaitForSingleObject(handle, 0) != WAIT_OBJECT:
            raise ValueError('Exit cannot be credited before process signaling')
        code = D()
        self.ok(self.api.GetExitCodeProcess(handle, c.byref(code)))
        return code.value

    def spawn(self, role, bootstrap, script, job, capabilities=()):
        """No arbitrary executable: only this interpreter and the pinned role script."""
        if role not in {'O', 'S', 'C', 'W'} or script != Path(__file__).with_name('live_roles.py').resolve():
            raise ValueError('Only fixed artificial role entry points may launch')
        reader, writer = H(), H()
        security = SECURITY_ATTRIBUTES(c.sizeof(SECURITY_ATTRIBUTES), None, True)
        self.ok(self.api.CreatePipe(c.byref(reader), c.byref(writer), c.byref(security), 16384))
        self.own(reader.value); self.own(writer.value)
        self.ok(self.api.SetHandleInformation(writer, 1, 0))
        inherited = [reader.value, *capabilities]
        values = (H * len(inherited))(*inherited)
        size = SIZE()
        self.api.InitializeProcThreadAttributeList(None, 1, 0, c.byref(size))
        storage = c.create_string_buffer(size.value)
        self.ok(self.api.InitializeProcThreadAttributeList(storage, 1, 0, c.byref(size)))
        process = PROCESS_INFORMATION()
        try:
            self.ok(self.api.UpdateProcThreadAttribute(storage, 0, 0x20002, values, c.sizeof(values), None, None))
            startup = STARTUPINFOEX()
            startup.StartupInfo.cb = c.sizeof(startup)
            startup.StartupInfo.dwFlags = 1
            startup.StartupInfo.wShowWindow = 0
            startup.lpAttributeList = c.cast(storage, H).value
            command = c.create_unicode_buffer(subprocess.list2cmdline([sys.executable, '-I', '-S', str(script), role, str(reader.value)]))
            environment = c.create_unicode_buffer('SYSTEMROOT=' + os.environ['SYSTEMROOT'] + '\0\0')
            self.ok(self.api.CreateProcessW(c.c_wchar_p(sys.executable), command, None, None, True,
                0x80000 | 0x400 | 0x4 | 0x8000000, environment, c.c_wchar_p(str(script.parent)), c.byref(startup), c.byref(process)))
            self.own(process.hProcess); self.own(process.hThread)
            expected = self.identity(process.hProcess)
            if job is not None:
                self.ok(self.api.AssignProcessToJobObject(job, process.hProcess))
            payload = dict(bootstrap, role=role, self_identity=expected)
            if payload.get('case') == 'identity_reject' and role == 'W':
                payload['self_identity'] = dict(expected, birth=expected['birth'] + 1)
            wire = json.dumps(payload, separators=(',', ':')).encode('utf-8')
            if len(wire) > 8192:
                raise ValueError('Bootstrap exceeds private pipe budget')
            if self.api.ResumeThread(process.hThread) == 0xffffffff:
                raise c.WinError(c.get_last_error())
            written = D()
            frame = len(wire).to_bytes(4, 'little') + wire
            self.ok(self.api.WriteFile(writer, frame, len(frame), c.byref(written), None))
            if written.value != len(frame):
                raise ValueError('Partial bootstrap write')
            return process.hProcess, expected
        except Exception:
            if process.hProcess:
                self.api.TerminateProcess(process.hProcess, 73)
                self.api.WaitForSingleObject(process.hProcess, 2000)
                self.close(process.hProcess)
            raise
        finally:
            self.api.DeleteProcThreadAttributeList(storage)
            if process.hThread:
                self.close(process.hThread)
            self.close(reader.value); self.close(writer.value)

    def read_bootstrap(self, handle):
        self.own(handle)
        def exact(count):
            buffer = c.create_string_buffer(count)
            used = D()
            self.ok(self.api.ReadFile(handle, buffer, count, c.byref(used), None))
            if used.value != count:
                raise ValueError('Incomplete private bootstrap')
            return buffer.raw
        try:
            size = int.from_bytes(exact(4), 'little')
            if not 1 <= size <= 8192:
                raise ValueError('Bootstrap size outside bound')
            return json.loads(exact(size))
        finally:
            self.close(handle)
