Import-Module -Name ( Resolve-Path( Join-Path -Path ( $PSScriptRoot ) -ChildPath "..\Scripts.psm1" ) ) -ErrorAction Stop -Force

RunEditor @( 
    "$($global:context.ConfigInfos.ServerOptions.MapName)"
    "-server"
    "-forcelan"
    "-log"
    "-stdout"
    "-notimeouts")