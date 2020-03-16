[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
Register-WmiEvent -Class win32_VolumeChangeEvent -SourceIdentifier volumeChange
write-host (get-date -format s) " Beginning script..."
$env:path += ";$env:userprofile\Documents\bin\"


do{
$newEvent = Wait-Event -SourceIdentifier volumeChange
$eventType = $newEvent.SourceEventArgs.NewEvent.EventType
$eventTypeName = switch($eventType)
{
1 {"Configuration changed"}
2 {"Device arrival"}
3 {"Device removal"}
4 {"docking"}
}
write-host (get-date -format s) " Event detected = " $eventTypeName
if ($eventType -eq 2)
{
$driveLetter = $newEvent.SourceEventArgs.NewEvent.DriveName
$driveLabel = ([wmi]"Win32_LogicalDisk='$driveLetter'").VolumeName
write-host (get-date -format s) " Drive name = " $driveLetter
write-host (get-date -format s) " Drive label = " $driveLabel
$yv = powershell.exe vircheck.ps1 "$driveLetter"
Write-Output $yv

if ($yv -eq "True"){
    $oReturn=[System.Windows.Forms.MessageBox]::Show("A Virus has been detected`nWould you like to remove it","Virus Detected!!!",[System.Windows.Forms.MessageBoxButtons]::OKCancel)

    switch ($oReturn){
        "OK" {
            powershell.exe .\viremove.ps1 $driveLetter
        } 
        "Cancel" {
            write-host "You pressed Cancel"
            [System.Windows.Forms.Messagebox]::Show("Sucks for you")
            # Enter some code
        } 
}
# Execute process if drive matches specified condition(s)
# write-host (get-date -format s) " Starting task in 3 seconds..."
# start-sleep -seconds 3
}
}
Remove-Event -SourceIdentifier volumeChange
} while (1-eq1) #Loop until next event
Unregister-Event -SourceIdentifier volumeChange
