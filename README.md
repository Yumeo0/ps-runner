# 🚀 Private Server Runner

This script automates the setup and management of private servers by downloading all necessary software (Rust, PostgreSQL, SurrealDB, etc.). It provides an easy selection menu for installing specific servers and ensures they stay updated to the latest version automatically. 🚀

## 📖 Table of Contents

- [📌 Getting Started](#-getting-started)
- [🌐 Currently Available Servers](#-currently-available-servers)
  - [Zenless Zone Zero](#zenless-zone-zero)
  - [Wuthering Waves](#wuthering-waves)
- [❓ FAQ](#-faq)
  - [📂 Where will the files be stored after running the script?](#-where-will-the-files-be-stored-after-running-the-script)
  - [🔄 Will the script redownload existing files?](#-will-the-script-redownload-existing-files)

## 📌 Getting Started

1. Open **PowerShell** in the directory where you want your private servers to be stored.
2. Run the following command:

   ```powershell
   iwr -useb "https://raw.githubusercontent.com/Yumeo0/ps-runner/refs/heads/main/ps.ps1" | iex
   ```

## 🌐 Currently available servers

### Status

🟢 — Working  
🟡 — Updating  
🔴 — Broken  
🔵 — Deprecated

### Zenless Zone Zero

- **🔗 [Trigger](https://git.xeondev.com/ObolSquad/trigger-rs)** — `1.6.0` 🟢
- **🔗 [Evelyn](https://git.xeondev.com/evelyn-rs/evelyn-rs)** — `1.5.0` 🔵
- **🔗 [Yanagi](https://git.xeondev.com/HollowSpecialOperationsS6/YanagiZS)** — `1.4.2` 🔵

### Wuthering Waves

- **🔗 [Wicked Waifus](https://git.xeondev.com/wickedwaifus/wicked-waifus-rs)** — `2.1.0` 🟡

## ❓ FAQ

### 📂 Where will the files be stored after running the script?

The servers are stored in subdirectories of the folder where you run the script.  
For example, if you run the script in: `C:\Games\PrivateServers`  
A **Zenless Zone Zero** server might be stored in: `C:\Games\PrivateServers\zzz\trigger-rs`  
Each server will have its own subdirectory within the main folder.

### 🔄 Will the script redownload existing files?

No. If you execute the script in the same directory again, it will detect existing files and update them if possible, rather than redownloading everything.
