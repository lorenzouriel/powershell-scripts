# Declare tha variable paths
$G = 'G:\Databases\your_database'
$bcpDIFF = 'G:\backups\DIFF'
$bcpFULL = 'G:\backups\FULL'


# Create the directory folders
New-Item $G -ItemType Directory
New-Item $bcpDIFF -ItemType Directory
New-Item $bcpFULL -ItemType Directory