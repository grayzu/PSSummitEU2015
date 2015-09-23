$cred = Import-Clixml -Path C:\DemoScripts\PullServer\Admin.xml
dir C:\Demos\PSSummitEurope2015\MOF\localhost.mof | Copy-VMFile -Name Pull -DestinationPath 'c:\Configs\MOF\localhost.mof' -CreateFullPath -FileSource Host -Force
Invoke-Command -VMName Pull -ScriptBlock {Start-DscConfiguration -Path 'C:\Configs\MOF' -Wait -Verbose -Force} -Credential $cred