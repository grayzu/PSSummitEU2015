
Configuration Meta
{
    Node $AllNodes.NodeName
    {
        LocalConfigurationManager
        {
            RefreshMode                = 'Pull'
            ConfigurationID            = $Node.ConfigurationID
            DownloadManagerName        = 'WebDownloadManager'
            DownloadManagerCustomData  = @{ServerUrl='http://corp.fabricam.com/PSDSCPullServer.svc';AllowUnsecureConnection = "True"}
        }
    }
}

Meta -ConfigurationData "$PSScriptRoot\TargetNodeConfigData.psd1" -OutputPath 'C:\Demos\PSSummitEurope2015\MOF\V1' -Verbose