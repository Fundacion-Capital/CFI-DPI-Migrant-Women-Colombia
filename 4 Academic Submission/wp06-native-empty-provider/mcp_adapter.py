"""Isolated stdio MCP binding. No server, native provider or engine starts on import."""
import sys
sys.dont_write_bytecode = True
from pathlib import Path
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import ast
import enum
import hashlib
import re
import threading
from deployment import load_active


def source_manager(binding):
    path = Path(binding['manager_source'])
    raw = path.read_bytes()
    if hashlib.sha256(raw).hexdigest() != binding['manager_sha256']:
        raise ValueError('Selection source pin changed')
    tree = ast.parse(raw.decode('utf-8-sig'))
    old = next(n for n in tree.body if isinstance(n, ast.ClassDef) and n.name == 'SessionManager')
    execute = next(n for n in old.body if isinstance(n, ast.FunctionDef) and n.name == 'execute')
    join = next(n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == 'join_stata_line_continuations')
    for item in (execute, join):
        for node in ast.walk(item):
            if isinstance(node, ast.arg):
                node.annotation = None
            if isinstance(node, ast.FunctionDef):
                node.returns = None
                node.decorator_list = []
    cls = ast.ClassDef(name='PinnedManager', bases=[], keywords=[], body=[execute], decorator_list=[])
    module = ast.fix_missing_locations(ast.Module(body=[join, cls], type_ignores=[]))
    namespace = {'re': re, 'CommandType': enum.Enum('CommandType', {'EXECUTE': 'execute'})}
    exec(compile(module, str(path) + ':execute-definition-only', 'exec'), namespace)
    result = namespace['PinnedManager']
    result.__source_sha256__ = binding['manager_sha256']
    return result


def build_server(manager, sdk_factory):
    from native_session import bind_dispatcher
    route = bind_dispatcher(manager)
    server = sdk_factory('WP06 isolated native empty Stata')
    state = {'opened': False, 'closed': False, 'close_result': None}
    def close():
        if not state['closed']:
            state['closed'] = True
            state['close_result'] = manager.close()
        return state['close_result']

    @server.tool(name='stata_run_selection')
    def stata_run_selection(selection: str, session_id: str, timeout: int = 10) -> str:
        try:
            if state['closed']:
                raise ValueError('This one-run MCP session is closed')
            if (session_id != manager._scope['session_id'] or type(timeout) is not int or timeout != 10
                    or manager.calls >= 2 or selection != manager._selections[manager.calls]):
                manager._forbidden()  # Reject before an invalid first request can initialize Stata.
            if not state['opened']:
                manager.open()
                state['opened'] = True
            result = route(dict(selection=selection, session_id=session_id, timeout=timeout), True)
            if manager.calls == 2:
                if close()['accepted'] is not True:
                    raise ValueError('Final native output cannot pass before successful cleanup')
            return result['output']
        except Exception:
            if not getattr(manager, '_close_started', False):
                close()
            raise

    @server.tool(name='stata_session')
    def stata_session(action: str, session_id: str = '') -> str:
        if action == 'list':
            return str({'session_id': manager._scope['session_id'], 'opened': state['opened'], 'closed': state['closed']})
        if action == 'destroy' and session_id == manager._scope['session_id']:
            return str(close())
        raise ValueError('Only this bound session can be listed or destroyed')

    return server, close


def lifecycle_step(manager, kernel, close):
    if manager._phase == 'CLOSED':
        return True
    if manager._resource is not None:
        manager.control_tick()
    now = kernel.now()
    if now >= manager._origin + 110 * kernel.frequency:
        close()  # Enforce final ownership cleanup even if the client sends no further request.
    if manager._phase != 'CLOSED' and now >= manager._origin + 120 * kernel.frequency:
        manager._fail('Native final lifecycle deadline exceeded')
        manager._owner._rollback()
        return True
    return manager._phase == 'CLOSED'


def lifecycle_loop(manager, kernel, close, done):
    while not done.wait(0.01):
        try:
            if lifecycle_step(manager, kernel, close):
                return
        except Exception as error:
            manager._fail(error)
            manager._owner._rollback()
            return


def main(binding_path):
    binding, grant = load_active(binding_path)
    from win32_owner import Kernel
    from private_channel import Channel
    from native_provider import NativeOwner
    from native_session import isolated_manager
    kernel = Kernel(binding, grant)
    sys.path.insert(0, binding['site_packages'])
    from mcp.server.fastmcp import FastMCP
    owner = NativeOwner(kernel, Channel(kernel), binding, binding['run_scope'])
    manager = isolated_manager(source_manager(binding), owner, binding['run_scope'], binding)
    server, close = build_server(manager, FastMCP)
    done = threading.Event()
    supervisor = threading.Thread(target=lifecycle_loop, args=(manager, kernel, close, done), daemon=True)
    supervisor.start()
    try:
        server.run(transport='stdio')
    finally:
        try:
            close()
        finally:
            done.set()
            supervisor.join(1)
            if supervisor.is_alive():
                raise ValueError('Parent lifecycle supervisor did not close')


if __name__ == '__main__':
    if len(sys.argv) != 2:
        raise SystemExit('An exact authorized active binding is required')
    main(sys.argv[1])
