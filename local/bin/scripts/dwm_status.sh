#!/bin/sh
# dwm status using xset root

printDate(){
    echo "$(date +"%a, %d %b %C%g, %I:%M:%S %P")"
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
    echo " $(xbacklight -get | sed 's/\.[0-9]*//' | sed 's/$/%/')"
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
    duo=$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/energy_now)
    max=$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/energy_full)
    total=$(bc <<< "scale=2; $duo/$max")
    final=($total * 10)
    low=(0.15)
    echo "$final%"
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
        output=$(echo "M")
    fi
    echo "$output"
}

while true
do
    xsetroot -name "$(printBacklight) $(printOutputVolume) $(printBattery) $(printDate)"
    sleep 1
done
