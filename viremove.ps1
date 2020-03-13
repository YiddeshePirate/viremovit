
$rootdir = $args[0]

$sh = New-Object -COM WScript.Shell

$allfiles = Get-ChildItem $rootdir -Filter *.lnk -Recurse | % { $_.FullName}




$vexeclist = New-Object System.Collections.Generic.List[System.Object]
$vfilelist = New-Object System.Collections.Generic.List[System.Object]
$vshortcutlist = New-Object System.Collections.Generic.List[System.Object]

foreach($thing in $allfiles)
{
    
    $Target = $sh.CreateShortcut($thing).targetpath

    if ($Target -eq "C:\Windows\system32\cmd.exe")
    {
        $arg = $sh.CreateShortcut($thing).arguments
        $exec = $arg -match "(?<=start ).*\...."
        if ($exec)
        {
            $fresult = $Matches[0]

            $vexec = $fresult.split() | Select-Object -First 1
            $vfile = $fresult.split() | Select-Object -Skip 1 | Select-Object -First 1
            if($vfile){$vfile = $vfile.Replace("`"","")}
            

            # Write-Host "exec is $vexec"
            # Write-Host "execfile is $vfile"

            If (-not ($vexeclist -contains $vexec)){$vexeclist.Add($vexec)}
            If (-not ($vfilelist -contains $vfile)){$vfilelist.Add($vfile)}
            If (-not ($vshortcutlist -contains $thing)){$vshortcutlist.Add($thing)}
        }

        if($matches){clear-variable matches}
    }
}



Write-Host $vexeclist -join `n
Write-Host "--------------------------------------------------------------------------------"
Write-Host $vfilelist  -join `n
Write-Host "--------------------------------------------------------------------------------"
Write-Host $vshortcutlist -join `n