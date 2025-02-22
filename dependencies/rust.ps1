$rustCheck = Get-Command rustc -ErrorAction SilentlyContinue
if (-not $rustCheck) {
    $installRust = Read-Host "Rust is not installed. Do you want to install it? (Y/N)"
    if ($installRust -match "^[Yy]") {
        winget install -e --id Rustlang.Rustup
        winget install Rustlang.Rust
        rustup update
    } else {
        Write-Host "Rust installation skipped."
    }
} else {
    Write-Host "Rust is already installed." -ForegroundColor Green
}
