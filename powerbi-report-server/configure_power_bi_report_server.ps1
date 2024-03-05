# Configure and Reserve the URLs in the Report Server 
Set-PbiRsUrlReservation -ReportServerVirtualDirectory ReportServer -PortalVirtualDirectory Reports -ListeningPort 80 -ReportServerInstance 'PBIRS' -ReportServerVersion SQLServervNext

# Configure the Database in the Report Server
$localhost = $env:ComputerName
Set-RsDatabase -DatabaseServerName $localhost -Name ReportServer -DatabaseCredentialType ServiceAccount -ReportServerInstance 'PBIRS' -ReportServerVersion SQLServervNext -TrustServerCertificate -Confirm:$false 

Restart-Service -Name "Power BI Report Server"

#Initialize-Rs -ReportServerInstance 'PBIRS' -ReportServerVersion SQLServervNext