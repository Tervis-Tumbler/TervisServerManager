$ModulePath = (Get-Module -ListAvailable TervisServerManager).ModuleBase
. $ModulePath\Definition.ps1

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
    Process {
        if(-not (invoke-command -ComputerName $Computername -ScriptBlock {get-windowsoptionalfeature -FeatureName $using:featurename -online | where State -eq "Enabled"})){
            $Command = "dism /online /enable-feature /featurename:$FeatureName /all /NoRestart"
            $command
            Invoke-PsExec -ComputerName $Computername -Command $Command -IsPSCommand -IsLongPSCommand
            if (-not ($NoRestart)){
                if (Get-PendingRestart -ComputerName $Computername){
                    Restart-Computer -ComputerName $Computername -Force
                }
            }
        }
    }    
}

function Get-MemoryUsage {
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]$ComputerName
    )

    process {        
        $MemoryStats = Get-CimInstance -ComputerName $Computername -ClassName Win32_OperatingSystem -Property FreePhysicalMemory,TotalVisibleMemorySize
        $PercentUsed = 100 - [System.Math]::Round(($MemoryStats.FreePhysicalMemory/$MemoryStats.TotalVisibleMemorySize)*100,2)
        $TotalMemoryInGB = [System.Math]::Round($MemoryStats.TotalVisibleMemorySize/1mb,2)
        $UsedMemoryInGB = $TotalMemoryInGB - [System.Math]::Round($MemoryStats.FreePhysicalMemory/1mb,2)
    
        [PSCustomObject][Ordered]@{
            ComputerName = $ComputerName
            PercentUsed = $PercentUsed
            UsedMemoryInGB = $UsedMemoryInGB
            MemoryTotalInGB = $TotalMemoryInGB
        }
    }
}