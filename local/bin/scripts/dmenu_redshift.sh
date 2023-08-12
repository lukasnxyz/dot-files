#!/bin/sh

options=$(echo -e "on\noff" | dmenu -i -p "redshift")
case $options in
    on)
        redshift -P -O 4500:4500
    ;;

    off)
        redshift -x
    ;;
esac
