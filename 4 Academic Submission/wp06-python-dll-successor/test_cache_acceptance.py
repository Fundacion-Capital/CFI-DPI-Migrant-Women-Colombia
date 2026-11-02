"""Coupled cache-policy boundary checks; all files and native functions are artificial."""
import copy
import importlib.machinery
import importlib.util
import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch
import deployment
import empty_client
import mcp_adapter
import startup_guard
import termination_evidence
from test_startup import StartupFixture
from test_support import prepared_binding, fake_cache_proof, scope, FakeKernel

class CommandTests(StartupFixture):
    def test_missing_flags_prefix_command_or_entry_cannot_pass_binding_admission(self):
        for channel,field in (('stdio','args'),('client','command')):
            for index in range(len(self.value[channel][field])):
                value=copy.deepcopy(self.value);value[channel][field].pop(index)
                with self.subTest(channel=channel,index=index),self.assertRaises(ValueError):deployment.validate(value)
        for channel,field in (('stdio','command'),('client','entry')):
            value=copy.deepcopy(self.value);value[channel][field]='C:/foreign/entry.exe'
            with self.subTest(channel=channel),self.assertRaises(ValueError):deployment.validate(value)

    def test_actual_missing_prefix_or_no_write_is_not_inferred_from_requested_arguments(self):
        for prefix,no_write in ((None,True),(str(self.root/'pycache'),False)):
            with patch.object(sys,'pycache_prefix',prefix),patch.object(sys,'dont_write_bytecode',no_write):
                with self.assertRaises(ValueError):deployment.cache_proof(self.value)

    def test_client_terminal_success_and_failure_both_record_actual_cache_proof(self):
        for fail in (False,True):
            with tempfile.TemporaryDirectory() as folder:
                value=prepared_binding(Path(folder));root=Path(value['private_root']);good=fake_cache_proof(value)
                async def connect(*args):
                    if fail:raise OSError('artificial transport failure')
                    return dict(recipe_completed=True)
                with patch.object(empty_client,'load_active',return_value=(value,{})),patch.object(empty_client,'cache_proof',return_value=good),patch.object(empty_client,'reserve_client'),patch.object(empty_client,'_connect',new=connect):
                    if fail:
                        with self.assertRaises(OSError):empty_client.main(root/'active_binding.json')
                    else:empty_client.main(root/'active_binding.json')
                row=json.loads((root/'client_receipt.json').read_text())
                self.assertEqual(row['scope'],scope());self.assertEqual(row['cache_control'],good)
                self.assertIs(row['recipe_completed'],not fail)

    def test_adapter_publication_failure_occurs_before_sdk_import_or_allocation(self):
        startup_guard.reserve(self.value);self.value['run_scope']=scope()
        kernel=FakeKernel()
        with patch.object(mcp_adapter,'load_active',return_value=(self.value,{})),patch.object(mcp_adapter,'cache_proof',return_value=fake_cache_proof(self.value)),patch('win32_owner.Kernel',return_value=kernel),patch('private_channel.Channel.record_parent',side_effect=OSError('artificial publication failure')):
            with self.assertRaises(OSError):mcp_adapter.main(self.root/'active_binding.json')
        self.assertFalse(kernel.processes);self.assertEqual(kernel.handles,set())

class ReaderTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory();self.addCleanup(self.temp.cleanup)
        self.value=prepared_binding(Path(self.temp.name));self.root=Path(self.value['private_root'])
        good=fake_cache_proof(self.value)
        from test_support import fake_python_ready
        self.records={'client_receipt.json':dict(scope=scope(),cache_control=good),
            'parent.cache.json':dict(scope=scope(),kind='cache',payload=good,provenance='artificial'),
            **{role+'.ready.0.json':dict(scope=scope(),role=role,kind='ready',sequence=0,tag='0'*64,
                payload=dict(ready=True,cache_control=good,**({'runtime_identity':{name:rows[0] for name,rows in self.value['runtime_identity_files'].items()},
                    'python_bootstrap':fake_python_ready(self.value)} if role=='worker' else {}))) for role in ('worker','watchdog')}}
        self.restore()
    def restore(self):
        for name,row in self.records.items():(self.root/name).write_text(json.dumps(row))
    def read(self):return termination_evidence.read_cache_witnesses(self.root,scope(),self.value)
    def test_exact_reservation_is_required_and_a_foreign_receipt_is_rejected(self):
        path=self.root/'startup_receipt.json';original=path.read_bytes()
        path.write_text('{}')
        with self.assertRaises(ValueError):self.read()
        path.write_bytes(original);path.unlink()
        with self.assertRaises((ValueError,FileNotFoundError)):self.read()
    def test_missing_witness_in_each_channel_and_nonempty_prefix_are_rejected(self):
        for name in self.records:
            (self.root/name).unlink()
            with self.subTest(name=name),self.assertRaises((ValueError,FileNotFoundError)):self.read()
            self.restore()
        path=self.root/'pycache'/'keep.pyc';path.write_bytes(b'preserve')
        with self.assertRaises(ValueError):self.read()
        self.assertEqual(path.read_bytes(),b'preserve')
    def test_duplicate_oversized_extra_role_and_foreign_scope_are_rejected(self):
        for name in self.records:
            path=self.root/name
            for raw in ('{"scope":{},"scope":{}}',' '*8193):
                path.write_text(raw)
                with self.subTest(name=name),self.assertRaises(ValueError):self.read()
                self.restore()
            row=copy.deepcopy(self.records[name]);row['scope']['owner_nonce']='foreign'
            path.write_text(json.dumps(row))
            with self.subTest(name=name),self.assertRaises(ValueError):self.read()
            self.restore()
        for change in (dict(sequence=False),dict(role='other'),dict(extra=True),dict(tag='bad')):
            row={**self.records['worker.ready.0.json'],**change}
            (self.root/'worker.ready.0.json').write_text(json.dumps(row))
            with self.subTest(change=change),self.assertRaises(ValueError):self.read()
            self.restore()

class ImportRoutingTests(unittest.TestCase):
    def check_routing(self,private_prefix):
        with tempfile.TemporaryDirectory() as folder:
            root=Path(folder);source=root/'artificial.py'
            source.write_bytes(b'raise AssertionError("the module body must never execute")\n')
            prefix=root/'pycache';prefix.mkdir()
            with patch.object(sys,'pycache_prefix',None):adjacent=Path(importlib.util.cache_from_source(str(source)))
            adjacent.parent.mkdir();adjacent.write_bytes(b'invalid artificial cache')
            reads=[]
            class RecordingLoader(importlib.machinery.SourceFileLoader):
                def get_data(self,path):
                    reads.append(Path(path));return super().get_data(path)
            with patch.object(sys,'dont_write_bytecode',True),patch.object(sys,'pycache_prefix',str(prefix) if private_prefix else None):
                code=RecordingLoader('artificial',str(source)).get_code('artificial')
            self.assertEqual(code.co_filename,str(source));self.assertEqual(adjacent in reads,not private_prefix)
            self.assertEqual(list(prefix.rglob('*')),[])
    def test_no_write_flag_alone_still_reads_adjacent_cache(self):self.check_routing(False)
    def test_private_prefix_bypasses_adjacent_cache_without_executing_module(self):self.check_routing(True)
