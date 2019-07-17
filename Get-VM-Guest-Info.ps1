# Source: http://www.yusufozturk.info/virtual-machine-manager/getting-virtual-machine-guest-information-from-hyper-v-server-2012r2.html
# Usage example: Get-VMGuestInfo -VMName TEST01 -HyperVHost VMHOSTT01
function Get-VMGuestInfo
{
<#
    .SYNOPSIS
 
        Gets virtual machine guest information
 
    .EXAMPLE
 
        Get-VMGuestInfo -VMName Test01
 
    .EXAMPLE
 
        Get-VMGuestInfo -VMName Test01 -HyperVHost Host01
 
    .NOTES
 
        Author: Yusuf Ozturk
        Website: http://www.yusufozturk.info
        Email: ysfozy[at]gmail.com
 
#>
 
[CmdletBinding(SupportsShouldProcess = $true)]
param (
 
    [Parameter(
        Mandatory = $true,
        HelpMessage = 'Virtual Machine Name')]
    $VMName,
 
    [Parameter(
        Mandatory = $false,
        HelpMessage = 'Hyper-V Host Name')]
    $HyperVHost = "localhost",
 
	[Parameter(
        Mandatory = $false,
        HelpMessage = 'Debug Mode')]
    [switch]$DebugMode = $false
)
	# Enable Debug Mode
	if ($DebugMode)
	{
		$DebugPreference = "Continue"
	}
	else
	{
		$ErrorActionPreference = "silentlycontinue"
	}
 
	$VMState = (Get-VM -ComputerName $HyperVHost -Name $VMName).State
 
	if ($VMState -eq "Running")
	{
		filter Import-CimXml
		{
			$CimXml = [Xml]$_
			$CimObj = New-Object -TypeName System.Object
			foreach ($CimProperty in $CimXml.SelectNodes("/INSTANCE/PROPERTY"))
			{
				if ($CimProperty.Name -eq "Name" -or $CimProperty.Name -eq "Data")
				{
					$CimObj | Add-Member -MemberType NoteProperty -Name $CimProperty.NAME -Value $CimProperty.VALUE
				}
			}
			$CimObj
		}
 
		$VMConf = Get-WmiObject -ComputerName $HyperVHost -Namespace "root\virtualization\v2" -Query "SELECT * FROM Msvm_ComputerSystem WHERE ElementName like '$VMName' AND caption like 'Virtual%' "
		$KVPData = Get-WmiObject -ComputerName $HyperVHost -Namespace "root\virtualization\v2" -Query "Associators of {$VMConf} Where AssocClass=Msvm_SystemDevice ResultClass=Msvm_KvpExchangeComponent"
		$KVPExport = $KVPData.GuestIntrinsicExchangeItems
 
		if ($KVPExport)
		{
			# Get KVP Data
			$KVPExport = $KVPExport | Import-CimXml
 
			# Get Guest Information
			$VMOSName = ($KVPExport | where {$_.Name -eq "OSName"}).Data
			$VMOSVersion = ($KVPExport | where {$_.Name -eq "OSVersion"}).Data
			$VMHostname = ($KVPExport | where {$_.Name -eq "FullyQualifiedDomainName"}).Data
		}
		else
		{
			$VMOSName = "Unknown"
			$VMOSVersion = "Unknown"
			$VMHostname = "Unknown"
		}
	}
	else
	{
		$VMOSName = "Unknown"
		$VMOSVersion = "Unknown"
		$VMHostname = "Unknown"
	}
 
	$Properties = New-Object Psobject
	$Properties | Add-Member Noteproperty VMName $VMName
	$Properties | Add-Member Noteproperty VMHost $HyperVHost
	$Properties | Add-Member Noteproperty VMState $VMState
	$Properties | Add-Member Noteproperty VMOSName $VMOSName
	$Properties | Add-Member Noteproperty VMOSVersion $VMOSVersion
	$Properties | Add-Member Noteproperty VMHostname $VMHostname
	Write-Output $Properties
