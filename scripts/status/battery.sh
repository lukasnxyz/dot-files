#!/bin/sh

bat0=$(cat /sys/class/power_supply/BAT0/status)
batstat0=$(echo "(i)$(cat /sys/class/power_supply/BAT0/capacity | sed 's/$/%/')")

bat1=$(cat /sys/class/power_supply/BAT1/status)
batstat1=$(echo "$(cat /sys/class/power_supply/BAT1/capacity | sed 's/$/%/'| sed 's/^/(e)/')")

case $bat0 in
        Full)
            bat0=$(echo "T ")
        ;;
        Unknown)
            bat0=$(echo "T ")
        ;;
        Discharging)
            bat0=$(echo "D ")
        ;;
        Charging)
            bat0=$(echo "C ")
        ;;
esac

case $bat1 in 
        Full) 
            bat1=$()
        ;;
        Unknown)
            bat1=$(echo "T")
        ;;
        Discharging)
            bat1=$(echo "D")
        ;;
        Charging)
            bat1=$(echo "C")
        ;;
esac

echo "$batstat0$bat0$batstat1$bat1"
