#!/bin/sh
# dwm status using xset root

printDate(){
    echo "$(date +"%a %d %b, %C%g, %H:%M")"
}

printBacklight() {
    echo " $(xbacklight -get | sed 's/\.[0-9]*//' | sed 's/$/%/')"
}

printBattery() {
    duo=$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/energy_now)
    max=$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/energy_full)
    bat0=$(cat /sys/class/power_supply/BAT0/status)

    total=$(bc <<< "scale=2; $duo/$max")
    final=$(bc <<< "$total * 100" | cut -d'.' -f1)

    if [ "$bat0" == "Charging" ]; then
        icon=" "
    else
        if [ $final -ge 90 ]; then
            icon=" "
        elif [ $final -lt 90 ] && [ $final -ge 70 ]; then
            icon=" "
        elif [ $final -lt 70 ] && [ $final -ge 40 ]; then
            icon=" "
        elif [ $final -lt 40 ] && [ $final -ge 10 ]; then
            icon=" "
        elif [ $final -lt 10 ]; then
            icon=" !!"
        fi
    fi

    echo "$icon$final%"
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
    xsetroot -name "$(printBacklight) $(printOutputVolume) $(printBattery) $(printDate)"
    sleep 1
done
