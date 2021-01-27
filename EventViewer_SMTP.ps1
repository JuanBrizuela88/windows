#Script para enviar logs por medio de correo
#Creado por Juan Brizuela
<#
IDs de Evento:
Sesión Windows Fallida. Log: Security , ID 4625
Sesiones fallidas deben tener esto en custom XML properties:
<Select Path="Security">*[System[(EventID=4625)]] and *[EventData[Data[@Name='LogonType'] and (Data=3 or Data=4 or Data=8)]]</Select>
Sesion SQL Fallida Log: MSSQL , ID 18456
Instalacion Aplicacion. Log: Application , ID 11707
Cambios en Firewall Log: Security, ID 4947
Creacion de Usuario Log: Security, ID 4720
Bloqueos de Firewall Log: Security, ID 5152
Eliminacion de Logs Log: Security, ID, 1102
#>
#Se invoca mediante Task Scheduler utilizando uno de los eventos de la lista como trigger
#Como accion se debe utilizar:
#powershell-ExecutionPolicy ByPass -File C:\$ruta\$Script

$EmailFrom = "correo@dominio.com"

$EmailTo = "correo@dominio.com"

$Subject = "Inicio de sesion/Malware Detectado/OTRO"

$LogText = Get-WinEvent -FilterHashTable @{LogName='$Log';ID='$numID'} -MaxEvents 1 | Format-List > $archivo.txt

$Body = "$Body = Get-Content -Path $archivo.txt | out-string"

$SMTPServer = "$ServidorSMTP"

$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)

$SMTPClient.EnableSsl = $true

$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("correo@dominio.com", "password");

$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
