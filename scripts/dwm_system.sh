#!/bin/sh

# dwm escape prompt
systemTools=$(echo -e "suspend\nbluetooth\nreboot\nshutdown" | dmenu -i -p "system:")
case $systemTools in 
        shutdown)
            exec poweroff
        ;;
        reboot)
            exec reboot
        ;;
        bluetooth)
            bluetoothMenu=$(echo -e "bluetooth-on\nbluetooth-off\nedit" | dmenu -i -p "bluetooth:")

            case $bluetoothMenu in
                bluetooth-on)
                    echo -e 'power on\nquit' | bluetoothctl
                ;;
                bluetooth-off)
                    echo -e 'power off\nquit' | bluetoothctl
                ;;
                edit)
                    $TERMINAL -e bluetoothctl
                ;;
            esac
        ;;
        suspend)
                systemctl suspend
        ;;
esac
