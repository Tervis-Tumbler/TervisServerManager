Configuration WindowsFileserver
{
param (
    [Parameter(Mandatory=$true)] $Computername
)
    Node $Computername
    {
        Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
        WindowsFeature Deduplication
        {
            Ensure = “Present”
            Name = “FS-Data-Deduplication”
            IncludeAllSubFeature = $true
        }
        WindowsFeature DSFR
        {
            Ensure = “Present”
            Name = “FS-DFS-Replication”
            IncludeAllSubFeature = $true
        }
        WindowsFeature DSFN
        {
            Ensure = “Present”
            Name = “FS-DFS-Namespace”
            IncludeAllSubFeature = $true
        }
        WindowsFeature FS-NFS-Service
        {
            Ensure = “Present”
            Name = "FS-NFS-Service”
            IncludeAllSubFeature = $true
        }
        WindowsFeature File-Services-Management
        {
            Ensure = “Present”
            Name = "RSAT-File-Services”
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
        Registry DFS-KeepInheritance
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerforNFS\CurrentVersion\Mapping"
            ValueType = "DWORD"
            ValueName = "KeepInheritance"
            ValueData = "1"
        }

    }
}
