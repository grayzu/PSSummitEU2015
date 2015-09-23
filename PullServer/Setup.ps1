#############################################################
# PowerShell Summit Europe 2015 Pull Server version 2 Demo
# 
# This script is used to setup VM environment for Pull Demo's
#
#############################################################


$cred = Import-Clixml -Path C:\DemoScripts\PullServer\Admin.xml

#Prep local machine
    Write-Host "Starting configuration of Local Machine."
    #New-NetIPAddress -IPAddress '10.0.0.1' -PrefixLength 24 -InterfaceAlias 'vEthernet (DemoNet)' -AddressFamily IPv4
    #"`r`n10.0.0.10`tcorp.fabricam.com" | Out-File -FilePath 'c:\windows\system32\drivers\etc\hosts' -Encoding ascii -Append
    Write-Host "Completed: Local Machine setup"

#Prep Pull Server
    Write-Host "Starting configuration of Pull Server."
    #Copy required module
    dir $PSScriptRoot\Modules\ -Recurse -File | %{Copy-VMFile -Name Pull -SourcePath $_.FullName -DestinationPath $_.FullName -CreateFullPath -FileSource Host -Force}
    #dir $PSScriptRoot\site\ -Recurse -File | %{Copy-VMFile -Name Pull -SourcePath $_.FullName -DestinationPath $_.FullName -CreateFullPath -FileSource Host -Force}
    #Invoke-Command -VMName Pull -ScriptBlock{copy C:\Git\Examples\Configs\PSSummitEU2015\Site\* 'C:\inetpub\DscAdmin' -Recurse } -Credential $cred
    Invoke-Command -VMName Pull -ScriptBlock{copy C:\DemoScripts\PullServer\Modules\* 'C:\Program Files\WindowsPowerShell\Modules' -Recurse; del c:\DemoScripts -Recurse} -Credential $cred #Use PowerShell direct to run a script on a VM.

    
    #Copy and install private SSL certificate
    dir $PSScriptRoot\fabricam_ssl.pfx | Copy-VMFile -Name Pull -DestinationPath 'c:\temp\fabricam_ssl.pfx' -CreateFullPath -FileSource Host -Force
    Invoke-Command -VMName Pull -ScriptBlock {$Password = Read-Host -Prompt 'Enter Password for SSL Certificate:' -AsSecureString;Import-PfxCertificate -Password $Password -CertStoreLocation 'Cert:\LocalMachine\My' -FilePath 'c:\temp\fabricam_ssl.pfx'} -Credential $cred
    Invoke-Command -VMName Pull -ScriptBlock {del 'c:\temp' -Recurse} -Credential $cred
    Write-Host "   Completed: copied and installed SSL Certificate"

    #Set IP Address
    Invoke-Command -VMName Pull -ScriptBlock {New-NetIPAddress -IPAddress '10.0.0.10' -PrefixLength 24 -InterfaceAlias 'Ethernet' -AddressFamily IPv4} -Credential $cred
    Write-Host "   Completed: set Host IP Address"

    #Disable firewall
    Invoke-Command -VMName Pull -ScriptBlock {Set-NetFirewallProfile -Name Public -Enabled False;Set-NetFirewallProfile -Name Domain -Enabled False;Set-NetFirewallProfile -Name Private -Enabled False} -Credential $cred
    Write-Host "   Completed: disabled firewall"

    #Add DNS name to host file
    Invoke-Command -VMName Pull -ScriptBlock {"`r`n10.0.0.10`tcorp.fabricam.com" | Out-File -FilePath 'c:\windows\system32\drivers\etc\hosts' -Encoding ascii -Append} -Credential $cred
    Write-Host "   Completed: set hosts file"

    #Add Demo user
    Invoke-Command -VMName Pull -ScriptBlock {$CN = [ADSI]"WinNT://$env:computername";$user = $CN.Create("User","Demo");$user.SetPassword("<PasswordHere>");$user.UserFlags = 64 + 65536;$user.SetInfo();$Admins = [ADSI]"WinNT://$env:computername/Administrators,group";$Admins.Add("WinNT://$env:computername/Demo,user");} -Credential $cred
    Write-Host "   Completed: created Demo user"
    Write-Host "Completed: Pull server setup"

#Prep Target Node
    Write-Host ""
    Write-Host "Starting configuration of Target Server."
    #Copy public SSL certificate
    dir $PSScriptRoot\fabricam_ssl.cer | Copy-VMFile -Name Server -DestinationPath 'c:\temp\fabricam_ssl.cer' -CreateFullPath -FileSource Host -Force
    Invoke-Command -VMName Server -ScriptBlock {Import-Certificate -FilePath 'c:\temp\fabricam_ssl.cer' -CertStoreLocation Cert:\LocalMachine\Root} -Credential $cred
    Write-Host "   Completed: copied and installed SSL Certificate"

    #Set IP Address
    Invoke-Command -VMName Server -ScriptBlock {New-NetIPAddress -IPAddress '10.0.0.11' -PrefixLength 24 -InterfaceAlias 'Ethernet' -AddressFamily IPv4} -Credential $cred
    Write-Host "   Completed: set Host IP Address"

    #Disable Firewall
    Invoke-Command -VMName Server -ScriptBlock {Set-NetFirewallProfile -Name Public -Enabled False;Set-NetFirewallProfile -Name Domain -Enabled False;Set-NetFirewallProfile -Name Private -Enabled False} -Credential $cred
    Write-Host "   Completed: disabled firewall"

    #Add DNS name to host file
    Invoke-Command -VMName Server -ScriptBlock {"`r`n10.0.0.10`tcorp.fabricam.com" | Out-File -FilePath 'c:\windows\system32\drivers\etc\hosts' -Encoding ascii -Append} -Credential $cred
    Write-Host "   Completed: set hosts file"

    #Add Demo users
    Invoke-Command -VMName Server -ScriptBlock {$CN = [ADSI]"WinNT://$env:computername";$user = $CN.Create("User","Demo");$user.SetPassword("<PasswordHere>");$user.UserFlags = 64 + 65536;$user.SetInfo();$Admins = [ADSI]"WinNT://$env:computername/Administrators,group";$Admins.Add("WinNT://$env:computername/Demo,user");} -Credential $cred
    Invoke-Command -VMName Server -ScriptBlock {$CN = [ADSI]"WinNT://$env:computername";$user = $CN.Create("User","Employees");$user.SetPassword("<PasswordHere>");$user.UserFlags = 64 + 65536;$user.SetInfo();} -Credential $cred
    Invoke-Command -VMName Server -ScriptBlock {$CN = [ADSI]"WinNT://$env:computername";$user = $CN.Create("User","Managers");$user.SetPassword("<PasswordHere>");$user.UserFlags = 64 + 65536;$user.SetInfo();} -Credential $cred
    #Invoke-Command -VMName Server -ScriptBlock {$CN = [ADSI]"WinNT://$env:computername";$user = $CN.Create("User","Finance");$user.SetPassword("<PasswordHere>");$user.UserFlags = 64 + 65536;$user.SetInfo();} -Credential $cred
    Write-Host "   Completed: created Demo user"
    Write-Host "Completed: Target server setup"