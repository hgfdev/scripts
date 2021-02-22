#Used to execute a powershell script without enabling script execution on a system which may be vulnerability. 
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command .\1-hhl-backup.ps1
