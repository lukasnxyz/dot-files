#!/bin/sh

echo "$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))"
