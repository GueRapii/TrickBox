#!/system/bin/sh

MODDIR=${0%/*}

while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 10
done

if [ ! -f "$MODDIR/auto_update" ]; then
    exit 0
fi

while true; do
    sh "$MODDIR/action.sh" > /dev/null 2>&1
    
    sleep 43200
done