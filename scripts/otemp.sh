#!/bin/bash

weather=$(curl -s wttr.in?format=%t)
printf " %s %s \n" "$weather"
