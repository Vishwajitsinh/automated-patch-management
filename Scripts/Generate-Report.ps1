# Get list of inventory files
$inventoryFiles = Get-ChildItem "Data\Inventory\inventory_*.csv" | Sort-Object LastWriteTime -Descending

# Compare latest inventory with previous one
if ($inventoryFiles.Count -ge 2) {
    $latest = Import-Csv $inventoryFiles[0].FullName
    $previous = Import-Csv $inventoryFiles[1].FullName

    $changes = Compare-Object $previous $latest -Property DisplayName, DisplayVersion

    # Create reports directory if it doesn't exist
    if (-not (Test-Path -Path "Data\Reports")) {
        New-Item -ItemType Directory -Path "Data\Reports" | Out-Null
    }

    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $changes | Format-Table -AutoSize | Out-File "Data\Reports\report_$timestamp.txt"
    Write-Host "Report generated. Saved to Data\Reports\report_$timestamp.txt"
} else {
    Write-Host "Not enough inventory files to generate a report"
}