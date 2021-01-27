#!/bin/sh

mem_og=$(cat /proc/meminfo | awk '/^Active:/ { print $2 }')
final=$(echo "scale=3; $mem_og / 1024 / 1024" | bc)
echo "(mem)$final"
