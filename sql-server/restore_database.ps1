# Install-Module -Name SqlServer -Force

# SQL Server Connection in Variable
$localhost = $env:ComputerName
$instance = $localhost

# Generate a SQL Script and change the path for the required paths >> Right-click on the Database, select Tasks and then Generate Scripts 
$query = "
        RESTORE DATABASE [your_db]
        FROM DISK = 'C:\Database\your_db.bak'
        WITH RECOVERY;
"

# Sqlcmd command to run the Query in the specified instance
Invoke-SqlCmd -QueryTimeout 600 -ServerInstance $instance -Query $query -TrustServerCertificate