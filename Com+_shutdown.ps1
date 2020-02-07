$comAdmin = New-Object -com ("COMAdmin.COMAdminCatalog.1")
$applications = $comAdmin.GetCollection("Applications") 
$applications.Populate()
$applications

#$comAdmin.ShutdownApplication("appname")
#$comAdmin.StartApplication("appName")
