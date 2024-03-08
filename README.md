# CreatePseudoConsole-crash-with-long-path

This repository automates reproducing `CreatePseudoConsole` crash when path to `conpty.dll` is long.

## Usage
```powershell
.\run-terminal-app.ps1 -DestinationDirLength <number>
```
It does the following:
1. Creates a new directory in the project root. The length of the directory full path is equal to the specified `number`.
2. Downloads [Windows Terminal v1.19.10573.0](https://github.com/microsoft/terminal/releases/tag/v1.19.10573.0) and extracts it to the created directory.
3. Runs the extracted `WindowsTerminal.exe`.


## Steps to reproduce crashing `CreatePseudoConsole`

```powershell
.\run-terminal-app.ps1 -DestinationDirLength 145
```

It runs a few seconds and then terminates without showing the Windows Terminal UI:
<style>
  code {
    white-space : pre-wrap !important;
    word-break: break-all;
  }
</style>
```text
PS D:\CreatePseudoConsole-crash-with-long-path> .\run-terminal-app.ps1 -DestinationDirLength 145
Generating destination directory of total full path length 145, base directory full path length: 47
Destination path: D:\CreatePseudoConsole-crash-with-long-path\tmp\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaa (length: 145, 11 new directories created)
Downloading https://github.com/microsoft/terminal/releases/download/v1.19.10573.0/Microsoft.WindowsTerminal_1.19.10573.0_x64.zip ...
Expanding Microsoft.WindowsTerminal_1.19.10573.0_x64.zip
Running D:\CreatePseudoConsole-crash-with-long-path\tmp\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaaa\aaaaaaa\terminal-1.19.10573.0\WindowsTerminal.exe
Finished with exit code -1073740791 (hex: c0000409)
```
