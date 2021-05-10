$seconds = Get-Date -UFormat %S
$aiqIniFile = "$([Environment]::GetFolderPath("ProgramFiles"))\Ellie Mae AIQ Desktop\Desktop\Desktop.ini"
Rename-Item $aiqIniFile "Desktop-$seconds.ini"
$aiqIniFileRenamed = "$([Environment]::GetFolderPath("ProgramFiles"))\Ellie Mae AIQ Desktop\Desktop\Desktop-$seconds.ini"
$line = Get-Content $aiqIniFileRenamed | Select-String domainname | Select-Object -ExpandProperty Line
if ($line -eq $null) {
 "String Not Found"
 exit
} else {
 $content = Get-Content $aiqIniFileRenamed
 $content | ForEach-Object {$_ -replace $line,"domainname=Emaiq-na2.net"} | Set-Content $aiqIniFile
}
