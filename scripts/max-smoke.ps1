# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
#
# Windows counterpart of max-smoke.sh. UNTESTED: written without access to a Windows machine.
#
#   scripts\max-smoke.ps1 [-OddPath] [-NoLoader] -PatcherDir <dir with smoke.maxpat and smoke.js> -Expected "<line>"
#
# Copies package\Jamoma to a staging folder, links it into %USERPROFILE%\Documents\Max 9\Packages\Jamoma with a
# junction (no administrator rights needed; removed afterwards), launches Max with the patcher, waits for the
# result file, and requires Max to quit by itself with exit code 0.
#   -OddPath    stage the package under a path with spaces and a non-ASCII character
#   -NoLoader   remove j.loader from the staged package
param(
    [switch]$OddPath,
    [switch]$NoLoader,
    [Parameter(Mandatory = $true)][string]$PatcherDir,
    [Parameter(Mandatory = $true)][string]$Expected
)
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$maxExe = "C:\Program Files\Cycling '74\Max 9\Max.exe"
$packages = Join-Path $env:USERPROFILE "Documents\Max 9\Packages"
$link = Join-Path $packages "Jamoma"

if (Get-Process -Name "Max" -ErrorAction SilentlyContinue) { Write-Error "Max is already running; quit it first"; exit 2 }
if (Test-Path $link) { Write-Error "$link already exists; not touching it"; exit 2 }

$work = Join-Path ([System.IO.Path]::GetTempPath()) ("jamoma-smoke-" + [guid]::NewGuid())
New-Item -ItemType Directory $work | Out-Null
$stageRoot = if ($OddPath) { Join-Path $env:USERPROFILE "Documents\Jamoma smoke Åpen\Packages-target" } else { Join-Path $work "stage" }
New-Item -ItemType Directory -Force $stageRoot | Out-Null
Copy-Item -Recurse (Join-Path $root "package\Jamoma") (Join-Path $stageRoot "Jamoma")
if ($NoLoader) { Get-ChildItem (Join-Path $stageRoot "Jamoma\extensions") -Filter "j.loader.*" | Remove-Item -Force }

$result = Join-Path $work "result.txt"
(Get-Content (Join-Path $PatcherDir "smoke.js") -Raw).Replace("@RESULT@", ($result -replace "\\", "/")) | Set-Content (Join-Path $work "smoke.js") -Encoding UTF8
Copy-Item (Join-Path $PatcherDir "smoke.maxpat") (Join-Path $work "smoke.maxpat")

$status = 0
try {
    New-Item -ItemType Junction -Path $link -Target (Join-Path $stageRoot "Jamoma") | Out-Null
    $proc = Start-Process -FilePath $maxExe -ArgumentList ('"' + (Join-Path $work "smoke.maxpat") + '"') -PassThru
    $deadline = (Get-Date).AddSeconds(60)
    while (-not (Test-Path $result) -and (Get-Date) -lt $deadline) { Start-Sleep -Milliseconds 500 }
    $got = if (Test-Path $result) { (Get-Content $result -TotalCount 1).Trim() } else { "" }
    $exited = $proc.WaitForExit(20000)
    if ($got -ne $Expected) { Write-Output "FAIL: result '$got', expected '$Expected'"; $status = 1 }
    if (-not $exited) { Write-Output "FAIL: Max did not quit by itself"; $status = 1 }
    elseif ($proc.ExitCode -ne 0) { Write-Output "FAIL: Max exit code $($proc.ExitCode)"; $status = 1 }
    if ($status -eq 0) { Write-Output "PASS: '$got', exit 0" }
}
finally {
    if ($proc -and -not $proc.HasExited) { $proc.Kill() }
    if (Test-Path $link) { (Get-Item $link).Delete() }
    if ($OddPath) { Remove-Item -Recurse -Force (Join-Path $env:USERPROFILE "Documents\Jamoma smoke Åpen") -ErrorAction SilentlyContinue }
    Remove-Item -Recurse -Force $work -ErrorAction SilentlyContinue
}
exit $status
