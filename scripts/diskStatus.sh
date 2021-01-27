#!/bin/sh

echo " (disk)$(df /dev/sda1 -h | awk 'NR==2{ print $3 }') "
