"""Synthetic Stage-A journal only. No live-control or participant interfaces."""
import hashlib
import json
import pathlib
import re
import shutil
import sqlite3
import threading
import uuid
from contextlib import closing

ROOT=pathlib.Path(__file__).resolve().parents[1]/'audit-local/intake/wp06-stage-a-implementation-c870e8b'
MAX=9223372036854775807
ZERO='0'*64
FIELDS={'origin','contract_digest','build_digest','host_id','boot_id','session_id','owner_nonce','worker_epoch','command_id','pid','creation_time','engine_module_digest','reservation_id','lease_id','scope_id','clock_domain'}
DIGESTS={'contract_digest','build_digest','engine_module_digest'}
KINDS={'RESERVE','ARM','DISPATCH_INTENT','DISPATCH_OBSERVED','STOP_INTENT','STOP_APPLIED','EXIT_OBSERVED','CLEANUP_OBSERVED','QUARANTINED'}
CLAIMS_SQL='CREATE TABLE claims(reservation TEXT PRIMARY KEY, command TEXT UNIQUE NOT NULL, binding TEXT NOT NULL)'
EVENTS_SQL='CREATE TABLE events(seq INTEGER PRIMARY KEY, reservation TEXT NOT NULL, kind TEXT NOT NULL, metadata TEXT NOT NULL, previous TEXT NOT NULL, digest TEXT NOT NULL)'
_PATH_LOCKS={}
_PATH_LOCKS_GUARD=threading.Lock()

def integer(value,positive=False):
    if type(value) is not int or not (1 if positive else 0)<=value<=MAX:raise ValueError('Bounded exact integer required')
    return value

def validate_binding(value,wire=False):
    if type(value) is not dict or set(value)!=FIELDS:raise ValueError('Exact artificial binding required')
    result=dict(value)
    if type(result['origin']) is not str or result['origin']!='ARTIFICIAL_ONLY':raise ValueError('Artificial origin required')
    for key in FIELDS-{'origin'}:
        item=result[key]
        if key in ('pid','worker_epoch'):
            if wire:
                if type(item) is not str or not re.fullmatch(r'[1-9][0-9]*',item) or len(item)>19:raise ValueError('Canonical positive decimal required')
                item=int(item)
            integer(item,True)
            if wire:result[key]=str(item)
        elif key in DIGESTS:
            if type(item) is not str or not re.fullmatch('[0-9a-f]{64}',item):raise ValueError('Hex digest required')
        elif type(item) is not str or not re.fullmatch(r'ART_[A-Z0-9_]{1,60}',item):raise ValueError('Bounded artificial token required')
    return result

def encoded(value):return json.dumps(value,sort_keys=True,separators=(',',':'),ensure_ascii=True)

class Journal:
    """Forward-only fixture claims. Durability limited to observed SQLite commits."""
    def __init__(self,path,expected_watermark):
        self.path=pathlib.Path(path).absolute();self._blocked=False;self.fixture_fault=None
        if (ROOT/'validation.json').exists() or ROOT.resolve()/'runs' not in self.path.resolve().parents or self.path.resolve()!=self.path or self.path.suffix!='.sqlite':raise ValueError('Current unsealed fixture path required')
        with _PATH_LOCKS_GUARD:self._lock=_PATH_LOCKS.setdefault(str(self.path),threading.RLock())
        if self.blocked:raise ValueError('Preserved journal hold requires separately reviewed reconciliation')
        if type(expected_watermark) not in (tuple,list) or len(expected_watermark)!=2:raise ValueError('Explicit watermark required')
        integer(expected_watermark[0])
        if type(expected_watermark[1]) is not str or not re.fullmatch('[0-9a-f]{64}',expected_watermark[1]):raise ValueError('Watermark digest')
        self._expected=tuple(expected_watermark)
        existed=self.path.exists()
        try:
            with self._lock,closing(self._connection()) as con:
                if not existed:
                    if self._expected!=(0,ZERO):raise ValueError('Missing journal with nonzero watermark')
                    con.execute('PRAGMA journal_mode=DELETE')
                    con.executescript(CLAIMS_SQL+';'+EVENTS_SQL+';')
                self._scan(con)
        except (sqlite3.Error,ValueError,OSError) as error:self._fail(error,persistent=not (isinstance(error,sqlite3.OperationalError) and getattr(error,'sqlite_errorcode',None)==sqlite3.SQLITE_BUSY))

    @property
    def blocked(self):return self._blocked or self.path.with_name(self.path.name+'.hold').exists()

    def _connection(self):
        con=sqlite3.connect(self.path,timeout=0,isolation_level=None)
        try:con.execute('PRAGMA synchronous=EXTRA')
        except Exception:con.close();raise
        return con

    def _fail(self,error,persistent=True):
        self._blocked=True
        if persistent:
            try:
                with self.path.with_name(self.path.name+'.hold').open('xb') as marker:marker.write(b'ART_UNCERTAIN_REQUIRES_RECONCILIATION')
            except FileExistsError:pass
        if self.path.is_file():shutil.copyfile(self.path,self.path.with_name(self.path.name+'.'+uuid.uuid4().hex[:8]+'.diagnostic'))
        raise ValueError('Journal unavailable, uncertain or invalid; no retry') from error

    def _scan(self,con):
        owned=not con.in_transaction
        if owned:con.execute('BEGIN')
        try:return self._scan_rows(con)
        finally:
            if owned and con.in_transaction:con.execute('ROLLBACK')

    def _scan_rows(self,con):
        if con.execute('PRAGMA quick_check').fetchall()!=[('ok',)] or con.execute('PRAGMA journal_mode').fetchone()[0]!='delete':raise ValueError('Journal integrity/mode')
        schema={(kind,name):sql for kind,name,sql in con.execute('SELECT type,name,sql FROM sqlite_master')}
        if schema!={('table','claims'):CLAIMS_SQL,('table','events'):EVENTS_SQL,('index','sqlite_autoindex_claims_1'):None,('index','sqlite_autoindex_claims_2'):None}:raise ValueError('Unexpected journal schema/constraints')
        claims=con.execute('SELECT reservation,command,binding FROM claims').fetchall();known=set()
        for reservation,command,bound in claims:
            b=validate_binding(json.loads(bound))
            if reservation!=b['reservation_id'] or command!=self._command(b):raise ValueError('Claim binding mismatch')
            known.add(reservation)
        events=[];previous=ZERO;statuses={};watermarks={0:ZERO}
        for seq,reservation,kind,metadata,prev,digest in con.execute('SELECT seq,reservation,kind,metadata,previous,digest FROM events ORDER BY seq'):
            if seq!=len(events)+1 or reservation not in known or kind not in KINDS or prev!=previous or json.loads(metadata)!={'reason':'ART_FIXTURE'}:raise ValueError('Forward journal history')
            body=[seq,reservation,kind,metadata,prev];actual=hashlib.sha256(encoded(body).encode('ascii')).hexdigest()
            if digest!=actual:raise ValueError('Journal chain mismatch')
            previous=digest;events.append(dict(seq=seq,reservation=reservation,kind=kind));statuses[reservation]=kind;watermarks[seq]=digest
        if any(r not in statuses for r in known) or watermarks.get(self._expected[0])!=self._expected[1]:raise ValueError('Journal rollback or missing claim event')
        return dict(claims=len(claims),events=events,statuses=statuses,watermark=(len(events),previous),dispatches=sum(e['kind']=='DISPATCH_OBSERVED' for e in events))

    @staticmethod
    def _command(b):return encoded([b[k] for k in ('host_id','boot_id','session_id','worker_epoch','command_id')])

    def _write(self,b,kind,reserve=False):
        with self._lock:
            if self.blocked or not self.path.exists():raise ValueError('Journal frozen or missing')
            con=None;transaction_started=False
            try:
                con=self._connection();con.execute('BEGIN IMMEDIATE');transaction_started=True;state=self._scan(con)
                if self.fixture_fault=='BEFORE_WRITE':raise sqlite3.OperationalError('ART_BEFORE_WRITE')
                if reserve:con.execute('INSERT INTO claims VALUES(?,?,?)',(b['reservation_id'],self._command(b),encoded(b)))
                else:
                    row=con.execute('SELECT binding FROM claims WHERE reservation=?',(b['reservation_id'],)).fetchone()
                    if not row or row[0]!=encoded(b) or state['statuses'][b['reservation_id']] in ('QUARANTINED','CLEANUP_OBSERVED'):raise ValueError('Unknown/terminal claim')
                seq=state['watermark'][0]+1;integer(seq,True);prev=state['watermark'][1];metadata=encoded({'reason':'ART_FIXTURE'})
                digest=hashlib.sha256(encoded([seq,b['reservation_id'],kind,metadata,prev]).encode('ascii')).hexdigest()
                con.execute('INSERT INTO events VALUES(?,?,?,?,?,?)',(seq,b['reservation_id'],kind,metadata,prev,digest))
                if self.fixture_fault=='BEFORE_COMMIT':raise sqlite3.OperationalError('ART_BEFORE_COMMIT')
                if self.blocked:raise ValueError('Journal hold observed before commit')
                con.execute('COMMIT')
                if self.fixture_fault=='AFTER_COMMIT':raise sqlite3.OperationalError('ART_AFTER_COMMIT')
                self._expected=(seq,digest)
                return dict(kind=kind,reservation=b['reservation_id'],watermark=self._expected,origin='ARTIFICIAL_ONLY')
            except (sqlite3.Error,ValueError,OSError) as error:
                if con is not None and con.in_transaction:con.execute('ROLLBACK')
                self._fail(error,persistent=not isinstance(error,sqlite3.IntegrityError) and transaction_started)
            finally:
                if con is not None:con.close()

    def reserve(self,binding):return self._write(validate_binding(binding),'RESERVE',True)

    def append(self,binding,kind,metadata):
        if type(kind) is not str or kind not in KINDS-{'RESERVE'} or type(metadata) is not dict or metadata!={'reason':'ART_FIXTURE'}:raise ValueError('Exact journal event required')
        return self._write(validate_binding(binding),kind)

    def snapshot(self):
        with self._lock:
            if not self.path.exists():self._fail(ValueError('Missing journal'))
            con=None
            try:con=self._connection();return self._scan(con)
            except (sqlite3.Error,ValueError,OSError,json.JSONDecodeError) as error:self._fail(error)
            finally:
                if con is not None:con.close()

    def status(self,binding):return self.snapshot()['statuses'].get(validate_binding(binding)['reservation_id'])

    def recover(self):
        with self._lock:
            state=self.snapshot();ids=[]
            for reservation,status in state['statuses'].items():
                if status not in ('QUARANTINED','CLEANUP_OBSERVED'):
                    with closing(self._connection()) as con:bound=json.loads(con.execute('SELECT binding FROM claims WHERE reservation=?',(reservation,)).fetchone()[0])
                    self.append(bound,'QUARANTINED',{'reason':'ART_FIXTURE'});ids.append(reservation)
            return ids
