# Create the variables to run 
$localhost = $env:ComputerName
$ReportPortalUri = 'http://' + $localhost + ':80/Reports'
$dashboardFolder = 'Dashboards'
$uploadItemPath = 'C:\SSRS\Dashboards\dashboard.pbix'
$catalogItemsUri = $ReportPortalUri + "/api/v2.0/PowerBIReports"

# Create folder (optional)
New-RsRestFolder -ReportPortalUri $ReportPortalUri -RsFolder $dashboardFolder -FolderName $dashboardFolder -Verbose

Write-Host "Upload an item..."
$bytes = [System.IO.File]::ReadAllBytes($uploadItemPath)
$payload = @{
    "@odata.type" = "#Model.PowerBIReport";
    "Content" = [System.Convert]::ToBase64String($bytes);
    "ContentType"="";
    "Name" = 'dashboard'; # This is the the pbix name
    "Path" = '/Dashboards/dashboard'; # This is the path in Report Server >> The folder name and the pbix name
    } | ConvertTo-Json
Invoke-WebRequest -Uri $catalogItemsUri -Method Post -Body $payload -ContentType "application/json" -UseDefaultCredentials | Out-Null


# Scripts to Dowload and Delete
<#============================================================================
Write-Host "Download an item..."
$downloadPath = 'C:\download\test.rdl'
$catalogItemsApi = $ReportPortalUri + "/api/v2.0/CatalogItems(Path='/test')/Content/$value"
$url = [string]::Format($catalogItemsApi, $item)
$response = Invoke-WebRequest -Uri $url -Method Get -UseDefaultCredentials
[System.IO.File]::WriteAllBytes($downloadPath, $response.Content)


Write-Host "Delete an item..."
$url = $ReportPortalUri + "/api/v2.0/CatalogItems(Path='/test')"
Invoke-WebRequest -Uri $url -Method Delete -UseDefaultCredentials | Out-Null
===========================================================================#>