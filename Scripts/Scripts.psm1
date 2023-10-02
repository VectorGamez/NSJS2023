$ScriptFiles = Get-ChildItem -Recurse "$PSScriptRoot\Internal" -Include *.ps1 
 
foreach ( $ScriptFile in $ScriptFiles ) { 
    . $ScriptFile.FullName
}

$global:context = New-Object Context

Write-Host -ForegroundColor Green "Module $(Split-Path $PSScriptRoot -Leaf) was successfully loaded."
Write-Host