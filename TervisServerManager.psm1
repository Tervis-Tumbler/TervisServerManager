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
}