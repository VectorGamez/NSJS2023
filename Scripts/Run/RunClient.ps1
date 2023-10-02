Import-Module -Name ( Resolve-Path( Join-Path -Path ( $PSScriptRoot ) -ChildPath "..\Scripts.psm1" ) ) -ErrorAction Stop -Force

RunEditor @( 
    "$($global:context.ConfigInfos.ClientOptions.IPAddress)"
    "-ResX=$($global:context.ConfigInfos.ClientOptions.Width)"
    "-ResY=$($global:context.ConfigInfos.ClientOptions.Height)"
    "-game"
    "-windowed"
    "-log"
    "-stdout"
    "-notimeouts"
    "-nosplash")