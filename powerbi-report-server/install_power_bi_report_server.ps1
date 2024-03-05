$reportingPath = "C:\PowerBIReportServer.exe"

Write-Host "Installing..."
cmd /c start /wait $reportingPath /quiet /norestart /IACCEPTLICENSETERMS /Edition=Dev

# Write-Host "Deleting temporary files..."
# Remove-Item $reportingPath -Force -ErrorAction Ignore

Write-Host "Power BI Report Server Installed"