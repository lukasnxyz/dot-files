#!/bin/sh
# dwm status using xset root

printDate(){
    echo "$(date +"%a, %D %I:%M:%S %p")"
}

printIp() {
    echo "$(ip route get 8.8.8.8 2>/dev/null | grep -Eo 'src [0-9.]+' | grep -Eo '[0-9.]+')"
}

printCpuTemp() {
    echo "$(head -c 2 /sys/class/thermal/thermal_zone0/temp | sed 's/$/°C/')"
}

printMemory() {
    echo $(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
}

printBacklight() {
    echo "bl$(xbacklight -get | sed 's/\.[0-9]*//' | sed 's/$/%/')"
}

printDisk() {
    echo "/$(df -h / | awk '{print $3}' | sed -n '1!p')"
}

printNetworkSpeeds() {
    logfile=/dev/shm/netlog
    [ -f "$logfile" ] || echo "0 0" > "$logfile"
    read -r rxprev txprev < "$logfile"
    rxcurrent="$(($(paste -d '+' /sys/class/net/[ew]*/statistics/rx_bytes)))"
    txcurrent="$(($(paste -d '+' /sys/class/net/[ew]*/statistics/tx_bytes)))"
    echo "$(bc <<< "scale=2; ($rxcurrent-$rxprev) / 10^6")" "$(bc <<< "scale=2; ($txcurrent-$txprev) / 10^6")"
    echo "$rxcurrent $txcurrent" > "$logfile"
}

printBattery() {
    bat0=$(cat /sys/class/power_supply/BAT0/status)
    bat1=$(cat /sys/class/power_supply/BAT1/status)

    duo=$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/capacity)
    total=$(bc <<< "scale=0; $duo/2")

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
	output=$(echo "")
    fi
    echo "$output"
}

while true
do
    xsetroot -name "$(s_output_volume.sh) $(printMemory) $(printIp) $(printDisk) $(printCpuTemp) $(printBattery) $(printDate)"
    sleep 1
done
