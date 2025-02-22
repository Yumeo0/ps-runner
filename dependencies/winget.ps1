$wingetCheck = Get-Command winget -ErrorAction SilentlyContinue
if (-not $wingetCheck) {
    $installWinget = Read-Host "Winget is not installed. Do you want to install it? (Y/N)"
    if ($wingetCheck -match "^[Yy]") {
        $process = Start-Process powershell.exe -ArgumentList "Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe" -PassThru
        $process.WaitForExit()
    } else {
        Write-Host "Winget installation skipped."
    }
} else {
    Write-Host "Winget is already installed." -ForegroundColor Green
}
