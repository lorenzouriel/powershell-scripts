$isoPath = "$env:C:\SQLServer2019-x64-ENU-Dev.iso"
$driveLetter = "D"

Write-Host "Opening ISO directory..."
Invoke-Item -Path $isoPath 

Write-Host "Waiting for ISO directory to open..."
Start-Sleep -Seconds 5

$extractPath = $driveLetter + ":" 

Write-Host "Installing..."
cmd /c start /wait $extractPath\setup.exe /q /ACTION=Install /FEATURES=SQLEngine,FullText,RS,IS /INSTANCENAME=MSSQLSERVER /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /TCPENABLED=1 /SECURITYMODE=SQL /SAPWD=Password12! /IACCEPTSQLSERVERLICENSETERMS

Write-Host "Dismounting ISO..."
Dismount-DiskImage -ImagePath $isoPath

Write-Host "OK"