$choices = @(
    "Trigger [1.6]"
)

$index = 0

function Show-Menu {
    Clear-Host
    Write-Host "Server version:"
    for ($i = 0; $i -lt $choices.Length; $i++) {
        if ($i -eq $index) {
            Write-Host "> $($choices[$i])" -ForegroundColor Cyan
        } else {
            Write-Host "  $($choices[$i])"
        }
    }
}

Show-Menu

while ($true) {
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode
    
    switch ($key) {
        38 { if ($index -gt 0) { $index-- }; Show-Menu }
        40 { if ($index -lt $choices.Length - 1) { $index++ }; Show-Menu }
    }
    if ($key -eq 13) { break }  # Ensures loop exits on Enter key
}

switch ($index) {
    0 { iwr -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/zzz/trigger.ps1" | iex }
}