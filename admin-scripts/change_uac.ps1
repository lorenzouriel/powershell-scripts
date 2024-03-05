# Check if the script is running with administrative privileges
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as an administrator."
    Exit
}

# Define the registry key path
$regKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Define the name of the registry value to change
$regValueName = "PromptOnSecureDesktop"

# Define the new value data (0 to disable Secure Desktop)
$newValueData = 0

# Attempt to change the registry value
try {
    Set-ItemProperty -Path $regKeyPath -Name $regValueName -Value $newValueData -ErrorAction Stop
    Write-Host "Registry value changed successfully."
} catch {
    Write-Host "Error: $_"
}
