Import-Module -Name ( Resolve-Path( Join-Path -Path ( $PSScriptRoot ) -ChildPath "..\Scripts.psm1" ) ) -ErrorAction Stop -Force

Stop-Processes -processName "UnrealEditor*"