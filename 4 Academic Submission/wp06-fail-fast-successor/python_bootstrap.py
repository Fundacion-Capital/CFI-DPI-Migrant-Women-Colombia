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


def verify_config(binding, config):
    path = Path(config.__file__).resolve(strict=True)
    expected = Path(binding['stata_home']).resolve() / 'utilities/pystata/config.py'
    pins = binding['runtime_identity_files']['pystata_config']
    with path.open('rb') as stream:
        digest = hashlib.file_digest(stream, 'sha256').hexdigest()
    if path != expected or pins != [dict(path=str(path), bytes=path.stat().st_size, sha256=digest)]:
        raise ValueError('Vendor bootstrap source is not the pinned config.py')
    for function in (config.init, config._init_stata, config._get_executable_path):
        if (not inspect.isfunction(function) or function.__globals__ is not vars(config)
                or Path(function.__code__.co_filename).resolve() != path):
            raise ValueError('Vendor bootstrap function does not belong to pinned config.py')


def check_return(payload):
    if (type(payload) is not dict or set(payload) !=
            {'schema', 'state', 'return_code', 'raw_executable', 'resolved_executable'}
            or payload['schema'] != 'WP06_BOOTSTRAP_RETURN_V1'):
        raise ValueError('Unknown bootstrap-return schema')
    raw, resolved = payload['raw_executable'], payload['resolved_executable']
    if not ((raw is None and resolved is None) or
            all(type(value) is str and 0 < len(value) <= 2048 and '\0' not in value
                and Path(value).is_absolute() for value in (raw, resolved))):
        raise ValueError('Malformed executable handoff')
    state, rc = payload['state'], payload['return_code']
    if state == 'RETURNED' and type(rc) is int and -(2**31) <= rc < 2**31 and raw is not None:
        return payload
    if rc is None and (state == 'RAISED' or (state == 'NOT_REACHED' and raw is None)):
        return payload
    raise ValueError('Malformed native-return status')


def initialize_with_return(binding, config):
    verify_config(binding, config)
    native, resolver = config._init_stata, config._get_executable_path
    evidence = dict(schema='WP06_BOOTSTRAP_RETURN_V1', state='NOT_REACHED',
                    return_code=None, raw_executable=None, resolved_executable=None)
    publication_error = None

    def publish():
        nonlocal publication_error
        try:
            if evidence['raw_executable'] is not None:
                evidence['resolved_executable'] = str(Path(evidence['raw_executable']).resolve())
            record(binding, 'native_return', evidence)
        except BaseException as error:
            publication_error = error

    def handoff():
        path = resolver()
        evidence['raw_executable'] = path
        return path

    def initialize(splash):
        if evidence['state'] != 'NOT_REACHED':
            raise RuntimeError('Unexpected second vendor bootstrap call')
        evidence['state'] = 'RAISED'
        try:
            config._get_executable_path = handoff
            try:
                rc = native(splash)
            finally:
                config._get_executable_path = resolver
            evidence.update(state='RETURNED', return_code=rc)
            return rc
        finally:
            # Preserve the return even if later vendor setup never comes back.
            publish()

    try:
        config._init_stata = initialize
        try:
            result = config.init('mp', splash=False)
        finally:
            config._init_stata = native
    except BaseException as primary:
        if evidence['state'] == 'NOT_REACHED':
            publish()
        if publication_error is not None:
            raise BaseExceptionGroup('Vendor initialization and return-evidence publication failed',
                                     [primary, publication_error]) from primary
        raise
    if evidence['state'] == 'NOT_REACHED':
        publish()
    if publication_error is not None:
        raise publication_error
    check_return(evidence)
    if evidence['state'] != 'RETURNED':
        raise ValueError('Successful vendor initialization lacks a native return')
    return result


def record(binding,kind,payload):
    spec=check_spec(binding)
    if kind not in {'preinit','result','failure','native_return'}:
        raise ValueError('Unknown fixed Python bootstrap record')
    if kind == 'native_return':
        check_return(payload)
    row=dict(scope=binding['run_scope'],kind=kind,payload=payload,
        binding_sha256=hashlib.sha256(json.dumps(binding,sort_keys=True,separators=(',',':')).encode()).hexdigest())
    raw=json.dumps(row,sort_keys=True,separators=(',',':'),ensure_ascii=True).encode('utf-8')
    if len(raw)>spec['metadata_limit_bytes']:
        raise ValueError('Python bootstrap record exceeds its byte bound')
    with (Path(binding['private_root'])/('python-bootstrap.'+kind+'.json')).open('xb') as stream:
        stream.write(raw);stream.flush()


def read_native_return(binding):
    spec = check_spec(binding)
    with (Path(binding['private_root']) / 'python-bootstrap.native_return.json').open('rb') as stream:
        raw = stream.read(spec['metadata_limit_bytes'] + 1)
    if len(raw) > spec['metadata_limit_bytes']:
        raise ValueError('Bootstrap return record exceeds its byte bound')
    row = json.loads(raw)
    if type(row) is not dict:
        raise ValueError('Malformed bootstrap return record')
    payload = check_return(row.get('payload'))
    expected = dict(scope=binding['run_scope'], kind='native_return', payload=payload,
                    binding_sha256=hashlib.sha256(json.dumps(binding, sort_keys=True,
                    separators=(',', ':')).encode()).hexdigest())
    if raw != json.dumps(expected, sort_keys=True, separators=(',', ':'), ensure_ascii=True).encode('utf-8'):
        raise ValueError('Foreign or noncanonical bootstrap return record')
    return payload
