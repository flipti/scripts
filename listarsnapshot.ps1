## LISTAR SNAPSHOT


$machine = Get-VMsnapshot –VMname * -ComputerName HOST1,HOST2,HOST3
$machine | Get-VMHardDiskDrive | where {$_.path -match 'Volume15'} | Select-Object VMName,Path
