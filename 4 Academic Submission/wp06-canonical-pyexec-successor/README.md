# WP06 — disabled canonical Python handoff successor

V6 is an additive, disabled candidate. It changes one loader input: the value passed through the pinned PyStata `-pyexec` resolver. It does not alter the worker launch, SDK client, Python distribution, DLL directory, environment, `sys.executable`, prefixes, vendor files, timing, containment, or SFI acceptance.

The temporary wrapper requires the exact bound launch spelling. It resolves it to the pinned canonical image and checks size and SHA-256 on the opened executable before forwarding the canonical string. Unexpected, missing, or changed inputs fail closed. The original resolver and initializer are restored. The versioned `WP06_BOOTSTRAP_RETURN_V2` record keeps the original, resolved and forwarded strings distinct and retains the actual integer return when observed. It remains diagnostic evidence, not positive SFI proof. Earlier V1 records are not reinterpreted.

The prior −7100 result remains failed. Artificial tests prove the argument and evidence behavior, not that native discovery succeeds or why it previously failed. No native launch, settings change, participant processing, or execution grant is part of this package.

Any later native comparison requires a fresh source-exact checkpoint and separate authorization. If the canonical handoff still returns −7100, stop rather than layering another loader tweak without evidence of the actual failed lookup.
