clear
$UserPadrao = 'xxxx'
$UserDestino = $UserPadrao + 'adm'

$NameUserDestino = Get-aduser $UserDestino | Select-Object Name
    $User = $NameUserDestino.Name

$grupos = ((Get-ADUser -Identity $UserPadrao -Properties MemberOf | Select-Object MemberOf).MemberOf) 
    $grupoprod = $grupos
    foreach ($i in $grupos) { 
    Start-Sleep 2 
    
    Write-HOST "Adicionando ao grupo: $i"

    Add-ADGroupMember -Identity $i -Members $UserDestino 

}
 Write-HOST `n 
 Write-HOST "Usuario Espelhado com sucesso!" -foregroundcolor "Green"
 Write-HOST `n 
 
 Write-HOST "Grupos Atualizados do Colaborador: $user" -foregroundcolor "Green" 
 Write-HOST `n 
