Configuration OraDBARMT
{
#    Param(
#        [string[]]$ComputerName
#
#    )
    Import-DscResource –Module PSDesiredStateConfiguration

    Node $AllNodes.NodeName
    {
        WindowsFeature SNMP
        {
            Ensure = “Present”
            Name = “SNMP-Service”
            IncludeAllSubFeature = $true
        }
        Registry SNMP-PermittedManagers
        {
            Ensure = "Present"  # You can also set Ensure to "Absent"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\PermittedManagers"
            ValueType = "String"
            ValueName = "2"
            ValueData = "orion.tervis.prv"
        }
        Registry SNMP-ValidCommunities
        {
            Ensure = "Present"  # You can also set Ensure to "Absent"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\Validcommunities"
            ValueType = "DWORD"
            ValueName = "ttComStr201"
            ValueData = "4"
        }
        Group AdministratorsGroup
        {
            GroupName = 'Administrators'
            Ensure = "Present"
            MembersToInclude = "tervis\domain admins"
        }
        WindowsFeature "NET"
        {
            Ensure = "Present"
            Name = "NET-Framework-Core"
            Source = "\\dfs-10\DisasterRecovery\Programs\Microsoft\Windows 2016 Sources\sources\sxs"
        }
    }
}

