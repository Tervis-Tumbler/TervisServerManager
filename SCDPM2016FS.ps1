Configuration SCDPM2016
{
#    Param(
#        [string[]]$ComputerName
#
#    )
    Import-DscResource –Module PSDesiredStateConfiguration
    Import-DscResource -Module xDismFeature
    Import-DscResource -Module xSqlServer
    Import-DscResource -Module xSCDPM

    Node $AllNodes.NodeName
    {
        WindowsFeature Deduplication
        {
            Ensure = “Present”
            Name = “FS-Data-Deduplication”
            IncludeAllSubFeature = $true
        }
        WindowsFeature MPIO
        {
            Ensure = “Present”
            Name = “Multipath-IO”
        }
        WindowsFeature SNMP
        {
            Ensure = “Present”
            Name = “SNMP-Service”
            IncludeAllSubFeature = $true
        }
        WindowsFeature Hyper-V
        {
            Ensure = “Present”
            Name = “Hyper-V”
            IncludeAllSubFeature = $true
        }
        WindowsFeature Hyper-V-Powershell
        {
            Ensure = “Present”
            Name = “Hyper-V-Powershell”
            IncludeAllSubFeature = $true
        }
        Registry MPIO1
        {
            Ensure = "Present"  # You can also set Ensure to "Absent"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\MPDEV"
            ValueType = "Multistring"
            ValueName = "MPIOSupportedDeviceList"
            ValueData = "DGC     RAID 3","DGC     RAID 5","DGC     RAID 1","DGC     RAID 0","DGC     RAID 10","DGC     VRAID","DGC     DISK","DGC     LUNZ","DELL    Universal Xport","DELL    MD38xx"
        }
        Registry MPIO2
        {
            Ensure = "Present"  # You can also set Ensure to "Absent"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\msdsm\Parameters"
            ValueType = "Multistring"
            ValueName = "DsmSupportedDeviceList"
            ValueData = "DGC     RAID 3","DGC     RAID 5","DGC     RAID 1","DGC     RAID 0","DGC     RAID 10","DGC     VRAID","DGC     DISK","DGC     LUNZ","DELL    Universal Xport","DELL    MD38xx"
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
        Group SCDPMUserAddToAdministratorsGroup
        {
            GroupName = 'Administrators'
            Ensure = "Present"
            MembersToInclude = "tervis\domain admins","tervis\scdpm"
        }
        WindowsFeature "NET"
        {
            Ensure = "Present"
            Name = "NET-Framework-Core"
            Source = "\\dfs-10\DisasterRecovery\Programs\Microsoft\Windows 2016 Sources\sources\sxs"
        }
    }
}

