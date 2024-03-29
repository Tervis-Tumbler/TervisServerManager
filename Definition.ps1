﻿$WindowsFeatureGroups = [PSCustomObject][Ordered] @{
    Name = "BartenderCommander"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
RSAT-AD-PowerShell
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
RSAT-AD-PowerShell
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "WCSJavaApplication"
    WindowsFeature = @"
RSAT-AD-PowerShell
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
    Name = "HyperVCluster5Evergreen"
    WindowsFeature = @"
Hyper-V
Hyper-V-PowerShell
Failover-Clustering
Multipath-IO
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
    Name = "HyperVCluster6Evergreen"
    WindowsFeature = @"
Hyper-V
Hyper-V-PowerShell
Failover-Clustering
Multipath-IO
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
    Name = "VPNTest"
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
    Name = "AlwaysOn"
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
    Name = "VendorVPN"
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
    Name = "SCCM2019"
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
    Name = "SCDPM2016"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Core
NET-Framework-45-ASPNET
SNMP-Service
SNMP-WMI-Provider
FS-Data-Deduplication
Multipath-IO
Hyper-V-PowerShell
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "SCDPMOraBackups"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Core
NET-Framework-45-ASPNET
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
},
[PSCustomObject][Ordered] @{
    Name = "AzureBackupServer"
    WindowsFeature = @"
FS-Data-Deduplication
SNMP-Service
Hyper-V-PowerShell
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Core
NET-Framework-45-ASPNET
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "SMTPRelay"
    WindowsFeature = @"
SNMP-Service
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Core
NET-Framework-45-ASPNET
SMTP-Server
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "ITToolbox"
    WindowsFeature = @"
RSAT
RSAT-Feature-Tools
RSAT-Clustering
RSAT-Clustering-Mgmt
RSAT-Clustering-PowerShell
RSAT-SNMP
RSAT-Role-Tools
RSAT-AD-Tools
RSAT-AD-PowerShell
RSAT-ADDS
RSAT-AD-AdminCenter
RSAT-ADDS-Tools
RSAT-ADLDS
RSAT-Hyper-V-Tools
RSAT-RDS-Tools
RSAT-RDS-Gateway
RSAT-RDS-Licensing-Diagnosis-UI
RSAT-ADCS
RSAT-ADCS-Mgmt
RSAT-Online-Responder
RSAT-DHCP
RSAT-DNS-Server
RSAT-File-Services
RSAT-DFS-Mgmt-Con
RSAT-FSRM-Mgmt
RSAT-Print-Services
Failover-Clustering
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "AzureADConnector"
    WindowsFeature = @"
SNMP-Service
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Core
NET-Framework-45-ASPNET
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "CertificateAuthority"
    WindowsFeature = @"
ADCS-Cert-Authority
ADCS-Enroll-Web-Pol
ADCS-Enroll-Web-Svc
ADCS-Web-Enrollment
ADCS-Device-Enrollment
ADCS-Online-Cert
RSAT-ADCS
RSAT-ADCS-Mgmt
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "Passwordstate"
    WindowsFeature = @"
SNMP-Service
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Core
NET-Framework-45-ASPNET
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
    Name = "NestedHyperVCluster"
    WindowsFeature = @"
SNMP-Service
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Core
NET-Framework-45-ASPNET
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
    Name = "MFANPS"
    WindowsFeature = @"
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "MFANPSRDGateway"
    WindowsFeature = @"
SNMP-Service
RDS-Gateway
Remote-Desktop-Services
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "MFANPSRDBroker"
    WindowsFeature = @"
SNMP-Service
Remote-Desktop-Services
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "AzureMFANPS"
    WindowsFeature = @"
SNMP-Service
NPAS
RSAT-NPAS
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "DCPasswordComplexityTest"
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
    Name = "FedExShipManagerServer"
    WindowsFeature = @"
SNMP-Service
SNMP-WMI-Provider
NET-Framework-Features
NET-Framework-Core
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "HyperVCluster7"
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
    Name = "RiminiSupport"
    WindowsFeature = @"
RDS-RD-Server
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "OracleDR"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
SNMP-Service
SNMP-WMI-Provider
FS-Fileserver
FS-Data-Deduplication
FS-DFS-Namespace
FS-DFS-Replication
FS-NFS-Service
RSAT-File-Services
Multipath-IO
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "AcronisFileServer"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
SNMP-Service
SNMP-WMI-Provider
FS-Fileserver
FS-Data-Deduplication
FS-DFS-Namespace
FS-DFS-Replication
FS-NFS-Service
RSAT-File-Services
Multipath-IO
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "SCOM2019"
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
    Name = "ChannelAdvisor"
    WindowsFeature = @"
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "SCVMM2019"
    WindowsFeature = @"
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "SCDPM2019"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
NET-Framework-45-Core
NET-Framework-45-ASPNET
SNMP-Service
SNMP-WMI-Provider
FS-Data-Deduplication
Multipath-IO
Hyper-V-PowerShell
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "Adaptive"
    WindowsFeature = @"
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "NavisionRemoteApp"
    WindowsFeature = @"
RDS-RD-Server
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "2019FileServer"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
SNMP-Service
SNMP-WMI-Provider
FS-Fileserver
FS-Data-Deduplication
FS-DFS-Namespace
FS-DFS-Replication
FS-NFS-Service
RSAT-File-Services
Multipath-IO
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "OpenDNSConnector"
    WindowsFeature = @"
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "Packsize"
    WindowsFeature = @"
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "Solidworks"
    WindowsFeature = @"
SNMP-Service
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "VeeamBackup"
    WindowsFeature = @"
    SNMP-Service
    SNMP-WMI-Provider
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "VeeamProxy"
    WindowsFeature = @"
    SNMP-Service
    SNMP-WMI-Provider
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "VeeamRepository"
    WindowsFeature = @"
    SNMP-Service
    SNMP-WMI-Provider
    Multipath-IO
"@ -split "`r`n" 
}