Import-Module -Name ( Resolve-Path( Join-Path -Path ( $PSScriptRoot ) -ChildPath "..\Scripts.psm1" ) ) -ErrorAction Stop -Force

RunBuild @(
    "$($global:context.ProjectInfos.Name)Editor"
    "Win64"
    "Development"
    "-project=`"$($global:context.ProjectInfos.UProjectPath)`""
    "-WaitMutex"
    "-FromMsBuild"
)