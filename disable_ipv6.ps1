$nic = get-netadapter
Disable-NetAdapterBinding –Name $nic.name –ComponentID ms_tcpip6
Get-NetAdapterBinding | Where-Object {$_.ComponentID -match "ms_tcpip6"}
