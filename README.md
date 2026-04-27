# TrickyBox 📦📦

A simple Magisk / KernelSU / APatch module to easily install, restore, and update your `keybox.xml` for Tricky Store.

## ✨ Features

- **One-Click Update**: Update your keybox directly from the Magisk/KernelSU app using the Action button.
- **Smart Versioning**: The script checks the remote version before downloading. It will only download the keybox if there is a newer version available, saving data and time.
- **Auto Security Patch**: Automatically configures Tricky Store's `security_patch.txt` with your device's actual security patch date every time it runs.
- **Auto Target Apps**: Automatically selects and adds all your installed apps (including Google Play Services) to Tricky Store's `target.txt` so you don't have to set them up manually.
- **Play Integrity Fix**: Helps maintain your Tricky Store configuration to pass Play Integrity by ensuring your keybox is valid and up-to-date.

## ⚙️ Prerequisites

- A rooted Android device (Magisk, KernelSU, or APatch).
- **Tricky Store installed** (The installer will automatically check for this and abort if it is not found).
- Curl or Wget (Usually pre-installed on Android/Magisk environments).

## 🚀 Installation

1. Download the latest `TrickyBox.zip` from the Releases page.
2. Open the Magisk / KernelSU / APatch app.
3. Go to the **Modules** tab.
4. Select **Install from storage** and choose the downloaded zip file.
5. Reboot your device.

## 💡 How to Use

1. Open the Magisk / KernelSU app and go to the Modules section.
2. Find **TrickyBox** and tap the **Action** button (the terminal/play icon).
3. The script will automatically check for updates.
4. If a new version is found, it will automatically download and apply the new `keybox.xml` to `/data/adb/tricky_store/`.
5. If your current keybox is still valid and up-to-date, it will notify you without downloading anything.

##  Support & Community

Join our Telegram channel for updates or contact the developers directly:

[![Telegram Channel](https://img.shields.io/badge/Telegram-Channel-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/randommodules)
[![GueRapii](https://img.shields.io/badge/Chat-GueRapii-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/GueRapii)

## ⚠️ Disclaimer

This module is provided "as is" without warranty of any kind. Use at your own risk. The developer is not responsible for any bricked devices, data loss, or banned accounts.

## 📜 License

Copyright © 2026 GueRapii (@randommodules).
This module is free to use. However, **copying, redistributing, or using this code in other scripts requires explicit permission** from the developer and must include proper attribution.

---