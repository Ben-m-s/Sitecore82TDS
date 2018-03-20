$ErrorActionPreference = "STOP"
$VSDevEnvPath = "c:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.exe"


docker build -t sitecore-8-base .\images\sitecore-8-base
docker build -t sitecore:8.2.161221 .\images\sitecore-82rev161221

& $VSDevEnvPath /build .\Sitecore82TDS.sln Debug

& $VSDevEnvPath /build .\Sitecore82TDS.sln Release
