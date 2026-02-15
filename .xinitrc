#
# ~/.xinitrc
#

systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS

# speed up movment and xrate
xset r rate 300 50 &

# set cursor on no window space
xsetroot -cursor_name left_ptr &

XCURSOR_SIZE=32
export XCURSOR_SIZE

# load window manager
dwm_status.sh &
nm-applet &
blueman-applet &
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh) &
redshift -l 48.21:16.37 &
fehbg.sh

exec dwm
