"""V2 captured-actor bootstrap, injected ARTIFICIAL ABI only; no live entry."""
import copy
import ctypes as c
from functools import wraps
from native_backend import WindowsBackend,DWORD,HANDLE,SIZE,FILETIME,STARTUPINFOEX,PROCESS_INFORMATION,utf16
from identity_contract import validate_manifest,validate_actor,project_target,decode_wire,Endpoint,ActorFrames,PARENTS,ROLES,PROTOCOL,sha,require,exact,integer,decimal,canonical,mac
from providers import Provider
from win32_bridge import Bridge
from journal_protocol import OBSERVED,KINDS,digest


class SplitBackend(WindowsBackend):
    def __init__(self,api,manifest,capabilities,clock):
        self.manifest=validate_manifest(manifest);exact(capabilities,set(PARENTS))
        handles={};commands={}
        for role,cap in capabilities.items():
            exact(cap,{'run_digest','role','handle'});integer(cap['handle'],True)
            require(cap['run_digest']==sha(manifest['run_context']) and cap['role']==role and sha(cap)==manifest['actor_intents'][role]['bootstrap_capability_digest'],'Capability does not match fixed intent')
            handles[role]=cap['handle'];commands[role]=manifest['actor_intents'][role]['command_line']
        require(len(set(handles.values()))==4,'Bootstrap handles must be private per actor')
        super().__init__(api,handles,commands,clock)
        self._captures={};self._last=None
    def _guard(self):
        require(not self.failed,'Split backend quarantined')
        try:
            run=self.manifest['run_context'];now=integer(self.clock.now_tick())
            require(self.clock.domain==run['clock_domain'] and type(self.clock.frequency_hz) is int and self.clock.frequency_hz==int(run['qpc_frequency_hz']),'Clock scope changed')
            require(self._last is None or now>=self._last,'Clock rollback')
            require(now<self.manifest['budgets']['bootstrap_deadline_tick'],'Bootstrap ceiling expired')
            self._last=now;return now
        except Exception:self.failed=True;raise
    def _read_identity(self,h):
        pid=self.api.GetProcessId(h);created,exited,kernel,user=FILETIME(),FILETIME(),FILETIME(),FILETIME()
        require(self.api.GetProcessTimes(h,c.byref(created),c.byref(exited),c.byref(kernel),c.byref(user))!=0,'Native capture unavailable')
        result=dict(pid=str(pid),creation_time_100ns=str((created.high<<32)|created.low))
        decimal(result['pid'],True);decimal(result['creation_time_100ns'],True)
        return result
    def capture(self,role):
        self._guard();require(type(role) is str and role in PARENTS and role not in self._launched,'Unknown/consumed actor')
        parent=PARENTS[role]
        if parent=='L':parent_identity=self.manifest['external_launcher']['identity']
        else:
            require(parent in self._captures and self._captures[parent]['state']=='RESUMED','Parent not captured/resumed')
            require(not self.exit_status(self._captures[parent]['token'])['signaled'],'Parent already exited')
            parent_identity=self._captures[parent]['identity']
        self._launched.add(role);intent=self.manifest['actor_intents'][role]
        attrs=None;initialized=False
        try:
            flags=DWORD();require(self.api.GetHandleInformation(self._bootstrap[role],c.byref(flags))!=0 and flags.value&1,'Uninheritable private handle')
            size=SIZE();require(self.api.InitializeProcThreadAttributeList(None,1,0,c.byref(size))==0 and self.api.GetLastError()==122 and 0<size.value<=65536,'Attribute size unavailable')
            attrs=c.create_string_buffer(size.value)
            require(self.api.InitializeProcThreadAttributeList(attrs,1,0,c.byref(size))!=0,'Attribute init failed');initialized=True
            inherited=(HANDLE*1)(self._bootstrap[role])
            require(self.api.UpdateProcThreadAttribute(attrs,0,0x20002,inherited,c.sizeof(inherited),None,None)!=0,'Handle allowlist failed')
            startup=STARTUPINFOEX();startup.StartupInfo.cb=c.sizeof(STARTUPINFOEX);startup.lpAttributeList=c.addressof(attrs)
            info=PROCESS_INFORMATION();app=utf16(intent['application']);command=utf16(intent['command_line'])
            raw=('SYSTEMROOT='+intent['environment']['SYSTEMROOT']+'\0\0').encode('utf-16-le');env=(c.c_uint16*(len(raw)//2)).from_buffer_copy(raw)
            require(self.api.CreateProcessW(app,command,None,None,True,0x80404,env,None,c.byref(startup),c.byref(info))!=0,'Suspended actor creation failed')
            creator=self._new('CREATOR_PROCESS',info.hProcess);thread=self._new('PRIMARY_THREAD',info.hThread)
            observed=self._read_identity(info.hProcess)
            require(info.dwProcessId==int(observed['pid']),'Process-info capture mismatch')
            used={self.manifest['external_launcher']['identity']['pid']}|{x['identity']['pid'] for x in self._captures.values()}
            require(observed['pid'] not in used,'Duplicate concurrent process identity')
            identity=dict(run_digest=sha(self.manifest['run_context']),role=role,actor_epoch=intent['actor_epoch'],generation='1',
                  parent_role=parent,parent_actor_digest=sha(parent_identity),image_pin_digest=intent['image_pin_digest'],credential_id=intent['credential_id'],**observed)
            validate_actor(identity);narrow=HANDLE();current=self.api.GetCurrentProcess()
            require(self.api.DuplicateHandle(current,info.hProcess,current,c.byref(narrow),0x101000,False,0)!=0,'Actor rights narrowing failed')
            token=self._new('PROCESS',narrow.value,binding=None,role=role,event=None,pipe=None,termination=None)
            record=dict(identity=identity,token=token,creator=creator,thread=thread,state='SUSPENDED')
            record['capture_digest']=sha({k:v for k,v in record.items() if k!='state'})
            self._captures[role]=record;self._guard()
            return copy.deepcopy(record)
        except Exception as error:
            self.failed=True;self.quarantine.append(dict(role=role,reason=type(error).__name__,disposition='RETAIN_NO_RETRY'));raise
        finally:
            if initialized:
                try:self.api.DeleteProcThreadAttributeList(attrs)
                except Exception:
                    self.failed=True;self.quarantine.append(dict(role=role,reason='ATTRIBUTE_RELEASE_UNCERTAIN',disposition='RETAIN_NO_RETRY'));raise
    def resume(self,role):
        self._guard();require(role in self._captures and self._captures[role]['state']=='SUSPENDED','No suspended actor')
        record=self._captures[role]
        try:
            require(self.api.ResumeThread(self._row(record['thread'])['handle'])!=0xffffffff,'Quiescent resume failed')
            record['state']='RESUME_CONSUMED'
            self.close(record['thread']);self.close(record['creator'])
            record['state']='RESUMED';return copy.deepcopy(record)
        except Exception:
            self.failed=True;self.quarantine.append(dict(role=role,reason='RESUME_OR_CLOSE_UNCERTAIN',disposition='RETAIN_NO_RETRY'));raise
    def verify_peer(self,role,pipe):
        self._guard();record=self._captures[role];row=self._row(record['token'],'PROCESS');channel=self._row(pipe,'PIPE')
        require(channel['server'] and channel['connected'] and record['state']=='RESUMED','No quiescent connected peer')
        require(not self.exit_status(record['token'])['signaled'],'Peer exited')
        observed=self._read_identity(row['handle']);expected=record['identity']
        require(all(observed[k]==expected[k] for k in observed),'Retained identity changed')
        pid=DWORD();require(self.api.GetNamedPipeClientProcessId(channel['handle'],c.byref(pid))!=0 and pid.value==int(expected['pid']),'Kernel pipe peer mismatch')
        return True


def bounded(method):
    @wraps(method)
    def call(self,*args,**kwargs):
        try:self._guard();return method(self,*args,**kwargs)
        except Exception as error:
            self._abort(method.__name__,error)
            if isinstance(error,ValueError):raise
            raise ValueError('Bootstrap boundary failed; retained, no retry') from error
    return call

def target_bounded(method):
    @wraps(method)
    def call(self,*args,**kwargs):
        try:self._guard_target();return method(self,*args,**kwargs)
        except Exception as error:
            self._abort(method.__name__,error)
            if isinstance(error,ValueError):raise
            raise ValueError('Target frame boundary failed; retained') from error
    return call


class Bootstrap:
    evidence_domain='ARTIFICIAL'
    def __init__(self,manifest,authority,backend,external_anchor):
        self.manifest=validate_manifest(manifest);self.authority=authority;self.backend=backend
        require(type(backend) is SplitBackend and getattr(authority,'evidence_domain',None)=='ARTIFICIAL','Explicit artificial split backend/authority required')
        require(backend.manifest==self.manifest and authority.run==manifest['run_context'] and backend.clock is authority.clock,'Pinned run/backend/clock required')
        self.run=copy.deepcopy(manifest['run_context']);self.run_digest=sha(self.run);self.manifest_digest=sha(manifest);self.budgets=copy.deepcopy(manifest['budgets'])
        self._epoch=authority.generation;self.failed=False;self.failures=[];self._allocated=set();self._phases={};self._registrations={};self._channels={}
        self._challenges={};self._responses={};self._endpoints={};self._target=None;self._binding=None;self._adopted=False;self._routes={}
        self._actors={'L':copy.deepcopy(manifest['external_launcher']['identity'])}
        now=self._guard();proof=manifest['external_launcher']['anchor_proof']
        require(proof['run_digest']==self.run_digest and proof['actor_digest']==sha(self._actors['L']) and proof['external_anchor_digest']==external_anchor,'External anchor mismatch')
        require(authority.verify('EXTERNAL_ANCHOR',proof,'OWNER'),'External anchor signature invalid');self._period(proof,now)
        for role in ROLES:
            declared=self._actors['L']['credential_id'] if role=='L' else manifest['actor_intents'][role]['credential_id']
            require(declared==authority.credential_id(role),'Role credential pin mismatch')
    def _guard(self):
        require(not self.failed and not self.backend.failed,'Bootstrap quarantined')
        require(self.authority.authority_current(self._epoch),'Run authority revoked')
        now=self.authority.now();require(now<self.budgets['bootstrap_deadline_tick'],'Bootstrap deadline expired')
        return now
    def _abort(self,stage,error):
        if not self.failed:self.failures.append(dict(stage=stage,error=type(error).__name__,disposition='RETAIN_NO_RETRY'))
        self.failed=True;self.backend.failed=True
    def _period(self,row,now,start='issued_tick'):
        lo=integer(row[start]);hi=integer(row['expires_tick'],True)
        require(lo<=now<hi<=self.budgets['bootstrap_deadline_tick'],'Expired/future/extended bootstrap authority')
    def actor(self,role):
        require(type(role) is str and role in self._actors,'Unknown captured actor');return copy.deepcopy(self._actors[role])
    def channel(self,role):return copy.deepcopy(self._channels[role])
    def transcript(self,role):
        return dict(challenge=copy.deepcopy(self._challenges[role]),response=copy.deepcopy(self._responses[role]))
    @bounded
    def capture(self,role,grant):
        require(type(role) is str and role in PARENTS and role not in self._allocated,'Unknown/consumed role')
        parent=PARENTS[role];require(parent=='L' or self._phases.get(parent)=='ACCEPTED','Parent bootstrap not authenticated')
        exact(grant,set('run_digest manifest_digest intent_digest issuer credential_id allowance not_before_tick expires_tick signature'.split()))
        require(grant['run_digest']==self.run_digest and grant['manifest_digest']==self.manifest_digest and grant['intent_digest']==sha(self.manifest['actor_intents'][role]),'Launch grant scope mismatch')
        require(type(grant['allowance']) is int and grant['allowance']==1 and self.authority.verify('RUN_LAUNCH',grant,'OWNER'),'Invalid launch allowance/signature')
        self._period(grant,self.authority.now(),'not_before_tick');self._allocated.add(role)
        record=self.backend.capture(role);identity=record['identity'];self._actors[role]=identity
        require(identity['parent_actor_digest']==sha(self._actors[parent]),'Captured parent differs from admitted parent')
        body=dict(actor_digest=sha(identity),parent_actor_digest=identity['parent_actor_digest'],intent_digest=sha(self.manifest['actor_intents'][role]),
           capture_evidence_digest=record['capture_digest'],bootstrap_capability_digest=self.manifest['actor_intents'][role]['bootstrap_capability_digest'],
           issuer=parent,credential_id=self.authority.credential_id(parent),issued_tick=self.authority.now(),expires_tick=grant['expires_tick'])
        self._registrations[role]=self.authority.sign('REGISTRATION',body,parent);self._phases[role]='CAPTURED'
        return copy.deepcopy(identity)
    @bounded
    def registration(self,role):
        require(self._phases.get(role)=='CAPTURED','No fresh captured registration')
        return copy.deepcopy(self._registrations[role])
    @bounded
    def resume(self,role,proof):
        require(self._phases.get(role)=='CAPTURED','Registration already consumed/unavailable')
        exact(proof,set('actor_digest parent_actor_digest intent_digest capture_evidence_digest bootstrap_capability_digest issuer credential_id issued_tick expires_tick signature'.split()))
        require(proof==self._registrations[role] and self.authority.verify('REGISTRATION',proof,PARENTS[role]),'Registration differs from local captured proof')
        self._period(proof,self.authority.now());record=self.backend._captures[role]
        observed=self.backend._read_identity(self.backend._row(record['token'])['handle'])
        require(all(observed[k]==self._actors[role][k] for k in observed),'Identity changed before quiescent resume')
        self._phases[role]='RESUME_CONSUMED';self.backend.resume(role);self._phases[role]='QUIESCENT'
        return dict(status='QUIESCENT_BOOTSTRAP_ONLY',work_dispatched=False)
    @bounded
    def connect(self,role,sids):
        require(self._phases.get(role)=='QUIESCENT','No fresh quiescent endpoint')
        event=self.backend.create_event(sids);pipe=self.backend.create_pipe('\\\\.\\pipe\\WP06_ART_'+self.run_digest+'_'+role,sids)
        self._channels[role]=dict(event=event,pipe=pipe,operation=None)
        row=self.backend._row(self.backend._captures[role]['token']);row['event']=event;row['pipe']=pipe
        self.backend._row(pipe)['channel_claimed']=True
        self._channels[role]['operation']=self.backend.connect_pipe(pipe);self._phases[role]='CONNECTING'
        return copy.deepcopy(self._channels[role])
    @bounded
    def poll_connect(self,role):
        require(self._phases.get(role)=='CONNECTING','No connection operation')
        result=self.backend.completion(self._channels[role]['operation'])
        if result['status']=='PENDING':return result
        require(result['status']=='SUCCESS','Connection uncertain/failed')
        self.backend.verify_peer(role,self._channels[role]['pipe']);self._phases[role]='CONNECTED'
        return dict(status='CONNECTED')
    @bounded
    def challenge(self,role):
        require(self._phases.get(role)=='CONNECTED' and role not in self._challenges,'Challenge unavailable/consumed')
        self.backend.verify_peer(role,self._channels[role]['pipe']);actor=self._actors[role];intent=self.manifest['actor_intents'][role]
        row=dict(protocol=PROTOCOL,run_digest=self.run_digest,manifest_digest=self.manifest_digest,actor_digest=sha(actor),parent_actor_digest=actor['parent_actor_digest'],
           intent_digest=sha(intent),capability_digest=intent['bootstrap_capability_digest'],challenge_id=sha(dict(actor=sha(actor),pipe=self._channels[role]['pipe'],run=self.run_digest)),
           issued_tick=self.authority.now(),expires_tick=self.budgets['bootstrap_deadline_tick'])
        self._challenges[role]=row;self._phases[role]='CHALLENGE_ISSUED';return canonical(row)
    def _verify_challenge(self,role,row):
        try:
            self._guard();require(self._phases.get(role)=='CHALLENGE_DELIVERED' and row==self._challenges[role],'Challenge scope/phase mismatch')
            self._period(row,self.authority.now());self.backend.verify_peer(role,self._channels[role]['pipe']);return True
        except Exception as error:self._abort('verify_challenge',error);return False
    @bounded
    def endpoint(self,role):
        require(role in self._challenges and role not in self._endpoints,'Endpoint already provisioned/unavailable')
        endpoint=Endpoint(self._actors[role],self.authority._credentials[role]['key'],self.authority.clock,lambda row:self._verify_challenge(role,row))
        self._endpoints[role]=endpoint;return endpoint
    @bounded
    def write_challenge(self,role):
        require(self._phases.get(role)=='CHALLENGE_ISSUED','No fresh challenge to send')
        self._channels[role]['operation']=self.backend._start(self._channels[role]['pipe'],canonical(self._challenges[role]),'WRITE',origin=self.backend._captures[role]['token'])
        self._phases[role]='WRITING_CHALLENGE'
        return dict(status='PENDING')
    @bounded
    def poll_challenge(self,role):
        require(self._phases.get(role)=='WRITING_CHALLENGE','No challenge write')
        result=self.backend.completion(self._channels[role]['operation'])
        if result['status']=='PENDING':return result
        require(result['status']=='SUCCESS','Challenge delivery failed/uncertain')
        self._phases[role]='CHALLENGE_DELIVERED';return dict(status='CHALLENGE_DELIVERED')
    @bounded
    def read_response(self,role):
        require(self._phases.get(role)=='CHALLENGE_DELIVERED','No one-use response allowance')
        self._channels[role]['operation']=self.backend._start(self._channels[role]['pipe'],b'','READ',origin=self.backend._captures[role]['token'])
        self._phases[role]='READING_RESPONSE';return dict(status='PENDING')
    @bounded
    def poll_response(self,role):
        require(self._phases.get(role)=='READING_RESPONSE','No native response read')
        result=self.backend.completion(self._channels[role]['operation'])
        if result['status']=='PENDING':return result
        require(result['status']=='SUCCESS','Response transport failed/uncertain');self.backend.verify_peer(role,self._channels[role]['pipe'])
        row=decode_wire(result['wire']);exact(row,set('protocol run_digest actor_digest challenge_digest credential_id sequence previous_digest tick frequency payload_digest tag'.split()))
        require(row['protocol']==PROTOCOL and row['run_digest']==self.run_digest and row['actor_digest']==sha(self._actors[role]) and row['challenge_digest']==sha(self._challenges[role]),'Response scope mismatch')
        require(row['sequence']=='1' and row['previous_digest']=='0'*64 and row['frequency']==self.run['qpc_frequency_hz'],'Bootstrap chain/frequency mismatch')
        tick=integer(row['tick']);require(self._challenges[role]['issued_tick']<=tick<=self.authority.now(),'Future/stale bootstrap response')
        require(row['payload_digest']==sha({'ready':'BOOTSTRAP_ONLY'}) and self.authority.verify_tag('BOOT_RESPONSE',row,role),'Response role authentication failed')
        self._responses[role]=row;self._phases[role]='ACCEPTED';return dict(status='ACTOR_BOOTSTRAP_ACCEPTED',work_dispatched=False)
    def drain(self,role):
        require(self.failed or self.backend.failed,'Drain requires quarantined run')
        now=self.authority.now();require(now<self.budgets['cleanup_deadline_tick'],'Drain cleanup ceiling expired')
        require(role in self._channels and self._channels[role]['operation'] is not None,'No owned bootstrap operation')
        result=self.backend.completion(self._channels[role]['operation'])
        return dict(status=result['status'],delivery_accepted=False,admission_accepted=False,run_revived=False,cleanup_certified=False)
    @bounded
    def roster(self):
        require(all(self._phases.get(r)=='ACCEPTED' for r in PARENTS),'Incomplete authenticated roster')
        for role in PARENTS:self.backend.verify_peer(role,self._channels[role]['pipe'])
        return dict(run_digest=self.run_digest,manifest_digest=self.manifest_digest,budget_digest=sha(self.budgets),actors=copy.deepcopy(self._actors),
           registrations={r:sha(self._registrations[r]) for r in PARENTS},transcripts={r:sha(self.transcript(r)) for r in PARENTS})
    @bounded
    def admit_target(self,target,admission):
        require(self._target is None,'Worker target already sealed')
        roster=self.roster();binding=project_target(self.run,self._actors['W'],target)
        exact(admission,set('run_digest roster_digest target_digest manifest_digest budget_digest issued_tick expires_tick issuer credential_id signature'.split()))
        expected=dict(run_digest=self.run_digest,roster_digest=sha(roster),target_digest=sha(target),manifest_digest=self.manifest_digest,budget_digest=sha(self.budgets))
        require(all(admission[k]==v for k,v in expected.items()) and self.authority.verify('TARGET_ADMISSION',admission,'OWNER'),'Target admission scope/signature mismatch')
        self._period(admission,self.authority.now());self._target=copy.deepcopy(target);self._binding=binding;self._admission=copy.deepcopy(admission)
        self._roster=roster;self.scope_digest=sha({k:expected[k] for k in ('run_digest','roster_digest','target_digest','budget_digest')})
        self.backend._row(self.backend._captures['W']['token'])['binding']=copy.deepcopy(binding)
        return dict(status='ARTIFICIAL_IDENTITY_BOOTSTRAP_ACCEPTED',work_dispatched=False,cases_executed=0,operational_acceptance=False,scientific_acceptance=False)
    @bounded
    def binding(self):
        require(self._binding is not None,'No admitted worker target');return copy.deepcopy(self._binding)
    @bounded
    def legacy_provider(self):
        require(self._target is not None,'No admitted target provider')
        if not hasattr(self,'_provider'):self._provider=TargetProvider(self)
        return self._provider
    @bounded
    def adopt_worker(self,decisions,observations):
        require(self._target is not None and not self._adopted,'No fresh sealed worker adoption')
        require(self.roster()==self._roster,'Admitted roster changed')
        provider=self.legacy_provider();self._capability=_Adoption(self,provider,decisions,observations)
        return BoundWorkerBridge(self._capability)
    def _guard_target(self):
        require(not self.failed and not self.backend.failed and self._target is not None,'No active target')
        require(self.authority.authority_current(self._epoch),'Target role authority revoked')
        now=self.authority.now();require(now<self.budgets['ipc_deadline_tick'],'Approved IPC ceiling expired')
        return now
    def _target_peer(self,sender,recipient):
        require(type(sender) is str and type(recipient) is str and sender in ROLES and recipient in ROLES and sender!=recipient,'Distinct captured actor roles required')
        child=sender if PARENTS.get(sender)==recipient else recipient if PARENTS.get(recipient)==sender else None
        require(child is not None,'Unregistered actor transport topology')
        for role in (sender,recipient):
            if role=='L':continue
            token=self.backend._captures[role]['token'];row=self.backend._row(token,'PROCESS')
            require(not self.backend.exit_status(token)['signaled'],'Target actor exited')
            observed=self.backend._read_identity(row['handle']);require(all(observed[k]==self._actors[role][k] for k in observed),'Target actor identity changed')
        pipe=self._channels[child]['pipe'];channel=self.backend._row(pipe,'PIPE');pid=DWORD()
        require(channel['connected'] and self.backend.api.GetNamedPipeClientProcessId(channel['handle'],c.byref(pid))!=0 and pid.value==int(self._actors[child]['pid']),'Target kernel peer mismatch')
        return child
    @bounded
    def target_endpoint(self,sender,recipient):
        require(self._target is not None and (sender,recipient) not in self._routes,'No fresh target direction')
        child=self._target_peer(sender,recipient)
        endpoint=ActorFrames(self._actors[sender],self._actors[recipient],sha(self._target),self.run,self.authority._credentials[sender]['key'],self._guard_target)
        self._routes[sender,recipient]=dict(child=child,endpoint=endpoint,sequence=0,previous_digest='0'*64,operation=None)
        return endpoint
    @target_bounded
    def read_target(self,sender,recipient):
        route=self._routes[sender,recipient];child=self._target_peer(sender,recipient)
        require(route['operation'] is None,'Target direction already pending')
        route['operation']=self.backend._start(self._channels[child]['pipe'],b'','READ',origin=self.backend._captures[child]['token'])
        return dict(status='PENDING')
    @target_bounded
    def poll_target(self,sender,recipient):
        route=self._routes[sender,recipient];require(route['operation'] is not None,'No target native read')
        result=self.backend.completion(route['operation'])
        if result['status']=='PENDING':return result
        require(result['status']=='SUCCESS','Target transport failed/uncertain');self._target_peer(sender,recipient)
        row=decode_wire(result['wire']);exact(row,set('protocol run_digest target_digest sender_actor_digest recipient_actor_digest credential_id sequence previous_digest tick frequency kind payload_digest tag'.split()))
        require(row['protocol']=='WP06_TARGET_V2_ARTIFICIAL' and row['run_digest']==self.run_digest and row['target_digest']==sha(self._target),'Wrong target frame scope')
        require(row['sender_actor_digest']==sha(self._actors[sender]) and row['recipient_actor_digest']==sha(self._actors[recipient]),'Wrong actor endpoints')
        require(decimal(row['sequence'],True)==route['sequence']+1 and row['previous_digest']==route['previous_digest'] and row['frequency']==self.run['qpc_frequency_hz'],'Target sequence/frequency mismatch')
        tick=integer(row['tick']);digest(row['payload_digest'])
        require(self._admission['issued_tick']<=tick<=self.authority.now(),'Future/stale target frame')
        require(type(row['kind']) is str and row['kind'] in KINDS[sender] and self.authority.verify_tag('TARGET_FRAME',row,sender),'Wrong target actor authentication')
        route['sequence']+=1;route['previous_digest']=sha(row);route['operation']=None
        return dict(status='VERIFIED_TARGET_FRAME',message=row,application_proven=False,operational_acceptance=False)


class TargetProvider(Provider):
    """Legacy coordinator provider, retaining the V2 local revocation identity."""
    def __init__(self,root):
        self._root=root
        keys={r:row['key'] for r,row in root.authority._credentials.items() if r!='L'}
        super().__init__(root._binding,root.scope_digest,keys,root.authority.clock,{r:'O' for r in OBSERVED},max_age=root.budgets['cleanup_deadline_tick'])
    def authority_current(self,generation):
        return not self._root.failed and not self._root.backend.failed and self._root.authority.authority_current(self._root._epoch) and super().authority_current(generation)
    def _tag(self,kind,body,role):
        require(self.authority_current(self.generation),'Target authority unavailable')
        return mac(self._keys[role],'TARGET_FRAME',dict(compatibility_scope_digest=self.scope_digest,kind=kind,issuer=role,body=body))
    def revoke(self,role):
        require(role in self._keys,'Unknown target role');self._root.authority.revoke(role);super().revoke(role)


class _Adoption:
    def __init__(self,root,provider,decisions,observations):
        self.root=root;self.provider=provider;self.decisions=copy.deepcopy(decisions);self.observations=copy.deepcopy(observations)


class BoundWorkerBridge(Bridge):
    """Public construction requires the coordinator's actual one-use capability."""
    def __init__(self,capability):
        require(type(capability) is _Adoption and type(capability.root) is Bootstrap,'Sealed adoption capability required')
        root=capability.root
        require(getattr(root,'_capability',None) is capability and not root._adopted,'Unissued/consumed adoption capability')
        root._guard();root._adopted=True;self._v2_root=root
        provider=capability.provider;self._v2_provider=provider;self._v2_generation=provider.generation
        scope=dict(evidence_domain='ARTIFICIAL',scope_digest=root.scope_digest,build_digest=root.run['build_digest'],observer_epoch=root.run['observer_epoch'],
           now_tick=root.authority.now(),binding=copy.deepcopy(root._binding),verify_decision=provider.verify_decision,verify_observation=provider.verify_observation,
           actor_specs={},fallback_profile_digest='0'*64,**root.budgets)
        super().__init__(root.backend,scope,capability.decisions,capability.observations,root.authority.clock,owner_role='S',case_id='AC17')
        self._admit('QUIESCENT_BOOTSTRAP')
        captured=root.backend._captures['W'];token=captured['token'];binding=root._binding
        self._owned[token]=dict(resource_id=token,kind='PROCESS',owner_role='W',generation=binding['worker_epoch'],binding_digest=sha(binding),operation_id=None,
           rights=['QUERY','SYNCHRONIZE'],state='LIVE',deadline_tick=root.budgets['bootstrap_deadline_tick'],disposition='OWNED',binding=copy.deepcopy(binding),native_token=token,waiting=False)
    def bootstrap(self,role,spec):raise ValueError('V2 view cannot launch/rebootstrap actors')
    def for_owner(self,role):raise ValueError('V2 view is the sealed worker-only S boundary')
    def signal_cooperative(self,token,binding):
        require(self._v2_provider.authority_current(self._v2_generation),'Adopted authority revoked/quarantined')
        return super().signal_cooperative(token,binding)


def main(argv=None):return 2

if __name__=='__main__':raise SystemExit(main())
