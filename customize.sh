#!/system/bin/sh

if [ ! -d "/data/adb/modules/tricky_store" ]; then
    ui_print "==================================="
    ui_print "[-] ERROR: Tricky Store Not Found! "
    ui_print "==================================="
    abort "Please install Tricky Store before installing TrickyBox."
fi

ui_print "==================================="
ui_print "  TrickyBox 📦📦 Auto-Update   "
ui_print "==================================="
ui_print "Do you want to enable Auto-Update?"
ui_print "It will check for updates every 12 hours."
ui_print " "
ui_print "  [ VOLUME UP ]   = YES, Enable"
ui_print "  [ VOLUME DOWN ] = NO, Disable"
ui_print " "

while true; do
    key=$(getevent -qlc 1 2>/dev/null | awk '{ print $3 }')
    if [ "$key" = "KEY_VOLUMEUP" ]; then
        ui_print " -> You selected: YES (Auto-Update Enabled)"
        touch "$MODPATH/auto_update"
        break
    elif [ "$key" = "KEY_VOLUMEDOWN" ]; then
        ui_print " -> You selected: NO (Auto-Update Disabled)"
        break
    fi
done

ui_print "==================================="
ui_print "[!] NOTE:"
ui_print "You can ALWAYS update manually at any"
ui_print "time by pressing the 'Action' button"
ui_print "in the Magisk/KernelSU app."
ui_print " "
if [ -f "$MODPATH/auto_update" ]; then
    ui_print "Since Auto-Update is ON, the script"
    ui_print "will automatically run in the background"
    ui_print "every 12 hours."
    ui_print " "
fi
ui_print "-> After rebooting, you can just click"
ui_print "   the Action button right away to get"
ui_print "   the newest keybox 📦📦 immediately!"
ui_print "==================================="