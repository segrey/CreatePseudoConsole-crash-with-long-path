$ArchiveFileName="Microsoft.WindowsTerminal_1.19.10573.0_x64.zip"

function SetupTerminal {
  param(
    [string]$BaseDir,
    [string]$DestinationPath
  )

  $ArchiveFullPath = "$BaseDir\$ArchiveFileName"
  if (-Not (Test-Path $ArchiveFullPath)) {
    $TerminalUrl = "https://github.com/microsoft/terminal/releases/download/v1.19.10573.0/Microsoft.WindowsTerminal_1.19.10573.0_x64.zip"
    Write-Host "Downloading $TerminalUrl ..."
    Invoke-WebRequest $TerminalUrl -OutFile $ArchiveFullPath -ErrorAction Stop
  }

  Write-Host "Expanding $ArchiveFileName"
  Expand-Archive "$ArchiveFullPath" -DestinationPath $DestinationPath -ErrorAction Stop

  $TerminalExeFile = "$DestinationPath\terminal-1.19.10573.0\WindowsTerminal.exe"

  if (-Not (Test-Path $TerminalExeFile)) {
    throw "Something went wrong: cannot find $TerminalExeFile"
  }

  return $TerminalExeFile
}
