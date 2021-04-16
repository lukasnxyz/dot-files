#!/bin/sh

# dwm escape prompt
systemTools=$(echo -e "suspend\nbluetooth-on\nbluetooth-off\nshutdown\nreboot" | dmenu -i -p "system")
case $systemTools in 
        shutdown)
            exec poweroff
        ;;
        reboot)
            exec reboot
        ;;
        bluetooth-on)
            echo -e 'power on\nquit' | bluetoothctl
        ;;
        bluetooth-off)
            echo -e 'power off\nquit' | bluetoothctl
        ;;
        suspend)
            locker.sh
        ;;
esac
