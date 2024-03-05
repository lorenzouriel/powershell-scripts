# Server Variable, Will be used in all the package
$localhost = $env:ComputerName
$instance = $localhost

# Variables
$SSISNamespace = "Microsoft.SqlServer.Management.IntegrationServices"
$TargetServerName = $localhost
$TargetFolderName = "your_ssis_folder"
$ProjectFilePath = "C:\SSIS\ETL.ispac"
$ProjectName = "ETL"


# Create SSISDB Catalog
$SQLServerInstance = $localhost 
  $SSISCatalogPassword = "your_pass"
  $SQLServerConnectionString = "Data Source=$SQLServerInstance;Initial Catalog=master;Integrated Security=SSPI;"
  # Pre-Requisite - Enable CLR before creating catalog
  $query = "
    EXEC sp_configure 'clr enabled', 1
    RECONFIGURE
   "
   Invoke-SqlCmd -QueryTimeout 60 -ServerInstance $instance -Query $query -TrustServerCertificate


  # Loading IntegrationServices Assembly .........
  [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Management.IntegrationServices") | Out-Null;
  # Store the value of IntegrationServices Assembly name in a string
  # This will avoid to re type the same string again and again
  $SSISNamespace = "Microsoft.SqlServer.Management.IntegrationServices"
  Write-Host "Trying to connect SQL Server...."
  # Create SQL Server connection based on the connection string
  $SQLServerConnection = New-Object System.Data.SqlClient.SqlConnection $SQLServerConnectionString
  Write-Host "SQL Server connection has been enabled successfully"
  # Create Integration Services object based on the SQL Server connection
  Write-Host "Trying to create a object for Integration Service...."
  $IntegrationServices = New-Object $SSISNamespace".IntegrationServices" $SQLServerConnection
  Write-Host "Integration service object has been created successfully"
  Write-Host "Dropping existing SSIS Catalog on the server $SQLServerInstance"
  # Drop the existing catalog if it exists
  if ($IntegrationServices.Catalogs.Count -gt 0)
  {
      Write-Host "Warning !, all the SSIS projects and Packages will be dropped...."
      $IntegrationServices.Catalogs["SSISDB"].Drop()
      Write-Host "Existing SSIS Catalog has been dropped successfully ."
  }
  Write-Host "Creating SSIS Catalog on the server $SQLServerInstance"
  $SSISCatalog = New-Object $SSISNamespace".Catalog" ($IntegrationServices, "SSISDB", $SSISCatalogPassword)
  $SSISCatalog.Create()
  Write-Host "SSIS Catalog has been created successfully on the server $SQLServerInstance"


# Load the IntegrationServices assembly
$loadStatus = [System.Reflection.Assembly]::Load("Microsoft.SQLServer.Management.IntegrationServices, "+
    "Version=13.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91, processorArchitecture=MSIL")

# Create a connection to the server
$sqlConnectionString = `
    "Data Source=" + $TargetServerName + ";Initial Catalog=master;Integrated Security=SSPI;"
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $sqlConnectionString

# Create the Integration Services object
$integrationServices = New-Object $SSISNamespace".IntegrationServices" $sqlConnection

# Get the Integration Services catalog
$catalog = $integrationServices.Catalogs["SSISDB"]

# Create the target folder
$folder = New-Object $SSISNamespace".CatalogFolder" ($catalog, $TargetFolderName,
    "Folder description")
$folder.Create()

Write-Host "Deploying " $ProjectName " project ..."

# Read the project file and deploy it
[byte[]] $projectFile = [System.IO.File]::ReadAllBytes($ProjectFilePath)
$folder.DeployProject($ProjectName, $projectFile)

Write-Host "Done."