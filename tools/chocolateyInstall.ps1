$packageName    = 'docker-cli'
$url            = 'https://github.com/StefanScherer/docker-cli-builder/releases/download/19.03.3/docker.exe'
$checksum       = 'ToDO'
$checksumType   = 'sha256'
$validExitCodes = @(0)

$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$file = "$($toolsDir)\docker.exe"

if (![System.IO.Directory]::Exists($toolsDir)) {[System.IO.Directory]::CreateDirectory($toolsDir)}

Get-ChocolateyWebFile `
  -PackageName $packageName `
  -FileFullPath $file `
  -Url64bit "$url" `
  -Checksum64 $checksum `
  -ChecksumType64 $checksumType

