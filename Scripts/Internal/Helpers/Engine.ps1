class EngineDefinition
{
    [String] $Path;
    [String] $EngineAssociation;
    [Version] $Version;

    [void] DumpToHost(){
        Write-Host "----- Engine infos -----"
        Write-Host " * Folder : $($this.Path)"
        Write-Host " * EngineAssociation : $($this.EngineAssociation)"
        Write-Host " * Version : $($this.Version)"
        Write-Host "----- Engine infos -----"
        Write-Host ""
    }
}
function Get-ProjectEngineAssociation( [String] $ProjectPath ) {
    $uproject_json = Get-Content -Raw -Path $ProjectPath | ConvertFrom-Json
    return $uproject_json.EngineAssociation
}

function Resolve-EnginePath( [String] $EngineAssociation ) {
    if (Test-Path "HKLM:\SOFTWARE\EpicGames\Unreal Engine\$EngineAssociation") {
        return (Get-ItemProperty -Path "HKLM:\SOFTWARE\EpicGames\Unreal Engine\$EngineAssociation" -Name "InstalledDirectory").InstalledDirectory;
    }

    Write-Error "Unable to locate engine description by `"$EngineAssociation`" (checked registry, Program Files and absolute path)."
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

function Get-EngineDefinition( [String] $UProjectPath ) {
    $engine_definition = [EngineDefinition]::new();

    $engine_definition.EngineAssociation = Get-ProjectEngineAssociation( $UProjectPath )
    $engine_definition.Path = Resolve-EnginePath( $engine_definition.EngineAssociation )
    $engine_definition.Version = Get-EngineVersion( $engine_definition.Path )

    return $engine_definition
}