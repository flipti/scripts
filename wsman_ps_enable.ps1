# Get a list of trusted hosts
Get-Item WSMan:\localhost\Client\TrustedHosts

# Note that these commands don't create a list of trusted hosts, it simply replaces the trusted host with what you set via the command. If you need to add multiple hosts, they need to be comma seperated

# Trust all computers in a domain
Set-Item WSMan:\localhost\Client\TrustedHosts *.contoso.com

# Turst a single machine
Set-Item WSMan:\localhost\Client\TrustedHosts -Value myserver

# Add another single machine
$trustedHosts = (Get-Item WSMan:\localhost\Client\TrustedHosts).value
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "$trustedHosts, mynextserver"

# Trust an IP address range
Set-Item WSMan:\localhost\Client\TrustedHosts -value 192.168.10.*

# Trust all remote machines (not recommended)
Set-Item WSMan:\localhost\Client\TrustedHosts *