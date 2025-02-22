# Check if Git is installed
$gitCheck = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitCheck) {
    $installGit = Read-Host "Git is not installed. Do you want to install it? (Y/N)"
    if ($installGit -match "^[Yy]") {
        winget install --id Git.Git -e --source winget
    } else {
        Write-Host "Git installation skipped."
    }
} else {
    Write-Host "Git is already installed." -ForegroundColor Green
}
