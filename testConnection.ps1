[CmdletBinding()]
param(
    # path to list computers
    [parameter(Mandatory=$true)]
    [string] $filePath,
    #path to file that hold results of disconnected machine
    [string] $outputFile
)
#$ErrorActionPreference = 'Stop'
# test exist file?
Write-Verbose "check if filepath $filePath exist"
if ((test-path -path $filePath) -ne $true){
    write-host "$filePath is not valid please try again" -ForegroundColor Red
    exit 
}

# check validation of outputFile for OFLINE computers if request by parameter
Write-Verbose "checking if $outputFile is valid parameter (-outputFile) "
if($outputFile -ne "" -and(Test-Path -Path $outputFile)-ne $true){
    Write-Verbose "running new-item to create $outputFile"
    Write-Host "run new-item func to create $outputFile for OFFLINE computers"
    New-Item -Path $outputFile -ItemType File 
    Write-Verbose "checking if $outputFile create successfully"
    if ((Test-Path -Path $outputFile)-ne $true){
        Write-Verbose "running test-path to validate new-item ($outputFile)create successfully"
        Write-Host "failed to create $outputFile please try again"
        exit
    }
}
else{
    Write-Verbose "$outputFile allready exist"
    write-host "$outputFile allready exist" -ForegroundColor Yellow
}
# create func that write output to file
function output ($computer) {
    $computer >> $outputFile    
}
Write-Host "get contents of computers.txt $filePath"
$computersList = Get-Content -Path $filePath
foreach ($computer in $computersList){
    Write-Verbose "running test-connection func on $computer"  
    if((Test-Connection -ComputerName $computer -Count 1 -Quiet) -eq $true){      
        Write-Host "$computer is ONLINE" -ForegroundColor Green
    }
    else{
        Write-Host "$computer IS OFFLINE!!!" -ForegroundColor Red
        Write-Verbose "adding OFFLINE computers to $outputFile"
        output $computer
    }
}