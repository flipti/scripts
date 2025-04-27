# Configurações
$personalAccessToken = "INSIRA SEU TOKEN"
$variableGroupId = "8" # INSIRA SEU ID DO VARIABLE GROUP
$organization = "bioholding"
$project = "Out Buy Center - Compras"  # Nome do projeto original
$appsettingsPath = "C:\projetos\devops\appsettings.json" # Caminho para o arquivo appsettings.json original
$newAppsettingsPath = "C:\projetos\devops\appsettings_updated.json" # Caminho para o novo arquivo gerado

# Substituindo espaços por %20 no nome do projeto
$encodedProject = [uri]::EscapeDataString($project)

# URL da API REST para obter o Variable Group
$url = "https://dev.azure.com/{0}/{1}/_apis/distributedtask/variablegroups/{2}?api-version=5.1-preview.1" -f $organization, $encodedProject, $variableGroupId

# Configuração da Autenticação
$headers = @{
    Authorization = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$personalAccessToken"))
}

# Obtendo as variáveis do Variable Group
try {
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get

    # Verificando se existe um objeto 'variables' na resposta
    if ($response.variables) {
        Write-Host "Variáveis obtidas com sucesso!"
        
        # Lendo o conteúdo do appsettings.json
        $appsettingsContent = Get-Content -Path $appsettingsPath -Raw

        # Iterando sobre as propriedades das variáveis no response
        foreach ($property in $response.variables.PSObject.Properties) {
            $key = $property.Name
            $value = $property.Value.value

            Write-Host "Substituindo: '$key' com valor '$value'"

            # Verificando se o valor da variável é uma string não vazia
            if ($value -and $value -ne '') {
                # Limpando as barras invertidas do valor, se necessário
                $escapedValue = $value -replace '\\', ''  # Removendo todas as barras invertidas

                # Substituindo a variável no conteúdo do arquivo
                $appsettingsContent = $appsettingsContent -replace [regex]::Escape($key), $escapedValue
            } else {
                Write-Host "Valor inválido ou vazio para a variável: '$key'"
            }
        }

        # Remover os caracteres '__' restantes
        $appsettingsContent = $appsettingsContent -replace '__', ''

        # Salvando o conteúdo modificado em um novo arquivo
        Set-Content -Path $newAppsettingsPath -Value $appsettingsContent -Encoding UTF8 -Force

        Write-Host "Substituições realizadas com sucesso no arquivo $newAppsettingsPath."
    } else {
        Write-Host "Nenhuma variável encontrada no Variable Group."
    }
} catch {
    Write-Host "Erro ao obter os valores do Variable Group: $($_.Exception.Message)"
}
