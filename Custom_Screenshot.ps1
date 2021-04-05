#CustomScreenshots with PSR
#Created by Juan Brizuela

$datenow=Get-Date -UFormat "%d%m%Y%H%M"
psr.exe /start /output Desktop\$datenow.zip /sc 1 /gui 0 /maxsc 300
echo "when done type 'psr /stop'"
