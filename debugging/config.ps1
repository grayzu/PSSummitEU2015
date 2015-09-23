
Configuration Simple
{
    Environment AppSetting
    {
        Ensure = 'Present'
        Name   = 'SpellChecking'
        Value  = 'Enabled'
    }

    Service WinRM
    {
        Ensure = 'Present'
        State  = 'Running'
        Name   = 'WinRM'
    }
}

Simple -OutputPath C:\DemoScripts\MOF\Debugging

Start-DscConfiguration -Path C:\DemoScripts\MOF\Debugging -Wait -Verbose