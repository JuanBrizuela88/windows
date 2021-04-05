#Application Remover
#Created by Juan Brizuela

$App_Search = Read-Host -Prompt 'Enter the application name you want to find: '

$Search_Result = Get-WmiObject -Class Win32_Product | Select-String -Pattern "$App_Search"

$Search_Result = $Search_Result -replace '.*Name=.'

$Search_Result -replace '\s*",Version.*'

$App_Name = Read-Host -Prompt 'Copy and Paste the application name from the list to uninstall: '

$App = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "$App_Name"}

$App.uninstall()
