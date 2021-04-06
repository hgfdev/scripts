robocopy "Apps" "C:\Apps" /E /MOVE
attrib +h "C:\Apps"
Start-Process "C:\Apps\LGPO\LGPO.exe" -argumentlist "/g C:\Apps\LGPO\Pre-Sysprep"
robocopy "C:\Apps\Desktop Links" "C:\Users\Public\Desktop" /E
Start-Process "C:\Apps\Adobe Reader DC\AdobeReaderDC.exe" -argumentlist "/sPB /rs" -Wait
Start-Process "C:\Apps\Microsoft Office 365\OfficeSetup.exe" -Wait
New-Item -Path "C:\Users\Public\Desktop\Excel" -ItemType SymbolicLink -Value "C:\Program Files (x86)\Microsoft Office\root\Office16\EXCEL.EXE"
New-Item -Path "C:\Users\Public\Desktop\Word" -ItemType SymbolicLink -Value "C:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE"
New-Item -Path "C:\Users\Public\Desktop\Outlook" -ItemType SymbolicLink -Value "C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE"
New-Item -Path "C:\Users\Public\Desktop\PowerPoint" -ItemType SymbolicLink -Value "C:\Program Files (x86)\Microsoft Office\root\Office16\POWERPNT.EXE"
Start-Process "C:\Apps\Scripts\changename.vbs" -Wait
Start-Process "C:\Apps\LogMeIn\LogMeIn.msi" -argumentlist "/quiet" -Wait
Start-Process "C:\Apps\Ninite\ninite_installer.exe" -Wait
Start-Process "C:\Apps\Encompass 360\vcredist_x64.exe" -Wait
Start-Process "C:\Apps\Encompass 360\smartclient.exe" -Wait
[microsoft.win32.registry]::SetValue("HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown\bProtectedMode","00000000", "DWord")
[microsoft.win32.registry]::SetValue("HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown\bEnhancedSecurityStandalone","00000000", "DWord")
[microsoft.win32.registry]::SetValue("HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown\bEnhancedSecurityInBrowser","00000000", "DWord")
[microsoft.win32.registry]::SetValue("HKEY_CURRENT_USER\SOFTWARE\Encompass","","")
[microsoft.win32.registry]::SetValue("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Hardware Profiles\Current\Software\Encompass","","")
[microsoft.win32.registry]::SetValue("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Ellie Mae","","")
[microsoft.win32.registry]::SetValue("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Ellie Mae\Encompass","WordBackgroundPrint","0")
[microsoft.win32.registry]::SetValue("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Ellie Mae\Encompass","UseWordSaveAsPdfAddIn","1")
$idRef = [System.Security.Principal.NTAccount]("Everyone")
$regRights = [System.Security.AccessControl.RegistryRights]::FullControl
$inhFlags = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit
$prFlags = [System.Security.AccessControl.PropagationFlags]::None
$acType = [System.Security.AccessControl.AccessControlType]::Allow
$rule = New-Object System.Security.AccessControl.RegistryAccessRule ($idRef, $regRights, $inhFlags, $prFlags, $acType)
$acl = Get-Acl "HKCU:\SOFTWARE\Encompass"
$acl.SetAccessRule($rule)
$acl | Set-Acl -Path "HKCU:\SOFTWARE\Encompass"
$acl = Get-Acl "HKLM:\SYSTEM\CurrentControlSet\Hardware Profiles\Current\Software\Encompass"
$acl.SetAccessRule($rule)
$acl | Set-Acl -Path "HKLM:\SYSTEM\CurrentControlSet\Hardware Profiles\Current\Software\Encompass"
$acl = Get-Acl "HKLM:\SOFTWARE\WOW6432Node\Ellie Mae"
$acl.SetAccessRule($rule)
$acl | Set-Acl -Path "HKLM:\SOFTWARE\WOW6432Node\Ellie Mae"
Start-Process "C:\Apps\Encompass 360\EllieMae_AIQ_Desktop.msi" -Wait
