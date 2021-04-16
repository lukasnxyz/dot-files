#!/bin/sh

# display prompt
prompt=$(ls ~/.local/share/screenlayout | dmenu -i -p "display layout")
sh ~/.local/share/screenlayout/$prompt
