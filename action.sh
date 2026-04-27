#!/system/bin/sh

MODDIR=${0%/*}

GITHUB_URL="https://raw.githubusercontent.com/GueRapii/randommodulesfiles/refs/heads/main/file.enc"
VERSION_URL="https://raw.githubusercontent.com/GueRapii/randommodulesfiles/refs/heads/main/keyversion.txt"

TARGET_DIR="/data/adb/tricky_store"
TARGET_FILE="$TARGET_DIR/keybox.xml"
TMP_ENC_FILE="$TARGET_DIR/file.enc"
LOCAL_VERSION_FILE="$MODDIR/keyversion.txt"
SECURITY_PATCH_FILE="$TARGET_DIR/security_patch.txt"
TARGET_TXT_FILE="$TARGET_DIR/target.txt"

echo "==================================="
echo "     TrickyBox Action 📦📦    "
echo "==================================="

LOCAL_VERSION=0
if [ -f "$LOCAL_VERSION_FILE" ]; then
    LOCAL_VERSION=$(cat "$LOCAL_VERSION_FILE" | tr -d '\r\n')
fi

TIMESTAMP=$(date +%s)

echo "[*] Checking for updates..."
REMOTE_VERSION=$(curl -s "${VERSION_URL}?t=$TIMESTAMP" | tr -d '\r\n')
if [ -z "$REMOTE_VERSION" ]; then
    REMOTE_VERSION=$(wget -qO- "${VERSION_URL}?t=$TIMESTAMP" | tr -d '\r\n')
fi

if [ -z "$REMOTE_VERSION" ]; then
    echo "[-] Failed to check version! Ensure your internet is active and the URL is valid."
    exit 1
fi

echo "[*] Local version: $LOCAL_VERSION | Remote version: $REMOTE_VERSION"

if [ "$REMOTE_VERSION" -gt "$LOCAL_VERSION" ] 2>/dev/null; then
    echo "[*] New version found! Preparing to update..."
    echo "[*] Checking tricky_store folder..."
    mkdir -p "$TARGET_DIR"

    echo "[*] Downloading encrypted keybox from GitHub..."
    if curl -s -L -o "$TMP_ENC_FILE" "${GITHUB_URL}?t=$TIMESTAMP"; then
        echo "[+] Successfully downloaded using curl!"
    elif wget -q -O "$TMP_ENC_FILE" "${GITHUB_URL}?t=$TIMESTAMP"; then
        echo "[+] Successfully downloaded using wget!"
    else
        echo "[-] Download failed! Ensure your internet is active and the URL is valid."
        exit 1
    fi

    echo "[*] Decrypting keybox..."
    base64 -d "$TMP_ENC_FILE" > "$TARGET_FILE"
    
    if grep -q "<Keybox" "$TARGET_FILE"; then
        echo "[+] Decryption successful!"
        rm -f "$TMP_ENC_FILE"
    else
        echo "[-] Decryption failed! The file is not a valid Keybox."
        rm -f "$TMP_ENC_FILE"
        exit 1
    fi

    chmod 644 "$TARGET_FILE"
    echo "$REMOTE_VERSION" > "$LOCAL_VERSION_FILE"
    echo "[+] Done! Tricky Store Keybox has been successfully updated to version $REMOTE_VERSION."
else
    echo "[+] Keybox is already up to date."
    echo "[!] (If the keybox is invalid, please report to the Telegram channel to be updated)"
fi

echo "-----------------------------------"
echo "[*] Configuring Security Patch Date..."
PATCH_DATE=$(getprop ro.build.version.security_patch)

if [ -n "$PATCH_DATE" ]; then
    mkdir -p "$TARGET_DIR"
    echo "system=prop" > "$SECURITY_PATCH_FILE"
    echo "boot=$PATCH_DATE" >> "$SECURITY_PATCH_FILE"
    echo "vendor=$PATCH_DATE" >> "$SECURITY_PATCH_FILE"
    chmod 644 "$SECURITY_PATCH_FILE"
    echo "[+] Security Patch successfully set to: $PATCH_DATE"
else
    echo "[-] Failed to get Security Patch Date from device."
fi

echo "-----------------------------------"
echo "[*] Configuring Target Apps..."
mkdir -p "$TARGET_DIR"

echo "com.google.android.gms" > "$TARGET_TXT_FILE"
echo "com.google.android.gms.unstable" >> "$TARGET_TXT_FILE"
echo "com.android.vending" >> "$TARGET_TXT_FILE"

pm list packages -3 | cut -d':' -f2 >> "$TARGET_TXT_FILE"

# Hapus duplikasi nama paket agar rapi
sort -u "$TARGET_TXT_FILE" > "${TARGET_TXT_FILE}.tmp"
mv "${TARGET_TXT_FILE}.tmp" "$TARGET_TXT_FILE"
chmod 644 "$TARGET_TXT_FILE"

echo "[+] All installed apps successfully added to target.txt!"