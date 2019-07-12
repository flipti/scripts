#LISTAR TODAS AS VMS DE TODOS OS CLUTERS E SEUS IP'S

$no1 = Get-Cluster -Name CLUSTER | Get-ClusterNode
$no2 = Get-Cluster -Name Cluster_Hyper-V_02 | Get-ClusterNode
$no3 = Get-Cluster -Name Cluster_HV_03 | Get-ClusterNode
$outros =@( 'SECH28' , 'SECH51' , 'SECH60' , 'SECH61')
$nototal = $no1 + $no2 + $no3 + $outros

#CRIAR AS SESSOES
$s = New-PSSession -ComputerName $nototal

###CAMINHO DE SCRIPT DE COLETA##
#C:\SCRIPT\script.ps1



#COMANDO PARA EXECUTAR NOS NÓS DO CLUSTER

#Invoke-Command -Session $s -ScriptBlock { & $comando} -ArgumentList $comando
#Invoke-Command -ComputerName localhost -ScriptBlock {& $using:comando}

$saida = Invoke-Command -Session $s -FilePath C:\script\script.ps1

#Remove-PSSession -ComputerName $nototal

$saida > c:\temp\saida.txt
$saida | Export-Csv -Path c:\temp\saida.csv

#Get-Content -Path c:\temp\saida.txt | Select-String -Pattern  'PSComputerName|RunspaceId' -NotMatch | Out-File -Path c:\temp\saida2.txt

Import-Csv c:\temp\saida.csv | Select-Object Vm,Memoria,Processador,Disco_GB,IP,Cliente,Host | Out-GridHtml -FilePath C:\inetpub\consultadados.com.br\ambiente.html

