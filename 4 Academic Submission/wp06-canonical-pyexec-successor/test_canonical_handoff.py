import json
from pathlib import Path
from tempfile import TemporaryDirectory
from types import SimpleNamespace
import unittest
from unittest.mock import Mock, patch

import python_bootstrap as bootstrap
from test_python_bootstrap import artificial_pe, pinned
from test_support import scope


class CanonicalHandoffTests(unittest.TestCase):
    def setUp(self):
        tmp = TemporaryDirectory(prefix='wp06_handoff_')
        self.addCleanup(tmp.cleanup)
        self.root = Path(tmp.name).resolve()
        base = self.root/'base'
        base.mkdir()
        self.exe = base/'python.exe'
        self.exe.write_bytes(artificial_pe())
        dll = base/'python311.dll'
        dll.write_bytes(artificial_pe())
        sfi = self.root/'ado/base/py/sfi.py'
        sfi.parent.mkdir(parents=True)
        sfi.write_text('# artificial',encoding='utf-8')
        alias = base/'..'/'base'
        self.raw = str(alias/'python.exe')
        self.binding = dict(python_base_root=str(alias), stata_home=str(self.root), private_root=str(self.root),
            run_scope=scope(), python_dll_bootstrap=dict(schema='WP06_PYTHON_DLL_BOOTSTRAP_V1',
                directory=str(base),base_executable=pinned(self.exe),shared_library=pinned(dll),sfi_module=pinned(sfi),
                python_version=[3,11,15],metadata_limit_bytes=8192))

    def invoke(self, raw, expected_error=None):
        resolver = Mock(return_value=raw)
        sink = Mock(return_value=-7100)
        config = SimpleNamespace(_get_executable_path=resolver)
        def native(splash):
            return sink('', '-q', '-pyexec', config._get_executable_path())
        config._init_stata = native
        config.init = lambda edition, splash: config._init_stata(splash)
        with patch.object(bootstrap,'verify_config'):
            if expected_error:
                with self.assertRaises(expected_error):
                    bootstrap.initialize_with_return(self.binding,config)
                sink.assert_not_called()
            else:
                self.assertEqual(bootstrap.initialize_with_return(self.binding,config),-7100)
                sink.assert_called_once_with('', '-q', '-pyexec', str(self.exe))
        self.assertIs(config._get_executable_path,resolver)
        self.assertIs(config._init_stata,native)
        resolver.assert_called_once()
        return bootstrap.read_native_return(self.binding)

    def test_forwarded_value_and_versioned_readback(self):
        row = self.invoke(self.raw)
        self.assertEqual(row,dict(schema='WP06_BOOTSTRAP_RETURN_V2',state='RETURNED',return_code=-7100,
                    raw_executable=self.raw,resolved_executable=str(self.exe),forwarded_executable=str(self.exe)))
        path = self.root/'python-bootstrap.native_return.json'
        envelope = json.loads(path.read_bytes())
        for change in ({'forwarded_executable':self.raw},{'schema':'WP06_BOOTSTRAP_RETURN_V1'},
                       {'return_code':False},{'raw_executable':str(self.exe)}):
            payload = {**row,**change}
            path.write_bytes(json.dumps({**envelope,'payload':payload},sort_keys=True,separators=(',',':')).encode())
            with self.assertRaises(ValueError):
                bootstrap.read_native_return(self.binding)

    def test_unexpected_spelling_even_if_same_image_is_held(self):
        row = self.invoke(str(self.exe),ValueError)
        self.assertEqual(row['state'],'RAISED')
        self.assertIsNone(row['forwarded_executable'])

    def test_changed_executable_is_held(self):
        self.exe.write_bytes(artificial_pe()+b'changed')
        self.assertIsNone(self.invoke(self.raw,ValueError)['return_code'])

    def test_missing_executable_is_held(self):
        self.exe.unlink()
        self.assertIsNone(self.invoke(self.raw,FileNotFoundError)['return_code'])
