#!/bin/sh

weather=$(curl -s wttr.in?format=%t)
icon="🌧"
printf "%s %s\n" "$icon" "$weather"
