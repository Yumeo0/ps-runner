& iwr -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/git.ps1" | iex
& iwr -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/rust.ps1" | iex
& iwr -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/docker_desktop.ps1" | iex
& iwr -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/hoyo_sdk.ps1" | iex
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/postgresql.ps1" -OutFile "postgresql.ps1"
& .\postgresql.ps1 -container_name "trigger-rs-postgres" -user "root" -password "root" -db "trigger-rs"

$folderPath = "zzz\trigger-rs"

if (-Not (Test-Path $folderPath)) {
    Write-Host "Trigger-RS not found. Cloning Trigger-RS..."
    New-Item -ItemType Directory -Path $folderPath
    git clone "https://git.xeondev.com/ObolSquad/trigger-rs.git" $folderPath
} else {
    Write-Host "Trigger-RS found. Getting newest version..." -ForegroundColor Green
    & "git" -C $folderPath pull
}


Write-Host "Running Trigger-RS..." -ForegroundColor Green

Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin trigger-dispatch-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin trigger-gate-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin trigger-game-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin trigger-hall-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin trigger-battle-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin trigger-muip-server"

Write-Host "Trigger-RS is starting in the background. Wait a few seconds for it to start up." -ForegroundColor Yellow
Write-Host ""
Write-Host "-------------"
Write-Host "While you wait, you can register an account at:"
Write-Host "http://127.0.0.1:20100/account/register"
Write-Host "-------------"
Write-Host ""