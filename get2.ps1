$listComputers = Get-Content .\vid5computers.txt
foreach($computer in $listComputers){
    try {
    $testResults = Test-Connection -ComputerName $computer -Count 1 -Quiet
    if ($testResults -eq 'true'){
        if ($computer -eq "localhost"){
            Write-Host "this is local host w'll check connection, soft and process"
            Write-Host "connection test successfully on localhost" -ForegroundColor Green
            $getSoft = Get-WmiObject -Class win32_Product
            if ($getSoft.Name -eq "HP Update"){
                Write-Host "HP Update installed on localhost" -ForegroundColor Green
            }
            else{
                Write-Host "HP Update not installed on localhost" -ForegroundColor Red
            }
        }
        else{
            Write-Host "this not local host"
            Write-Host "connection test successfully on ps-win" -ForegroundColor Green
        }
    }
    else{
        Write-Host "SERV1 is OFLINE!!!" -ForegroundColor Yellow -BackgroundColor Red
    }
    }
    Catch{
        Write-Host "$_.ExeptionMessage" -ForegroundColor Yellow -BackgroundColor Red
    }
}    