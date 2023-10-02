class ProjectInfos
{
    [String] $Folder;
    [String] $Name;
    [String] $UProjectPath;

    [void] DumpToHost(){
        Write-Host ""
        Write-Host "----- Project Infos -----"
        Write-Host " * Folder : $($this.Folder)"
        Write-Host " * Name : $($this.Name)"
        Write-Host " * UProjectPath : $($this.UProjectPath)"
        Write-Host "----- Project Infos -----"
        Write-Host ""
    }

    [bool] IsValid(){

        return ($null -ne $this.Folder) && ($null -ne $this.Name) && ($null -ne  $this.UProjectPath)
    }
}

function Get-ProjectFolder() {
    return Resolve-Path ( Join-Path -Path $PSScriptRoot -ChildPath "..\.." )
}

function Get-UProject([String] $ProjectFolder){
    return Get-ChildItem $ProjectFolder -File '*.uproject'
}

function Get-ProjectInfos() {
    $project_infos = [ProjectInfos]::new()

    $project_infos.Folder = Get-ProjectFolder
    $u_project = Get-UProject($project_infos.Folder)

    if ( $null -eq $u_project ) {

        throw "Impossible to find a uproject file"
    }

    $project_infos.Name = $u_project.BaseName
    $project_infos.UProjectPath = Resolve-Path ( Join-Path -Path $project_infos.Folder -ChildPath $u_project.Name )

    return $project_infos
}