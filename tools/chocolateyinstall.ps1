$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/dvingerh/tb-vol-scroll/releases/download/3.9/tb-vol-scroll.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64
  softwareName  = 'tb-vol-scroll*'
  checksum      = '20D78C68CE76D774AF3D843EB727F8E161BD8BAE63822C6C3D280F0BD39CA4A8'
  checksumType  = 'sha256'
}

$executable = "tb-vol-scroll.exe"

Get-ChocolateyWebFile -PackageName $packageName -FileFullPath "$toolsDir\$executable" -Url $url

# Move to startup folder
$startuppath = [Environment]::GetFolderPath("Startup")
$donloadpath = Join-Path $toolsDir $executable
Move-Item $donloadpath $startuppath
$fullpathtoexe = Join-Path $startuppath $executable
& $fullpathtoexe