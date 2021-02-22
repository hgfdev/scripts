#Define variables
$desktop = [Environment]::GetFolderPath("Desktop")
$documents = [Environment]::GetFolderPath("MyDocuments")
$favorites = [Environment]::GetFolderPath("Favorites")
$pictures = [Environment]::GetFolderPath("MyPictures")
$signatures = "$([Environment]::GetFolderPath("ApplicationData"))\Microsoft\Signatures"
$bmc = "$([Environment]::GetFolderPath("LocalApplicationData"))\Google\Chrome\User Data\Default\Bookmarks"
$bme = "$([Environment]::GetFolderPath("LocalApplicationData"))\Microsoft\Edge\User Data\Default\Bookmarks"

#Define functions
function makeChoice {
 $choice = Read-Host -Prompt "(B)ackup or (R)estore (b/r)"
 If ($choice -ieq 'b') {
 	backupSystem
 }
 ElseIf ($choice -ieq 'r') {
 	restoreSystem
 } 
 Else {
 	ECHO "'$($choice)' is an invalid choice!"
 	makeChoice
 } 
}

function backupSystem {
 #Prompt for destination drive letter
 $driveletter = Read-Host -Prompt "Enter destination drive letter"
 $destination = "$($driveletter):\hhl-backup"
 #Create Directory
 #Check if directory exists
 If(!(Test-Path $destination))
 {
 	New-Item -Path $destination -ItemType Directory | Out-Null
 }
 #Create Program's List
 $programlist = "$($destination)\installed-programs-list.txt"
 Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName | Format-Table -AutoSize > $programlist
 #Backup Important Directories
 ECHO "Backing Up Desktop..."
 Copy-Item -Recurse $desktop -Destination "$($destination)\Desktop"
 ECHO "Backing Up Documents..."
 Copy-Item -Recurse $documents -Destination "$($destination)\Documents"
 ECHO "Backing Up Favorites..."
 Copy-Item -Recurse $favorites -Destination "$($destination)\Favorites"
 ECHO "Backing Up Pictures..."
 Copy-Item -Recurse $pictures -Destination "$($destination)\Pictures"
 ECHO "Backing Up Email Signatures..."
 Copy-Item -Recurse $signatures -Destination "$($destination)\Signatures"
 ECHO "Backing Up Bookmarks (Chrome and Edge)..."
 #Check if file exists
 If((Test-Path -Path $bmc -PathType Leaf))
 {
 	Copy-Item $bmc -Destination "$($destination)\bookmarks-chrome" 
 }
 If((Test-Path -Path $bme -PathType Leaf))
 {
 	Copy-Item $bme -Destination "$($destination)\bookmarks-edge"
 }
 ECHO "Files are located in $($destination)"
}

function restoreSystem {
 $driveletter = Read-Host -Prompt "Enter source drive letter"
 $source = "$($driveletter):\hhl-backup"
 #Restore Important Directories
 ECHO "Restoring Desktop..."
 Copy-Item -Recurse "$($source)\Desktop\*" -Destination $desktop
 ECHO "Restoring Documents..."
 Copy-Item -Recurse "$($source)\Documents\*" -Destination $documents 
 ECHO "Restoring Favorites..."
 Copy-Item -Recurse "$($source)\Favorites\*" -Destination  $favorites
 ECHO "Restoring Pictures..."
 Copy-Item -Recurse "$($source)\Pictures\*" -Destination  $pictures
 ECHO "Restoring Email Signatures..."
 Copy-Item -Recurse "$($source)\Signatures\*" -Destination $signatures
 ECHO "Restoring Bookmarks (Chrome and Edge)..."
 Copy-Item -Force "$($source)\bookmarks-chrome" -Destination $bmc
 Copy-Item -Force "$($source)\bookmarks-edge" -Destination $bme
}

#Execute main function
makeChoice
Read-Host -Prompt "Press Enter to exit"
