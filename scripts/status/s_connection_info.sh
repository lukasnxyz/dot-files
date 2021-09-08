#!/bin/sh

# 
val=$(iwconfig wlp3s0 | grep -i link | awk -F"/" '{print $1}' | sed 's/Link Quality=//g' | sed 's/ //g')
connectionName=$(iwconfig wlp3s0 | grep ESSID | awk -F: '{print $2}' | awk '{$1=$1};1' | awk '{print substr($0, 2, length($0) - 2)}')
valFinal=$(bc <<< "scale=2; ($val/70) * 100" | awk -F. '{print $1}' | sed 's/$/%/')

echo "$valFinal"
