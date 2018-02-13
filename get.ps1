Get-Process | Where-Object {$_.ProcessName -eq "wininit"}
Get-WmiObject -Namespace ROOT\CIMV2 -Class win32_quickfixengineering | Where-Object {$_.HotfixID -like '*KB407*'}