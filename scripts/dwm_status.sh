#!/bin/sh
# dwm status using xset root

print_ip() {
    echo "$(ip route get 8.8.8.8 2>/dev/null | grep -Eo 'src [0-9.]+' | grep -Eo '[0-9.]+')"
}

print_mem() {
    echo "(mem)$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))"
}

print_disk() {
    echo "(disk)$(df -h / | awk '{print $3}' | sed -n '1!p')"
}

print_caps() {
    echo "Caps: $(xset -q | grep Caps | awk '{ print $4 }')"
}

print_time() {
    echo "$(date +"%a, %D %I:%M:%S %p")"
}

print_backlight() {
    echo "(bl)$(xbacklight -get | sed 's/\.[0-9]*//' | sed 's/$/%/')"
}

print_battery() {
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
}

print_cputmp() {
    test -f /sys/class/thermal/thermal_zone0/temp || return 0
    echo "(cpu)$(head -c 2 /sys/class/thermal/thermal_zone0/temp)C"
    #sensors | awk '/^Package id/ { print $4 }' | sed -e 's/+//' -e 's/C//' -e 's/°//' -e 's/.$//' -e 's/.$//' >> ~/tempsLog.txt
    #echo "(cpu)$(sensors | awk '/^Package id/ { print $4 }')"
}

print_volume() {
    # output script
    output=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }')
    input=$(amixer sget Capture | grep 'Left:' | awk -F '[][]' '{ print $4 }')
    if [[ $output = "on" ]]; then
        output=$(echo "(vol)$(amixer sget Master | grep 'Right:' | awk -F '[][]' '{ print $2, $4 }')")
        input=$(echo "$(amixer sget Capture | grep 'Left:' | awk -F '[][]' '{ print $4 }')")
    else
        output=$(echo "(vol)$(amixer sget Master | grep 'Right:' | awk -F '[][]' '{ print $4 }')")
        fi
    echo "$output $input"
}

while true
do
    xsetroot -name "$(print_volume) $(print_backlight) $(print_battery) $(print_disk) $(print_mem) $(print_cputmp) $(print_ip) $(print_time)"
    sleep 1
done
