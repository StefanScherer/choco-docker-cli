$packageName    = 'docker-cli'
$url            = 'https://github.com/StefanScherer/docker-cli-builder/releases/download/18.09.0/docker.exe'
$checksum       = '831d191ecb337889287630d4b89a24953f1416deb76f823f42f7101de23ce540'
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

