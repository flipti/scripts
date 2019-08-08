Import-Module PSWriteHTML
Import-module Dashimo

# C:\Program Files (x86)\Robware\RVTools
# rvtools.exe -u hwindows@cometa.local -p 2019_@HWin -s 192.168.6.181 -c ExportAll2csv -d d:\teste -f teste

$a = Import-Csv D:\teste\RVTools_tabvInfo.csv
$b = Import-Csv D:\teste\RVTools_tabvCPU.csv
$c = Import-Csv D:\teste\RVTools_tabvMemory.csv
$d = Import-Csv D:\teste\RVTools_tabvDisk.csv
$e = Import-Csv D:\teste\RVTools_tabvPartition.csv
$f = Import-Csv D:\teste\RVTools_tabvNetwork.csv
$g = Import-Csv D:\teste\RVTools_tabvFloppy.csv
$h = Import-Csv D:\teste\RVTools_tabvCD.csv
$i = Import-Csv D:\teste\RVTools_tabvSnapshot.csv
$j = Import-Csv D:\teste\RVTools_tabvTools.csv
$l = Import-Csv D:\teste\RVTools_tabvRP.csv
$m = Import-Csv D:\teste\RVTools_tabvCluster.csv
$n = Import-Csv D:\teste\RVTools_tabvHost.csv
$o = Import-Csv D:\teste\RVTools_tabvHBA.csv
$p = Import-Csv D:\teste\RVTools_tabvNIC.csv
$q = Import-Csv D:\teste\RVTools_tabdvSwitch.csv
$r = Import-Csv D:\teste\RVTools_tabdvPort.csv
$s = Import-Csv D:\teste\RVTools_tabvDatastore.csv
$t = Import-Csv D:\teste\RVTools_tabvMultiPath.csv
$u = Import-Csv D:\teste\RVTools_tabvLicense.csv
$v = Import-Csv D:\teste\RVTools_tabvHealth.csv





Dashboard -Name 'VMWARE' -FilePath D:\teste\teste.html -Show {
    Tab -Name 'VMWARE' {
        Section  -Name 'INFO' -Collapsable {
            Table -DataTable $a -HideFooter
        }
        Section -Name 'CPU' -Collapsable {
            Table -DataTable $b -HideFooter
        }
        Section -Name 'MEMORIA' -Collapsable {
            Table -DataTable $c -HideFooter
        }
        Section -Name 'DISCO' -Collapsable {
            Table -DataTable $d -HideFooter
        }
        Section -Name 'PARTICAO' -Collapsable {
            Table -DataTable $e -HideFooter
        }
        Section -Name 'NETWORK' -Collapsable {
            Table -DataTable $f -HideFooter
        }
        Section -Name 'FLOPPY' -Collapsable {
            Table -DataTable $g -HideFooter
        }
        Section -Name 'CD' -Collapsable {
            Table -DataTable $h -HideFooter
        }
        Section -Name 'SNAPSHOT' -Collapsable {
            Table -DataTable $i -HideFooter
        }
        Section -Name 'VM_TOOLS' -Collapsable {
            Table -DataTable $j -HideFooter
        }
        Section -Name 'RP' -Collapsable {
            Table -DataTable $l -HideFooter
        }
        Section -Name 'CLUSTER' -Collapsable {
            Table -DataTable $m -HideFooter
        }
        Section -Name 'HOST' -Collapsable {
            Table -DataTable $n -HideFooter
        }
        Section -Name 'HBA' -Collapsable {
            Table -DataTable $o -HideFooter
        }
        Section -Name 'NIC' -Collapsable {
            Table -DataTable $p -HideFooter
        }
        Section -Name 'SWITCH' -Collapsable {
            Table -DataTable $q -HideFooter
        }
        Section -Name 'PORT' -Collapsable {
            Table -DataTable $r -HideFooter
        }
        Section -Name 'DATASTORE' -Collapsable {
            Table -DataTable $s -HideFooter
        }
        Section -Name 'MULTIPATH' -Collapsable {
            Table -DataTable $t -HideFooter
        }
        Section -Name 'LICENSE' -Collapsable {
            Table -DataTable $u -HideFooter
        }
        Section -Name 'HEALTH' -Collapsable {
            Table -DataTable $v -HideFooter
        }

    }


   
}
