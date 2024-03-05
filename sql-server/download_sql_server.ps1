Write-Host "Downloading SQL Server 2019..."
$isoPath = "$env:C:\SQLServer2019-x64-ENU-Dev.iso"
(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SQLServer2019-x64-ENU-Dev.iso', $isoPath)