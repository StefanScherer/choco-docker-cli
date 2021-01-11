$packageName    = 'docker-cli'
$url            = 'https://github.com/StefanScherer/docker-cli-builder/releases/download/19.03.12/docker.exe'
$checksum       = 'a55792e693d6833ff4d6b1b2efd94fb93c244c859e33c831699e3124408c5be8'
$checksumType   = 'sha256'
$validExitCodes = @(0)

$params = Get-PackageParameters

if (!$params['toolDir']) 
{ 
  $toolsDir = $params['toolDir']
}
else 
{
  $toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
}

$file = "$($toolsDir)\docker.exe"

if (![System.IO.Directory]::Exists($toolsDir)) {[System.IO.Directory]::CreateDirectory($toolsDir)}

Get-ChocolateyWebFile `
  -PackageName $packageName `
  -FileFullPath $file `
  -Url64bit "$url" `
  -Checksum64 $checksum `
  -ChecksumType64 $checksumType

