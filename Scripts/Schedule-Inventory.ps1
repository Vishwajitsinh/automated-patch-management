# Example: Schedule Inventory.ps1 to run nightly at 2 AM
$trigger = New-ScheduledTaskTrigger -Daily -At 2am
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File .\Scripts\Inventory.ps1"
Register-ScheduledTask -TaskName "PatchManagement_Inventory" -Trigger $trigger -Action $action -RunLevel Highest -Force
