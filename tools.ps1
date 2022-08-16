##Create the Form
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$AutopilotMenu = New-Object system.Windows.Forms.Form
$AutopilotMenu.ClientSize = New-Object System.Drawing.Point(396, 431)
$AutopilotMenu.text = "Autopilot Tools"
$AutopilotMenu.TopMost = $false
$AutopilotMenu.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")


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