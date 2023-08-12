#!/bin/sh

# command used to display current status of cmus music player

# variables
stat=$(cmus-remote -C status | awk '/^status/ { print $2 }')
artist=$(cmus-remote -C status | grep artist -m 1 | cut -c 12-)
song=$(cmus-remote -C status | grep title | cut -c 11-)
sec_in=$(cmus-remote -C status | grep position | cut -c 10-)
tot_sec=$(cmus-remote -C status | grep duration | cut -c 10-)

# print the final product
if [[ $stat = "playing" ]]; then
    #echo "$artist - $song [$sec_in : $tot_sec]"
    echo "$artist - $song "
fi
