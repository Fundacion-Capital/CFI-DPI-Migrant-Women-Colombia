# Offline checks only: never open the carrier or call Stata.
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$repo = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$scope = Get-Content -Raw -LiteralPath (Join-Path $PSScriptRoot 'EXECUTION_SCOPE.json') | ConvertFrom-Json
$prior = Get-Content -Raw -LiteralPath (Join-Path $repo '4 Academic Submission/wp07-restricted-coverage/SCOPE.json') | ConvertFrom-Json
foreach ($pin in @($scope.source_bindings.canonical) + @($scope.source_bindings.private_payloads) + @($scope.denominator_reference)) {
    $file = Join-Path $repo $pin.path
    if ((Get-Item -LiteralPath $file).Length -ne $pin.bytes) { throw "Size mismatch: $($pin.path)" }
    if ((Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash.ToLower() -ne $pin.sha256) { throw "Source mismatch: $($pin.path)" }
}
if (($scope.carrier.projection -join ' ') -ne ($prior.prepared_fields -join ' ')) { throw 'Projection differs from E3' }
if ($scope.carrier.projection.Count -ne 98 -or @($scope.carrier.projection | Sort-Object -Unique).Count -ne 98) { throw 'Projection is not exactly 98 unique fields' }
if (($scope.carrier.string_parents -join ' ') -ne ($prior.string_parents -join ' ')) { throw 'Mixed-type parents changed' }
$prepLines = [IO.File]::ReadAllLines((Join-Path $repo $scope.source_bindings.preparation.path))
$expectedPrep = (($prepLines | Select-Object -Skip 8) -join "`n").TrimEnd() + "`n"
$copyPrep = [IO.File]::ReadAllText((Join-Path $repo $scope.source_bindings.preparation.copy))
if ($expectedPrep -cne $copyPrep) { throw 'Preparation copy differs from current body' }
if (@([regex]::Matches($copyPrep, '\* BEGIN E4 GROUPINGS')).Count -ne 1) { throw 'Groupings not present exactly once' }
$modelBinding = $scope.source_bindings.model
$modelLines = [IO.File]::ReadAllLines((Join-Path $repo $modelBinding.path))
if ($modelLines[$modelBinding.args_line - 1] -cne 'args e4_output') { throw 'Canonical argument line changed' }
$body = ($modelLines[($modelBinding.body_lines[0]-1)..($modelBinding.body_lines[1]-1)] -join "`n") + "`n"
$copyModel = [IO.File]::ReadAllText((Join-Path $repo $modelBinding.copy))
if ($copyModel -cne ("args e4_output`n" + $body)) { throw 'Model copy/argument scope changed' }
$wrapperPin = $scope.source_bindings.private_payloads | Where-Object { $_.path -like '*/Run restricted E4.do' }
$wrapper = [IO.File]::ReadAllText((Join-Path $repo $wrapperPin.path))
$projection = [regex]::Match($wrapper, '(?ms)^\s*use\s+///\s*(.*?)\s+using "').Groups[1].Value.Replace('///','').Trim() -split '\s+'
if (($projection -join ' ') -cne ($prior.prepared_fields -join ' ')) { throw 'Caller differs from 98-field projection' }
if (@([regex]::Matches($wrapper, '(?m)^\s*use\s+')).Count -ne 1) { throw 'Caller load count is not one' }
if (@([regex]::Matches($wrapper, '(?m)^\s*quietly do "')).Count -ne 2) { throw 'Expected two exact source do-file boundaries' }
if (@([regex]::Matches($wrapper, '(?m)^\s*(?:quietly )?log query _all\s*$')).Count -ne 1) { throw 'Reserved _all token changed' }
if ($wrapper -match '(?m)^\s*(?:capture |quietly |noisily )*(?:list|browse|save|export|regress|logit|margins|python|shell)\b') { throw 'Unexpected caller operation' }
if ($scope.models.Count -ne 5 -or $scope.model_order.Count -ne 5 -or ($scope.model_order -join ' ') -cne 'R0_E4 D0_E4 R1_E4 D1_E4 R0C_E4' -or ($scope.models.id -join ' ') -cne ($scope.model_order -join ' ')) { throw 'Named model order changed' }
$modelCommands = ($copyModel.Replace('///','') -replace '\s+',' ')
foreach ($model in $scope.models) {
    if (!$modelCommands.Contains($model.command)) { throw "Model command differs from source: $($model.id)" }
}
if ($scope.fit_ceiling -ne 5 -or @($scope.models | Where-Object { $_.maximum_attempts -ne 1 -or $_.retries -ne 0 }).Count -ne 0) { throw 'Fit ceiling changed' }
if ($scope.primary_slots.Count -ne 6 -or $scope.multiplicity.m -ne 6 -or $scope.probability_policy.commands.Count -ne 15) { throw 'Test/contrast scope changed' }
if (($scope.denominator_reference.matches.model -join ' ') -cne ($scope.model_order -join ' ')) { throw 'Denominator reference model mapping changed' }
if (($scope.denominator_reference.matches.nomination -join ' ') -cne 'R0 D0 R1 D1 COMMON' -or ($scope.denominator_reference.matches.check_id -join ' ') -cne 'domain_valid_inputs domain_valid_inputs domain_valid_inputs domain_valid_inputs core_common_inputs') { throw 'Denominator selectors changed' }
if ($scope.denominator_reference.value_column -cne 'observed_n' -or $scope.denominator_reference.comparison_target.column -cne 'intended_n' -or $scope.denominator_reference.expected_records_per_selector -ne 1) { throw 'Denominator value/cardinality changed' }
if ($scope.proposed_execution.carrier_loads_ceiling -ne 1 -or $scope.proposed_execution.tool_calls_ceiling -ne 1 -or $scope.proposed_execution.retries -ne 0 -or $scope.proposed_execution.timeout_seconds -ne 60) { throw 'Execution limits changed' }
if ($scope.current_authority.participant_loads -ne 0 -or $scope.current_authority.participant_fits -ne 0 -or $scope.current_authority.Stata_selections -ne 0 -or $scope.proposed_execution.current_release -ne $false) { throw 'Execution authority must remain absent' }
foreach ($item in $scope.outputs.files) {
    if (Test-Path -LiteralPath (Join-Path $scope.outputs.absolute_directory $item.name)) { throw "Output collision: $($item.name)" }
}
foreach ($name in 'e4_restricted.log','scope_complete.txt') {
    if (Test-Path -LiteralPath (Join-Path $scope.outputs.absolute_directory $name)) { throw "Output collision: $name" }
}
$selection = [IO.File]::ReadAllText((Join-Path $repo $scope.proposed_execution.selection_file))
if ($selection -notmatch '(?m)^capture quietly do "' -or $selection.Length -gt 2048) { throw 'Fixed-file quiet selection changed' }
foreach ($pin in $scope.source_bindings.canonical) {
    if (([IO.File]::ReadAllLines((Join-Path $repo $pin.path)))[6] -cne 'exit 198') { throw "Hold changed: $($pin.path)" }
}
[ordered]@{result='PASS_SCOPE_SOURCE_ONLY';projection_fields=98;strings=6;groupings_copies=1;named_models=5;maximum_future_attempts=5;current_native_selections=0;current_participant_loads=0;current_fits=0;new_wrapper_natively_validated=$false;C2='HOLD'} | ConvertTo-Json
