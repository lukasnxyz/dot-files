#!/bin/sh
cmus_options=$(echo -e "$(ls ~/media/music/Felix\ Laband/Dark\ Days\ Exit)" | dmenu -l 20 -i -p "cmus:")
cmus-remote -f $cmus_options
