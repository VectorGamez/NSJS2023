class EngineInfos
{
    [String] $Path;
    [String] $Association;
    [Version] $Version;

    [void] DumpToHost(){
        Write-Host ""
        Write-Host "----- Engine Infos -----"
        Write-Host " * Path : $($this.Path)"
        Write-Host " * Association : $($this.Association)"
        Write-Host " * Version : $($this.Version)"
        Write-Host "----- Engine Infos -----"
        Write-Host ""
    }

    [bool] IsValid(){

        $not_empty = ($null -ne $this.Path) && ($null -ne $this.Association) && ([Version]::new( 0, 0, 0 ) -ne  $this.Version)
        $valid_path = Test-Path $this.Path

        return $not_empty && $valid_path
    }
}

function Get-EngineAssociation( [String] $ProjectPath ) {
    $uproject_json = Get-Content -Raw -Path $ProjectPath | ConvertFrom-Json
    return $uproject_json.EngineAssociation
}

function Get-EnginePath( [String] $Association ) {
    $test_path = "HKLM:\SOFTWARE\EpicGames\Unreal Engine\$Association"
    if (Test-Path $test_path) {
        return (Get-ItemProperty -Path $test_path -Name "InstalledDirectory").InstalledDirectory
    }

    Write-Error "Unable to locate engine description at `"$test_path`"."
    return $null
}

function Get-EngineVersion( [string] $EnginePath ) {
    $build_version_file_path = Join-Path -Path $EnginePath -ChildPath "Engine\Build\Build.version"

    if ( [System.IO.File]::Exists( $build_version_file_path ) -eq $False ) {
        Write-Warning "Impossible to find the file ${build_version_file_path}"
        return [Version]::new( 0, 0, 0 )
    }

    $ue_json = Get-Content -Raw -Path $build_version_file_path | ConvertFrom-Json
    return [Version]::new( $ue_json.MajorVersion, $ue_json.MinorVersion, $ue_json.PatchVersion, "0" )
}

function Get-EngineInfos( [String] $UProjectPath ) {
    $engine_infos = [EngineInfos]::new();

    $engine_infos.Association = Get-EngineAssociation( $UProjectPath )
    $engine_infos.Path = Get-EnginePath( $engine_infos.Association )
    $engine_infos.Version = Get-EngineVersion( $engine_infos.Path )

    return $engine_infos
}