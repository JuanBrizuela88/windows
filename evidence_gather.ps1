#Evidence gathering script for Windows
#Created by Juan Brizuela and Ray Morris.
#

#Create a netstat list and view which service the connection belongs to.

$netstat = netstat -aon | Select-String -Pattern “(TCP|UDP)”
$ProcessList = Get-Process
foreach ($line in $netstat)
{
$SpltArry = $line -split ” “
$PD = $spltArry[$spltarry.length – 1]
$pn = $ProcessList | Where-Object {$_.id -eq $pd } | select processname
$SpltArry[$SpltArry.length – 1] = $PD + ” “ + $PN.processname
$SpltArry -join ” “
}


echo "================================================================================================================"
echo "================================================================================================================"

#Get Process List and present it as a Tree

function Get-ProcessAndChildProcesses($Level, $Process) {
"{0}[{1,-5}] [{2}]" -f (" " * $Level), $Process.ProcessId, $Process.Name
$Children = $Global:Processes | where-object {$_.ParentProcessId -eq $Process.ProcessId -and $_.CreationDate -ge $Process.CreationDate}
if ($Children -ne $null) {
foreach ($Child in $Children) {
Get-ProcessAndChildProcesses ($Level + 1) $Child
}
}
}
$Global:Processes = Get-WMIObject -Class Win32_Process
$RootProcesses = @()
# Process "System Idle Process" is processed differently, as ProcessId and ParentProcessId are 0
# $Global:Processes is sliced from index 1 to the end of the array
foreach ($Process in $Global:Processes[1..($Global:Processes.length-1)]) {
$Parent = $global:Processes | where-object {$_.ProcessId -eq $Process.ParentProcessId -and $_.CreationDate -lt $Process.CreationDate}
if ($Parent -eq $null) {
$RootProcesses += $Process
}
}
#Process the "System Idle process" separately
"[{0,-5}] [{1}]" -f $Global:Processes[0].ProcessId, $Global:Processes[0].Name
foreach ($Process in $RootProcesses) {
Get-ProcessAndChildProcesses 0 $Process
}

echo "================================================================================================================"
echo "================================================================================================================"


#List all users on the machine and users in the administrators group
net users
net localgroup administrators

echo "================================================================================================================"
echo "================================================================================================================"

#List network drives in use.
net use

echo "================================================================================================================"
echo "================================================================================================================"

#List Scheduled Tasks
schtasks

echo "================================================================================================================"
echo "================================================================================================================"

#List Startup files
ls 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\'

echo "================================================================================================================"
echo "================================================================================================================"

#Get Logs
#Security 4720, User creation.
#Security 1102, Deletion of logs.
#Application 11707, Application install.
Get-WinEvent -FilterHashTable @{LogName='Security';ID='4720'} -MaxEvents 10 | Format-List
Get-WinEvent -FilterHashTable @{LogName='Security';ID='1102'} -MaxEvents 10 | Format-List
Get-WinEvent -FilterHashTable @{LogName='Application';ID='11707'} -MaxEvents 10 | Format-List

echo "================================================================================================================"
echo "================================================================================================================"

#Download MalwareBytes
#
bitsadmin /transfer MBDownload /download /priority normal https://data-cdn.mbamupdates.com/web/mb4-setup-consumer/MBSetup.exe $pwd\MBSetup.exe

 
