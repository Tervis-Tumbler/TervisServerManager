function Install-TervisWindowsFeature {
    [CmdletBinding()]
    param (
        $ComputerName,
        $Credential = [System.Management.Automation.PSCredential]::Empty,
        $WindowsFeatureGroupNames
    )    
    $WindowsFeatureGroups = $WindowsFeatureGroupNames | Get-WindowsFeatureGroup
    $WindowsFeatures = $WindowsFeatureGroups.WindowsFeature | sort -Unique
    
    if ($Credential-ne [System.Management.Automation.PSCredential]::Empty) {
        Install-WindowsFeature -Name $WindowsFeatures -ComputerName:$ComputerName -Credential:$Credential
    } else {
        Install-WindowsFeature -Name $WindowsFeatures -ComputerName:$ComputerName
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

$WindowsFeatureGroups = [PSCustomObject][Ordered] @{
    Name = "BartenderCommander"
    WindowsFeature = @"
NET-Framework-Features
NET-Framework-Core
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
NET-Framework-45-Features
NET-Framework-45-Core
NET-WCF-Services45
NET-WCF-TCP-PortSharing45
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