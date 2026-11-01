"""Exercise actual ctypes argument construction using Python fake ABI functions."""
import ctypes as c
from pathlib import Path
import tempfile
import unittest
from test_support import binding
from win32_owner import Kernel, H, D, SIZE, legacy


class FakeABI:
    evidence_scope = 'FAKE_WIN32_ABI'
    frequency = 1

    def __init__(self):
        self.next = 10
        self.closed = []
        self.resumed = []
        self.attributes = None
        self.command = None
        self.flags = None
        self.frame = None
        self.input = bytearray()

    def CreatePipe(self, reader, writer, security, size):
        c.cast(reader, c.POINTER(H)).contents.value = 11
        c.cast(writer, c.POINTER(H)).contents.value = 12
        return 1

    def SetHandleInformation(self, *args):
        return 1

    def CreateFileW(self, *args):
        self.next += 1
        return 100 + self.next

    def InitializeProcThreadAttributeList(self, storage, count, flags, size):
        c.cast(size, c.POINTER(SIZE)).contents.value = 256
        return 1 if storage is not None else 0

    def UpdateProcThreadAttribute(self, storage, flags, attribute, values, size, previous, used):
        self.attributes = list(values)
        return 1

    def DeleteProcThreadAttributeList(self, *args):
        return None

    def CreateProcessW(self, app, command, a, b, inherit, flags, environment, cwd, startup, info):
        self.command, self.flags = command.value, flags
        self.environment = environment.value
        row = c.cast(info, c.POINTER(legacy.PROCESS_INFORMATION)).contents
        row.hProcess, row.hThread = 501, 502
        return 1

    def GetProcessTimes(self, process, created, exited, kernel, user):
        value = c.cast(created, c.POINTER(legacy.FILETIME)).contents
        value.low, value.high = 1001, 0
        return 1

    def GetProcessId(self, process):
        return 700

    def CloseHandle(self, handle):
        self.closed.append(handle)
        return 1

    def WriteFile(self, handle, frame, size, used, overlap):
        self.frame = bytes(frame)
        c.cast(used, c.POINTER(D)).contents.value = size
        return 1

    def ReadFile(self, handle, target, size, used, overlap):
        length = min(size, 2, len(self.input))
        value = bytes(self.input[:length])
        del self.input[:length]
        c.memmove(target, value, length)
        c.cast(used, c.POINTER(D)).contents.value = length
        return 1

    def ResumeThread(self, handle):
        self.resumed.append(handle)
        return 1


class NativeABITests(unittest.TestCase):
    def test_suspended_hidden_exact_capabilities_and_bootstrap_before_resume(self):
        with tempfile.TemporaryDirectory(prefix='wp06_fake_abi_') as directory:
            from test_support import prepared_binding
            value = prepared_binding(Path(directory))
            api = FakeABI()
            kernel = Kernel(value, None, api=api)
            process = kernel.spawn_suspended('worker', value, {'stop_event': 999})
            self.assertTrue(api.flags & 4)
            self.assertTrue(api.flags & 0x8000000)
            self.assertIn('-I -S -B -X utf8', api.command)
            self.assertIn(999, api.attributes)
            self.assertNotIn(12, api.attributes)
            self.assertEqual(api.resumed, [])
            with self.assertRaises(ValueError):
                kernel.resume(process)
            kernel.bootstrap(process, {'role': 'worker', 'key': 'not-an-account-secret'})
            kernel.resume(process)
            self.assertEqual(api.resumed, [502])
            self.assertNotIn('not-an-account-secret', api.command)
            kernel.close(process)
            self.assertEqual(kernel.handles, set())

    def test_bootstrap_reader_handles_short_reads_and_closes_its_capability(self):
        import json
        with tempfile.TemporaryDirectory(prefix='wp06_fake_abi_') as directory:
            api = FakeABI()
            raw = json.dumps({'role': 'worker'}).encode()
            api.input = bytearray(len(raw).to_bytes(4, 'little') + raw)
            kernel = Kernel(binding(Path(directory)), None, api=api)
            self.assertEqual(kernel.read_private_bootstrap(333), {'role': 'worker'})
            self.assertEqual(kernel.handles, set())

    def test_wrong_entry_cannot_create_a_process(self):
        with tempfile.TemporaryDirectory(prefix='wp06_fake_abi_') as directory:
            value = binding(Path(directory))
            api = FakeABI()
            kernel = Kernel(value, None, api=api)
            value['entry'] = 'C:/other/runtime_roles.py'
            with self.assertRaises(ValueError):
                kernel.spawn_suspended('worker', value, {})
            self.assertIsNone(api.command)
