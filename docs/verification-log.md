# Verification Log

Date: 2026-05-23

Host:

- Windows 11 Pro for Workstations
- Processor: AMD Ryzen AI 9 HX PRO 370 w/ Radeon 890M
- AMD Radeon(TM) 890M Graphics
- HIP SDK 6.4.2
- ROCm path: `C:\Program Files\AMD\ROCm\6.4`

Search keywords:

```text
Ollama AMD GPU on Windows - Custom Build (890M)
AMD Ryzen AI 9 HX PRO 370 w/ Radeon 890M
AMD Radeon 890M gfx1150 ROCm HIP Windows
```

Build:

- Ollama source commit: `275f122c`
- Version string: `0.25.0-rc0-8-g275f122-dirty`
- ROCm CMake preset: `AMDGPU_TARGETS=gfx1150`

Key build output:

```text
Preset CMake variables:
  AMDGPU_TARGETS="gfx1150"
  CMAKE_HIP_FLAGS="-parallel-jobs=4"
  CMAKE_HIP_PLATFORM="amd"
  OLLAMA_RUNNER_DIR="rocm"
```

Runtime discovery:

```text
verifying if device is supported
library=C:\ollama\dist\windows-amd64\lib\ollama\rocm
description="AMD Radeon(TM) 890M Graphics"
compute=gfx1150
```

Runtime inference:

```text
inference compute
library=ROCm
compute=gfx1150
description="AMD Radeon(TM) 890M Graphics"
```

Model load:

```text
loaded ROCm backend from C:\ollama\dist\windows-amd64\lib\ollama\rocm\ggml-hip.dll
Device 0: AMD Radeon(TM) 890M Graphics, gfx1150
offloaded 37/37 layers to GPU
```

API test:

```powershell
$body = @{
  model = "qwen2.5:3b"
  prompt = "Reply with exactly: OK"
  stream = $false
  options = @{ num_predict = 4 }
} | ConvertTo-Json -Depth 5

Invoke-RestMethod -Method Post `
  -Uri http://127.0.0.1:11434/api/generate `
  -ContentType "application/json" `
  -Body $body
```

Response:

```json
{
  "model": "qwen2.5:3b",
  "response": "OK",
  "done": true
}
```
