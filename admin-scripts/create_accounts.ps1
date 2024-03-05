# Create the repl_distribution
# Set the desired username and password
$username = "db_distribution"
$password = ConvertTo-SecureString "your_pass" -AsPlainText -Force
New-LocalUser -Name $username -Password $password -FullName "Geo Distribution" -Description "Description" 

# Create the repl_logreader
$username = "db_logreader"
$password = ConvertTo-SecureString "your_pass" -AsPlainText -Force
New-LocalUser -Name $username -Password $password -FullName "Geo Logreader" -Description "Description" 


# Add the new user to a specific group (optional)
#Add-LocalGroupMember -Group "Administrators" -Member $username