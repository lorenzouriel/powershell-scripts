# Need NuGet Package
Install-PackageProvider -Name NuGet -Force

# SQL Server Tools
Install-Module -Name SqlServer -Force

# Install Reporting Services Tools
Install-Module -Name ReportingServicesTools -Force -Confirm:$false

Get-Command -Module ReportingServicesTools