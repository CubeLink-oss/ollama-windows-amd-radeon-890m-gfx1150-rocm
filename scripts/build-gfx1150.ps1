param(
    [string]$OllamaSource = "C:\ollama",
    [string]$RocmBin = "C:\Program Files\AMD\ROCm\6.4\bin",
    [int]$Parallel = 8
)

$ErrorActionPreference = "Stop"

if (!(Test-Path $OllamaSource)) {
    git clone https://github.com/ollama/ollama.git $OllamaSource
}

Set-Location $OllamaSource

$presetPath = Join-Path $OllamaSource "CMakePresets.json"
$json = Get-Content $presetPath -Raw | ConvertFrom-Json
$preset = $json.configurePresets | Where-Object { $_.name -eq "ROCm 6" }
if (!$preset) {
    throw "Could not find the 'ROCm 6' preset in CMakePresets.json"
}

$preset.cacheVariables.AMDGPU_TARGETS = "gfx1150"
$json | ConvertTo-Json -Depth 20 | Set-Content $presetPath -Encoding UTF8

$env:Path = "$RocmBin;$env:Path"
$env:OLLAMA_BUILD_PARALLEL = "$Parallel"

powershell -ExecutionPolicy Bypass -File .\scripts\build_windows.ps1 clean cpu rocm6 ollama zip

Write-Host ""
Write-Host "Build complete. Check:"
Write-Host "  $OllamaSource\dist\windows-amd64\ollama.exe"
Write-Host "  $OllamaSource\dist\ollama-windows-amd64-rocm.zip"

