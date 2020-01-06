function watch {
   param([int]$timeInSeconds,[string]$cliCommand)
while ($true) {
      clear
      invoke-expression $cliCommand
      sleep $timeInSeconds
      }
}
