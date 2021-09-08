#!/bin/sh

#         

# Full, Unknown, Discharging, Charging

bat0=$(cat /sys/class/power_supply/BAT0/status)
bat1=$(cat /sys/class/power_supply/BAT1/status)
icon="foo"

batstat0=$(echo "$(cat /sys/class/power_supply/BAT0/capacity)")
batstat1=$(echo "$(cat /sys/class/power_supply/BAT1/capacity)")

addition=$(( $batstat0 + $batstat1 ))
total=$(bc <<< "scale=0; $addition/2")

if [ "$bat0" == "Charging" ] || [ "$bat1" == "Charging" ]
then
        icon=""
        sleep 1
        icon=""
        sleep 1
        icon=""
        sleep 1
        icon=""
        sleep 1
        icon=""
else
    if [ $total > 90 ]
    then
        icon=""
    fi
    if [ $total -lt 90 ] && [ $total -ge 60 ]
    then
        icon=""
    fi
    if [ $total -lt 60 ] && [ $total -ge 30 ]
    then
        icon="  "
    fi
    if [ $total -lt 30 ] && [ $total -ge 15 ]
    then
        icon="  "
    fi
    if [ $total -lt 15 ]
    then
        icon="  "
    fi

fi

echo "$icon  $total"

#case $bat0 in
    #Full)
        #bat0=$()
        #;;
    #Unknown)
        #bat0=$()
        #;;
    #Discharging)
        #bat0=$()
        #;;
    #Charging)
        #bat0=$(echo "C")
        #;;
#esac

#case $bat1 in
    #Full)
        #bat1=$()
        #;;
    #Unknown)
        #bat1=$()
        #;;
    #Discharging)
        #bat1=$()
        #;;
    #Charging)
        #bat1=$(echo "C")
        #;;
#esac

#echo "$batstat0$bat0$batstat1$bat1"
