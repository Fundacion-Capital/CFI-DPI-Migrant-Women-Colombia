"""Owned-resource policy boundary. Live providers are intentionally unadopted.

No DLL load, API call, endpoint, clock read or process lookup occurs on import.
Only an explicitly injected ARTIFICIAL provider can be admitted in this build.
"""
import copy
import pathlib
from journal_protocol import admit_phase,validate_binding,require,integer,decimal,sha,exact,digest

def win32_signatures():
    """Unbound ABI declarations, not a DLL loader or host compatibility probe."""
    import ctypes as c
    BOOL=c.c_int;DWORD=c.c_uint32;HANDLE=c.c_void_p
    class FILETIME(c.Structure):_fields_=[('low',DWORD),('high',DWORD)]
    return {
        'CreateProcessW':(BOOL,[c.c_wchar_p,c.c_wchar_p,c.c_void_p,c.c_void_p,BOOL,DWORD,c.c_void_p,c.c_wchar_p,c.c_void_p,c.c_void_p]),
        'DuplicateHandle':(BOOL,[HANDLE,HANDLE,HANDLE,c.POINTER(HANDLE),DWORD,BOOL,DWORD]),
        'GetProcessTimes':(BOOL,[HANDLE,*([c.POINTER(FILETIME)]*4)]),
        'WaitForSingleObject':(DWORD,[HANDLE,DWORD]),
        'SetEvent':(BOOL,[HANDLE]),'CloseHandle':(BOOL,[HANDLE]),
        'CancelIoEx':(BOOL,[HANDLE,c.c_void_p]),
        'GetOverlappedResult':(BOOL,[HANDLE,c.c_void_p,c.POINTER(DWORD),BOOL]),
        'TerminateProcess':(BOOL,[HANDLE,c.c_uint32]),
        'GetNamedPipeClientProcessId':(BOOL,[HANDLE,c.POINTER(DWORD)]),
        'GetNamedPipeServerProcessId':(BOOL,[HANDLE,c.POINTER(DWORD)])}

class Bridge:
    def __init__(self,native=None,expected_scope=None,decisions=None,observations=None,clock=None,owner_role='S',case_id='AC17',_shared=None):
        self._native=native;self._scope=copy.deepcopy(expected_scope);self._decisions=copy.deepcopy(decisions or []);self._observations=copy.deepcopy(observations or [])
        self._clock=clock;self._owner=owner_role;self._case=case_id
        self._shared=_shared if _shared is not None else dict(owned={},pending={},signaled=set(),fallback=set(),launches=0,counts={},failed=False,last_tick=None,clock_quarantined=False,authority_generation=0,stop_permits={},io_outcomes=[],cooperative_outcomes={},attempts={})
        self._owned=self._shared['owned'];self._pending=self._shared['pending'];self._signaled=self._shared['signaled'];self._fallback=self._shared['fallback'];self._counts=self._shared['counts']
        self._termination_resources={};self._retention_released=False
    def for_owner(self,role):
        self._admit('QUIESCENT_BOOTSTRAP')
        require((self._owner,role) in (('L','O'),('O','S')) and any(r['owner_role']==role and r['state']=='LIVE' for r in self._owned.values()),'Missing retained parent identity')
        return Bridge(self._native,self._scope,self._decisions,self._observations,self._clock,role,self._case,self._shared)
    @property
    def pending_count(self):return len(self._pending)
    @property
    def io_outcomes(self):return copy.deepcopy(self._shared['io_outcomes'])
    def refresh_authority(self,decisions,observations):
        old=self._decisions,self._observations;self._decisions=copy.deepcopy(decisions);self._observations=copy.deepcopy(observations)
        try:self._admit('PRECREATION')
        except Exception:self._decisions,self._observations=old;raise
        self._shared['authority_generation']+=1
    def _local_now(self):
        require(self._scope is not None and self._clock is not None and not self._shared['clock_quarantined'],'Clock/scope unavailable or quarantined')
        now=self._clock.now_tick();integer(now)
        if self._clock.frequency_hz!=int(self._scope['binding']['qpc_frequency_hz']) or self._clock.domain!=self._scope['binding']['clock_domain'] or (self._shared['last_tick'] is not None and now<self._shared['last_tick']):
            self._shared['clock_quarantined']=True;raise ValueError('Clock continuity lost; no reanimation')
        self._shared['last_tick']=now;return now
    def _admit(self,phase):
        require(self._native is not None and getattr(self._native,'evidence_domain',None)=='ARTIFICIAL','Live/unconfigured native providers are unavailable')
        require(self._scope is not None and self._clock is not None,'Explicit artificial scope/clock required')
        scope=copy.deepcopy(self._scope);scope['now_tick']=self._local_now()
        for key in ('bootstrap_deadline_tick','ipc_deadline_tick','control_deadline_tick','cleanup_deadline_tick'):integer(scope[key],True)
        require(scope['bootstrap_deadline_tick']<scope['control_deadline_tick']<=scope['cleanup_deadline_tick'] and scope['ipc_deadline_tick']<=scope['cleanup_deadline_tick'],'Inconsistent immutable phase budgets')
        require(self._clock.frequency_hz==int(scope['binding']['qpc_frequency_hz']) and self._clock.domain==scope['binding']['clock_domain'],'Clock discontinuity')
        result=admit_phase(phase,self._decisions,self._observations,scope,scope['verify_decision'])
        require(result['eligible'],'Missing/expired phase authority');return scope
    def _resource(self,token):
        require(type(token) is str and token in self._owned,'Unknown owned token')
        row=self._owned[token];require(row['state']!='CLOSED','Closed resource');return row
    def bootstrap(self,role,approved_spec):
        scope=self._admit('QUIESCENT_BOOTSTRAP');require(not self._shared['failed'],'Failed bootstrap consumed allowance')
        creators={'O':'L','S':'O','C':'O','W':'S'};require(role in creators and creators[role]==self._owner,'Wrong ownership topology')
        exact(approved_spec,{'binding','application','environment','inherited_handles','remote_clients','overlapped','acl_evidence','bootstrap_deadline_tick'})
        b=validate_binding(approved_spec['binding']);require(b==scope['binding'],'Unapproved target binding')
        require(approved_spec==scope['actor_specs'][role] and approved_spec['bootstrap_deadline_tick']==scope['bootstrap_deadline_tick'],'Exact approved role spec/budget required')
        application=approved_spec['application'];require(type(application) is str and pathlib.PureWindowsPath(application).is_absolute() and application.lower().endswith('.exe') and '\x00' not in application,'Explicit absolute executable required')
        env=approved_spec['environment'];require(type(env) is dict and set(env)=={'SYSTEMROOT'} and type(env['SYSTEMROOT']) is str and env['SYSTEMROOT'],'Minimal reviewed environment required')
        require(approved_spec['inherited_handles']==['ART_PRIVATE_BOOTSTRAP'],'Only explicit artificial bootstrap handle allowed')
        require(approved_spec['remote_clients'] is False and approved_spec['overlapped'] is True,'Restricted overlapped local transport required');digest(approved_spec['acl_evidence'])
        require(scope['now_tick']<integer(approved_spec['bootstrap_deadline_tick'],True),'Bootstrap expired')
        limit=2 if (role=='C' and self._case=='AC18') or (role=='W' and self._case=='AC19') else 1
        require(self._case in {'AC'+str(i) for i in range(17,23)} and self._counts.get(role,0)<limit,'Generation allowance exhausted')
        require(not any(r['owner_role']==role and r['state']=='LIVE' for r in self._owned.values()),'Overlapping generation')
        require(all(r['binding']!=b for r in self._owned.values() if r['owner_role']==role),'Old full identity/lease cannot become a replacement')
        require(sum(r['state']=='LIVE' for r in self._owned.values())<4 and self._shared['launches']<(5 if self._case in ('AC18','AC19') else 4),'Launch cap')
        self._shared['launches']+=1;self._counts[role]=self._counts.get(role,0)+1
        try:
            captured=self._native.create_process(role,copy.deepcopy(approved_spec))
            exact(captured,{'token','binding','rights','creator_handles_closed','primary_thread_closed','creation_captured'})
            require(captured['binding']==b and captured['rights']==['QUERY','SYNCHRONIZE'] and all(captured[k] is True for k in ('creator_handles_closed','primary_thread_closed','creation_captured')),'Incomplete ownership/rights capture')
            token=captured['token'];require(type(token) is str and token and token not in self._owned,'Invalid/duplicate resource token')
            self._owned[token]=dict(resource_id=token,kind='PROCESS',owner_role=role,generation=b['worker_epoch'],binding_digest=sha(b),operation_id=None,rights=captured['rights'],state='LIVE',deadline_tick=approved_spec['bootstrap_deadline_tick'],disposition='OWNED',binding=b,native_token=token,waiting=False)
        except Exception:self._shared['failed']=True;raise
        return copy.deepcopy(dict(token=token,binding=b,rights=captured['rights']))
    def capture_identity(self,token):
        self._admit('QUIESCENT_BOOTSTRAP');return copy.deepcopy(self._resource(token)['binding'])
    def worker_token(self,binding):
        self._admit('QUIESCENT_BOOTSTRAP');validate_binding(binding)
        matches=[token for token,row in self._owned.items() if row['owner_role']=='W' and row['binding']==binding and row['state']=='LIVE']
        require(len(matches)==1,'No unique owned live worker');return matches[0]
    def verify_control_observation(self,record):
        scope=self._admit('PREARM_WORK_FAULT')
        return type(record) is dict and record.get('binding')==scope['binding'] and scope['verify_observation'](copy.deepcopy(record)) is True
    def arm_cooperative(self,token,binding,deadline_tick):
        scope=self._admit('PREARM_WORK_FAULT');row=self._resource(token);integer(deadline_tick,True)
        require(self._owner=='S' and row['owner_role']=='W' and row['binding']==binding==scope['binding'] and row['state']=='LIVE','Wrong prearm target')
        require(scope['now_tick']<deadline_tick<=scope['control_deadline_tick']<=scope['cleanup_deadline_tick'],'Invalid prearm ceilings')
        key=sha(binding);require(key not in self._shared['stop_permits'] and key not in self._signaled,'Stop slot cannot be rearmed')
        expires=min(decimal(d['expires_tick'],True) for d in self._decisions)
        require(scope['now_tick']<min(expires,scope['control_deadline_tick']),'Authority expired')
        self._shared['stop_permits'][key]=dict(token=token,binding=copy.deepcopy(binding),expires=expires,ceiling=scope['control_deadline_tick'],generation=self._shared['authority_generation'],provider=self._native)
    def signal_cooperative(self,token,binding):
        now=self._local_now();row=self._resource(token)
        require(self._owner=='S','Only supervisor consumes cooperative stop')
        require(row['owner_role']=='W' and row['binding']==validate_binding(binding) and row['state']=='LIVE','Wrong exact worker')
        permit=self._shared['stop_permits'].get(sha(binding))
        require(permit is not None and permit['token']==token and permit['binding']==binding and permit['generation']==self._shared['authority_generation'] and permit['provider'] is self._native and getattr(self._native,'evidence_domain',None)=='ARTIFICIAL' and now<min(permit['expires'],permit['ceiling']),'Expired/revoked/unarmed bounded local authority')
        slot=sha(binding);require(slot not in self._signaled,'Stop already consumed');self._signaled.add(slot)
        try:status=self._native.signal(row['native_token'])
        except Exception:status='UNKNOWN'
        require(status in ('ATTEMPTED','UNKNOWN'),'Invalid delivery status')
        receipt=dict(binding=copy.deepcopy(binding),slot_id=slot,attempt_tick=now,delivery_status=status)
        self._shared['attempts'][token]=copy.deepcopy(receipt);return receipt
    def poll_exit(self,token,deadline_tick):
        scope=self._admit('QUIESCENT_BOOTSTRAP');row=self._resource(token);integer(deadline_tick,True)
        require(scope['now_tick']<deadline_tick<=scope['cleanup_deadline_tick'],'Exit observation ceiling expired/extended')
        observed=self._native.exit_status(row['native_token']);exact(observed,{'signaled','exit_code'})
        require(type(observed['signaled']) is bool,'Exact signaled observation required')
        if observed['signaled']:row['state']='EXITED'
        return dict(binding=copy.deepcopy(row['binding']),observed_tick=scope['now_tick'],same_handle=True,signaled=observed['signaled'],exit_code=observed['exit_code'])
    def _io(self,token,wire,deadline_tick):
        scope=self._admit('PREARM_WORK_FAULT');row=self._resource(token);integer(deadline_tick,True)
        require(row['state']=='LIVE' and scope['now_tick']<deadline_tick<=scope['ipc_deadline_tick'] and type(wire) is bytes and len(wire)<=8192,'Invalid/expired/extended frame')
        require(not any(r['token']==token for r in self._pending.values()),'One pending operation per resource')
        operation=self._native.start_io(row['native_token'],wire);require(operation not in self._pending,'Duplicate operation')
        self._pending[operation]=dict(token=token,buffer=wire,deadline_tick=deadline_tick,cancel_requested=False)
        return dict(status='PENDING',operation_id=operation)
    def write_frame(self,token,wire,deadline_tick):return self._io(token,wire,deadline_tick)
    def read_frame(self,token,deadline_tick):
        result=self._io(token,b'',deadline_tick);out=self._native.completion(result['operation_id'])
        if out['status']=='SUCCESS':
            require(type(out['wire']) is bytes and len(out['wire'])<=8192,'Invalid read frame');self._pending.pop(result['operation_id']);return out['wire']
        raise ValueError('Read completion pending/failed; buffer retained')
    def cancel_io(self,operation_id):
        self._admit('QUIESCENT_BOOTSTRAP');require(operation_id in self._pending,'Unknown operation')
        operation=self._pending[operation_id];require(not operation['cancel_requested'],'Cancellation already requested');operation['cancel_requested']=True
        return dict(status=self._native.cancel(operation_id),completion_proven=False)
    def close_completed(self,token):
        self._admit('QUIESCENT_BOOTSTRAP');row=self._resource(token);require(not row['waiting'],'Wait still outstanding')
        for operation,record in list(self._pending.items()):
            if record['token']!=token:continue
            out=self._native.completion(operation);require(out['status'] in ('SUCCESS','CANCELLED','FAILED'),'Completion not observed; retain buffer')
            self._shared['io_outcomes'].append(dict(operation_id=operation,resource_id=token,status=out['status'],buffer_digest=sha(list(record['buffer']))))
            self._pending.pop(operation)
        require(row['state']=='EXITED','Retain process identity until same-handle exit observed')
        require(self._case!='AC19' or self._retention_released,'Retired AC19 handles remain retained pending case disposition')
        if token in self._termination_resources:self._native.close(self._termination_resources.pop(token)['token'])
        self._native.close(row['native_token']);row['state']='CLOSED';row['disposition']='CLOSED'
        return dict(resource_id=token,disposition='CLOSED')
    def record_cooperative_outcome(self,token,receipt):
        scope=self._admit('PREARM_WORK_FAULT');row=self._resource(token)
        exact(receipt,{'binding','slot_id','status','tick','evidence_ref'})
        require(self._owner=='S' and receipt['binding']==row['binding']==scope['binding'] and receipt['slot_id']==sha(row['binding']) in self._signaled,'No preceding consumed cooperative attempt')
        integer(receipt['tick']);require(receipt['status'] in ('FAILED','UNKNOWN') and self._shared['attempts'][token]['attempt_tick']<=receipt['tick']<=scope['now_tick'] and scope['verify_observation'](copy.deepcopy(receipt)) is True,'Application failure/uncertainty not verified')
        self._shared['cooperative_outcomes'][token]=copy.deepcopy(receipt)
    def terminate_exact(self,token,grant):
        scope=self._admit('CONDITIONAL_FALLBACK');row=self._resource(token)
        exact(grant,{'binding','slot_id','profile_revision','scope_digest','expires_tick','cleanup_deadline_tick','signature'})
        require(self._owner=='S' and self._case=='AC21' and row['owner_role']=='W' and row['state']=='LIVE' and row['binding']==grant['binding']==scope['binding'],'Wrong fallback owner/target')
        require(token in self._shared['cooperative_outcomes'] and grant['slot_id']==sha(dict(binding=row['binding'],purpose='FALLBACK')),'Missing cooperative uncertainty/exact fallback slot')
        require(grant['profile_revision']==scope['fallback_profile_digest'] and grant['scope_digest']==scope['scope_digest'] and grant['cleanup_deadline_tick']==scope['cleanup_deadline_tick'] and scope['now_tick']<decimal(grant['expires_tick'],True)<=scope['cleanup_deadline_tick'],'Invalid/expired/extended fallback grant')
        proofs={d['component']:d['evidence_digest'] for d in self._decisions}
        require(proofs['G13_PROFILE_REVISION']==grant['profile_revision'] and proofs['G14_EXACT_TARGET_TERMINATION_GRANT']==sha({k:v for k,v in grant.items() if k!='signature'}),'Fallback grants not bound to exact profile/request')
        require(scope['verify_decision'](copy.deepcopy(grant)) is True and token not in self._fallback,'Unverified/consumed fallback')
        self._fallback.add(token)
        try:
            separate=self._native.termination_handle(row['native_token'],copy.deepcopy(row['binding']))
            exact(separate,{'token','binding','rights'});require(separate['binding']==row['binding'] and separate['rights']==['TERMINATE'] and separate['token']!=row['native_token'],'Separate narrow termination handle required')
            self._termination_resources[token]=separate;status=self._native.terminate(separate['token'])
        except Exception:status='UNKNOWN'
        return dict(binding=copy.deepcopy(row['binding']),delivery_status=status,exit_proven=False)
