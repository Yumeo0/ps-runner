# Check if the page is reachable
try {
    $response = Invoke-WebRequest -Uri "http://127.0.0.1:20100/account/register" -Method Head
    $isPageReachable = $true
} catch {
    $isPageReachable = $false
}

# Check if the folder exists
$folderPath = ".\hoyo-sdk"
$isFolderExist = Test-Path $folderPath

# Clone the repo if neither is true
if (-Not $isPageReachable -and -Not $isFolderExist) {
    $installGit = Read-Host "Hoyo-SDK not found. Do you want to download it? (Y/N)"
    if ($installGit -match "^[Yy]") {
        git clone "https://git.xeondev.com/reversedrooms/hoyo-sdk"
    } else {
        Write-Host "Hoyo-SDK download skipped."
    }
} elseif (-Not $isPageReachable -and $isFolderExist) {
    Write-Host "Hoyo-SDK found. Getting newest version..." -ForegroundColor Green
    & "git" -C "hoyo-sdk" pull
    Write-Host "Running Hoyo-SDK..."
    Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd 'hoyo-sdk'; cargo run"
} else {
    Write-Host "Hoyo-SDK is already running." -ForegroundColor Green
}