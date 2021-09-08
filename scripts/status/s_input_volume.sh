#!/bin/sh

if [[ $(amixer sget Capture | grep 'Left:' | awk -F '[][]' '{ print $4 }') = "on" ]]; then
    echo " $(amixer sget Capture | grep 'Left:' | awk -F '[][]' '{ print $2 }')"
else
    echo ""
fi
