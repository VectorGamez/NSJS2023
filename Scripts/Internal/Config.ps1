class ConfigInfos
{
    [bool] $Debug
    [String] $ServerOptions
    [String] $ClientOptions

    [void] DumpToHost(){
        Write-Host ""
        Write-Host "----- Config Infos -----"
        Write-Host " * Debug : $($this.Debug)"
        Write-Host " * ServerOptions : $($this.ServerOptions)"
        Write-Host " * ClientOptions : $($this.ClientOptions)"
        Write-Host "----- Config Infos -----"
        Write-Host ""
    }

    [bool] IsValid(){

        return ($false -ne $this.Debug) && ($null -ne $this.ServerOptions) && ($null -ne  $this.ClientOptions)
    }
}

function Get-ConfigPath()
{
    return Resolve-Path( Join-Path -Path $PSScriptRoot -ChildPath "..")
}

function Get-ConfigInfos(){
    $infos = [ConfigInfos]::new();

    $config_path = Get-ConfigPath

    if ( [System.IO.File]::Exists( $(Get-ChildItem $config_path -File "Config.json") ) -eq $False ) {
        Write-Warning "Impossible to find Config.json at ${config_path}"
        return $infos
    }

    $config_json = Get-Content -Raw -Path $config_path | ConvertFrom-Json

    $infos.Debug = $config_json.Debug
    $infos.ServerOptions = $config_json.ServerOptions
    $infos.ClientOptions = $config_json.ClientOptions

    return $infos
}