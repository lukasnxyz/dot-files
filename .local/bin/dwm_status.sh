#!/bin/sh
# dwm status using xset root

printDate(){
    echo "$(date +"%a, %d/%m/%y %H:%M")"
}

printBacklight() {
    max=$(brightnessctl max)
    curr=$(brightnessctl get)
    echo "bl $(echo "scale=0; ($curr * 100) / $max" | bc)%"
}

printBattery() {
    bat0=$(cat /sys/class/power_supply/BAT0/status)
    total=$(cat /sys/class/power_supply/BAT0/capacity)

    if [ "$bat0" == "Charging" ]; then
        icon=" "
    else
        if [ $total -ge 90 ]; then
            icon=" "
        elif [ $total -ge 70 ]; then
            icon=" "
        elif [ $total -ge 40 ]; then
            icon=" "
        elif [ $total -ge 15 ]; then
            icon=" "
        else
            icon=" "
        fi
    fi

    echo "$icon$total%"
}

printInputVolume() {
    if [[ $(amixer sget Capture | grep 'Left:' | awk -F '[][]' '{ print $4 }') = "on" ]]; then
	echo "(i)$(amixer sget Capture | grep 'Left:' | awk -F '[][]' '{ print $2 }')"
    else
	echo "(i)"
    fi
}

printOutputVolume() {
    output=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }')
    if [[ $output = "on" ]]; then
	output=$(echo " $(amixer sget Master | grep 'Right:' | awk -F '[][]' '{ print $2 }' | tr -d ' ')")
    else
	output=$(echo "")
    fi

    echo "$output"
}

while true
do
    xsetroot -name "$(printOutputVolume) $(printBacklight) $(printBattery) $(printDate)"
    sleep 1
done
