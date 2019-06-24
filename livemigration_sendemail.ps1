## LISTAR OS LIVE MIGRATION E ENVIAR EMAIL:

#AUTOR:  FELIPE RODRIGUES
#DATA 09/05/19

# Criando estilo do cabeçalho

$Head = @"
 
<style>
  body {
    font-family: "Arial";
    font-size: 8pt;
    color: #4C607B;
    }
  th, td {
    border: 1px solid #e57300;
    border-collapse: collapse;
    padding: 5px;
    }
  th {
    font-size: 1.2em;
    text-align: left;
    background-color: #003366;
    color: #ffffff;
    }
  td {
    color: #000000;
    }
  .even { background-color: #ffffff; }
  .odd { background-color: #bfbfbf; }
</style>
 
"@



$no1 = Get-Cluster -Name CLUSTER | Get-ClusterNode
$no2 = Get-Cluster -Name Cluster_Hyper-V_02 | Get-ClusterNode
$no3 = Get-Cluster -Name Cluster_HV_03 | Get-ClusterNode
$notal = $no1 + $no2 + $no3
$saida = Invoke-Command -scriptblock {Get-WinEvent -LogName Microsoft-Windows-Hyper-V-VMMS-Admin  -MaxEvents 100 | Where {$_.Message -match 'live'}  } -computername $notal |
select @{n='Mensagem';e={$_.Message}},
@{n='Host';e={$_.PSComputerName}},
@{n='Horário';e={$_.Timecreated}} | ConvertTo-Html -head $Head


$data=get-date

$Assunto = "LIVE MIGRATION DO DIA ` $data"



Function Send-Mail {
    Param($strAssunto, $strConteudo)

     $strDe = ""
     $strPara = ""
     $strPwd = ""
     $attachment2 = “C:\site\imagens\hostweb4.gif”
     $strConteudo  = $saida
     $SMTPServer = "mail.secrel.net.br"
     $SMTPMessage = New-Object System.Net.Mail.MailMessage($strDe,$strPara,$strAssunto,$strConteudo)
     $SMTPMessage.IsBodyHtml = $true
     $SMTPClient = New-Object Net.Mail.SmtpClient($SMTPServer, 587)
     $SMTPClient.EnableSsl = $false
     $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($strDe, $strPwd);
     $SMTPClient.Send($SMTPMessage)
     Remove-Variable -Name SMTPClient
     Remove-Variable -Name strPwd

}

Send-Mail $Assunto $Conteudo
