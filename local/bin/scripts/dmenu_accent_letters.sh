#!/bin/sh

declare -a options=(
"€"
"ä"
"Ä"
"ö"
"Ö"
"ü"
"Ü"
"ß"
"ẞ"
)

choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 9 -p 'accent marks')

if [ "$choice" ]; then
    cfg=$(printf '%s\n' "${choice}" | awk '{printf $NF}')
    echo -n "$cfg" | xclip -selection c
else
    echo "program terminated" && exit 1
fi
