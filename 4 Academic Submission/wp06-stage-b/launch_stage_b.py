"""Deny-by-default entry and bounded artificial bootstrap orchestration.

No real launcher/provider or live work loop is adopted by this build.
"""
import copy
import json
from journal_protocol import admit_phase,validate_binding,require,sha

def plan_launch(case_id,decisions,expected_scope,verify_decision):
    result=dict(case_id=case_id,eligible=False,evidence_domain='ARTIFICIAL',build_digest=None,scope_digest=None,manifest_digest=None,actor_specs={},cases_executed=0)
    try:
        require(case_id in {'AC'+str(i) for i in range(17,23)},'Unknown case')
        admission=admit_phase('QUIESCENT_BOOTSTRAP',decisions,[],expected_scope,verify_decision)
        require(admission['eligible'],'No bootstrap authority')
        specs=expected_scope['actor_specs'];require(type(specs) is dict and set(specs)=={'O','S','C','W'},'Exact actor manifest required')
        for spec in specs.values():require(validate_binding(spec['binding'])==expected_scope['binding'],'Unapproved actor binding')
        result.update(eligible=True,build_digest=expected_scope['build_digest'],scope_digest=expected_scope['scope_digest'],manifest_digest=sha(specs),actor_specs=copy.deepcopy(specs))
    except (ValueError,KeyError,TypeError):pass
    return result
def run_authorized_case(plan,bridge,clock):
    result=dict(status='HOLD_PRESERVED',evidence_domain='ARTIFICIAL',created=[],work_dispatched=False,cases_executed=0,termination_authorized=False)
    try:
        scope=bridge._admit('QUIESCENT_BOOTSTRAP')
        require(plan['eligible'] is True and plan['evidence_domain']=='ARTIFICIAL' and plan['case_id']==bridge._case,'Wrong/unadmitted plan')
        require(plan['build_digest']==scope['build_digest'] and plan['scope_digest']==scope['scope_digest'] and plan['manifest_digest']==sha(plan['actor_specs'])==sha(scope['actor_specs']),'Changed build/manifest')
        require(clock is bridge._clock and bridge._owner=='L','Pinned clock/external launcher required')
        result['created'].append(bridge.bootstrap('O',plan['actor_specs']['O'])['token'])
        observer=bridge.for_owner('O')
        result['created'].append(observer.bootstrap('S',plan['actor_specs']['S'])['token'])
        result['created'].append(observer.bootstrap('C',plan['actor_specs']['C'])['token'])
        supervisor=observer.for_owner('S');result['created'].append(supervisor.bootstrap('W',plan['actor_specs']['W'])['token'])
        # Quiescent initialization never credits work or fabricated prearm evidence.
        result['status']='ARTIFICIAL_BOOTSTRAP_ONLY'
    except (ValueError,KeyError,TypeError,AttributeError):result['failure']='BOOTSTRAP_OR_ADMISSION_UNCERTAIN_NO_RETRY'
    return result
def main(argv):
    print(json.dumps(dict(status='BLOCKED_NO_RUNTIME_PROVIDER_OR_GRANT',cases_executed=0,arguments_accepted=False)))
    return 2
if __name__=='__main__':
    import sys
    raise SystemExit(main(sys.argv[1:]))
