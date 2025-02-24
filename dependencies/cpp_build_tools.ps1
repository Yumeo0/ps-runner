$buildToolsCheck = Get-Command link.exe -ErrorAction SilentlyContinue
if (-not $buildToolsCheck) {
    $installBuildTools = Read-Host "C++ Build Tools are not installed. Do you want to install them? (Y/N)"
    if ($installBuildTools -match "^[Yy]") {
        winget install --id Microsoft.VisualStudio.2022.BuildTools --override "--passive --wait --add Microsoft.VisualStudio.Component.VC.CoreBuildTools --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64"
    } else {
        Write-Host "C++ Build Tools installation skipped."
    }
} else {
    Write-Host "C++ Build Tools are already installed." -ForegroundColor Green
}
