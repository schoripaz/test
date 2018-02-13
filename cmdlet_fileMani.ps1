[CmdletBinding()]
param(
    [parameter(Mandatory=$true)]
    [string] $filePath,
    [parameter()]
    [string] $outputFile
)
$xbox = Get-Service -Name xbgm
 
Write-Host $xbox 
Write-Verbose "Starting cmdlet ps1"
Write-Verbose "starting filePath Validation"
if ((Test-Path -Path $filePath) -ne $true){
    Write-Verbose "The path is not valid"
    Write-Host "$filePath is not valid please try again" -ForegroundColor Yellow
    Exit
}

if ($outputFile -ne "" -and (Test-Path -Path $outputFile) -ne $true){
    Write-Verbose "starting create $outputFile"
    New-Item -Path $outputFile -ItemType File | Out-Null
    Write-Verbose "testing if $outputFile create successfully???"
    if ((Test-Path -Path $outputFile) -ne $true){
        Write-Verbose "$outputFile created successfully"
        Write-Host "$outputFile not created" -ForegroundColor Yellow
        exit
    }
    Write-Verbose "$outputFile was create successfully"
}

function output{
    param($computerName)
    $computerName >> $outputFile
}

$listComputers = Get-Content $filePath
Write-Verbose "beginnig foreach loop"
foreach($computer in $listComputers){
    Write-Verbose "Beginning check connection of computer name"
    if ((Test-Connection -ComputerName $computer -Count 1 -Quiet) -eq $true){
        Write-Host "successfully ping to $computer" -ForegroundColor Green
    }
    else{
        Write-Verbose "Computer is not responding"
        Write-Verbose "determining if $computer will copied to $outputFile"
        if($outputFile -ne ""){
            Write-Verbose "call output func with -param $computer "
            output -computerName $computer
        }
        Write-Host "failed to Ping $computer" -ForegroundColor Red
    }
}
Write-Verbose "Complete script"
