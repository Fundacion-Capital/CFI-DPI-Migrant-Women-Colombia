"""Independent-review regressions: early admission, outstanding spawn, atomic publication."""
import json
from pathlib import Path
import tempfile
import threading
import unittest
from unittest.mock import patch
import mcp_adapter
from private_channel import Channel
import test_lifecycle
from test_support import FakeKernel, prepared_binding, scope


class ReviewFixTests(unittest.TestCase):
    setup_run=test_lifecycle.LifecycleTests.setup_run

    def test_r01_close_during_first_guard_cannot_be_followed_by_allocation(self):
        value,kernel,_,_,manager,server,close=self.setup_run()
        entered,release=threading.Event(),threading.Event(); original=manager._before
        first=True
        def guard(seconds):
            nonlocal first
            if seconds==60 and first:
                first=False; entered.set()
                if not release.wait(2): raise RuntimeError('Artificial release missing')
            original(seconds)
        caught=[]
        def opening():
            try: server.tools['stata_run_selection'](value['literal_selections'][0],scope()['session_id'],10)
            except BaseException as error: caught.append(error)
        with patch.object(manager,'_before',side_effect=guard):
            thread=threading.Thread(target=opening); thread.start()
            try:
                self.assertTrue(entered.wait(2))
                self.assertTrue(close().get('cleanup_pending',False))
            finally:
                release.set();thread.join(2)
        self.assertFalse(thread.is_alive());self.assertEqual(len(caught),1)
        self.assertEqual(kernel.handles,set())
        self.assertFalse(any(isinstance(e,tuple) and e[0]=='spawn' for e in kernel.events))
        self.assertFalse(close()['accepted'])

    def test_r02_supervisor_cannot_terminalize_outstanding_worker_or_watchdog(self):
        for target in ('worker','watchdog'):
            with self.subTest(target=target):
                value,kernel,_,_,manager,server,close=self.setup_run()
                original=kernel.spawn_suspended; supervisor=[]
                def spawn(role,descriptor,inherited):
                    handle=original(role,descriptor,inherited)
                    if role==target:
                        kernel.tick=120
                        supervisor.append(mcp_adapter.lifecycle_step(manager,kernel,close))
                    return handle
                with patch.object(kernel,'spawn_suspended',side_effect=spawn):
                    with self.assertRaises(ValueError):
                        server.tools['stata_run_selection'](value['literal_selections'][0],scope()['session_id'],10)
                self.assertEqual(supervisor,[False])
                self.assertEqual(kernel.handles,set())
                self.assertFalse(close()['accepted'])
                self.assertNotIn(('resume',target),kernel.events)
                closed=[e[1] for e in kernel.events if isinstance(e,tuple) and e[0]=='close']
                self.assertEqual(len(closed),len(set(closed)))

    def test_r03_write_then_flush_failure_cannot_publish_final_success(self):
        with tempfile.TemporaryDirectory(prefix='wp06_commit_artificial_') as folder:
            value,kernel,wire,_,_,server,close=self.setup_run()
            descriptor=prepared_binding(Path(folder)); root=Path(descriptor['private_root'])
            real=Channel(FakeKernel());real.prepare(descriptor,scope(),{'worker':b'w'*32,'watchdog':b'o'*32})
            original_record=wire.record_parent; original_open=Path.open
            def record(kind,payload):
                if kind=='cleanup': real.record_parent(kind,payload)
                else: original_record(kind,payload)
            class FailedFlush:
                def __init__(self,stream): self.stream=stream
                def __enter__(self): return self
                def write(self,raw):
                    count=self.stream.write(raw);self.stream.flush();return count
                def flush(self): raise OSError('artificial failure after complete bytes')
                def fileno(self): return self.stream.fileno()
                def __exit__(self,*args): self.stream.close()
            def opened(path,*args,**kwargs):
                stream=original_open(path,*args,**kwargs)
                if path.name in {'parent.cleanup.json','parent.cleanup.pending'} and args and args[0]=='xb':
                    return FailedFlush(stream)
                return stream
            with patch.object(wire,'record_parent',side_effect=record),patch.object(Path,'open',new=opened):
                server.tools['stata_run_selection'](value['literal_selections'][0],scope()['session_id'],10)
                with self.assertRaises(ValueError):
                    server.tools['stata_run_selection'](value['literal_selections'][1],scope()['session_id'],10)
            self.assertFalse(close()['accepted'])
            self.assertFalse((root/'parent.cleanup.json').exists())
            pending=json.loads((root/'parent.cleanup.pending').read_text(encoding='utf-8'))
            self.assertTrue(pending['payload']['accepted'])
            self.assertEqual(kernel.handles,set())

    def test_r03_successful_cleanup_publication_has_one_exclusive_final_record(self):
        with tempfile.TemporaryDirectory(prefix='wp06_commit_artificial_') as folder:
            value=prepared_binding(Path(folder));root=Path(value['private_root'])
            wire=Channel(FakeKernel());wire.prepare(value,scope(),{'worker':b'w'*32,'watchdog':b'o'*32})
            result=dict(accepted=True,cleanup_complete=True,calls=2,completed=2,failures=[])
            wire.record_parent('cleanup',result)
            self.assertEqual(json.loads((root/'parent.cleanup.json').read_text(encoding='utf-8'))['payload'],result)
            self.assertEqual((root/'parent.cleanup.pending').read_bytes(),(root/'parent.cleanup.json').read_bytes())
            with self.assertRaises(FileExistsError):wire.record_parent('cleanup',result)

    def test_r03_candidate_close_failure_cannot_publish_success(self):
        with tempfile.TemporaryDirectory(prefix='wp06_commit_artificial_') as folder:
            value=prepared_binding(Path(folder));root=Path(value['private_root'])
            wire=Channel(FakeKernel());wire.prepare(value,scope(),{'worker':b'w'*32,'watchdog':b'o'*32})
            original=Path.open
            class FailedClose:
                def __init__(self,stream):self.stream=stream
                def __enter__(self):return self.stream
                def __exit__(self,*args):self.stream.close();raise OSError('artificial close failure after all bytes')
            def opened(path,*args,**kwargs):
                stream=original(path,*args,**kwargs)
                return FailedClose(stream) if path.name=='parent.cleanup.pending' else stream
            with patch.object(Path,'open',new=opened):
                with self.assertRaises(OSError):wire.record_parent('cleanup',dict(accepted=True))
            self.assertFalse((root/'parent.cleanup.json').exists())
            self.assertTrue((root/'parent.cleanup.pending').exists())

    def test_r03_foreign_existing_final_is_never_replaced(self):
        with tempfile.TemporaryDirectory(prefix='wp06_commit_artificial_') as folder:
            value=prepared_binding(Path(folder));root=Path(value['private_root'])
            wire=Channel(FakeKernel());wire.prepare(value,scope(),{'worker':b'w'*32,'watchdog':b'o'*32})
            final=root/'parent.cleanup.json';final.write_bytes(b'preserved foreign record')
            with self.assertRaises(FileExistsError):wire.record_parent('cleanup',dict(accepted=True))
            self.assertEqual(final.read_bytes(),b'preserved foreign record')


if __name__=='__main__': unittest.main()
