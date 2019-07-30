#AUTOR:  FELIPE RODRIGUES
#DATA 12/07/19


#LISTAR TODAS AS VMS DE TODOS OS CLUTERS E SEUS IP'S

$no1 = Get-Cluster -Name CLUSTER | Get-ClusterNode
$no2 = Get-Cluster -Name Cluster_Hyper-V_02 | Get-ClusterNode
$no3 = Get-Cluster -Name Cluster_HV_03 | Get-ClusterNode
$outros =@( 'SECH28' , 'SECH51' , 'SECH60' , 'SECH61')
$nototal = $no1 + $no2 + $no3 + $outros

#CRIAR AS SESSOES
$s = New-PSSession -ComputerName $nototal


############# SNAPSHOT DO AMBIENTE

#$credential = Get-Credential -Credential hostweb\waytec


####################

#Invoke-Command -Session $s -ScriptBlock { & $comando} -ArgumentList $comando
#Invoke-Command -ComputerName localhost -ScriptBlock {& $using:comando}

$saida = Invoke-Command -Session $s -FilePath C:\script\script2.ps1
$saida1 = Invoke-Command -Session $s -FilePath C:\script\script3.ps1



$saida > c:\temp\saida.txt
$saida1 > c:\temp\saida1.txt


$saida | Export-Csv -Path c:\temp\saida.csv
$saida1 | Export-Csv -Path c:\temp\saida1.csv


$a = Import-Csv c:\temp\saida.csv | Select-Object Vm,Memoria,Processador,Disco_GB,OS,IP,VLAN,Volume,Cliente,Host
$b = Import-Csv c:\temp\saida1.csv -Delimiter "," | Select-Object VMname, Path, Type, Format, SizeGB, FileSizeGB, PSComputerName


Dashboard -Name 'Ambiente' -FilePath C:\inetpub\consultadados.com.br\ambiente2.html -Show {
    Tab -Name 'Ambiente' {
        Section -Name 'Ambiente' {
            Table -DataTable $a -HideFooter
        }
       
    }
    Tab -Name 'DISCOS' {
     Section -Name 'Discos' {
        Panel {
            Table -DataTable $b -HideFooter
        }

       
}
}
}


#Import-Csv c:\temp\saida.csv | Select-Object Vm,Memoria,Processador,Disco_GB,OS,IP,Volume,Cliente,Host | Out-GridHtml -Title Ambiente -FilePath C:\inetpub\consultadados.com.br\ambiente.html

#Desconectar as sessoes abertas
Get-PSSession | Disconnect-PSSession
