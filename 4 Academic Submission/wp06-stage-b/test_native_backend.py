"""Only the external ABI is fake; production adapter/provider code runs unchanged."""
import copy
import ctypes as c
import hashlib
import importlib
import unittest

from test_stage_b import binding, scope, decisions, observations, POLICY, A, B


class ProviderTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(importlib.util.find_spec('providers'), 'Missing scoped native provider implementation')
        self.m = importlib.import_module('providers')
        self.clock = type('Clock', (), {'now_tick': lambda _:10, 'domain':'ART_QPC', 'frequency_hz':1000000000})()
        self.provider = self.m.Provider(binding(), A, {'OWNER':b'o'*32, 'O':b'p'*32}, self.clock,
                                         {'G04_OBSERVED':'O'}, max_age=8)

    def decision(self):
        row=decisions()[0]; row['issuer']='OWNER'
        return self.provider.sign_decision(row)

    def test_decision_authentication_and_scope(self):
        row=self.decision(); self.assertTrue(self.provider.verify_decision(row))
        for change in ({'approved':False}, {'build_digest':A}, {'scope_digest':B}, {'observer_epoch':'OTHER'}, {'expires_tick':'10'}):
            bad=copy.deepcopy(row);bad.update(change)
            self.assertFalse(self.provider.verify_decision(bad))

    def test_role_separation_and_revocation(self):
        row=self.decision();row['issuer']='O'
        self.assertFalse(self.provider.verify_decision(row))
        row=self.decision();self.provider.revoke('OWNER')
        self.assertFalse(self.provider.verify_decision(row))

    def test_observation_requires_authenticated_source_and_freshness(self):
        row=observations()[0]; row['component']='G04_OBSERVED'
        signed=self.provider.sign_observation(row,'O')
        self.assertTrue(self.provider.verify_observation(signed))
        for change in ({'tick':'11'}, {'tick':'1'}, {'envelope_digest':B}, {'binding':dict(binding(),pid='102')}):
            bad=copy.deepcopy(signed);bad.update(change)
            self.assertFalse(self.provider.verify_observation(bad))
        self.assertRaises(ValueError,self.provider.sign_observation,row,'OWNER')

    def test_provider_rejects_malformed_inputs_and_no_live_adoption(self):
        for value in (None, [], {'issuer':[]}, {'component':{}}):
            self.assertFalse(self.provider.verify_decision(value))
            self.assertFalse(self.provider.verify_observation(value))
        self.assertRaises(ValueError,self.m.Provider,binding(),A,{'OWNER':b'x'},self.clock,{})
        self.assertRaises(ValueError,self.m.Provider,binding(),A,{'OWNER':b'x'*32},self.clock,{},evidence_domain='LIVE')

    def test_qpc_abi_success_rollback_and_failure(self):
        ticks=iter([10,11,9,20])
        def freq(out):out._obj.value=1000000000;return 1
        def tick(out):out._obj.value=next(ticks);return 1
        clock=self.m.QpcClock(tick,freq,'ART_QPC',1000000000)
        self.assertEqual(clock.now_tick(),10);self.assertEqual(clock.now_tick(),11)
        self.assertRaises(ValueError,clock.now_tick)
        self.assertRaises(ValueError,clock.now_tick)
        self.assertRaises(ValueError,self.m.QpcClock,tick,lambda out:0,'ART_QPC',1000000000)


class FakeAPI:
    evidence_domain='ARTIFICIAL'
    def __init__(self):
        self.calls=[];self.error=0;self.fail=None;self.pid=101;self.created=1001
        self.exit=False;self.closed=[];self.next=300;self.io_status=996;self.io_wire=b'OK'
        self.info={};self.pending={};self.reads=0;self.events=set();self.event_signaled=False
    def handle(self):self.next+=1;return self.next
    def GetLastError(self):return self.error
    def GetCurrentProcess(self):return -1
    def GetHandleInformation(self,h,out):out._obj.value=1;return 1
    def InitializeProcThreadAttributeList(self,p,count,flags,size):
        size._obj.value=64
        if p is None:self.error=122;return 0
        return 1
    def UpdateProcThreadAttribute(self,*args):self.calls.append(('ATTR',args));return 1
    def DeleteProcThreadAttributeList(self,p):self.calls.append(('DELETE_ATTR',))
    def CreateProcessW(self,app,cmd,ps,ts,inherit,flags,env,cwd,start,info):
        self.calls.append(('CREATE',inherit,flags,bytes(env),start._obj.StartupInfo.cb))
        if self.fail=='create':self.error=5;return 0
        info._obj.hProcess=201;info._obj.hThread=202;info._obj.dwProcessId=self.pid
        self.info[201]=(self.pid,self.created)
        return 1
    def GetProcessId(self,h):return self.info[h][0]
    def GetProcessTimes(self,h,created,exited,kernel,user):
        if self.fail=='identity':return 0
        created._obj.low=self.info[h][1]&0xffffffff;created._obj.high=self.info[h][1]>>32
        return 1
    def DuplicateHandle(self,source,h,target,out,rights,inherit,options):
        self.calls.append(('DUP',h,rights,inherit,options))
        if self.fail=='duplicate':return 0
        out._obj.value=self.handle();self.info[out._obj.value]=self.info[h];return 1
    def ResumeThread(self,h):self.calls.append(('RESUME',h));return 0xffffffff if self.fail=='resume' else 1
    def CloseHandle(self,h):self.closed.append(h);return 0 if self.fail=='close' else 1
    def WaitForSingleObject(self,h,timeout):
        self.calls.append(('WAIT',h,timeout))
        signaled=self.event_signaled if h in self.events else self.exit
        return 0 if signaled else 258
    def GetExitCodeProcess(self,h,out):out._obj.value=259 if not self.exit else 42;return 1
    def SetEvent(self,h):self.calls.append(('SET',h));return 0 if self.fail=='signal' else 1
    def TerminateProcess(self,h,code):self.calls.append(('TERMINATE',h,code));return 1
    def ConvertStringSecurityDescriptorToSecurityDescriptorW(self,text,revision,out,size):
        self.calls.append(('SDDL',bytes(text)));out._obj.value=900;return 1
    def LocalFree(self,p):self.calls.append(('FREE_SD',p));return None
    def CreateEventW(self,sa,manual,initial,name):
        self.calls.append(('EVENT',manual,initial,name));h=self.handle();self.events.add(h);return h
    def CreateNamedPipeW(self,name,access,mode,count,outsize,insize,timeout,sa):
        self.calls.append(('PIPE',access,mode,count,sa._obj.bInheritHandle));return self.handle()
    def CreateFileW(self,*args):self.calls.append(('OPEN_PIPE',));return self.handle()
    def GetNamedPipeClientProcessId(self,h,out):out._obj.value=self.pid;return 1
    def GetNamedPipeServerProcessId(self,h,out):out._obj.value=self.pid;return 1
    def ConnectNamedPipe(self,h,overlap):self.error=997;return 0
    def ReadFile(self,h,buf,size,done,overlap):
        self.reads+=1;self.pending[h]=(buf,size,False);self.error=997;return 0
    def WriteFile(self,h,buf,size,done,overlap):
        self.pending[h]=(buf,size,True);self.error=997;return 0
    def GetOverlappedResult(self,h,overlap,done,wait):
        self.calls.append(('RESULT',wait))
        if self.io_status:self.error=self.io_status;return 0
        if h in self.pending:
            buf,size,write=self.pending[h]
            if not write:c.memmove(buf,self.io_wire,len(self.io_wire))
            done._obj.value=size if write else len(self.io_wire)
        return 1
    def CancelIoEx(self,h,overlap):self.calls.append(('CANCEL',h));return 1


class BackendProcessTests(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(importlib.util.find_spec('native_backend'),'Missing concrete native backend')
        self.m=importlib.import_module('native_backend');self.api=FakeAPI()
        self.clock=type('Clock',(),{'now_tick':lambda _:10,'frequency_hz':1000000000,'domain':'ART_QPC'})()
        self.backend=self.make()
    def make(self,**extra):
        return self.m.WindowsBackend(self.api,{'W':41},{'W':'"C:/ART_ONLY/python.exe" fixed-worker'},self.clock,**extra)
    def spec(self):return scope()['actor_specs']['W']
    def test_fixed_abi_layout_and_narrow_process_identity(self):
        self.assertEqual(c.sizeof(self.m.FILETIME),8)
        result=self.backend.create_process('W',self.spec())
        self.assertEqual(result['binding'],binding());self.assertEqual(result['rights'],['QUERY','SYNCHRONIZE'])
        self.assertEqual(self.api.closed,[202,201])
        self.assertEqual([x[2] for x in self.api.calls if x[0]=='DUP'],[0x101000])
        created=next(x for x in self.api.calls if x[0]=='CREATE')
        self.assertEqual(created[1:3],(True,0x80404));self.assertTrue(created[3].endswith(b'\0\0\0\0'))
        self.assertEqual(created[4],c.sizeof(self.m.STARTUPINFOEX))
        self.assertEqual(self.backend.exit_status(result['token']),{'signaled':False,'exit_code':None})
        self.api.exit=True;self.assertEqual(self.backend.exit_status(result['token'])['exit_code'],42)
        self.backend.close(result['token']);self.assertEqual(len(set(self.api.closed)),3)
    def test_identity_mismatch_quarantines_suspended_resources(self):
        self.api.pid=102
        self.assertRaises(ValueError,self.backend.create_process,'W',self.spec())
        self.assertFalse(any(x[0]=='RESUME' for x in self.api.calls))
        self.assertTrue(self.backend.quarantine)
        self.assertRaises(ValueError,self.backend.create_process,'W',self.spec())
    def test_bootstrap_failure_no_retry_and_no_resource_loss(self):
        for failure in ('create','identity','duplicate','resume','close'):
            api=FakeAPI();api.fail=failure;self.api=api;backend=self.make()
            self.assertRaises(ValueError,backend.create_process,'W',self.spec())
            self.assertTrue(backend.failed)
            self.assertRaises(ValueError,backend.create_process,'W',self.spec())
            if failure!='create':self.assertTrue(backend.quarantine)
    def test_no_live_default_or_unowned_target(self):
        self.assertRaises(ValueError,self.m.WindowsBackend,None,{}, {},self.clock)
        self.assertRaises(ValueError,self.backend.signal,'unowned')
        self.assertRaises(ValueError,self.backend.create_process,'X',self.spec())
        self.assertFalse(self.api.calls)
    def test_separate_pregranted_termination_capability(self):
        from journal_protocol import sha
        backend=self.make(termination_bindings={sha(binding())})
        result=backend.create_process('W',self.spec())
        cap=backend.termination_handle(result['token'],binding())
        self.assertNotEqual(cap['token'],result['token']);self.assertEqual(cap['rights'],['TERMINATE'])
        self.assertEqual(backend.terminate(cap['token']),'REQUESTED')
        self.assertEqual([x[2] for x in self.api.calls if x[0]=='DUP'],[0x101000,1])
        self.assertRaises(ValueError,backend.terminate,cap['token'])
        self.assertRaises(ValueError,self.backend.termination_handle,'unowned',binding())


class BackendIOTests(unittest.TestCase):
    setUp=BackendProcessTests.setUp
    make=BackendProcessTests.make
    spec=BackendProcessTests.spec
    def setup_channel(self):
        self.assertTrue(hasattr(self.backend,'create_pipe'),'Missing concrete pipe/event/I/O backend')
        process=self.backend.create_process('W',self.spec())['token']
        event=self.backend.create_event(['S-1-5-21-1-2-3-1001'])
        pipe=self.backend.create_pipe(r'\\.\pipe\WP06_ART_TEST',['S-1-5-21-1-2-3-1001'])
        op=self.backend.connect_pipe(pipe)
        self.api.io_status=0;self.assertEqual(self.backend.completion(op)['status'],'SUCCESS')
        self.backend.attach_control(process,event,pipe)
        self.api.io_status=996
        return process,event,pipe
    def test_acl_flags_and_peer_identity_are_actual_api_checks(self):
        process,event,pipe=self.setup_channel()
        row=next(x for x in self.api.calls if x[0]=='PIPE')
        self.assertEqual(row[1:],(0x40080003,14,1,False))
        self.assertEqual(self.backend.signal(process),'ATTEMPTED')
        self.assertFalse(self.backend.event_observed(event))
        self.api.event_signaled=True;self.assertTrue(self.backend.event_observed(event))
        self.assertRaises(ValueError,self.backend.create_event,['WD'])
        self.assertRaises(ValueError,self.backend.create_pipe,r'\\remote\pipe\bad',['S-1-5-21-1-2-3-1001'])
    def test_wrong_peer_cannot_attach(self):
        process,event,pipe=self.setup_channel();self.api.pid=102
        self.assertRaises(ValueError,self.backend.attach_control,process,event,pipe)
    def test_pending_cancel_retains_buffer_until_completed(self):
        process,event,pipe=self.setup_channel()
        op=self.backend.start_io(process,b'FRAME')
        self.assertEqual(self.backend.completion(op)['status'],'PENDING')
        self.assertEqual(self.backend.cancel(op),'REQUESTED')
        self.assertRaises(ValueError,self.backend.cancel,op)
        self.assertRaises(ValueError,self.backend.close,pipe)
        self.assertRaises(ValueError,self.backend.close,process)
        self.assertEqual(self.backend.completion(op)['status'],'PENDING')
        self.api.io_status=995;self.assertEqual(self.backend.completion(op)['status'],'CANCELLED')
        self.backend.close(pipe)
    def test_read_and_write_complete_without_false_cancellation(self):
        process,event,pipe=self.setup_channel()
        op=self.backend.start_io(process,b'')
        self.assertRaises(ValueError,self.backend.start_io,process,b'other')
        self.api.io_status=0
        self.assertEqual(self.backend.completion(op),{'status':'SUCCESS','wire':b'OK'})
        op=self.backend.start_io(process,b'abc')
        self.assertEqual(self.backend.completion(op),{'status':'SUCCESS','wire':b''})
        self.assertTrue(all(x[1] is False for x in self.api.calls if x[0]=='RESULT'))
    def test_frame_limits_unknown_completion_and_close_failure(self):
        process,event,pipe=self.setup_channel()
        self.assertRaises(ValueError,self.backend.start_io,process,b'x'*8193)
        op=self.backend.start_io(process,b'')
        self.api.io_status=5
        self.assertEqual(self.backend.completion(op)['status'],'FAILED')
        self.api.fail='close'
        self.assertRaises(ValueError,self.backend.close,pipe)
        self.assertTrue(self.backend.quarantine)


class RuntimeTests(unittest.TestCase):
    make=BackendProcessTests.make
    spec=BackendProcessTests.spec
    setup_channel=BackendIOTests.setup_channel
    def setUp(self):
        BackendProcessTests.setUp(self)
        self.assertIsNotNone(importlib.util.find_spec('native_runtime'),'Missing bounded role runtime')
        self.rt=importlib.import_module('native_runtime')
    def runtime(self):
        from providers import Provider
        from win32_bridge import Bridge
        from journal_protocol import Journal
        from test_stage_b import store_path
        process,event,pipe=self.setup_channel()
        self.clock.tick=10;self.clock.now_tick=lambda:self.clock.tick
        sc=scope();provider=Provider(binding(),A,{'OWNER':b'a'*32,'O':b'b'*32,'W':b'c'*32,'C':b'd'*32,'S':b'e'*32},self.clock,
          {x['component']:'O' for x in observations()},max_age=50)
        ds=[]
        for d in decisions(POLICY+['G11_EXACT_FAULT_AUTHORITY']):
            d['issuer']='OWNER';ds.append(provider.sign_decision(d))
        obs=[provider.sign_observation(x,'O') for x in observations()]
        sc['verify_decision']=provider.verify_decision;sc['verify_observation']=provider.verify_observation
        # Bridge captures the same retained object through its public bootstrap API.
        fresh=FakeAPI();backend=self.m.WindowsBackend(fresh,{'W':41},{'W':'"C:/ART_ONLY/python.exe" fixed-worker'},self.clock)
        br=Bridge(backend,sc,ds,obs,self.clock,owner_role='S')
        token=br.bootstrap('W',sc['actor_specs']['W'])['token']
        ev=backend.create_event(['S-1-5-21-1-2-3-1001']);ch=backend.create_pipe(r'\\.\pipe\WP06_ART_RUNTIME',['S-1-5-21-1-2-3-1001'])
        op=backend.connect_pipe(ch);fresh.io_status=0;backend.completion(op);backend.attach_control(token,ev,ch)
        journal=Journal(str(store_path(self._testMethodName)),dict(sequence=0,chain_digest='0'*64,evidence_domain='ARTIFICIAL'))
        self.addCleanup(journal.close)
        runtime=self.rt.RoleRuntime(br,backend,provider,self.clock,journal,token,ev,self_ceiling_tick=70)
        return runtime,fresh,provider
    def test_runtime_requires_arm_before_work_and_single_attempt(self):
        runtime,api,provider=self.runtime()
        self.assertRaises(ValueError,runtime.worker_once,False)
        runtime.arm(40)
        self.assertEqual(runtime.worker_once(True)['terminal'],None)
        self.clock.tick=40
        first=runtime.supervisor_once();self.assertEqual(first['kind'],'CONTROL_ATTEMPT')
        self.assertFalse(first['application_proven'])
        self.assertEqual(runtime.supervisor_once()['kind'],'ALREADY_CONSUMED')
        self.assertEqual(sum(x[0]=='SET' for x in api.calls),1)
        self.assertEqual(runtime.flush_attempt()['disposition'],'RECORDED')
    def test_worker_applied_requires_event_and_independent_exit_observation(self):
        runtime,api,provider=self.runtime();runtime.arm(40)
        self.assertIsNone(runtime.worker_once(True)['terminal'])
        api.event_signaled=True
        applied=runtime.worker_once(True)
        self.assertEqual(applied['terminal'],'STOP_APPLIED')
        self.assertEqual(runtime.observe_worker_exit()['signaled'],False)
        api.exit=True
        self.assertEqual(runtime.observe_worker_exit()['signaled'],True)
        self.assertEqual(runtime.finish()['disposition'],'HOLD')
        self.assertFalse(runtime.finish()['operational_acceptance'])
    def test_bounded_entry_does_not_dispatch_blocking_work_or_retry(self):
        runtime,api,provider=self.runtime();runtime.arm(40)
        result=self.rt.role_entry('W',runtime,3)
        self.assertEqual(result['iterations'],3);self.assertEqual(result['disposition'],'HOLD')
        self.assertEqual(result['work_callbacks'],0)
        self.assertRaises(ValueError,self.rt.role_entry,'W',runtime,0)
        self.assertRaises(ValueError,self.rt.role_entry,'X',runtime,1)
        self.assertRaises(ValueError,runtime.arm,45)
    def test_unverified_completion_never_promoted_and_default_entry_denies(self):
        runtime,api,provider=self.runtime();runtime.arm(40)
        self.assertEqual(runtime.finish()['disposition'],'HOLD')
        self.assertEqual(self.rt.main([]),2);self.assertEqual(self.rt.main(['--live']),2)
        self.assertRaises(ValueError,runtime.accept_observer_evidence,[],{})


class ChannelTests(unittest.TestCase):
    make=BackendProcessTests.make
    spec=BackendProcessTests.spec
    setup_channel=BackendIOTests.setup_channel
    def setUp(self):
        BackendProcessTests.setUp(self)
        from providers import Provider
        self.clock.tick=10;self.clock.now_tick=lambda:self.clock.tick
        self.provider=Provider(binding(),A,{'OWNER':b'a'*32,'O':b'o'*32,'S':b's'*32,'W':b'w'*32},self.clock,
                               {x['component']:'O' for x in observations()})
        self.assertTrue(hasattr(importlib.import_module('native_runtime'),'FrameChannel'),'Missing authenticated native frame transport')
        self.channel_class=importlib.import_module('native_runtime').FrameChannel
    def channel(self,deadline=30):
        from win32_bridge import Bridge
        sc=scope();sc['verify_decision']=self.provider.verify_decision;sc['verify_observation']=self.provider.verify_observation
        ds=[]
        for d in decisions(POLICY+['G11_EXACT_FAULT_AUTHORITY']):
            d['issuer']='OWNER';ds.append(self.provider.sign_decision(d))
        obs=[self.provider.sign_observation(x,'O') for x in observations()]
        bridge=Bridge(self.backend,sc,ds,obs,self.clock,owner_role='S')
        process=bridge.bootstrap('W',sc['actor_specs']['W'])['token']
        event=self.backend.create_event(['S-1-5-21-1-2-3-1001'])
        pipe=self.backend.create_pipe(r'\\.\pipe\WP06_ART_CHANNEL',['S-1-5-21-1-2-3-1001'])
        op=self.backend.connect_pipe(pipe);self.api.io_status=0;self.backend.completion(op)
        self.backend.attach_control(process,event,pipe);self.api.io_status=996
        return self.channel_class(self.backend,pipe,self.provider,'S','W',self.clock,deadline,bridge=bridge)
    def message(self):
        import hmac,json
        m=dict(binding=binding(),issuer='W',credential_id='ART_W_CREDENTIAL',sequence='1',previous_digest='0'*64,tick='10',frequency='1000000000',kind='STOP_APPLIED',reason='REQUEST',result='APPLIED',payload_digest=A)
        body=json.dumps(m,sort_keys=True,separators=(',',':')).encode()
        m['tag']=hmac.new(b'w'*32,body,hashlib.sha256).hexdigest()
        return json.dumps(m,sort_keys=True,separators=(',',':')).encode()
    def test_native_channel_verifies_bound_role_chain_and_credential(self):
        channel=self.channel();self.api.io_wire=self.message();self.api.io_status=0
        channel.receive();result=channel.poll()
        self.assertEqual(result['message']['kind'],'STOP_APPLIED')
        channel.receive()
        self.assertRaises(ValueError,channel.poll)
        self.assertTrue(channel.quarantined)
    def test_channel_timeout_cancels_once_without_releasing_pending(self):
        channel=self.channel();channel.receive();self.clock.tick=30
        self.assertEqual(channel.poll()['status'],'HOLD')
        self.assertEqual(channel.poll()['status'],'HOLD')
        self.assertEqual(sum(x[0]=='CANCEL' for x in self.api.calls),1)
        self.assertTrue(self.backend.inventory()['pending'])
    def test_native_write_receipt_is_not_application_evidence(self):
        channel=self.channel();channel.send('REGISTERED','BOOTSTRAP','READY',A)
        self.api.io_status=0
        self.assertEqual(channel.poll()['status'],'WRITE_COMPLETED')
        self.assertFalse(channel.application_proven)
        self.assertRaises(ValueError,channel.send,'STOP_APPLIED','x','y',A)
    def test_native_channel_rejects_tamper_and_clock_rollback(self):
        channel=self.channel();self.api.io_status=0
        self.api.io_wire=self.message().replace(b'APPLIED',b'FORGED',1)
        channel.receive();self.assertRaises(ValueError,channel.poll)
        self.api=FakeAPI();self.backend=self.make()
        other=self.channel();other.receive();self.clock.tick=9
        self.assertRaises(ValueError,other.poll);self.assertTrue(other.quarantined)
    def test_channel_ownership_cannot_reset_replay_state(self):
        channel=self.channel()
        self.assertRaises(ValueError,self.channel_class,self.backend,channel.pipe,self.provider,'S','W',self.clock,30,bridge=channel.bridge)


class ReviewCorrectionTests(unittest.TestCase):
    setUp=RuntimeTests.setUp
    make=BackendProcessTests.make
    spec=BackendProcessTests.spec
    setup_channel=BackendIOTests.setup_channel
    runtime=RuntimeTests.runtime
    def test_i1_pending_event_cannot_close(self):
        process,event,pipe=self.setup_channel();op=self.backend.start_io(process,b'')
        io_event=self.backend._operations[op]['event'];before=list(self.api.closed)
        self.assertRaises(ValueError,self.backend.close,io_event)
        self.assertEqual(self.api.closed,before)
    def test_i2_uncertain_completion_never_reanimates_or_retries_close(self):
        process,event,pipe=self.setup_channel();op=self.backend.start_io(process,b'')
        self.api.io_status=0;self.api.fail='close'
        self.assertRaises(ValueError,self.backend.completion,op)
        count=len(self.api.closed)
        self.assertNotEqual(self.backend.completion(op)['status'],'SUCCESS')
        self.assertEqual(len(self.api.closed),count)
        self.assertRaises(ValueError,self.backend.close,pipe)
        count=len(self.api.closed)
        self.assertRaises(ValueError,self.backend.close,pipe)
        self.assertEqual(len(self.api.closed),count)
    def test_i2b_channel_cleanup_uncertainty_is_sticky(self):
        ChannelTests.setUp(self)
        channel=ChannelTests.channel(self)
        channel.send('REGISTERED','BOOTSTRAP','READY',A);self.api.io_status=0;self.api.fail='close'
        self.assertRaises(ValueError,channel.poll)
        self.assertTrue(channel.quarantined)
        self.assertEqual(channel.poll()['status'],'HOLD')
        before=len(self.api.calls)
        self.assertRaises(ValueError,channel.send,'REGISTERED','BOOTSTRAP','READY',A)
        self.assertEqual(len(self.api.calls),before)
    def test_i3_revocation_reaches_copied_bridge_and_due_capability(self):
        runtime,api,provider=self.runtime();runtime.arm(40)
        provider.revoke('OWNER')
        self.assertRaises(ValueError,runtime.bridge._admit,'PREARM_WORK_FAULT')
    def test_i3b_revocation_stops_cached_action_without_verifier_dependency(self):
        runtime,api,provider=self.runtime();runtime.arm(40);provider.revoke('OWNER');self.clock.tick=40
        self.assertEqual(runtime.supervisor_once()['kind'],'QUARANTINED')
        self.assertEqual(sum(x[0]=='SET' for x in api.calls),0)
    def test_i4_authenticated_controller_loss_request_tamper_and_revocation(self):
        runtime,api,provider=self.runtime();runtime.arm(40)
        self.assertTrue(hasattr(provider,'sign_status'),'Missing controller status/request authentication')
        status=dict(binding=binding(),alive=False,heartbeat_tick=10,heartbeat_loss_tick=20,evidence_ref='PENDING')
        signed=provider.sign_status(status)
        self.assertTrue(provider.verify_observation(signed))
        bad=copy.deepcopy(signed);bad['alive']=True
        self.assertFalse(provider.verify_observation(bad))
        self.assertEqual(runtime.supervisor_once(signed)['kind'],'CONTROL_ATTEMPT')
        request=provider.sign_status(dict(binding=binding(),kind='REQUEST',tick=10,evidence_ref='PENDING'))
        self.assertTrue(provider.verify_observation(request));provider.revoke('C')
        self.assertFalse(provider.verify_observation(request))
    def test_i4b_authenticated_request_and_status_freshness(self):
        runtime,api,provider=self.runtime();runtime.arm(40)
        status=provider.sign_status(dict(binding=binding(),alive=True,heartbeat_tick=10,heartbeat_loss_tick=20,evidence_ref='PENDING'))
        request=provider.sign_status(dict(binding=binding(),kind='REQUEST',tick=10,evidence_ref='PENDING'))
        self.assertEqual(runtime.supervisor_once(status,request)['kind'],'CONTROL_ATTEMPT')
        self.assertRaises(ValueError,provider.sign_status,dict(binding=binding(),kind='REQUEST',tick=11,evidence_ref='PENDING'))
        self.clock.tick=61
        self.assertFalse(provider.verify_observation(status));self.assertFalse(provider.verify_observation(request))
    def test_i5_channel_peer_role_matches_captured_endpoint(self):
        runtime,api,provider=self.runtime()
        pipe=runtime.backend._row(runtime.worker)['pipe']
        self.assertRaises(ValueError,self.rt.FrameChannel,runtime.backend,pipe,provider,'S','C',self.clock,30,bridge=runtime.bridge)
        good=self.rt.FrameChannel(runtime.backend,pipe,provider,'S','W',self.clock,30,bridge=runtime.bridge)
        self.assertEqual(good.peer,'W')
    def test_i6_channel_cannot_extend_approved_ipc_budget(self):
        runtime,api,provider=self.runtime()
        pipe=runtime.backend._row(runtime.worker)['pipe']
        self.assertRaises(ValueError,self.rt.FrameChannel,runtime.backend,pipe,provider,'S','W',self.clock,200,bridge=runtime.bridge)
        channel=self.rt.FrameChannel(runtime.backend,pipe,provider,'S','W',self.clock,60,bridge=runtime.bridge)
        self.clock.tick=70;count=len(api.calls)
        self.assertRaises(ValueError,channel.send,'REGISTERED','BOOTSTRAP','READY',A)
        self.assertEqual(len(api.calls),count)
    def test_i7_application_fact_survives_terminal_noop(self):
        runtime,api,provider=self.runtime();runtime.arm(40);api.event_signaled=True
        runtime.worker_once(True);first=copy.deepcopy(runtime.application)
        self.assertIsNotNone(first)
        runtime.worker_once(True)
        self.assertEqual(runtime.application,first)


if __name__=='__main__':unittest.main()
