"""Exact Python-DLL/SFI checks. Importing this module performs no native operation."""
import hashlib
from importlib.machinery import BuiltinImporter
import inspect
import json
from pathlib import Path
import re
import struct
import sys
from types import ModuleType


def check_spec(binding):
    spec=binding.get('python_dll_bootstrap')
    names={'schema','directory','base_executable','shared_library','sfi_module','python_version','metadata_limit_bytes'}
    if (type(spec) is not dict or set(spec)!=names or spec['schema']!='WP06_PYTHON_DLL_BOOTSTRAP_V1'
            or spec['python_version']!=[3,11,15] or type(spec['metadata_limit_bytes']) is not int
            or spec['metadata_limit_bytes']!=8192 or type(spec['directory']) is not str):
        raise ValueError('Exact Python DLL bootstrap specification required')
    base=Path(binding['python_base_root']).resolve()
    if Path(spec['directory'])!=base or Path(spec['directory'])!=Path(spec['directory']).resolve():
        raise ValueError('Python DLL directory must be the canonical bound base directory')
    expected={'base_executable':base/'python.exe','shared_library':base/'python311.dll',
              'sfi_module':Path(binding['stata_home']).resolve()/'ado/base/py/sfi.py'}
    for name,path in expected.items():
        row=spec[name]
        if (type(row) is not dict or set(row)!={'path','bytes','sha256'} or type(row['path']) is not str
                or Path(row['path'])!=path or Path(row['path'])!=Path(row['path']).resolve()
                or type(row['bytes']) is not int or row['bytes']<=0
                or type(row['sha256']) is not str or not re.fullmatch(r'[0-9a-f]{64}',row['sha256'])):
            raise ValueError('Foreign, aliased or malformed Python/SFI pin')
    return spec


def verify_files(binding):
    spec=check_spec(binding)
    for name in ('base_executable','shared_library','sfi_module'):
        row=spec[name];path=Path(row['path'])
        with path.open('rb') as stream:
            if path.stat().st_size!=row['bytes'] or hashlib.file_digest(stream,'sha256').hexdigest()!=row['sha256']:
                raise ValueError('Bound Python/SFI bytes changed')
            if name=='sfi_module':
                continue
            stream.seek(0);dos=stream.read(64)
            if len(dos)!=64 or dos[:2]!=b'MZ':
                raise ValueError('Missing Python PE header')
            stream.seek(struct.unpack_from('<I',dos,60)[0]);pe=stream.read(26)
            if (len(pe)!=26 or pe[:4]!=b'PE\0\0' or struct.unpack_from('<H',pe,4)[0]!=0x8664
                    or struct.unpack_from('<H',pe,24)[0]!=0x20b):
                raise ValueError('Python executable/DLL is not the bound x64 PE profile')
    return spec


def metadata(binding,runtime=sys):
    spec=check_spec(binding)
    roots=[str(Path(binding['stata_home'])/'utilities'),binding['site_packages']]
    cache=dict(pycache_prefix=runtime.pycache_prefix,dont_write_bytecode=runtime.dont_write_bytecode,
        cache_tag=runtime.implementation.cache_tag,isolated=runtime.flags.isolated==1,no_site=runtime.flags.no_site==1)
    wanted=dict(pycache_prefix=str(Path(binding['private_root'])/'pycache'),dont_write_bytecode=True,
        cache_tag='cpython-311',isolated=True,no_site=True)
    if (Path(runtime.executable).resolve()!=Path(spec['base_executable']['path'])
            or Path(runtime.prefix).resolve()!=Path(spec['directory'])
            or Path(runtime.base_prefix).resolve()!=Path(spec['directory'])
            or list(runtime.version_info[:3])!=spec['python_version'] or struct.calcsize('P')*8!=64
            or json.dumps(cache,sort_keys=True)!=json.dumps(wanted,sort_keys=True)
            or not {Path(p).resolve() for p in roots}.issubset({Path(p).resolve() for p in runtime.path})
            or any(name in runtime.modules for name in ('sfi','stata_plugin'))):
        raise ValueError('Worker Python identity, isolation, import roots or cold SFI state differs')
    result=dict(executable=runtime.executable,resolved_executable=str(Path(runtime.executable).resolve()),
        prefix=runtime.prefix,base_prefix=runtime.base_prefix,version=list(runtime.version_info[:3]),bits=64,
        explicit_import_roots=roots,cache_control=cache,python_shared_library=spec['shared_library'])
    if any(type(value) is not str or len(value)>2048 for value in
            (result['executable'],result['resolved_executable'],result['prefix'],result['base_prefix'],*roots)):
        raise ValueError('Bootstrap metadata path exceeds its bound')
    return result


def require_sfi(binding,config,sfi,plugin):
    spec=check_spec(binding)
    if (getattr(config,'stinitialized',None) is not True or getattr(config,'sfiinitialized',None) is not True
            or not isinstance(sfi,ModuleType) or sfi.__name__!='sfi'
            or Path(getattr(sfi,'__file__','')).resolve()!=Path(spec['sfi_module']['path'])
            or not isinstance(plugin,ModuleType) or plugin.__name__!='stata_plugin'
            or getattr(sfi,'_stp',None) is not plugin or getattr(plugin,'__file__',None) is not None):
        raise ValueError('Positive vendor SFI and registered plugin evidence required')
    module_spec=getattr(plugin,'__spec__',None)
    if module_spec is not None and (module_spec.name!='stata_plugin' or module_spec.origin!='built-in'
                                    or module_spec.loader is not BuiltinImporter):
        raise ValueError('Foreign plugin module origin')
    # C-created embedded modules may have no ModuleSpec; require their actual C API ownership.
    for name in ('_st_getvalue','_st_getglobal'):
        function=getattr(plugin,name,None)
        if (not inspect.isbuiltin(function) or getattr(function,'__module__',None)!='stata_plugin'
                or getattr(function,'__self__',None) is not plugin):
            raise ValueError('Plugin API is not the registered built-in module')
    proof=dict(schema='WP06_POSITIVE_SFI_V1',stata_initialized=True,sfi_initialized=True,
        sfi_source=spec['sfi_module'],plugin=dict(name='stata_plugin',
            origin='built-in' if module_spec is not None else 'C_API_MODULE_NO_SPEC',
            sfi_reference=True,builtin_api=True))
    check_ready(binding,proof)
    return proof


def check_ready(binding,proof):
    spec=check_spec(binding)
    if type(proof) is not dict or type(proof.get('plugin')) is not dict:
        raise ValueError('Missing positive Python bootstrap proof')
    expected=dict(schema='WP06_POSITIVE_SFI_V1',stata_initialized=True,sfi_initialized=True,
        sfi_source=spec['sfi_module'],plugin=dict(name='stata_plugin',origin=proof['plugin'].get('origin'),
            sfi_reference=True,builtin_api=True))
    if (expected['plugin']['origin'] not in {'built-in','C_API_MODULE_NO_SPEC'}
            or json.dumps(proof,sort_keys=True)!=json.dumps(expected,sort_keys=True)):
        raise ValueError('False, foreign or malformed Python bootstrap proof')
    return proof


def record(binding,kind,payload):
    spec=check_spec(binding)
    if kind not in {'preinit','result','failure'}:
        raise ValueError('Unknown fixed Python bootstrap record')
    row=dict(scope=binding['run_scope'],kind=kind,payload=payload,
        binding_sha256=hashlib.sha256(json.dumps(binding,sort_keys=True,separators=(',',':')).encode()).hexdigest())
    raw=json.dumps(row,sort_keys=True,separators=(',',':'),ensure_ascii=True).encode('utf-8')
    if len(raw)>spec['metadata_limit_bytes']:
        raise ValueError('Python bootstrap record exceeds its byte bound')
    with (Path(binding['private_root'])/('python-bootstrap.'+kind+'.json')).open('xb') as stream:
        stream.write(raw);stream.flush()
