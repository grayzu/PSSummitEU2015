#Unit testing with Pester

cd C:\Git\Examples\Configs\PSSummitEU2015\DevOps

#Run a single test script
Invoke-Pester -Path .\Website\Tests\WebsiteConfig.Tests.ps1

#Run test and get code coverage numbers
Invoke-Pester -Path .\Website\Tests\WebsiteConfig.Tests.ps1 -CodeCoverage .\Website\WebsiteConfig.ps1

#Run all tests in a folder and sub folders
Invoke-Pester 

#Run all tests and output in format that CI tools can understand
Invoke-Pester -OutputFile .\Website\output.xml -OutputFormat NUnitXml -Quiet