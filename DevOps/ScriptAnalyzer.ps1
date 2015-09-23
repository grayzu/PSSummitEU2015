#region prep
# static code analysis 
Install-Module PSScriptAnalyzer
#GitHub https://github.com/PowerShell/PSScriptAnalyzer/releases
cd C:\Git\Examples\Configs\PSSummitEU2015\DevOps\Website
#endregion

#Get list of rules that will be analysed
Get-ScriptAnalyzerRule
Get-ScriptAnalyzerRule -Name PSDSC*
Get-ScriptAnalyzerRule -Severity Error
Get-ScriptAnalyzerRule -CustomizedRulePath C:\Git\nScriptAnalyzerRules\nScriptAnalyzerRules.psd1

#In-line Suppress ??
#[Diagnostics.CodeAnalysis.SuppressMessageAttribute("*")]
#Script or Function level

#Builtin Rules
Invoke-ScriptAnalyzer -Path .\ -Recurse

#Ignore Rule
Invoke-ScriptAnalyzer -Path .\ -Recurse -ExcludeRule 'PSAvoidUsingInternalURLs'

#Only Specified rules
Invoke-ScriptAnalyzer -Path .\ -Recurse -IncludeRule 'PSAvoidUsingCmdletAliases',inv

#Custom Rule
Invoke-ScriptAnalyzer -Path .\ -Recurse -CustomizedRulePath C:\Git\nScriptAnalyzerRules\nScriptAnalyzerRules.psd1
Invoke-ScriptAnalyzer -Path .\ -Recurse -Severity Error, Warning


#Profile
$myProfile = @{
    Severity='Warning';
    IncludeRules=@('PSAvoidUsingCmdletAliases',
                    'PSAvoidUsingPositionalParameters',
                    'PSAvoidUsingInternalURLs',
                    'PSAvoidUninitializedVariable')
    ExcludeRules=@('PSAvoidUsingCmdletAliases'
                   'PSAvoidUninitializedVariable')
}

Invoke-ScriptAnalyzer -path .\WebsiteConfig.ps1 -Profile $myProfile