##
## Long running script
##

function Get-ProcessInfo
{
    param (
        $Process
    )

    $IsPowerShellProcess = ($Process.ProcessName -like "powershell*")
    $IsPowerShelHostProcess = (($Process.Modules | ? ModuleName -match "system.management.automation") -ne $null)
    
    return @{
        Name=$Process.ProcessName;
        StartTime=$Process.StartTime;
        SessionId=$Process.SessionId;
        Alive=$Process.Responding;
        ThreadCount=$Process.Threads.Count;
        HandleCount=$Process.Handles.Count;
        ModuleCount=$Process.Modules.Count;
        WorkingSet=$Process.WorkingSet;
        IsPowerShellProcess = $IsPowerShellProcess;
        IsPowerShellHostProcess = $IsPowerShelHostProcess;
    }
}

"Starting script"

$count = 1
Get-Process | foreach {
    sleep 1
    "Process count: $count"; $count++

    ""
    Get-ProcessInfo $_
    ""
}

"Script complete"
