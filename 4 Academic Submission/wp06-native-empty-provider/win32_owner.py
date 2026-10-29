"""Lazy Win32 implementation. Construction is denied before DLL load without authority."""
import ctypes as c
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
from deployment import require_execution, validate

HERE = Path(__file__).resolve().parent
CONTROL = HERE.parent / 'wp06-live-control/live_windows.py'
spec = importlib.util.spec_from_file_location('wp06_reviewed_native_primitives', CONTROL)
legacy = importlib.util.module_from_spec(spec)
spec.loader.exec_module(legacy)  # Definitions only; Native.__init__ is not called here.
H, D, SIZE = legacy.H, legacy.D, legacy.SIZE


class Kernel(legacy.Native):
    def __init__(self, binding, grant, api=None):
        self.pending = {}
        if api is not None:
            if getattr(api, 'evidence_scope', None) != 'FAKE_WIN32_ABI':
                raise ValueError('Only explicitly simulated ABI injection is allowed')
            validate(binding)
            self.api, self.frequency, self.handles = api, api.frequency, set()
            self.evidence_scope = 'FAKE_WIN32'
            return
        require_execution(binding, grant)  # Must precede WinDLL, QPC or any native probe.
        super().__init__()
        self.evidence_scope = 'LIVE_NATIVE_EMPTY'
        self.api.CreateFileW.argtypes = [c.c_wchar_p, D, D, H, D, D, H]
        self.api.CreateFileW.restype = H
        self.api.GetModuleFileNameW.argtypes = [H, c.c_wchar_p, D]
        self.api.GetModuleFileNameW.restype = D

    def module_path(self, handle):
        buffer = c.create_unicode_buffer(32768)
        length = self.api.GetModuleFileNameW(handle, buffer, len(buffer))
        self.ok(length)
        if length >= len(buffer):
            raise ValueError('Resolved module path was truncated')
        return Path(buffer.value)

    def assign(self, job, process):
        self.ok(self.api.AssignProcessToJobObject(job, process))

    def job(self):
        before = set(self.handles)
        try:
            return super().job()
        except Exception:
            for handle in self.handles - before:
                self.close(handle)
            raise

    def member(self, process, job):
        value = c.c_int()
        self.ok(self.api.IsProcessInJob(process, job, c.byref(value)))
        return value.value == 1

    def signaled(self, process):
        status = self.api.WaitForSingleObject(process, 0)
        if status not in (0, 258):
            raise OSError('Native wait failed')
        return status == 0

    def pause(self):
        self.api.Sleep(5)

    def _file(self, path, access, disposition):
        security = legacy.SECURITY_ATTRIBUTES(c.sizeof(legacy.SECURITY_ATTRIBUTES), None, True)
        handle = self.api.CreateFileW(str(path), access, 0, c.byref(security), disposition, 0x80, None)
        if handle in (None, H(-1).value):
            raise OSError('Private child stream could not be opened')
        return self.own(handle)

    def spawn_suspended(self, role, binding, inherited):
        validate(binding)
        if role not in {'worker', 'watchdog'} or Path(binding['entry']).resolve() != HERE / 'runtime_roles.py':
            raise ValueError('Only fixed native-empty role entry points may launch')
        before = set(self.handles)
        reader, writer = H(), H()
        security = legacy.SECURITY_ATTRIBUTES(c.sizeof(legacy.SECURITY_ATTRIBUTES), None, True)
        process = legacy.PROCESS_INFORMATION()
        attributes = None
        initialized_attributes = False
        try:
            self.ok(self.api.CreatePipe(c.byref(reader), c.byref(writer), c.byref(security), 16384))
            self.own(reader.value); self.own(writer.value)
            self.ok(self.api.SetHandleInformation(writer, 1, 0))
            root = Path(binding['private_root'])
            output = self._file(root / (role + '.stdout.log'), 0x40000000, 1)
            input_handle = self._file('NUL', 0x80000000, 3)
            handles = [reader.value, output, input_handle, *inherited.values()]
            if len(handles) != len(set(handles)):
                raise ValueError('Duplicate inherited capabilities')
            values = (H * len(handles))(*handles)
            size = SIZE()
            self.api.InitializeProcThreadAttributeList(None, 1, 0, c.byref(size))
            attributes = c.create_string_buffer(size.value)
            self.ok(self.api.InitializeProcThreadAttributeList(attributes, 1, 0, c.byref(size)))
            initialized_attributes = True
            self.ok(self.api.UpdateProcThreadAttribute(attributes, 0, 0x20002, values, c.sizeof(values), None, None))
            startup = legacy.STARTUPINFOEX()
            startup.StartupInfo.cb = c.sizeof(startup)
            startup.StartupInfo.dwFlags = 0x101  # Hidden window and explicit private standard handles.
            startup.StartupInfo.wShowWindow = 0
            startup.StartupInfo.hStdInput = input_handle
            startup.StartupInfo.hStdOutput = output
            startup.StartupInfo.hStdError = output
            startup.lpAttributeList = c.cast(attributes, H).value
            command = c.create_unicode_buffer(subprocess.list2cmdline([binding['python'], '-I', '-S', '-B', '-X', 'utf8',
                binding['entry'], role, str(reader.value), str(root / 'active_binding.json')]))
            environment = dict(SYSTEMROOT=os.environ['SYSTEMROOT'], TEMP=str(root / 'temp'),
                TMP=str(root / 'temp'), STATATMP=str(root / 'temp'), USERPROFILE=str(root / 'home'))
            block = c.create_unicode_buffer('\0'.join(k + '=' + v for k, v in sorted(environment.items())) + '\0\0')
            self.ok(self.api.CreateProcessW(binding['python'], command, None, None, True,
                0x80000 | 0x400 | 0x4 | 0x8000000, block, str(root), c.byref(startup), c.byref(process)))
            self.own(process.hProcess); self.own(process.hThread)
            self.pending[process.hProcess] = dict(writer=writer.value, thread=process.hThread,
                identity=self.identity(process.hProcess), inherited=dict(inherited))
            for handle in (reader.value, output, input_handle):
                self.close(handle)
            return process.hProcess
        except Exception:
            if process.hProcess:
                self.api.TerminateProcess(process.hProcess, 73)
                self.api.WaitForSingleObject(process.hProcess, 2000)
            failures = []
            for handle in list(self.handles - before):
                try:
                    self.close(handle)
                except Exception as error:
                    failures.append(error)
            if failures:
                raise ExceptionGroup('Native creation and rollback failed', failures)
            raise
        finally:
            if initialized_attributes:
                self.api.DeleteProcThreadAttributeList(attributes)

    def bootstrap(self, process, packet):
        row = self.pending[process]
        body = dict(packet, identity=row['identity'], inherited=row['inherited'])
        wire = json.dumps(body, separators=(',', ':')).encode('utf-8')
        if len(wire) > 8192:
            raise ValueError('Bootstrap exceeds inherited pipe capacity budget')
        frame = len(wire).to_bytes(4, 'little') + wire
        written = D()
        self.ok(self.api.WriteFile(row['writer'], frame, len(frame), c.byref(written), None))
        if written.value != len(frame):
            raise OSError('Incomplete private bootstrap write')
        self.close(row.pop('writer'))

    def resume(self, process):
        row = self.pending[process]
        if 'writer' in row:
            raise ValueError('No resume before bootstrap is complete')
        if self.api.ResumeThread(row['thread']) == 0xffffffff:
            raise OSError('ResumeThread failed')
        self.close(row.pop('thread'))

    def close(self, handle):
        row = self.pending.get(handle, {})
        failures = []
        targets = [row[name] for name in ('writer', 'thread') if name in row] + [handle]
        for target in dict.fromkeys(targets):
            try:
                super().close(target)
            except Exception as error:
                failures.append(error)
        for process, metadata in list(self.pending.items()):
            for name in ('writer', 'thread'):
                if metadata.get(name) not in self.handles:
                    metadata.pop(name, None)
            if process not in self.handles and not any(name in metadata for name in ('writer', 'thread')):
                self.pending.pop(process)
        if failures:
            raise ExceptionGroup('All retained close operations attempted', failures)

    def read_private_bootstrap(self, handle):
        self.own(handle)
        def exact(count):
            data = bytearray()
            while len(data) < count:
                buffer = c.create_string_buffer(count - len(data))
                used = D()
                self.ok(self.api.ReadFile(handle, buffer, len(buffer), c.byref(used), None))
                if used.value == 0:
                    raise OSError('Private bootstrap pipe closed early')
                data.extend(buffer.raw[:used.value])
            return bytes(data)
        try:
            size = int.from_bytes(exact(4), 'little')
            if not 1 <= size <= 8192:
                raise ValueError('Invalid bootstrap length')
            return json.loads(exact(size))
        finally:
            self.close(handle)
