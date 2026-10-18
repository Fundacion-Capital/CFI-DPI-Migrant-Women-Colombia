"""Metadata-only artificial deployment and evidence rules; no native calls or key discovery."""
import copy
import hashlib
import hmac
from functools import wraps
from identity_bootstrap import Bootstrap
from journal_protocol import exact,require,integer,digest,canonical,sha

ROLES=('L','O','S','C','W')
STAGES=(('S','CONTROL_ATTEMPT'),('W','WORKER_APPLICATION'),('O','APPLIED_OBSERVATION'),('O','EXIT_OBSERVATION'),('O','CLEANUP_OBSERVATION'),('L','FINAL_INVENTORY'))
TICKET=set('protocol deployment_digest role actor_digest credential_id issued_tick expires_tick tag'.split())
EVIDENCE=set('protocol deployment_digest role actor_digest credential_id kind sequence previous_digest tick payload tag'.split())

def tag(key,domain,body):
    require(domain in ('HANDOFF','EVIDENCE'),'Unknown deployment domain')
    return hmac.new(key,canonical(dict(protocol='WP06_DEPLOYMENT_AUTH_V1_ARTIFICIAL',domain=domain,body=body)),hashlib.sha256).hexdigest()

def guarded(method):
    @wraps(method)
    def call(self,*args,**kwargs):
        try:self._now();return method(self,*args,**kwargs)
        except Exception as error:
            self.failed=True
            if isinstance(error,ValueError):raise
            raise ValueError('Artificial contract quarantined; no retry') from error
    return call

class DeploymentContract:
    def __init__(self,root,implementation_digest,witness_verifiers):
        require(type(root) is Bootstrap and root._target is not None and all(root._phases.get(r)=='ACCEPTED' for r in ('O','S','C','W')),'Actual admitted bootstrap required')
        digest(implementation_digest);exact(witness_verifiers,{'O','L'})
        require(all(callable(v) for v in witness_verifiers.values()) and witness_verifiers['O'] is not witness_verifiers['L'],'Distinct pinned witness seats required')
        require(root._actors==root._roster['actors'],'Sealed roster differs')
        self._root=root;self._epoch=root.authority.generation;self.failed=False;self._verifiers=witness_verifiers.copy()
        self._keys={r:row['key'] for r,row in root.authority._credentials.items()}
        self._profile=dict(protocol='WP06_DEPLOYMENT_V1_ARTIFICIAL',evidence_domain='ARTIFICIAL',run_digest=sha(root.run),manifest_digest=sha(root.manifest),roster_digest=sha(root._roster),
            target_digest=sha(root._target),scope_digest=root.scope_digest,implementation_digest=implementation_digest,budgets=copy.deepcopy(root.budgets),
            actors={r:dict(actor_digest=sha(root._actors[r]),credential_id=root._actors[r]['credential_id'],parent_role=root._actors[r]['parent_role']) for r in ROLES},
            transport='IN_MEMORY_ONLY',effects={k:False for k in ('host_probe','launch','live_control','service_change','stata','participant_processing')})
        self._stamp=self._root_stamp();self.deployment_digest=sha(self._profile);self._tickets={};self._delivered=set();self._accepted=[];self._accepting=False
        self._sequence={r:0 for r in ROLES};self._previous={r:'0'*64 for r in ROLES};self._last_evidence=root._admission['issued_tick']
        self._now()
    def _root_stamp(self):
        r=self._root
        return sha(dict(run=r.run,manifest=r.manifest,roster=r._roster,actors=r._actors,target=r._target,binding=r._binding,budgets=r.budgets,scope=r.scope_digest))
    def _now(self):
        require(not self.failed and not self._root.failed and not self._root.backend.failed,'Deployment contract quarantined')
        require(self._root.authority.authority_current(self._epoch) and self._root_stamp()==self._stamp,'Authority revoked or sealed metadata changed')
        now=self._root.authority.now();require(now<self._profile['budgets']['cleanup_deadline_tick'],'Cleanup ceiling expired')
        return now
    @guarded
    def request(self):return copy.deepcopy(self._profile)
    @guarded
    def validate_request(self,row):
        require(canonical(row)==canonical(self._profile),'Deployment profile mismatch')
        return dict(status='ARTIFICIAL_METADATA_ACCEPTED',host_actions=0)
    @guarded
    def ticket(self,role,expires_tick):
        require(type(role) is str and role in ROLES and role not in self._tickets,'Unknown/consumed handoff allowance')
        now=self._now();integer(expires_tick,True)
        require(now<expires_tick<=self._profile['budgets']['bootstrap_deadline_tick'],'Expired/extended handoff')
        actor=self._profile['actors'][role]
        row=dict(protocol='WP06_HANDOFF_V1_ARTIFICIAL',deployment_digest=self.deployment_digest,role=role,actor_digest=actor['actor_digest'],credential_id=actor['credential_id'],issued_tick=now,expires_tick=expires_tick)
        row['tag']=tag(self._keys['OWNER'],'HANDOFF',row);self._tickets[role]=copy.deepcopy(row)
        return row
    @guarded
    def consume(self,role,row):
        require(type(role) is str and role in self._tickets and role not in self._delivered,'No fresh issued handoff')
        self._delivered.add(role);exact(row,TICKET);now=self._now()
        require(canonical(row)==canonical(self._tickets[role]),'Handoff differs from issued ticket')
        require(now<row['expires_tick'] and now<self._profile['budgets']['bootstrap_deadline_tick'],'Handoff expired')
        body={k:v for k,v in row.items() if k!='tag'}
        require(type(row['tag']) is str and hmac.compare_digest(row['tag'],tag(self._keys['OWNER'],'HANDOFF',body)),'Handoff authentication failed')
        return RoleEndpoint(role,self._profile['actors'][role],self.deployment_digest,self._keys[role],self._now,self._profile['budgets'])
    def _inventory(self,rows,roles):
        exact(rows,set(roles))
        for role,row in rows.items():
            exact(row,{'actor_digest','resources_closed','pending_io','uncertainty'})
            require(row['actor_digest']==self._profile['actors'][role]['actor_digest'] and row['resources_closed'] is True and row['uncertainty'] is False,'Inventory not exact closed captured actor')
            require(type(row['pending_io']) is int and row['pending_io']==0,'Pending/unknown I/O')
    def _payload(self,kind,p):
        previous=sha(self._accepted[-1]) if self._accepted else None
        if kind=='CONTROL_ATTEMPT':
            exact(p,{'slot_digest','delivery_status'});require(p['slot_digest']==sha(self._root._binding) and p['delivery_status']=='ATTEMPTED','Uncertain/wrong control attempt')
        elif kind=='WORKER_APPLICATION':
            exact(p,{'attempt_digest','terminal'});require(p['attempt_digest']==previous and p['terminal']=='STOP_APPLIED','Application not linked to attempt')
        elif kind=='APPLIED_OBSERVATION':
            exact(p,{'worker_evidence_digest','applied'});require(p['worker_evidence_digest']==previous and p['applied'] is True,'No exact applied observation')
        elif kind=='EXIT_OBSERVATION':
            exact(p,{'application_observation_digest','signaled','exit_code'});integer(p['exit_code'])
            require(p['application_observation_digest']==previous and p['signaled'] is True and p['exit_code']<=0xffffffff,'No exact exit observation')
        else:
            link,roles=('exit_evidence_digest',('S','C','W')) if kind=='CLEANUP_OBSERVATION' else ('cleanup_evidence_digest',('O','S','C','W'))
            exact(p,{link,'inventory'});require(p[link]==previous,'Wrong cleanup dependency');self._inventory(p['inventory'],roles)
    @guarded
    def accept(self,row):
        require(not self._accepting,'Reentrant evidence acceptance');self._accepting=True
        row=copy.deepcopy(row);require(len(canonical(row))<=8192,'Oversized direct evidence')
        exact(row,EVIDENCE);require(len(self._accepted)<len(STAGES),'Evidence chain already consumed')
        role,kind=STAGES[len(self._accepted)];actor=self._profile['actors'][role]
        require(role in self._delivered and row['role']==role and row['kind']==kind,'Unissued/wrong role or out-of-order stage')
        require(row['protocol']=='WP06_EVIDENCE_V1_ARTIFICIAL' and row['deployment_digest']==self.deployment_digest and row['actor_digest']==actor['actor_digest'] and row['credential_id']==actor['credential_id'],'Wrong evidence scope/actor')
        require(type(row['sequence']) is int and row['sequence']==self._sequence[role]+1 and row['previous_digest']==self._previous[role],'Evidence replay/gap/genesis mismatch')
        now=self._now();tick=integer(row['tick']);ceiling=self._profile['budgets']['control_deadline_tick' if role in ('S','W') else 'cleanup_deadline_tick']
        require(self._last_evidence<=tick<=now<ceiling,'Expired/future/out-of-order evidence')
        require(type(row['tag']) is str and hmac.compare_digest(row['tag'],tag(self._keys[role],'EVIDENCE',{k:v for k,v in row.items() if k!='tag'})),'Evidence authentication failed')
        self._payload(kind,row['payload'])
        if role in self._verifiers:require(self._verifiers[role](copy.deepcopy(row)) is True,'Independent witness absent/unverified')
        require(self._now()<ceiling,'Evidence phase expired during verification')
        self._accepted.append(copy.deepcopy(row));self._sequence[role]+=1;self._previous[role]=sha(row);self._last_evidence=tick
        self._accepting=False
        return dict(status='ARTIFICIAL_EVIDENCE_CHAIN_ACCEPTED' if len(self._accepted)==6 else 'ARTIFICIAL_EVIDENCE_PREFIX_ACCEPTED',accepted_stages=len(self._accepted),operational_acceptance=False,scientific_acceptance=False,release=False,host_actions=0)

class RoleEndpoint:
    def __init__(self,role,actor,deployment_digest,key,guard,budgets):
        self.role=role;self.actor=copy.deepcopy(actor);self.deployment_digest=deployment_digest;self._key=key;self._guard=guard;self._budgets=copy.deepcopy(budgets)
        self._sequence=0;self._previous='0'*64
    def encode(self,kind,payload):
        now=self._guard();require((self.role,kind) in STAGES,'Unsupported role evidence kind')
        ceiling=self._budgets['control_deadline_tick' if self.role in ('S','W') else 'cleanup_deadline_tick'];require(now<ceiling,'Role evidence ceiling expired')
        row=dict(protocol='WP06_EVIDENCE_V1_ARTIFICIAL',deployment_digest=self.deployment_digest,role=self.role,actor_digest=self.actor['actor_digest'],credential_id=self.actor['credential_id'],kind=kind,
            sequence=self._sequence+1,previous_digest=self._previous,tick=now,payload=copy.deepcopy(payload))
        row['tag']=tag(self._key,'EVIDENCE',row);require(len(canonical(row))<=8192,'Oversized evidence')
        self._sequence+=1;self._previous=sha(row);return row
