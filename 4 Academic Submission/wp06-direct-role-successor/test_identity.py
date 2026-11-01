"""Loaded-path evidence is tested with artificial bytes, not a native runtime."""

import ctypes
import hashlib
from pathlib import Path
from types import SimpleNamespace
import tempfile
import unittest
import deployment
import runtime_roles
import win32_owner
from test_support import binding


class IdentityTests(unittest.TestCase):
    def fixture(self, folder):
        descriptor = binding(Path(folder))
        paths = {
            'engine': Path(folder) / 'mp-64.dll',
            'python_image': Path(folder) / 'python.exe',
            'pystata_config': Path(folder) / 'config.py',
            'pystata_stata': Path(folder) / 'stata.py'}
        descriptor['runtime_identity_files'] = {}
        for name, path in paths.items():
            data = ('artificial:' + name).encode()
            path.write_bytes(data)
            descriptor['runtime_identity_files'][name] = [dict(path=str(path.resolve()),
                bytes=len(data), sha256=hashlib.sha256(data).hexdigest())]
        kernel = SimpleNamespace(module_path=lambda handle: paths['python_image'] if handle is None else paths['engine'])
        config = SimpleNamespace(__file__=paths['pystata_config'], stlib=SimpleNamespace(_handle=123))
        stata = SimpleNamespace(__file__=paths['pystata_stata'])
        return descriptor, paths, kernel, config, stata

    def test_loaded_identity_matches_exact_pinned_artificial_files(self):
        with tempfile.TemporaryDirectory(prefix='wp06_identity_') as folder:
            descriptor, paths, kernel, config, stata = self.fixture(folder)
            proof = runtime_roles.capture_runtime_identity(descriptor, kernel, config, stata)
            self.assertEqual(set(proof), set(paths))
            deployment.check_runtime_identity(descriptor, proof)

    def test_modified_loaded_file_cannot_be_reported_as_pinned(self):
        with tempfile.TemporaryDirectory(prefix='wp06_identity_') as folder:
            descriptor, paths, kernel, config, stata = self.fixture(folder)
            paths['engine'].write_bytes(b'changed')
            with self.assertRaises(ValueError):
                runtime_roles.capture_runtime_identity(descriptor, kernel, config, stata)

    def test_wrong_resolved_engine_path_rejected(self):
        with tempfile.TemporaryDirectory(prefix='wp06_identity_') as folder:
            descriptor, paths, kernel, config, stata = self.fixture(folder)
            kernel.module_path = lambda handle: paths['python_image']
            with self.assertRaises(ValueError):
                runtime_roles.capture_runtime_identity(descriptor, kernel, config, stata)

    def test_missing_engine_identity_cannot_be_adopted(self):
        with tempfile.TemporaryDirectory(prefix='wp06_identity_') as folder:
            descriptor, paths, kernel, config, stata = self.fixture(folder)
            with self.assertRaises(ValueError):
                deployment.check_runtime_identity(descriptor, {})

    def test_resolved_module_path_uses_supplied_handle_without_a_dll_load(self):
        calls = []
        def module_filename(handle, buffer, limit):
            calls.append((handle, limit))
            buffer.value = 'C:\\artificial\\mp-64.dll'
            return len(buffer.value)
        kernel = object.__new__(win32_owner.Kernel)
        kernel.api = SimpleNamespace(GetModuleFileNameW=module_filename)
        self.assertEqual(str(kernel.module_path(123)), 'C:\\artificial\\mp-64.dll')
        self.assertEqual(calls[0][0], 123)
