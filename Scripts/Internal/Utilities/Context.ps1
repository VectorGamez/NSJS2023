class Context
{
    [String] $UATPath;
    [String] $UBTPath;
    [String] $BuildPath;
    [String] $EditorPath;
    $EngineDefinition;
    $ProjectInfos;
    [String] $BuildGraphPath;
    [String] $Environment;

    Context() 
    {
        $this.ProjectInfos = Get-ProjectInfos
        $this.ProjectInfos.DumpToHost()
        
        $this.EngineDefinition = Get-EngineDefinition( $this.ProjectInfos.UProjectPath )

        if ( ( Test-Path $this.EngineDefinition.Path ) -eq $False ) {
            throw "Impossible to get a correct path to a UE installation"
        }

        $this.EngineDefinition.DumpToHost()

        $this.UATPath = Join-Path -Path $this.EngineDefinition.Path -ChildPath "Engine\Build\BatchFiles\RunUAT.bat"
        $this.UBTPath = Join-Path -Path $this.EngineDefinition.Path -ChildPath "Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe"
        $this.BuildPath = Join-Path -Path $this.EngineDefinition.Path -ChildPath "Engine\Build\BatchFiles\Build.bat"

        if ( ( Test-Path $this.UATPath ) -eq $False ) {
            throw "Impossible to get a correct path to RunUAT.bat"
        }

        if ( ( Test-Path $this.UBTPath ) -eq $False ) {
            throw "Impossible to get a correct path to UnrealBuildTool.exe"
        }

        $EditorFileName = "UnrealEditor"

        $EditorFileName = "$($EditorFileName).exe"

        $this.EditorPath = Join-Path -Path $this.EngineDefinition.Path -ChildPath "Engine\Binaries\Win64\$($EditorFileName)"
    }
}