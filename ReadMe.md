##Description
This Repo contains PowerShell and Desired State Configuration examples used in the following presentations at the PowerShell Summit Europe 2015 in Stockholm Sweden:

##Session (YouTube Videos)
- [Enabling DevOPs using PowerShell 5.0](https://www.youtube.com/watch?v=90zjUk0pJ1w)
- [What's Up with DSC Pull Server](https://www.youtube.com/watch?v=y3-_XBQTpS8)
- [What's new in DSC](https://www.youtube.com/watch?v=0Jc4qNZabU8)

##Repo Contents
The contents for each session are stored in an individual folder ... for the most part. Since we did not have time to finish some of the content in some sessions, we covered the content in a later session.

- \Debugging\\* contains content from the _Enabling DevOps using PowerShell 5.0_ session. Also covered in _What's New in DSC_ session.
- \DevOps\\* contains content from _Enabling DevOps using PowerShell 5.0_ session.
- \PullServer\\* contains content from _What's Up with DSC Pull Server_ session.

###File Details
| Path           |  File Name   | Description          |
| ------------- | ------------ | -------------------- |
| Assets        | site.zip     | Pull Server ASP.Net WebApp content.|
| Debugging     | 00 - debugging flow.ps1 | Script used to demonstrate new debugging functionality. |
| Debugging     | config.ps1 | DSC configuration run on remote server and debugged. |
| Debugging     | longrunning.ps1 | Simple script that runs for long time allowing time to debug into it. |
| DevOps	| Assert-SiteTests.ps1 | Sample script that performs basic CI functionality for Pester and Script Analyzer scripts.|
| DevOps	| Pester.ps1 | Sample execution of pester against website configuration and resources. |
| DevOps	| ScriptAnalyzer.ps1 | Sample execution of Script Analyzer tests against website configurations and resources. |
| DevOps\Website | * | Sample website content and resources used for testing. |
| DevOps\Website\Tests | WebsiteConfig.Tests.ps1 | Sample unit tests for website configuration. |
| PullServer | 01 - PullServer Config.ps1 | Sample configuration used to deploy V2 pull server. |  
| PullServer | 01 - PullServer Config.ps1 | Sample configuraiton used to deploy V2 pull server and sample PullServer WebApp. | 
| PullServer | *.xml | CliXML files used to pass credentials into scripts. Replace these with your own CliXML files in order to run sample scripts successfully. |
| PullServer | Assert-PullServer.ps1 | Script use to deploy dsc configuration which configures the V2 Pull Server. |
| PullServer | Assert-TargetNode.ps1 | Script used to deploy meta-configuration to target node which tells it to get its configuration from the v2 pull server. |
| PullServer | Fabricam_ssl.* | SSL Certficates used to configure pull server to use HTTPS. | 
| PullServer | Setup.ps1 | Script used to do initial configuration of demo environment. |
| PullServer | TargetNodeConfigs.ps1 | Configuration which generates target noded configurations that are posted to the pull server for retrieval by target node. |
| PullServer | TargetNodeMetaConfig.ps1 | Meta-Configuration script for target nodes which will point them to the pull server. |
| PullServer\Assets | * | Contains Pull Server ASP.Net WebApp content. |
| PullServer\Modules | * | Modules required for configurations. Copy these to your modules directory in order to execute scripts. |
| PullServer\V1 | * | Sample configurations and scripts demonstarting target node configuration and resulting mofs for pull server version 1. |

##Also see
[DSC Pull Server UI](https://github.com/grayzu/DSCPullServerUI) repo for the sample application source code.
