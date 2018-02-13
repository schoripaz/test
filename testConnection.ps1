[CmdletBinding()]
param(
    # path to list computers
    [parameter()]
    [string] $filePath,
    #path to file that hold results of disconnected machine
    [string] $outputFile
)

# test exist file?
if ((test-path -path $filePath) -ne $true){
    write-host "$filePath is not valid please try again "
    exit
}    


