$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/dvingerh/tb-vol-scroll/releases/download/4.1.2/tb-vol-scroll.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64
  softwareName  = 'tb-vol-scroll*'
  checksum      = '80C1025314A976B71E4122288CACB5344F6EA3B02AB4C0FBB68B8BDA8192995D'
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
