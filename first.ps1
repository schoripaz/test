$listcomputers = Get-Content G:\Docs\Study\udemy\powershell\computers.txt
Write-Host $listcomputers
ForEach ($computer in $listcomputers) {

    Write-Host "performing action on $computer"

    Test-Connection $computer -Count 1
}