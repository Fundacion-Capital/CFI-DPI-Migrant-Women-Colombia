"""Artificial Python/DLL/SFI witnesses only. No vendor import, DLL or worker launch."""
import copy
import hashlib
import importlib
from importlib.machinery import BuiltinImporter, ModuleSpec
import json
from pathlib import Path
import struct
import sys
import tempfile
from types import ModuleType, SimpleNamespace
import unittest
from unittest.mock import patch
import runtime_roles
from test_support import binding, scope

try:
    bootstrap = importlib.import_module('python_bootstrap')
except ModuleNotFoundError:
    bootstrap = None

def pinned(path):
    data=path.read_bytes()
    return dict(path=str(path.resolve()),bytes=len(data),sha256=hashlib.sha256(data).hexdigest())

def artificial_pe(machine=0x8664):
    data=bytearray(128)
    data[:2]=b'MZ';struct.pack_into('<I',data,60,64)
    data[64:68]=b'PE\0\0';struct.pack_into('<H',data,68,machine)
    struct.pack_into('<H',data,88,0x20b)
    return bytes(data)

class BootstrapTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(bootstrap,'Python DLL bootstrap implementation missing')
        self.temp=tempfile.TemporaryDirectory(prefix='wp06_dll_artificial_')
        self.addCleanup(self.temp.cleanup)
        self.folder=Path(self.temp.name).resolve()
        self.base=self.folder/'base';self.base.mkdir()
        self.stata=self.folder/'stata'
        sfi=self.stata/'ado/base/py/sfi.py';sfi.parent.mkdir(parents=True)
        sfi.write_bytes(b'# artificial vendor interface\n')
        for name in ('python.exe','python311.dll'):
            (self.base/name).write_bytes(artificial_pe())
        self.root=self.folder/'run';self.root.mkdir()
        self.value=binding(self.root)
        self.value.update(schema='WP06_NATIVE_EMPTY_DEFERRED_EXIT_V5',python_base_root=str(self.base),
            stata_home=str(self.stata),site_packages=str(self.folder/'site'),run_scope=scope())
        self.value['python_dll_bootstrap']=dict(schema='WP06_PYTHON_DLL_BOOTSTRAP_V1',
            directory=str(self.base),base_executable=pinned(self.base/'python.exe'),
            shared_library=pinned(self.base/'python311.dll'),sfi_module=pinned(sfi),
            python_version=[3,11,15],metadata_limit_bytes=8192)
        self.runtime=SimpleNamespace(executable=str(self.base/'python.exe'),prefix=str(self.base),
            base_prefix=str(self.base),version_info=(3,11,15),dllhandle=456,
            flags=SimpleNamespace(isolated=1,no_site=1),dont_write_bytecode=True,
            pycache_prefix=str(self.root/'pycache'),implementation=SimpleNamespace(cache_tag='cpython-311'),
            path=[str(self.stata/'utilities'),self.value['site_packages']],modules={})

    def modules(self, failure=None):
        config=ModuleType('pystata.config');config.stinitialized=True;config.sfiinitialized=True
        stata=ModuleType('pystata.stata');sfi=ModuleType('sfi');plugin=ModuleType('stata_plugin')
        plugin.__spec__=ModuleSpec('stata_plugin',BuiltinImporter,origin='built-in')
        self.api=[]
        for name in ('_st_getvalue','_st_getglobal'):
            def function(*args):
                raise AssertionError('No artificial SFI operation may execute')
            function.__module__='stata_plugin';function.__self__=plugin
            setattr(plugin,name,function);self.api.append(function)
        sfi._stp=plugin
        sfi.__file__=self.value['python_dll_bootstrap']['sfi_module']['path']
        package=ModuleType('pystata');package.config=config;package.stata=stata
        for module in (package,config,stata,sfi,plugin):module.__wp06_artificial__=True
        def init(*args,**kwargs):
            self.events.append('init')
            if failure:raise failure
            config._init_stata(kwargs['splash'])
            self.runtime.modules.update(sfi=sfi,stata_plugin=plugin)
        config.init=init
        config._get_executable_path=lambda: self.runtime.executable
        def native(splash):
            config._get_executable_path()
            return 0
        config._init_stata=native
        return dict(pystata=package,sfi=sfi,stata_plugin=plugin),config,stata,sfi,plugin

    def engine(self, failure=None, close_error=None, record_error=False, return_error=False):
        self.events=[]
        modules,config,stata,sfi,plugin=self.modules(failure)
        def close():
            self.events.append('dll_close')
            if close_error:raise close_error
        handle=SimpleNamespace(close=close)
        thread=SimpleNamespace(start=lambda:self.events.append('thread_start'),
            join=lambda seconds:self.events.append('thread_join'),is_alive=lambda:False)
        original_record=bootstrap.record
        def record(value,kind,payload):
            if record_error and kind=='failure':raise OSError('artificial recording failure')
            if return_error and kind=='native_return':raise OSError('artificial return publication failure')
            return original_record(value,kind,payload)
        with patch.dict(sys.modules,modules),patch.object(runtime_roles,'verify_startup',return_value=None),\
             patch.dict(runtime_roles.os.environ,{},clear=False),\
             patch.object(runtime_roles,'sys',self.runtime),\
             patch.object(runtime_roles.os,'add_dll_directory',side_effect=lambda path:self.events.append(('dll_open',path)) or handle),\
             patch.object(runtime_roles.threading,'Thread',return_value=thread),\
             patch.object(runtime_roles,'capture_runtime_identity',return_value={'artificial':'checked separately'}),\
             patch.object(bootstrap.inspect,'isbuiltin',side_effect=lambda value:value in self.api),\
                patch.object(bootstrap,'verify_config'),patch.object(bootstrap,'record',side_effect=record):
            engine=runtime_roles.StataEngine(self.value,SimpleNamespace(),123)
        return engine

    def test_exact_files_and_64bit_headers_qualify_without_loading(self):
        self.assertEqual(bootstrap.check_spec(self.value),self.value['python_dll_bootstrap'])
        bootstrap.verify_files(self.value)

    def test_schema_unknown_fields_and_noncanonical_directory_are_rejected(self):
        for change in ({'schema':'OLD'},{'extra':True},{'directory':str(self.base/'..'/'base')}):
            value=copy.deepcopy(self.value);value['python_dll_bootstrap'].update(change)
            with self.subTest(change=change),self.assertRaises(ValueError):bootstrap.check_spec(value)

    def test_foreign_dll_and_sfi_paths_are_rejected(self):
        for name in ('shared_library','base_executable','sfi_module'):
            value=copy.deepcopy(self.value);value['python_dll_bootstrap'][name]['path']=str(self.folder/'foreign')
            with self.subTest(name=name),self.assertRaises(ValueError):bootstrap.check_spec(value)

    def test_invalid_or_boolean_pin_sizes_are_rejected(self):
        for size in (True,0,-1,'128'):
            value=copy.deepcopy(self.value);value['python_dll_bootstrap']['shared_library']['bytes']=size
            with self.subTest(size=size),self.assertRaises(ValueError):bootstrap.check_spec(value)

    def test_changed_bytes_or_missing_library_are_not_rebaselined(self):
        path=self.base/'python311.dll';path.write_bytes(artificial_pe()+b'x')
        with self.assertRaises(ValueError):bootstrap.verify_files(self.value)
        path.unlink()
        with self.assertRaises((ValueError,FileNotFoundError)):bootstrap.verify_files(self.value)

    def test_wrong_architecture_is_rejected_even_with_matching_hash(self):
        path=self.base/'python311.dll';path.write_bytes(artificial_pe(0x14c))
        self.value['python_dll_bootstrap']['shared_library']=pinned(path)
        with self.assertRaises(ValueError):bootstrap.verify_files(self.value)

    def test_preinit_metadata_is_allowlisted_and_has_no_environment_dump(self):
        self.runtime.secret='MUST_NOT_APPEAR'
        result=bootstrap.metadata(self.value,self.runtime)
        self.assertEqual(set(result),{'executable','resolved_executable','prefix','base_prefix','version',
            'bits','explicit_import_roots','cache_control','python_shared_library'})
        self.assertNotIn('MUST_NOT_APPEAR',json.dumps(result))
        self.assertEqual(result['bits'],64)

    def test_preinit_rejects_foreign_interpreter_prefix_or_preloaded_plugin(self):
        for field,value in (('executable',str(self.folder/'foreign.exe')),('prefix',str(self.folder/'foreign')),
                            ('version_info',(3,12,0)),('modules',{'stata_plugin':object()})):
            runtime=copy.copy(self.runtime);setattr(runtime,field,value)
            with self.subTest(field=field),self.assertRaises(ValueError):bootstrap.metadata(self.value,runtime)

    def test_metadata_rejects_weak_isolation_cache_or_missing_explicit_root(self):
        for field,value in (('flags',SimpleNamespace(isolated=0,no_site=1)),('dont_write_bytecode',False),
                            ('pycache_prefix',None),('path',[])):
            runtime=copy.copy(self.runtime);setattr(runtime,field,value)
            with self.subTest(field=field),self.assertRaises(ValueError):bootstrap.metadata(self.value,runtime)

    def test_positive_artificial_sfi_witness_has_exact_ready_contract(self):
        self.events=[];_,config,_,sfi,plugin=self.modules()
        with patch.object(bootstrap.inspect,'isbuiltin',side_effect=lambda value:value in self.api):
            proof=bootstrap.require_sfi(self.value,config,sfi,plugin)
        bootstrap.check_ready(self.value,proof)
        self.assertTrue(proof['sfi_initialized'])
        self.assertEqual(proof['plugin']['origin'],'built-in')

    def test_false_or_missing_sfi_readiness_is_rejected(self):
        self.events=[];_,config,_,sfi,plugin=self.modules()
        for value in (False,None,1):
            config.sfiinitialized=value
            with self.subTest(value=value),self.assertRaises(ValueError):bootstrap.require_sfi(self.value,config,sfi,plugin)

    def test_foreign_plugin_or_python_implementation_is_rejected(self):
        self.events=[];_,config,_,sfi,plugin=self.modules()
        with self.assertRaises(ValueError):bootstrap.require_sfi(self.value,config,sfi,plugin)
        sfi._stp=object()
        with patch.object(bootstrap.inspect,'isbuiltin',return_value=True),self.assertRaises(ValueError):
            bootstrap.require_sfi(self.value,config,sfi,plugin)

    def test_foreign_sfi_file_or_plugin_origin_is_rejected(self):
        self.events=[];_,config,_,sfi,plugin=self.modules()
        for field,value in (('__file__',str(self.folder/'foreign.py')),):
            setattr(sfi,field,value)
            with self.assertRaises(ValueError):bootstrap.require_sfi(self.value,config,sfi,plugin)
        sfi.__file__=self.value['python_dll_bootstrap']['sfi_module']['path']
        plugin.__spec__=ModuleSpec('stata_plugin',object(),origin='foreign')
        with self.assertRaises(ValueError):bootstrap.require_sfi(self.value,config,sfi,plugin)

    def test_ready_rejects_missing_false_or_extra_evidence(self):
        self.events=[];_,config,_,sfi,plugin=self.modules()
        with patch.object(bootstrap.inspect,'isbuiltin',side_effect=lambda value:value in self.api):
            proof=bootstrap.require_sfi(self.value,config,sfi,plugin)
        for change in ({'sfi_initialized':False},{'stata_initialized':1},{'extra':True},{'plugin':{}}):
            with self.subTest(change=change),self.assertRaises(ValueError):bootstrap.check_ready(self.value,{**proof,**change})

    def test_records_are_bounded_create_only_and_run_scoped(self):
        bootstrap.record(self.value,'preinit',{'artificial':True})
        path=self.root/'python-bootstrap.preinit.json';before=path.read_bytes()
        row=json.loads(before);self.assertEqual(row['scope'],scope())
        with self.assertRaises(FileExistsError):bootstrap.record(self.value,'preinit',{})
        self.assertEqual(path.read_bytes(),before)
        with self.assertRaises(ValueError):bootstrap.record(self.value,'../../foreign',{})
        with self.assertRaises(ValueError):bootstrap.record(self.value,'result',{'large':'x'*9000})

    def test_engine_opens_one_exact_scope_and_retains_it_until_close(self):
        engine=self.engine()
        self.assertEqual(self.events[0],('dll_open',str(self.base)))
        self.assertIn('init',self.events);self.assertNotIn('dll_close',self.events)
        bootstrap.check_ready(self.value,engine.python_bootstrap)
        evidence=bootstrap.read_native_return(self.value)
        self.assertEqual(evidence['return_code'],0)
        self.assertEqual(evidence['raw_executable'],self.runtime.executable)
        with self.assertRaisesRegex(ValueError,'Foreign'):
            bootstrap.read_native_return({**self.value,'run_scope':{}})
        engine.close();self.assertEqual(self.events.count('dll_close'),1)

    def test_constructor_failure_preserves_exception_and_closes_scope(self):
        original=ModuleNotFoundError('artificial sfi failure')
        with self.assertRaises(ModuleNotFoundError) as caught:self.engine(failure=original)
        self.assertIs(caught.exception,original)
        self.assertEqual(self.events.count('dll_close'),1)
        row=json.loads((self.root/'python-bootstrap.failure.json').read_bytes())
        self.assertEqual(row['payload']['error_type'],'ModuleNotFoundError')
        self.assertEqual(row['payload']['error'],'artificial sfi failure')
        evidence=bootstrap.read_native_return(self.value)
        self.assertEqual(evidence['state'],'NOT_REACHED')
        self.assertIsNone(evidence['return_code'])
        self.assertNotIn('thread_start',self.events)

    def test_constructor_retains_primary_recording_and_closure_errors(self):
        with self.assertRaises(BaseExceptionGroup) as caught:
            self.engine(failure=RuntimeError('primary'),close_error=OSError('close'),record_error=True)
        text=str(caught.exception.exceptions)
        self.assertIn('primary',text);self.assertIn('close',text);self.assertIn('recording',text)
        self.assertEqual(self.events.count('dll_close'),1)

    def test_return_publication_failure_cannot_reach_positive_result(self):
        with self.assertRaisesRegex(OSError, 'return publication failure'):
            self.engine(return_error=True)
        self.assertNotIn('thread_start',self.events)
        self.assertEqual(self.events.count('dll_close'),1)
        self.assertFalse((self.root/'python-bootstrap.result.json').exists())

    def test_stop_monitor_error_still_closes_dll_scope(self):
        engine=self.engine();engine.thread.is_alive=lambda:True
        with self.assertRaises(ValueError):engine.close()
        self.assertEqual(self.events.count('dll_close'),1)

    def test_close_retains_monitor_and_directory_failures(self):
        engine=self.engine(close_error=OSError('directory close'))
        engine.thread.is_alive=lambda:True
        try:engine.close()
        except BaseExceptionGroup as group:errors=group.exceptions
        except BaseException as error:self.fail('Closure lost the monitor error: '+str(error))
        else:self.fail('Both closure failures must be retained')
        self.assertEqual(len(errors),2)
        self.assertIn('Stop-monitor',str(errors[0]))
        self.assertIn('directory close',str(errors[1]))

    def test_loaded_identity_includes_actual_python_dll_and_sfi_paths(self):
        self.events=[];_,config,stata,sfi,_=self.modules()
        paths=dict(engine=self.stata/'mp-64.dll',python_image=self.base/'python.exe',
            pystata_config=self.folder/'config.py',pystata_stata=self.folder/'stata.py',
            python_shared_library=self.base/'python311.dll',sfi_module=Path(sfi.__file__))
        for name in ('engine','pystata_config','pystata_stata'):paths[name].write_bytes(('artificial '+name).encode())
        self.value['runtime_identity_files']={name:[pinned(path)] for name,path in paths.items()}
        config.__file__=str(paths['pystata_config']);config.stlib=SimpleNamespace(_handle=123)
        stata.__file__=str(paths['pystata_stata'])
        kernel=SimpleNamespace(module_path=lambda handle:paths['python_image'] if handle is None
            else paths['engine'] if handle==123 else paths['python_shared_library'])
        with patch.object(runtime_roles,'sys',self.runtime):
            try:proof=runtime_roles.capture_runtime_identity(self.value,kernel,config,stata,sfi)
            except (TypeError,ValueError) as error:self.fail('Complete Python DLL/SFI identity is not supported: '+str(error))
        self.assertEqual(set(proof),set(paths))
        self.assertEqual(proof['python_shared_library'],pinned(paths['python_shared_library']))
        from deployment import check_runtime_identity
        check_runtime_identity(self.value,proof)

    def test_new_binding_is_supported_but_old_schema_is_rejected(self):
        import deployment
        try:deployment.validate(self.value)
        except ValueError as error:self.fail('New disabled DLL binding is not admitted: '+str(error))
        old=copy.deepcopy(self.value);old['schema']='WP06_NATIVE_EMPTY_PRIVATE_CACHE_V2'
        with self.assertRaises(ValueError):deployment.validate(old)

    def test_disabled_source_denies_before_dll_or_sdk(self):
        from win32_owner import Kernel
        with patch.object(runtime_roles.os,'add_dll_directory',side_effect=AssertionError('Forbidden live DLL scope')):
            with self.assertRaises(ValueError):Kernel(self.value,None)

    def role_cleanup(self,body_failure=False,kernel_failure=False):
        events=[];identity=dict(pid=1,birth=2)
        packet=dict(scope=scope(),origin=0,key='0'*64,worker_identity=identity,
                    inherited=dict(stop_event=10,ready_event=11))
        def close_engine():events.append('engine_close');raise OSError('engine close')
        def close_kernel():
            events.append('kernel_close')
            if kernel_failure:raise ValueError('kernel close')
        kernel=SimpleNamespace(read_private_bootstrap=lambda reader:packet,own=lambda handle:None,
            api=SimpleNamespace(GetCurrentProcess=lambda:777),identity=lambda handle:identity,
            now=lambda:0,frequency=1,signal=lambda handle:None,close_all=close_kernel)
        wire=SimpleNamespace(prepare=lambda *args:None,publish=lambda *args:None,read=lambda *args:{})
        engine=SimpleNamespace(identity={'artificial':True},python_bootstrap={'artificial':True},close=close_engine)
        with patch.object(runtime_roles,'load_active',return_value=(self.value,{})),\
             patch.object(runtime_roles,'cache_proof',return_value={}),\
             patch('win32_owner.Kernel',return_value=kernel),patch.object(runtime_roles,'check_bootstrap',return_value=None),\
             patch.object(runtime_roles,'Channel',return_value=wire),patch.object(runtime_roles,'StataEngine',return_value=engine),\
             patch.object(runtime_roles,'worker_loop',side_effect=RuntimeError('body failure') if body_failure else None):
            try:runtime_roles.main('worker',99,'artificial-binding.json')
            except BaseException as error:return events,error
        self.fail('Artificial role was expected to report its closure failure')

    def test_role_kernel_closes_even_if_engine_closure_fails(self):
        events,error=self.role_cleanup()
        self.assertIsInstance(error,OSError)
        self.assertEqual(events,['engine_close','kernel_close'])

    def test_role_preserves_body_engine_and_kernel_failures(self):
        events,error=self.role_cleanup(body_failure=True,kernel_failure=True)
        self.assertIsInstance(error,BaseExceptionGroup)
        self.assertEqual(events,['engine_close','kernel_close'])
        self.assertEqual([str(e) for e in error.exceptions],['body failure','engine close','kernel close'])

