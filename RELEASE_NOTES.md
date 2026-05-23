# Release Notes - Ollama AMD GPU on Windows - Custom Build (890M)

## v0.25.0-rc0-gfx1150-rocm-windows-2026-05-23

Unofficial **Ollama AMD GPU on Windows - Custom Build (890M)** ROCm/HIP build for AMD Radeon 890M Graphics, `gfx1150`.

Target system keywords:

- Processor: AMD Ryzen AI 9 HX PRO 370 w/ Radeon 890M
- GPU: AMD Radeon(TM) 890M Graphics
- GPU architecture: gfx1150
- Platform: Windows 11, AMD ROCm/HIP SDK 6.4.2

### Included

- `ollama.exe`
- `OllamaSetup-gfx1150-radeon-890m-desktop.exe`
- `windows-ollama-app-amd64.exe` inside the installer as `ollama app.exe`
- CPU backend DLLs
- ROCm/HIP backend DLLs
- `ggml-hip.dll`
- rocBLAS runtime files, including `gfx1150` kernels

### Tested

- Windows 11 Pro for Workstations
- AMD Radeon(TM) 890M Graphics
- AMD HIP SDK 6.4.2
- `qwen2.5:3b`

### SHA256

```text
C46F19F666D3A098E2991CCBF8CE3C72474B112B95415F5655B2D7C4E75D78E0  ollama-windows-amd64-rocm-gfx1150-radeon-890m.zip
320814BA15E05E112763169DF2DD6A1F57BDD3FF5C162A3E2E868EF7AB76AE42  OllamaSetup-gfx1150-radeon-890m-desktop.exe
```

### Warning

This is an unofficial community build.

- The desktop installer is not digitally signed, so Windows SmartScreen may warn.
- The desktop GUI may offer or perform official Ollama updates.
- An official update can replace this custom `gfx1150` ROCm build with a stock build.
- If Radeon 890M GPU acceleration stops working after a GUI update, reinstall this custom build or use the CLI zip release.
