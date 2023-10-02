Import-Module -Name ( Resolve-Path( Join-Path -Path ( $PSScriptRoot ) -ChildPath "..\Scripts.psm1" ) ) -ErrorAction Stop -Force

RunEditor @( 
    "127.0.0.1"
    "-ResX=1024"
    "-ResY=768"
    "-game"
    "-windowed"
    "-log"
    "-stdout"
    "-notimeouts"
    "-nosplash")