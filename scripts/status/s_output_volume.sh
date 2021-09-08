#!/bin/sh

output=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }')
if [[ $output = "on" ]]; then
    output=$(echo " $(amixer sget Master | grep 'Right:' | awk -F '[][]' '{ print $2 }' | tr -d ' ')")
else
    output=$(echo "")
fi
echo "$output"
