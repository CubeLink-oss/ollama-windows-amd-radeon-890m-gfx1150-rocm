# Ollama AMD GPU on Windows - Custom Build (890M, gfx1150, ROCm HIP)

[English Version](./README.md) / [中文版本](./README.zh-TW.md)

這是一份非官方 Windows 編譯紀錄與二進位發布，用於在 AMD Radeon 890M iGPU、RDNA 3.5、`gfx1150` 上，透過 AMD ROCm/HIP 加速 Ollama。

本 repo 記錄了一份可工作的 Ollama build，目標環境：

- Windows 11 Pro for Workstations
- 處理器：AMD Ryzen AI 9 HX PRO 370 w/ Radeon 890M
- AMD Radeon 890M Graphics
- Windows 版 ROCm/HIP SDK 6.4.2
- Ollama source commit `275f122c`
- Ollama version string `0.25.0-rc0-8-g275f122-dirty`
- AMDGPU target `gfx1150`

這份 release 主要給搜尋以下關鍵字的人：

- Ollama AMD Radeon 890M Windows
- Ollama AMD GPU on Windows Custom Build 890M
- Ollama AMD Ryzen AI 9 HX PRO 370 w/ Radeon 890M
- Ollama gfx1150 ROCm Windows
- Ollama AMD 890M HIP SDK
- Ollama RDNA 3.5 Windows ROCm
- Ollama Ryzen AI HX 370 Radeon 890M
- Ollama Ryzen AI 9 HX PRO 370 ROCm
- Ollama Windows AMD iGPU ROCm

## 適用產品

這份 build 主要面向使用 AMD Radeon 890M 內顯的 Windows 系統，特別是 AMD Ryzen AI 9 HX 370 / HX PRO 370 / HX 375 / HX PRO 375 / HX 470 這類裝置，且 iGPU 在 HIP/ROCm 中回報為 `gfx1150`。

以下清單是實務搜尋與辨識用參考。實際能否使用 GPU 加速，仍取決於 BIOS/韌體、AMD 驅動、HIP SDK，以及系統是否把 Radeon 890M 正確暴露為 `gfx1150`。

### 筆記本電腦

| 品牌 | 產品名稱 | CPU / GPU |
|---|---|---|
| Acer | Swift 14 AI | Ryzen AI 9 HX 370 / Radeon 890M |
| ASUS | Vivobook S 14 OLED M5406 | Ryzen AI 9 HX 370 / Radeon 890M |
| ASUS | Vivobook S 15 OLED M5506 | Ryzen AI 9 HX 370 / Radeon 890M |
| ASUS | Vivobook S 16 OLED M5606 | Ryzen AI 9 HX 370 / Radeon 890M |
| ASUS | Zenbook S 16 OLED UM5606 | Ryzen AI 9 HX 370 / Radeon 890M |
| ASUS | ProArt PX13 | Ryzen AI 9 HX 370 / Radeon 890M，部分配置另有 RTX 4050/4060/4070 |
| ASUS | ProArt P16 | Ryzen AI 9 HX 370 / Radeon 890M，另搭 RTX 4060/4070/50 系列等獨顯配置 |
| ASUS | TUF Gaming A14 | Ryzen AI 9 HX 370 / Radeon 890M，另搭 NVIDIA 獨顯 |
| ASUS | ROG Zephyrus G14 | Ryzen AI 9 HX 370 / Radeon 890M，另搭 NVIDIA 獨顯 |
| ASUS | ROG Zephyrus G16 | Ryzen AI 9 HX 370 / Radeon 890M，另搭 NVIDIA 獨顯 |
| Dell | Pro 13 Plus / 2-in-1 | Ryzen AI 9 HX 370 或 Ryzen AI 9 HX PRO 370 / Radeon 890M |
| Dell | Pro 14 Plus / 2-in-1 | Ryzen AI 9 HX 370 或 Ryzen AI 9 HX PRO 370 / Radeon 890M |
| Dell | Pro 16 Plus | Ryzen AI 9 HX 370 / Radeon 890M |
| Framework | Framework Laptop 13 | Ryzen AI 9 HX 370 / Radeon 890M |
| GPD | Duo OLED | Ryzen AI 9 HX 370 / Radeon 890M |
| GPD | Pocket 4 | Ryzen AI 9 HX 370 / Radeon 890M |
| GPD | Win 4 | Ryzen AI 9 HX 370 / Radeon 890M |
| GPD | Win Mini | Ryzen AI 9 HX 370 / Radeon 890M |
| HP | OmniBook Ultra 14 | Ryzen AI 9 HX 375 / Radeon 890M |
| HP | EliteBook X G1a 14 AI | Ryzen AI 9 HX PRO 375 或 HX 375 / Radeon 890M |
| Lenovo | ThinkPad P14s Gen 6 AMD | Ryzen AI 9 HX PRO 370 / Radeon 890M |
| Lenovo | ThinkPad P16s Gen 4 AMD | Ryzen AI 9 HX PRO 370 / Radeon 890M |
| MSI | Prestige A16 AI+ | Ryzen AI 9 HX 370 / Radeon 890M |
| MSI | Stealth A16 AI+ | Ryzen AI 9 HX 370 / Radeon 890M，另搭 NVIDIA 獨顯 |
| MSI | Creator A16 AI+ | Ryzen AI 9 HX 370 / Radeon 890M，另搭 NVIDIA 獨顯 |
| MSI | Pulse A17 AI+ | Ryzen AI 9 HX 370 / Radeon 890M，另搭 NVIDIA 獨顯 |
| NIMO | 17.3" AI Laptop | Ryzen AI 9 HX 370 / Radeon 890M |
| TUXEDO | InfinityBook Pro 14 Gen10 AMD | Ryzen AI 9 HX 370 / Radeon 890M |

### 台式電腦 / Mini PC

| 品牌 | 產品名稱 | CPU / GPU |
|---|---|---|
| ACEMAGIC | F3A | Ryzen AI 9 HX 370 / Radeon 890M |
| ACEMAGIC | F5A | Ryzen AI 9 HX 470 / Radeon 890M |
| ACEMAGIC | Retro X5 | Ryzen AI 9 HX 370 / Radeon 890M |
| AOOSTAR | GEM10 370 | Ryzen AI 9 HX 370 / Radeon 890M |
| AOOSTAR | GT37 | Ryzen AI 9 HX 370 / Radeon 890M |
| AOOSTAR | G-Flip 370 | Ryzen AI 9 HX 370 / Radeon 890M |
| ARCTIC | Senza AI 370 | Ryzen AI 9 HX 370 / Radeon 890M |
| Beelink | SER9 | Ryzen AI 9 HX 370 / Radeon 890M |
| Beelink | SER9 Pro | Ryzen AI 9 HX 370 / Radeon 890M |
| Beelink | SER10 Pro | Ryzen AI 9 HX 470 / Radeon 890M |
| Beelink | SER10 Max | Ryzen AI 9 HX 470 / Radeon 890M |
| BOSGAME | BeyondMax M6 / M6 HX370 AI PC | Ryzen AI 9 HX 370 / Radeon 890M |
| GEEKOM | A9 Max AI Mini PC | Ryzen AI 9 HX 370 或 HX 470 / Radeon 890M |
| GMKtec | EVO-X1 AI Mini PC | Ryzen AI 9 HX 370 / Radeon 890M |
| MINISFORUM | EliteMini AI370 | Ryzen AI 9 HX 370 / Radeon 890M |
| MINISFORUM | AI X1 Pro / AI X1 Pro-370 | Ryzen AI 9 HX 370 / Radeon 890M |
| Sapphire | Edge AI 370 | Ryzen AI 9 HX 370 / Radeon 890M |
| Topton | D12 Ultra, top-end version | Ryzen AI 9 HX 370 / Radeon 890M |

### NAS / 類 NAS 系統

| 品牌 | 產品名稱 | CPU / GPU |
|---|---|---|
| MINISFORUM | N5 Pro AI NAS | Ryzen AI 9 HX PRO 370 / Radeon 890M |

## 狀態

這份 build 已在 Windows 11 + AMD Radeon 890M 上測試。

## 重要警告

桌面安裝器是未簽名的非官方社群 build。

- Windows SmartScreen 可能會警告，因為 `OllamaSetup-gfx1150-radeon-890m-desktop.exe` 沒有數位簽章。
- Ollama 桌面 GUI 內含官方更新機制。
- 如果 GUI 自行更新，可能會把這份自編譯 `gfx1150` ROCm build 覆蓋成官方 stock build。
- 如果更新後 GPU 加速消失，請重新安裝這份 custom build，或改用 CLI zip release。

測試機器關鍵字：

```text
Processor: AMD Ryzen AI 9 HX PRO 370 w/ Radeon 890M
GPU: AMD Radeon(TM) 890M Graphics
Architecture: gfx1150
Topic: Ollama AMD GPU on Windows - Custom Build (890M)
```

成功 runtime log：

```text
description="AMD Radeon(TM) 890M Graphics" compute=gfx1150
library=ROCm compute=gfx1150
loaded ROCm backend ... ggml-hip.dll
Device 0: AMD Radeon(TM) 890M Graphics, gfx1150
offloaded 37/37 layers to GPU
```

測試模型：

```text
qwen2.5:3b
```

模型已透過 Ollama HTTP API 成功回覆 `OK`。

## 下載

請到 GitHub Releases 下載：

```text
ollama-windows-amd64-rocm-gfx1150-radeon-890m.zip
OllamaSetup-gfx1150-radeon-890m-desktop.exe
```

SHA256：

```text
C46F19F666D3A098E2991CCBF8CE3C72474B112B95415F5655B2D7C4E75D78E0
320814BA15E05E112763169DF2DD6A1F57BDD3FF5C162A3E2E868EF7AB76AE42
```

`OllamaSetup-gfx1150-radeon-890m-desktop.exe` 是未簽名桌面安裝器，Windows SmartScreen 可能會警告。GUI 也可能自動更新並覆蓋這份 custom `gfx1150` build。

## 快速開始

解壓 release zip，然後在解壓目錄打開 PowerShell：

```powershell
$env:Path = "$PWD\lib\ollama\rocm;$PWD\lib\ollama;C:\Program Files\AMD\ROCm\6.4\bin;$env:Path"
$env:ROCR_VISIBLE_DEVICES = "0"
$env:OLLAMA_DEBUG = "1"
.\ollama.exe serve
```

另開第二個 PowerShell：

```powershell
.\ollama.exe list
.\ollama.exe run qwen2.5:3b "Reply with exactly: OK"
```

server log 裡應該看到：

```text
library=ROCm compute=gfx1150
offloaded ... layers to GPU
```

## 從原始碼編譯

安裝依賴：

```powershell
winget install -e --id GoLang.Go
winget install -e --id Git.Git
winget install -e --id Kitware.CMake
winget install -e --id GitHub.cli
winget install -e --id JRSoftware.InnoSetup
winget install -e --id Microsoft.VisualStudio.2022.BuildTools --override "--quiet --wait --norestart --nocache --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"
winget install -e --id MartinStorsjo.LLVM-MinGW.UCRT
```

安裝 Windows 版 AMD HIP SDK 6.4.2。AMD 目前的封裝名稱為：

```text
AMD-Software-PRO-Edition-25.Q3-Win10-Win11-For-HIP.exe
```

預期 HIP 路徑：

```text
C:\Program Files\AMD\ROCm\6.4\bin
```

clone 並修改 Ollama：

```powershell
git clone https://github.com/ollama/ollama.git C:\ollama
cd C:\ollama
```

修改 `CMakePresets.json` 的 `ROCm 6` preset：

```json
"AMDGPU_TARGETS": "gfx1150"
```

編譯：

```powershell
cd C:\ollama
$env:Path = "C:\Program Files\AMD\ROCm\6.4\bin;$env:Path"
$env:OLLAMA_BUILD_PARALLEL = "8"
powershell -ExecutionPolicy Bypass -File .\scripts\build_windows.ps1 clean cpu rocm6 ollama zip
```

預期產物：

```text
C:\ollama\dist\windows-amd64\ollama.exe
C:\ollama\dist\ollama-windows-amd64-rocm.zip
C:\ollama\dist\ollama-windows-amd64.zip
```

## 關於 GUI

Release 同時包含 CLI/server runtime zip 和桌面安裝器。Ollama Windows GUI 是獨立的 `app` target，產物為：

```text
C:\ollama\dist\windows-ollama-app-amd64.exe
```

installer target 會包成：

```text
C:\ollama\dist\OllamaSetup.exe
```

請注意 GUI 和 installer，因為 Ollama 桌面 app 包含更新機制。官方更新可能會把這份 custom `gfx1150` build 覆蓋成不包含相同 ROCm target 的 stock build。如果發生這種情況，Radeon 890M GPU 加速可能會消失，直到重新安裝 custom build。

## 改了什麼

ROCm backend 只需要一個核心設定修改：

```diff
- "AMDGPU_TARGETS": "gfx940;gfx941;gfx942;gfx1010;gfx1012;gfx1030;gfx1100;gfx1101;gfx1102;gfx1151;gfx1200;gfx1201;gfx908:xnack-;gfx90a:xnack+;gfx90a:xnack-"
+ "AMDGPU_TARGETS": "gfx1150"
```

## 免責聲明

這是非官方社群 build，不由 Ollama 或 AMD 官方背書。請自行承擔使用風險，尤其是在既有 Ollama 桌面安裝上覆蓋安裝時。

