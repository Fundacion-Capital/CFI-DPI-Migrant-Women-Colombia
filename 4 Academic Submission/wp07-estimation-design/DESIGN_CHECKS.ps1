# Offline design checks only. This script never calls Stata or reads a dataset.
$ErrorActionPreference = 'Stop'
$manifest = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'ESTIMATION_MANIFEST.json') -Raw | ConvertFrom-Json
$mapping = @(Import-Csv -LiteralPath (Join-Path $PSScriptRoot 'FIELD_GROUPINGS.csv'))
$checks = [Collections.Generic.List[string]]::new()
if ($manifest.scientific_adoption -or $manifest.current_authority.participant_loads -ne 0 -or
    $manifest.current_authority.participant_fits -ne 0 -or $manifest.current_authority.artificial_fits -ne 0) {
    throw 'The design must not grant scientific adoption or execution.'
}
$checks.Add('No execution/adoption authority created')
if (@($manifest.models).Count -ne 5 -or $manifest.operation_ceiling.fits -ne 5) { throw 'Five-fit ceiling differs.' }
$expectedIds = @('R0_E4','D0_E4','R1_E4','D1_E4','R0C_E4')
if (($manifest.models.id -join '|') -ne ($expectedIds -join '|')) { throw 'Named fit sequence differs.' }
$terms = 'c.wp07_iat3 c.wp07_iadt2 c.wp07_iaff2 c.q4 ib2.e4_education3 ib1.e4_residence4'
foreach ($model in $manifest.models) {
    $extension = ''
    if ($model.id -in @('R1_E4','D1_E4')) { $extension = ' ib3.e4_occupation6 c.q2_1' }
    $expected = "logit $($model.outcome) $terms$extension if $($model.mask), vce(robust) iterate(100) level(95)"
    if ($model.command -cne $expected -or $model.maximum_attempts -ne 1 -or $model.retries -ne 0) {
        throw "Unexpected command or attempt budget: $($model.id)"
    }
    if ($model.command -match 'asis|stepwise|bootstrap|cluster|pweight|force') { throw 'Unapproved estimator option.' }
}
$checks.Add('Five exact commands, one attempt each, no fallback')
$specs = @(
    @{source='q2_2'; target='e4_education3'; codes=1..10; values=@(1,1,1,1,2,3,3,3,3,3)},
    @{source='wp07_residence'; target='e4_residence4'; codes=1..6; values=@(1,2,3,4,4,4)},
    @{source='q2_3'; target='e4_occupation6'; codes=1..9; values=@(1,1,3,4,5,5,7,5,9)}
)
foreach ($spec in $specs) {
    $rows = @($mapping | Where-Object source_field -eq $spec.source | Sort-Object { [int]$_.source_code })
    if ($rows.Count -ne $spec.codes.Count) { throw 'Incomplete mapping.' }
    for ($i=0; $i -lt $rows.Count; $i++) {
        if ([int]$rows[$i].source_code -ne $spec.codes[$i] -or
            [int]$rows[$i].proposed_code -ne $spec.values[$i] -or
            $rows[$i].proposed_field -ne $spec.target) { throw 'Mapping differs from reviewed design.' }
    }
}
if ($mapping.Count -ne 25) { throw 'Unexpected mapping size.' }
$checks.Add('All 25 category mappings total, unique and source-preserving')
$slots = @($manifest.primary_slots)
if ($slots.Count -ne 6 -or ($slots.slot_id -join '|') -ne 'R_IAT|R_IADT|R_IAFF|D_IAT|D_IADT|D_IAFF') {
    throw 'Primary family changed.'
}
foreach ($slot in $slots) {
    if ($slot.model_id -notin @('R0_E4','D0_E4') -or $null -ne $slot.raw_p -or $null -ne $slot.adjusted_p -or
        $slot.command -ne "test $($slot.field)") { throw 'Primary test is not an uncomputed core coefficient test.' }
}
if ($manifest.multiplicity.m -ne 6 -or $manifest.multiplicity.nominal_alpha -ne .05) { throw 'Family constant differs.' }
$checks.Add('Six uncomputed core coefficient-null slots retained')
$ops = @($manifest.probability_operations)
if ($ops.Count -ne 15 -or @($ops.operation_id | Select-Object -Unique).Count -ne 15) { throw 'Margins operation count differs.' }
foreach ($model in $manifest.models) {
    foreach ($contrast in $manifest.contrasts) {
        $op = @($ops | Where-Object { $_.model_id -eq $model.id -and $_.contrast_id -eq $contrast.id })
        $lo = $contrast.lower.ToString([cultureinfo]::InvariantCulture)
        $hi = $contrast.higher.ToString([cultureinfo]::InvariantCulture)
        $expected = "margins, at($($contrast.field)=($lo $hi)) predict(pr) vce(delta) level(95) pwcompare(effects) mcompare(noadjust)"
        if ($op.Count -ne 1 -or $op[0].command -cne $expected -or
            $op[0].restore -ne "estimates restore $($model.id)" -or $op[0].command -match 'atmeans|noesample|force|noestimcheck| post') {
            throw 'Unexpected probability averaging or state handling.'
        }
    }
}
$expectedContrasts = @('wp07_iat3|0.5|0.75','wp07_iadt2|0.5|0.75','wp07_iaff2|0.5|1')
for ($i=0; $i -lt 3; $i++) {
    $c = $manifest.contrasts[$i]
    $s = $c.field+'|'+$c.lower.ToString([cultureinfo]::InvariantCulture)+'|'+$c.higher.ToString([cultureinfo]::InvariantCulture)
    if ($s -ne $expectedContrasts[$i]) { throw 'Fixed contrast differs.' }
}
$checks.Add('Fifteen model/contrast operations, fixed endpoints and no at-means default')
if ($manifest.contrast_support.exact_endpoint_minimum_observed_n -ne 1 -or
    -not $manifest.contrast_support.requires_both_named_endpoints -or
    $manifest.contrast_support.automatic_endpoint_substitution -or
    $manifest.contrast_support.retain_endpoint_by_outcome_counts -ne 'restricted_only' -or
    $manifest.contrast_support.on_missing_endpoint -notmatch 'do_not_block_otherwise_estimable_coefficient_test') {
    throw 'Exact endpoint support/unavailable-contrast rule differs.'
}
# These arrays are artificial p-values, not estimates or study participant data.
$fixtures = @(
    @{p=@(.001,.01,.02,.04,.2,.8); expected=@(.006,.05,.08,.12,.4,.8)},
    @{p=@(.001,.01,$null,.04,.2,.8); expected=@(.006,.05,$null,.16,.6,1)},
    @{p=@(.01,.01,.01,.5,.9,1); expected=@(.06,.06,.06,1,1,1)},
    @{p=@($null,$null,$null,$null,$null,$null); expected=@($null,$null,$null,$null,$null,$null)},
    @{p=@(0,$null,1,$null,$null,$null); expected=@(0,$null,1,$null,$null,$null)}
)
foreach ($fixture in $fixtures) {
    $available = @(for ($i=0; $i -lt 6; $i++) {
        if ($null -ne $fixture.p[$i]) { [pscustomobject]@{index=$i; p=$fixture.p[$i]} }
    })
    $ordered = @($available | Sort-Object p,index)
    $adjusted = @($null,$null,$null,$null,$null,$null)
    $running = 0.0
    for ($i=0; $i -lt $ordered.Count; $i++) {
        $running = [math]::Min(1.0,[math]::Max($running,(6-$i)*$ordered[$i].p))
        $adjusted[$ordered[$i].index] = $running
    }
    for ($i=0; $i -lt 6; $i++) {
        if ($null -eq $fixture.expected[$i]) {
            if ($null -ne $adjusted[$i]) { throw 'An unavailable test acquired a p-value.' }
        } elseif ($null -eq $adjusted[$i] -or [math]::Abs($adjusted[$i]-$fixture.expected[$i]) -gt 1e-12) {
            throw "Fixed-six Holm fixture failed: index=$i expected=$($fixture.expected[$i]) actual=$($adjusted[$i])"
        }
    }
}
$checks.Add('Five artificial Holm fixtures: complete, unavailable, tied, all unavailable, boundaries')
# A singleton indicator permits an improving likelihood path for either binary outcome.
foreach ($y in 0,1) {
    $p0 = .5
    $p1 = 1/(1+[math]::Exp(-((2*$y-1)*20)))
    $l0 = $y*[math]::Log($p0)+(1-$y)*[math]::Log(1-$p0)
    $l1 = $y*[math]::Log($p1)+(1-$y)*[math]::Log(1-$p1)
    if ($l1 -le $l0) { throw 'Singleton-direction fixture failed.' }
}
$checks.Add('Artificial singleton likelihood-direction check for both binary outcomes')
if ($manifest.execution_envelope.hard_kill_guarantee -or $manifest.execution_envelope.participant_dataset_exports -or
    $manifest.execution_envelope.participant_predictions -or $manifest.current_authority.commit -or
    $manifest.current_authority.push -or $manifest.current_authority.overleaf_sync -or
    $manifest.excluded -notcontains 'C2') { throw 'Boundary differs.' }
$checks.Add('No native/participant execution, hard-kill promise, release or C2 authority')
[pscustomobject]@{result='PASS_OFFLINE_DESIGN_ONLY'; check_groups=$checks.Count; checks=@($checks);
    native_execution=0; participant_loads=0; fits=0; native_syntax_tested=$false} | ConvertTo-Json -Depth 4

