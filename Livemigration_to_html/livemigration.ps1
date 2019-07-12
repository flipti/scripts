#AUTOR:  FELIPE RODRIGUES
#DATA 09/05/19

$data=get-date


$no1 = Get-Cluster -Name CLUSTER | Get-ClusterNode
$no2 = Get-Cluster -Name Cluster_Hyper-V_02 | Get-ClusterNode
$no3 = Get-Cluster -Name Cluster_HV_03 | Get-ClusterNode
$no4 = Get-Cluster -Name Cluster_SQL_01 | Get-ClusterNode
$notal = $no1 + $no2 + $no3 +$no4
$saida = Invoke-Command -scriptblock {Get-WinEvent -LogName Microsoft-Windows-Hyper-V-VMMS-Admin  -MaxEvents 1000 | Where {$_.Message -match 'live'}  } -computername $notal | select Message, PSComputerName, Timecreated  

if ($saida -eq $empyt) {
$var = "NÃO HÁ LIVE MIGRATION DO DIA $data"
$var > C:\inetpub\consultadados.com.br\live_migration\migration.html
}

else {
$saida | Out-HtmlView -Title "Live Migration" -FilePath C:\inetpub\consultadados.com.br\live_migration\migration.html
}
