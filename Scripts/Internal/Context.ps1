class Context
{
    $ProjectInfos
    $EngineInfos
    $ConfigInfos

    [String] $UATPath
    [String] $UBTPath
    [String] $BuildPath
    [String] $EditorPath

    Context() 
    {
        $this.InitializeProjectInfos()
        $this.InitializeEngineInfos()
        $this.InitializeConfigInfos()
        $this.InitializeEngineTools()

        $EditorFileName = "UnrealEditor"

        if($this.ConfigInfos.Debug -eq $true)
        {
            $EditorFileName = "$($EditorFileName)-Win64-DebugGame"
        }

        $EditorFileName = "$($EditorFileName).exe"

        $this.EditorPath = Join-Path -Path $this.EngineInfos.Path -ChildPath "Engine\Binaries\Win64\$($EditorFileName)"
    }

    [void] InitializeProjectInfos(){
        $this.ProjectInfos = Get-ProjectInfos

        if($false -eq $this.ProjectInfos.IsValid){
            throw "Project Infos are not valid."
        }

        $this.ProjectInfos.DumpToHost()
    }

    [void] InitializeEngineInfos()
    {
        $this.EngineInfos = Get-EngineInfos( $this.ProjectInfos.UProjectPath )

        if($false -eq $this.EngineInfos){
            throw "Engine Infos are not valid."
        }

        $this.EngineInfos.DumpToHost()
    }

    [void] InitializeConfigInfos()
    {
        $this.ConfigInfos = Get-ConfigInfos

        if($false -eq $this.ConfigInfos){
            throw "Engine Infos are not valid."
        }

        $this.ConfigInfos.DumpToHost()
    }

    [void] InitializeEngineTools()
    {
        $this.UATPath = Join-Path -Path $this.EngineInfos.Path -ChildPath "Engine\Build\BatchFiles\RunUAT.bat"
        $this.UBTPath = Join-Path -Path $this.EngineInfos.Path -ChildPath "Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe"
        $this.BuildPath = Join-Path -Path $this.EngineInfos.Path -ChildPath "Engine\Build\BatchFiles\Build.bat"

        if ( ( Test-Path $this.UATPath ) -eq $False ) {
            throw "Impossible to get a correct path to RunUAT.bat"
        }

        if ( ( Test-Path $this.UBTPath ) -eq $False ) {
            throw "Impossible to get a correct path to UnrealBuildTool.exe"
        }

        if ( ( Test-Path $this.BuildPath ) -eq $False ) {
            throw "Impossible to get a correct path to Build.bat"
        }
    }
}