$cred = Import-Clixml -Path C:\DemoScripts\PullServer\Admin.xml
dir C:\Demos\PSSummitEurope2015\MOF\TargetNodes\localhost.meta.mof | Copy-VMFile -Name Server -DestinationPath 'c:\Configs\MOF\localhost.meta.mof' -CreateFullPath -FileSource Host -Force
Invoke-Command -VMName Server -ScriptBlock {Set-DscLocalConfigurationManager -Path C:\Configs\MOF\ -Verbose} -Credential $cred