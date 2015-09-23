cd C:\Git\Examples\Configs\PSSummitEU2015\DevOps


#Static code analysis 
if (! (Get-Module PSScriptAnalyzer -ListAvailable))
{
    Install-Module -Name PSScriptAnalyzer -Force
}

$StaticResults = Invoke-ScriptAnalyzer -Path .\ -Recurse -Severity Error, Warning

if ($StaticResults.count -eq 0)
{
    #Unit tests

    Invoke-Pester -OutputFile .\Website\output.xml -OutputFormat NUnitXml -Quiet -ErrorAction SilentlyContinue

    $UnitResults = ConvertTo-Xml .\website\output.xml

    If($UnitResults)
    { 
        $BGColor = $Host.UI.RawUI.BackgroundColor
        $FGColor = $Host.UI.RawUI.ForegroundColor

        $Host.UI.RawUI.BackgroundColor = "Black"
        $Host.UI.RawUI.ForegroundColor = "Red"

        #### ADD message to be displayed here ####
        Write-Host "UNIT TESTING FAILED"
        Write-Host "Details of test failure:"
        Write-Host ""
        Write-Host ""

        $Host.UI.RawUI.BackgroundColor = $BGColor
        $Host.UI.RawUI.ForegroundColor = $FGColor
    }
}
else
{ 
    $BGColor = $Host.UI.RawUI.BackgroundColor
    $FGColor = $Host.UI.RawUI.ForegroundColor

    $Host.UI.RawUI.BackgroundColor = "Black"
    $Host.UI.RawUI.ForegroundColor = "Red"

    #### ADD message to be displayed here ####
    Write-Host "STATIC ANALYSIS FAILED"
    Write-Host "Details of analysis failure:"
    Write-Host ""
    Write-Host $StaticResults

    $Host.UI.RawUI.BackgroundColor = $BGColor
    $Host.UI.RawUI.ForegroundColor = $FGColor
}


#Integration tests
