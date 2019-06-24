$data_inicio = Get-Date -format "dd-MM-yyyy-HH-mm-ss"
$expdp_pump_dir="E:\Producao\Oracle\backup"
$username=""
$password=""
$log_file="expdp-orclnovo-"+$data_inicio+".log"

expdp $username/$password directory=expdp_pump_dir dumpfile=expdp-orclnovo-$data_inicio.dmp logfile=$log_file content=metadata_only full=y 

$data_fim = Get-Date -format "dd-MM-yyyy-HH-mm-ss"


$caminho = "E:\Producao\Oracle\backup\expdp-orclnovo-$data_inicio.dmp"
$destino = "E:\Producao\Oracle\backup\expdp-orclnovo-$data_fim.dmp.7z"

set-alias zip "$env:ProgramFiles\7-Zip\7z.exe"

zip a -t7z $destino $caminho
Remove-Item "$expdp_pump_dir\EXPDP-ORCLNOVO-$data_inicio.DMP"


Get-ChildItem –Path "E:\Producao\Oracle\backup" | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-2))} | Remove-Item

## metade do script

$sqlquery = "

insert into secrel_italo.v`$data_pump(start_time,end_time,dump_file_name,dump_file_log,completion_status) values("+ "to_date(" + "`'"+$data_inicio + "`'" + "," + "'DD-MM-YYYY-HH24:Mi:ss')" + ","+ "to_date(" + "`'"+$data_fim+"`'" + "," + "'DD-MM-YYYY-HH24:Mi:ss')" +","+"`'"+$destino+"`'"+","+"`'"+$log_file+"`'"+","+1+");"+"`n" + "commit;"

$sqlquery | sqlplus / as sysdba | Out-File c:\temp\log.txt
