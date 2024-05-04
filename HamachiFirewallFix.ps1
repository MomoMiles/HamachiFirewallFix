# HamachiFirewallFix.ps1



#This will self elevate the script so with a UAC prompt since this script needs to be run as an Administrator in order to function properly.
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
# UPDATE THIS SHIT DONT WORK
Write-Warning "You didn't run this script as an Administrator. Please reread the instructions before running this."
#     Start-Sleep 1
#     Write-Host "3"
#     Start-Sleep 1
#     Write-Host "2"
#     Start-Sleep 1
#     Write-Host "1"
#     Start-Sleep 1
#     Start-Process -Verb RunAs -FilePath pwsh.exe -ArgumentList "-NoProfile", "-ExecutionPolicy Bypass", "-sta `"$PSCommandPath`""; exit
    Break
    Exit
}

#No Errors Throughout
# $ErrorActionPreference = 'silentlycontinue'
#Vars


$Button = [System.Windows.Forms.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.Forms.MessageBoxImage]::Error

$CheckDefaultApplicationRule = Get-NetFirewallRule -DisplayName "Hamachi Client Application"
$CheckDefaultTunnelRule = Get-NetFirewallRule -DisplayName "Hamachi Client Tunneling Engine"
$CheckCustomTunnelRule = Get-NetFirewallRule -DisplayName "Allow Hamachi Tunneling Service"

$DefaultFirewallRuleExists = 'One or more default Hamachi firewall rules exist. This script can remove them for you if you want, or you can leave them there with no issues.'
$CustomFirewallRuleExists = 'This script has already been run. Did you want to rerun it? (This will remove the previously created rule and recreate it. Use this if you changed it and need to remake it.)'

if (($NULL -ne $CheckDefaultApplicationRule) -or ($NULL -ne $CheckDefaultTunnelRule)) {
    $DefaultPrompt = [System.Windows.Forms.MessageBox]::Show($DefaultFirewallRuleExists, "Remove Default Firewall Rules?", $Button, $ErrorIco)
    Switch ($DefaultPrompt) {
        #This will remove all Hamachi default firewall rules. We don't backup around here cause we full commit to every decision.
        Yes {
            Write-Host "Removing existing firewall rules."
            Remove-NetFirewallRule -DisplayName "Hamachi Client Application"
            Remove-NetFirewallRule -DisplayName "Hamachi Client Tunneling Engine"
            Break
        }
        No {
            Write-Host "Leaving Existing Hosts"
            Break
        }
    }

}

if (($NULL -ne $CheckCustomTunnelRule)) {
    $RerunPrompt = [System.Windows.Forms.MessageBox]::Show($CustomFirewallRuleExists, "Rerun Script?", $Button, $ErrorIco)
    Switch ($RerunPrompt) {
        #This will remove all hamachi default rules. We don't backup around here cause we full commit to every decision.
        Yes {
            Write-Host "Removing old firewall rule."
            Remove-NetFirewallRule -DisplayName "Hamachi Client Application"
            Remove-NetFirewallRule -DisplayName "Hamachi Client Tunneling Engine"
            Start-Sleep 1
            Write-Host "Successfully removed old firewall rules"
            Break
        }
        No {
            Write-Host "Script Aborted. Exiting Script in 3 seconds."
            Start-Sleep 3
            exit
        }
    }

}

#This will create the new Firewall Rule
Start-Sleep 1
Write-Host "Creating new Firewall Rule"
Start-Sleep 1
New-NetFirewallRule `
    -DisplayName "Allow Hamachi Tunneling Service" `
    -Direction Inbound `
    -Profile Any `
    -Action Allow `
    -Program "C:\Program Files (x86)\LogMeIn Hamachi\x64\hamachi-2.exe" `
    -Protocol Any
Start-Sleep 1
Write-Host "New firewall rules created. Exiting Script in 3 seconds."
Start-Sleep 3
#exit
