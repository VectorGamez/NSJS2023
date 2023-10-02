try {
    Write-Host
    $CloseEditor = Join-Path -Path $PSScriptRoot -ChildPath "\\Scripts\\Tools\\CloseEditor.ps1"
    Invoke-Expression "& `"$CloseEditor`""
    Write-Host
} catch {
    Write-Error $_
    Exit 1
}

try {
    Write-Host
    $CompileEditor = Join-Path -Path $PSScriptRoot -ChildPath "\\Scripts\\Tools\\CompileEditor.ps1"
    Invoke-Expression "& `"$CompileEditor`""
    Write-Host
} catch {
    Write-Error $_
    Exit 1
}

try {
    Write-Host
    $RunEditor = Join-Path -Path $PSScriptRoot -ChildPath "\\Scripts\\Tools\\RunEditor.ps1"
    Invoke-Expression "& `"$RunEditor`""
    Write-Host
} catch {
    Write-Error $_
    Exit 1
}