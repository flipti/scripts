<#
Link referencia: http://kunaludapi.blogspot.com/2016/03/powershell-rocks-rejoin-computers-in.html
#>

#Executar o comando com powershell (admin)
#Premissa Powershell version 3 to use this command which is by default there in windows 2012 server version and windows 8.
Test-ComputerSecureChannel -Repair -Credential (Get-Credential)

#here is old trick for old OS you can use Netdom command (I used to use it on Windows 2008 r2 and lower OS, you can find this netdom 2008 os series by default,
#for older you can download it from its CD/DVD)
netdom resetpwd /Server:DC /UserD:DomainAdmin /PasswordD:Password
