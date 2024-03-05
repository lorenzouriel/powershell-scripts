# Format the drives
New-Partition -DiskNumber 1 -UseMaximumSize -DriveLetter G | Format-Volume
New-Partition -DiskNumber 2 -UseMaximumSize -DriveLetter E | Format-Volume
