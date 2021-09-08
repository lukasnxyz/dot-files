#!/bin/sh

weather=$(curl -s wttr.in/spring?format=%t)
icon="🌤️"
printf " %s %s \n" "$icon " "$weather"
