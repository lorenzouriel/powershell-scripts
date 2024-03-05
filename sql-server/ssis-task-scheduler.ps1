# Run the First Load Jobs
powershell -ExecutionPolicy Bypass -File "/SSIS/package.ps1"
powershell -ExecutionPolicy Bypass -File "/SSIS/package2.ps1"


# Define the Variables
$StartTime = Get-Date -Hour 12 -Minute 0 -Second 0
$Interval = New-TimeSpan -Minutes 5


# REVERSED (data/data_details)
$Trigger_data = New-ScheduledTaskTrigger -At $StartTime -Daily
$Action_data = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument '-ExecutionPolicy Bypass -File "C:\SSIS\package.ps1"'
Register-ScheduledTask -TaskName "DM - Reversed Data" -Trigger $Trigger_data -Action $Action_data -RunLevel Highest


$Trigger_data_details = New-ScheduledTaskTrigger -At $StartTime -Daily
$Action_data_details = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument '-ExecutionPolicy Bypass -File "C:\SSIS\package.ps1"'
Register-ScheduledTask -TaskName "DM - Reversed Data Details" -Trigger $Trigger_data_details -Action $Action_data_details -RunLevel Highest