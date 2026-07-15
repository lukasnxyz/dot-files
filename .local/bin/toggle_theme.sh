#!/bin/bash

if [ -f ~/.lightmode ]; then
    rm ~/.lightmode
    # Dark settings
    #xrdb -merge ~/.Xresources.dark  # Or load dark colors
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
else
    touch ~/.lightmode
    # Light settings
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
fi
