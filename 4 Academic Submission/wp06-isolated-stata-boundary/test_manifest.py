"""Manifest mutation tests use artificial source files, never runtime imports."""
import copy
import hashlib
import json
from pathlib import Path
import tempfile
import unittest
import source_manifest
from test_support import manifest


class ManifestTests(unittest.TestCase):
    def test_valid_core_and_changed_contract_or_bounds(self):
        source_manifest.validate(manifest())
        for field, value in [('contract_sha256', '0' * 64), ('manager_sha256', '0' * 64),
                ('bounds', {}), ('literal_selections', ['display 1']), ('domain', 'LIVE'),
                ('startup_review', 'APPROVED'), ('deployment', 'RUNNING')]:
            changed = manifest()
            changed[field] = value
            with self.subTest(field=field), self.assertRaises(ValueError):
                source_manifest.validate(changed)

    def test_file_verification_rejects_changed_bytes_missing_and_added_sources(self):
        with tempfile.TemporaryDirectory(prefix='wp06_artificial_source_') as directory:
            root = Path(directory)
            (root / 'src').mkdir()
            file = root / 'src/example.py'
            file.write_bytes(b'answer = 1\n')
            row = dict(file='src/example.py', bytes=11, sha256=hashlib.sha256(b'answer = 1\n').hexdigest())
            self.assertEqual(source_manifest.verify_sources([row], root), [])
            file.write_bytes(b'answer = 2\n')
            self.assertTrue(source_manifest.verify_sources([row], root))
            file.unlink()
            self.assertTrue(source_manifest.verify_sources([row], root))
            file.write_bytes(b'answer = 1\n')
            (root / 'src/extra.py').write_bytes(b'answer = 3\n')
            self.assertTrue(source_manifest.verify_sources([row], root))

    def test_manifest_paths_cannot_escape_source_root(self):
        row = dict(file='../outside.py', bytes=0, sha256='0' * 64)
        with tempfile.TemporaryDirectory(prefix='wp06_artificial_source_') as directory:
            with self.assertRaises(ValueError):
                source_manifest.verify_sources([row], Path(directory))

    def test_complete_manifest_rejects_missing_code_and_false_interpreter_or_package(self):
        extension = Path('C:/Users/jzava/.cursor/extensions/deepecon.stata-mcp-0.5.3-universal')
        complete = source_manifest.build(extension)
        self.assertEqual(source_manifest.verify_complete(complete, extension), [])
        for field, value in [('implementation_sources', {}), ('artificial_test_interpreter', {}),
                ('extension_package', {}), ('extension_source_files', [])]:
            changed = copy.deepcopy(complete)
            changed[field] = value
            with self.subTest(field=field):
                self.assertTrue(source_manifest.verify_complete(changed, extension))
