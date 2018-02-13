[CmdletBinding()]
param(
    # path to list computers
    [parameter(Mandatory=$true)]
    [string] $filePath,
    #path to file that hold results of disconnected machine
    [string] $outputFile
)

# test exist file?
if ((test-path -path $filePath) -ne $true){
    write-host "$filePath is not valid please try again "
    exit
}    
$computersList = Get-Content -Path $filePath
foreach ($computer in $computersList){
    Write-Verbose "running test-connection func on $computer"  
    if((Test-Connection -ComputerName $computer -Count 1 -Quiet) -eq $true){      
        Write-Host "$computer is ONLINE" -ForegroundColor Green
    }
    else{
        Write-Host "$computer IS OFLINE!!!" -ForegroundColor Red
    }
}