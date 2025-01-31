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

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($PAT)"))

$result = Invoke-RestMethod -Uri $url -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)} -Method Get -ContentType "application/json"

# Prepare the body for the CREATE request.  This is the crucial change.
$body = @{
    name = $result.name  # Use the name from the retrieved group
    description = $result.description # Use the description (if any)
    variables = $result.variables # Use the variables
} | ConvertTo-Json -Depth 10

$updateurl = "https://dev.azure.com/{organization}/{projectB}/_apis/distributedtask/variablegroups?api-version=5.1-preview.1"

# Create the new variable group in the Datalake project
Invoke-RestMethod -Uri $updateurl -Headers @{Authorization = "Basic {0}" -f $base64AuthInfo} -ContentType "application/json" -Method Post -Body $body


