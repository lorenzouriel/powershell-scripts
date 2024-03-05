# Install-Module -Name SqlServer -Force

# SQL Server Connection in Variable
$localhost = $env:ComputerName
$instance = $localhost


# Declare tha variable paths
$logPath = 'C:\databases\your_db'
$mdfPath = 'C:\databases\your_db'
$otherPath = 'C:\databases\your_db'


# Create the directory folders
New-Item $logPath -ItemType Directory
New-Item $mdfPath -ItemType Directory
New-Item $otherPath -ItemType Directory

Write-Output 'The folders have been created, now starting Database script...'


# Generate a SQL Script and change the path for the required paths >> Right-click on the Database, select Tasks and then Generate Scripts 
$query = "
        USE [master]
        GO
        CREATE DATABASE [your_db]
         CONTAINMENT = NONE
         ON  PRIMARY 
        ( NAME = N'your_db', FILENAME = N'$mdfPath\your_db.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
         LOG ON 
        ( NAME = N'your_db_log', FILENAME = N'$logPath\your_db_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
         WITH CATALOG_COLLATION = DATABASE_DEFAULT
        GO
        ALTER DATABASE [your_db] SET COMPATIBILITY_LEVEL = 150
        GO

        .... YOUR DB SCRIPT ...
"

# Sqlcmd command to run the Query in the specified instance
Invoke-SqlCmd -QueryTimeout 600 -ServerInstance $instance -Query $query -TrustServerCertificate