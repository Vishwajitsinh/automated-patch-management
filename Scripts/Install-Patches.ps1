# Requires administrative privileges
# Create backup of current inventory before installing updates
& "D:\automated-patch-management\Scripts\Inventory.ps1"

# Create logs directory if it doesn't exist
if (-not (Test-Path -Path "Logs")) {
    New-Item -ItemType Directory -Path "Logs" | Out-Null
}

# Install Windows updates
$session = New-Object -ComObject Microsoft.Update.Session
$searcher = $session.CreateUpdateSearcher()
$updates = $searcher.Search("IsInstalled=0 and Type='Software'")

if ($updates.Updates.Count -gt 0) {
    $installer = $session.CreateUpdateInstaller()
    $installer.Updates = $updates.Updates
    $result = $installer.Install()

    # Log results
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $result | Out-File "Logs\patch_results_$timestamp.txt"
    Write-Host "Installed $($updates.Updates.Count) updates. Results logged to Logs\patch_results_$timestamp.txt"
} else {
    Write-Host "No updates available"
}