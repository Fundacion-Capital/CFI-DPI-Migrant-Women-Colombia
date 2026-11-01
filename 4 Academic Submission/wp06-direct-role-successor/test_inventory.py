"""Real artificial-file catalog checks, differential against the preserved predecessor."""
import copy
import hashlib
import importlib.util
from pathlib import Path
import stat
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch
import deployment

original_path = Path(__file__).resolve().parent.parent / 'wp06-lifecycle-remediation/deployment.py'
spec = importlib.util.spec_from_file_location('preserved_inventory_reference', original_path)
reference = importlib.util.module_from_spec(spec)
spec.loader.exec_module(reference)


def outcome(module, catalog, roots, required):
    try:
        return 'result', module.check_catalog(catalog, roots, required)
    except (ValueError, TypeError, KeyError, OSError) as error:
        return 'error', type(error).__name__


class InventoryTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='wp06_inventory_artificial_')
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name).resolve()
        self.files = [self.root / ('module_%02d.py' % n) for n in range(12)]
        for path in self.files:
            path.write_bytes(b'value = 1\n')
        self.roots = [dict(path=str(self.root), mode='importable')]
        self.required = [str(self.files[0])]
        self.catalog = dict(schema='WP06_RUNTIME_FILES_V1', roots=self.roots, required=self.required,
            files=[dict(path=str(p), bytes=10, sha256=hashlib.sha256(b'value = 1\n').hexdigest()) for p in self.files])

    def compare(self, catalog=None):
        catalog = self.catalog if catalog is None else catalog
        old = outcome(reference, catalog, self.roots, self.required)
        new = outcome(deployment, catalog, self.roots, self.required)
        self.assertEqual(new, old)
        return new

    def test_canonical_members_are_not_resolved_twice(self):
        # Resolving every catalog member again regresses the shared verifier's metadata cost.
        resolved = []
        original = Path.resolve
        def count(path, *args, **kwargs):
            resolved.append(str(path))
            return original(path, *args, **kwargs)
        with patch.object(Path, 'resolve', new=count):
            self.assertEqual(deployment.check_catalog(self.catalog, self.roots, self.required), [])
        self.assertLessEqual(len(resolved), len(self.files) + len(self.roots))

    def test_exact_catalog_still_hashes_every_file(self):
        digested = []
        original = hashlib.file_digest
        def digest(stream, algorithm):
            digested.append(stream.name)
            return original(stream, algorithm)
        with patch.object(hashlib, 'file_digest', new=digest):
            self.assertEqual(deployment.check_catalog(self.catalog, self.roots, self.required), [])
        self.assertEqual(sorted(digested), sorted(str(p) for p in self.files))

    def test_same_size_changed_bytes_remain_rejected(self):
        self.files[0].write_bytes(b'value = 2\n')
        self.assertEqual(self.compare(), ('result', [str(self.files[0])]))

    def test_changed_size_remains_rejected(self):
        self.files[0].write_bytes(b'value = 200\n')
        self.assertEqual(self.compare(), ('result', [str(self.files[0])]))

    def test_missing_critical_file_remains_rejected(self):
        self.files[0].unlink()
        self.assertIn(str(self.files[0]), self.compare()[1])

    def test_added_importable_file_remains_rejected(self):
        (self.root / 'unexpected.py').write_bytes(b'# artificial\n')
        self.assertIn('runtime_file_set', self.compare()[1])

    def test_renamed_file_remains_rejected(self):
        self.files[0].rename(self.root / 'renamed.py')
        result = self.compare()[1]
        self.assertIn('runtime_file_set', result)
        self.assertIn(str(self.files[0]), result)

    def test_duplicate_and_missing_required_rows_remain_rejected(self):
        for rows in (self.catalog['files'] + [self.catalog['files'][0]], self.catalog['files'][1:]):
            with self.subTest(rows=len(rows)):
                self.assertEqual(self.compare({**self.catalog, 'files': rows}), ('error', 'ValueError'))

    def test_schema_root_required_and_empty_catalog_rules_remain(self):
        for changed in (dict(schema='wrong'), dict(roots=[]), dict(required=[]), dict(files=[]), dict(files=())):
            with self.subTest(changed=changed):
                self.assertEqual(self.compare({**self.catalog, **changed}), ('error', 'ValueError'))

    def test_dot_alias_preserves_predecessor_acceptance(self):
        bridge = self.root / 'bridge'
        bridge.mkdir()
        value = copy.deepcopy(self.catalog)
        value['files'][0]['path'] = str(bridge / '..' / self.files[0].name)
        self.assertEqual(self.compare(value), ('result', []))

    def test_duplicate_alias_cannot_bypass_duplicate_detection(self):
        bridge = self.root / 'bridge'
        bridge.mkdir()
        value = copy.deepcopy(self.catalog)
        value['files'].append({**value['files'][0], 'path': str(bridge / '..' / self.files[0].name)})
        self.assertEqual(self.compare(value), ('error', 'ValueError'))

    def test_required_alias_cannot_be_treated_as_a_scanned_canonical_member(self):
        bridge = self.root / 'bridge'
        bridge.mkdir()
        alias = str(bridge / '..' / self.files[0].name)
        self.required = [alias]
        value = copy.deepcopy(self.catalog)
        value['required'] = self.required
        value['files'].append({**value['files'][0], 'path': alias})
        self.assertEqual(self.compare(value), ('error', 'ValueError'))

    def test_case_variant_preserves_predecessor_outcome(self):
        value = copy.deepcopy(self.catalog)
        value['files'][0]['path'] = value['files'][0]['path'].swapcase()
        self.compare(value)

    def test_reparse_file_directory_and_ignored_entry_remain_rejected(self):
        folder = self.root / 'folder'
        folder.mkdir()
        ignored = self.root / 'ignored.txt'
        ignored.write_bytes(b'artificial')
        original = Path.lstat
        for target in (self.files[0], folder, ignored):
            def reported(path, *args, **kwargs):
                if path == target:
                    return SimpleNamespace(st_file_attributes=stat.FILE_ATTRIBUTE_REPARSE_POINT)
                return original(path, *args, **kwargs)
            with self.subTest(target=target.name), patch.object(Path, 'lstat', new=reported):
                self.assertEqual(self.compare(), ('error', 'ValueError'))

    def test_nonimportable_file_filter_is_unchanged(self):
        (self.root / 'ignored.txt').write_bytes(b'artificial')
        self.assertEqual(self.compare(), ('result', []))

    def test_all_importable_and_top_dll_modes_preserve_membership(self):
        extra = self.root / 'ignored.txt'
        engine = self.root / 'engine.dll'
        nested = self.root / 'nested'
        nested.mkdir()
        deep = nested / 'deep.dll'
        for path in (extra, engine, deep):
            path.write_bytes(b'artificial')
        for mode, files in (('all', self.files + [extra, engine, deep]),
                            ('importable', self.files + [engine, deep]), ('dll_top', [engine])):
            self.roots = [dict(path=str(self.root), mode=mode)]
            self.required = [str(engine)]
            rows = [dict(path=str(p), bytes=p.stat().st_size, sha256=hashlib.sha256(p.read_bytes()).hexdigest()) for p in files]
            catalog = dict(schema='WP06_RUNTIME_FILES_V1', roots=self.roots, required=self.required, files=rows)
            with self.subTest(mode=mode):
                self.assertEqual(self.compare(catalog), ('result', []))

    def test_malformed_rows_preserve_predecessor_rejection(self):
        for row in ({}, {'path': None}, {'path': ['not-a-path']}):
            with self.subTest(row=row):
                self.assertEqual(self.compare({**self.catalog, 'files': [row]})[0], 'error')

    def test_scanning_error_is_not_hidden(self):
        def fail(root, **kwargs):
            kwargs['onerror'](PermissionError('Artificial scan denial'))
            return iter(())
        with patch.object(deployment.os, 'walk', new=fail):
            self.assertEqual(self.compare(), ('error', 'PermissionError'))
