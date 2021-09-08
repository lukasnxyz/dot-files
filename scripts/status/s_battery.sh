#!/bin/sh

bat0=$(cat /sys/class/power_supply/BAT0/status)
bat1=$(cat /sys/class/power_supply/BAT1/status)

duo=$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/capacity)
total=$(bc <<< "scale=0; $duo/2")

#if [ "$bat0" == "Charging" ] || [ "$bat1" == "Charging" ]; then
    #icon="charging "
#fi

if [ "$bat0" == "Charging" ] || [ "$bat1" == "Charging" ]
then
    icon=" "
else
    if [ $total -ge 90 ]
    then
	icon=" "
    fi
    if [ $total -lt 90 ] && [ $total -ge 70 ]
    then
	icon=" "
    fi
    if [ $total -lt 70 ] && [ $total -ge 40 ]
    then
	icon=" "
    fi
    if [ $total -lt 40 ] && [ $total -ge 15 ]
    then
	icon=" "
    fi
    if [ $total -lt 15 ]
    then
	icon=" "
    fi
fi

echo "$icon$total%"
