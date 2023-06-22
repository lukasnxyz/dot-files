#!/bin/sh

declare -a options=(
"https://mail.yahoo.com"
"quit"
)

choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 20 -p 'bookmarks')

if [[ "$choice" == quit ]]; then
    echo "program terminated" && exit 1
elif [ "$choice" ]; then
    cfg=$(printf '%s\n' "${choice}" | awk '{printf $NF}')
    $BROWSER "$cfg"
else
    echo "program terminated" && exit 1
fi
