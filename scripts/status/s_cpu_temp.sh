#!/bin/sh

echo " $(head -c 2 /sys/class/thermal/thermal_zone0/temp | sed 's/$/°C/')"
