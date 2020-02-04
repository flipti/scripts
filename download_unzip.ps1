#FUNCAO DOWNLOAD DO ARQUIVO E DESCOMPACTA O ARQUIVO ZIPADO

$url = "http://s2ramg01:9080/ram/artifact/59C3EB56-C97B-B318-3224-2945BDE2A371/2.0.5"
$output = "c:\temp\teste.zip"

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)

Expand-Archive -Path c:\temp\teste.zip -DestinationPath C:\temp\teste
