# HamachiFirewallFix


[![made-with-powershell](https://img.shields.io/badge/PowerShell-1f425f?logo=Powershell)](https://microsoft.com/PowerShell)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Script to automatically fix your firewall settings in Hamachi. This just removes Hamachi's default firewall settings and creates one that works for all 64 bit computers.

## Disclaimer

**WARNING:** I do **NOT** take responsibility for what may happen to your system! Run scripts at your own risk! 

## How To Run the HamachiFirewallFix.ps1 file

**Please follow the instructions closely or things might break. Step 2 and 3 are especially important:**

1) Download the .zip file on the main page of the GitHub and extract the .zip file to your desired location
2) Once extracted, open [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-5.1) (or [PowerShell ISE](https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/ise/introducing-the-windows-powershell-ise?view=powershell-7)) as an **Administrator**
3) **Enable PowerShell execution**
<code>Set-ExecutionPolicy Unrestricted -Force</code>
1) On the prompt, change to the directory where you extracted the files:
  e.g. - `cd C:\Users\YOURUSER\Downloads\HamachiFirewallFix`
1) Next, to run the script script, enter in the following:
  e.g. - `.\HamachiFirewallFix.ps1`
