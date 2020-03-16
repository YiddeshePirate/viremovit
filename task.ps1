param([switch]$Elevated)
function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}
schtasks /create /xml C:\Users\eliez\Documents\Programming\Batch\viremovit\start.xml /tn "start"  /ru system
# C:\Users\eliez\Documents\Programming\Batch\viremovit\start.xml
# schtasks /query /xml /tn "\TASK-PATH-TASKSCHEDULER\usbevent" > "
# schtasks /query /xml /tn "\TASK-PATH-TASKSCHEDULER\usbevent" > "C:\Users\eliez\Desktop\start.xml"
# Register-ScheduledTasT -TaskName startusb -TaskPath "\" -Xml ""
