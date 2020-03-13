

$rootdir = $args[0]

Set-Location $rootdir

$sh = New-Object -COM WScript.Shell


$allfiles = Get-ChildItem $rootdir -Filter *.lnk -Recurse | % { $_.FullName}


attrib.exe -h -s -r /s /d

$vexeclist = New-Object System.Collections.Generic.List[System.Object]
$vfilelist = New-Object System.Collections.Generic.List[System.Object]
$vshortcutlist = New-Object System.Collections.Generic.List[System.Object]

foreach($thing in $allfiles)
{
    
    $Target = $sh.CreateShortcut($thing).targetpath
    $shpath = $thing | Split-Path


    if ($Target -eq "C:\Windows\system32\cmd.exe")
    {
        $arg = $sh.CreateShortcut($thing).arguments
        $exec = $arg -match "(?<=start ).*\...."
        if ($exec)
        {
            $fresult = $Matches[0]


            $vexec = $fresult.split() | Select-Object -First 1
            $vexec = "$shpath\$vexec"
            $vexec = $vexec -replace "\\[^\\]+\\\.\.", ""

            $vfile = $fresult.split() | Select-Object -Skip 1 | Select-Object -First 1
            $vfile = "$shpath\$vfile"
            if($vfile){$vfile = $vfile.Replace("`"","")}
            $vfile = $vfile -replace "\\[^\\]+\\\.\.", ""

            

            # Write-Host "exec is $vexec"
            # Write-Host "execfile is $vfile"

            If (-not ($vexeclist -contains $vexec)){$vexeclist.Add($vexec)}
            If (-not ($vfilelist -contains $vfile)){$vfilelist.Add($vfile)}
            If (-not ($vshortcutlist -contains $thing)){$vshortcutlist.Add($thing)}
        }

        if($matches){clear-variable matches}
    }
}

# $vexecliststring = $vexeclist -join "`n"
# $vfileliststring = $vfilelist -join "`n"
# $vshortcutliststring = $vshortcutlist -join "`n"
# Write-Host $vexecliststring
# Write-Host "--------------------------------------------------------------------------------"
# Write-Host $vfileliststring
# Write-Host "--------------------------------------------------------------------------------"
# Write-Host $vshortcutliststring


foreach ($mfile in $vexeclist, $vfilelist, $vshortcutlist){Remove-Item -Path $mfile -Force}