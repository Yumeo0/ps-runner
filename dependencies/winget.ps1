$rustCheck = Get-Command winget -ErrorAction SilentlyContinue
if (-not $rustCheck) {
    $installRust = Read-Host "Winget is not installed. Do you want to install it? (Y/N)"
    if ($installRust -match "^[Yy]") {
        Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
    } else {
        Write-Host "Winget installation skipped."
    }
} else {
    Write-Host "Winget is already installed." -ForegroundColor Green
}


