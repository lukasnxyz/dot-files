#!/bin/sh

# display prompt
prompt=$(ls ~/.config/screenlayout | dmenu -i -p "choose a display layout:")
sh ~/.config/screenlayout/$prompt
