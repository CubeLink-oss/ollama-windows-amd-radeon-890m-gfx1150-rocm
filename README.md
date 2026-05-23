# Ollama for AMD Radeon 890M gfx1150 on Windows 11 with ROCm HIP

Unofficial Windows build notes and binaries for running Ollama with AMD ROCm/HIP acceleration on the AMD Radeon 890M iGPU, RDNA 3.5, `gfx1150`.

This repo documents a working build of Ollama for:

- Windows 11 Pro for Workstations
- AMD Radeon 890M Graphics
- ROCm/HIP SDK 6.4.2 for Windows
- Ollama source commit `275f122c`
- Ollama version string `0.25.0-rc0-8-g275f122-dirty`
- AMDGPU target `gfx1150`

The release zip is intended for people searching for:

- Ollama AMD Radeon 890M Windows
- Ollama gfx1150 ROCm Windows
- Ollama AMD 890M HIP SDK
- Ollama RDNA 3.5 Windows ROCm
- Ollama Ryzen AI HX 370 Radeon 890M

## Status

The build was tested locally on Windows 11 with an AMD Radeon 890M.

Successful runtime log lines:

```text
description="AMD Radeon(TM) 890M Graphics" compute=gfx1150
library=ROCm compute=gfx1150
loaded ROCm backend ... ggml-hip.dll
Device 0: AMD Radeon(TM) 890M Graphics, gfx1150
offloaded 37/37 layers to GPU
```

Test model:

```text
qwen2.5:3b
```

The model successfully generated `OK` through Ollama's HTTP API.

## Download

See GitHub Releases and download:

```text
ollama-windows-amd64-rocm-gfx1150-radeon-890m.zip
```

SHA256:

```text
C46F19F666D3A098E2991CCBF8CE3C72474B112B95415F5655B2D7C4E75D78E0
```

## Quick Start

Extract the release zip, then run PowerShell from the extracted folder:

```powershell
$env:Path = "$PWD\lib\ollama\rocm;$PWD\lib\ollama;C:\Program Files\AMD\ROCm\6.4\bin;$env:Path"
$env:ROCR_VISIBLE_DEVICES = "0"
$env:OLLAMA_DEBUG = "1"
.\ollama.exe serve
```

In a second PowerShell window:

```powershell
.\ollama.exe list
.\ollama.exe run qwen2.5:3b "Reply with exactly: OK"
```

Watch the server log for:

```text
library=ROCm compute=gfx1150
offloaded ... layers to GPU
```

## Build From Source

Install dependencies:

```powershell
winget install -e --id GoLang.Go
winget install -e --id Git.Git
winget install -e --id Kitware.CMake
winget install -e --id GitHub.cli
winget install -e --id JRSoftware.InnoSetup
winget install -e --id Microsoft.VisualStudio.2022.BuildTools --override "--quiet --wait --norestart --nocache --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"
winget install -e --id MartinStorsjo.LLVM-MinGW.UCRT
```

Install AMD HIP SDK 6.4.2 for Windows. AMD currently packages this as:

```text
AMD-Software-PRO-Edition-25.Q3-Win10-Win11-For-HIP.exe
```

Expected HIP path:

```text
C:\Program Files\AMD\ROCm\6.4\bin
```

Clone and patch Ollama:

```powershell
git clone https://github.com/ollama/ollama.git C:\ollama
cd C:\ollama
```

Edit `CMakePresets.json` and set the `ROCm 6` preset:

```json
"AMDGPU_TARGETS": "gfx1150"
```

Build:

```powershell
cd C:\ollama
$env:Path = "C:\Program Files\AMD\ROCm\6.4\bin;$env:Path"
$env:OLLAMA_BUILD_PARALLEL = "8"
powershell -ExecutionPolicy Bypass -File .\scripts\build_windows.ps1 clean cpu rocm6 ollama zip
```

Expected outputs:

```text
C:\ollama\dist\windows-amd64\ollama.exe
C:\ollama\dist\ollama-windows-amd64-rocm.zip
C:\ollama\dist\ollama-windows-amd64.zip
```

## Notes About the GUI

The tested release focuses on `ollama.exe`, the CLI/server/runtime. Ollama's Windows GUI is a separate target named `app`, producing:

```text
C:\ollama\dist\windows-ollama-app-amd64.exe
```

The installer target then packages it as:

```text
C:\ollama\dist\OllamaSetup.exe
```

Be careful with the GUI and installer because Ollama's desktop app includes update behavior. An official update may replace this custom `gfx1150` build with a stock build that does not include the same ROCm target.

## What Changed

Only one source configuration change is required for the ROCm backend:

```diff
- "AMDGPU_TARGETS": "gfx940;gfx941;gfx942;gfx1010;gfx1012;gfx1030;gfx1100;gfx1101;gfx1102;gfx1151;gfx1200;gfx1201;gfx908:xnack-;gfx90a:xnack+;gfx90a:xnack-"
+ "AMDGPU_TARGETS": "gfx1150"
```

## Disclaimer

This is an unofficial community build. It is not endorsed by Ollama or AMD. Use at your own risk, especially if you install it over an existing Ollama desktop installation.

