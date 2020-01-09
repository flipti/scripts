$herestring = @"
[/settings/external scripts/scripts]
check_disk_c=cscript.exe //NoLogo //T:10 "C:\Program Files\NSClient++\scripts\check_disk.wsf" /drive:"c:\" /w:3072 /c:1024
"@

$pattern = "[/settings/external scripts/scripts]"

(Get-Content C:\Temp\Testing.txt -Raw).Replace("[/settings/external scripts/scripts]",$herestring) | Out-File C:\Temp\Testing.txt
