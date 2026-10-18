"""Windows ABI implementation with an explicitly injected ARTIFICIAL function table.

No DLL loading, endpoint discovery or runtime adoption. Injection is trusted test
configuration, not a sandbox against malicious caller-supplied functions.
"""
import copy
import ctypes as c
import re
from pathlib import PureWindowsPath
from journal_protocol import require, exact, integer, validate_binding, sha, digest

DWORD=c.c_uint32
BOOL=c.c_int32
HANDLE=c.c_void_p
WORD=c.c_uint16
SIZE=c.c_size_t

class FILETIME(c.Structure):
    _fields_=[('low',DWORD),('high',DWORD)]

class STARTUPINFO(c.Structure):
    _fields_=[('cb',DWORD),('lpReserved',HANDLE),('lpDesktop',HANDLE),('lpTitle',HANDLE),
       ('dwX',DWORD),('dwY',DWORD),('dwXSize',DWORD),('dwYSize',DWORD),
       ('dwXCountChars',DWORD),('dwYCountChars',DWORD),('dwFillAttribute',DWORD),
       ('dwFlags',DWORD),('wShowWindow',WORD),('cbReserved2',WORD),('lpReserved2',HANDLE),
       ('hStdInput',HANDLE),('hStdOutput',HANDLE),('hStdError',HANDLE)]

class STARTUPINFOEX(c.Structure):
    _fields_=[('StartupInfo',STARTUPINFO),('lpAttributeList',HANDLE)]

class PROCESS_INFORMATION(c.Structure):
    _fields_=[('hProcess',HANDLE),('hThread',HANDLE),('dwProcessId',DWORD),('dwThreadId',DWORD)]

class SECURITY_ATTRIBUTES(c.Structure):
    _fields_=[('nLength',DWORD),('lpSecurityDescriptor',HANDLE),('bInheritHandle',BOOL)]

class OVERLAPPED(c.Structure):
    _fields_=[('Internal',SIZE),('InternalHigh',SIZE),('Offset',DWORD),('OffsetHigh',DWORD),('hEvent',HANDLE)]

def utf16(text):
    require(type(text) is str and bool(text) and '\0' not in text,'Invalid UTF-16 input')
    raw=text.encode('utf-16-le')+b'\0\0'
    return (c.c_uint16*(len(raw)//2)).from_buffer_copy(raw)

def abi_signatures():
    """Unbound declarations. A separately authorized resolver must apply these."""
    P=HANDLE;U=DWORD;B=BOOL
    return {
      'CreateProcessW':([P,P,P,P,B,U,P,P,P,P],B),
      'InitializeProcThreadAttributeList':([P,U,U,P],B),
      'UpdateProcThreadAttribute':([P,U,SIZE,P,SIZE,P,P],B),
      'DeleteProcThreadAttributeList':([P],None),
      'GetCurrentProcess':([],P),'GetHandleInformation':([P,P],B),
      'DuplicateHandle':([P,P,P,P,U,B,U],B),'CloseHandle':([P],B),
      'GetProcessId':([P],U),'GetProcessTimes':([P,P,P,P,P],B),
      'ResumeThread':([P],U),'WaitForSingleObject':([P,U],U),
      'GetExitCodeProcess':([P,P],B),'SetEvent':([P],B),
      'CreateEventW':([P,B,B,P],P),'TerminateProcess':([P,U],B),
      'ConvertStringSecurityDescriptorToSecurityDescriptorW':([P,U,P,P],B),
      'LocalFree':([P],P),'CreateNamedPipeW':([P,U,U,U,U,U,U,P],P),
      'CreateFileW':([P,U,U,P,U,U,P],P),
      'GetNamedPipeClientProcessId':([P,P],B),'GetNamedPipeServerProcessId':([P,P],B),
      'ConnectNamedPipe':([P,P],B),'ReadFile':([P,P,U,P,P],B),'WriteFile':([P,P,U,P,P],B),
      'CancelIoEx':([P,P],B),'GetOverlappedResult':([P,P,P,B],B),
      'GetLastError':([],U),'QueryPerformanceCounter':([P],B),'QueryPerformanceFrequency':([P],B)}


class WindowsBackend:
    evidence_domain='ARTIFICIAL'
    def __init__(self,api,bootstrap_handles,command_lines,clock,termination_bindings=()):
        require(api is not None and getattr(api,'evidence_domain',None)=='ARTIFICIAL','No adopted native API provider')
        require(type(bootstrap_handles) is dict and type(command_lines) is dict and set(bootstrap_handles)==set(command_lines),'Pinned bootstrap configuration required')
        require(set(bootstrap_handles)<={'O','S','C','W'},'Unknown role')
        for role,h in bootstrap_handles.items():
            integer(h,True);utf16(command_lines[role])
        for value in termination_bindings:digest(value)
        self.api=api;self.clock=clock;self._bootstrap=bootstrap_handles.copy();self._commands=command_lines.copy()
        self._termination_bindings=frozenset(termination_bindings)
        self._owned={};self._operations={};self._counter=0;self._launched=set()
        self.failed=False;self.quarantine=[]

    def _new(self,kind,handle,**data):
        require(type(handle) is int and handle>0 and handle!=c.c_void_p(-1).value,'Invalid handle')
        self._counter+=1;token='NATIVE_'+str(self._counter)
        self._owned[token]=dict(kind=kind,handle=handle,closed=False,**data)
        return token

    def _row(self,token,kind=None):
        require(type(token) is str and token in self._owned,'Unowned handle')
        row=self._owned[token]
        require(not row['closed'] and not row.get('close_uncertain',False) and (kind is None or row['kind']==kind),'Wrong/closed/quarantined owned handle')
        return row

    def _identity(self,h,expected):
        pid=self.api.GetProcessId(h)
        created,exited,kernel,user=FILETIME(),FILETIME(),FILETIME(),FILETIME()
        require(self.api.GetProcessTimes(h,c.byref(created),c.byref(exited),c.byref(kernel),c.byref(user))!=0,'Process-time capture failed')
        captured=copy.deepcopy(expected)
        captured['pid']=str(pid);captured['creation_time_100ns']=str((created.high<<32)|created.low)
        validate_binding(captured)
        require(captured==expected,'Captured process identity differs; do not resume')
        return captured

    def create_process(self,role,spec):
        require(not self.failed and role in self._bootstrap and role not in self._launched,'No role launch/retry authority')
        exact(spec,{'binding','application','environment','inherited_handles','remote_clients','overlapped','acl_evidence','bootstrap_deadline_tick'})
        validate_binding(spec['binding']);application=spec['application'];environment=spec['environment']
        require(type(application) is str and PureWindowsPath(application).is_absolute() and application.lower().endswith('.exe'),'Absolute fixed application required')
        require(self._commands[role].startswith('"'+application+'" '),'Command does not pin application')
        require(type(environment) is dict and set(environment)=={'SYSTEMROOT'} and type(environment['SYSTEMROOT']) is str and bool(environment['SYSTEMROOT']) and '\0' not in environment['SYSTEMROOT'],'Minimal environment required')
        require(spec['inherited_handles']==['ART_PRIVATE_BOOTSTRAP'] and spec['remote_clients'] is False and spec['overlapped'] is True,'Invalid bootstrap boundary')
        digest(spec['acl_evidence']);integer(spec['bootstrap_deadline_tick'],True)
        require(self.clock.now_tick()<spec['bootstrap_deadline_tick'],'Bootstrap deadline expired')
        flag=DWORD();require(self.api.GetHandleInformation(self._bootstrap[role],c.byref(flag))!=0 and flag.value&1,'Bootstrap handle not inheritable')
        self._launched.add(role)
        size=SIZE();attrs=None;initialized=False;retained=set()
        try:
            result=self.api.InitializeProcThreadAttributeList(None,1,0,c.byref(size))
            require(result==0 and self.api.GetLastError()==122 and 0<size.value<=65536,'Attribute-list sizing failed')
            attrs=c.create_string_buffer(size.value)
            require(self.api.InitializeProcThreadAttributeList(attrs,1,0,c.byref(size))!=0,'Attribute-list initialization failed');initialized=True
            inherited=(HANDLE*1)(self._bootstrap[role])
            require(self.api.UpdateProcThreadAttribute(attrs,0,0x20002,inherited,c.sizeof(inherited),None,None)!=0,'Explicit handle list failed')
            startup=STARTUPINFOEX();startup.StartupInfo.cb=c.sizeof(STARTUPINFOEX);startup.lpAttributeList=c.addressof(attrs)
            info=PROCESS_INFORMATION();app=utf16(application);cmd=utf16(self._commands[role])
            env_raw=('SYSTEMROOT='+environment['SYSTEMROOT']+'\0\0').encode('utf-16-le')
            env=(c.c_uint16*(len(env_raw)//2)).from_buffer_copy(env_raw)
            require(self.api.CreateProcessW(app,cmd,None,None,True,0x80404,env,None,c.byref(startup),c.byref(info))!=0,'CreateProcessW failed')
            retained.update((info.hProcess,info.hThread))
            captured=self._identity(info.hProcess,spec['binding'])
            require(info.dwProcessId==int(captured['pid']),'Process-info identity mismatch')
            current=self.api.GetCurrentProcess();narrow=HANDLE()
            require(self.api.DuplicateHandle(current,info.hProcess,current,c.byref(narrow),0x101000,False,0)!=0,'Rights narrowing failed')
            retained.add(narrow.value)
            termination=None
            if sha(captured) in self._termination_bindings:
                dedicated=HANDLE()
                require(self.api.DuplicateHandle(current,info.hProcess,current,c.byref(dedicated),1,False,0)!=0,'Termination capability capture failed')
                termination=dedicated.value;retained.add(termination)
            require(self.clock.now_tick()<spec['bootstrap_deadline_tick'],'Capture exceeded bootstrap deadline')
            require(self.api.ResumeThread(info.hThread)!=0xffffffff,'Primary-thread resume failed')
            for h in (info.hThread,info.hProcess):
                require(self.api.CloseHandle(h)!=0,'Creator-handle closure uncertain');retained.remove(h)
            token=self._new('PROCESS',narrow.value,binding=captured,role=role,event=None,pipe=None,termination=None)
            if termination is not None:
                self._owned[token]['termination']=self._new('TERMINATE',termination,binding=captured,used=False)
            return dict(token=token,binding=copy.deepcopy(captured),rights=['QUERY','SYNCHRONIZE'],creator_handles_closed=True,primary_thread_closed=True,creation_captured=True)
        except Exception as error:
            self.failed=True
            if retained:self.quarantine.append(dict(role=role,handles=sorted(h for h in retained if h),reason=type(error).__name__,disposition='RETAIN_NO_RETRY'))
            raise
        finally:
            if initialized:self.api.DeleteProcThreadAttributeList(attrs)

    def exit_status(self,token):
        row=self._row(token,'PROCESS');status=self.api.WaitForSingleObject(row['handle'],0)
        require(status in (0,258),'Process wait failed/unknown')
        if status==258:return dict(signaled=False,exit_code=None)
        code=DWORD();require(self.api.GetExitCodeProcess(row['handle'],c.byref(code))!=0,'Exit-code readback failed')
        return dict(signaled=True,exit_code=code.value)

    def signal(self,token):
        row=self._row(token,'PROCESS');event=self._row(row['event'],'EVENT')
        if 'authority' in row:
            require(row['authority'].authority_current(row['authority_generation']),'Revoked prearmed authority')
        return 'ATTEMPTED' if self.api.SetEvent(event['handle'])!=0 else 'UNKNOWN'

    def bind_authority(self,token,provider,generation):
        row=self._row(token,'PROCESS')
        require('authority' not in row and provider.binding==row['binding'] and provider.authority_current(generation),'No fresh exact local authority')
        row['authority']=provider;row['authority_generation']=generation

    def termination_handle(self,token,binding):
        row=self._row(token,'PROCESS');require(row['binding']==binding,'Termination binding mismatch')
        cap=row['termination'];self._row(cap,'TERMINATE')
        return dict(token=cap,binding=copy.deepcopy(binding),rights=['TERMINATE'])

    def terminate(self,token):
        row=self._row(token,'TERMINATE');require(not row['used'],'Termination already consumed');row['used']=True
        return 'REQUESTED' if self.api.TerminateProcess(row['handle'],1)!=0 else 'UNKNOWN'

    def close(self,token):
        row=self._row(token)
        require(not any((op['resource']==token or op.get('origin')==token or op['event']==token) and op['status']=='PENDING' for op in self._operations.values()),'Pending I/O retained')
        if row['kind']=='PROCESS':require(self.exit_status(token)['signaled'],'Live process handle retained')
        try:closed=self.api.CloseHandle(row['handle'])!=0
        except Exception:closed=False
        if not closed:
            row['close_uncertain']=True
            self.quarantine.append(dict(token=token,handles=[row['handle']],reason='CLOSE_UNCERTAIN',disposition='RETAIN_NO_RETRY'))
            raise ValueError('Handle closure uncertain')
        row['closed']=True

    def _security(self,sids):
        require(type(sids) is list and 0<len(sids)<=4 and len(set(sids))==len(sids),'Explicit account ACL required')
        require(all(type(s) is str and re.fullmatch(r'S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+',s) for s in sids),'Only explicit account SIDs allowed')
        text=utf16('D:P'+''.join('(A;;GA;;;'+s+')' for s in sids))
        descriptor=HANDLE()
        require(self.api.ConvertStringSecurityDescriptorToSecurityDescriptorW(text,1,c.byref(descriptor),None)!=0 and descriptor.value,'Security descriptor unavailable')
        sa=SECURITY_ATTRIBUTES(c.sizeof(SECURITY_ATTRIBUTES),descriptor.value,False)
        return sa,descriptor.value

    def _free_security(self,descriptor):
        if self.api.LocalFree(descriptor) is not None:
            self.quarantine.append(dict(descriptor=descriptor,reason='SECURITY_FREE_UNCERTAIN',disposition='RETAIN_NO_RETRY'))
            raise ValueError('Security-descriptor release uncertain')

    def create_event(self,sids):
        sa,descriptor=self._security(sids)
        try:
            h=self.api.CreateEventW(c.byref(sa),True,False,None)
            return self._new('EVENT',h)
        finally:self._free_security(descriptor)

    @staticmethod
    def _pipe_name(name):
        require(type(name) is str and re.fullmatch(r'\\\\\.\\pipe\\WP06_ART_[A-Za-z0-9_-]{1,100}',name),'Only fixed local artificial pipe namespace allowed')
        return utf16(name)

    def create_pipe(self,name,sids):
        name=self._pipe_name(name);sa,descriptor=self._security(sids)
        try:
            h=self.api.CreateNamedPipeW(name,0x40080003,14,1,8192,8192,0,c.byref(sa))
            return self._new('PIPE',h,server=True,connected=False)
        finally:self._free_security(descriptor)

    def open_pipe(self,name):
        h=self.api.CreateFileW(self._pipe_name(name),0xc0000000,0,None,3,0x40000000,None)
        return self._new('PIPE',h,server=False,connected=True)

    def attach_control(self,process,event,pipe):
        row=self._row(process,'PROCESS');self._row(event,'EVENT');channel=self._row(pipe,'PIPE')
        require(row['role']=='W' and channel['connected'],'Worker/connected channel required')
        require(not self.exit_status(process)['signaled'],'Exited peer cannot authenticate')
        peer=DWORD()
        query=self.api.GetNamedPipeClientProcessId if channel['server'] else self.api.GetNamedPipeServerProcessId
        require(query(channel['handle'],c.byref(peer))!=0 and peer.value==int(row['binding']['pid']),'Kernel pipe-peer identity mismatch')
        require(row['event'] is None and row['pipe'] is None,'Control channel already bound')
        row['event']=event;row['pipe']=pipe

    def event_observed(self,event):
        row=self._row(event,'EVENT');result=self.api.WaitForSingleObject(row['handle'],0)
        require(result in (0,258),'Event wait failed/unknown')
        return result==0

    def _start(self,resource,wire,kind,origin=None):
        row=self._row(resource,'PIPE')
        require(not any(op['resource']==resource and op['status']=='PENDING' for op in self._operations.values()),'I/O already pending')
        require(type(wire) is bytes and len(wire)<=8192,'Bounded frame required')
        event=self.api.CreateEventW(None,True,False,None)
        event_token=self._new('IO_EVENT',event)
        overlap=OVERLAPPED();overlap.hEvent=event
        buffer=c.create_string_buffer(wire,len(wire)) if wire else c.create_string_buffer(8192)
        self._counter+=1;operation='IO_'+str(self._counter)
        op=dict(resource=resource,origin=origin,kind=kind,event=event_token,overlap=overlap,buffer=buffer,
                requested=len(wire),cancel=False,status='PENDING',wire=b'')
        self._operations[operation]=op
        done=DWORD()
        try:
            if kind=='CONNECT':ok=self.api.ConnectNamedPipe(row['handle'],c.byref(overlap))
            elif wire:ok=self.api.WriteFile(row['handle'],buffer,len(wire),c.byref(done),c.byref(overlap))
            else:ok=self.api.ReadFile(row['handle'],buffer,8192,c.byref(done),c.byref(overlap))
            if not ok:
                error=self.api.GetLastError()
                if kind=='CONNECT' and error==535:
                    op['status']='SUCCESS';row['connected']=True;self.close(event_token)
                elif error!=997:
                    op['status']='FAILED';self.close(event_token)
            # Even synchronous success is read back through the same OVERLAPPED.
            return operation
        except Exception:
            if op['status']!='PENDING':op['status']='CLEANUP_UNCERTAIN'
            self.quarantine.append(dict(operation=operation,reason='SUBMISSION_UNCERTAIN',disposition='RETAIN_NO_RETRY'))
            raise

    def connect_pipe(self,pipe):
        row=self._row(pipe,'PIPE');require(row['server'] and not row['connected'],'Only unconnected server can connect')
        return self._start(pipe,b'','CONNECT')

    def start_io(self,token,wire):
        row=self._row(token,'PROCESS');pipe=row['pipe'];self._row(pipe,'PIPE')
        return self._start(pipe,wire,'WRITE' if wire else 'READ',origin=token)

    def cancel(self,operation):
        require(operation in self._operations,'Unowned operation');op=self._operations[operation]
        require(op['status']=='PENDING' and not op['cancel'],'No repeat/completed cancellation')
        op['cancel']=True;row=self._row(op['resource'],'PIPE')
        return 'REQUESTED' if self.api.CancelIoEx(row['handle'],c.byref(op['overlap']))!=0 else 'UNKNOWN'

    def completion(self,operation):
        require(operation in self._operations,'Unowned operation');op=self._operations[operation]
        if op['status']=='PENDING':
            row=self._row(op['resource'],'PIPE');count=DWORD()
            ok=self.api.GetOverlappedResult(row['handle'],c.byref(op['overlap']),c.byref(count),False)
            error=0 if ok else self.api.GetLastError()
            if not ok and error in (996,997):return dict(status='PENDING',wire=b'')
            op['status']='SUCCESS' if ok else 'CANCELLED' if error==995 else 'FAILED'
            if ok:
                if op['kind']=='CONNECT':row['connected']=True
                elif op['kind']=='WRITE':
                    if count.value!=op['requested']:op['status']='FAILED'
                elif 0<count.value<=8192:op['wire']=op['buffer'].raw[:count.value]
                else:op['status']='FAILED'
            try:self.close(op['event'])
            except Exception:
                op['status']='CLEANUP_UNCERTAIN'
                row['close_uncertain']=True
                raise
        return dict(status=op['status'],wire=op['wire'])

    def inventory(self):
        """Observable ownership facts, not a signed O/L cleanup certificate."""
        return dict(resources=[dict(token=t,kind=r['kind'],closed=r['closed'],quarantined=r.get('close_uncertain',False),handle=r['handle']) for t,r in self._owned.items()],
                    pending=[k for k,v in self._operations.items() if v['status']=='PENDING'],
                    quarantine=copy.deepcopy(self.quarantine))
