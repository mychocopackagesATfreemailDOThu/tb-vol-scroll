$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'tb-vol-scroll*'
  fileType      = 'exe'
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % {
    $packageArgs['file'] = "$($_.UninstallString)" 
    if ($packageArgs['fileType'] -eq 'MSI') {
      $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
      $packageArgs['file'] = ''
    }
    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}


# Stop process before remove
$psfile = Join-Path $env:TEMP stop-to-vol-scroll.ps1
echo "Stop-Process -Name tb-vol-scroll" > $psfile
Start-ChocolateyProcessAsAdmin "& `'$psfile`'"
Remove-Item $psfile

# Remove Program
$executable = "tb-vol-scroll.exe"
$startuppath = [Environment]::GetFolderPath("Startup")
Remove-Item $startuppath/$executable