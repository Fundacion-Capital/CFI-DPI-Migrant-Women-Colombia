"""Exact isolated MCP client. Import is inert; execution needs a separately prepared grant."""
import ast
import asyncio
from datetime import timedelta
import json
from pathlib import Path
import re
import sys
sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
from deployment import validate, require_execution, load_active, digest
from startup_guard import verify, environment, sdk_environment


def contract(binding):
    validate(binding)
    if (Path(binding['source_root']).resolve() != HERE
            or Path(binding['entry']).resolve() != HERE / 'runtime_roles.py'):
        raise ValueError('The client target is not this exact successor source')
    root = Path(binding['private_root'])
    return dict(command=binding['python'], args=['-I','-S','-B','-X','utf8',
        str(HERE / 'mcp_adapter.py'), str(root / 'active_binding.json')],
        cwd=str(root), env=environment(binding))


def reserve_client(binding, grant):
    require_execution(binding, grant)
    verify(binding)
    contract(binding)
    with (Path(binding['private_root']) / 'CLIENT_RESERVED').open('xb') as stream:
        stream.write(digest(binding).encode('ascii'))


def _text(result):
    if result.isError is not False or not result.content:
        raise ValueError('The isolated tool returned an error or empty result')
    if any(block.type != 'text' or type(block.text) is not str for block in result.content):
        raise ValueError('Only bounded text metadata is accepted')
    text = ''.join(block.text for block in result.content)
    if len(text.encode('utf-8')) > 8192:
        raise ValueError('Tool metadata exceeds the fixed bound')
    return text


async def exchange(binding, grant, session):
    require_execution(binding, grant)
    verify(binding)
    contract(binding)
    sid = binding['run_scope']['session_id']
    # The first transport call includes bootstrap; the Stata selection timeout remains ten seconds.
    read_budget = timedelta(seconds=binding['bounds']['final_evidence_seconds'])
    await session.initialize()
    initial = ast.literal_eval(_text(await session.call_tool('stata_session',
        dict(action='list', session_id=sid), read_timeout_seconds=read_budget)))
    if initial != dict(session_id=sid, opened=False, closed=False):
        raise ValueError('The initial isolated session is foreign or already used')
    outputs = []
    for code, marker in zip(binding['literal_selections'], ('WP06_EMPTY_BEGIN','WP06_EMPTY_END')):
        text = _text(await session.call_tool('stata_run_selection',
            dict(selection=code, session_id=sid, timeout=10), read_timeout_seconds=read_budget))
        lines = [line.strip() for line in text.splitlines()]
        if marker not in lines or not any(re.fullmatch(r'N=\s*0\s+K=\s*0', line) for line in lines):
            raise ValueError('Empty-session marker or zero dimensions were not established')
        outputs.append(text)
    final = ast.literal_eval(_text(await session.call_tool('stata_session',
        dict(action='list', session_id=sid), read_timeout_seconds=read_budget)))
    if final != dict(session_id=sid, opened=True, closed=True):
        raise ValueError('The exact session did not report completed closure')
    return dict(recipe_completed=True, session_id=sid, selections=2, outputs=outputs,
        independent_native_acceptance=False, scientific_acceptance=False)


async def _connect(binding, grant, errlog):
    require_execution(binding, grant)
    verify(binding)
    with sdk_environment(binding, grant):
        from mcp import ClientSession, StdioServerParameters
        from mcp.client.stdio import stdio_client
        parameters = StdioServerParameters(**contract(binding))
        # This is an async client budget, not a claim of independent native termination.
        async with asyncio.timeout(binding['bounds']['final_evidence_seconds']):
            async with stdio_client(parameters, errlog=errlog) as (read, write):
                async with ClientSession(read, write) as session:
                    return await exchange(binding, grant, session)


def main(path):
    binding, grant = load_active(path)
    reserve_client(binding, grant)  # Consumed before SDK import; no retry after any failure.
    root = Path(binding['private_root'])
    try:
        with (root / 'client.stderr.log').open('x', encoding='utf-8') as errlog:
            result = asyncio.run(_connect(binding, grant, errlog))
    except BaseException as error:
        with (root / 'client_receipt.json').open('x', encoding='utf-8') as stream:
            json.dump(dict(recipe_completed=False, failure_type=type(error).__name__, retry=False), stream)
        raise
    with (root / 'client_receipt.json').open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2)


if __name__ == '__main__':
    if len(sys.argv) != 2:
        raise SystemExit('One exact authorized prepared active-binding path is required')
    main(Path(sys.argv[1]))
