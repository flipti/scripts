######################################################################
#SE LOGAR 
az login --allow-no-subscriptions
#WSL
az login --allow-no-subscriptions --use-device-code
######################################################################

#EXEMPLO PARA LISTAR TODOS OS VARIABLE GROUPS DE UM PROJETO COM SEU ID
az pipelines variable-group list --org https://dev.azure.com/DiagnosticosBrasil --project "Portal DB" --query "[].{Name:name, Id:id}" --output table
#######################################################################

#INICIO DO SCRIPT EDITAR ORGANIZAÇÃO,PROJECT,GROUPID E PAT(GERAR TOKEN CASO NÃO POSSUA )
# Get the variable group in projectA
$url = "https://dev.azure.com/{organization}/{projectA}/_apis/distributedtask/variablegroups/{groupId}?api-version=5.1-preview.1"

$PAT = "Personal access token"

$base64AuthInfo = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($PAT)"))

$result=Invoke-RestMethod -Uri $url -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)} -Method get -ContentType "application/json" 

# Call add variable group rest api to add variable group in ProjectB
$updateurl = "https://dev.azure.com/{organization}/{projectB}/_apis/distributedtask/variablegroups?api-version=5.1-preview.1"

$body = $result | ConvertTo-Json -Depth 10

Invoke-RestMethod -Uri $updateurl -Headers @{Authorization = "Basic {0}" -f $base64AuthInfo} -ContentType "application/json" -Method post -Body $body
