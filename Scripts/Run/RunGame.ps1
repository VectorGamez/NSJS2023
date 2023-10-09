Import-Module -Name ( Resolve-Path( Join-Path -Path ( $PSScriptRoot ) -ChildPath "..\Scripts.psm1" ) ) -ErrorAction Stop -Force

RunEditor @( 
    "$($global:context.ConfigInfos.GameOptions.MapName)$($global:context.ConfigInfos.GameOptions.Options)"
    "-ResX=$($global:context.ConfigInfos.GameOptions.Width)"
    "-ResY=$($global:context.ConfigInfos.GameOptions.Height)")