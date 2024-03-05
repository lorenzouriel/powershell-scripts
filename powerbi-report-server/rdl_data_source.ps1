# Data Source Variables
$User = "lorenzo.uriel"
$PWord = ConvertTo-SecureString -String "your_password" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
$dataSourceName = 'your_db_name'
$extension = 'SQL'
$connectionString = 'Data Source=your_server_name;Initial Catalog=your_db_name;'
$credentialRetrieval = 'Store'

# Report Server Variables
$localhost = $env:ComputerName
$reportServerUrl = 'http://' + $localhost + ':80/ReportServer'
$reportFolder = 'Reports'


# Do the first connection in the Report Server
Connect-RsReportServer -ComputerName $localhost -ReportServerInstance $localhost -ReportServerUri $reportServerUrl -Verbose
$proxy = New-RsWebServiceProxy -ReportServerUri $reportServerUrl -Verbose

# Create a new data source
New-RsDataSource -Proxy $proxy -RsFolder /$reportFolder -Name $dataSourceName -Extension $extension -ConnectionString $connectionString -CredentialRetrieval $credentialRetrieval -DatasourceCredentials $Credential  -ImpersonateUser -Credential $CredentialRS -Overwrite -Verbose