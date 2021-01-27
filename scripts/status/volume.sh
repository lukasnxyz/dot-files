#!/bin/sh

# output script
output=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }')

if [[ $output = "on" ]]; then
    output=$(echo "(out)$(amixer sget Master | grep 'Right:' | awk -F '[][]' '{ print $2, $4 }')")
else
    output=$(echo "(out)$(amixer sget Master | grep 'Right:' | awk -F '[][]' '{ print $4 }')")
fi

# input script
input=$(amixer sget Capture | grep 'Left:' | awk -F '[][]' '{ print $4 }')

if [[ $input = "on" ]]; then
    input=$(echo "(in)$(amixer sget Capture | grep 'Left:' | awk -F '[][]' '{ print $4 }')")
else
    input=$(echo "(in)$(amixer sget Capture | grep 'Left:' | awk -F '[][]' '{ print $4 }')")
fi

echo "$output $input"
