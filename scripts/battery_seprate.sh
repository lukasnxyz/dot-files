#!/bin/sh

bat0=$(cat /sys/class/power_supply/BAT0/status)
case $bat0 in
	Full)
		echo "0: $(cat /sys/class/power_supply/BAT0/capacity | sed 's/$/%/')"
	;;
	Unknown)
		echo "0: $(cat /sys/class/power_supply/BAT0/capacity | sed 's/$/%/')"
	;;
	Discharging)
		echo "0: $(cat /sys/class/power_supply/BAT0/capacity | sed 's/$/%/') Dis"
	;;
	Charging)
		echo "0: $(cat /sys/class/power_supply/BAT0/capacity | sed 's/$/%/') Char"
	;;
esac

bat1=$(cat /sys/class/power_supply/BAT1/status)
case $bat1 in
	Full)
		echo "1: $(cat /sys/class/power_supply/BAT1/capacity | sed 's/$/%/')"
	;;
	Unknown)
                echo "1: $(cat /sys/class/power_supply/BAT1/capacity | sed 's/$/%/')"
	;;
	Discharging)
		echo "1: $(cat /sys/class/power_supply/BAT1/capacity | sed 's/$/%/') Dis"
	;;
	Charging)
		echo "1: $(cat /sys/class/power_supply/BAT1/capacity | sed 's/$/%/') Char"
	;;
esac
