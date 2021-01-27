#!/bin/sh

#echo " $(date | awk '{ print $1, $2, $3, $4, $5, $6 }')"
echo "$(date +"%a, %b %d %l:%M %p"| sed 's/  / /g')"
