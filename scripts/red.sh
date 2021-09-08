#!/bin/sh

if [ !$(pgrep -l redshift) ]
then
    redshift -l 30.122807:-95.486184 -t 4500:4500
else
    killall redshift
fi
