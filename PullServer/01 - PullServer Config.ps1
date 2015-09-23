
Configuration V2PullServer
{
    param(
            [Parameter(Mandatory)]
            [ValidateNotNullOrEmpty()]
            [string] $SSLCertThumbprint
    )

    Import-DscResource -ModuleName xPsDesiredStateConfiguration

    node localhost
    {
        WindowsFeature DSCServiceFeature
        {
            Ensure = "Present"
            Name   = "DSC-Service"            
        }

        xDscWebService PSDSCPullServer
        {
            Ensure                       = "Present"
            EndpointName                 = "PSDSCService"
            Port                         = 443
            PhysicalPath                 = "c:\inetpub\PullServer"
            CertificateThumbPrint        = $SSLCertThumbprint                  
            State                        = "Started"
            DependsOn                    = "[WindowsFeature]DSCServiceFeature" 
            AcceptSelfSignedCertificates = $true
        }

        File RegistrationKeyFile
        {
            Ensure          ='Present'
            Type            = 'File'
            DestinationPath = "$env:ProgramFiles\WindowsPowerShell\DscService\RegistrationKeys.txt"
            Contents        = '9a28a925-18d9-4689-a591-5a0c53ab73b2'
        }
    }
}

$SSLCertFilePath = "$PSScriptRoot\fabricam_ssl.pfx"
$SSLThumbprint = (Get-PfxCertificate -FilePath $SSLCertFilePath).Thumbprint

V2PullServer -SSLCertThumbprint $SSLThumbprint -OutputPath C:\Demos\PSSummitEurope2015\MOF