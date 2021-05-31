$data = Get-Date
$Usuarios = @(
''
''
)

Write-Host  Comando Executado as $data -ForegroundColor Yellow -BackgroundColor DarkRed

foreach ($item in $Usuarios ) {

Get-ADUser -Filter {Name -like $item } | select @{n="Nome";e={ $_.name}} , @{n="Status";e={ $_.Enabled -replace 'False','Desabilitado'}  }


}



