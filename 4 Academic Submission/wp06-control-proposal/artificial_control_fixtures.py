"""Artificial concurrency patterns and envelope checks; no Stata, sockets or killer."""
import ast
import asyncio
import threading

async def dispatch_fixture(*,offload):
    assert type(offload)==bool
    started=threading.Event();release=threading.Event();finished=threading.Event()
    order=[];observed={};timer=None
    def work():
        order.append('work_started');started.set()
        if not release.wait(2):raise TimeoutError('Artificial fixture release missing')
        order.append('work_returned');finished.set()
    async def control():
        if not await asyncio.to_thread(started.wait,2):raise TimeoutError('Artificial work never started')
        order.append('control_reached');observed['work_stopped_at_control']=finished.is_set()
        if offload:release.set()
    task=asyncio.create_task(control())
    try:
        await asyncio.sleep(0)
        if offload:await asyncio.to_thread(work)
        else:
            timer=threading.Timer(.05,release.set);timer.start()
            work()
        await asyncio.wait_for(task,3)
    finally:
        release.set()
        if timer is not None:timer.cancel();timer.join(1)
        if not task.done():
            task.cancel()
            try:await task
            except asyncio.CancelledError:pass
    assert finished.is_set() and task.done()
    return dict(order=order,fixture_cleanup_complete=True,origin='ARTIFICIAL_PATTERN_ONLY',**observed)

async def cooperative_fixture():
    started=threading.Event();stop=threading.Event();finished=threading.Event()
    def worker():
        started.set()
        try:
            if not stop.wait(2):raise TimeoutError('Artificial stop was not delivered')
            return 'STOPPED_ARTIFICIAL'
        finally:finished.set()
    task=asyncio.create_task(asyncio.to_thread(worker))
    try:
        if not await asyncio.to_thread(started.wait,2):raise TimeoutError('Artificial worker failed to start')
        stop.set();outcome=await asyncio.wait_for(task,3)
    finally:
        stop.set()
        if not task.done():await asyncio.wait_for(task,3)
    return dict(worker_outcome=outcome,fixture_cleanup_complete=finished.is_set(),stata_interrupt_validated=False)

def artificial_binding():
    return dict(origin='ARTIFICIAL_ONLY',session_id='ART_owned_session',owner_nonce='ART_nonce',
      epoch=1,command_id='ART_command',pid=123,creation_token='ART_creation')

def validate_envelope(request,registered):
    assert set(request)==set(registered)==set(artificial_binding())
    assert registered['origin']=='ARTIFICIAL_ONLY' and registered['session_id'].startswith('ART_owned_')
    assert type(registered['pid'])==int and registered['pid']>0
    assert type(registered['epoch'])==int and registered['epoch']>0
    assert all(registered[k].startswith('ART_') for k in ['owner_nonce','command_id','creation_token'])
    assert request==registered
    return 'MATCH_ONLY_NO_SIGNAL'

def dispatch_calls(source,function_name):
    tree=ast.parse(source)
    functions=[n for n in ast.walk(tree) if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef)) and n.name==function_name]
    assert len(functions)==1
    fn=functions[0];parents={child:node for node in ast.walk(fn) for child in ast.iter_child_nodes(node)}
    def name(node):
        if isinstance(node,ast.Name):return node.id
        if isinstance(node,ast.Attribute):return name(node.value)+'.'+node.attr
        return ''
    out=[]
    for node in ast.walk(fn):
        if not isinstance(node,ast.Call):continue
        called=name(node.func)
        if called=='asyncio.to_thread' or called.endswith(('.execute','.destroy_session')):
            out.append(dict(call=called,awaited=isinstance(parents.get(node),ast.Await)))
    return out
