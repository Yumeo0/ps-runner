& Invoke-WebRequest -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/common.ps1" | Invoke-Expression
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/surrealdb.ps1" -OutFile "surrealdb.ps1"
& .\surrealdb.ps1 -container_name "evelyn-rs-surrealdb" -user "root" -password "root" -db "evelyn"

$folderPath = "zzz\evelyn-rs"

if (-Not (Test-Path $folderPath)) {
    Write-Host "Evelyn-RS not found. Cloning Evelyn-RS..."
    New-Item -ItemType Directory -Path $folderPath
    git clone "https://git.xeondev.com/evelyn-rs/evelyn-rs.git" $folderPath
} else {
    Write-Host "Evelyn-RS found. Getting newest version..." -ForegroundColor Green
    & "git" -C $folderPath pull
}


Write-Host "Running Evelyn-RS..." -ForegroundColor Green

Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin evelyn-sdk-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin evelyn-autopatch-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin evelyn-dispatch-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin evelyn-gate-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin evelyn-game-server"

Write-Host "Evelyn-RS is starting in the background. Wait a few seconds for it to start up." -ForegroundColor Yellow
Write-Host ""
Write-Host "-------------"
Write-Host "You should be able to register an account here in a little bit:"
Write-Host "http://127.0.0.1:10001/account/register"
Write-Host "-------------"
Write-Host ""