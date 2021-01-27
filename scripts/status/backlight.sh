#!/bin/sh

echo "(bl)$(xbacklight -get | sed 's/\.[0-9]*//' | sed 's/$/%/')"
