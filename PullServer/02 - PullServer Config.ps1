
Configuration V2PullServer
{
    param(
            [Parameter(Mandatory)]
            [ValidateNotNullOrEmpty()]
            [string] $SSLCertThumbprint
    )

    Import-DscResource -ModuleName xPsDesiredStateConfiguration
    Import-DscResource -ModuleName xWebAdministration

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
            Ensure           ='Present'
            Type             = 'File'
            DestinationPath  = "$env:ProgramFiles\WindowsPowerShell\DscService\RegistrationKeys.txt"
            Contents         = '9a28a925-18d9-4689-a591-5a0c53ab73b2'
        }

        #Install WebApp for managing Configurations / resources
        File AdminSite
        {
            Ensure          = 'Present'
            Type            = 'Directory'
            DestinationPath = 'c:\inetpub\DscAdmin'
        }
    
        xRemoteFile SiteContents
        {
            Uri             = 'http://PSDemo45/Assets/site.zip'
            DestinationPath = 'c:\inetpub\temp\site.zip'
        }

        xArchive SiteContents
        {
            Path            = 'c:\inetpub\temp\site.zip'
            Destination     = 'c:\inetpub\DscAdmin\'
            DestinationType = 'Directory'
        }

        xWebAppPool PSWS
        {
             Ensure                = 'Present'
             Name                  = 'PSWS'
             State                 = 'Started'
             Enable32BitAppOnWin64 = $true
        }

        xWebApplication DscAdmin
        {
            Ensure          = 'Present'
            Name            = 'Admin'
            Website         = 'Default Web Site'
            PhysicalPath    = 'c:\Inetpub\DSCAdmin'
            WebAppPool      = 'PSWS'
        }
    }
}

$SSLCertFilePath = "$PSScriptRoot\fabricam_ssl.pfx"
$SSLThumbprint = (Get-PfxCertificate -FilePath $SSLCertFilePath).Thumbprint
              
V2PullServer -SSLCertThumbprint $SSLThumbprint -OutputPath C:\Demos\PSSummitEurope2015\MOF