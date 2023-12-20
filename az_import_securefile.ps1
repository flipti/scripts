#TOKEN QUE DEVE SER GERADO
$PAT = ""

$base64AuthInfo = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($PAT)"))

# URL DA API ONDE DEVE SE ALTERAR A EMPRESA,PROJETO E NOME DO SECUREFILE 
$updateurl = "https://dev.azure.com/DiagnosticosBrasil/Dashboard%20Diretoria/_apis/distributedtask/securefiles?api-version=5.0-preview.1&name=producao_db-apigee-prd-024c9c1c55c9.json"
$body = $result | ConvertTo-Json -Depth 10
Invoke-RestMethod -Uri $updateurl -Headers @{Authorization = "Basic {0}" -f $base64AuthInfo} -ContentType "application/octet-stream" -Method post -Body $body
