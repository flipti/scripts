<#
O CODIGO ABAIXO REALIZA A ALTERAÇÃO DO ARQUIVO TIPO TXT, ENCONTRANDO UM PADRAO E ALTERANDO (ELIMINANDO OU ADICIONANDO)
#>

$herestring = @"
<add key="strAssuntoEmail" value=" - ERRO x  - Migrado"/>
`t`t<add key="strAssuntoEmail" value=" - ERRO x  - Migrado"/>
`t`t<add key="strAssuntoEmail" value=" - ERRO x - Migrado"/>
`t`t<add key="strAssuntoEmail" value=" - ERRO x - Migrado"/>
"@

$pattern = '<add key="strAssuntoEmail" value=" - ERRO x - Migrado"/>'

(Get-Content C:\Temp\'NOMEDOARQUIVO' -Raw).Insert($pattern,$herestring) | Out-File C:\Temp\Saida_NOMEDOARQUIVO.txt 
