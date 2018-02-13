function testConnection () {
    param ($computerName)
    if ((Test-Connection -ComputerName $computerName -Count 1 -Quiet) -eq $true){
        Write-Host "successfully ping to $computerName" -ForegroundColor Green
    }
    else{
        Write-Host "failed to Ping $computerName" -ForegroundColor Red
    }
}
#$computerName = "schori"
$listComputers = Get-Content -Path ".\vid5computers.txt"
foreach ($computerName in $listComputers){
    testConnection -computerName $computerName
}


