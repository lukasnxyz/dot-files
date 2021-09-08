#!/bin/sh

echo " $(xbacklight -get | sed 's/\.[0-9]*//' | sed 's/$/%/')"
