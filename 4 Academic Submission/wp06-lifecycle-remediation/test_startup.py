"""Real filesystem guard tests with artificial paths and bytes; no engine or launch."""
import importlib
from pathlib import Path
import stat
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch
from test_support import binding, scope

try:
    startup = importlib.import_module('startup_guard')
except ModuleNotFoundError:
    startup = None


class StartupFixture(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(startup, 'Startup implementation missing')
        self.temp = tempfile.TemporaryDirectory(prefix='wp06_startup_')
        self.addCleanup(self.temp.cleanup)
        self.base = Path(self.temp.name)
        self.root = self.base / 'run'
        self.win = self.base / 'windows'
        (self.win / 'System32').mkdir(parents=True)
        self.stata = self.base / 'stata'
        self.stata.mkdir()
        self.value = binding(self.root)
        self.value.update(stata_home=str(self.stata), run_scope=scope(),
            startup_contract=startup.spec(str(self.win)))


class StartupTests(StartupFixture):
    def test_unknown_root_input_is_rejected_without_reading_it(self):
        startup.reserve(self.value)
        (self.root / 'unapproved-input.dta').write_bytes(b'artificial file, not participant data')
        with self.assertRaises(ValueError):
            startup.verify(self.value)

    def test_foreign_source_cannot_pass_base_binding_validation(self):
        from deployment import validate
        self.value['source_root'] = str(self.base / 'foreign')
        with self.assertRaises(ValueError):
            validate(self.value)

    def test_explicit_path_is_bounded_not_inherited(self):
        env = startup.environment(self.value)
        self.assertEqual(env['PATH'], str(self.win / 'System32') + ';' + str(self.win))
        self.assertEqual(set(env), {'SYSTEMROOT','PATH','USERPROFILE','TEMP','TMP','STATATMP'})

    def test_fresh_reservation_has_inert_profiles_and_empty_private_dirs(self):
        startup.reserve(self.value)
        startup.verify(self.value)
        for name in ('profile.do','sysprofile.do'):
            lines = (self.root / name).read_text().splitlines()
            self.assertTrue(lines)
            self.assertTrue(all(line.startswith('* ') for line in lines))
        self.assertEqual(list((self.root / 'home').iterdir()), [])
        self.assertEqual(list((self.root / 'temp').iterdir()), [])

    def test_existing_root_is_retained_and_rejected(self):
        self.root.mkdir()
        retained = self.root / 'retained.txt'
        retained.write_bytes(b'artificial retained original')
        with self.assertRaises(FileExistsError):
            startup.reserve(self.value)
        self.assertEqual(retained.read_bytes(), b'artificial retained original')

    def test_reservation_cannot_repeat(self):
        startup.reserve(self.value)
        with self.assertRaises(FileExistsError):
            startup.reserve(self.value)

    def test_altered_profile_rejected_before_use(self):
        startup.reserve(self.value)
        (self.root / 'profile.do').write_bytes(b'use fictional-data.dta\n')
        with self.assertRaises(ValueError):
            startup.verify(self.value)

    def test_unknown_home_content_is_not_read_or_accepted(self):
        startup.reserve(self.value)
        (self.root / 'home/pystata.conf').write_bytes(b'artificial unexpected configuration')
        with self.assertRaises(ValueError):
            startup.verify(self.value)

    def test_missing_private_directory_is_not_recreated(self):
        startup.reserve(self.value)
        (self.root / 'temp').rmdir()
        with self.assertRaises((ValueError, FileNotFoundError)):
            startup.verify(self.value)
        self.assertFalse((self.root / 'temp').exists())

    def test_installation_profile_precedence_rejects_before_reservation(self):
        (self.stata / 'profile.do').write_bytes(b'* artificial\n')
        with self.assertRaises(ValueError):
            startup.reserve(self.value)
        self.assertFalse(self.root.exists())


class CallerTests(StartupFixture):
    def test_unexpected_temp_content_is_retained_and_rejected(self):
        startup.reserve(self.value)
        target = self.root / 'temp' / 'unaccounted.conf'
        target.write_bytes(b'artificial input retained')
        with self.assertRaises(ValueError):
            startup.verify(self.value)
        self.assertEqual(target.read_bytes(), b'artificial input retained')

    def test_nonempty_temp_rejects_before_fake_process_creation(self):
        from test_abi import FakeABI
        from win32_owner import Kernel
        startup.reserve(self.value)
        target = self.root / 'temp' / 'unaccounted.conf'
        target.write_bytes(b'artificial input retained')
        api = FakeABI()
        with self.assertRaises(ValueError):
            Kernel(self.value, None, api=api).spawn_suspended('worker', self.value, {})
        self.assertIsNone(api.command)
        self.assertEqual(target.read_bytes(), b'artificial input retained')

    def test_nonempty_temp_rejects_before_any_pystata_import(self):
        import builtins
        import os
        import sys
        from runtime_roles import StataEngine
        from test_support import FakeKernel
        startup.reserve(self.value)
        target = self.root / 'temp' / 'unaccounted.conf'
        target.write_bytes(b'artificial input retained')
        imports = []
        original = builtins.__import__
        def guarded(name, *args, **kwargs):
            if name.startswith('pystata'):
                imports.append(name)
                raise RuntimeError('A real engine is forbidden in this test')
            return original(name, *args, **kwargs)
        error = None
        with patch.object(builtins, '__import__', guarded), patch.object(sys, 'path', list(sys.path)), patch.dict(os.environ):
            try:
                StataEngine(self.value, FakeKernel(), 123)
            except Exception as observed:
                error = observed
        self.assertEqual(imports, [])
        self.assertIsInstance(error, ValueError)
        self.assertEqual(target.read_bytes(), b'artificial input retained')

    def test_channel_cannot_create_an_unprepared_root(self):
        from private_channel import Channel
        from test_support import FakeKernel
        channel = Channel(FakeKernel())
        with self.assertRaises((ValueError, FileNotFoundError)):
            channel.prepare(self.value, scope(), {'worker': b'x' * 32})
        self.assertFalse(self.root.exists())

    def test_channel_attach_cannot_recreate_a_missing_home(self):
        from private_channel import Channel
        from test_support import FakeKernel
        startup.reserve(self.value)
        (self.root / 'home').rmdir()
        with self.assertRaises((ValueError, FileNotFoundError)):
            Channel(FakeKernel()).prepare(self.value, scope(), {'worker': b'x' * 32})
        self.assertFalse((self.root / 'home').exists())

    def test_spawn_rejects_higher_priority_profile_before_fake_process_creation(self):
        from test_abi import FakeABI
        from win32_owner import Kernel
        startup.reserve(self.value)
        (self.stata / 'profile.do').write_bytes(b'* artificial precedence\n')
        api = FakeABI()
        with self.assertRaises(ValueError):
            Kernel(self.value, None, api=api).spawn_suspended('worker', self.value, {})
        self.assertIsNone(api.command)

    def test_spawn_supplies_the_explicit_bounded_path(self):
        from test_abi import FakeABI
        from win32_owner import Kernel
        startup.reserve(self.value)
        class RecordedABI(FakeABI):
            def CreateProcessW(api, app, command, a, b, inherit, flags, environment, cwd, si, info):
                api.environment = ''.join(environment).split('\0')
                return super().CreateProcessW(app, command, a, b, inherit, flags, environment, cwd, si, info)
        api = RecordedABI()
        kernel = Kernel(self.value, None, api=api)
        process = kernel.spawn_suspended('worker', self.value, {})
        kernel.close(process)
        self.assertIn('PATH=' + str(self.win / 'System32') + ';' + str(self.win), api.environment)

    def test_worker_rechecks_before_any_pystata_import(self):
        import builtins
        import os
        import sys
        from runtime_roles import StataEngine
        from test_support import FakeKernel
        startup.reserve(self.value)
        (self.stata / 'sysprofile.do').write_bytes(b'* artificial precedence\n')
        imports = []
        original = builtins.__import__
        def guarded(name, *args, **kwargs):
            if name.startswith('pystata'):
                imports.append(name)
                raise RuntimeError('A real engine import is forbidden in this test')
            return original(name, *args, **kwargs)
        error = None
        with patch.object(builtins, '__import__', guarded), patch.object(sys, 'path', list(sys.path)), patch.dict(os.environ):
            try:
                StataEngine(self.value, FakeKernel(), 123)
            except Exception as observed:
                error = observed
        self.assertEqual(imports, [])
        self.assertIsInstance(error, ValueError)

    def test_installation_sysprofile_directory_also_rejected(self):
        (self.stata / 'sysprofile.do').mkdir()
        with self.assertRaises(ValueError):
            startup.reserve(self.value)

    def test_reparse_profile_is_rejected(self):
        startup.reserve(self.value)
        target = self.root / 'profile.do'
        original = Path.lstat
        def observed(path, *args, **kwargs):
            if path == target:
                return SimpleNamespace(st_mode=stat.S_IFREG, st_file_attributes=stat.FILE_ATTRIBUTE_REPARSE_POINT)
            return original(path, *args, **kwargs)
        with patch.object(Path, 'lstat', observed):
            with self.assertRaises(ValueError):
                startup.verify(self.value)

    def test_foreign_epoch_cannot_attach_to_existing_reservation(self):
        startup.reserve(self.value)
        self.value['run_scope'] = dict(scope(), worker_epoch='foreign')
        with self.assertRaises(ValueError):
            startup.verify(self.value)

    def test_current_disabled_binding_cannot_prepare_an_active_run(self):
        with self.assertRaises(ValueError):
            startup.prepare_authorized(self.value, {'approved':True})
        self.assertFalse(self.root.exists())

    def test_tampered_startup_contract_cannot_supply_executable_profiles(self):
        self.value['startup_contract']['profiles']['profile.do']['sha256'] = '0' * 64
        with self.assertRaises(ValueError):
            startup.reserve(self.value)
        self.assertFalse(self.root.exists())
