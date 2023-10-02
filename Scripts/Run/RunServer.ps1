Import-Module -Name ( Resolve-Path( Join-Path -Path ( $PSScriptRoot ) -ChildPath "..\Scripts.psm1" ) ) -ErrorAction Stop -Force

RunEditor @( 
    "L_Test_001"
    "-server"
    "-forcelan"
    "-log"
    "-stdout"
    "-notimeouts")