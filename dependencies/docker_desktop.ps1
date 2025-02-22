# Check if Docker Desktop is installed
$dockerCheck = Get-Command docker -ErrorAction SilentlyContinue
if (-not $dockerCheck) {
    $installDocker = Read-Host "Docker Desktop is not installed. Do you want to install it? (Y/N)"
    if ($installDocker -match "^[Yy]") {
        winget install Docker.DockerDesktop
    } else {
        Write-Host "Docker installation skipped."
    }
} else {
    Write-Host "Docker Desktop is already installed." -ForegroundColor Green
}
