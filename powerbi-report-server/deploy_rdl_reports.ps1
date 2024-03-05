# Folder and Reports Variables
$localhost = $env:ComputerName
$serverUrl = 'http://' + $localhost + ':80/Reports'
$reportFolder = 'Reports'
$reportLocalPath = 'C:\SSRS\Reports'
$dataSourceLocalPath = 'C:\SSRS\DataSource'

Start-Service -Name "Power BI Report Server"

# Create folder (optional)
New-RsRestFolder -ReportPortalUri $serverUrl -RsFolder $reportFolder -FolderName $reportFolder -Verbose

# Deploy the reports and Data Sources With Write-RsRestFolderContent Method
Write-RsRestFolderContent -ReportPortalUri $serverUrl -Path $dataSourceLocalPath -RsFolder /$reportFolder -Verbose
Write-RsRestFolderContent -ReportPortalUri $serverUrl -Path $reportLocalPath -RsFolder /$reportFolder -Verbose