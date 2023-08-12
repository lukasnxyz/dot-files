#
# ~/.xinitrc
#

# set cursor on no window space
xsetroot -cursor_name left_ptr &

# trackpad settings
xinput set-prop "SYNA8018:00 06CB:CE67 Touchpad" "libinput Disable While Typing Enabled" 0
#xinput set-prop "SYNA8018:00 06CB:CE67 Touchpad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "SYNA8018:00 06CB:CE67 Touchpad" "libinput Tapping Enabled" 1

# autostart
dwm_status.sh &
clipmenud &
nm-applet &

# launch window manager
exec /usr/local/bin/dwm 2> /tmp/dwm.log
