function Invoke-DPMHealthCheck {
    $DPMServername = "inf-scdpmsql01"
    Connect-DPMServer $DPMServername
    Write-Output "Getting Datasources"    
    $DPMDatasources = Get-DPMDatasource -DPMServerName $DPMServername | where state -eq "valid" | Where-Object ProtectionGroupName -eq "fedex" #| Select-Object DPMServerName,Computer,Name,protectiongroupname
    $DPMDatasources | select latestrecoverypoint | Out-Null
    write-output "getting protectiongroups"
    $DPMProtectionGroups = Get-DPMProtectionGroup -DPMServerName $DPMServername | Where-Object name -eq "fedex"
    
    ForEach ($ProtectionGroup in $DPMProtectionGroups){
    #   $ProtectionGroup = $DPMProtectionGroups
        $DatasourcesWithinProtectionGroup = $DPMDatasources | where ProtectionGroupName -eq $ProtectionGroup.Name
        $ProtectionGroupDiskSchedule = Get-DPMPolicySchedule -ProtectionGroup $ProtectionGroup -ShortTerm
        $ProtectionGroupOnlineSchedule = Get-DPMPolicySchedule -ProtectionGroup $ProtectionGroup -LongTerm Online
      
        $DiskScheduleTimes = New-Object System.Collections.ArrayList
        $OnlineScheduleTimes = New-Object System.Collections.ArrayList
    
        $DiskTimesOfDay = $ProtectionGroupDiskSchedule.TimesofDay.ToShortTimeString()
        foreach($DiskRecoveryPointTime in $DiskTimesOfDay){
            $Timestamp = [datetime]("{0:HH:mm}" -f [datetime]$DiskRecoveryPointTime)
            if ($TimeStamp -gt (get-date)){
                $DiskScheduleTimes.Add($TimeStamp.AddDays(-1)) | Out-Null
            }
            else {
                $DiskScheduleTimes.Add($TimeStamp) | Out-Null
            }
        
        }
    
        $OnlineTimesOfDay = $ProtectionGroupOnlineSchedule.TimesofDay.ToShortTimeString()
        foreach($OnlineRecoveryPointTime in $OnlineTimesOfDay){
                $Timestamp = [datetime]("{0:HH:mm}" -f [datetime]$OnlineRecoveryPointTime)
                if ($TimeStamp -gt (get-date)){
                    $OnlineScheduleTimes.Add($TimeStamp.AddDays(-1)) | Out-Null
                }
                else {
                    $OnlineScheduleTimes.Add($TimeStamp) | Out-Null
                }
            
        }
    
        $OldestDiskRecoveryPointPermitted = ($DiskScheduleTimes | Sort-Object -Descending | Select-Object -first 1).addminutes(-15)
        $OldestOnlineRecoveryPointPermitted = $diskscheduletimes | where {$_ -lt ($OnlineScheduleTimes | Sort-Object -Descending | Select-Object -first 1)}
        
        if($ProtectionGroupDiskSchedule.JobType -eq "FullReplicationForApplication"){
            $IncrementalFrequency = $ProtectionGroupDiskSchedule.Frequency
            $OldestIncrementalRecoveryPointPermitted = (get-date).AddMinutes(-$IncrementalFrequency * 2)
            $OldestStoresIncrementalRecoveryPointPermitted = (get-date).AddHours(-15)
        }
            
        foreach ($Datasource in $DatasourcesWithinProtectionGroup){
     #      $Datasource = $DatasourcesWithinProtectionGroup | where name -eq ims
            $LatestOnlineRecoveryPoint = Get-DPMRecoveryPoint -Datasource $($DataSource) -Online -OnlyActive | Sort-Object BackupTime -Descending | Select-Object -first 1
            
            if ($OldestIncrementalRecoveryPointPermitted){
                if(($Datasource.protectiongroupname -match "Stores") -and ($Datasource.LatestRecoveryPoint -lt $OldestStoresIncrementalRecoveryPointPermitted)){
                    $Datasource | Add-Member -MemberType NoteProperty -Name RecoveryPointType -Value "Incremental" -Force
                    $Datasource | Add-Member -MemberType NoteProperty -Name LatestRecoveryPointTime -Value $Datasource.LatestRecoveryPoint -force
                    $Datasource | Add-Member -MemberType NoteProperty -Name OldestRecoveryPointPermitted -Value $OldestStoresIncrementalRecoveryPointPermitted -force
                    $Datasource | Select-Object DPMServerName,Computer,Name,protectiongroupname,LatestRecoveryPointTime,OldestRecoveryPointPermitted,RecoveryPointType | ft -AutoSize
                }
                elseif($Datasource.LatestRecoveryPoint -lt $OldestIncrementalRecoveryPointPermitted){
                    $Datasource | Add-Member -MemberType NoteProperty -Name RecoveryPointType -Value "Incremental" -Force
                    $Datasource | Add-Member -MemberType NoteProperty -Name LatestRecoveryPointTime -Value $Datasource.LatestRecoveryPoint -force
                    $Datasource | Add-Member -MemberType NoteProperty -Name OldestRecoveryPointPermitted -Value $OldestIncrementalRecoveryPointPermitted -force
                    $Datasource | Select-Object DPMServerName,Computer,Name,protectiongroupname,LatestRecoveryPointTime,OldestRecoveryPointPermitted,RecoveryPointType | ft -AutoSize
                }
            }
            else {
                if ($Datasource.LatestRecoveryPoint -lt $OldestDiskRecoveryPointPermitted) {
                    $Datasource | Add-Member -MemberType NoteProperty -Name RecoveryPointType -Value "Disk" -Force
                    $Datasource | Add-Member -MemberType NoteProperty -Name LatestRecoveryPointTime -Value $Datasource.LatestRecoveryPoint -force
                    $Datasource | Add-Member -MemberType NoteProperty -Name OldestRecoveryPointPermitted -Value $OldestDiskRecoveryPointPermitted -force
                    $Datasource | Select-Object DPMServerName,Computer,Name,protectiongroupname,LatestRecoveryPointTime,OldestRecoveryPointPermitted,RecoveryPointType | ft -AutoSize
                }
            }
            if ($LatestOnlineRecoveryPoint.BackupTime -lt $OldestOnlineRecoveryPointPermitted) {
                $Datasource | Add-Member -MemberType NoteProperty -Name RecoveryPointType -Value Online -Force
                $Datasource | Add-Member -MemberType NoteProperty -Name OldestRecoveryPointPermitted -Value $OldestOnlineRecoveryPointPermitted -force
                $Datasource | Add-Member -MemberType NoteProperty -Name LatestRecoveryPointTime -Value $($LatestOnlineRecoveryPoint.BackupTime) -force
                $Datasource | Select-Object DPMServerName,Computer,Name,protectiongroupname,LatestRecoveryPointTime,OldestRecoveryPointPermitted,RecoveryPointType | ft -AutoSize
            } #   }    
        
        }
    }
    }



    