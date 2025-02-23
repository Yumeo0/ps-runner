$protobufCheck = Get-Command protoc -ErrorAction SilentlyContinue
if (-not $protobufCheck) {
    $installProtobuf = Read-Host "Protobuf is not installed. Do you want to install it? (Y/N)"
    if ($installProtobuf -match "^[Yy]") {
        winget install --id=Google.Protobuf  -e
    } else {
        Write-Host "Protobuf installation skipped."
    }
} else {
    Write-Host "Protobuf is already installed." -ForegroundColor Green
}
