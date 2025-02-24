& Invoke-WebRequest -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/common.ps1" | Invoke-Expression
& Invoke-WebRequest -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/protobuf.ps1" | Invoke-Expression
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/dependencies/postgresql.ps1" -OutFile "postgresql.ps1"
& .\postgresql.ps1 -container_name "wicked-waifus-postgres" -user "postgres" -password "" -db "shorekeeper"

$folderPath = "wuwa\wicked_waifus"

if (-Not (Test-Path $folderPath)) {
    Write-Host "Wicked Waifus not found. Cloning Wicked Waifus..."
    New-Item -ItemType Directory -Path $folderPath
    git clone "https://git.xeondev.com/wickedwaifus/wicked-waifus-rs.git" $folderPath
    
    Write-Host "Downloading config server files..."
    $zipUrl = "https://git.xeondev.com/wickedwaifus/wicked-waifus-config-server-files/archive/main.zip"
    $zipPath = ".\main.zip"
    $extractPath = ".\wuwa\wicked_waifus\data\assets\config-server"
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
    Expand-Archive -Path $zipPath
    Remove-Item -Path $zipPath
    Move-Item -Path ".\main\wicked-waifus-config-server-files\*" -Destination $extractPath -Force -ErrorAction SilentlyContinue
    Remove-Item -Path ".\main" -Recurse

    Write-Host "Downloading game data..."
    $zipUrl = "https://git.xeondev.com/wickedwaifus/wicked-waifus-data/archive/master.zip"
    $zipPath = ".\master.zip"
    $extractPath = ".\wuwa\wicked_waifus\data\assets\game-data"
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
    Expand-Archive -Path $zipPath
    Remove-Item -Path $zipPath
    Move-Item -Path ".\master\wicked-waifus-data\*" -Destination $extractPath -Force -ErrorAction SilentlyContinue
    Remove-Item -Path ".\master" -Recurse
} else {
    Write-Host "Wicked Waifus found. Getting newest version..." -ForegroundColor Green
    & "git" -C $folderPath pull
}


Write-Host "Running Wicked Waifus..." -ForegroundColor Green

Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin wicked-waifus-config-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin wicked-waifus-hotpatch-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin wicked-waifus-login-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin wicked-waifus-gateway-server"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit", "-Command", "cd '$folderPath'; cargo run --bin wicked-waifus-game-server"

Write-Host "Wicked Waifus is starting in the background. Wait a bit for it to start up." -ForegroundColor Yellow
