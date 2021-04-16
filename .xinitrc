#!/bin/sh

#
# ~/.xinitrc
#

# speed up movment and xrate
xset r rate 300 50 &

# set cursor on no window space
xsetroot -cursor_name left_ptr &

# trackpad settings
xinput set-prop "Synaptics TM3053-004" "libinput Disable While Typing Enabled" 0
xinput set-prop "Synaptics TM3053-004" "libinput Tapping Enabled" 1

# load window manager
wautostart.sh
exec dwm
