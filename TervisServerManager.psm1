function Install-TervisDesiredStateConfiguration {
    [CmdletBinding()]
    param (
        $ComputerName,
        $ApplicationName
    )    
    $DesiredStateConfigurationDefinition = $ApplicationName | Get-DesiredStateConfigurationDefinition
    if ($DesiredStateConfigurationDefinition) {
        $TempPath = $env:TEMP
        . $DesiredStateConfigurationDefinition.DSCConfigurationFile
        $ConfigurationData = $desiredstateconfigurationdefinition.dscconfiguration.Clone()
        $DSCConfigurationName = $DesiredStateConfigurationDefinition.Name
        $ConfigurationData.AllNodes += @{"Nodename" = $ComputerName}
        foreach ($PSLibraryRequiredModule in $desiredstateconfigurationdefinition.PSLibraryModuleRequirements){
            Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                Install-Module -Name $Using:PSLibraryRequiredModule -Force
            }
        }

        New-Item -Path "$TempPath\$DSCConfigurationName" -ItemType Directory
        & $DSCConfigurationName -ConfigurationData $ConfigurationData -OutputPath "$TempPath\$DSCConfigurationName"
        Start-DscConfiguration -ComputerName $ComputerName -path $TempPath\$DSCConfigurationName -Wait -Verbose -Force
        remove-item -path $TempPath\$DSCConfigurationName -recurse -force
    }
}

function Install-TervisWindowsFeature {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]$ComputerName,
        $Credential = [System.Management.Automation.PSCredential]::Empty,
        $WindowsFeatureGroupNames
    )
    begin {    
    $WindowsFeatureGroups = $WindowsFeatureGroupNames | Get-WindowsFeatureGroup
    $WindowsFeatures = $WindowsFeatureGroups.WindowsFeature | sort -Unique
    }
    process {
        if ($WindowsFeatures) {
            if ($Credential -ne [System.Management.Automation.PSCredential]::Empty) {
                Install-WindowsFeature -Name $WindowsFeatures -ComputerName:$ComputerName -Credential:$Credential
            } else {
                Install-WindowsFeature -Name $WindowsFeatures -ComputerName:$ComputerName
            }
        }
    }
}

function Get-WindowsFeatureGroup {
    param (
        [Parameter(Mandatory,ValueFromPipeline)]$Name
    )
    process {
        $WindowsFeatureGroups | where Name -eq $Name
    }
}

function Get-DesiredStateConfigurationDefinition {
    param (
        [Parameter(Mandatory,ValueFromPipeline)]$ApplicationName
    )
    process {
        $WindowsDesiredStateConfigurationDefinitions | where Name -eq $ApplicationName
    }
}

$WindowsDesiredStateConfigurationDefinitions = [PSCustomObject][Ordered]@{
    Name = "SCDPM2016"
    DSCConfigurationfile = "$PSScriptRoot\SCDPM2016.ps1"
    PSLibraryModuleRequirements = "xSqlServer"
    DSCConfiguration = @{
        AllNodes = @(
                @{
                Nodename = "*"
                NETPath = "\\dfs-10\DisasterRecovery\Programs\Microsoft\Windows 2016 Sources\sources\sxs"
                }
        )
    }
},
[PSCustomObject][Ordered]@{
    Name = "OraDBARMT"
    DSCConfigurationfile = "$PSScriptRoot\OraDBARMT.ps1"
    DSCConfiguration = @{
        AllNodes = @(
                @{
                Nodename = "*"
                NETPath = "\\dfs-10\DisasterRecovery\Programs\Microsoft\Windows 2016 Sources\sources\sxs"
                }
        )
    }
},
[PSCustomObject][Ordered]@{
    Name = "SCDPM2016SQL"
    DSCConfigurationfile = "$PSScriptRoot\SCDPM2016SQL.ps1"
    DSCConfiguration = @{
        AllNodes = @(
                @{
                Nodename = "*"
                NETPath = "\\dfs-10\DisasterRecovery\Programs\Microsoft\Windows 2016 Sources\sources\sxs"
                }
        )
    }
},
[PSCustomObject][Ordered] @{
    Name = "WindowsFileServer"
    DSCConfigurationFile = "WindowsFileserver.ps1"
}


$WindowsFeatureGroups = [PSCustomObject][Ordered] @{
    Name = "BartenderCommander"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "RMSHQManagerRemoteApp"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "RemoteWebBrowserApp"
    WindowsFeature = @"
RDS-RD-Server
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "StoresRemoteDesktop"
    WindowsFeature = @"
RDS-RD-Server
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "Progistics"
    WindowsFeature = @"
Web-Server
Web-WebServer
Web-Common-Http
Web-Default-Doc
Web-Dir-Browsing
Web-Http-Errors
Web-Static-Content
Web-Health
Web-Http-Logging
Web-Performance
Web-Stat-Compression
Web-Security
Web-Filtering
Web-App-Dev
Web-ASP
Web-ISAPI-Ext
Web-Mgmt-Tools
Web-Mgmt-Console
Web-Scripting-Tools
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Features
NET-Framework-45-Core
NET-WCF-Services45
NET-WCF-TCP-PortSharing45
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "WCSJavaApplication"
    WindowsFeature = @"
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "HyperVCluster5"
    WindowsFeature = @"
Hyper-V
Hyper-V-Tools
Hyper-V-PowerShell
Failover-Clustering
Multipath-IO
RSAT-Clustering-Mgmt
RSAT-Clustering-PowerShell
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "HyperVCluster6"
    WindowsFeature = @"
Hyper-V
Hyper-V-Tools
Hyper-V-PowerShell
Failover-Clustering
Multipath-IO
RSAT-Clustering-Mgmt
RSAT-Clustering-PowerShell
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "VDICluster1"
    WindowsFeature = @"
Hyper-V
Hyper-V-Tools
Hyper-V-PowerShell
Multipath-IO
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "StandaloneHyperVServer"
    WindowsFeature = @"
Hyper-V
Hyper-V-Tools
Hyper-V-PowerShell
Multipath-IO
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "ScheduledTasks"
    WindowsFeature = @"
RSAT-Clustering-PowerShell
RSAT-AD-PowerShell
RSAT-RemoteAccess-PowerShell
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "PrintServer"
    WindowsFeature = @"
Print-Internet
Print-LPD-Service
Print-Server
RSAT-Print-Services
SNMP-Service
Telnet-Client
Web-ASP
Web-Basic-Auth
Web-Default-Doc
Web-Dir-Browsing
Web-Filtering
Web-Http-Errors
Web-Http-Logging
Web-Http-Redirect
Web-Http-Tracing
Web-ISAPI-Ext
Web-ISAPI-Filter
Web-Log-Libraries
Web-Metabase
Web-Mgmt-Service
Web-Mgmt-Console
Web-Net-Ext45
Web-Request-Monitor
Web-Scripting-Tools
Web-Stat-Compression
Web-Static-Content
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "DirectAccess"
    WindowsFeature = @"
CMAK
DirectAccess-VPN
GPMC
Routing
RSAT-RemoteAccess
RSAT-RemoteAccess-Mgmt
RSAT-RemoteAccess-PowerShell
SNMP-Service
Telnet-Client
Web-Application-Proxy
Web-Static-Content
Web-Basic-Auth
Web-Default-Doc
Web-Dir-Browsing
Web-Filtering
Web-Http-Errors
Web-Http-Logging
Web-Http-Redirect
Web-Http-Tracing
Web-ISAPI-Ext
Web-ISAPI-Filter
Web-Log-Libraries
Web-Metabase
Web-Mgmt-Service
Web-Mgmt-Console
Web-Request-Monitor
Web-Scripting-Tools
Web-Stat-Compression
Web-Static-Content
Windows-Internal-Database
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "OracleDBA Remote Desktop"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
SNMP-Service
RDS-RD-Server
RSAT-Feature-Tools
RSAT-SNMP
RDS-RD-Server
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "RemoteDesktopGateway"
    WindowsFeature = @"
RDS-Gateway
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "iSNS"
    WindowsFeature = @"
ISNS
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "RemoteDesktopLicensing"
    WindowsFeature = @"
RDS-Licensing
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "ADFS"
    WindowsFeature = @"
ADFS-Federation
NET-Framework-45-Features
NET-Framework-45-Core
NET-WCF-Services45
NET-WCF-TCP-PortSharing45
RSAT-AD-Tools
RSAT-AD-PowerShell
Telnet-Client
Windows-Internal-Database
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "ADFSProxy"
    WindowsFeature = @"
RemoteAccess
Web-Application-Proxy
NET-Framework-45-Features
NET-Framework-45-Core
NET-WCF-Services45
NET-WCF-TCP-PortSharing45
GPMC
CMAK
RSAT-RemoteAccess
RSAT-RemoteAccess-Mgmt
RSAT-RemoteAccess-PowerShell
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "DomainController"
    WindowsFeature = @"
AD-Domain-Services
DNS
FileAndStorage-Services
File-Services
FS-FileServer
Storage-Services
NET-Framework-45-Features
NET-Framework-45-Core
NET-WCF-Services45
NET-WCF-TCP-PortSharing45
GPMC
RDC
RSAT
RSAT-Feature-Tools
RSAT-SNMP
RSAT-Role-Tools
RSAT-AD-Tools
RSAT-AD-PowerShell
RSAT-ADDS
RSAT-AD-AdminCenter
RSAT-ADDS-Tools
RSAT-DNS-Server
SNMP-Service
SNMP-WMI-Provider
Telnet-Client
Windows-Server-Backup
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "FedExShipManager"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "ZeroTier Router"
    WindowsFeature = @"
Routing
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "SCCM2016"
    WindowsFeature = @"
BITS
NET-Framework-45-Core
NET-Framework-45-ASPNET
Telnet-Client
UpdateServices-RSAT
Web-Static-Content
Web-Default-Doc
Web-Dir-Browsing
Web-Http-Errors
Web-Http-Logging
Web-Request-Monitor
Web-Filtering
Web-Stat-Compression
Web-Metabase
Web-Asp-Net
Web-Asp-Net45
Web-Windows-Auth
Web-WMI
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "SCDPMOraBackups"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Core
NET-Framework-45-ASPNET
SNMP-Service
FS-Data-Deduplication
Multipath-IO
Hyper-V-PowerShell
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "SCDPM2016FileServer"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Core
NET-Framework-45-ASPNET
SNMP-Service
FS-Data-Deduplication
Multipath-IO
Hyper-V-PowerShell
"@ -split "`r`n" 
}

function Compare-WindowsFeatureBetweenComputers {
    param (
        $ReferenceComputer,
        $DifferenceComputer
    )
    $Reference = Get-WindowsFeature -ComputerName $ReferenceComputer
    $Difference = Get-WindowsFeature -ComputerName $DifferenceComputer
    Compare-Object -ReferenceObject $Reference -DifferenceObject $Difference -Property Name,InstallState
}

function Set-StaticNetworkConfiguration {
    param(
        [parameter(Mandatory)]$IPAddress,
        [parameter(Mandatory)]$Gateway,
        [parameter(Mandatory)]$Prefix,
        [parameter(Mandatory)]$DNSServers,
        [parameter(Mandatory)]$NetAdapterName
    )
    
    $IPAddress = $IPAddress;
    $Gateway = $Gateway;
    $Prefix = $Prefix;
    $DNSServer = $DNSServers;
    Import-Module NetAdapter ;
    $NetAdapter = Get-NetAdapter -Name $NetAdapterName;
    $NetAdapter | Set-NetIPInterface -DHCP Disabled;
    $NetAdapter | New-NetIPAddress -AddressFamily IPv4 -IPAddress $IPAddress -PrefixLength $Prefix -Type Unicast -DefaultGateway $Gateway;
    Set-DnsClientServerAddress -InterfaceAlias $NetAdapterName -ServerAddresses $DNSServers;
}

function Invoke-InstallWindowsFeatureViaDISM {
    param(
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]$Computername,
        [parameter(Mandatory)]$FeatureName,
        [switch]$NoRestart
    )
    if(-not (get-windowsoptionalfeature -FeatureName $FeatureName -Online)){
        $Command = "dism /online /enable-feature /featurename:$FeatureName /all /NoRestart"
        Invoke-PsExec -ComputerName $Computername -Command $Command -IsPSCommand -IsLongPSCommand
        if (-not ($NoRestart)){
            if (Get-PendingRestart -ComputerName $Computername){
                Restart-Computer -ComputerName $Computername -Force
            }
        }

    }
    
}