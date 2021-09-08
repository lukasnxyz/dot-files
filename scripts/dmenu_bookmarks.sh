#!/bin/sh

declare -a options=(
"https://www.youtube.com/"
"https://color.adobe.com/create/color-wheel"
"https://www.w3schools.com/colors/colors_shades.asp"
"http://lukasn.xyz/"
"https://johncooper.myschoolapp.com/app/student#login"
"https://mail.yahoo.com/"
"https://outlook.office.com/mail/inbox"
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
