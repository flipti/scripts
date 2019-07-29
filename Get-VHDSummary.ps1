Function Get-VHDSummary {
Param()
 
#get all virtual machines
$vms=Get-VM
 
foreach ($vm in $vms) {
  Write-Host "Getting drive info from $($vm.name)" -foregroundcolor Cyan
  #get the hard drives foreach virtual machine
  $vm.HardDrives | foreach-object {
      #a VM might have multiple drives so for each one get the VHD
      $vhd=Get-VHD -path $_.path
 
      <#
       $_ is the hard drive object so select a few properties and
       include properties from the VHD
      #>
      $_ | Select-Object -property VMName,Path,
        @{Name="Type";Expression={$vhd.VhdType}},
        @{Name="Format";Expression={$vhd.VhdFormat}},
        @{Name="SizeGB";Expression={($vhd.Size)/1GB -as [int]}},
        @{Name="FileSizeGB";Expression={($vhd.FileSize)/1GB -as [int]}}
 } #foreach
} #foreach vm
 
} #close function
