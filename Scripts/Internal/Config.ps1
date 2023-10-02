class ServerInfos
{
    [String] $MapName

    [void] DumpToHost(){
        Write-Host "    - MapName : $($this.MapName)"
    }

    [bool] IsValid(){

        return $null -ne $this.MapName
    }
}

class ClientInfos
{
    [String] $IPAddress
    [int] $Width
    [int] $Height

    [void] DumpToHost(){
        Write-Host "    - IPAddress : $($this.IPAddress)"
        Write-Host "    - Width : $($this.Width)"
        Write-Host "    - Height : $($this.Height)"
    }

    [bool] IsValid(){

        return ($null -ne $this.IPAddress) && (0 -ne $this.Width) && (0 -ne  $this.Height)
    }
}


class ConfigInfos
{
    [bool] $Debug
    [ServerInfos] $ServerOptions
    [ClientInfos] $ClientOptions

    [void] DumpToHost(){
        Write-Host ""
        Write-Host "----- Config Infos -----"
        Write-Host " * Debug : $($this.Debug)"
        Write-Host " * ServerOptions : "
        $this.ServerOptions.DumpToHost()
        Write-Host " * ClientOptions : "
        $this.ClientOptions.DumpToHost()
        Write-Host "----- Config Infos -----"
        Write-Host ""
    }

    [bool] IsValid(){

        return ($false -ne $this.Debug) && $this.ServerOptions.IsValid() && $this.ClientOptions.IsValid()
    }
}

function Get-ConfigPath()
{
    return Resolve-Path( Join-Path -Path $PSScriptRoot -ChildPath "..")
}

function Get-ConfigInfos(){
    $infos = [ConfigInfos]::new();

    $config_path = Get-ConfigPath
    $config = Get-ChildItem $config_path -File "Config.json"

    if ( [System.IO.File]::Exists( $config ) -eq $False ) {
        Write-Warning "Impossible to find Config.json at ${config_path}"
        return $infos
    }

    $config_json = Get-Content -Raw -Path $config | ConvertFrom-Json

    $infos.Debug = $config_json.Debug
    $infos.ServerOptions = $config_json.ServerOptions
    $infos.ClientOptions = $config_json.ClientOptions

    return $infos
}