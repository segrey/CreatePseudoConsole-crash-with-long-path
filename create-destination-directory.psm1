$DirectoryNameLength=8

function FindNextDirNameLength {
  param(
    [int]$RequestedTotalLength,
    [string]$CurrentDir
  )
  $RestLength = $RequestedTotalLength - $CurrentDir.Length - 1
  if ($RestLength -lt $DirectoryNameLength) {
    return $RestLength
  }
  if ($RestLength -eq $DirectoryNameLength + 1) {
    return $DirectoryNameLength - 1
  }
  return $DirectoryNameLength
}

function CreateDestinationDirectory {
  param(
    [string]$BaseDir,
    [int]$FullPathLength
  )

  if ($FullPathLength -lt $BaseDir.Length) {
    throw "Too small destination directory full path length: $FullPathLength, base directory full path length: $($BaseDir.Length) ($BaseDir)"
  }

  Get-ChildItem $BaseDir -exclude "Microsoft.WindowsTerminal_*.zip" -Recurse | Remove-Item -Recurse -ErrorAction Stop

  $CreatedCount = 0
  Write-Host "Generating destination directory of total full path length $FullPathLength, base directory full path length: $($BaseDir.Length)"
  $CurrentDir = $BaseDir
  while ($CurrentDir.Length -lt $FullPathLength) {
    $NextDirNameLength = FindNextDirNameLength -RequestedTotalLength $FullPathLength -CurrentDir $CurrentDir
    $NextDirName = "".PadLeft($NextDirNameLength, 'a')
    $CurrentDir = Join-Path $CurrentDir $NextDirName
    $CreatedCount++
    New-Item -ItemType Directory -Path $CurrentDir -ErrorAction Stop | Out-Null
  }
  Write-Host "Destination path: $CurrentDir (length: $($CurrentDir.Length), $($CreatedCount) new directories created)"

  return $CurrentDir
}
