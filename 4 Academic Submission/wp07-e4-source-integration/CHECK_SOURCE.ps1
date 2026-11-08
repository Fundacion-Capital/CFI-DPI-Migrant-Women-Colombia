# Source-only checks: no Stata, dataset, process-launch or model execution.
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$code = Join-Path $repo '1 Code/academic'
$preparation = Get-Content -LiteralPath (Join-Path $code '1 Data preparation.do') -Raw
$analysis = Get-Content -LiteralPath (Join-Path $code '2 Analysis.do') -Raw
$master = Get-Content -LiteralPath (Join-Path $code '0 Master.do') -Raw
$accepted = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'OWNER_ACCEPTANCE.json') -Raw | ConvertFrom-Json
$design = Get-Content -LiteralPath (Join-Path $repo '4 Academic Submission/wp07-estimation-design/ESTIMATION_MANIFEST.json') -Raw | ConvertFrom-Json
if (-not $accepted.authority.source_integration -or $accepted.authority.Stata_execution -or
    $accepted.authority.participant_loads -ne 0 -or $accepted.authority.C2 -ne 'HOLD') { throw 'Authority mismatch.' }
foreach ($name in '0 Master.do','1 Data preparation.do','2 Analysis.do') {
    if ((Get-Content -LiteralPath (Join-Path $code $name))[6].Trim() -ne 'exit 198') { throw "Entry hold changed: $name" }
}
if ($preparation -notmatch '(?m)^\* BEGIN E4 GROUPINGS$' -or $analysis -notmatch '(?m)^\* BEGIN E4 ESTIMATION$') {
    throw 'Approved source integration is absent.'
}
$group = ($preparation -split '\* BEGIN E4 GROUPINGS',2)[1] -split '\* END E4 GROUPINGS',2 | Select-Object -First 1
$fit = ($analysis -split '\* BEGIN E4 ESTIMATION',2)[1] -split '\* END E4 ESTIMATION',2 | Select-Object -First 1
$holm = ($analysis -split '\* BEGIN E4 HOLM',2)[1] -split '\* END E4 HOLM',2 | Select-Object -First 1
if ($analysis -notmatch 'exit 198\r?\n\* BEGIN E4 ESTIMATION') { throw 'Independent estimation stop missing.' }
if ($group -match '(?m)^\s*(drop|keep|use|save|merge|append|replace q[0-9]|replace wp07_)') { throw 'Grouping modifies original data.' }
foreach ($line in @('replace e4_education3 = 1 if inrange(q2_2, 1, 4) & wp07_state_q2_2 == 1',
    'replace e4_education3 = 2 if q2_2 == 5 & wp07_state_q2_2 == 1',
    'replace e4_education3 = 3 if inrange(q2_2, 6, 10) & wp07_state_q2_2 == 1',
    'replace e4_residence4 = wp07_residence if inlist(wp07_residence, 1, 2, 3)',
    'replace e4_residence4 = 4 if inlist(wp07_residence, 4, 5, 6)',
    'replace e4_occupation6 = 1 if inlist(q2_3, 1, 2) & wp07_state_q2_3 == 1',
    'replace e4_occupation6 = 3 if q2_3 == 3 & wp07_state_q2_3 == 1',
    'replace e4_occupation6 = 4 if q2_3 == 4 & wp07_state_q2_3 == 1',
    'replace e4_occupation6 = 5 if inlist(q2_3, 5, 6, 8) & wp07_state_q2_3 == 1',
    'replace e4_occupation6 = 7 if q2_3 == 7 & wp07_state_q2_3 == 1',
    'replace e4_occupation6 = 9 if q2_3 == 9 & wp07_state_q2_3 == 1')) {
    if (-not $group.Contains($line)) { throw "Mapping differs: $line" }
}
# Continuations and capture/noisily prefixes do not change the estimator command.
$normal = $fit -replace '///\r?\n\s*',' '
$found = @([regex]::Matches($normal,'(?m)^\s*capture noisily (logit [^\r\n]+)') | ForEach-Object { $_.Groups[1].Value.Trim() -replace '\s+',' ' })
if ($found.Count -ne 5) { throw 'The source does not contain exactly five estimator commands.' }
for ($i=0; $i -lt 5; $i++) {
    if ($found[$i] -cne $design.models[$i].command) { throw "Estimator differs from adopted command: $i" }
}
if ($fit -match '(?m)^\s*(use |save |predict |correlate |bootstrap |program define |mata|clear|preserve|restore$)') {
    throw 'Unapproved operation in estimation block.'
}
if ($fit -match 'noestimcheck|noesample|vce\(cluster|asis|stepwise|firthlogit') { throw 'Unapproved override/fallback.' }
foreach ($c in $design.contrasts) {
    $lo=$c.lower.ToString([cultureinfo]::InvariantCulture); $hi=$c.higher.ToString([cultureinfo]::InvariantCulture)
    $cmd="margins, at($($c.field)=($lo $hi)) predict(pr) vce(delta) level(95) pwcompare(effects) mcompare(noadjust)"
    if (-not ($normal -replace '\s+',' ').Contains($cmd)) { throw 'Fixed contrast changed.' }
}
if ($holm -notmatch '7 - rank' -or $holm -notmatch 'sort p_raw slot' -or $holm -notmatch 'p_holm\[_n - 1\]' -or
    $holm -match 'count if !missing|r\(N\)') { throw 'Fixed-six Holm formula changed.' }
foreach ($token in @('e(sample)','e(converged)','e(rank)','e(N_cds)','e(N_cdf)','rownumb(e4_MT, "b")',
    'r(table_vs)','r(error_vs)','r(L)','estimates restore','frame post','if !missing(p_raw)')) {
    if (-not $fit.Contains($token)) { throw "Native receipt/guard missing: $token" }
}
$unbalanced = 0
foreach ($line in ($fit -split '\r?\n')) {
    $s=$line.Trim()
    if ($s.StartsWith('*')) {continue}
    if ($s.EndsWith('{')) {$unbalanced++}
    if ($s -eq '}') {$unbalanced--}
    if ($unbalanced -lt 0) {throw 'Unexpected closing brace.'}
}
if ($unbalanced -ne 0) {throw 'Unbalanced native blocks.'}
$nativePlan = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'NATIVE_VALIDATION_PLAN.json') -Raw | ConvertFrom-Json
if ($nativePlan.authority.native_execution -or $nativePlan.authority.participant_loads -ne 0 -or
    $nativePlan.cases.Count -ne 10 -or ($nativePlan.cases | Measure-Object maximum_fits -Sum).Sum -ne 7) {
    throw 'Native validation scope differs.'
}
foreach ($block in $nativePlan.source_blocks) {
    $path=Join-Path $repo $block.path
    if ((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLower() -ne $block.file_sha256) {
        throw "Stale native whole-file binding: $($block.id)"
    }
    $lines=[IO.File]::ReadAllLines($path)
    if ($lines[$block.line_start-2].Trim() -cne $block.start_marker -or
        $lines[$block.line_end].Trim() -cne $block.end_marker) { throw 'Native line boundary shifted.' }
    $text=($lines[($block.line_start-1)..($block.line_end-1)] -join "`n")+"`n"
    $hash=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($text))).ToLower()
    if ($hash -ne $block.text_sha256) { throw 'Stale native block binding.' }
}
[pscustomobject]@{result='PASS_SOURCE_ONLY';guards=3;estimation_stop=$true;mapping_source_codes=25;
    estimator_commands=$found.Count;probability_commands=3;maximum_probability_calls=15;primary_slots=6;
    native_executions=0;participant_loads=0;native_syntax_tested=$false} | ConvertTo-Json

