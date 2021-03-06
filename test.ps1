$ErrorActionPreference = "Stop"

if ($env:APPVEYOR_BUILD_VERSION) {
  # run in CI
  $version = $env:APPVEYOR_BUILD_VERSION -replace('\.[^.\\/]+$')
} else {
  # run manually
  [xml]$spec = Get-Content docker-cli.nuspec
  $version = $spec.package.metadata.version
}

"TEST: Package should contain only install script"
Add-Type -assembly "system.io.compression.filesystem"
$zip = [IO.Compression.ZipFile]::OpenRead("$pwd\docker-cli.$version.nupkg")
if ($zip.Entries.Count -ne 5) {
  Write-Error "FAIL: Wrong count in nupkg!"
}
$zip.Dispose()

"TEST: Installation of package should work"
. choco install -y docker-cli -source .

"TEST: Version of binary should match"
. docker --version
if (-Not $(docker --version).Contains("version $version,")) {
  Write-Error "FAIL: Wrong version of docker installed!"
}

"TEST: Docker daemon shim must not exist"
if (Test-Path $env:ChocolateyInstall\bin\dockerd.exe) {
  Write-Error "FAIL: Docker daemon shim exists!"
}

"TEST: Docker proxy shim must not exist"
if (Test-Path $env:ChocolateyInstall\bin\docker-proxy.exe) {
  Write-Error "FAIL: Docker proxy shim exists!"
}

"TEST: Uninstall show remove the binary"
. choco uninstall docker-cli
try {
  . docker
  Write-Error "FAIL: docker CLI binary still found"
} catch {
  Write-Host "PASS: docker CLI binary not found"
}

"TEST: Finished"
