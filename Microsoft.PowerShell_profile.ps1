<#

.SYNOPSIS
profile.ps1 version 0.1

.DESCRIPTION
Profile .ps1 >> @"C:\Users\(USER)\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

.EXAMPLE
Run Powershell

.NOTES
Author : Tony Simoes | DateCreated: 09/07/2017  
 
.LINK
(Tony Simoes) https://web.lunarviews.net

#>


# profile.ps1 version 0.2
Set-Alias -name Out-Clipboard -value 'c:\windows\system32\clip.exe'
Set-Alias -name grep -value select-string
$Racine = "\\Terre\!codes"
function goAngular {set-location "$Racine\Angular"; start .}
Set-Alias opan goAngular
#
function goBatch {set-location "$Racine\Batch"; start .}
Set-Alias opba goBatch
#
function goCsharp {set-location "$Racine\C#"; start .}
Set-Alias opcs goCsharp
#
function goCpp {set-location "$Racine\Cpp"; start .}
Set-Alias opcp goCpp
#
function goNode {set-location "$Racine\Node"; start .}
Set-Alias opno goNode
#
function goPowerShell {set-location "$Racine\PowerShell"; start .}
Set-Alias oppo goPowerShell
#
function goPython {set-location "$Racine\Python"; start .}
Set-Alias oppy goPython
#...
# Fais parler Virginie
function Parler($texte)
{
	$TTS = new-object -com SAPI.SpVoice
	$var = $TTS.Speak($texte, 2) 
}
# Ouvre .txt dans Notepad++
function Note($arg1)
{
	$Command = "C:\Program Files\Notepad++\notepad++.exe "
	& "$Command" $arg1
}
# Current Path
function monPath()
{
	$CurrentDir = $(get-location).Path
	Write-Host "$CurrentDir"
}
Set-Alias p monPath
# Trafic des ports
function MesPorts()
{
	$CurrentDir = $(get-location).Path
	$file = "$CurrentDir/activity.txt"
	Netstat -abf > $file
	Note($file)	
	#del $file
	if ([System.Console]::ReadKey($true).Key -eq [System.ConsoleKey]::O) {
		write-chost " Bien compris ! , j'efface $file ...# "
		rem $file
	}
}
# Customize window
function AdminWindow()
{
	$Shell = $Host.UI.RawUI
	$size = $Shell.WindowSize
	$size.width=80
	$size.height=35
	$Shell.WindowSize = $size
	$size = $Shell.BufferSize
	$size.width=80
	$size.height=5000
	$Shell.BufferSize = $size
}
AdminWindow
# Modification des variables de preference
$VerbosePreference 	= 'continue'		#par defaut silentlycontinue
$DebugPreference 	= 'continue'
$WarningPreference 	= 'continue'
#Message d'accueuil personnalisé
$UserType = 'Utilisateur'
$CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principal = new-object System.security.Principal.windowsprincipal($CurrentUser)
if ($principal.IsInRole('Administrateurs'))
{
	$UserType = 'Admin'
	$host.ui.RawUI.BackGroundColor = 'Red' #'Gray'
	$host.ui.RawUI.ForeGroundColor = 'White' #'Blue'
	Clear-Host
}
else
{
	$host.ui.RawUI.BackGroundColor = 'DarkMagenta'
	Clear-Host
}
$VMaj = $PSVersionTable.PSVersion.Major
$VMin = $PSVersionTable.PSVersion.Minor
Write-Host ' '	
Write-Host "                 Bonjour $UserType sur PowerShell V $VMaj.$VMin            " -foregroundcolor red -backgroundcolor white
Write-Host ' '
Write-Host ' '
$User = $(($CurrentUser.Name).split('\')[1])
Parler("Bonjour $UserType . Je suis contente de te revoir.")
# Modification de la couleur du prompt en jaune, remplacement
# du prompt par PS > et affichage du chemin courant dans la barre
# de titre de la fênetre de la console
function prompt
{
	$heure = get-date -format T
	Write-Host ('PS ' + $heure +' >') -nonewline -fore yellow
	$host.ui.RawUI.Set_windowtitle("$(get-location) ($UserType) : $User")
	return ' '
}
cd C:\
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# SIG # Begin signature block
# MIIFpAYJKoZIhvcNAQcCoIIFlTCCBZECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUOzrAd/M/Ta75Uunu8JgHwkIr
# xMqgggNDMIIDPzCCAiegAwIBAgIQU1PKzu01ortEte7oDh4JvjANBgkqhkiG9w0B
# AQsFADAWMRQwEgYDVQQDDAtUb255IFNpbW9lczAeFw0xNzA4MTIxNjIxMDRaFw0x
# ODA4MTIxNjQxMDRaMBYxFDASBgNVBAMMC1RvbnkgU2ltb2VzMIIBIjANBgkqhkiG
# 9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwcx61ecXmKSZtixQDqqtJm0AwEhfC53v5ooD
# dPI9P4DHWt3U25FxEJashN31Yzvsf/Uv0K28k2RHjIbM6+EBluaVk1aH0VyM22mp
# Dmeig+d6nMzVAL81e0JMhaJnBuLT2Q6XhVc+EqjPkiU7mWYOg1FrLfNn7iVM6s2S
# Tt17YpADyjDXhQRLaa1JJzipWcJY1eXgn3Y/9+2+jnHHfoMFWT5yNHxrN2nVPemc
# AGypJegzNgyl6M5Czt1Z7KytPIqX16OQa9zCOnh3HWojqwgbwiWSY2rTDjkdS1q3
# FtblfqKn5RfN7PAU/AwVF1ZxPRwbJUHKZX1s25zhvVLX7DGIgQIDAQABo4GIMIGF
# MA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzA/BgNVHREEODA2
# gRFzci50b255QGdtYWlsLmNvbaAhBgorBgEEAYI3FAIDoBMMEXNyLnRvbnlAZ21h
# aWwuY29tMB0GA1UdDgQWBBSE8xbNfoxpqLPLF7rUvbuFzF30XTANBgkqhkiG9w0B
# AQsFAAOCAQEAqeJfqqTU7XZPoeceB27JhsV4pCT+AMjhgGt5qScj3z0Q3wX4hqOD
# WzPqkUwDAuUsy8rrrVqfEvEQMNJbkqmimkjHwlzdrU8N9190oOwwpWL4nbtbC7EV
# d/Xj21ZAWMCuiQ0j5Adlomt2p2IzU+4dMgYYa/mf3pvkmdCcDQU2ZpCrDVVONwJh
# ssI+9GCiPJsVE9qAXd3pS2sj5lSvKR0RURV7G1GXrRjHmsg0u1vzBQowHh9e5mys
# GChwcLIHOog4zaLBbbfQ05VRKFGB1HitUfxQ9kqMIkPZxrBEw7jmV71sRK6dapRN
# f8fK1u7JnSdUNpbbEkj7n/AsTCuXQgsH3zGCAcswggHHAgEBMCowFjEUMBIGA1UE
# AwwLVG9ueSBTaW1vZXMCEFNTys7tNaK7RLXu6A4eCb4wCQYFKw4DAhoFAKB4MBgG
# CisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcC
# AQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYE
# FOzJMiJBc68mcfu70TzgOiCxld8zMA0GCSqGSIb3DQEBAQUABIIBAKcEhuubGNyW
# 0RSOgaUUZz2Wk8wxmizQgMPyzef9nYCKFZY+KhBJ6qt6g+k7nJ3++xyZfJJ6O6j2
# 1vZ/qUtOGP8ccrOjVowAURE2D0piQbgw7OF6MP5H5qmbHAcP3ddB+buKN8VNEbI5
# bAAG7O/JqAezgDStww2NVSaE8ROufrL3FmuHkMc8OB2kCWx0WBrhJFpR3uv9NKma
# UZuTBO7SUcj5h29EK4EeAgrDrwFUUHCVnk0sXzTlpTyyH6H8rmIRTet7LWTJke2Y
# 1O9NVauI5uEY5e2Md52q6nJIGNCHgcz8bom+OLdUTHYSEg/wx7rE3Dtja4DOaBzh
# vfMAVeV3og0=
# SIG # End signature block
