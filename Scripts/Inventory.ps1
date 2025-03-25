# Get installed software from registry
$software = @()
$software += Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
$software += Get-ItemProperty "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

# Create output directory if it doesn't exist
if (-not (Test-Path -Path "Data\Inventory")) {
    New-Item -ItemType Directory -Path "Data\Inventory" | Out-Null
}

# Export inventory to CSV
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$software | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
           Export-Csv -Path "Data\Inventory\inventory_$timestamp.csv" -NoTypeInformation

Write-Host "Inventory collected successfully. Saved to Data\Inventory\inventory_$timestamp.csv"