##Create the Form
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Windows.Forms.Application]::EnableVisualStyles()
#region ---------------------------------------creacion repositorio y custom------------------------------------

$tools = "C:\ProgramData\ServiceUI"
$path = $(Join-Path $tools Check)
$ico = Test-Path "$tools\favicon.ico"
$back = Test-Path "$tools\wallpaper_NTT25%.png"
if (!(Test-Path $path))
{
	New-Item -Path $path -ItemType Directory -Force -Confirm:$false
}
if ($ico -eq $false)
{
	Invoke-WebRequest "https://sastdprointune.blob.core.windows.net/intune/faviconntt.ico?sv=2020-04-08&st=2021-06-28T15%3A53%3A44Z&se=2040-06-29T15%3A53%3A00Z&sr=b&sp=r&sig=%2FFwt6lXnJeeTZegqoOzv60BVSe%2B5BvHs6UI7oms7IZA%3D" -outfile "$tools\faviconntt.ico"
}

if ($back -eq $false)
{
	Invoke-WebRequest "https://sastdprointune.blob.core.windows.net/intune/wallpaper_everis25%.png?sv=2019-12-12&st=2021-04-16T11%3A39%3A25Z&se=2041-04-17T11%3A39%3A00Z&sr=b&sp=r&sig=DYi51OiVyPmU2MYNpa%2BjVGd5NOHON8IQQN1NeMsJexI%3D" -outfile "$tools\wallpaper_NTT25%.png"
}






$AutopilotMenu = New-Object system.Windows.Forms.Form
$AutopilotMenu.ClientSize = New-Object System.Drawing.Point(396, 431)
$AutopilotMenu.text = "Autopilot Tools"
$AutopilotMenu.TopMost = $false
$AutopilotMenu.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$formIcon = New-Object system.drawing.icon ("$tools\faviconntt.ico")
$AutopilotMenu.Icon = $formicon
$FormImage = [system.drawing.image]::FromFile("$tools\wallpaper_NTT25%.png")
$AutopilotMenu.BackgroundImage = $FormImage

$eventvwr = New-Object system.Windows.Forms.Button
$eventvwr.text = "Event Viewer"
$eventvwr.width = 157
$eventvwr.height = 56
$eventvwr.location = New-Object System.Drawing.Point(21, 18)
$eventvwr.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 12)

$scriptrun = New-Object system.Windows.Forms.Button
$scriptrun.text = "Troubleshooting Script"
$scriptrun.width = 157
$scriptrun.height = 56
$scriptrun.location = New-Object System.Drawing.Point(219, 16)
$scriptrun.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 12)

$regedit = New-Object system.Windows.Forms.Button
$regedit.text = "Regedit"
$regedit.width = 157
$regedit.height = 56
$regedit.location = New-Object System.Drawing.Point(22, 131)
$regedit.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 12)

$explorer = New-Object system.Windows.Forms.Button
$explorer.text = "File Explorer"
$explorer.width = 157
$explorer.height = 56
$explorer.location = New-Object System.Drawing.Point(222, 132)
$explorer.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 12)

$log1 = New-Object system.Windows.Forms.Button
$log1.text = "SetupAct Log"
$log1.width = 157
$log1.height = 56
$log1.location = New-Object System.Drawing.Point(22, 245)
$log1.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 12)

$log2 = New-Object system.Windows.Forms.Button
$log2.text = "Intune Mgmt Log"
$log2.width = 157
$log2.height = 56
$log2.location = New-Object System.Drawing.Point(222, 245)
$log2.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 12)





$AutopilotMenu.controls.AddRange(@($scriptrun, $eventvwr, $regedit, $explorer, $log1, $log2))


##Launch Autopilot Diagnostics in new window (don't autoclose)
$scriptrun.Add_Click({
		start-process powershell.exe -argument '-nologo -noprofile -noexit -executionpolicy bypass -command  Get-AutopilotDiagnostics ' -Wait
		
	})

##Launch Event Viewer
$eventvwr.Add_Click({
		start-process -filepath "C:\Windows\System32\eventvwr.exe"
	})

##Launch Regedit
$regedit.Add_Click({
		start-process -filepath "C:\Windows\regedit.exe"
	})

##Launch Windows Explorer
$explorer.Add_Click({
		start-process -filepath "C:\Windows\explorer.exe"
	})

##Launch CMTrace on SetupAct.log
$log1.Add_Click({
		start-process -filepath "C:\ProgramData\ServiceUI\cmtrace.exe" -argumentlist c:\windows\panther\setupact.log
	})

##Launch CMTrace on IntuneMgmt.log
$log2.Add_Click({
		start-process -filepath "C:\ProgramData\ServiceUI\cmtrace.exe" -argumentlist C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\intunemanagementextension.log
	})


[void]$AutopilotMenu.ShowDialog()