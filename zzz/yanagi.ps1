& iwr -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/git.ps1" | iex
& iwr -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/rust.ps1" | iex
& iwr -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/docker_desktop.ps1" | iex
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/surrealdb.ps1" -OutFile "surrealdb.ps1"
& .\surrealdb.ps1 -container_name "yanagi-zs-surrealdb" -user "root" -password "root" -db "yanagi"

$folderPath = "zzz\YanagiZS"

if (-Not (Test-Path $folderPath)) {
    Write-Host "YanagiZS not found. Cloning YanagiZS..."
    New-Item -ItemType Directory -Path $folderPath
    git clone "https://git.xeondev.com/HollowSpecialOperationsS6/YanagiZS.git" $folderPath
} else {
    Write-Host "YanagiZS found. Getting newest version..." -ForegroundColor Green
    & "git" -C $folderPath pull
}


Write-Host "Running YanagiZS..." -ForegroundColor Green

Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin yanagi-sdk-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin yanagi-autopatch-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin yanagi-dispatch-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin yanagi-gate-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin yanagi-game-server"

Write-Host "YanagiZS is starting in the background. Wait a few seconds for it to start up." -ForegroundColor Yellow
Write-Host ""
Write-Host "-------------"
Write-Host "You should be able to register an account here in a little bit:"
Write-Host "http://127.0.0.1:10001/account/register"
Write-Host "-------------"
Write-Host ""