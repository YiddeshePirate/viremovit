
$yv = Get-Process -Name WinddowsUpdater


if ($yv){
Write-Output "you have the virus\n I will attempt to clean it"
pause
Stop-Process -Name WinddowsUpdater
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v WinddowsUpdate /f
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v WinddowsUpdater /f
Set-Location C:\
Remove-Item -Force -Recurse .\WinddowsUpdater\
Remove-Item -Force -Recurse .\WinddowsUpdateCheck\

}else{
Write-Output "you do not have the virus"

}
