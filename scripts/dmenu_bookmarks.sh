#!/bin/sh

declare -a options=(
"https://google.com"
"https://youtube.com"
"https://monkeytype.com"
"https://github.com"
"https://www.amazon.com/"
"https://open.spotify.com/"
"https://color.adobe.com/create/color-wheel"
"https://duckduckgo.com/?t=ffab&q=calculator&ia=calculator"
"https://mail.yahoo.com/d/folders/1"
"https://www.w3schools.com/colors/colors_shades.asp"
# school
"https://translate.google.com/"
"https://livejohncooper-my.sharepoint.com/personal/23lnitzsche_johncooper_org/_layouts/15/onedrive.aspx"
"https://outlook.office.com/mail/inbox"
"https://johncooper.myschoolapp.com/app#login"
"https://www.office.com/?auth=2"
"https://docs.google.com/document/d/1iXxtdiiG1Xj34TLdJfb0n0cIC-yNxRGD4EFFoZT5NRY/edit"
"https://driving.aceable.com/user/signin"
"https://login.cengagebrain.com/cb/login.htm"
"https://www.vhlcentral.com/"
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
