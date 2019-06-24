###COLETA NOME , MEMORIA, NUMERO DE PROCESSADOR, NOTE ,HOST , SOMA OS DISCOS##

Get-VM * | ForEach-Object {
    $VHDSize = 0;
    #$VMName = $_.Name;
    Get-VMHardDiskDrive -VMName $_.Name | ForEach-Object {
        Get-VHD -Path $_.Path | ForEach-Object {
            $VHDSize += $_.Size
        }
    };
     
     [pscustomobject]@{
      Vm = $_.name
      Memoria = ($_.MemoryStartup/1GB)
      Processador = ($_.ProcessorCount)
      Disco_GB = ($VHDSize / 1GB)
      Cliente = $_.Notes
      Host = $_.computername
     }
} | ft -auto

