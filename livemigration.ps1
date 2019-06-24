#AUTOR:  FELIPE RODRIGUES
#DATA 09/05/19


$cluster = Read-Host -prompt 'Selecione o Cluster DIGITE O NUMERO:
1-CLUSTER ALDEOTA
2-CLUSTER SERRINHA
3-CLUSTER_HV_03
4-TODOS OS CLUSTER
'


if ($cluster -eq 1){  
$no = Get-Cluster -Name CLUSTER | Get-ClusterNode
Invoke-Command -scriptblock {Get-WinEvent -LogName Microsoft-Windows-Hyper-V-VMMS-Admin  -MaxEvents 100 | Where {$_.Message -match 'live'}  } -computername $no | ft -AutoSize


}
else {

if ($cluster -eq 2){
$no = Get-Cluster -Name Cluster_Hyper-V_02 | Get-ClusterNode
Invoke-Command -scriptblock {Get-WinEvent -LogName Microsoft-Windows-Hyper-V-VMMS-Admin  -MaxEvents 100 | Where {$_.Message -match 'live'}  } -computername $no | ft -AutoSize

}

else {

if ($cluster -eq 3){
$no = Get-Cluster -Name Cluster_HV_03 | Get-ClusterNode
Invoke-Command -scriptblock {Get-WinEvent -LogName Microsoft-Windows-Hyper-V-VMMS-Admin  -MaxEvents 100 | Where {$_.Message -match 'live'}  } -computername $no | ft -AutoSize

}
else{

if ($cluster -eq 4){

$no1 = Get-Cluster -Name CLUSTER | Get-ClusterNode
$no2 = Get-Cluster -Name Cluster_Hyper-V_02 | Get-ClusterNode
$no3 = Get-Cluster -Name Cluster_HV_03 | Get-ClusterNode
Invoke-Command -scriptblock {Get-WinEvent -LogName Microsoft-Windows-Hyper-V-VMMS-Admin  -MaxEvents 100 | Where {$_.Message -match 'live'}  } -computername $no1 | ft -AutoSize
Invoke-Command -scriptblock {Get-WinEvent -LogName Microsoft-Windows-Hyper-V-VMMS-Admin  -MaxEvents 100 | Where {$_.Message -match 'live'}  } -computername $no2 | ft -AutoSize
Invoke-Command -scriptblock {Get-WinEvent -LogName Microsoft-Windows-Hyper-V-VMMS-Admin  -MaxEvents 100 | Where {$_.Message -match 'live'}  } -computername $no3 | ft -AutoSize

}

else {
Write-Host ERROR ESCOLHA O NUMERO CORRETO

}
}
}
}
