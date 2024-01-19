#!/bin/sh

# deploy.sh install
# deploy.sh update
# deploy.sh help
#
# Things to deploy and install on system
#   For all distros (maybe seperate for xorg and wayland)?
#   - X11 things
#       - xorg-server, xinput, xorg-init, .xinitrc,
#       - xcpip, xev, xbacklight (add user to group video)
#       - xrandr/autorandr/arandr and setup
#       - /etc/X11/xorg.conf.d/00-keyboard.conf
#       - /usr/share/X11/xkb/symbols/pc
#       - /etc/systemd/system/slock@.service
#       - dwm, dmenu, slock, clipmenu,
#   - iosevka font
#   - tlp and setup
#   - starship prompt
#   - network manager, nm-applet
#   - alacritty, sxiv, vifm, zathura,
#   - playerctl
#   - scrot
#
#   For personal Arch system
#   - paru
#   - Packages to install
#
#   - scripts, zsh, chsh
#   - alacrity, vifm, vifmrun, nvim, tmux, zathura, cmus
#
# fix suckles config.def.h and make file not delete config.h
# Add some patches to dwm (layouts, etc.)
