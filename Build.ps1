$ErrorActionPreference = "STOP"
$VSDevEnvPath = "c:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.exe"


docker build -t sitecore-8-base .\images\sitecore-8-base

&$VSDevEnvPath /build .\Sitecore82TDS.sln Release
#&"c:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.exe" /build .\Sitecore82TDS.sln Release
#& "c:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.exe" /build "c:\Docker\Sitecore82TDS\Sitecore82TDS.sln" Release

docker build -t sitecore:8.2.161221 .\images\sitecore-82rev161221
