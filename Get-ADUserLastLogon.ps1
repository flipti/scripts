function Get-ADUserLastLogon {
 
# .SYNOPSIS
# Get-ADUserLastLogon gets the last logon timestamp of an Active Directory user.
 
# .DESCRIPTION
# Each domain controller is queried separately to calculate the last logon from all results of all DCs.
 
# .PARAMETER
# UserLogonName
# Provide the user logon name (samaccountname) of the user.
 
# .EXAMPLE
# Get-ADUserLastLogon -UserLogonName s.stollane
 
# .NOTES
# Author: Patrick Gruenauer
# Web:
# https://sid-500.com
 
[CmdletBinding()]
param
 
(
 
[Parameter(Mandatory=$true)]
$UserLogonName
 
)
 
$resultlogon=@()
 
Import-Module ActiveDirectory
 
$ds=dsquery user -samid $UserLogonName
 
If ($ds) {
 
$getdc=(Get-ADDomainController -Filter *).Name
 
foreach ($dc in $getdc) {
 
Try {
 
$user=Get-ADUser $UserLogonName -Server $dc -Properties lastlogon -ErrorAction Stop
 
$resultlogon+=New-Object -TypeName PSObject -Property ([ordered]@{
 
'User' = $user.Name
'DC' = $dc
'LastLogon' = [datetime]::FromFileTime($user.'lastLogon')
 
})
 
}
 
Catch {
''
Write-Warning "No reports from $($dc)!"
 
}
 
}
 
$resultlogon | Where-Object {$_.lastlogon -NotLike '*1601*'} | Sort-Object LastLogon -Descending | Select-Object -First 1 | Format-Table -AutoSize
 
If (($resultlogon | Where-Object {$_.lastlogon -NotLike '*1601*'}) -EQ $null)
 
{
 
''
Write-Warning "No reports for user $($user.name). Possible reason: No first login."
 
}
}
 
else
 
{throw 'User not found. Check entered username.'}
 
}
