# Alterando a data de expiração das contas
# Domínio 
foreach ($user in (Get-Content ".txt")){
Get-ADUser -Server dominio -Identity $user -Properties * | Set-ADAccountExpiration -DateTime 01/01/2021
}
# Domínio 
foreach ($user in (Get-Content "..txt")){
Get-ADUser -Server dominio -Identity $user -Properties * | Set-ADAccountExpiration -DateTime 01/01/2021
}  


# Domínio 
foreach ($user in (Get-Content ".txt")){
Get-ADUser -Server dominio -Identity $user -Properties * | select Name,SamAccountName,AccountExpirationDate | Export-Csv ".csv>" -NotypeInformation -Encoding Unicode -Append
}  
