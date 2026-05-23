param(
    [string]$OllamaDir = "C:\ollama\dist\windows-amd64",
    [string]$RocmBin = "C:\Program Files\AMD\ROCm\6.4\bin",
    [string]$HostAddress = "127.0.0.1:11434"
)

$ErrorActionPreference = "Stop"

Set-Location $OllamaDir

$env:Path = "$OllamaDir\lib\ollama\rocm;$OllamaDir\lib\ollama;$RocmBin;$env:Path"
$env:ROCR_VISIBLE_DEVICES = "0"
$env:OLLAMA_DEBUG = "1"
$env:OLLAMA_HOST = $HostAddress

.\ollama.exe serve

