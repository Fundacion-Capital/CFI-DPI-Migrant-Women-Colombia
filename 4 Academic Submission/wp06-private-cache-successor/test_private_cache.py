"""Private-prefix acceptance using artificial files, processes and proof records only."""
import copy
import hashlib
import json
from pathlib import Path
from types import SimpleNamespace
import sys
import tempfile
import unittest
from unittest.mock import patch
import deployment
import empty_client
import startup_guard
import native_provider
import runtime_roles
import mcp_adapter
import termination_evidence
from test_startup import StartupFixture
from test_support import binding,scope,FakeKernel,FakeChannel,prepared_binding
from test_abi import FakeABI

POLICY=dict(schema='WP06_PRIVATE_CACHE_PREFIX_V1',cache_tag='cpython-311',directory='pycache',source_backed_only=True)
def proof(value):
    return dict(pycache_prefix=str(Path(value['private_root'])/'pycache'),dont_write_bytecode=True,
        cache_tag='cpython-311',isolated=True,no_site=True)

class PrefixTests(StartupFixture):
    def test_old_binding_schema_and_wrong_policy_are_rejected(self):
        for change in (dict(schema='WP06_NATIVE_EMPTY_V1'),dict(cache_policy={**POLICY,'source_backed_only':1})):
            value={**self.value,**change}
            with self.subTest(change=change),self.assertRaises(ValueError):deployment.validate(value)

    def test_reserved_prefix_is_plain_empty_and_receipt_versioned(self):
        startup_guard.reserve(self.value)
        self.assertTrue((self.root/'pycache').is_dir())
        self.assertEqual(list((self.root/'pycache').iterdir()),[])
        row=json.loads((self.root/'startup_receipt.json').read_text())
        self.assertEqual(row['schema'],'WP06_FRESH_STARTUP_RECEIPT_V2')

    def test_nonempty_prefix_is_rejected_and_retained(self):
        startup_guard.reserve(self.value)
        folder=self.root/'pycache';folder.mkdir(exist_ok=True)
        retained=folder/'unexpected.pyc';retained.write_bytes(b'artificial')
        with self.assertRaises(ValueError):startup_guard.verify(self.value)
        self.assertEqual(retained.read_bytes(),b'artificial')

    def test_client_and_adapter_commands_both_have_exact_prefix(self):
        command=empty_client.contract(self.value)
        self.assertIn('pycache_prefix='+str(self.root/'pycache'),command['args'])
        builder=getattr(deployment,'client_command',None);self.assertTrue(callable(builder))
        self.assertEqual(builder(self.value)[1:8],['-I','-S','-B','-X','utf8','-X','pycache_prefix='+str(self.root/'pycache')])

    def test_worker_and_watchdog_native_commands_carry_prefix_without_real_processes(self):
        from win32_owner import Kernel
        startup_guard.reserve(self.value)
        for role in ('worker','watchdog'):
            with self.subTest(role=role):
                api=FakeABI();kernel=Kernel(self.value,None,api=api)
                process=kernel.spawn_suspended(role,self.value,{'stop_event':999})
                self.assertIn('pycache_prefix='+str(self.root/'pycache'),api.command)
                self.assertEqual(api.flags,0x80000|0x400|0x4|0x8000000)
                kernel.close(process);self.assertEqual(kernel.handles,set())

    def test_actual_interpreter_state_is_checked_with_strict_types(self):
        capture=getattr(deployment,'cache_proof',None);check=getattr(deployment,'check_cache_proof',None)
        self.assertTrue(callable(capture));self.assertTrue(callable(check))
        with patch.object(sys,'pycache_prefix',str(self.root/'pycache')),patch.object(sys,'dont_write_bytecode',True),patch.object(sys,'flags',SimpleNamespace(isolated=1,no_site=1)):
            self.assertEqual(capture(self.value),proof(self.value))
        for changed in (dict(dont_write_bytecode=1),dict(pycache_prefix='C:/shared'),dict(cache_tag='cpython-312'),dict(isolated=False),dict(extra=True)):
            with self.subTest(changed=changed),self.assertRaises(ValueError):check(self.value,{**proof(self.value),**changed})

    def test_entry_guards_stop_before_sdk_or_native_construction(self):
        for module,args in ((empty_client,(self.root/'active_binding.json',)),(mcp_adapter,(self.root/'active_binding.json',)),(runtime_roles,('worker',1,self.root/'active_binding.json'))):
            with self.subTest(module=module.__name__):
                self.assertTrue(callable(getattr(module,'cache_proof',None)))
                with patch.object(module,'load_active',return_value=(self.value,{})),patch.object(module,'cache_proof',side_effect=ValueError('artificial wrong prefix')),patch('win32_owner.Kernel',side_effect=AssertionError('native must not construct')):
                    with self.assertRaises(ValueError):module.main(*args)

    def test_assignment_is_disabled_pure_and_relocates_both_prefix_arguments(self):
        assign=getattr(deployment,'assign_run',None);self.assertTrue(callable(assign))
        source=binding(self.base/'source'/'UNASSIGNED');source['run_scope']=None
        before=copy.deepcopy(source);newscope={**scope(),'run_id':'cache-artificial-assigned'}
        value=assign(source,newscope)
        self.assertEqual(source,before);self.assertFalse(value['activation_allowed'])
        self.assertFalse(value['client']['enabled']);self.assertFalse(value['stdio']['enabled'])
        self.assertFalse(Path(value['private_root']).exists())
        for args in (value['stdio']['args'],value['client']['command']):
            self.assertIn('pycache_prefix='+str(Path(value['private_root'])/'pycache'),args)
            self.assertEqual(args[-1],str(Path(value['private_root'])/'active_binding.json'))
        with self.assertRaises(ValueError):assign(source,{**newscope,'run_id':'../escape'})

class CacheCatalogTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory();self.addCleanup(self.temp.cleanup)
        self.root=Path(self.temp.name).resolve();self.source=self.root/'module.py';self.source.write_bytes(b'x=1\n')
        self.cache=self.root/'__pycache__'/'module.cpython-311.pyc';self.cache.parent.mkdir();self.cache.write_bytes(b'artificial')
        self.roots=[dict(path=str(self.root),mode='all')];self.required=[str(self.source)]
        self.catalog=dict(schema='WP06_RUNTIME_FILES_V2',cache_policy=POLICY,roots=self.roots,required=self.required,
            files=[dict(path=str(self.source),bytes=4,sha256=hashlib.sha256(b'x=1\n').hexdigest())])
    def result(self,catalog=None):
        try:return deployment.check_catalog(catalog or self.catalog,self.roots,self.required)
        except (ValueError,TypeError,KeyError):return 'rejected'
    def test_normal_source_backed_cache_bytes_and_presence_are_observational(self):
        self.assertEqual(self.result(),[])
        self.cache.write_bytes(b'different artificial cache');self.assertEqual(self.result(),[])
        self.cache.unlink();self.assertEqual(self.result(),[])
    def test_source_bytes_remain_strict(self):
        self.source.write_bytes(b'x=2\n');self.assertIn(str(self.source),self.result())
    def test_unknown_orphan_binary_archive_and_source_in_cache_directory_are_strict(self):
        for name in ('other.cpython-311.pyc','module.cpython-312.pyc','module.cpython-311.opt-3.pyc','code.py','binary.pyd','binary.dll','code.zip'):
            path=self.cache.parent/name;path.write_bytes(b'artificial')
            with self.subTest(name=name):self.assertIn('runtime_file_set',self.result())
            path.unlink()
    def test_old_catalog_or_missing_policy_is_not_reinterpreted(self):
        for value in ({**self.catalog,'schema':'WP06_RUNTIME_FILES_V1'},{k:v for k,v in self.catalog.items() if k!='cache_policy'}):
            with self.subTest(value=value):self.assertEqual(self.result(value),'rejected')

class ProofFlowTests(unittest.TestCase):
    def test_parent_rejects_watchdog_and_worker_ready_without_exact_cache_proof(self):
        for role in ('watchdog','worker'):
            with self.subTest(role=role):
                kernel=FakeKernel();value=binding(Path('C:/artificial/run'))
                class BadWire(FakeChannel):
                    def wait(self,r,kind,seq,deadline):
                        row=super().wait(r,kind,seq,deadline)
                        if r==role and kind=='ready':row.pop('cache_control',None)
                        return row
                owner=native_provider.NativeOwner(kernel,BadWire(kernel),value,scope())
                resource=owner.allocate_suspended(scope());owner.assign_job(resource)
                with self.assertRaises(ValueError):owner.initialize(resource)

    def test_saved_four_channel_reader_rejects_missing_extra_foreign_or_typed_false_proof(self):
        reader=getattr(termination_evidence,'read_cache_witnesses',None);self.assertTrue(callable(reader))
        with tempfile.TemporaryDirectory() as directory:
            value=prepared_binding(Path(directory));root=Path(value['private_root']);good=proof(value)
            records={'client_receipt.json':dict(scope=scope(),cache_control=good),
                'parent.cache.json':dict(kind='cache',scope=scope(),payload=good,provenance='artificial'),
                **{r+'.ready.0.json':dict(scope=scope(),role=r,kind='ready',sequence=0,payload=dict(ready=True,cache_control=good,**({'runtime_identity':{}} if r=='worker' else {})),tag='0'*64) for r in ('worker','watchdog')}}
            for name,row in records.items():(root/name).write_text(json.dumps(row))
            self.assertEqual(set(reader(root,scope(),value)),{'client','adapter','worker','watchdog'})
            for changed in (dict(dont_write_bytecode=1),dict(pycache_prefix='C:/shared'),dict(extra=True)):
                record=copy.deepcopy(records['client_receipt.json']);record['cache_control'].update(changed)
                (root/'client_receipt.json').write_text(json.dumps(record))
                with self.subTest(changed=changed),self.assertRaises(ValueError):reader(root,scope(),value)
            (root/'client_receipt.json').write_text(json.dumps(records['client_receipt.json']))
            row=copy.deepcopy(records['parent.cache.json']);row['scope']['worker_epoch']='foreign'
            (root/'parent.cache.json').write_text(json.dumps(row))
            with self.assertRaises(ValueError):reader(root,scope(),value)

if __name__=='__main__':unittest.main(verbosity=2)
