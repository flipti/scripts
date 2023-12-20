#COLOCAR O PERSONAL ACESS TOKEN

$PAT = ""

$base64AuthInfo = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($PAT)"))

# Diretório que contém os arquivos que você deseja adicionar como secure files
$directoryPath = "C:\caminho\para\sua\pasta"

# Itera sobre todos os arquivos no diretório
foreach ($file in Get-ChildItem -Path $directoryPath) {
    $filePath = $file.FullName

    # Nome do arquivo (sem o caminho completo)
    $fileName = $file.Name

    # URL da API onde você deve alterar a empresa, projeto
    $updateurl = "https://dev.azure.com/DiagnosticosBrasil/Dashboard%20DB%20-%20MOL%20PAT%20TOX/_apis/distributedtask/securefiles?api-version=5.0-preview.1&name=$fileName"

    # Lê o conteúdo do arquivo e converte para base64
    $fileContentBase64 = [System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes($filePath))

    # Corpo da solicitação
    $body = @{
        authorized = "true"
        name = $fileName
        properties = @{
            description = "Descrição do Secure File"
        }
        ticket = "token"
        contentType = "application/octet-stream"
        content = $fileContentBase64
    } | ConvertTo-Json

    # Envia a solicitação para a API
    Invoke-RestMethod -Uri $updateurl -Headers @{Authorization = "Basic {0}" -f $base64AuthInfo} -Method Post -Body $body -ContentType "application/json"
}
