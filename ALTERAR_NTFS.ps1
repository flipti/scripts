<#
O CODIGO IRA ADICIONAR O USUARIO XYZ COM PERMISSAO DE SOMENTE LEITURA PARA OS COMPARTILHAMENTOS.

#>

$unidades_s3 = @(
 'S3DCAG002'

)

$unidades_ag = @(
'agxxxx_ger01'
)


#Declarar array
$a = @()
$b = @()


<#
FUNCAO ABAIXO IRA EXECUTAR NAS UNIDADES S3
#>

foreach ($unidade in $unidades_s3) {

$acl = Get-Acl \\$unidade\INSTALL
$acl.SetAccessRuleProtection($False,$True)
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("DOMINIO\XYZ","Read,ReadandExecute","ContainerInherit, ObjectInherit","None","Allow")
$acl.SetAccessRule($AccessRule)

$acl | Set-Acl \\$unidade\INSTALL  -ErrorAction Inquire
$a += Get-Acl \\$unidade\INSTALL | fl
$a
}

<#
FUNCAO ABAIXO IRA EXECUTAR NAS UNIDADES AG
#>

foreach ($unidade in $unidades_ag) {
$acl = Get-Acl \\$unidade\INSTALL
$acl.SetAccessRuleProtection($False,$True)
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("CAPGV\CASH963","Read,ReadandExecute","ContainerInherit, ObjectInherit","None","Allow")
$acl.SetAccessRule($AccessRule)

$acl | Set-Acl \\$unidade\INSTALL  -ErrorAction Inquire
$b += Get-Acl \\$unidade\INSTALL | fl
$b

}


#GERANDO EVIDENCIA, RENOMEAR O ARQUIVO

$a + $b | Out-File -Append -Encoding ascii -FilePath C:\TEMP\RENOMEAROARQUIVO.doc
