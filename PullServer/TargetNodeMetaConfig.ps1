
[DscLocalConfigurationManager()]
Configuration MetaConfig
{
    
    Settings
    {
        RefreshMode          = 'Pull'
        ConfigurationMode    = 'ApplyAndAutoCorrect'
        ActionAfterReboot    = 'ContinueConfiguration'
        RebootNodeIfNeeded   = $true
    }

    ConfigurationRepositoryWeb V2PullServer
    {
        ServerURL           = 'https://corp.fabricam.com/PSDSCPullServer.svc/'
        #ConfigurationNames = 'Basic.FileServer' # This can be used to bootstrap target node with configuration during registration
        RegistrationKey     = '9a28a925-18d9-4689-a591-5a0c53ab73b2'
    }

    ResourceRepositoryWeb V2PullServer
    {
        ServerURL         = 'https://corp.fabricam.com/PSDSCPullServer.svc/'
        RegistrationKey   = '9a28a925-18d9-4689-a591-5a0c53ab73b2'
    }

    ReportServerWeb V2PullServer
    {
        ServerURL         = 'https://corp.fabricam.com/PSDSCPullServer.svc/'
        RegistrationKey   = '9a28a925-18d9-4689-a591-5a0c53ab73b2'
    }
}

MetaConfig -OutputPath C:\Demos\PSSummitEurope2015\MOF\TargetNodes