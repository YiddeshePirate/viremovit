


$rootdir = $args[0]

Set-Location $rootdir

$sh = New-Object -COM WScript.Shell


$allshortcuts = Get-ChildItem $rootdir -Filter *.lnk -Recurse | ForEach-Object { $_.FullName}


attrib.exe -h -s -r /s /d

foreach($thing in $allshortcuts)
{
    
    $Target = $sh.CreateShortcut($thing).targetpath


    if ($Target -eq "C:\Windows\system32\cmd.exe")
    {
        Write-Host "True"
        exit
        
    }
}
Write-Host "False"
# $vexecliststring = $vexeclist -join "`n"
# $vfileliststring = $vfilelist -join "`n"
# $vshortcutliststring = $vshortcutlist -join "`n"
# Write-Host $vexecliststring
# Write-Host "--------------------------------------------------------------------------------"
# Write-Host $vfileliststring
# Write-Host "--------------------------------------------------------------------------------"
# Write-Host $vshortcutliststring

