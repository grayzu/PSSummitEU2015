#region prep
cd C:\DemoScripts\Debugging
$cred = Import-Clixml -Path C:\DemoScripts\PullServer\Admin.xml
#endregion prep

# Break into running script
# '.\LongRunning.ps1'

#Edit and debug remote script

Enter-PSSession corp.fabricam.com -Credential $cred
cd C:\Configs\
PSEdit .\LongRunning.ps1
exit

#Debug job
# job needs to reference full path since job creates new session which will have default path
Start-Job {& 'C:\DemoScripts\Debugging\LongRunning.ps1'} -Name "Debug"
Get-Job
Debug-job -Name Debug
Detach
Quit

#Debug process / runspace
#Launch c:\DemoScripts\MyScript.ps1 in PS console
$ProcessId = (Get-PSHostProcessInfo | where {$_.ProcessName -eq 'Powershell'}).ProcessId
Enter-PSHostProcess -Id $ProcessId
$RunspaceId = (Get-Runspace | where {$_.Name -notcontains "RemoteHost"}).Id
Debug-Runspace -Id $RunspaceId

#Debug DSC Configuration
#Run from PS console
start-process powershell.exe -ArgumentList '-noexit', @' 
                                                -command 
                                                $s = new-PSSession corp.fabricam.com -Credential Administrator; 
                                                icm $s {Enable-DscDebug -BreakAll
                                                & 'c:\configs\Config.ps1'}
'@

Enter-PSSession corp.fabricam.com -Credential $cred
# enter commands per Warning messages

