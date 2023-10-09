Import-Module -Name ( Resolve-Path( Join-Path -Path ( $PSScriptRoot ) -ChildPath "..\Scripts.psm1" ) ) -ErrorAction Stop -Force

RunEditor @( 
    "$($global:context.ConfigInfos.ClientOptions.IPAddress)$($global:context.ConfigInfos.ClientOptions.Options)"
    "-ResX=$($global:context.ConfigInfos.ClientOptions.Width)"
    "-ResY=$($global:context.ConfigInfos.ClientOptions.Height)")