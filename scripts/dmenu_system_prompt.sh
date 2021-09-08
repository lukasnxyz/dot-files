#!/bin/sh

systemTools=$(echo -e "\nshutdown\nreboot\nbluetooth-on\nbluetooth-off" | dmenu -i -p "system")
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
esac
