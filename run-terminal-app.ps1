Param(
  [Parameter(Mandatory=$true)]
  [int]$DestinationDirLength
)

Import-Module ".\create-destination-directory.psm1"
Import-Module ".\setup-terminal-app.psm1"

$BaseDir = "$PSScriptRoot\tmp"
if (-Not (Test-Path $BaseDir)) {
  New-Item -ItemType Directory -Path $BaseDir -ErrorAction Stop | Out-Null
}

$DestinationDir = CreateDestinationDirectory -BaseDir $BaseDir -FullPathLength $DestinationDirLength
$TerminalExeFile = SetupTerminal -BaseDir $BaseDir -DestinationPath $DestinationDir

Write-Host "Running $TerminalExeFile"

$Process = Start-Process -FilePath $TerminalExeFile -NoNewWindow -PassThru -Wait
$Process.WaitForExit()
$ExitCode = $Process.ExitCode

Write-Host "Finished with exit code $ExitCode (hex: $("{0:x}" -f $ExitCode))"
exit $ExitCode
